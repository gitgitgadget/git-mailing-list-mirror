Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5CEC433FE
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiABRPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiABRPu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:15:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAF6C061761
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 09:15:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so17267163wmb.0
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GYqweZC5EF7GJbMaV27pYLzf+jxQrtBwYAwBnSgu2aM=;
        b=D2l9avmYvGd7yhFvbNVxwwiyFD6l75nJXGVT0YLEbcMnxVZzPtSxvt+pXTWQdWiTEc
         Y8HbFbe5VthjRFSVWnHq5c+FiZU1gQCTOo+oe+tGR/YUr6hyEOf1NJrri6K6J6Mtd5ba
         +MtIUaoTALErYQFPeUqN911YGvDBhjZ8iXuONwHF6+U0PFNg/2y9Gb5L97qMBdZIME+E
         2czK2+r9Ygvf/JyVUckHz5PR9NHOhoOyGbhhXvZDJj5M09H2eEE26CyDebRR+XgOgjQc
         nj4UbzAGCb8R2i+HcS3G/ZABwL4rjs46SlDLhSo6FInQ4aIMiBidORKkLqgXW49voguK
         uvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GYqweZC5EF7GJbMaV27pYLzf+jxQrtBwYAwBnSgu2aM=;
        b=Y9Ilg9ckEpaUw7QTZLhXe7ZJr0xqvfxUIf338+Tv8415vSHAxhcSCLzdUGpUNeSvdq
         nR2WqwQXY3qPHLaqDTUMxOxfByTXL9uoHrnB4jNjoQVsDr0J4NXbtkt0AL6VOFToQhDJ
         zebbOQ1EuPGdKeWkqQGoyWNgfp9Jn5NsIW+TNbwkhpyCDSttiTV53qhoGLUbRBqLPDX9
         rdm/COpVSatquwvvz4cgEdv4CZN9u+aeTdRmUxvTzDorNjC71whkbcmXhjZ8nd/gJlHF
         h8hVpJTNjU6aubi1EmOZfWWwtCaH1y4Dwgrwkvrlj2yJrTyjvrDAxB5XKU2OUgLJf9g5
         Fjew==
X-Gm-Message-State: AOAM530EbtZ9sFLhtOWDUs9RYUOJovIJrVFybNq4oXf0Il9Pss5MgoVh
        asCmB4dGq8cTpeiW1pUnLh0BX1eiVlI=
X-Google-Smtp-Source: ABdhPJy6WcySSxdAZTg28omXT3Ny1wAg5ZOug2jpohg3nLJIPXVlFefyh1HLlnvQgYydroWZE5D3Lw==
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr36376367wmb.63.1641143748121;
        Sun, 02 Jan 2022 09:15:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm34305480wmm.7.2022.01.02.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 09:15:47 -0800 (PST)
Message-Id: <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sun, 02 Jan 2022 17:15:34 +0000
Subject: [PATCH v4 00/11] Factorization of messages with similar meaning
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
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

Changes since V2:

 * fixed change of behaviour in tag.c
 * reverted sam changes as per Johannes Sixt comments

