Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5922023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934732AbdEVOTG (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:06 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42984 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934555AbdEVOS7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:59 -0400
X-AuditID: 12074413-0c9ff70000001dc3-ea-5922f34f30b8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id BB.20.07619.053F2295; Mon, 22 May 2017 10:18:56 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24T023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 20/25] read_packed_refs(): do more of the work of reading packed refs
Date:   Mon, 22 May 2017 16:17:50 +0200
Message-Id: <014fce73da7def59605e55e113d05802d4e219ff.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqBvwWSnSYMEKXou1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXRtv1o6wFe+Qq
        zryew9bA2C/ZxcjJISFgIrFm7wbGLkYuDiGBHUwSi5/fYwNJCAmcYpK4sjEFxGYT0JVY1NPM
        BGKLCKhJTGw7xALSwCywgVnizfTVYAlhgQiJ7oXTGUFsFgFViTUvH7OA2LwCURI3Np5kgtgm
        L7Gr7SIriM0pYCHxe9YBJohl5hK9/1azTGDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI
        11wvN7NELzWldBMjJBCFdzDuOil3iFGAg1GJh1fjsVKkEGtiWXFl7iFGSQ4mJVHeo2+AQnxJ
        +SmVGYnFGfFFpTmpxYcYJTiYlUR4te8C5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NT
        C1KLYLIyHBxKErx6n4AaBYtS01Mr0jJzShDSTBycIMN5gIav+QAyvLggMbc4Mx0if4pRUUqc
        dwdIQgAkkVGaB9cLSxSvGMWBXhHmLQRZwQNMMnDdr4AGMwENtn4mDzK4JBEhJdXAqNfHcYxh
        ici6i5GrXOXaD28+yNFjcJfrvnrW6lvXWaP7hUz1grVEzSwOfROyrBD4si+//H/rvN8Zmo4T
        xGzfmk/U+lloLD31dlum+Oaz21LktFQ+CCxZ9+hSuZM4l2JOmnLbIt7Q+femfoib77h3+e5v
        sbNqFv3V15+j/vjZ/fUPHvGJZYT6KrEUZyQaajEXFScCABOBupPvAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach `read_packed_refs()` to also

* Allocate and initialize the new `packed_ref_cache`
* Open and close the `packed-refs` file
* Update the `validity` field of the new object

This decreases the coupling between `packed_refs_cache` and
`files_ref_store` by a little bit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 40 ++++++++++++++++++++++++----------------
 refs/ref-cache.h     |  3 ++-
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index c4bc9550d3..b4fa745cd7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -209,7 +209,9 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 }
 
 /*
- * Read f, which is a packed-refs file, into dir.
+ * Read from `packed_refs_file` into a newly-allocated
+ * `packed_ref_cache` and return it. The return value will already
+ * have its reference count incremented.
  *
  * A comment line of the form "# pack-refs with: " may contain zero or
  * more traits. We interpret the traits as follows:
@@ -235,12 +237,26 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
  *      compatibility with older clients, but we do not require it
  *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
  */
-static void read_packed_refs(FILE *f, struct ref_dir *dir)
+static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 {
+	FILE *f;
+	struct packed_ref_cache *packed_refs = xcalloc(1, sizeof(*packed_refs));
 	struct ref_entry *last = NULL;
 	struct strbuf line = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
+	struct ref_dir *dir;
 
+	acquire_packed_ref_cache(packed_refs);
+	packed_refs->cache = create_ref_cache(NULL, NULL);
+	packed_refs->cache->root->flag &= ~REF_INCOMPLETE;
+
+	f = fopen(packed_refs_file, "r");
+	if (!f)
+		return packed_refs;
+
+	stat_validity_update(&packed_refs->validity, fileno(f));
+
+	dir = get_ref_dir(packed_refs->cache->root);
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
 		struct object_id oid;
 		const char *refname;
@@ -287,7 +303,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		}
 	}
 
+	fclose(f);
 	strbuf_release(&line);
+
+	return packed_refs;
 }
 
 static const char *files_packed_refs_path(struct files_ref_store *refs)
@@ -357,20 +376,9 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
 		clear_packed_ref_cache(refs);
 
-	if (!refs->packed) {
-		FILE *f;
-
-		refs->packed = xcalloc(1, sizeof(*refs->packed));
-		acquire_packed_ref_cache(refs->packed);
-		refs->packed->cache = create_ref_cache(&refs->base, NULL);
-		refs->packed->cache->root->flag &= ~REF_INCOMPLETE;
-		f = fopen(packed_refs_file, "r");
-		if (f) {
-			stat_validity_update(&refs->packed->validity, fileno(f));
-			read_packed_refs(f, get_ref_dir(refs->packed->cache->root));
-			fclose(f);
-		}
-	}
+	if (!refs->packed)
+		refs->packed = read_packed_refs(packed_refs_file);
+
 	return refs->packed;
 }
 
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 1f65e2f9ed..fbfee7ce79 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -194,7 +194,8 @@ struct ref_entry *create_ref_entry(const char *refname,
  * function called to fill in incomplete directories in the
  * `ref_cache` when they are accessed. If it is NULL, then the whole
  * `ref_cache` must be filled (including clearing its directories'
- * `REF_INCOMPLETE` bits) before it is used.
+ * `REF_INCOMPLETE` bits) before it is used, and `refs` can be NULL,
+ * too.
  */
 struct ref_cache *create_ref_cache(struct ref_store *refs,
 				   fill_ref_dir_fn *fill_ref_dir);
-- 
2.11.0

