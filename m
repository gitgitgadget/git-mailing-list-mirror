Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3462023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbdEVOTA (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:00 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44009 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934694AbdEVOSv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:18:51 -0400
X-AuditID: 12074412-a4fff70000003a21-f7-5922f34315f9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.77.14881.343F2295; Mon, 22 May 2017 10:18:43 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24O023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:41 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/25] ref_update_reject_duplicates(): expose function to whole refs module
Date:   Mon, 22 May 2017 16:17:45 +0200
Message-Id: <42b26d23a71f932e14727066139b32d905ec53c6.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqOv8WSnS4M4xc4u1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxu6FKQW3RCpe
        HljF2MC4VaCLkZNDQsBE4uueo6wgtpDADiaJI0ujuhi5gOxTTBJ75z5nBkmwCehKLOppZgKx
        RQTUJCa2HWIBKWIW2MAs8Wb6arCEsECcxJr2R+wgNouAqsT0FW1gU3kFoiR+nXvDCLFNXmJX
        20WwOKeAhcTvWQeYIDabS/T+W80ygZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73c
        zBK91JTSTYyQMBTawbj+pNwhRgEORiUe3oanSpFCrIllxZW5hxglOZiURHmPvgEK8SXlp1Rm
        JBZnxBeV5qQWH2KU4GBWEuHVvguU401JrKxKLcqHSUlzsCiJ8/5crO4nJJCeWJKanZpakFoE
        k5Xh4FCS4NX7BNQoWJSanlqRlplTgpBm4uAEGc4DNHzNB5DhxQWJucWZ6RD5U4yKUuK8BiDN
        AiCJjNI8uF5YmnjFKA70ijBvIUgVDzDFwHW/AhrMBDTY+pk8yOCSRISUVANj1s7/ov/dLRlK
        lt1+XDAnQiY17DJnCWPQT9XTV/mSlx6d8LH/uply87/Hs1+sX33T7ItptBKfOmvs+h+5L3nv
        1Fs4VAhVxmz77xsSrxKolnTFp5l9qvLnew57GI9y126K6Th479r15ZnzU6ZOtJr0L2qCgnrI
        cxsXsVs315Za137e4n15bWSZEktxRqKhFnNRcSIAHR99Su4CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It will soon have some other users.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 17 +++++++++++++++++
 refs/files-backend.c | 17 -----------------
 refs/refs-internal.h |  8 ++++++++
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/refs.c b/refs.c
index b3860a9e33..beb49fb297 100644
--- a/refs.c
+++ b/refs.c
@@ -1702,6 +1702,23 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 				  refs_heads_master, logmsg);
 }
 
+int ref_update_reject_duplicates(struct string_list *refnames,
+				 struct strbuf *err)
+{
+	int i, n = refnames->nr;
+
+	assert(err);
+
+	for (i = 1; i < n; i++)
+		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
+			strbuf_addf(err,
+				    "multiple updates for ref '%s' not allowed.",
+				    refnames->items[i].string);
+			return 1;
+		}
+	return 0;
+}
+
 int ref_transaction_prepare(struct ref_transaction *transaction,
 			    struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 19842d2e56..8d0ce739a6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2512,23 +2512,6 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	return ref_iterator;
 }
 
-static int ref_update_reject_duplicates(struct string_list *refnames,
-					struct strbuf *err)
-{
-	int i, n = refnames->nr;
-
-	assert(err);
-
-	for (i = 1; i < n; i++)
-		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
-			strbuf_addf(err,
-				    "multiple updates for ref '%s' not allowed.",
-				    refnames->items[i].string);
-			return 1;
-		}
-	return 0;
-}
-
 /*
  * If update is a direct update of head_ref (the reference pointed to
  * by HEAD), then add an extra REF_LOG_ONLY update for HEAD.
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4d3dd17f9f..192f9f85c9 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -169,6 +169,14 @@ int refs_read_raw_ref(struct ref_store *ref_store,
 		      const char *refname, unsigned char *sha1,
 		      struct strbuf *referent, unsigned int *type);
 
+/*
+ * Write an error to `err` and return a nonzero value iff the same
+ * refname appears multiple times in `refnames`. `refnames` must be
+ * sorted on entry to this function.
+ */
+int ref_update_reject_duplicates(struct string_list *refnames,
+				 struct strbuf *err);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
-- 
2.11.0

