Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA6DA20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbdFWHCP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:15 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50046 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754563AbdFWHCO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:14 -0400
X-AuditID: 1207440d-3e9ff70000001be7-2c-594cbcf27605
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 19.51.07143.2FCBC495; Fri, 23 Jun 2017 03:02:10 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5q001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:08 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/29] validate_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:25 +0200
Message-Id: <03799b6a25a81624e9cdd8133b7f3a73e0ca3ffa.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqPtpj0+kwc/lNhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGVc3aFdMJW/4njPNtYGxg88XYyc
        HBICJhITzr1n72Lk4hAS2MEk8Wb9TCYI5xSTxNLJZ5hAqtgEdCUW9TSD2SICahIT2w6xgBQx
        C0xilnh7bSFYQlggRmL2lyXMIDaLgKrEtUU97CA2r0CUxN3Z+5kh1slL7Gq7yApicwpYSPRM
        XA5WIyRgLrHq92rWCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaUbmKE
        BB3vDsb/62QOMQpwMCrx8Cac9Y4UYk0sK67MPcQoycGkJMqrGekTKcSXlJ9SmZFYnBFfVJqT
        WnyIUYKDWUmEV2cVUI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHb
        shuoUbAoNT21Ii0zpwQhzcTBCTKcB2i4x2aQ4cUFibnFmekQ+VOMilLivBtAmgVAEhmleXC9
        sKTwilEc6BVh3kSQKh5gQoHrfgU0mAlo8Iw1YINLEhFSUg2Mpj5XouWPPPu6LLrv14EQbjl3
        czvHnLN8f/NLZivMlz0lfs1t8+pNSz3+r7j9+Jrbr6ca16+kOl+UV9s02XZW4p7Zfs4tFUmH
        Lb5MsmdO3/7hU/kSgdvqx/P3PXr53/ezlqOYounc30srDBSObg9MddXgfSoq4Ny+WaRCUPwT
        D9vasHpe3ox1SizFGYmGWsxFxYkAmSpkwuUCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2b0db60b2b..f061506bf0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -396,12 +396,11 @@ static void files_ref_path(struct files_ref_store *refs,
  * Check that the packed refs cache (if any) still reflects the
  * contents of the file. If not, clear the cache.
  */
-static void validate_packed_ref_cache(struct files_ref_store *refs)
+static void validate_packed_ref_cache(struct packed_ref_store *refs)
 {
-	if (refs->packed_ref_store->cache &&
-	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
-				 refs->packed_ref_store->path))
-		clear_packed_ref_cache(refs->packed_ref_store);
+	if (refs->cache &&
+	    !stat_validity_check(&refs->cache->validity, refs->path))
+		clear_packed_ref_cache(refs);
 }
 
 /*
@@ -417,7 +416,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	const char *packed_refs_file = refs->packed_ref_store->path;
 
 	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
-		validate_packed_ref_cache(refs);
+		validate_packed_ref_cache(refs->packed_ref_store);
 
 	if (!refs->packed_ref_store->cache)
 		refs->packed_ref_store->cache = read_packed_refs(packed_refs_file);
@@ -1364,7 +1363,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * cache is still valid. We've just locked the file, but it
 	 * might have changed the moment *before* we locked it.
 	 */
-	validate_packed_ref_cache(refs);
+	validate_packed_ref_cache(refs->packed_ref_store);
 
 	packed_ref_cache = get_packed_ref_cache(refs);
 	/* Increment the reference count to prevent it from being freed: */
-- 
2.11.0

