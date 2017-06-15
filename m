Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC2720401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbdFOOsp (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:45 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:56147 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752481AbdFOOso (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:44 -0400
X-AuditID: 12074414-cffff7000000283f-08-59429e4ae84b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 50.D0.10303.A4E92495; Thu, 15 Jun 2017 10:48:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRM014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:41 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 28/28] read_packed_refs(): die if `packed-refs` contains bogus data
Date:   Thu, 15 Jun 2017 16:47:33 +0200
Message-Id: <c13b2fad1fe0bc521b58fdf3115ee47a11db770b.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqOs1zynSYO0dK4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJev1vGVjCHs2LitCbmBsZl7F2M
        nBwSAiYSG56+YOli5OIQEtjBJLGvcS4zhHOSSeLC/ZOsIFVsAroSi3qamUBsEQE1iYlth8A6
        mAUmMUu8vbYQLCEsECzx+/dlFhCbRUBV4tTeXiCbg4NXIEri0SRZiG3yErvaLoLN5BSwkJj9
        ZR0zSImQgLnEseUaExh5FjAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3StdDLzSzRS00p3cQI
        CTmRHYxHTsodYhTgYFTi4T1R6xQpxJpYVlyZe4hRkoNJSZSXXw4oxJeUn1KZkVicEV9UmpNa
        fIhRgoNZSYR36hygHG9KYmVValE+TEqag0VJnPfbYnU/IYH0xJLU7NTUgtQimKwMB4eSBK/x
        XKBGwaLU9NSKtMycEoQ0EwcnyHAeoOF/wYYXFyTmFmemQ+RPMSpKifNmgTQLgCQySvPgemEp
        4RWjONArwrzzQNp5gOkErvsV0GAmoMFBFxxABpckIqSkGhjN5hzzfvSu/p7dFraibd+s3d97
        Ol+eI9W79X7Ytpyn8zjLHU1e7ApvWhIxsY5RSfvZ+6hja1cb6J/jWixwviZn2vmrZXHaRQxr
        J0gvj1Zu+Xy/XKRHZ8Fq83PXyw9z3Xjzu/7PXBcpQ64wr67LK9b2bt5gcWCGb8PzeOHNArFs
        W+dsN+FTPLBAiaU4I9FQi7moOBEAfBNm5uQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code ignored any lines that it didn't understand. This is
dangerous. Instead, `die()` if the `packed-refs` file contains any
lines that we don't know how to handle.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 721afd066a..311fd014ce 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -253,9 +253,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
 			add_ref_entry(dir, last);
-			continue;
-		}
-		if (last &&
+		} else if (last &&
 		    line.buf[0] == '^' &&
 		    line.len == PEELED_LINE_LENGTH &&
 		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
@@ -267,6 +265,8 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			 * reference:
 			 */
 			last->flag |= REF_KNOWS_PEELED;
+		} else {
+			die("unexpected line in %s: %s", packed_refs_file, line.buf);
 		}
 	}
 
-- 
2.11.0

