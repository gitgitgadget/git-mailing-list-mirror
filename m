Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FF1C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhKVWpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhKVWps (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:45:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC3AC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a9so35444928wrr.8
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6og7Pmp+4dsroDk5inawXvbpcOlISGcVuuPGVVXY394=;
        b=TuYIi54UXRJN59ni1oRsWzHrdq2UDCuMf8MbGUChOgnhU7zjC5pMqcGzMkRlmV82xG
         YJUvBEHfWVEIS/bEPGt3U5dRLr8Cvpn+HIRBRY6zv1N+bKDtwgef4dTEd3DEAL+SQAxv
         qE+7rwe5zNeTdeI5MrTsvZT3wf6DoqdmkJ/X4eBB4nR0TkE9KhXjOWYZ8s0oxLXsM5TZ
         7QCzk0JKMB6pSUBI24LrvnC+2w4Yhq9VK7zFtIZGa1yVWBdnPgz9vE4FJIkCA2b1ov6h
         qGHugXKLOg5HoHkUcZPyfQa8mXvAlHrBf1O2mMHaR5tLXXKOVX68QwPIQIAD+R60ST9D
         zUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6og7Pmp+4dsroDk5inawXvbpcOlISGcVuuPGVVXY394=;
        b=EAxTsuee2vhg980QbHMD7Wj9p4GpAALl2+qWrZEkDYff0uSp3InC6f3SuUv9iSceag
         A6dnJxQSfjFNWdSOszzSBv8XlnMRI3wBnok+rbrMMcYyPZDlHayB57TU4vTCJswkTTQ/
         cf6k/LnNHfFDvo+kRVhJok2EaFoirHiw06LLaBuZCWY2J0z95UofpR/IyTFMxbETxji8
         U+xpUyHSrMTIF7dkOxl8pCGE3cffH9mBHk5JZxXA17KVHnRzVI8/HxF4qhfcmIhMQ2Yz
         Pp7GgzddAoramszirxThh13lzU+zNd3Ej7iNjtQ4WZOxdMVmzsnLcM9YbO6Ytq2NFSmP
         TDGA==
X-Gm-Message-State: AOAM533xLuXH8LSnkvP9m0HyCgSgB1s6qmuz8YnxJb4gNSrHRN5yvamv
        QpJ9ufiyhINfB4hVUe0U3TKLFj3JSMQ=
X-Google-Smtp-Source: ABdhPJxxBBd1Xm+ZUmuyw0/Eu4B3MTmYX6/qM+yZiPq/NX5/LuTOv3GHGsxmcHgVof5U0L5wXb73BA==
X-Received: by 2002:a5d:6d84:: with SMTP id l4mr1137028wrs.266.1637620959964;
        Mon, 22 Nov 2021 14:42:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm10301609wrt.36.2021.11.22.14.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:42:39 -0800 (PST)
Message-Id: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 22:42:34 +0000
Subject: [PATCH v4 0/4] Sparse Index: diff and blame builtins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on vd/sparse-reset. It integrates the sparse index with
git diff and git blame and includes:

 1. tests added to t1092 and p2000 to establish the baseline functionality
    of the commands
 2. repository settings to enable the sparse index

The p2000 tests demonstrate a ~44% execution time reduction for 'git diff'
and a ~86% execution time reduction for 'git diff --staged' using a sparse
index. For 'git blame', the reduction time was ~60% for a file two levels
deep and ~30% for a file three levels deep.

Test                                         before  after
----------------------------------------------------------------
2000.30: git diff (full-v3)                  0.33    0.34 +3.0%
2000.31: git diff (full-v4)                  0.33    0.35 +6.1%
2000.32: git diff (sparse-v3)                0.53    0.31 -41.5%
2000.33: git diff (sparse-v4)                0.54    0.29 -46.3%
2000.34: git diff --cached (full-v3)         0.07    0.07 +0.0%
2000.35: git diff --cached (full-v4)         0.07    0.08 +14.3%
2000.36: git diff --cached (sparse-v3)       0.28    0.04 -85.7%
2000.37: git diff --cached (sparse-v4)       0.23    0.03 -87.0%
2000.62: git blame f2/f4/a (full-v3)         0.31    0.32 +3.2%
2000.63: git blame f2/f4/a (full-v4)         0.29    0.31 +6.9%
2000.64: git blame f2/f4/a (sparse-v3)       0.55    0.23 -58.2%
2000.65: git blame f2/f4/a (sparse-v4)       0.57    0.23 -59.6%
2000.66: git blame f2/f4/f3/a (full-v3)      0.77    0.85 +10.4%
2000.67: git blame f2/f4/f3/a (full-v4)      0.78    0.81 +3.8%
2000.68: git blame f2/f4/f3/a (sparse-v3)    1.07    0.72 -32.7%
2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%



Changes since V1
================

 * Fix failing diff partially-staged test in
   t1092-sparse-checkout-compatibility.sh, which was breaking in seen.


Changes since V2
================

 * Update diff commit description to include patches that make the checkout
   and status commands work with the sparse index for readers to reference.
 * Add new test case to verify diff behaves as expected when run against
   files outside the sparse checkout cone.
 * Indent error message in blame commit
 * Check error message in blame with pathspec outside sparse definition test
   matches expectations.
 * Loop blame tests (instead of running the same command multiple time
   against different files).


Changes since V3
================

 * Update diff p2000 tests to use --cached instead of --staged. Execute new
   run and update results in commit description and cover letter.
 * Update comment on blame with pathspec outside sparse definition test in
   t1092-sparse-checkout-compatibility.sh to clarify that it tests the
   current state and could be improved in the future.
 * Ensure sparse index is only activated when diff is running against files
   in a Git repo.
 * BUG if prepare_repo_settings() is called outside a repository.
 * Ensure sparse index is not activated for calls to blame, checkout, or
   pack-object with -h.
 * Ensure commit-graph is only loaded if a git directory exists.

Thanks, Lessley

Lessley Dennington (4):
  sparse index: enable only for git repos
  test-read-cache: set up repo after git directory
  diff: enable and test the sparse index
  blame: enable and test the sparse index

 builtin/blame.c                          |  5 ++
 builtin/checkout.c                       |  6 +-
 builtin/diff.c                           |  5 ++
 builtin/pack-objects.c                   |  9 ++-
 commit-graph.c                           |  5 +-
 repo-settings.c                          |  3 +
 t/helper/test-read-cache.c               |  5 +-
 t/perf/p2000-sparse-operations.sh        |  4 +
 t/t1092-sparse-checkout-compatibility.sh | 95 +++++++++++++++++++++---
 9 files changed, 118 insertions(+), 19 deletions(-)


base-commit: 7159bf518eed5c997cf4ff0f17d9cb69192a091c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1050%2Fldennington%2Fdiff-blame-sparse-index-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1050/ldennington/diff-blame-sparse-index-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1050

Range-diff vs v3:

 -:  ----------- > 1:  81e208cf454 sparse index: enable only for git repos
 -:  ----------- > 2:  5bc5e8465ab test-read-cache: set up repo after git directory
 1:  991aaad37b4 ! 3:  273ee16b74e diff: enable and test the sparse index
     @@ Commit message
          diff: enable and test the sparse index
      
          Enable the sparse index within the 'git diff' command. Its implementation
     -    already safely integrates with the sparse index because it shares code with
     -    the 'git status' and 'git checkout' commands that were already integrated.
     -    For more details see:
     +    already safely integrates with the sparse index because it shares code
     +    with the 'git status' and 'git checkout' commands that were already
     +    integrated.  For more details see:
      
     -    d76723ee53 (status: use sparse-index throughout, 2021-07-14)
     -    1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)
     +    d76723e (status: use sparse-index throughout, 2021-07-14)
     +    1ba5f45 (checkout: stop expanding sparse indexes, 2021-06-29)
      
     -    The most interesting thing to do is to add tests that verify that 'git diff'
     -    behaves correctly when the sparse index is enabled. These cases are:
     +    The most interesting thing to do is to add tests that verify that 'git
     +    diff' behaves correctly when the sparse index is enabled. These cases are:
      
          1. The index is not expanded for 'diff' and 'diff --staged'
          2. 'diff' and 'diff --staged' behave the same in full checkout, sparse
     @@ Commit message
              2. Path is outside sparse-checkout cone
              3. A merge conflict exists for paths outside sparse-checkout cone
      
     -    The `p2000` tests demonstrate a ~30% execution time reduction for 'git
     -    diff' and a ~75% execution time reduction for 'git diff --staged' using a
     +    The `p2000` tests demonstrate a ~44% execution time reduction for 'git
     +    diff' and a ~86% execution time reduction for 'git diff --staged' using a
          sparse index:
      
          Test                                      before  after
          -------------------------------------------------------------
     -    2000.30: git diff (full-v3)               0.37    0.36 -2.7%
     -    2000.31: git diff (full-v4)               0.36    0.35 -2.8%
     -    2000.32: git diff (sparse-v3)             0.46    0.30 -34.8%
     -    2000.33: git diff (sparse-v4)             0.43    0.31 -27.9%
     -    2000.34: git diff --staged (full-v3)      0.08    0.08 +0.0%
     -    2000.35: git diff --staged (full-v4)      0.08    0.08 +0.0%
     -    2000.36: git diff --staged (sparse-v3)    0.17    0.04 -76.5%
     -    2000.37: git diff --staged (sparse-v4)    0.16    0.04 -75.0%
     +    2000.30: git diff (full-v3)               0.33    0.34 +3.0%
     +    2000.31: git diff (full-v4)               0.33    0.35 +6.1%
     +    2000.32: git diff (sparse-v3)             0.53    0.31 -41.5%
     +    2000.33: git diff (sparse-v4)             0.54    0.29 -46.3%
     +    2000.34: git diff --cached (full-v3)      0.07    0.07 +0.0%
     +    2000.35: git diff --cached (full-v4)      0.07    0.08 +14.3%
     +    2000.36: git diff --cached (sparse-v3)    0.28    0.04 -85.7%
     +    2000.37: git diff --cached (sparse-v4)    0.23    0.03 -87.0%
      
          Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
       
       	prefix = setup_git_directory_gently(&nongit);
       
     -+	prepare_repo_settings(the_repository);
     -+	the_repository->settings.command_requires_full_index = 0;
     ++	if (!nongit) {
     ++		prepare_repo_settings(the_repository);
     ++		the_repository->settings.command_requires_full_index = 0;
     ++	}
      +
       	if (!no_index) {
       		/*
     @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout -f -
       test_perf_on_all git reset --hard
       test_perf_on_all git reset -- does-not-exist
      +test_perf_on_all git diff
     -+test_perf_on_all git diff --staged
     ++test_perf_on_all git diff --cached
       
       test_done
      
 2:  cfdd33129ec ! 4:  7acf5118bf5 blame: enable and test the sparse index
     @@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
       	long anchor;
       	const int hexsz = the_hash_algo->hexsz;
       
     -+	prepare_repo_settings(the_repository);
     -+	the_repository->settings.command_requires_full_index = 0;
     ++	if (startup_info->have_repository) {
     ++		prepare_repo_settings(the_repository);
     ++		the_repository->settings.command_requires_full_index = 0;
     ++	}
      +
       	setup_default_color_by_age();
       	git_config(git_blame_config, &output_option);
       	repo_init_revisions(the_repository, &revs, NULL);
      
       ## t/perf/p2000-sparse-operations.sh ##
     -@@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git reset --hard
     +@@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git reset
     + test_perf_on_all git reset --hard
       test_perf_on_all git reset -- does-not-exist
       test_perf_on_all git diff
     - test_perf_on_all git diff --staged
     +-test_perf_on_all git diff --cached
     ++test_perf_on_all git diff --staged
      +test_perf_on_all git blame $SPARSE_CONE/a
      +test_perf_on_all git blame $SPARSE_CONE/f3/a
       
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'log with pathspec
      -# TODO: blame currently does not support blaming files outside of the
      -# sparse definition. It complains that the file doesn't exist locally.
      -test_expect_failure 'blame with pathspec outside sparse definition' '
     -+# Blame does not support blaming files outside of the sparse
     -+# definition, so we verify this scenario.
     ++# NEEDSWORK: This test documents the current behavior, but this could
     ++# change in the future if we decide to support blaming files outside
     ++# the sparse definition.
      +test_expect_success 'blame with pathspec outside sparse definition' '
       	init_repos &&
      +	test_sparse_match git sparse-checkout set &&

-- 
gitgitgadget
