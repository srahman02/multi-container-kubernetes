docker build -t srahman2/multi-client:latest -t srahman2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t srahman2/multi-server:latest -t srahman2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t srahman2/multi-worker:latest -t srahman2/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push srahman2/multi-client:latest
docker push srahman2/multi-client:$SHA
docker push srahman2/multi-server:latest
docker push srahman2/multi-server:$SHA
docker push srahman2/multi-worker:latest
docker push srahman2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployments server=srahman2/multi-server:$SHA
kubectl set image deployments/client-deployments client=srahman2/multi-client:$SHA
kubectl set image deployments/worker-deployments worker=srahman2/multi-worker:$SHA
