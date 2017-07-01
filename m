Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9AE020209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdGASbb (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:31 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45209 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASba (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:30 -0400
X-AuditID: 12074412-b7fff70000000fed-ba-5957ea80550c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DA.65.04077.08AE7595; Sat,  1 Jul 2017 14:31:28 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBJ010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:26 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 06/30] clear_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:44 +0200
Message-Id: <8f8c54b55ecbdea360263f5820dc54852bb96266.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNvwKjzSYMlsG4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDIOz9zEXDCPr+LOytNMDYyTeboY
        OTkkBEwkji+/zdzFyMUhJLCDSWLxm1eMEM5JJol/Ty+wg1SxCehKLOppZgKxRQTUJCa2HWIB
        KWIWmMQs8fbaQrCEsECkxO/efWA2i4CqxK+Hv9lAbF6BKIkNTfeYINbJS+xqu8gKYnMKWEj8
        aVvPDGILCZhLNB/sY5nAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukm
        RkjYCe1gXH9S7hCjAAejEg/vhpCwSCHWxLLiytxDjJIcTEqivCuvhUYK8SXlp1RmJBZnxBeV
        5qQWH2KU4GBWEuHNfR4eKcSbklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8Gh
        JME76SVQo2BRanpqRVpmTglCmomDE2Q4D9DwhXdBhhcXJOYWZ6ZD5E8x6nK8mvD/G5MQS15+
        XqqUOG8ryCABkKKM0jy4ObB08YpRHOgtYV4GYPIQ4gGmGrhJr4CWMAEtEZ4RArKkJBEhJdXA
        OP/Yj5vKTOsEA3x3/FotqfDx7Lnj6y0XpjjereLrTK7ZOiXYbZ9pnMmCZqacToUJItL35z/4
        9up+bOU29ZNf/Jwdp24RnjLRMUbOgFmop2FC6ctL01abKlcfFt9ZJH/v0WbTr38edv4Q2v1x
        ddB61vxJq7bsOHTuxI15uSus14gF8F6qrNz87owSS3FGoqEWc1FxIgAFMlDI8gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index de8293493f..2b0db60b2b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -120,15 +120,15 @@ static int release_packed_ref_cache(struct packed_ref_cache *packed_refs)
 	}
 }
 
-static void clear_packed_ref_cache(struct files_ref_store *refs)
+static void clear_packed_ref_cache(struct packed_ref_store *refs)
 {
-	if (refs->packed_ref_store->cache) {
-		struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
+	if (refs->cache) {
+		struct packed_ref_cache *cache = refs->cache;
 
-		if (is_lock_file_locked(&refs->packed_ref_store->lock))
+		if (is_lock_file_locked(&refs->lock))
 			die("BUG: packed-ref cache cleared while locked");
-		refs->packed_ref_store->cache = NULL;
-		release_packed_ref_cache(packed_refs);
+		refs->cache = NULL;
+		release_packed_ref_cache(cache);
 	}
 }
 
@@ -401,7 +401,7 @@ static void validate_packed_ref_cache(struct files_ref_store *refs)
 	if (refs->packed_ref_store->cache &&
 	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
 				 refs->packed_ref_store->path))
-		clear_packed_ref_cache(refs);
+		clear_packed_ref_cache(refs->packed_ref_store);
 }
 
 /*
@@ -1435,7 +1435,7 @@ static void rollback_packed_refs(struct files_ref_store *refs)
 		die("BUG: packed-refs not locked");
 	rollback_lock_file(&refs->packed_ref_store->lock);
 	release_packed_ref_cache(packed_ref_cache);
-	clear_packed_ref_cache(refs);
+	clear_packed_ref_cache(refs->packed_ref_store);
 }
 
 struct ref_to_prune {
-- 
2.11.0

