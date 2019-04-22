Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16BD20374
	for <e@80x24.org>; Mon, 22 Apr 2019 00:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfDVAHf (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 20:07:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44604 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfDVAHf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 20:07:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so4868783pfm.11
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 17:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZW/cQXleWVmhmDvJIsdF2xKjhr0AwWCW7guMUlkLJoU=;
        b=YFBkwIlnyZZ8xT4OBK0NwbkGZvn3ZxEhjExlj28vf2Y1/cjDim2Hv34JsIeT664gh5
         Qt21XBal4hboQGga1yLWbL4QPcM3Bx+qTwe3A+gcCq6e5trCHfYi6daeiGNnn0vYmcwC
         p7dKVW+yBiiVM7dHitXrvQLKquZuLpS8sQFxxPhIQnTEqBagKIj8DE7E+Q0+41EcZ0mu
         kxWL3BlFi3OoSrFHOawT37p4y9RmJi8Elibe8R2BBHvC+wLW5APp2+PylNUVWO5ygS8/
         KV006M5YVydd3MOBDHCb30jQDuuwYO8fxaLhJSlGEfPWqQIX5pd1MZP8JCPnJO9HlrMq
         BaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZW/cQXleWVmhmDvJIsdF2xKjhr0AwWCW7guMUlkLJoU=;
        b=qvclHbgrbxROcIOpKxpLRMxCoZTTSFWWMjkG++yjyXf/tRLogYaQPpHBMUkQRxR1aj
         VxluSrPkRLWu4fO+J4ylSnq5ktp7Sjg33KbCQCPAj/zRQKUlDlHuSye43EMyA+la7pcm
         N6JKbZNfRnUNLsclpl6gMY6gHGpqyfc8G8Q+oKj8IJ55JR5navNnq1xvOFMsJNcmQvSJ
         iK7cQ/5FfffxG5PATrB041gplO4JvslVUo5RgcSvifTSjXHKh+9K1zRMZCzvS3reOppA
         kWgAU878vOdsSPxFA6Mj0LQ8BKl62TYgtwypeP+1gpVfyh1Ih6r3p/oLYQzwsgllwu3/
         pd/g==
X-Gm-Message-State: APjAAAXV6wgQ4bZMPR2UXOnLr0AP2nR1FhZgAjQyyZFXbNB3W7c0hCWL
        UfKbe5dgR+6hEilcPRkHuD7f79/l
X-Google-Smtp-Source: APXvYqyNHoYqjspIHF+AT5K4Wg81JKR34k4UohRhFJTny7CUKntM1+mAZAATS7FOeMRVa56TxV6nxw==
X-Received: by 2002:a63:8f49:: with SMTP id r9mr9697216pgn.306.1555891653821;
        Sun, 21 Apr 2019 17:07:33 -0700 (PDT)
Received: from phord-x1.hsd1.ca.comcast.net ([2601:647:5701:455f:49f6:143c:5261:44c0])
        by smtp.gmail.com with ESMTPSA id h189sm21163918pfc.125.2019.04.21.17.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 17:07:32 -0700 (PDT)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH/RFC 1/2] rebase: add switches for drop, edit and reword
Date:   Sun, 21 Apr 2019 17:07:11 -0700
Message-Id: <20190422000712.13584-2-phil.hord@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190422000712.13584-1-phil.hord@gmail.com>
References: <20190422000712.13584-1-phil.hord@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

A common use for rebase is to drop or edit some commit in a
feature branch.  The commit to be changed is known in advance,
so a user will say 'git rebase -i that-commit^' to see the todo
list in her editor.  Then she will change the command on the line
for "that-commit" to edit instead of pick, or delete the line
altogether.

This involves 'git log' to find the commit in the first place,
the cli to start the rebase, the editor to make a single change, and
some mental context switch from "that-commit" to its hash so she can
be sure to edit the correct line.

Introduce some new "edit-todo" switches to the rebase command to
simplify this cycle.  Add 3 new switches to support common
todo-list operations.
    '--drop <ref>' to drop a specific commit,
    '--edit <ref>' to edit a specific commit,
    '--reword <ref>' to reword a specific commit,

Allow each switch to be used mutliple times on the command line so more
than one ref could be dropped, for example.

Complain and abort the rebase if a mentioned ref is not in the
todo-list in the first place so the user doesn't get a wrong idea
from a successful 'git rebase --drop foo' that did nothing since
no foo was encountered.

Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 builtin/rebase--interactive.c | 46 +++++++++++++++-
 builtin/rebase.c              | 44 ++++++++++++++++
 sequencer.c                   | 98 ++++++++++++++++++++++++++++++-----
 sequencer.h                   | 21 +++++++-
 4 files changed, 192 insertions(+), 17 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index 4535523bf5..9285d05443 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -140,6 +140,34 @@ static int get_revision_ranges(const char *upstream, const char *onto,
 	return 0;
 }

