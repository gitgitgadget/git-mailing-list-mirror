Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAB91F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeKJPdT (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44587 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeKJPdS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:18 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2815059lfe.11
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdWIDfwKkXRtzDNapMJl5b5XaZ1pQZDdxdXUDXqxrQg=;
        b=tt+cv4rMXmufKAPxU/kJoBAJW4Xk54LHtnpqNTDPYhKbECxbeRQj++aERV8yoQc/R/
         x23V2Q6dYr0BW9UlUaSSfEcfyGw/SHDGO3GAlFKfjT0cV46GPZ6DW47gafTyWw7E5srw
         q5//Lz+NLAfIKEb2T7WNpfPbQS/Oni3S2M5fxALCdAt6d2JrVprjE4YVajQ76zbmiBF4
         a/lKxGDMAlEs6DFEPw2RaktU4x4ljHjMi1CxtZ3sXsF8csFJBMx3b+wlrwIFMHZtOmpn
         XZ4LMPt7srPpwkec54ZcWT1qzV2Sfp1s6cVb+w34OslJ8q3QuG9ODxoyCVJxsy+lvymA
         ohYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdWIDfwKkXRtzDNapMJl5b5XaZ1pQZDdxdXUDXqxrQg=;
        b=bk9dtACjLtcdUqJzrhb+Fp9NsfE4fpvnVsuZL7CSic++Vmxo9As3rFDgRQmC/lRcMO
         luVACohduA46/X90h38xjA4//wmuM9dO2r7Q6bHQSUVFFswyPMH4/Z6LxYWRXcUd21u6
         tfZSymmntqgBqUb++u9LEn96pMneCPUDwzvbx0VTy+mwcxMKpj/6pt7MFPivKYJ07sh8
         wQD+nFnWYiIu/KYJH9wTqBTnB3kvfF/rB6yfxjcgLrRYODFaJVUuBQ09Ke0LJtD3ET+J
         wUz0ld3EegQdcRf1UYJXp6t42dEzHWEZFoXdJix1zFiCGeWATjWSTg6NXomQAAHKLw9x
         Mt6A==
X-Gm-Message-State: AGRZ1gL0dRce7RdJgRFUuGlPmToLvAR5jiyIvbCRBc74iNOOilWVbz2M
        z2IPiXnhseZC0H0Q5TDkhFCBPC0+
X-Google-Smtp-Source: AJdET5eeFSXC9ki9f5cZg2wjD1EFHWEZAcoNoj9WAkXGv37gI+Uurj48Cc5cNtC1qHnMor5ZjR2hZA==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr7421648lfb.140.1541828969084;
        Fri, 09 Nov 2018 21:49:29 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:28 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/22] sequencer.c: remove implicit dependency on the_repository
Date:   Sat, 10 Nov 2018 06:48:57 +0100
Message-Id: <20181110054910.10568-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note that the_hash_algo stays, even if we can easily replace it with
repo->hash_algo. My reason is I still believe tying hash_algo to a
struct repository is a wrong move. But if I'm wrong, we can always go
for another round of conversion.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/rebase--interactive.c |  11 +--
 builtin/revert.c              |   2 +-
 rebase-interactive.c          |   4 +-
 sequencer.c                   | 134 ++++++++++++++++++----------------
 sequencer.h                   |  12 +--
 5 files changed, 86 insertions(+), 77 deletions(-)

