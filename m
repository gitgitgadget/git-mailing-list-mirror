Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B883920248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCSTEK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfCSTEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so90576wrq.1
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ModWTVyyoFbiyUfy0+qQZ72Egc9jWQgys97YCumSHTM=;
        b=BkRlahVm6I3jSjJJyNkGRE8QP8s9xoVK6fpvWAZpl/8ble6JW/TV50DsgFVQntuA8k
         G+tl1k6Qr4+/w7KlGVjv7kHvVZQqoS2hIH8E91kyvRNbJW0nIoCvklCC+LFdFluzszWE
         I6ZeiuHrvGiaxpdrxaP9+u3xLX7bWiNGnRiiWzsl1PWAiBz6ZoEs98OmfxTN9I43JuB9
         vBd6yqp8Cp6yL5eTSbO3fTKjJVkQ1GvDrajZuOzl4iSDbm9RWyFzlIeO58kq1fgpcaL6
         +MK8vfn3QFF1aTumU3uXDpGcxw/S+GlVz3X73OTZw6QjwEL9aWVi6so7NjsfzqgqOv05
         75yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ModWTVyyoFbiyUfy0+qQZ72Egc9jWQgys97YCumSHTM=;
        b=Hso6oG1mdWs6KHSqOovdnPIEaPeGnQknJlG0aCuuSzy3ctC/X4Onw4C1QvOm58pH/Z
         oizWTgN4mTQX9DliTK5D0Un/LO/KcP0BCJVMEX8gc3oatpx85GQXXGeraDsq0V6Ywwn0
         uBom9VEMYF1uq8GzRs6dDjkPuv/xgyoqeBkASWkx3PpI9mQxkrTUBk+9EJXQtC7oPVDz
         KN4Bx1BA4MN15VcXSjDZT7u8ToNVkG3VKRze1A6UUXFssNz25uHVv6AwYHRsdkxFdDZx
         H9DVixhoBVUTgkQ2RKgxJM1Jkc8jq+fQebiDZtLkrHsKF9FBD+tdg07ruHiDiZGFQhyb
         l9ng==
X-Gm-Message-State: APjAAAVNwQonFqi+QEBOWbHaGDY4s5ro5tnZzKw/j/2IuxEPwmLy9P9t
        IEAq9LDit5+u8xNu5lhJ4PZ2v2vCjq4=
X-Google-Smtp-Source: APXvYqyaobHqTNgJ5ab3gb3d79uALhjwptnXEq5KI2mj/1kRyFsv/YIel7YN4cxE2F50TspjT8ayHA==
X-Received: by 2002:a5d:6947:: with SMTP id r7mr14124891wrw.167.1553022246584;
        Tue, 19 Mar 2019 12:04:06 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:04:06 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 10/11] rebase: use a common action enum
Date:   Tue, 19 Mar 2019 19:03:16 +0000
Message-Id: <20190319190317.6632-11-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

cmd_rebase() and cmd_rebase__interactive() used different enums to hold
the current action. Change to using a common enum so the values are the
same when we change `rebase -i` to avoid forking `rebase--interactive`.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    I'm not sure what to do with action_names, I moved it to keep it near
    the definition of the enum. The extra commands in the enum are not
    traced so they don't need to be in action_names but it looks odd to
    leave them out. Also I don't understand why action_names in NULL
    terminated or the names are marked for translation as it is used in
    	trace2_cmd_mode(action_names[action]);
    so we don't use the NULL termination or translate the names (I'd be
    surprised if we did for tracing)

 builtin/rebase.c | 93 +++++++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 21ccb6495e..26d25a5242 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -119,6 +119,30 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	return replay;
 }
 
+enum action {
+	ACTION_NONE = 0,
+	ACTION_CONTINUE,
+	ACTION_SKIP,
+	ACTION_ABORT,
+	ACTION_QUIT,
+	ACTION_EDIT_TODO,
+	ACTION_SHOW_CURRENT_PATCH,
+	ACTION_SHORTEN_OIDS,
+	ACTION_EXPAND_OIDS,
+	ACTION_CHECK_TODO_LIST,
+	ACTION_REARRANGE_SQUASH,
+	ACTION_ADD_EXEC
+};
+
+static const char *action_names[] = { N_("undefined"),
+				      N_("continue"),
+				      N_("skip"),
+				      N_("abort"),
+				      N_("quit"),
+				      N_("edit_todo"),
+				      N_("show_current_patch"),
+				      NULL };
+
 static int add_exec_commands(struct string_list *commands)
 {
 	const char *todo_file = rebase_path_todo();
@@ -347,10 +371,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	unsigned flags = 0;
 	int abbreviate_commands = 0, ret = 0;
 	struct object_id squash_onto = null_oid;
-	enum {
-		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
-		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
-	} command = 0;
+	enum action command = ACTION_NONE;
 	struct option options[] = {
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
@@ -367,22 +388,22 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			N_("display a diffstat of what changed upstream"),
 			REBASE_NO_QUIET | REBASE_VERBOSE | REBASE_DIFFSTAT),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
-			    CONTINUE),
-		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), SKIP),
+			    ACTION_CONTINUE),
+		OPT_CMDMODE(0, "skip", &command, N_("skip commit"), ACTION_SKIP),
 		OPT_CMDMODE(0, "edit-todo", &command, N_("edit the todo list"),
-			    EDIT_TODO),
+			    ACTION_EDIT_TODO),
 		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
