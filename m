Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 997A71F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeHJTXN (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40785 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTXN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id y9-v6so2577816wma.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shZXDS3MHSgxAMVFtY8+cmQJfnf0XAwvjw/bqV0TcTM=;
        b=Uxk8PIYfoARD8oUCMIMjPUmu2NkIDx9kTR3WrGghFGvFbsa3MCEw3oihLD3jl2+psB
         JugwZOePOkNX23vCVG7l0vxkiX2VL2ENQs76DfNavlp6H7uvF+DmBdnLMXZq425IjxaK
         ANq1LJU3VODFgsYNPt8OTEuojAeJXi8LjCzeUC1faKWJigLOqnPe2aO4rOWfimpo3AXv
         LjxMhgHazei6XtTx3dIOS7QF0UuNIzpDnBrgM9/YseWenGBzQTH+yu0uT2WyIn1AO+5x
         SyGcxK1j4uw+FZMvewo8/Qjaesdu6EQ12rPCr8230rtGGqgxvT7BqjoI9ITdEookXeAb
         M5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shZXDS3MHSgxAMVFtY8+cmQJfnf0XAwvjw/bqV0TcTM=;
        b=l49by7Pxbmde8PL2lIWiiJV0InZitukN/lIcOjZpIBei7QqSE1MLxm5THRSdGeDXez
         nlmN7fEJA7lfrwTlhwSGMZHqyWN6UhG2AeYCVHje1LrnRpL1ZolHJkfhy09B/0ev47Wm
         cii/KZuMjiaTMGufk7ep4f37oXc37YEmqN2rCSIYAg0GNOVIagUzlHoLJ7LEW/5mYozp
         +n0LBDVpD1EgOEYwJoJ33MQL6bRMiV2L27cdJY3JeB/XXvKBC7D82gg3KvEdpFBt7wr8
         V9Et5qJpLBuuY6d+TLGA8IRa83KsRDgrxgUl0/iqDUDLQujkf6KS3LwV2HrRSuJxcL0S
         Gsig==
X-Gm-Message-State: AOUpUlGB6gZRuOsa3covReqGI4YmQM++pOANdZiN93dj6oShhk2VUD72
        lXtMEYwxAqVeNjUp/FbzMLWl5sMY
X-Google-Smtp-Source: AA+uWPw+nEbSoVLZn1q1jN3hN2UF8SA7pWzUNFPLcDlyv2HthR4zHPCo989Zja3h2KrF2l8fOxMVbQ==
X-Received: by 2002:a1c:8955:: with SMTP id l82-v6mr1948681wmd.110.1533919952158;
        Fri, 10 Aug 2018 09:52:32 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:31 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 11/20] rebase -i: rewrite complete_action() in C
Date:   Fri, 10 Aug 2018 18:51:38 +0200
Message-Id: <20180810165147.4779-12-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites complete_action() from shell to C.

A new mode is added to rebase--helper (`--complete-action`), as well as
a new flag (`--autosquash`).

Finally, complete_action() is stripped from git-rebase--interactive.sh.

The original complete_action() would return the code 2 when the todo
list contained no actions.  This was a special case for rebase -i and
-p; git-rebase.sh would then apply the autostash, delete the state
directory, and die with the message "Nothing to do".  This cleanup is
rewritten in C instead of returning 2.  As rebase -i no longer returns
2, the comment describing this behaviour in git-rebase.sh is updated to
reflect this change.

The message "Nothing to do" is now printed with error(), and so becomes
"error: nothing to do".  Some tests in t3404 check this value, so they
are updated to fit this change.

