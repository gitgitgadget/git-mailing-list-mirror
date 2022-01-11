Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5FEC4332F
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 18:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiAKSHC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 13:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345679AbiAKSGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 13:06:01 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB01C034003
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k18so34459065wrg.11
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 10:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aK3NuUCpaTu71utxcsxgza1gVP3L5JeprbAJ5CLzEws=;
        b=iGk5ntCP1SQUR9h5NLzSdHrmsCieE9S2sVNE74acepA9X+fC4tHq9i5vj6GzNnpq34
         QI424hnSPJ/Ad52FWNepbCcA8/hXzvc+Kqm192YYoZb15NXXReSaNTxooViJq+eqURpg
         EfE4vB87A05wSWvnsohxCHv44W59mAA2cz+NUQfgdCMMCN2dZRdLxnVL1eW+/J0JXfl0
         kQxNTvxs0E8qlKI5XEvdqXhUaMZrX3ZcqU6P0ts/h0bQ96uhzh/RRtA9aFCSUTCNt/8u
         z4oZbPdVJqNDl+RS2XT/mTke1y3XnrJXJtxhz3m4wY7AKOU990NWKgWxEHHvu+F5cQ+k
         WqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aK3NuUCpaTu71utxcsxgza1gVP3L5JeprbAJ5CLzEws=;
        b=PlVxSg5hk8JXN+e2XkvTuBza1C7Y3r3m3fpHg+W5z0QD1iOeyk2lBv3Ml3yecBE8yP
         gvkOGilRSyl+6VHsx59rvDerlLlJ/vL2MTwhswh5b2RJFlzPvjJHSj02oGcCT2wzG9KC
         5dK91Hgu+muTfAUlfHacwi2pTgjEB7vjkUKC2yUzrm8h1rTCAPkvXSZAh1IR+e2iU1Ia
         desJ2FIvsZqHKWVnOPOHrmHd3xu9KYEQh6CFS0NQG5Ix4tHro1WW9iTt5hDHo6nwwh8/
         hcbHMzL8fCI4D9XsTXPwxUJ8x2RWqWe8NfmKSHXqf+fYqQSoOIDMMMAbOT6OULAdMpZF
         /74g==
X-Gm-Message-State: AOAM530+AIAnuBfP/yMLCpRqealFLAWo4AJq8TIPS6DWOyt6g3MKnZxx
        3QDqLKXEX3kUmFd/eZLtUSl4HGa1HWY=
X-Google-Smtp-Source: ABdhPJwXpMw+sez1Hd/dqTuLa7kVmyXanFHU63isEluFaTtX7S4POBinuGZWELXetXGabRdNMNpmTQ==
X-Received: by 2002:adf:ee0e:: with SMTP id y14mr107656wrn.172.1641924315353;
        Tue, 11 Jan 2022 10:05:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm13268725wrz.63.2022.01.11.10.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:05:14 -0800 (PST)
Message-Id: <ff32952a21c5005552a2892c4ac1a581f4fd0bb2.1641924306.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
        <pull.1109.v2.git.1641924306.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 18:05:04 +0000
Subject: [PATCH v2 7/9] update-index: add tests for sparse-checkout
 compatibility
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
performance scenarios. Tests are intended to exercise `update-index` with
options that change the commands interaction with the index (e.g.,
`--again`) and with files/directories inside and outside a sparse checkout
cone.

Of note is that these tests clearly establish the behavior of `git
update-index --add` with untracked, outside-of-cone files. Unlike `git add`,
which fails with an error when provided with such files, `update-index`
succeeds in adding them to the index. Additionally, the `skip-worktree` flag
is *not* automatically added to the new entry. Although this is pre-existing
behavior, there are a couple of reasons to avoid changing it in favor of
consistency with e.g. `git add`:

* `update-index` is low-level command for modifying the index; while it can
  perform operations similar to those of `add`, it traditionally has fewer
  "guardrails" preventing a user from doing something they may not want to
  do (in this case, adding an outside-of-cone, non-`skip-worktree` file to
  the index)
* `update-index` typically only exits with an error code if it is incapable
  of performing an operation (e.g., if an internal function call fails);
  adding a new file outside the sparse checkout definition is still a valid
  operation, albeit an inadvisable one
* `update-index` does not implicitly set flags (e.g., `skip-worktree`) when
  creating new index entries with `--add`; if flags need to be updated,
  options like `--[no-]skip-worktree` allow a user to intentionally set them

