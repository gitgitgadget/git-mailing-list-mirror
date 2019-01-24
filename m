Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1C061F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAXI3d (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:33 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39729 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXI3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so2349075pgl.6
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8UO2WreXdHVFioXoNKijmfBluGT2TIor+yDsLxZ/BD0=;
        b=DuXvzHUM2RS8MwzPHiiYW1yH7Zbihruk3VUsywTxN+YmcjSbY4ZucGNvQnWB+JBjq1
         UNS4BjQIyGQsdxWVuVOYqRaujxAKYYp9ftxqFqljNaXJny1yWLEK4vu1Myh9tkb79kCD
         Nmt23mADejqYbp4EspkxkQ3MLxxtdgGS0wYgHNwkzWR0pA+VWsVNIkqYP4TmAfq9Ubxs
         bZLOeUqE4ialua9okyVxsgaRvKALSYTBa1Srut4hjak8SQ1HpcJwNBVPkcVl91+pFU7y
         ezecN8s2EhpZ3GoVglP02dIKEnfE9GisOcnu3NWp6F/FoDi24PFCZZRmv81R6VGiANNg
         mm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8UO2WreXdHVFioXoNKijmfBluGT2TIor+yDsLxZ/BD0=;
        b=MliJ6dMEfN0g+HRn6LMsSMyLc6l4NwO/8QQZXzDiKLOQwG3AKvJkkoSdF7pZ3812vM
         J/VFLUNQCssTTOkye66wdfaxxMMFAHMx0vot2xYyr4BwJDBNGB/20rSTR9R0sIJGGvaN
         XsvqZ5ryWnFzLuKgKvI2CfkLV5v8kA7hX4HTyaDPgOlMSHsR2UTSgT0uyGsnSffaT265
         oO6tf432EB8+IHCO4FwRDjTTrOTHZ7cbXlSohBAnipSyFfOncAzCJb5LVy2UG5h2fUMf
         jlR/yp3y4u2UKjBspSuG3PyJzCuFf8G+TvPO5RqbwsNW77eg5ixAL/fcndrAtVxO3Hzb
         zOsQ==
X-Gm-Message-State: AJcUukdwMHlv23jQ86z+7jjrpVOp/ClFvtoj4meikLXufYwpvYy4IxjK
        SmcgLrf92bDXmtELmy2weyaQ1L4044s=
X-Google-Smtp-Source: ALg8bN6ZU5m7PrDoZKP8ePl5/RPakztaj1nNCbCmQzgxZzkkvVqyg5GJYn/KOJuMBRP43YLDcbPO7g==
X-Received: by 2002:a62:104a:: with SMTP id y71mr5495897pfi.34.1548318571608;
        Thu, 24 Jan 2019 00:29:31 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l19sm41038126pfi.71.2019.01.24.00.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/11] notes-utils.c: remove the_repository references
Date:   Thu, 24 Jan 2019 15:29:03 +0700
Message-Id: <20190124082912.24401-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c     |  2 +-
 builtin/commit.c |  2 +-
 builtin/notes.c  | 21 +++++++++++++--------
 notes-merge.c    |  4 ++--
 notes-utils.c    | 17 ++++++++++-------
 notes-utils.h    | 11 ++++++++---
 sequencer.c      |  7 ++++---
 sequencer.h      |  3 ++-
 8 files changed, 41 insertions(+), 26 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 95370313b6..d32044545d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -527,7 +527,7 @@ static int copy_notes_for_rebase(const struct am_state *state)
 	}
 
 finish:
-	finish_copy_notes_for_rewrite(c, msg);
+	finish_copy_notes_for_rewrite(the_repository, c, msg);
 	fclose(fp);
 	strbuf_release(&sb);
 	return ret;
diff --git a/builtin/commit.c b/builtin/commit.c
index 004b816635..e29fb5e3eb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1674,7 +1674,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
-		commit_post_rewrite(current_head, &oid);
+		commit_post_rewrite(the_repository, current_head, &oid);
 	}
 	if (!quiet) {
 		unsigned int flags = 0;
diff --git a/builtin/notes.c b/builtin/notes.c
index 4996a670f7..02e97f55c5 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -330,10 +330,10 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 	}
 
 	if (!rewrite_cmd) {
-		commit_notes(t, msg);
+		commit_notes(the_repository, t, msg);
 		free_notes(t);
 	} else {
-		finish_copy_notes_for_rewrite(c, msg);
+		finish_copy_notes_for_rewrite(the_repository, c, msg);
 	}
 	strbuf_release(&buf);
 	return ret;
