From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 26/38] commit_ref_update(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:04:01 +0200
Message-ID: <f987509203a2ff8c3ac7c3855f85ad229252d2ae.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wI4-0001HP-1O
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbcFCVFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:50 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52610 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932962AbcFCVFN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:13 -0400
X-AuditID: 12074413-487ff700000008c7-21-5751f1085dfe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0E.8F.02247.801F1575; Fri,  3 Jun 2016 17:05:12 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcq003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:10 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMvxMTDcYP4tfov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGe8/7mAseCKSMX3OUvZGxh/CXQx
	cnJICJhI3Gi+z9jFyMUhJLCVUaJn/Q9GkISQwHEmidYlLiA2m4CuxKKeZiYQW0QgQqLhVQtY
	A7PAHCaJ2w87mUESwgJeEjPXPgOzWQRUJX6/nMIGYvMKREk0XH/CDrFNTuLy9AdgcU4BC4mW
	z6tYIZaZSzSeOswygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ
	oBPewbjrpNwhRgEORiUe3oJngeFCrIllxZW5hxglOZiURHn33gEK8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuFNeQ2U401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8C56
	D9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qB+GJgFICkeID2cn8A2VtckJgL
	FIVoPcWoKCXOewhkrgBIIqM0D24sLJW8YhQH+lKYVwyknQeYhuC6XwENZgIaXPDIH2RwSSJC
	SqqBsaJJUq5FzC0izW7xMcbs7H/+y/y/XHaYf9yad7cSz64cMVFv455fWzYLd9+Xbpflu9gt
	eWTSM5NF8l9ePQy4+HHFFK4NJu7qW2T2cVb6Fh6WTnAV/GCY67Ti5xbzj7PiFvld 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296391>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index dfce4d1..bc7d250 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2578,12 +2578,14 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
-static int commit_ref_update(struct ref_lock *lock,
+static int commit_ref_update(struct files_ref_store *refs,
+			     struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
+	struct files_ref_store *refs = get_files_ref_store(NULL, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -2656,7 +2658,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
+	    commit_ref_update(refs, lock, orig_sha1, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -2676,7 +2678,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
+	    commit_ref_update(refs, lock, orig_sha1, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -2912,12 +2914,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  * to the loose reference lockfile. Also update the reflogs if
  * necessary, using the specified lockmsg (which can be NULL).
  */
-static int commit_ref_update(struct ref_lock *lock,
+static int commit_ref_update(struct files_ref_store *refs,
+			     struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "commit_ref_update");
+	assert_main_repository(&refs->base, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
 	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
-- 
2.8.1
