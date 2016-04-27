From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 28/29] commit_ref_update(): remove the flags parameter
Date: Wed, 27 Apr 2016 18:57:45 +0200
Message-ID: <9516d8e2b9b5853e3d28d0508eba372a1b860605.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoH-00047Q-Jg
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbcD0Q7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:59:18 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:53624 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753011AbcD0Q6w (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:52 -0400
X-AuditID: 12074414-63fff700000008e6-87-5720efcb58e9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E7.72.02278.BCFE0275; Wed, 27 Apr 2016 12:58:51 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6f022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:49 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqHv6vUK4wb2ZnBbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owtLRNYChaKVRy5sYOpgbFZqIuRk0NCwETi4tqf
	TF2MXBxCAlsZJc51PmaBcI4zSUx6v4UdpIpNQFdiUU8zE4gtIuAgsXzlL3aQImaBJiaJ78ub
	WEASwgJuEr+n7mEFsVkEVCX+z25hA7F5BaIkrj47wAKxTk7i8vQHYHFOAQuJL61vGUFsIQFz
	iSUPVrNPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83s0QvNaV0EyMkyER2MB45
	KXeIUYCDUYmH94SUQrgQa2JZcWXuIUZJDiYlUd4lZ4FCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHinvwHK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CycpwcChJ8KoCo0lIsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhQF8cXAOABJ8QDtLX0Hsre4IDEXKArReopR
	UUqc9zVIQgAkkVGaBzcWljpeMYoDfSnMGwRSxQNMO3Ddr4AGMwENvnxIFmRwSSJCSqqBUc7g
	++nS1XU3EvpfyPp8sFX68y/2bXwce2RPvsfct2fyIttymiZsUQvVUDmbNv8QQ9eUmtAJ/7iq
	OY/sn7O67eV7lv/TKzR7Njw2/b5tcTbzxnomSYWNR6TEour/3BB69qtjwr0JBQcj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292762>

commit_ref_update() is now only called with flags=0. So remove the flags
parameter entirely.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 40ed157..938871b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2568,7 +2568,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
 static int commit_ref_update(struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
-			     int flags, struct strbuf *err);
+			     struct strbuf *err);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
@@ -2636,7 +2636,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, 0, &err)) {
+	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -2656,7 +2656,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, 0, &err)) {
+	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -2870,12 +2870,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
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
@@ -2911,7 +2911,7 @@ static int commit_ref_update(struct ref_lock *lock,
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
