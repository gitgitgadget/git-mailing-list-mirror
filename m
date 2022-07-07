Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBEAC433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 19:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiGGTLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiGGTLr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 15:11:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6226AD8
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657221091;
        bh=jnlqkIFvz6wCsalkHLQji41JYHIFhv9wF1oSaMUvwSY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j9mcClqJ1j2T+EEj+yAHlq8kWPTFiRpWsKz1rIm3qYDnDjKI1jagyY5ESlPPdjcLR
         jBEwJYQ8r7mbSsIqh0idpMYEMUh/WSoOAMjH8OZteKTtNkNhAvsxT7Qo16s9gHt9bq
         T62K2Hl/y9QZAyV9ygUZtV9YFhzap66o7Ep7Qiww=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq1CA-1nn6Bc3PpC-00n3ji; Thu, 07
 Jul 2022 21:11:30 +0200
Message-ID: <cb866b8c-dcc6-557f-da23-1c1972619a8a@web.de>
Date:   Thu, 7 Jul 2022 21:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0
Subject: Re: [PATCH] builtin/mv.c: use correct type to compute size of an
 array element
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <xmqq8rp54r4l.fsf@gitster.g>
 <220707.86y1x585wy.gmgdl@evledraar.gmail.com> <xmqq1quw23r8.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1quw23r8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQ1e2IUTcXSbDAdBJCsVg/5MdoWvOz8tLD6q7cfMP575Foru0BS
 nnppuCtlwiPIs1PK3yKBsA/MZh1MfC4rg9m9M55Wy170bW5/r3Y7FzzZUdUalHsai2pvIWx
 5bzDPTgdI4wElkTclz1cejecld34/QO2FbeIRJ2QOUVejxi7tVZBLtxah0oC1Aqy389Gxdw
 fsgUM5TSnsxukel/BQsyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G3Xk1ocG578=:d5a44AR3FvO723HjR4HL/j
 tDPz2JGL8quadOtfLaDb/2pFwQFsvzbjLhHRNqmJyORx4JdhxzllhyUuMlPfrTyYFQiK6hoSA
 o6Aj0j/4bQCzs3UvdVQi04Z2vi6cUWROBLVw4afRFxsQSOEML0nJnMWfyj0R4yiwZTUuerYFb
 e52ydvBV2eAZHLrXBiOogLdW6dhIVq9uncFTTtdZxA+0TyiihKiTmec6gDHggAHFB5YzzQIBE
 lU8uCf+dZ4maDc0Oxny30g0tv9rlnwVQl1rCV0u337ik+XZv3w+SQ19HEPEmqcGCIpdCxMUuA
 IvR9qiFqspga8NPo2JBxuioA88/u8R6GEaWxD/+EQYIM6jZswlY/ANALCFCjG714doGbBJHHu
 Zh28wlZm6Ms/5dL0eGosq+1GchvQfEEiROkpwz+ArnqZ67v67EcUNA7k8gCWiMeAjouyWf6N5
 7N/oiyPSEhyYtEUZZBhf3+grTI5D3CPExM3Egl1S3SwbGFCSZMuot7C2p7gCPAVkKKBAbJdkR
 Ux5wNkJyj0a9+5efvcljegWvbhsvfiCzNGgnmJ7sWNVfY56XAekr2iUsK7c9KtdwcWFIbpSVt
 Y2AsrXLJZDtIuU6wNnbPt1ZWaghRfZ5+BJDH/ShdAdqwjKSB3RtO9qCM6bFTiXbzk5qxRNZyh
 XGnhJ7kuMp8PR/+8qfeoDvYtGYqXbJXDs5fjNaEfBXWw8hqSc5KcXpAAARVJ5mz94GLlldcYv
 DdJ7upwTFPP0GfjiZs+trn03+MFPD3ydtoiewKK+ccvgzTzGFMCWfbTKXWZWQCYK9qMjUyChX
 P1PajV/yg2WgMHhKyAlZaaBU+Rlt8wtI/uYypWKcXfbXklcZ91Rf+bh5dinthJskhDTM7JcLv
 oBLn2/cx3aVoRcMYP/w320oEfv9lmmebrQx06n1HdBtXNlPfeuwouEHg/MaHDb1fIBXgq4xey
 jXgZfTeGVh45n8XI8YYLei0uxmaRlk5LnXUaQh+nU97KQCCE1JRIXsnxCrK4G00XTYA1AKD/H
 xVFQY0vD9aD87M4eR1vX5vMtPH5/evYVoK8GKvv7NQovYQ0DtsGe4eSWHPwmnkg2grHEXlDuM
 eukFaULv3GPjMI8ptFIpz2fzOjc/7uuBP5I
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.07.22 um 20:10 schrieb Junio C Hamano:
> While our eyes are on array.cocci, I have a few observations on it.
>
> This is not meant specifically to you, =C3=86var, but comments by those
> more familiar with Coccinelle (and I am sure the bar to pass is
> fairly low, as I am not all that familiar) are very much
> appreciated.
>
>     @@
>     expression dst, src, n, E;
>     @@
>       memcpy(dst, src, n * sizeof(
>     - E[...]
>     + *(E)
>       ))
>
> This seems to force us prefer sizeof(*(E)) over sizeof(E[i]), when
> it is used to compute the byte size of memcpy() operation.  There is
> no reason to prefer one over the other, but I presume it is there
> only for convenience for the other rules in this file (I recall
> vaguely reading somewhere that these rules do not "execute" from top
> to bottom, so I wonder how effective it is?).

