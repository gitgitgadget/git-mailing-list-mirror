Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BAE20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbdGASbY (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:24 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:59121 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASbX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:23 -0400
X-AuditID: 1207440c-c4dff70000001e54-0a-5957ea7a16f1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id E4.2E.07764.A7AE7595; Sat,  1 Jul 2017 14:31:22 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBG010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:20 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/30] packed_ref_store: new struct
Date:   Sat,  1 Jul 2017 20:30:41 +0200
Message-Id: <ae5f4e2818ca8b184500bef5044900a4250bec3a.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqFv1KjzSYM8aMYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDI2nFjJXrBRumLdy1mMDYyvxboY
        OTgkBEwkntyp7GLk4hAS2MEk0TupixnCOckkMWvlNtYuRk4ONgFdiUU9zUwgtoiAmsTEtkMs
        IEXMApOYJd5eW8gEMklYwExi00x7kBoWAVWJ3s0ggzg5eAWiJH6cvcEIYksIyEvsarsINpNT
        wELiT9t6sBohAXOJ5oN9LBMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s0UtN
        Kd3ECAk5nh2M39bJHGIU4GBU4uHdEBIWKcSaWFZcmXuIUZKDSUmUd+W10EghvqT8lMqMxOKM
        +KLSnNTiQ4wSHMxKIry5z8MjhXhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIy
        HBxKErxMwNgSEixKTU+tSMvMKUFIM3FwggznARq+8C7I8OKCxNzizHSI/ClGXY5XE/5/YxJi
        ycvPS5US5219CVQkAFKUUZoHNweWKl4xigO9Jcwb8QKoigeYZuAmvQJawgS0RHhGCMiSkkSE
        lFQDo1/GvVef3TMy9uyfs+f0ZUaHoHu2iW2ZEjkvl7LJv/Ke9GRBHNNuQ87wBRe2d167cr5N
        Q1I18OnJBdxiiRWTPGZnrBc8dH7CosInS1wzb/e76OwNvGPxxPKW7S4po9Wshac4ne1f7nfw
        TpGqvCIo+3bTwzmPhJiafq09yOPZzblwp//FGbtdHJVYijMSDbWYi4oTATNOAh3wAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start extracting the packed-refs-related data structures into a new
class, `packed_ref_store`. It doesn't yet implement `ref_store`, but
it will.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 87cecde231..2efb71cee9 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -47,6 +47,28 @@ struct packed_ref_cache {
 	struct stat_validity validity;
 };
 
+/*
+ * A container for `packed-refs`-related data. It is not (yet) a
+ * `ref_store`.
+ */
+struct packed_ref_store {
+	unsigned int store_flags;
+
+	/*
+	 * A cache of the values read from the `packed-refs` file, if
+	 * it might still be current; otherwise, NULL.
+	 */
+	struct packed_ref_cache *cache;
+};
+
+static struct packed_ref_store *packed_ref_store_create(unsigned int store_flags)
+{
+	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
+
+	refs->store_flags = store_flags;
+	return refs;
+}
+
 /*
  * Future: need to be in "struct repository"
  * when doing a full libification.
@@ -60,13 +82,14 @@ struct files_ref_store {
 	char *packed_refs_path;
 
 	struct ref_cache *loose;
-	struct packed_ref_cache *packed;
 
 	/*
 	 * Lock used for the "packed-refs" file. Note that this (and
 	 * thus the enclosing `files_ref_store`) must not be freed.
 	 */
 	struct lock_file packed_refs_lock;
+
+	struct packed_ref_store *packed_ref_store;
 };
 
 /*
@@ -95,12 +118,12 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 
 static void clear_packed_ref_cache(struct files_ref_store *refs)
 {
-	if (refs->packed) {
-		struct packed_ref_cache *packed_refs = refs->packed;
+	if (refs->packed_ref_store->cache) {
+		struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
 
 		if (is_lock_file_locked(&refs->packed_refs_lock))
 			die("BUG: packed-ref cache cleared while locked");
-		refs->packed = NULL;
+		refs->packed_ref_store->cache = NULL;
 		release_packed_ref_cache(packed_refs);
 	}
 }
@@ -132,6 +155,7 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
 	refs->packed_refs_path = strbuf_detach(&sb, NULL);
+	refs->packed_ref_store = packed_ref_store_create(flags);
 
 	return ref_store;
 }
@@ -375,8 +399,8 @@ static void files_ref_path(struct files_ref_store *refs,
  */
 static void validate_packed_ref_cache(struct files_ref_store *refs)
 {
-	if (refs->packed &&
-	    !stat_validity_check(&refs->packed->validity,
+	if (refs->packed_ref_store->cache &&
+	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
 				 files_packed_refs_path(refs)))
 		clear_packed_ref_cache(refs);
 }
@@ -396,10 +420,10 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	if (!is_lock_file_locked(&refs->packed_refs_lock))
 		validate_packed_ref_cache(refs);
 
-	if (!refs->packed)
-		refs->packed = read_packed_refs(packed_refs_file);
+	if (!refs->packed_ref_store->cache)
+		refs->packed_ref_store->cache = read_packed_refs(packed_refs_file);
 
-	return refs->packed;
+	return refs->packed_ref_store->cache;
 }
 
 static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_cache)
-- 
2.11.0