-			    SHOW_CURRENT_PATCH),
+			    ACTION_SHOW_CURRENT_PATCH),
 		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
+			N_("shorten commit ids in the todo list"), ACTION_SHORTEN_OIDS),
 		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand commit ids in the todo list"), EXPAND_OIDS),
+			N_("expand commit ids in the todo list"), ACTION_EXPAND_OIDS),
 		OPT_CMDMODE(0, "check-todo-list", &command,
-			N_("check the todo list"), CHECK_TODO_LIST),
+			N_("check the todo list"), ACTION_CHECK_TODO_LIST),
 		OPT_CMDMODE(0, "rearrange-squash", &command,
-			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
+			N_("rearrange fixup/squash lines"), ACTION_REARRANGE_SQUASH),
 		OPT_CMDMODE(0, "add-exec-commands", &command,
-			N_("insert exec commands in todo list"), ADD_EXEC),
+			N_("insert exec commands in todo list"), ACTION_ADD_EXEC),
 		{ OPTION_CALLBACK, 0, "onto", &opts.onto, N_("onto"), N_("onto"),
 		  PARSE_OPT_NONEG, parse_opt_commit, 0 },
 		{ OPTION_CALLBACK, 0, "restrict-revision", &opts.restrict_revision,
@@ -428,36 +449,36 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= opts.rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts.rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
-	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (opts.rebase_cousins >= 0 && !opts.rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
 			  "--rebase-merges"));
 
 	switch (command) {
-	case NONE: {
+	case ACTION_NONE: {
 		if (!opts.onto && !opts.upstream)
 			die(_("a base commit must be provided with --upstream or --onto"));
 
 		ret = do_interactive_rebase(&opts, flags);
 		break;
 	}
-	case SKIP: {
+	case ACTION_SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
 		rerere_clear(the_repository, &merge_rr);
 	}
 		/* fallthrough */
-	case CONTINUE: {
+	case ACTION_CONTINUE: {
 		struct replay_opts replay_opts = get_replay_opts(&opts);
 
 		ret = sequencer_continue(the_repository, &replay_opts);
 		break;
 	}
-	case EDIT_TODO:
+	case ACTION_EDIT_TODO:
 		ret = edit_todo_file(flags);
 		break;
-	case SHOW_CURRENT_PATCH: {
+	case ACTION_SHOW_CURRENT_PATCH: {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
@@ -466,17 +487,17 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 		break;
 	}
-	case SHORTEN_OIDS:
-	case EXPAND_OIDS:
+	case ACTION_SHORTEN_OIDS:
+	case ACTION_EXPAND_OIDS:
 		ret = transform_todo_file(flags);
 		break;
-	case CHECK_TODO_LIST:
+	case ACTION_CHECK_TODO_LIST:
 		ret = check_todo_list_from_file(the_repository);
 		break;
-	case REARRANGE_SQUASH:
+	case ACTION_REARRANGE_SQUASH:
 		ret = rearrange_squash_in_todo_file();
 		break;
-	case ADD_EXEC: {
+	case ACTION_ADD_EXEC: {
 		struct string_list commands = STRING_LIST_INIT_DUP;
 
 		split_exec_commands(opts.cmd, &commands);
@@ -1417,23 +1438,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	struct strbuf revisions = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id merge_base;
-	enum {
-		NO_ACTION,
-		ACTION_CONTINUE,
-		ACTION_SKIP,
-		ACTION_ABORT,
-		ACTION_QUIT,
-		ACTION_EDIT_TODO,
-		ACTION_SHOW_CURRENT_PATCH,
-	} action = NO_ACTION;
-	static const char *action_names[] = { N_("undefined"),
-					      N_("continue"),
-					      N_("skip"),
-					      N_("abort"),
-					      N_("quit"),
-					      N_("edit_todo"),
-					      N_("show_current_patch"),
-					      NULL };
+	enum action action = ACTION_NONE;
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
@@ -1600,7 +1605,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
-	if (action != NO_ACTION && total_argc != 2) {
+	if (action != ACTION_NONE && total_argc != 2) {
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 	}
@@ -1609,7 +1614,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
-	if (action != NO_ACTION && !in_progress)
+	if (action != ACTION_NONE && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
 
@@ -1709,7 +1714,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.action = "show-current-patch";
 		options.dont_finish_rebase = 1;
 		goto run_rebase;
-	case NO_ACTION:
+	case ACTION_NONE:
 		break;
 	default:
 		BUG("action: %d", action);
-- 
2.21.0

