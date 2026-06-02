Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDB3D649C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398966; cv=none; b=n9jigie7dySc1qaVitHUNL8wtPzhbFQ9qja/rHJ188f1aDzbkDY56SFJNa/dJSqt85vk8bUkJkvcfGPkys6lAUyvNnw4fNkWLKoBnansSEBYxVRsOcR5lvdieUfsOdpIfDCjOAXTa91vh6F203GbbeyrJqE31a4YVc+ig08g4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398966; c=relaxed/simple;
	bh=8YNUyTYd5gtUwON3uI68ZrmaKmDNnUwsXfc7iaJtVSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twAKsLziBJVoa45BY7GdJOL2zN16qU6J7ZVlrANXGPaYHC4lypjnT/iXxFa02VACnQhh4SuFC0LUSslYDSdem+2SKlhgwJSB57TYLkjij5C9Ov9NLP9OwXT9IRY04YN11LmwlAfg3a7ee0Zfp+xCS2naEOyt5NUvmVFgfyxbvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqK/G9hq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqK/G9hq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so3824685e9.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 04:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780398957; x=1781003757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnAx4LCGIUiWpO4o9fmFO0YdFsjOtiiW88f8+WhGm1E=;
        b=EqK/G9hqILbDJrYtyyLoZzz6VWBHDUd96VT+h0kRk+giPfCDMJ7iI4gz4tso+YNPfJ
         k7OhR6acC/3phPKp71+5BsxIfu+EEauZJCC9ZfC4uD7EAIxlvtIhZ98mnWZBXSjnDw9f
         NWTXiewjqFCDPv3br50uL0OvoMUho4b+xuNkuCasf8eEW3TW6aUZUadzPSFUgWTEqk5h
         a3AFT5d4cEEQocfQptvA85hS83KH8vUiQ3A8/1MMwMEq1fq5COzLu84aU7tiaO1IVTUZ
         3kH5X9hUhH2tsClApW3Tgsb0t9o/fm4yVE4f1ZPv/10F4mDisGhEJ+NDQIgkA0iM25Wt
         6oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780398957; x=1781003757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnAx4LCGIUiWpO4o9fmFO0YdFsjOtiiW88f8+WhGm1E=;
        b=D886amkwnmu22RlBV2lrL+3yvjlmGd3q1huQHVQAEsTXnypBdiQrjxbPdkrhg3D/bT
         8mwxA35Z1thbHGAiwt86ekdHoJOazTEp4cW0I82RgnnahsUesd7B5RjYWRlZppznpRsU
         B1Ajol4TLaWgv7yntcywtNHUTDHRAUbbp16Ahlr6hYM9ove2dAKDGyWfyBnKuRPHAkNp
         zW8s0+AIpFjZPgycycAGk6jTJlnFXJNUdFhQ4VXLJnu4LaTjfO5mdQrcNB6M///oBueR
         J3p8uKoiDFuo99eyKCFErz0VwX0wEZNI5RWEuXM1pzJZpxTf0MpEdSmt1EVb2essblt+
         E8oQ==
X-Gm-Message-State: AOJu0Yy12qbEDP4WCc8gVPfXKYuD5+vdw1/v2HRr/OLIy9ekGOw+1R24
	9dAOuLedMtJFqY8gxQ2Ox922MQWXlJRq/JSw22OaryxIaLEvc3Py5d4KcR5K3w==
X-Gm-Gg: Acq92OHjyNcyYQ41KP9RWSHmFxdlUmvx+UuytOagfpLS1KMM9vllcygURbe3FtHi13X
	yI91FV66dpnJ8W1crdUm7obAydskAkMqpyNIu+0J3Qo8sPc6FNJSRAFk8PyrduA8ARvpQnL6iqd
	Xr50Kjvr3Mx09V3opydVquEu26Z/WyhFf37bqVNKh6G2le4HEcmZimng2ZiAzfFCkIXX3UmoHCI
	ieFG0L+ZTe0k2ZeZmijHQexqUAbs+/QUQKD1M/T1CstJHV3vfSsd+S4fIcbUd9zdmYpnLKMzV1K
	OB21/JgPa7F8TGZkhxRE9tj+X3WE0s1pjU7s4Z7iihDLwd05ft0xhoAyKzbTN3ok2OZJU+iJZk6
	ekmRS0tAgEz62h1I55wZ+SDBl9q+dJ1T/G+a0J4OQhgy1Z6BqTR1kfid0pjuvRScusQqWRsTC2d
	a9yipIWDR+8jMTWcNey/JrHYYb87gM8THSCXBw