All this to say that, while there are valid reasons to consider changing the
treatment of outside-of-cone files in `update-index`, there are also
sufficient reasons for leaving it as-is.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |   1 +
 t/t1092-sparse-checkout-compatibility.sh | 167 +++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 54f8602f3c1..2a7106b9495 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -118,5 +118,6 @@ test_perf_on_all git diff --cached
 test_perf_on_all git blame $SPARSE_CONE/a
 test_perf_on_all git blame $SPARSE_CONE/f3/a
 test_perf_on_all git checkout-index -f --all
+test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c72c854d84..91f849f541e 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -630,6 +630,173 @@ test_expect_success 'reset with wildcard pathspec' '
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
+	# Note that this setup is a manual way of reaching the erroneous
+	# condition in which a `skip-worktree` enabled, outside-of-cone file
+	# exists on disk. It is used here to ensure `update-index` is stable
+	# and behaves predictably if such a condition occurs.
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
+	# The *untracked* out-of-cone file is added to the index because it does
+	# not have a `skip-worktree` bit to signal that it should be ignored
+	# (unlike in `git add`, which will fail due to the file being outside
+	# the sparse checkout definition).
+	test_all_match git update-index --add folder1/b &&
+	test_all_match git status --porcelain=v2
+'
+
+# NEEDSWORK: `--remove`, unlike the rest of `update-index`, does not ignore
+# `skip-worktree` entries by default and will remove them from the index.
+# The `--ignore-skip-worktree-entries` flag must be used in conjunction with
+# `--remove` to ignore the `skip-worktree` entries and prevent their removal
+# from the index.
+test_expect_success 'update-index --remove outside sparse definition' '
+	init_repos &&
+
+	# When --ignore-skip-worktree-entries is _not_ specified:
+	# out-of-cone, not-on-disk files are removed from the index
+	test_sparse_match git update-index --remove folder1/a &&
+	cat >expect <<-EOF &&
+	D	folder1/a
+	EOF
+	test_sparse_match git diff --cached --name-status &&
+	test_cmp expect sparse-checkout-out &&
+
+	# Reset the state
+	test_all_match git reset --hard &&
+
+	# When --ignore-skip-worktree-entries is specified, out-of-cone
+	# (skip-worktree) files are ignored
+	test_sparse_match git update-index --remove --ignore-skip-worktree-entries folder1/a &&
+	test_sparse_match git diff --cached --name-status &&
+	test_must_be_empty sparse-checkout-out &&
+
+	# Reset the state
+	test_all_match git reset --hard &&
+
+	# --force-remove supercedes --ignore-skip-worktree-entries, removing
+	# a skip-worktree file from the index (and disk) when both are specified
+	# with --remove
+	test_sparse_match git update-index --force-remove --ignore-skip-worktree-entries folder1/a &&
+	cat >expect <<-EOF &&
+	D	folder1/a
+	EOF
+	test_sparse_match git diff --cached --name-status &&
+	test_cmp expect sparse-checkout-out
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
+	run_on_all test_must_fail git update-index folder1 &&
+	test_must_fail git -C full-checkout update-index --remove folder1 &&
+	test_sparse_match git update-index --remove folder1 &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'update-index --again file outside sparse definition' '
+	init_repos &&
+
+	test_all_match git checkout -b test-reupdate &&
+
+	# Update HEAD without modifying the index to introduce a difference in
+	# folder1/a
+	test_sparse_match git reset --soft update-folder1 &&
+
+	# Because folder1/a differs in the index vs HEAD,
+	# `git update-index --no-skip-worktree --again` will effectively perform
+	# `git update-index --no-skip-worktree folder1/a` and remove the skip-worktree
+	# flag from folder1/a
+	test_sparse_match git update-index --no-skip-worktree --again &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	cat >expect <<-EOF &&
+	D	folder1/a
+	EOF
+	test_sparse_match git diff --name-status &&
+	test_cmp expect sparse-checkout-out
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
+	# Sparse match only: the new outside-of-cone entry is added *without* skip-worktree,
+	# so `git status` reports it as "deleted" in the worktree
+	test_sparse_match git update-index --add --cacheinfo 100644 $folder1_a_oid folder1/a &&
+	test_sparse_match git status --porcelain=v2 &&
+	cat >expect <<-EOF &&
+	MD folder1/a
+	EOF
+	test_sparse_match git status --short -- folder1/a &&
+	test_cmp expect sparse-checkout-out &&
+
+	# To return folder1/a to "normal" for a sparse checkout (ignored &
+	# outside-of-cone), add the skip-worktree flag.
+	test_sparse_match git update-index --skip-worktree folder1/a &&
+	cat >expect <<-EOF &&
+	S folder1/a
+	EOF
+	test_sparse_match git ls-files -t -- folder1/a &&
+	test_cmp expect sparse-checkout-out
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

