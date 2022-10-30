Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE98C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 07:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJ3HGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3HGb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 03:06:31 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7D3D8
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 00:06:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t186so10508437yba.12
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpdYhltocbhypFpPQEaezYPuja9n4D3XqD35x59QAmY=;
        b=bol5CWWZYy0/B5tf0Zb37H5FOKaYL74NySXn/+AuBr+sJlgqNmp7Eh/0PUCrIpj91A
         atCfhti30F+dKqpXOQCO4EoWZOBkmaQRDoX9e9v0lHeCZGwhoIOthsSA+M46572Z0eiK
         Jazg2x4jidRotdjiciv3eN6EfaVfKbHWAx9qKWHLP/6eMXZJ34jPN8v9eu1XSMIW9rtH
         U8CEYk135KT34fj9qMbAJ+OTt33Ccgkqn2pj/ZVyXL3ezFwTslElKtgHvZcmyloM+Qj8
         PTCS+tkXJfVuxPza0bGMsf+nHmwScvCDYCpWfC/ptYLn0yPcbmfXJEchBN6cFM1mSGtp
         3m6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpdYhltocbhypFpPQEaezYPuja9n4D3XqD35x59QAmY=;
        b=ZC36ejq5NiC9kOsgwumtAlPF00rexIK62xj84gH7JI7BcRIjhNqhvW2Xrsq7zo/IaL
         SxBAwQIzNci+jUZGgGA9bJD1/CVrUP6L0gSIZXYaOIcPoTkOEsRU1Exic1XfGEOh2xLC
         qc2U4J9Onr1IOMb6zub35Hd/JXmBUIeBE6uWfhGBrRMbdudgBbZqvPXSlCCo4jda/aql
         0s+lB3J71MRK93QM/pvSsN0gKTiKxR8fXdkTwlye6tmtI/11PLY6Tw6ELP5+YuiTayBC
         e++cHXhKkdUOipx7DBZ684ZWrCAp9lu/mflPo58XRvYm/tuniWq8X49m6b1aJqQOLJ1v
         xZwg==
X-Gm-Message-State: ACrzQf1ZBZFobqZHiov/GYIgTt+Bjidz9hQY4VOJGoTe+5r+Ss/4JZ2L
        PezNN2EhZkIx98+FYNpTWioYQWMaswANP4wzxx5TexR9
X-Google-Smtp-Source: AMsMyM5zT7KSudD257q3Ux64xVhRucXzjekGRPpj/JWEHrvTHqI0Hsf85JiaUdNtvOaUPdAYwUOsRHG0FtxshCn3i8g=
X-Received: by 2002:a5b:6d1:0:b0:6cb:77dc:1cde with SMTP id
 r17-20020a5b06d1000000b006cb77dc1cdemr6756915ybq.447.1667113590188; Sun, 30
 Oct 2022 00:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220923193543.58635-1-siddharthasthana31@gmail.com>
 <20221029092513.73982-1-siddharthasthana31@gmail.com> <Y11rnKwuR0q47ngq@nand.local>
In-Reply-To: <Y11rnKwuR0q47ngq@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 30 Oct 2022 08:06:19 +0100
Message-ID: <CAP8UFD3J3Q4UTGo5aaDDVth1hXLXAt53322z3TSNWTVRNiJ8Xg@mail.gmail.com>
Subject: Re: [PATCH] doc/cat-file: allow --use-mailmap for --batch options
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Sat, Oct 29, 2022 at 8:06 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Siddharth,
>
> On Sat, Oct 29, 2022 at 02:55:13PM +0530, Siddharth Asthana wrote:
> > This patch was previously sent as the first patch of a 3 patch series for
> > adding the mailmap support in git cat-file options:
> > https://lore.kernel.org/git/20220916205946.178925-2-siddharthasthana31@gmail.com/
>
> Why was this split off from the original series? I don't have a problem
> queueing the two topics independently, but an explanation of how the two
> interact would be appreciated.

I think it was split off from the original series because it's a
documentation fix that could hopefully have graduated faster, and
could perhaps have made it into v2.38.0. Or perhaps it could make it
in v2.38.2 if such a bug fix release is made.

> E.g., does one depend on the other? Are they independent and can be
> merged at will? Should the integrator expect merge conflicts?

The other patch series has some code changes that are independent, but
the documentation changes it makes should probably go on top of this.

Thanks,
Christian.
