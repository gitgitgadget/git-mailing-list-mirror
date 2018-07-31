Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6A21F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbeGaTl4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:41:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37771 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbeGaTl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:41:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11-v6so4114039wmc.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmpqOZtT2wZFC19Y/7KC/SYTth3KlYrZE1a1mfrF1NQ=;
        b=cW6MvjhfXwRmUGTuhHxB/gzWZud5sNkgoqZvV3Nx39ptBzV/Hm8O+ejs+o+gWQyZp6
         EcCD+URA8EGxSXJVSuGCI6w/AEmYkiEfGXkcKwXEPqrHdjkFNERYIJwC/rrCwghPLRim
         wJZHbWD/VhQghHXzPSsCbHdu/n/cYlJmbUZB31Dx0PJohvaqHreBKsFWMDDBXU42wGeJ
         6Ta7u4kzqzp6U47bLe0zGUg8C9fHLhZo2dPv77NvMFAWWKJu+z8IpY4tkSRYfDk5GZEv
         +1UCJGNQanRRpmLxx8n9QuST7sjSUNrQSFZXly1p0ff+wilRZyxwmq/dJ/pNbiTwS/aS
         +lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmpqOZtT2wZFC19Y/7KC/SYTth3KlYrZE1a1mfrF1NQ=;
        b=DIR16QAfO58S7CtSkk4uJuXcXUoSMPuWWqL/tKqVB9tF5lMfTb2O284yhqGeFOM4JC
         TNc/9BjQRRW9V9LwX9aeL24PXNRxBlE3DPSlII+T4ND5gB8LYuex0nIs/vCH1XXm/+c5
         TLoXXmd2FKkdtx3fiioj0o1VdQweZI1jydD6Ti+Q0HHCK36YPJ5v5CibQCnyiVq/D3a1
         /GPMQne7+xmZEx6KA6aPubW4ToRkjRIZEu7yHLqKRCVSpDvo6YFhQ+lIupLYqHA6KcPC
         zyJ6v7ykFGNgQXFYD7Al1/urHNMesMYpTbjygWeMlnFcSa1Ap324Fue5ZwjeHnvrNh1F
         Pc5Q==
X-Gm-Message-State: AOUpUlH2y2wu+CAtr4ncgsQ1O2/e+sjAd2oMDzW8eJ/nChVmzk+a5tfl
        FP6u8l4j8qYw0tWvl83wTs0v/9NE
X-Google-Smtp-Source: AAOMgpd8pbK1pBCrr+lGGLbCwPhr7d6ZzhF5O25QsNxoxFBsN75Lh8tdafK7eeg0+Vrbkn6Jp4DgKQ==
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr452456wmd.137.1533060027908;
        Tue, 31 Jul 2018 11:00:27 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:26 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 06/20] rebase -i: rewrite setup_reflog_action() in C
Date:   Tue, 31 Jul 2018 19:59:49 +0200
Message-Id: <20180731180003.5421-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites (the misnamed) setup_reflog_action() from shell to C. The
new version is called prepare_branch_to_be_rebased().

A new command is added to rebase--helper.c, “checkout-base”, as well as
a new flag, “verbose”, to avoid silencing the output of the checkout
operation called by checkout_base_commit().

The function `run_git_checkout()` will also be used in the next commit,
therefore its code is not part of `checkout_base_commit()`.

The shell version is then stripped in favour of a call to the helper.

As $GIT_REFLOG_ACTION is no longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v4.

 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 30 ++++++++++++++++++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 731a64971d..0e76dadba6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -18,7 +18,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,6 +28,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -51,6 +52,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "prepare-branch", &command,
+			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_END()
 	};
 
@@ -94,5 +97,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == PREPARE_BRANCH && argc == 2)
+		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f4..77e972bb6c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -72,6 +72,7 @@ collapse_todo_ids() {
 
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
+	comment_for_reflog start
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
 	git update-ref ORIG_HEAD $orig_head
@@ -119,19 +120,6 @@ initiate_action () {
 	esac
 }
 
-setup_reflog_action () {
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
-	fi
-}
-
 init_basic_state () {
 	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
@@ -211,7 +199,7 @@ git_rebase__interactive () {
 		return 0
 	fi
 
-	setup_reflog_action
+	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index 6d87f5ae6a..52949f38b3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3141,6 +3141,36 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int run_git_checkout(struct replay_opts *opts, const char *commit,
+			    const char *action)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	argv_array_push(&cmd.args, "checkout");
+	argv_array_push(&cmd.args, commit);
+	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+
+	if (opts->verbose)
+		return run_command(&cmd);
+	else
+		return run_command_silent_on_success(&cmd);
+}
+
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (run_git_checkout(opts, commit, action))
+			return error(_("could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index ffab798f1e..93da713fe2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -106,6 +106,8 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.18.0

