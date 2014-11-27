From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] refs.c: rename the transaction functions
Date: Wed, 26 Nov 2014 21:34:42 -0800
Message-ID: <1417066485-24921-2-git-send-email-sbeller@google.com>
References: <20141120181701.GB15945@google.com>
 <1417066485-24921-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: ronniesahlberg@gmail.com, gitster@pobox.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 06:35:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtrjJ-0005DC-J9
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 06:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaK0Few (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2014 00:34:52 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:44649 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaK0Feu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 00:34:50 -0500
Received: by mail-ig0-f175.google.com with SMTP id h15so8049671igd.2
        for <git@vger.kernel.org>; Wed, 26 Nov 2014 21:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G6winQvZusTMBbnF5bkdBRTnMvgAFviB3DMwKOoUJX8=;
        b=pP0TRpw2Zv6PWCxHbXEmi/A8zfrSco041mOr/hAKrelMdTOvz3fddUXZQAAHnFyQ7k
         EV0qlb8d/G1uY8/iGi4q8IyBTzV4WYCBd+zGQiqKZLuSSO97+PtfgCAoSszWHRso8WWw
         s8NR+7KCudYA2d6cAnV/sXgG4Smqlnhinh4GfY27EfiDs31R72Lju1g1pG5UkeIFznZ4
         FYJGqpq0ifzbzIN8kj00+GOjwK06q2ABOtE99nRuAQyz+siNAy/bbbGfCPXkJXG3UrRF
         1IhiFi3GBrhG7UxYoQEcJ1AnpGW8g9oGJCZW2dWCEOVMg8CcL+eR0czyVJZifrJATb8I
         Z6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G6winQvZusTMBbnF5bkdBRTnMvgAFviB3DMwKOoUJX8=;
        b=ixf+kGxRKM7fttWWFMcgYj9HDjcvF+8r6RJfpFWeFkvH7ex8Hzto/dBT8rSczDWQ2L
         9YA2bJuaLSNcetum5nw+kfVhREGnq8YtIcz70kl2O+2FFa/EwTS+R3SncjCv/5G1zh8O
         9zFF4Mgl2qW7jz0VV6PNW1CBV9KI2qu42e7q7+mN2t4lklFgkt+WLKkR1N5hDF6x8s7H
         /FTnDVxtd9JHD2jmiPDTHXe1AmIANMchqMJcNBwx+IV3nHCFyfNQoN7JWFiX+j7xP19d
         KO0zQcVuKZqIXCT2L1AaNmSqm1rKj3Pem9kpJp1cr50H4/yQaiMKLsIKZWgOe1DN0Mei
         zGLg==
X-Gm-Message-State: ALoCoQlTUApSa2QiqYO6zOIa4pu0kU2flgrfd+RBlCVYZUBdJmUJexKnoMXbMo8T0tv2KbSIKWN3
X-Received: by 10.42.50.72 with SMTP id z8mr17410390icf.3.1417066489518;
        Wed, 26 Nov 2014 21:34:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:3190:a053:325e:48b2])
        by mx.google.com with ESMTPSA id o8sm3665174igh.18.2014.11.26.21.34.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Nov 2014 21:34:49 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1417066485-24921-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260338>

From: Ronnie Sahlberg <sahlberg@google.com>

Rename the transaction functions. Remove the leading ref_ from the
names and append _ref to the names for functions that create/delete/
update sha1 refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

This commit can be reproduced via
find . -name "*.[ch]" -print | xargs sed -i ' \
	s/REF_TRANSACTION_OPEN/TRANSACTION_OPEN/; \
	s/REF_TRANSACTION_CLOSED/TRANSACTION_CLOSED/; \
	s/ref_transaction_begin/transaction_begin/; \
	s/ref_transaction_commit/transaction_commit/; \
	s/ref_transaction_create/transaction_create_ref/; \
	s/ref_transaction_delete/transaction_delete_ref/; \
	s/ref_transaction_free/transaction_free/; \
	s/ref_transaction_update/transaction_update_ref/; \
	s/ref_transaction/transaction/'
modulo white space changes for alignment.

---
 branch.c               | 13 +++++----
 builtin/commit.c       | 10 +++----
 builtin/fetch.c        | 12 ++++----
 builtin/receive-pack.c | 13 ++++-----
 builtin/replace.c      | 10 +++----
 builtin/tag.c          | 10 +++----
 builtin/update-ref.c   | 26 ++++++++---------
 fast-import.c          | 22 +++++++-------
 refs.c                 | 78 +++++++++++++++++++++++++-------------------------
 refs.h                 | 36 +++++++++++------------
 sequencer.c            | 12 ++++----
 walker.c               | 10 +++----
 12 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/branch.c b/branch.c
