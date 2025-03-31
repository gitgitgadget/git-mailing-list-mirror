Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31548214221
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436296; cv=none; b=OOr6Vf48hVyceVHx/U0kxOwxIpuRnGVi3yrRUuqKNALeLzmKZviGK5lDU+nHirldRS1bu/jxfeGiLJqhu0/xDHvVzrM4ZvW3v8J8QSkuwqdlHM4iK2wsh7j+yw8dfd6A/ZY9LXwvlk5UYCsLj/F6YDwaGwEUBpDMieJoK20nF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436296; c=relaxed/simple;
	bh=DXnjcCVPIQTNOPZqAaPaatavl4dzzPFeELNudu2ZntI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=h9qZXNqbX2wl3K1f0Qfy579TKZh9QM0uhnEln71P1eG+if6JLNMn4FVqbsApLcm6sARGmErXuoecSLnGyI4+JCUQl1aXS/X3xgSlHIvGcNySs95xV8NqF7fC4a4JvCggXjRCr/msv/srXkmbsMRQr1DbE2AnnoSMPT2NnqIIf80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLYF/y1E; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLYF/y1E"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394a823036so43804775e9.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436290; x=1744041090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PvGhBWTuS0CmUaiSsKEvwJnHy9GBoYi4mKeJ1FkAJ4=;
        b=mLYF/y1EsoS9/A9tTRmfMUHvtYCtvRe75RCV/3aBincAcHw4IlyUq1ouE9KA9QB3gY
         fYfZX+379yAoSBJmBMWdCt9XRB5u78QKEARs8HrMyFREOEOmt1w4soNidQpyh+cZmIyv
         jvF5GD0yAjwhevgvAIPrD9dt4JYmDxJntwvA1KLKfd1Lvu1URn82OwqFmmi59awg98kb
         SfICByZ/UHCxFNR25KtRj/nzPUU6HcAbjGm5dIZvT8BT8TyEcG5xueo0GUV6g/XBqGNx
         qm0PAVjYjwhIFC0ANW5GDaQ9U3pRBwc3yg4r8YVpCgKD1edHjOZ3s8boxRRAOFEyg+Zw
         kujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436290; x=1744041090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PvGhBWTuS0CmUaiSsKEvwJnHy9GBoYi4mKeJ1FkAJ4=;
        b=XWGyosO4khIB4GEa+XJXPnBCw/UOfw5RR5YysA6wbHZkfXqHz21kaTmz/32IahXgRO
         kaO3VHOu5VbWswO1XPNI5RFjDRb02BL2ShFvigqAi0v45bI2kvY15LBwl+KUWLbgkmzH
         gnEA3eWQrnYBf9g/4mAQonbJ27EYj2YREi245yCr/q3tc6HUOKTarQKiKWl+S9SLrftx
         kfcDQs+OSShl8x2R+8+QDBRFosAhs0+rYsyJmUWv06nCRB75pUQskOaYYREH/pC+4NqT
         uErdQEUwLlJ0mk7oZnu/1baea4X3OyThJzodSqbr2FkatRQMLNlv05ic8zWw4EOtBtGj
         +ITw==
X-Gm-Message-State: AOJu0YyvrVFwRYF0SQfeWGfeso2GVU/jAI31PRDwxiKB8g3pjuHgAQXs
	M9ag1rBvvCpG86CmzCoOMfZfyJdpMDMzAJNbogEvAa25b3cBa/K6QobDEg==
X-Gm-Gg: ASbGnctNDwftYckJYOGrDnQ/Cs+rUYW/khGR5wBVfbagUcpS7aUuARiHC5+HF/7g5SZ
	n0rlFwVH5ZyuIpQR6czLNB4Nro/cTy7e2KZ2KZR2iO3FUjU6BIALzo8V1cUz6SHuTgwKlOCpNrd
	m0y8AmEfnZNzfBi7M0072pF/BL85ocX5supSrfP09lRjCECIeAVZCOvxw/iNJ8ElfoJsqiI4bgY
	KEKAqbqlu7/j23d8S7TtaUvXdgqQRuQl+dJgT3hwFmCE9AzskdsmO5Yya1PZVtjeqgaLLtOIpUk
	2UC6b23HSAKESf2g/5Q2RrpiHTIL2yZnsVKj792VQ8ne2A==
X-Google-Smtp-Source: AGHT+IFBLa4SfRqKdJ18OJMndcCMAfcwyQABOAYVIbNOU4rmMncTHXSITRbHRsalaGznAleRso1ALQ==
X-Received: by 2002:a05:600c:699b:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-43db62c034bmr89920725e9.24.1743436289129;
        Mon, 31 Mar 2025 08:51:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f5f22sm167688825e9.30.2025.03.31.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:28 -0700 (PDT)
Message-Id: <0b6bcd225dc1444f4debe5fb8c499c6cad0a4ab2.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:18 +0000
Subject: [PATCH 7/8] tests: remove GIT_TEST_MERGE_ALGORITHM and
 test_expect_merge_algorithm
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Both of these existed to allow use to reuse all the merge-related tests
in the testsuite while easily flipping between the 'recursive' and the
'ort' backends.  Now that we have removed merge-recursive and remapped
'recursive' to mean 'ort', we don't need this scaffolding anymore.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 ci/run-build-and-tests.sh                     |   1 -
 t/lib-merge.sh                                |  13 -
 t/t1092-sparse-checkout-compatibility.sh      |   2 -
 t/t2501-cwd-empty.sh                          |   2 -
 t/t3512-cherry-pick-submodule.sh              |   5 -
 t/t3513-revert-submodule.sh                   |   4 -
 t/t4069-remerge-diff.sh                       |   7 -
 t/t4301-merge-tree-write-tree.sh              |   7 -
 t/t5572-pull-submodule.sh                     |   5 -
 t/t6400-merge-df.sh                           |  14 +-
 t/t6402-merge-rename.sh                       | 125 +----
 t/t6404-recursive-merge.sh                    |  21 +-
 t/t6406-merge-attr.sh                         |   7 +-
 t/t6416-recursive-corner-cases.sh             | 194 ++-----
 t/t6421-merge-partial-clone.sh                |   7 +-
 t/t6422-merge-rename-corner-cases.sh          |  31 +-
 t/t6423-merge-rename-directories.sh           | 517 ++++--------------
 t/t6424-merge-unrelated-index-changes.sh      |   4 +-
 t/t6426-merge-skip-unneeded-updates.sh        |   4 +-
 t/t6428-merge-conflicts-sparse.sh             |   2 -
 t/t6430-merge-recursive.sh                    |   3 +-
 t/t6436-merge-overwrite.sh                    |  17 +-
 t/t6437-submodule-merge.sh                    |  65 +--
 t/t6438-submodule-directory-file-conflicts.sh |   5 -
 t/t6439-merge-co-error-msgs.sh                |   2 +-
 t/t7402-submodule-rebase.sh                   |   7 +-
 t/t7602-merge-octopus-many.sh                 |   9 +-
 t/t7610-mergetool.sh                          |  40 +-
 t/test-lib.sh                                 |   2 -
 29 files changed, 248 insertions(+), 874 deletions(-)
 delete mode 100644 t/lib-merge.sh

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 1c698467235..f99b7db2ee8 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -20,7 +20,6 @@ linux-breaking-changes)
 linux-TEST-vars)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
-	export GIT_TEST_MERGE_ALGORITHM=recursive
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true
 	export GIT_TEST_OE_SIZE=10
 	export GIT_TEST_OE_DELTA_SIZE=5
