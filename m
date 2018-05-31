Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703B91F51C
	for <e@80x24.org>; Thu, 31 May 2018 11:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754568AbeEaLDY (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 07:03:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52291 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754469AbeEaLDT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 07:03:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id 18-v6so47711523wml.2
        for <git@vger.kernel.org>; Thu, 31 May 2018 04:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M0metM26xelsTMOisSPtqLIWAwAyxEy/cM/CP3heBFU=;
        b=vPLNbgAl/IsiFKreKRdwInvFgMUtx8FzihlP3AMAZMm//GYg2XGLQdSV83T1dFKJNc
         sbGLQ3G6OYaw6uncHpVYVoaDagv4tRubuBm3d6QdU2bvh1Y3n2Pvz69uCumqxuMDLWDF
         +4EEf5UjBZm7LajCW2CULapAxbRv6AkW3+eXPebLVpayOZYiGLd9bKTQ0UAleeesiQoO
         zDJdLk/D+a16Hrf0KEl0qlOpSTU1QCSttQi/wxK6g+YHlSjRq6Tiq6A8T7s8gpK1skUQ
         ewImb/l0e1EitjYAsZ+VatFhkm0vrm7gltyN5zPcDqgZTCrIEl3m1Cn1G9oTNmSOCCVs
         hJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M0metM26xelsTMOisSPtqLIWAwAyxEy/cM/CP3heBFU=;
        b=P+PZRb0wIfxgOaCQ1DKE+kRSkrwYwDKzeljJyUtz2XUcq7yW4+pK8StIfDM9WZBaEA
         rm+TKhF7jBDq7TAzlgrN9rsrMrHTBjJQ/DRVMTMpy/8yX4hc9AG/GPo+oCzgaZjY8iW1
         AjvN3Ml60pRa8gfWNhp0sNfpUmhr3c7/5eIErD/5dx8VVdpNJmc6rDWo9Im5pQVwlO7E
         yfOlWqPXXXMEz5brpEJKmktA+ziXhEpRbVC3rw589EKPYDYPzxGthfXc3VD1rNgfqcmf
         tiq9lQ4W2OB4ZlNJzVAC/eBgWr42JtJV4+NIhbtGjT4xK4V8XJ96jdc7+xyRQhnIuSHW
         fl6A==
X-Gm-Message-State: ALKqPweG04Y8Xf5xB5xJ3lJK6dtixznWVWbzGcbDg7c+7zJMimNpXxoF
        RPkt+UORtIYuPRu8UuTc6d6d78FI
X-Google-Smtp-Source: ADUXVKI28bkfYWeG+Q8C6yOLYial166VUkJZXTNEg5Fodf3b9dC5EmnfkDj6tfXVjiN38bw+R8cDgQ==
X-Received: by 2002:aa7:c486:: with SMTP id m6-v6mr6880097edq.266.1527764598390;
        Thu, 31 May 2018 04:03:18 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-184-117.w86-199.abo.wanadoo.fr. [86.199.39.117])
        by smtp.googlemail.com with ESMTPSA id f2-v6sm5887419edq.28.2018.05.31.04.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 May 2018 04:03:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH 1/2] rebase--interactive: rewrite append_todo_help() in C
Date:   Thu, 31 May 2018 13:01:29 +0200
Message-Id: <20180531110130.18839-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180531110130.18839-1-alban.gruin@gmail.com>
References: <20180531110130.18839-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites append_todo_help() from shell to C. It also incorporates
some parts of initiate_action() and complete_action() that also write
help texts to the todo file.

Two flags are added to rebase--helper.c: one to call
append_todo_help() (`--append-todo-help`), and another one to tell
append_todo_help() to write the help text suited for the edit-todo
mode (`--edit-todo`).

Finally, append_todo_help() is removed from git-rebase--interactive.sh
to use `rebase--helper --append-todo-help` instead.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 10 ++++++--
 git-rebase--interactive.sh | 52 ++--------------------------------------
 sequencer.c                | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  1 +
 4 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index f7c2a5fdc..ad3a3a7eb 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, edit_todo = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC
+		ADD_EXEC, APPEND_TODO_HELP
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,6 +27,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "edit-todo", &edit_todo,
+			 N_("edit the todo list during an interactive rebase")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -45,6 +47,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
 			N_("insert exec commands in todo list"), ADD_EXEC),
+		OPT_CMDMODE(0, "append-todo-help", &command,
+			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
 		OPT_END()
 	};
 
@@ -84,5 +88,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!rearrange_squash();
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
+	if (command == APPEND_TODO_HELP && argc == 1)
+		return !!append_todo_help(edit_todo, keep_empty);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9884ecd71..419c54068 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -39,38 +39,6 @@ comment_for_reflog () {
 	esac
 }
 
