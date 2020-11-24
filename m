Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446BDC2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 01:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F037720729
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 01:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S99r6ZqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKXBva (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgKXBva (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 20:51:30 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE86C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 17:51:30 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so26568670lfq.10
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 17:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GwuZWInd8CKKbqTLwMzmyP13NoRXTo2dkQMBaBslSs=;
        b=S99r6ZqN65M8EojQ3aAUeRMIfKtvFMAZlTJyG6XSpEXcgREz9+VWsSh0Qd0XGL3BB8
         NsIHy9PTNCFsF7bUPi8RSo0VPhnPB9zI6o9VGudKAktQBGzmhkzJufFLuT//dUoUQnaG
         cFPPr4AeXIuh8a72hXZRhmFDcslEKrdWY2qzXjeJjNRhko7lqwOkRglP0vJB/RaaSFyD
         nPBTP0YlQ9BlyCI1jdS/KiZeLh63Fio4oGpgVaeYqCsc/0hcmeuWRj9uAlpD6O1+uau9
         aAW+9wZ/So425qE3X2Eh5QQ8hLFmE8QPUueD6U7WOLv73RRpK1C+jOS8i9v78NArOQgM
         c9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GwuZWInd8CKKbqTLwMzmyP13NoRXTo2dkQMBaBslSs=;
        b=dJOdAxPP66R3l91BuPA8WlzthmRZmHudNTIPOtFpnSESULKZzx2ACQIxSoZNRIvY9T
         1aMS4QLU83fargM2uhXUAebafnthXnPQmfkE2WPQJWCbulDgk7JrADQtTwZjc7LzmCtO
         72QQd9aDfah6MUWV3toii383Vov5ZQmsdfaE+gqfoqRmkHmUT/YvrtnVJnFiJmk4ckUB
         WJz4k3HhsYVe8ZbWKCGQL56pwsh1CWTO8K1A2ofba1WlOaj4U2iOHeShOceWSX9yYxG3
         AIA2orAIyuDKezzeZF1K1FCoHgvZMM7GQimi9VzeAZzWXL/LSTabs+B7PAq3xiyFMuEr
         F1XQ==
X-Gm-Message-State: AOAM531o88FkEC+fq0F1wcs9Q5ZWouB7xI7HV5zG4uEIuisFYELRhqhm
        EMCvVMDHPtulQ6muhFmIrWSZjRjl1a+QTLU6SpQ=
X-Google-Smtp-Source: ABdhPJwmnc7dxla+ah3IcufcyNx6KsiPzAyU/1qXojBpV4sfRqu1CR0Oa1+0JTPY+br2CR0XxjbaVywSNq5ZmGs1pd8=
X-Received: by 2002:a19:4154:: with SMTP id o81mr757395lfa.540.1606182688625;
 Mon, 23 Nov 2020 17:51:28 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s0r1vf7x-wHP-b6KQRU7mcPSZzcMRK2VqqxU_SJRDs+kg@mail.gmail.com>
 <C7B2K1BLPDIO.1D6XVJIWIG3UZ@ziyou.local>
In-Reply-To: <C7B2K1BLPDIO.1D6XVJIWIG3UZ@ziyou.local>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 23 Nov 2020 18:51:16 -0700
Message-ID: <CAMMLpeQmJ7TjMKvtjdczyRX+Kebc9DDDyOJthpA6AwxQqy022Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] pull: add ff-only option
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jeff King <peff@peff.net>,
        Andreas Krey <a.krey@gmx.de>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        Philip Oakley <philipoakley@iee.email>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 5:52 PM Raymond E. Pasco <ray@ameretat.dev> wrote:
>
> I feel like the parsimonious change to make is simply defaulting the
> existing "pull.ff" to "only". I think someone who has set "pull.rebase"
> expects pull --rebase behavior just as much as someone who passes
> --rebase on the command line. The issue in question is what someone who
> has not made any changes to the settings expects to happen with a plain
> "git pull", and I certainly agree that people who are not power users
> expect a fast-forward (I try not to force my opinions on workflow or
> style when onboarding people to Git, but I do always recommend
> "pull.ff=only" because I know this is a perennial pitfall).
>
> The problem is that, as it stands now, this would just leave the user
> with a cryptic error message ("Not possible to fast-forward, aborting")
> when they wanted to see remote changes. I think this might warrant an
> even more expanded message than the short one in this patch, but I'm
> not sure exactly what it should say - there are a few things the user
> might expect, but an error message isn't the best place for a crash
> course.

Another problem is that when pull.ff=only but you really do want to
allow merging if fast-forwarding is impossible, having to type `git
pull --ff` to get that behavior is *very* counterintuitive :-(

-Alex
