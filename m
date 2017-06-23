Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95C5620401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754223AbdFWHCv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:51 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50066 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754131AbdFWHCu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:50 -0400
X-AuditID: 1207440d-3d1ff70000001be7-51-594cbd1832a4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.51.07143.81DBC495; Fri, 23 Jun 2017 03:02:48 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o69001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:46 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/29] packed_refs_lock(): report errors via a `struct strbuf *err`
Date:   Fri, 23 Jun 2017 09:01:42 +0200
Message-Id: <2df54c75be6712588605ac5bb43f3e2845c6300c.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqCux1yfSYOs7A4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDIedBoX9MtUrLv8kbGBcYZ4FyMn
        h4SAicT65muMXYxcHEICO5gkbn1ZwAzhnGKS6Dp4lR2kik1AV2JRTzMTiC0ioCYxse0QC0gR
        s8AkZom31xaCJYQFwiSav1xmBLFZBFQlZv5fxApi8wpESbx42swMsU5eYlfbRbA4p4CFRM/E
        5WALhATMJVb9Xs06gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdI73czBK91JTSTYyQ
        oOPdwfh/ncwhRgEORiUe3oSz3pFCrIllxZW5hxglOZiURHk1I30ihfiS8lMqMxKLM+KLSnNS
        iw8xSnAwK4nw6qwCyvGmJFZWpRblw6SkOViUxHnVlqj7CQmkJ5akZqemFqQWwWRlODiUJHhb
        dgM1ChalpqdWpGXmlCCkmTg4QYbzAA332AwyvLggMbc4Mx0if4pRUUqcdwNIswBIIqM0D64X
        lhReMYoDvSLMmwhSxQNMKHDdr4AGMwENnrEGbHBJIkJKqoFRcXN/WNh1p4McdWuVjR+2BbLE
        1cr8XXz6duhWqXubz1icEJKS4F6YMGfJwWmSTOtWGx75LmR5I+t4Dl/sNOa3XzZEbJyZ+Kno
        5O07m6aXpVyYkGLdFTuxpXKax8n8aY0vvvg4qa3tfflyq7ps9Tb5m/O5V+wsM+tsObNgSV0i
        A3P+NM4ZYqfMlFiKMxINtZiLihMBtth8veUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That way the callers don't have to come up with error messages
themselves.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c  |  6 ++----
 refs/packed-backend.c | 17 +++++++++++------
 refs/packed-backend.h |  6 +++---
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 88de907148..8ea4e9ab05 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1096,7 +1096,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	struct ref_to_prune *refs_to_prune = NULL;
 	struct strbuf err = STRBUF_INIT;
 
-	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR);
+	packed_refs_lock(refs->packed_ref_store, LOCK_DIE_ON_ERROR, &err);
 
 	iter = cache_ref_iterator_begin(get_loose_ref_cache(refs), NULL, 0);
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
@@ -2679,9 +2679,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (packed_refs_lock(refs->packed_ref_store, 0)) {
-		strbuf_addf(err, "unable to lock packed-refs file: %s",
-			    strerror(errno));
+	if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index cd214e07a1..78e877a9e3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -515,7 +515,7 @@ static int write_packed_entry(FILE *fh, const char *refname,
 	return 0;
 }
 
-int packed_refs_lock(struct ref_store *ref_store, int flags)
+int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 {
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
@@ -537,9 +537,15 @@ int packed_refs_lock(struct ref_store *ref_store, int flags)
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0 ||
-	    close_lock_file(&refs->lock))
+			    flags, timeout_value) < 0) {
+		unable_to_lock_message(refs->path, errno, err);
+		return -1;
+	}
+
+	if (close_lock_file(&refs->lock)) {
+		strbuf_addf(err, "unable to close %s: %s", refs->path, strerror(errno));
 		return -1;
+	}
 
 	/*
 	 * Now that we hold the `packed-refs` lock, make sure that our
@@ -698,10 +704,9 @@ int repack_without_refs(struct ref_store *ref_store,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (packed_refs_lock(&refs->base, 0)) {
-		unable_to_lock_message(refs->path, errno, err);
+	if (packed_refs_lock(&refs->base, 0, err))
 		return -1;
-	}
+
 	packed = get_packed_refs(refs);
 
 	/* Remove refnames from the cache */
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index dbc00d3396..210e3f35ce 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -6,10 +6,10 @@ struct ref_store *packed_ref_store_create(const char *path,
 
 /*
  * Lock the packed-refs file for writing. Flags is passed to
- * hold_lock_file_for_update(). Return 0 on success. On errors, set
- * errno appropriately and return a nonzero value.
+ * hold_lock_file_for_update(). Return 0 on success. On errors, write
+ * an error message to `err` and return a nonzero value.
  */
-int packed_refs_lock(struct ref_store *ref_store, int flags);
+int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err);
 
 void add_packed_ref(struct ref_store *ref_store,
 		    const char *refname, const struct object_id *oid);
-- 
2.11.0

