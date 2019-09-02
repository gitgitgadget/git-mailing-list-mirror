Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 979711F461
	for <e@80x24.org>; Mon,  2 Sep 2019 23:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfIBXl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 19:41:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43840 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfIBXl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 19:41:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id 90so11049207otg.10
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 16:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4IQMt6VsFkCxAYfRs9QZmQStYknflhFexZt+HFCgHzw=;
        b=f76Bv9bM2QSXz00j68a2DpOvT9m9MT9242IK7/RmErt1EzSQbGOR1ZQ+vIfYvFlgw8
         3wnac/x9gbCJJEFdEnHDEc9kCC/E3XC9f46qqRlkElpY3rhEfJyUToznXwK9mZvey5HE
         mZKoaDXZ2h65MhAb5XLDcoh+bGEeIuZgPEWpjxv3mpYqKs0HD3EOr1j/chiJBd9vuHkL
         oJ0eWB2NGdP/Rc1E6/kBbOjhA+pG7o3fzjtPhBNs0eqI0l38iL/WevAgS3bf7Wlnvrdo
         mbKwln+2H5Z3ayEYl9cgoTUluvmL1QwV1UmjncVvYwUcoK5mj8KGzouz2cjiUxodM/8y
         3KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4IQMt6VsFkCxAYfRs9QZmQStYknflhFexZt+HFCgHzw=;
        b=WViGMNmtKAaVpTXAQrmKH9fm7aNklZKG3cQc4NXPU0Nfzhq+SnKsbZc2DevX6zE/Xy
         2uyv4B3TOxBc5Pzp4m1zDVaOgrxmYKSFB8620rfFalNSe2hTrmCBrTJVmaCJFqVJHi8W
         3ABeZZI5jMI2ErGcrnKujwoLg56C8GDoUUg8iQPhn3fqZstI7C2hqUwuxmYHJWBLGoK5
         rJ8OseC1HxlQrmx4je2bEh044LBz6M8CL9eG8s/fU6pAXfRMoBghgj/SN/C7nYu9DI8k
         eP5rbMQoSNLSxu7rspKKDy7GcV8djGaZjOUClwsox2deraHDE05alnYY0oWtLdiMWE8X
         PlPA==
X-Gm-Message-State: APjAAAVCXitdLZeLhyZHZjMCaoLv9GigQmZ/HcLPHDTQCS08SYcZIwVC
        ZxCTrlukoeTcQcvHTLRzoXpcogD6R0g=
X-Google-Smtp-Source: APXvYqwvaUhFbieqzPv9BGMrFXVhr4REZ6o614W9cKlsnf496hpnmIgEwomDjd1nMRowJPMM5ZmZPw==
X-Received: by 2002:a05:6830:2094:: with SMTP id y20mr17231376otq.36.1567467687645;
        Mon, 02 Sep 2019 16:41:27 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:8a10:1290:cc39:3958:899b:7a63])
        by smtp.gmail.com with ESMTPSA id n32sm5842906otn.61.2019.09.02.16.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 16:41:27 -0700 (PDT)
From:   Warren He <pickydaemon@gmail.com>
X-Google-Original-From: Warren He <wh109@yahoo.com>
To:     git@vger.kernel.org
Cc:     Warren He <wh109@yahoo.com>
Subject: [PATCH] rebase: introduce --update-branches option
Date:   Mon,  2 Sep 2019 16:41:09 -0700
Message-Id: <20190902234109.2922-2-wh109@yahoo.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20190902234109.2922-1-wh109@yahoo.com>
References: <20190902234109.2922-1-wh109@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rebasing normally updates the current branch to the rewritten version.
If any other branches point to commits rewritten along the way, those
remain untouched. This commit adds an `--update-branches` option, which
instructs the command to update any such branches that it encounters to
point to the rewritten versions of those commits.

