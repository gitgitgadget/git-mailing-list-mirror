Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB8C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A4F64F03
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 01:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhBYBjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 20:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhBYBjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 20:39:45 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8A4C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:39:05 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id o3so4539160oic.8
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 17:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xfkjuCdKz7JNdSgrocoGMDkSvgqG9gRjZKs8vmfmgGw=;
        b=pI8Vd3hcmj2GQMxvcv6aD589yrtn4LpSzS0Dtajc+ps/wGzhSPlX5JMe0ir0DJYlGX
         Ah/xx1Xq3yj8p0DHkg/wC1Kx6ZeUNuRx1ak+9WuRYjM8FrzU0qdQz6kcpR2worGy2Xra
         HFf93NYiMWXBo9dStMrxXbAbLtQNEQR+XvrDNpUSv3dq5C3mhZkFquxXIEXh/jtPLrfn
         C3uAuPiVqcTzfZlTVWtcK7TTGlXztMygxl6vj4ovO0ihlTjUuR71UyJ7X+a5oTAI3tjg
         yL42wqaLfjyW/dHVBV6Rj+o4GudpJgFHlJP1mrlAM9zft6d9X+t3hKxGHH1e4pKqPf7/
         J0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xfkjuCdKz7JNdSgrocoGMDkSvgqG9gRjZKs8vmfmgGw=;
        b=KES36lujOy6zYLuDxY/BRUjuXDsqfCgv8x6mB/4upmHJXOQgybG/F1dCNhSPBRPg/q
         X0VKns5ITBO+M7qhIRRZOLTZkn9qExsZEHHPAZFZDI33Cf79+fInebpO+lZdExPdb7eR
         BmOkS32RRQQthIzK0drA1dfcHe8vVgsbbQniOGOt5KNJ0HOh2PyAarCAUxwrY+/V5C+4
         xbwWZUysJkvxL7vLZYkpMDVSKBH2A2kqFE7iLQEGhlvmgnfdhHX3qMZSTS1mCIJVb8Hp
         RMqKTScUO3yg29Iyl7cW0Vx6dDvZ3F7OCg+e8JbZhO/DqeHDvm6ADnpWtbwCrJ2nU1/E
         nuBA==
X-Gm-Message-State: AOAM530ajbFlcB1HWhCBNvsxiqqsixax+h3QxuLnRKxyiEw/Mpaxa9pP
        G4wASnqjNaGgTHpFIyDIB6HEwBILVfB+benFEynob934CQM=
X-Google-Smtp-Source: ABdhPJw1m1YLeNVp3QupyvG97wNX4Dp80az3R1EtkFWKtN3ZlDqmE0XmTa1P5J1suDm7TnnDX/jjQqVASxfJ9QhCg+4=
X-Received: by 2002:aca:b407:: with SMTP id d7mr349233oif.167.1614217144125;
 Wed, 24 Feb 2021 17:39:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com> <22419bc6-d35a-7537-d388-d51c24138f5f@gmail.com>
In-Reply-To: <22419bc6-d35a-7537-d388-d51c24138f5f@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 17:38:52 -0800
Message-ID: <CABPp-BH0NABbHqY1ZfcatiEryrqXLbv=qQKJKKzsGp-4=tWTEA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Optimization batch 8: use file basenames even more
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 9:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/23/2021 6:43 PM, Elijah Newren via GitGitGadget wrote:
> > This series depends on en/diffcore-rename (a concatenation of what I wa=
s
> > calling ort-perf-batch-6 and ort-perf-batch-7).
> >
> > There are no changes since v1; it's just a resend a week and a half lat=
er to
> > bump it so it isn't lost.
>
> Thank you for re-sending. I intended to review it before but got redirect=
ed
> and forgot to pick it up again.
>
> > =3D=3D=3D Results =3D=3D=3D
> >
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28), =
the
> > changes in just this series improves the performance as follows:
> >
> >                      Before Series           After Series
> > no-renames:       12.775 s =C2=B1  0.062 s    12.596 s =C2=B1  0.061 s
> > mega-renames:    188.754 s =C2=B1  0.284 s   130.465 s =C2=B1  0.259 s
> > just-one-mega:     5.599 s =C2=B1  0.019 s     3.958 s =C2=B1  0.010 s
> >
> >
> > As a reminder, before any merge-ort/diffcore-rename performance work, t=
he
> > performance results we started with (as noted in the same commit messag=
e)
> > were:
> >
> > no-renames-am:      6.940 s =C2=B1  0.485 s
> > no-renames:        18.912 s =C2=B1  0.174 s
> > mega-renames:    5964.031 s =C2=B1 10.459 s
> > just-one-mega:    149.583 s =C2=B1  0.751 s
>
> These are good results.
>
> I reviewed the patches and believe they do the optimizations claimed. I
> only found some nits for comments and whitespace things.

Thanks for taking a look; I'll get those fixed up.  Also, I think your
performance improvement of switching from xstrfmt to a few strbuf
calls, even if small, counts as more than "nits for comments and
whitespace things".  :-)

> You are very careful to create the necessary pieces and connect them
> from the bottom-up. However, this leads to one big "now everything is
> done" commit with performance improvements. It seems that there are
> some smaller performance improvements that could be measured if the
> logic was instead built from the top-down with stubs for the complicated
> logic.
>
> For example, the final patch links the rename logic with a call to
> idx_possible_rename(). But, that could just as well always return -1
> and the implementation would be correct. Then, it would be good to see
> if the performance changes with that non-functional update. It would
> also help me read the series in patch order and understand the context
> of the methods a bit better before seeing their implementation.
>
> This is _not_ a recommendation that you rewrite the series. Just food
> for thought as we continue with similar enhancements in the future.

I can give it a shot for future relevant patch series (some of the
series this wouldn't be relevant for because they just include a
collection of patches implementing separate improvements that are just
batched together).  A couple of the series are already structured this
way, in fact, but the next series after this one has one patch that I
think I could reorder to make it more like this.
