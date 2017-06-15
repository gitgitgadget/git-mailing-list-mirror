Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96D4D20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbdFOOsT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:19 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51694 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752666AbdFOOsS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:18 -0400
X-AuditID: 1207440f-353ff7000000102d-9f-59429e308a09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.F5.04141.03E92495; Thu, 15 Jun 2017 10:48:16 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRA014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:15 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/28] packed_ref_store: support iteration
Date:   Thu, 15 Jun 2017 16:47:21 +0200
Message-Id: <ca6b06eb7071305e5ddbd3803263285ca89785b3.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqGswzynS4GqbjcXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBkX1q1mL9igWrGr9TFbA+MPuS5G
        Tg4JAROJ2x82MoHYQgI7mCTuL67rYuQCsk8ySWx6tJcVJMEmoCuxqKcZrEhEQE1iYtshFpAi
        ZoFJzBJvry0ESwgLWEm83fGIHcRmEVCVeHnsP5jNKxAl0X1gMxvENnmJXW0XwYZyClhIzP6y
        jrmLkQNom7nEseUaExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQI
        CTn+HYxd62UOMQpwMCrx8Co0OEUKsSaWFVfmHmKU5GBSEuXllwMK8SXlp1RmJBZnxBeV5qQW
        H2KU4GBWEuGdOgcox5uSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4N0G
        0ihYlJqeWpGWmVOCkGbi4AQZzgM0/C/Y8OKCxNzizHSI/ClGRSlxXg+QhABIIqM0D64XlhJe
        MYoDvSLM+wWkigeYTuC6XwENZgIaHHTBAWRwSSJCSqqB0Xf7F4HECQcUTlfZND89dljH1WC3
        lVej1NrVoftbWIRTlkbpPInawnp2ZqKev1fV7ZYSu0c8onPOztJScv55U2zPBqbe0MeJXydH
        7bSc2iOjURrnterC7f4tLTZqv581T6p/sdRwi8Ne8YzsJe+++Yr7HdNYwdXV3O/0fyP/ppjO
        q7t7+Q5xK7EUZyQaajEXFScCAC5OOijkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the infrastructure to iterate over a `packed_ref_store`. It's a
lot of boilerplate, but it's all part of a campaign to make
`packed_ref_store` implement `ref_store`. In the future, this iterator
will work much differently.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 185d05e1d6..e57cdeba36 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1062,10 +1062,102 @@ static int files_peel_ref(struct ref_store *ref_store,
 	return peel_object(base, sha1);
 }
 
+struct packed_ref_iterator {
+	struct ref_iterator base;
+
+	struct packed_ref_cache *cache;
+	struct ref_iterator *iter0;
+	unsigned int flags;
+};
+
+static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
+{
+	struct packed_ref_iterator *iter =
+		(struct packed_ref_iterator *)ref_iterator;
+	int ok;
+
+	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
+		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
+		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
+			continue;
+
+		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
+		    !ref_resolves_to_object(iter->iter0->refname,
+					    iter->iter0->oid,
+					    iter->iter0->flags))
+			continue;
+
+		iter->base.refname = iter->iter0->refname;
+		iter->base.oid = iter->iter0->oid;
+		iter->base.flags = iter->iter0->flags;
+		return ITER_OK;
+	}
+
+	iter->iter0 = NULL;
+	if (ref_iterator_abort(ref_iterator) != ITER_DONE)
+		ok = ITER_ERROR;
+
+	return ok;
+}
+
+static int packed_ref_iterator_peel(struct ref_iterator *ref_iterator,
+				   struct object_id *peeled)
+{
+	struct packed_ref_iterator *iter =
+		(struct packed_ref_iterator *)ref_iterator;
+
+	return ref_iterator_peel(iter->iter0, peeled);
+}
+
+static int packed_ref_iterator_abort(struct ref_iterator *ref_iterator)
+{
+	struct packed_ref_iterator *iter =
+		(struct packed_ref_iterator *)ref_iterator;
+	int ok = ITER_DONE;
+
+	if (iter->iter0)
+		ok = ref_iterator_abort(iter->iter0);
+
+	release_packed_ref_cache(iter->cache);
+	base_ref_iterator_free(ref_iterator);
+	return ok;
+}
+
+static struct ref_iterator_vtable packed_ref_iterator_vtable = {
+	packed_ref_iterator_advance,
+	packed_ref_iterator_peel,
+	packed_ref_iterator_abort
+};
+
+static struct ref_iterator *packed_ref_iterator_begin(
+		struct packed_ref_store *refs,
+		const char *prefix, unsigned int flags)
+{
+	struct packed_ref_iterator *iter;
+	struct ref_iterator *ref_iterator;
+
+	iter = xcalloc(1, sizeof(*iter));
+	ref_iterator = &iter->base;
+	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable);
+
+	/*
+	 * Note that get_packed_ref_cache() internally checks whether
+	 * the packed-ref cache is up to date with what is on disk,
+	 * and re-reads it if not.
+	 */
+
+	iter->cache = get_packed_ref_cache(refs);
+	acquire_packed_ref_cache(iter->cache);
+	iter->iter0 = cache_ref_iterator_begin(iter->cache->cache, prefix, 0);
+
+	iter->flags = flags;
+
+	return ref_iterator;
+}
+
 struct files_ref_iterator {
 	struct ref_iterator base;
 
-	struct packed_ref_cache *packed_ref_cache;
 	struct ref_iterator *iter0;
 	unsigned int flags;
 };
@@ -1118,7 +1210,6 @@ static int files_ref_iterator_abort(struct ref_iterator *ref_iterator)
 	if (iter->iter0)
 		ok = ref_iterator_abort(iter->iter0);
 
-	release_packed_ref_cache(iter->packed_ref_cache);
 	base_ref_iterator_free(ref_iterator);
 	return ok;
 }
@@ -1160,18 +1251,16 @@ static struct ref_iterator *files_ref_iterator_begin(
 	 * (If they've already been read, that's OK; we only need to
 	 * guarantee that they're read before the packed refs, not
 	 * *how much* before.) After that, we call
-	 * get_packed_ref_cache(), which internally checks whether the
-	 * packed-ref cache is up to date with what is on disk, and
-	 * re-reads it if not.
+	 * packed_ref_iterator_begin(), which internally checks
+	 * whether the packed-ref cache is up to date with what is on
+	 * disk, and re-reads it if not.
 	 */
 
 	loose_iter = cache_ref_iterator_begin(get_loose_ref_cache(refs),
 					      prefix, 1);
 
-	iter->packed_ref_cache = get_packed_ref_cache(refs->packed_ref_store);
-	acquire_packed_ref_cache(iter->packed_ref_cache);
-	packed_iter = cache_ref_iterator_begin(iter->packed_ref_cache->cache,
-					       prefix, 0);
+	packed_iter = packed_ref_iterator_begin(refs->packed_ref_store,
+						prefix, 0);
 
 	iter->iter0 = overlay_ref_iterator_begin(loose_iter, packed_iter);
 	iter->flags = flags;
-- 
2.11.0

