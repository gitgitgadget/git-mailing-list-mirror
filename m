From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 32/33] commit_ref_update(): remove the flags parameter
Date: Fri,  6 May 2016 18:14:13 +0200
Message-ID: <678e70dd4fa33223bb5a870d7196413dbfad2c3e.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiPV-00005T-2F
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbcEFQPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:15:21 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56573 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758677AbcEFQPT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:15:19 -0400
X-AuditID: 12074412-51bff700000009f7-55-572cc315c83d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 0E.62.02551.513CC275; Fri,  6 May 2016 12:15:18 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHVE031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:15:16 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqCt2WCfc4NMJXov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxq7cDu8ff9ByaPnbPusns8693D6HHxkrLH/qXb2DwW
	PL/P7vF5k1wAexS3TVJiSVlwZnqevl0Cd8ajQ+oFC8UqZj/fxdjA2CzUxcjJISFgIrF82QUm
	EFtIYCujxI/2rC5GLiD7OJPErj2T2UESbAK6Eot6msGKRAQiJBpetTB2MXJwMAt8ZpRYyQ1i
	Cgt4SpzvSAOpYBFQlfg7+z4riM0rECWx90cXI8QqOYnL0x+wgdicAhYSh3qPQ601l+hYe4N9
	AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Znq5mSV6qSmlmxghoSW0g3H9SblDjAIc
	jEo8vBkntcOFWBPLiitzDzFKcjApifJ+L9AJF+JLyk+pzEgszogvKs1JLT7EKMHBrCTCe2Uf
	UI43JbGyKrUoHyYlzcGiJM77c7G6n5BAemJJanZqakFqEUxWhoNDSYK3+RBQo2BRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwo9OOLgcEPkuIB2ssH0s5bXJCYCxSFaD3FqMtxZP+9
	tUxCLHn5ealS4rxzDwIVCYAUZZTmwa2AJZJXjOJAHwvzXgap4gEmIbhJr4CWMAEteT9XE2RJ
	SSJCSqqBcXHSxn0bXlls4HzkHqg5aya74PtzIl/vPS/fJ371amdGQnVeuSuvY3Ch1LFXEWtt
	hX3Su1nnqHYcWPrkl/r5dVFvec7JRBf2/yj5+I4hgut89OfVpZUP6n5tSUq2Krp5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293813>

commit_ref_update() is now only called with flags=0. So remove the flags
parameter entirely.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 08ec293..a180b9e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2541,7 +2541,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     int flags, struct strbuf *err);
+			     struct strbuf *err);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -2617,7 +2617,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, 0, &err)) {
+	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -2637,7 +2637,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, 0, &err)) {
+	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -2875,12 +2875,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  */
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     int flags, struct strbuf *err)
+			     struct strbuf *err)
 {
 	clear_loose_ref_cache(&ref_cache);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0 ||
+	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
-	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0)) {
+	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, 0, err) < 0)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -2916,7 +2916,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
+	if (commit_ref(lock)) {
 		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
-- 
2.8.1
