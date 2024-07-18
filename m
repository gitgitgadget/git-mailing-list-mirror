Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20C7CF30
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290576; cv=none; b=EK5Ln6jcr2yN9Q8mhE83zXihLl6Av47vy99eXBkr5FWH6CDFMn9lTmJ6rUFNOwZ+T8dZo1NRoB7i+uIF0ackk9b2cbulWnGLhJVit0LUaqWJLnPI7flhl0J1iwZL4ohy8BU12Jmqm1LL9z4s6dNtg7APZ5Mjj51O98JKn0dZOzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290576; c=relaxed/simple;
	bh=Y31aADat4fA3Usr4h81u60I1xgTliDuxKQfJoOyOVoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=shQRZQGzRWkr1N5yOqv2xl0gv8Vapz/MRlo5adi/p3zo/JUPj94PkSF0VgMqC+E/p/nh3+R1I44On8RqPv42fdBUDiD7zNnuC02CgdyAsE3U5gPyeXkg3OZRMvLrW8/iCn0FefLueqlaadT7FEV7dgE3qVka95Weeh+gOYclA+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5mw6+OZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5mw6+OZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266ed6c691so215465e9.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721290574; x=1721895374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV4c1RtqvwQl2FhVDHHsZzR1lqJqJuoxbPpvwuiA6DI=;
        b=I5mw6+OZ24JR4+FP1f4xZi4dwcFH8pjrSGdIWLtB7rjCiCcq/gjX+lRyk9Y4CPFj5X
         0S5be4de3tny4nFofzwFMXn+4OnneS+eUJ2zPPQbNAkB3vb6oKGRBl7DH6xEu2fWpX9l
         CiJEmDfXIYB69vL8iYrHOhQn0UxzEyZmp9NfHvBV9iGSklU3wi6Xs+HyboB5Z+ZdE8/S
         KlwI6ovMCJVrp9L3HPLhI5cxsCj0zpfE2xcEdxT5fofwxxCD+haPzj0olytIQAz1Pyi3
         6Y7wpYip5hbLkHLeOX0KR9v/hBgSyapQbipQZLm9pkBsZWtZFzkrElQ/zjAMTM1FSlCA
         Hzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290574; x=1721895374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV4c1RtqvwQl2FhVDHHsZzR1lqJqJuoxbPpvwuiA6DI=;
        b=cK1N9tDGZLZHXgGz8SJBqq4R+x/ctPADmkK1YydMYmDFCK8zgdgU0sqPakCfDRIcsx
         nyEJ3JBLtV+A++OT994VagM7s6HxKBxlbufAdNkiSp6+lfkf8WpXLww2k0gNAk201G/S
         qTDvKU2ngmQSBWamD0tzFLSNDjf3ueAo8neyNWBSTUCoy8GBrTwqsahB9OWpXK4Z1ayN
         LlWXrmsrivzQgy/y3oO1J2c+8TeuBK7deHwMgFldhWWeNPy2MvCkFPraoUyg+/gMV1s1
         iE1Dz8ie/WoIeNPU65efw2N0ZwEM8TphDIrWMp72NLHI3PIVmlIYJVvV5wferJD+uJoY
         4hKw==
X-Forwarded-Encrypted: i=1; AJvYcCW0W7XnnWswjUX93aybrPFheG9wRZM1qEPvsfZBt+wlHOG+KUzc3MWGPayTDDHM23HveYXsBF/rFKYziNoGo+mFA2nn
X-Gm-Message-State: AOJu0YzCgt9ycXWH2N5WfNL5y2jysSGI4Kqg6K+7Nolt1h3qvkPQqPSg
	yRflbJkfpoaNvv/ZPuAeqqGAtANbnhyazc4gB1OoB9XV+WDlGp0W
X-Google-Smtp-Source: AGHT+IEMmfosQL42qpFIDBUyurFRhMlsZKk77piB54ybVzfONsoNt8K36RqLBDC0oIP1yY+oTa8MAw==
X-Received: by 2002:a05:600c:c12:b0:426:6ea0:d5b8 with SMTP id 5b1f17b1804b1-427c2cefebemr29487175e9.29.1721290573463;
        Thu, 18 Jul 2024 01:16:13 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e75c:3a24:6dbb:5d7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a43598sm1714375e9.1.2024.07.18.01.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:16:12 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v5 5/6] check-whitespace: detect if no base_commit is provided
Date: Thu, 18 Jul 2024 10:16:04 +0200
Message-ID: <20240718081605.452366-6-karthik.188@gmail.com>
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

The 'check-whitespace' CI script exits gracefully if no base commit is
provided or if an invalid revision is provided. This is not good because
if a particular CI provides an incorrect base_commit, it would fail
successfully.

This is exactly the case with the GitLab CI. The CI is using the
"$CI_MERGE_REQUEST_TARGET_BRANCH_SHA" variable to get the base commit
SHA, but variable is only defined for _merged_ pipelines. So it is empty
for regular pipelines [1]. This should've failed the check-whitespace
job.

Let's fallback to 'CI_MERGE_REQUEST_DIFF_BASE_SHA' if
"CI_MERGE_REQUEST_TARGET_BRANCH_SHA" isn't available in GitLab CI,
similar to the previous commit. Let's also add a check for incorrect
base_commit in the 'check-whitespace.sh' script. While here, fix a small
typo too.

[1]: https://docs.gitlab.com/ee/ci/variables/predefined_variables.html#predefined-variables-for-merge-request-pipelines

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .gitlab-ci.yml         | 13 ++++++++++++-
 ci/check-whitespace.sh | 10 ++++++++--
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 817266226e..320b78b9ae 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -118,8 +118,19 @@ check-whitespace:
   image: ubuntu:latest
   before_script:
     - ./ci/install-dependencies.sh
+  # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
+  # pipelines, we fallback to $CI_MERGE_REQUEST_DIFF_BASE_SHA, which should
+  # be defined in all pipelines.
   script:
-    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+    - |
+      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
+
+      if test -z "$R"
+      then
+        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
+        exit 1
+      fi
+      ./ci/check-whitespace.sh "$R"
   rules:
     - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
 
diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
index db399097a5..c40804394c 100755
--- a/ci/check-whitespace.sh
+++ b/ci/check-whitespace.sh
@@ -9,7 +9,7 @@ baseCommit=$1
 outputFile=$2
 url=$3
 
-if test "$#" -ne 1 && test "$#" -ne 3
+if test "$#" -ne 1 && test "$#" -ne 3 || test -z "$1"
 then
 	echo "USAGE: $0 <BASE_COMMIT> [<OUTPUT_FILE> <URL>]"
 	exit 1
@@ -21,6 +21,12 @@ commitText=
 commitTextmd=
 goodParent=
 
+if ! git rev-parse --quiet --verify "${baseCommit}"
+then
+    echo "Invalid <BASE_COMMIT> '${baseCommit}'"
+    exit 1
+fi
+
 while read dash sha etc
 do
 	case "${dash}" in
@@ -67,7 +73,7 @@ then
 		goodParent=${baseCommit: 0:7}
 	fi
 
-	echo "A whitespace issue was found in onen of more of the commits."
+	echo "A whitespace issue was found in one or more of the commits."
 	echo "Run the following command to resolve whitespace issues:"
 	echo "git rebase --whitespace=fix ${goodParent}"
 
-- 
2.45.2

