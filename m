Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57136C433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383180AbhLCVTe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353164AbhLCVTe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:19:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C010C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 13:16:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u1so8263616wru.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 13:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ag2mXlbpvhJEKA8T3O2Lllx/gV4BdSn5zyntYkakEvI=;
        b=JCjJLt3FckTbZ98wl1op6ePG7NMMJ9NG+3BZ8MctXsvyMEDkUfLiWclinVWsziTWGT
         IjJtATdg7XLJUWxn6xtW5m3VLbRGBlgQ9ZFslNxkev9ude+uiPQKZNIPXYZOM8NtL2o1
         XBU+z2+fSyEd2gLc71BvswLn+V6NfYwm12RkKykt/rpuW+RbdTZVTdGoRnYxBJKzAtD4
         Z9eycbxcQyWB8xwsZuUfFhGFNUd/5AqovPU1JInKt6L4C7Rq6GW/AMjOsTQvUYvpW/LI
         gNaHMqbAHC8dt3pLf+wp6kKANxBowXhCpog/L+K39+dws+er1RjWFJGVRmVVCWOOo+fA
         vMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ag2mXlbpvhJEKA8T3O2Lllx/gV4BdSn5zyntYkakEvI=;
        b=Mu+AvnSqXsnK9ZYWIFhT76bXf0g9tuvDDPRjYrtMK6VZpnXJTurNdQyTtLBD4IDGu3
         fF61ZFko/3stPUpb5w/Or+WSUdYAEOuTBkPzIxBvJ4PwW8RzGISke+pLsM9oApGqYh2l
         x8stEEaeNfJ/YFvBcKuurcfyWiS+tLQO0dCYy0nf3J7ySLEsfspxk2bpsZCsiYmqVGnh
         cs0bhPskNydPkg0uzeiCREKz2DRoK46O+sN1F62NGnP8G4TeBVmpRLwPbR2cxokEdysT
         QbcBsZMlUG2G8QKQX0o4VKxtaVQbGZSqFxFdr3koFEXR4yD0M9KAgg7pxtwM4R/lusmX
         lasw==
X-Gm-Message-State: AOAM533FE8lPB+pJOPTICvTxBZyT9pxyVWjlXFaJ6Wtpt7fgOdKzzQWl
        Ubv8KtyZjMIl7JWA4mT4+abG2J1MhUM=
X-Google-Smtp-Source: ABdhPJxFLvOeQssR3BXvU2WcIdMmSDoCPDmh51Z3ae1ADJ/Q0BOs22j6c10LGzO/2Nd2pF95+QiOPg==
X-Received: by 2002:adf:f042:: with SMTP id t2mr24402397wro.180.1638566167794;
        Fri, 03 Dec 2021 13:16:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm7630502wmp.26.2021.12.03.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 13:16:07 -0800 (PST)
Message-Id: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
References: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Dec 2021 21:15:58 +0000
Subject: [PATCH v5 0/7] Sparse Index: diff and blame builtins
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


Changes since V4
================

 * Remove startup_info->have_repository check from checkout, pack-objects,
   and blame. Update git.c to no longer bypass setup when -h is passed
   instead.
 * Move commit-graph, test-read-cache, and repo-settings changes into their
   own patches with details in commit description of why the changes are
   being made.
 * Update t1092-sparse-checkout-compatibility.sh tests to use --cached
   instead of --staged.
 * Use 10-character hash abbreviations for commits referenced in diff commit
   message.
 * Clarify that being unable to blame files outside the working directory is
   not supported in either sparse or non-sparse checkouts both in comment on
   blame with pathspec outside sparse definition test in
   t1092-sparse-checkout-compatibility.sh and blame commit message.

Thanks, Lessley

Lessley Dennington (7):
  git: esnure correct git directory setup with -h
  commit-graph: return if there is no git directory
  test-read-cache: set up repo after git directory
  repo-settings: prepare_repo_settings only in git repos
  diff: replace --staged with --cached in t1092 tests
  diff: enable and test the sparse index
  blame: enable and test the sparse index

 builtin/blame.c                          |   3 +
 builtin/diff.c                           |   5 ++
 commit-graph.c                           |   5 +-
 git.c                                    |  37 ++++----
 repo-settings.c                          |   3 +
 t/helper/test-read-cache.c               |   5 +-
 t/perf/p2000-sparse-operations.sh        |   4 +
 t/t1092-sparse-checkout-compatibility.sh | 109 +++++++++++++++++++----
 8 files changed, 132 insertions(+), 39 deletions(-)


