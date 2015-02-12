From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/12] ref_transaction_delete(): remove "have_old" parameter
Date: Thu, 12 Feb 2015 12:12:16 +0100
Message-ID: <1423739543-1025-6-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLroA-0007OX-Fb
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbbBLLTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:19:42 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50426 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752766AbbBLLTl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:19:41 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2015 06:19:41 EST
X-AuditID: 1207440f-f792a6d000001284-59-54dc8aa733f4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.A0.04740.7AA8CD45; Thu, 12 Feb 2015 06:12:39 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7Y003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:38 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqLu8606IwbWbAhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzZj3dylKwQKFi0qWLLA2McyS7GDk4JARMJNa90+5i5AQyxSQu3FvP
	1sXIxSEkcJlRYuK1BVDOCSaJTb+2sIFUsQnoSizqaWYCsUUE1CQmth1iAbGZBVYzSWy9ywYy
	VFjAX+LxFE8Qk0VAVWLKkiCQCl4BZ4mFEyazQOySkzh//CcziM0p4CLx7lIDI4gtBFSzq20L
	6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE30cjNL9FJTSjcxQgKMfwdj13qZQ4wC
	HIxKPLwrTO+ECLEmlhVX5h5ilORgUhLl5WoFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh9W0C
	yvGmJFZWpRblw6SkOViUxHnVl6j7CQmkJ5akZqemFqQWwWRlODiUJHjLO4EaBYtS01Mr0jJz
	ShDSTBycIMO5pESKU/NSUosSS0sy4kFREV8MjAuQFA/QXjGQdt7igsRcoChE6ylGRSlx3kyQ
	hABIIqM0D24sLG28YhQH+lKYVwKYRIR4gCkHrvsV0GAmoMETZ9wGGVySiJCSamDckRk8b8K8
	60vu+nUIB/98+cTsunt0zYMrX/Y2v/5+tb/iRrPygr3Zb7RmsO5j++AwecLUvNnc8odOtER+
	/ci27P2KsBij84f+FplP3PE5tr0x/nKRTJzD9kKhNZUa9t83Gx4NXqPoKLBRJUAi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263724>

Instead, verify the reference's old value if and only if old_sha1 is
non-NULL.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/receive-pack.c |  3 +--
 builtin/update-ref.c   |  5 +++--
 refs.c                 | 11 ++++++-----
 refs.h                 |  6 +++---
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0be50e9..70e9ce5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -953,8 +953,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		if (ref_transaction_delete(transaction,
 					   namespaced_name,
 					   old_sha1,
-					   0, old_sha1 != NULL,
-					   "push", &err)) {
+					   0, "push", &err)) {
 			rp_error("%s", err.buf);
 			strbuf_release(&err);
 			return "failed to delete";
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index beb583e..e9632d5 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -265,8 +265,9 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	if (ref_transaction_delete(transaction, refname, old_sha1,
-				   update_flags, have_old, msg, &err))
+	if (ref_transaction_delete(transaction, refname,
+				   have_old ? old_sha1 : NULL,
+				   update_flags, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
diff --git a/refs.c b/refs.c
index 95ebd35..ddb8bca 100644
--- a/refs.c
+++ b/refs.c
@@ -2576,7 +2576,7 @@ static void prune_ref(struct ref_to_prune *r)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, r->name, r->sha1,
-				   REF_ISPRUNING, 1, NULL, &err) ||
+				   REF_ISPRUNING, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
@@ -2753,8 +2753,9 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, sha1, delopt,
-				   sha1 && !is_null_sha1(sha1), NULL, &err) ||
+	    ref_transaction_delete(transaction, refname,
+				   (sha1 && !is_null_sha1(sha1)) ? sha1 : NULL,
+				   delopt, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
 		ref_transaction_free(transaction);
@@ -3696,11 +3697,11 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err)
 {
 	return ref_transaction_update(transaction, refname,
-				      null_sha1, have_old ? old_sha1 : NULL,
+				      null_sha1, old_sha1,
 				      flags, msg, err);
 }
 
diff --git a/refs.h b/refs.h
index f05ac89..ee612da 100644
--- a/refs.h
+++ b/refs.h
@@ -295,8 +295,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 			   struct strbuf *err);
 
 /*
- * Add a reference deletion to transaction.  If have_old is true, then
- * old_sha1 holds the value that the reference should have had before
+ * Add a reference deletion to transaction.  If old_sha1 is non-NULL, then
+ * it holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
  * Function returns 0 on success and non-zero on failure. A failure to delete
  * means that the transaction as a whole has failed and will need to be
@@ -305,7 +305,7 @@ int ref_transaction_create(struct ref_transaction *transaction,
 int ref_transaction_delete(struct ref_transaction *transaction,
 			   const char *refname,
 			   const unsigned char *old_sha1,
-			   int flags, int have_old, const char *msg,
+			   int flags, const char *msg,
 			   struct strbuf *err);
 
 /*
-- 
2.1.4
