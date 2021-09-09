Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4901C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B22860E94
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348771AbhIIXMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:12:47 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:35776 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhIIXMr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:12:47 -0400
Received: by mail-ej1-f53.google.com with SMTP id i21so344952ejd.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 16:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=it1Dq9FVKnGobcjju+Vxr2PZ83D3huUwYr2chrbhS3Y=;
        b=RMGH0aUyl2Nc0RQsBe0lE3NcNqqbhuqCyyHDl52jYZ4iBkB7ZQD11jy/IxYo6CeYzc
         M0Ypi4rj0kpWCy8HtzdqeP7Na82E98g5Z4tANtCvWKNUmD5GbiSSIgRpDOvByuWfNqmj
         Oq/Ksy8WtOejmJRMoyu/ye0TitnguJ2HqfMHQIqHz6bjual1zIwbiXbLYbAx3ulyLkrz
         Fdm1kP1b0ufloroMC3wYzpQZaoraAhGss/Tg4grzH8uJCLamSYlbLyM+xYooq3StFrwE
         AYKAAkij/UFlUUj3tGiQj+d7//rdssAmLG2X4GtPYXnd5Z3X0Q0hjMfcNXcLOzUI27zP
         3xaQ==
X-Gm-Message-State: AOAM531IlQtjSxXCN2bZ7aNgSb12zFsBVCCl6tY+xzJjW2Q12JZAZS2H
        3XXY9qoJ8tsIfXv16xMdyu36FkzfkmgR71T1cx8=
X-Google-Smtp-Source: ABdhPJzTzWdZRybIUl/F9GjN1pHRgXZmS7/xNiwfSoLBExDPGLKP8jnNLx1kWQsCYuXdyKHAfCBEktoaCm8JVhuIX38=
X-Received: by 2002:a17:906:5a66:: with SMTP id my38mr5917956ejc.36.1631229096166;
 Thu, 09 Sep 2021 16:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <YTqRdU1Tgn/HVhdA@coredump.intra.peff.net>
In-Reply-To: <YTqRdU1Tgn/HVhdA@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Sep 2021 19:11:25 -0400
Message-ID: <CAPig+cRXerwoqthmOAvOKZs=EVb1VB2ig=uBn247xUuWocqDmQ@mail.gmail.com>
Subject: Re: [PATCH] t5562: use alarm() to interrupt timed child-wait
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Max Kirillov <max@max630.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 9, 2021 at 6:58 PM Jeff King <peff@peff.net> wrote:
> [...]
>   - after the sleep finishes (whetherby 60 seconds or because it was
>     interrupted by the signal), we check a flag to see if our SIGCLD
>     handler was called. If not, then we complain.

s/whetherby/whether by/
