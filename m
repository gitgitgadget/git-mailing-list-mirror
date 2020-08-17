Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC4FC433E3
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE9420738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmlxet3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgHQRlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbgHQRkT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:40:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3FEC061344
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p14so13943974wmg.1
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=usG17fN4pbYpqgL4KQpZO0Wthm7Gcy1yCXnbnPTbUpE=;
        b=jmlxet3+L/3D+zhai/OrVVpPK3IcQsSkjSWtPJGKmgBzB0Vv56ozyQthswZwLV2N16
         AKqccUYZUuM/fZhD4XUWUnLIx3Q5OiDoVKtAhsnczMeUrNdwlO4CrhsoJRa3672yFiFG
         at80KgyJVi7BUUAb2goW5bX/iJQKpuDA5apKOeGQFyLvHwIBjGKvnz2V/yp3gMBk4NEm
         0X4l0ua5eXPPF+5lG6sTqUmcPilRNlSIgTCKjlvrX1wiyk9V3pfBID/WEw3FOM3cCoss
         Y+IvbKSoiF4VINwEF43uwVwBYq9z15/wGfJiOgMjXw8pLuEjXhMe/kf/LTQdJlC7ygUv
         M8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=usG17fN4pbYpqgL4KQpZO0Wthm7Gcy1yCXnbnPTbUpE=;
        b=fuy53CySJYDV6oJLp8VP0qQjnGvtA0RP9180UmA7GLQz4573K9uo31fWjsOjVUNreM
         9t32MRZFkdRo46F1czZxcxkRSIrIhMZkwgDRL3t8iKnD7usBtV3t1dFWnA09XOtTHJeQ
         pWfYmKMcKkSZE/2GUstRxaC42LQitl//tSMnNyWK84EHxN5pqyBse+5vGod/tDRlkf2Y
         hgpXBt8/Is7mnJIsmgJVfxwBJ3IyfXEzLZzYHF5w2O+3s21cJxLTEvxJcy3m40BfRBj+
         r6ixVFa1CO8OYsq9QxF+rgFr0YGEnlbqK073Gb3xfoTWqB+3n95k8CMt9rpHqkXDTEg8
         XZNw==
X-Gm-Message-State: AOAM531SUl7T1Mxqde0EhSD5XGK1xl+OzpcWpUCci8Eel58QhOWnRgwk
        ufm5FPXCItHOsF+ijbu84S0=
X-Google-Smtp-Source: ABdhPJw6L0Lt0bEcC1ErOeG0hNuWp3/dxnDEYuK4MEGswmSblC9Q7ohpYYR4EclNEOAx+B2mkWFMBQ==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr16301959wmg.39.1597686017014;
        Mon, 17 Aug 2020 10:40:17 -0700 (PDT)
Received: from localhost.localdomain (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id l10sm31252058wru.3.2020.08.17.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:40:16 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 3/5] rebase -i: support --committer-date-is-author-date
Date:   Mon, 17 Aug 2020 18:40:02 +0100
Message-Id: <20200817174004.92455-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817174004.92455-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rebase is implemented with two different backends - 'apply' and
'merge' each of which support a different set of options. In
particular the apply backend supports a number of options implemented
by 'git am' that are not implemented in the merge backend. This means
that the available options are different depending on which backend is
used which is confusing. This patch adds support for the
--committer-date-is-author-date option to the merge backend. This
option uses the author date of the commit that is being rewritten as
the committer date when the new commit is created.

Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt           | 10 ++-
 builtin/rebase.c                       | 17 +++--
 sequencer.c                            | 86 +++++++++++++++++++++++++-
 sequencer.h                            |  3 +
 t/t3422-rebase-incompatible-options.sh |  1 -
 t/t3436-rebase-more-options.sh         | 58 ++++++++++++++++-
 6 files changed, 162 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index b003784f01..f9ddfe2e77 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -445,9 +445,13 @@ if the other side had no changes that conflicted.
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
+	Instead of using the current time as the committer date, use
+	the author date of the commit being rebased as the committer
+	date. This option implies `--force-rebase`.
+
 --ignore-date::
-	These flags are passed to 'git am' to easily change the dates
-	of the rebased commits (see linkgit:git-am[1]).
+	This flag is passed to 'git am' to change the author date
+	of each rebased commit (see linkgit:git-am[1]).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -585,7 +589,6 @@ INCOMPATIBLE OPTIONS
 The following options:
 
  * --apply
