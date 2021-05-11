Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E451DC433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 11:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE60860720
	for <git@archiver.kernel.org>; Tue, 11 May 2021 11:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhEKLsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 07:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhEKLsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 07:48:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5DEC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 04:47:13 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z24so17860893ioj.7
        for <git@vger.kernel.org>; Tue, 11 May 2021 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tai9/PmHnWWBmBcIT3VEvLuNmzWtYR3ev3qSH0sWGkU=;
        b=tjW2eUXg++gTMX1WGjzkuzaOhA8WC8ti3lAyizMUHsk7amkAWEFAnj1fTREOS0gfjw
         HJsF4HOZPOkXBM2nbmHNjWWtXDgF88k8sXs4qf9NLUsXYI5TNojzFZT+fBYc35cFrAC2
         hBbi6tob8k69JsBj/EL4232JLPtx5FnKIr0k538D6VIg9pEMIa7usZ6quOeHH8u8nrTs
         eJ3OHlT3Pj1X3hQuFphQVgoGh3oKOhOOIVtPLBKnjfYCzodrd7EN0JdG2Pyhw4WSOpM5
         h3TS5cPOhR/kmDiFzkZidoCX4mLjK94yYMF7GUM2mFhyggBForYylUCvXRW+QQtvH8+/
         6+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tai9/PmHnWWBmBcIT3VEvLuNmzWtYR3ev3qSH0sWGkU=;
        b=dbqvDYbA3qGkOPpsCfy5CX0ohyLN6jc6hDBGTX0UFBtWXXsGNVGdBVl8opsIE4nlmA
         HV1Adnved7c1S8tF0toeoqoW2XOrRiNkrdx1a7sZ+EqJhNZhBIO9egKknsU0t9VCk0Si
         r4957Zul9/uDBZ3z/j7tiIluCZ2xDDEPavzSNACZrQk3kkqTTgqIOsgLSBBcs427Oxb0
         pHo9CqPAVyAzaxJhBXM8BE/Y3jXt04mj+4hMZBQPctaujC5T243gfTaxVuW5ZDkGc1Cj
         CN5q4NNSmaiCyuVgmgcOlW70CI3+raW1trd1RcQFp1qsZIZ2F29zdue6yX34QTyVH76g
         xasg==
X-Gm-Message-State: AOAM53092AfCNdCNZlZpzA0Ybe3z3tFDFq5n/0s704gNBAgQrbs9aqxV
        ITbtqpWbeR89Vv/HP6bA5n6yZR/LPiLyRZ0CR7U=
X-Google-Smtp-Source: ABdhPJy/uZfZ4+0IwxSQbmV8QWD+K9/o93f3B0riMRMKvc8mxnVgeyltPuDjdlM/88jieDVhfbRWHOhnk+5SrXVojP0=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr22172915iom.68.1620733632980;
 Tue, 11 May 2021 04:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
 <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com> <xmqqcztyovf7.fsf@gitster.g>
 <CAOLTT8QR4Ga41ADKhgB4=C7VgGbJEe5G5HSbcjRb51H2yQVRPA@mail.gmail.com> <xmqqlf8lmxca.fsf@gitster.g>
In-Reply-To: <xmqqlf8lmxca.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 11 May 2021 19:47:01 +0800
Message-ID: <CAOLTT8SiEVR62LwuagnpbZ4XxiUMe2M2WPjaorzSJmfERD6BMw@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Well, the thing is,
>
>     $ git checkout 49f38e2d ;# (The fifteenth batch, 2021-05-10)
>     $ git am -s mbox
>     $ git show --stat --oneline
>     39509d100a (HEAD) ref-filter: fix read invalid union member bug
>      ref-filter.c                   |  2 +-
>      t/t6302-for-each-ref-filter.sh | 18 ++++++++++++++++++
>      2 files changed, 19 insertions(+), 1 deletion(-)
>     $ git show ref-filter.c | git apply -R ;# revert only the fix
>     $ make -j32 && make -C t T=t6302-*.sh
>
> does not seem to break anything.  Perhaps there is something more
> than the "17th byte" thing (like structure padding that may vary
> depending on the compiler and architecture)?

Fine, I guess the reason for this mystery is I "push" this branch to github
and you haven't done it. That may not be due to the platform. Because I
can see no this bug happening when I use a new git repo without "git push",
and I test in archlinux or deepin, this bug will happen in these environments.

I take back what I said before, maybe this is really related to push.

Let's see what happens:

#!/bin/sh
mkdir test
cd test
git init
echo 1>1
git add .
git branch -M main
git commit -m "test"
git remote add origin nowhere
git config branch.main.remote origin
git config branch.main.merge refs/heads/main
git for-each-ref --format="%(color:#aa22ac)%(objectname)"

These two "git config" is for simulating a push environment.

I guess you also saw this bug:

BUG: ref-filter.c:1544: unhandled RR_* enum

I will use it for the test.

Thanks.
--
ZheNing Hu
