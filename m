Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FCBC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2219F61410
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 19:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhGATZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhGATZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 15:25:13 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A26C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 12:22:43 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id a133so8488586oib.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 12:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hizT7S6IBH4S88WWXddYRlKJuyJa4d4/qdSjI6wUUJM=;
        b=i2FF1PBB8q5TS3o2t5AtZ39ELVN+kMtvfXQxlPfTVQCESV69FZwq2LtjLFux8tG40B
         4sqdGtHHSVIIu9l9boAvtr4xDYncWXb8kV/vGmdrA9pb2pqJIRpjkbm2lfb25H7db0ki
         yOHwXQSY/1pqDiTk6Gj6/aBuMH6pWWBlTJNIoNrUhGxScWsIyGiRrQj5NB7pL80Nu1Q/
         vn66GM2SyEiKkjQR+p5x/ZKAC8IWsQK5X0ItVa9OIniD2kZoRO6ECYBPKekqyks5Vqhk
         2deXC7QtNB0iHzrUsj1WZkZfVlIzZ7mWuP061UE7grRmbvpy0Ct5QPUcvaabuTTHD8nW
         m7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hizT7S6IBH4S88WWXddYRlKJuyJa4d4/qdSjI6wUUJM=;
        b=S1/GnROQA8jvBtcZF6jQWgPBMwEH1Xyalk8GHel/wq4SsFsxPRQWtC8hQwvQNXzWfm
         FiyZamCvLMaLLQgsz9xM44Ah23Gt4dTJWsWL023WtP55iLtOS3eWGHG5lcMX2OYj6jaJ
         hSOsTIihRdqiHy5DFqKjBdh5FJPauBbGU3Fxk5PHd3mNG6IRnUjTuUV/ylW5fGFiSbGJ
         2zDejyJAxWmrvRk7vnKMgiEV3nA2Uz6XgE4arMEgtxT5a2q6p80PkcfTRdGl+d6PpzsO
         vROFP9PEkOTV4Q7t8QIZu292AXHltdimcJ0QAEi6n6HC3Tl8fquMt4Qb10Zl6+v6FPUK
         yDlw==
X-Gm-Message-State: AOAM530vPtn3vvBGtc/jcHGFvHAgu39Z0J4730bpI8XEWekvWe/1jj0+
        Me2CmDTl2tSvDKIrNYZ3z3gD4Pm6n5WJQYPzNCs=
X-Google-Smtp-Source: ABdhPJw0Lzn6iMRoqSvI3mWpS9ifrymRiGJzlQ55hP8T+2UeOzFq7EX7myOaykGnCw3uYS2RnjW2OW9isdtYjL3FWyg=
X-Received: by 2002:a05:6808:10c4:: with SMTP id s4mr8824425ois.39.1625167362491;
 Thu, 01 Jul 2021 12:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.1625111177.gitgitgadget@gmail.com>
 <87wnqacg9i.fsf@evledraar.gmail.com> <CABPp-BGRgL-SnHDgefq887e51z9t_TMXcc4DLrazggC-1iQWng@mail.gmail.com>
In-Reply-To: <CABPp-BGRgL-SnHDgefq887e51z9t_TMXcc4DLrazggC-1iQWng@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Jul 2021 12:22:31 -0700
Message-ID: <CABPp-BH3H20wAoD4CJmQjj2iVhnXN+M=XvQdUWUgvY0VxPHKZw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Optimization batch 14: trivial directory resolution
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A small correction/clarification...

On Thu, Jul 1, 2021 at 8:04 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jul 1, 2021 at 6:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
> >
> > On Thu, Jul 01 2021, Elijah Newren via GitGitGadget wrote:
> >
> > > This series depends textually on ort-perf-batch-12, but is semantical=
ly
> > > independent. (It is both semantically and textually independent of
> > > ort-perf-batch-13.)
> >
> > For others following along, that ort-perf-batch-12 is at
> > https://lore.kernel.org/git/pull.962.v4.git.1623168703.gitgitgadget@gma=
il.com/#t
> > & currently marked as 'will merge to next' in what's cooking.

Yeah, I should have referred to it as en/ort-perf-batch-12, the branch
name Junio used.

> Granted, merge-recursive doesn't take quite as long as it used to; it
> also benefited from some of my optimizations[1].  Nowhere near as much
> as merge-ort benefited, but it still would be about 20x faster on the
> cases with "mega" in their name.  So, although today's merge-ort is
> ~5542.7x faster than git-2.29.0's merge-recursive for a massive set of
> renames in a really long rebase sequence, it is probably only a mere
> 277x faster than today's merge-recursive on the same case.

The 20x number here I was just spit-balling, whereas the other numbers
were measured.  I think 20x may have been a bit too high.  Regardless,
though, to me the important takeaway is not the performance difference
between merge-ort and merge-recursive now (though that's also huge in
merge-ort's favor), but between merge-ort now and merge-recursive when
I started.  If someone really wants me to get the difference between
the two now, I can dig in, but it's annoyingly painful waiting for
merge-recursive to finish tests several times.
