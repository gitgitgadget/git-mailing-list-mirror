Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E8320209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdGASbi (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:31:38 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:61225 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751919AbdGASbg (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:31:36 -0400
X-AuditID: 1207440d-e95ff70000000a46-62-5957ea878f43
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 1F.E6.02630.78AE7595; Sat,  1 Jul 2017 14:31:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBM010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:31:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 09/30] get_packed_refs(): take a `packed_ref_store *` parameter
Date:   Sat,  1 Jul 2017 20:30:47 +0200
Message-Id: <e70fdafcf5d2d8b46985c7251ad1509423725a60.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsUixO6iqNv+KjzSYN9tJYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDL+tp5hL1jKX/F/+RuWBsZO3i5G
        Tg4JAROJF30nmLsYuTiEBHYwSew9toQNwjnJJLHhyXc2kCo2AV2JRT3NTCC2iICaxMS2Qywg
        RcwCk5gl3l5bCJYQFgiSWHbwGlgDi4CqxK/3sxlBbF6BKIk7r46zQ6yTl9jVdpEVxOYUsJD4
        07aeGcQWEjCXaD7YxzKBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJN
        jJCw493B+H+dzCFGAQ5GJR7eDSFhkUKsiWXFlbmHGCU5mJREeVdeC40U4kvKT6nMSCzOiC8q
        zUktPsQowcGsJMKb+zw8Uog3JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8Gh
        JME76SVQo2BRanpqRVpmTglCmomDE2Q4D9DwhXdBhhcXJOYWZ6ZD5E8x6nK8mvD/G5MQS15+
        XqqUOG8ryCABkKKM0jy4ObB08YpRHOgtYd6IF0BVPMBUAzfpFdASJqAlwjNCQJaUJCKkpBoY
        5y8ynXhv9V3hh3qyFWd0Vqqvm8s0t6O9b3HTk/N313eKssQz/N56IDLo9t7+14cfdC870vs2
        X37WlpNX7stsOVCv+bDT91G2skHdlyN83gejNR0YOt8lTqrdsOHebEHDoItyK62yfXnF7U31
        z0xLOrjh8IZFddV7mL74Bt15mjiHMci0eXZ7qRJLcUaioRZzUXEiAEf1AwLyAgAA
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

