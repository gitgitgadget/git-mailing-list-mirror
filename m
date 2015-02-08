From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/11] struct ref_update: move "have_old" into "flags"
Date: Sun,  8 Feb 2015 17:13:57 +0100
Message-ID: <1423412045-15616-4-git-send-email-mhagger@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 17:21:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKUc8-0005s7-5l
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758670AbbBHQVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:21:35 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56142 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758668AbbBHQVe (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Feb 2015 11:21:34 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Feb 2015 11:21:34 EST
X-AuditID: 1207440e-f79bc6d000000c43-3e-54d78b5c1754
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 2F.7E.03139.C5B87D45; Sun,  8 Feb 2015 11:14:20 -0500 (EST)
Received: from michael.fritz.box (p4FC9719C.dip0.t-ipconnect.de [79.201.113.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t18GE9l7014021
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 8 Feb 2015 11:14:19 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqBvTfT3EoO26uEXXlW4mi4beK8wW
	b28uYbS4vWI+s0X3lLeMFr19n1gtNm9uZ3Fg9/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYo
	bpukxJKy4Mz0PH27BO6M43c3sBcskKi4d3ULYwPjLaEuRk4OCQETiQef7zNC2GISF+6tZ+ti
	5OIQErjMKNH3sZkdwjnBJDFrxxt2kCo2AV2JRT3NTCC2iICaxMS2QywgNrPAaiaJrXfZQGxh
	ATeJRVvngtksAqoSh3beB6vhFXCR2PJrGxPENjmJ88d/MoPYnAKuEkve9ILZQkA1e271Mk1g
	5F3AyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQTIyTM+HYwtq+XOcQowMGo
	xMNrIHM9RIg1say4MvcQoyQHk5Io79FwoBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3kWHr4UI
	8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeA27gIYKFqWmp1akZeaU
	IKSZODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC9VSDtvMUFiblAUYjWU4yKUuK8/zuB
	EgIgiYzSPLixsOTxilEc6EthXk2Qdh5g4oHrfgU0mAlo8OKlV0AGlyQipKQaGNf+V2VfH6e9
	dt6JNSd59N4+ydnzb8vMM28831W6zzrGOEUjZG3/jJzH98v+9N5ccbFsZtgBiQ1bTojocm1c
	9y1nX7XqZfk6xnDBop2cbK8PxhY8sOEtXf6rPI5jUtrMBJVA2dg2keOuc/x82Tl6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263524>

Instead of having a separate have_old field, record this boolean value
as a bit in the "flags" field.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index 477a5b3..851c9f8 100644
--- a/refs.c
+++ b/refs.c
@@ -41,12 +41,18 @@ static unsigned char refname_disposition[256] = {
 #define REF_DELETING	0x02
 
 /*
- * Used as a flag to ref_transaction_delete when a loose ref is being
+ * Used as a flag in ref_update::flags when a loose ref is being
  * pruned.
  */
 #define REF_ISPRUNING	0x04
 
 /*
+ * Used as a flag in ref_update::flags when old_sha1 should be
+ * checked.
+ */
+#define REF_HAVE_OLD	0x08
+
+/*
  * Try to read one refname component from the front of refname.
  * Return the length of the component found, or -1 if the component is
  * not legal.  It is legal if it is something reasonable to have under
@@ -3564,16 +3570,20 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 }
 
 /**
- * Information needed for a single ref update.  Set new_sha1 to the
- * new value or to zero to delete the ref.  To check the old value
- * while locking the ref, set have_old to 1 and set old_sha1 to the
- * value or to zero to ensure the ref does not exist before update.
+ * Information needed for a single ref update. Set new_sha1 to the new
+ * value or to null_sha1 to delete the ref. To check the old value
+ * while the ref is locked, set (flags & REF_HAVE_OLD) and set
+ * old_sha1 to the old value, or to null_sha1 to ensure the ref does
+ * not exist before update.
  */
 struct ref_update {
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	/*
+	 * One or more of REF_HAVE_OLD, REF_NODEREF,
+	 * REF_DELETING, and REF_IS_PRUNING:
+	 */
+	int flags;
 	struct ref_lock *lock;
 	int type;
 	char *msg;
@@ -3667,10 +3677,11 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
-	update->flags = flags;
-	update->have_old = have_old;
-	if (have_old)
+	if (have_old) {
 		hashcpy(update->old_sha1, old_sha1);
+		flags |= REF_HAVE_OLD;
+	}
+	update->flags = flags;
 	if (msg)
 		update->msg = xstrdup(msg);
 	return 0;
@@ -3786,13 +3797,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 		if (is_null_sha1(update->new_sha1))
 			flags |= REF_DELETING;
-		update->lock = lock_ref_sha1_basic(update->refname,
-						   (update->have_old ?
-						    update->old_sha1 :
-						    NULL),
-						   NULL,
-						   flags,
-						   &update->type);
+		update->lock = lock_ref_sha1_basic(
+				update->refname,
+				((update->flags & REF_HAVE_OLD) ?
+				 update->old_sha1 : NULL),
+				NULL,
+				flags,
+				&update->type);
 		if (!update->lock) {
 			ret = (errno == ENOTDIR)
 				? TRANSACTION_NAME_CONFLICT
-- 
2.1.4
