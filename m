Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D18FC433EF
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 23:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357449AbiD2XW1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 19:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbiD2XW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 19:22:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB0D39AD
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 16:19:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j6so8067623pfe.13
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PyollLlV1z24yTlACYJhWUrBSMGD0MTwEBbicEP37EY=;
        b=dL0JPeLcjhdEeHIyB6BLmRhlT7QyYxTim1/kSnR1wWgWSG9i3rZLZdBummCdV9jK79
         pkG1+76Dh1/xVY7tLfxiiJjn3rPzs9B/S5qY/L/h0kDyT6KCU5GQY7onvc/C7GkOVbNn
         p+7YuMK3eUkbSN0ULmwoejlxS49tOj4l3qUtHDp07UKf9Af+CEHgzwXjlZxOUUO3aQ2b
         eW+tTwhEhpQUAa7j85sy4RG1kM6CiC8k6HDvdgA0GSoqKHyMm11d8dpqm+lMFDG1nxhr
         Wg8ObyVPhP4k70GZz/TCsXH3eIZT9yNFjHXsl19s67iwETVwBZZaZRWAos0yO7+pfyCr
         A6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PyollLlV1z24yTlACYJhWUrBSMGD0MTwEBbicEP37EY=;
        b=omlzumHHWHVXu3P9ECqfiyxHhHoyCMMbzlbzbpfk+Nj6aZ/chN5aAOuqjr2qIfYWMM
         5TTO/XoQL+Si62LV4uxoAsZTDGqjDRum1c+T0XiaOKmuHVEWXIlYKtcRUTNXZ4bT+j+y
         NXPXTH6FxdLjHbKMcVCjxKpO/aMMrEFOSvUJi1tnVJsBJV9jF/co3XDpflwd1U8dD3yL
         YkY/Hq+/S+WbzWKifk3n9M4RDo39O1HZVlkF3+L63DZJ5r4R7YMLQQZjp4GLwlrXr9KX
         FvNNe8CLYcxwZ7pP+ByjdMpBeihDG+6LbiE57I6akR3hZCqXQNPABuUDvYtAmzcwtZKd
         10eA==
X-Gm-Message-State: AOAM533bhQUF+i6N58oMNj8jtHFNyg/8TV/6BeHJpT+V8ur6YbbOp03e
        F8MzwFaX85V1FDnyQ2XULkJ8PMTjZ/0qXQQC60t4d9IvNB4=
X-Google-Smtp-Source: ABdhPJy0bmYYF5IzzxD6sfXUt7mz9p5KjEtlTICwIi30yHzHRbBYnPXwhsRJPfpmQnvdMQKQiwhbbx24aYf8Gjp1cRk=
X-Received: by 2002:a63:4101:0:b0:3aa:6375:e5f4 with SMTP id
 o1-20020a634101000000b003aa6375e5f4mr1227382pga.240.1651274346145; Fri, 29
 Apr 2022 16:19:06 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 30 Apr 2022 01:18:54 +0200
Message-ID: <CAP8UFD1kL8jGjsCZPY0aV4zg2yv4cNVJr6hNX+neKVkZHk8+Dw@mail.gmail.com>
Subject: Draft of Git Rev News edition 86
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Bruno Brito <bruno@git-tower.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-86.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/568

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on Sunday
May 1st. (Yeah, we are very very late, and it's entirely my fault,
sorry. Also we will cheat a bit and pretend that we published it on
Saturday April 30, so that it doesn't look like there have been 2
editions in May 2022 and 0 in April 2022.)

Thanks,
Christian.
