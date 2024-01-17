Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7E24B4C
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521166; cv=none; b=DS/07lZWajPMC66WamxhNJhO9bC1cl9255taOR0SZ1qVSTCJBeHInZbRAiymstf8k8K55hkwd7L8fU0yTxdopZi0w2ejq+t6jK3qaKTg8gr9VimaeOCKPEjsHc4UFs34c/FrB7o1R75BAZuxuuiA5yWKUPQd+xTogF3M9QfpNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521166; c=relaxed/simple;
	bh=pzzLF160L2R7OIVX0GoG+9fWRDYbcYfdmdjn/1g/Qz0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=NJeTVURunKRwvPqM7U1BE3m9hQtsm6Q0i4buwLvnkbEBBv89hrMS5UzRzIy6rIzAV0JcKu/oDgmJuMhxBYTKYjuJiaUmazB1mToQyYRHmikyK+nIUdRRwR9kNH5wx1HI57QG5XRHuBt9KdeR0OOuCU/QlPqckdOmdJlBXNuLhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDWziGFP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDWziGFP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-337c40fde20so844542f8f.0
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521162; x=1706125962; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmMUzd0U48IbGgsQJ+mxAzAkYCyXDeFTYCcsjSpdWxo=;
        b=fDWziGFPXBu0nCH2xStpK24tKFXZlXmGvyfkNDgiW70oPEM3Y93faSryG08hxveNGQ
         NUzgq/5OvxsD4Uy8XZ1SHrQU8ADASh4BBsnT2ofm75JdafcgXjlelRR/xH8JzYbGcquT
         uydw/+gt13nzL7uPONbz6jttxanXZzyGmBuojaGowCMXAAvZOfDGKXBHJuIVWRvEYbCQ
         A4lWNSdeHeBhSCf00xhoLOmXTz4fbfI8PSb8jURsxJOEbeXwFqu6CaG/Tub/sAOXpfkD
         dM+chtj3uLy8zGVLtgISDEkRe1zqVG6EslNeJig77CAjn+MT2v4mn7gacPMddcG6Y5ye
         XqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521162; x=1706125962;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmMUzd0U48IbGgsQJ+mxAzAkYCyXDeFTYCcsjSpdWxo=;
        b=Nk8UquL6mr7loMVdHMQ/C/p1OsN1kuQduhWw1jKHFRggo9QIgmR8k/sATgItjVG9lU
         e3rYvF5uU1A2r2lca8cNIa/iCEoGTWlXVXWw0xdbVScxEtoq57TN7ZTklpKqUZAIum7V
         H8mp2fNY6SVYG3/+pVMmf3NAr4sCMmzDFullGZvxHLahQ4IEi9zFoyK3XwWNpHr0CaPG
         Zf89yioVbMdxuVeANK8d8PrvxrH+3ZDy54B+VInDSOT6U3QczAtSKgdg3kLVizrFvPpG
         pIW8etvBGNgOI8O13nnKosQuNDWWBppcjL/A+EZQAuMPeuZ9WSE/fa5JV9PWXA/aLSqV
         vM0w==
X-Gm-Message-State: AOJu0YwuWnfa8BpggW6f+Jed7Fe0+CtIB5PDccO5ap/NO90x2RaaS1wn
	+/aSF1l+/j+e2spHEpxGjx9rqFV3AF4=
X-Google-Smtp-Source: AGHT+IFKKnzKA2IqV2ezJJuB7EkMJW0fiMW5RRtg2USyBT2k6GY+D3P7mhwnI7kKgMSffEnwX1IZmQ==
X-Received: by 2002:a5d:6d4c:0:b0:337:5bdf:57a with SMTP id k12-20020a5d6d4c000000b003375bdf057amr5356517wri.118.1705521162294;
        Wed, 17 Jan 2024 11:52:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020adfe601000000b00337bf461385sm2347376wrm.26.2024.01.17.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:41 -0800 (PST)
Message-ID: <ae71747871cf97e8f0fb802836e0e5c7ae961696.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:30 +0000
Subject: [PATCH 07/12] t1410: move reffiles specific tests to t0600
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move these tests to t0600 with other reffiles specific tests since they
do things like take a lock on an individual ref, and write directly into
the reflog refs

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 51 +++++++++++++++++++++++++++++++++++++
 t/t1410-reflog.sh           | 42 ------------------------------
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 09fbe312092..0b28a2cc5ea 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -451,4 +451,55 @@ test_expect_success 'for_each_reflog()' '
 	test_cmp expected actual
 '
 
