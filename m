Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A635D20285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbdH2IVk (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:21:40 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59260 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751264AbdH2IVC (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Aug 2017 04:21:02 -0400
X-AuditID: 12074414-0d3ff70000006ddf-44-59a523ed2fdb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 39.CF.28127.DE325A95; Tue, 29 Aug 2017 04:21:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC836.dip0.t-ipconnect.de [87.188.200.54])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v7T8KcS4002808
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 29 Aug 2017 04:20:59 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/10] files_transaction_finish(): delete reflogs before references
Date:   Tue, 29 Aug 2017 10:20:34 +0200
Message-Id: <b147389b4abfbd8975fe651d956fded34f5b90cd.1503993268.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqPtWeWmkwbIPuhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxuEjv1gK+gQrZi84xNjAeJG3i5GTQ0LARGL6pVtM
        ILaQwA4mif0XVSDsk0wSpxYmg9hsAroSi3qawWpEBNQkJrYdYuli5OJgFnjKJLHz5F1WkISw
        QLDE7H272EFsFgFVid+PVoPFeQWiJKb9WcMKsUxe4tyD28wgNqeAhcSlz48YIZaZS5zufMA8
        gZFnASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdC73czBK91JTSTYyQ8BLZwXjkpNwhRgEO
        RiUeXga7JZFCrIllxZW5hxglOZiURHkzFJZGCvEl5adUZiQWZ8QXleakFh9ilOBgVhLhDWYH
        yvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfByAeNISLAoNT21Ii0z
        pwQhzcTBCTKcB2i4sBLI8OKCxNzizHSI/ClGRSlx3gmKQAkBkERGaR5cLyz+XzGKA70izMsD
        soIHmDrgul8BDWYCGqwouBBkcEkiQkqqgTFIRlLL9nLVqVVP7XoeeXVEtZS3TNrZI1fnf/Fp
        Hvubb4/V3q+fue1H3sQVT1f3us/VdP/RfVx+S1foXMXrWedDkh78+9b6sMmdXy361I4Uy1UK
        U3V+HCv3/HNZOKfl/pdAdasXx60fMEcKhhQqfz51gvPs4iYdZXn1juUVm41vvAs/JfRNL0mJ
        pTgj0VCLuag4EQCLjd6n2gIAAA==
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
index 4f4c47b9db..36f81b4f28 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2630,6 +2630,27 @@ static int files_transaction_finish(struct ref_store *ref_store,
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
@@ -2666,20 +2687,6 @@ static int files_transaction_finish(struct ref_store *ref_store,
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

