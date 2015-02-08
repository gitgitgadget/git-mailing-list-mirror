From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/11] ref_transaction_update(): remove "have_old" parameter
Date: Sun,  8 Feb 2015 17:13:58 +0100
Message-ID: <1423412045-15616-5-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:21:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUc6-0005s7-S8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666AbbBHQVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:21:34 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:48184 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758490AbbBHQVd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:21:33 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 11:21:32 EST
X-AuditID: 1207440f-f792a6d000001284-a7-54d78b5dccaf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3D.07.04740.D5B87D45; Sun,  8 Feb 2015 11:14:21 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9l8014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:20 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqBvbfT3EYMVWA4uuK91MFg29V5gt
	3t5cwmhxe8V8ZovuKW8ZLXr7PrFabN7czuLA7vH3/Qcmj52z7rJ7LNhU6nHxkrLH501yAaxR
	3DZJiSVlwZnpefp2CdwZNxbyFXzwr5i97TJbA+MWuy5GTg4JAROJpefnsULYYhIX7q1n62Lk
	4hASuMwo8eTjdCjnBJPEsn3HmECq2AR0JRb1NIPZIgJqEhPbDrGA2MwCq5kktt5lA7GFBXwk
	Nh68yQhiswioSjzc2wkW5xVwkdh/6Q0TxDY5ifPHfzKD2JwCrhJL3vSC2UJANXtu9TJNYORd
	wMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkyPh3MHatlznEKMDBqMTD
	ayBzPUSINbGsuDL3EKMkB5OSKO/RcKAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd5Fh6+FCPGm
	JFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHhPdAINFSxKTU+tSMvMKUFI
	M3FwggznkhIpTs1LSS1KLC3JiAdFRnwxMDZAUjxAeztB2nmLCxJzgaIQracYFaXEef+DJARA
	EhmleXBjYanjFaM40JfCvKldQFU8wLQD1/0KaDAT0ODFS6+ADC5JREhJNTAyWrvz8z3kd38W
	FP79lFbjbRNdwQ1N6h7fEplXuFl0d2v/f8D6wmCWSShPtc9HBrl5XvtOPNiRsERht9w+2Sff
	TlzZsuzeisPRvZH7P/8L2p1W0M2Vq1Z8X2Crp/Ha2IZbh9yD9RJPOiQYJ2x84lP4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263525>

Instead, if old_sha1 is non-NULL, verify it; otherwise, don't.

ref_transaction_delete() will get the same treatment in a moment.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 branch.c               |  5 +++--
 builtin/commit.c       |  2 +-
 builtin/fetch.c        |  6 ++++--
 builtin/receive-pack.c |  2 +-
 builtin/replace.c      |  2 +-
 builtin/tag.c          |  2 +-
 builtin/update-ref.c   |  7 ++++---
 fast-import.c          |  6 +++---
 refs.c                 | 18 ++++++++----------
 refs.h                 |  6 +++---
 sequencer.c            |  2 +-
 walker.c               |  2 +-
 12 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/branch.c b/branch.c
index 4bab55a..b002435 100644
--- a/branch.c
+++ b/branch.c
@@ -284,8 +284,9 @@ void create_branch(const char *head,
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
-		    ref_transaction_update(transaction, ref.buf, sha1,
-					   null_sha1, 0, !forcing, msg, &err) ||
+		    ref_transaction_update(transaction, ref.buf,
+					   sha1, forcing ? NULL : null_sha1,
+					   0, msg, &err) ||
 		    ref_transaction_commit(transaction, &err))
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
diff --git a/builtin/commit.c b/builtin/commit.c
index 7d90c35..5654abd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1773,7 +1773,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
 				   ? current_head->object.sha1 : NULL,
