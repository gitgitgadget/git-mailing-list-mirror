Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8D4C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 17:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiADRhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 12:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiADRhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 12:37:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69161C061799
        for <git@vger.kernel.org>; Tue,  4 Jan 2022 09:37:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t26so77637068wrb.4
        for <git@vger.kernel.org>; Tue, 04 Jan 2022 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PAqOT23epdiguINfFEHggxfPg7Qga4S5NUH6UrpRNnM=;
        b=i6zZxRTQHhBw0QmE7hiol7XbUdUonnX3xbl2Qpukm3kyTJr2H01wPySGLWR2DbuvJs
         PsBU0VgWObSPEPTypoo9tcogFQ7I6+pHMKCpdiUXmOd1R5rmkhHLXQuqebdotaCVkk7g
         HWKvqqoTDoSv8BDBj+g2Wzy7wp+0wHCqZb5d4p9GEfTe1kguAv61PJY1L6M8fenr7kok
         sMw7BRdk9OllfHwYts5OIU0w0MERhGqJLSKBa3sgA1uNHeJpC7GWdWnCh3ZX/RrQdNWB
         p8fd6YCv2jlnTyAMqA3Mp8qUHJxQT/sOadPEPTy6Mnjg8sTzrK3dcThjU9mwjgHtCt4E
         CrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PAqOT23epdiguINfFEHggxfPg7Qga4S5NUH6UrpRNnM=;
        b=cuDaUPvwlH0ghkotVGLoNqb5K0W8joxRCWinc4izN7X6CT3ltbVyYdsT1C5Ubl5snA
         i4GLiGavog37h9M3JD4hph22aig2jw+RLTgUyRxiDiGkVk82MI+8thlNOFs4mUwtoGc5
         j3dhbP/nmIdorsbZtW8b9vbcd1sP0i7gV5o9QSGKKSgfy/Sk4R5miaMobaiAXTo4Y+wN
         jZVVXAcdvXXe+J8wqXXpMI3/3jqqiGWsnpxR3PvMakxKfFHnSXBtFZcyvabmWKAhTmQr
         C615l+BW74JaJuNm8kQVnjmv5RYjI6gDdiR3ZnyAKX89dqAzHUDwP2Eo0370jFly0abr
         djBw==
X-Gm-Message-State: AOAM530u1eswKNvDJHpJuFDYnrjPJI69V8DyT+jAIK7ILPb/SDgxJDcd
        YfBysztNowJIUdG6NABrvGxOnHstQZE=
X-Google-Smtp-Source: ABdhPJw9SYO/Oyp1KeXfFxp7RTu9gyF0GM2lHt/ixc02EBGTKpFp3BuWBzb5p8GAsWq+ya+2ggkcxQ==
X-Received: by 2002:a5d:47c2:: with SMTP id o2mr43119852wrc.416.1641317826847;
        Tue, 04 Jan 2022 09:37:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm15395wmg.27.2022.01.04.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 09:37:06 -0800 (PST)
Message-Id: <3b734f89c0f2f473d71a5d3c85faec6d48a0e350.1641317820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Jan 2022 17:36:58 +0000
Subject: [PATCH 7/9] update-index: add tests for sparse-checkout compatibility
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Introduce tests for a variety of `git update-index` use cases, including
performance scenarios. Tests for `update-index add/remove` are specifically
focused on how `git stash` uses `git update-index` as a subcommand to
prepare for sparse index integration with `stash` in a future series.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh | 125 +++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 54f8602f3c1..7dbed330160 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -118,5 +118,6 @@ test_perf_on_all git diff --cached
 test_perf_on_all git blame $SPARSE_CONE/a
 test_perf_on_all git blame $SPARSE_CONE/f3/a
 test_perf_on_all git checkout-index -f --all
+test_perf_on_all git update-index --add --remove
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 6ecf1f2bf8e..6804ab23a27 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -630,6 +630,131 @@ test_expect_success 'reset with wildcard pathspec' '
 	test_all_match git ls-files -s -- folder1
 '
 