The first check might seem useless as we write "noop" to the todo list
if it is empty.  Actually, the todo list might contain commented
commands (ie. empty commits).  In this case, complete_action() won’t
write "noop", and will abort without starting the editor.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c      |  12 +++-
 git-rebase--interactive.sh    |  53 ++----------------
 git-rebase.sh                 |   2 +-
 sequencer.c                   | 102 ++++++++++++++++++++++++++++++++++
 sequencer.h                   |   4 ++
 t/t3404-rebase-interactive.sh |   2 +-
 6 files changed, 122 insertions(+), 53 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index bed3dd2b95..01b3333958 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,13 +13,13 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, autosquash = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
 		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
-		CHECKOUT_ONTO
+		CHECKOUT_ONTO, COMPLETE_ACTION
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -29,6 +29,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT_BOOL(0, "autosquash", &autosquash,
+			 N_("move commits that begin with squash!/fixup!")),
 		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
@@ -57,6 +59,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_CMDMODE(0, "checkout-onto", &command,
 			    N_("checkout a commit"), CHECKOUT_ONTO),
+		OPT_CMDMODE(0, "complete-action", &command,
+			    N_("complete the action"), COMPLETE_ACTION),
 		OPT_END()
 	};
 
@@ -110,5 +114,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	if (command == CHECKOUT_ONTO && argc == 4)
 		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
+	if (command == COMPLETE_ACTION && argc == 6)
+		return !!complete_action(&opts, flags, argv[1], argv[2], argv[3],
+					 argv[4], argv[5], autosquash);
+
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b68f108f28..59dc4888a6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -127,54 +127,6 @@ init_revisions_and_shortrevisions () {
 	fi
 }
 