diff --git a/builtin/rebase--interactive.c b/builtin/rebase--interactive.c
index b7ce48a1ec..d867050fd2 100644
--- a/builtin/rebase--interactive.c
+++ b/builtin/rebase--interactive.c
@@ -114,7 +114,8 @@ static int do_interactive_rebase(struct replay_opts *opts, unsigned flags,
 		error(_("could not generate todo list"));
 	else {
 		discard_cache();
-		ret = complete_action(opts, flags, shortrevisions, onto_name, onto,
+		ret = complete_action(the_repository, opts, flags,
+				      shortrevisions, onto_name, onto,
 				      head_hash, cmd, autosquash);
 	}
 
@@ -252,16 +253,16 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	}
 	case SHORTEN_OIDS:
 	case EXPAND_OIDS:
-		ret = transform_todos(flags);
+		ret = transform_todos(the_repository, flags);
 		break;
 	case CHECK_TODO_LIST:
-		ret = check_todo_list();
+		ret = check_todo_list(the_repository);
 		break;
 	case REARRANGE_SQUASH:
-		ret = rearrange_squash();
+		ret = rearrange_squash(the_repository);
 		break;
 	case ADD_EXEC:
-		ret = sequencer_add_exec_commands(cmd);
+		ret = sequencer_add_exec_commands(the_repository, cmd);
 		break;
 	default:
 		BUG("invalid command '%d'", command);
diff --git a/builtin/revert.c b/builtin/revert.c
index cd9f068195..1fa75b2773 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -201,7 +201,7 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	if (cmd == 'c')
 		return sequencer_continue(the_repository, opts);
 	if (cmd == 'a')
-		return sequencer_rollback(opts);
+		return sequencer_rollback(the_repository, opts);
 	return sequencer_pick_revisions(the_repository, opts);
 }
 
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 78f3263fc1..3cc19283ff 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -69,7 +69,7 @@ int edit_todo_list(unsigned flags)
 
 	strbuf_release(&buf);
 
-	transform_todos(flags | TODO_LIST_SHORTEN_IDS);
+	transform_todos(the_repository, flags | TODO_LIST_SHORTEN_IDS);
 
 	if (strbuf_read_file(&buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
@@ -85,7 +85,7 @@ int edit_todo_list(unsigned flags)
 	if (launch_sequence_editor(todo_file, NULL, NULL))
 		return -1;
 
-	transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS));
+	transform_todos(the_repository, flags & ~(TODO_LIST_SHORTEN_IDS));
 
 	return 0;
 }
diff --git a/sequencer.c b/sequencer.c
index 6cf3f65b0c..111cb747d6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -356,7 +356,8 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void print_advice(int show_hint, struct replay_opts *opts)
+static void print_advice(struct repository *r, int show_hint,
+			 struct replay_opts *opts)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
@@ -367,7 +368,7 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 		 * (typically rebase --interactive) wants to take care
 		 * of the commit itself so remove CHERRY_PICK_HEAD
 		 */
-		unlink(git_path_cherry_pick_head(the_repository));
+		unlink(git_path_cherry_pick_head(r));
 		return;
 	}
 
@@ -440,9 +441,9 @@ static int read_oneliner(struct strbuf *buf,
 	return 1;
 }
 
-static struct tree *empty_tree(void)
+static struct tree *empty_tree(struct repository *r)
 {
-	return lookup_tree(the_repository, the_repository->hash_algo->empty_tree);
+	return lookup_tree(r, the_hash_algo->empty_tree);
 }
 
 static int error_dirty_index(struct index_state *istate, struct replay_opts *opts)
@@ -553,8 +554,8 @@ static int do_recursive_merge(struct repository *r,
 	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
-	next_tree = next ? get_commit_tree(next) : empty_tree();
-	base_tree = base ? get_commit_tree(base) : empty_tree();
+	next_tree = next ? get_commit_tree(next) : empty_tree(r);
+	base_tree = base ? get_commit_tree(base) : empty_tree(r);
 
 	for (xopt = opts->xopts; xopt != opts->xopts + opts->xopts_nr; xopt++)
 		parse_merge_opt(&o, *xopt);
@@ -600,15 +601,16 @@ static struct object_id *get_cache_tree_oid(struct index_state *istate)
 	return &istate->cache_tree->oid;
 }
 
-static int is_index_unchanged(struct index_state *istate)
+static int is_index_unchanged(struct repository *r)
 {
 	struct object_id head_oid, *cache_tree_oid;
 	struct commit *head_commit;
+	struct index_state *istate = r->index;
 
 	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL))
 		return error(_("could not resolve HEAD commit"));
 
-	head_commit = lookup_commit(the_repository, &head_oid);
+	head_commit = lookup_commit(r, &head_oid);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
@@ -1225,7 +1227,7 @@ void print_commit_summary(struct repository *r,
 	strbuf_release(&format);
 }
 
