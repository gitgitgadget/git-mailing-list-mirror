Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CCAF20401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbdFWHCe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:02:34 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50343 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754650AbdFWHC1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:27 -0400
X-AuditID: 1207440f-b81ff7000000740c-a6-594cbd02ae58
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.EF.29708.20DBC495; Fri, 23 Jun 2017 03:02:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o5x001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:24 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 14/29] get_packed_ref(): take a `packed_ref_store *` parameter
Date:   Fri, 23 Jun 2017 09:01:32 +0200
Message-Id: <8d1581056e406231f52379643df1c7f653553aee.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsUixO6iqMu01yfS4Md1WYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJOz3zDUrCKv+LG3JfMDYzHeboY
        OTkkBEwkFi/4y9rFyMUhJLCDSeLj0g1MEM4pJok3d/awgFSxCehKLOppZgKxRQTUJCa2HWIB
        KWIWmMQs8fbaQrCEsECgxJ+f/cwgNouAqsTX9W/A4rwCURI9azayQKyTl9jVdpEVxOYUsJDo
        mbicHcQWEjCXWPV7NesERp4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3
        MULCjn8HY9d6mUOMAhyMSjy8CWe9I4VYE8uKK3MPMUpyMCmJ8mpG+kQK8SXlp1RmJBZnxBeV
        5qQWH2KU4GBWEuHVWQWU401JrKxKLcqHSUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ
        8HbuAWoULEpNT61Iy8wpQUgzcXCCDOcBGu6xGWR4cUFibnFmOkT+FKOilDjvht1ACQGQREZp
        HlwvLC28YhQHekWYNxGkigeYUuC6XwENZgIaPGMN2OCSRISUVANjpdOqqHypu1slg873nT7c
        abnAkXtF+NNVO9OSfhn9dZj/f5XOP80fuju0p00JN4pgNd19YDMH18mcqG0pZ8S+zl9zfefl
        Iw/PXpukzfNGkf+Npk3g6+aTSZHzQhP/1VyUaJ57w6q/yMPb/9I075NhL2PkJaWuchiYiNsX
        5Kgbf51w9KTlk69hSizFGYmGWsxFxYkAjmgh4eYCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a08d3fbadf..2b9d93d3b6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -602,10 +602,10 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
  * Return the ref_entry for the given refname from the packed
  * references.  If it does not exist, return NULL.
  */
-static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
+static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
 					const char *refname)
 {
-	return find_ref_entry(get_packed_refs(refs->packed_ref_store), refname);
+	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
 /*
@@ -621,7 +621,7 @@ static int resolve_packed_ref(struct files_ref_store *refs,
 	 * The loose reference file does not exist; check for a packed
 	 * reference.
 	 */
-	entry = get_packed_ref(refs, refname);
+	entry = get_packed_ref(refs->packed_ref_store, refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.oid.hash);
 		*flags |= REF_ISPACKED;
@@ -1044,7 +1044,9 @@ static int files_peel_ref(struct ref_store *ref_store,
 	 * have REF_KNOWS_PEELED.
 	 */
 	if (flag & REF_ISPACKED) {
-		struct ref_entry *r = get_packed_ref(refs, refname);
+		struct ref_entry *r =
+			get_packed_ref(refs->packed_ref_store, refname);
+
 		if (r) {
 			if (peel_entry(r, 0))
 				return -1;
@@ -1631,7 +1633,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 
 	/* Look for a packed ref */
 	for_each_string_list_item(refname, refnames) {
-		if (get_packed_ref(refs, refname->string)) {
+		if (get_packed_ref(refs->packed_ref_store, refname->string)) {
 			needs_repacking = 1;
 			break;
 		}
-- 
2.11.0