-				   0, !!current_head, sb.buf, &err) ||
+				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
 		die("%s", err.buf);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7b84d35..719bf4f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -416,8 +416,10 @@ static int s_update_ref(const char *action,
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
-				   ref->old_sha1, 0, check_old, msg, &err))
+	    ref_transaction_update(transaction, ref->name,
+				   ref->new_sha1,
+				   check_old ? ref->old_sha1 : NULL,
+				   0, msg, &err))
 		goto fail;
 
 	ret = ref_transaction_commit(transaction, &err);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4e85e25..71be82e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -951,7 +951,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_update(transaction,
 					   namespaced_name,
 					   new_sha1, old_sha1,
-					   0, 1, "push",
+					   0, "push",
 					   &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
diff --git a/builtin/replace.c b/builtin/replace.c
index 85d39b5..54bf01a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -172,7 +172,7 @@ static int replace_object_sha1(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, 1, NULL, &err) ||
+				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
diff --git a/builtin/tag.c b/builtin/tag.c
index e633f4e..232c28c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -733,7 +733,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, 1, NULL, &err) ||
+				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1993529..f0db7a3 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -198,8 +198,9 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (ref_transaction_update(transaction, refname,
+				   new_sha1, have_old ? old_sha1 : NULL,
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -297,7 +298,7 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, 1, msg, &err))
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
diff --git a/fast-import.c b/fast-import.c
index d0bd285..1e72bfb 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1716,7 +1716,7 @@ static int update_branch(struct branch *b)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
-				   0, 1, msg, &err) ||
+				   0, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -1756,8 +1756,8 @@ static void dump_tags(void)
 		strbuf_reset(&ref_name);
 		strbuf_addf(&ref_name, "refs/tags/%s", t->name);
 
-		if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
-					   NULL, 0, 0, msg, &err)) {
+		if (ref_transaction_update(transaction, ref_name.buf,
+					   t->sha1, NULL, 0, msg, &err)) {
 			failure |= error("%s", err.buf);
 			goto cleanup;
 		}
diff --git a/refs.c b/refs.c
index 851c9f8..6beafcf 100644
--- a/refs.c
+++ b/refs.c
@@ -3655,7 +3655,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err)
 {
 	struct ref_update *update;
@@ -3665,9 +3665,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
-	if (have_old && !old_sha1)
-		die("BUG: have_old is true but old_sha1 is NULL");
-
 	if (!is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		strbuf_addf(err, "refusing to update ref with bad name %s",
@@ -3677,7 +3674,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
-	if (have_old) {
+	if (old_sha1) {
 		hashcpy(update->old_sha1, old_sha1);
 		flags |= REF_HAVE_OLD;
 	}
@@ -3694,7 +3691,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname, new_sha1,
-				      null_sha1, flags, 1, msg, err);
+				      null_sha1, flags, msg, err);
 }
 
 int ref_transaction_delete(struct ref_transaction *transaction,
@@ -3703,8 +3700,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 			   int flags, int have_old, const char *msg,
 			   struct strbuf *err)
 {
-	return ref_transaction_update(transaction, refname, null_sha1,
-				      old_sha1, flags, have_old, msg, err);
+	return ref_transaction_update(transaction, refname,
+				      null_sha1, have_old ? old_sha1 : NULL,
+				      flags, msg, err);
 }
 
 int update_ref(const char *action, const char *refname,
@@ -3716,8 +3714,8 @@ int update_ref(const char *action, const char *refname,
 
 	t = ref_transaction_begin(&err);
 	if (!t ||
-	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, action, &err) ||
+	    ref_transaction_update(t, refname, sha1, oldval,
+				   flags, action, &err) ||
 	    ref_transaction_commit(t, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
diff --git a/refs.h b/refs.h
index 9bf2148..f05ac89 100644
--- a/refs.h
+++ b/refs.h
@@ -265,8 +265,8 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 /*
  * Add a reference update to transaction.  new_sha1 is the value that
  * the reference should have after the update, or null_sha1 if it should
- * be deleted.  If have_old is true, then old_sha1 holds the value
- * that the reference should have had before the update, or zeros if
+ * be deleted.  If old_sha1 is non-NULL, then it the value
+ * that the reference should have had before the update, or null_sha1 if
  * it must not have existed beforehand.
  * Function returns 0 on success and non-zero on failure. A failure to update
  * means that the transaction as a whole has failed and will need to be
@@ -276,7 +276,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *new_sha1,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
diff --git a/sequencer.c b/sequencer.c
index 77a1266..32aa05e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -252,7 +252,7 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD",
 				   to, unborn ? null_sha1 : from,
-				   0, 1, sb.buf, &err) ||
+				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
diff --git a/walker.c b/walker.c
index f149371..34881b0 100644
--- a/walker.c
+++ b/walker.c
@@ -299,7 +299,7 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		strbuf_reset(&refname);
 		strbuf_addf(&refname, "refs/%s", write_ref[i]);
 		if (ref_transaction_update(transaction, refname.buf,
-					   &sha1[20 * i], NULL, 0, 0,
+					   &sha1[20 * i], NULL, 0,
 					   msg ? msg : "fetch (unknown)",
 					   &err)) {
 			error("%s", err.buf);
-- 
2.1.4
