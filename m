From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 24/25] refs: create a shared version of verify_refname_available
Date: Tue,  3 Nov 2015 08:40:08 +0100
Message-ID: <977f96011c2a35c77a1bc6b25960b357e2bd7ef7.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:48:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWKR-000631-TA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbbKCHsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:48:24 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44590 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752709AbbKCHsW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:48:22 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Nov 2015 02:48:22 EST
X-AuditID: 12074414-f794f6d000007852-cf-563864fb59da
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DA.2D.30802.BF468365; Tue,  3 Nov 2015 02:40:43 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdL016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:42 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPs7xSLMoHuxtcX8TScYLbqudDNZ
	NPReYba4vWI+s8W/CTUOrB5/339g8liwqdTj4iVljwXP77N7fN4kF8AaxW2TlFhSFpyZnqdv
	l8CdMXHSReaCHdYVRzq3szUw7tfvYuTkkBAwkdhxdRMLhC0mceHeerYuRi4OIYHLjBKvpt1h
	gnCOMUl0zbsPVsUmoCuxqKeZCcQWEVCTmNh2iAWkiFlgEaNE65vpYAlhgWCJg7N6mUFsFgFV
	ict3e9hBbF6BKImTh/rYIdbJSUy53w5WzylgIfHg7h+wuJCAucSme8vYJjDyLmBkWMUol5hT
	mqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokRElIiOxiPnJQ7xCjAwajEw7tgiXmYEGti
	WXFl7iFGSQ4mJVHedTEWYUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeAsCgXK8KYmVValF+TAp
	aQ4WJXHeb4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8l5KBGgWLUtNTK9Iyc0oQ0kwcnCDDuaRE
	ilPzUlKLEktLMuJB0RFfDIwPkBQP0N6EFJC9xQWJuUBRiNZTjIpS4rwXQeYKgCQySvPgxsIS
	xStGcaAvhXknglTxAJMMXPcroMFMQIPDt5mCDC5JREhJNTAuTYjdsP62reHOJ+J/irmqpvwO
	D1G37P/r937xLP5XbxevNBWu5jL6v7TVyKTr1YzPD22c+6qX3ZUUUz+eUebdcdVnddG0pVm3
	3Vb1HTe/wH0oc9fDN3FFS5d7TZpz6HLOpIi2ie0WYi+YdjD/7fmccn3bGk7rVUEe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280776>

From: Ronnie Sahlberg <sahlberg@google.com>

Create a version of verify_refname_available that backends can use,
and add it to refs/refs-internal.h.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 65 ++++++++++++++++++++++++----------------------------
 refs/refs-internal.h | 20 ++++++++++++++++
 2 files changed, 50 insertions(+), 35 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 20e2924..e0ae769 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -135,7 +135,7 @@ struct ref_dir {
  * presence of an empty subdirectory does not block the creation of a
  * similarly-named reference.  (The fact that reference names with the
  * same leading components can conflict *with each other* is a
- * separate issue that is regulated by verify_refname_available().)
+ * separate issue that is regulated by verify_refname_available_dir().)
  *
  * Please note that the name field contains the fully-qualified
  * reference (or subdirectory) name.  Space could be saved by only
@@ -720,25 +720,13 @@ static int nonmatching_ref_fn(struct ref_entry *entry, void *vdata)
 /*
  * Return 0 if a reference named refname could be created without
  * conflicting with the name of an existing reference in dir.
- * Otherwise, return a negative value and write an explanation to err.
- * If extras is non-NULL, it is a list of additional refnames with
- * which refname is not allowed to conflict. If skip is non-NULL,
- * ignore potential conflicts with refs in skip (e.g., because they
- * are scheduled for deletion in the same operation). Behavior is
- * undefined if the same name is listed in both extras and skip.
- *
- * Two reference names conflict if one of them exactly matches the
- * leading components of the other; e.g., "refs/foo/bar" conflicts
- * with both "refs/foo" and with "refs/foo/bar/baz" but not with
- * "refs/foo/bar" or "refs/foo/barbados".
- *
- * extras and skip must be sorted.
+ * See verify_refname_available for details.
  */
