Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C2EC20209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdGAScH (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:07 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45228 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752089AbdGAScF (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:05 -0400
X-AuditID: 12074412-b7fff70000000fed-d3-5957ea9a736c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DD.65.04077.A9AE7595; Sat,  1 Jul 2017 14:31:54 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBU010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:52 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/30] packed_ref_store: support iteration
Date:   Sat,  1 Jul 2017 20:30:55 +0200
Message-Id: <34acfb1986a79d847ed1a978e495b91ac4bb2273.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqDvrVXikwbmlohZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGXcfLaDveCXZsX0C70sDYyHlboY
        OTkkBEwkJv0+wQpiCwnsYJKY3VzaxcgFZJ9kkni1awYbSIJNQFdiUU8zE4gtIqAmMbHtEAtI
        EbPAJGaJt9cWgiWEBWwlXp+5xQ5iswioSqx4cJEZxOYViJLY9u86G8Q2eYldbRfBtnEKWEj8
        aVvPDLHZXKL5YB/LBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFC
        gk5oB+P6k3KHGAU4GJV4eDeEhEUKsSaWFVfmHmKU5GBSEuVdeS00UogvKT+lMiOxOCO+qDQn
        tfgQowQHs5IIb+7z8Egh3pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ
        3kkvgRoFi1LTUyvSMnNKENJMHJwgw3mAhi+8CzK8uCAxtzgzHSJ/ilGX49WE/9+YhFjy8vNS
        pcR5W0EGCYAUZZTmwc2BJYtXjOJAbwnzMgBThxAPMNHATXoFtIQJaInwjBCQJSWJCCmpBkY7
        kXfmf57ZO3e8njy9RDMkUdlM0WH61HPf2KSEM9RPvdh13Kt9wV1Hj+O3Pkwp/vvuiDHL3udv
        Hx5T6Pt7Wk3LrN53seWBnxWZzVunV96wZLLlnL+z/4Pk9ZX5+1I2n1pZ2fHrvNvWJR8N9tSw
        +HCv7/6/+pDLjq8rqnwa3p0Rf3Q9+JVRoHCzEktxRqKhFnNRcSIArYknufECAAA=
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
 refs/files-backend.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 185d05e1d6..0490cc087e 100644
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
@@ -1160,18 +1251,28 @@ static struct ref_iterator *files_ref_iterator_begin(
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
+	/*
+	 * The packed-refs file might contain broken references, for
+	 * example an old version of a reference that points at an
+	 * object that has since been garbage-collected. This is OK as
+	 * long as there is a corresponding loose reference that
+	 * overrides it, and we don't want to emit an error message in
+	 * this case. So ask the packed_ref_store for all of its
+	 * references, and (if needed) do our own check for broken
+	 * ones in files_ref_iterator_advance(), after we have merged
+	 * the packed and loose references.
+	 */
+	packed_iter = packed_ref_iterator_begin(
+			refs->packed_ref_store, prefix,
+			DO_FOR_EACH_INCLUDE_BROKEN);
 
 	iter->iter0 = overlay_ref_iterator_begin(loose_iter, packed_iter);
 	iter->flags = flags;
-- 
2.11.0

