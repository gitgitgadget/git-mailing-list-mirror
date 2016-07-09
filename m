Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C2EE20705
	for <e@80x24.org>; Sat,  9 Jul 2016 07:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbcGIHYF (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 03:24:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:52873 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbcGIHYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 03:24:03 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LuPYt-1bEnex1hsl-011hFP; Sat, 09 Jul 2016 09:23:52
 +0200
Date:	Sat, 9 Jul 2016 09:23:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Naja Melan <najamelan@autistici.org>
Subject: [PATCH 1/2] diff: demonstrate a bug with --patience and
 --ignore-space-at-eol
In-Reply-To: <cover.1468048754.git.johannes.schindelin@gmx.de>
Message-ID: <db5aa5d1f22a22901eb3dd57132e027f462852c5.1468048754.git.johannes.schindelin@gmx.de>
References: <cover.1468048754.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gQe8J/VH61NLZ7XpEcQsnZVV7RfVLzHXaOw2aSlN4rPZLoWleVV
 gWmFo6w65m8wpQ/vA1hjecqRHSz4RKQL2I2U0IgsXbE/85e+q3POrzjg26ekkJlbBaimTCd
 Hd5pGKstg9rFr5fRgJy6P0zNhoP7m1VnaNu5P08ZT3LzVE8LqXFNttOb5XC04k1uVgwpidK
 vxyAC39Zcr9iKCzBNTU8Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gZezV8mMCic=:rq9AltGmu0cOX8jlHf4wCp
 sq/FsXCS7J7M+1RK0cGs8UyF9g0hMJP24OWL248xMaI/9Q2Sn/ttfF2wFmzcBJM/Tb7yS/z3P
 6dE7BLR7t1nCKBI0A5R2CJPeHw7bzqMVql2Tmp5HY9mRISKorkNtCjFI6fWyX2Xbi4KR66myG
 57YUB7UEoXD+zj8x1yuE1f+5niaHnYjBeAcvxjrhRyYVqgNGt5cEhAH1RQHrLWA54AlnvnBwY
 AGEI7MHMjeHy/SwVdaxtEFBtgFNEDZnp+eAntZmBaererCUs884237LWzXhjN7IhrX6jTJEIF
 p0cIfoQFWHmkczPuUex632U3QX3QvnsXbdfnP2Ut+10G9HFkmeDfygo3E998w2KBhLXLAyOXw
 FIYGvOhiIbI1FDT6dahRcB9mukH28uph+tjcAvz1qENoTecuxA4WzlqMBfWjqaOFJvSmdGS4P
 DrfUBQq1dCfK0EtYfwVUncXWnKWJCA6H0h7Fu0D4qYtPAYS557ReJJgdq7ud/QecAT/TH14Q2
 tAPStgQCQX7fq72tbYgJnlXBAxKi2j7Q763iOXJPuD/hLnqCmKl30coCN1SHjV3KY8V1wu+LO
 rXlGXVQDSBDfZX8xpwUunqwub5tPo9BemmnVulAzGSCSTslaSxNSO1N7bdRDfXfPMV5nY/F4s
 toCpvzl65kA7A8wrTy3Rf/+nB0QMIWOkLr0evHaCEWZUusWnPCIxtzDJ1YykI7dzT5YBgi7eC
 D2HtxusVrfKcGuhXvbkspKyTZuKSZyJp+YiNP/Kw+AgUaOS7nnBLtwndVEY79zxZr/SAY0Wmx
 dFKJFUV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When a single character is added to a line, the combination of these
two options results in an empty diff.

This bug was noticed and reported by Naja Melan.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4033-diff-patience.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t4033-diff-patience.sh b/t/t4033-diff-patience.sh
index 3c9932e..5f0d0b1 100755
--- a/t/t4033-diff-patience.sh
+++ b/t/t4033-diff-patience.sh
@@ -5,6 +5,14 @@ test_description='patience diff algorithm'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-alternative.sh
 
+test_expect_failure '--ignore-space-at-eol with a single appended character' '
+	printf "a\nb\nc\n" >pre &&
+	printf "a\nbX\nc\n" >post &&
+	test_must_fail git diff --no-index \
+		--patience --ignore-space-at-eol pre post >diff &&
+	grep "^+.*X" diff
+'
+
 test_diff_frobnitz "patience"
 
 test_diff_unique "patience"
-- 
2.9.0.278.g1caae67