base-commit: f2a454e0a5e26c0f7b840970f69d195c37b16565
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1050%2Fldennington%2Fdiff-blame-sparse-index-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1050/ldennington/diff-blame-sparse-index-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1050

Range-diff vs v4:

 -:  ----------- > 1:  09c2ff9f898 git: esnure correct git directory setup with -h
 1:  81e208cf454 ! 2:  9e53a6435e4 sparse index: enable only for git repos
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    sparse index: enable only for git repos
     +    commit-graph: return if there is no git directory
      
     -    Check whether git dir exists before adding any repo settings. If it
     -    does not exist, BUG with the message that one cannot add settings for an
     -    uninitialized repository. If it does exist, proceed with adding repo
     -    settings.
     -
     -    Additionally, ensure the above BUG is not triggered when users pass the -h
     -    flag by adding a check for the repository to the checkout and pack-objects
     -    builtins.
     -
     -    Finally, ensure the above BUG is not triggered for commit-graph by
     -    returning early if the git directory does not exist.
     +    Return early if git directory does not exist. This will protect against
     +    test failures in the upcoming change to BUG in prepare_repo_settings if no
     +    git directory exists.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
      
     - ## builtin/checkout.c ##
     -@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
     - 
     - 	git_config(git_checkout_config, opts);
     - 
     --	prepare_repo_settings(the_repository);
     --	the_repository->settings.command_requires_full_index = 0;
     -+	if (startup_info->have_repository) {
     -+		prepare_repo_settings(the_repository);
     -+		the_repository->settings.command_requires_full_index = 0;
     -+	}
     - 
     - 	opts->track = BRANCH_TRACK_UNSPECIFIED;
     - 
     -
     - ## builtin/pack-objects.c ##
     -@@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
     - 	read_replace_refs = 0;
     - 
     - 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", -1);
     --	prepare_repo_settings(the_repository);
     --	if (sparse < 0)
     --		sparse = the_repository->settings.pack_use_sparse;
     -+
     -+	if (startup_info->have_repository) {
     -+		prepare_repo_settings(the_repository);
     -+		if (sparse < 0)
     -+			sparse = the_repository->settings.pack_use_sparse;
     -+	}
     - 
     - 	reset_pack_idx_option(&pack_idx_opts);
     - 	git_config(git_pack_config, NULL);
     -
       ## commit-graph.c ##
      @@ commit-graph.c: static int prepare_commit_graph(struct repository *r)
       	struct object_directory *odb;
     @@ commit-graph.c: static int prepare_commit_graph(struct repository *r)
       		return 0;
       
       	if (r->objects->commit_graph_attempted)
     -
     - ## repo-settings.c ##
     -@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
     - 	char *strval;
     - 	int manyfiles;
     - 
     -+	if (!r->gitdir)
     -+		BUG("Cannot add settings for uninitialized repository");
     -+
     - 	if (r->settings.initialized++)
     - 		return;
     - 
 2:  5bc5e8465ab ! 3:  219a4158b6a test-read-cache: set up repo after git directory
     @@ Metadata
       ## Commit message ##
          test-read-cache: set up repo after git directory
      
     -    Move repo setup to occur after git directory is set up. This will ensure
     -    enabling the sparse index for `diff` (and guarding against the nongit
     -    scenario) will not cause tests to start failing, since that change will include
     -    adding a check to prepare_repo_settings() with the new BUG.
     +    Move repo setup to occur after git directory is set up. This will protect
     +    against test failures in the upcoming change to BUG in
     +    prepare_repo_settings if no git directory exists.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
      
 -:  ----------- > 4:  4d8d58c473b repo-settings: prepare_repo_settings only in git repos
 -:  ----------- > 5:  85e3e5c78e7 diff: replace --staged with --cached in t1092 tests
 3:  273ee16b74e ! 6:  4f16366e5ad diff: enable and test the sparse index
     @@ Commit message
          with the 'git status' and 'git checkout' commands that were already
          integrated.  For more details see:
      
     -    d76723e (status: use sparse-index throughout, 2021-07-14)
     -    1ba5f45 (checkout: stop expanding sparse indexes, 2021-06-29)
     +    d76723ee53 (status: use sparse-index throughout, 2021-07-14)
     +    1ba5f45132 (checkout: stop expanding sparse indexes, 2021-06-29)
      
          The most interesting thing to do is to add tests that verify that 'git
          diff' behaves correctly when the sparse index is enabled. These cases are:
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	run_on_all ../edit-contents deep/testfile &&
      +
      +	test_all_match git diff &&
     -+	test_all_match git diff --staged &&
     ++	test_all_match git diff --cached &&
      +	ensure_not_expanded diff &&
     -+	ensure_not_expanded diff --staged &&
     ++	ensure_not_expanded diff --cached &&
      +
      +	# Add file outside cone
      +	test_all_match git reset --hard &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	test_sparse_match git sparse-checkout set &&
      +
      +	test_all_match git diff &&
     -+	test_all_match git diff --staged &&
     ++	test_all_match git diff --cached &&
      +	ensure_not_expanded diff &&
     -+	ensure_not_expanded diff --staged &&
     ++	ensure_not_expanded diff --cached &&
      +
      +	# Merge conflict outside cone
      +	# The sparse checkout will report a warning that is not in the
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
      +	test_all_match test_must_fail git merge merge-right &&
      +
      +	test_all_match git diff &&
     -+	test_all_match git diff --staged &&
     ++	test_all_match git diff --cached &&
      +	ensure_not_expanded diff &&
     -+	ensure_not_expanded diff --staged
     ++	ensure_not_expanded diff --cached
      +'
      +
       # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
 4:  7acf5118bf5 ! 7:  04532378734 blame: enable and test the sparse index
     @@ Commit message
          2000.99: git blame f2/f4/f3/a (sparse-v4)    1.05    0.73 -30.5%
      
          We do not include paths outside the sparse checkout cone because blame
     -    currently does not support blaming files outside of the sparse definition.
     -    Attempting to do so fails with the following error:
     -
     -      fatal: no such path '<path outside sparse definition>' in HEAD
     +    does not support blaming files that are not present in the working
     +    directory. This is true in both sparse and full checkouts.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
      
       ## builtin/blame.c ##
     -@@ builtin/blame.c: int cmd_blame(int argc, const char **argv, const char *prefix)
     - 	long anchor;
     - 	const int hexsz = the_hash_algo->hexsz;
     +@@ builtin/blame.c: parse_done:
     + 	revs.diffopt.flags.follow_renames = 0;
     + 	argc = parse_options_end(&ctx);
       
     -+	if (startup_info->have_repository) {
     -+		prepare_repo_settings(the_repository);
     -+		the_repository->settings.command_requires_full_index = 0;
     -+	}
     ++	prepare_repo_settings(the_repository);
     ++	the_repository->settings.command_requires_full_index = 0;
      +
     - 	setup_default_color_by_age();
     - 	git_config(git_blame_config, &output_option);
     - 	repo_init_revisions(the_repository, &revs, NULL);
     + 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
     + 		if (show_progress > 0)
     + 			die(_("--progress can't be used with --incremental or porcelain formats"));
      
       ## t/perf/p2000-sparse-operations.sh ##
     -@@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git reset
     - test_perf_on_all git reset --hard
     +@@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git reset --hard
       test_perf_on_all git reset -- does-not-exist
       test_perf_on_all git diff
     --test_perf_on_all git diff --cached
     -+test_perf_on_all git diff --staged
     + test_perf_on_all git diff --cached
      +test_perf_on_all git blame $SPARSE_CONE/a
      +test_perf_on_all git blame $SPARSE_CONE/f3/a
       
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'log with pathspec
      -# TODO: blame currently does not support blaming files outside of the
      -# sparse definition. It complains that the file doesn't exist locally.
      -test_expect_failure 'blame with pathspec outside sparse definition' '
     -+# NEEDSWORK: This test documents the current behavior, but this could
     -+# change in the future if we decide to support blaming files outside
     -+# the sparse definition.
     ++# Without a revision specified, blame will error if passed any file that
     ++# is not present in the working directory (even if the file is tracked).
     ++# Here we just verify that this is also true with sparse checkouts.
      +test_expect_success 'blame with pathspec outside sparse definition' '
       	init_repos &&
      +	test_sparse_match git sparse-checkout set &&
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'log with pathspec
       
       test_expect_success 'checkout and reset (mixed)' '
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse index is not expanded: diff' '
     - 	ensure_not_expanded diff --staged
     + 	ensure_not_expanded diff --cached
       '
       
      +test_expect_success 'sparse index is not expanded: blame' '

-- 
gitgitgadget
