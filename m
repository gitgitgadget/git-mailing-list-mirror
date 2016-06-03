From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 28/38] lock_ref_sha1_basic(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:04:03 +0200
Message-ID: <f754a38a5b0c6c3fa0873e3c460f9b0deb183e47.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wI4-0001HP-JP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbcFCVFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:54 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53980 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422633AbcFCVFR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:17 -0400
X-AuditID: 12074412-52fff700000009f7-14-5751f10b3363
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 26.A4.02551.B01F1575; Fri,  3 Jun 2016 17:05:15 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcs003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:14 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMv9MTDc4OE+S4v5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGcc/vKTseCsTEX3vBWMDYyPxboY
	OTkkBEwkHlz+wwRiCwlsZZTo/1zSxcgFZB9nkpi3fjYzSIJNQFdiUU8zWJGIQIREw6sWRpAi
	ZoE5TBK3H3aCFQkL+Ei0fWtjA7FZBFQlvj14xA5i8wpESdxsf8YGsU1O4vL0B2A2p4CFRMvn
	VawQm80lGk8dZpnAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkjQ
	Ce1gXH9S7hCjAAejEg9vwbPAcCHWxLLiytxDjJIcTEqivHvvAIX4kvJTKjMSizPii0pzUosP
	MUpwMCuJ8Ka8BsrxpiRWVqUW5cOkpDlYlMR5fy5W9xMSSE8sSc1OTS1ILYLJynBwKEnwyn8A
	ahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUB8MTAKQFI8QHu5Qdp5iwsSc4Gi
	EK2nGBWlxHkPvQdKCIAkMkrz4MbCUskrRnGgL4V5k0GqeIBpCK77FdBgJqDBBY/8QQaXJCKk
	pBoYmeVzXTefXhhnKJ0TWC9k8kX/zTmm6zOXM/hIXn3vPf/YC7+HohpX2VqOydvP/7L2fONu
	q6yJX3Rs9i6Ni5g9eZb32mdH/eJyFN8x9y07c+eL/oO/mUeceKoebdS6czP3/sPP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296390>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 225e0af..24b7c60 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1987,15 +1987,14 @@ static int remove_empty_directories(struct strbuf *path)
  * Locks a ref returning the lock on success and NULL on failure.
  * On failure errno is set to something meaningful.
  */
-static struct ref_lock *lock_ref_sha1_basic(const char *refname,
+static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
+					    const char *refname,
 					    const unsigned char *old_sha1,
 					    const struct string_list *extras,
 					    const struct string_list *skip,
 					    unsigned int flags, int *type,
 					    struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "lock_ref_sha1_basic");
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
@@ -2005,6 +2004,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int attempts_remaining = 3;
 	int resolved;
 
+	assert_main_repository(&refs->base, "lock_ref_sha1_basic");
 	assert(err);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -2648,8 +2648,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, err.buf);
 		strbuf_release(&err);
@@ -2667,8 +2667,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, NULL, REF_NODEREF,
-				   NULL, &err);
+	lock = lock_ref_sha1_basic(refs, oldrefname, NULL, NULL, NULL,
+				   REF_NODEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -3024,13 +3024,14 @@ static int files_create_symref(struct ref_store *ref_store,
 			       const char *refname, const char *target,
 			       const char *logmsg)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "create_symref");
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
-	files_downcast(ref_store, 0, "create_symref");
-
-	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
+	lock = lock_ref_sha1_basic(refs, refname, NULL,
+				   NULL, NULL, REF_NODEREF, NULL,
 				   &err);
 	if (!lock) {
 		error("%s", err.buf);
@@ -3933,6 +3934,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		 reflog_expiry_cleanup_fn cleanup_fn,
 		 void *policy_cb_data)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "reflog_expire");
 	static struct lock_file reflog_lock;
 	struct expire_reflog_cb cb;
 	struct ref_lock *lock;
@@ -3951,7 +3954,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+	lock = lock_ref_sha1_basic(refs, refname, sha1,
+				   NULL, NULL, REF_NODEREF,
 				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
-- 
2.8.1