X-Received: by 2002:a05:600c:6592:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-490a2904ab0mr295979885e9.6.1780398957167;
        Tue, 02 Jun 2026 04:15:57 -0700 (PDT)
Received: from void ([2a00:a041:e53b:8a00:5d8c:bf27:3f6:529f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e823f7sm66370635e9.13.2026.06.02.04.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 04:15:56 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH v3] doc: fix typos via codespell
Date: Tue,  2 Jun 2026 14:15:18 +0300
Message-ID: <20260602111552.6084-1-algonell@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506101631.18127-1-algonell@gmail.com>
References: <20260506101631.18127-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in the documentation, comments, etc.
Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
v3:
  - Address test breaking changes (strings bounded by single quotes).
  - Thank you for your patience (extreme noise/gain ratio).

 t/t1700-split-index.sh         | 2 +-
 t/t3909-stash-pathspec-file.sh | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 869fb4a14e..887e72a5fa 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base index' '
 		git checkout main &&
 		git update-index --split-index &&
 		test_commit more &&
-		# must not write a new shareindex, or we won't catch the problem
+		# must not write a new shareindex, or we will not catch the problem
 		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
 		# i.e. do not expect warnings like
 		# could not freshen shared index .../shareindex.00000...
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 3afa6bff3d..e34cea6ce1 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -29,7 +29,7 @@ verify_expect () {
 test_expect_success 'simplest' '
 	restore_checkpoint &&
 
-	# More files are written to make sure that git didn't ignore
+	# More files are written to make sure that git did not ignore
 	# --pathspec-from-file, stashing everything
 	echo A >fileA.t &&
 	echo B >fileB.t &&
@@ -47,7 +47,7 @@ test_expect_success 'simplest' '
 test_expect_success '--pathspec-file-nul' '
 	restore_checkpoint &&
 
-	# More files are written to make sure that git didn't ignore
+	# More files are written to make sure that git did not ignore
 	# --pathspec-from-file, stashing everything
 	echo A >fileA.t &&
 	echo B >fileB.t &&
@@ -66,7 +66,7 @@ test_expect_success '--pathspec-file-nul' '
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
-	# More files are written to make sure that git didn't ignore
+	# More files are written to make sure that git did not ignore
 	# --pathspec-from-file, stashing everything
 	echo A >fileA.t &&
 	echo B >fileB.t &&

Interdiff against v2:
  diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
  index 869fb4a14e..887e72a5fa 100755
  --- a/t/t1700-split-index.sh
  +++ b/t/t1700-split-index.sh
  @@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base index' '
   		git checkout main &&
   		git update-index --split-index &&
   		test_commit more &&
  -		# must not write a new shareindex, or we won't catch the problem
  +		# must not write a new shareindex, or we will not catch the problem
   		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
   		# i.e. do not expect warnings like
   		# could not freshen shared index .../shareindex.00000...
  diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
  index 3afa6bff3d..e34cea6ce1 100755
  --- a/t/t3909-stash-pathspec-file.sh
  +++ b/t/t3909-stash-pathspec-file.sh
  @@ -29,7 +29,7 @@ verify_expect () {
   test_expect_success 'simplest' '
   	restore_checkpoint &&
   
  -	# More files are written to make sure that git didn't ignore
  +	# More files are written to make sure that git did not ignore
   	# --pathspec-from-file, stashing everything
   	echo A >fileA.t &&
   	echo B >fileB.t &&
  @@ -47,7 +47,7 @@ test_expect_success 'simplest' '
   test_expect_success '--pathspec-file-nul' '
   	restore_checkpoint &&
   
  -	# More files are written to make sure that git didn't ignore
  +	# More files are written to make sure that git did not ignore
   	# --pathspec-from-file, stashing everything
   	echo A >fileA.t &&
   	echo B >fileB.t &&
  @@ -66,7 +66,7 @@ test_expect_success '--pathspec-file-nul' '
   test_expect_success 'only touches what was listed' '
   	restore_checkpoint &&
   
  -	# More files are written to make sure that git didn't ignore
  +	# More files are written to make sure that git did not ignore
   	# --pathspec-from-file, stashing everything
   	echo A >fileA.t &&
   	echo B >fileB.t &&

Range-diff against v2:
-:  ---------- > 1:  bcbd09129a doc: fix typos via codespell
-- 
2.54.0

