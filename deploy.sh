docker build -t tobyfintops/multi-client:latest -t tobyfintops/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tobyfintops/multi-server:latest -t tobyfintops/multi-server:$SHA -f ./server/Dockerfile ./server
docker buidd -t tobyfintops/multi-worker:latest -t tobyfintops/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tobyfintops/multi-client:latest
docker push tobyfintops/multi-server:latest
docker push tobyfintops/multi-worker:latest

docker push tobyfintops/multi-client:$SHA
docker push tobyfintops/multi-server:$SHA
docker push tobyfintops/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tobyfintops/multi-server:$SHA
kubectl set image deployments/client-deployment client=tobyfintops/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tobyfintops/multi-worker:$SHA