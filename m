Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA11F1312
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735296849; cv=none; b=QBt1OIavSqyQlhwBWA9vdzA83G1Xk/dvLN0XvhhN2Rg9dFA2c4lZtJOZs/Po68dMEg4H5UUSWzrwm0Gx4xTSxhv7Nvc5c70Bhevt4/8G8jtgcxIgQuiPDifZfYppnfB7x6oE50tTWUF3sdbofyU5qZMfAp+LuS77xaP/eYMQvM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735296849; c=relaxed/simple;
	bh=tSLdp8kot8TkI1LE/8ZaPpi8SnOMuNnL5pwuSuLgH1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCDS95Sf8ADsgOsMv4D3IxnpDl9Ae0b6dmbf58LZLTaBjDd7qUNZZ4Zx0Z49kgYdm84mCASQIEguN5VHCyQKhpDgj18+bd2nXATQOenuv4UyWfN/48WUMaICeEFkN58lQCcSNTzOZ0MFeJ6AogI1cH+jqeixjXyEFkyLdjAYxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM4rAefg; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM4rAefg"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb95317so89267325ad.1
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 02:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735296847; x=1735901647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZJwiRv/P1lp+TCJUUwTSg41R5Z4qDqeKA901NlSfkU=;
        b=MM4rAefg+TWnvmk7w/YI5XPbGYILWMJslWPl5AeFPCEPFOrFtzndp5eblk/D2XTgWd
         EkQT5AGYFdDID2z5LQxWHT1lkK3zvCWgLXM3HjuMYaccN/A68pMYTB+QwEgusWtDL/1K
         a9WpCe/TUvncF7yhZs8Bj//ImrVxU/2tzyFhIWgupCokROGyt2nDw/boci8QzASGHb6h
         /nJBAuxa3Mvupj1KAxvM6VrtHvkVxKulKEljKZVk0BISgW9SZJ1pcsKPveNFwJaxdEY5
         spwH+esewqz1bUIOZi157hFzCJM6DV1KgP9OFpEC4dPOpwgKWVyYPQJKVp+RcCHyghnz
         Nsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735296847; x=1735901647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZJwiRv/P1lp+TCJUUwTSg41R5Z4qDqeKA901NlSfkU=;
        b=qRxsGMQLI5Gd7ZqcbH5PPliYV+dsVvlg2WxVPfvavf+/USrx9AmtkBgAc2zffpLpER
         gLqSpuX3OEf79ssi3ffFTXv4cQTc0V+Z317+l6h7E5XfD1OVwdtEN0HzTbtOFbR2dzsn
         vSAq6pzRr7PUCRgmo2Uh7IGj2aPhPn/HFm+mJeFw1czpVdIavTAxzvxHiRQXnnRnWwkc
         PHuQTL6SjF3hIhrWSrVpqXV1xZaKkNzWWZbDvdhkjh1ennZi2twwRUws8C4BIrLPdGeh
         WXkDkWGhfKIF+ebTXn3+3Zfw2PdKzOopsZKfmvf2oznftQtGHE0vp8YPNSdqDoG+jI7i
         YrbQ==
X-Gm-Message-State: AOJu0YxfBh1rWhX4EBI0iFa+2xJWnMWHgp+0hllsHY5YSPzTm+JDR5KW
	70n13jKu5gGk7rWYzCcTtt3IJTcXagzi8AioqMkTGzo/KmZC/2EEdemNPsol
X-Gm-Gg: ASbGncu7pCPo3wuXw/jO1/QyN/W45k6XG4i9rKMW+OwEmKy+y+B0xuRr859NhvTFAE0
	vkBgGBEEqbuStsWYQRW3yf3BIkEzoEdY3mw6a00VqkuChpOj98I8cBs4hKk3ihVNy5capl1rrtE
	3vSj+KDDyhuuvNtP2580YWxhlx8K3mZmFmKU6NovUY643Yz3zD/3wkT8p3k1p3k+4Bm3C1xm2+d
	2L+znM1WQBxQHtered9q0w7gvAC80hy5gGKXkXYmLZ6gL2G+fe1x64=
X-Google-Smtp-Source: AGHT+IGWNcFj4uPaUwTSlSgzmGOzR8H5cCEnZUX+mx8fJMwJfJsmXoyj/XZL7WCqboFF1G04/+uiWg==
X-Received: by 2002:a17:902:dac6:b0:216:2426:7666 with SMTP id d9443c01a7336-219e6e89559mr326560755ad.12.1735296847156;
        Fri, 27 Dec 2024 02:54:07 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eb1dsm133356525ad.78.2024.12.27.02.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 02:54:06 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	shyamthakkar001@gmail.com,
	shejialuo@gmail.com,
	chandrapratap3519@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v3] t7611: replace test -f with test_path_is* helpers
