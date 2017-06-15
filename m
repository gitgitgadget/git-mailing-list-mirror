Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8246B20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbdFOOtF (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:49:05 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58201 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752627AbdFOOr7 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:47:59 -0400
X-AuditID: 12074412-431ff70000001956-93-59429e1862ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 99.D6.06486.81E92495; Thu, 15 Jun 2017 10:47:53 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbQx014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:50 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 05/28] clear_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:10 +0200
Message-Id: <3d7e45d0f1b725f20d15835304a576f9a7629c0a.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqCs5zynSYPZuLou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDIOz9zEXDCPr+LOytNMDYyTeboY
        OTkkBEwkdjfNZeli5OIQEtjBJDFx6SMmCOckk8Ss7e+ZQKrYBHQlFvU0g9kiAmoSE9sOgXUw
        C0xilnh7bSFYQlggTGLi8z1gNouAqsSfj4eYQWxegSiJ51/esUGsk5fY1XaRFcTmFLCQmP1l
        HVANB9A2c4ljyzUmMPIsYGRYxSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrppebWaKXmlK6iRES
        dEI7GNeflDvEKMDBqMTDe6LWKVKINbGsuDL3EKMkB5OSKC+/HFCILyk/pTIjsTgjvqg0J7X4
        EKMEB7OSCO/UOUA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJXuO5
        QI2CRanpqRVpmTklCGkmDk6Q4TxAw/+CDS8uSMwtzkyHyJ9iVJQS5/UASQiAJDJK8+B6YUnh
        FaM40CvCvPNAqniACQWu+xXQYCagwUEXHEAGlyQipKQaGNvNXgn+6Jtfcv75s7Sb6zq2vcpr
        mnrI4MuVbV9fBm1/zZ66+ZaCml1oapGa7vr7ZXJrmLzVUu0XyfxfeXvlzArRP3s88iad6Vwz
        rSL0+e5mK831F49//5ywWoit8SWT3bwVgTeXqFS8Od2t9KDsf1L45p3evHtOPXxxWF+DcZbI
        NYngXV7rDfcosRRnJBpqMRcVJwIABIM8AuUCAAA=
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

