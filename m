From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/38] refs: make verify_refname_available() virtual
Date: Fri,  3 Jun 2016 23:03:55 +0200
Message-ID: <6781e0075884167b1ea6d1ca10ff07e235052d72.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:05:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wHd-0000uA-Ds
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970AbcFCVF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:05:28 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61304 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932740AbcFCVFB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:01 -0400
X-AuditID: 1207440c-c53ff70000000b85-a6-5751f0fd4f72
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id C7.55.02949.DF0F1575; Fri,  3 Jun 2016 17:05:01 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kck003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:59 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv3Q2C4QddPfov5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGcs+H+VqWClaEVn71nWBsZFgl2M
	nBwSAiYSh++sYO1i5OIQEtjKKLH0UieUc5xJ4sO0b8wgVWwCuhKLepqZQGwRgQiJhlctjCBF
	zAJzmCRuP+wEKxIWcJH4O/8xexcjBweLgKrE/KtsIGFegSiJQ3teMENsk5O4PP0BWJxTwEKi
	5fMqVhBbSMBcovHUYZYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluilppRu
	YoQEHc8Oxm/rZA4xCnAwKvHwFjwLDBdiTSwrrsw9xCjJwaQkyrv3DlCILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCG/Ka6Acb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampBahFMVoaDQ0mC
	d9F7oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UAzEFwOjACTFA7T3HEg7b3FB
	Yi5QFKL1FKOilDjvIZCEAEgiozQPbiwslbxiFAf6Upj3NkgVDzANwXW/AhrMBDS44JE/yOCS
	RISUVANjadVcvt2b333KVOKdISaxwJ93imy0fnFCaYqw+58zG479C5T5xH7tiEPOJWZd24sK
	IbtlVx5xV5zyfYFWDpP3VLew1ReUzhrbLVxfPNUoL8n90ofPkw6XZIkv3t3KdvOK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296385>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 10 ++++++++++
 refs/files-backend.c | 14 ++++++++------
 refs/refs-internal.h |  7 +++++++
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 1798f66..79ef443 100644
--- a/refs.c
+++ b/refs.c
@@ -1425,3 +1425,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 
 	return refs->be->transaction_commit(refs, transaction, err);
 }
+
+int verify_refname_available(const char *refname,
+			     const struct string_list *extra,
+			     const struct string_list *skip,
+			     struct strbuf *err)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->verify_refname_available(refs, refname, extra, skip, err);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5b6d388..af8de85 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2553,13 +2553,14 @@ out:
 	return ret;
 }
 
-int verify_refname_available(const char *newname,
-			     const struct string_list *extras,
-			     const struct string_list *skip,
-			     struct strbuf *err)
+static int files_verify_refname_available(struct ref_store *ref_store,
+					  const char *newname,
+					  const struct string_list *extras,
+					  const struct string_list *skip,
+					  struct strbuf *err)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "verify_refname_available");
+		files_downcast(ref_store, 1, "verify_refname_available");
 	struct ref_dir *packed_refs = get_packed_refs(refs);
 	struct ref_dir *loose_refs = get_loose_refs(refs);
 
@@ -4025,5 +4026,6 @@ struct ref_storage_be refs_be_files = {
 	files_ref_store_create,
 	files_transaction_commit,
 
-	files_read_raw_ref
+	files_read_raw_ref,
+	files_verify_refname_available
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 8d4287c..18e01d0 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -537,6 +537,12 @@ typedef int read_raw_ref_fn(struct ref_store *ref_store,
 			    const char *refname, unsigned char *sha1,
 			    struct strbuf *referent, unsigned int *type);
 
+typedef int verify_refname_available_fn(struct ref_store *ref_store,
+					const char *newname,
+					const struct string_list *extras,
+					const struct string_list *skip,
+					struct strbuf *err);
+
 struct ref_storage_be {
 	struct ref_storage_be *next;
 	const char *name;
@@ -544,6 +550,7 @@ struct ref_storage_be {
 	ref_transaction_commit_fn *transaction_commit;
 
 	read_raw_ref_fn *read_raw_ref;
+	verify_refname_available_fn *verify_refname_available;
 };
 
 extern struct ref_storage_be refs_be_files;
-- 
2.8.1
