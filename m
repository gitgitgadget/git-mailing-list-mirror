From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 03/14] refs.c: rename the transaction functions
Date: Wed, 18 Jun 2014 10:08:55 -0700
Message-ID: <1403111346-18466-4-git-send-email-sahlberg@google.com>
References: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 19:09:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxJMl-0007A7-6h
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 19:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753626AbaFRRJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 13:09:36 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:53617 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407AbaFRRJK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 13:09:10 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so299959iec.2
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pz526VJYemmLKUVH1rkYAuzoL7XZS8CzsnhZl7NxlKM=;
        b=LjY+u5bQkJm9OTc52b/b3THWPSrxcbWd/2b9X9Xkv2kR0QElpYj+eQoDuyJo4B7k3T
         ugBZqZ+VqmR+eyZsx2XeWgncFzZDGDKPA12gIXWOR2SOohDPgFn0cgbbydAAR9+NasRG
         Z3/SgDgOJm6NHMNLcRa231eAYc2uUMG02qzbW46Q/8514iCq95QFGpgAFyhOVbn7f+79
         yE2eGlEuuZCQBdhKZhSVttoSS+AElT6T8bVP2NBEzmmYFwBT9csAS2Tm2lXtAFoTSSER
         9pHp+KzCWqCA27DPgP8DUabsv1FNQNosg3SZ7oR7DoL30B2MWXpR5I3S18CFOVBSvxkf
         dDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pz526VJYemmLKUVH1rkYAuzoL7XZS8CzsnhZl7NxlKM=;
        b=TEDEuZzux+N+x1DzMD20ldYROkjMDSB/uTH+P1TYWBcZ0wzXx9td2ycCb0jn0C5MAO
         j2q6bl04eNOQyqnPN5NkTL2Oa5kd74wZenjzjxTUNG005uGa5rwGjPcJLe6tcv3YfkIe
         9uXTr7+ggOdaSx94yDZV7UaVrmP0AbfkIsI0P0zpCybmzf9XCgoqLPVpLYvWfDHq43W4
         dAOlsBQA0kFGIFKvTUshQWh6DrLsgcXndQMefuW9rR8hbKn2rMDTtf4QPQIPKUGqf7RB
         pELLFS0J5imk2FsFzxHSkb0+LyBzgk/E+3bW6VlHMU62GsuRXDE6+G9L3rKhkZnutJgp
         CUAw==
X-Gm-Message-State: ALoCoQnpL+vEmsaaWbrVf0uLGk7jpKGxQwqwQX2a7FFlNFsT2VEitpZyeQ5MA0niokm612TMScn3
X-Received: by 10.43.126.130 with SMTP id gw2mr1220502icc.15.1403111349887;
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id v12si100875yhe.2.2014.06.18.10.09.09
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9909431C80C;
	Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3F998E0DBC; Wed, 18 Jun 2014 10:09:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.467.g08c0633
In-Reply-To: <1403111346-18466-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251999>

Rename the transaction functions. Remove the leading ref_ from the
names and append _sha1 to the names for functions that create/delete/
update sha1 refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               | 11 ++++---
 builtin/commit.c       | 14 ++++-----
 builtin/fetch.c        | 12 ++++----
 builtin/receive-pack.c | 14 ++++-----
 builtin/replace.c      | 10 +++---
 builtin/tag.c          | 10 +++---
 builtin/update-ref.c   | 22 +++++++-------
 fast-import.c          | 22 +++++++-------
 refs.c                 | 82 +++++++++++++++++++++++++-------------------------
 refs.h                 | 56 +++++++++++++++++-----------------
 sequencer.c            | 12 ++++----
 walker.c               | 16 +++++-----
 12 files changed, 141 insertions(+), 140 deletions(-)

diff --git a/branch.c b/branch.c
index e0439af..6fa6d78 100644
--- a/branch.c
+++ b/branch.c
@@ -298,13 +298,14 @@ void create_branch(const char *head,
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
 
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, msg, &err) ||
-		    ref_transaction_commit(transaction, &err))
+		    transaction_update_sha1(transaction, ref.buf, sha1,
+					    null_sha1, 0, !forcing, msg,
+					    &err) ||
+		    transaction_commit(transaction, &err))
 			die("%s", err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 	}
 
 	if (real_ref && track)
