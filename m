Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FBBA20984
	for <e@80x24.org>; Tue, 13 Sep 2016 17:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759626AbcIMRMd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 13:12:33 -0400
Received: from mout.web.de ([212.227.15.3]:53513 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755373AbcIMRMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 13:12:10 -0400
Received: from [192.168.178.36] ([79.213.113.239]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0Ljxc1-1b8sfq0RGz-00bwTB; Tue, 13 Sep 2016 19:12:03
 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] checkout: constify parameters of checkout_stage() and
 checkout_merged()
Message-ID: <a66eedc3-fc86-dd45-628c-e38018a03808@web.de>
Date:   Tue, 13 Sep 2016 19:11:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:K5CokWMA0nQfWioZpV79gBE2RbbJ0Ua5vzx3CbWr6aOq+QPn7R1
 8q9PHiIn60WlxPLgls+EGNVpvUgObsMA+mLBMsek8QTktDEQeWoQKxqvEkkfERWbn+Cj6A3
 brIvywOcUqveUKnXPEZGmCQZtruv/TlPziFFxW6kDVD1+uRIXCe4fxm8Ju4Ge/uXucIcpTm
 66hp+GZDGjT5gHmytZmEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bljaZD6D4D8=:LEbzvEDt1CvNIlVi+d/nhk
 X1t1Ilk//N/31eja/02yFD3l+fmKCmAU77G7YKVfd3eIEzhDmYzu77HBl8ijRmBGZtlbUky1n
 7D73ZrNxvVhGghsXecuBJHAx6niAnehSczog0XL1kQXJ7hzrT94ccNFzdoCH1Cj6NGguGn7vT
 DefZC3404CwIIoZzi/TpCH4EXQABwrX9tmdRemx+/Uba/+C7H/mbIAMWp+xXoqCoapNS7LJCy
 4VKO1PoeLUbElZhGzhHxSNUvGDdDmB0mpi1y6IfoXUrN3bEGLxl/0PetqIOtIePbZJKk8gu/E
 FpJEqB/q86Ajo/cb+2GlcywdxCyavOJ6XptBABm3dkiqTZ5DO1N+EM4lXqGbXIG0+o5Vfz5Uw
 vOC8dEHeVFWpL/4zNthXYiAycBWhK1sBvID9sX6+ieyVpbi5NXtL9oFk72wtcMpMGAky09JvW
 QEIxRyGLRRfoDDY7/z3VWF2Z6zg2h8j+EsyCziTLlYu73j4gx/Xs+jR8vTutNmaFkpLRW7Mbx
 JEA318z3+RsDToRkrR529b3DR9gEmVhDxR3Kqzx2c+eAiOcRBhaMZCHYA0F/SKS6+yrt0gogB
 eER8dw1yl4vNRBpj17U3Vc9bqte8kwP3rjKwkr8LcTJYYmnzM4uuB/sOBMfh1yKxfnchycebZ
 lF/36MKHSQxc8xTyQNRVi0mDh+c9V0DPcKpvEqwjKGoFIcyBWv7kXdGjbem3b9GrCe+c0im95
 YTt4JZZw5ZRefMJz98TmC3PdfmOgPOhujDKREBFNOCJUlN2xa8FRiC0yFq0qxVVGhnbdtLdk8
 D+T1/Xe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the fact that checkout_stage() and checkout_merged() don't
change the objects passed to them by adding the modifier const.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/checkout.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..afbff3e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -154,8 +154,8 @@ static int check_stages(unsigned stages, const struct cache_entry *ce, int pos)
 	return 0;
 }
 
-static int checkout_stage(int stage, struct cache_entry *ce, int pos,
-			  struct checkout *state)
+static int checkout_stage(int stage, const struct cache_entry *ce, int pos,
+			  const struct checkout *state)
 {
 	while (pos < active_nr &&
 	       !strcmp(active_cache[pos]->name, ce->name)) {
@@ -169,7 +169,7 @@ static int checkout_stage(int stage, struct cache_entry *ce, int pos,
 		return error(_("path '%s' does not have their version"), ce->name);
 }
 
-static int checkout_merged(int pos, struct checkout *state)
+static int checkout_merged(int pos, const struct checkout *state)
 {
 	struct cache_entry *ce = active_cache[pos];
 	const char *path = ce->name;
-- 
2.10.0

