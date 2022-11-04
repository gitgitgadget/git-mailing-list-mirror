Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B251EC433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKDVt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiKDVty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 17:49:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904994E418
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 14:49:50 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b2so4822036iof.12
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5No0GSQcv5fBta9yqQX5mdn/CYyDL32pM+4No3kMazs=;
        b=EsSPNtpoHEfAxfAwZUNuX3KvrLz6rdhKIuOtwmXRYnUrxUp5mOaePuPOzBbHktaQEC
         XZGv2Triu8ySGdYFEizExX9j5P5z3G/9yBn5NaD+qorqs7tXfmYVN390EuICGA+Y8175
         djf693Lkv+18aLljiB9FFmnojKHW44FgpCmbrWONGaAkbJqgnyFZ/14Mo9oSLViM+NIy
         mr3TpyYuXgysKaS5Q2Dc5kSo4KZdDG+NCxu+SKvg+lr5zNPDqqNooBDXkgvH3MLs1NmM
         I/A0AN4F9+RB4Wu4GdDY6rK0qTHL+3TcMAbnbRri42NM+pLtDGi698Uqa9cLbMmo+0ux
         TIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5No0GSQcv5fBta9yqQX5mdn/CYyDL32pM+4No3kMazs=;
        b=OQHsX07y69fKd6pYUGwRgkOwndcOXuPO3425L7GGS7sfhMgbx6IOrTk0nedIkMJ0bi
         2YKhF1LM2Tm1zNrwV5oBZLtL3m37tUkDmqv4AD0GyNTDZQfDM1o0925RWwnUcppA8spz
         PxDxqJqtlZ6TJiNMMhD3NUiLF3/BEDzJnG+EbiGPKWE6o5TjNHZ/p2MAvHkDE5G0aeAG
         mTeilkKUsyx4lD0A0RzlDyMtbuvSSb2yz0Gjy2y8OTyXfPXYepKqbQ7P7qE1fS9C6fkK
         6gw0tvy5MptzycvK83j0sytfDP5gBkhplGr7VVgBzMCD0IriUsaPdUy+SQ0a4lBJ6wZt
         z2nw==
X-Gm-Message-State: ACrzQf1LDE3NQSBF1Q5cmzBTMlxdv6F6hGXWstx/M75+Qe9RMTtUDy+G
        KiQTRISkekyZ18B89kHtVIG2bg==
X-Google-Smtp-Source: AMsMyM6wS978iZ7+YntWv2LATud/veQOE1K/1HvNzWkTR4EgHmoRRtOgNPckOYgncTE/ctk9R/sYDA==
X-Received: by 2002:a05:6602:2d49:b0:6bc:d242:579d with SMTP id d9-20020a0566022d4900b006bcd242579dmr23705308iow.7.1667598589733;
        Fri, 04 Nov 2022 14:49:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id g4-20020a05663810e400b00372e2c4232asm43436jae.121.2022.11.04.14.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:49:49 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:49:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] rebase: stop setting GIT_REFLOG_ACTION
Message-ID: <Y2WI/C0E479jf6l7@nand.local>
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <Y2WIz5qvjQMfXPgP@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2WIz5qvjQMfXPgP@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[dropping broken email from the To: list]

On Fri, Nov 04, 2022 at 05:49:03PM -0400, Taylor Blau wrote:
> On Fri, Nov 04, 2022 at 03:19:00PM +0000, Phillip Wood via GitGitGadget wrote:
> > This is a follow up to pw/rebase-reflog-fixes that moves away from using
> > GIT_REFLOG_ACTION internally. This conflicts with patches 12 & 14 in [1]. As
> > this series replaces the code being changed in those patches I think the
> > best solution would be to just drop them.
>
> Thanks, I appreciate the updated round.
>
> The conflict you noted in [1] is a perfect example of why I dislike
> queuing sweeping leak cleanups like in that series. Those two patches
> need to get dropped in order to queue this series. OK, except what
> happens if a different part of [1] marks a test as leak-free when that
> is no longer the case because of something in this series?
>
> I haven't queued this topic yet, so perhaps all of this is moot with
> respect to these particular two series. But in general, such a problem
> is not hard to imagine.
>
> It is greatly appreciated to err on the side of smaller, more targeted
> series instead of sweeping changes when they can be avoided.
>
> Thanks,
> Taylor
