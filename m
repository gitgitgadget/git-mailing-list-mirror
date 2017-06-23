Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7919320401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbdFWHC1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:27 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59222 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754632AbdFWHCZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:25 -0400
X-AuditID: 12074412-b97ff70000000fed-46-594cbd0053b3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 35.9F.04077.00DBC495; Fri, 23 Jun 2017 03:02:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5w001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/29] rollback_packed_refs(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:31 +0200
Message-Id: <4e46e49b074730bc9d098d7448fc7601bbfa26f2.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqMuw1yfS4NEdXou1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJOn1jGVnCYt2LJ/WXMDYzHubsY
        OTkkBEwkJjV9YOti5OIQEtjBJLH4yBYmCOcUk8S2A5+ZQKrYBHQlFvU0g9kiAmoSE9sOsYAU
        MQtMYpZ4e20hWEJYIFxiWeNEZhCbRUBV4uSuP2A2r0CUxNwPv5gg1slL7Gq7yApicwpYSPRM
        XM4OYgsJmEus+r2adQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsY
        IWEntINx/Um5Q4wCHIxKPLwJZ70jhVgTy4orcw8xSnIwKYnyakb6RArxJeWnVGYkFmfEF5Xm
        pBYfYpTgYFYS4dVZBZTjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLg
        bdkN1ChYlJqeWpGWmVOCkGbi4AQZzgM03GMzyPDigsTc4sx0iPwpRkUpcd4NIM0CIImM0jy4
        XlhaeMUoDvSKMG8iSBUPMKXAdb8CGswENHjGGrDBJYkIKakGxp16ylfvNeb56/vt3so7z+lt
        0P/1m/S/R7zsnPTcZldsG/vk5D2z37b6V/HLL+6Y8/vfpSd/iqY9WHTp4Mt97Fc2boic95DT
        r23H28rO3Qae+lMmmvZvV+Tx02jZNHnaWp/61cfe6DTYLFDtK7YSCd7/Juar7CGfPGFRtYrN
        a+weFXzfuMVUSlWJpTgj0VCLuag4EQARyAmf5gIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5d159620f0..a08d3fbadf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1434,18 +1434,17 @@ static int commit_packed_refs(struct packed_ref_store *refs)
  * in-memory packed reference cache.  (The packed-refs file will be
  * read anew if it is needed again after this function is called.)
  */
-static void rollback_packed_refs(struct files_ref_store *refs)
+static void rollback_packed_refs(struct packed_ref_store *refs)
 {
-	struct packed_ref_cache *packed_ref_cache =
-		get_packed_ref_cache(refs->packed_ref_store);
+	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
-	files_assert_main_repository(refs, "rollback_packed_refs");
+	packed_assert_main_repository(refs, "rollback_packed_refs");
 
-	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
+	if (!is_lock_file_locked(&refs->lock))
 		die("BUG: packed-refs not locked");
-	rollback_lock_file(&refs->packed_ref_store->lock);
+	rollback_lock_file(&refs->lock);
 	release_packed_ref_cache(packed_ref_cache);
-	clear_packed_ref_cache(refs->packed_ref_store);
+	clear_packed_ref_cache(refs);
 }
 
 struct ref_to_prune {
@@ -1657,7 +1656,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_packed_refs(refs);
+		rollback_packed_refs(refs->packed_ref_store);
 		return 0;
 	}
 
-- 
2.11.0

