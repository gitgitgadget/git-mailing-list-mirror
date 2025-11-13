Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABA342514
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763057443; cv=none; b=dr4GBScJKmOfXBbKgE+5W5aixG96CqPm1lp2vdR3q5rJB74k8MUh4OXHBCHztDupdvIq/8d0cSOx212Vw8ER2T4clUQAtiYDkkCdK1NuFzhwer9E3furDJz3g6eiPgWtD9DziWStoBTKpONqyxBDNGSNcgi2ZAuhPpAS9TrR7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763057443; c=relaxed/simple;
	bh=ze+Z827cimlbFCuHNGBZwHERFzfMjXTizKFw6JmdQPM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=c0RJ0va/YVNdV6JApCbJhpepI3X4Ig/NHWz/J0vymXgxys/lKjDMRoaMj7cvf9gdMuqaWkhCVMKojvMEM7KiYHQIy4JVLfbi8xPca6QIo8WIUvqtMCN/bxtySGAHp+IQyE1VISvoPBmSvqvZWCGM6xkojJdsbnQwyu/zndDttws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlEJ7xs+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlEJ7xs+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-298144fb9bcso11700875ad.0
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763057441; x=1763662241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eC99j2jDQmGlkCFBwkELLZJDlZ5KD+zKkDxZ/3BIbPM=;
        b=hlEJ7xs+DN+jkwUPD7peUX1tmu51suYn65XKdFCyYjDCnyqVTtm9rgN0wfs0YTvPKE
         ynbk5vPk3xBlzHdwM2xljkSEhdLodtapCE+mtp1aKegWjlh9wO9MVBtMgoqH36FRs+nA
         8ULff4waLLOe7B/8vmBQS19XIsMBJytIfUEaQinPwtZiwJkqsbyzxQPjjwTt7BD5yXTj
         kDPNflTktRXPIal7hzO54FM0ACCck+3NTY8GxWwluj1ddc4G571s9bSc81NDJQHQkmD+
         6nTWyHqkd/TEjp0uY/JrmaXBv/r1WMHqkwV8wRvaOCthcZvzfbsNRJgEvh882hpOUa3L
         7Hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763057441; x=1763662241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eC99j2jDQmGlkCFBwkELLZJDlZ5KD+zKkDxZ/3BIbPM=;
        b=Iqnj92UzxNE4Wx9+stZfyabUNiCV13db+NN+qGg7SuXluCDq+mqjcSNe7ZA9DHEdB6
         zmrzo31AZkW/dNncyeRNNiqEA5vQ5gqa+5eRnj0aZhogx8+bXy3hkc0+P0BgwkSLuthq
         pZwAnPBKA9ytxeRaP8ze/rsVwWUQaO8z/ZblzxEM/QQIvfVb9abuFqutw5Vw7ClYopPQ
         mJf83TlmdkYAeITIKbmnbCT7NU+0VTNWIcz0vnRH9/ibCLdV9Tf/5CzKUkjSN34cghDJ
         +V89/FOVcNAwIWppsrdKiYodc5/trUUnN2S6oNp7MlE59loPeNdV2KtSxRJFeJOKwUA/
         imkQ==
X-Gm-Message-State: AOJu0YyW/1ZOdhRA+4gTeyEnrjp2YL1jyPi6K9YeuIbkSB1g5AU7Mscu
	Y1Tik/G9uEw+nGZDCJJOQNjIJUVLMajrVmF4zFQEI1H3n49jLV7GBBekDfEC1GFF
