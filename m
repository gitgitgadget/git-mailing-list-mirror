Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3328389
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342615; cv=none; b=TiRQSheV8UkgrlODSv14UzZ356gV9eYTFZcpGO+cdhwsEIocGxf9sBKUuRCUBGFzzXdzWPmm+gGN1M5jHUfdWXA6/Cxgo5z0wsE+JinX1V5J11Jc/PHAoMkcWnO6ybm1mruzz6mCjRhCD6fJrNXx1EEM+fCF0kwWzjw18xEb9kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342615; c=relaxed/simple;
	bh=cSDMJY3bzviqbxcR6MgXxOBADvrVZ1ohC5opVWpuToE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RV4hgzB+iwwQ6b2QArE0nbeeZOnGOl0zgGi4yfYhvnbUYqU7efiCKETg0zyX6rktL1xCubc8FS7GUURZBC3tIA6oGZCoIJCfgsaNM8pr6F7Qkg2i5YxFLJvmMeZmZ3fZssDTaI6gaHqDD7Vz3hYE6hp4NryDPc97hn1Tcutepb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hplm3jJx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hplm3jJx"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a868831216cso134525366b.3
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724342611; x=1724947411; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAubRDNNCAduZE9CcvD8RrYiBGd8MwcUwN2HHhgmLJA=;
        b=Hplm3jJxTUInA8u7BYSfZ5vO+WDGey/c3qlLr4b62NPGVmZNwQW2nP4i/OJUbAp3yB
         RnMuyOJ5LLrsrhm9dXp25EsLZB5cUgjDv2P8RSPnHvhizq3hLYI4LmtRNzzB2aiqzKfG
         luO9RsJ4S/Ghl7+KeixsPQFywmeyfjWiWlfYR1XAG+f3D/xQPRo0Ede38oxPAXUQREu6
         lHzjNF0ur/EP2egjftBjqMWOHC4NSOPy4tMlWMGRBXZ/9TFRJVX/X8LbU1lZFoAneWgz
         QnPF6O6FpSo+vT0brz/pmS5w5TuZUU2UVE3Bu9aPZx7vE2d7sDR86FAZwmzrJX6Mv/cv
         OWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724342611; x=1724947411;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAubRDNNCAduZE9CcvD8RrYiBGd8MwcUwN2HHhgmLJA=;
        b=uRpiU3QDFGNhCudepZm4/oZMvDK4TMGhAHjndXp6WQU9/nGin1+7yChie/GMI865RX
         9Zo1c56q9S5qlz0jZM5rwnVeneA5KmMsa4hzCnK8MgyFdhOsoWrP1AU+NJnQT0N0dSEq
         EDxHXwyR4SC7K9WCNAfhM4EYgVgUHgWWMG/mm5i29fYm/P4s9DzJs/uBVmMOea7W6pdK
         j8Rgb1xDtzVZeF9p0vyYSVFfMc5JCyDx9jix3UmbVxlKQhGlJCaua80xN1XVi7E/e+l5
         GjyVKyU/sHOozk5tOZX8dwezLqFD8nF1FnFeVfzYK0YZAjBiGJ3J9LOfq4/cjz4bgRaE
         U1ng==
X-Gm-Message-State: AOJu0YytPgECJxLcFCBRnEoc6VpSUjBvy7qUAO2es/cSzj+Pa9k4w+JS
	DKK/WpbQ5jYwZg4mEN0vkTRQAwIAPxX0Sy/MxqkORyyIBUG3gEhhAcNyoQ==
X-Google-Smtp-Source: AGHT+IHKjxFNmBLt1MWV4SfdmGRwQMUIJgtrHj8Wm0b4hT7pOmVmBSU8jsM85gVmEBqMgpE2plZXeg==
X-Received: by 2002:a17:906:7313:b0:a86:743a:a716 with SMTP id a640c23a62f3a-a86743aa903mr423890066b.53.1724342609017;
        Thu, 22 Aug 2024 09:03:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2e768esm138891566b.93.2024.08.22.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:03:28 -0700 (PDT)
Message-Id: <pull.1777.git.1724342607793.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Aug 2024 16:03:27 +0000
Subject: [PATCH] diff-index: integrate with the sparse index
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The sparse index allows focusing the index data structure on the files
present in the sparse-checkout, leaving only tree entries for
directories not within the sparse-checkout. Each builtin needs a
repository setting to indicate that it has been tested with the sparse
index before Git will allow the index to be loaded into memory in its
sparse form. This is a safety precaution.

