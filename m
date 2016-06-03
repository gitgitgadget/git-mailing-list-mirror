From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 22/38] refs: make create_symref() virtual
Date: Fri,  3 Jun 2016 23:03:57 +0200
Message-ID: <a56b10941416c5d0ff229ac397cd16f2d9a795b7.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHm-00013O-T0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932977AbcFCVFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:34 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61304 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932432AbcFCVFG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:06 -0400
X-AuditID: 1207440c-c53ff70000000b85-b5-5751f1005418
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id A9.55.02949.001F1575; Fri,  3 Jun 2016 17:05:04 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcm003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:03 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqMvwMTDcoPGDtcX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDN2TNIp6BSpaGuay9jAOFOgi5GT
	Q0LAROLAgVbmLkYuDiGBrYwSj+ffY4VwjjNJHH7UzwRSxSagK7GopxnMFhGIkGh41cIIUsQs
	MIdJ4vbDTmaQhLCApcSBX7fZQWwWAVWJ4ztBxnJw8ApESfx/JQ6xTU7i8vQHbCA2p4CFRMvn
	VawgtpCAuUTjqcMsExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdTLzSzRS00p3cQI
	CTmeHYzf1skcYhTgYFTi4S14FhguxJpYVlyZe4hRkoNJSZR37x2gEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHelNdAOd6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eSBO+i
	90CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAIiC8GxgBIigdo7zmQdt7igsRc
	oChE6ylGRSlx3kMgCQGQREZpHtxYWCJ5xSgO9KUw722QKh5gEoLrfgU0mAlocMEjf5DBJYkI
	KakGRpbJaxLrDrqtfdV2+JWzjttn/8M/Fd8b1s267ywf+W2fi0LEEnaGP/fmZTClawRMVUxO
	W/3D7873M/7rXu1hsku6Frz7Z/ddNq3eCa1380W/Tw61zHRes9h1LQuTEQvr25oz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296384>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 9 +++++++++
 refs/files-backend.c | 7 ++++++-
 refs/refs-internal.h | 5 +++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f4f5f32..22837f4 100644
--- a/refs.c
+++ b/refs.c
@@ -1425,6 +1425,15 @@ int pack_refs(unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
+int create_symref(const char *ref_target, const char *refs_heads_master,
+		  const char *logmsg)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->create_symref(refs, ref_target, refs_heads_master,
+				       logmsg);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e5a8799..f82a1be 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3015,12 +3015,16 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 	return 0;
 }
 
-int create_symref(const char *refname, const char *target, const char *logmsg)
+static int files_create_symref(struct ref_store *ref_store,
+			       const char *refname, const char *target,
+			       const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	struct ref_lock *lock;
 	int ret;
 
+	files_downcast(ref_store, 0, "create_symref");
+
 	lock = lock_ref_sha1_basic(refname, NULL, NULL, NULL, REF_NODEREF, NULL,
 				   &err);
 	if (!lock) {
@@ -4027,6 +4031,7 @@ struct ref_storage_be refs_be_files = {
 	files_transaction_commit,
 
 	files_pack_refs,
+	files_create_symref,
 
 	files_read_raw_ref,
 	files_verify_refname_available
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 578c125..c342e57 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -496,6 +496,10 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int create_symref_fn(struct ref_store *ref_store,
+			     const char *ref_target,
+			     const char *refs_heads_master,
+			     const char *logmsg);
 
 /*
  * Read a reference from the specified reference store, non-recursively.
@@ -552,6 +556,7 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *transaction_commit;
 
 	pack_refs_fn *pack_refs;
+	create_symref_fn *create_symref;
 
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
-- 
2.8.1
