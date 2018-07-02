Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E7191F516
	for <e@80x24.org>; Mon,  2 Jul 2018 10:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753615AbeGBK6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 06:58:11 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53640 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeGBK6I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 06:58:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so8576795wme.3
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M8/WxjUR05v2ckXwyQsiuZ8cyCklf1rRyyEqyu16330=;
        b=ofHrO0LTGPwZLSRLxKW72m0aFBT/i+HiT0beZ98Ej0WeTTcWRGmfeCIF8LohKN7y1l
         Sg5DKqZncen8hC9ZFuEQo7ALSxWmCKqCoIR+uCb4XvCh9k62CuP1z5jPLfT3MN8vB6sF
         YLm7ZYpJsEL71UmJOIs9RJRU3i+zF7Wauycr2zo0MiCWrpcrVYz/+MIQakRUHnOVZwOc
         06igF6mDRoBr1nsgzoNqzklObKdmXJdKfZZZ1t/xUR4VisVzY+Db0lLPM17hCtHM4Yu+
         AqQdybw+FeA9wPcPP213ZguzXzGu0KJSpmRvTDjmBohktvJcM4+3vBJkHaWzfvss1s+F
         1f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M8/WxjUR05v2ckXwyQsiuZ8cyCklf1rRyyEqyu16330=;
        b=mS7W4jLGjL1GqPPgYImK84l8aQW21oZjJGRjEbQwBUREx7AhBgFRNDY+ZZ/vqYmb7x
         /RcDeFuhY4d2mB8fUhcy3FQrGFtp5xTd6d+PoCKDiJBy9KkYDKBD6Hz0xRexWg9XbkPG
         06R6MYLOrnMk+bmj3B1qySGsOet0EjPeiDay70ysr3efxEMOsjDYX7TUPRUBZsLqaZRe
         o/PYaUntXLK03rJwTOMiIjfqF3nX4d++2oa4iIdk6mD8wVqmicKjJwJzLs46C7jqc5Nv
         okDD2UlmuglwifVmIiCFHOCNEi8SPjrjxxUBsuEebuJYZRbX73sfCG5AGCkgoW8noK+g
         MbFg==
X-Gm-Message-State: APt69E1hIJN1n2RROaPpHqpZ9TxgQOx4S158CHViXc15wO7hsr3v6Ofs
        h1GpSMJLRN0D8qyDj803DTdVDRrT
X-Google-Smtp-Source: AAOMgpd3VfZYs8GA6qiI0lapsM4sYmufQ2+I9nuNZjMDF1/XFIi0ZzVQhaqexFSiXsk1U8caeShrJg==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21-v6mr4713452wmh.106.1530529086115;
        Mon, 02 Jul 2018 03:58:06 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-72-143.w92-156.abo.wanadoo.fr. [92.156.124.143])
        by smtp.googlemail.com with ESMTPSA id m64-v6sm7462437wmb.38.2018.07.02.03.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 03:58:05 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 4/7] rebase-interactive: rewrite the edit-todo functionality in C
Date:   Mon,  2 Jul 2018 12:57:14 +0200
Message-Id: <20180702105717.26386-5-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180702105717.26386-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites the edit-todo functionality from shell to C.

To achieve that, a new command mode, `edit-todo`, is added, and the
`write-edit-todo` flag is removed, as the shell script does not need to
write the edit todo help message to the todo list anymore.

The shell version is then stripped in favour of a call to the helper.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   | 13 ++++++++-----
 git-rebase--interactive.sh | 11 +----------
 rebase-interactive.c       | 31 +++++++++++++++++++++++++++++++
 rebase-interactive.h       |  1 +
 4 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 05e73e71d..731a64971 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,12 +13,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, write_edit_todo = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,8 +28,6 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "write-edit-todo", &write_edit_todo,
-			 N_("append the edit-todo message to the todo-list")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +48,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_CMDMODE(0, "append-todo-help", &command,
 			    N_("insert the help in the todo list"), APPEND_TODO_HELP),
+		OPT_CMDMODE(0, "edit-todo", &command,
+			    N_("edit the todo list during an interactive rebase"),
+			    EDIT_TODO),
 		OPT_END()
 	};
 
@@ -90,6 +91,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ADD_EXEC && argc == 2)
 		return !!sequencer_add_exec_commands(argv[1]);
 	if (command == APPEND_TODO_HELP && argc == 1)
-		return !!append_todo_help(write_edit_todo, keep_empty);
+		return !!append_todo_help(0, keep_empty);
+	if (command == EDIT_TODO && argc == 1)
+		return !!edit_todo_list(flags);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 94c23a7af..2defe607f 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -108,16 +108,7 @@ initiate_action () {
 		     --continue
 		;;
 	edit-todo)
-		git stripspace --strip-comments <"$todo" >"$todo".new
-		mv -f "$todo".new "$todo"
-		collapse_todo_ids
-		git rebase--helper --append-todo-help --write-edit-todo
-
-		git_sequence_editor "$todo" ||
-			die "$(gettext "Could not execute editor")"
-		expand_todo_ids
-
-		exit
+		exec git rebase--helper --edit-todo
 		;;
 	show-current-patch)
 		exec git show REBASE_HEAD --
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 015e08cd0..fb7ad401a 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -66,3 +66,34 @@ int append_todo_help(unsigned edit_todo, unsigned keep_empty)
 
 	return ret;
 }
+
+int edit_todo_list(unsigned flags)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *todo_file = rebase_path_todo();
+	FILE *todo;
+
+	if (strbuf_read_file(&buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	strbuf_stripspace(&buf, 1);
+	todo = fopen_or_warn(todo_file, "w");
+	if (!todo) {
+		strbuf_release(&buf);
+		return 1;
+	}
+
+	strbuf_write(&buf, todo);
+	fclose(todo);
+	strbuf_release(&buf);
+
+	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	append_todo_help(1, 0);
+
+	if (launch_sequence_editor(todo_file, NULL, NULL))
+		return 1;
+
+	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+
+	return 0;
+}
diff --git a/rebase-interactive.h b/rebase-interactive.h
index 47372624e..155219e74 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -2,5 +2,6 @@
 #define REBASE_INTERACTIVE_H
 
 int append_todo_help(unsigned edit_todo, unsigned keep_empty);
+int edit_todo_list(unsigned flags);
 
 #endif
-- 
2.18.0

