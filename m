Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F712082D
	for <e@80x24.org>; Fri,  8 Sep 2017 13:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754578AbdIHNwa (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 09:52:30 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53087 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752415AbdIHNwZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Sep 2017 09:52:25 -0400
X-AuditID: 1207440c-7fdff7000000143e-08-59b2a098ea13
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B4.3B.05182.890A2B95; Fri,  8 Sep 2017 09:52:24 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAEECC.dip0.t-ipconnect.de [84.170.238.204])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v88Dpvk4002844
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 8 Sep 2017 09:52:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 11/11] files_transaction_finish(): delete reflogs before references
Date:   Fri,  8 Sep 2017 15:51:53 +0200
Message-Id: <1e04a8769227abe850863ba75d10b43396362af4.1504877858.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1504877858.git.mhagger@alum.mit.edu>
References: <cover.1504877858.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqDtjwaZIg5b7khZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXRveTY+wFfYIVdxbeY2pgvMjbxcjJISFgInH/8VLW
        LkYuDiGBHUwSzS0NUM5JJokznWfZQKrYBHQlFvU0M4HYIgJqEhPbDrGAFDELPGWS2HnyLitI
        QlggTOLfpNfsIDaLgKrEmZONYA28AlESG/7PYoZYJy9x7sFtMJtTwELi1b81YAuEBMwlru6e
        xDqBkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJAQ49nB+G2dzCFG
        AQ5GJR7eCaEbI4VYE8uKK3MPMUpyMCmJ8sr0bIoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMJr
        Pgsox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4A2YD9QoWJSanlqR
        lplTgpBm4uAEGc4DNHwjSA1vcUFibnFmOkT+FKMuR8fNu3+YhFjy8vNSpcR52+YBFQmAFGWU
        5sHNgaWGV4ziQG8J804BGcUDTCtwk14BLWECWlLyfAPIkpJEhJRUA2M4z9ets0svpr3lULIS
        kNCb7/Nsuv/L1v3M8bPlo2r+1f3Tszr566vXyUXHX6bwxQit1XvY0L0nSGDC7BLzDkGGhtlB
        ZyJv8hVqFr5e7RLLLsa/TO45n+kEnZJTyf6rFhRMLjSJati6bemM/Y63hd32ujYcCF0ReEFo
        /oxbv9imfQrRFg624lNiKc5INNRiLipOBADi0khP6AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the deletion steps unexpectedly fail, it is less bad to leave a
reference without its reflog than it is to leave a reflog without its
reference, since the latter is an invalid repository state.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 29eb5e826f..961424a4ea 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2636,6 +2636,27 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		}
 	}
 
+	/*
+	 * Now that updates are safely completed, we can perform
+	 * deletes. First delete the reflogs of any references that
+	 * will be deleted, since (in the unexpected event of an
+	 * error) leaving a reference without a reflog is less bad
+	 * than leaving a reflog without a reference (the latter is a
+	 * mildly invalid repository state):
+	 */
+	for (i = 0; i < transaction->nr; i++) {
+		struct ref_update *update = transaction->updates[i];
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY) &&
+		    !(update->flags & REF_ISPRUNING)) {
+			strbuf_reset(&sb);
+			files_reflog_path(refs, &sb, update->refname);
+			if (!unlink_or_warn(sb.buf))
+				try_remove_empty_parents(refs, update->refname,
+							 REMOVE_EMPTY_PARENTS_REFLOG);
+		}
+	}
+
 	/*
 	 * Perform deletes now that updates are safely completed.
 	 *
@@ -2672,20 +2693,6 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		}
 	}
 
-	/* Delete the reflogs of any references that were deleted: */
-	for (i = 0; i < transaction->nr; i++) {
-		struct ref_update *update = transaction->updates[i];
-		if (update->flags & REF_DELETING &&
-		    !(update->flags & REF_LOG_ONLY) &&
-		    !(update->flags & REF_ISPRUNING)) {
-			strbuf_reset(&sb);
-			files_reflog_path(refs, &sb, update->refname);
-			if (!unlink_or_warn(sb.buf))
-				try_remove_empty_parents(refs, update->refname,
-							 REMOVE_EMPTY_PARENTS_REFLOG);
-		}
-	}
-
 	clear_loose_ref_cache(refs);
 
 cleanup:
-- 
2.14.1

