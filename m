Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84018C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C661B5D
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbhHPJOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbhHPJOC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:14:02 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE0C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:13:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h29so1239258ila.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u8JDnkXOIJPo5ChkqNb5NxK0pBPdHxdiwITKemDhaSg=;
        b=THrfd5G56sIvH7WOIquQQz5JDWu9AnnERzJqGdTapPpesYPHe/M24nE/4vngiux9EA
         MfkUrPb7yahp2HPcsK31/FSGPrg4xGPyjQNloVJa3xKBa7hT2y1tsVOPxUI93ky6TFwv
         5n9dLqpvchs2ebAjnJNOMdzp5Ze/P5KqmT/Su8EGGqZRPW3n+yAYhrOYHLRBmXDr3GpK
         SPzKLMyQkfVQU77sQ65nJRE/RvJZkkPSB4hu5Ij9IpAlYl6FyGIx3R5vZ6FjNKO0SxWU
         GXoLA/ktiUAaCKVXzdJUqdd0EUgKo2/my22/hrUggstlVkA7B9Hr4VL8R7n3PAiLzRNr
         hMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u8JDnkXOIJPo5ChkqNb5NxK0pBPdHxdiwITKemDhaSg=;
        b=bEg0rF6kgHweZsf1ZVUn6qvAA3DVPTJJUoYvoJA0NhkIQDTKNYvQO2m+BNNUYqBeEQ
         5qCseNhB9+8cR2r4q91FpDdN02Rnfzp+tJ1FAs8BIjuAi0k1oC0GGaiyddpzBLoWYqnW
         0r1V4J5dsc7uyJf9AhEdVmN1mnhTHLz1BXya+SRWtAgmXid/vip3Rsyl0sYkbU6vuFVH
         JHPfrTRl4bKI9pSlgZUSODDNgxJPQCahY81oU7XrV5JLVZekLdoO/CmSHAFHtmcyhjLk
         MhbCUYpA1xhHoPvua9ticqN9cE/rZ2MbKeZOow1UZHyOJcGZVeNnHAQhUyVCmx1VqHu/
         E7gQ==
X-Gm-Message-State: AOAM531y/utrgZrhJm5qYXsKmrUmmZ7C888AHf2tUuIuS9+yrzYZct2D
        TViXvdKLy9/tDpsfS4YpSMwzZ/nhBIurf6xRgkI=
X-Google-Smtp-Source: ABdhPJyF/9EN+myZXxoGdFK9D49nbII5XS6jHjVIv45aaaBblftaUn863oTzc7U7OW5xePB9DFKQCo5fPU34k6+dlSw=
X-Received: by 2002:a05:6e02:190d:: with SMTP id w13mr11554209ilu.53.1629105210984;
 Mon, 16 Aug 2021 02:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8Q6f-B05bQ+XCDuGGk5KTS1o3QatGbeJ-FQiqFCYGW7Og@mail.gmail.com>
 <CAP8UFD3FpnmOi50iUuFa9qMzi=PVP_Kcod6T+8BzJNq5X-cmgw@mail.gmail.com>
In-Reply-To: <CAP8UFD3FpnmOi50iUuFa9qMzi=PVP_Kcod6T+8BzJNq5X-cmgw@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 16 Aug 2021 17:13:19 +0800
Message-ID: <CAOLTT8Rfai0bHJaUYHLU05guEApOacOhurjTZrP+VEw0YwenPA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 13
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=
=8815=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=886:28=E5=86=99=E9=81=93=
=EF=BC=9A
>
> > I think the key to continuing to optimize is still to reduce unnecessar=
y copies.
>
> Do you have data or hints about this?
>

Here is the result of perf diff with git cat-file --batch-check
--batch-all-objects
between upstream/master and cat-file-reuse-ref-filter-logic:

# Event 'cycles:u'
#
# Baseline  Delta Abs  Shared Object     Symbol
# ........  .........  ................  ..................................
#
    18.08%     -2.11%  libz.so.1.2.11    [.] 0x0000000000008dde
               +2.09%  libc-2.33.so      [.] malloc_consolidate
    21.65%     -1.70%  git               [.] unpack_object_header_buffer
     5.62%     -1.57%  git               [.] use_pack
     0.59%     +1.49%  libc-2.33.so      [.] _int_free
               +1.40%  git               [.] get_object
    13.62%     -1.39%  libz.so.1.2.11    [.] inflate
     1.54%     -0.98%  libc-2.33.so      [.] __strchrnul_avx2
               +0.90%  git               [.] format_ref_array_item
               +0.82%  git               [.] populate_value
     0.77%     +0.74%  libc-2.33.so      [.] __strlen_avx2
     0.37%     +0.68%  libc-2.33.so      [.] cfree@GLIBC_2.2.5
               +0.56%  git               [.] append_literal.isra.0
     0.32%     +0.53%  libc-2.33.so      [.] malloc
     1.09%     -0.48%  git               [.] get_size_from_delta
     0.77%     -0.46%  git               [.] oid_array_for_each_unique
     2.48%     -0.45%  git               [.] get_delta_base
     0.20%     +0.41%  libc-2.33.so      [.] _IO_fwrite
               +0.41%  git               [.] batch_object_write.constprop.0
               +0.40%  git               [.] quote_formatting
               +0.39%  git               [.] get_ref_atom_value
     0.31%     +0.38%  git               [.] strbuf_add
               +0.36%  libc-2.33.so      [.] __libc_calloc
     0.41%     +0.35%  [unknown]         [k] 0xffffffff84c00158
     0.58%     -0.33%  libc-2.33.so      [.] unlink_chunk.constprop.0
     1.04%     -0.31%  libc-2.33.so      [.] __GI___qsort_r
               +0.30%  git               [.] 0x000000000001cd80
               +0.30%  git               [.] append_atom
     3.23%     +0.30%  libc-2.33.so      [.] __memmove_avx_unaligned_erms

malloc_consolidate(), _int_free(), malloc(), __libc_calloc(), they
take up a larger
proportion of time (through gprof, we can also see that the number of
calls is also
increasing), it shows that our memory allocation is worth optimizing.

__memmove_avx_unaligned_erms() take up a larger proportion of time,
it shows that we have some unnecessary copies.

Note that 4602b62 ([GSOC] ref-filter: reuse finnal buffer if no stack
need) is trying
to alleviate this problem, and the results show that it does have a 2%
optimization.

So today I added two new commits to verify my guess: We need to reduce copy=
ing.
See: https://github.com/adlternative/git/commits/cat-file-reuse-ref-filter-=
logic-temp-5


Test                                        upstream/master   this
tree
---------------------------------------------------------------------------=
---------
1006.2: cat-file --batch-check              0.08(0.06+0.01)
0.08(0.06+0.01) +0.0%
1006.3: cat-file --batch-check with atoms   0.06(0.04+0.01)
0.07(0.06+0.01) +16.7%
1006.4: cat-file --batch                    0.49(0.47+0.02)
0.47(0.46+0.00) -4.1%
1006.5: cat-file --batch with atoms         0.47(0.45+0.01)
0.46(0.46+0.00) -2.1%

This is good news. The performance of our git cat-file --batch is
better than before!

> Have you looked at why there is still +16.7% in the cat-file
> --batch-check with atoms case? Maybe solving this would improve things
> in the other cases too.
>

I am continuing to think about it, I guess it is still a
malloc/free/memmove problem.
The execution time of git cat-file --batch-check is relatively short,
and the disadvantages
of using ref-filter logic will be more prominent.

> > ### Additional advice
> >
> > During the optimization process this week, I found that I might want
> > to use a `strbuf_move()` function, although I did not adopt it in my wo=
rk
> > (because it did not allow my work to be greatly optimized), but I think=
 it might
> > be useful in some situations: We don=E2=80=99t want to copy the data of=
 strbuf,
> > but just want to move its buf pointer:
>
> Yeah, if we are sure that it improves performance, that might be worth it=
.
>
> About your patch series
> (https://lore.kernel.org/git/pull.1016.git.1628842990.gitgitgadget@gmail.=
com/),
> I wonder if it might be possible and better to have some performance
> improvements before the commit that uses the ref-filter code
> ("cat-file: reuse ref-filter logic"). If you are going this way, it
> might make sense to add a few performance tests, if some don't already
> exist, to show the effect of these performance improvements on the
> ref-filter code when it's used by other commands like for-each-ref.
>
> This could show that these performance improvements are worth doing
> even if we didn't want to reuse the ref-filter code in cat-file. And
> then perhaps these performance improvements could be merged as part of
> one or more small patch series, before the patch series that reuses
> the ref-filter code in cat-file.
>

Ah, this is estimated to take a lot of effort. I feel that it will
take a long time
for these optimization patches to be merged into the master.

I tried to add a performance test for for-each-ref, but the effect is very
insignificant, because its execution time is too short.

> Best,
> Christian.

Thanks.
--
ZheNing Hu