- * --committer-date-is-author-date
  * --ignore-date
  * --whitespace
  * -C
@@ -613,6 +616,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --empty=
  * --preserve-merges and --ignore-whitespace
+ * --preserve-merges and --committer-date-is-author-date
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index bd93e9742c..2579380729 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -88,6 +88,7 @@ struct rebase_options {
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
+	int committer_date_is_author_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -124,6 +125,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.committer_date_is_author_date =
+					opts->committer_date_is_author_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -1497,9 +1500,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
-				  &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &options.committer_date_is_author_date,
+			 N_("make committer date match author date")),
 		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
@@ -1794,11 +1797,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    options.autosquash) {
 		allow_preemptive_ff = 0;
 	}
+	if (options.committer_date_is_author_date)
+		options.flags |= REBASE_FORCE;
 
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--committer-date-is-author-date") ||
-		    !strcmp(option, "--ignore-date") ||
+		if (!strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			allow_preemptive_ff = 0;
@@ -1855,6 +1859,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (ignore_whitespace)
 			argv_array_push(&options.git_am_opts,
 					"--ignore-whitespace");
+		if (options.committer_date_is_author_date)
+			argv_array_push(&options.git_am_opts,
+					"--committer-date-is-author-date");
 	} else {
 		/* REBASE_MERGE and PRESERVE_MERGES */
 		if (ignore_whitespace) {
diff --git a/sequencer.c b/sequencer.c
index 968a2d4ef3..78d09f9252 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -149,6 +149,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  * command-line.
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -302,6 +303,8 @@ int sequencer_remove_state(struct replay_opts *opts)
 		}
 	}
 
+	free(opts->committer_name);
+	free(opts->committer_email);
 	free(opts->gpg_sign);
 	free(opts->strategy);
 	for (i = 0; i < opts->xopts_nr; i++)
@@ -872,6 +875,22 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+static const char *author_date_from_env_array(const struct argv_array *env)
+{
+	int i;
+	const char *date;
+
+	for (i = 0; i < env->argc; i++)
+		if (skip_prefix(env->argv[i],
+				"GIT_AUTHOR_DATE=", &date))
+			return date;
+	/*
+	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
+	 * reading the script
+	 */
+	BUG("GIT_AUTHOR_DATE missing from author script");
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -938,6 +957,10 @@ static int run_git_commit(struct repository *r,
 			     gpg_opt, gpg_opt);
 	}
 
+	if (opts->committer_date_is_author_date)
+		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+				 author_date_from_env_array(&cmd.env_array));
+
 	argv_array_push(&cmd.args, "commit");
 
 	if (!(flags & VERIFY_MSG))
@@ -1315,6 +1338,7 @@ static int try_to_commit(struct repository *r,
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
 	char *amend_author = NULL;
+	const char *committer = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
@@ -1406,10 +1430,32 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	reset_ident_date();
+	if (opts->committer_date_is_author_date) {
+		struct ident_split id;
+		struct strbuf date = STRBUF_INIT;
+
+		if (split_ident_line(&id, author, (int)strlen(author)) < 0) {
+			res = error(_("invalid author identity '%s'"), author);
+			goto out;
+		}
+		if (!id.date_begin) {
+			res = error(_("corrupt author: missing date information"));
+			goto out;
+		}
+		strbuf_addf(&date, "@%.*s %.*s",
+			    (int)(id.date_end - id.date_begin), id.date_begin,
+			    (int)(id.tz_end - id.tz_begin), id.tz_begin);
+		committer = fmt_ident(opts->committer_name,
+				      opts->committer_email,
+				      WANT_COMMITTER_IDENT, date.buf,
+				      IDENT_STRICT);
+		strbuf_release(&date);
+	} else {
+		reset_ident_date();
+	}
 
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
-				 author, NULL, opts->gpg_sign, extra)) {
+				 author, committer, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
 		goto out;
 	}
@@ -2532,6 +2578,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2622,6 +2673,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_drop_redundant_commits(), "%s", "");
 	if (opts->keep_redundant_commits)
 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3542,6 +3595,10 @@ static int do_merge(struct repository *r,
 			goto leave_merge;
 		}
 