@@ -469,12 +469,14 @@ static int add(int argc, const char **argv, const char *prefix)
 		write_note_data(&d, &new_note);
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			BUG("combine_notes_overwrite failed");
-		commit_notes(t, "Notes added by 'git notes add'");
+		commit_notes(the_repository, t,
+			     "Notes added by 'git notes add'");
 	} else {
 		fprintf(stderr, _("Removing note for object %s\n"),
 			oid_to_hex(&object));
 		remove_note(t, object.hash);
-		commit_notes(t, "Notes removed by 'git notes add'");
+		commit_notes(the_repository, t,
+			     "Notes removed by 'git notes add'");
 	}
 
 	free_note_data(&d);
@@ -552,7 +554,8 @@ static int copy(int argc, const char **argv, const char *prefix)
 
 	if (add_note(t, &object, from_note, combine_notes_overwrite))
 		BUG("combine_notes_overwrite failed");
-	commit_notes(t, "Notes added by 'git notes copy'");
+	commit_notes(the_repository, t,
+		     "Notes added by 'git notes copy'");
 out:
 	free_notes(t);
 	return retval;
@@ -636,7 +639,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		remove_note(t, object.hash);
 		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
 	}
-	commit_notes(t, logmsg);
+	commit_notes(the_repository, t, logmsg);
 
 	free(logmsg);
 	free_note_data(&d);
@@ -937,7 +940,8 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 	if (!retval)
-		commit_notes(t, "Notes removed by 'git notes remove'");
+		commit_notes(the_repository, t,
+			     "Notes removed by 'git notes remove'");
 	free_notes(t);
 	return retval;
 }
@@ -965,7 +969,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	prune_notes(t, (verbose ? NOTES_PRUNE_VERBOSE : 0) |
 		(show_only ? NOTES_PRUNE_VERBOSE|NOTES_PRUNE_DRYRUN : 0) );
 	if (!show_only)
-		commit_notes(t, "Notes removed by 'git notes prune'");
+		commit_notes(the_repository, t,
+			     "Notes removed by 'git notes prune'");
 	free_notes(t);
 	return 0;
 }
diff --git a/notes-merge.c b/notes-merge.c
index 72688d301b..280aa8e6c1 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -649,7 +649,7 @@ int notes_merge(struct notes_merge_options *o,
 		struct commit_list *parents = NULL;
 		commit_list_insert(remote, &parents); /* LIFO order */
 		commit_list_insert(local, &parents);
-		create_notes_commit(local_tree, parents, o->commit_msg.buf,
+		create_notes_commit(o->repo, local_tree, parents, o->commit_msg.buf,
 				    o->commit_msg.len, result_oid);
 	}
 
@@ -724,7 +724,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 		strbuf_setlen(&path, baselen);
 	}
 
