Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44B8C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 17:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiKJRCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiKJRCC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 12:02:02 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1241209C
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:02:01 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y6so1695017iof.9
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4eMIjP1+4KFt8gPon2KUoOR1H/gfIh6H+cj6JFwLs+8=;
        b=H40tVQHO4HeiQtmpf2A+NngP5xADNUFfqxKMzRXhEWuta6QxeQ2B+fITLPkEIowyP9
         RgrADAAOWjnrPx4Cl030ZT53JIAwIGahElkq88IK+ci3jUaju4sbM6ZV9UjoV1F/B1ys
         VsMSPvdaY8wc4c13fuc2TDcF6s/wxFc8BnxJrUmXxQuB4ZHjV/861A8bTijPioadUiy9
         pTfLj5o/V0nLUth0VrBrTLLQxeg7gJ2D1rgVTuwgu+MLxvRyLLpR+t2fEa0SDjxQkrt8
         nxwoK7i5kYcZbY7NVfXFSWX937dpnGnyQwbf0bdoZPSNkvSt+3Mq86+x/cvAmu6p1dVX
         eTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eMIjP1+4KFt8gPon2KUoOR1H/gfIh6H+cj6JFwLs+8=;
        b=0DUMx4n46BkENCjf5qu6x/Zbhbyd9629y78qAK1GO4LiZKKlk28GQBrZdJ+AsRweHc
         2jO70UYKkfcXzsWCl4z5Ax5dnSICmnuOS/x24U+5f9310OFB+FpiNpzQWjEZQyRTg2IR
         iAVYNoJDBhdBG7KJml3DBcsiMl3FC7x75fG+hUEjPX+Xu0Gz5Ua0ZJw8Oo3o7dPhCx49
         cxX4gg52HDibzRhhps8xBYLimaN01tZHKw0PuvqSadLiEeKndBT2Fq00mB1/tuwMgebs
         dxFGEG5RzkTmGTQycRc6ORhNVayQAusoSs+cfB6+pqDXJyw7OnfGdacIJdICzU+hD32C
         a8Ag==
X-Gm-Message-State: ACrzQf2KNkJfYhXqcvFeihi8IJpmL5jZr79ujLmwmjHGz/0R1MTVOdEL
        /3PMrz+HaiNMpd1OoXoEElACI3fkztSJAVmz5hY=
X-Google-Smtp-Source: AMsMyM7Lpwh4rTWg6DNh+kBLbY2Em/VvU9OrRu+Z6KKAJ+WNduA3W7J3mw08w0PnZZ0aq/64dsPulKz8XAebli4XHnw=
X-Received: by 2002:a05:6638:19:b0:375:2b75:93d with SMTP id
 z25-20020a056638001900b003752b75093dmr3115027jao.235.1668099720896; Thu, 10
 Nov 2022 09:02:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v3.git.1667424467505.gitgitgadget@gmail.com>
 <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com> <CAPig+cTGG-y6myEYOVeF8W9QBdCjhqeghsepi-2R9V-v7=YwZA@mail.gmail.com>
In-Reply-To: <CAPig+cTGG-y6myEYOVeF8W9QBdCjhqeghsepi-2R9V-v7=YwZA@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Thu, 10 Nov 2022 11:01:49 -0600
Message-ID: <CANaDLWK9ZhtqdpJJCNvOJ24x0jtUzZjZE5WKdzBPnePA4eGqTg@mail.gmail.com>
Subject: Re: [PATCH v4] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> the <<- operator allows you to indent the here-doc body
> (with TABs, not spaces), so you can align the body with the rest of
> the code

Unfortunately, that's how I had done it first, but since some of those
lines are blank, the test code had lines just made of "<tab><tab>" and
nothing else, which made the check-whitespace check fail. I considered
replacing empty line with something on the fly with sed (like just an
"x" character for instance), but this felt hacky and brittle (in the
unlikely case where an actual "x" would find itself genuinely lost in
the middle of that output, the test would mistakenly pass). I went
with the solution I'm presenting here because the readability
downsides of missing that indentation felt less bad. Definitely
willing to be convinced though.

I have no issues with anything else from your review, and I'm planning
to integrate it all. More specifically:

> I presume the reason you're escaping the "trash" directory is because
> you don't want these untracked "actual" and "expected" files to
> pollute the `git status` output you're testing?

You are presuming right! The test was being flappy in CI runs before I
changed this, which I found used as a solution in other
git-status-related tests currently in the codebase. I'm not familiar
with the trash directory approach, but I'll figure it out.

> Does this need to be inline? Is this a hot piece of code, or is this
> merely a premature optimization?

I'll admit my limits, I'm not familiar enough to know. If you feel the
inline is unnecessary here, I'm glad to trust you on it, I'll remove
it.

Thanks a lot for your in-depth review, I am planning to integrate all
the other feedback, and bring another iteration forward, possibly
today.
