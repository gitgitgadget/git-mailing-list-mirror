Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C4C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087472073E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQAQHp+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD2K0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2K0r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5AC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so1818725wrw.12
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=T0c6W/iiHt4eRAs0K/ttKtgTp6fC1eA1edkB0sFP2/k=;
        b=NQAQHp+Jn08lasHKs3KD1w+zaTdsdoXSELZzCCcCbzLW6txKhxHFOjGwn1TIlNveAq
         oOlgiZkwG94eTGJWjtRGSbklycp6b56W3WElF8XsjKjFo4BRGuyfDiINEB+6szEJTGr2
         Lfqdzq3OxhL0NxDP5tp/smyeVjQGU+vQBMGCvsSdt2XfiMrFwIpI2GvoaObdv3BTiWWo
         jWwdKOj5SuRm0EGgGDQVTINEal9rJi0PuBV2VP1CbDYJftOt55EkVeqVHnPieH5dZMmZ
         OHGD87BYR72s1O6p9txFdvNAMksJaVFRNrBeV1H9vHUe4LjzvmVPB8eS5iwXxnYFDiT9
         GAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=T0c6W/iiHt4eRAs0K/ttKtgTp6fC1eA1edkB0sFP2/k=;
        b=f4xedTmyUhGFPTX5EWxczLqhSoQ8UbH+tadLKDOwr4Tuu/NshQyJocqtLrZYfmCKAC
         l8e2narnLRrbZciEUnB2XAqZPR1aIbaVI4BHELc6rI30hjGg7zkEzwLH1XOA//rBlEia
         HP4nNplC9TVtVXvjSmZ2S2/EtTIC6D8+jUgAL0hiTEfHfTBiAO0R+9BPmnw9bLAx3AvJ
         6W6jXnKwWg7Jyh/OOFxjUYnXUeK/QQszdaBolsp/VRwFmov4Tx1cqtuVpTmZ1pLjujjC
         v54d2F5KSPDHD66QKRoksa1iHILWdbUsP7jy1JAdos2gB3FWupapcbIiYwKW/BWpKSCW
         99og==
X-Gm-Message-State: AGi0PubCm20VNrXGos2vRCNYklfmd48/eic7IZqxy019l2GhpOr6qAQS
        ADYy7MTGggmbW7chXfI5OXk=
X-Google-Smtp-Source: APiQypKPv7F4Hja+2p92aXp/XW+snqeCP1/PKEivKr6PlDLB7BcZtgzTyFSmC9ke5rItubR/GP1DsQ==
X-Received: by 2002:adf:8284:: with SMTP id 4mr38372205wrc.6.1588156004861;
        Wed, 29 Apr 2020 03:26:44 -0700 (PDT)
Received: from localhost.localdomain (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id c1sm30718196wrc.4.2020.04.29.03.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:26:44 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 0/5] cleanup ra/rebase-i-more-options
Date:   Wed, 29 Apr 2020 11:25:16 +0100
Message-Id: <20200429102521.47995-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've rebased Rohit's patches on master and reworked them with my
fixups from v1. I've renamed the test file that was causing a
problem (as you'll see I wasn't feeling very inspired when I came
up with the name) and changed some tests from using rebase -i to
rebase -m as suggested by Elijah. I've updated the last patch to
test both --reset-author and --ignore-author.

There's a range-diff below between ra/rebase-i-more-options and
these patches though I'm not sure how useful it is in practice.

Phillip Wood (2):
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (3):
  rebase -i: add --ignore-whitespace flag
  sequencer: rename amend_author to author_to_free
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  26 ++-
 builtin/rebase.c                       |  46 ++++--
 sequencer.c                            | 111 ++++++++++++-
 sequencer.h                            |   2 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 209 +++++++++++++++++++++++++
 6 files changed, 371 insertions(+), 25 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

