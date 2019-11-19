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
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D571F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 19:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKSTPI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 14:15:08 -0500
Received: from mout.web.de ([212.227.17.12]:54039 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfKSTPI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 14:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574190906;
        bh=u+7BCjC5OxhnhtdWKJyA0+ibZl7+P2X+9ZAYzsZgvmk=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a2fakqmaea69UTDTUysZ6WSlgaZzK+BgPj2uu0teAmmrn11sFhySzhmAUgUNWHcL6
         KF1TAUt6dq6HkAc8artStwb7AwxI/2U6qQzsHghGjIFMPFKRp14reADgW0+hJyfC98
         iETDbNlfuX5ayZwUai7o3Zd+avmVFknzWf5mMl4M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LaTid-1i8l1x1075-00mGwl; Tue, 19
 Nov 2019 20:15:06 +0100
Subject: Re: [PATCH] coccinelle: improve array.cocci
To:     Markus Elfring <Markus.Elfring@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
Date:   Tue, 19 Nov 2019 20:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:25VKRjYiFKNEjiScCRX7miqHfyDeMpZoH8QxXmTQaoopX5/hFNN
 sLJbtI25a7TfX3MmYmCgQItAOIYATeN/ThhLzeKOw+oITLc0moAlgIiSsLsOFMhPXt6vEhr
 5L2GQmc2kBkVbtYfnzlPmWIL16I+uwR1wsb8C1dnXWbgXIbsuVumXL2c/x3v1cSdznWwcRV
 DTl36iNlFvNmAyJ6rzQjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pDk7mNFsEnA=:OD3dwWfikHyPthjhqcs07T
 x7LCq48JckdLmt+fFD14MgCaA728Zrh2MFMaJ4PhTcHsLTE9V1xvD2qnOFCvaBwhGwzOXSTQb
 0Vc9GNrF6OhFrztVlsoM1xNg8nWo5sgVvK1hAOb7AXiZvsVSjbiQ0DLN+grT49u9WILDlL8zR
 OeublxedP1fJkKfasRoojP37mk/EjL/NOf2aAd5Vh6BF44+AFMUOTbcNnPtH0v1ZnNcSyXD9z
 jVxkINt/lCSCgiSaaX5gBM1o+ivZsG2sJz6n/K2wNaPzSveVlNGne4AYgR51R4LSj+OhFOT9o
 UhJLRsUQAPsI+RdCT2hteIIBhiPY5tw7xY8yZaLuzvU2+rHTq76S9ql4QuLfvxNKoJf7kwGi3
 bawUPAFuKmAGWtTUKuNmzklBFauEtp/ByRX+ZItnbbeV+cxHp8fI8hOiIcF+b7olfQFjyIUX+
 +MKzRiH9uiKNUK7eYfTt7+sN3pm+MRbfGeff8s5CjW13okNx4nLiuv9sGHC/9dbhBUOTH7+DT
 daM4+0wy3wn23TmiA8tBLqWxQ7hBf+N2ACdZzJIp4VCbEAKHFbvxdl4SN4t+eW5eAhp/wR4pJ
 RJmYXMxC8m+2PJgEQkuNbOoNiQo9O1wpwb5lnwB8j0g9NhhVv67Q7/9NwXovejqdXmTZgjEy7
 ISsWZ7wt4oGMIitIM0cseRw9oyx/3vStJnBzaHt2yNdT6e4pXiqIFJRfpYGohrlxz/tZQ8HKl
 z8j5j9v1nA+WvoPyTGqB4SvDqX9h1sGoivu6BAMpXes9MR4jxpNogapJ6mKfSk7aCzgsdDLue
 CuGtV6+R1K/ps4rxXCZG9X6/I8DUVpLAXu991D0xwDwDi8xDSd32jP8vFDHeOlUtAgscOyg0d
 2aIONEtWap0GhJA1uc4bGlrJcIPwnzJEFxmf1COOQzGNXoOMFuWrmMwtVZEtXVZ2rgTdLQvUK
 YXGNUGD/jjkbdH5EjACOTLCKZpJ1uii/UI1SP20agPaL6rMdIz8Die4Ja7rfpsbzTLM2lhnyJ
 Cf0lMAgTd57jkC7CWQL+7Nu4jNfN6MltIaq53n8bsvWzsiuyRjBuV/a15765BujUuOBf7hZRN
 xrRLh3ESm9r0nM9KBvlHfmt5vIryfyD97T+/EA3My/vCXawzsx4tYvr6DqRDb1IZd/X4Mx6ZB
 HyzOcC5Lzi3ZcpdyGzjNZR5/bTBSK0tFn9VbDVfdExslrYDYU7KiKbKy8IoqT+gVOoiuvybmB
 Eonzarz3dVa5wpwAq5HYrW8ewqReVLAqRSheqJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Am 18.11.19 um 17:10 schrieb Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 18 Nov 2019 17:00:37 +0100
>
> This script contained transformation rules for the semantic patch langua=
ge
> which used similar code.
>
> 1. Delete two SmPL rules which were used to transform source code fragme=
nts
>    (pointer expressions) so that the search pattern =E2=80=9Csizeof(T)=
=E2=80=9D would work
>    in the third rule.
>    See also the topic =E2=80=9Ccoccinelle: adjustments for array.cocci?=
=E2=80=9D:
>    https://public-inbox.org/git/f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web=
.de/
>
> 2. Combine the remaining rules by using six SmPL disjunctions.
>
> 3. Adjust case distinctions and corresponding metavariables so that
>    the desired search for update candidates can be more complete.
>
> 4. Increase the precision for the specification of required changes.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  contrib/coccinelle/array.cocci | 100 ++++++---------------------------
>  1 file changed, 18 insertions(+), 82 deletions(-)

The diff is hard to read, so here's the resulting semantic patch:

=2D- start --
@@
type T;
T[] src_arr;
expression n, dst_e, src_e;
expression* dst_p_e, src_p_e;
@@
(
(
-memcpy
+COPY_ARRAY
|
-memmove
+MOVE_ARRAY
)
       (
        dst_e,
        src_e
-       , (n) * \( sizeof(T) \| sizeof( \( *(src_p_e) \| src_e[...] \| src=
_arr \) ) \)
+       , n
       )
|
+ALLOC_ARRAY(
             dst_p_e
-                    =3D xmalloc((n) * \( sizeof( \( *(src_p_e) \| src_e[.=
..] \| src_arr \) ) \| sizeof(T) \))
+            , n)
)
=2D- end --

I like that COPY_ARRAY and MOVE_ARRAY are handled in the same rule,
as they share the same parameters and do the same -- except that
the latter handles overlaps, while the former may be a bit faster.

And I like that it's short.

I don't like that ALLOC_ARRAY is handled in the same rule, as it is
quite different from the other two macros.

Coccinelle needs significantly longer to apply the new version.
Here are times for master:

Benchmark #1: make contrib/coccinelle/array.cocci.patch
  Time (mean =C2=B1 =CF=83):     19.314 s =C2=B1  0.200 s    [User: 19.065=
 s, System: 0.224 s]
  Range (min =E2=80=A6 max):   19.009 s =E2=80=A6 19.718 s    10 runs

... and here with the patch applied:

Benchmark #1: make contrib/coccinelle/array.cocci.patch
  Time (mean =C2=B1 =CF=83):     43.420 s =C2=B1  0.490 s    [User: 43.087=
 s, System: 0.273 s]
  Range (min =E2=80=A6 max):   42.636 s =E2=80=A6 44.359 s    10 runs

The current version checks if source and destination are of the same type,
and whether the sizeof operand is either said type or an element of source
or destination.  The new one does not.  So I don't see claim 4 ("Increase
the precision") fulfilled, quite the opposite rather.  It can produce e.g.
a transformation like this:

 void f(int *dst, char *src, size_t n)
 {
-	memcpy(dst, src, n * sizeof(short));
+	COPY_ARRAY(dst, src, n);
 }

The COPY_ARRAY there effectively expands to:

	memcpy(dst, src, n * sizeof(*dst));

... which is quite different -- if short is 2 bytes wide and int 4 bytes
then we copy twice as many bytes as before.

I think an automatic transformation should only be generated if it is
safe.  It's hard to spot a weird case in a generated patch amid ten
well-behaving ones.

>
> diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.c=
occi
> index 46b8d2ee11..bcd6ff4793 100644
> --- a/contrib/coccinelle/array.cocci
> +++ b/contrib/coccinelle/array.cocci
> @@ -1,90 +1,26 @@
> -@@
> -expression dst, src, n, E;
> -@@
> -  memcpy(dst, src, n * sizeof(
> -- E[...]
> -+ *(E)
> -  ))
> -
>  @@
>  type T;
> -T *ptr;
> -T[] arr;
> -expression E, n;
> -@@
> -(
> -  memcpy(ptr, E,
> -- n * sizeof(*(ptr))
> -+ n * sizeof(T)
> -  )
> -|
> -  memcpy(arr, E,
> -- n * sizeof(*(arr))
> -+ n * sizeof(T)
> -  )
> -|
> -  memcpy(E, ptr,
> -- n * sizeof(*(ptr))
> -+ n * sizeof(T)
> -  )
> -|
> -  memcpy(E, arr,
> -- n * sizeof(*(arr))
> -+ n * sizeof(T)
> -  )
> -)
> -
> -@@
> -type T;
> -T *dst_ptr;
> -T *src_ptr;
> -T[] dst_arr;
>  T[] src_arr;
> -expression n;
> +expression n, dst_e, src_e;
> +expression* dst_p_e, src_p_e;
>  @@
>  (
> -- memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
> -+ COPY_ARRAY(dst_ptr, src_ptr, n)
> -|
> -- memcpy(dst_ptr, src_arr, (n) * sizeof(T))
> -+ COPY_ARRAY(dst_ptr, src_arr, n)
> -|
> -- memcpy(dst_arr, src_ptr, (n) * sizeof(T))
> -+ COPY_ARRAY(dst_arr, src_ptr, n)
> -|
> -- memcpy(dst_arr, src_arr, (n) * sizeof(T))
> -+ COPY_ARRAY(dst_arr, src_arr, n)
> -)
> -
> -@@
> -type T;
> -T *dst;
> -T *src;
> -expression n;
> -@@
>  (
> -- memmove(dst, src, (n) * sizeof(*dst));
> -+ MOVE_ARRAY(dst, src, n);
> -|
> -- memmove(dst, src, (n) * sizeof(*src));
> -+ MOVE_ARRAY(dst, src, n);
> +-memcpy
> ++COPY_ARRAY
>  |
> -- memmove(dst, src, (n) * sizeof(T));
> -+ MOVE_ARRAY(dst, src, n);
> +-memmove
> ++MOVE_ARRAY
> +)
> +       (
> +        dst_e,
> +        src_e
> +-       , (n) * \( sizeof(T) \| sizeof( \( *(src_p_e) \| src_e[...] \| =
src_arr \) ) \)
> ++       , n
> +       )
> +|
> ++ALLOC_ARRAY(
> +             dst_p_e
> +-                    =3D xmalloc((n) * \( sizeof( \( *(src_p_e) \| src_=
e[...] \| src_arr \) ) \| sizeof(T) \))
> ++            , n)
>  )
> -
> -@@
> -type T;
> -T *ptr;
> -expression n;
> -@@
> -- ptr =3D xmalloc((n) * sizeof(*ptr));
> -+ ALLOC_ARRAY(ptr, n);
> -
> -@@
> -type T;
> -T *ptr;
> -expression n;
> -@@
> -- ptr =3D xmalloc((n) * sizeof(T));
> -+ ALLOC_ARRAY(ptr, n);
> --
> 2.24.0
>
