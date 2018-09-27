Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A14B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeI1EVC (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:21:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41525 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeI1EVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:21:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id j15-v6so4219685wrt.8
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GthGCUWYdPj7y2CmvVXL7STiQ1QXc/mxs2NH392SKQ=;
        b=VnzKuIEnQSQfqtjLOGGAyzZJdLMPoGrmAS4d9ziSSIU/SWGx87ZfZEtDY8e7l0aztO
         oNRsGF780Bo2ffNDLLw/hkJxxQ2JxRKRvMib3UY9imV8trcpehzz1sBtUxuf2uLUGmV6
         hIjLoME78GBV84LqZ7sXCkQeD5/IXI72LBmvBMXzTpXcjQ801CiwiqvsJ121VLz0+zyC
         hQQeMDfloPPqAST+5sr5hWDJRV9zhQ2RylN8MdxAQko/+C2rpZeLfMkdfO/f2WZJJc+D
         I+4rhSPg0Xy4tq88mZX9+HHyvCYIGi4D1pyIxSaBQt2tky7Of9/Xk41rZxbhHuM80ZTJ
         OzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GthGCUWYdPj7y2CmvVXL7STiQ1QXc/mxs2NH392SKQ=;
        b=Oy5jbgG7z4GTAlpwvl5TtdAppiNqA01NiA+PVy7jcCUXRsvAJL+11YNiJJ9EQHNFoi
         vL3li1DdHaCLgIvfCv9Gkw+q3CVE7vtOY9XpkYBoA7EfHDuSOU7e9QwIUkhi9NLTNpld
         hQ529GLfSEI4Q9Q8QnytZGqr+v7+BC4aA7+XLm1Cy1q7JnBT7V95O+Nu1RSO/S6p8krk
         khsYPQcgPOUKGurmC9Z2ypAJFabrL/qkBxaF0Ze5EJhN21Q1B5gBcA3cCIK11D6BiAat
         LfeZqOqaQXjPyI33zeyZZnHe6v6Ee6eCLcJ5M52vy/RjfRdAeq7MKo5nIJLnfHFfxGl/
         6fGg==
X-Gm-Message-State: ABuFfohVDOXwkiNyZBYcBKr+h+AQWPvRqB59Os149vHuaTvYH65YPzIk
        A2HzMzuUt9IYsWt2N1N8cAiA+7Ne
X-Google-Smtp-Source: ACcGV61lEYO/rRycwKlIFwF3o8GBQSyynpIB+JvIjfkrYj2QzdCluJ2iH0dOSbflycG/+KcXKGCp0g==
X-Received: by 2002:adf:e882:: with SMTP id d2-v6mr9844481wrm.43.1538085634905;
        Thu, 27 Sep 2018 15:00:34 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-28-140.w86-222.abo.wanadoo.fr. [86.222.27.140])
        by smtp.googlemail.com with ESMTPSA id h206-v6sm243153wmf.25.2018.09.27.15.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 15:00:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v8 06/20] rebase -i: rewrite setup_reflog_action() in C
Date:   Thu, 27 Sep 2018 23:55:56 +0200
Message-Id: <20180927215610.32210-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927215610.32210-1-alban.gruin@gmail.com>
References: <20180828121045.14933-1-alban.gruin@gmail.com>
 <20180927215610.32210-1-alban.gruin@gmail.com>
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
No changes since v7.

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
index 5919ad312e..d8a59c50f8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3285,6 +3285,36 @@ static const char *reflog_message(struct replay_opts *opts,
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
index 579de9127b..9f0ce21be7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -121,6 +121,8 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.19.0

