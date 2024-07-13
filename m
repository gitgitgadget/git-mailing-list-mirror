Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2D1386DF
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878331; cv=none; b=t1aU/bhmBkwJQUSSEBgWcKmWIq2czETeydNn6CPXcVFVKHKaKQffCTQrYvLDAB24WvjBIny0VC3FUIb5xm5x9zUPauY/KJqtqhDM+S5F8T9JlR794aToV9qieyzJ3fGYbBWezE5l/Zl2NGDTNiWC8IHBjW2u9nOjG5lHRaEYoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878331; c=relaxed/simple;
	bh=aGdl7VU6fu87AxZSW/5vme8YBNWVlJShsiPuSUTfeuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R53sxB6H/YEelEa2oG0d4Jyj9wwaEjQzmzCsk3Z1eWdOAZfKOZAqvZjbDDA1ieVV0DEqBbbMbuvR3SA+Tjc81bkvztwfoI435nBcccS37HvBQdCQCaQNo7792k+q0d3+rU+/O1duZV7tzblJXKKJ8E5kAnOTzqfCceI+H2/ZFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0JFdv2c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0JFdv2c"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42793d4abbbso19619675e9.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878328; x=1721483128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51UjLfdboabiYtuKEd6+VeM1Ku67vBrIRynYFTxwLuI=;
        b=m0JFdv2c+QYJfsLP5jqtzoHnfm+r/FMHMULUZIlelVOWcmax3T+L18nOyXywdnyEXs
         8jJrI4kZLm8kMviqykZF+8+sqS/3ujakFw/eOUAh6LJ/yyPUbaKKgL6YZ7kKZxUTiIpc
         b04V+4O4loIUSChEnMuheCEPag/U4xW9Abn0QAZD1MP7oOr6va9N+GwMveOQ3FgM9olg
         mOcWFQx8bxl9Lmv/IilMvjWdG4c/jpZQe9B8kNuPBMXVWntsF9f7gH/GeKmjklr0yTic
         ZKc45JdAoGmrwaKq3UAknARjcl3dEiVH1ifNp4NC4AxULv3XMN2nFG9+dJEdaJotGa2D
         9OaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878328; x=1721483128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51UjLfdboabiYtuKEd6+VeM1Ku67vBrIRynYFTxwLuI=;
        b=c9ZJ8SIW6RbI/dSnAtqcTn4xW1EASFUJzV5cgC9DqeNEgB34o+z4ozy5LHtEPDqXq1
         7Qez/Ry0uVBrX+ya7lBtmGfC+O4pGzIxl/sYLcue1/mADnfqlu7rqWdaUYcx6IjXujj5
         b7LvXgYfTfusPSbFfbCH98COWng0t3icGfm9GAzjcs2353127/ZlgOXW1KM4tSjj6/TQ
         lEEcA70iKKYwvHLgn3xJWsNstMpXYyOIKubVtGFMMMGfOyucCxM/eYujgrLQqDrO57wI
         uCs3mvT22AkJcuAxVywMuvQXxb/rcvwke/5byobpj/E1FYw/IILhrg6BswYrTpuh4jjw
         57Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWMcVBwfpqsSrl4mJsSmvg5c4iIZo4P1mhTZWEApuKhaP9hGstmsi20+cjGdJedgvUArsQymV9tXOGA+qldvwIg9D64
X-Gm-Message-State: AOJu0YxvmLPjnUwbUL7vm69QntONvJyv6XR+iBynt/k3PL9Rx2Ei9CUa
	mi3PY5lA2Tz2ijQmzpPVc55MaGgTJh9R++fyfK9xsXzeUryprgWAgoVLfIvH
X-Google-Smtp-Source: AGHT+IHrDf0XRK2AihY0ZDiBtXRgSs7gVVnndwKF6PmSOej/vlIUTF46bmVQaQoZNLUV+ZX02uXUFQ==
X-Received: by 2002:a05:600c:2247:b0:426:5dc8:6a6a with SMTP id 5b1f17b1804b1-426707d7fd6mr97289135e9.21.1720878327970;
        Sat, 13 Jul 2024 06:45:27 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:27 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 6/8] ci: run style check on GitHub and GitLab
Date: Sat, 13 Jul 2024 15:45:16 +0200
Message-ID: <20240713134518.773053-7-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
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

For GitLab, we use the 'CI_MERGE_REQUEST_TARGET_BRANCH_SHA' variable by
default to obtain the base SHA of the merged pipeline (which is only
available for merged pipelines [1]). Otherwise we use the
'CI_MERGE_REQUEST_DIFF_BASE_SHA' variable.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .github/workflows/check-style.yml | 29 +++++++++++++++++++++++++++++
 .gitlab-ci.yml                    | 24 ++++++++++++++++++++++++
 ci/install-dependencies.sh        |  2 +-
 ci/run-style-check.sh             |  8 ++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)
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
index 37b991e080..14f9d3dc8e 100644
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
+  before_script:
+    - ./ci/install-dependencies.sh
+  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
+  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
+  # be defined in all pipelines.
+  script:
+    - |
+      if test -n "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+      then
+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+      elif test -n "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+      then
+        ./ci/run-style-check.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+      else
+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"; exit 1
+      fi
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

