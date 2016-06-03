From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 21/38] refs: make pack_refs() virtual
Date: Fri,  3 Jun 2016 23:03:56 +0200
Message-ID: <22e49ca0f50831538d07d115d56b4af4e457a80c.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wIS-0001b3-MN
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbcFCVGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:00 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58656 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932951AbcFCVFE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:05:04 -0400
X-AuditID: 1207440e-ef3ff700000008c5-af-5751f0fe9496
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6E.68.02245.EF0F1575; Fri,  3 Jun 2016 17:05:03 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4Kcl003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:05:01 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqPv/Q2C4wcRmAYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGcsa53FWLBasOL7BbcGxjl8XYyc
	HBICJhJPlh1i7GLk4hAS2MooMf3RBCYI5ziTxII3NxlBqtgEdCUW9TQzgdgiAhESDa9awDqY
	BeYwSdx+2MkMkhAWMJV4s3sDWBGLgKrE3P/fweK8AlES7y/vYYFYJydxefoDNhCbU8BCouXz
	KlYQW0jAXKLx1GGWCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKE
	BB3fDsb29TKHGAU4GJV4eAueBYYLsSaWFVfmHmKU5GBSEuXdewcoxJeUn1KZkVicEV9UmpNa
	fIhRgoNZSYQ35TVQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbvo
	PVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPCgG4ouBUQCS4gHay/0BZG9xQWIu
	UBSi9RSjopQ4byjIXAGQREZpHtxYWCp5xSgO9KUwbzJIFQ8wDcF1vwIazAQ0uOCRP8jgkkSE
	lFQDowNPXFazUcn1lxu6GmoPJ0w8t3xi2xaVH1azU4slWVYf27XNa+nJaMW0lT3TPp7KmP4t
	2+HrtANvll91/Txr46/XJ5fW/UhIM9nmqsfc37Yg6cYl3szLxsb2OS4az/vrDO3V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296393>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 7 +++++++
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 4 ++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 79ef443..f4f5f32 100644
--- a/refs.c
+++ b/refs.c
@@ -1418,6 +1418,13 @@ void assert_main_repository(struct ref_store *refs, const char *caller)
 }
 
 /* backend functions */
+int pack_refs(unsigned int flags)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->pack_refs(refs, flags);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index af8de85..e5a8799 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2358,10 +2358,10 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "pack_refs");
+		files_downcast(ref_store, 0, "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
@@ -4026,6 +4026,8 @@ struct ref_storage_be refs_be_files = {
 	files_ref_store_create,
 	files_transaction_commit,
 
+	files_pack_refs,
+
 	files_read_raw_ref,
 	files_verify_refname_available
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 18e01d0..578c125 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -495,6 +495,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
+typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+
 /*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
@@ -549,6 +551,8 @@ struct ref_storage_be {
 	ref_store_init_fn *init;
 	ref_transaction_commit_fn *transaction_commit;
 
+	pack_refs_fn *pack_refs;
+
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
 };
-- 
2.8.1
