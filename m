Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41670C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389598AbhLFQOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388328AbhLFQNa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43262C08E9BD
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l16so23387427wrp.11
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CMEcHUnAGyEs6gUDxTN6j2YDDtTHtb/jtf+/QPCen/k=;
        b=b/uzI/HlHhrVsDycKOhI75CVDeS52fP1spL/r7oWnwz33nthZLKeVFwah/Gdkuw9Hw
         zs+iA74QqJmE71xeCa9bYVrbdg+Q9Mc8aaSZVMh7QZuN77gwawlZjKgGxvwyNpqL1ZUf
         Kl1RxAHd8DlpD/QOSiVcpDchFdC7PPz8rttLpGh6yysH44bvjUGJJX5j8VnoKSsNcA7u
         oblpG9HpmPdnH41RUpK0FSMD3JAyPC92m3WxjeepHN+YY0hnl/8MW+/ztL4xdm8kW1Yc
         kYYLFcx7G3Qiqz7+vMrROZnazDhy3YoLS+IaIt8H6qfPuVy4Wqi7CYgGrrd5z1qW/Qyg
         urig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CMEcHUnAGyEs6gUDxTN6j2YDDtTHtb/jtf+/QPCen/k=;
        b=RHuoepY8Y4CG1iGOAaYn6qeyV7Cik7jhw6ZNxcBEyZotXSKNsb7xyuk6tMBVpFPQfp
         6V8A/ZVaa3DcewpuCzoGhb4JAbBZv9dtmzLrsf6tL+wYRkS+jzph8m4Vy3zlAWBfb9Fv
         N7z8c0m3JZxpIIlRofaozJqHN1EWjJCTmvtaYU1rTOrEPuBhd32EHPEqn3QLnbLw2uw7
         /3P+IrpBOvnByLndpXgzN13fegwAHdIZ0d+theerS5rav7DWA8/7NwyUhoCR63fOEgYs
         vHRRsP7cgEB/W5iTsq3EDE8gI+kWBZWYEGGPXwiDJ5ZrUSYcryEhWHCsXxF6iAS6uhOx
         HsHQ==
X-Gm-Message-State: AOAM533iZnmn31Ns+nyhc/AAHbNFQsDVnG1Av+14waFchpnmqBcgc+rn
        FQtFMID/ePX100Zd0T50qKZooj1l7FE=
X-Google-Smtp-Source: ABdhPJzgsQIK2QqqTijj3nzRSBRm39P+GcQUWjivSW8HWBqk2WoEGEAsuCPirEt7y0J39bCNlHh2Ng==
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr44813760wrb.148.1638806162515;
        Mon, 06 Dec 2021 07:56:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm16135315wmq.31.2021.12.06.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:02 -0800 (PST)
Message-Id: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:55:54 +0000
Subject: [PATCH v6 0/7] Sparse Index: diff and blame builtins
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


Changes since V5
================

 * Fix commit message typo.
 * Re-add blank line to separate variable declarations from statements in
   run_builtin.
 * Refactor prefix NULL assignment in run_builtin.

Thanks, Lessley

Lessley Dennington (7):
  git: ensure correct git directory setup with -h
  commit-graph: return if there is no git directory
  test-read-cache: set up repo after git directory
  repo-settings: prepare_repo_settings only in git repos
  diff: replace --staged with --cached in t1092 tests
  diff: enable and test the sparse index
  blame: enable and test the sparse index

 builtin/blame.c                          |   3 +
 builtin/diff.c                           |   5 ++
 commit-graph.c                           |   5 +-
 git.c                                    |  39 ++++----
 repo-settings.c                          |   3 +
 t/helper/test-read-cache.c               |   5 +-
 t/perf/p2000-sparse-operations.sh        |   4 +
 t/t1092-sparse-checkout-compatibility.sh | 109 +++++++++++++++++++----
 8 files changed, 134 insertions(+), 39 deletions(-)


base-commit: f2a454e0a5e26c0f7b840970f69d195c37b16565
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1050%2Fldennington%2Fdiff-blame-sparse-index-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1050/ldennington/diff-blame-sparse-index-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1050

Range-diff vs v5:

 1:  09c2ff9f898 ! 1:  efdd55c126d git: esnure correct git directory setup with -h
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    git: esnure correct git directory setup with -h
     +    git: ensure correct git directory setup with -h
      
          Ensure correct git directory setup when -h is passed with commands. This
          specifically applies to repos with special help text configuration
     @@ Commit message
      
          Co-authored-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## git.c ##
      @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
       	int status, help;
       	struct stat st;
       	const char *prefix;
     --
      +	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
     - 	prefix = NULL;
     + 
     +-	prefix = NULL;
       	help = argc == 2 && !strcmp(argv[1], "-h");
      -	if (!help) {
      -		if (p->option & RUN_SETUP)
     @@ git.c: static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
      +		/* demote to GENTLY to allow 'git cmd -h' outside repo */
      +		run_setup = RUN_SETUP_GENTLY;
      +
     -+	if (run_setup & RUN_SETUP)
     ++	if (run_setup & RUN_SETUP) {
      +		prefix = setup_git_directory();
     -+	else if (run_setup & RUN_SETUP_GENTLY) {
     ++	} else if (run_setup & RUN_SETUP_GENTLY) {
      +		int nongit_ok;
      +		prefix = setup_git_directory_gently(&nongit_ok);
     ++	} else {
     ++		prefix = NULL;
       	}
      +	precompose_argv_prefix(argc, argv, NULL);
      +	if (use_pager == -1 && run_setup &&
 2:  9e53a6435e4 ! 2:  f676f03ccb0 commit-graph: return if there is no git directory
     @@ Commit message
          git directory exists.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## commit-graph.c ##
      @@ commit-graph.c: static int prepare_commit_graph(struct repository *r)
 3:  219a4158b6a ! 3:  7b1fab86a4a test-read-cache: set up repo after git directory
     @@ Commit message
          prepare_repo_settings if no git directory exists.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## t/helper/test-read-cache.c ##
      @@ t/helper/test-read-cache.c: int cmd__read_cache(int argc, const char **argv)
 4:  4d8d58c473b ! 4:  fd28be71ca4 repo-settings: prepare_repo_settings only in git repos
     @@ Commit message
          settings.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## repo-settings.c ##
      @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
 5:  85e3e5c78e7 ! 5:  2a1524a7e9a diff: replace --staged with --cached in t1092 tests
     @@ Commit message
          diff.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## t/t1092-sparse-checkout-compatibility.sh ##
      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'checkout and reset --hard' '
 6:  4f16366e5ad ! 6:  897611682af diff: enable and test the sparse index
     @@ Commit message
          2000.37: git diff --cached (sparse-v4)    0.23    0.03 -87.0%
      
          Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
     -    Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/diff.c ##
      @@ builtin/diff.c: int cmd_diff(int argc, const char **argv, const char *prefix)
 7:  04532378734 ! 7:  85bcbaa1771 blame: enable and test the sparse index
     @@ Commit message
          directory. This is true in both sparse and full checkouts.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
     +    Reviewed-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/blame.c ##
      @@ builtin/blame.c: parse_done:

-- 
gitgitgadget
