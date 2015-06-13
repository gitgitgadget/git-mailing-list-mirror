From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/12] delete_ref(): move declaration to refs.h
Date: Sat, 13 Jun 2015 16:42:04 +0200
Message-ID: <0c49ee45d76303320c197f10270601683ed27cf4.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3mdp-0007iJ-LC
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbbFMOmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:25 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51525 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751394AbbFMOmX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:23 -0400
X-AuditID: 1207440f-f79236d000000c5e-f7-557c414cdc4d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 15.CF.03166.C414C755; Sat, 13 Jun 2015 10:42:20 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpP026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:19 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOvjWBNqcGyGoEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M37On8BYMF+kYtNJlQbGJQJdjJwcEgImEhuOLmOBsMUkLtxbz9bFyMUhJHCZUWLxntvM
	EM4JJon7rW1MIFVsAroSi3qawWwRATWJiW2HWECKmAU6GCUuLN/GDpIQFnCSuLFsHdhYFgFV
	iT8LDzCD2LwCURK/lhxhhFgnJ3H++E+gOAcHp4CFxMumTJCwkIC5xNsV7awTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI10cvNLNFLTSndxAgJKP4djF3rZQ4xCnAwKvHwZsRWhwqx
	JpYVV+YeYpTkYFIS5Y3cAxTiS8pPqcxILM6ILyrNSS0+xCjBwawkwiuoXRMqxJuSWFmVWpQP
	k5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4L1mD9QoWJSanlqRlplTgpBm4uAEGc4l
	JVKcmpeSWpRYWpIRD4qM+GJgbICkeID2PgRp5y0uSMwFikK0nmJUlBLnvQWSEABJZJTmwY2F
	pYlXjOJAXwrzejgAVfEAUwxc9yugwUxAg9t7qkAGlyQipKQaGMtt5gWff3G4zei8h8+a3wzZ
	ObebctQkM7vjjCVmX61jZeuJNZy0RPzcjCmHP7+qm1Ph7lI567y62Em5qX/n7etdttTcYsIT
	nlKOWftLd+61r+WQEjpfZPHUzY1h9hwlVhWmC/fPzU6Ie5S4j7nNOZj3wPlAiwc3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271546>

Also

* Add a docstring

* Rename the second parameter to "old_sha1", to be consistent with the
  convention used elsewhere in the refs module

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h |  2 --
 refs.c  |  5 +++--
 refs.h  | 10 ++++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 571c98f..be92121 100644
--- a/cache.h
+++ b/cache.h
@@ -585,8 +585,6 @@ extern void update_index_if_able(struct index_state *, struct lock_file *);
 extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
-extern int delete_ref(const char *, const unsigned char *sha1, unsigned int flags);
-
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int trust_ctime;
diff --git a/refs.c b/refs.c
index a742d79..b575bb8 100644
--- a/refs.c
+++ b/refs.c
@@ -2789,7 +2789,8 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flags)
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2797,7 +2798,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, unsigned int flag
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname,
-				   (sha1 && !is_null_sha1(sha1)) ? sha1 : NULL,
+				   (old_sha1 && !is_null_sha1(old_sha1)) ? old_sha1 : NULL,
 				   flags, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
diff --git a/refs.h b/refs.h
index 8c3d433..68b5e81 100644
--- a/refs.h
+++ b/refs.h
@@ -202,6 +202,16 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/*
+ * Delete the specified reference. If old_sha1 is non-NULL and not
+ * NULL_SHA1, then verify that the current value of the reference is
+ * old_sha1 before deleting it. If old_sha1 is NULL or NULL_SHA1,
+ * delete the reference if it exists, regardless of its old value.
+ * flags is passed through to ref_transaction_delete().
+ */
+extern int delete_ref(const char *refname, const unsigned char *old_sha1,
+		      unsigned int flags);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.4
