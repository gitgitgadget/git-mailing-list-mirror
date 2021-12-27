Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED4EC433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhL0XYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbhL0XYC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122D3C061401
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso5798549wmi.0
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8QcooAEVC/U+0r/z4Q0Iui8X4vj3lzVTXHsOOO7+Bb8=;
        b=KyoOUHedjP1qla9uKqKdoKuEZgd2xlNqOIBsr6DU/xv6i72+O+8R2yl2E3bLKvFclk
         Z18xRfJMBgBsMRYyCgES/r0UAm3uaikaT9+bJimgWicEnHFbfOnWtfcasybziTNZ5xS7
         zrERJoT5tN6shBILZu3FIe4cj7Jn5Sh+RJhwO9Kbr5DhvfyxCGSjza+lfSdQrr1FThtw
         WbDW5UWIM5WjOx7YQyHXIE4TuWtqJpXRaqhKwHKVOHtaqeDPg1DqWaTz6lDkvL8HDDVh
         CHXb6a7aIPeBSjlrViOtPigzaMk2+4hU6rqnJA+IM98TjkH5bnxn9YZZwhsBqd3P+ft6
         xnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8QcooAEVC/U+0r/z4Q0Iui8X4vj3lzVTXHsOOO7+Bb8=;
        b=aa3HpnhKHF74JLuZhV4cM7vKUjhcAHme53yfCQRBm8dxpvjCfgq/mg3+0l5uobmvPp
         26JsKQUiNQmVW7462fBXWwkF5dSMtYTrTWlFscaPUb17le0y4FXGUfpzb8dzt0pIXR4F
         3bu96iN3QMiN/Eul9I+HjmEI1071krS9QzFUz4oTYuf5jxmA7DX6YI42OvWPuUcHalmF
         EZo7QHOnLfAuodfweCpFz4t3q/SlkBLwjgqm2AKuwhnE36+yUx5JrN5v3QLj9DVILozD
         7Ix9mCL6dkKuu/svW8DXyO89tOqcTYxkeLeB5nszf66vJXWu5KGPlev5ksBfnOyn0ehs
         bkVQ==
X-Gm-Message-State: AOAM530N05HTMf1KNd4Di40hN3tdv3oVTG0Tf5Z6lxEENzpITCBaIuCh
        XIAi0RtcAwoE2nyog3/txAHq12HX3UY=
X-Google-Smtp-Source: ABdhPJzGY3BejEc98ACf3eIt1ajDGdTaul+xudpH6uRga46aih8UGMWgUBkh9wpN+JgXJav/rMxZ2g==
X-Received: by 2002:a1c:2085:: with SMTP id g127mr14915380wmg.120.1640647439501;
        Mon, 27 Dec 2021 15:23:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7sm16636441wrx.104.2021.12.27.15.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:23:59 -0800 (PST)
Message-Id: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:46 +0000
Subject: [PATCH v2 00/11] Factorization of messages with similar meaning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a meager attempt at rationalizing a small fraction of the
internationalized messages. Sorry in advance for the dull task of reviewing
these insipide patches.

Doing so has some positive effects:

 * non-translatable constant strings are kept out of the way for translators
 * messages with identical meaning are built identically
 * the total number of messages to translate is decreased.

Changes since V1:

 * took into account the comments, except for ref-filter.c where the
   proposed refactoring is not obvious.
 * added even more strings to the "cannot be used together" crowd.

