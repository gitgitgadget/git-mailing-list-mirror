From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 03/31] refs.c: rename the transaction functions
Date: Wed, 14 May 2014 15:13:02 -0700
Message-ID: <1400105610-21194-4-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:15:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhSg-0001Y9-NX
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbaENWP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:15:27 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:51894 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbaENWNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:34 -0400
Received: by mail-qg0-f73.google.com with SMTP id q108so15737qgd.2
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BLraMsvCauowN9HkdKnyNWrhSfuMrnOlwYusaMggjsw=;
        b=Jf/mx3xFdAcG2pcMEr5ncFo8DIM+F3hCWAWR3VThantWS8RPIrp0snfUzyq2IphX+r
         BuLUPF07AbmT6nCcQlLgGi+fM+ffbiD1Ho/7Nu3RttOZgimqeL0+ZdGGwWm5Pg8f5OJU
         ahObs3gt5+hOKP22OB1F5Du+tVVVS2aU1ke4Om3cTI1CNFBCSbSOzrRZKK0dC1/usJSY
         SvnEDcsg5+M6FrJAxAtN47Hi+K7ff+iRwglWCDbV1F8G2Vo2GG5pMY9Av+Yi+euumBJO
         190LVYI1EvN+nx0aW25Kz4xld8+cXJCLzPQw97DDO8O/NzIdcT+xWLeBJ1Uj5ofq3FP1
         g8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BLraMsvCauowN9HkdKnyNWrhSfuMrnOlwYusaMggjsw=;
        b=Cp/rwxLKd0feo4Ei/sMZ3vaYQsTGy+m4VR5Q4KRS2rmc548yy4vXS6llWLUykiS1tk
         s6aiVwI2RVUg2E4enzqR2Oq0m9TU8GYNZWZU4p+s/Yty5lklNKB4EsEAmlMXkW/INW3x
         Stk2ogGEtAt2obQVqcAaWGdIlDXCrLpECrZFJ4cOKiltYLlqaxTkGPSPePOlmu3WkBDJ
         tLHPO6N+RCwNlLC/rFoUt5DkbdZz1m0VaZ0Hdkw8xgMMPuTSEqJcu3nsbDZNSmgz0x8q
         c0YhVJlmGZP9kMunghyIzbQzCymc6XT9ICgxXbN/0mFSMafgKdmnume6qpinKQkchm2L
         1NDQ==
X-Gm-Message-State: ALoCoQkfhpe3Te6yznjMHQrqyfZzzyT4IWqdfF3YoKrjfsTpg8TlXtJbSYZvWjiPtyhIfQgO6Fll
X-Received: by 10.58.178.232 with SMTP id db8mr3293153vec.21.1400105613476;
        Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si78036yhj.5.2014.05.14.15.13.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 292E55A41E5;
	Wed, 14 May 2014 15:13:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E04E5E038E; Wed, 14 May 2014 15:13:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249039>

Rename the transaction functions. Remove the leading ref_ from the names
and append _sha1 to the names for functions that create/delete/update sha1
refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               | 10 +++---
 builtin/commit.c       | 14 ++++----
 builtin/fetch.c        | 10 +++---
 builtin/receive-pack.c | 10 +++---
 builtin/replace.c      | 10 +++---
 builtin/tag.c          | 10 +++---
 builtin/update-ref.c   | 22 ++++++------
 fast-import.c          | 22 ++++++------
 refs.c                 | 92 +++++++++++++++++++++++++-------------------------
 refs.h                 | 36 ++++++++++----------
 sequencer.c            | 12 +++----
 walker.c               | 14 ++++----
 12 files changed, 131 insertions(+), 131 deletions(-)

diff --git a/branch.c b/branch.c
index 74d55e7..0a4d4f3 100644
--- a/branch.c
+++ b/branch.c
@@ -298,14 +298,14 @@ void create_branch(const char *head,
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
 
-		transaction = ref_transaction_begin();
+		transaction = transaction_begin();
 		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, msg) ||
-		    ref_transaction_commit(transaction, &err))
+		    transaction_update_sha1(transaction, ref.buf, sha1,
+					    null_sha1, 0, !forcing, msg) ||
+		    transaction_commit(transaction, &err))
 				die_errno(_("%s: failed to write ref: %s"),
 					  ref.buf, err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 	}
 
 	if (real_ref && track)
