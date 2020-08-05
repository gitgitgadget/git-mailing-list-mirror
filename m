Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB8C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B3922B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 20:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFZLWGap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHEUcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHEUcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 16:32:08 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A8C061575
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 13:32:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 4so17015963vsf.11
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4lUGcGYZ0nTZO2d6fRNL0StS8kO+nlkccgKWsSEUMo=;
        b=GFZLWGapss/aTcPJo/3llRxc9JAJ4+fNliL6h/jADKSjSkO8gv2XS6umTcGk+v7kdj
         /VZfLgLueGs7aZO1GiBYgYZ34s8U/83M9ovIn1EqUxsU7+7fNQefhZ7iY/KEfz6o+hHD
         Q0X8h8WtsmjOxzph/DFpi1xfeONVDzRsn4GaTOOyHYgzRiHKeoRQi9QDifRIWLTVzKrS
         q1u12IB4JnHyZylpRJWu7MqodQbbXqO8Cw4PmXVL1SHqquYbYoUDUcNw77A82TSbKcXC
         WYhtVrdP2EHHWMQbvbU1udTVSqKuICtF+ZibxmzbM2/+MDdMIm2qYISbT0JB2ag0cuL1
         RBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4lUGcGYZ0nTZO2d6fRNL0StS8kO+nlkccgKWsSEUMo=;
        b=bmtW9hQ+WFRSeatj4pkzXAdgKlCEX8k6oaDGnmzuYlbr7+M8albZdoXe2mOIuUP7+m
         y19wS0Lv4R+Qix9aJVC2YtsfwGeO6X5KqSXk69PwyZhyRgdCVXXf+aPLRgk25CNWs4mj
         jLP8a0xoSLVWJBrKASucZFuDpNpGIHOvH+4wwA12qe08BhkimESOO169KRKmPnOYDJn7
         98zwVyFB9dzH7KEe7lhXL1DspnLD19kpLbEOBS0Bv27pnNktjvQpl0ej1VJ3RwsxlwwL
         FImMLiZM73fEuh2XHYFB6kGUlwgs+Ekt9Dxrws0db7StZ6VdnCKYig2Q9z3ijE57VnR5
         RcSQ==
X-Gm-Message-State: AOAM531FsPBFUCn1WF/3SmpVzNNwHyRn3msuRmcRG6AHDQqslh+ms/pR
        x1cBVNSqHZZw+IIfJfAAgtu66SjGyfxrmuy5MUHE+zrk
X-Google-Smtp-Source: ABdhPJwsHWjya8Vp32DhnCrmEVq3NG7XFIhrxvjpY7IJrT5PBw11TowsSbLFxOUcjbllzWvJeL6Ww9bm8bn7k5GMo18=
X-Received: by 2002:a67:1702:: with SMTP id 2mr3790252vsx.153.1596659527274;
 Wed, 05 Aug 2020 13:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+P7+xpokJ3Z4xZ9ibCBpBO65D1v-AD6_JknprGUsEDxEvMGGw@mail.gmail.com>
 <20200805063704.GA2690083@coredump.intra.peff.net>
In-Reply-To: <20200805063704.GA2690083@coredump.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 5 Aug 2020 13:31:55 -0700
Message-ID: <CA+P7+xofEHdvVOy-9RLUF=kXCjNEXrs0M3Mp6h8RgehY2KHaaw@mail.gmail.com>
Subject: Re: avoiding fetching specific refs from a remote
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 4, 2020 at 11:37 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 04, 2020 at 02:53:30PM -0700, Jacob Keller wrote:
>
> > This results in the annoying completion behavior where:
> >
> > $git checkout ma<TAB>
> > main
> > master
> >
> > Essentially, because both main and master have similar names, tab
> > completion requires remembering to type one additional character than
> > I am used to.
>
> Heh, I didn't think anybody considered that implication so far; the fact
> that they were similar names has generally been considered a positive. I
> agree it would be annoying.
>
> > I'd like to be able to customize my pull so that I either (a) exclude
> > the reference when performing a fetch, or (b) exclude the reference
> > when tab completing.
>
> Not quite (b), but if you:
>
>   - delete any local "master" branch, if you haven't already
>
>   - set $GIT_COMPLETION_CHECKOUT_NO_GUESS to "1"
>
> then it shouldn't complete "master". The second is necessary because
> we'd try to complete the magic "git checkout master" that auto-creates
> the branch from the remote version.
>

I don't like this approach because I like having the guessing options
available in most repositories.

> > something like adding a remote.<name>.excludeRefs which would allow
> > specifying a set of references to exclude from matching the refspec..
> >
> > I realize I could customize the refspec to list the set of things I
> > want, but then I would miss any potential future branches until I
> > updated my remote config again.
>
> This is definitely a reasonable thing to want, and it has come up off
> and on over the years. One search term for the list archive is "negative
> refspecs", though it turns up a lot of useless hits when the two words
> are not directly adjacent.
>
> This old thread might be worth reading:
>
>   https://lore.kernel.org/git/20140124090104.GA396@x4/
>
> and there is even a patch in there:
>
>   https://lore.kernel.org/git/20140125013433.GA22336@sigill.intra.peff.net/
>
> but I didn't go over it carefully enough to know whether it is utter
> trash, or something that could be used as a starting point.
>

Thanks, it looks like this is at least sensible.

> -Peff
