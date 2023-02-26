Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ED8C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 22:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBZWMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 17:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBZWMU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 17:12:20 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250D918B04
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 14:11:55 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-53916ab0c6bso127907397b3.7
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 14:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E9zfNDH0mvUVD7Oyek/UnvH+yrnb2/VHPqpEqDUy+sw=;
        b=QCW/D0peWPLrzLW/BXbjbXpROC8XwvwOaHJrnO1N1SzAJZyMM0VqKZDaC8J4JAts51
         +ZLpHAhi7SnZthZ4g3bKZCCVru/4XhkQqGuizCUKpQIoTMZASlYp+F2IjnePnvDf5tj+
         jjN93+GN6I89Cr2VMNlshbH7S61nN86590kIcYj8JDn1C4Pa4J7Lo4AQ67D/rhX2auay
         5vcJ2Mwe+YcimhtA+kZdoDwyO56TXH3WoDjgx2UrZz02EaZGuG0ZOiZfQFIL+RB8Jh+9
         b/RsPeo5th+dLcct8iBU5yYUPPeuJLYn8xyLxpGHKuMdyg78EbEXBsFMg+boEzKnrob6
         nLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9zfNDH0mvUVD7Oyek/UnvH+yrnb2/VHPqpEqDUy+sw=;
        b=p/YSna40NdwKl9LbBsgMONHAQOsHd6I6gNG2TwP6k/uruHDrOj3Uf0WBRnEfFZ1IQh
         sBpl8cm7BF8Qw6Gx3LgLwnmdJQQPKV0RAyrq3H3EFV4HhVN8Iqz6C188grG8mWBc9rNe
         DOe29s6DJKHFmpJl7JNlFUwQR3xEeBJ63Ww3ojAiASFlINY2LgeFLecKstfI6rsPyegC
         N3HZ/Yc0wWwV20EO3tkFKTNYKzBA77gSRVTw7ciY4pPg20eRlsPQqZln6kVeSJEnhkwy
         3R4ZkR7RPNTLtGfXWxlfCaLJUBzne0M2eCJIqlZzdr/G36eIYnPzWEv5RRH9zcOEKx/i
         ZfVg==
X-Gm-Message-State: AO0yUKU7YKtKUz35kg60m7BkIDX4oMMHOSPXNmKE6muGgcZiZJuhCMz8
        6dTfYxyq/OGomzPTX0eePrGeHTL4XtNvcII6isYnTnblW/s=
X-Google-Smtp-Source: AK7set+a8ZebK504s5TpwmH5vRNWid8epi8trhbot8+wOlvVC+wALosk4HT5tSbPJPwp5pMYDmdAeG4EZxmsxbAqV58=
X-Received: by 2002:a05:6902:158c:b0:8bd:4ab5:18f4 with SMTP id
 k12-20020a056902158c00b008bd4ab518f4mr5627390ybu.6.1677449514037; Sun, 26 Feb
 2023 14:11:54 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 26 Feb 2023 23:11:43 +0100
Message-ID: <CAP8UFD09OvzG+q2BEN4axiKHNLkKiXB3TaqQ7hqFx4Bu+iPcfg@mail.gmail.com>
Subject: Draft of Git Rev News edition 96
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-96.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/625

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Tuesday
February 28th in the evening.

Thanks,
Christian.
