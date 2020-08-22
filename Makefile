PATH_DEPLOY=docker

create-env:
	docker-compose -f $(PATH_DEPLOY)/docker-compose.yml \
		run --rm python "python3 -m venv .venv"

install-libs:
	docker-compose -f $(PATH_DEPLOY)/docker-compose.yml \
		run --rm python "source .venv/bin/activate && pip3 install -r requirements.txt"

jupyter: create-env install-libs
	docker-compose -f $(PATH_DEPLOY)/docker-compose.yml \
		run --rm -p 8888:8888 python "source .venv/bin/activate && jupyter notebook --ip=0.0.0.0 --allow-root"

shell-ml: create-env install-libs
	docker-compose -f $(PATH_DEPLOY)/docker-compose.yml \
		run --rm python "source .venv/bin/activate && /bin/bash"