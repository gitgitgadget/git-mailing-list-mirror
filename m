Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9515574D
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686658; cv=none; b=ZBXAcCsvtzz9HQH00sK80+cAhPm3JnbpCbP+AW0dYgR9AJ60KqJVUpMrGT5zRFdgOl1mgyOZXim8aQA4zk38oG9iasY/ic4L4IIcNac5TWieoUv+g2QGkUCMgZu/lWoTeB192MTbeaV0W0wUvvPFWKoSKY5276uUEBPGryn2KgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686658; c=relaxed/simple;
	bh=CSQ0u7etAcdVs017iyF3YWM1rAywySyLUZsB6v92Cwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFi6IMC5WjXiIVy2Bjn38GjyliANc/24t9MtsnSp+BrFSVgmK05cKUcKmtFABOFR1Lw9cqzQfyF2Ock8YTiGN2o9vYWwoZ6EC1iQIPkapRG9lLVc0oQP0BDMcdxojDzCouiHr6AkTfLKSJ7W60eN59SLV/2JPrH2nMikunBCjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRZfUwvM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRZfUwvM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so4549535e9.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686654; x=1721291454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o55qjhraTQAh5EzcD56XmIAzotfofXcwPCRhRDMUfZo=;
        b=ZRZfUwvMmDIeh5fqrhF7dDDQDlTgQHpHMqIuovgABdtb30bbIuYIWdNzbFmYGly+X/
         bBv2wjDXvXAtwPCnsNGXe19JaeaFh9RrvCqHT2cNuyhK5vpZJ/i/fA5sdwLSBNZmv6CN
         z0NIrE2eCF11l2XW//5X2XaB7ijxsAc2+TKj8biR0Qnk2v9WEOxqy9BnC4CfidScMGP2
         3G3OfNTFcLOM1JoW21RoCEfwnS110zMWQsNyKM7lRMxb5EXhSRa97xiHXhi+PKMxOe6h
         OQuEHMOsfpjz7uP65QHqP6cSDzBRPi0MXRXI8rQ0Tu2uQjAiBd2/zjyJt8rqtwI75sP6
         7UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686654; x=1721291454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o55qjhraTQAh5EzcD56XmIAzotfofXcwPCRhRDMUfZo=;
        b=JTELF691jFFZAvxAe6Ku+m8u0VyNe/1Wt9dp3eKP+Dc2puVtXbKsFPCFqtY0SuD7kn
         6WjnBL6xPqyAMp1nTYPPOPMrmmm49Q/JXB+MfrCxpymfW2RIjoTUr2KgTRGjBqyY8KSi
         Stvv7PMoZWgCcMrEpCXRRz03CX6YvdmtqvIgGQeQYpR+fdKNmExW7EitkRHfOwog5JmO
         YWPj5PgzgfTupKy8e6CXwbAY7vsBbbgpwgUPytTlkVg/AjwP1QCE1/OHG0KKliDHN2nK
         mhnsKFHOdSuE40zux0EozSVleeokb/fu+MCb7NPftVssmUS2iyFWVlKcA3uDSzaqs+a5
         bx0A==
X-Forwarded-Encrypted: i=1; AJvYcCXwfNVQQloepZaVWhh2sH7Xw9W6OvoCp4IBT1M71iX1muhc67uLPrefoZdoDCfWguAsXFgmHdFmursprvzY3nj2bpnQ
X-Gm-Message-State: AOJu0YwMH/IigDeVca2G13EEF9O0CG0SWE2r82ok1L3WsivV+oTjE9iL
	G0+srPqUPyIdsIBwS70em24rJT3OSAfOCfiAKQ6sViV6URSVWITPtWceSXKX
X-Google-Smtp-Source: AGHT+IHu+SfzZElOEbhaAXWPuUReVG3DXH7nUropGkij6ASfhuksMcZPdXli9qKN9I7jLO2Py9Cc/A==
X-Received: by 2002:a5d:47a7:0:b0:360:75b1:77fb with SMTP id ffacd0b85a97d-367cea46438mr8266750f8f.8.1720686654332;
        Thu, 11 Jul 2024 01:30:54 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:8da7:30a3:c67a:daf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm263674305e9.16.2024.07.11.01.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 01:30:53 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com
Subject: [PATCH v2 8/8] check-whitespace: detect if no base_commit is provided
Date: Thu, 11 Jul 2024 10:30:43 +0200
Message-ID: <20240711083043.1732288-9-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com>
References: <20240708092317.267915-1-karthik.188@gmail.com>
 <20240711083043.1732288-1-karthik.188@gmail.com>
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

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 .gitlab-ci.yml         |  7 ++++++-
 ci/check-whitespace.sh | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index dc43fc8ba8..c5a18f655a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -119,7 +119,12 @@ check-whitespace:
   before_script:
     - ./ci/install-dependencies.sh
   script:
-    - ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+    - |
+      if [ -z ${CI_MERGE_REQUEST_TARGET_BRANCH_SHA} ]; then
+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_DIFF_BASE_SHA"
+      else
+        ./ci/check-whitespace.sh "$CI_MERGE_REQUEST_TARGET_BRANCH_SHA"
+      fi
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
2.45.1