-	create_notes_commit(partial_tree, partial_commit->parents, msg,
+	create_notes_commit(o->repo, partial_tree, partial_commit->parents, msg,
 			    strlen(msg), result_oid);
 	unuse_commit_buffer(partial_commit, buffer);
 	if (o->verbosity >= 4)
diff --git a/notes-utils.c b/notes-utils.c
index 14ea03178e..a819410698 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -5,7 +5,9 @@
 #include "notes-utils.h"
 #include "repository.h"
 
-void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+void create_notes_commit(struct repository *r,
+			 struct notes_tree *t,
+			 struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 struct object_id *result_oid)
 {
@@ -20,8 +22,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* Deduce parent commit from t->ref */
 		struct object_id parent_oid;
 		if (!read_ref(t->ref, &parent_oid)) {
-			struct commit *parent = lookup_commit(the_repository,
-							      &parent_oid);
+			struct commit *parent = lookup_commit(r, &parent_oid);
 			if (parse_commit(parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
@@ -34,7 +35,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		die("Failed to commit notes tree to database");
 }
 
-void commit_notes(struct notes_tree *t, const char *msg)
+void commit_notes(struct repository *r, struct notes_tree *t, const char *msg)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id commit_oid;
@@ -50,7 +51,7 @@ void commit_notes(struct notes_tree *t, const char *msg)
 	strbuf_addstr(&buf, msg);
 	strbuf_complete_line(&buf);
 
-	create_notes_commit(t, NULL, buf.buf, buf.len, &commit_oid);
+	create_notes_commit(r, t, NULL, buf.buf, buf.len, &commit_oid);
 	strbuf_insert(&buf, 0, "notes: ", 7); /* commit message starts at index 7 */
 	update_ref(buf.buf, t->update_ref, &commit_oid, NULL, 0,
 		   UPDATE_REFS_DIE_ON_ERR);
@@ -171,11 +172,13 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 	return ret;
 }
 
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg)
+void finish_copy_notes_for_rewrite(struct repository *r,
+				   struct notes_rewrite_cfg *c,
+				   const char *msg)
 {
 	int i;
 	for (i = 0; c->trees[i]; i++) {
-		commit_notes(c->trees[i], msg);
+		commit_notes(r, c->trees[i], msg);
 		free_notes(c->trees[i]);
 	}
 	free(c->trees);
diff --git a/notes-utils.h b/notes-utils.h
index 5408306528..d9b3c09eaf 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -5,6 +5,7 @@
 
 struct commit_list;
 struct object_id;
+struct repository;
 
 /*
  * Create new notes commit from the given notes tree
@@ -17,11 +18,13 @@ struct object_id;
  *
  * The resulting commit SHA1 is stored in result_sha1.
  */
-void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
+void create_notes_commit(struct repository *r,
+			 struct notes_tree *t,
+			 struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 struct object_id *result_oid);
 
-void commit_notes(struct notes_tree *t, const char *msg);
+void commit_notes(struct repository *r, struct notes_tree *t, const char *msg);
 
 enum notes_merge_strategy {
 		NOTES_MERGE_RESOLVE_MANUAL = 0,
@@ -45,6 +48,8 @@ int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s);
 struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
 int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const struct object_id *from_obj, const struct object_id *to_obj);
-void finish_copy_notes_for_rewrite(struct notes_rewrite_cfg *c, const char *msg);
+void finish_copy_notes_for_rewrite(struct repository *r,
+				   struct notes_rewrite_cfg *c,
+				   const char *msg);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index b68bca0bef..1a92a5d678 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1115,7 +1115,8 @@ static int run_rewrite_hook(const struct object_id *oldoid,
 	return finish_command(&proc);
 }
 
-void commit_post_rewrite(const struct commit *old_head,
+void commit_post_rewrite(struct repository *r,
+			 const struct commit *old_head,
 			 const struct object_id *new_head)
 {
 	struct notes_rewrite_cfg *cfg;
@@ -1124,7 +1125,7 @@ void commit_post_rewrite(const struct commit *old_head,
 	if (cfg) {
 		/* we are amending, so old_head is not NULL */
 		copy_note_for_rewrite(cfg, &old_head->object.oid, new_head);
-		finish_copy_notes_for_rewrite(cfg, "Notes added by 'git commit --amend'");
+		finish_copy_notes_for_rewrite(r, cfg, "Notes added by 'git commit --amend'");
 	}
 	run_rewrite_hook(&old_head->object.oid, new_head);
 }
@@ -1405,7 +1406,7 @@ static int try_to_commit(struct repository *r,
 	}
 
 	if (flags & AMEND_MSG)
-		commit_post_rewrite(current_head, oid);
+		commit_post_rewrite(r, current_head, oid);
 
 out:
 	free_commit_extra_headers(extra);
diff --git a/sequencer.h b/sequencer.h
index 9d83f0f3e9..2caecd550b 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -124,7 +124,8 @@ int update_head_with_reflog(const struct commit *old_head,
 			    const struct object_id *new_head,
 			    const char *action, const struct strbuf *msg,
 			    struct strbuf *err);
-void commit_post_rewrite(const struct commit *current_head,
+void commit_post_rewrite(struct repository *r,
+			 const struct commit *current_head,
 			 const struct object_id *new_head);
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
-- 
2.20.1.560.g70ca8b83ee