diff --git a/builtin/commit.c b/builtin/commit.c
index e6bb7b3..386dfb1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1716,17 +1716,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", sha1,
-				   current_head ?
-				   current_head->object.sha1 : NULL,
-				   0, !!current_head, sb.buf) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    transaction_update_sha1(transaction, "HEAD", sha1,
+				    current_head ?
+				    current_head->object.sha1 : NULL,
+				    0, !!current_head, sb.buf) ||
+	    transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die(_("HEAD: cannot update ref: %s"), err.buf);
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3a849b0..f74a267 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -383,8 +383,8 @@ static int s_update_ref(const char *action,
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
-	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old, msg))
+	if (transaction_update_sha1(transaction, ref->name, ref->new_sha1,
+				    ref->old_sha1, 0, check_old, msg))
 		return STORE_REF_ERROR_OTHER;
 
 	return 0;
@@ -559,7 +559,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	}
 
 	errno = 0;
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction) {
 		rc = error(_("cannot start ref transaction\n"));
 		goto abort;
@@ -676,10 +676,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
-	if (ref_transaction_commit(transaction, NULL))
+	if (transaction_commit(transaction, NULL))
 		rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 		  STORE_REF_ERROR_OTHER;
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 991c659..0461f93 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -581,8 +581,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		if (ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, "push"))
+		if (transaction_update_sha1(transaction, namespaced_name,
+					    new_sha1, old_sha1, 0, 1, "push"))
 			return "failed to update";
 		return NULL; /* good */
 	}
@@ -807,7 +807,7 @@ static void execute_commands(struct command *commands,
 	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
 
 	checked_connectivity = 1;
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	for (cmd = commands; cmd; cmd = cmd->next) {
 		if (cmd->error_string)
 			continue;
@@ -823,9 +823,9 @@ static void execute_commands(struct command *commands,
 			checked_connectivity = 0;
 		}
 	}
-	if (ref_transaction_commit(transaction, &err))
+	if (transaction_commit(transaction, &err))
 		error("%s", err.buf);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&err);
 
 	if (shallow_update && !checked_connectivity)
diff --git a/builtin/replace.c b/builtin/replace.c
index 820d703..2587a06 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -157,14 +157,14 @@ static int replace_object_sha1(const char *object_ref,
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), NULL) ||
-	    ref_transaction_commit(transaction, &err))
+	    transaction_update_sha1(transaction, ref, repl, prev,
+				    0, !is_null_sha1(prev), NULL) ||
+	    transaction_commit(transaction, &err))
 		die(_("%s: failed to replace ref: %s"), ref, err.buf);
 
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 2cc260f..3739e23 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -702,13 +702,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, !is_null_sha1(prev), NULL) ||
-	    ref_transaction_commit(transaction, &err))
+	    transaction_update_sha1(transaction, ref.buf, object, prev,
+				    0, !is_null_sha1(prev), NULL) ||
+	    transaction_commit(transaction, &err))
 		die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index c5aff92..f7e33bd 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -198,8 +198,8 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg))
+	if (transaction_update_sha1(transaction, refname, new_sha1, old_sha1,
+				    update_flags, have_old, msg))
 		die("update %s: failed", refname);
 
 	update_flags = 0;
@@ -226,8 +226,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, msg))
+	if (transaction_create_sha1(transaction, refname, new_sha1,
+				    update_flags, msg))
 		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
@@ -258,8 +258,8 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, msg))
+	if (transaction_delete_sha1(transaction, refname, old_sha1,
+				    update_flags, have_old, msg))
 		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
@@ -291,8 +291,8 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg))
+	if (transaction_update_sha1(transaction, refname, new_sha1, old_sha1,
+				    update_flags, have_old, msg))
 		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
@@ -366,15 +366,15 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = transaction_begin();
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		if (ref_transaction_commit(transaction, &err))
+		if (transaction_commit(transaction, &err))
 			die("%s", err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		return 0;
 	}
 
