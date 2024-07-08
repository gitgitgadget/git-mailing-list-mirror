Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522A74077
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430618; cv=none; b=YEtIg5IhO5I1fnxcQSlRapxtHJyJczhL+gxVTmcNOnGEs4kSs3mbXoohD4BL2C4+e6vVay92qtPApt4scCFMxiP6E93owK4me0RcltOpxlA2GsMwYPV5fC8mxkWfpmWMLd2bNaOLrwzrczY5oymeuEQuwNy5nZoIiQadzGLOTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430618; c=relaxed/simple;
	bh=xm4ZloHydbKWdqpwlTZ7Ll/QmZ0cFJEBQAZp0WTF0rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2uuCDFVyAZfHAR1LCuACYemorb6UZ7x3QuOxJZJ3+LVsbBgvZemn4+EdjkRvLFTigCjYq/TmKmgP7zQ3yfMnfddYmfSC0xFybDkbIpaqPyyratO/SngHg/x8aiDMcMynI2Inka/Lx9pqisC0e1iItt89s+OqJZ20r5Np3pvuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeezlEO2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeezlEO2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so481455e9.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720430615; x=1721035415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBi2SePDUDL2U0in1AvntQvb90L94gT0MTYcEwNyyCk=;
        b=GeezlEO2FW3HbybMh3w83assPFv/oUIGqu3NHmS6FYN6poX2oSXLYPIjE3F+imvkj9
         FDR+YZG7B3A3e56mYncmYKsIucjz6n6Msce/X+hI1Y7MEeYLG1pcZpsqGzldOvAmPYiF
         yWrMa3Uu9NvhYz0LXUr8uAhoeUuE1kDnDsFXCMVJAN/llcuY4UXUxjKubnGBBSRV7ZtS
         AcmZajXB0R80HxZVnh9ZOd4mLf3aY9vNOlfFrGfq0Tk/tAlGedZhzWoc9ADX1+XBLoiZ
         hmSLPw5+EQ5Frb5x7hwsHnQPFIZjf7Gk25jpye9iRmtsGv48276Ujq2zxTSpxCogEJp2
         3eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720430615; x=1721035415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBi2SePDUDL2U0in1AvntQvb90L94gT0MTYcEwNyyCk=;
        b=Rf1pUQ8vpA5AWxjdyiC0QcPGevHHLwSoStWyUfXvEaZvlFDQB+QbH2c+5GzmLr+2IJ
         /+SnWnyjFQYWLQGVNcwBKlfynF4dVoVE+88iokFQvIZRf6T/CESaGitivg0kgxe8mZRe
         Vg4k02EfTgmafjU+U7VEcGKZEGzHMUlw+BSui7P1QBYFsqH/v+bwVAVJnERf2Yd0aidE
         n3WfGJSLw08ANC8MYBu/KKGUl5qGW1VhB2s4zMbcJrRLWLqf7Z/zXttlanrGYIK7slg+
         YVd6zc3IzERozA/EKTBoX4Kg+0XoMt4m2INAusJoRfUAujs4sF6oO1OJxml30PCy+MmW
         UNqA==
X-Gm-Message-State: AOJu0YyRZHDhPOQhQR9QHHT42w2UgfZ09+W07oFK7JNwVcfCptNKtxSx
	KvFKLx5qh0t1dpRS7Ycb8XxdBo4vhm0V2y+NeH+ViNP3I/9tG59bqt6smy2U
X-Google-Smtp-Source: AGHT+IFw1YCXba8vSLoPkyQ7XsNi/f9Mtg6WQDn50R10FL4VdR4HYq617ChOFQZLm4flOQEf7B3eJg==
X-Received: by 2002:a05:600c:354f:b0:426:6714:5415 with SMTP id 5b1f17b1804b1-426671454famr26303865e9.30.1720430615421;
        Mon, 08 Jul 2024 02:23:35 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1d0d:3d35:3ae6:ef05])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm158259935e9.10.2024.07.08.02.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 02:23:34 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH 7/8] ci: run style check on GitHub and GitLab
Date: Mon,  8 Jul 2024 11:23:15 +0200
Message-ID: <20240708092317.267915-8-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240708092317.267915-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .github/workflows/check-style.yml | 29 +++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 12 ++++++++++++
 ci/install-dependencies.sh        |  2 +-
 ci/run-style-check.sh             |  8 ++++++++
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 .github/workflows/check-style.yml
 create mode 100755 ci/run-style-check.sh

diff --git a/.github/workflows/check-style.yml b/.github/workflows/check-style.yml
new file mode 100644
index 0000000000..27276dfe5e
--- /dev/null
+++ b/.github/workflows/check-style.yml
@@ -0,0 +1,29 @@
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
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v4
+      with:
+        fetch-depth: 0
+
+    - name: git clang-format
+      continue-on-error: true
+      id: check_out
+      run: |
+        ./ci/run-style-check.sh \
+          "${{github.event.pull_request.base.sha}}"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 37b991e080..65fd261e5e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -123,6 +123,18 @@ check-whitespace:
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
+check-style:
+  image: ubuntu:latest
+  allow_failure: true
+  variables:
+    CC: clang
+  before_script:
+    - ./ci/install-dependencies.sh
+  script:
+    - ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+  rules:
+    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
+
 documentation:
   image: ubuntu:latest
   variables:
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 6ec0f85972..46fe12a690 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -43,7 +43,7 @@ ubuntu-*)
 		make libssl-dev libcurl4-openssl-dev libexpat-dev wget sudo default-jre \
 		tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl \
 		libemail-valid-perl libio-pty-perl libio-socket-ssl-perl libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
-		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
+		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE clang-format
 
 	mkdir --parents "$CUSTOM_PATH"
 	wget --quiet --directory-prefix="$CUSTOM_PATH" \
diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
new file mode 100755
index 0000000000..9d4c4089c1
--- /dev/null
+++ b/ci/run-style-check.sh
@@ -0,0 +1,8 @@
+#!/usr/bin/env sh
+#
+# Perform style check
+#
+
+baseCommit=$1
+
+git clang-format --style file --diff --extensions c,h "$baseCommit"
-- 
2.45.1

