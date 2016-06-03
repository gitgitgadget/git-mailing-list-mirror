From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 23/38] refs: make peel_ref() virtual
Date: Fri,  3 Jun 2016 23:03:58 +0200
Message-ID: <316f0fed796fd2ed17ea5df4c264a98028d6b98a.1464983301.git.mhagger@alum.mit.edu>
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
	id 1b8wI3-0001HP-Fh
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbcFCVFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:46 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:61171 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932943AbcFCVFI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:08 -0400
X-AuditID: 1207440f-8a7ff700000008e4-4e-5751f102b0bf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id AE.EB.02276.201F1575; Fri,  3 Jun 2016 17:05:06 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcn003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:05 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqMv0MTDcYH+vocX8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61tjjzppHRgcPj7/sPTB47Z91l93jWu4fR4+IlZY/9
	S7exeSx+4OWx4Pl9do/Pm+QCOKK4bZISS8qCM9Pz9O0SuDPOzX/DWnBIqOLtlNesDYxT+bsY
	OTkkBEwklkyex9zFyMUhJLCVUeLL9zVMEM5xJomzTzexgFSxCehKLOppZgKxRQQiJBpetTCC
	FDELzGGSuP2wE6idg0MYaNSyDYIgNSwCqhKvbmxhBLF5BaIkLt6exAKxTU7i8vQHbCA2p4CF
	RMvnVawgtpCAuUTjqcMsExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p
	3cQICTr+HYxd62UOMQpwMCrx8J54ERguxJpYVlyZe4hRkoNJSZR37x2gEF9SfkplRmJxRnxR
	aU5q8SFGCQ5mJRHelNdAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eS
	BO+i90CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAYiC8GRgFIigdoL/cHkL3F
	BYm5QFGI1lOMilLivIdA5gqAJDJK8+DGwlLJK0ZxoC+FeQNB2nmAaQiu+xXQYCagwQWP/EEG
	lyQipKQaGMWP6X2f91Kw1+yfo+EMnyr990bnbs/WsXVgn7IuMys+Lyjg3O/Hl+M973qE/w4t
	Mk0t8i+cnb3H8ZH1s49fdtleXRzRsaChd9HtuK2+gjN23lu+pv9w6P1vXxNCr+of 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296389>

For now it only supports the main reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 7 +++++++
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 22837f4..2d84c5c 100644
--- a/refs.c
+++ b/refs.c
@@ -1425,6 +1425,13 @@ int pack_refs(unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
+int peel_ref(const char *refname, unsigned char *sha1)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->peel_ref(refs, refname, sha1);
+}
+
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f82a1be..91dcfcb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1763,9 +1763,10 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 	return status;
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+static int files_peel_ref(struct ref_store *ref_store,
+			  const char *refname, unsigned char *sha1)
 {
-	struct files_ref_store *refs = get_files_ref_store(NULL, "peel_ref");
+	struct files_ref_store *refs = files_downcast(ref_store, 0, "peel_ref");
 	int flag;
 	unsigned char base[20];
 
@@ -4031,6 +4032,7 @@ struct ref_storage_be refs_be_files = {
 	files_transaction_commit,
 
 	files_pack_refs,
+	files_peel_ref,
 	files_create_symref,
 
 	files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c342e57..ae67b49 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -496,6 +496,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct strbuf *err);
 
 typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+typedef int peel_ref_fn(struct ref_store *ref_store,
+			const char *refname, unsigned char *sha1);
 typedef int create_symref_fn(struct ref_store *ref_store,
 			     const char *ref_target,
 			     const char *refs_heads_master,
@@ -556,6 +558,7 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *transaction_commit;
 
 	pack_refs_fn *pack_refs;
+	peel_ref_fn *peel_ref;
 	create_symref_fn *create_symref;
 
 	read_raw_ref_fn *read_raw_ref;
-- 
2.8.1