Date: Fri, 27 Dec 2024 16:23:45 +0530
Message-Id: <20241227105345.10184-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220130632.11826-1-meetsoni3017@gmail.com>
References: <20241220130632.11826-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `test -f` and `test ! -f` with `test_path_is_file` and
`test_path_is_missing` for better debuggability.

While `test -f` ensures that the file exists and is a regular file,
`test_path_is_file` provides clearer error messages on failure. On the
other hand, `test ! -f`, used to check either the absence of a regular
file or the presence of any other filesystem object, but looking at
them in the test individually, all of them should've said `test ! e`,
i.e. "there shouldn't be anything at given path on filesystem."
Replaced these cases with `test_path_is_missing` for better
debuggability.

Helped-by: karthik nayak <karthik.188@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
Apologies for late response.
Updated commit message for better clarification of changes made.
 t/t7611-merge-abort.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index d6975ca48d..1a251485e1 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -54,13 +54,13 @@ test_expect_success 'fails without MERGE_HEAD (unstarted merge)' '
 '
 
 test_expect_success 'fails without MERGE_HEAD (unstarted merge): .git/MERGE_HEAD sanity' '
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)"
 '
 
 test_expect_success 'fails without MERGE_HEAD (completed merge)' '
 	git merge clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	# Merge successfully completed
 	post_merge_head="$(git rev-parse HEAD)" &&
 	test_must_fail git merge --abort 2>output &&
@@ -68,7 +68,7 @@ test_expect_success 'fails without MERGE_HEAD (completed merge)' '
 '
 
 test_expect_success 'fails without MERGE_HEAD (completed merge): .git/MERGE_HEAD sanity' '
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$post_merge_head" = "$(git rev-parse HEAD)"
 '
 
@@ -79,10 +79,10 @@ test_expect_success 'Forget previous merge' '
 test_expect_success 'Abort after --no-commit' '
 	# Redo merge, but stop before creating merge commit
 	git merge --no-commit clean_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort non-conflicting merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	test -z "$(git diff --staged)"
@@ -91,10 +91,10 @@ test_expect_success 'Abort after --no-commit' '
 test_expect_success 'Abort after conflicts' '
 	# Create conflicting merge
 	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort conflicting merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	test -z "$(git diff --staged)"
@@ -105,7 +105,7 @@ test_expect_success 'Clean merge with dirty index fails' '
 	git add foo &&
 	git diff --staged > expect &&
 	test_must_fail git merge clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	git diff --staged > actual &&
@@ -114,7 +114,7 @@ test_expect_success 'Clean merge with dirty index fails' '
 
 test_expect_success 'Conflicting merge with dirty index fails' '
 	test_must_fail git merge conflict_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff)" &&
 	git diff --staged > actual &&
@@ -129,10 +129,10 @@ test_expect_success 'Reset index (but preserve worktree changes)' '
 
 test_expect_success 'Abort clean merge with non-conflicting dirty worktree' '
 	git merge --no-commit clean_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -141,10 +141,10 @@ test_expect_success 'Abort clean merge with non-conflicting dirty worktree' '
 
 test_expect_success 'Abort conflicting merge with non-conflicting dirty worktree' '
 	test_must_fail git merge conflict_branch &&
-	test -f .git/MERGE_HEAD &&
+	test_path_is_file .git/MERGE_HEAD &&
 	# Abort merge
 	git merge --abort &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -159,7 +159,7 @@ test_expect_success 'Fail clean merge with conflicting dirty worktree' '
 	echo xyzzy >> bar &&
 	git diff > expect &&
 	test_must_fail git merge --no-commit clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -168,7 +168,7 @@ test_expect_success 'Fail clean merge with conflicting dirty worktree' '
 
 test_expect_success 'Fail conflicting merge with conflicting dirty worktree' '
 	test_must_fail git merge conflict_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -183,7 +183,7 @@ test_expect_success 'Fail clean merge with matching dirty worktree' '
 	echo bart > bar &&
 	git diff > expect &&
 	test_must_fail git merge --no-commit clean_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
@@ -194,7 +194,7 @@ test_expect_success 'Fail conflicting merge with matching dirty worktree' '
 	echo barf > bar &&
 	git diff > expect &&
 	test_must_fail git merge conflict_branch &&
-	test ! -f .git/MERGE_HEAD &&
+	test_path_is_missing .git/MERGE_HEAD &&
 	test "$pre_merge_head" = "$(git rev-parse HEAD)" &&
 	test -z "$(git diff --staged)" &&
 	git diff > actual &&
-- 
2.34.1