-static int parse_head(struct commit **head)
+static int parse_head(struct repository *r, struct commit **head)
 {
 	struct commit *current_head;
 	struct object_id oid;
@@ -1233,7 +1235,7 @@ static int parse_head(struct commit **head)
 	if (get_oid("HEAD", &oid)) {
 		current_head = NULL;
 	} else {
-		current_head = lookup_commit_reference(the_repository, &oid);
+		current_head = lookup_commit_reference(r, &oid);
 		if (!current_head)
 			return error(_("could not parse HEAD"));
 		if (!oideq(&oid, &current_head->object.oid)) {
@@ -1273,7 +1275,7 @@ static int try_to_commit(struct repository *r,
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
-	if (parse_head(&current_head))
+	if (parse_head(r, &current_head))
 		return -1;
 
 	if (flags & AMEND_MSG) {
@@ -1440,7 +1442,7 @@ static int allow_empty(struct repository *r,
 	if (!opts->allow_empty)
 		return 0; /* let "git commit" barf as necessary */
 
-	index_unchanged = is_index_unchanged(r->index);
+	index_unchanged = is_index_unchanged(r);
 	if (index_unchanged < 0)
 		return index_unchanged;
 	if (!index_unchanged)
@@ -1544,8 +1546,10 @@ static int is_pick_or_similar(enum todo_command command)
 	}
 }
 
-static int update_squash_messages(enum todo_command command,
-		struct commit *commit, struct replay_opts *opts)
+static int update_squash_messages(struct repository *r,
+				  enum todo_command command,
+				  struct commit *commit,
+				  struct replay_opts *opts)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int res;
@@ -1574,7 +1578,7 @@ static int update_squash_messages(enum todo_command command,
 
 		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(the_repository, &head)))
+		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
@@ -1813,7 +1817,7 @@ static int do_pick_commit(struct repository *r,
 	if (command == TODO_REWORD)
 		flags |= EDIT_MSG | VERIFY_MSG;
 	else if (is_fixup(command)) {
-		if (update_squash_messages(command, commit, opts))
+		if (update_squash_messages(r, command, commit, opts))
 			return -1;
 		flags |= AMEND_MSG;
 		if (!final_fixup)
@@ -1883,7 +1887,7 @@ static int do_pick_commit(struct repository *r,
 		      ? _("could not revert %s... %s")
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
-		print_advice(res == 1, opts);
+		print_advice(r, res == 1, opts);
 		repo_rerere(r, opts->allow_rerere_auto);
 		goto leave;
 	}
@@ -1990,7 +1994,8 @@ static struct todo_item *append_new_todo(struct todo_list *todo_list)
 	return todo_list->items + todo_list->nr++;
 }
 
-static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
+static int parse_insn_line(struct repository *r, struct todo_item *item,
+			   const char *bol, char *eol)
 {
 	struct object_id commit_oid;
 	char *end_of_object_name;
@@ -2075,11 +2080,12 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (status < 0)
 		return -1;
 
-	item->commit = lookup_commit_reference(the_repository, &commit_oid);
+	item->commit = lookup_commit_reference(r, &commit_oid);
 	return !item->commit;
 }
 
-static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
+static int parse_insn_buffer(struct repository *r, char *buf,
+			     struct todo_list *todo_list)
 {
 	struct todo_item *item;
 	char *p = buf, *next_p;
@@ -2095,7 +2101,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 
 		item = append_new_todo(todo_list);
 		item->offset_in_buf = p - todo_list->buf.buf;
-		if (parse_insn_line(item, p, eol)) {
+		if (parse_insn_line(r, item, p, eol)) {
 			res = error(_("invalid line %d: %.*s"),
 				i, (int)(eol - p), p);
 			item->command = TODO_NOOP;
@@ -2156,8 +2162,9 @@ static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
 	return len;
 }
 
-static int read_populate_todo(struct todo_list *todo_list,
-			struct replay_opts *opts)
+static int read_populate_todo(struct repository *r,
+			      struct todo_list *todo_list,
+			      struct replay_opts *opts)
 {
 	struct stat st;
 	const char *todo_file = get_todo_path(opts);
@@ -2172,7 +2179,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		return error(_("could not stat '%s'"), todo_file);
 	fill_stat_data(&todo_list->stat, &st);
 
-	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
+	res = parse_insn_buffer(r, todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
 			return error(_("please fix this using "
@@ -2203,7 +2210,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
-				!parse_insn_buffer(done.buf.buf, &done))
+		    !parse_insn_buffer(r, done.buf.buf, &done))
 			todo_list->done_nr = count_commands(&done);
 		else
 			todo_list->done_nr = 0;
@@ -2520,12 +2527,12 @@ static int reset_for_rollback(const struct object_id *oid)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int rollback_single_pick(void)
+static int rollback_single_pick(struct repository *r)
 {
 	struct object_id head_oid;
 
-	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
-	    !file_exists(git_path_revert_head(the_repository)))
+	if (!file_exists(git_path_cherry_pick_head(r)) &&
+	    !file_exists(git_path_revert_head(r)))
 		return error(_("no cherry-pick or revert in progress"));
 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
 		return error(_("cannot resolve HEAD"));
@@ -2534,7 +2541,7 @@ static int rollback_single_pick(void)
 	return reset_for_rollback(&head_oid);
 }
 
-int sequencer_rollback(struct replay_opts *opts)
+int sequencer_rollback(struct repository *r, struct replay_opts *opts)
 {
 	FILE *f;
 	struct object_id oid;
@@ -2548,7 +2555,7 @@ int sequencer_rollback(struct replay_opts *opts)
 		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
 		 * a single-cherry-pick in progress, abort that.
 		 */
-		return rollback_single_pick();
+		return rollback_single_pick(r);
 	}
 	if (!f)
 		return error_errno(_("cannot open '%s'"), git_path_head_file());
@@ -3427,14 +3434,14 @@ static int checkout_onto(struct replay_opts *opts,
 	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 }
 
-static int stopped_at_head(void)
+static int stopped_at_head(struct repository *r)
 {
 	struct object_id head;
 	struct commit *commit;
 	struct commit_message message;
 
 	if (get_oid("HEAD", &head) ||
-	    !(commit = lookup_commit(the_repository, &head)) ||
+	    !(commit = lookup_commit(r, &head)) ||
 	    parse_commit(commit) || get_message(commit, &message))
 		fprintf(stderr, _("Stopped at HEAD\n"));
 	else {
@@ -3495,7 +3502,7 @@ static int pick_commits(struct repository *r,
 			delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
 
 			if (item->command == TODO_BREAK)
-				return stopped_at_head();
+				return stopped_at_head(r);
 		}
 		if (item->command <= TODO_SQUASH) {
 			if (is_rebase_i(opts))
@@ -3572,7 +3579,7 @@ static int pick_commits(struct repository *r,
 						  get_todo_path(opts));
 			else if (match_stat_data(&todo_list->stat, &st)) {
 				todo_list_release(todo_list);
-				if (read_populate_todo(todo_list, opts))
+				if (read_populate_todo(r, todo_list, opts))
 					res = -1; /* message was printed */
 				/* `current` will be incremented below */
 				todo_list->current = -1;
@@ -3732,12 +3739,12 @@ static int pick_commits(struct repository *r,
 	return sequencer_remove_state(opts);
 }
 
-static int continue_single_pick(void)
+static int continue_single_pick(struct repository *r)
 {
 	const char *argv[] = { "commit", NULL };
 
-	if (!file_exists(git_path_cherry_pick_head(the_repository)) &&
-	    !file_exists(git_path_revert_head(the_repository)))
+	if (!file_exists(git_path_cherry_pick_head(r)) &&
+	    !file_exists(git_path_revert_head(r)))
 		return error(_("no cherry-pick or revert in progress"));
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
@@ -3836,7 +3843,7 @@ static int commit_staged_changes(struct repository *r,
 				struct commit *commit;
 				const char *path = rebase_path_squash_msg();
 
-				if (parse_head(&commit) ||
+				if (parse_head(r, &commit) ||
 				    !(p = get_commit_buffer(commit, NULL)) ||
 				    write_message(p, strlen(p), path, 0)) {
 					unuse_commit_buffer(commit, p);
@@ -3891,20 +3898,20 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 	if (read_populate_opts(opts))
 		return -1;
 	if (is_rebase_i(opts)) {
-		if ((res = read_populate_todo(&todo_list, opts)))
+		if ((res = read_populate_todo(r, &todo_list, opts)))
 			goto release_todo_list;
 		if (commit_staged_changes(r, opts, &todo_list))
 			return -1;
 	} else if (!file_exists(get_todo_path(opts)))
-		return continue_single_pick();
-	else if ((res = read_populate_todo(&todo_list, opts)))
+		return continue_single_pick(r);
+	else if ((res = read_populate_todo(r, &todo_list, opts)))
 		goto release_todo_list;
 
 	if (!is_rebase_i(opts)) {
 		/* Verify that the conflict has been resolved */
 		if (file_exists(git_path_cherry_pick_head(r)) ||
 		    file_exists(git_path_revert_head(r))) {
-			res = continue_single_pick();
+			res = continue_single_pick(r);
 			if (res)
 				goto release_todo_list;
 		}
@@ -4477,7 +4484,8 @@ int sequencer_make_script(struct repository *r, FILE *out,
  * Add commands after pick and (series of) squash/fixup commands
  * in the todo list.
  */
-int sequencer_add_exec_commands(const char *commands)
+int sequencer_add_exec_commands(struct repository *r,
+				const char *commands)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4488,7 +4496,7 @@ int sequencer_add_exec_commands(const char *commands)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4533,7 +4541,7 @@ int sequencer_add_exec_commands(const char *commands)
 	return i;
 }
 
-int transform_todos(unsigned flags)
+int transform_todos(struct repository *r, unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4544,7 +4552,7 @@ int transform_todos(unsigned flags)
 	if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
 		return error(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list)) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4613,7 +4621,7 @@ define_commit_slab(commit_seen, unsigned char);
  * Check if there is an unrecognized command or a
  * bad SHA-1 in a command.
  */
-int check_todo_list(void)
+int check_todo_list(struct repository *r)
 {
 	enum missing_commit_check_level check_level = get_missing_commit_check_level();
 	struct strbuf todo_file = STRBUF_INIT;
@@ -4630,7 +4638,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	advise_to_edit_todo = res =
-		parse_insn_buffer(todo_list.buf.buf, &todo_list);
+		parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	if (res || check_level == MISSING_COMMIT_CHECK_IGNORE)
 		goto leave_check;
@@ -4649,7 +4657,7 @@ int check_todo_list(void)
 		goto leave_check;
 	}
 	strbuf_release(&todo_file);
-	res = !!parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	res = !!parse_insn_buffer(r, todo_list.buf.buf, &todo_list);
 
 	/* Find commits in git-rebase-todo.backup yet unseen */
 	for (i = todo_list.nr - 1; i >= 0; i--) {
@@ -4713,7 +4721,7 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 }
 
 /* skip picking commits whose parents are unchanged */
-static int skip_unnecessary_picks(struct object_id *output_oid)
+static int skip_unnecessary_picks(struct repository *r, struct object_id *output_oid)
 {
 	const char *todo_file = rebase_path_todo();
 	struct strbuf buf = STRBUF_INIT;
@@ -4731,7 +4739,7 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
@@ -4792,7 +4800,7 @@ static int skip_unnecessary_picks(struct object_id *output_oid)
 	return 0;
 }
 
-int complete_action(struct replay_opts *opts, unsigned flags,
+int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
 		    unsigned autosquash)
@@ -4810,16 +4818,16 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 	    write_message("noop\n", 5, todo_file, 0))
 		return -1;
 
-	if (autosquash && rearrange_squash())
+	if (autosquash && rearrange_squash(r))
 		return -1;
 
 	if (cmd && *cmd)
-		sequencer_add_exec_commands(cmd);
+		sequencer_add_exec_commands(r, cmd);
 
 	if (strbuf_read_file(buf, todo_file, 0) < 0)
 		return error_errno(_("could not read '%s'."), todo_file);
 
-	if (parse_insn_buffer(buf->buf, &todo_list)) {
+	if (parse_insn_buffer(r, buf->buf, &todo_list)) {
 		todo_list_release(&todo_list);
 		return error(_("unusable todo list: '%s'"), todo_file);
 	}
@@ -4848,7 +4856,7 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 		return error(_("could not copy '%s' to '%s'."), todo_file,
 			     rebase_path_todo_backup());
 
-	if (transform_todos(flags | TODO_LIST_SHORTEN_IDS))
+	if (transform_todos(r, flags | TODO_LIST_SHORTEN_IDS))
 		return error(_("could not transform the todo list"));
 
 	strbuf_reset(buf);
@@ -4872,24 +4880,24 @@ int complete_action(struct replay_opts *opts, unsigned flags,
 
 	todo_list_release(&todo_list);
 
-	if (check_todo_list()) {
+	if (check_todo_list(r)) {
 		checkout_onto(opts, onto_name, onto, orig_head);
 		return -1;
 	}
 
-	if (transform_todos(flags & ~(TODO_LIST_SHORTEN_IDS)))
+	if (transform_todos(r, flags & ~(TODO_LIST_SHORTEN_IDS)))
 		return error(_("could not transform the todo list"));
 
-	if (opts->allow_ff && skip_unnecessary_picks(&oid))
+	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
 		return error(_("could not skip unnecessary pick commands"));
 
 	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
 		return -1;
 ;
-	if (require_clean_work_tree(the_repository, "rebase", "", 1, 1))
+	if (require_clean_work_tree(r, "rebase", "", 1, 1))
 		return -1;
 
-	return sequencer_continue(the_repository, opts);
+	return sequencer_continue(r, opts);
 }
 
 struct subject2item_entry {
@@ -4916,7 +4924,7 @@ define_commit_slab(commit_todo_item, struct todo_item *);
  * message will have to be retrieved from the commit (as the oneline in the
  * script cannot be trusted) in order to normalize the autosquash arrangement.
  */
-int rearrange_squash(void)
+int rearrange_squash(struct repository *r)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -4927,7 +4935,7 @@ int rearrange_squash(void)
 
 	if (strbuf_read_file_or_whine(&todo_list.buf, todo_file) < 0)
 		return -1;
-	if (parse_insn_buffer(todo_list.buf.buf, &todo_list) < 0) {
+	if (parse_insn_buffer(r, todo_list.buf.buf, &todo_list) < 0) {
 		todo_list_release(&todo_list);
 		return -1;
 	}
diff --git a/sequencer.h b/sequencer.h
index ba86515ad6..d2c18edd3a 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -78,7 +78,7 @@ void sequencer_init_config(struct replay_opts *opts);
 int sequencer_pick_revisions(struct repository *repo,
 			     struct replay_opts *opts);
 int sequencer_continue(struct repository *repo, struct replay_opts *opts);
-int sequencer_rollback(struct replay_opts *opts);
+int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 #define TODO_LIST_KEEP_EMPTY (1U << 0)
@@ -95,15 +95,15 @@ int sequencer_make_script(struct repository *repo, FILE *out,
 			  int argc, const char **argv,
 			  unsigned flags);
 
-int sequencer_add_exec_commands(const char *command);
-int transform_todos(unsigned flags);
+int sequencer_add_exec_commands(struct repository *r, const char *command);
+int transform_todos(struct repository *r, unsigned flags);
 enum missing_commit_check_level get_missing_commit_check_level(void);
-int check_todo_list(void);
-int complete_action(struct replay_opts *opts, unsigned flags,
+int check_todo_list(struct repository *r);
+int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    const char *onto, const char *orig_head, const char *cmd,
 		    unsigned autosquash);
-int rearrange_squash(void);
+int rearrange_squash(struct repository *r);
 
 extern const char sign_off_header[];
 
-- 
2.19.1.1231.g84aef82467

