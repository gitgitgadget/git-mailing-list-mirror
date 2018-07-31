Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69B271F597
	for <e@80x24.org>; Tue, 31 Jul 2018 18:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeGaTmW (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 15:42:22 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53752 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeGaTmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 15:42:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id s9-v6so4067969wmh.3
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 11:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRdO//+7tZ/fqw35hsv2p0XNCKzH4hso6CjKMyccTlQ=;
        b=ngQd6iLIC9M+P55o2tlb+2UnK+mhBMpQJP9U/2zKOhrJdH+SyaOLD0U54nBPoOnpjx
         oxiqpFEonw97+MsOQOOCDsPKQKO2tBWvMy96TGSL5HgldOheO6eFRnKW+x6HSJ5TX1Oj
         4qvmhdAviec18I0b2KPkVds/f2YwJNOdyr0v9dYYAkRTKzX2qE97x2sgukmrgNvJD/4g
         AxKMQ5Zc/4aP4wIRy8r8qWBS7xkJ1TqGGwaKET+oehUBI66Bo3Z7HmFfZ+djGYS66tay
         NweaRHaw+STc8gX84PJ3YTGR0SZhV9ZdSr2nkohyY9q+29+xLh86BuGvGAiwBV/8qZJC
         h2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRdO//+7tZ/fqw35hsv2p0XNCKzH4hso6CjKMyccTlQ=;
        b=a0TjqWv3CJn2lJKso+rzIDdc3Y8BF2vQC7vNt+Qw9vOnpa4Z+Vn1I/H851zfDZHHPK
         AHu0CuR+AD8BRGUI3F4Q8oYl6KK5r3HdJlDMVRFx6UEcIrOfjbbMbGfXtGkOG+ysu9/M
         BJyEyLsdg6tKm/u//I3EfAxJVN5u7LG4Ahst6Ng/ZQWD/3y+IseVrqKroXG6Wsx+U6zs
         7mlJAVsAHd5IFNiV6HAxcKWg9m4cNVeC+mHIpT4F2gToJeXfLRbTECxyGLXSU9cZo8Fr
         bPJGIzpZ5Mb/qLNd8Vg00tezLTgdLH1ZZgr9K3jDO707YYhmOg7uG5WSzHMF68CHsxel
         Wblg==
X-Gm-Message-State: AOUpUlEs0Wo22CVM1jFY8MiNW1wSB1wmcfgAhBHy0ZdmH3uCrv9fr0OQ
        ik9EGVPqxjqVt6Jyzmt6MeHpmvh1
X-Google-Smtp-Source: AAOMgpdPVR/TgRFUdsi0Dm4ngMwxQOE/f5p8A0DgBMVa7SejizQkyG6Y+CAtYJ4w6wVXDd/fRAVWbA==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr481562wmg.44.1533060052376;
        Tue, 31 Jul 2018 11:00:52 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-67-118.w92-136.abo.wanadoo.fr. [92.136.29.118])
        by smtp.googlemail.com with ESMTPSA id l10-v6sm20756602wrv.23.2018.07.31.11.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:00:51 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v5 20/20] rebase -i: move rebase--helper modes to rebase--interactive
Date:   Tue, 31 Jul 2018 20:00:03 +0200
Message-Id: <20180731180003.5421-21-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731180003.5421-1-alban.gruin@gmail.com>
References: <20180724163221.15201-1-alban.gruin@gmail.com>
 <20180731180003.5421-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the rebase--helper modes still used by
git-rebase--preserve-merges.sh (`--shorten-ids`, `--expand-ids`,
`--check-todo-list`, `--rearrange-squash` and `--add-exec-commands`) to
rebase--interactive.c.

git-rebase--preserve-merges.sh is modified accordingly, and
rebase--helper.c is removed as it is useless now.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 .gitignore                     |   1 -
 Makefile                       |   1 -
 builtin.h                      |   1 -
 builtin/rebase--helper.c       | 226 ---------------------------------
 builtin/rebase--interactive.c  |  27 +++-
 git-rebase--preserve-merges.sh |  10 +-
 git.c                          |   1 -
 7 files changed, 31 insertions(+), 236 deletions(-)
 delete mode 100644 builtin/rebase--helper.c

diff --git a/.gitignore b/.gitignore
index 3284a1e9b1..406f26d050 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,7 +116,6 @@
 /git-read-tree
 /git-rebase
 /git-rebase--am