It halves the number of syntax variants to deal with.

>
>     @@
>     type T;
>     T *ptr;
>     T[] arr;
>     expression E, n;
>     @@
>     (
>       memcpy(ptr, E,
>     - n * sizeof(*(ptr))
>     + n * sizeof(T)
>       )
>     |
>       memcpy(arr, E,
>     - n * sizeof(*(arr))
>     + n * sizeof(T)
>       )
>     |
>       memcpy(E, ptr,
>     - n * sizeof(*(ptr))
>     + n * sizeof(T)
>       )
>     |
>       memcpy(E, arr,
>     - n * sizeof(*(arr))
>     + n * sizeof(T)
>       )
>     )
>
> Likewise, but this one is a lot worse.
>
> Taken alone, sizeof(*(ptr)) is far more preferrable than sizeof(T),
> because the code will be more maintainable.
>
>     Side Note.  I know builtin/mv.c had this type mismatch between
>     the variable and sizeof() from the beginning when 11be42a4 (Make
>     git-mv a builtin, 2006-07-26) introduced both the variable
>     declaration "const char **source" and memmove() on it, but a
>     code that starts out with "char **src" with memmove() that moves
>     part of src[] and uses sizeof(char *) to compute the byte size
>     of the move would become broken the same way when a later
>     developer tightens the declaration to use "const char **src"
>     without realizing that they have to update the type used in
>     sizeof().
>
> So even though I am guessing that this is to allow the later rules
> to worry only about sizeof(T), I am a bit unhappy to see the rule.
> If an existing code matched this rule and get rewritten to use
> sizeof(T), not sizeof(*(ptr)), but did not match the other rules to
> be rewritten to use COPY_ARRAY(), the overall effect would be that
> the automation made the code worse.

True.

>
>     @@
>     type T;
>     T *dst_ptr;
>     T *src_ptr;
>     T[] dst_arr;
>     T[] src_arr;
>     expression n;
>     @@
>     (
>     - memcpy(dst_ptr, src_ptr, (n) * sizeof(T))
>     + COPY_ARRAY(dst_ptr, src_ptr, n)
>     |
>     - memcpy(dst_ptr, src_arr, (n) * sizeof(T))
>     + COPY_ARRAY(dst_ptr, src_arr, n)
>     |
>     - memcpy(dst_arr, src_ptr, (n) * sizeof(T))
>     + COPY_ARRAY(dst_arr, src_ptr, n)
>     |
>     - memcpy(dst_arr, src_arr, (n) * sizeof(T))
>     + COPY_ARRAY(dst_arr, src_arr, n)
>     )
>
> I take it that thanks to the earlier "meh -- between sizeof(*p) and
> sizeof(p[0]) there is no reason to prefer one over the other" and
> "oh, no, we should prefer sizeof(*p) not sizeof(typeof(*p)) but this
> one is the other way around" rules, this one only has to deal with
> sizeof(T).
>
> Am I reading it correctly?