+test_expect_success 'update-index modify outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Create & modify folder1/a
+	run_on_sparse mkdir -p folder1 &&
+	run_on_sparse cp ../initial-repo/folder1/a folder1/a &&
+	run_on_all ../edit-contents folder1/a &&
+
+	# If file has skip-worktree enabled, update-index does not modify the
+	# index entry
+	test_sparse_match git update-index folder1/a &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_must_be_empty sparse-checkout-out &&
+
+	# When skip-worktree is disabled (even on files outside sparse cone), file
+	# is updated in the index
+	test_sparse_match git update-index --no-skip-worktree folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git update-index folder1/a &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'update-index --add outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Create folder1, add new file
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/b &&
+
+	# Similar to `git add`, the untracked out-of-cone file is added to the index
+	# identically across sparse and non-sparse checkouts
+	test_all_match git update-index --add folder1/b &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'update-index --remove outside sparse definition' '
+	init_repos &&
+
+	# When `--ignore-skip-worktree-entries` is specified, out-of-cone files are
+	# not removed from the index if they do not exist on disk
+	test_sparse_match git update-index --remove --ignore-skip-worktree-entries folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# When the flag is _not_ specified, out-of-cone, not-on-disk files are
+	# removed from the index
+	rm full-checkout/folder1/a &&
+	test_all_match git update-index --remove folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# NOTE: --force-remove supercedes --ignore-skip-worktree-entries, removing
+	# a skip-worktree file from the index (and disk) when both are specified
+	test_all_match git update-index --force-remove --ignore-skip-worktree-entries folder1/a &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'update-index with directories' '
+	init_repos &&
+
+	# update-index will exit silently when provided with a directory name
+	# containing a trailing slash
+	test_all_match git update-index deep/ folder1/ &&
+	grep "Ignoring path deep/" sparse-checkout-err &&
+	grep "Ignoring path folder1/" sparse-checkout-err &&
+
+	# When update-index is given a directory name WITHOUT a trailing slash, it will
+	# behave in different ways depending on the status of the directory on disk:
+	# * if it exists, the command exits with an error ("add individual files instead")
+	# * if it does NOT exist (e.g., in a sparse-checkout), it is assumed to be a
+	#   file and either triggers an error ("does not exist  and --remove not passed")
+	#   or is ignored completely (when using --remove)
+	test_all_match test_must_fail git update-index deep &&
+	run_on_all test_must_fail git update-indexe folder1 &&
+	test_must_fail git -C full-checkout update-index --remove folder1 &&
+	test_sparse_match git update-index --remove folder1 &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'update-index --again file outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b test-reupdate &&
+
+	# Update HEAD without modifying the index to introduce a difference in
+	# folder1/a
+	test_sparse_match git reset --soft update-folder1 &&
+
+	# Because folder1/a differs in the index vs HEAD,
+	# `git update-index --remove --again` will effectively perform
+	# `git update-index --remove folder1/a` and remove the folder1/a
+	test_sparse_match git update-index --remove --again &&
+	test_sparse_match git status --porcelain=v2
+'
+
+test_expect_success 'update-index --cacheinfo' '
+	init_repos &&
+
+	deep_a_oid=$(git -C full-checkout rev-parse update-deep:deep/a) &&
+	folder2_oid=$(git -C full-checkout rev-parse update-folder2:folder2) &&
+	folder1_a_oid=$(git -C full-checkout rev-parse update-folder1:folder1/a) &&
+
+	test_all_match git update-index --cacheinfo 100644 $deep_a_oid deep/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Cannot add sparse directory, even in sparse index case
+	test_all_match test_must_fail git update-index --add --cacheinfo 040000 $folder2_oid folder2/ &&
+
+	# Sparse match only - because folder1/a is outside the sparse checkout
+	# definition (and thus not on-disk), it will appear "deleted" in
+	# unstaged changes.
+	test_all_match git update-index --add --cacheinfo 100644 $folder1_a_oid folder1/a &&
+	test_sparse_match git status --porcelain=v2
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

