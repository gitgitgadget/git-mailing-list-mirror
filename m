Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36DFC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6E6613CE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhFXSy1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbhFXSy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 14:54:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48959C061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:52:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i24so9987398edx.4
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9yqPCJiRHImQcEOFjyiZVt5mho/r3oOHlDi987t9KmI=;
        b=zWpDImNeimYh3A3gkzewcwxqJqz2owI4c5N2zk9+MovVmo4smbnYDltLVZy+TqqJNn
         reWj63DAiZEldgJs08otQskwb4ZfR1qOU4xT68eo7Zo+Vl2+l5XvymWicPYgVcrxPUZv
         3FPuPRP9gDJ2YaR+83OZ85WVxIiCwqKxw3bue2KTfHQgUjrvhYg4wJhm1o/Yk8Ldw1bp
         ms4Xn1NZUv1tBJ9yEIghxqvRDJ0b5KULYpX9Is7w0g6aCCUL8SjbHz08B1hglEjiZl1Y
         hkylkVclCyW4+RnwiIyeGoBS3xpwalaDe0eDjyMw2NeJe/azmdgfpCk5267jb+5iI2pH
         Kemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yqPCJiRHImQcEOFjyiZVt5mho/r3oOHlDi987t9KmI=;
        b=pfyXoq4MkFterLNuXsrNjs56rr0vc1U6y7cedBY34aFEZjG2Ml+VrnUF/wYOsLhq+Z
         g1IvdciblJPDq+zre5nLbd/Rxb3aYetuXmgbGcrOgQsuSXxlokLKQRthqVo7ajfqbGS4
         0iw517rXK6KS+r4KXyNnxWyWz5X0ig0u+K1g1W5RtwrKnpRaydnc4jopcKxwke5KP5ac
         C+RBh/csTtr3bO9jSAmZuDlSbjtCqqVnHdGe+Qf0XlzUdXE7Vv6LQkxaDXeLDrLE8bIN
         NRTm9H2aNLyBJn5pQjn5HWaAomQhkrPCd8MDioDz0I/KmPqpNcilJXG7GjJoUvHW/TdU
         CIbg==
X-Gm-Message-State: AOAM533RWQg2frCHsgRW3+vCvTC8Q2jZP1DCAMhnjgzaMKi2GjXgpyDH
        FJRzJ2cUA/+zXWl75ritqcKjangKre6taEEvJubZSw==
X-Google-Smtp-Source: ABdhPJwYtpZW28fBqyicuDOV1hLIDe4qvkdI6Saaptape1xK6b/wn3RljiNEXLqY1W9+DiH1eSA3vdALyB0bPNn4sq4=
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr4085834edz.371.1624560725768;
 Thu, 24 Jun 2021 11:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet> <CAPMMpogeWeQujG0UL80REOsaBJipxhQyOpBTuWD9U9_jg=FMMA@mail.gmail.com>
 <81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com> <CAPMMpogjr43111HfPzk23c98JBaiEF2YA_OTkQVG1a63zyeiOw@mail.gmail.com>
In-Reply-To: <CAPMMpogjr43111HfPzk23c98JBaiEF2YA_OTkQVG1a63zyeiOw@mail.gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 24 Jun 2021 20:51:55 +0200
Message-ID: <CAPMMpogek1N=5D8OVBLGXyWGgur4=-1Txever0P=86Lr7AEeKQ@mail.gmail.com>
Subject: Re: Windows: core.useBuiltinFSMonitor without core.untrackedcache -
 performance hazard?
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fwiw, I've now submitted a patch(set) that I believe addresses this
particular issue correctly:

https://lore.kernel.org/git/pull.986.git.1624559401.gitgitgadget@gmail.com/

Thanks,
Tao

On Mon, Jun 21, 2021 at 10:52 PM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi Jeff, thanks for the update!
>
> On Mon, Jun 21, 2021 at 8:41 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> > We're currently looking at a problem that we believe is in the
> > untracked-cache code.  This is causing some of our Scalar tests
> > to fail on Windows when the untracked-cache is turned on.
>
> For what it's worth, I just discovered an untracked cache bug this
> evening, although I doubt it's related to the one you mention - it's
> not very exciting:
>
> If you disable untracked cache (and write an index file), and then
> enable untracked cache and run status with "-uall" (writing a new
> index file), the untracked cache data written in the new index file is
> empty/invalid, and subsequent "git status" calls perform just the same
> as if untracked cache were disabled:
> ----
> # write an index without untracked cache
> git -c core.untrackedcache=false status
>
> # write another index with invalid/empty/bad untracked cache because
> "-uall" skipped its population/maintenance
> git -c core.untrackedcache=true status -uall # expected to be slow
>
> # run regular "git status" (with untracked cache) any number of times,
> but don't get the benefit (and you don't write a new index because
> nothing appears to have changed)
> git -c core.untrackedcache=true status # unexpectedly slow
> git -c core.untrackedcache=true status # unexpectedly slow
> git -c core.untrackedcache=true status # unexpectedly slow
> ---
> # TO FIX:
> # write a new index file without untracked cache
> git -c core.untrackedcache=false status
>
> # run regular "git status" (with untracked cache), does work and
> writes a new index file
> git -c core.untrackedcache=true status # slow as expected
>
> # run regular "git status" (with untracked cache) any number of times,
> is fast as expected
> git -c core.untrackedcache=true status # fast as expected
> git -c core.untrackedcache=true status # fast as expected
> git -c core.untrackedcache=true status # fast as expected
> ----
>
> I suspect this issue has bit me in the past when attempting to
> understand untracked cache behavior; it can be *very* confusing, if
> you're using tooling like "git extensions" that can, in the above
> flow, "poison" your untracked cache if it just happens to run a "git
> status -uall" in the background as you are testing.
>
> (I discovered this issue while trying to understand the weird &
> wonderful relationship between the repo-level untracked cache
> reference, the dir-level untracked cache reference, and the mechanisms
> that initialize a new one at dir.c#new_untracked_cache() and write the
> repo-level one (even if the dir-level reference was voided due to flag
> mismatch) at dir.c#write_untracked_extension())
>
> Should I be reporting this in some more "official" form somewhere? Is
> there a bug DB?
>
> Thanks,
> Tao
