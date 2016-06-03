From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 25/38] lock_raw_ref(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:04:00 +0200
Message-ID: <e06f5aae56ae8d83812effa7c359dc0b6796740b.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHp-00013O-5W
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbcFCVFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:43 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58656 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932944AbcFCVFL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:11 -0400
X-AuditID: 1207440e-ef3ff700000008c5-ba-5751f1066cdd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 4F.68.02245.601F1575; Fri,  3 Jun 2016 17:05:10 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcp003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:08 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqMv2MTDcYOYKKYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGfMnz2BqWC+UMXhM29YGxhP8XUx
	cnJICJhIvPx0nKWLkYtDSGAro8Sap4+ZIJzjTBK7J91lBKliE9CVWNTTzARiiwhESDS8amEE
	KWIWmMMkcfthJzNIQljAVeLbyj9gRSwCqhKPPu4Fs3kFoiT6Hl1kgVgnJ3F5+gM2EJtTwEKi
	5fMqVhBbSMBcovHUYZYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6+VmluilppRu
	YoSEHd8Oxvb1MocYBTgYlXh4C54FhguxJpYVV+YeYpTkYFIS5d17ByjEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhDflNVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTB
	u+g9UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KArii4FxAJLiAdrL/QFkb3FB
	Yi5QFKL1FKOilDjvIZC5AiCJjNI8uLGwZPKKURzoS2HeOSBVPMBEBNf9CmgwE9Dggkf+IINL
	EhFSUg2MzI/3V95yb20Jls4uLsjJDVn7M/PfBcsOoyeTHO33S4X4iSQkRuXJz95+VbpjTkrQ
	jJaKZVqLE75fNeU+nsrVvfBVb7vr5ik3dVg2MdbuiJvq9i3pxrp3W5fU1B+weeTG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296388>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 48b37fa..dfce4d1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1527,7 +1527,8 @@ static void unlock_ref(struct ref_lock *lock)
  *   avoided, namely if we were successfully able to read the ref
  * - Generate informative error messages in the case of failure
  */
-static int lock_raw_ref(const char *refname, int mustexist,
+static int lock_raw_ref(struct files_ref_store *refs,
+			const char *refname, int mustexist,
 			const struct string_list *extras,
 			const struct string_list *skip,
 			struct ref_lock **lock_p,
@@ -1535,15 +1536,14 @@ static int lock_raw_ref(const char *refname, int mustexist,
 			unsigned int *type,
 			struct strbuf *err)
 {
-	struct ref_store *ref_store = get_ref_store(NULL);
-	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "lock_raw_ref");
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	assert(err);
+	assert_main_repository(&refs->base, "lock_raw_ref");
+
 	*type = 0;
 
 	/* First lock the file so it can't change out from under us. */
@@ -1627,7 +1627,7 @@ retry:
 	 * fear that its value will change.
 	 */
 
-	if (files_read_raw_ref(ref_store, refname,
+	if (files_read_raw_ref(&refs->base, refname,
 			       lock->old_oid.hash, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
@@ -3489,6 +3489,8 @@ static int lock_ref_for_update(struct ref_update *update,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "lock_ref_for_update");
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_sha1(update->old_sha1);
@@ -3505,7 +3507,7 @@ static int lock_ref_for_update(struct ref_update *update,
 			return ret;
 	}
 
-	ret = lock_raw_ref(update->refname, mustexist,
+	ret = lock_raw_ref(refs, update->refname, mustexist,
 			   affected_refnames, NULL,
 			   &update->lock, &referent,
 			   &update->type, err);
-- 
2.8.1
