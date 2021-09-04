Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A8C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 04:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5560F22
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 04:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhIDEbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 00:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhIDEbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 00:31:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604AFC061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 21:30:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s25so1669743edw.0
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 21:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QAquT9bIqt9jEvdAaMsYQbRgtklK9EzFWwdXriPDcs=;
        b=kKizfht8he5+VBZXXPgSo2NZGpLq+IGzvWLjomN7r47YerA4/GJpEwq2FYArEID9mv
         BaToX0PVROxMv9nO4B+sJsHJMEHQ2Hap0kHwcG1gmH8YSgmquK3v2ako9ssToLXQtE3K
         EC6U8UEdbIYAtmEyhabbJ31ZzEu0f5+28vy4B21AvGGGOQCOy6hWnoMt1B3BYGCUyhmI
         d/HXSOvnEIj4HY4wTRwTeNO3sy+ALqrKMDrx3U2yF51d78JP+mzpeNYy4dtTKnnJQoj6
         gT1OBCmhr4jc4sxBh6fjcXv7pQNi0wkn2ONR+86zqCM8bAjf8KKREDM3IIrE/MDsxK1J
         vIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QAquT9bIqt9jEvdAaMsYQbRgtklK9EzFWwdXriPDcs=;
        b=ibCHGD2aT1r3WMPi/ZXhlQw4YFN5lGzPM91ay7Wx9KTO7BRwVwLYMqWVgV7s6xr4Wz
         s1XhQpCEej9TICxE7ra14rNvx2Ejl3NQR2gXKxfwm6h2MR4w2dv/rqwZMRABnqnCSrnN
         /zZ6P76YEDEQzaLVNFesEBHEKHPyjNWO/kf0cJ/yhW4ecPek0RJ7LB0/U1KW+kd7i98o
         aWkDHmI+S//HhuGjbI1YAX2JoDdW9L2bUWY20VDvyAYBYi6YfnrwNz6EjUGwcaP42x/f
         m0l1XIAbVfk9P45MRzgdxoTcVXxkTaHSbhZZs5xbp7ZjalOViTj+qxxkD4BN/RnQgJ95
         bg9A==
X-Gm-Message-State: AOAM5301L2UraEfguAKCrHI13dHR99msTMHHvDWA3e9Rmf0fXenKCA8+
        MymG61/udWkLAGdRgz40noqUChqPcbj0LIR/oVY=
X-Google-Smtp-Source: ABdhPJwjwr9uKHuzA4AAYC7kHVftlxJze5Qdf0VpVa7SSCO7rq3Gxh9gH3K3DXZuCYdpH4b4WYrh/IAiG7nVMIR536c=
X-Received: by 2002:a05:6402:1703:: with SMTP id y3mr2394602edu.355.1630729821869;
 Fri, 03 Sep 2021 21:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local>
In-Reply-To: <YTGLLQCvlnT17jo8@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 4 Sep 2021 06:30:10 +0200
Message-ID: <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Taylor Blau <ttaylorr@github.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>,
        Hariom verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 3, 2021 at 4:40 AM Taylor Blau <ttaylorr@github.com> wrote:
>
> Are we interested in participating in the December 2021 round of
> Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
> application deadline.
>
> Christian, Peff, and I discussed off-list that we would each try to pull
> together funding for one intern from GitHub and GitLab respectively.

Yeah, and we submitted an initial community application.

> If we're interested, the project submission deadline is September 23rd
> [1]. By then, we'd need:
>
>   - Volunteers to act as mentors

I am ok with co-mentoring 2 interns.

>   - Updates to our applicant materials on git.github.io (project ideas,
>     as well as potential microprojects).

About microprojects, I have been wondering if there are run_command*()
calls that could be replaced by direct calls to C functions like what
Junio did in ffcb4e94d3 (bisect: do not run show-branch just to show
the current commit, 2021-07-27), and if that could make a good
microproject.

About project ideas, maybe continuing Hariom Verma's GSoC 2020 "Unify
ref-filter formats with other \-\-pretty formats" project could be and
idea, though maybe it could interact too much with ZheNing Hu
continuing his GSoC 2021 "Use ref-filter formats in `git cat-file`"
project.