diff --git a/t/lib-merge.sh b/t/lib-merge.sh
deleted file mode 100644
index 8734ebfc17f..00000000000
--- a/t/lib-merge.sh
+++ /dev/null
@@ -1,13 +0,0 @@
-# Helper functions used by merge tests.
-
-test_expect_merge_algorithm () {
-	status_for_recursive=$1 status_for_ort=$2
-	shift 2
-
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_expect_${status_for_ort} "$@"
-	else
-		test_expect_${status_for_recursive} "$@"
-	fi
-}
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a4c7c41fc00..f9b448792cb 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1486,7 +1486,6 @@ test_expect_success 'sparse-index is not expanded' '
 	ensure_not_expanded checkout -f update-deep &&
 	test_config -C sparse-index pull.twohead ort &&
 	(
-		sane_unset GIT_TEST_MERGE_ALGORITHM &&
 		for OPERATION in "merge -m merge" cherry-pick rebase
 		do
 			ensure_not_expanded merge -m merge update-folder1 &&
@@ -1506,7 +1505,6 @@ test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
 	done &&
 
 	(
-		sane_unset GIT_TEST_MERGE_ALGORITHM &&
 		git -C sparse-index config pull.twohead ort &&
 		ensure_not_expanded ! merge -m merged expand-right
 	)
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index f6d8d7d03d7..be9140bbaa4 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -117,8 +117,6 @@ test_expect_success 'merge fails if cwd needs to be removed; recursive friendly'
 	grep "Refusing to remove the current working directory" error
 '
 
-GIT_TEST_MERGE_ALGORITHM=ort
-
 test_expect_success 'merge fails if cwd needs to be removed' '
 	test_required_dir_removal git merge fd_conflict
 '
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodule.sh
index f22d1ddead1..85a79326977 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -8,11 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
-if test "$GIT_TEST_MERGE_ALGORITHM" != ort
-then
-	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-fi
 test_submodule_switch "cherry-pick"
 
 test_expect_success 'unrelated submodule/file conflict is ignored' '
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 8bfe3ed2467..32e15c72eee 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -30,10 +30,6 @@ git_revert () {
 	git revert HEAD
 }
 
-if test "$GIT_TEST_MERGE_ALGORITHM" != ort
-then
-	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-fi
 test_submodule_switch_func "git_revert"
 
 test_done
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index c6c94aef14d..966882ce912 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -4,13 +4,6 @@ test_description='remerge-diff handling'
 
 . ./test-lib.sh
 
-# This test is ort-specific
-if test "${GIT_TEST_MERGE_ALGORITHM}" != ort
-then
-	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
-	test_done
-fi
-
 test_expect_success 'setup basic merges' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 >numbers &&
 	git add numbers &&
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 44f7d077593..f9c5883a7f7 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -4,13 +4,6 @@ test_description='git merge-tree --write-tree'
 
 . ./test-lib.sh
 
-# This test is ort-specific
-if test "$GIT_TEST_MERGE_ALGORITHM" != "ort"
-then
-	skip_all="GIT_TEST_MERGE_ALGORITHM != ort"
-	test_done
-fi
-
 test_expect_success setup '
 	test_write_lines 1 2 3 4 5 >numbers &&
 	echo hello >greeting &&
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index f7650e8475e..45f384dd328 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -45,11 +45,6 @@ git_pull_noff () {
 	$2 git pull --no-ff
 }
 
-if test "$GIT_TEST_MERGE_ALGORITHM" != ort
-then
-	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-fi
 test_submodule_switch_func "git_pull_noff"
 
 test_expect_success 'setup' '
diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 3de4ef6bd9e..b46fe494409 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -84,12 +84,7 @@ test_expect_success 'modify/delete + directory/file conflict' '
 
 	test_stdout_line_count = 5 git ls-files -s &&
 	test_stdout_line_count = 4 git ls-files -u &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 0 git ls-files -o
-	else
-		test_stdout_line_count = 1 git ls-files -o
-	fi &&
+	test_stdout_line_count = 0 git ls-files -o &&
 
 	test_path_is_file letters/file &&
 	test_path_is_file letters.txt &&
@@ -105,12 +100,7 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_stdout_line_count = 5 git ls-files -s &&
 	test_stdout_line_count = 4 git ls-files -u &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 0 git ls-files -o
-	else
-		test_stdout_line_count = 1 git ls-files -o
-	fi &&
+	test_stdout_line_count = 0 git ls-files -o &&
 
 	test_path_is_file letters/file &&
 	test_path_is_file letters.txt &&
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 2738b50c2a9..ff00b74e9c1 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -313,12 +313,7 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 
 	test_grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_grep "Auto-merging dir" output &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_grep "moving it to dir~HEAD instead" output
-	else
-		test_grep "Adding as dir~HEAD instead" output
-	fi &&
+	test_grep "moving it to dir~HEAD instead" output &&
 
 	test_stdout_line_count = 3 git ls-files -u &&
 	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
@@ -340,12 +335,7 @@ test_expect_success 'Same as previous, but merged other way' '
 	! grep "error: refusing to lose untracked file at" errors &&
 	test_grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_grep "Auto-merging dir" output &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_grep "moving it to dir~renamed-file-has-no-conflicts instead" output
-	else
-		test_grep "Adding as dir~renamed-file-has-no-conflicts instead" output
-	fi &&
+	test_grep "moving it to dir~renamed-file-has-no-conflicts instead" output &&
 
 	test_stdout_line_count = 3 git ls-files -u &&
 	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
@@ -400,14 +390,7 @@ test_expect_success 'Rename+D/F conflict; renamed file cannot merge and dir in t
 	test_must_fail git merge --strategy=recursive dir-in-way &&
 
 	test_stdout_line_count = 5 git ls-files -u &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 3 git ls-files -u dir~HEAD
-	else
-		git ls-files -u dir >out &&
-		test 3 -eq $(grep -v file-in-the-way out | wc -l) &&
-		rm -f out
-	fi &&
+	test_stdout_line_count = 3 git ls-files -u dir~HEAD &&
 	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
@@ -425,14 +408,7 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git merge --strategy=recursive renamed-file-has-conflicts &&
 
 	test_stdout_line_count = 5 git ls-files -u &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 3 git ls-files -u dir~renamed-file-has-conflicts
-	else
-		git ls-files -u dir >out &&
-		test 3 -eq $(grep -v file-in-the-way out | wc -l) &&
-		rm -f out
-	fi &&
+	test_stdout_line_count = 3 git ls-files -u dir~renamed-file-has-conflicts &&
 	test_stdout_line_count = 2 git ls-files -u dir/file-in-the-way &&
 
 	test_must_fail git diff --quiet &&
@@ -488,12 +464,7 @@ test_expect_success 'both rename source and destination involved in D/F conflict
 	git checkout -q rename-dest^0 &&
 	test_must_fail git merge --strategy=recursive source-conflict &&
 
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 2 git ls-files -u
-	else
-		test_stdout_line_count = 1 git ls-files -u
-	fi &&
+	test_stdout_line_count = 2 git ls-files -u &&
 
 	test_must_fail git diff --quiet &&
 
@@ -527,63 +498,33 @@ test_expect_success 'setup pair rename to parent of other (D/F conflicts)' '
 	git commit -m "Rename one/file -> two"
 '
 
-if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-then
-	test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
-		git checkout -q rename-one^0 &&
-		mkdir one &&
-		test_must_fail git merge --strategy=recursive rename-two &&
-
-		test_stdout_line_count = 4 git ls-files -u &&
-		test_stdout_line_count = 2 git ls-files -u one &&
-		test_stdout_line_count = 2 git ls-files -u two &&
-
-		test_must_fail git diff --quiet &&
-
-		test 3 -eq $(find . | grep -v .git | wc -l) &&
-
-		test_path_is_file one &&
-		test_path_is_file two &&
-		test "other" = $(cat one) &&
-		test "stuff" = $(cat two)
-	'
-else
-	test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
-		git checkout -q rename-one^0 &&
-		mkdir one &&
-		test_must_fail git merge --strategy=recursive rename-two &&
+test_expect_success 'pair rename to parent of other (D/F conflicts) w/ untracked dir' '
+	git checkout -q rename-one^0 &&
+	mkdir one &&
+	test_must_fail git merge --strategy=recursive rename-two &&
 
-		test_stdout_line_count = 2 git ls-files -u &&
-		test_stdout_line_count = 1 git ls-files -u one &&
-		test_stdout_line_count = 1 git ls-files -u two &&
+	test_stdout_line_count = 4 git ls-files -u &&
+	test_stdout_line_count = 2 git ls-files -u one &&
+	test_stdout_line_count = 2 git ls-files -u two &&
 
-		test_must_fail git diff --quiet &&
+	test_must_fail git diff --quiet &&
 
-		test 4 -eq $(find . | grep -v .git | wc -l) &&
+	test 3 -eq $(find . | grep -v .git | wc -l) &&
 
-		test_path_is_dir one &&
-		test_path_is_file one~rename-two &&
-		test_path_is_file two &&
-		test "other" = $(cat one~rename-two) &&
-		test "stuff" = $(cat two)
-	'
-fi
+	test_path_is_file one &&
+	test_path_is_file two &&
+	test "other" = $(cat one) &&
+	test "stuff" = $(cat two)
+'
 
 test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean start' '
 	git reset --hard &&
 	git clean -fdqx &&
 	test_must_fail git merge --strategy=recursive rename-two &&
 
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 4 git ls-files -u &&
-		test_stdout_line_count = 2 git ls-files -u one &&
-		test_stdout_line_count = 2 git ls-files -u two
-	else
-		test_stdout_line_count = 2 git ls-files -u &&
-		test_stdout_line_count = 1 git ls-files -u one &&
-		test_stdout_line_count = 1 git ls-files -u two
-	fi &&
+	test_stdout_line_count = 4 git ls-files -u &&
+	test_stdout_line_count = 2 git ls-files -u one &&
+	test_stdout_line_count = 2 git ls-files -u two &&
 
 	test_must_fail git diff --quiet &&
 
@@ -623,22 +564,12 @@ test_expect_success 'check handling of differently renamed file with D/F conflic
 	git checkout -q first-rename^0 &&
 	test_must_fail git merge --strategy=recursive second-rename &&
 
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_stdout_line_count = 5 git ls-files -s &&
-		test_stdout_line_count = 3 git ls-files -u &&
-		test_stdout_line_count = 1 git ls-files -u one~HEAD &&
-		test_stdout_line_count = 1 git ls-files -u two~second-rename &&
-		test_stdout_line_count = 1 git ls-files -u original &&
-		test_stdout_line_count = 0 git ls-files -o
-	else
-		test_stdout_line_count = 5 git ls-files -s &&
-		test_stdout_line_count = 3 git ls-files -u &&
-		test_stdout_line_count = 1 git ls-files -u one &&
-		test_stdout_line_count = 1 git ls-files -u two &&
-		test_stdout_line_count = 1 git ls-files -u original &&
-		test_stdout_line_count = 2 git ls-files -o
-	fi &&
+	test_stdout_line_count = 5 git ls-files -s &&
+	test_stdout_line_count = 3 git ls-files -u &&
+	test_stdout_line_count = 1 git ls-files -u one~HEAD &&
+	test_stdout_line_count = 1 git ls-files -u two~second-rename &&
+	test_stdout_line_count = 1 git ls-files -u original &&
+	test_stdout_line_count = 0 git ls-files -o &&
 
 	test_path_is_file one/file &&
 	test_path_is_file two/file &&
diff --git a/t/t6404-recursive-merge.sh b/t/t6404-recursive-merge.sh
index ae687f2ce54..346f3608b98 100755
--- a/t/t6404-recursive-merge.sh
+++ b/t/t6404-recursive-merge.sh
@@ -108,12 +108,7 @@ test_expect_success 'refuse to merge binary files' '
 	printf "\0\0" >binary-file &&
 	git add binary-file &&
 	git commit -m binary2 &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_must_fail git merge F >merge_output
-	else
-		test_must_fail git merge F 2>merge_output
-	fi &&
+	test_must_fail git merge F >merge_output &&
 	grep "Cannot merge binary files: binary-file (HEAD vs. F)" merge_output
 '
 
@@ -129,22 +124,12 @@ test_expect_success 'mark rename/delete as unmerged' '
 	test_tick &&
 	git commit -m rename &&
 	test_must_fail git merge delete &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test 2 = $(git ls-files --unmerged | wc -l)
-	else
-		test 1 = $(git ls-files --unmerged | wc -l)
-	fi &&
+	test 2 = $(git ls-files --unmerged | wc -l) &&
 	git rev-parse --verify :2:a2 &&
 	test_must_fail git rev-parse --verify :3:a2 &&
 	git checkout -f delete &&
 	test_must_fail git merge rename &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test 2 = $(git ls-files --unmerged | wc -l)
-	else
-		test 1 = $(git ls-files --unmerged | wc -l)
-	fi &&
+	test 2 = $(git ls-files --unmerged | wc -l) &&
 	test_must_fail git rev-parse --verify :2:a2 &&
 	git rev-parse --verify :3:a2
 '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 66e01464b5e..8f6fbef0024 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -259,12 +259,7 @@ test_expect_success 'binary files with union attribute' '
 	printf "two\0" >bin.txt &&
 	git commit -am two &&
 
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_must_fail git merge bin-main >output
-	else
-		test_must_fail git merge bin-main 2>output
-	fi &&
+	test_must_fail git merge bin-main >output &&
 	grep -i "warning.*cannot merge.*HEAD vs. bin-main" output
 '
 
diff --git a/t/t6416-recursive-corner-cases.sh b/t/t6416-recursive-corner-cases.sh
index 17b54d625d0..ed20de8ea22 100755
--- a/t/t6416-recursive-corner-cases.sh
+++ b/t/t6416-recursive-corner-cases.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
 
 #
 #  L1  L2
@@ -529,15 +528,8 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 
 		git checkout B^0 &&
 		test_must_fail git merge C^0 &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git rm -rf a/ &&
-			git rm a~HEAD
-		else
-			git clean -fd &&
-			git rm -rf a/ &&
-			git rm a
-		fi &&
+		git rm -rf a/ &&
+		git rm a~HEAD &&
 		git cat-file -p B:a >a2 &&
 		git add a2 &&
 		git commit -m D2 &&
@@ -556,12 +548,7 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 
 		git checkout C^0 &&
 		test_must_fail git merge B^0 &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git rm a~B^0
-		else
-			git clean -fd
-		fi &&
+		git rm a~B^0 &&
 		git rm -rf a/ &&
 		test_write_lines 1 2 3 4 5 6 7 8 >a &&
 		git add a &&
@@ -570,15 +557,8 @@ test_expect_success 'setup differently handled merges of directory/file conflict
 
 		git checkout C^0 &&
 		test_must_fail git merge B^0 &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git rm -rf a/ &&
-			git rm a~B^0
-		else
-			git clean -fd &&
-			git rm -rf a/ &&
-			git rm a
-		fi &&
+		git rm -rf a/ &&
+		git rm a~B^0 &&
 		test_write_lines 1 2 3 4 5 6 7 8 >a2 &&
 		git add a2 &&
 		git commit -m E4 &&
@@ -596,34 +576,16 @@ test_expect_success 'merge of D1 & E1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive E1^0 &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 3 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >expect    \
-				A:ignore-me  B:a  D1:a &&
-			git rev-parse   >actual   \
-				:0:ignore-me :1:a :2:a &&
-			test_cmp expect actual
-		else
-			git ls-files -s >out &&
-			test_line_count = 2 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >expect    \
-				A:ignore-me  B:a &&
-			git rev-parse   >actual   \
-				:0:ignore-me :2:a &&
-			test_cmp expect actual
-		fi
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect    A:ignore-me  B:a D1:a &&
+		git rev-parse >actual   :0:ignore-me :1:a :2:a &&
+		test_cmp expect actual
 	)
 '
 
