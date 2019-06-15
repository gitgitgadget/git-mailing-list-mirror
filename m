Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE241F462
	for <e@80x24.org>; Sat, 15 Jun 2019 18:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfFOSdU (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 14:33:20 -0400
Received: from mout.web.de ([212.227.15.4]:48795 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfFOSdU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 14:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1560623591;
        bh=D096lH+cCFNa/FeP26MeWmXZPrnXBxDfCwu5KFHXBO8=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=lXJOESnVtSUk91mi/cVIZGC6kUsUHcbgKNEogm1eAQf1KqIP7vPDu2JV06EdTFl+P
         TVPsA/uBtMbb1ut+KrTI0EInNLXla1VHkk1FeW37UOXuGyBYnA69YF5aJ9Axn68Rv0
         L7fUiNiQOXPz3G8l+DJ50LnYU30SnxtuDIrEf/Ic=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPYMT-1hgK5m3Cb3-004mrN; Sat, 15
 Jun 2019 20:33:11 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] coccinelle: use COPY_ARRAY for copying arrays
Message-ID: <a2633676-5350-e85d-2bea-c2c0f7a33bbb@web.de>
Date:   Sat, 15 Jun 2019 20:32:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X01dsKu5jhaP/6QvKwO1soT2UvwtP0YGIpt7tEpcHsFfo6nBfIS
 5E+xFKMP10LS9E3Eih+cn0Wlznkm7rwxlTPW9nELuOJ7yrmALjWyiZbzCMBAv/kVilG6cht
 UOmfWpfVw3jYFZqCqPMRMNmeieaFZ4CD1H95WLz/h33ruo3YQ3i8aMCG4ctYgUcWmpkTUhA
 WYTISq+oczFtUnXKERjbg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tIgQYMz7aS4=:0Anad11uKGJSJ4ePoaWjVM
 aR8mq6A/RgvSBGQWhwXPkOU2l6hi2bz0BS33mf0gRBdlgSJevMkKHLTlSw6nDscdaWeglvocn
 0EjysMq2cAfa1pHcafzv6HrxcEr9cDEtErOxNHrNswnYO7lWpyIK0HC4lC01gHQjP4YrO5WMn
 9AX1qt+TQ2RQHlGdV29pPtueS6vFkBRGQbZePGuNV8imINuCf7RRcRLQHAphU5z+prjkwDPFQ
 G0S77d5HlBLhgMUpIAIwQAqMH5ozTCHcBH0Tr+yJ0Kjolf3ioGHeHJGOwxTXhnqz1081gGYnS
 UYt8OwTBDvyGOMvoazp3TX+d8p66eFXr+mwh/XUvlDgAY3RvU9jpB1DrLuNWgGJUZlTTgWSEV
 3uDv2w1g158TBbSISMw5SraZ1+Ps3HXXYiTQuMdJQE4YxeZMagLRnEfXWp4IvayjJX+Sa8oT5
 2V8O5B9vg5tR80dlvRV+TSBJjpB0flG6sPGluJ/Pj5oDW3dTIr18e5n/RKdNMk5UZiJzGk9Iv
 MJcKi1dhXRGB9J8lCsBc81+NBhAOdu0iMndi9TTILFHq8rBmCtb5MblHz3L2NViduth+fzg3C
 B+lBMLhRP6GzQu6NrwkE3ruLSvZpN3C9c6pVcrBvOUzsgy6KvptzPMo41OzXu5iqHlxHPkH9I
 mtpNkPMftc8t4PpMOQa8tDqyJcZNVR0fNJhPPhiuhJpCYApYqzHKEHqVefjahqJBJSDrLujSt
 /DYGmYkcCf4ePSV1O8YJMW2ef/z+Ku1I+zKAzIL6/txXrII5ccovwrYv1mzu9HjalTsIs3+F3
 V3aZBBTiA+cyzFHVHp99BBmCVlUQf1qNpyQw0wiyjwBEDedLMlfCfqRRq78c/XpcVRKwRGte3
 hRzqYnMnvbN/+9hMVhysxknSlDx9NL2AGHqcrWVYBXwwA0dpsOILDzK1pycnL6V5Ndozdfcm4
 Msc9VDQJ5ytJNAUlW93iwc73+4WJcdgQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current semantic patch for COPY_ARRAY transforms memcpy(3) calls on
pointers, but Coccinelle distinguishes them from arrays.  It already
contains three rules to handle the options for sizeof (i.e. source,
destination and type), and handling arrays as source and destination
would require four times as many rules if we enumerated all cases.

We also don't handle array subscripts, and supporting that would
increase the number of rules by another factor of four.  (An isomorphism
telling Coccinelle that "sizeof x[...]" is equivalent to "sizeof *x"
would be nice..)

Support arrays and array subscripts, but keep the number of rules down
by adding normalization steps: First turn array subscripts into
derefences, then determine the types of expressions used with sizeof and
replace them with these types, and then convert the different possible
combinations of arrays and pointers with memcpy(3) to COPY_ARRAY.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
 contrib/coccinelle/array.cocci | 61 +++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 01586821dc..46b8d2ee11 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -1,29 +1,60 @@
 @@
-type T;
-T *dst;
-T *src;
-expression n;
+expression dst, src, n, E;
 @@
=2D- memcpy(dst, src, (n) * sizeof(*dst));
-+ COPY_ARRAY(dst, src, n);
+  memcpy(dst, src, n * sizeof(
+- E[...]
++ *(E)
+  ))

 @@
 type T;
-T *dst;
-T *src;
-expression n;
+T *ptr;
+T[] arr;
+expression E, n;
 @@
=2D- memcpy(dst, src, (n) * sizeof(*src));
-+ COPY_ARRAY(dst, src, n);
+(
+  memcpy(ptr, E,
+- n * sizeof(*(ptr))
++ n * sizeof(T)
+  )
+|
+  memcpy(arr, E,
+- n * sizeof(*(arr))
++ n * sizeof(T)
+  )
+|
+  memcpy(E, ptr,
+- n * sizeof(*(ptr))
++ n * sizeof(T)
+  )
+|
+  memcpy(E, arr,
+- n * sizeof(*(arr))
++ n * sizeof(T)
+  )
+)

 @@
 type T;
-T *dst;
-T *src;
+T *dst_ptr;
+T *src_ptr;
+T[] dst_arr;
+T[] src_arr;
 expression n;
 @@
=2D- memcpy(dst, src, (n) * sizeof(T));
-+ COPY_ARRAY(dst, src, n);
+(
+- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
++ COPY_ARRAY(dst_ptr, src_ptr, n)
+|
+- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
++ COPY_ARRAY(dst_ptr, src_arr, n)
+|
+- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
++ COPY_ARRAY(dst_arr, src_ptr, n)
+|
+- memcpy(dst_arr, src_arr, (n) * sizeof(T))
++ COPY_ARRAY(dst_arr, src_arr, n)
+)

 @@
 type T;
=2D-
2.22.0
