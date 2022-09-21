Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49130ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 15:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIUPbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiIUPb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 11:31:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C5B98D37
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:28:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so14377899ejb.13
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YmBO2X1PnjhsEWlWtHR3kHkXYaBTShe38r4luyKa3B4=;
        b=kiHjizs9OPgaOLkOPW+jUu4NQBjf9AfrEcUmySwz7H3ih4w6BsrIRCpG3EZKWUUeiE
         MDsDd3NpO+mPB1TeRoLf+xzywej2qxb7zJ6edlBUeLfFzCnK99QUZ5+nvGmCcinmS2dz
         3qDNrZ+hjPWUkBoVj0e1B5ENiv/o982oT6o5R2rNr35fm6+QEDrV7TjTTU/UffffpvUd
         k5HegqE/u5y/esiaaIhAytuhfrVlAFcnAs/wcuiz9pqEnLLwhiXlWy5NY6hnD+HAu8FO
         RiZjxFSpwAqlTuaUrV/Qrc/nDxmpzoQk4alqlbfE42oMamPYMKk6QeIxsTDexU34vtn+
         kebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YmBO2X1PnjhsEWlWtHR3kHkXYaBTShe38r4luyKa3B4=;
        b=o9BNc7nRZxJWq7MRxF+Jrcww3DMp+ZlEKaKcb1ArR7UkMmvAGB5Oj/sMeJHbf9NTnU
         bUCEbJSFPPDouGfAT2SF89vxWVbpwTrh7GxCFSniTVIsOVCVC5w6WMzYUXXGIeNDAnHX
         45UO0xElQ2yiky5S027LzEsuW3aqZn8h/no28pRIN9rc6XI8P6yGptfXp5JDYC5qAbr4
         FpHLbPuSYI5PmIVy7hjaZ0Rat2KjNCpZgGyzQ57utYLhzt/01pwsMxAd5bfPYZaI3JS6
         5hPwuFx11pG0mET1L76pz43Cl4NyL/P225jWV5mePNcr7xq5VESWXVDEVUgjTvsXkxnw
         l3Cw==
X-Gm-Message-State: ACrzQf1+IL5ASsGYsUmiChMoDO+ku7llta4l8LBKs0PjWHEw2w7PZxvx
        GlDbpBmxx61EIMkyihgqu43FIYfkSTyuYB0Ppva+Kx7MTpU=
X-Google-Smtp-Source: AMsMyM6TYhYHPXulnkKqRWgmlwh0uE0jQDm1eYCNX2cJrd9CsRbi/Jul7v0NWLOus7tpkpJsS77wrSJTGeHkBcvz6UU=
X-Received: by 2002:a17:907:842:b0:731:3310:4187 with SMTP id
 ww2-20020a170907084200b0073133104187mr20283943ejb.578.1663774040946; Wed, 21
 Sep 2022 08:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com> <Yyo3pMlGkw1TWLDQ@nand.local>
In-Reply-To: <Yyo3pMlGkw1TWLDQ@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Wed, 21 Sep 2022 20:57:07 +0530
Message-ID: <CAPOJW5zJ=5RiV+bVg_0pgJ=cZKV0TC0=RgRdH4r7D-D8Q9vnkw@mail.gmail.com>
Subject: Re: [PATCH 0/5] [RFC] introduce Roaring bitmaps to Git
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 21, 2022 at 3:29 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Mon, Sep 19, 2022 at 05:47:34PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> > This patch series is currently in RFC state and it aims to let Git use
> > roaring bitmaps. As this is an RFC patch series (for now), the code are not
> > fully accurate (i.e. some tests are failing). But it is backward-compatible
> > (tests related to ewah bitmaps are passing). Some commit messages might need
> > more explanation and some commits may need a split (specially the one that
> > implement writing roaring bitmaps). Overall, the structure and code are near
> > to ready to make the series a formal patch series.
>
> Extremely exciting. Congratulations on all of your work so far. I'm
> hopeful that you'll continue working on this after GSoC is over (for
> those playing along at home, Abhradeep's coding period was extended by a
> couple of weeks).

Yeah, I will continue (or better to say I am continuing) my work. I
hope that I can submit the next version in the upcoming few days.

Thanks for supporting and guiding me throughout the GSoC period. I
have learned a lot of new things during this period.

> I am still working through my post-Git Merge backlog, but I'm looking
> forward to reading these patches soon. I'm glad that other reviewers
> have already started to dive in :-).

No problem, I am doing some improvements by this time.
By the way, I am very excited to see the Youtube Git-Merge recordings ;)

Thanks :)