@@ -637,34 +599,18 @@ test_expect_success 'merge of E1 & D1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive D1^0 &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 3 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >expect    \
-				A:ignore-me  B:a  D1:a &&
-			git rev-parse   >actual   \
-				:0:ignore-me :1:a :3:a &&
-			test_cmp expect actual
-		else
-			git ls-files -s >out &&
-			test_line_count = 2 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >expect    \
-				A:ignore-me  B:a &&
-			git rev-parse   >actual   \
-				:0:ignore-me :3:a &&
-			test_cmp expect actual
-		fi
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect    \
+			A:ignore-me  B:a  D1:a &&
+		git rev-parse   >actual   \
+			:0:ignore-me :1:a :3:a &&
+		test_cmp expect actual
 	)
 '
 
@@ -678,32 +624,17 @@ test_expect_success 'merge of D1 & E2 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive E2^0 &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 5 out &&
-			git ls-files -u >out &&
-			test_line_count = 4 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >expect    \
-				B:a       D1:a      E2:a/file  C:a/file   A:ignore-me &&
-			git rev-parse   >actual   \
-				:1:a~HEAD :2:a~HEAD :3:a/file  :1:a/file  :0:ignore-me
-		else
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 3 out &&
-			git ls-files -o >out &&
-			test_line_count = 2 out &&
-
-			git rev-parse >expect    \
-				B:a    E2:a/file  C:a/file   A:ignore-me &&
-			git rev-parse   >actual   \
-				:2:a   :3:a/file  :1:a/file  :0:ignore-me
-		fi &&
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 4 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect    \
+			B:a       D1:a      E2:a/file  C:a/file   A:ignore-me &&
+		git rev-parse   >actual   \
+			:1:a~HEAD :2:a~HEAD :3:a/file  :1:a/file  :0:ignore-me &&
 		test_cmp expect actual &&
 
 		test_path_is_file a~HEAD
