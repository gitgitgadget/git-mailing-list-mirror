Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E57187540
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035860; cv=none; b=K5P4w33T5vxWk+EJUxKnsIWP4daioWowRGie0/D96yMq4a9AQ0z6D75Pqayx2VvY1pZcJ2H6DgsapJZjvqE4SftTaiHs/RRzTOnozBx5QhSiNAwNtoPLNMhwMzF3aesfpToI+XL5bZig/KaZJM71R3AeEP2XQtMkE6Ixa3naDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035860; c=relaxed/simple;
	bh=Y31aADat4fA3Usr4h81u60I1xgTliDuxKQfJoOyOVoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RblnXxJRPuzyRb+9TAmg0Yx9BYL8TK8Yr5DT6RRl89hLCrYRE6CuuiIx+zw9u1HlP4qx6e6hhZvTX7eZ0KcuF9ISPN/g6dtOejvLU4vS2F1WavuFs2M49pRBR6jnDzr4yyraLkO1CEK7Q+RufDD1SgsfU20AJZ3shqELhmma9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BILrk5Bl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BILrk5Bl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so2105022f8f.1
        for <git@vger.kernel.org>; Mon, 15 Jul 2024 02:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721035857; x=1721640657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GV4c1RtqvwQl2FhVDHHsZzR1lqJqJuoxbPpvwuiA6DI=;
        b=BILrk5BlcbMbTu105qcdtoBeb012BbODwCTwkJneuvr2Kxa2lJ5ERspJrIMOGjV/KI
         KsO0DropHnX/Mp/ZcqDfH5uhxXjoExteWoH5QN5T/KUndT/z1MXsPRt9suvLNC/pWUZX
         GHJyP5Q75aNd83KOV4QebAHyaTRWQ3sdu7z/+jEVvjs09ZjBtP6fRCDUbL+sU1K4EUue
         mcsYr7OqmBljeXVShYMk2jw37TetNe4laL3VlFay6FNqYziRs8gCTybGDGtVuy9hcCMf
         LgEOkheSfEr+fDNnHJIm4XdjN1MiFS6G5H7Ypi9y0WpuffaZqSFsHbW3xrHaeeDT4cvP
         zaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721035857; x=1721640657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GV4c1RtqvwQl2FhVDHHsZzR1lqJqJuoxbPpvwuiA6DI=;
        b=oHXRVjJFWm002yYeLIsrJnlYPfW7fEvAPDyWCEwfWXXVSb9O8uQ1oNqxPsCEUcCcFZ
         VvZ+mKN/+vN4mSgGr9itnI04sYYa1q7P/LRAbIatPOrx6pxL8wY+6lpldYZoVMBYTKb5
         CuIoECWc9K7Cg3j89Ig0trOyxAthCEwD/kPDg+8dxoMUKsSXgJAcBGWzThSHOKSoXTIl
         S1HTUmzvrJNFaMYqPE+Q/R7V+9Y2e6BK4pw3/hZzaf6e2KUJkOlodu8j+3sv2lV0dlYb
         6+IqzkO2EylCS6xc1MsXAyuOX5oL/vUqbJLghx852re1Or+LOh//W570DinRISgkV9n+
         6dmg==
X-Forwarded-Encrypted: i=1; AJvYcCVojHrsqJuyctiJtFtyF4JhTR/R3wV1FotL0KuAhxa/k+BvZIlGLJXQQo/tZuWxoXNuUj6hcyDFN5jb9xMsUJm3akhc
X-Gm-Message-State: AOJu0YyHQQFw2H7pUHs5JsyAsjIh1iYRTVFa93DOD1OOwzTUJ9MOZmNu
	dUgx6ixLvQ26G7lEleblTcq0KY+DMr1hEuiX8IZL1VhtWyaE0KTv
X-Google-Smtp-Source: AGHT+IHkAme6Z1FWlmMgodx1ictSmyoGZfMeIGdeTU//povRwWS+IrJUvqObGtIC7nizGOWSVF0emQ==
X-Received: by 2002:a05:6000:237:b0:367:9c93:f87e with SMTP id ffacd0b85a97d-367cea964d6mr13072516f8f.33.1721035856743;
        Mon, 15 Jul 2024 02:30:56 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:1a3c:da7e:77ea:d1ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbf19sm5745208f8f.68.2024.07.15.02.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 02:30:56 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v4 7/8] check-whitespace: detect if no base_commit is provided
Date: Mon, 15 Jul 2024 11:30:46 +0200
Message-ID: <20240715093047.49321-8-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715093047.49321-1-karthik.188@gmail.com>
References: <20240713134518.773053-1-karthik.188@gmail.com>
 <20240715093047.49321-1-karthik.188@gmail.com>
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

