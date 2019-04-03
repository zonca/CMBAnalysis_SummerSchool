#Dockerfile for running pycamb notebooks with binder
#https://mybinder.org/v2/gh/cmbant/camb/master?filepath=docs%2FCAMBdemo.ipynb

FROM cmbant/cosmobox:python3

ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

COPY . ${HOME}
USER root

RUN conda install -c conda-forge --yes jupyterlab \
 && conda clean --yes -i -t -l -s -p

RUN pip install camb

RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR ${HOME}