diff --git a/fast-import.c b/fast-import.c
index 099e71b..2fa1d29 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1707,17 +1707,17 @@ static int update_branch(struct branch *b)
 			return -1;
 		}
 	}
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, msg) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
+	    transaction_update_sha1(transaction, b->name, b->sha1, old_sha1,
+				    0, 1, msg) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_rollback(transaction);
 		error("Unable to update branch %s: %s", b->name, err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
@@ -1740,17 +1740,17 @@ static void dump_tags(void)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	for (t = first_tag; t; t = t->next_tag) {
 		sprintf(ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name, t->sha1,
-					   NULL, 0, 0, msg))
+		if (transaction_update_sha1(transaction, ref_name, t->sha1,
+					    NULL, 0, 0, msg))
 			failure |= error("Unable to update %s", err.buf);
 	}
-	if (failure || ref_transaction_commit(transaction, &err))
+	if (failure || transaction_commit(transaction, &err))
 		failure |= error("Unable to update %s", err.buf);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&err);
 }
 
diff --git a/refs.c b/refs.c
index c180fa2..6785fa6 100644
--- a/refs.c
+++ b/refs.c
@@ -2357,17 +2357,17 @@ static void prune_ref(struct ref_to_prune *r)
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, NULL) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
+	    transaction_delete_sha1(transaction, r->name, r->sha1,
+				    REF_ISPRUNING, 1, NULL) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_rollback(transaction);
 		warning("prune_ref: %s", err.buf);
 		strbuf_release(&err);
 		return;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	try_remove_empty_parents(r->name);
 }
 
@@ -2521,15 +2521,15 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
 	struct ref_transaction *transaction;
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), NULL) ||
-	    ref_transaction_commit(transaction, NULL)) {
-		ref_transaction_rollback(transaction);
+	    transaction_delete_sha1(transaction, refname, sha1, delopt,
+				    sha1 && !is_null_sha1(sha1), NULL) ||
+	    transaction_commit(transaction, NULL)) {
+		transaction_rollback(transaction);
 		return 1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
@@ -2625,20 +2625,20 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
 		return error("unable to pack refs");
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_delete(transaction, oldrefname, sha1,
-				   REF_NODEREF | REF_ISPACKONLY,
-				   1, NULL) ||
-	    ref_transaction_update(transaction, newrefname, sha1,
-				   NULL, 0, 0, logmsg) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
+	    transaction_delete_sha1(transaction, oldrefname, sha1,
+				    REF_NODEREF | REF_ISPACKONLY,
+				    1, NULL) ||
+	    transaction_update_sha1(transaction, newrefname, sha1,
+				    NULL, 0, 0, logmsg) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_rollback(transaction);
 		error("rename_ref failed: %s", err.buf);
 		strbuf_release(&err);
 		goto rollbacklog;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	if (log && rename_tmp_log(newrefname))
 		goto rollbacklog;
@@ -3270,12 +3270,12 @@ struct ref_transaction {
 	enum ref_transaction_status status;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *transaction_begin(void)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-void ref_transaction_free(struct ref_transaction *transaction)
+void transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3290,14 +3290,14 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-void ref_transaction_rollback(struct ref_transaction *transaction)
+void transaction_rollback(struct ref_transaction *transaction)
 {
 	if (!transaction)
 		return;
 
 	transaction->status = REF_TRANSACTION_ERROR;
 
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 }
 
 static struct ref_update *add_update(struct ref_transaction *transaction,
@@ -3312,11 +3312,11 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
+int transaction_update_sha1(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg)
+			    int flags, int have_old, const char *msg)
 {
 	struct ref_update *update;
 
@@ -3340,10 +3340,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   int flags, const char *msg)
+int transaction_create_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    int flags, const char *msg)
 {
 	struct ref_update *update;
 
@@ -3356,14 +3356,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (flags & REF_ISPACKONLY)
 		die("BUG: REF_ISPACKONLY can not be used with create");
 
-	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, 1, msg);
+	return transaction_update_sha1(transaction, refname, new_sha1,
+				       null_sha1, flags, 1, msg);
 }
 