diff --git a/builtin/commit.c b/builtin/commit.c
index c499826..bf8d85a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1762,17 +1762,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", sha1,
-				   current_head ?
-				   current_head->object.sha1 : NULL,
-				   0, !!current_head, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    transaction_update_sha1(transaction, "HEAD", sha1,
+				    current_head ?
+				    current_head->object.sha1 : NULL,
+				    0, !!current_head, sb.buf, &err) ||
+	    transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 52f1ebc..baf7929 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -385,22 +385,22 @@ static int s_update_ref(const char *action,
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old, msg, &err))
+	    transaction_update_sha1(transaction, ref->name, ref->new_sha1,
+				    ref->old_sha1, 0, check_old, msg, &err))
 		goto fail;
 
-	ret = ref_transaction_commit(transaction, &err);
+	ret = transaction_commit(transaction, &err);
 	if (ret == UPDATE_REFS_NAME_CONFLICT)
 		df_conflict = 1;
 	if (ret)
 		goto fail;
 
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 fail:
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	error("%s", err.buf);
 	strbuf_release(&err);
 	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0ed1ddd..dcd1862 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -582,20 +582,20 @@ static char *update(struct command *cmd, struct shallow_info *si)
 		    update_shallow_ref(cmd, si))
 			return xstrdup("shallow error");
 
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction ||
-		    ref_transaction_update(transaction, namespaced_name,
-					   new_sha1, old_sha1, 0, 1, "push",
-					   &err) ||
-		    ref_transaction_commit(transaction, &err)) {
+		    transaction_update_sha1(transaction, namespaced_name,
+					    new_sha1, old_sha1, 0, 1, "push",
+					    &err) ||
+		    transaction_commit(transaction, &err)) {
 			char *str = strbuf_detach(&err, NULL);
-			ref_transaction_free(transaction);
+			transaction_free(transaction);
 
 			rp_error("%s", str);
 			return str;
 		}
 
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		strbuf_release(&err);
 		return NULL; /* good */
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 8e699f2..9e3f7e0 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -167,14 +167,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), NULL, &err) ||
-	    ref_transaction_commit(transaction, &err))
+	    transaction_update_sha1(transaction, ref, repl, prev,
+				    0, !is_null_sha1(prev), NULL, &err) ||
+	    transaction_commit(transaction, &err))
 		die("%s", err.buf);
  
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 74af63e..4525c69 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -702,13 +702,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, !is_null_sha1(prev), NULL, &err) ||
-	    ref_transaction_commit(transaction, &err))
+	    transaction_update_sha1(transaction, ref.buf, object, prev,
+				    0, !is_null_sha1(prev), NULL, &err) ||
+	    transaction_commit(transaction, &err))
 		die("%s", err.buf);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 28b478a..d62871d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -199,8 +199,8 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (transaction_update_sha1(transaction, refname, new_sha1, old_sha1,
+				    update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -227,8 +227,8 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, msg, &err))
+	if (transaction_create_sha1(transaction, refname, new_sha1,
+				    update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -259,8 +259,8 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (transaction_delete_sha1(transaction, refname, old_sha1,
+				    update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -292,8 +292,8 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (transaction_update_sha1(transaction, refname, new_sha1, old_sha1,
+				    update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -366,15 +366,15 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
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
index f5ccf4e..778b6ea 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1705,17 +1705,17 @@ static int update_branch(struct branch *b)
 			return -1;
 		}
 	}
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, msg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	    transaction_update_sha1(transaction, b->name, b->sha1, old_sha1,
+				    0, 1, msg, &err) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
@@ -1738,7 +1738,7 @@ static void dump_tags(void)
 	struct strbuf err = STRBUF_INIT;
 	struct ref_transaction *transaction;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction) {
 		failure |= error("%s", err.buf);
 		goto cleanup;
@@ -1747,17 +1747,17 @@ static void dump_tags(void)
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
-					   NULL, 0, 0, msg, &err)) {
+		if (transaction_update_sha1(transaction, ref_name.buf, t->sha1,
+					    NULL, 0, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
 	}
-	if (ref_transaction_commit(transaction, &err))
+	if (transaction_commit(transaction, &err))
 		failure |= error("%s", err.buf);
 
  cleanup:
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&ref_name);
 	strbuf_release(&err);
 }
diff --git a/refs.c b/refs.c
index 0eace70..4e3d4c3 100644
--- a/refs.c
+++ b/refs.c
@@ -25,7 +25,7 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
- * Used as a flag to ref_transaction_delete when a loose ref is being
+ * Used as a flag to transaction_delete_sha1 when a loose ref is being
  * pruned.
  */
 #define REF_ISPRUNING	0x0100
@@ -2402,17 +2402,17 @@ static void prune_ref(struct ref_to_prune *r)
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	    transaction_delete_sha1(transaction, r->name, r->sha1,
+				    REF_ISPRUNING, 1, NULL, &err) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		return;
  	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	try_remove_empty_parents(r->name);
 }
 
@@ -2598,17 +2598,17 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    transaction_delete_sha1(transaction, refname, sha1, delopt,
+				    sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		strbuf_release(&err);
 		return 1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
@@ -3423,12 +3423,12 @@ struct ref_transaction {
 	int status;
 };
 
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+struct ref_transaction *transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
-void ref_transaction_free(struct ref_transaction *transaction)
+void transaction_free(struct ref_transaction *transaction)
 {
 	int i;
 
@@ -3455,12 +3455,12 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
-			   struct strbuf *err)
+int transaction_update_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err)
 {
 	struct ref_update *update;
 
@@ -3481,11 +3481,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   int flags, const char *msg,
-			   struct strbuf *err)
+int transaction_create_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    int flags, const char *msg,
+			    struct strbuf *err)
 {
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
@@ -3493,15 +3493,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	if (!new_sha1 || is_null_sha1(new_sha1))
 		die("BUG: create ref with null new_sha1");
 
-	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, 1, msg, err);
+	return transaction_update_sha1(transaction, refname, new_sha1,
+				       null_sha1, flags, 1, msg, err);
 }
 