+static int resolve_commit_list(const struct string_list *str,
+			       struct commit_list **revs)
+{
+	struct object_id oid;
+	int i;
+	for (i = 0; i < str->nr; i++) {
+		struct commit *r;
+		const char * ref = str->items[i].string;
+		if (get_oid(ref, &oid))
+			return error(_("cannot resolve %s"), ref);
+
+		r = lookup_commit_reference(the_repository, &oid);
+		if (!r)
+			return error(_("%s is not a commit"), ref);
+
+		commit_list_insert(r, revs);
+		str->items[i].util = &(*revs)->item->object.oid;
+	}
+	return 0;
+}
+
+static int resolve_edits_commit_list(struct sequence_edits *edits)
+{
+	return resolve_commit_list(&edits->drop, &edits->revs) ||
+	       resolve_commit_list(&edits->edit, &edits->revs) ||
+	       resolve_commit_list(&edits->reword, &edits->revs);
+}
+
 static int init_basic_state(struct replay_opts *opts, const char *head_name,
 			    const char *onto, const char *orig_head)
 {
@@ -163,6 +191,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 				 const char *onto, const char *onto_name,
 				 const char *squash_onto, const char *head_name,
 				 const char *restrict_revision, char *raw_strategies,
+				 struct sequence_edits *edits,
 				 struct string_list *commands, unsigned autosquash)
 {
 	int ret;
@@ -197,7 +226,7 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,

 	ret = sequencer_make_script(the_repository, &todo_list.buf,
 				    make_script_args.argc, make_script_args.argv,
-				    flags);
+				    edits, flags);

 	if (ret)
 		error(_("could not generate todo list"));
@@ -233,6 +262,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		*squash_onto = NULL, *upstream = NULL, *head_name = NULL,
 		*switch_to = NULL, *cmd = NULL;
 	struct string_list commands = STRING_LIST_INIT_DUP;
+	struct sequence_edits edits = SEQUENCE_EDITS_INIT;
 	char *raw_strategies = NULL;
 	enum {
 		NONE = 0, CONTINUE, SKIP, EDIT_TODO, SHOW_CURRENT_PATCH,
@@ -272,6 +302,15 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 			   N_("restrict-revision"), N_("restrict revision")),
 		OPT_STRING(0, "squash-onto", &squash_onto, N_("squash-onto"),
 			   N_("squash onto")),
+		OPT_STRING_LIST(0, "drop", &edits.drop, N_("revision"),
+				N_("drop the mentioned ref from the "
+				   "todo list")),
+		OPT_STRING_LIST(0, "edit", &edits.edit, N_("revision"),
+				N_("edit the mentioned ref instead of "
+				   "picking it")),
+		OPT_STRING_LIST(0, "reword", &edits.reword, N_("revision"),
+				N_("reword the mentioned ref instead of "
+				   "picking it")),
 		OPT_STRING(0, "upstream", &upstream, N_("upstream"),
 			   N_("the upstream commit")),
 		OPT_STRING(0, "head-name", &head_name, N_("head-name"), N_("head name")),
@@ -325,6 +364,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 		string_list_remove_empty_items(&commands, 0);
 	}

+	resolve_edits_commit_list(&edits);
+
 	switch (command) {
 	case NONE:
 		if (!onto && !upstream)
@@ -332,7 +373,7 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)

 		ret = do_interactive_rebase(&opts, flags, switch_to, upstream, onto,
 					    onto_name, squash_onto, head_name, restrict_revision,
-					    raw_strategies, &commands, autosquash);
+					    raw_strategies, &edits, &commands, autosquash);
 		break;
 	case SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
@@ -373,5 +414,6 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}

 	string_list_clear(&commands, 0);
+	free_sequence_edits(&edits);
 	return !!ret;
 }
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e41ad5644..a8101630cf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -78,6 +78,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	char *cmd;
+	char *edit_switches;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
 	char *strategy, *strategy_opts;
@@ -694,6 +695,8 @@ static int run_specific_rebase(struct rebase_options *opts)
 					 opts->switch_to);
 		if (opts->cmd)
 			argv_array_pushf(&child.args, "--cmd=%s", opts->cmd);
+		if (opts->edit_switches)
+			argv_array_split(&child.args, opts->edit_switches);
 		if (opts->allow_empty_message)
 			argv_array_push(&child.args, "--allow-empty-message");
 		if (opts->allow_rerere_autoupdate > 0)