@@ -720,32 +651,17 @@ test_expect_success 'merge of E2 & D1 fails but has appropriate contents' '
 
 		test_must_fail git merge -s recursive D1^0 &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 5 out &&
-			git ls-files -u >out &&
-			test_line_count = 4 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >expect    \
-				B:a       D1:a      E2:a/file  C:a/file   A:ignore-me &&
-			git rev-parse   >actual   \
-				:1:a~D1^0 :3:a~D1^0 :2:a/file  :1:a/file  :0:ignore-me
-		else
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 3 out &&
-			git ls-files -o >out &&
-			test_line_count = 2 out &&
-
-			git rev-parse >expect    \
-				B:a   E2:a/file  C:a/file   A:ignore-me &&
-			git rev-parse   >actual   \
-				:3:a  :2:a/file  :1:a/file  :0:ignore-me
-		fi &&
+		git ls-files -s >out &&
+		test_line_count = 5 out &&
+		git ls-files -u >out &&
+		test_line_count = 4 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >expect    \
+			B:a       D1:a      E2:a/file  C:a/file   A:ignore-me &&
+		git rev-parse   >actual   \
+			:1:a~D1^0 :3:a~D1^0 :2:a/file  :1:a/file  :0:ignore-me &&
 		test_cmp expect actual &&
 
 		test_path_is_file a~D1^0