index 4bab55a..c8462de 100644
--- a/branch.c
+++ b/branch.c
@@ -279,16 +279,17 @@ void create_branch(const char *head,
 		log_all_ref_updates = 1;
 
 	if (!dont_change_ref) {
-		struct ref_transaction *transaction;
+		struct transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
 
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, msg, &err) ||
-		    ref_transaction_commit(transaction, &err))
+		    transaction_update_ref(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, msg,
+					   &err) ||
+		    transaction_commit(transaction, &err))
 			die("%s", err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		strbuf_release(&err);
 	}
 
diff --git a/builtin/commit.c b/builtin/commit.c
index e108c53..f50b7df 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1673,7 +1673,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct stat statbuf;
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -1804,17 +1804,17 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	strbuf_insert(&sb, 0, reflog_msg, strlen(reflog_msg));
 	strbuf_insert(&sb, strlen(reflog_msg), ": ", 2);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD", sha1,
+	    transaction_update_ref(transaction, "HEAD", sha1,
 				   current_head
 				   ? current_head->object.sha1 : NULL,
 				   0, !!current_head, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b84d35..0be0b09 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -404,7 +404,7 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	int ret, df_conflict = 0;
 
@@ -414,23 +414,23 @@ static int s_update_ref(const char *action,
 		rla = default_rla.buf;
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+	    transaction_update_ref(transaction, ref->name, ref->new_sha1,
 				   ref->old_sha1, 0, check_old, msg, &err))
 		goto fail;
 
-	ret = ref_transaction_commit(transaction, &err);
+	ret = transaction_commit(transaction, &err);
 	if (ret) {
 		df_conflict = (ret == TRANSACTION_NAME_CONFLICT);
 		goto fail;
 	}
 
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&err);
 	return 0;
 fail:
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	error("%s", err.buf);
 	strbuf_release(&err);
 	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..397abc9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -838,26 +838,25 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 	else {
 		struct strbuf err = STRBUF_INIT;
-		struct ref_transaction *transaction;
+		struct transaction *transaction;
 
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction ||
-		    ref_transaction_update(transaction, namespaced_name,
+		    transaction_update_ref(transaction, namespaced_name,
 					   new_sha1, old_sha1, 0, 1, "push",
 					   &err) ||
-		    ref_transaction_commit(transaction, &err)) {
-			ref_transaction_free(transaction);
-
+		    transaction_commit(transaction, &err)) {
+			transaction_free(transaction);
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
 			return "failed to update ref";
 		}
 
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		strbuf_release(&err);
 		return NULL; /* good */
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 85d39b5..5a7ab1f 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -155,7 +155,7 @@ static int replace_object_sha1(const char *object_ref,
 	unsigned char prev[20];
 	enum object_type obj_type, repl_type;
 	char ref[PATH_MAX];
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
 	obj_type = sha1_object_info(object, NULL);
@@ -169,14 +169,14 @@ static int replace_object_sha1(const char *object_ref,
 
 	check_ref_valid(object, prev, ref, sizeof(ref), force);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl, prev,
+	    transaction_update_ref(transaction, ref, repl, prev,
 				   0, 1, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err))
+	    transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index e633f4e..5f3554b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -583,7 +583,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_CMDMODE('l', "list", &cmdmode, N_("list tag names"), 'l'),
@@ -730,13 +730,13 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref.buf, object, prev,
+	    transaction_update_ref(transaction, ref.buf, object, prev,
 				   0, 1, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err))
+	    transaction_commit(transaction, &err))
 		die("%s", err.buf);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6c9be05..af08dd9 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -175,7 +175,7 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
  * depending on how line_termination is set.
  */
 