There are still some builtins that haven't been integrated due to the
complexity of the integration and the lack of significant use. However,
'git diff-index' was neglected only because of initial data showing low
usage. The diff machinery was already integrated and there is no more
work to be done there but add some tests to be sure 'git diff-index'
behaves as expected.

For this purpose, we can follow the testing pattern used in 51ba65b5c35
(diff: enable and test the sparse index, 2021-12-06). One difference
here is that we only verify that the sparse index case agrees with the
full index case, but do not generate the expected output. The 'git diff'
tests use the '--name-status' option to ease the creation of the
expected output, but that's not an option for 'diff-index'. Since the
underlying diff machinery is the same, a simple comparison is sufficient
to give some coverage.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    diff-index: integrate with the sparse index
    
    This integration is motivated by an internal GUI tool using the 'git
    diff-index' builtin. It is hitting the index expansion during every
    execution, contributing significant performance issues. This was missed
    in previous estimates of Git builtin usages because the numbers changed
    as users started using this tool.
    
    Thanks, - Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1777%2Fderrickstolee%2Fdiff-index-sparse-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1777/derrickstolee/diff-index-sparse-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1777

 builtin/diff-index.c                     |  4 ++++
 t/t1092-sparse-checkout-compatibility.sh | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 3e05260ac0e..685b60284fd 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -25,6 +25,10 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		usage(diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
+
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
 	repo_init_revisions(the_repository, &rev, prefix);
 	rev.abbrev = 0;
 	prefix = precompose_argv_prefix(argc, argv, prefix);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a2c0e1b4dcc..6fa7f5e9587 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -803,6 +803,8 @@ test_expect_success 'update-index --remove outside sparse definition' '
 	test_sparse_match git diff --cached --name-status &&
 	test_cmp expect sparse-checkout-out &&
 
+	test_sparse_match git diff-index --cached HEAD &&
+
 	# Reset the state
 	test_all_match git reset --hard &&
 
@@ -812,6 +814,8 @@ test_expect_success 'update-index --remove outside sparse definition' '
 	test_sparse_match git diff --cached --name-status &&
 	test_must_be_empty sparse-checkout-out &&
 
+	test_sparse_match git diff-index --cached HEAD &&
+
 	# Reset the state
 	test_all_match git reset --hard &&
 
@@ -823,7 +827,9 @@ test_expect_success 'update-index --remove outside sparse definition' '
 	D	folder1/a
 	EOF
 	test_sparse_match git diff --cached --name-status &&
-	test_cmp expect sparse-checkout-out
+	test_cmp expect sparse-checkout-out &&
+
+	test_sparse_match git diff-index --cached HEAD
 '
 
 test_expect_success 'update-index with directories' '
@@ -1551,7 +1557,7 @@ test_expect_success 'sparse-index is not expanded: describe' '
 	ensure_not_expanded describe
 '
 
-test_expect_success 'sparse index is not expanded: diff' '
+test_expect_success 'sparse index is not expanded: diff and diff-index' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
@@ -1568,6 +1574,7 @@ test_expect_success 'sparse index is not expanded: diff' '
 	test_all_match git diff --cached &&
 	ensure_not_expanded diff &&
 	ensure_not_expanded diff --cached &&
+	ensure_not_expanded diff-index --cached HEAD &&
 
 	# Add file outside cone
 	test_all_match git reset --hard &&
@@ -1582,6 +1589,7 @@ test_expect_success 'sparse index is not expanded: diff' '
 	test_all_match git diff --cached &&
 	ensure_not_expanded diff &&
 	ensure_not_expanded diff --cached &&
+	ensure_not_expanded diff-index --cached HEAD &&
 
 	# Merge conflict outside cone
 	# The sparse checkout will report a warning that is not in the
@@ -1594,7 +1602,8 @@ test_expect_success 'sparse index is not expanded: diff' '
 	test_all_match git diff &&
 	test_all_match git diff --cached &&
 	ensure_not_expanded diff &&
-	ensure_not_expanded diff --cached
+	ensure_not_expanded diff --cached &&
+	ensure_not_expanded diff-index --cached HEAD
 '
 
 test_expect_success 'sparse index is not expanded: show and rev-parse' '

base-commit: 80ccd8a2602820fdf896a8e8894305225f86f61d
-- 
gitgitgadget