X-Gm-Gg: ASbGncu5VwVelipq3AZreEvFQUmg4/gSX/PgQMQQfFD6sGTse0bLjdu80GI09OkbGmK
	pWYQgLMgG0jkE4rgz7Q6emeSxn5gLjp0o6/A67CixMLE4stUsfarAKWiFaVKwUsOW4+E0nmhOTv
	G2PHaBUJL6X+SM3rZM0ZtWD8oj+jt5SkO4NNFHyx9bBzQeDvu5eQRedIXYVFTzT5CQglnx0dBEn
	dfCoToA8fn65nrtNESijlLSqmgCNYRljR3NHBy1QgH6BxBWiagYv/vj8FG5e6fUx6DR41pIu5YO
	UqB/R3W5WcRVW6SNVsqmWmYLBpfeIhBjqF0HhIGQkn2Wfl3VzLmVE6JXUPpdBMgIWO0UxCR4fnn
	+B+RekHnQlx5reGfNKHNAzIXoIdvlGzIUMvJKBKtxyipoIL7nGLDEQLcAzL+l9QSOEOleOxtPr2
	77mQ==
X-Google-Smtp-Source: AGHT+IG7xMYLa0aKU0Up2WZY5PJSmXGsdWKZXzV8xFGS7EsRk8WIWw6rlrp7r7oPzLql2o3vr+O+5A==
X-Received: by 2002:a17:903:b0d:b0:297:e231:f410 with SMTP id d9443c01a7336-2984ed457e7mr93668115ad.13.1763057440687;
        Thu, 13 Nov 2025 10:10:40 -0800 (PST)
