Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37880C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C58F604DC
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 00:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhH1AVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 20:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhH1AVn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 20:21:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2FAC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:20:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id i28so14351298ljm.7
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+besq5dzxo7bTPJcwkS1scBTgpdRMZ9FrOyI59cuid0=;
        b=H5R5aHZbwvcgwvm8zopBJdkxDiz1eNgoGVpHs8xkyfOfWw734MWqWQd8R/EQ14Ez7L
         rQB+iLcdpFbA275BKylZwgPNLHdGunoH3CphngaOSda1LWSu54iXOl7ZV8PLJOq6MHXx
         NrTLXwm4TeTvhkmqV9kU3rOe9v6ACFgvEL0q8CQ2BrrNrgF0P9aruiFbUu/Tit1xjKqG
         Svpk8F/jxpcn95ajcQ+lbtUXQzlV9ra3OgoJtq0OBQhBP//VbMkjUiJbxityaUshb0WR
         ZnkO1ZU9F2noqHqrzwY9W5Rfy8ctuRH6OoiTuCwzbhLOgt6e02CSWJyrPSNvKulbrezp
         lAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+besq5dzxo7bTPJcwkS1scBTgpdRMZ9FrOyI59cuid0=;
        b=KYNZ54YHuGCR4Y/3zxhgzJGLsrMdtZGlDdG0jphEQB4pVGZNpLSd+Ars0c+FwGRP8R
         /c/2tBncNiP1I/lDuJFLhaa7dwLA6rvyk5MCguCsWvmqzx8Q7cP2TVmWYW8J8tLE+88x
         lVvT7i7ckt5ZubLAbn9yExcao1+Eoopn6LgVTyjHDIzjYrNEOb7lahmMHS56ZfVbmRWJ
         8LP5quCM55XQFcGrdWKHAdGtS/g6vQgkYvrcVx9zR8qU73owXXGXZaBca+PrTSjLt/y/
         tnjzuXTh39gS4ZVX/l3EP/su+cD9Z03dJzavIn3coRKlP8vgRll8FNivC70MUy7fK2jc
         US4w==
X-Gm-Message-State: AOAM533vDivf1qRweXvqAFMcvupX20zH3Hw1hWBVPSqp51SXm9+Ys1hw
        O65raHJ8ODu9I3fidAxQ5fxYhMoOIxVYodmzYYs=
X-Google-Smtp-Source: ABdhPJzlc0geTTNT1wRiSB0Q45XkxbtwvmWI9Aii6pZwCRGhbXSQUihy7qYkIQSDP9ewVoiIlhFPQcjOTpB1RzLdtKs=
X-Received: by 2002:a2e:2a06:: with SMTP id q6mr9702675ljq.424.1630110052276;
 Fri, 27 Aug 2021 17:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <d1e68d4a2afc1d0ba74af64680bea09f412f21cc.1629856293.git.gitgitgadget@gmail.com>
 <87mtp5cwpn.fsf@evledraar.gmail.com> <CANQDOdd2FDNXnXLdm2FSmxUTk3oi+mQtiW2rf3YG7MJayrexPQ@mail.gmail.com>
 <20210826055024.GA17178@lst.de>
In-Reply-To: <20210826055024.GA17178@lst.de>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Fri, 27 Aug 2021 17:20:44 -0700
Message-ID: <CANQDOdcr0gXsdXtqfN+FFRkAumNfYmr2C3qAcdzFxY26bDPWCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] core.fsyncobjectfiles: batch disk flushes
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 25, 2021 at 10:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 25, 2021 at 05:49:45PM -0700, Neeraj Singh wrote:
> > One conclusion from reviewing that thread is that as of then,
> > sync_file_ranges isn't actually enough
> > to make a hard guarantee about writeout occurring. See
> > https://lore.kernel.org/linux-fsdevel/20190319204330.GY26298@dastard/.
> > My hope is that the Linux FS developers have rectified that shortcoming by now.
>
> I'm not sure what shortcoming you mean.  sync_file_ranges is a system
> call that only causes data writeback.  It never performs metadata write
> back and thus is not an integrity operation at all.  That is also very
> clearly documented in the man page.
>

You're right. On re-read of the man page, sync_file_range is listed as
an "extremely dangerous"
system call.  The opportunity in the linux kernel is to offer an
alternative set of flags or separate
API that allows for an application like Git to separate a metadata
writeback request from the disk flush.

Separately, I'm hoping I can push from the Windows filesystem side to
get a barrier primitive put into
the NVME standard so that we can offer more useful behavior to
applications rather than these painful
hardware flushes.