Jean-Noël Avila (11):
  i18n: refactor "foo and bar are mutually exclusive"
  i18n: refactor "%s, %s and %s are mutually exclusive"
  i18n: turn "options are incompatible" into "cannot be used together"
  i18n: standardize "cannot open" and "cannot read"
  i18n: tag.c factorize i18n strings
  i18n: factorize "--foo requires --bar" and the like
  i18n: factorize "no directory given for --foo"
  i18n: refactor "unrecognized %(foo) argument" strings
  i18n: factorize "--foo outside a repository"
  i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
  i18n: turn even more messages into "cannot be used together" ones

 apply.c                                   |  8 ++++----
 archive.c                                 |  8 ++++----
 builtin/add.c                             | 14 +++++++-------
 builtin/am.c                              |  4 ++--
 builtin/branch.c                          |  2 +-
 builtin/cat-file.c                        |  2 +-
 builtin/checkout.c                        | 12 ++++++------
 builtin/clone.c                           |  4 ++--
 builtin/commit.c                          | 18 ++++++++++--------
 builtin/describe.c                        |  6 +++---
 builtin/diff-tree.c                       |  2 +-
 builtin/difftool.c                        |  4 ++--
 builtin/fast-export.c                     |  4 ++--
 builtin/fetch.c                           |  8 ++++----
 builtin/index-pack.c                      |  4 ++--
 builtin/init-db.c                         |  4 ++--
 builtin/log.c                             |  8 ++++----
 builtin/ls-files.c                        |  2 +-
 builtin/merge.c                           |  4 ++--
 builtin/pack-objects.c                    |  2 +-
 builtin/push.c                            |  8 ++++----
 builtin/rebase.c                          | 10 +++++-----
 builtin/repack.c                          |  4 ++--
 builtin/reset.c                           | 10 +++++-----
 builtin/rev-list.c                        |  4 ++--
 builtin/rm.c                              |  4 ++--
 builtin/show-branch.c                     |  4 ++--
 builtin/stash.c                           |  8 ++++----
 builtin/submodule--helper.c               |  4 ++--
 builtin/tag.c                             | 13 ++++++++-----
 builtin/worktree.c                        |  6 +++---
 diff.c                                    |  8 ++++----
 fetch-pack.c                              |  2 +-
 git.c                                     |  6 +++---
 http-fetch.c                              |  4 ++--
 range-diff.c                              |  2 +-
 ref-filter.c                              | 22 +++++++++++-----------
 revision.c                                | 22 +++++++++++-----------
 t/t0001-init.sh                           |  6 +++---
 t/t2025-checkout-no-overlay.sh            |  2 +-
 t/t2026-checkout-pathspec-file.sh         |  6 +++---
 t/t2072-restore-pathspec-file.sh          |  4 ++--
 t/t3431-rebase-fork-point.sh              |  2 +-
 t/t3601-rm-pathspec-file.sh               |  2 +-
 t/t3704-add-pathspec-file.sh              |  8 ++++----
 t/t3909-stash-pathspec-file.sh            |  4 ++--
 t/t4209-log-pickaxe.sh                    | 10 +++++-----
 t/t5606-clone-options.sh                  |  4 ++--
 t/t7107-reset-pathspec-file.sh            |  4 ++--
 t/t7500-commit-template-squash-signoff.sh | 11 ++++++-----
 t/t7526-commit-pathspec-file.sh           |  8 ++++----
 51 files changed, 169 insertions(+), 163 deletions(-)


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1088%2Fjnavila%2Fi18n-refactor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1088/jnavila/i18n-refactor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1088