Signed-off-by: Warren He <wh109@yahoo.com>
---
 Documentation/git-rebase.txt      |  8 +++++
 builtin/rebase.c                  | 13 ++++++--
 sequencer.c                       | 68 ++++++++++++++++++++++++++++++++++++++-
 sequencer.h                       |  6 ++--
 t/t3431-rebase-update-branches.sh | 64 ++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 5 deletions(-)
 create mode 100755 t/t3431-rebase-update-branches.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6156609..c37a0db 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -246,6 +246,13 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 +
 See also INCOMPATIBLE OPTIONS below.
 
+--update-branches::
+	If there are branch refs that point to commits that will be
+	reapplied, add shell commands to the todo list to update those
+	refs to point to the commits in the final history.
++
+See also INCOMPATIBLE OPTIONS below.
+
 --allow-empty-message::
 	By default, rebasing commits with an empty message will fail.
 	This option overrides that behavior, allowing commits with empty
@@ -535,6 +542,7 @@ are incompatible with the following options:
  * --interactive
  * --exec
  * --keep-empty
+ * --update-branches
  * --edit-todo
  * --root when used in combination with --onto
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 670096c..cf87c53 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -78,6 +78,7 @@ struct rebase_options {
 	int signoff;
 	int allow_rerere_autoupdate;
 	int keep_empty;
+	int update_branches;
 	int autosquash;
 	char *gpg_sign_opt;
 	int autostash;
@@ -349,8 +350,8 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto, head_hash,
-			&commands, opts->autosquash, &todo_list);
+			shortrevisions, opts->onto_name, opts->onto, opts->head_name,
+			head_hash, &commands, opts->autosquash, &todo_list);
 	}
 
 	string_list_clear(&commands, 0);
