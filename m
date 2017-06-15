Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A256C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbdFOOsC (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:02 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56130 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752161AbdFOOsA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:00 -0400
X-AuditID: 12074414-d17ff7000000283f-8c-59429e1f1a8f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 57.C0.10303.F1E92495; Thu, 15 Jun 2017 10:47:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR2014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:57 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/28] get_packed_refs(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:13 +0200
Message-Id: <7581705d9afade88b663aaaa9451fd128c749b2a.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCs/zynS4MhzVYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDL+tp5hL1jKX/F/+RuWBsZO3i5G
        Tg4JAROJzotvWboYuTiEBHYwSVxb+BrKOckk0dawlBmkik1AV2JRTzMTiC0ioCYxse0QWBGz
        wCRmibfXFoIlhAX8JR5vOQpmswioSvTMXMrYxcjBwSsQJXGiB2qbvMSutousIDangIXE7C/r
        mEFKhATMJY4t15jAyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukmRkjI
        iexgPHJS7hCjAAejEg/viVqnSCHWxLLiytxDjJIcTEqivPxyQCG+pPyUyozE4oz4otKc1OJD
        jBIczEoivFPnAOV4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGanphakFsFkZTg4lCR4jecC
        NQoWpaanVqRl5pQgpJk4OEGG8wAN/ws2vLggMbc4Mx0if4pRUUqc1wMkIQCSyCjNg+uFpYRX
        jOJArwjzzgOp4gGmE7juV0CDmYAGB11wABlckoiQkmpgzH1w/tz2h9tPKyesrJbvvvP07/ty
        8zbpHNG6fTHTqy7s6H3D8zV0Na/FNOmu7Nm/TcR7z39a6Cp7p0rM/05De8itKE/xRME4zW2W
        mTYzn60+JrHIkONzanaF/8zWAJaP81K2vJq+abGIVUrR1vjou/mtLkod9bIPhdJqvj6SVbt0
        w85v/9ouJZbijERDLeai4kQADh/LIOQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b2ef7b3bb9..bc5c0de84e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -427,9 +427,9 @@ static struct ref_dir *get_packed_ref_dir(struct packed_ref_cache *packed_ref_ca
 	return get_ref_dir(packed_ref_cache->cache->root);
 }
 
-static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
+static struct ref_dir *get_packed_refs(struct packed_ref_store *refs)
 {
-	return get_packed_ref_dir(get_packed_ref_cache(refs->packed_ref_store));
+	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
 /*
@@ -450,7 +450,7 @@ static void add_packed_ref(struct files_ref_store *refs,
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 
-	packed_refs = get_packed_refs(refs);
+	packed_refs = get_packed_refs(refs->packed_ref_store);
 	packed_entry = find_ref_entry(packed_refs, refname);
 	if (packed_entry) {
 		/* Overwrite the existing entry: */
@@ -592,7 +592,7 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 					const char *refname)
 {
-	return find_ref_entry(get_packed_refs(refs), refname);
+	return find_ref_entry(get_packed_refs(refs->packed_ref_store), refname);
 }
 
 /*
@@ -1633,7 +1633,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		unable_to_lock_message(refs->packed_ref_store->path, errno, err);
 		return -1;
 	}
-	packed = get_packed_refs(refs);
+	packed = get_packed_refs(refs->packed_ref_store);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
-- 
2.11.0

