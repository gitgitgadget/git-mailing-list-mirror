Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E33C433EF
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 08:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiGIIQr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jul 2022 04:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGIIQq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jul 2022 04:16:46 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2515747BF
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657354589;
        bh=YMPV96t6ONhu0nb3PmiYI+SoSWFctt/ZEholvmsLUUM=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=llF7pFMJ3Hh+QZBfClmIpYYH6ebdfYM656L2qKonDtmrsTDBAyZ8qChHcFKncWC/j
         gBjs0m8nUxpui5DkiWK8lhhvImNeUs2MGn6tJ2OPkijUNF44M29lj2vVEEBf+jgGIS
         byvX1X8GkkEEtiGfImOJKGLzJHTYrYe7oZjUpbsE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQxo5-1nyK2k14gZ-00Nkd1; Sat, 09
 Jul 2022 10:16:29 +0200
Message-ID: <95432eb4-e66a-5c04-9267-f71391fbe277@web.de>
Date:   Sat, 9 Jul 2022 10:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.1
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
 <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
Content-Language: en-US
In-Reply-To: <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ei2k57xWlqJqMmxczlsIayP2KzCBQp13QHK7iDBORuiz+zq1Ha3
 FD91VYaZiwyzfGKtqykufNxEnUhPS0zA+mkIbwT+vG7PPmHLZmaCwToXeGmCHRVIJeHl59a
 ZhHv8PoPBiimwZUsrPSTzlJ9G2LJxQd0gklXd+H2fzTU0+5MqBt7ysvprGTEPAVTj31pa3C
 AiCJg0An1HU3RVq25RETQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rmWqR1akoDA=:I5k5Vdok3D0cVD/uqXHucN
 kZSO9gseDefODqljGqm+UfjnzGv0kv1JN6Bv0fm3y5gheI6Q5gWFqAmfYLu8/V/Zc17Bf3LPH
 WeXmWJm+KUIYTZ7nOXD3ey3T/ktvWs6XGez6/rsXArz5xm2/zL3/dumI5UdJ6D4EcrA5/sJI+
 Tx7PLp66pHj+n6nIL6bDbfVlcXDttpcn4wGl+ZqD7H8KUUOUoYjki0GAzrI06zT3BKYAKm9cd
 elJTSJVRnuZ7XqzJfgASzaHLMV7tOvEQJshTHsNr/uLsA+iFIR95UtxRtMt4KnOH+Wr108RRz
 btEgJSuMLZWMUVM/4iI/AMAaQ2PqS9vzTwzjFMdU7KNgUlXnKEb7ch8Rdw9fH4L7C9c7ZQTF+
 Jq0iq7SpagagZU5t5MCZuUFy7d9k1kgPZeZEN3Dq9+LMATDT3DJkQDbeqdKwVEmtW1rZWcQ6V
 kaHuakpA2DbJ39SAAsoTyf/8xjiHb4NMjZOFRSsE44aWhHRQPIGglQgaNJTJvTJtMggTYrqbu
 ThP4ToQ3JhWTp3Jrj6s1lMJfQPOqsyNgUZQKL5qarqCaGfnbWvkZxqMgU2v8ckXrLooQUU36M
 Qb9zJhu+ZEktNMNEzgSVXA8whD3kN/bDbyYA4QaPYgYL17k/V1T3AbiQCJf02l35ikGc/Xx6a
 DLe1mAnK3uCn/wcDaX9LtOqv3a4uhSffynvucSZJ2bshFXg1bUgiVfChrQ+OjBVB/HyG8EtMy
 MRo9FCnfP3CYpqYsu6eHcbwtTkRVC35eI4+Rd/JF9UCHdHAisw1H1chdhz5K6xJ67eTNwreXq
 nG9P0n9atBDO7oN1jQ1H2dYaDxGbNNRLTxw00TZw8oBmyqkBJ0HcqNblbnco1ckQS3ibbBEE0
 207Zv/TJ3Eq4vwqaq5iOpAv4xoNSuvKRW86/h/qsMXje4BUReRgGPF3waKXGqweihak6xdsXh
 i8di75rBr+VMda1bY1KY1SfAsPtMf43ua44OuDvJETK3GGPW028TKUKqZ8Nv5VnI7mB0PfIa9
 q18CuIRiKc/uY9HnD93bcIuqMnh5u9OFM8ErB4j2DZGoXaSgJu2XV94IeOVcg7+afj9rk/uZs
 wPT8UAo1K2mqwNgQSecyKdUcjOe4MR8Fbcp
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.07.22 um 21:11 schrieb Ren=C3=A9 Scharfe:
> Am 07.07.22 um 20:10 schrieb Junio C Hamano:
>>     @@
>>     type T;
>>     T *dst_ptr;
>>     T *src_ptr;
>>     T[] dst_arr;
>>     T[] src_arr;
>>     expression n;
>>     @@
>>     (
>>     - memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
>>     + COPY_ARRAY(dst_ptr, src_ptr, n)
>>     |
>>     - memcpy(dst_ptr, src_arr, (n) * sizeof(T))
>>     + COPY_ARRAY(dst_ptr, src_arr, n)
>>     |
>>     - memcpy(dst_arr, src_ptr, (n) * sizeof(T))
>>     + COPY_ARRAY(dst_arr, src_ptr, n)
>>     |
>>     - memcpy(dst_arr, src_arr, (n) * sizeof(T))
>>     + COPY_ARRAY(dst_arr, src_arr, n)
>>     )
>>
>> I take it that thanks to the earlier "meh -- between sizeof(*p) and
>> sizeof(p[0]) there is no reason to prefer one over the other" and
>> "oh, no, we should prefer sizeof(*p) not sizeof(typeof(*p)) but this
>> one is the other way around" rules, this one only has to deal with
>> sizeof(T).
>>
>> Am I reading it correctly?
>
> Yes.  Without the ugly normalization step in the middle could either
> use twelve cases instead of four here or use inline alternatives,
> e.g.:
>
> type T;
> T *dst_ptr;
> T *src_ptr;
> T[] dst_arr;
> T[] src_arr;
> expression n;
> @@
> (
> - memcpy(dst_ptr, src_ptr, (n) * \( sizeof(*(dst_ptr)) \| sizeof(*(src_p=
tr)) \| sizeof(T) \) )
> + COPY_ARRAY(dst_ptr, src_ptr, n)
> |
> - memcpy(dst_ptr, src_arr, (n) * \( sizeof(*(dst_ptr)) \| sizeof(*(src_a=
rr)) \| sizeof(T) \) )
> + COPY_ARRAY(dst_ptr, src_arr, n)
> |
> - memcpy(dst_arr, src_ptr, (n) * \( sizeof(*(dst_arr)) \| sizeof(*(src_p=
tr)) \| sizeof(T) \) )
> + COPY_ARRAY(dst_arr, src_ptr, n)
> |
> - memcpy(dst_arr, src_arr, (n) * \( sizeof(*(dst_arr)) \| sizeof(*(src_a=
rr)) \| sizeof(T) \) )
> + COPY_ARRAY(dst_arr, src_arr, n)
> )
>
> I seem to remember that rules like this missed some cases, but perhaps
> that's no longer an issue with the latest Coccinelle version?

