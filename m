Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7FC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 00:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BDA64DE1
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 00:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhBAA2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Jan 2021 19:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhBAA2h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Jan 2021 19:28:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888ABC061573
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 16:27:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c2so16902320edr.11
        for <git@vger.kernel.org>; Sun, 31 Jan 2021 16:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=I2iHDOSJXdAY2kLt53ItilQjVnqBkT271rWwBSlALVc=;
        b=JTWVvIkllbhbp999HBhJUSuNMTDoSTpV8kIQiR0KEoQZxs3AEyBLr/OZ72q0/8NN24
         ZMFRbBcBy45OgU1btqxP+8TubUNauKYMTLCvRMk7RXFBKHLV0DubAJ1UirynItwJYXYK
         wo+4SNI5FhRf1CXPYrFJOeRv7eso3j0hii/y9StQknqmiRSEFvGK9t88UgxefOn5ILRM
         BuIYydAkUJJEACI7PgZFX5YhJmYVAXngTlDRsmuObunH3NH4hXb6tw5VhbrUTGJ8MdpK
         DR+5YkkndV07hwXxox79XXMlGMwIuLIoJvVqf0sDUgBMi6TGZM1vS6pHdGzUMoThEJRw
         wDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=I2iHDOSJXdAY2kLt53ItilQjVnqBkT271rWwBSlALVc=;
        b=FF0X0b3+KB+hMTNN86dg+0atH59tiArMF3hYcHueEpB9Edx2xATPC8sdj79N3d7rNr
         UdjgCV39N+xtibKDyp/TaB0POHrR5/NI+tTZnLsMkUKlkQ/qXzOt+q1jwAyb13FO/3z9
         LafiuX9GsOAeTAUqwLk+IsMv4YTYrsNe01evGVjgmExmIR3demcn5COGMAmaFx0qdmhG
         yJs8AdQLCmsxfAv6e3p2RI0sCPmn4ksJPp9T4ZQhHJqTjJTzh+7awdM7qk1eloAqkjRZ
         ky/ZY4xpi25HyJlkziMgVk8rgDZaqKghh9TJlBAW5RvDlDWbCv0GSCPMGbAzr1ZjKhsz
         yuxg==
X-Gm-Message-State: AOAM533o22dgYaqpD9DmPTaO5aFlJww2yCWjV5fGpHMa48eQu30mzTIK
        NmA7T21Li1wikyAGOpNupYQ=
X-Google-Smtp-Source: ABdhPJzEQC21RtgXg+zuU7RmDicyEyJ9sxsvzBv0aGrUgGydeXieYoyyNFaZpPE+IZeWr6q1Ati4Pg==
X-Received: by 2002:aa7:dac4:: with SMTP id x4mr15833238eds.192.1612139276031;
        Sun, 31 Jan 2021 16:27:56 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id y1sm2139605edq.26.2021.01.31.16.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 16:27:55 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
References: <xmqqsg6infev.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.14
In-reply-to: <xmqqsg6infev.fsf@gitster.c.googlers.com>
Date:   Mon, 01 Feb 2021 01:27:54 +0100
Message-ID: <87lfc8ocmt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 31 2021, Junio C Hamano wrote:


> * ab/detox-gettext-tests (2021-01-21) 3 commits
>  - tests: remove uses of GIT_TEST_GETTEXT_POISON=false
>  - tests: remove support for GIT_TEST_GETTEXT_POISON
>  - ci: remove GETTEXT_POISON jobs
>
>  Get rid of "GETTEXT_POISON" support altogether, which may or may
>  not be controversial.

I'm waiting on SZEDER'S feedback on [1], ditto the last What's
Cooking[2]. Also as noted in [2] the "do we keep GETTEXT_POISON at all"
question.

How about we just remove it and see if people who love it will come out
of the woodworks, the patches aren't going to be hard to revert...

1. https://lore.kernel.org/git/87pn1rp5nk.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87mtwvp4v9.fsf@evledraar.gmail.com/