-static const char *parse_cmd_update(struct ref_transaction *transaction,
+static const char *parse_cmd_update(struct transaction *transaction,
 				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -198,7 +198,7 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+	if (transaction_update_ref(transaction, refname, new_sha1, old_sha1,
 				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
@@ -209,7 +209,7 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 	return next;
 }
 
-static const char *parse_cmd_create(struct ref_transaction *transaction,
+static const char *parse_cmd_create(struct transaction *transaction,
 				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -229,7 +229,7 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, new_sha1,
+	if (transaction_create_ref(transaction, refname, new_sha1,
 				   update_flags, msg, &err))
 		die("%s", err.buf);
 
@@ -240,7 +240,7 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 	return next;
 }
 
-static const char *parse_cmd_delete(struct ref_transaction *transaction,
+static const char *parse_cmd_delete(struct transaction *transaction,
 				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -264,7 +264,7 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	if (ref_transaction_delete(transaction, refname, old_sha1,
+	if (transaction_delete_ref(transaction, refname, old_sha1,
 				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
@@ -275,7 +275,7 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 	return next;
 }
 
-static const char *parse_cmd_verify(struct ref_transaction *transaction,
+static const char *parse_cmd_verify(struct transaction *transaction,
 				    struct strbuf *input, const char *next)
 {
 	struct strbuf err = STRBUF_INIT;
@@ -300,7 +300,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+	if (transaction_update_ref(transaction, refname, new_sha1, old_sha1,
 				   update_flags, have_old, msg, &err))
 		die("%s", err.buf);
 
@@ -320,7 +320,7 @@ static const char *parse_cmd_option(struct strbuf *input, const char *next)
 	return next + 8;
 }
 
-static void update_refs_stdin(struct ref_transaction *transaction)
+static void update_refs_stdin(struct transaction *transaction)
 {
 	struct strbuf input = STRBUF_INIT;
 	const char *next;
@@ -376,9 +376,9 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	if (read_stdin) {
 		struct strbuf err = STRBUF_INIT;
-		struct ref_transaction *transaction;
+		struct transaction *transaction;
 
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction)
 			die("%s", err.buf);
 		if (delete || no_deref || argc > 0)
@@ -386,9 +386,9 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin(transaction);
-		if (ref_transaction_commit(transaction, &err))
+		if (transaction_commit(transaction, &err))
 			die("%s", err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		strbuf_release(&err);
 		return 0;
 	}
diff --git a/fast-import.c b/fast-import.c
index d0bd285..152d944 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1687,7 +1687,7 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	unsigned char old_sha1[20];
 	struct strbuf err = STRBUF_INIT;
 
@@ -1713,17 +1713,17 @@ static int update_branch(struct branch *b)
 			return -1;
 		}
 	}
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+	    transaction_update_ref(transaction, b->name, b->sha1, old_sha1,
 				   0, 1, msg, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	    transaction_commit(transaction, &err)) {
+		transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&err);
 	return 0;
 }
@@ -1745,9 +1745,9 @@ static void dump_tags(void)
 	struct tag *t;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction) {
 		failure |= error("%s", err.buf);
 		goto cleanup;
@@ -1756,17 +1756,17 @@ static void dump_tags(void)
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
+		if (transaction_update_ref(transaction, ref_name.buf, t->sha1,
 					   NULL, 0, 0, msg, &err)) {
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
index 150c980..f0f0d23 100644
--- a/refs.c
+++ b/refs.c
@@ -26,7 +26,7 @@ static unsigned char refname_disposition[256] = {
 };
 
 /*
- * Used as a flag to ref_transaction_delete when a loose ref is being
+ * Used as a flag to transaction_delete_ref when a loose ref is being
  * pruned.
  */
 #define REF_ISPRUNING	0x0100
@@ -2533,23 +2533,23 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
 	if (check_refname_format(r->name, 0))
 		return;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, r->name, r->sha1,
+	    transaction_delete_ref(transaction, r->name, r->sha1,
 				   REF_ISPRUNING, 1, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	    transaction_commit(transaction, &err)) {
+		transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		return;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&err);
 	try_remove_empty_parents(r->name);
 }
@@ -2711,20 +2711,20 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 {
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, delopt,
+	    transaction_delete_ref(transaction, refname, sha1, delopt,
 				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
+	    transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
-		ref_transaction_free(transaction);
+		transaction_free(transaction);
 		strbuf_release(&err);
 		return 1;
 	}
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	strbuf_release(&err);
 	return 0;
 }
@@ -3543,9 +3543,9 @@ struct ref_update {
  *         an active transaction or if there is a failure while building
  *         the transaction thus rendering it failed/inactive.
  */
-enum ref_transaction_state {
-	REF_TRANSACTION_OPEN   = 0,
-	REF_TRANSACTION_CLOSED = 1
+enum transaction_state {
+	TRANSACTION_OPEN   = 0,
+	TRANSACTION_CLOSED = 1
 };
 
 /*
@@ -3553,21 +3553,21 @@ enum ref_transaction_state {
  * consist of checks and updates to multiple references, carried out
  * as atomically as possible.  This structure is opaque to callers.
  */
-struct ref_transaction {
+struct transaction {
 	struct ref_update **updates;
 	size_t alloc;
 	size_t nr;
-	enum ref_transaction_state state;
+	enum transaction_state state;
 };
 
-struct ref_transaction *ref_transaction_begin(struct strbuf *err)
+struct transaction *transaction_begin(struct strbuf *err)
 {
 	assert(err);
 
-	return xcalloc(1, sizeof(struct ref_transaction));
+	return xcalloc(1, sizeof(struct transaction));
 }
 
-void ref_transaction_free(struct ref_transaction *transaction)
+void transaction_free(struct transaction *transaction)
 {
 	int i;
 
@@ -3582,7 +3582,7 @@ void ref_transaction_free(struct ref_transaction *transaction)
 	free(transaction);
 }
 
-static struct ref_update *add_update(struct ref_transaction *transaction,
+static struct ref_update *add_update(struct transaction *transaction,
 				     const char *refname)
 {
 	size_t len = strlen(refname);
@@ -3594,7 +3594,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-int ref_transaction_update(struct ref_transaction *transaction,
+int transaction_update_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
@@ -3605,7 +3605,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	assert(err);
 
-	if (transaction->state != REF_TRANSACTION_OPEN)
+	if (transaction->state != TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
 	if (have_old && !old_sha1)
@@ -3629,23 +3629,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-int ref_transaction_create(struct ref_transaction *transaction,
+int transaction_create_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   int flags, const char *msg,
 			   struct strbuf *err)
 {
-	return ref_transaction_update(transaction, refname, new_sha1,
+	return transaction_update_ref(transaction, refname, new_sha1,
 				      null_sha1, flags, 1, msg, err);
 }
 
-int ref_transaction_delete(struct ref_transaction *transaction,
+int transaction_delete_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	return ref_transaction_update(transaction, refname, null_sha1,
+	return transaction_update_ref(transaction, refname, null_sha1,
 				      old_sha1, flags, have_old, msg, err);
 }
 
@@ -3653,17 +3653,17 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_transaction *t;
+	struct transaction *t;
 	struct strbuf err = STRBUF_INIT;
 
-	t = ref_transaction_begin(&err);
+	t = transaction_begin(&err);
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval, flags,
+	    transaction_update_ref(t, refname, sha1, oldval, flags,
 				   !!oldval, action, &err) ||
-	    ref_transaction_commit(t, &err)) {
+	    transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
-		ref_transaction_free(t);
+		transaction_free(t);
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR:
 			error(str, refname, err.buf);
@@ -3678,7 +3678,7 @@ int update_ref(const char *action, const char *refname,
 		return 1;
 	}
 	strbuf_release(&err);
-	ref_transaction_free(t);
+	transaction_free(t);
 	return 0;
 }
 
@@ -3706,8 +3706,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 	return 0;
 }
 
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err)
+int transaction_commit(struct transaction *transaction,
+		       struct strbuf *err)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3716,11 +3716,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	assert(err);
 
-	if (transaction->state != REF_TRANSACTION_OPEN)
+	if (transaction->state != TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
 	if (!n) {
-		transaction->state = REF_TRANSACTION_CLOSED;
+		transaction->state = TRANSACTION_CLOSED;
 		return 0;
 	}
 
@@ -3799,7 +3799,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	clear_loose_ref_cache(&ref_cache);
 
 cleanup:
-	transaction->state = REF_TRANSACTION_CLOSED;
+	transaction->state = TRANSACTION_CLOSED;
 
 	for (i = 0; i < n; i++)
 		if (updates[i]->lock)
diff --git a/refs.h b/refs.h
index 7d675b7..556adfd 100644
--- a/refs.h
+++ b/refs.h
@@ -11,22 +11,22 @@ struct ref_lock {
 };
 
 /*
- * A ref_transaction represents a collection of ref updates
+ * A transaction represents a collection of ref updates
  * that should succeed or fail together.
  *
  * Calling sequence
  * ----------------
- * - Allocate and initialize a `struct ref_transaction` by calling
- *   `ref_transaction_begin()`.
+ * - Allocate and initialize a `struct transaction` by calling
+ *   `transaction_begin()`.
  *
  * - List intended ref updates by calling functions like
- *   `ref_transaction_update()` and `ref_transaction_create()`.
+ *   `transaction_update_ref()` and `transaction_create_ref()`.
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
@@ -42,7 +42,7 @@ struct ref_lock {
  * The message is appended to err without first clearing err.
  * err will not be '\n' terminated.
  */
-struct ref_transaction;
+struct transaction;
 
 /*
  * Bit values set in the flags argument passed to each_ref_fn():
@@ -181,8 +181,8 @@ extern int is_branch(const char *refname);
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
 /*
- * Flags controlling lock_any_ref_for_update(), ref_transaction_update(),
- * ref_transaction_create(), etc.
+ * Flags controlling lock_any_ref_for_update(), transaction_update_ref(),
+ * transaction_create_ref(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
  * REF_DELETING: tolerate broken refs
@@ -269,13 +269,13 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * be freed by calling ref_transaction_free().
+ * be freed by calling transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(struct strbuf *err);
+struct transaction *transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
- * ref_transaction.  In all of them, refname is the name of the
+ * transaction.  In all of them, refname is the name of the
  * reference to be affected.  The functions make internal copies of
  * refname and msg, so the caller retains ownership of these parameters.
  * flags can be REF_NODEREF; it is passed to update_ref_lock().
@@ -291,7 +291,7 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
  */
-int ref_transaction_update(struct ref_transaction *transaction,
+int transaction_update_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
@@ -307,7 +307,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
  */
-int ref_transaction_create(struct ref_transaction *transaction,
+int transaction_create_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   int flags, const char *msg,
@@ -321,7 +321,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * means that the transaction as a whole has failed and will need to be
  * rolled back.
  */
-int ref_transaction_delete(struct ref_transaction *transaction,
+int transaction_delete_ref(struct transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
 			   int flags, int have_old, const char *msg,
@@ -337,13 +337,13 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 #define TRANSACTION_NAME_CONFLICT -1
 /* All other errors. */
 #define TRANSACTION_GENERIC_ERROR -2
-int ref_transaction_commit(struct ref_transaction *transaction,
-			   struct strbuf *err);
+int transaction_commit(struct transaction *transaction,
+		       struct strbuf *err);
 
 /*
  * Free an existing transaction and all associated data.
  */
-void ref_transaction_free(struct ref_transaction *transaction);
+void transaction_free(struct transaction *transaction);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
diff --git a/sequencer.c b/sequencer.c
index a03d4fa..f888005 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -238,7 +238,7 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_transaction *transaction;
+	struct transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 
@@ -248,13 +248,13 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 
-	transaction = ref_transaction_begin(&err);
+	transaction = transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, "HEAD",
+	    transaction_update_ref(transaction, "HEAD",
 				   to, unborn ? null_sha1 : from,
 				   0, 1, sb.buf, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		ref_transaction_free(transaction);
+	    transaction_commit(transaction, &err)) {
+		transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
@@ -263,7 +263,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 
 	strbuf_release(&sb);
 	strbuf_release(&err);
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	return 0;
 }
 
diff --git a/walker.c b/walker.c
index f149371..f1d5e9b 100644
--- a/walker.c
+++ b/walker.c
@@ -253,7 +253,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 {
 	struct strbuf refname = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
-	struct ref_transaction *transaction = NULL;
+	struct transaction *transaction = NULL;
 	unsigned char *sha1 = xmalloc(targets * 20);
 	char *msg = NULL;
 	int i, ret = -1;
@@ -261,7 +261,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	save_commit_buffer = 0;
 
 	if (write_ref) {
-		transaction = ref_transaction_begin(&err);
+		transaction = transaction_begin(&err);
 		if (!transaction) {
 			error("%s", err.buf);
 			goto done;
@@ -298,7 +298,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			continue;
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
-		if (ref_transaction_update(transaction, refname.buf,
+		if (transaction_update_ref(transaction, refname.buf,
 					   &sha1[20 * i], NULL, 0, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
@@ -306,7 +306,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 			goto done;
 		}
 	}
-	if (ref_transaction_commit(transaction, &err)) {
+	if (transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		goto done;
 	}
@@ -314,7 +314,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 	ret = 0;
 
 done:
-	ref_transaction_free(transaction);
+	transaction_free(transaction);
 	free(msg);
 	free(sha1);
 	strbuf_release(&err);
-- 
2.2.0.rc3