Not a problem, it seems; at least Coccinelle 1.1.1 is still able to
recreate the conversions from 45ccef87b3 (use COPY_ARRAY, 2016-09-25)
and 921d49be86 (use COPY_ARRAY for copying arrays, 2019-06-15) with the
patch below, which removes the normalization rules.  It increases the
processing time for array.cocci from 53s to 66s for me, though.  Worth
the increased precision and clarity?

Ren=C3=A9

=2D--
 contrib/coccinelle/array.cocci | 82 +++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 42 deletions(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 9a4f00cb1b..aa75937950 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -1,60 +1,58 @@
 @@
-expression dst, src, n, E;
+type T;
+T *dst_ptr;
+T *src_ptr;
+expression n;
 @@
-  memcpy(dst, src, n * sizeof(
=2D- E[...]
-+ *(E)
-  ))
+- memcpy(dst_ptr, src_ptr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_ptr))
+-                                \| sizeof(*(src_ptr))
+-                                \| sizeof(dst_ptr[...])
+-                                \| sizeof(src_ptr[...])
+-                                \) )
++ COPY_ARRAY(dst_ptr, src_ptr, n)

 @@
 type T;
-T *ptr;
-T[] arr;
-expression E, n;
+T *dst_ptr;
+T[] src_arr;
+expression n;
 @@
-(
-  memcpy(ptr, E,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(arr, E,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(E, ptr,
=2D- n * sizeof(*(ptr))
-+ n * sizeof(T)
-  )
-|
-  memcpy(E, arr,
=2D- n * sizeof(*(arr))
-+ n * sizeof(T)
-  )
-)
+- memcpy(dst_ptr, src_arr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_ptr))
+-                                \| sizeof(*(src_arr))
+-                                \| sizeof(dst_ptr[...])
+-                                \| sizeof(src_arr[...])
+-                                \) )
++ COPY_ARRAY(dst_ptr, src_arr, n)

 @@
 type T;
-T *dst_ptr;
+T[] dst_arr;
 T *src_ptr;
+expression n;
+@@
+- memcpy(dst_arr, src_ptr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_arr))
+-                                \| sizeof(*(src_ptr))
+-                                \| sizeof(dst_arr[...])
+-                                \| sizeof(src_ptr[...])
+-                                \) )
++ COPY_ARRAY(dst_arr, src_ptr, n)
+
+@@
+type T;
 T[] dst_arr;
 T[] src_arr;
 expression n;
 @@
-(
=2D- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
-+ COPY_ARRAY(dst_ptr, src_ptr, n)
-|
=2D- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
-+ COPY_ARRAY(dst_ptr, src_arr, n)
-|
=2D- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
-+ COPY_ARRAY(dst_arr, src_ptr, n)
-|
=2D- memcpy(dst_arr, src_arr, (n) * sizeof(T))
+- memcpy(dst_arr, src_arr, (n) * \( sizeof(T)
+-                                \| sizeof(*(dst_arr))
+-                                \| sizeof(*(src_arr))
+-                                \| sizeof(dst_arr[...])
+-                                \| sizeof(src_arr[...])
+-                                \) )
 + COPY_ARRAY(dst_arr, src_arr, n)
-)

 @@
 type T;
=2D-
2.37.0