1:  ba51d2fb24 ! 1:  5ef315240a rebase -i: add --ignore-whitespace flag
    @@ Metadata
      ## Commit message ##
         rebase -i: add --ignore-whitespace flag
     
    -    There are two backends available for rebasing, viz, the am and the
    -    interactive. Naturally, there shall be some features that are
    -    implemented in one but not in the other. One such flag is
    -    --ignore-whitespace which indicates merge mechanism to treat lines
    -    with only whitespace changes as unchanged. Wire the interactive
    -    rebase to also understand the --ignore-whitespace flag by
    -    translating it to -Xignore-space-change.
    +    Rebase is implemented with two different backends - 'apply' and 'merge'
    +    each of which support a different set of options. In particuar the apply
    +    backend supports a number of options implemented by 'git am' that are
    +    not available to the merge backend. As part of an on going effort to
    +    remove the apply backend this patch adds support for the
    +    --ignore-whitespace option to the merge backend. This option treats
    +    lines with only whitespace changes as unchanged and is implemented in
    +    the merge backend by translating it to -Xignore-space-change.
     
         Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-rebase.txt ##
    -@@ Documentation/git-rebase.txt: If either <upstream> or --root is given on the command line, then the
    - default is `--no-fork-point`, otherwise the default is `--fork-point`.
    +@@ Documentation/git-rebase.txt: your branch contains commits which were dropped, this option can be used
    + with `--keep-base` in order to drop those commits from your branch.
      
      --ignore-whitespace::
     +	Behaves differently depending on which backend is selected.
     ++
    -+'am' backend: When applying a patch, ignore changes in whitespace in
    -+context lines if necessary.
    ++apply backend: When applying a patch, ignore changes in whitespace in
    ++context lines.
     ++
    -+'interactive' backend: Treat lines with only whitespace changes as
    -+unchanged for the sake of a three-way merge.
    ++merge backend: Treat lines with only whitespace changes as unchanged
    ++when merging.
     +
      --whitespace=<option>::
    --	These flag are passed to the 'git apply' program
    +-	These flags are passed to the 'git apply' program
     +	This flag is passed to the 'git apply' program
      	(see linkgit:git-apply[1]) that applies the patch.
    + 	Implies --apply.
      +
    - See also INCOMPATIBLE OPTIONS below.
     @@ Documentation/git-rebase.txt: The following options:
    +  * --apply
       * --committer-date-is-author-date
       * --ignore-date
    -  * --whitespace
     - * --ignore-whitespace
    +  * --whitespace
       * -C
      
    - are incompatible with the following options:
     @@ Documentation/git-rebase.txt: In addition, the following pairs of options are incompatible:
    -  * --preserve-merges and --interactive
       * --preserve-merges and --signoff
       * --preserve-merges and --rebase-merges
    +  * --preserve-merges and --empty=
     + * --preserve-merges and --ignore-whitespace
    -  * --rebase-merges and --strategy
    -  * --rebase-merges and --strategy-option
    +  * --keep-base and --onto
    +  * --keep-base and --root
      
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: struct rebase_options {
    + 	int signoff;
      	int allow_rerere_autoupdate;
    - 	int keep_empty;
      	int autosquash;
     +	int ignore_whitespace;
      	char *gpg_sign_opt;
    @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_
     +	if (strategy_buf.len)
     +		parse_strategy_opts(&replay, strategy_buf.buf);
      
    + 	if (opts->squash_onto) {
    + 		oidcpy(&replay.squash_onto, opts->squash_onto);
    + 		replay.have_squash_onto = 1;
    + 	}
    + 
     +	strbuf_release(&strategy_buf);
      	return replay;
      }
      
     @@ builtin/rebase.c: int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
    - 	argc = parse_options(argc, argv, NULL, options,
    + 	argc = parse_options(argc, argv, prefix, options,
      			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
      
     +	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
    @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      test_rebase_am_only -C4
      
     
    - ## t/t3433-rebase-options-compatibility.sh (new) ##
    + ## t/t3436-rebase-more-options.sh (new) ##
     @@
     +#!/bin/sh
     +#
    @@ t/t3433-rebase-options-compatibility.sh (new)
     +
     +. ./test-lib.sh
     +
    ++. "$TEST_DIRECTORY"/lib-rebase.sh
    ++
     +# This is a special case in which both am and interactive backends
     +# provide the same output. It was done intentionally because
     +# both the backends fall short of optimal behaviour.
    @@ t/t3433-rebase-options-compatibility.sh (new)
     +	git tag main
     +'
     +
    -+test_expect_success '--ignore-whitespace works with am backend' '
    ++test_expect_success '--ignore-whitespace works with apply backend' '
     +	cat >expect <<-\EOF &&
     +	line 1
     +	new line 2
     +	line 3
     +	EOF
    -+	test_must_fail git rebase main side &&
    ++	test_must_fail git rebase --apply main side &&
     +	git rebase --abort &&
    -+	git rebase --ignore-whitespace main side &&
    ++	git rebase --apply --ignore-whitespace main side &&
     +	test_cmp expect file
     +'
     +
    -+test_expect_success '--ignore-whitespace works with interactive backend' '
    ++test_expect_success '--ignore-whitespace works with merge backend' '
     +	cat >expect <<-\EOF &&
     +	line 1
     +	new line 2
    @@ t/t3433-rebase-options-compatibility.sh (new)
     +	test_cmp expect file
     +'
     +
    ++test_expect_success '--ignore-whitespace is remembered when continuing' '
    ++	cat >expect <<-\EOF &&
    ++	line 1
    ++	new line 2
    ++	line 3
    ++	EOF
    ++	(
    ++		set_fake_editor &&
    ++		FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
    ++	) &&
    ++	git rebase --continue &&
    ++	test_cmp expect file
    ++'
    ++
    ++# This must be the last test in this file
    ++test_expect_success '$EDITOR and friends are unchanged' '
    ++	test_editor_unchanged
    ++'
    ++
     +test_done
2:  c068bcc59b < -:  ---------- sequencer: allow callers of read_author_script() to ignore fields
3:  cbd8db17ac ! 2:  55eb3a7efc rebase -i: support --committer-date-is-author-date
    @@
      ## Metadata ##
    -Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +Author: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Commit message ##
         rebase -i: support --committer-date-is-author-date
     
    -    rebase am already has this flag to "lie" about the committer date
    -    by changing it to the author date. Let's add the same for
    -    interactive machinery.
    +    As part of the on-going effort to retire the apply rebase backend teach
    +    the merge backend how to handle --committer-date-is-author-date.
     
    -    Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-rebase.txt ##
    -@@ Documentation/git-rebase.txt: unchanged for the sake of a three-way merge.
    +@@ Documentation/git-rebase.txt: when merging.
      See also INCOMPATIBLE OPTIONS below.
      
      --committer-date-is-author-date::
    -+	Instead of recording the time the rebased commits are
    -+	created as the committer date, reuse the author date
    -+	as the committer date. This implies --force-rebase.
    ++	Instead of using the current time as the committer date, use
    ++	the author date of the commit being rebased as the committer
    ++	date. This option implies --force-rebase.
     +
      --ignore-date::
     -	These flags are passed to 'git am' to easily change the dates
    @@ Documentation/git-rebase.txt: unchanged for the sake of a three-way merge.
      See also INCOMPATIBLE OPTIONS below.
      
     @@ Documentation/git-rebase.txt: INCOMPATIBLE OPTIONS
    - 
      The following options:
      
    +  * --apply
     - * --committer-date-is-author-date
       * --ignore-date
       * --whitespace
       * -C
     @@ Documentation/git-rebase.txt: In addition, the following pairs of options are incompatible:
    -  * --preserve-merges and --signoff
       * --preserve-merges and --rebase-merges
    +  * --preserve-merges and --empty=
       * --preserve-merges and --ignore-whitespace
     + * --preserve-merges and --committer-date-is-author-date
    -  * --rebase-merges and --strategy
    -  * --rebase-merges and --strategy-option
    +  * --keep-base and --onto
    +  * --keep-base and --root
      
     
      ## builtin/rebase.c ##
    @@ builtin/rebase.c: struct rebase_options {
      	int allow_empty_message;
      	int rebase_merges, rebase_cousins;
     @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_options *opts)
    - 	replay.allow_empty_message = opts->allow_empty_message;
    + 	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
      	replay.verbose = opts->flags & REBASE_VERBOSE;
      	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
     +	replay.committer_date_is_author_date =
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
      		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 		    state_dir_base, cmd_live_rebase, buf.buf);
    + 	    options.autosquash) {
    + 		allow_preemptive_ff = 0;
      	}
    - 
     +	if (options.committer_date_is_author_date)
     +		options.flags |= REBASE_FORCE;
    -+
    + 
      	for (i = 0; i < options.git_am_opts.argc; i++) {
      		const char *option = options.git_am_opts.argv[i], *p;
     -		if (!strcmp(option, "--committer-date-is-author-date") ||
     -		    !strcmp(option, "--ignore-date") ||
     +		if (!strcmp(option, "--ignore-date") ||
      		    !strcmp(option, "--whitespace=fix") ||
      		    !strcmp(option, "--whitespace=strip"))
    - 			options.flags |= REBASE_FORCE;
    + 			allow_preemptive_ff = 0;
     
      ## sequencer.c ##
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
    @@ sequencer.c: static char *get_author(const char *message)
      	return NULL;
      }
      
    -+/* Returns a "date" string that needs to be free()'d by the caller */
    -+static char *read_author_date_or_null(void)
    ++static const char *author_date_from_env_array(const struct argv_array *env)
     +{
    -+	char *date;
    ++	int i;
    ++	const char *date;
     +
    -+	if (read_author_script(rebase_path_author_script(),
    -+			       NULL, NULL, &date, 0))
    -+		return NULL;
    -+	return date;
    ++	for (i = 0; i < env->argc; i++)
    ++		if (skip_prefix(env->argv[i],
    ++				"GIT_AUTHOR_DATE=", &date))
    ++			return date;
    ++	/*
    ++	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
    ++	 * reading the script
    ++	 */
    ++	BUG("GIT_AUTHOR_DATE missing from author script");
     +}
     +
      static const char staged_changes_advice[] =
      N_("you have staged changes in your working tree\n"
      "If these changes are meant to be squashed into the previous commit, run:\n"
     @@ sequencer.c: static int run_git_commit(struct repository *r,
    + 			     gpg_opt, gpg_opt);
    + 	}
      
    - 	cmd.git_cmd = 1;
    - 
    -+	if (opts->committer_date_is_author_date) {
    -+		int res = -1;
    -+		struct strbuf datebuf = STRBUF_INIT;
    -+		char *date = read_author_date_or_null();
    -+
    -+		if (!date)
    -+			return -1;
    -+
    -+		strbuf_addf(&datebuf, "@%s", date);
    -+		res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
    -+
    -+		strbuf_release(&datebuf);
    -+		free(date);
    -+
    -+		if (res)
    -+			return -1;
    -+	}
    ++	if (opts->committer_date_is_author_date)
    ++		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
    ++				 author_date_from_env_array(&cmd.env_array));
     +
    - 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
    - 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
    + 	argv_array_push(&cmd.args, "commit");
      
    + 	if (!(flags & VERIFY_MSG))
     @@ sequencer.c: static int try_to_commit(struct repository *r,
      
      	if (parse_head(r, &current_head))
      		return -1;
     -
      	if (flags & AMEND_MSG) {
    - 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
    + 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
      		const char *out_enc = get_commit_output_encoding();
     @@ sequencer.c: static int try_to_commit(struct repository *r,
      		commit_list_insert(current_head, &parents);
    @@ sequencer.c: static int try_to_commit(struct repository *r,
     +		struct strbuf date = STRBUF_INIT;
     +
     +		if (split_ident_line(&ident, author, len) < 0) {
    -+			res = error(_("malformed ident line"));
    ++			res = error(_("malformed ident line '%s'"), author);
     +			goto out;
     +		}
     +		if (!ident.date_begin) {
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      			opts->reschedule_failed_exec = 1;
      
     @@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_name,
    - 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
    - 	if (opts->signoff)
    - 		write_file(rebase_path_signoff(), "--signoff\n");
    + 		write_file(rebase_path_drop_redundant_commits(), "%s", "");
    + 	if (opts->keep_redundant_commits)
    + 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
     +	if (opts->committer_date_is_author_date)
     +		write_file(rebase_path_cdate_is_adate(), "%s", "");
      	if (opts->reschedule_failed_exec)
      		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
      
    +@@ sequencer.c: static int do_merge(struct repository *r,
    + 			goto leave_merge;
    + 		}
    + 
    ++		if (opts->committer_date_is_author_date)
    ++			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
    ++					 author_date_from_env_array(&cmd.env_array));
    ++
    + 		cmd.git_cmd = 1;
    + 		argv_array_push(&cmd.args, "merge");
    + 		argv_array_push(&cmd.args, "-s");
     @@ sequencer.c: static int pick_commits(struct repository *r,
      	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
      	if (opts->allow_ff)
    @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      
      test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
     
    - ## t/t3433-rebase-options-compatibility.sh ##
    -@@ t/t3433-rebase-options-compatibility.sh: test_description='tests to ensure compatibility between am and interactive backe
    + ## t/t3436-rebase-more-options.sh ##
    +@@ t/t3436-rebase-more-options.sh: test_description='tests to ensure compatibility between am and interactive backe
      
    - . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-rebase.sh
      
     +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
     +export GIT_AUTHOR_DATE
     +
      # This is a special case in which both am and interactive backends
      # provide the same output. It was done intentionally because
      # both the backends fall short of optimal behaviour.
    -@@ t/t3433-rebase-options-compatibility.sh: test_expect_success 'setup' '
    +@@ t/t3436-rebase-more-options.sh: test_expect_success 'setup' '
      	EOF
      	git commit -am "update file" &&
      	git tag side &&
    @@ t/t3433-rebase-options-compatibility.sh: test_expect_success 'setup' '
      	sed -e "s/^|//" >file <<-\EOF &&
      	|line 1
      	|        line 2
    -@@ t/t3433-rebase-options-compatibility.sh: test_expect_success '--ignore-whitespace works with interactive backend' '
    +@@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-whitespace is remembered when continuing' '
      	test_cmp expect file
      '
      
    -+test_expect_success '--committer-date-is-author-date works with am backend' '
    -+	git commit --amend &&
    -+	git rebase --committer-date-is-author-date HEAD^ &&
    -+	git show HEAD --pretty="format:%ai" >authortime &&
    -+	git show HEAD --pretty="format:%ci" >committertime &&
    ++test_expect_success '--committer-date-is-author-date works with apply backend' '
    ++	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
    ++	git rebase --apply --committer-date-is-author-date HEAD^ &&
    ++	git log -1 --pretty="format:%ai" >authortime &&
    ++	git log -1 --pretty="format:%ci" >committertime &&
     +	test_cmp authortime committertime
     +'
     +
    -+test_expect_success '--committer-date-is-author-date works with interactive backend' '
    -+	git commit --amend &&
    -+	git rebase -i --committer-date-is-author-date HEAD^ &&
    -+	git show HEAD --pretty="format:%ai" >authortime &&
    -+	git show HEAD --pretty="format:%ci" >committertime &&
    ++test_expect_success '--committer-date-is-author-date works with merge backend' '
    ++	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
    ++	git rebase -m --committer-date-is-author-date HEAD^ &&
    ++	git log -1 --pretty="format:%ai" >authortime &&
    ++	git log -1 --pretty="format:%ci" >committertime &&
     +	test_cmp authortime committertime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works with rebase -r' '
     +	git checkout side &&
    -+	git merge --no-ff commit3 &&
    ++	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
     +	git rebase -r --root --committer-date-is-author-date &&
    -+	git rev-list HEAD >rev_list &&
    -+	while read HASH
    -+	do
    -+		git show $HASH --pretty="format:%ai" >authortime
    -+		git show $HASH --pretty="format:%ci" >committertime
    -+		test_cmp authortime committertime
    -+	done <rev_list
    ++	git log --pretty="format:%ai" >authortime &&
    ++	git log --pretty="format:%ci" >committertime &&
    ++	test_cmp authortime committertime
     +'
     +
    - test_done
    ++test_expect_success '--committer-date-is-author-date works when forking merge' '
    ++	git checkout side &&
    ++	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
    ++	git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
    ++	git log --pretty="format:%ai" >authortime &&
    ++	git log --pretty="format:%ci" >committertime &&
    ++	test_cmp authortime committertime
    ++
    ++'
    ++
    ++test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
    ++	git checkout commit2 &&
    ++	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
    ++	git log -1 --format=%at HEAD >expect &&
    ++	test_must_fail git rebase -m --committer-date-is-author-date \
    ++		--onto HEAD^^ HEAD^ &&
    ++	echo resolved > foo &&
    ++	git add foo &&
    ++	git rebase --continue &&
    ++	git log -1 --format=%ct HEAD >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + # This must be the last test in this file
    + test_expect_success '$EDITOR and friends are unchanged' '
    + 	test_editor_unchanged
4:  0185c683c9 ! 3:  19352fdc22 sequencer: rename amend_author to author_to_rename
    @@ Metadata
     Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
     
      ## Commit message ##
    -    sequencer: rename amend_author to author_to_rename
    +    sequencer: rename amend_author to author_to_free
     
         The purpose of amend_author was to free() the malloc()'d string
    -    obtained from get_author() while amending a commit. But we can
    +    obtained from get_author() when amending a commit. But we can
         also use the variable to free() the author at our convenience.
         Rename it to convey this meaning.
     
         Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## sequencer.c ##
     @@ sequencer.c: static int try_to_commit(struct repository *r,
5:  08187b4cba ! 4:  5e971abb74 rebase -i: support --ignore-date
    @@
      ## Metadata ##
    -Author: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +Author: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Commit message ##
         rebase -i: support --ignore-date
     
    -    rebase am already has this flag to "lie" about the author date
    -    by changing it to the committer (current) date. Let's add the same
    -    for interactive machinery.
    +    As part of the on-going effort to retire the apply rebase backend
    +    teach the merge backend how to handle --ignore-date. We take care to
    +    handle the combination of --ignore-date and
    +    --committer-date-is-author-date in the same way as the apply backend.
     
    -    Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
    +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
      ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
    - 	as the committer date. This implies --force-rebase.
    + 	date. This option implies --force-rebase.
      
      --ignore-date::
     -	This flag is passed to 'git am' to change the author date
     -	of each rebased commit (see linkgit:git-am[1]).
    -+	Instead of using the given author date, reset it to the
    -+	current time. This implies --force-rebase.
    ++	Instead of using the author date of the original commit, use
    ++	the current time as the	author date of the rebased commit.  This
    ++	option implies `--force-rebase`.
      +
      See also INCOMPATIBLE OPTIONS below.
      
     @@ Documentation/git-rebase.txt: INCOMPATIBLE OPTIONS
    - 
      The following options:
      
    +  * --apply
     - * --ignore-date
       * --whitespace
       * -C
      
     @@ Documentation/git-rebase.txt: In addition, the following pairs of options are incompatible:
    -  * --preserve-merges and --rebase-merges
    +  * --preserve-merges and --empty=
       * --preserve-merges and --ignore-whitespace
       * --preserve-merges and --committer-date-is-author-date
     + * --preserve-merges and --ignore-date
    -  * --rebase-merges and --strategy
    -  * --rebase-merges and --strategy-option
    +  * --keep-base and --onto
    +  * --keep-base and --root
      
     
      ## builtin/rebase.c ##
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      				  N_("passed to 'git apply'"), 0),
      		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 		    state_dir_base, cmd_live_rebase, buf.buf);
    + 	    options.autosquash) {
    + 		allow_preemptive_ff = 0;
      	}
    - 
     -	if (options.committer_date_is_author_date)
    -+	if (options.committer_date_is_author_date ||
    -+	    options.ignore_date)
    ++	if (options.committer_date_is_author_date || options.ignore_date)
      		options.flags |= REBASE_FORCE;
      
      	for (i = 0; i < options.git_am_opts.argc; i++) {
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     -		    !strcmp(option, "--whitespace=fix") ||
     +		if (!strcmp(option, "--whitespace=fix") ||
      		    !strcmp(option, "--whitespace=strip"))
    - 			options.flags |= REBASE_FORCE;
    + 			allow_preemptive_ff = 0;
      		else if (skip_prefix(option, "-C", &p)) {
     
      ## sequencer.c ##
    @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs
      static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
      static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
      static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
    -@@ sequencer.c: static char *read_author_date_or_null(void)
    - 	return date;
    +@@ sequencer.c: static const char *author_date_from_env_array(const struct argv_array *env)
    + 	BUG("GIT_AUTHOR_DATE missing from author script");
      }
      
     +/* Construct a free()able author string with current time as the author date */
    @@ sequencer.c: static char *read_author_date_or_null(void)
     +	struct strbuf new_author = STRBUF_INIT;
     +
     +	if (split_ident_line(&ident, author, len) < 0) {
    -+		error(_("malformed ident line"));
    ++		error(_("malformed ident line '%s'"), author);
     +		return NULL;
     +	}
     +	len = ident.mail_end - ident.name_begin + 1;
    @@ sequencer.c: static char *read_author_date_or_null(void)
     +	datestamp(&new_author);
     +	return strbuf_detach(&new_author, NULL);
     +}
    -+
    -+static void push_dates(struct child_process *child, int change_committer_date)
    -+{
    -+	time_t now = time(NULL);
    -+	struct strbuf date = STRBUF_INIT;
    -+
    -+	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
    -+	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
    -+	if (change_committer_date)
    -+		argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
    -+	strbuf_release(&date);
    -+}
     +
      static const char staged_changes_advice[] =
      N_("you have staged changes in your working tree\n"
      "If these changes are meant to be squashed into the previous commit, run:\n"
     @@ sequencer.c: static int run_git_commit(struct repository *r,
    - 			return -1;
      
    - 		strbuf_addf(&datebuf, "@%s", date);
    --		res = setenv("GIT_COMMITTER_DATE", datebuf.buf, 1);
    -+		res = setenv("GIT_COMMITTER_DATE",
    -+			     opts->ignore_date ? "" : datebuf.buf, 1);
    - 
    - 		strbuf_release(&datebuf);
    - 		free(date);
    -@@ sequencer.c: static int run_git_commit(struct repository *r,
    - 		argv_array_push(&cmd.args, "--amend");
    - 	if (opts->gpg_sign)
    - 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
    + 	if (opts->committer_date_is_author_date)
    + 		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
    ++				 opts->ignore_date ?
    ++				 "" :
    + 				 author_date_from_env_array(&cmd.env_array));
     +	if (opts->ignore_date)
    -+		push_dates(&cmd, opts->committer_date_is_author_date);
    - 	if (defmsg)
    - 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
    - 	else if (!(flags & EDIT_MSG))
    ++		argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
    + 
    + 	argv_array_push(&cmd.args, "commit");
    + 
     @@ sequencer.c: static int try_to_commit(struct repository *r,
      		strbuf_addf(&date, "@%.*s %.*s",
      			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
    @@ sequencer.c: static int read_populate_opts(struct replay_opts *opts)
      			opts->reschedule_failed_exec = 1;
      
     @@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_name,
    - 		write_file(rebase_path_signoff(), "--signoff\n");
    + 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
      	if (opts->committer_date_is_author_date)
      		write_file(rebase_path_cdate_is_adate(), "%s", "");
     +	if (opts->ignore_date)
    @@ sequencer.c: int write_basic_state(struct replay_opts *opts, const char *head_na
      		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
      
     @@ sequencer.c: static int do_merge(struct repository *r,
    - 		argv_array_push(&cmd.args, git_path_merge_msg(r));
    - 		if (opts->gpg_sign)
    - 			argv_array_push(&cmd.args, opts->gpg_sign);
    + 
    + 		if (opts->committer_date_is_author_date)
    + 			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
    ++					 opts->ignore_date ?
    ++					 "" :
    + 					 author_date_from_env_array(&cmd.env_array));
     +		if (opts->ignore_date)
    -+			push_dates(&cmd, opts->committer_date_is_author_date);
    ++			argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
      
    - 		/* Add the tips to be merged */
    - 		for (j = to_merge; j; j = j->next)
    + 		cmd.git_cmd = 1;
    + 		argv_array_push(&cmd.args, "merge");
     @@ sequencer.c: static int pick_commits(struct repository *r,
      	if (opts->allow_ff)
      		assert(!(opts->signoff || opts->no_commit ||
    @@ sequencer.h: struct replay_opts {
      	int mainline;
      
     
    - ## t/t3433-rebase-options-compatibility.sh ##
    -@@ t/t3433-rebase-options-compatibility.sh: test_expect_success '--committer-date-is-author-date works with rebase -r' '
    - 	done <rev_list
    + ## t/t3436-rebase-more-options.sh ##
    +@@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-date works when committing confl
    + 	test_cmp expect actual
      '
      
     +# Checking for +0000 in author time is enough since default
     +# timezone is UTC, but the timezone used while committing
     +# sets to +0530.
    -+test_expect_success '--ignore-date works with am backend' '
    ++test_expect_success '--ignore-date works with apply backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
    -+	git rebase --ignore-date HEAD^ &&
    -+	git show HEAD --pretty="format:%ai" >authortime &&
    ++	git rebase --apply --ignore-date HEAD^ &&
    ++	git log -1 --pretty="format:%ai" >authortime &&
     +	grep "+0000" authortime
     +'
     +
    -+test_expect_success '--ignore-date works with interactive backend' '
    ++test_expect_success '--ignore-date works with merge backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
    -+	git rebase --ignore-date -i HEAD^ &&
    -+	git show HEAD --pretty="format:%ai" >authortime &&
    ++	git rebase --ignore-date -m HEAD^ &&
    ++	git log -1 --pretty="format:%ai" >authortime &&
     +	grep "+0000" authortime
     +'
     +
    ++test_expect_success '--ignore-date works after conflict resolution' '
    ++	test_must_fail git rebase --ignore-date -m \
    ++		--onto commit2^^ commit2^ commit2 &&
    ++	echo resolved >foo &&
    ++	git add foo &&
    ++	git rebase --continue &&
    ++	git log --pretty=%ai >authortime &&
    ++	grep +0000 authortime
    ++'
    ++
     +test_expect_success '--ignore-date works with rebase -r' '
     +	git checkout side &&
     +	git merge --no-ff commit3 &&
     +	git rebase -r --root --ignore-date &&
    -+	git rev-list HEAD >rev_list &&
    -+	while read HASH
    -+	do
    -+		git show $HASH --pretty="format:%ai" >authortime
    -+		grep "+0000" authortime
    -+	done <rev_list
    ++	git log --pretty=%ai >authortime &&
    ++	! grep -v "+0000" authortime
     +'
     +
    - test_done
    ++test_expect_success '--ignore-date with --committer-date-is-author-date works' '
    ++	test_must_fail git rebase -m --committer-date-is-author-date \
    ++		--ignore-date --onto commit2^^ commit2^ commit3 &&
    ++	git checkout --theirs foo &&
    ++	git add foo &&
    ++	git rebase --continue &&
    ++	git log -2 --pretty=%ai >authortime &&
    ++	git log -2 --pretty=%ci >committertime &&
    ++	test_cmp authortime committertime &&
    ++	! grep -v "+0000" authortime
    ++'
    ++
    ++test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
    ++	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
    ++		git rebase -i --strategy=resolve --ignore-date \
    ++		--committer-date-is-author-date side side &&
    ++	git log -1 --pretty=%ai >authortime &&
    ++	git log -1 --pretty=%ci >committertime &&
    ++	test_cmp authortime committertime &&
    ++	grep "+0000" authortime
    ++ '
    ++
    + # This must be the last test in this file
    + test_expect_success '$EDITOR and friends are unchanged' '
    + 	test_editor_unchanged
6:  fe28ad8520 < -:  ---------- rebase: add --reset-author-date
7:  d82dfa7f5b < -:  ---------- rebase -i: finishing touches to --reset-author-date
-:  ---------- > 5:  43a097c583 rebase: add --reset-author-date
-- 
2.26.2