-static int verify_refname_available(const char *refname,
-				    const struct string_list *extras,
-				    const struct string_list *skip,
-				    struct ref_dir *dir,
-				    struct strbuf *err)
+static int verify_refname_available_dir(const char *refname,
+					const struct string_list *extras,
+					const struct string_list *skip,
+					struct ref_dir *dir,
+					struct strbuf *err)
 {
 	const char *slash;
 	int pos;
@@ -1942,9 +1930,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		 */
 		strbuf_git_path(&orig_ref_file, "%s", orig_refname);
 		if (remove_empty_directories(&orig_ref_file)) {
+			struct ref_dir *loose_refs;
+			loose_refs = get_loose_refs(&ref_cache);
 			last_errno = errno;
-			if (!verify_refname_available(orig_refname, extras, skip,
-						      get_loose_refs(&ref_cache), err))
+			if (!verify_refname_available_dir(orig_refname, extras,
+							  skip, loose_refs,
+							  err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    orig_refname);
 			goto error_return;
@@ -1957,8 +1948,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	if (!refname) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-		    !verify_refname_available(orig_refname, extras, skip,
-					      get_loose_refs(&ref_cache), err))
+		    !verify_refname_available_dir(orig_refname, extras, skip,
+						  get_loose_refs(&ref_cache),
+						  err))
 			strbuf_addf(err, "unable to resolve reference %s: %s",
 				    orig_refname, strerror(last_errno));
 
@@ -1971,8 +1963,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 * our refname.
 	 */
 	if (is_null_oid(&lock->old_oid) &&
-	    verify_refname_available(refname, extras, skip,
-				     get_packed_refs(&ref_cache), err)) {
+	    verify_refname_available_dir(refname, extras, skip,
+					 get_packed_refs(&ref_cache), err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2476,10 +2468,7 @@ static int rename_ref_available(const char *oldname, const char *newname)
 	int ret;
 
 	string_list_insert(&skip, oldname);
-	ret = !verify_refname_available(newname, NULL, &skip,
-					get_packed_refs(&ref_cache), &err)
-		&& !verify_refname_available(newname, NULL, &skip,
-					     get_loose_refs(&ref_cache), &err);
+	ret = !verify_refname_available(newname, NULL, &skip, &err);
 	if (!ret)
 		error("%s", err.buf);
 
@@ -2612,6 +2601,17 @@ static int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
+int verify_refname_available(const char *newname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err)
+{
+	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
+	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
+	return verify_refname_available_dir(newname, extra, skip,
+					    packed_refs, err) ||
+		verify_refname_available_dir(newname, extra, skip,
+					     loose_refs, err);
+}
+
 /*
  * Create a reflog for a ref.  If force_create = 0, the reflog will
  * only be created for certain refs (those for which
@@ -3327,8 +3327,6 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
-	struct ref_dir *loose_refs = get_loose_refs(&ref_cache);
-	struct ref_dir *packed_refs = get_packed_refs(&ref_cache);
 	int ret = 0, i;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
@@ -3371,10 +3369,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 			die("BUG: initial ref transaction with old_sha1 set");
 		if (verify_refname_available(update->refname,
 					     &affected_refnames, NULL,
-					     loose_refs, err) ||
-		    verify_refname_available(update->refname,
-					     &affected_refnames, NULL,
-					     packed_refs, err)) {
+					     err)) {
 			ret = TRANSACTION_NAME_CONFLICT;
 			goto cleanup;
 		}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 5f447d4..f6a79b9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -93,6 +93,26 @@ enum peel_status {
  */
 enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
 
+/*
+ * Return 0 if a reference named refname could be created without
+ * conflicting with the name of an existing reference.
+ * Otherwise, return a negative value and write an explanation to err.
+ * If extras is non-NULL, it is a list of additional refnames with
+ * which refname is not allowed to conflict. If skip is non-NULL,
+ * ignore potential conflicts with refs in skip (e.g., because they
+ * are scheduled for deletion in the same operation). Behavior is
+ * undefined if the same name is listed in both extras and skip.
+ *
+ * Two reference names conflict if one of them exactly matches the
+ * leading components of the other; e.g., "foo/bar" conflicts with
+ * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
+ * "foo/barbados".
+ *
+ * skip must be sorted.
+ */
+int verify_refname_available(const char *newname, struct string_list *extra,
+			     struct string_list *skip, struct strbuf *err);
+
 /**
  * Information needed for a single ref update. Set new_sha1 to the new
  * value or to null_sha1 to delete the ref. To check the old value
-- 
2.6.2
