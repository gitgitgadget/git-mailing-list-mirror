Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2291C433F5
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 09:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiBMJdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 04:33:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiBMJdg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 04:33:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D95C35B
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 01:33:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id da4so22738314edb.4
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fk/9sOoqgpIvQzynJi+/UCEMp0MWa1QbvYiK9Fciyio=;
        b=fMLGtVko4vz1eDvy4lfXNkjnyupqjtQT3bdAvbgqnhS8QNBFUtMGWKDsgBHvu5tE3I
         dGfCpbgO0QT9W08ICVZuPSg2wabSz94Fq0glyqLjY3OIbX6iwVdh1Lney2cSaDO2Uw+2
         RGGC/7zlRsdhq/1Jbmvo/bfgwQ3uVpo/jKdTNhQwazqmA7KbJAqbUu16vwsb9qIRI+DA
         D/i0WMuSV6R27aR9NB5nSTmLYIiqhIYInq7JhTrKtgiOoefS1B0JSNHBzOVE9bekEVAH
         A84uMZ4P6i/RJhD3ZZ/rLEurJEqykjtAL4P0WX71pZyh0aAaGohITJBqVEdXCnzjLOah
         kaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fk/9sOoqgpIvQzynJi+/UCEMp0MWa1QbvYiK9Fciyio=;
        b=Q5kAvbcj9pHUdd+TNpKjdEo2HEDJ8/ozdHceoQRq56tV5rNBGw7G9pom/q6URTqWk7
         QQw27WfK2Oxp0G3ZFHT+RpvwFFi5QX+j1lGA1pNGs4uSHOH4zsAwDOQES/JZAH7uVDpX
         pSRONJj6Kj3MWT6N2fFxBqLAxW2ObhZMWoHGunKL/q7MP7102Op0fxZsy/YVbiRMUzSt
         bwUEw/qFaF0UHMzeXSlCeS2gKkjTuu4SEmmI+/KWGFVc+bxuL3HCR3OfF5C3pTb+KjDI
         8wKOgMFr9AJB6Sv4QL6DG5ibRyCuW8dsp9tankIBMZTlFG9wsPs3elBHfuLbF7q0RTNf
         x04w==
X-Gm-Message-State: AOAM531cTsgGaZsN20jUSMA6ytc6Mp3dm/NkdF/U5zw3bAGvidVMxVXV
        1YqAfxnNRQYFLMD8vN8Gm0+HOkvyXJcxy5/cTupRZscglK8=
X-Google-Smtp-Source: ABdhPJy82sFD2IHEi1nf6NNHcsAvV7zOMuMdhoI4EtczzD5tDJ2uYMmicuRZpN6QOhnuUULiGLOH138RqOgQXH6KT+4=
X-Received: by 2002:a05:6402:942:: with SMTP id h2mr9348103edz.328.1644744808841;
 Sun, 13 Feb 2022 01:33:28 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com>
 <730fb307-3bc7-b52f-49c1-d83b5ab55c95@iee.email> <3b112eee-8110-baf6-d7e7-cb25b03c32ff@gmail.com>
In-Reply-To: <3b112eee-8110-baf6-d7e7-cb25b03c32ff@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 13 Feb 2022 10:33:17 +0100
Message-ID: <CAP8UFD1BYm-_p=JYw3GELsk1=hR9-o7cxEowtnrKPumi0Gk8kg@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git Community <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 12, 2022 at 7:12 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 03/02/22 7:42 pm, Philip Oakley wrote:

> > My latest thinking is that the repos would be held in-tree under
> > /Documentation/RepoBundles and have been exported as bundles by an
> > explicit test_export_function. Of key importance in the project is to
> > minimise/eliminate any extra maintainer actions, so once a patch with a
> > repo export is accepted, the flow through the delivery process to user
> > installs is essentially the same as the man pages.
>
> We could possibly include this one in the idea list but I suppose we might
> need a more concrete idea on what needs to be done as part of this project.
> That would help very much with guiding the student during the project
> period.
>
> We also need to know if the end result of such a project would be an
> acceptable contribution to the project. What it would take for the contribution
> to be acceptable? etc.

Yeah, I think this is the main issue with this idea. We have a section
named "Note about refactoring projects versus projects that implement
new features" in
https://git.github.io/General-Application-Information/ explaining why
projects implementing new things can be a bad idea, and what can be
done about it.

> Just to make it clear, I'm trying to think through on what we need to do to
> make this a GSoC idea proposal.
>
> > Not sure if that's fleshed out enough, or if it's at the wrong level for
> > GSoC, or If I'm right as a Mentor, but I'd be happy to co-mentor.
>
> That's nice. Thanks for volunteering.

Yeah, thanks for volunteering anyway!

> On a related note, the organization registrations are now open for this year.
> The deadline is February 21 - 18:00 UTC. I'm not sure if anyone else is
> planning on applying for Git. In case no one else beats me to it, I plan on
> applying for Git around February 15 17:00 UTC.

I was thinking about applying for Git, but I am glad that you plan to
do it. I will try to add some project ideas to SoC-2022-Ideas.md
before February 15.

Thanks,
Christian.
