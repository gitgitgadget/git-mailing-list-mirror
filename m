Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B7322A3F
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518169; cv=none; b=DGuQRzkDi4QqitGL3Qb2beODdG/6Ce7tTEhJPPjLl+p219HbXEQA5CoWcjhzPZ2MdNk8Eswq9xEQFciHIxfz4ewuu7GDp28n5VLjzNMWSuzQTaHBb7/aJCIKC+O0OGB1pH2+ZX8LEHB0S2KxSSJ9Gk5ongUS4RkCLcaO7si1vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518169; c=relaxed/simple;
	bh=Ca9Z5SDAEXEHeCPiTY8wBnFDvL3h2eeB6Rsiav8HSy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg5ueKfCZ4N9oGIH+W2jwTnTRmN+JHqFfiJjH/xEJcxUPbGImAkSp4zKmTtEUcOyoitw90heUkVJTukR+bhhb9HlKizr0XEpOXBv6qfTRD8HEIgnGojucQPjSP63jBnOp12jN9ErscqD/Avg/iKuZcT1fcpUsMFsWTDotayerP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+hCitNR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+hCitNR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e537dc30c7so5407705f8f.3
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518165; x=1758122965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u9qeOwRSxo7WGBy0tA3pwSfnQGqnPf1HudfAp3CKFCs=;
        b=l+hCitNRYdSN5meKHUz7q5xulMY6D4V1CI7qw9A8tlB0b4g3E/dCKbwAChPq0wZNGr
         1A+l5R9kE/171OckvjGEQerTO7RHORnUtbpKPY+qpplKCDs9vQ1ULtwftQjBSRyVA1Ga
         qAkrgLzDaN3wY/ys33IvrhK1GXPSdpiBt+3EwWjH9+NbcU7GUPKfajgVlkR2Yvx0lhLR
         Gqy24R05Cd8LYAziFbA587A29qrAYxHWOddGfmVXO0C8dQbGV2zjofzpENugtSIzOjBK
         AlUNDYKoiRzmjdm6SUREGHy+avx7W8L7gWzMwjy3FfR14fiiFB40uu2tfP7M1xjqB5xW
         95bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518165; x=1758122965;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u9qeOwRSxo7WGBy0tA3pwSfnQGqnPf1HudfAp3CKFCs=;
        b=U7Cmp8Lb4kmULeGVZMs1Y8otq/fcqydCub5QpxGl/tn2G/GzB4K/jEwZwnSxRwR4LJ
         aBa2EY9sGSTxPaJr4iuYm25w6mzJlb2okeWtizou9L04zSVYE5fzrvt/HDk+HWIQ7jI8
         83w0II+fN69vmnphB2e/siEhIyImrrIYwWhAIsZSC4WkY9eB+SHQ+Iop6cqvwCRv8dsm
         AdLXL/legE/9fDplKBfd0INQdm3Ibtu19+rbDN5eqeivD7iikx3dk/YkmAmgogyBYbbu
         WBIVItzZs8+TP4VKFVPB49OAL/YCNca8/H4VuDQilNN/KEKWgX4VYJIEZpt1v0ZDzzSp
         wzLA==
X-Gm-Message-State: AOJu0YxWuHy83/j/FQ2BQegwypedFxDDFyRMQaU+Z4ZOPheq+G0DjpWV
	HtFe4lm0UX0ppot/PQtSNAeELxXWKdG/kv7U+RzAptR1utjABuwjitA6XDsXhg==
X-Gm-Gg: ASbGncuOPlmlkrTLgZ8eLhy5Eurzm67koUHnZkmHGr0cohwKajio8NhKh9BVllWQhCT
	VsaDzQlAqj5l3UQjxhx6Fo5R/gP1s3jkyvVfcKk+kslMwTskc77QU6ffP8UGYUKKdFRhSyPUQJt
	i+UXv0NTzgC3lQ8FDRrEHwqtpk35jfTzC/MhlbcwZIzjnnh5kyMyALnh0QF8SBVguQwmo200egj
	FYuZq2zWUvKTUf0ZrKsvV2tYNmQP2lO/8tcYPZpq9TegGn5JBGCqOXs3m0ok1a9aAgxxjoZiQSq
	MyU7/rSB3hvuJqGSm3igI9B1r/4SwfaExoAr5Q40pWqgKaGxudUAtLixVznEyIJ/9RHuGx0b0Iw
	o6nWuHYqfZiDuqzTAw3CQQQgXwYfRT9O6BrYjeXQh092iqLDmPFo8Z4o=
X-Google-Smtp-Source: AGHT+IE1Rzmh4q2VEup5v+kqnF2sivhLAXS6Y76i7Bsfhq066bZTDjwU6/NT4BmkWzeHYeANNTbzuw==
X-Received: by 2002:a05:6000:2902:b0:3d3:9b18:227e with SMTP id ffacd0b85a97d-3e63736b8e0mr15932316f8f.10.1757518165325;
        Wed, 10 Sep 2025 08:29:25 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f188sm7137107f8f.48.2025.09.10.08.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:29:24 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 4/4] t0613: stop setting default initial branch
Date: Wed, 10 Sep 2025 16:29:03 +0100
Message-ID: <353328c61890b16cf6b088bf3d231b03176a969b.1757518141.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1757518141.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk> <cover.1757518141.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As the tests are all run in separate repositories, set the branch
name to "master" when creating the repository for the tests where
the result depends on the branch name. In order to make it easier to
change the branch name in the future a helper function is used. This
reduces the number of tests that depend on the default branch name
being "master" and removes the last instance of a test file using
"GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master".

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t0613-reftable-write-options.sh | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index d77e601111f..e3347517594 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -11,16 +11,18 @@ export GIT_TEST_REFTABLE_AUTOCOMPACTION
 # Block sizes depend on the hash function, so we force SHA1 here.
 GIT_TEST_DEFAULT_HASH=sha1
 export GIT_TEST_DEFAULT_HASH
-# Block sizes also depend on the actual refs we write, so we force "master" to
-# be the default initial branch name.
-GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+# Block sizes depend on the actual refs we write, so, for tests
+# that check block size, we force the initial branch name to be "master".
+init_repo () {
+	git init --initial-branch master repo
+}
+
 test_expect_success 'default write options' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -43,7 +45,7 @@ test_expect_success 'default write options' '
 test_expect_success 'disabled reflog writes no log blocks' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -62,7 +64,7 @@ test_expect_success 'disabled reflog writes no log blocks' '
 
 test_expect_success 'many refs results in multiple blocks' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -115,7 +117,7 @@ test_expect_success 'tiny block size leads to error' '
 test_expect_success 'small block size leads to multiple ref blocks' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit A &&
@@ -172,7 +174,7 @@ test_expect_success 'block size exceeding maximum supported size' '
 
 test_expect_success 'restart interval at every single record' '
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -212,7 +214,7 @@ test_expect_success 'restart interval exceeding maximum supported interval' '
 test_expect_success 'object index gets written by default with ref index' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit initial &&
@@ -247,7 +249,7 @@ test_expect_success 'object index gets written by default with ref index' '
 test_expect_success 'object index can be disabled' '
 	test_config_global core.logAllRefUpdates false &&
 	test_when_finished "rm -rf repo" &&
-	git init repo &&
+	init_repo &&
 	(
 		cd repo &&
 		test_commit initial &&
-- 
2.49.0.897.gfad3eb7d210

