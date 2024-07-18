Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111EE7A715
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290575; cv=none; b=CkIAwQJS/TM6P2q2+x4/9x1E7d9FGGvajkbUXhcCNUjBvQ6Hp3oVvEbNMg8h275tJf5FOYeXUPEsnYtVFMIP/C56mW3pk4WsLResYJzCu5Cxsci8hoJmWSuLfxBVjlb4cE2Zrv86WxvBdqNlP15QoF47i7E0FyO305r0gB42Cx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290575; c=relaxed/simple;
	bh=rwLRnsKYvUFoDTFgof5PRJgbWZQ/MQGM9ZzsJ3UvzeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUlmCCkXJQbI/eg1uQzvkpfM4t7Zl7UbPQ4pT5HV+L4Ggawn25Tbxzfmg0GpvMFNHA2pRNVTpy9PRiG56R9P2sWww47T9lcfphcCUeDKQJP2A2kpuqqj7sznqio/Y872Ih4DUDLBSeoEBrivOmdMqAPSNYSJCEHBd7YJXc8S3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqfBd0l2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqfBd0l2"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266f535e82so293455e9.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290572; x=1721895372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scaJXtQ683x4rg7PUZYMvNACcRxGHUThDZRqfOQfi3M=;
        b=QqfBd0l2XRMxC0ah3v8+/Vs64HT1I/AGkA1OJyLHfkDqulCl/g5o6ZKsX+pmBoh66t
         RjuI06PTw2iI8QzZzmj3N3CEADyuLqoebt/2IBXADZe8w2iaBwIWYQnI9/d5vyIEw/ZT
         TFBPFy2pGFlHCcEHR/UiKuVVAZBAetedTpZpFq+FcQHCRoDqpUBwKETe5uiDmJKXwwbF
         uMxiGiV0pa/5s+497Khu6YSxCX3h0GNTNGmHPcZgef/KMGN1JmfovPf3Z8JGr8T88lUD
         GfAftzGkH8qjRjTO59U/jlSVIogUXrfUKDxs0GiUc+TBkk4XezcTd/SY2qTiumvxZ8ak
         p/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290572; x=1721895372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scaJXtQ683x4rg7PUZYMvNACcRxGHUThDZRqfOQfi3M=;
        b=t9Y0FiEWuDZtwZVnhyFHPsjUwrqI4Dcf/+7Z+j1p93qNRMI34gOZuWSmMhnwaFsqsy
         SgvR4say4n+uGxpYQu7afSGF/UnzWJv+iJJuwwd4FXkWkVynRAMyNrhRHWyb2N9AJrrC
         uBDaOg0ojlO128O0FiKffWt0S4waKVYtQ0pO5xUPeOWpIk6P9Xxcv90S1eXVLnRr2fjd
         N7lRYcg+VuNpZaCsq3IMGfFA9cAuY2bus6Lu5five504MQu62sdzqOuwLpiOWMdVJLpX
         atNO5vjtlASyzkZqLalcntkVGHSUv2tY+MFoUmye/++WEF820Kpa7lK3cIcQbSeUuwjA
         0M9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtsJTJd86kD1Yg0wpdmWogGLSP4O8EFMTc+5dPxDCVjx2Rkf9bUVf2WdHmDocc2tv8nJ6MyWdlGoboaXLwzVp6NtFW
X-Gm-Message-State: AOJu0Yw0f+19h3Ek8VLNTB1PerHwurbgMBVMVErg/CeeYnFjibYwNwfk
	oGm1zT6MXrvdIhX9WFjDFT0++wyQMHUcAcf9aBOqZwXeGcB7LOal9V9pJUTD
X-Google-Smtp-Source: AGHT+IEbm35FauD+N09JiCRnEv+vPlzk5g9Rm5x4yX7bGV/q5tyiAAF65LPWArXkMhbtznXbPeiOnQ==
X-Received: by 2002:a05:600c:4e4f:b0:426:6773:17 with SMTP id 5b1f17b1804b1-427c2cf27d5mr32939525e9.30.1721290572235;
        Thu, 18 Jul 2024 01:16:12 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:11 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 4/6] ci: run style check on GitHub and GitLab
Date: Thu, 18 Jul 2024 10:16:03 +0200
Message-ID: <20240718081605.452366-5-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718081605.452366-1-karthik.188@gmail.com>
References: <20240715093047.49321-1-karthik.188@gmail.com>
 <20240718081605.452366-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't run style checks on our CI, even though we have a
'.clang-format' setup in the repository. Let's add one, the job will
validate only against the new commits added and will only run on merge
requests. Since we're introducing it for the first time, let's allow
this job to fail, so we can validate if this is useful and eventually
enforce it.

For GitHub, we allow the job to pass by adding 'continue-on-error: true'
to the workflow. This means the job would show as passed, even if the
style check failed. To know the status of the job, users have to
manually check the logs.

For GitLab, we allow the job to pass by adding 'allow_failure: true', to
the job. Unlike GitHub, here the job will show as failed with a yellow
warning symbol, but the pipeline would still show as passed.

Also for GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA'
variable by default to obtain the base SHA of the merged pipeline (which
is only available for merged pipelines [1]). Otherwise we use the
'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .github/workflows/check-style.yml | 34 +++++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 24 ++++++++++++++++++++++
 ci/install-dependencies.sh        |  4 ++++
 ci/run-style-check.sh             |  8 ++++++++
 4 files changed, 70 insertions(+)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
new file mode 100644
index 0000000000..c052a5df23
--- /dev/null
+++ b/.github/workflows/check-style.yml
@@ -0,0 +1,34 @@
+name: check-style
+
+# Get the repository with all commits to ensure that we can analyze
+# all of the commits contributed via the Pull Request.
+
+on:
+  pull_request:
+    types: [opened, synchronize]
+
+# Avoid unnecessary builds. Unlike the main CI jobs, these are not
+# ci-configurable (but could be).
+concurrency:
+  group: ${{ github.workflow }}-${{ github.ref }}
+  cancel-in-progress: true
+
+jobs:
+  check-style:
+    env:
+      CC: clang
+      jobname: ClangFormat
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v4
+      with:
+        fetch-depth: 0
+
+    - run: ci/install-dependencies.sh
+
+    - name: git clang-format
+      continue-on-error: true
+      id: check_out
+      run: |
+        ./ci/run-style-check.sh \
+          "${{github.event.pull_request.base.sha}}"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 37b991e080..817266226e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -123,6 +123,30 @@ check-whitespace:
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
+check-style:
+  image: ubuntu:latest
+  allow_failure: true
+  variables:
+    CC: clang
+    jobname: ClangFormat
+  before_script:
+    - ./ci/install-dependencies.sh
+  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
+  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
+  # be defined in all pipelines.
+  script:
+    - |
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
+
+      if test -z "$R"
+      then
+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
+        exit 1
+      fi
+      ./ci/run-style-check.sh "$R"
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
+
 documentation:
   image: ubuntu:latest
   variables:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ec0f85972..fb34ced8f0 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -87,6 +87,10 @@ macos-*)
 esac
 
 case "$jobname" in
+ClangFormat)
+	sudo apt-get -q update
+	sudo apt-get -q -y install clang-format
+	;;
 StaticAnalysis)
 	sudo apt-get -q update
 	sudo apt-get -q -y install coccinelle libcurl4-openssl-dev libssl-dev \
diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
new file mode 100755
index 0000000000..76dd37d22b
--- /dev/null
+++ b/ci/run-style-check.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+#
+# Perform style check
+#
+
+baseCommit=$1
+
+git clang-format --style file --diff --extensions c,h "$baseCommit"
-- 
2.45.2