@@ -711,6 +714,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 		goto finished_rebase;
 	}

+	if (opts->edit_switches)
+		BUG("Unexpected rebase type with switches %d", opts->type);
+
 	if (opts->type == REBASE_AM) {
 		status = run_am(opts);
 		goto finished_rebase;
@@ -988,6 +994,28 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }

+static void forward_switches(struct rebase_options *options,
+			     const char *sw_name,
+			     struct string_list *values)
+{
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+
+	if (!values->nr)
+		return;
+
+	imply_interactive(options, sw_name);
+
+	if (!!options->edit_switches)
+		strbuf_addf(&buf, "%s ", options->edit_switches);
+
+	for (i = 0; i < values->nr; i++)
+		strbuf_addf(&buf, "%s %s ", sw_name, values->items[i].string);
+	strbuf_rtrim(&buf);
+	options->edit_switches = xstrdup(buf.buf);
+
+	strbuf_release(&buf);
+}

 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
@@ -1025,6 +1053,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 					      NULL };
 	const char *gpg_sign = NULL;
 	struct string_list exec = STRING_LIST_INIT_NODUP;
+	struct string_list reword = STRING_LIST_INIT_NODUP;
+	struct string_list edit = STRING_LIST_INIT_NODUP;
+	struct string_list drop = STRING_LIST_INIT_NODUP;
 	const char *rebase_merges = NULL;
 	int fork_point = -1;
 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
@@ -1107,6 +1138,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_STRING_LIST('x', "exec", &exec, N_("exec"),
 				N_("add exec lines after each commit of the "
 				   "editable list")),
+		OPT_STRING_LIST(0, "drop", &drop, N_("revision"),
+				N_("drop the mentioned ref from the "
+				   "todo list")),
+		OPT_STRING_LIST(0, "edit", &edit, N_("revision"),
+				N_("edit the mentioned ref instead of "
+				   "picking it")),
+		OPT_STRING_LIST(0, "reword", &reword, N_("revision"),
+				N_("reword the mentioned ref instead of "
+				   "picking it")),
 		OPT_BOOL(0, "allow-empty-message",
 			 &options.allow_empty_message,
 			 N_("allow rebasing commits with empty messages")),
@@ -1364,6 +1404,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.cmd = xstrdup(buf.buf);
 	}

+	forward_switches(&options, "--drop", &drop);
+	forward_switches(&options, "--edit", &edit);
+	forward_switches(&options, "--reword", &reword);
+
 	if (rebase_merges) {
 		if (!*rebase_merges)
 			; /* default mode; do nothing */
diff --git a/sequencer.c b/sequencer.c
index 546f281898..d7384d987c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4259,9 +4259,81 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	return string_entry->string;
 }