+# Triggering the bug detected by this test requires a newline to fall
+# exactly BUFSIZ-1 bytes from the end of the file. We don't know
+# what that value is, since it's platform dependent. However, if
+# we choose some value N, we also catch any D which divides N evenly
+# (since we will read backwards in chunks of D). So we choose 8K,
+# which catches glibc (with an 8K BUFSIZ) and *BSD (1K).
+#
+# Each line is 114 characters, so we need 75 to still have a few before the
+# last 8K. The 89-character padding on the final entry lines up our
+# newline exactly.
+test_expect_success SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
+	git checkout -b reflogskip &&
+	zf=$(test_oid zero_2) &&
+	ident="abc <xyz> 0000000001 +0000" &&
+	for i in $(test_seq 1 75); do
+		printf "$zf%02d $zf%02d %s\t" $i $(($i+1)) "$ident" &&
+		if test $i = 75; then
+			for j in $(test_seq 1 89); do
+				printf X || return 1
+			done
+		else
+			printf X
+		fi &&
+		printf "\n" || return 1
+	done >.git/logs/refs/heads/reflogskip &&
+	git rev-parse reflogskip@{73} >actual &&
+	echo ${zf}03 >expect &&
+	test_cmp expect actual
+'
+
+# This test takes a lock on an individual ref; this is not supported in
+# reftable.
+test_expect_success 'reflog expire operates on symref not referrent' '
+	git branch --create-reflog the_symref &&
+	git branch --create-reflog referrent &&
+	git update-ref referrent HEAD &&
+	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
+	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
+	touch .git/refs/heads/referrent.lock &&
+	git reflog expire --expire=all the_symref
+'
+
+test_expect_success 'empty reflog' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	test_commit -C empty A &&
+	>empty/.git/logs/refs/heads/foo &&
+	git -C empty reflog expire --all 2>err &&
+	test_must_be_empty err
+'
+
 test_done
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index a0ff8d51f04..d2f5f42e674 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -354,36 +354,6 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 	test_must_be_empty actual
 '
 
-# Triggering the bug detected by this test requires a newline to fall
-# exactly BUFSIZ-1 bytes from the end of the file. We don't know
-# what that value is, since it's platform dependent. However, if
-# we choose some value N, we also catch any D which divides N evenly
-# (since we will read backwards in chunks of D). So we choose 8K,
-# which catches glibc (with an 8K BUFSIZ) and *BSD (1K).
-#
-# Each line is 114 characters, so we need 75 to still have a few before the
-# last 8K. The 89-character padding on the final entry lines up our
-# newline exactly.
-test_expect_success REFFILES,SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
-	git checkout -b reflogskip &&
-	zf=$(test_oid zero_2) &&
-	ident="abc <xyz> 0000000001 +0000" &&
-	for i in $(test_seq 1 75); do
-		printf "$zf%02d $zf%02d %s\t" $i $(($i+1)) "$ident" &&
-		if test $i = 75; then
-			for j in $(test_seq 1 89); do
-				printf X || return 1
-			done
-		else
-			printf X
-		fi &&
-		printf "\n" || return 1
-	done >.git/logs/refs/heads/reflogskip &&
-	git rev-parse reflogskip@{73} >actual &&
-	echo ${zf}03 >expect &&
-	test_cmp expect actual
-'
-
 test_expect_success 'no segfaults for reflog containing non-commit sha1s' '
 	git update-ref --create-reflog -m "Creating ref" \
 		refs/tests/tree-in-reflog HEAD &&
@@ -397,18 +367,6 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
-# This test takes a lock on an individual ref; this is not supported in
-# reftable.
-test_expect_success REFFILES 'reflog expire operates on symref not referrent' '
-	git branch --create-reflog the_symref &&
-	git branch --create-reflog referrent &&
-	git update-ref referrent HEAD &&
-	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
-	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
-	touch .git/refs/heads/referrent.lock &&
-	git reflog expire --expire=all the_symref
-'
-
 test_expect_success 'continue walking past root commits' '
 	git init orphanage &&
 	(
-- 
gitgitgadget