Changes since V3:

 * apply Oxford comma where needed
 * switch all options to " '%s' " style where i18n is applied.

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
 builtin/am.c                              |  6 +++---
 builtin/branch.c                          |  2 +-
 builtin/cat-file.c                        |  2 +-
 builtin/checkout.c                        | 18 +++++++++---------
 builtin/clone.c                           |  6 +++---
 builtin/commit.c                          | 17 +++++++++--------
 builtin/describe.c                        |  6 +++---
 builtin/diff-tree.c                       |  2 +-
 builtin/difftool.c                        |  4 ++--
 builtin/fast-export.c                     |  4 ++--
 builtin/fetch.c                           |  8 ++++----
 builtin/index-pack.c                      |  4 ++--
 builtin/init-db.c                         |  2 +-
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
 builtin/tag.c                             | 23 +++++++++++++----------
 builtin/worktree.c                        |  6 +++---
 diff.c                                    | 12 ++++++++----
 fetch-pack.c                              |  2 +-
 git.c                                     |  6 +++---
 http-fetch.c                              |  4 ++--
 range-diff.c                              |  2 +-
 ref-filter.c                              | 22 +++++++++++-----------
 revision.c                                | 22 +++++++++++-----------
 t/t0001-init.sh                           |  2 +-
 t/t2025-checkout-no-overlay.sh            |  2 +-
 t/t2026-checkout-pathspec-file.sh         |  8 ++++----
 t/t2072-restore-pathspec-file.sh          |  6 +++---
 t/t3431-rebase-fork-point.sh              |  2 +-
 t/t3601-rm-pathspec-file.sh               |  4 ++--
 t/t3704-add-pathspec-file.sh              | 10 +++++-----
 t/t3909-stash-pathspec-file.sh            |  6 +++---
 t/t4209-log-pickaxe.sh                    | 10 +++++-----
 t/t5606-clone-options.sh                  |  4 ++--
 t/t7107-reset-pathspec-file.sh            |  6 +++---
 t/t7500-commit-template-squash-signoff.sh | 11 ++++++-----
 t/t7526-commit-pathspec-file.sh           | 10 +++++-----
 51 files changed, 186 insertions(+), 177 deletions(-)


base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1088%2Fjnavila%2Fi18n-refactor-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1088/jnavila/i18n-refactor-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1088

