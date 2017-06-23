Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9EE20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754184AbdFWHDT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:03:19 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62611 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754660AbdFWHCf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:35 -0400
X-AuditID: 1207440e-8bfff70000006f9a-d7-594cbd04e543
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 96.F0.28570.40DBC495; Fri, 23 Jun 2017 03:02:28 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o60001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:26 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/29] repack_without_refs(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:33 +0200
Message-Id: <995a460dc1adbea187da842e0e52507afc05b52f.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqMuy1yfSoO2ZocXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBlL3jxnLlgvXnHjyH6mBsapwl2M
        nBwSAiYSL59PY+5i5OIQEtjBJLHh0TwWCOcUk8SPRVdYQKrYBHQlFvU0M4HYIgJqEhPbDoEV
        MQtMYpZ4e20hUIKDQ1ggTKL5Rz5IDYuAqsTRvjOMIDavQJTEozurmCC2yUvsarvICmJzClhI
        9Exczg5iCwmYS6z6vZp1AiPPAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6xnq5mSV6qSml
        mxghQce3g7F9vcwhRgEORiUe3h3nvSOFWBPLiitzDzFKcjApifJqRvpECvEl5adUZiQWZ8QX
        leakFh9ilOBgVhLh1VkFlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAo
        SfC27AZqFCxKTU+tSMvMKUFIM3FwggznARrusRlkeHFBYm5xZjpE/hSjopQ47waQZgGQREZp
        HlwvLCm8YhQHekWYNxGkigeYUOC6XwENZgIaPGMN2OCSRISUVANjystNh9/6ch0U+z/542W+
        WYvK1ttfqK5gN7s8RTig9Z7j/ouLYt3vLDL4ZXXwbv+0qFUfdpxtNVBM61VoLdcW2MQyuZqv
        Veb+20kn7j+Y4qWf5J0hdvvju9tyj388ubqLcfpm7vsMXxaFSG+ZGNFQOUOIde2JP4+8PN+H
        7szxLHx2hMt8/9ePnEosxRmJhlrMRcWJAPh9bBLlAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2b9d93d3b6..c206791b91 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1621,19 +1621,19 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
-static int repack_without_refs(struct files_ref_store *refs,
+static int repack_without_refs(struct packed_ref_store *refs,
 			       struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
-	files_assert_main_repository(refs, "repack_without_refs");
+	packed_assert_main_repository(refs, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refs->packed_ref_store, refname->string)) {
+		if (get_packed_ref(refs, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
@@ -1643,11 +1643,11 @@ static int repack_without_refs(struct files_ref_store *refs,
 	if (!needs_repacking)
 		return 0; /* no refname exists in packed refs */
 
-	if (lock_packed_refs(refs->packed_ref_store, 0)) {
-		unable_to_lock_message(refs->packed_ref_store->path, errno, err);
+	if (lock_packed_refs(refs, 0)) {
+		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}
-	packed = get_packed_refs(refs->packed_ref_store);
+	packed = get_packed_refs(refs);
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
@@ -1658,12 +1658,12 @@ static int repack_without_refs(struct files_ref_store *refs,
 		 * All packed entries disappeared while we were
 		 * acquiring the lock.
 		 */
-		rollback_packed_refs(refs->packed_ref_store);
+		rollback_packed_refs(refs);
 		return 0;
 	}
 
 	/* Write what remains */
-	ret = commit_packed_refs(refs->packed_ref_store);
+	ret = commit_packed_refs(refs);
 	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
@@ -1681,7 +1681,7 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 	if (!refnames->nr)
 		return 0;
 
-	result = repack_without_refs(refs, refnames, &err);
+	result = repack_without_refs(refs->packed_ref_store, refnames, &err);
 	if (result) {
 		/*
 		 * If we failed to rewrite the packed-refs file, then
@@ -3101,7 +3101,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		}
 	}
 
-	if (repack_without_refs(refs, &refs_to_delete, err)) {
+	if (repack_without_refs(refs->packed_ref_store, &refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-- 
2.11.0

