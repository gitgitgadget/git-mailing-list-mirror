Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736A420A10
	for <e@80x24.org>; Sun,  1 Oct 2017 15:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdJAPMN (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 11:12:13 -0400
Received: from mout.web.de ([212.227.15.3]:50292 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdJAPMM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 11:12:12 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQL8O-1dtHaH0jue-00TlWv; Sun, 01
 Oct 2017 17:12:09 +0200
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] coccinelle: remove parentheses that become unnecessary
Message-ID: <c4abb7ac-dafd-57f2-8b46-45d610d656c4@web.de>
Date:   Sun, 1 Oct 2017 17:12:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iFJMQnbAH3yaZ3Bx1ddEahE1PXCsjkKT66pZysIM3V4u95z0wKe
 aQrnJEjoUCpkRVM3WYYR4kgb7yFMQKbTl0SI8om7LRVFSZbTg/r8ZyFe6w3BYkThrIvarEq
 ru4PYGU+bx+/Sm+2/A9r/S9tDj6GIGEbA+sRVNDA+2fWynvvXol5s/IonGwNFyLpNt9/7Qk
 p+FtLgSYk0gRwfIJiPIJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g3R3noVYJcI=:gpcR4d1J73BUJmPQW5hIpJ
 EcdPQrtUv3mg1LrpO4aihF7kBbkmgwWi0tCczVMhl+XETWoLOqv2AA+WZHWn2KSyrCEqtvpFk
 zDogteQLONkQTP9NyCL2txKAOugBLzi4FHUD06+18DcZZBm/YbE+rPne1QDj15Kqf+Ac603eZ
 DJLf0SPGhi+J4KORVO/ExOFGP+wyqCziFh0jgZWMwIP8xgA1Xz8vM1K2A5WyUn1tGL9g5KwhA
 DVdlryDyFvIQzkUbhE2S719KYGkBrwAue6/bL7EsQ2sah/EX0mYhtAJDoA2FNBGGGjuqglSwa
 RA5zC4rab/AMV/0IzmBTdhoR4XK+XehZ1xT2AGa/wM7EGh8nwBxLn5g+lscbRPNXDJQEhxhBR
 eX4eypVnh3c+5gsozHXgHe4h1uxkJ5fTaEfAxFfWaKSFHTBNzD5fqIELNLiFHjI5rAjvGGstz
 UEpzPwjFyDrTPdlDs5vgwAY3kDLuueOaLOmpaaMsYhTMwj2DvHzEAb+aXueFaCiK7Ml10k/V4
 kNF1rKhsPXsC3QYXbydW9TFJlllNMZ1wbsesVHIePgs1N9I8OoIOQjWuXJ4pKLDxGeh1liT70
 /ML8IuPkdZhRoUsj57jWJEGEh9ZxEjJ3V3KOqVljOlIOtjzH0QDCf1F2lTTJBmWikUzL2QEOB
 ku3RI5ZSjKcptVLqjcLWnN08Mvj+3dZzmdn4VgiYS+WXrUOetNSKhh29ke494/1USVnEaxNol
 ugAdc6IShq6wVzj6liAzYmjBJAz/9Sd60ujxVV6gUZtW/w6ncBRPCR0ykciQBX1yWX3EUbggx
 IrZqLFw6Oryee1eDU+ZSxJxDNvQZQ/SDp4/bjPtADTWG9ms/1U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Transformations that hide multiplications can end up with an pair of
parentheses that is no longer needed.  E.g. with a rule like this:

  @@
  expression E;
  @@
  - E * 2
  + double(E)

... we might get a patch like this:

  -	x = (a + b) * 2;
  +	x = double((a + b));

Add a pair of parentheses to the preimage side of such rules.
Coccinelle will generate patches that remove them if they are present,
and it will still match expressions that lack them.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 contrib/coccinelle/array.cocci | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index c61d1ca8dc..01586821dc 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -4,7 +4,7 @@ T *dst;
 T *src;
 expression n;
 @@
-- memcpy(dst, src, n * sizeof(*dst));
+- memcpy(dst, src, (n) * sizeof(*dst));
 + COPY_ARRAY(dst, src, n);
 
 @@
@@ -13,7 +13,7 @@ T *dst;
 T *src;
 expression n;
 @@
-- memcpy(dst, src, n * sizeof(*src));
+- memcpy(dst, src, (n) * sizeof(*src));
 + COPY_ARRAY(dst, src, n);
 
 @@
@@ -22,7 +22,7 @@ T *dst;
 T *src;
 expression n;
 @@
-- memcpy(dst, src, n * sizeof(T));
+- memcpy(dst, src, (n) * sizeof(T));
 + COPY_ARRAY(dst, src, n);
 
 @@
@@ -47,7 +47,7 @@ type T;
 T *ptr;
 expression n;
 @@
-- ptr = xmalloc(n * sizeof(*ptr));
+- ptr = xmalloc((n) * sizeof(*ptr));
 + ALLOC_ARRAY(ptr, n);
 
 @@
@@ -55,5 +55,5 @@ type T;
 T *ptr;
 expression n;
 @@
-- ptr = xmalloc(n * sizeof(T));
+- ptr = xmalloc((n) * sizeof(T));
 + ALLOC_ARRAY(ptr, n);
-- 
2.14.2