-int ref_transaction_delete(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg)
+int transaction_delete_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg)
 {
 	struct ref_update *update;
 
@@ -3376,8 +3376,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (transaction->status != REF_TRANSACTION_OPEN)
 		die("BUG: delete on transaction that is not open");
 
-	return ref_transaction_update(transaction, refname, null_sha1,
-				      old_sha1, flags, have_old, msg);
+	return transaction_update_sha1(transaction, refname, null_sha1,
+				       old_sha1, flags, have_old, msg);
 }
 
 int update_ref(const char *action, const char *refname,
@@ -3387,14 +3387,14 @@ int update_ref(const char *action, const char *refname,
 	struct ref_transaction *t;
 	struct strbuf err = STRBUF_INIT;
 
-	t = ref_transaction_begin();
+	t = transaction_begin();
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, action) ||
-	    ref_transaction_commit(t, &err)) {
+	    transaction_update_sha1(t, refname, sha1, oldval, flags,
+				    !!oldval, action) ||
+	    transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
-		ref_transaction_rollback(t);
+		transaction_rollback(t);
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR:
 			error(str, refname, err.buf); break;
@@ -3405,7 +3405,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
-	ref_transaction_free(t);
+	transaction_free(t);
 	return 0;
 }
 
@@ -3432,7 +3432,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
+int transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
diff --git a/refs.h b/refs.h
index 8d56edf..127c12f 100644
--- a/refs.h
+++ b/refs.h
@@ -213,12 +213,12 @@ enum action_on_err {
  * eventually be freed by either calling ref_transaction_rollback()
  * or ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *transaction_begin(void);
 
 /*
  * Roll back a ref_transaction and free all associated data.
  */
-void ref_transaction_rollback(struct ref_transaction *transaction);
+void transaction_rollback(struct ref_transaction *transaction);
 
 
 /*
@@ -239,11 +239,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * already exist and a new ref will be created with new_sha1.
  * Function returns 0 on success and non-zero on failure.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg);
+int transaction_update_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
@@ -252,10 +252,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * already.
  * Function returns 0 on success and non-zero on failure.
  */
-int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   int flags, const char *msg);
+int transaction_create_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    int flags, const char *msg);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -263,10 +263,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * the update (which must not be the null SHA-1).
  * Function returns 0 on success and non-zero on failure.
  */
-int ref_transaction_delete(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg);
+int transaction_delete_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
@@ -274,13 +274,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * problem. If err is non-NULL we will add an error string to it to explain
  * why the transaction failed. The string does not end in newline.
  */
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err);
+int transaction_commit(struct ref_transaction *transaction,
+		       struct strbuf *err);
 
 /*
  * Free an existing transaction.
  */
-void ref_transaction_free(struct ref_transaction *transaction);
+void transaction_free(struct ref_transaction *transaction);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
diff --git a/sequencer.c b/sequencer.c
index 3a0ee09..3f7996f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -282,18 +282,18 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn, sb.buf) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_rollback(transaction);
+	    transaction_update_sha1(transaction, "HEAD", to, from,
+				    0, !unborn, sb.buf) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_rollback(transaction);
 		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
 		return -1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	strbuf_release(&sb);
 	return 0;
diff --git a/walker.c b/walker.c
index c2a1266..3701c78 100644
--- a/walker.c
+++ b/walker.c
@@ -260,7 +260,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 
 	save_commit_buffer = 0;
 
-	transaction = ref_transaction_begin();
+	transaction = transaction_begin();
 	if (!transaction)
 		return -1;
 
@@ -289,14 +289,14 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		if (!write_ref || !write_ref[i])
 			continue;
 		sprintf(ref_name, "refs/%s", write_ref[i]);
-		if (ref_transaction_update(transaction, ref_name,
-					   &sha1[20 * i], NULL,
-					   0, 0,
-					   msg ? msg : "fetch (unknown)"))
+		if (transaction_update_sha1(transaction, ref_name,
+					    &sha1[20 * i], NULL,
+					    0, 0,
+					    msg ? msg : "fetch (unknown)"))
 			goto rollback_and_fail;
 	}
 
-	if (ref_transaction_commit(transaction, &err)) {
+	if (transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		goto rollback_and_fail;
 	}
@@ -307,7 +307,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 rollback_and_fail:
 	free(msg);
 	strbuf_release(&err);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	return -1;
 }
-- 
2.0.0.rc3.506.g3739a35
