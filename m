Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9120AC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4D92084C
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 08:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwSwyZqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgIRIhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIRIhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 04:37:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF32C06174A
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 01:37:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i22so7011966eja.5
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9S0THJu4bMDWwu8ScExJpPZf6LaMnFP6fGGgSO0XzEI=;
        b=jwSwyZqGnb61hVWUxrgZz9oGzHjpiFXfuDsYVVmojueDxU51pBUObrBA2RxxG8aI5M
         b/fy3z2/d5VGGoXwYiwkTBWoFC1KJG2HVGZrsFbhlU7rMFF2nfuJqWrXpj3u1DUVGuoW
         RPa0/awAmKErikNeH5bZ5IDPuAXuDZ8+i5ZP3o46wsEyv8bpEE1sz7CbgMN9YXv9VIxJ
         rkDo9N70BQLipfl5ia29XNSz50DRs+QJzBaXOeQgwZ75ttwBMyX7laiyLXBT/wy16UrX
         E4oIJJKu2hf8u/3ydMn4TNqsbOxmuuyD3HLdyg33UNpy9LO3AZb7UUnlnjOVcnUR91rj
         Hxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9S0THJu4bMDWwu8ScExJpPZf6LaMnFP6fGGgSO0XzEI=;
        b=Yu8AXiaKQUTBubCduxQtb0wuXuXMT1zp5R96iJTdPd4Q4VelqVwqulOBBegmy6PNxb
         3G+5Zy9HPJ/VgamQIxYD7Bz9GjuNCC6Tp+eQMUYLfxlg5LVEf6KjLWcr40PyOEAQQetq
         IC0Mb7DF7mfUhFG8URItTwyfy+yxFCj+3IICfj0RePfB8DqE3tyGaXky/ny109cQCwC2
         +d3QQJ530Jj0WXwurhE7wFp//5PLsSqAYgLaVJJdmF29onxlJB6CvVYqXo0JJdRn0nGK
         fKcOWE7ghXXl66G1X3WJG7QDYvUnnVUEo+9fdf9wDSErcz+cMO9aebFbK20IphkIQB3I
         0TfQ==
X-Gm-Message-State: AOAM532R5uMRi6oXXfm2uu4uKuVvkRaiNNVw6eQK0G94lenyZEyg4dmv
        vNcCxavXOEg/ezHce1Al/vjFNjun84wI5DNN/VJjpUDGuoRqfw==
X-Google-Smtp-Source: ABdhPJy/3GnleM1wpd39Pmrejhgv69kkRSsccwcEkZIqimHqi9FTwGxkBEo27hYsg7oF22vYcp7zfVXuWUtQAS+L/PM=
X-Received: by 2002:a17:906:1c5b:: with SMTP id l27mr36639430ejg.283.1600418237117;
 Fri, 18 Sep 2020 01:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet> <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
 <CAP8UFD1n_PYzygFCgNDt3T=EQhbcuaTYFCfNN5n45OHRh45KOg@mail.gmail.com> <ed35b0ac-a2c6-c25d-db39-284e7daf29e8@gmail.com>
In-Reply-To: <ed35b0ac-a2c6-c25d-db39-284e7daf29e8@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 18 Sep 2020 10:37:05 +0200
Message-ID: <CAP8UFD0dsNbfR_uvWv7TmMBDXiO9paGpTex2HvGEofwSgL+GuQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 17, 2020 at 12:14 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 17/09/2020 10:43, Christian Couder wrote:
> > On Wed, Sep 16, 2020 at 11:01 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> >
> >> On Wed, Sep 2, 2020 at 10:50 AM Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>
> >>> As to projects, I would like to believe that
> >>> https://github.com/gitgitgadget/git/issues has grown into a useful
> >>> resource.
> >>
> >> Thanks for the useful resource!
> >>
> >> I would be interested in mentoring, or better co-mentoring, the
> >> following projects:
> >>
> >> - Accelerate rename detection and range-diff
> >> (https://github.com/gitgitgadget/git/issues/519): ideally I would
> >> co-mentor with someone a bit familiar with the suggested algorithms.
> >
> > Proposed on Outreachy's website:
> >
> > https://www.outreachy.org/outreachy-december-2020-internship-round/communities/git/accelerate-rename-detection-and-the-range-diff-com/cfp/
> >
> >> - Add support for drop!/reword! commits to `git rebase -i`
> >> (https://github.com/gitgitgadget/git/issues/259,
> >> https://public-inbox.org/git/alpine.DEB.2.21.1.1710151754070.40514@virtualbox/)
>
> I'd be happy to support someone working on this though not necessarily
> as a formal co-mentor

Ok, I have submitted it then:

https://www.outreachy.org/outreachy-december-2020-internship-round/communities/git/improve-droping-and-rewording-commits-in-git-inter/cfp/

> - what the time (and other) commitments does being
> a co-mentor involve?

The above page should have a link/button to let you apply as a
co-mentor and when you do that it should explain the requirements in
detail. I think though that the time you will actually spend on
mentoring depends a lot on the intern that will be selected and on how
much time you and I will be willing to spend.

Thanks!