Yes.  Without the ugly normalization step in the middle could either
use twelve cases instead of four here or use inline alternatives,
e.g.:

type T;
T *dst_ptr;
T *src_ptr;
T[] dst_arr;
T[] src_arr;
expression n;
@@
(
- memcpy(dst_ptr, src_ptr, (n) * \( sizeof(*(dst_ptr)) \| sizeof(*(src_ptr=
)) \| sizeof(T) \) )
+ COPY_ARRAY(dst_ptr, src_ptr, n)
|
- memcpy(dst_ptr, src_arr, (n) * \( sizeof(*(dst_ptr)) \| sizeof(*(src_arr=
)) \| sizeof(T) \) )
+ COPY_ARRAY(dst_ptr, src_arr, n)
|
- memcpy(dst_arr, src_ptr, (n) * \( sizeof(*(dst_arr)) \| sizeof(*(src_ptr=
)) \| sizeof(T) \) )
+ COPY_ARRAY(dst_arr, src_ptr, n)
|
- memcpy(dst_arr, src_arr, (n) * \( sizeof(*(dst_arr)) \| sizeof(*(src_arr=
)) \| sizeof(T) \) )
+ COPY_ARRAY(dst_arr, src_arr, n)
)

I seem to remember that rules like this missed some cases, but perhaps
that's no longer an issue with the latest Coccinelle version?

>
>     @@
>     type T;
>     T *dst;
>     T *src;
>     expression n;
>     @@
>     (
>     - memmove(dst, src, (n) * sizeof(*dst));
>     + MOVE_ARRAY(dst, src, n);
>     |
>     - memmove(dst, src, (n) * sizeof(*src));
>     + MOVE_ARRAY(dst, src, n);
>     |
>     - memmove(dst, src, (n) * sizeof(T));
>     + MOVE_ARRAY(dst, src, n);
>     )
>
> What I find interesting is that this one seems to be able to do the
> necessary rewrite without having to do the "turn everything into
> sizeof(T) first" trick.  If this approach works well, I'd rather see
> the COPY_ARRAY() done without the first two preliminary rewrite
> rules.

It doesn't support arrays (T[]).  That doesn't matter in practice
because we don't have such cases (yet?).

>
> I wonder if the pattern in the first rule catches sizeof(dst[0])
> instead of sizeof(*dst), though.

It doesn't.

>
>     @@
>     type T;
>     T *ptr;
>     expression n;
>     @@
>     - ptr =3D xmalloc((n) * sizeof(*ptr));
>     + ALLOC_ARRAY(ptr, n);
>
>     @@
>     type T;
>     T *ptr;
>     expression n;
>     @@
>     - ptr =3D xmalloc((n) * sizeof(T));
>     + ALLOC_ARRAY(ptr, n);
>
> Is it a no-op rewrite if we replace the above two rules with
> something like:
>
> .   @@
> .   type T;
> .   T *ptr;
> .   expression n;
> .   @@
> .   (
> .   - ptr =3D xmalloc((n) * sizeof(*ptr));
> .   + ALLOC_ARRAY(ptr, n);
> .   |
> .   - ptr =3D xmalloc((n) * sizeof(T));
> .   + ALLOC_ARRAY(ptr, n);
> .   )

I think so.

>
> or even following the pattern of the next one ...
>
> .   @@
> .   type T;
> .   T *ptr;
> .   expression n;
> .   @@
> .   - ptr =3D xmalloc((n) * \( sizeof(*ptr) \| sizeof(T) \))
> .   + ALLOC_ARRAY(ptr, n);
>
> ... I have to wonder?  I like the simplicity of this pattern.

In theory this is equivalent.

>
>     @@
>     type T;
>     T *ptr;
>     expression n !=3D 1;
>     @@
>     - ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \) )
>     + CALLOC_ARRAY(ptr, n)
>
> And this leaves xcalloc(1, ...) alone because it is a way to get a
> cleared block of memory that may not be an array at all.  Shouldn't
> we have "n !=3D 1" for xmalloc rule as well, I wonder, if only for
> consistency?

I agree that a single-element array is a bit awkward, so allowing the
explicit sizeof in that case is less iffy.  ALLOC/CALLOC macros for
single items might make that automation more palatable..

Ren=C3=A9
