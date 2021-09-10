Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71900C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE361059
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhIJPhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhIJPhH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 11:37:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F33C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:35:56 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a1cf714000000b002e71f4d2026so1274361wmh.1
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WI/iEO3H+13nZMjVElr5nY4zyWM74K9fdQ5u/II60g=;
        b=K94+izHCB4Oh2xjZgBZLTz84K37d337GQQ/X0Nrxw8tH5hMtuoFOUusRbrPdZp0Dpb
         mYnbr/TuesZi3vOpPKG+nb0NAVEbwazrinXU76FCieNjuJVI0sGVA9TXGBi12TdPivJK
         BF33PkewWOfMPHdv4lN4jBz7dsM7PInOamoBgGDjgh02goTuZML1bTqZNgIk7Z0QlkJ6
         DQC9z0z0V9sWnxYFHHIp7tO6OC1pa/7H/FpXI9YhooAvJzUNURySU+luKXNNLnRksPYq
         DnN0OMAn7/Zj7KwIla2K4iVULfBsOBTM98KScBmWlB7CarnqAkK43naA+prbwn+cSqpV
         tHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WI/iEO3H+13nZMjVElr5nY4zyWM74K9fdQ5u/II60g=;
        b=5xZFcPbpL/fU1Bc2JXdIhNcb1Qh5cPqVkAd1tlXdQpF2k8Q8g4HU6j1XTYCmZbdZ4Z
         7dk0GrEiTeBj4qD4h+0QvhFnEEpoOS7Y/8bMKezcu3uFbU9EQbS3mbvUAfmSrjLOOsok
         ZDDkYh1HyPFM+8kv2GAiPycuxrBoqOj+w1WP9uIQ/OKY0x3pR66UbPhaISfbDGwmSl4F
         WKRmLefN0ujrHTaajbd+o+lR3UYh6A64SUzvufgC99h7TFXXyjzzPqlvhHTyYIR+fAm4
         P/1O58Kdjoc5nAyYi5NLI5wP1CFTXZ3zTtZES1+EVe1jsUv7Uyn60Fr8F9s9aAgfRVLi
         fWCw==
X-Gm-Message-State: AOAM532GIUUnrUDJ1HfzI3kC7/jLXWM+JAbOxY81kL4V8zA1FSALR70o
        Q5XFuX/5ulCzVOtnDXaFJdT9ZNrKjg3vCqgbulg=
X-Google-Smtp-Source: ABdhPJz0l7TLwh7LGywyJCCynKSX3GAXQCnOSCCPyDNVODPgYm9i6pH+e3kJy1r38o9dJt0X630UBlmfDCj6eGfsuj8=
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr8964507wmk.97.1631288155064;
 Fri, 10 Sep 2021 08:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210910130236.40101-1-me@fangyi.io> <YTt4RymWg+TOEmUf@tilde.club>
 <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
In-Reply-To: <YTt6RTwJw64tYJRw@coredump.intra.peff.net>
From:   Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Date:   Fri, 10 Sep 2021 21:05:44 +0530
Message-ID: <CAKw82xwnQLT-u4xnQZOiuM33=hC298dNt0eMna-KiMkq25fSow@mail.gmail.com>
Subject: Re: [PATCH] .mailmap: Update mailmap
To:     Jeff King <peff@peff.net>
Cc:     Gwyneth Morgan <gwymor@tilde.club>, Fangyi Zhou <me@fangyi.io>,
        git@vger.kernel.org, Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        CB Bailey <cbailey32@bloomberg.net>,
        =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz_Riveros?= <chrisadr@gentoo.org>,
        Ed Maste <emaste@freebsd.org>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Jean-Noel Avila <jean-noel.avila@scantech.fr>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kazuhiro Kato <kato-k@ksysllc.co.jp>,
        Kazuhiro Kato <kazuhiro.kato@hotmail.co.jp>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?B?U2xhdmljYSDEkHVracSH?= <slawica92@hotmail.com>,
        Slavica Djukic <slavicadj.ip2018@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey there,

Please change the line 'Sibi Siddharthan
<sibisiddharthan.github@gmail.com> <sibisiv.siddharthan@gmail.com>'
to
'Sibi Siddharthan <sibisiddharthan.github@gmail.com>'.
The other one is my personal email.

Thank You,
Sibi Siddharthan
