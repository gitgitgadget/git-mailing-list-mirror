Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73D9C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF33B64E58
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhBQUCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhBQUCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:02:07 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D921AC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:01:26 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b14so14106088qkk.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zGXELVWF02qXch1NlrWSN1cZ7zCJPzC9xPSBnsXuKCc=;
        b=gTCX30EZhLNLUdBOVWInCVeW34uCsYK4K9neilgV7Sb/tavxcIkfNIdc9sy990Zl19
         zWKKslm6Ow0iANAHhFsM4rq8OS59Gft5F/CMNOneL+HVWZB1HTRdK7k/2UbKbubGnGbP
         iBSJH3UDWrd7fBxSXyk8QONuy8V2yuJ7AlM8X5Q/5n6eCvVDdE4JVga/6mj088KQcRHd
         CIsKJj9cZR8mw72kc+LM+uVrzHrpfxji1gTOnPLwCKoywnJYn3cTteo9bflsQHIja91l
         7EsDJCVcF95eRlImbyfQfBpRzzqQVIT/XoMiaMg4IW1Yahkb8NwkEB/d2e0ZMfI5uoWM
         CLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGXELVWF02qXch1NlrWSN1cZ7zCJPzC9xPSBnsXuKCc=;
        b=l7l3ws362orfOBE/x2bdhoTM5KNVxGPRbtM5qUPNyROd+SiQOOmTTs72tq+iR98EYJ
         NlLTmzCCLLjauQLnuhkFnJYhCOWOXWm6UCdMoiYoR6RluDmx2KsqU2zdYx5/alIuFxc8
         HCRdTxOHrox4h/t2RzscNEGE/adxXuQYjMKjztOzwayRzQvVtNKrv7+Z8aoynpsHn0zj
         AaRyBTA/TwWwzwjqVDTnwYMMYemfm5VTDuSP5j5k9/ETLd3ikmaH+Jj/iQ1Om/N+QzdY
         gEDGuQO/brwVz/eyAogRpISGkeKqbYN6vs3bicvc+rvY/KpBc+sdf9uqiC8dVJw05tpt
         V7fQ==
X-Gm-Message-State: AOAM532GF08qc221qpSSA0rMdsT6YWZqkjwtv4JAyVkLPDrWv9a4Zv9Y
        iHOoM+CBk+5IbJgT6u9aPbxCY7QiRtwOprTR
X-Google-Smtp-Source: ABdhPJzyOrgg0Eu4YiyO6IKi8u1pGYWg25xqu9KIO3Ms4RaQM9khJRdb1R7n8KdHrcvs/C9nJhqi8g==
X-Received: by 2002:a37:a34f:: with SMTP id m76mr878566qke.251.1613592086080;
        Wed, 17 Feb 2021 12:01:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:aeda:db8b:7233:8f54])
        by smtp.gmail.com with ESMTPSA id r1sm395393qtd.57.2021.02.17.12.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 12:01:24 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:01:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v2 8/8] builtin/repack.c: add '--geometric' option
Message-ID: <YC12EnHZCsCPwiay@nand.local>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
 <d5561585c2221a9635eb0fc7a65298ee8a2b6348.1612411124.git.me@ttaylorr.com>
 <YC1drGrIEg0C7Zo5@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YC1drGrIEg0C7Zo5@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 01:17:16PM -0500, Jeff King wrote:
> On Wed, Feb 03, 2021 at 10:59:25PM -0500, Taylor Blau wrote:
>
> > Often it is useful to both:
> >
> >   - have relatively few packfiles in a repository, and
> >
> >   - avoid having so few packfiles in a repository that we repack its
> >     entire contents regularly
> >
> > This patch implements a '--geometric=<n>' option in 'git repack'. This
> > allows the caller to specify that they would like each pack to be at
> > least a factor times as large as the previous largest pack (by object
> > count).
> >
> > Concretely, say that a repository has 'n' packfiles, labeled P1, P2,
> > ..., up to Pn. Each packfile has an object count equal to 'objects(Pn)'.
> > With a geometric factor of 'r', it should be that:
> >
> >   objects(Pi) > r*objects(P(i-1))
> >
> > for all i in [1, n], where the packs are sorted by
> >
> >   objects(P1) <= objects(P2) <= ... <= objects(Pn).
>
> Just devil's advocating for a moment.
>
> [large push becoming the biggest pack in a repository]
>
>   - it may have been more carefully packed (e.g., with a larger window
>     size, using "-f", etc) than the packs we got from pushes. We do
>     _mostly_ retain the deltas when we roll up the packs, so it probably
>     only has a small impact in practice (I'd expect in a few cases we'd
>     throw away deltas because a pushed pack contains a duplicate of its
>     base object that we added via --fix-thin).

Yeah, agreed.

> So I suspect it's probably OK in practice. These cases would happen
> rarely, and the impact would not be all that big. The bitmap thing I'd
> worry the most about. As part of a larger strategy involving a midx it
> is taken care of, but people using just this new feature may not realize
> that. The bitmaps of course are "just" an optimization, but it's hard to
> say how dire things are when they don't exist. For many situations,
> probably not very dire. But I know that on our servers, when repos lack
> bitmaps, people notice the performance degradation.
>
> On the other hand, by definition this happens in a case where there are
> more objects that have just been pushed (and are therefore not
> bitmapped) than existed already. So you _already_ have a performance
> problem either way until you get bitmap coverage of those new objects.

I almost split my reply between this and the above paragraph to say
exactly this. I think in this case you'd want to rewrite your bitmap
from scratch either way (whether you were using multi-pack or
traditional reachability bitmaps).

> > --- a/Documentation/git-repack.txt
> > +++ b/Documentation/git-repack.txt
> > @@ -165,6 +165,17 @@ depth is 4095.
> >  	Pass the `--delta-islands` option to `git-pack-objects`, see
> >  	linkgit:git-pack-objects[1].
> >
> > +-g=<factor>::
> > +--geometric=<factor>::
> > +	Arrange resulting pack structure so that each successive pack
> > +	contains at least `<factor>` times the number of objects as the
> > +	next-largest pack.
> > ++
> > +`git repack` ensures this by determining a "cut" of packfiles that need to be
> > +repacked into one in order to ensure a geometric progression. It picks the
> > +smallest set of packfiles such that as many of the larger packfiles (by count of
> > +objects contained in that pack) may be left intact.
>
> I think we might need to make clear in the documentation how this
> differs from other repacks, in that it is not considering reachability
> at all. I like the term "roll up" to describe what is happening, but we
> probably need to define that term clearly, as well.

All fair suggestions, thanks.

Thanks,
Taylor