-/git-rebase--helper
 /git-rebase--interactive
 /git-rebase--merge
 /git-rebase--preserve-merges
diff --git a/Makefile b/Makefile
index 584834726d..ca3a0888dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1059,7 +1059,6 @@ BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
 BUILTIN_OBJS += builtin/push.o
 BUILTIN_OBJS += builtin/read-tree.o
-BUILTIN_OBJS += builtin/rebase--helper.o
 BUILTIN_OBJS += builtin/rebase--interactive.o
 BUILTIN_OBJS += builtin/receive-pack.o
 BUILTIN_OBJS += builtin/reflog.o
diff --git a/builtin.h b/builtin.h
index ed89b4f495..7feb689d87 100644
--- a/builtin.h
+++ b/builtin.h
@@ -203,7 +203,6 @@ extern int cmd_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
-extern int cmd_rebase__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
 extern int cmd_remote(int argc, const char **argv, const char *prefix);
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
deleted file mode 100644
index ac21e8e06e..0000000000
--- a/builtin/rebase--helper.c
+++ /dev/null
@@ -1,226 +0,0 @@
-#include "builtin.h"
-#include "cache.h"
-#include "config.h"
-#include "parse-options.h"
-#include "sequencer.h"
-#include "rebase-interactive.h"
-#include "argv-array.h"
-#include "refs.h"
-#include "rerere.h"
-#include "alias.h"
-
-static GIT_PATH_FUNC(path_state_dir, "rebase-merge/")
-static GIT_PATH_FUNC(path_squash_onto, "rebase-merge/squash-onto")
-static GIT_PATH_FUNC(path_interactive, "rebase-merge/interactive")
-
-static int get_revision_ranges(const char *upstream, const char *onto,
-			       const char **head_hash,
-			       char **revisions, char **shortrevisions)
-{
-	const char *base_rev = upstream ? upstream : onto;
-	struct object_id orig_head;
-
-	if (get_oid("HEAD", &orig_head))
-		return error(_("no HEAD?"));
-
-	*head_hash = find_unique_abbrev(&orig_head, GIT_MAX_HEXSZ);
-
-	if (revisions)
-		*revisions = xstrfmt("%s...%s", base_rev, *head_hash);
-	if (shortrevisions) {
-		const char *shorthead;
-
-		shorthead = find_unique_abbrev(&orig_head, DEFAULT_ABBREV);
-
-		if (upstream) {
-			const char *shortrev;
-			struct object_id rev_oid;
-
-			get_oid(base_rev, &rev_oid);
-			shortrev = find_unique_abbrev(&rev_oid, DEFAULT_ABBREV);
-
-			*shortrevisions = xstrfmt("%s..%s", shortrev, shorthead);
-		} else
-			*shortrevisions = xstrdup(shorthead);
-	}
-
-	return 0;
-}
-
-static int init_basic_state(struct replay_opts *opts, const char *head_name,
-			    const char *onto, const char *orig_head)
-{
-	FILE *interactive;
-
-	if (!is_directory(path_state_dir()) && mkdir_in_gitdir(path_state_dir()))
-		return error_errno(_("could not create temporary %s"), path_state_dir());
-
-	delete_reflog("REBASE_HEAD");
-
-	interactive = fopen(path_interactive(), "w");
-	if (!interactive)
-		return error_errno(_("could not mark as interactive"));
-	fclose(interactive);
-
-	return write_basic_state(opts, head_name, onto, orig_head);
-}
-
-static const char * const builtin_rebase_helper_usage[] = {
-	N_("git rebase--helper [<options>]"),
-	NULL
-};
-
-int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
-{
-	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
-	int abbreviate_commands = 0, rebase_cousins = -1, ret;
-	const char *head_hash = NULL, *onto = NULL, *restrict_revision = NULL,
-		*squash_onto = NULL, *upstream = NULL, *head_name = NULL;
-	char *raw_strategies = NULL;
-	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
-		CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC, EDIT_TODO, PREPARE_BRANCH,
-		COMPLETE_ACTION, INIT_BASIC_STATE
-	} command = 0;
-	struct option options[] = {
-		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
-		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
-		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
-			N_("allow commits with empty messages")),
-		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
-		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
-			 N_("keep original branch points of cousins")),
-		OPT_BOOL(0, "autosquash", &autosquash,
-			 N_("move commits thas begin with squash!/fixup!")),
-		OPT_BOOL(0, "signoff", &opts.signoff, N_("sign commits")),
-		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
-		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
-				CONTINUE),
-		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
-				ABORT),
-		OPT_CMDMODE(0, "make-script", &command,
-			N_("make rebase script"), MAKE_SCRIPT),
-		OPT_CMDMODE(0, "shorten-ids", &command,
-			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
-		OPT_CMDMODE(0, "expand-ids", &command,
-			N_("expand commit ids in the todo list"), EXPAND_OIDS),
-		OPT_CMDMODE(0, "check-todo-list", &command,
-			N_("check the todo list"), CHECK_TODO_LIST),
-		OPT_CMDMODE(0, "rearrange-squash", &command,
-			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
-		OPT_CMDMODE(0, "add-exec-commands", &command,
-			N_("insert exec commands in todo list"), ADD_EXEC),
-		OPT_CMDMODE(0, "edit-todo", &command,
-			    N_("edit the todo list during an interactive rebase"),
-			    EDIT_TODO),
-		OPT_CMDMODE(0, "prepare-branch", &command,
-			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
-		OPT_CMDMODE(0, "complete-action", &command,
-			    N_("complete the action"), COMPLETE_ACTION),
-		OPT_CMDMODE(0, "init-basic-state", &command,
-			    N_("initialise the rebase state"), INIT_BASIC_STATE),
-		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
-		OPT_STRING(0, "restrict-revision", &restrict_revision,
-			   N_("restrict-revision"), N_("restrict revision")),
-		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
-			   N_("squash onto")),
-		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
-			   N_("the upstream commit")),
-		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
-		OPT_STRING('S', "gpg-sign", &opts.gpg_sign, N_("gpg-sign"),
-			   N_("GPG-sign commits")),
-		OPT_STRING(0, "strategy", &opts.strategy, N_("strategy"),
-			   N_("rebase strategy")),
-		OPT_STRING(0, "strategy-opts", &raw_strategies, N_("strategy-opts"),
-			   N_("strategy options")),
-		OPT_RERERE_AUTOUPDATE(&opts.allow_rerere_auto),
-		OPT_END()
-	};
-
-	sequencer_init_config(&opts);
-	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
-
-	opts.action = REPLAY_INTERACTIVE_REBASE;
-	opts.allow_ff = 1;
-	opts.allow_empty = 1;
-
-	argc = parse_options(argc, argv, NULL, options,
-			builtin_rebase_helper_usage, PARSE_OPT_KEEP_ARGV0);
-
-	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
-	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
-	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
-	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
-	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
-
-	if (rebase_cousins >= 0 && !rebase_merges)
-		warning(_("--[no-]rebase-cousins has no effect without "
-			  "--rebase-merges"));
-
-	if (command == CONTINUE && argc == 1)
-		return !!sequencer_continue(&opts);
-	if (command == ABORT && argc == 1)
-		return !!sequencer_remove_state(&opts);
-	if (command == MAKE_SCRIPT && argc == 1) {
-		char *revisions = NULL;
-		struct argv_array make_script_args = ARGV_ARRAY_INIT;
-
-		if (!upstream && squash_onto)
-			write_file(path_squash_onto(), "%s\n", squash_onto);
-
-		ret = get_revision_ranges(upstream, onto, &head_hash, &revisions, NULL);
-		if (ret)
-			return ret;
-
-		argv_array_pushl(&make_script_args, "", revisions, NULL);
-		if (restrict_revision)
-			argv_array_push(&make_script_args, restrict_revision);
-
-		ret = sequencer_make_script(stdout,
-					    make_script_args.argc, make_script_args.argv,
-					    flags);
-
-		free(revisions);
-		argv_array_clear(&make_script_args);
-
-		return !!ret;
-	}
-	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
-		return !!transform_todos(flags);
-	if (command == CHECK_TODO_LIST && argc == 1)
-		return !!check_todo_list();
-	if (command == REARRANGE_SQUASH && argc == 1)
-		return !!rearrange_squash();
-	if (command == ADD_EXEC && argc == 2)
-		return !!sequencer_add_exec_commands(argv[1]);
-	if (command == EDIT_TODO && argc == 1)
-		return !!edit_todo_list(flags);
-	if (command == PREPARE_BRANCH && argc == 2)
-		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
-	if (command == COMPLETE_ACTION && argc == 3) {
-		char *shortrevisions = NULL;
-
-		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, &shortrevisions);
-		if (ret)
-			return ret;
-
-		ret = complete_action(&opts, flags, shortrevisions, argv[1], onto,
-				      head_hash, argv[2], autosquash);
-
-		free(shortrevisions);
-		return !!ret;
-	}
-	if (command == INIT_BASIC_STATE) {
-		if (raw_strategies)
-			parse_strategy_opts(&opts, raw_strategies);
-
-		ret = get_revision_ranges(upstream, onto, &head_hash, NULL, NULL);
-		if (ret)
-			return ret;
-
-		return !!init_basic_state(&opts, head_name, onto, head_hash);
-	}
-
-	usage_with_options(builtin_rebase_helper_usage, options);
-}
diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 53b4f7483d..1e1756f1e8 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -140,7 +140,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		*switch_to = NULL, *cmd = NULL;
 	char *raw_strategies = NULL;
 	enum {
-		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH
+		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
+		SHORTEN_OIDS, EXPAND_OIDS, CHECK_TODO_LIST, REARRANGE_SQUASH, ADD_EXEC
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -161,6 +162,16 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "show-current-patch", &command, N_("show the current patch"),
 			    SHOW_CURRENT_PATCH),