-append_todo_help () {
-	gettext "
-Commands:
-p, pick <commit> = use commit
-r, reword <commit> = use commit, but edit the commit message
-e, edit <commit> = use commit, but stop for amending
-s, squash <commit> = use commit, but meld into previous commit
-f, fixup <commit> = like \"squash\", but discard this commit's log message
-x, exec <commit> = run command (the rest of the line) using shell
-d, drop <commit> = remove commit
-l, label <label> = label current HEAD with a name
-t, reset <label> = reset HEAD to a label
-m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
-.       create a merge commit using the original merge commit's
-.       message (or the oneline, if no original merge commit was
-.       specified). Use -c <commit> to reword the commit message.
-
-These lines can be re-ordered; they are executed from top to bottom.
-" | git stripspace --comment-lines >>"$todo"
-
-	if test $(get_missing_commit_check_level) = error
-	then
-		gettext "
-Do not remove any line. Use 'drop' explicitly to remove a commit.
-" | git stripspace --comment-lines >>"$todo"
-	else
-		gettext "
-If you remove a line here THAT COMMIT WILL BE LOST.
-" | git stripspace --comment-lines >>"$todo"
-	fi
-}
-
 die_abort () {
 	apply_autostash
 	rm -rf "$state_dir"
@@ -143,13 +111,7 @@ initiate_action () {
 		git stripspace --strip-comments <"$todo" >"$todo".new
 		mv -f "$todo".new "$todo"
 		collapse_todo_ids
-		append_todo_help
-		gettext "
-You are editing the todo file of an ongoing interactive rebase.
-To continue rebase after editing, run:
-    git rebase --continue
-
-" | git stripspace --comment-lines >>"$todo"
+		git rebase--helper --append-todo-help --edit-todo
 
 		git_sequence_editor "$todo" ||
 			die "$(gettext "Could not execute editor")"
@@ -220,17 +182,7 @@ $comment_char $(eval_ngettext \
 	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
 	"$todocount")
 EOF
-	append_todo_help
-	gettext "
-	However, if you remove everything, the rebase will be aborted.
-
-	" | git stripspace --comment-lines >>"$todo"
-
-	if test -z "$keep_empty"
-	then
-		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-	fi
-
+	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
 
 	has_action "$todo" ||
 		return 2
diff --git a/sequencer.c b/sequencer.c
index 01e561bc2..9b291845e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4223,6 +4223,66 @@ int check_todo_list(void)
 	return res;
 }
 
+int append_todo_help(unsigned edit_todo, unsigned keep_empty)
+{
+	struct strbuf buf = STRBUF_INIT;
+	FILE *todo;
+	int ret;
+	const char *msg = _("\nCommands:\n"
+"p, pick <commit> = use commit\n"
+"r, reword <commit> = use commit, but edit the commit message\n"
+"e, edit <commit> = use commit, but stop for amending\n"
+"s, squash <commit> = use commit, but meld into previous commit\n"
+"f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
+"x, exec <command> = run command (the rest of the line) using shell\n"
+"d, drop <commit> = remove commit\n"
+"l, label <label> = label current HEAD with a name\n"
+"t, reset <label> = reset HEAD to a label\n"
+"m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
+".       create a merge commit using the original merge commit's\n"
+".       message (or the oneline, if no original merge commit was\n"
+".       specified). Use -c <commit> to reword the commit message.\n"
+"\n"
+"These lines can be re-ordered; they are executed from top to bottom.\n");
+
+	todo = fopen_or_warn(rebase_path_todo(), "a");
+	if (!todo)
+		return 1;
+
+	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+
+	if (get_missing_commit_check_level() == CHECK_ERROR)
+		msg = _("\nDo not remove any line. Use 'drop' "
+			 "explicitly to remove a commit.\n");
+	else
+		msg = _("\nIf you remove a line here "
+			 "THAT COMMIT WILL BE LOST.\n");
+
+	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+
+	if (edit_todo)
+		msg = _("\nYou are editing the todo file "
+			"of an ongoing interactive rebase.\n"
+			"To continue rebase after editing, run:\n"
+			"    git rebase --continue\n\n");
+	else
+		msg = _("\nHowever, if you remove everything, "
+			"the rebase will be aborted.\n\n");
+
+	strbuf_add_commented_lines(&buf, msg, strlen(msg));
+
+	if (!keep_empty) {
+		msg = _("Note that empty commits are commented out");
+		strbuf_add_commented_lines(&buf, msg, strlen(msg));
+	}
+
+	ret = fputs(buf.buf, todo);
+	fclose(todo);
+	strbuf_release(&buf);
+
+	return ret;
+}
+
 static int rewrite_file(const char *path, const char *buf, size_t len)
 {
 	int rc = 0;
diff --git a/sequencer.h b/sequencer.h
index 4b2717881..c1cd01c50 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -76,6 +76,7 @@ int sequencer_make_script(FILE *out, int argc, const char **argv,
 int sequencer_add_exec_commands(const char *command);
 int transform_todos(unsigned flags);
 int check_todo_list(void);
+int append_todo_help(unsigned edit_todo, unsigned keep_empty);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
 
-- 
2.16.4