Range-diff vs v1:

  1:  476eb77aff6 !  1:  71699eaa27b i18n: refactor "foo and bar are mutually exclusive"
     @@ Metadata
       ## Commit message ##
          i18n: refactor "foo and bar are mutually exclusive"
      
     -    Use static strings for constant parts of the sentences.
     +    Use static strings for constant parts of the sentences. They are all
     +    turned into "cannot be used together".
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       
       	if (opts->overlay_mode == 1 && opts->patch_mode)
      -		die(_("-p and --overlay are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "-p", "--overlay");
     ++		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
       
       	if (opts->checkout_index >= 0 || opts->checkout_worktree >= 0) {
       		if (opts->checkout_index < 0)
     @@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *
       
       	if (read_stdin && merge_base)
      -		die(_("--stdin and --merge-base are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "--stdin", "--merge-base");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--stdin", "--merge-base");
       	if (merge_base && opt->pending.nr != 2)
       		die(_("--merge-base only works with two commits"));
       
     @@ builtin/diff-tree.c: int cmd_diff_tree(int argc, const char **argv, const char *
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: int cmd_fetch(int argc, const char **argv, const char *prefix)
       		if (deepen_relative < 0)
     - 			die(_("Negative depth in --deepen is not supported"));
     + 			die(_("negative depth in --deepen is not supported"));
       		if (depth)
      -			die(_("--deepen and --depth are mutually exclusive"));
     -+			die(_("%s and %s are mutually exclusive"), "--deepen", "--depth");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--deepen", "--depth");
       		depth = xstrfmt("%d", deepen_relative);
       	}
       	if (unshallow) {
     + 		if (depth)
     +-			die(_("--depth and --unshallow cannot be used together"));
     ++			die(_("options '%s' and '%s' cannot be used together"), "--depth", "--unshallow");
     + 		else if (!is_repository_shallow(the_repository))
     + 			die(_("--unshallow on a complete repository does not make sense"));
     + 		else
      
       ## builtin/init-db.c ##
      @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
       
       	if (real_git_dir && is_bare_repository_cfg == 1)
      -		die(_("--separate-git-dir and --bare are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "--separate-git-dir", "--bare");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--separate-git-dir", "--bare");
       
       	if (real_git_dir && !is_absolute_path(real_git_dir))
       		real_git_dir = real_pathdup(real_git_dir, 1);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       
       	if (numbered && keep_subject)
      -		die(_("-n and -k are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "-n", "-k");
     ++		die(_("options '%s' and '%s' cannot be used together"), "-n", "-k");
       	if (keep_subject && subject_prefix)
      -		die(_("--subject-prefix/--rfc and -k are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "--subject-prefix/--rfc", "-k");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--subject-prefix/--rfc", "-k");
       	rev.preserve_subject = keep_subject;
       
       	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
     @@ builtin/submodule--helper.c: static int module_summary(int argc, const char **ar
       	if (files) {
       		if (cached)
      -			die(_("--cached and --files are mutually exclusive"));
     -+			die(_("%s and %s are mutually exclusive"), "--cached", "--files");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--cached", "--files");
       		diff_cmd = DIFF_FILES;
       	}
       
     @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
       
       	if (opt_branch && opt_default)
      -		die(_("--branch and --default are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "--branch", "--default");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--branch", "--default");
       
       	if (argc != 1 || !(path = argv[0]))
       		usage_with_options(usage, options);
     @@ builtin/worktree.c: static int list(int ac, const char **av, const char *prefix)
       		usage_with_options(worktree_usage, options);
       	else if (verbose && porcelain)
      -		die(_("--verbose and --porcelain are mutually exclusive"));
     -+		die(_("%s and %s are mutually exclusive"), "--verbose", "--porcelain");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--verbose", "--porcelain");
       	else {
       		struct worktree **worktrees = get_worktrees();
       		int path_maxlen = 0, abbrev = DEFAULT_ABBREV, i;
     @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       
       	if (range_diff_opts->left_only && range_diff_opts->right_only)
      -		res = error(_("--left-only and --right-only are mutually exclusive"));
     -+		res = error(_("%s and %s are mutually exclusive"), "--left-only", "--right-only");
     ++		res = error(_("options '%s' and '%s' cannot be used together"), "--left-only", "--right-only");
       
       	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
       		res = error(_("could not parse log for '%s'"), range1);
     +
     + ## t/t0001-init.sh ##
     +@@ t/t0001-init.sh: test_expect_success 'init with separate gitdir' '
     + 
     + test_expect_success 'explicit bare & --separate-git-dir incompatible' '
     + 	test_must_fail git init --bare --separate-git-dir goop.git bare.git 2>err &&
     +-	test_i18ngrep "mutually exclusive" err
     ++	test_i18ngrep "cannot be used together" err
     + '
     + 
     + test_expect_success 'implicit bare & --separate-git-dir incompatible' '
     +
     + ## t/t2025-checkout-no-overlay.sh ##
     +@@ t/t2025-checkout-no-overlay.sh: test_expect_success 'checkout --no-overlay removing last file from directory' '
     + 
     + test_expect_success 'checkout -p --overlay is disallowed' '
     + 	test_must_fail git checkout -p --overlay HEAD 2>actual &&
     +-	test_i18ngrep "fatal: -p and --overlay are mutually exclusive" actual
     ++	test_i18ngrep "fatal: options .-p. and .--overlay. cannot be used together" actual
     + '
     + 
     + test_expect_success '--no-overlay --theirs with D/F conflict deletes file' '
     +
     + ## t/t4209-log-pickaxe.sh ##
     +@@ t/t4209-log-pickaxe.sh: test_expect_success 'usage' '
     + 	test_i18ngrep "switch.*requires a value" err &&
     + 
     + 	test_expect_code 128 git log -Gregex -Sstring 2>err &&
     +-	grep "mutually exclusive" err &&
     ++	grep "cannot be used together" err &&
     + 
     + 	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
     +-	grep "mutually exclusive" err &&
     ++	grep "cannot be used together" err &&
     + 
     + 	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
     +-	grep "mutually exclusive" err &&
     ++	grep "cannot be used together" err &&
     + 
     + 	test_expect_code 128 git log --pickaxe-all --find-object=HEAD 2>err &&
     + 	grep "mutually exclusive" err
  2:  32c7799388b !  2:  be4e8757f38 i18n: refactor "%s, %s and %s are mutually exclusive"
     @@ Metadata
       ## Commit message ##
          i18n: refactor "%s, %s and %s are mutually exclusive"
      
     -    Use placeholders for constant tokens.
     +    Use placeholders for constant tokens. The strings are turned into
     +    "cannot be used together"
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
       
       	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
      -		die(_("--gui, --tool and --extcmd are mutually exclusive"));
     -+		die(_("%s, %s and %s are mutually exclusive"), "--gui", "--tool", "--extcmd");
     ++		die(_("options '%s', '%s' and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
       
       	if (use_gui_tool)
       		setenv("GIT_MERGETOOL_GUI", "true", 1);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       
       	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
      -		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
     -+		die(_("%s, %s and %s are mutually exclusive"), "--stdout", "--output", "--output-directory");
     ++		die(_("options '%s', '%s' and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
       
       	if (use_stdout) {
       		setup_pager();
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
      -		die(_("-b, -B, and --detach are mutually exclusive"));
     -+		die(_("%s, %s and %s are mutually exclusive"), "-b", "-B", "--detach");
     ++		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
       		die(_("--reason requires --lock"));
       	if (lock_reason)
     @@ diff.c: void diff_setup_done(struct diff_options *options)
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
      -		die(_("-G, -S and --find-object are mutually exclusive"));
     -+		die(_("%s, %s and %s are mutually exclusive"), "-G", "-S", "--find-object");
     ++		die(_("options '%s', '%s' and '%s' cannot be used together"), "-G", "-S", "--find-object");
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
       		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
  3:  46e94ef3ac9 !  3:  53bad588bfc i18n: turn "options are incompatible" into "are mutually exclusive"
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    i18n: turn "options are incompatible" into "are mutually exclusive"
     +    i18n: turn "options are incompatible" into "cannot be used together"
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
       
       	if (state->apply_with_reject && state->threeway)
      -		return error(_("--reject and --3way cannot be used together."));
     -+		return error(_("%s and %s are mutually exclusive"),"--reject",  "--3way");
     ++		return error(_("options '%s' and '%s' cannot be used together"),"--reject",  "--3way");
       	if (state->threeway) {
       		if (is_not_gitdir)
       			return error(_("--3way outside a repository"));
     @@ archive.c: static int parse_archive_args(int argc, const char **argv,
       		die(_("Unexpected option --output"));
       	if (is_remote && args->extra_files.nr)
      -		die(_("Options --add-file and --remote cannot be used together"));
     -+		die(_("%s and %s are mutually exclusive"), "--add-file", "--remote");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--add-file", "--remote");
       
       	if (!base)
       		base = "";
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       	if (add_interactive) {
       		if (show_only)
      -			die(_("--dry-run is incompatible with --interactive/--patch"));
     -+			die(_("%s and %s are mutually exclusive"), "--dry-run", "--interactive/--patch");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
       		if (pathspec_from_file)
      -			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--interactive/--patch");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
       		exit(interactive_add(argv + 1, prefix, patch_interactive));
       	}
       	if (legacy_stash_p) {
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       	if (edit_interactive) {
       		if (pathspec_from_file)
      -			die(_("--pathspec-from-file is incompatible with --edit"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--edit");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--edit");
       		return(edit_patch(argc, argv, prefix));
       	}
       	argc--;
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       
       	if (addremove && take_worktree_changes)
      -		die(_("-A and -u are mutually incompatible"));
     -+		die(_("%s and %s are mutually exclusive"), "-A", "-u");
     ++		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
       
       	if (!show_only && ignore_missing)
       		die(_("Option --ignore-missing can only be used together with --dry-run"));
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
       	if (filter.verbose) {
       		if (explicitly_enable_column(colopts))
      -			die(_("--column and --verbose are incompatible"));
     -+			die(_("%s and %s are mutually exclusive"), "--column", "--verbose");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--column", "--verbose");
       		colopts = 0;
       	}
       
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       
       		if (opts->force_detach)
      -			die(_("--pathspec-from-file is incompatible with --detach"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file",  "--detach");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file",  "--detach");
       
       		if (opts->patch_mode)
      -			die(_("--pathspec-from-file is incompatible with --patch"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--patch");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
       
       		parse_pathspec_file(&opts->pathspec, 0,
       				    0,
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       			    option_origin);
       		if (real_git_dir)
      -			die(_("--bare and --separate-git-dir are incompatible."));
     -+			die(_("%s and %s are mutually exclusive"), "--bare", "--separate-git-dir");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
       		option_no_checkout = 1;
       	}
       
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
       	if (pathspec_from_file) {
       		if (interactive)
      -			die(_("--pathspec-from-file is incompatible with --interactive/--patch"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--interactive/--patch");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
       
       		if (all)
     - 			die(_("--pathspec-from-file with -a does not make sense"));
     +-			die(_("--pathspec-from-file with -a does not make sense"));
     ++			die(_("options '%s' and '%s' cannot be used together"),"--pathspec-from-file", "-a");
     + 
     + 		if (pathspec.nr)
     + 			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
      @@ builtin/commit.c: static void finalize_deferred_config(struct wt_status *s)
       		    status_format == STATUS_FORMAT_UNSPECIFIED)
       			status_format = STATUS_FORMAT_PORCELAIN;
       		else if (status_format == STATUS_FORMAT_LONG)
      -			die(_("--long and -z are incompatible"));
     -+			die(_("%s and %s are mutually exclusive"), "--long", "-z");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--long", "-z");
       	}
       
       	if (use_deferred_config && status_format == STATUS_FORMAT_UNSPECIFIED)
     @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
       
       	if (longformat && abbrev == 0)
      -		die(_("--long is incompatible with --abbrev=0"));
     -+		die(_("%s and %s are mutually exclusive"), "--long", "--abbrev=0");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--long", "--abbrev=0");
       
       	if (contains) {
       		struct string_list_item *item;
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
       		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
       	} else if (dir_diff)
      -		die(_("--dir-diff is incompatible with --no-index"));
     -+		die(_("%s and %s are mutually exclusive"), "--dir-diff", "--no-index");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
       
       	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
     - 		die(_("%s, %s and %s are mutually exclusive"), "--gui", "--tool", "--extcmd");
     + 		die(_("options '%s', '%s' and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
      
       ## builtin/fast-export.c ##
      @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
     @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
       
       	if (import_filename && import_filename_if_exists)
      -		die(_("Cannot pass both --import-marks and --import-marks-if-exists"));
     -+		die(_("%s and %s are mutually exclusive"), "--import-marks", "--import-marks-if-exists");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--import-marks", "--import-marks-if-exists");
       	if (import_filename)
       		import_marks(import_filename, 0);
       	else if (import_filename_if_exists)
     @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char
       		die(_("--stdin requires a git repository"));
       	if (from_stdin && hash_algo)
      -		die(_("--object-format cannot be used with --stdin"));
     -+		die(_("%s and %s are mutually exclusive"), "--object-format", "--stdin");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--object-format", "--stdin");
       	if (!index_name && pack_name)
       		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
       
      
     + ## builtin/ls-files.c ##
     +@@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
     + 		 * would not make any sense with this option.
     + 		 */
     + 		if (show_stage || show_unmerged)
     +-			die("ls-files --with-tree is incompatible with -s or -u");
     ++			die(_("options '%s' and '%s' cannot be used together"), "ls-files --with-tree", "-s/-u");
     + 		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
     + 	}
     + 
     +
     + ## builtin/merge.c ##
     +@@ builtin/merge.c: int cmd_merge(int argc, const char **argv, const char *prefix)
     + 
     + 	if (squash) {
     + 		if (fast_forward == FF_NO)
     +-			die(_("You cannot combine --squash with --no-ff."));
     ++			die(_("options '%s' and '%s' cannot be used together"), "--squash", "--no-ff.");
     + 		if (option_commit > 0)
     +-			die(_("You cannot combine --squash with --commit."));
     ++			die(_("options '%s' and '%s' cannot be used together"), "--squash", "--commit.");
     + 		/*
     + 		 * squash can now silently disable option_commit - this is not
     + 		 * a problem as it is only overriding the default, not a user
     +
       ## builtin/pack-objects.c ##
      @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
       		die(_("--thin cannot be used to build an indexable pack"));
       
       	if (keep_unreachable && unpack_unreachable)
      -		die(_("--keep-unreachable and --unpack-unreachable are incompatible"));
     -+		die(_("%s and %s are mutually exclusive"), "--keep-unreachable", "--unpack-unreachable");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "--unpack-unreachable");
       	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
       		unpack_unreachable_expiration = 0;
       
     @@ builtin/push.c: int cmd_push(int argc, const char **argv, const char *prefix)
       
       	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
      -		die(_("--delete is incompatible with --all, --mirror and --tags"));
     -+		die(_("%s and %s are mutually exclusive"), "--delete", "--all/--mirror/--tags");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--delete", "--all/--mirror/--tags");
       	if (deleterefs && argc < 2)
       		die(_("--delete doesn't make sense without any refs"));
       
     @@ builtin/push.c: int cmd_push(int argc, const char **argv, const char *prefix)
       	if (flags & TRANSPORT_PUSH_ALL) {
       		if (tags)
      -			die(_("--all and --tags are incompatible"));
     -+			die(_("%s and %s are mutually exclusive"), "--all", "--tags");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--all", "--tags");
       		if (argc >= 2)
       			die(_("--all can't be combined with refspecs"));
       	}
       	if (flags & TRANSPORT_PUSH_MIRROR) {
       		if (tags)
      -			die(_("--mirror and --tags are incompatible"));
     -+			die(_("%s and %s are mutually exclusive"), "--mirror", "--tags");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--mirror", "--tags");
       		if (argc >= 2)
       			die(_("--mirror can't be combined with refspecs"));
       	}
       	if ((flags & TRANSPORT_PUSH_ALL) && (flags & TRANSPORT_PUSH_MIRROR))
      -		die(_("--all and --mirror are incompatible"));
     -+		die(_("%s and %s are mutually exclusive"), "--all", "--mirror");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--all", "--mirror");
       
       	if (!is_empty_cas(&cas) && (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES))
       		cas.use_force_if_includes = 1;
      
     + ## builtin/rebase.c ##
     +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     + 
     + 	if (keep_base) {
     + 		if (options.onto_name)
     +-			die(_("cannot combine '--keep-base' with '--onto'"));
     ++			die(_("options '%s' and '%s' cannot be used together"),"--keep-base", "--onto");
     + 		if (options.root)
     +-			die(_("cannot combine '--keep-base' with '--root'"));
     ++			die(_("options '%s' and '%s' cannot be used together"),"--keep-base", "--root");
     + 	}
     + 
     + 	if (options.root && options.fork_point > 0)
     +-		die(_("cannot combine '--root' with '--fork-point'"));
     ++		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
     + 
     + 	if (action != ACTION_NONE && !in_progress)
     + 		die(_("No rebase in progress?"));
     +
       ## builtin/repack.c ##
      @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
       
       	if (keep_unreachable &&
       	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
      -		die(_("--keep-unreachable and -A are incompatible"));
     -+		die(_("%s and %s are mutually exclusive"), "--keep-unreachable", "-A");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");
       
       	if (write_bitmaps < 0) {
       		if (!write_midx &&
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
       	if (geometric_factor) {
       		if (pack_everything)
      -			die(_("--geometric is incompatible with -A, -a"));
     -+			die(_("%s and %s are mutually exclusive"),"--geometric", "-A/-a");
     ++			die(_("options '%s' and '%s' cannot be used together"),"--geometric", "-A/-a");
       		init_pack_geometry(&geometry);
       		split_pack_geometry(geometry, geometric_factor);
       	}
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       	if (pathspec_from_file) {
       		if (patch_mode)
      -			die(_("--pathspec-from-file is incompatible with --patch"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--patch");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
       
       		if (pathspec.nr)
       			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       	if (patch_mode) {
       		if (reset_type != NONE)
      -			die(_("--patch is incompatible with --{hard,mixed,soft}"));
     -+			die(_("%s and %s are mutually exclusive"), "--patch", "--{hard,mixed,soft}");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
       		trace2_cmd_mode("patch-interactive");
       		return run_add_interactive(rev, "--patch=reset", &pathspec);
       	}
      
     + ## builtin/rev-list.c ##
     +@@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
     + 		const char *arg = argv[i];
     + 		if (skip_prefix(arg, "--missing=", &arg)) {
     + 			if (revs.exclude_promisor_objects)
     +-				die(_("cannot combine --exclude-promisor-objects and --missing"));
     ++				die(_("options '%s' and '%s' cannot be used together"),"--exclude-promisor-objects", "--missing");
     + 			if (parse_missing_action_value(arg))
     + 				break;
     + 		}
     +
     + ## builtin/show-branch.c ##
     +@@ builtin/show-branch.c: int cmd_show_branch(int ac, const char **av, const char *prefix)
     + 			 *
     + 			 * Also --all and --remotes do not make sense either.
     + 			 */
     +-			die(_("--reflog is incompatible with --all, --remotes, "
     +-			      "--independent or --merge-base"));
     ++			die(_("options '%s' and '%s' cannot be used together"), "--reflog",
     ++				"--all/--remotes/--independent/--merge-base");
     + 	}
     + 
     + 	/* If nothing is specified, show all branches by default */
     +
       ## builtin/stash.c ##
      @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *prefix,
       
       	if (pathspec_from_file) {
       		if (patch_mode)
      -			die(_("--pathspec-from-file is incompatible with --patch"));
     -+			die(_("%s and %s are mutually exclusive"), "--pathspec-from-file", "--patch");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--patch");
     + 
     + 		if (only_staged)
     +-			die(_("--pathspec-from-file is incompatible with --staged"));
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--staged");
       
       		if (ps.nr)
       			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       	if (cmdmode == 'l' && filter.lines != -1) {
       		if (explicitly_enable_column(colopts))
      -			die(_("--column and -n are incompatible"));
     -+			die(_("%s and %s are mutually exclusive"), "--column", "-n");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--column", "-n");
       		colopts = 0;
       	}
     - 	if (!sorting)
     + 	sorting = ref_sorting_options(&sorting_options);
      
       ## revision.c ##
      @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
       	} else if (!strcmp(arg, "--right-only")) {
       		if (revs->left_only)
      -			die("--right-only is incompatible with --left-only");
     -+			die(_("%s and %s are mutually exclusive"), "--right-only", "--left-only");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--right-only", "--left-only");
       		revs->right_only = 1;
       	} else if (!strcmp(arg, "--cherry")) {
       		if (revs->left_only)
      -			die("--cherry is incompatible with --left-only");
     -+			die(_("%s and %s are mutually exclusive"), "--cherry", "--left-only");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--cherry", "--left-only");
       		revs->cherry_mark = 1;
       		revs->right_only = 1;
       		revs->max_parents = 1;
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
       	} else if (!strcmp(arg, "--cherry-mark")) {
       		if (revs->cherry_pick)
      -			die("--cherry-mark is incompatible with --cherry-pick");
     -+			die(_("%s and %s are mutually exclusive"), "--cherry-mark", "--cherry-pick");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--cherry-mark", "--cherry-pick");
       		revs->cherry_mark = 1;
       		revs->limited = 1; /* needs limit_list() */
       	} else if (!strcmp(arg, "--cherry-pick")) {
       		if (revs->cherry_mark)
      -			die("--cherry-pick is incompatible with --cherry-mark");
     -+			die(_("%s and %s are mutually exclusive"), "--cherry-pick", "--cherry-mark");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--cherry-pick", "--cherry-mark");
       		revs->cherry_pick = 1;
       		revs->limited = 1;
       	} else if (!strcmp(arg, "--objects")) {
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
       	}
       	if (revs->graph && revs->track_linear)
      -		die("--show-linear-break and --graph are incompatible");
     -+		die(_("%s and %s are mutually exclusive"), "--show-linear-break", "--graph");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--show-linear-break", "--graph");
       
       	return 1;
       }
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
       
       	if (revs->reverse && revs->reflog_info)
      -		die("cannot combine --reverse with --walk-reflogs");
     -+		die(_("%s and %s are mutually exclusive"), "--reverse", "--walk-reflogs");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "--walk-reflogs");
       	if (revs->reflog_info && revs->limited)
       		die("cannot combine --walk-reflogs with history-limiting options");
       	if (revs->rewrite_parents && revs->children.name)
      -		die("cannot combine --parents and --children");
     -+		die(_("%s and %s are mutually exclusive"), "--parents", "--children");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--parents", "--children");
       
       	/*
       	 * Limitations on the graph functionality
       	 */
       	if (revs->reverse && revs->graph)
      -		die("cannot combine --reverse with --graph");
     -+		die(_("%s and %s are mutually exclusive"), "--reverse", "--graph");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--reverse", "--graph");
       
       	if (revs->reflog_info && revs->graph)
      -		die("cannot combine --walk-reflogs with --graph");
     -+		die(_("%s and %s are mutually exclusive"), "--walk-reflogs", "--graph");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--walk-reflogs", "--graph");
       	if (revs->no_walk && revs->graph)
      -		die("cannot combine --no-walk with --graph");
     -+		die(_("%s and %s are mutually exclusive"), "--no-walk", "--graph");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
       	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
      -		die("cannot use --grep-reflog without --walk-reflogs");
      +		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
     @@ t/t2026-checkout-pathspec-file.sh: test_expect_success 'error conditions' '
       
       	test_must_fail git checkout --pathspec-from-file=list --detach 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --detach" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --detach are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--detach. cannot be used together" err &&
       
       	test_must_fail git checkout --pathspec-from-file=list --patch 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
       
       	test_must_fail git checkout --pathspec-from-file=list -- fileA.t 2>err &&
       	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     @@ t/t2072-restore-pathspec-file.sh: test_expect_success 'error conditions' '
       
       	test_must_fail git restore --pathspec-from-file=list --patch --source=HEAD^1 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
       
       	test_must_fail git restore --pathspec-from-file=list --source=HEAD^1 -- fileA.t 2>err &&
       	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     @@ t/t3704-add-pathspec-file.sh: test_expect_success 'error conditions' '
       
       	test_must_fail git add --pathspec-from-file=list --interactive 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
       
       	test_must_fail git add --pathspec-from-file=list --patch 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
       
       	test_must_fail git add --pathspec-from-file=list --edit 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --edit" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --edit are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--edit. cannot be used together" err &&
       
       	test_must_fail git add --pathspec-from-file=list -- fileA.t 2>err &&
       	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     @@ t/t3909-stash-pathspec-file.sh: test_expect_success 'error conditions' '
       
       	test_must_fail git stash push --pathspec-from-file=list --patch 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
       
       	test_must_fail git stash push --pathspec-from-file=list -- fileA.t 2>err &&
       	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     @@ t/t5606-clone-options.sh: test_expect_success 'disallows --bare with --separate-
       	test_must_fail git clone --bare --separate-git-dir dot-git-destiation parent clone-bare-sgd 2>err &&
       	test_debug "cat err" &&
      -	test_i18ngrep -e "--bare and --separate-git-dir are incompatible" err
     -+	test_i18ngrep -e "--bare and --separate-git-dir are mutually exclusive" err
     ++	test_i18ngrep -e "options .--bare. and .--separate-git-dir. cannot be used together" err
       
       '
       
     @@ t/t7107-reset-pathspec-file.sh: test_expect_success 'error conditions' '
       
       	test_must_fail git reset --pathspec-from-file=list --patch 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--patch. cannot be used together" err &&
       
       	test_must_fail git reset --pathspec-from-file=list -- fileA.t 2>err &&
       	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
     @@ t/t7526-commit-pathspec-file.sh: test_expect_success 'error conditions' '
       
       	test_must_fail git commit --pathspec-from-file=list --interactive -m "Commit" 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
       
       	test_must_fail git commit --pathspec-from-file=list --patch -m "Commit" 2>err &&
      -	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
     -+	test_i18ngrep -e "--pathspec-from-file and --interactive/--patch are mutually exclusive" err &&
     ++	test_i18ngrep -e "options .--pathspec-from-file. and .--interactive/--patch. cannot be used together" err &&
       
       	test_must_fail git commit --pathspec-from-file=list --all -m "Commit" 2>err &&
       	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
  4:  d408cecc85f =  4:  88dfde62eda i18n: standardize "cannot open" and "cannot read"
  5:  b67f0e492e0 !  5:  6d89c23a248 i18n: tag.c factorize i18n strings
     @@ Commit message
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## builtin/tag.c ##
     +@@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
     + 		OPT_END()
     + 	};
     + 	int ret = 0;
     ++	const char *only_in_list = NULL;
     + 
     + 	setup_ref_filter_porcelain_msg();
     + 
      @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       		goto cleanup;
       	}
       	if (filter.lines != -1)
      -		die(_("-n option is only allowed in list mode"));
     -+		die(_("%s option is only allowed in list mode"), "-n");
     ++		only_in_list = "-n";
       	if (filter.with_commit)
      -		die(_("--contains option is only allowed in list mode"));
     -+		die(_("%s option is only allowed in list mode"), "--contains");
     ++		only_in_list = "--contains";
       	if (filter.no_commit)
      -		die(_("--no-contains option is only allowed in list mode"));
     -+		die(_("%s option is only allowed in list mode"), "--no-contains");
     ++		only_in_list = "--no-contains";
       	if (filter.points_at.nr)
      -		die(_("--points-at option is only allowed in list mode"));
     -+		die(_("%s option is only allowed in list mode"), "--points-at");
     ++		only_in_list = "--points-at";
     ++	if (only_in_list)
     ++		die("the '%s' option is only allowed in list mode", only_in_list);
       	if (filter.reachable_from || filter.unreachable_from)
       		die(_("--merged and --no-merged options are only allowed in list mode"));
       	if (cmdmode == 'd') {
  6:  653e33f7995 !  6:  f83ed5cb799 i18n: factorize "--foo requires --bar" and the like
     @@ archive.c: static int parse_archive_args(int argc, const char **argv,
      
       ## builtin/add.c ##
      @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
     - 		die(_("%s and %s are mutually exclusive"), "-A", "-u");
     + 		die(_("options '%s' and '%s' cannot be used together"), "-A", "-u");
       
       	if (!show_only && ignore_missing)
      -		die(_("Option --ignore-missing can only be used together with --dry-run"));
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
      -		die(_("-N can only be used with --mixed"));
      +		die(_("%s requires %s"), "-N", "--mixed");
       
     - 	/* Soft reset does not touch the index file nor the working tree
     - 	 * at all, but requires them in a good order.  Other resets reset
     + 	prepare_repo_settings(the_repository);
     + 	the_repository->settings.command_requires_full_index = 0;
      
       ## builtin/rm.c ##
      @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
     - 		die(_("%s, %s and %s are mutually exclusive"), "-b", "-B", "--detach");
     + 		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
      -		die(_("--reason requires --lock"));
      +		die(_("%s requires %s"), "--reason", "--lock");
  7:  4b0e1ff29cb =  7:  2b7d558f8f9 i18n: factorize "no directory given for --foo"
  8:  4c2df4522a1 !  8:  5f80ac2fa20 i18n: refactor "unrecognized %(foo) argument" strings
     @@ ref-filter.c: static int raw_atom_parser(struct ref_format *format, struct used_
       	return 0;
       }
       
     +@@ ref-filter.c: static int oid_atom_parser(struct ref_format *format, struct used_atom *atom,
     + 		if (atom->u.oid.length < MINIMUM_ABBREV)
     + 			atom->u.oid.length = MINIMUM_ABBREV;
     + 	} else
     +-		return strbuf_addf_ret(err, -1, _("unrecognized argument '%s' in %%(%s)"), arg, atom->name);
     ++		return strbuf_addf_ret(err, -1, _("unrecognized %%(%s) argument: %s"), atom->name, arg);
     + 	return 0;
     + }
     + 
      @@ ref-filter.c: static int align_atom_parser(struct ref_format *format, struct used_atom *atom,
       		else if ((position = parse_align_position(s)) >= 0)
       			align->position = position;
  9:  6196bccf086 !  9:  9dd53960c42 i18n: factorize "--foo outside a repository"
     @@ Commit message
      
       ## apply.c ##
      @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
     - 		return error(_("%s and %s are mutually exclusive"),"--reject",  "--3way");
     + 		return error(_("options '%s' and '%s' cannot be used together"),"--reject",  "--3way");
       	if (state->threeway) {
       		if (is_not_gitdir)
      -			return error(_("--3way outside a repository"));
 10:  7d97cbe7e9a = 10:  a575f566f2a i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
  -:  ----------- > 11:  89066f01f32 i18n: turn even more messages into "cannot be used together" ones

-- 
gitgitgadget
