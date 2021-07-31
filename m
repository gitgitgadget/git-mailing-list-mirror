Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9640C4338F
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796EC60BD3
	for <git@archiver.kernel.org>; Sat, 31 Jul 2021 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbhGaOih (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Jul 2021 10:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhGaOig (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Jul 2021 10:38:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215E6C06175F
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 07:38:30 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gs8so22432580ejc.13
        for <git@vger.kernel.org>; Sat, 31 Jul 2021 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XdYYb33wHyGztwLsxpLc3ilmkLrM2yf0T4a7ELcUYXs=;
        b=VAUcguY/YeOnMXw4ME4zcnm1+/z6xPIhWt2/6iAIyQMdTtRID8UAy+28444f9Jq8Ew
         uYDTLaYXI5cyGaoSq6OTNqWvcfYVh3FF6v0Zuffl3GhLVAdr7ybi6rB6wPHl+kt1Zbmi
         eso5G6VJFEUJnV6BL2XBD3kt+W55C6MtYkyyGzUcJRavwnmmub6y8XlWvaO8XNCiqZLE
         j9baIbg9rtoblHbUgaYAn0G3oMKXeKNg/vAJSSEpqXK3wXnax3B7vBdvVDdPraap6bJc
         6RyFX7z7sNVkXhyICE3utu5TwpZWyx3H4yhowqV76IFOaCqdYNLMVyRUhY7wHsI1uveZ
         cElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XdYYb33wHyGztwLsxpLc3ilmkLrM2yf0T4a7ELcUYXs=;
        b=K0da3NR1WtqGIJO4K1gwh2Tf/WBTS0sZDNFlCrJlbUGE4w89rioVYZTxG70Xr4BZtB
         vKswQQjaQ6goykEyFS9C4j1xM+BZw1L4Y6DrFxHnR77nFpmdH4WPXDyYaafvxuC4cioK
         m5bUOG6nco2FsovGfM6Zeq/n1bxObx2GMBcR3IYDYue0nwat9KgnpSx84yIGbhbAhOdz
         zZicO+dB3yvF/3msz4QKdSEWD/zFwEZZy9sPv685d0gOxQ5r7Lcso3GXe+LsZ/TFQp+e
         +HyImuXs7jI4+EA2PwEI5BU6VuVaP+Z3LOL6oHRlIWcfru9AUuLrVKHTqb5jeyQSEzRQ
         u88g==
X-Gm-Message-State: AOAM531MgQw2J/KPEOwsisfqjTarZV/giKMq5XUrCKm6B8jtI/JRIXVV
        1i91j46A+A1VYASzPR1l4GmcnMcPkDpx3nkcQv8RuDAcdlMC3g==
X-Google-Smtp-Source: ABdhPJzxxj/G/8ninv5KbTaFmZbBqwm9PAseK9jWAPxCSTfNycLDPWI56A1ryNp6epQnCwW75HzykLMqG9vQ7XC90Dg=
X-Received: by 2002:a17:906:511:: with SMTP id j17mr7693466eja.283.1627742308471;
 Sat, 31 Jul 2021 07:38:28 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 31 Jul 2021 16:38:17 +0200
Message-ID: <CAP8UFD0V-ZVvt=8UYJ+AiAoQET449LRJAa+wgf92pkRwWs86aA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 77
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 77th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/07/31/edition-77/

Thanks a lot to Elijah Newren who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/518