+		OPT_CMDMODE(0, "shorten-ids", &command,
+			N_("shorten commit ids in the todo list"), SHORTEN_OIDS),
+		OPT_CMDMODE(0, "expand-ids", &command,
+			N_("expand commit ids in the todo list"), EXPAND_OIDS),
+		OPT_CMDMODE(0, "check-todo-list", &command,
+			N_("check the todo list"), CHECK_TODO_LIST),
+		OPT_CMDMODE(0, "rearrange-squash", &command,
+			N_("rearrange fixup/squash lines"), REARRANGE_SQUASH),
+		OPT_CMDMODE(0, "add-exec-commands", &command,
+			N_("insert exec commands in todo list"), ADD_EXEC),
 		OPT_STRING(0, "onto", &onto, N_("onto"), N_("onto")),
 		OPT_STRING(0, "restrict-revision", &restrict_revision,
 			   N_("restrict-revision"), N_("restrict revision")),
@@ -199,6 +210,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
 	flags |= rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
+	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
 
 	if (rebase_cousins >= 0 && !rebase_merges)
 		warning(_("--[no-]rebase-cousins has no effect without "
@@ -231,6 +243,19 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 
 		break;
 	}
+	case SHORTEN_OIDS:
+	case EXPAND_OIDS:
+		ret = transform_todos(flags);
+		break;
+	case CHECK_TODO_LIST:
+		ret = check_todo_list();
+		break;
+	case REARRANGE_SQUASH:
+		ret = rearrange_squash();
+		break;
+	case ADD_EXEC:
+		ret = sequencer_add_exec_commands(cmd);
+		break;
 	default:
 		BUG("invalid command '%d'", command);
 	}
diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index c214c5e4d6..afbb65765d 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -711,11 +711,11 @@ do_rest () {
 }
 
 expand_todo_ids() {
-	git rebase--helper --expand-ids
+	git rebase--interactive --expand-ids
 }
 
 collapse_todo_ids() {
-	git rebase--helper --shorten-ids
+	git rebase--interactive --shorten-ids
 }
 
 # Switch to the branch in $into and notify it in the reflog
@@ -876,8 +876,8 @@ init_revisions_and_shortrevisions () {
 
 complete_action() {
 	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
+	test -z "$autosquash" || git rebase--interactive --rearrange-squash || exit
+	test -n "$cmd" && git rebase--interactive --add-exec-commands --cmd "$cmd"
 
 	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
 	todocount=${todocount##* }
@@ -912,7 +912,7 @@ However, if you remove everything, the rebase will be aborted.
 	has_action "$todo" ||
 		return 2
 
-	git rebase--helper --check-todo-list || {
+	git rebase--interactive --check-todo-list || {
 		ret=$?
 		checkout_onto
 		exit $ret
diff --git a/git.c b/git.c
index 19d0b6e3b8..81aabd1423 100644
--- a/git.c
+++ b/git.c
@@ -519,7 +519,6 @@ static struct cmd_struct commands[] = {
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP | SUPPORT_SUPER_PREFIX},
 	{ "rebase--interactive", cmd_rebase__interactive, RUN_SETUP | NEED_WORK_TREE },
-	{ "rebase--helper", cmd_rebase__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "receive-pack", cmd_receive_pack },
 	{ "reflog", cmd_reflog, RUN_SETUP },
 	{ "remote", cmd_remote, RUN_SETUP },
-- 
2.18.0

