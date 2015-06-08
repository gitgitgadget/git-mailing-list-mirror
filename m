From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 01/13] delete_ref(): move declaration to refs.h
Date: Mon,  8 Jun 2015 13:45:35 +0200
Message-ID: <2eea274d60e355e4944ca9ed400e6c2132b4ed32.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vV9-0004zQ-T3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbbFHLp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:45:56 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:46705 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244AbbFHLpy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:45:54 -0400
X-AuditID: 12074411-f796c6d000000bc9-c8-557580728dbc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 35.1F.03017.27085755; Mon,  8 Jun 2015 07:45:54 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjoow017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:45:53 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqFvUUBpqMKODzaLrSjeTRUPvFWaL
	2yvmM1v8aOlhtti8uZ3FgdXj7/sPTB4LNpV6POvdw+hx8ZKyx+dNcgGsUdw2SYklZcGZ6Xn6
	dgncGV939rAVrBGumH3xElMD4wn+LkZODgkBE4n5u6axQdhiEhfurQeyuTiEBC4zSrQsXcgE
	4Zxgklh48xhYFZuArsSinmYmEFtEQE1iYtshFpAiZoEORokLy7exgySEBewlOm/PALNZBFQl
	ZjfNZ+xi5ODgFYiS+Po7G2KbnMT54z+ZQWxOAQuJu/8vgM0XEjCX+LitnXECI+8CRoZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRbqmermZJXqpKaWbGCEhJbiDccZJuUOMAhyMSjy8BxaVhAqx
	JpYVV+YeYpTkYFIS5e0qKw0V4kvKT6nMSCzOiC8qzUktPsQowcGsJMLLZAGU401JrKxKLcqH
	SUlzsCiJ8/ItUfcTEkhPLEnNTk0tSC2CycpwcChJ8H6sA2oULEpNT61Iy8wpQUgzcXCCDOeS
	EilOzUtJLUosLcmIB8VGfDEwOkBSPEB7VepB9hYXJOYCRSFaTzEqSonzRoAkBEASGaV5cGNh
	ieIVozjQl8K8T0GqeIBJBq77FdBgJqDB378WgwwuSURISTUwZp66JDXxXWr4klt7uhZ7z1t7
	yCRYquDHMoveber1XnIt/my7H+xzb+eYaZmzadHB+e9//lySJKj5YM/D+VP2HOLPNtC4/nov
	rzXjTvsPjhfOT3kuvK2q6FJR90w9sRN9P6+KKrUdOvM2pcdObWL6m+olCVIJ2bvc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271012>

Also

* Add a docstring

* Rename the second parameter to "old_sha1", to be consistent with the
  convention used elsewhere in the refs module

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h | 2 --
 refs.c  | 5 +++--
 refs.h  | 9 +++++++++
 3 files changed, 12 insertions(+), 4 deletions(-)

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
index 8c3d433..8785bca 100644
--- a/refs.h
+++ b/refs.h
@@ -202,6 +202,15 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 /** Check if a particular reflog exists */
 extern int reflog_exists(const char *refname);
 
+/*
+ * Delete the specified reference. If old_sha1 is non-NULL and not
+ * NULL_SHA1, then verify that the current value of the reference is
+ * old_sha1 before deleting it. flags is passed to
+ * ref_transaction_delete().
+ */
+extern int delete_ref(const char *refname, const unsigned char *old_sha1,
+		      unsigned int flags);
+
 /** Delete a reflog */
 extern int delete_reflog(const char *refname);
 
-- 
2.1.4
