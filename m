Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC9A1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 16:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKRQKh (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 11:10:37 -0500
Received: from mout.web.de ([212.227.17.12]:40687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfKRQKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 11:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574093434;
        bh=nu9U55kbYU7qtf1kiIwcaGs0KBM568Omvs+V/YqrIcE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Pd7dR6207+p058C6Ne2yeIG5xnf09G8BABuYJ8CC7IZfJj80npezCstEjjqISQ2gF
         dIR+7IjB/b312K3jkbss91PKANOlzXwF7ViR8hNy1PZgz2Gd1PFlSzq1/veCA028cF
         0v8Gjdwkb/YZaQwpixLQ+LJH6mXwtkj3AnfNZwjk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.191.247]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1XDJ-1hiDUB0A6j-00tUjU; Mon, 18
 Nov 2019 17:10:34 +0100
Subject: [PATCH] coccinelle: improve array.cocci
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
Date:   Mon, 18 Nov 2019 17:10:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kxv356aeZPJibu28xdL+Za+tTBgKLJhPwjyL3WbdVq5/45bS0B/
 h7zKEXyRyRzbmOetJkgr0LTyr+4jCfAnS4ccv16qsOq1CsfR24Zr7P0DI+WKpoKKC+HPFKI
 5PToFeFgPteXCYmoDwb0Sl4xRQ3xgsuI/Xu4mmycWUbR3Gx0e+oXaRJp9xu6Pmbk/gHvRne
 D7UXGRyIN/fk1BLmBkc2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JbgNl/FOyJc=:jLYNMl2WK1RIbbfHp9QYec
 JxDJ01ZCHSIA/8PrD6gfLo/F2uvqMnxQGI0kDWt6+K5pBpFI4azixQd2ScEhpU8pFg7LnKuUN
 SGQFRXWctHGrYzrEjIZ+HFLoAPj+cNUEEFPDabLlXcx+dstvr9KX2v4hV6+JbzwZr2uCqun90
 C03zx3z9yJ0Jvzit81STAZyTuaaVN0SAJFd3GwhpNsBuEzFjpe7wKlD47CVwVdvMsgYdltyib
 3fdikJD8whHgcuna/sXhTp+AppyaVcoNdiphja/In3xJLVlhGM1bbz79jHi04HuJhfIuvFqaW
 QnjeoTgWKUk/9zBbC0X1bVaAsPNQ/Rh3LgYV3ogsqUafb0vqKZhpfIzPsyON5UB2B38dbuUq5
 MhhmqogtV4Fkych2hsrMiBSZudlD6rPG+HvZS4Idn4onEHU4W+JBpM4gxOCrNVU/lkjPhMrfS
 F3zW1O36RJ06ohmEGJ44l+hdnule0Ms1z0oPGiVRAj6yHvEMhXxSzndt4Jp6rHL2INi09Pqat
 lXzeB6sVTZnIJ+fETt12L0C9y4LYJPVkWKjl2EQIdfEEvT017x9KHiusjzoCB2IckjZnVQs7g
 nx7l23Xq9CVq6xkEWq8sS/6lnhEAV7dgrqENG6zdpeVMWVnEE84q8zYzZjIheppGdoAx2uE2K
 hs3HAZ/d5ep720qgOJpAB5wLqrHGjulBGDFWEIiyf3YQJiWst7lTfCXdbdGvhAyP8MugJfrq/
 fwZct9q5n/i+0DwMtqvqath5OTMpDyiqTk4QwVgf2qzLjMc4Kw3MBSHNdcPAA40mjZ4joD2Ba
 NTHATWGSSKGHZod70kzLvE/n/PK3Ikzl9y7IilXfNKK3qLxYrH43rAGnYEuk9Ws5x1xP2OoCw
 hIRGLcaQXUKPZzOBJ5i+KNQRZrG5WMiEpgrtQKAZvep5H8VZDd8EuvyBwn+Gypf2Fusuaf59u
 u/B+ohj7xjkI8/wHah7PaYs34Pd7afb2m/cfnYOD2sqSbUbSvYxEQndpwDBwbDS7/6XSJpqjO
 Bp1JR5x37SiggHUsO5pij9rrzONGTH1PstJNMF2d+ee5ALMMb8/1xAfQkSq8w0hr0nTcsnnxA
 YPVOr+W81ReNOHpKzzlu2MRVZaGJbG/DIrKhu14rFtjY5cPcmgQXfCHnbIs2Nu7wnbeaNdiUg
 DIUk6L040nJ6wLGAhLuxohja2VpxAAkau5aB/RKJ81X6+eHkvL9e9eTXcDSw37JUNuRA3aUmV
 ohPTZjWMSzFLrxBmR3ZB0ogfcEI1tP4RwemVfyQ7ejB2RfnCux8spK3YuIfQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 18 Nov 2019 17:00:37 +0100

This script contained transformation rules for the semantic patch language
which used similar code.

1. Delete two SmPL rules which were used to transform source code fragment=
s
   (pointer expressions) so that the search pattern =E2=80=9Csizeof(T)=E2=
=80=9D would work
   in the third rule.
   See also the topic =E2=80=9Ccoccinelle: adjustments for array.cocci?=E2=
=80=9D:
   https://public-inbox.org/git/f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.d=
e/

2. Combine the remaining rules by using six SmPL disjunctions.

3. Adjust case distinctions and corresponding metavariables so that
   the desired search for update candidates can be more complete.

4. Increase the precision for the specification of required changes.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 contrib/coccinelle/array.cocci | 100 ++++++---------------------------
 1 file changed, 18 insertions(+), 82 deletions(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 46b8d2ee11..bcd6ff4793 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -1,90 +1,26 @@
-@@
-expression dst, src, n, E;
-@@
-  memcpy(dst, src, n * sizeof(
=2D- E[...]
-+ *(E)
-  ))
-
 @@
 type T;
-T *ptr;
-T[] arr;
-expression E, n;
-@@
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
-
-@@
-type T;
-T *dst_ptr;
-T *src_ptr;
-T[] dst_arr;
 T[] src_arr;
-expression n;
+expression n, dst_e, src_e;
+expression* dst_p_e, src_p_e;
 @@
 (
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
-+ COPY_ARRAY(dst_arr, src_arr, n)
-)
-
-@@
-type T;
-T *dst;
-T *src;
-expression n;
-@@
 (
=2D- memmove(dst, src, (n) * sizeof(*dst));
-+ MOVE_ARRAY(dst, src, n);
-|
=2D- memmove(dst, src, (n) * sizeof(*src));
-+ MOVE_ARRAY(dst, src, n);
+-memcpy
++COPY_ARRAY
 |
=2D- memmove(dst, src, (n) * sizeof(T));
-+ MOVE_ARRAY(dst, src, n);
+-memmove
++MOVE_ARRAY
+)
+       (
+        dst_e,
+        src_e
+-       , (n) * \( sizeof(T) \| sizeof( \( *(src_p_e) \| src_e[...] \| sr=
c_arr \) ) \)
++       , n
+       )
+|
++ALLOC_ARRAY(
+             dst_p_e
+-                    =3D xmalloc((n) * \( sizeof( \( *(src_p_e) \| src_e[=
...] \| src_arr \) ) \| sizeof(T) \))
++            , n)
 )
-
-@@
-type T;
-T *ptr;
-expression n;
-@@
=2D- ptr =3D xmalloc((n) * sizeof(*ptr));
-+ ALLOC_ARRAY(ptr, n);
-
-@@
-type T;
-T *ptr;
-expression n;
-@@
=2D- ptr =3D xmalloc((n) * sizeof(T));
-+ ALLOC_ARRAY(ptr, n);
=2D-
2.24.0