@@ -777,7 +693,7 @@ test_expect_success 'merge of D1 & E3 succeeds' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'merge of D1 & E4 puts merge of a and a2 in both a and a2' '
+test_expect_success 'merge of D1 & E4 puts merge of a and a2 in both a and a2' '
 	test_when_finished "git -C directory-file reset --hard" &&
 	test_when_finished "git -C directory-file clean -fdqx" &&
 	(
@@ -1140,7 +1056,7 @@ test_expect_success 'setup symlink modify/modify' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'check symlink modify/modify' '
+test_expect_success 'check symlink modify/modify' '
 	(
 		cd symlink-modify-modify &&
 
@@ -1206,7 +1122,7 @@ test_expect_success 'setup symlink add/add' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'check symlink add/add' '
+test_expect_success 'check symlink add/add' '
 	(
 		cd symlink-add-add &&
 
@@ -1294,7 +1210,7 @@ test_expect_success 'setup submodule modify/modify' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'check submodule modify/modify' '
+test_expect_success 'check submodule modify/modify' '
 	(
 		cd submodule-modify-modify &&
 
@@ -1382,7 +1298,7 @@ test_expect_success 'setup submodule add/add' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'check submodule add/add' '
+test_expect_success 'check submodule add/add' '
 	(
 		cd submodule-add-add &&
 
@@ -1457,7 +1373,7 @@ test_expect_success 'setup conflicting entry types (submodule vs symlink)' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'check conflicting entry types (submodule vs symlink)' '
+test_expect_success 'check conflicting entry types (submodule vs symlink)' '
 	(
 		cd submodule-symlink-add-add &&
 
diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index b99f29ef9ba..6eb51285a0c 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -27,7 +27,6 @@ test_description="limiting blob downloads when merging with partial clones"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_setup_repo () {
 	test -d server && return
@@ -207,7 +206,7 @@ test_setup_repo () {
 #
 #   Summary: 2 fetches (1 for 2 objects, 1 for 1 object)
 #
-test_expect_merge_algorithm failure success 'Objects downloaded for single relevant rename' '
+test_expect_success 'Objects downloaded for single relevant rename' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-single &&
 	(
@@ -297,7 +296,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded for single relev
 #      this are not all that common.)
 #   Summary: 1 fetches for 6 objects
 #
-test_expect_merge_algorithm failure success 'Objects downloaded when a directory rename triggered' '
+test_expect_success 'Objects downloaded when a directory rename triggered' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-dir &&
 	(
@@ -399,7 +398,7 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 #
 #   Summary: 4 fetches (1 for 6 objects, 1 for 8, 1 for 3, 1 for 2)
 #
-test_expect_merge_algorithm failure success 'Objects downloaded with lots of renames and modifications' '
+test_expect_success 'Objects downloaded with lots of renames and modifications' '
 	test_setup_repo &&
 	git clone --sparse --filter=blob:none "file://$(pwd)/server" objects-many &&
 	(
diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index 62b49c67e22..9cbe7ca7824 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -7,7 +7,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_setup_rename_delete_untracked () {
 	git init rename-delete-untracked &&
@@ -316,12 +315,7 @@ test_expect_success 'rename/directory conflict + clean content merge' '
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
 		git ls-files -o >out &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_line_count = 1 out
-		else
-			test_line_count = 2 out
-		fi &&
+		test_line_count = 1 out &&
 
 		echo 0 >expect &&
 		git cat-file -p base:file >>expect &&
@@ -350,12 +344,7 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 		git ls-files -u >out &&
 		test_line_count = 3 out &&
 		git ls-files -o >out &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_line_count = 1 out
-		else
-			test_line_count = 2 out
-		fi &&
+		test_line_count = 1 out &&
 
 		git cat-file -p left-conflict:newfile >left &&
 		git cat-file -p base:file    >base &&
@@ -369,14 +358,8 @@ test_expect_success 'rename/directory conflict + content merge conflict' '
 
 		git rev-parse >expect   \
 			base:file       left-conflict:newfile right:file &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git rev-parse >actual \
-				:1:newfile~HEAD :2:newfile~HEAD :3:newfile~HEAD
-		else
-			git rev-parse >actual \
-				:1:newfile      :2:newfile      :3:newfile
-		fi &&
+		git rev-parse >actual \
+			:1:newfile~HEAD :2:newfile~HEAD :3:newfile~HEAD &&
 		test_cmp expect actual &&
 
 		test_path_is_file newfile/realfile &&
@@ -896,7 +879,7 @@ test_setup_rad () {
 	)
 }
 
-test_expect_merge_algorithm failure success 'rad-check: rename/add/delete conflict' '
+test_expect_success 'rad-check: rename/add/delete conflict' '
 	test_setup_rad &&
 	(
 		cd rad &&
@@ -969,7 +952,7 @@ test_setup_rrdd () {
 	)
 }
 
-test_expect_merge_algorithm failure success 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
+test_expect_success 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 	test_setup_rrdd &&
 	(
 		cd rrdd &&
@@ -1058,7 +1041,7 @@ test_setup_mod6 () {
 	)
 }
 
-test_expect_merge_algorithm failure success 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
+test_expect_success 'mod6-check: chains of rename/rename(1to2) and rename/rename(2to1)' '
 	test_setup_mod6 &&
 	(
 		cd mod6 &&
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index e0785410cd9..f48ed6d0353 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -26,8 +26,6 @@ test_description="recursive merge with directory renames"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
-
 
 ###########################################################################
 # SECTION 1: Basic cases we should be able to handle
@@ -302,20 +300,11 @@ test_expect_success '1d: Directory renames cause a rename/rename(2to1) conflict'
 		git cat-file -p :2:x/wham >expect &&
 		git cat-file -p :3:x/wham >other &&
 		>empty &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_must_fail git merge-file \
-				-L "HEAD:y/wham" \
-				-L "" \
-				-L "B^0:z/wham" \
-				expect empty other
-		else
-			test_must_fail git merge-file \
-				-L "HEAD" \
-				-L "" \
-				-L "B^0" \
-				expect empty other
-		fi &&
+		test_must_fail git merge-file \
+			-L "HEAD:y/wham" \
+			-L "" \
+			-L "B^0:z/wham" \
+			expect empty other &&
 		test_cmp expect x/wham
 	)
 '
@@ -1186,18 +1175,10 @@ test_expect_success '5d: Directory/file/file conflict due to directory rename' '
 		git ls-files -u >out &&
 		test_line_count = 1 out &&
 		git ls-files -o >out &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_line_count = 1 out &&
-
-			git rev-parse >actual \
-			    :0:y/b :0:y/c :0:z/d :0:y/f :2:y/d~HEAD :0:y/d/e
-		else
-			test_line_count = 2 out &&
-
-			git rev-parse >actual \
-			    :0:y/b :0:y/c :0:z/d :0:y/f :2:y/d      :0:y/d/e
-		fi &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+		    :0:y/b :0:y/c :0:z/d :0:y/f :2:y/d~HEAD :0:y/d/e &&
 		git rev-parse >expect \
 			 O:z/b  O:z/c  B:z/d  B:z/f  A:y/d  B:y/d/e &&
 		test_cmp expect actual &&
@@ -1280,32 +1261,17 @@ test_expect_success '6a: Tricky rename/delete' '
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_grep "CONFLICT (rename/delete).*z/c.*y/c" out &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 3 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >actual \
-				:0:y/b :1:y/c :3:y/c &&
-			git rev-parse >expect \
-				 O:z/b  O:z/c  O:z/c
-		else
-			git ls-files -s >out &&
-			test_line_count = 2 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >actual \
-				:0:y/b :3:y/c &&
-			git rev-parse >expect \
-				 O:z/b  O:z/c
-		fi &&
+		git ls-files -s >out &&
+		test_line_count = 3 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :1:y/c :3:y/c &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  O:z/c &&
 		test_cmp expect actual
 	)
 '
@@ -1372,7 +1338,7 @@ test_setup_6b1 () {
 	)
 }
 
-test_expect_merge_algorithm failure success '6b1: Same renames done on both sides, plus another rename' '
+test_expect_success '6b1: Same renames done on both sides, plus another rename' '
 	test_setup_6b1 &&
 	(
 		cd 6b1 &&
@@ -1445,7 +1411,7 @@ test_setup_6b2 () {
 	)
 }
 
-test_expect_merge_algorithm failure success '6b2: Same rename done on both sides' '
+test_expect_success '6b2: Same rename done on both sides' '
 	test_setup_6b2 &&
 	(
 		cd 6b2 &&
@@ -1832,20 +1798,11 @@ test_expect_success '7b: rename/rename(2to1), but only due to transitive rename'
 		git cat-file -p :2:y/d >expect &&
 		git cat-file -p :3:y/d >other &&
 		>empty &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_must_fail git merge-file \
-				-L "HEAD:y/d" \
-				-L "" \
-				-L "B^0:z/d" \
-				expect empty other
-		else
-			test_must_fail git merge-file \
-				-L "HEAD" \
-				-L "" \
-				-L "B^0" \
-				expect empty other
-		fi &&
+		test_must_fail git merge-file \
+			-L "HEAD:y/d" \
+			-L "" \
+			-L "B^0:z/d" \
+			expect empty other &&
 		test_cmp expect y/d
 	)
 '
@@ -1967,32 +1924,17 @@ test_expect_success '7d: transitive rename involved in rename/delete; how is it
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_grep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >actual \
-				:0:y/b :0:y/c :1:y/d :3:y/d &&
-			git rev-parse >expect \
-				 O:z/b  O:z/c  O:x/d  O:x/d
-		else
-			git ls-files -s >out &&
-			test_line_count = 3 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >actual \
-				:0:y/b :0:y/c :3:y/d &&
-			git rev-parse >expect \
-				 O:z/b  O:z/c  O:x/d
-		fi &&
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:y/b :0:y/c :1:y/d :3:y/d &&
+		git rev-parse >expect \
+			 O:z/b  O:z/c  O:x/d  O:x/d &&
 		test_cmp expect actual
 	)
 '
@@ -2073,32 +2015,17 @@ test_expect_success '7e: transitive rename in rename/delete AND dirs in the way'
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out &&
 		test_grep "CONFLICT (rename/delete).*x/d.*y/d" out &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			git ls-files -s >out &&
-			test_line_count = 6 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 1 out &&
-
-			git rev-parse >actual \
-				:0:x/d/f :0:y/d/g :0:y/b :0:y/c :1:y/d~B^0 :3:y/d~B^0 &&
-			git rev-parse >expect \
-				 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d      O:x/d
-		else
-			git ls-files -s >out &&
-			test_line_count = 5 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 2 out &&
-
-			git rev-parse >actual \
-				:0:x/d/f :0:y/d/g :0:y/b :0:y/c :3:y/d &&
-			git rev-parse >expect \
-				 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d
-		fi &&
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+		git ls-files -u >out &&
+		test_line_count = 2 out &&
+		git ls-files -o >out &&
+		test_line_count = 1 out &&
+
+		git rev-parse >actual \
+			:0:x/d/f :0:y/d/g :0:y/b :0:y/c :1:y/d~B^0 :3:y/d~B^0 &&
+		git rev-parse >expect \
+			 A:x/d/f  A:y/d/g  O:z/b  O:z/c  O:x/d      O:x/d &&
 		test_cmp expect actual &&
 
 		git hash-object y/d~B^0 >actual &&
@@ -3284,34 +3211,15 @@ test_expect_success '10b: Overwrite untracked with dir rename + delete' '
 		echo contents >y/e &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
-
-			git ls-files -s >out &&
-			test_line_count = 1 out &&
-			git ls-files -u >out &&
-			test_line_count = 0 out &&
-			git ls-files -o >out &&
-			test_line_count = 5 out
-		else
-			test_grep "CONFLICT (rename/delete).*Version B\^0 of y/d left in tree at y/d~B\^0" out &&
-			test_grep "Error: Refusing to lose untracked file at y/e; writing to y/e~B\^0 instead" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 3 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 5 out &&
-
-			git rev-parse >actual \
-				:0:y/b :3:y/d :3:y/e &&
-			git rev-parse >expect \
-				O:z/b  O:z/c  B:z/e &&
-			test_cmp expect actual
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
+
+		git ls-files -s >out &&
+		test_line_count = 1 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 5 out &&
 
 		echo very >expect &&
 		test_cmp expect y/c &&
@@ -3374,38 +3282,15 @@ test_expect_success '10c1: Overwrite untracked with dir rename/rename(1to2)' '
 		echo important >y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
-
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 0 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out
-		else
-			test_grep "CONFLICT (rename/rename)" out &&
-			test_grep "Refusing to lose untracked file at y/c; adding as y/c~B\^0 instead" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 6 out &&
-			git ls-files -u >out &&
-			test_line_count = 3 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			git rev-parse >actual \
-				:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :3:y/c &&
-			git rev-parse >expect \
-				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
-			test_cmp expect actual &&
-
-			git hash-object y/c~B^0 >actual &&
-			git rev-parse O:x/c >expect &&
-			test_cmp expect actual
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
 
 		echo important >expect &&
 		test_cmp expect y/c
@@ -3425,38 +3310,15 @@ test_expect_success '10c2: Overwrite untracked with dir rename/rename(1to2), oth
 		echo important >y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive A^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
-
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 0 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out
-		else
-			test_grep "CONFLICT (rename/rename)" out &&
-			test_grep "Refusing to lose untracked file at y/c; adding as y/c~HEAD instead" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 6 out &&
-			git ls-files -u >out &&
-			test_line_count = 3 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			git rev-parse >actual \
-				:0:y/a :0:y/b :0:x/d :1:x/c :3:w/c :2:y/c &&
-			git rev-parse >expect \
-				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  O:x/c &&
-			test_cmp expect actual &&
-
-			git hash-object y/c~HEAD >actual &&
-			git rev-parse O:x/c >expect &&
-			test_cmp expect actual
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
+
+		git ls-files -s >out &&
+		test_line_count = 4 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
 
 		echo important >expect &&
 		test_cmp expect y/c
@@ -3514,47 +3376,15 @@ test_expect_success '10d: Delete untracked with dir rename/rename(2to1)' '
 		echo important >y/wham &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
-
-			git ls-files -s >out &&
-			test_line_count = 6 out &&
-			git ls-files -u >out &&
-			test_line_count = 0 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out
-		else
-			test_grep "CONFLICT (rename/rename)" out &&
-			test_grep "Refusing to lose untracked file at y/wham" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 6 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			git rev-parse >actual \
-				:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
-			git rev-parse >expect \
-				 O:z/a  O:z/b  O:x/d  O:x/e  O:z/c     O:x/f &&
-			test_cmp expect actual &&
-
-			test_must_fail git rev-parse :1:y/wham &&
-
-			# Test that two-way merge in y/wham~merged is as expected
-			git cat-file -p :2:y/wham >expect &&
-			git cat-file -p :3:y/wham >other &&
-			>empty &&
-			test_must_fail git merge-file \
-				-L "HEAD" \
-				-L "" \
-				-L "B^0" \
-				expect empty other &&
-			test_cmp expect y/wham~merged
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: The following untracked working tree files would be overwritten by merge" err &&
+
+		git ls-files -s >out &&
+		test_line_count = 6 out &&
+		git ls-files -u >out &&
+		test_line_count = 0 out &&
+		git ls-files -o >out &&
+		test_line_count = 3 out &&
 
 		echo important >expect &&
 		test_cmp expect y/wham
@@ -3596,7 +3426,7 @@ test_setup_10e () {
 	)
 }
 
-test_expect_merge_algorithm failure success '10e: Does git complain about untracked file that is not really in the way?' '
+test_expect_success '10e: Does git complain about untracked file that is not really in the way?' '
 	test_setup_10e &&
 	(
 		cd 10e &&
@@ -3687,30 +3517,8 @@ test_expect_success '11a: Avoid losing dirty contents with simple rename' '
 		echo stuff >>z/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: Your local changes to the following files would be overwritten by merge" err
-		else
-			test_grep "Refusing to lose dirty file at z/c" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 2 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			git rev-parse >actual \
-				:0:z/a :2:z/c &&
-			git rev-parse >expect \
-				 O:z/a  B:z/b &&
-			test_cmp expect actual &&
-
-			git hash-object z/c~HEAD >actual &&
-			git rev-parse B:z/b >expect &&
-			test_cmp expect actual
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
 		test_seq 1 10 >expected &&
 		echo stuff >>expected &&
@@ -3766,34 +3574,9 @@ test_expect_success '11b: Avoid losing dirty file involved in directory rename'
 		git checkout A^0 &&
 		echo stuff >>z/c &&
 
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: Your local changes to the following files would be overwritten by merge" err
-		else
-			git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-			test_grep "Refusing to lose dirty file at z/c" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 3 out &&
-			git ls-files -u >out &&
-			test_line_count = 0 out &&
-			git ls-files -m >out &&
-			test_line_count = 0 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			git rev-parse >actual \
-				:0:x/b :0:y/a :0:y/c &&
-			git rev-parse >expect \
-				 O:x/b  O:z/a  B:x/c &&
-			test_cmp expect actual &&
-
-			git hash-object y/c >actual &&
-			git rev-parse B:x/c >expect &&
-			test_cmp expect actual
-		fi &&
+		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
 		grep -q stuff z/c &&
 		test_seq 1 10 >expected &&
@@ -3850,13 +3633,8 @@ test_expect_success '11c: Avoid losing not-uptodate with rename + D/F conflict'
 		echo stuff >>y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: Your local changes to the following files would be overwritten by merge" err
-		else
-			test_grep "following files would be overwritten by merge" err
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
 		grep -q stuff y/c &&
 		test_seq 1 10 >expected &&
@@ -3924,30 +3702,8 @@ test_expect_success '11d: Avoid losing not-uptodate with rename + D/F conflict'
 		echo stuff >>z/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: Your local changes to the following files would be overwritten by merge" err
-		else
-			test_grep "Refusing to lose dirty file at z/c" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 1 out &&
-			git ls-files -o >out &&
-			test_line_count = 4 out &&
-
-			git rev-parse >actual \
-				:0:x/b :0:y/a :0:y/c/d :3:y/c &&
-			git rev-parse >expect \
-				 O:x/b  O:z/a  B:y/c/d  B:x/c &&
-			test_cmp expect actual &&
-
-			git hash-object y/c~HEAD >actual &&
-			git rev-parse B:x/c >expect &&
-			test_cmp expect actual
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
 		grep -q stuff z/c &&
 		test_seq 1 10 >expected &&
@@ -4010,39 +3766,8 @@ test_expect_success '11e: Avoid deleting not-uptodate with dir rename/rename(1to
 		echo mods >>y/c &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: Your local changes to the following files would be overwritten by merge" err
-		else
-			test_grep "CONFLICT (rename/rename)" out &&
-			test_grep "Refusing to lose dirty file at y/c" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 7 out &&
-			git ls-files -u >out &&
-			test_line_count = 4 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			git rev-parse >actual \
-				:0:y/a :0:y/b :0:x/d :1:x/c :2:w/c :2:y/c :3:y/c &&
-			git rev-parse >expect \
-				 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  A:y/c  O:x/c &&
-			test_cmp expect actual &&
-
-			# See if y/c~merged has expected contents; requires manually
-			# doing the expected file merge
-			git cat-file -p A:y/c >c1 &&
-			git cat-file -p B:z/c >c2 &&
-			>empty &&
-			test_must_fail git merge-file \
-				-L "HEAD" \
-				-L "" \
-				-L "B^0" \
-				c1 empty c2 &&
-			test_cmp c1 y/c~merged
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
 		echo different >expected &&
 		echo mods >>expected &&
@@ -4099,40 +3824,8 @@ test_expect_success '11f: Avoid deleting not-uptodate with dir rename/rename(2to
 		echo important >>y/wham &&
 
 		test_must_fail git -c merge.directoryRenames=true merge -s recursive B^0 >out 2>err &&
-		if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-		then
-			test_path_is_missing .git/MERGE_HEAD &&
-			test_grep "error: Your local changes to the following files would be overwritten by merge" err
-		else
-			test_grep "CONFLICT (rename/rename)" out &&
-			test_grep "Refusing to lose dirty file at y/wham" out &&
-
-			git ls-files -s >out &&
-			test_line_count = 4 out &&
-			git ls-files -u >out &&
-			test_line_count = 2 out &&
-			git ls-files -o >out &&
-			test_line_count = 3 out &&
-
-			test_must_fail git rev-parse :1:y/wham &&
-
-			git rev-parse >actual \
-				:0:y/a :0:y/b :2:y/wham :3:y/wham &&
-			git rev-parse >expect \
-				 O:z/a  O:z/b  O:x/c     O:x/d &&
-			test_cmp expect actual &&
-
-			# Test that two-way merge in y/wham~merged is as expected
-			git cat-file -p :2:y/wham >expect &&
-			git cat-file -p :3:y/wham >other &&
-			>empty &&
-			test_must_fail git merge-file \
-				-L "HEAD" \
-				-L "" \
-				-L "B^0" \
-				expect empty other &&
-			test_cmp expect y/wham~merged
-		fi &&
+		test_path_is_missing .git/MERGE_HEAD &&
+		test_grep "error: Your local changes to the following files would be overwritten by merge" err &&
 
 		test_seq 1 10 >expected &&
 		echo important >>expected &&
@@ -4267,7 +3960,7 @@ test_setup_12b1 () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12b1: Moving two directory hierarchies into each other' '
+test_expect_success '12b1: Moving two directory hierarchies into each other' '
 	test_setup_12b1 &&
 	(
 		cd 12b1 &&
@@ -4435,7 +4128,7 @@ test_setup_12c1 () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12c1: Moving one directory hierarchy into another w/ content merge' '
+test_expect_success '12c1: Moving one directory hierarchy into another w/ content merge' '
 	test_setup_12c1 &&
 	(
 		cd 12c1 &&
@@ -4797,7 +4490,7 @@ test_setup_12f () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12f: Trivial directory resolve, caching, all kinds of fun' '
+test_expect_success '12f: Trivial directory resolve, caching, all kinds of fun' '
 	test_setup_12f &&
 	(
 		cd 12f &&
@@ -5253,7 +4946,7 @@ test_setup_12l () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12l (B into A): Rename into each other + add/add conflict' '
+test_expect_success '12l (B into A): Rename into each other + add/add conflict' '
 	test_setup_12l BintoA &&
 	(
 		cd 12l_BintoA &&
@@ -5280,7 +4973,7 @@ test_expect_merge_algorithm failure success '12l (B into A): Rename into each ot
 	)
 '
 
-test_expect_merge_algorithm failure success '12l (A into B): Rename into each other + add/add conflict' '
+test_expect_success '12l (A into B): Rename into each other + add/add conflict' '
 	test_setup_12l AintoB &&
 	(
 		cd 12l_AintoB &&
@@ -5348,7 +5041,7 @@ test_setup_12m () {
 	)
 }
 
-test_expect_merge_algorithm failure success '12m: Change parent of renamed-dir to symlink on other side' '
+test_expect_success '12m: Change parent of renamed-dir to symlink on other side' '
 	test_setup_12m &&
 	(
 		cd 12m &&
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 084bfe7e6ce..ddc7524f6c1 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -296,10 +296,8 @@ test_expect_success 'with multiple strategies, recursive or ort failure do not e
 	git add a &&
 	git rev-parse :a >expect &&
 
-	sane_unset GIT_TEST_MERGE_ALGORITHM &&
-	test_must_fail git merge -s recursive -s ort -s octopus C^0 >output 2>&1 &&
+	test_must_fail git merge -s ort -s octopus C^0 >output 2>&1 &&
 
-	grep "Trying merge strategy recursive..." output &&
 	grep "Trying merge strategy ort..." output &&
 	grep "Trying merge strategy octopus..." output &&
 	grep "No merge strategy handled the merge." output &&
diff --git a/t/t6426-merge-skip-unneeded-updates.sh b/t/t6426-merge-skip-unneeded-updates.sh
index b059475ed03..404cd3f2ca1 100755
--- a/t/t6426-merge-skip-unneeded-updates.sh
+++ b/t/t6426-merge-skip-unneeded-updates.sh
@@ -23,8 +23,6 @@ test_description="merge cases"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
-
 
 ###########################################################################
 # SECTION 1: Cases involving no renames (one side has subset of changes of
@@ -663,7 +661,7 @@ test_setup_4a () {
 #   correct requires doing the merge in-memory first, then realizing that no
 #   updates to the file are necessary, and thus that we can just leave the path
 #   alone.
-test_expect_merge_algorithm failure success '4a: Change on A, change on B subset of A, dirty mods present' '
+test_expect_success '4a: Change on A, change on B subset of A, dirty mods present' '
 	test_setup_4a &&
 	(
 		cd 4a &&
diff --git a/t/t6428-merge-conflicts-sparse.sh b/t/t6428-merge-conflicts-sparse.sh
index 9919c3fa7cd..c86e02c6e23 100755
--- a/t/t6428-merge-conflicts-sparse.sh
+++ b/t/t6428-merge-conflicts-sparse.sh
@@ -23,8 +23,6 @@ test_description="merge cases"
 #                     files that might be renamed into each other's paths.)
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
-
 
 # Testcase basic, conflicting changes in 'numerals'
 
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index c539a68fd07..e59560a5dd9 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -6,7 +6,6 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
 
 test_expect_success 'setup 1' '
 
@@ -645,7 +644,7 @@ test_expect_success 'merge-recursive copy vs. rename' '
 	test_cmp expected actual
 '
 
-test_expect_merge_algorithm failure success 'merge-recursive rename vs. rename/symlink' '
+test_expect_success 'merge-recursive rename vs. rename/symlink' '
 
 	git checkout -f rename &&
 	git merge rename-ln &&
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index 4f4376421e7..70b5d2d6944 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -101,19 +101,10 @@ test_expect_success 'will not overwrite unstaged changes in renamed file' '
 	git mv c1.c other.c &&
 	git commit -m rename &&
 	cp important other.c &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		test_must_fail git merge c1a >out 2>err &&
-		test_grep "would be overwritten by merge" err &&
-		test_cmp important other.c &&
-		test_path_is_missing .git/MERGE_HEAD
-	else
-		test_must_fail git merge c1a >out &&
-		test_grep "Refusing to lose dirty file at other.c" out &&
-		test_path_is_file other.c~HEAD &&
-		test $(git hash-object other.c~HEAD) = $(git rev-parse c1a:c1.c) &&
-		test_cmp important other.c
-	fi
+	test_must_fail git merge c1a >out 2>err &&
+	test_grep "would be overwritten by merge" err &&
+	test_cmp important other.c &&
+	test_path_is_missing .git/MERGE_HEAD
 '
 
 test_expect_success 'will not overwrite untracked subtree' '
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 4815559157b..a564758f528 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -9,7 +9,6 @@ GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
 . ./test-lib.sh
-. "$TEST_DIRECTORY"/lib-merge.sh
 
 #
 # history
@@ -110,14 +109,10 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	test_when_finished "git -C merge-search reset --hard" &&
 	(cd merge-search &&
 	 git checkout -b test-nonforward-a b &&
-	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	  then
-		test_must_fail git merge c 2>actual &&
-		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-		grep "$sub_expect" actual
-	  else
-		test_must_fail git merge c 2> actual
-	  fi)
+	 test_must_fail git merge c 2>actual &&
+	 sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	 grep "$sub_expect" actual
+	 )
 '
 
 test_expect_success 'finish setup for merge-search' '
@@ -151,14 +146,9 @@ test_expect_success 'merging should conflict for non fast-forward (resolution ex
 	 git checkout -b test-nonforward-b b &&
 	 (cd sub &&
 	  git rev-parse --short sub-d > ../expect) &&
-	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	  then
-		test_must_fail git merge c >actual 2>sub-actual &&
-		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-		grep "$sub_expect" sub-actual
-	  else
-		test_must_fail git merge c 2> actual
-	  fi &&
+	  test_must_fail git merge c >actual 2>sub-actual &&
+	  sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	  grep "$sub_expect" sub-actual &&
 	 grep $(cat expect) actual > /dev/null &&
 	 git reset --hard)
 '
@@ -169,23 +159,12 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	(cd sub &&
 	 git checkout -b ambiguous sub-b &&
 	 git merge sub-c &&
-	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	 then
-		git rev-parse --short sub-d >../expect1 &&
-		git rev-parse --short ambiguous >../expect2
-	 else
-		git rev-parse sub-d > ../expect1 &&
-		git rev-parse ambiguous > ../expect2
-	 fi
+	 git rev-parse --short sub-d >../expect1 &&
+	 git rev-parse --short ambiguous >../expect2
 	 ) &&
-	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	 then
-		test_must_fail git merge c >actual 2>sub-actual &&
-		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
-		grep "$sub_expect" sub-actual
-	 else
-		test_must_fail git merge c 2> actual
-	 fi &&
+	test_must_fail git merge c >actual 2>sub-actual &&
+	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-c)" &&
+	grep "$sub_expect" sub-actual &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
 	git reset --hard)
@@ -227,11 +206,9 @@ test_expect_success 'merging should fail for changes that are backwards' '
 
 	git checkout -b test-backward e &&
 	test_must_fail git merge f 2>actual &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-    then
-		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
-		grep "$sub_expect" actual
-	fi)
+	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short sub-d)" &&
+	grep "$sub_expect" actual
+	)
 '
 
 
@@ -358,7 +335,7 @@ test_expect_success 'setup file/submodule conflict' '
 	)
 '
 
-test_expect_merge_algorithm failure success 'file/submodule conflict' '
+test_expect_success 'file/submodule conflict' '
 	test_when_finished "git -C file-submodule reset --hard" &&
 	(
 		cd file-submodule &&
@@ -467,7 +444,7 @@ test_expect_failure 'directory/submodule conflict; keep submodule clean' '
 	)
 '
 
-test_expect_merge_algorithm failure success !FAIL_PREREQS 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
+test_expect_success !FAIL_PREREQS 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
 	test_when_finished "git -C directory-submodule/path reset --hard" &&
 	test_when_finished "git -C directory-submodule reset --hard" &&
 	(
@@ -535,11 +512,9 @@ test_expect_success 'merging should fail with no merge base' '
 	git add sub &&
 	git commit -m "b" &&
 	test_must_fail git merge a 2>actual &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-    then
-		sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short HEAD^1)" &&
-		grep "$sub_expect" actual
-	fi)
+	sub_expect="go to submodule (sub), and either merge commit $(git -C sub rev-parse --short HEAD^1)" &&
+	grep "$sub_expect" actual
+	)
 '
 
 test_done
diff --git a/t/t6438-submodule-directory-file-conflicts.sh b/t/t6438-submodule-directory-file-conflicts.sh
index 8df67a0ef99..53d83c828a7 100755
--- a/t/t6438-submodule-directory-file-conflicts.sh
+++ b/t/t6438-submodule-directory-file-conflicts.sh
@@ -12,11 +12,6 @@ test_submodule_switch "merge --ff"
 
 test_submodule_switch "merge --ff-only"
 
-if test "$GIT_TEST_MERGE_ALGORITHM" != ort
-then
-	KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
-	KNOWN_FAILURE_NOFF_MERGE_ATTEMPTS_TO_MERGE_REMOVED_SUBMODULE_FILES=1
-fi
 test_submodule_switch "merge --no-ff"
 
 test_done
diff --git a/t/t6439-merge-co-error-msgs.sh b/t/t6439-merge-co-error-msgs.sh
index 55bd744a3f4..643c9368e0e 100755
--- a/t/t6439-merge-co-error-msgs.sh
+++ b/t/t6439-merge-co-error-msgs.sh
@@ -47,7 +47,7 @@ test_expect_success 'untracked files overwritten by merge (fast and non-fast for
 		export GIT_MERGE_VERBOSITY &&
 		test_must_fail git merge branch 2>out2
 	) &&
-	echo "Merge with strategy ${GIT_TEST_MERGE_ALGORITHM:-ort} failed." >>expect &&
+	echo "Merge with strategy ort failed." >>expect &&
 	test_cmp out2 expect &&
 	git reset --hard HEAD^
 '
diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
index 25b33a1e875..06cee3432fe 100755
--- a/t/t7402-submodule-rebase.sh
+++ b/t/t7402-submodule-rebase.sh
@@ -124,11 +124,8 @@ test_expect_success 'rebasing submodule that should conflict' '
 		echo "160000 $(git rev-parse HEAD) 3	submodule"
 	) >expect &&
 	test_cmp expect actual &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-    then
-		sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
-		grep "$sub_expect" actual_output
-	fi
+	sub_expect="go to submodule (submodule), and either merge commit $(git -C submodule rev-parse --short HEAD^0)" &&
+	grep "$sub_expect" actual_output
 '
 
 test_done
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index ff085b086cc..42f675b7399 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -77,12 +77,9 @@ Merge made by the 'recursive' strategy.
 EOF
 
 test_expect_success 'merge reduces irrelevant remote heads' '
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		mv expected expected.tmp &&
-		sed s/recursive/ort/ expected.tmp >expected &&
-		rm expected.tmp
-	fi &&
+	mv expected expected.tmp &&
+	sed s/recursive/ort/ expected.tmp >expected &&
+	rm expected.tmp &&
 	GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
 	test_cmp expected actual
 '
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index c077aba7ced..957f8e20ba3 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -535,14 +535,9 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		yes "c" | git mergetool submod~HEAD &&
-		git rm submod &&
-		git mv submod~HEAD submod
-	else
-		yes "l" | git mergetool submod
-	fi &&
+	yes "c" | git mergetool submod~HEAD &&
+	git rm submod &&
+	git mv submod~HEAD submod &&
 	git submodule update -N &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod &&
@@ -559,15 +554,10 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool file1 file2 spaced\ name subdir/file3 &&
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		mv submod submod.orig &&
-		git rm --cached submod &&
-		yes "c" | git mergetool submod~test19 &&
-		git mv submod~test19 submod
-	else
-		yes "r" | git mergetool submod
-	fi &&
+	mv submod submod.orig &&
+	git rm --cached submod &&
+	yes "c" | git mergetool submod~test19 &&
+	git mv submod~test19 submod &&
 	test -d submod.orig &&
 	git submodule update -N &&
 	echo "not a submodule" >expect &&
@@ -585,10 +575,7 @@ test_expect_success 'file vs modified submodule' '
 	yes "" | git mergetool both &&
 	yes "d" | git mergetool file11 file12 &&
 	yes "l" | git mergetool submod &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		yes "d" | git mergetool submod~test19
-	fi &&
+	yes "d" | git mergetool submod~test19 &&
 	echo "main submodule" >expect &&
 	test_cmp expect submod/bar &&
 	git submodule update -N &&
@@ -686,14 +673,9 @@ test_expect_success 'directory vs modified submodule' '
 	test_must_fail git merge main &&
 	test -n "$(git ls-files -u)" &&
 	test ! -e submod.orig &&
-	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
-	then
-		yes "r" | git mergetool submod~main &&
-		git mv submod submod.orig &&
-		git mv submod~main submod
-	else
-		yes "r" | git mergetool submod
-	fi &&
+	yes "r" | git mergetool submod~main &&
+	git mv submod submod.orig &&
+	git mv submod~main submod &&
 	test -d submod.orig &&
 	echo "not a submodule" >expect &&
 	test_cmp expect submod.orig/file16 &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9001ed3a647..5952eb56e27 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -544,8 +544,6 @@ GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
 export GIT_DEFAULT_REF_FORMAT
-GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
-export GIT_TEST_MERGE_ALGORITHM
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output
 GIT_TRACE_BARE=1
-- 
gitgitgadget