Received: from [127.0.0.1] ([104.209.7.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2c16a1sm31676115ad.95.2025.11.13.10.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:10:40 -0800 (PST)
Message-Id: <ee84190cd899a3954095bf7263744704bfa4fa85.1763057433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
References: <pull.1987.git.1760818039.gitgitgadget@gmail.com>
	<pull.1987.v2.git.1763057433.gitgitgadget@gmail.com>
From: "Claus Schneider(Eficode) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Nov 2025 18:10:33 +0000
Subject: [PATCH v2 5/5] Documentation: add --include_ignored_submodules +
 ignore=all config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Brandon Williams <bmwill@google.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    Claus Schneider <claus.schneider@eficode.com>,
    "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

From: "Claus Schneider(Eficode)" <claus.schneider@eficode.com>

- git-add.adoc: Add new documentation for --include_ignored_submodules
  option to supress ignore=all and new submodule functionality of not
  adding a ignore=all submodule by default.
- gitmodules.adoc and config/submodule.adoc: The submodule config
  ignore=all now need --include_ignored_submodules in order to update
  the index.

Signed-off-by: Claus Schneider(Eficode) <claus.schneider@eficode.com>
---
 .devcontainer/Dockerfile            | 70 ++++++++++++++++++++++++++
 .devcontainer/Dockerfile.standalone | 76 +++++++++++++++++++++++++++++
 .devcontainer/devcontainer.json     | 25 ++++++++++
 Documentation/config/submodule.adoc | 13 ++---
 Documentation/git-add.adoc          |  5 ++
 Documentation/gitmodules.adoc       |  5 +-
 6 files changed, 187 insertions(+), 7 deletions(-)
 create mode 100644 .devcontainer/Dockerfile
 create mode 100644 .devcontainer/Dockerfile.standalone
 create mode 100644 .devcontainer/devcontainer.json

diff --git a/.devcontainer/Dockerfile b/.devcontainer/Dockerfile
new file mode 100644
index 0000000000..680ca5f3ad
--- /dev/null
+++ b/.devcontainer/Dockerfile
@@ -0,0 +1,70 @@
+FROM ubuntu:latest
+
+ARG USER_ID
+ARG GROUP_ID
+
+ENV DEBIAN_FRONTEND=noninteractive
+ENV TZ=Europe/Copenhagen
+
+RUN apt-get update \
+    && \
+    apt-get install -y \
+        sudo \
+        build-essential \
+        libcurl4-gnutls-dev \
+        libexpat1-dev \
+        gettext \
+        libz-dev \
+        libssl-dev \
+        asciidoc \
+        xmlto \
+        docbook-xsl \
+        \
+        tzdata \
+        git \
+        coccinelle \
+    && \
+    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
+    && \
+    dpkg-reconfigure --frontend noninteractive tzdata
+
+RUN  apt-get update && apt-get install -y autoconf
+
+RUN addgroup -gid 1001 gituser
+RUN adduser --disabled-password -u 1001 -gid 1001 gituser
+RUN usermod -aG sudo gituser
+RUN echo 'gituser ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/010-gituser
+RUN chmod 0440 /etc/sudoers.d/010-gituser
+
+USER 1001
+
+#WORKDIR /home/gituser/git-src/
+
+#RUN  make configure
+#RUN ./configure --prefix=${HOME}/.local/
+
+#RUN make -j$(nproc) gitweb || make gitweb 
+#RUN make install-gitweb
+
+#RUN make -j$(nproc) || make
+#RUN make -j$(nproc) gitweb || make gitweb 
+#RUN make install-gitweb
+#RUN make -j$(nproc) NO_PERL=YesPlease install || make NO_PERL=YesPlease install
+#RUN make install
+
+
+RUN mkdir -p  ${HOME}/.local/
+#RUN ls -la ${HOME}/.local/bin
+#ENV PATH="/home/gituser/.local/bin:${PATH}"
+#RUN ls -l $HOME/.local/bin
+#RUN echo $PATH $HOME 
+
+#RUN git --version
+#RUN which git 
+
+RUN git config --global user.email "gituser@example.com"
+RUN git config --global user.name "Git User"
+
+#WORKDIR /home/gituser/git-test/
+
+#CMD [ "git" ]
diff --git a/.devcontainer/Dockerfile.standalone b/.devcontainer/Dockerfile.standalone
new file mode 100644
index 0000000000..39bda42c0e
--- /dev/null
+++ b/.devcontainer/Dockerfile.standalone
@@ -0,0 +1,76 @@
+FROM ubuntu:latest
+
+ARG USER_ID
+ARG GROUP_ID
+
+ENV DEBIAN_FRONTEND=noninteractive
+ENV TZ=Europe/Copenhagen
+
+RUN apt-get update \
+    && \
+    apt-get install -y \
+        build-essential \
+        libcurl4-gnutls-dev \
+        libexpat1-dev \
+        gettext \
+        libz-dev \
+        libssl-dev \
+        asciidoc \
+        xmlto \
+        docbook-xsl \
+        \
+        tzdata \
+        \
+        nano \
+        vim \
+    && \
+    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime \
+    && \
+    dpkg-reconfigure --frontend noninteractive tzdata
+
+RUN  apt-get update && apt-get install -y autoconf
+
+RUN addgroup -gid ${GROUP_ID} gituser
+RUN adduser --disabled-password -u ${USER_ID} -gid ${GROUP_ID} gituser
+
+
+COPY --chown=${USER_ID}:${GROUP_ID} ./git /home/gituser/git-src/
+
+USER ${USER_ID}
+
+WORKDIR /home/gituser/git-src/
+
+RUN  make configure
+RUN ./configure --prefix=${HOME}/.local/
+
+#RUN make -j$(nproc) gitweb || make gitweb 
+#RUN make install-gitweb
+
+#RUN make -j$(nproc) || make
+#RUN make -j$(nproc) gitweb || make gitweb 
+#RUN make install-gitweb
+RUN make -j$(nproc) NO_PERL=YesPlease install || make NO_PERL=YesPlease install
+RUN make install
+
+WORKDIR /home/gituser/git-src/t
+RUN ./t2206-add-submodule-ignored.sh -v
+
+RUN ls -la ${HOME}/.local/
+RUN ls -la ${HOME}/.local/bin
+ENV PATH="/home/gituser/.local/bin:${PATH}"
+RUN ls -l $HOME/.local/bin
+RUN echo $PATH $HOME 
+
+RUN git --version
+RUN which git 
+
+RUN git config --global user.email "gituser@example.com"
+RUN git config --global user.name "Git User"
+
+WORKDIR /home/gituser/git-src/t
+RUN pwd && ls -la 
+RUN ./t2206-add-submodule-ignored.sh -v
+
+WORKDIR /home/gituser/git-test/
+
+CMD [ "git" ]
diff --git a/.devcontainer/devcontainer.json b/.devcontainer/devcontainer.json
new file mode 100644
index 0000000000..2bc13902d8
--- /dev/null
+++ b/.devcontainer/devcontainer.json
@@ -0,0 +1,25 @@
+{
+  "name": "Git Dev Container",
+  "build": {
+    "dockerfile": "Dockerfile",
+    "context": "",
+    "args": {
+      "user_id": "1001",
+      "group_id": "1001"
+    }
+  },
+  "customizations": {
+    "vscode": {
+      "settings": {
+        "terminal.integrated.shell.linux": "/bin/bash"
+      }
+    }
+  },
+  "remoteUser": "gituser",
+  "features": {},
+  "mounts": [
+    "source=${localWorkspaceFolder}/,target=/home/gitusers/git-src,type=bind,consistency=cached",
+    "source=${localWorkspaceFolder}/,target=/home/gitusers/git-test,type=bind,consistency=cached"
+  ],
+  "postCreateCommand": "echo"
+}
diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
index 0672d99117..0753adbab5 100644
--- a/Documentation/config/submodule.adoc
+++ b/Documentation/config/submodule.adoc
@@ -32,15 +32,16 @@ submodule.<name>.fetchRecurseSubmodules::
 
 submodule.<name>.ignore::
 	Defines under what circumstances "git status" and the diff family show
-	a submodule as modified. When set to "all", it will never be considered
-	modified (but it will nonetheless show up in the output of status and
-	commit when it has been staged), "dirty" will ignore all changes
-	to the submodule's work tree and
+	a submodule as modified.
+	Set to "all" will never considered the submodule modified. It can
+	nevertheless be staged using the option --include_ignored_submodules and
+	it will then show up in the output of status.
+	Set to "dirty" will ignore all changes to the submodule's work tree and
 	takes only differences between the HEAD of the submodule and the commit
 	recorded in the superproject into account. "untracked" will additionally
 	let submodules with modified tracked files in their work tree show up.
-	Using "none" (the default when this option is not set) also shows
-	submodules that have untracked files in their work tree as changed.
+	Set to "none"(default) It is also shows submodules that have untracked
+	files in their work tree as changed.
 	This setting overrides any setting made in .gitmodules for this submodule,
 	both settings can be overridden on the command line by using the
 	"--ignore-submodules" option. The 'git submodule' commands are not
diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index b7a735824d..ab72fad651 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -79,6 +79,11 @@ in linkgit:gitglossary[7].
 `--force`::
 	Allow adding otherwise ignored files.
 
+`--include_ignored_submodules`::
+	The option is also used when `submodule.<name>.ignore=all`
+	is set, but you want to stage an update of the submodule. The
+	`path` to the submodule must be explicitly specified.
+
 `--sparse`::
 	Allow updating index entries outside of the sparse-checkout cone.
 	Normally, `git add` refuses to update index entries whose paths do
diff --git a/Documentation/gitmodules.adoc b/Documentation/gitmodules.adoc
index d9bec8b187..ea1fd377e6 100644
--- a/Documentation/gitmodules.adoc
+++ b/Documentation/gitmodules.adoc
@@ -70,7 +70,10 @@ submodule.<name>.ignore::
 --
 	all;; The submodule will never be considered modified (but will
 	    nonetheless show up in the output of status and commit when it has
-	    been staged).
+	    been staged). Add `(new commits)` can be overruled using the
+	    `git add --include_ignored_submodules <submodule.path>` 
+		The setting affects `status`, `update-index`, `diff` and `log`(due 
+		to underlaying `diff`).
 
 	dirty;; All changes to the submodule's work tree will be ignored, only
 	    committed differences between the `HEAD` of the submodule and its
-- 
gitgitgadget
