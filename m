Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E3C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C60D619BA
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhCWQQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhCWQQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:16:23 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C08C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:16:22 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n140so17571057oig.9
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZpJshgAa8YNjv8Y/ynoJF/y3LOYbUVSsJibZrqTxSdQ=;
        b=XmkptiWJlNa8zphrSwgjowEXDJF6cl+3bL5sgqRTJ8yer3+U3rzWUgbGNE9NhEEEwH
         IuVZ5W76bmLaPBUjLvYjwQRuyxNZzbfh2hHCpsufY47ZozMyy7eTy555uFYX7InvfJI6
         ubdY+/TXSu9clAHXuoiUTJlAiUsybPgquaEemvE5jl9gEnW7zG8Jiko3SBDzTuhE7GiG
         9oR+se8rJiHpi7FZMS6p5GvlMtZasoQJX/+xRif4QnZGV/gfWoKVSlAJeQR91rEyNzAt
         QrnrNySrxhqhAHD1d/aPOWGxC7S3FzDEKn178TaL2238FF9ElFbiQR5u0HaH7hXLWAQq
         DJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZpJshgAa8YNjv8Y/ynoJF/y3LOYbUVSsJibZrqTxSdQ=;
        b=DclnNfk8YMP4RbI/cgu24zY+oZjf4CHGMtkpTOl8kIC5o1rP2OZWFOGQTPG5x4O1/l
         D121u8RFTAzRltBieL3kFEdV0bm/89p8TdHE2Y+nEw3cW34MnpCqLttOHb7cMZrIs0ln
         1TiTaJEXGFtouYTiJYPsI8o2XY3uXPNTZh/GCfy2+BXgqc1n16PTaRm1uyE0HO6YSW8R
         x592enc0qymZ1XICUJB2mmKAV9sTqGPVeZGf41KZlH2G6XSCkKDqI8jDUCQzdg+b3Nhp
         RzIINWFY0SGiNJCYslulVdxw/jb/M58MOBZ+/YgtL1GiRcfApRWE1+SUyriw4WqUwKBP
         ujPw==
X-Gm-Message-State: AOAM531uroMqR8CpEORvA4jeGD3NdA7yPyzr9dDKzt4qSyEmvW8gMKcd
        rCNfB29Eo3JLeOjL9tLxYjC2lDA5PfgX3f+w+pY=
X-Google-Smtp-Source: ABdhPJzl5yDFDkUbcYWUKojkgfFDWaKLqkdtQc+AGtpxt0/7b9L975bWXhl5tZN2xcMSnNWPd2pE+uxFoaYiicdMIEs=
X-Received: by 2002:a05:6808:a8a:: with SMTP id q10mr3817895oij.167.1616516182301;
 Tue, 23 Mar 2021 09:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com> <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Mar 2021 09:16:11 -0700
Message-ID: <CABPp-BFixOyd1oX5L-fn8PkYjn7wUx3npr5uZNZTarh3ap-FPw@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 6:44 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the first full patch series submission coming out of the
> sparse-index RFC [1].
>
...
>
> Updates in V4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  * Rebased onto the latest copy of ab/read-tree.
>  * Updated the design document as per Junio's comments.
>  * Updated the submodule handling in the performance test.
>  * Followed up on some other review from =C3=86var, mostly style or commi=
t
>    message things.

Range-diff looks good to me; my Reviewed-by still holds.
