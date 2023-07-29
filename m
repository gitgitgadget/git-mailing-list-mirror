Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C427C001DC
	for <git@archiver.kernel.org>; Sat, 29 Jul 2023 20:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjG2Uie (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jul 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjG2Uid (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2023 16:38:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3367C3AB4
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 13:38:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9349948a12.0
        for <git@vger.kernel.org>; Sat, 29 Jul 2023 13:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690663088; x=1691267888;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7+FGVJHl5o7PUFj7/eM1PyPYOW3WnBB0KTuBtHB3h0=;
        b=FV8s0mm04VAgegWEoT7AyO20oWXWKZU5kp4EYaXWB3NsGm7eB/zFj9Eec3ROn1Ws4A
         xQfoiUCSdtMgsmKUVA3mjGfBby3WMbLrY+R+TO4zEo62ojfcq++sGX4id8nVGvPynE2I
         HrQ2uBNTEvXqQ4Y0qOJA9r0pBOEy5jPVjsOtZrJcoFYkMAPV1O/Qxpt5HG3KEjSRNITP
         iBpRs9Hou7oM6jnHxfL7VlnJ6CducWrnJn2KLUmDSyj5qwQMMNM1hjZrZIn5XOHA5wY/
         j9dUiXw3X4VLhYKcbJwv16oFB7WX5uI8/t+/MjnU6R09EwHvQ/M9WeMXtcQSfXEeRv+A
         PVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690663088; x=1691267888;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7+FGVJHl5o7PUFj7/eM1PyPYOW3WnBB0KTuBtHB3h0=;
        b=fDfEIh4jQbuSJ7eeO2r8D39qxkvjdnmXQ8frMoX0Bkxq/JTOeMe4vzwZCwjw7l6t+C
         ZRirQ501VjKFGjDPFKLz/YFxUcZBmtkiX8Hubk6m2GTZEWuzcHvlD0dY6SX5LQ/HICdO
         qNev3O0qs4rreNt15B8vl5fgQGyJOpqUU9FqorOrYIWoq6EK5UUeeiS2vxWplchhmlJL
         r3QS/WLpHAvxe5AmQhWLEBJvEn6XujJDb81uO/v+fucfHI/8/0UiaUUnyYh/Whu92Cs+
         sSD9FVN5e8sDAGXisG6JOQ1i3cWCZdIhtZ3ClLtWMqZtLpkfYuWMFzZBdQ2Wkul1IdJK
         Qtag==
X-Gm-Message-State: ABy/qLbU0zczco75rkPc1KQ0KKQkl7fc7L7UNJGDxE/l+rjgC+T5ZOhD
        ga0uaVWd2d6UgmrvKcJCaJN7zboabbYVRnM5X6/K4qUufeU=
X-Google-Smtp-Source: APBJJlEaK0Zjl1w+KMt2FAzYXAEa77ruju1Mr+zqYCbYG+NwPckcUDZicSANC8999mkzuxkH5UZYzx2fn/KZwqTkbNE=
X-Received: by 2002:aa7:cc18:0:b0:51e:421e:d209 with SMTP id
 q24-20020aa7cc18000000b0051e421ed209mr6512167edt.13.1690663087453; Sat, 29
 Jul 2023 13:38:07 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 29 Jul 2023 22:37:55 +0200
Message-ID: <CAP8UFD1M3sRPEJ42v2=pQ_CQYY+PN64Swx70O7D_=VfbhSwKLg@mail.gmail.com>
Subject: Draft of Git Rev News edition 101
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bruno Brito <bruno@git-tower.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Canpolat <eren.canpolat@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Linus Arver <linusa@google.com>,
        Victoria Dye <vdye@github.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-101.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/652

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition late on
Monday July 31th.

Thanks,
Christian.