@@ -375,6 +376,7 @@ static int run_rebase_interactive(struct rebase_options *opts,
 	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
 	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
 	flags |= command == ACTION_SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+	flags |= opts->update_branches ? TODO_LIST_UPDATE_BRANCHES : 0;
 
 	switch (command) {
 	case ACTION_NONE: {
@@ -447,6 +449,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
 		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
+		OPT_BOOL(0, "update-branches", &opts.update_branches,
+			 N_("update branches that point to reapplied commits")),
 		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
 			 N_("allow commits with empty messages")),
 		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
@@ -1453,6 +1457,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
+		OPT_BOOL(0, "update-branches", &options.update_branches,
+			 N_("update branches that point to reapplied commits")),
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
@@ -1710,6 +1716,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.keep_empty)
 		imply_interactive(&options, "--keep-empty");
 
+	if (options.update_branches)
+		imply_interactive(&options, "--update-branches");
+
 	if (gpg_sign) {
 		free(options.gpg_sign_opt);
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
diff --git a/sequencer.c b/sequencer.c
index 34ebf8e..c6749ff 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4901,6 +4901,69 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 	todo_list->alloc = alloc;
 }
 
+/*
+ * Add commands to update branch refs after the todo list would pick a commit
+ * that a branch ref points to.
+ */
+static void todo_list_add_branch_updates(struct todo_list *todo_list,
+				       const char *head_name)
+{
+	struct strbuf *buf = &todo_list->buf;
+	int i, nr = 0, alloc = 0;
+	struct todo_item *items = NULL;
+
+	load_ref_decorations(NULL, 0);
+
+	for (i = 0; i < todo_list->nr; i++) {
+		const struct todo_item *item = &todo_list->items[i];
+		enum todo_command command = item->command;
+		const struct name_decoration *decoration;
+
+		ALLOC_GROW(items, nr + 1, alloc);
+		items[nr++] = todo_list->items[i];
+
+		switch (command) {
+		case TODO_PICK:
+		case TODO_MERGE:
+			break;
+		default:
+			continue;
+		}
+
+		decoration = get_name_decoration(&item->commit->object);
+		for (; decoration; decoration = decoration->next) {
+			size_t base_offset, pretty_name_len;
+			const char *pretty_name;
+
+			if (decoration->type != DECORATION_REF_LOCAL)
+				continue;
+			if (!strcmp(decoration->name, head_name))
+				// Rebase itself will update the current branch for us.
+				continue;
+
+			base_offset = buf->len;
+			pretty_name = prettify_refname(decoration->name);
+			pretty_name_len = strlen(pretty_name);
+			strbuf_addstr(buf, "exec git branch -f ");
+			strbuf_addstr(buf, pretty_name);
+			strbuf_addch(buf, '\n');
+
+			ALLOC_GROW(items, nr + 1, alloc);
+			items[nr++] = (struct todo_item) {
+				.command = TODO_EXEC,
+				.offset_in_buf = base_offset,
+				.arg_offset = base_offset + strlen("exec "),
+				.arg_len = strlen("git branch -f ") + pretty_name_len,
+			};
+		}
+	}
+
+	FREE_AND_NULL(todo_list->items);
+	todo_list->items = items;
+	todo_list->nr = nr;
+	todo_list->alloc = alloc;
+}
+
 static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_list,
 				struct strbuf *buf, int num, unsigned flags)
 {
@@ -5051,7 +5114,7 @@ static int skip_unnecessary_picks(struct repository *r,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head,
+		    struct commit *onto, const char *head_name, const char *orig_head,
 		    struct string_list *commands, unsigned autosquash,
 		    struct todo_list *todo_list)
 {
@@ -5076,6 +5139,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (commands->nr)
 		todo_list_add_exec_commands(todo_list, commands);
 
+	if (flags & TODO_LIST_UPDATE_BRANCHES)
+		todo_list_add_branch_updates(todo_list, head_name);
+
 	if (count_commands(todo_list) == 0) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
diff --git a/sequencer.h b/sequencer.h
index 6704acb..69c6f71 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -143,6 +143,7 @@ int sequencer_remove_state(struct replay_opts *opts);
  */
 #define TODO_LIST_REBASE_COUSINS (1U << 4)
 #define TODO_LIST_APPEND_TODO_HELP (1U << 5)
+#define TODO_LIST_UPDATE_BRANCHES (1U << 6)
 
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
@@ -152,8 +153,9 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 int check_todo_list_from_file(struct repository *r);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash, struct todo_list *todo_list);
+		    struct commit *onto, const char *head_name, const char *orig_head,
+		    struct string_list *commands, unsigned autosquash,
+		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 /*
diff --git a/t/t3431-rebase-update-branches.sh b/t/t3431-rebase-update-branches.sh
new file mode 100755
index 0000000..221c25d
--- /dev/null
+++ b/t/t3431-rebase-update-branches.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='git rebase -i --update-branches
+
+This test runs git rebase, moving branch refs that point to commits
+that are reapplied.
+
+Initial setup:
+
+ A - B          (master)
+  |\
+  |  C          (linear-early)
+  |    \
+  |      D      (linear-late)
+  |\
+  |  E          (feat-e)
+   \   \
+     F  |       (feat-f)
+       \|
+         G      (interim)
+           \
+             H  (my-dev)
+'
+. ./test-lib.sh
+
+test_expect_success 'setup linear' '
+	test_commit A &&
+	test_commit B &&
+	git checkout -b linear-early A &&
+	test_commit C &&
+	git checkout -b linear-late &&
+	test_commit D
+'
+
+test_expect_success 'smoketest linear' '
+	git rebase --update-branches master
+'
+
+test_expect_success 'check linear' '
+	git rev-parse linear-early:B.t
+'
+
+test_expect_success 'setup merge' '
+	git checkout -b feat-e A &&
+	test_commit E &&
+	git checkout -b feat-f A &&
+	test_commit F &&
+	git checkout -b interim &&
+	test_merge G feat-e &&
+	git checkout -b my-dev &&
+	test_commit H
+'
+
+test_expect_success 'smoketest merge' '
+	git rebase -r --update-branches master
+'
+
+test_expect_success 'check merge' '
+	git rev-parse feat-e:B.t &&
+	git rev-parse feat-f:B.t &&
+	git rev-parse interim:B.t
+'
+
+test_done
-- 
2.7.4

