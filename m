Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 197332055E
	for <e@80x24.org>; Sun,  5 Nov 2017 08:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdKEImd (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 03:42:33 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49011 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752410AbdKEIma (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 03:42:30 -0500
X-AuditID: 1207440c-7e5ff7000000143e-79-59fecef4c55d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 93.48.05182.4FECEF95; Sun,  5 Nov 2017 03:42:29 -0500 (EST)
Received: from bagpipes.fritz.box (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA58gCCx018723
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 03:42:26 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 8/9] write_packed_entry(): take `object_id` arguments
Date:   Sun,  5 Nov 2017 09:42:08 +0100
Message-Id: <e397d73256373c319ff79b16ef5fb4a4813d8ff9.1509870243.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1509870243.git.mhagger@alum.mit.edu>
References: <cover.1509870243.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqPv13L9Ig7U7ZCy6rnQzWTT0XmG2
        +Pumi9Hi9or5zBZn3jQyOrB6/H3/gclj56y77B4XLyl7LH7g5fF5k1wAaxSXTUpqTmZZapG+
        XQJXxv2+i+wF+/gqpl04z97A+Jeri5GTQ0LAROL7uaPMXYxcHEICO5gk2vbsZ4NwTjBJbLrw
        hhWkik1AV2JRTzMTiC0ioCYxse0QC0gRs8BWRom/3c3MIAlhAQ+JZfPvgtksAqoSOw5cZAGx
        eQWiJA5c2soIsU5e4tyD22A1nAIWEn8+zmMDsYUEzCU+fdrJOoGRZwEjwypGucSc0lzd3MTM
        nOLUZN3i5MS8vNQiXUO93MwSvdSU0k2MkNDh2cH4bZ3MIUYBDkYlHt4THv8ihVgTy4orcw8x
        SnIwKYnyXnn5J1KILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/QYqBy3pTEyqrUonyYlDQHi5I4
        r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IE77WzQI2CRanpqRVpmTklCGkmDk6Q4TxAwx+D1PAW
        FyTmFmemQ+RPMRpzPJv5uoGZY9rV1iZmIZa8/LxUKXHeYyClAiClGaV5cNNg8f+KURzoOWFe
        eWAyEOIBpg64ea+AVjEBrZrN8QdkVUkiQkqqgbF0zhz+zIiehnPfrq89sSXpWP3O3eKKBcL1
        /hxRzocka53/vP6X9F0hrOzbBLFPhUra/PHFbLFZps+f87B6frWftyH2l6b2xl82TbKnUpMO
        X37hH/E2ZmXNQ1khYcuV5g68AvWuB3gM+QJ/3pF3sOPfVHqVQfNyfMOFiJ9TJOTDJ77suat5
        QomlOCPRUIu5qDgRAKFv0ZjaAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change `write_packed_entry()` to take `struct object_id *` rather than
`unsigned char *` arguments.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 74f1dea0f4..43ad74fc5a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -961,11 +961,11 @@ static struct ref_iterator *packed_ref_iterator_begin(
  * by the failing call to `fprintf()`.
  */
 static int write_packed_entry(FILE *fh, const char *refname,
-			      const unsigned char *sha1,
-			      const unsigned char *peeled)
+			      const struct object_id *oid,
+			      const struct object_id *peeled)
 {
-	if (fprintf(fh, "%s %s\n", sha1_to_hex(sha1), refname) < 0 ||
-	    (peeled && fprintf(fh, "^%s\n", sha1_to_hex(peeled)) < 0))
+	if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
+	    (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0))
 		return -1;
 
 	return 0;
@@ -1203,8 +1203,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 			int peel_error = ref_iterator_peel(iter, &peeled);
 
 			if (write_packed_entry(out, iter->refname,
-					       iter->oid->hash,
-					       peel_error ? NULL : peeled.hash))
+					       iter->oid,
+					       peel_error ? NULL : &peeled))
 				goto write_error;
 
 			if ((ok = ref_iterator_advance(iter)) != ITER_OK)
@@ -1224,8 +1224,8 @@ static int write_with_updates(struct packed_ref_store *refs,
 						     &peeled);
 
 			if (write_packed_entry(out, update->refname,
-					       update->new_oid.hash,
-					       peel_error ? NULL : peeled.hash))
+					       &update->new_oid,
+					       peel_error ? NULL : &peeled))
 				goto write_error;
 
 			i++;
-- 
2.14.1