-int ref_transaction_delete(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
-			   struct strbuf *err)
+int transaction_delete_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err)
 {
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
@@ -3512,7 +3512,7 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 	if (have_old && is_null_sha1(old_sha1))
 		die("BUG: have_old is true but old_sha1 is null_sha1");
 
-	return ref_transaction_update(transaction, refname, null_sha1,
+	return transaction_update_sha1(transaction, refname, null_sha1,
 				      old_sha1, flags, have_old, msg, err);
 }
 
@@ -3523,14 +3523,14 @@ int update_ref(const char *action, const char *refname,
 	struct ref_transaction *t;
 	struct strbuf err = STRBUF_INIT;
 
-	t = ref_transaction_begin(&err);
+	t = transaction_begin(&err);
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, action, &err) ||
-	    ref_transaction_commit(t, &err)) {
+	    transaction_update_sha1(t, refname, sha1, oldval, flags,
+				    !!oldval, action, &err) ||
+	    transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
-		ref_transaction_free(t);
+		transaction_free(t);
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR:
 			error(str, refname, err.buf); break;
@@ -3567,8 +3567,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+int transaction_commit(struct ref_transaction *transaction,
+		       struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i, df_conflict = 0;
 	const char **delnames;
diff --git a/refs.h b/refs.h
index 20bb152..cf48351 100644
--- a/refs.h
+++ b/refs.h
@@ -17,16 +17,16 @@ struct ref_lock {
  * Calling sequence
  * ----------------
  * - Allocate and initialize a `struct ref_transaction` by calling
- *   `ref_transaction_begin()`.
+ *   `transaction_begin()`.
  *
  * - List intended ref updates by calling functions like
- *   `ref_transaction_update()` and `ref_transaction_create()`.
+ *   `transaction_update_sha1()` and `transaction_create_sha1()`.
  *
- * - Call `ref_transaction_commit()` to execute the transaction.
+ * - Call `transaction_commit()` to execute the transaction.
  *   If this succeeds, the ref updates will have taken place and
  *   the transaction cannot be rolled back.
  *
- * - At any time call `ref_transaction_free()` to discard the
+ * - At any time call `transaction_free()` to discard the
  *   transaction and free associated resources.  In particular,
  *   this rolls back the transaction if it has not been
  *   successfully committed.
@@ -44,7 +44,7 @@ struct ref_lock {
  * error message:
  *
  *     strbuf_addf(&err, "Error while doing foo-bar: ");
- *     if (ref_transaction_update(..., &err)) {
+ *     if (transaction_update_sha1(..., &err)) {
  *         ret = error("%s", err.buf);
  *         goto cleanup;
  *     }
@@ -178,8 +178,8 @@ extern int ref_exists(const char *);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
- * ref_transaction_create(), etc.
+ * Flags controlling lock_any_ref_for_update(), transaction_update_sha1(),
+ * transaction_create_sha1(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  *
@@ -268,9 +268,9 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * be freed by calling ref_transaction_free().
+ * be freed by calling transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(struct strbuf *err);
+struct ref_transaction *transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
@@ -291,12 +291,12 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
-			   struct strbuf *err);
+int transaction_update_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
@@ -307,11 +307,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
  */
-int ref_transaction_create(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *new_sha1,
-			   int flags, const char *msg,
-			   struct strbuf *err);
+int transaction_create_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *new_sha1,
+			    int flags, const char *msg,
+			    struct strbuf *err);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
@@ -321,11 +321,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
  */
-int ref_transaction_delete(struct ref_transaction *transaction,
-			   const char *refname,
-			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
-			   struct strbuf *err);
+int transaction_delete_sha1(struct ref_transaction *transaction,
+			    const char *refname,
+			    const unsigned char *old_sha1,
+			    int flags, int have_old, const char *msg,
+			    struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
@@ -338,13 +338,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * collision (ENOTDIR).
  */
 #define UPDATE_REFS_NAME_CONFLICT -2
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err);
+int transaction_commit(struct ref_transaction *transaction,
+		       struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
  */
-void ref_transaction_free(struct ref_transaction *transaction);
+void transaction_free(struct ref_transaction *transaction);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
diff --git a/sequencer.c b/sequencer.c
index f9906ef..5080287 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -282,12 +282,12 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", to, from,
-				   0, !unborn, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	    transaction_update_sha1(transaction, "HEAD", to, from,
+				    0, !unborn, sb.buf, &err) ||
+	    transaction_commit(transaction, &err)) {
+		transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
@@ -295,7 +295,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	}
 
 	strbuf_release(&sb);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
diff --git a/walker.c b/walker.c
index fd9ef87..d22d07a 100644
--- a/walker.c
+++ b/walker.c
@@ -261,7 +261,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	save_commit_buffer = 0;
 
 	if (write_ref) {
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction) {
 			error("%s", err.buf);
 			goto rollback_and_fail;
@@ -293,27 +293,27 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			continue;
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
-		if (ref_transaction_update(transaction, ref_name.buf,
-					   &sha1[20 * i], NULL, 0, 0,
-					   msg ? msg : "fetch (unknown)",
-					   &err)) {
+		if (transaction_update_sha1(transaction, ref_name.buf,
+					    &sha1[20 * i], NULL, 0, 0,
+					    msg ? msg : "fetch (unknown)",
+					    &err)) {
 			error("%s", err.buf);
 			goto rollback_and_fail;
 		}
 	}
 	if (write_ref) {
-		if (ref_transaction_commit(transaction, &err)) {
+		if (transaction_commit(transaction, &err)) {
 			error("%s", err.buf);
 			goto rollback_and_fail;
 		}
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 	}
 
 	free(msg);
 	return 0;
 
 rollback_and_fail:
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	free(msg);
 	strbuf_release(&err);
 	strbuf_release(&ref_name);
-- 
2.0.0.467.g08c0633
