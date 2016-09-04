Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098DD1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbcIDQNR (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:17 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54601 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754533AbcIDQND (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:03 -0400
X-AuditID: 1207440d-bf7ff700000008af-0f-57cc47426b38
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 23.86.02223.2474CC75; Sun,  4 Sep 2016 12:09:38 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5k026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:36 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 24/38] repack_without_refs(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:30 +0200
Message-Id: <9aa0bb261d5e583fe2e2ea4cfeb4815c5267ee06.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqOvkfibc4OlXeYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGQv3nmUqeMJXceD/IrYGxk6eLkZO
        DgkBE4mfGxrZuxi5OIQEtjJK/Lx8hRXCOckk0d1wlg2kik1AV2JRTzMTiC0ioCYxse0QC0gR
        M0jRrIkz2UESwgL+EhdvTgNrYBFQlXi++RYjiM0rECWxY9VBJoh1chKXtn1hBrE5BSwkzuye
        C2RzAG0zl2h/kT2BkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3UlNJNjJCQ
        493B+H+dzCFGAQ5GJR5eC+0z4UKsiWXFlbmHGCU5mJREeWcdPBkuxJeUn1KZkVicEV9UmpNa
        fIhRgoNZSYRX2wWonDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwdvg
        CtQoWJSanlqRlplTgpBm4uAEGc4DNPwmSA1vcUFibnFmOkT+FKOilDhvCMhWAZBERmkeXC8s
        JbxiFAd6RZhX0Q2oigeYTuC6XwENZgIavG73aZDBJYkIKakGxoBglt3XV/79UX9zPcP24GuG
        PhsOpSnVTTn4586nmfdmrD/2Tz113Waze/ny3Mcl25dWhOzZLbUt5NOGVUlseziss06tFlg0
        6bXF1Rsex5RO772hX+3Pl3FzzlOdI2G9r7IviwWKzmP4/MFzm9rWokfO8fes727sMv97RlJs
        UcD1lJsvVMXZde4psRRnJBpqMRcVJwIAF8ppLuQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d43e0b..363f306 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2384,14 +2384,14 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
  *
  * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
  */
-static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
+static int repack_without_refs(struct files_ref_store *refs,
+			       struct string_list *refnames, struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "repack_without_refs");
 	struct ref_dir *packed;
 	struct string_list_item *refname;
 	int ret, needs_repacking = 0, removed = 0;
 
+	assert_main_repository(&refs->base, "repack_without_refs");
 	assert(err);
 
 	/* Look for a packed ref */
@@ -2453,13 +2453,15 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 
 int delete_refs(struct string_list *refnames, unsigned int flags)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "delete_refs");
 	struct strbuf err = STRBUF_INIT;
 	int i, result = 0;
 
 	if (!refnames->nr)
 		return 0;
 
-	result = repack_without_refs(refnames, &err);
+	result = repack_without_refs(refs, refnames, &err);
 	if (result) {
 		/*
 		 * If we failed to rewrite the packed-refs file, then
@@ -3779,7 +3781,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 		}
 	}
 
-	if (repack_without_refs(&refs_to_delete, err)) {
+	if (repack_without_refs(refs, &refs_to_delete, err)) {
 		ret = TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
 	}
-- 
2.9.3

