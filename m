Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAE4202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 08:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdGNIjf (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 04:39:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:52007 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbdGNIje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 04:39:34 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKpQ4-1dVw8I31w8-0000DT; Fri, 14
 Jul 2017 10:39:30 +0200
Date:   Fri, 14 Jul 2017 10:39:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t1300: demonstrate that CamelCased aliases regressed
In-Reply-To: <cover.1500021526.git.johannes.schindelin@gmx.de>
Message-ID: <79af768e29d878da995df553638b18fc6d7a5190.1500021526.git.johannes.schindelin@gmx.de>
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rLR9g1yPUqHx9hbnUjoe5JRtdJoTY2kQkpvFchSzJcKv5oLYvz0
 CbJYRwX99HDuh+hDQi/tOjf56MlnSRdKmH9189lBTR2J02y0n8LfV6MksE70OQFbcxpTBrz
 xHmdbZjl0sfOCn/Qvt1PMSPN8GDAE/lRjuVEJQrT/EkUDDN2ga5SIFx66XR5K1qKDNo6EcN
 yyA0K5ybTPEO9BiWAVXsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n4wrtbFkmaw=:Cda93FCg5SwJuCUbmSyGhi
 /GzCiZ7KcoLVMlJkPtYmoWeWT1+/B6T7pfgIw6h8Ybjn63QaGRe3nXIdyl9i5oj/pNWCFluTG
 e9sgzUGk4X24Rsg+AgQ1O6S5c6RqRtKga5aFMmPdDtORSUeSUJkqYxgz97ZTx0yqKQCGBsXJI
 g/X1iuDYXDNG3EvcD4fEhk83zvNfyyUGbFFHIEFadqLwvltHEnec0odl6RyYf+IcRaUOO1GaZ
 Br3pIYG9dSjUPiwju0PYNcH81RuPZO9aDqrXRNvFvr0HclstzMX8yOfkmkcbCGQvjjKfWX94H
 XS/bIuZVgMQp2FylXPT5rnJjI2Zto4Ekvk/wzKMjzczhblW0IlVP2iBh4x9uArqWC9Nk2aTsO
 vOPkH9R8b8g3qlLFXLnhkG0x9SycCa0Fq5l8VZzU0I1awxpCZIXmb0RuO8eMCjKuCmYyqmkAu
 Jx8lvElSFoHImQKrofddj5c7VJ5yKUNydeLRtg8vPSThlrgVsZmN64NI5ZlenQqdcpNcMn0Ey
 wsrGf8R7s+g96AKfppCmF2OyqN3qjOUb+sJif9FOcV0lpeH4kvVtccL/O5VayHgmHj11f4rHz
 9dK+tokJJomhZ6cGfN0oQw5IGKKBeqomEXsZlyPL+9nPcbYATfhZZ2a6p/8CSSnCD0JglSrHe
 QeyL3TVTU6AVyqFv2SB+dKe8sWVJ7k7DEwqLOCR8W8ODcz+ueLPWyAQRb5k7y09MwTbKEn97K
 V039/gtDCIiM/DEy5Uq4cm48YND0TPCe46Lo/cM2kwGMgEntcf/y/61z5ihAI6LujFyaKcUYm
 00M/gRVSUMO+PfoFoOSxpaUZcr0e1gl7rp4qvQkVenV6aUuFC0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is totally legitimate to add CamelCased aliases, but due to the way
config keys are compared, the case does not matter.

Except that now it does: the alias name is expected to be all
lower-case. This is a regression introduced by a9bcf6586d1 (alias: use
the early config machinery to expand aliases, 2017-06-14).

Noticed by Alejandro Pauly, diagnosed by Kevin Willford.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1300-repo-config.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index a37ef042221..0df71b84ccf 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1075,6 +1075,13 @@ test_expect_success 'git -c works with aliases of builtins' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'aliases can be CamelCased' '
+	test_config alias.CamelCased "rev-parse HEAD" &&
+	git CamelCased >out &&
+	git rev-parse HEAD >expect &&
+	test_cmp expect out
+'
+
 test_expect_success 'git -c does not split values on equals' '
 	echo "value with = in it" >expect &&
 	git -c core.foo="value with = in it" config core.foo >actual &&
-- 
2.13.3.windows.1.13.gaf0c2223da0