+		if (opts->committer_date_is_author_date)
+			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+					 author_date_from_env_array(&cmd.env_array));
+
 		cmd.git_cmd = 1;
 		argv_array_push(&cmd.args, "merge");
 		argv_array_push(&cmd.args, "-s");
@@ -3819,7 +3876,8 @@ static int pick_commits(struct repository *r,
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
+			 opts->record_origin || opts->edit ||
+			 opts->committer_date_is_author_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
@@ -4258,6 +4316,22 @@ static int commit_staged_changes(struct repository *r,
 	return 0;
 }
 
+static int init_committer(struct replay_opts *opts)
+{
+	struct ident_split id;
+	const char *committer;
+
+	committer = git_committer_info(IDENT_STRICT);
+	if (split_ident_line(&id, committer, strlen(committer)) < 0)
+		return error(_("invalid committer '%s'"), committer);
+	opts->committer_name =
+		xmemdupz(id.name_begin, id.name_end - id.name_begin);
+	opts->committer_email =
+		xmemdupz(id.mail_begin, id.mail_end - id.mail_end);
+
+	return 0;
+}
+
 int sequencer_continue(struct repository *r, struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4269,6 +4343,9 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
+		if (opts->committer_date_is_author_date && init_committer(opts))
+			return -1;
+
 		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 
@@ -5145,6 +5222,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	res = -1;
 
+	if (opts->committer_date_is_author_date && init_committer(opts))
+		goto cleanup;
+
 	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
 		goto cleanup;
 
diff --git a/sequencer.h b/sequencer.h
index 0bee85093e..7ca657fe2c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,9 +45,12 @@ struct replay_opts {
 	int verbose;
 	int quiet;
 	int reschedule_failed_exec;
+	int committer_date_is_author_date;
 
 	int mainline;
 
+	char *committer_name;
+	char *committer_email;
 	char *gpg_sign;
 	enum commit_msg_cleanup_mode default_msg_cleanup;
 	int explicit_cleanup;
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 55ca46786d..c8234062c6 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
 test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 4f8a6e51c9..50a63d8ebe 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
+export GIT_AUTHOR_DATE
+
 # This is a special case in which both am and interactive backends
 # provide the same output. It was done intentionally because
 # both the backends fall short of optimal behaviour.
@@ -21,11 +24,20 @@ test_expect_success 'setup' '
 	test_write_lines "line 1" "new line 2" "line 3" >file &&
 	git commit -am "update file" &&
 	git tag side &&
+	test_commit commit1 foo foo1 &&
+	test_commit commit2 foo foo2 &&
+	test_commit commit3 foo foo3 &&
 
 	git checkout --orphan master &&
+	rm foo &&
 	test_write_lines "line 1" "        line 2" "line 3" >file &&
 	git commit -am "add file" &&
-	git tag main
+	git tag main &&
+
+	mkdir test-bin &&
+	write_script test-bin/git-merge-test <<-\EOF
+	exec git-merge-recursive "$@"
+	EOF
 '
 
 test_expect_success '--ignore-whitespace works with apply backend' '
@@ -52,6 +64,50 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
 	git diff --exit-code side
 '
 
+test_ctime_is_atime () {
+	git log $1 --format=%ai >authortime &&
+	git log $1 --format=%ci >committertime &&
+	test_cmp authortime committertime
+}
+
+test_expect_success '--committer-date-is-author-date works with apply backend' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	git rebase --apply --committer-date-is-author-date HEAD^ &&
+	test_ctime_is_atime -1
+'
+
+test_expect_success '--committer-date-is-author-date works with merge backend' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	git rebase -m --committer-date-is-author-date HEAD^ &&
+	test_ctime_is_atime -1
+'
+
+test_expect_success '--committer-date-is-author-date works with rebase -r' '
+	git checkout side &&
+	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
+	git rebase -r --root --committer-date-is-author-date &&
+	test_ctime_is_atime
+'
+
+test_expect_success '--committer-date-is-author-date works when forking merge' '
+	git checkout side &&
+	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
+	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
+					--committer-date-is-author-date &&
+	test_ctime_is_atime
+'
+
+test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
+	git checkout commit2 &&
+	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
+	test_must_fail git rebase -m --committer-date-is-author-date \
+		--onto HEAD^^ HEAD^ &&
+	echo resolved > foo &&
+	git add foo &&
+	git rebase --continue &&
+	test_ctime_is_atime -1
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.28.0

