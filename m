Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F341FC4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbiK2Tou (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237132AbiK2Toa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 14:44:30 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FEA6D496
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 11:41:24 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o127so3345725yba.5
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T5iW9SIoNfXJFFGY56jk76UiJxpkgT//PObJBWaHv7A=;
        b=aYpVDIMZfM4mdaRGKUW/KFgeQgZu4GKWBN93zzyHeLPLF0btidjL3ESjIN9kdqbUjR
         oXQgTgzKsf14+8guouZVvbcFZ4RtE2tg5GuZHnMuv2B0Pmu6BD39WLtN8YEVRPyZ9c2S
         ZQ/E0j6oTR3SHUYD5ij2/0GBZ8vUUKn/zBNytNugfxDyMo/0XzYSRXKXBSEyiGInC00f
         oqHKJ1DfSbgnAToGEl/OZRDMrLdhGL3ybiDxVVqWUMLUNkh1FePPB9rQSOXPg1jdWDWd
         jHHrkYHQKdCjfGHz5RxUa/Ed5Ltp9HPJQWXRb/lYHBRITQ+8NsxmyxrZCyCBAXmUzRQM
         dW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5iW9SIoNfXJFFGY56jk76UiJxpkgT//PObJBWaHv7A=;
        b=Ntl9tOUAPoYqdo9QIBnc0dRbnqoH1ordkfXDUYK6r1iRcu1s7tszKbW1gnEyVQN3Ot
         XM9U5MwVAsumPrdVkZueR3OmbodROdyy6YQvijpgOwHIsk59yiqR70xiB3gLyBWl6uPY
         pQbuCLvhDWXBV8j6A4hQ0G6PzDWNdFzdps39GkD7/SaGjipP7FPiy4Sxm1uQAZ4LuolB
         U6UGnfN/XwL8yNK/CmHMbLoccfGrkDFYL1xjuQHr5vc6hi0e+jFOO9DT2MfcQgK8sK2o
         yvpcaUeVKIMFSLoTLio3W9qKdTq/8/rxykj3bFno75fGCodP5Jl5Y1/K6fhuGAsrrsKo
         3hJA==
X-Gm-Message-State: ANoB5pnumEt2yVWGM9Mk0G8naftl+92A2jTo+aNrgRpgOMYueCiygpXY
        zvYWkB6Ewk0o+tHAHJVR4/KBmkvHO69WNMqiKkBOmchFMSE=
X-Google-Smtp-Source: AA0mqf69AJ4FUiu7WPNFFjCtr11g1L7XgABVLcHPDBWV+txA1z3Tug7Hp/3+J5OjnW8qpYA6KgSEQ7EWY98SCqHoox0=
X-Received: by 2002:a25:2d49:0:b0:6f8:f1bb:ef79 with SMTP id
 s9-20020a252d49000000b006f8f1bbef79mr4185069ybe.447.1669750883815; Tue, 29
 Nov 2022 11:41:23 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 29 Nov 2022 20:41:12 +0100
Message-ID: <CAP8UFD3+swv6CQvVT0XvdGZqjpM1k=+ios6T-P+Mc=1+K5Fghg@mail.gmail.com>
Subject: Draft of Git Rev News edition 93
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Heather Lapointe <hthralpha@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Bruno Brito <bruno@git-tower.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-93.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/614

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on Thursday
December 1st in the evening.

Thanks,
Christian.