+void free_sequence_edits(struct sequence_edits *edits)
+{
+	string_list_clear(&edits->drop, 0);
+	string_list_clear(&edits->edit, 0);
+	string_list_clear(&edits->reword, 0);
+	free_commit_list(edits->revs);
+}
+
+/* Find an unmatched oid in the util pointer of our edit refs. If it's found
+   reset util to NULL and return 1. */
+static int consume_oid(const struct object_id *oid,
+		       const struct string_list *refs)
+{
+	int i;
+	for (i = 0; i < refs->nr; i++)
+		if (refs->items[i].util && oideq(oid, refs->items[i].util)) {
+			refs->items[i].util = NULL;
+			return 1;
+		}
+	return 0;
+}
+
+static int check_unused_refs(const struct string_list *refs)
+{
+	int i;
+	for (i = 0; i < refs->nr; i++)
+		if (refs->items[i].util)
+			return error(_("did not find '%s' in todo list"),
+					refs->items[i].string);
+	return 0;
+}
+
+static int check_unused_edits(const struct sequence_edits *edits)
+{
+	return check_unused_refs(&edits->drop) ||
+		check_unused_refs(&edits->edit) ||
+		check_unused_refs(&edits->reword);
+}
+
+static void add_todo_cmd(struct strbuf *buf, enum todo_command cmd,
+			      unsigned flags)
+{
+	if (flags & TODO_LIST_ABBREVIATE_CMDS)
+		strbuf_addch(buf, command_to_char(cmd));
+	else
+		strbuf_addstr(buf, command_to_string(cmd));
+}
+
+static void add_todo_cmd_oid(struct strbuf *buf, enum todo_command cmd,
+			     unsigned flags, const struct object_id *oid)
+{
+	add_todo_cmd(buf, cmd, flags);
+	strbuf_addf(buf, " %s ", oid_to_hex(oid));
+}
+
+static void add_edit_todo_inst(struct strbuf *buf, const struct object_id *oid,
+				const struct sequence_edits *edits,
+				unsigned flags)
+{
+	enum todo_command cmd = TODO_PICK;
+
+	if (consume_oid(oid, &edits->drop))
+		cmd = TODO_DROP;
+	else if (consume_oid(oid, &edits->edit))
+		cmd = TODO_EDIT;
+	else if (consume_oid(oid, &edits->reword))
+		cmd = TODO_REWORD;
+
+	add_todo_cmd_oid(buf, cmd, flags, oid);
+}
+
 static int make_script_with_merges(struct pretty_print_context *pp,
-				   struct rev_info *revs, struct strbuf *out,
-				   unsigned flags)
+				   struct rev_info *revs,
+				   const struct sequence_edits *edits,
+				   struct strbuf *out, unsigned flags)
 {
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
@@ -4277,8 +4349,7 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	struct label_state state = { OIDMAP_INIT, { NULL }, STRBUF_INIT };

 	int abbr = flags & TODO_LIST_ABBREVIATE_CMDS;
-	const char *cmd_pick = abbr ? "p" : "pick",
-		*cmd_label = abbr ? "l" : "label",
+	const char *cmd_label = abbr ? "l" : "label",
 		*cmd_reset = abbr ? "t" : "reset",
 		*cmd_merge = abbr ? "m" : "merge";

@@ -4322,9 +4393,9 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			strbuf_reset(&buf);
 			if (!keep_empty && is_empty)
 				strbuf_addf(&buf, "%c ", comment_line_char);
-			strbuf_addf(&buf, "%s %s %s", cmd_pick,
-				    oid_to_hex(&commit->object.oid),
-				    oneline.buf);
+			add_edit_todo_inst(&buf, &commit->object.oid, edits,
+					   flags);
+			strbuf_addbuf(&buf, &oneline);

 			FLEX_ALLOC_STR(entry, string, buf.buf);
 			oidcpy(&entry->entry.oid, &commit->object.oid);
@@ -4481,18 +4552,18 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	hashmap_free(&state.labels, 1);
 	strbuf_release(&state.buf);

-	return 0;
+	return check_unused_edits(edits);
 }

 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
-			  const char **argv, unsigned flags)
+			  const char **argv, const struct sequence_edits *edits,
+			  unsigned flags)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
 	struct rev_info revs;
 	struct commit *commit;
 	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
-	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
 	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;

 	repo_init_revisions(r, &revs, NULL);
@@ -4524,7 +4595,7 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 		return error(_("make_script: error preparing revisions"));

 	if (rebase_merges)
-		return make_script_with_merges(&pp, &revs, out, flags);
+		return make_script_with_merges(&pp, &revs, edits, out, flags);

 	while ((commit = get_revision(&revs))) {
 		int is_empty  = is_original_commit_empty(commit);
@@ -4533,12 +4604,11 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			continue;
 		if (!keep_empty && is_empty)
 			strbuf_addf(out, "%c ", comment_line_char);
-		strbuf_addf(out, "%s %s ", insn,
-			    oid_to_hex(&commit->object.oid));
+		add_edit_todo_inst(out, &commit->object.oid, edits, flags);
 		pretty_print_commit(&pp, commit, out);
 		strbuf_addch(out, '\n');
 	}
-	return 0;
+	return check_unused_edits(edits);
 }

 /*
diff --git a/sequencer.h b/sequencer.h
index a515ee4457..7887509fea 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -130,6 +130,24 @@ int sequencer_continue(struct repository *repo, struct replay_opts *opts);
 int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);

+/*
+ * The string_lists here contain the edit refs from the command-line. Each
+ * string_list_item's util pointer is pointed to the struct object_id * of
+ * the ref's oid by resolve_oids(), and util is set back to NULL when the
+ * ref is consumed during the todo-list generation.  After the todo-list is
+ * generated, any !!util strings were not encountered.
+ */
+struct sequence_edits {
+	struct commit_list *revs;
+	struct string_list drop;
+	struct string_list edit;
+	struct string_list reword;
+};
+#define SEQUENCE_EDITS_INIT { NULL, STRING_LIST_INIT_NODUP, \
+		STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP }
+void free_sequence_edits(struct sequence_edits *edits);
+
+
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
 #define TODO_LIST_SHORTEN_IDS (1U << 1)
 #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
@@ -143,7 +161,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 #define TODO_LIST_APPEND_TODO_HELP (1U << 5)

 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
-			  const char **argv, unsigned flags);
+			  const char **argv, const struct sequence_edits *edits,
+			  unsigned flags);

 void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
--
2.20.1
