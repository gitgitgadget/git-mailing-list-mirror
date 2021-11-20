Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B361BC433F5
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237882AbhKTRZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhKTRZS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 12:25:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B9DC061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 09:22:15 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id t5so56992074edd.0
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qw0rS0iMQwqNwwl+tc/zZRK3SgC/wNo9pb7NYzbyv48=;
        b=LQr2IQybuikjU4y1Lf52xxvA1n+adRY3+YNKC3kK8uDn2D/8BYURrWqhHCW2b5N1/m
         iqKEPFdzRgBTLSEsCozyKUFWWAzItOBA0hJHx/bMqmULbmocwSopVMNHu8efkkGdzDqR
         mSAMvpwx2KWsRQInwG5GWf27wMiRGaQVuOoiMeckuqEzdYPlGmR0Pxcwzqi54WkVDMjz
         HicutDz5nPIwUQ9hX0ACvtcjSzpa2dc0LaM5/rg1gHKZcMS9ANTjZw9y/GTgvM5oNAio
         7uoFKn5pQiVbOsKDrsqPHOQ/NqYB6WZYS0PRpBtHBspFlGbIgRjMOnEZj/fr/KtdDJHP
         8TgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qw0rS0iMQwqNwwl+tc/zZRK3SgC/wNo9pb7NYzbyv48=;
        b=PFsEJFweQnxrUPQbhchn1FvFzmFzEtyCtgs3O0xF2oicaxwRRWIW+9i3uIfDS1i9kA
         zdlYiBV7deQIMK3sR04EDZH0cQ9XaySgDMljUsYCqLWb2RSdWhhJsjBjhZOCt6bpBb91
         OOONsyD6OysPemiYWDQ5EsTV3BTaem6cW8lznI4OmTX1kj0kmhJBBX5X89LHcpyp5MEK
         rW7aNf1xzj7KIAUBYxdYT989dXLLw377sEwdxfkm/L57nW5NjIxpEEH5CPqK9ERdg181
         sopFz7IU/sicwslxaEczBnVm3GXK5wyQFywzWFESu4pk50HkG+/H7Wz3auxsUAvdLudP
         ZvGA==
X-Gm-Message-State: AOAM5325oLpeF90v1XKUPT5FJ6oJFlLyMtoiFxz42PgBkXViw+9mCFGJ
        JMu4fB4MUi0/VBW5nenIoyX9G+BQHd05EdmfH9glEOjroow=
X-Google-Smtp-Source: ABdhPJxM9XtMGEU6srraRwN39W+/r9DmA79zQtPDqTJIEcyux0/2SztiaqPnOAQMkTef0ke8EP8hWllgBTrYF6ecqKw=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr40044267edx.244.1637428933644;
 Sat, 20 Nov 2021 09:22:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 09:22:02 -0800
Message-ID: <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] Upstreaming the Scalar command
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 3:03 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> tl;dr: This series contributes the core part of the Scalar command to the
> Git project. This command provides an opinionated way to create and
> configure Git repositories with a focus on very large repositories.

I thought after
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110062241150.395@tvgsbejvaqbjf.bet/
that you'd update merge.renames to true on what is now patch 7.  Did
you end up changing your mind, or was this overlooked?

Other than that, this round looks good to me.  (I have no opinion on
the build system integration, other than that I like it being optional
and not installed by default.)
