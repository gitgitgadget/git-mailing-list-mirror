Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADC320899
	for <e@80x24.org>; Sat, 19 Aug 2017 11:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdHSL2I (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 07:28:08 -0400
Received: from mout.web.de ([212.227.15.4]:59045 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbdHSL2H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 07:28:07 -0400
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaCWE-1dICQp1awQ-00m6da; Sat, 19
 Aug 2017 13:28:01 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org, asottile@umich.edu
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 1/2] convert: Add SAFE_CRLF_KEEP_CRLF
Date:   Sat, 19 Aug 2017 13:27:59 +0200
Message-Id: <20170819112759.18521-1-tboegi@web.de>
X-Mailer: git-send-email 2.14.1.145.gb3622a4ee9
In-Reply-To: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa832vymw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:LyqscAxG4W2rWUx0h+NwNqSY/VwG+mtCbTiePQ45jCAJAI/e5Yr
 0CY4BKZS5OZ7xCEej/p/B6vrtjHIMc1U81UgiHTT6b9UR9LSnnCGkXgBhgF6aM/RFwYprHs
 bORLRCd0kaO1OdSS66LMuGeHeU6tV5+cHuy+9Ia7Q1w1IR3jQgyjy/eYNSFzQKe6EPm4TPv
 7P5s6Hct6LGXMOPabZd9w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ruZd8Xq/64=:XzPOAx4cQ75laq3aYzFgkD
 V4iwYlPDLbxnt4AbMeYCZxyUj//GtgZBChDoVNFxj5WUM5iAqWjqHkmGvEQIinJ2ULswKSgPk
 +WHIBIgLkBiFo4hyKj/mbHAOBei4GX38AEvi7wixhfaapHwHgA6hzEDS9/s9/jBsGVyFTlwtI
 PfmcKZiU2eT9eIx+ohoF2i4r1vERqOFjkB31AtLxCJNYAewp2uA/mAdDswkjJsSj7ImKb1zOs
 poLZpo5rFB/7N1oF6BPYR6WjVvO4/1cKGkmZIOiQvazfp2o1N4mbRdpSo26fuBWWD7U5RXD3r
 qWz/yfnjtGq/hZB63DRJAUqrujsLBNAnKNJ0FTySBFARZe4kCF+Ko9Wna6qj5Q6gmzbMJpRax
 YczYyIvMdm8iA6+xNb9GUSvXkiYtkv5aBP/b8c7E1EgrZjjp5c/XRuVPdXIv+o4S7OeXgXUSq
 O4rHTPUDLnlIOcxG9lZNX44Q0z8Sf9MUJQkrAVklduhep1VXFK90SLBXH24seIFT89rgy/6GH
 84PBHkWmebkgXMt0ziYkj62i60KTwdadkrwfHcVFQ0IXkwCMg4SZVtJc/M3rgTLvVBCD4Awua
 efWj9qbA6V9euzOLQqCeVbK6eHsTzIdzALSQqeRuUUe7eWbbHM0A3eIHPpwwJX2IOCOXLYedZ
 TBmmLtyXdqZdeaStrqAzp24R4bXMfvKRKQbOHAsO/FGaUJf9X0V36WQDKc49SRTgsrcDkX9JZ
 x+bMvYZIKDFmBmA7Fuw3so5Qlt+Op5vUlrhTx+NRlbSUAkQ0Hw/R58Z+ouegIBdlXiNtEtFxh
 gj35qDJtRjOLf+GzIA3BlE8/bfBZ6ip3g6w0U82nf2eFLFrVLw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

When convert_to_git() is called, the caller may want to keep CRLF
to be kept as CRLF (and not converted into LF).

This will be used in the next commit, when apply works with files that have
CRLF and patches are applied onto these files.

Add the new value "SAFE_CRLF_KEEP_CRLF" to safe_crlf.

Prepare convert_to_git() to be able to run the clean filter,
skip the CRLF conversion and run the ident filter.

Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 convert.c | 10 ++++++----
 convert.h |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/convert.c b/convert.c
index deaf0ba7b3..040123b4fe 100644
--- a/convert.c
+++ b/convert.c
@@ -1104,10 +1104,12 @@ int convert_to_git(const struct index_state *istate,
 		src = dst->buf;
 		len = dst->len;
 	}
-	ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
-	if (ret && dst) {
-		src = dst->buf;
-		len = dst->len;
+	if (checksafe != SAFE_CRLF_KEEP_CRLF) {
+		ret |= crlf_to_git(istate, path, src, len, dst, ca.crlf_action, checksafe);
+		if (ret && dst) {
+			src = dst->buf;
+			len = dst->len;
+		}
 	}
 	return ret | ident_to_git(path, src, len, dst, ca.ident);
 }
diff --git a/convert.h b/convert.h
index cecf59d1aa..cabd5ed6dd 100644
--- a/convert.h
+++ b/convert.h
@@ -10,7 +10,8 @@ enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
 	SAFE_CRLF_WARN = 2,
-	SAFE_CRLF_RENORMALIZE = 3
+	SAFE_CRLF_RENORMALIZE = 3,
+	SAFE_CRLF_KEEP_CRLF = 4
 };
 
 extern enum safe_crlf safe_crlf;
-- 
2.14.0.rc1.15.gd40c2d4e85.dirty

