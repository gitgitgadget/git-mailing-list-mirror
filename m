Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86312C433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFFA22243
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq2YRON2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgIQPnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgIQPm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 11:42:59 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ABAC061756
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 08:35:10 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y6so2943480oie.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aq0gx2i3vKp9jGUinAulPAaxpeiWbuw9fgIHXQiwjI4=;
        b=aq2YRON2C3iESmpMKoJFul0J/UNexC5wLy8LavFSwrJIkeSKLYwP5f7JgiNQ5YPD7m
         dZzCPYvFvl1BzNNSQD9npQHCG6HKjJ4eN0768xDtAHLaAZcTJxVufliDl2GFmKoMMocS
         vXR4JeNAPC9ZHXeUikB4Eh1bdhOYpL/Aq+ArXCV3+d/99UBK44MOgg6V2FbzAIurk1SQ
         ea1rQkt3X4sLy5eTb4qCZ62hZQj9thN0iUwjwRbn1Ahh2CkdqMrasl7rxMXT/gdIQujA
         LJvTPudN3RdF2wI23HvtbazCISYsEQSHGjM84BTgfLpwZ3ki9eBo+0UIoEsKauTN0Kwr
         YLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aq0gx2i3vKp9jGUinAulPAaxpeiWbuw9fgIHXQiwjI4=;
        b=LczHAnk2tWjST5Xq9b4/lde7QugTY1kWjHC3m4ZNN3vIAubbF7UCwzWNKZ4a1PSaKs
         8VlUGQEjarm5uizj0dwrLaMUS1VCF+QBDOLOlKHGCFfNYk4ajjA4XnrVDfdKE2wY2eAP
         UkjQE/pOW78LE4zcx+DkBFbiGgbRpjxTjgK/IBebCmVUU9p6YVrhO05fHxQyEWLlgqU2
         AdVVucy8WtXqYDcUkRx94dqSRtIPGzrZ9nqSu8ShiOgPfG0cVDVg6uMqp/BpL1WSlF5m
         634Cjep+x9HJYxJHy6foJB7I7Adei3pMf/MNdlrJzQJdWJrkU0EeffsR+dpd13AlBGYS
         DJLA==
X-Gm-Message-State: AOAM533cUYYf/0rCVcalHB7SkTOsYHKYqbXKF3aA9/fERVeGEEuu8Gr9
        cKDceuOFdBaY4UQna+K88syZUrC4tAMR27+sHMk=
X-Google-Smtp-Source: ABdhPJzBV6Pp1cNgd5ntp5s3vDcZeHVy+H8zO+W/hUGU1xYSSzF6XTawi0qAhiUHsO8GbM0gfMVApMxnsT7h/Nit/yg=
X-Received: by 2002:aca:5b45:: with SMTP id p66mr6946027oib.39.1600356909960;
 Thu, 17 Sep 2020 08:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet> <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
 <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com>
In-Reply-To: <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 17 Sep 2020 08:34:58 -0700
Message-ID: <CABPp-BHV5-UUio69b1ZnwuRwyj66HUEy3A24wvxELorR_1FB=g@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 2:47 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Sep 16, 2020 at 11:01 AM Christian Couder
> <christian.couder@gmail.com> wrote:
>
> > On Wed, Sep 2, 2020 at 10:50 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >
> > > As to projects, I would like to believe that
> > > https://github.com/gitgitgadget/git/issues has grown into a useful
> > > resource.
> >
> > Thanks for the useful resource!
> >
> > I would be interested in mentoring, or better co-mentoring, the
> > following projects:
> >
> > - Accelerate rename detection and range-diff
> > (https://github.com/gitgitgadget/git/issues/519): ideally I would
> > co-mentor with someone a bit familiar with the suggested algorithms.
>
> Proposed on Outreachy's website:
>
> https://www.outreachy.org/outreachy-december-2020-internship-round/communities/git/accelerate-rename-detection-and-the-range-diff-com/cfp/

As a heads up, I'm going to be sending many patches modifying quite a
wide range of diffcore-rename.c in the coming months for accelerating
rename detection.  Maybe I'll get them all upstreamed before outreachy
starts, but that's not so clear.  As I mentioned in the gitgitgadget
issue, the ideas outlined there and the methods I implemented are
different and complementary, but there is a pretty large risk of
conflicts we need to resolve if I don't finish landing all my patches
first.

>
> > - Add support for drop!/reword! commits to `git rebase -i`
> > (https://github.com/gitgitgadget/git/issues/259,
> > https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)
> > - Invent a way to retain reflogs for a while after the ref was deleted
> > (https://github.com/gitgitgadget/git/issues/236): I guess this might
> > be implemented as part of the new `git maintenance` builtin.
>
> I will also likely submit a proposal for one of the above projects.