Range-diff vs v3:

  1:  05af90f5814 =  1:  05af90f5814 i18n: refactor "foo and bar are mutually exclusive"
  2:  4accf1629e5 !  2:  e307ea9b998 i18n: refactor "%s, %s and %s are mutually exclusive"
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
       
       	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
      -		die(_("--gui, --tool and --extcmd are mutually exclusive"));
     -+		die(_("options '%s', '%s' and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
       
       	if (use_gui_tool)
       		setenv("GIT_MERGETOOL_GUI", "true", 1);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       
       	if (use_stdout + rev.diffopt.close_file + !!output_directory > 1)
      -		die(_("--stdout, --output, and --output-directory are mutually exclusive"));
     -+		die(_("options '%s', '%s' and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"), "--stdout", "--output", "--output-directory");
       
       	if (use_stdout) {
       		setup_pager();
     @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
      -		die(_("-b, -B, and --detach are mutually exclusive"));
     -+		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
       		die(_("--reason requires --lock"));
       	if (lock_reason)
     @@ diff.c: void diff_setup_done(struct diff_options *options)
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
      -		die(_("-G, -S and --find-object are mutually exclusive"));
     -+		die(_("options '%s', '%s' and '%s' cannot be used together"), "-G", "-S", "--find-object");
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"), "-G", "-S", "--find-object");
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
       		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
  3:  486cc6c89e2 !  3:  d5bfa26e992 i18n: turn "options are incompatible" into "cannot be used together"
     @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
       
       	if (state->apply_with_reject && state->threeway)
      -		return error(_("--reject and --3way cannot be used together."));
     -+		return error(_("options '%s' and '%s' cannot be used together"),"--reject",  "--3way");
     ++		return error(_("options '%s' and '%s' cannot be used together"), "--reject",  "--3way");
       	if (state->threeway) {
       		if (is_not_gitdir)
       			return error(_("--3way outside a repository"));
     @@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix
       
      
       ## builtin/checkout.c ##
     +@@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
     + 		die(_("'%s' cannot be used with updating paths"), "--detach");
     + 
     + 	if (opts->merge && opts->patch_mode)
     +-		die(_("'%s' cannot be used with %s"), "--merge", "--patch");
     ++		die(_("options '%s' and '%s' cannot be used together"), "--merge", "--patch");
     + 
     + 	if (opts->ignore_unmerged && opts->merge)
     +-		die(_("'%s' cannot be used with %s"),
     ++		die(_("options '%s' and '%s' cannot be used together"),
     + 		    opts->ignore_unmerged_opt, "-m");
     + 
     + 	if (opts->new_branch)
      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
       			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
       
       		if (opts->force_detach)
      -			die(_("--pathspec-from-file is incompatible with --detach"));
     -+			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file",  "--detach");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
       
       		if (opts->patch_mode)
      -			die(_("--pathspec-from-file is incompatible with --patch"));
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
       
       		if (all)
      -			die(_("--pathspec-from-file with -a does not make sense"));
     -+			die(_("options '%s' and '%s' cannot be used together"),"--pathspec-from-file", "-a");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "-a");
       
       		if (pathspec.nr)
       			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     @@ builtin/difftool.c: int cmd_difftool(int argc, const char **argv, const char *pr
      +		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
       
       	if (use_gui_tool + !!difftool_cmd + !!extcmd > 1)
     - 		die(_("options '%s', '%s' and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
     + 		die(_("options '%s', '%s', and '%s' cannot be used together"), "--gui", "--tool", "--extcmd");
      
       ## builtin/fast-export.c ##
      @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	if (keep_base) {
       		if (options.onto_name)
      -			die(_("cannot combine '--keep-base' with '--onto'"));
     -+			die(_("options '%s' and '%s' cannot be used together"),"--keep-base", "--onto");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--onto");
       		if (options.root)
      -			die(_("cannot combine '--keep-base' with '--root'"));
     -+			die(_("options '%s' and '%s' cannot be used together"),"--keep-base", "--root");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--keep-base", "--root");
       	}
       
       	if (options.root && options.fork_point > 0)
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
       	if (geometric_factor) {
       		if (pack_everything)
      -			die(_("--geometric is incompatible with -A, -a"));
     -+			die(_("options '%s' and '%s' cannot be used together"),"--geometric", "-A/-a");
     ++			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
       		init_pack_geometry(&geometry);
       		split_pack_geometry(geometry, geometric_factor);
       	}
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       		if (skip_prefix(arg, "--missing=", &arg)) {
       			if (revs.exclude_promisor_objects)
      -				die(_("cannot combine --exclude-promisor-objects and --missing"));
     -+				die(_("options '%s' and '%s' cannot be used together"),"--exclude-promisor-objects", "--missing");
     ++				die(_("options '%s' and '%s' cannot be used together"), "--exclude-promisor-objects", "--missing");
       			if (parse_missing_action_value(arg))
       				break;
       		}
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
       		colopts = 0;
       	}
       	sorting = ref_sorting_options(&sorting_options);
     +@@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
     + 
     + 	if (msg.given || msgfile) {
     + 		if (msg.given && msgfile)
     +-			die(_("only one -F or -m option is allowed."));
     ++			die(_("options '%s' and '%s' cannot be used together"), "-F", "-m");
     + 		if (msg.given)
     + 			strbuf_addbuf(&buf, &(msg.buf));
     + 		else {
      
       ## revision.c ##
      @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
      -		die("cannot combine --no-walk with --graph");
      +		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
       	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
     --		die("cannot use --grep-reflog without --walk-reflogs");
     -+		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
     + 		die("cannot use --grep-reflog without --walk-reflogs");
       
     - 	if (revs->line_level_traverse &&
     - 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
      
       ## t/t2026-checkout-pathspec-file.sh ##
      @@ t/t2026-checkout-pathspec-file.sh: test_expect_success 'error conditions' '
  4:  a2b42087342 =  4:  51c53f01dd8 i18n: standardize "cannot open" and "cannot read"
  5:  2d83654c48a !  5:  a9d8a50d666 i18n: tag.c factorize i18n strings
     @@ builtin/tag.c: int cmd_tag(int argc, const char **argv, const char *prefix)
      +	if (only_in_list)
      +		die(_("the '%s' option is only allowed in list mode"), only_in_list);
       	if (filter.reachable_from || filter.unreachable_from)
     - 		die(_("--merged and --no-merged options are only allowed in list mode"));
     +-		die(_("--merged and --no-merged options are only allowed in list mode"));
     ++		die(_("'--merged' and '--no-merged' options are only allowed in list mode"));
       	if (cmdmode == 'd') {
     + 		ret = delete_tags(argv);
     + 		goto cleanup;
  6:  1097cc7d6d1 !  6:  969946274aa i18n: factorize "--foo requires --bar" and the like
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
       ## builtin/worktree.c ##
      @@ builtin/worktree.c: static int add(int ac, const char **av, const char *prefix)
       	if (!!opts.detach + !!new_branch + !!new_branch_force > 1)
     - 		die(_("options '%s', '%s' and '%s' cannot be used together"), "-b", "-B", "--detach");
     + 		die(_("options '%s', '%s', and '%s' cannot be used together"),"-b", "-B", "--detach");
       	if (lock_reason && !keep_locked)
      -		die(_("--reason requires --lock"));
      +		die(_("the option '%s' requires '%s'"), "--reason", "--lock");
     @@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *re
       	if (revs->no_walk && revs->graph)
       		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
       	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
     --		die(_("%s requires %s"), "--grep-reflog", "--walk-reflogs");
     +-		die("cannot use --grep-reflog without --walk-reflogs");
      +		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
       
       	if (revs->line_level_traverse &&
  7:  4c17e08b9d3 !  7:  052dc06beeb i18n: factorize "no directory given for --foo"
     @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
       		} else if (!strcmp(cmd, "--git-dir")) {
       			if (*argc < 2) {
      -				fprintf(stderr, _("no directory given for --git-dir\n" ));
     -+				fprintf(stderr, _("no directory given for %s\n" ), "--git-dir");
     ++				fprintf(stderr, _("no directory given for '%s' option\n" ), "--git-dir");
       				usage(git_usage_string);
       			}
       			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
     @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
       		} else if (!strcmp(cmd, "--work-tree")) {
       			if (*argc < 2) {
      -				fprintf(stderr, _("no directory given for --work-tree\n" ));
     -+				fprintf(stderr, _("no directory given for %s\n" ), "--work-tree");
     ++				fprintf(stderr, _("no directory given for '%s' option\n" ), "--work-tree");
       				usage(git_usage_string);
       			}
       			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
     @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
       		} else if (!strcmp(cmd, "-C")) {
       			if (*argc < 2) {
      -				fprintf(stderr, _("no directory given for -C\n" ));
     -+				fprintf(stderr, _("no directory given for %s\n" ), "-C");
     ++				fprintf(stderr, _("no directory given for '%s' option\n" ), "-C");
       				usage(git_usage_string);
       			}
       			if ((*argv)[1][0]) {
  8:  b75c5b1ce35 =  8:  59e1e8aa1b4 i18n: refactor "unrecognized %(foo) argument" strings
  9:  44d715a224c !  9:  39e375c68ab i18n: factorize "--foo outside a repository"
     @@ Commit message
      
       ## apply.c ##
      @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
     - 		return error(_("options '%s' and '%s' cannot be used together"),"--reject",  "--3way");
     + 		return error(_("options '%s' and '%s' cannot be used together"), "--reject",  "--3way");
       	if (state->threeway) {
       		if (is_not_gitdir)
      -			return error(_("--3way outside a repository"));
     -+			return error(_("%s outside a repository"), "--3way");
     ++			return error(_("'%s' outside a repository"), "--3way");
       		state->check_index = 1;
       	}
       	if (state->apply_with_reject) {
     @@ apply.c: int check_apply_state(struct apply_state *state, int force_apply)
       		state->apply = 0;
       	if (state->check_index && is_not_gitdir)
      -		return error(_("--index outside a repository"));
     -+		return error(_("%s outside a repository"), "--index");
     ++		return error(_("'%s' outside a repository"), "--index");
       	if (state->cached) {
       		if (is_not_gitdir)
      -			return error(_("--cached outside a repository"));
     -+			return error(_("%s outside a repository"), "--cached");
     ++			return error(_("'%s' outside a repository"), "--cached");
       		state->check_index = 1;
       	}
       	if (state->ita_only && (state->check_index || is_not_gitdir))
 10:  03a880d534b = 10:  c6161bc3f1a i18n: ref-filter: factorize "%(foo) atom used without %(bar) atom"
 11:  12c5da81087 ! 11:  4fab0db3cc4 i18n: turn even more messages into "cannot be used together" ones
     @@ builtin/add.c: int cmd_add(int argc, const char **argv, const char *prefix)
       	if (pathspec_from_file) {
       		if (pathspec.nr)
      -			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     -+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
     ++			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
       
       		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
       				    PATHSPEC_PREFER_FULL |
     @@ builtin/am.c: static int parse_opt_show_current_patch(const struct option *opt,
       	if (resume->mode == RESUME_SHOW_PATCH && new_value != resume->sub_mode)
      -		return error(_("--show-current-patch=%s is incompatible with "
      -			       "--show-current-patch=%s"),
     -+		return error(_("options '--show-current-patch=%s' and '--show-current-patch=%s' "
     +-			     arg, valid_modes[resume->sub_mode]);
     ++		return error(_("options '%s=%s' and '%s=%s' "
      +					   "cannot be used together"),
     - 			     arg, valid_modes[resume->sub_mode]);
     ++					 "--show-current-patch", "--show-current-patch", arg, valid_modes[resume->sub_mode]);
       
       	resume->mode = RESUME_SHOW_PATCH;
     + 	resume->sub_mode = new_value;
      
       ## builtin/cat-file.c ##
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       
       	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
      -		die(_("-%c, -%c and --orphan are mutually exclusive"),
     -+		die(_("options '-%c', '-%c' and '--orphan' cannot be used together"),
     - 				cb_option, toupper(cb_option));
     +-				cb_option, toupper(cb_option));
     ++		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
     ++			cb_option, toupper(cb_option), "--orphan");
       
       	if (opts->overlay_mode == 1 && opts->patch_mode)
     + 		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
       
       	if (opts->pathspec_from_file) {
       		if (opts->pathspec.nr)
      -			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     -+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
     ++			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
       
       		if (opts->force_detach)
     - 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file",  "--detach");
     + 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--detach");
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       	if (option_bare) {
       		if (option_origin)
      -			die(_("--bare and --origin %s options are incompatible."),
     -+			die(_("options '--bare' and '--origin %s' cannot be used together"),
     - 			    option_origin);
     +-			    option_origin);
     ++			die(_("options '%s' and '%s %s' cannot be used together"),
     ++			    "--bare", "--origin", option_origin);
       		if (real_git_dir)
       			die(_("options '%s' and '%s' cannot be used together"), "--bare", "--separate-git-dir");
     + 		option_no_checkout = 1;
      
       ## builtin/commit.c ##
      @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
     - 			die(_("options '%s' and '%s' cannot be used together"),"--pathspec-from-file", "-a");
     + 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "-a");
       
       		if (pathspec.nr)
      -			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     -+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
     ++			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
       
       		parse_pathspec_file(&pathspec, 0,
       				    PATHSPEC_PREFER_FULL,
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
       		if (!strcmp(fixup_prefix, "amend")) {
       			if (have_option_m)
      -				die(_("cannot combine -m with --fixup:%s"), fixup_message);
     -+				die(_("options '-m' and '--fixup:%s' cannot be used together"), fixup_message);
     ++				die(_("options '%s' and '%s:%s' cannot be used together"), "-m", "--fixup", fixup_message);
       			prepare_amend_commit(commit, &sb, &ctx);
       		}
       	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
     @@ builtin/commit.c: static void check_fixup_reword_options(int argc, const char *a
       	}
       	if (argc)
      -		die(_("cannot combine reword option of --fixup with path '%s'"), *argv);
     -+		die(_("reword option of --fixup and path '%s' cannot be used together"), *argv);
     ++		die(_("reword option of '%s' and path '%s' cannot be used together"), "--fixup", *argv);
       	if (patch_interactive || interactive || all || also || only)
      -		die(_("reword option of --fixup is mutually exclusive with --patch/--interactive/--all/--include/--only"));
     -+		die(_("reword option of --fixup and "
     -+			  "--patch/--interactive/--all/--include/--only "
     -+			  "cannot be used together"));
     ++		die(_("reword option of '%s' and '%s' cannot be used together"),
     ++			"--fixup", "--patch/--interactive/--all/--include/--only");
       }
       
       static int parse_and_validate_options(int argc, const char *argv[],
     @@ builtin/reset.c: int cmd_reset(int argc, const char **argv, const char *prefix)
       
       		if (pathspec.nr)
      -			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     -+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
     ++			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
       
       		parse_pathspec_file(&pathspec, 0,
       				    PATHSPEC_PREFER_FULL,
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       	    (revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
       	    (revs.left_right || revs.cherry_mark))
      -		die(_("marked counting is incompatible with --objects"));
     -+		die(_("marked counting and '--objects' cannot be used together"));
     ++		die(_("marked counting and '%s' cannot be used together"), "--objects");
       
       	save_commit_buffer = (revs.verbose_header ||
       			      revs.grep_filter.pattern_list ||
     @@ builtin/rm.c: int cmd_rm(int argc, const char **argv, const char *prefix)
       	if (pathspec_from_file) {
       		if (pathspec.nr)
      -			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     -+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
     ++			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
       
       		parse_pathspec_file(&pathspec, 0,
       				    PATHSPEC_PREFER_CWD,
     @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
       
       		if (ps.nr)
      -			die(_("--pathspec-from-file is incompatible with pathspec arguments"));
     -+			die(_("'--pathspec-from-file' and pathspec arguments cannot be used together"));
     ++			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
       
       		parse_pathspec_file(&ps, 0,
       				    PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
     @@ diff.c: void diff_setup_done(struct diff_options *options)
       
       	if (HAS_MULTI_BITS(options->output_format & check_mask))
      -		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
     -+		die(_("options '--name-only', '--name-status', '--check' and '-s' cannot be used together"));
     ++		die(_("options '%s', '%s', '%s', and '%s' cannot be used together"),
     ++			"--name-only", "--name-status", "--check", "-s");
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
     - 		die(_("options '%s', '%s' and '%s' cannot be used together"), "-G", "-S", "--find-object");
     +-		die(_("options '%s', '%s', and '%s' cannot be used together"), "-G", "-S", "--find-object");
     ++		die(_("options '%s', '%s', and '%s' cannot be used together"),
     ++			"-G", "-S", "--find-object");
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_G_REGEX_MASK))
      -		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
     -+		die(_("-G and --pickaxe-regex cannot be used together, use --pickaxe-regex with -S"));
     ++		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s'"),
     ++			"-G", "--pickaxe-regex", "--pickaxe-regex", "-S");
       
       	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
      -		die(_("--pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
     -+		die(_("--pickaxe-all and --find-object cannot be used together, use --pickaxe-all with -G and -S"));
     ++		die(_("options '%s' and '%s' cannot be used together, use '%s' with '%s' and '%s'"),
     ++			"--pickaxe-all", "--find-object", "--pickaxe-all", "-G", "-S");
       
       	/*
       	 * Most of the time we can say "there are changes"
     @@ t/t7500-commit-template-squash-signoff.sh: test_expect_success 'amend! commit al
       	test_expect_success "--fixup=reword: incompatible with $1" "
      -		echo 'fatal: reword option of --fixup is mutually exclusive with'\
      -			'--patch/--interactive/--all/--include/--only' >expect &&
     -+		echo 'fatal: reword option of --fixup and' \
     -+			'--patch/--interactive/--all/--include/--only' \
     ++		echo 'fatal: reword option of '\''--fixup'\'' and' \
     ++			''\''--patch/--interactive/--all/--include/--only'\' \
      +			'cannot be used together' >expect &&
       		test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
       		test_cmp expect actual
     @@ t/t7500-commit-template-squash-signoff.sh: done
       test_expect_success '--fixup=reword: give error with pathsec' '
       	commit_for_rebase_autosquash_setup &&
      -	echo "fatal: cannot combine reword option of --fixup with path '\''foo'\''" >expect &&
     -+	echo "fatal: reword option of --fixup and path '\''foo'\'' cannot be used together" >expect &&
     ++	echo "fatal: reword option of '\''--fixup'\'' and path '\''foo'\'' cannot be used together" >expect &&
       	test_must_fail git commit --fixup=reword:HEAD~ -- foo 2>actual &&
       	test_cmp expect actual
       '

-- 
gitgitgadget
