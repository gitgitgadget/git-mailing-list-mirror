Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6C1C5F24
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734700018; cv=none; b=b0kYNTlh+Zf/2r916icGQNC8SriskC6JrPAU48C14uyWupCt+HkUOLZsx02WiQJoI9G1aUK15jKRNLRltGoAycnvtOzBqkfkiW86mQLcjU1TAEQG71Q4f+aPXmwMq43tCT2ldCWQYmx77GT1B71tnxEpFDUYTOgvRMfCqSgSCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734700018; c=relaxed/simple;
	bh=3QK08KwxcMfpKfTnLiRO8/PP8FEfQnXhGi13cDPEWxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDwOuVtMpCI/aboJMQrcuO5T5Y8iPP5EKnKn2LbqNpaX/4mDXLdYgbXIMwvwtUP7+ndsXcZ0ltViq9qVZncqIgJ2LO11dIn73rDjICOshG3vyGINHoZ3SistWdTXhagspnATVs3a/mMxWavuA2jhsBvEMbKr+yRm9Jhjk5zYtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMBTzUDw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMBTzUDw"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ed193c9eso1685421b3a.1
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 05:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734700016; x=1735304816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNJfTzzJPRcScWdn06MRRm57QW1y3u2nJwVmaR5hswA=;
        b=VMBTzUDwieqTIo51QzarYBbGbzGydfIKnmYNvOsMfDJZAWRNjehALlZVd6Di82NWNP
         aBDiCHvWz/OAzmt+MGb3nOrfaSxSEzba2gKTuaceJAByTFUlxtKbxpdGBP6RhoeT5L0X
         +CJW8J7d/L1rRoMAuVMH9NPCrWJ0zkYR+um5BoHpAefs0W4GM4eixGrRisjpqaFNRCAn
         R13RdHVcsW2XfW/wzjYK/8zDY2x1jwPACIIJ6ibgjNMSEcFq98PAgKQ7oMWwSDdwpYIw
         Koza/VFpMxdF41ic8PTid7S4Qii8vEFM9/4zo3rhSZmU5QyF0HKj1FQiEDyhJMbYXVcT
         0fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734700016; x=1735304816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNJfTzzJPRcScWdn06MRRm57QW1y3u2nJwVmaR5hswA=;
        b=d5fS3qYlqZgwQfsbJ6I4wygxPcrtIhvka8Hbf+j7ipVHMUNmCvaGV8USDqmbWz9P+n
         MFvyYLnJw8OfdA0ygbxwAncJQT5OCTKGfZWJYcZpzNy1Ap42nNk4S5LW2joXC7x3O6f7
         CtNa7bdEHkgfO4dM6M+nffgXjNquTDveR14HxhqrxNK0eX/Rd/gAEIccoD40B9FKaGdZ
         784WPkSVSG2o1T1mc7duCXBouu4nEYSevWlTDEV1RCz7s2CHLZS9s9cVE1qIBoYWH/6Q
         dKLxHn4EtrkxdhoLSR1l585a7/yAKErxg6DrkxtjDfg2dDkoDaFlxwj4MTrHxO5OBbeI
         if2g==
X-Gm-Message-State: AOJu0YwYApjEHLm+vtO/19PFaeIkwT/t40nVk2yCxA9uJBmvzmCj+9Gy
	yp7kd34wxfFp3rC0OmbP3kvpdg0pgIUaeUSiMP5mBPMrQoB8/Sh3WWGUyPpa
X-Gm-Gg: ASbGncszGzbJh4HhNmfWez+Iq7VONWn5UyfZ6GL+msVppYDA08WUFSUANvw/Xs3GyW6
	dONI81pjStsLIg8YJq2uNN9th7pE7qIV93Bf9b2MhPa2YNjm7n+t5XpAwneWglmQ7RJOL3U7+u2
	0jSOXxz0iIzui2Er6h9URkh7T0KnWede6INpJ2/lT5G537C8yekEBtkx20nUWwpjXSh30Kjt/9K
	ScF3cCL2luBAoNZWI1f9ywyFWlKdctOy5bogdQwSS5ToIQTAAr2Kho=
X-Google-Smtp-Source: AGHT+IGycFy9d57xWmAE8owel2Zv3o27+2q+oo3j4L7XpH8+car7MI2QxJOoEikGzSSDsr9K8is3oA==
X-Received: by 2002:a05:6a20:d49b:b0:1e0:c7cf:bc1f with SMTP id adf61e73a8af0-1e5e0447f12mr4931554637.9.1734700015906;
        Fri, 20 Dec 2024 05:06:55 -0800 (PST)
Received: from meet.. ([103.240.169.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad83033esm3037855b3a.48.2024.12.20.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 05:06:55 -0800 (PST)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	karthik.188@gmail.com,
	kaartic.sivaraam@gmail.com,
	ps@pks.im,
	shyamthakkar001@gmail.com,
	shejialuo@gmail.com,
	chandrapratap3519@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [PATCH v2] t7611: replace test -f with test_path_is* helpers
Date: Fri, 20 Dec 2024 18:36:32 +0530
Message-Id: <20241220130632.11826-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218111715.1030357-1-meetsoni3017@gmail.com>
References: <20241218111715.1030357-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `test -f` and `test ! -f` with `test_path_is_file` and
`test_path_is_missing` for better verbosity.

While `test -f` ensures that the file exists and is a regular file,
`test_path_is_file` provides clearer error messages on failure. Similarly,
`test ! -f`, used to check either the absence of a regular file or the
presence of a directory, has been replaced with `test_path_is_missing` for
better readability and consistent handling of such cases.

Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
Updated commit message and subject according to review.

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