-complete_action() {
-	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
-
-	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-	todocount=${todocount##* }
-
-cat >>"$todo" <<EOF
-
-$comment_char $(eval_ngettext \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
-	"$todocount")
-EOF
-	git rebase--helper --append-todo-help ${keep_empty:+--keep-empty}
-
-	has_action "$todo" ||
-		return 2
-
-	cp "$todo" "$todo".backup
-	collapse_todo_ids
-	git_sequence_editor "$todo" ||
-		die_abort "$(gettext "Could not execute editor")"
-
-	has_action "$todo" ||
-		return 2
-
-	git rebase--helper --check-todo-list || {
-		ret=$?
-		git rebase--helper --checkout-onto "$onto_name" "$onto" \
-		    "$orig_head" ${verbose:+--verbose}
-		exit $ret
-	}
-
-	expand_todo_ids
-
-	test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
-	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
-	    ${verbose:+--verbose}
-	require_clean_work_tree "rebase"
-	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-	     --continue
-}
-
 git_rebase__interactive () {
 	initiate_action "$action"
 	ret=$?
@@ -193,5 +145,8 @@ git_rebase__interactive () {
 		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
 	die "$(gettext "Could not generate todo list")"
 
-	complete_action
+	exec git rebase--helper --complete-action "$shortrevisions" "$onto_name" \
+		"$shortonto" "$orig_head" "$cmd" $allow_empty_message \
+		${autosquash:+--autosquash} ${keep_empty:+--keep-empty} \
+		${verbose:+--verbose} ${force_rebase:+--no-ff}
 }
diff --git a/git-rebase.sh b/git-rebase.sh
index 7973447645..51a6db7daa 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -219,7 +219,7 @@ run_specific_rebase () {
 	if test $ret -eq 0
 	then
 		finish_rebase
-	elif test $ret -eq 2 # special exit status for rebase -i
+	elif test $ret -eq 2 # special exit status for rebase -p
 	then
 		apply_autostash &&
 		rm -rf "$state_dir" &&
diff --git a/sequencer.c b/sequencer.c
index a56a781539..ae1f44de2f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -30,6 +30,7 @@
 #include "oidset.h"
 #include "commit-slab.h"
 #include "alias.h"
+#include "rebase-interactive.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -53,6 +54,9 @@ static GIT_PATH_FUNC(rebase_path, "rebase-merge")
  * file and written to the tail of 'done'.
  */
 GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
+static GIT_PATH_FUNC(rebase_path_todo_backup,
+		     "rebase-merge/git-rebase-todo.backup")
+
 /*
  * The rebase command lines that have already been processed. A line
  * is moved here when it is first handled, before any associated user
@@ -4499,6 +4503,104 @@ int skip_unnecessary_picks(struct object_id *output_oid)
 	return 0;
 }
 
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash)
+{
+	const char *shortonto, *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	struct strbuf *buf = &(todo_list.buf);
+	struct object_id oid;
+	struct stat st;
+
+	get_oid(onto, &oid);
+	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
+
+	if (!lstat(todo_file, &st) && st.st_size == 0 &&
+	    write_message("noop\n", 5, todo_file, 0))
+		return error_errno(_("could not write '%s'"), todo_file);
+
+	if (autosquash && rearrange_squash())
+		return -1;
+
+	if (cmd && *cmd)
+		sequencer_add_exec_commands(cmd);
+
+	if (strbuf_read_file(buf, todo_file, 0) < 0)
+		return error_errno(_("could not read '%s'."), todo_file);
+
+	if (parse_insn_buffer(buf->buf, &todo_list)) {
+		todo_list_release(&todo_list);
+		return error(_("unusable todo list: '%s'"), todo_file);
+	}
+
+	if (count_commands(&todo_list) == 0) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return error(_("nothing to do"));
+	}
+
+	strbuf_addch(buf, '\n');
+	strbuf_commented_addf(buf, Q_("Rebase %s onto %s (%d command)",
+				      "Rebase %s onto %s (%d commands)",
+				      count_commands(&todo_list)),
+			      shortrevisions, shortonto, count_commands(&todo_list));
+	append_todo_help(0, flags & TODO_LIST_KEEP_EMPTY, buf);
+
+	if (write_message(buf->buf, buf->len, todo_file, 0)) {
+		todo_list_release(&todo_list);
+		return error_errno(_("could not write '%s'"), todo_file);
+	}
+
+	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
+		return error(_("could not copy '%s' to '%s'."), todo_file,
+			     rebase_path_todo_backup());
+
+	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
+		return error(_("could not transform the todo list"));
+
+	strbuf_reset(buf);
+
+	if (launch_sequence_editor(todo_file, buf, NULL)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return -1;
+	}
+
+	strbuf_stripspace(buf, 1);
+	if (buf->len == 0) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		todo_list_release(&todo_list);
+
+		return error(_("nothing to do"));
+	}
+
+	todo_list_release(&todo_list);
+
+	if (check_todo_list()) {
+		checkout_onto(opts, onto_name, onto, orig_head);
+		return -1;
+	}
+
+	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
+		return error(_("could not transform the todo list"));
+
+	if (opts->allow_ff && skip_unnecessary_picks(&oid))
+		return error(_("could not skip unnecessary pick commands"));
+
+	checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head);
+	if (require_clean_work_tree("rebase", "", 1, 1))
+		return -1;
+
+	return sequencer_continue(opts);
+}
+
 struct subject2item_entry {
 	struct hashmap_entry entry;
 	int i;
diff --git a/sequencer.h b/sequencer.h
index fcbcd246c2..d58766c6d7 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -92,6 +92,10 @@ int transform_todos(unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
 int check_todo_list(void);
 int skip_unnecessary_picks(struct object_id *output_oid);
+int complete_action(struct replay_opts *opts, unsigned flags,
+		    const char *shortrevisions, const char *onto_name,
+		    const char *onto, const char *orig_head, const char *cmd,
+		    unsigned autosquash);
 int rearrange_squash(void);
 
 extern const char sign_off_header[];
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 496d88d7d6..12d3ed8396 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -76,7 +76,7 @@ test_expect_success 'rebase --keep-empty' '
 '
 
 cat > expect <<EOF
-Nothing to do
+error: nothing to do
 EOF
 
 test_expect_success 'rebase -i with empty HEAD' '
-- 
2.18.0

