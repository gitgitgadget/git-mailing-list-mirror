Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE65C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55ACC2222B
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtrKn8tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgJON6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbgJON6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:58:11 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7E2C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:58:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y16so4187820ila.7
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/leiLEvyGH8ClSVM70DTwmK1LrX0dAxR6pNPky3BgAU=;
        b=rtrKn8tj9fmDQs3cgW5hH5l/sC32AUouzQBM4CQ4ob/KXcx34fIYc25dPoWUaRFExP
         f2k1yDesUrClxlkqqrDe3VRt0dVRuPA+ClTweGACdzMNj5P9um4Ac79d2Pi06QQJUcaK
         BF3myukFGAfdeOUNUB6o96B4f4fpRgirBMZJz8W87ZqnqFm4SxYL5nJXnlxKU2OKOQ2Q
         jdetzmYqt9xezHuzjfOx0D6mbw689A3R8MIhFg0LuH1lN+VHG4eC1nkaGtOK/Aep14nU
         OQ+YjupjKi24ZtA4q+D/E8dL+SgMNmC5cxhNClKUDzgSPwUus2y2uGF7Eh7F5f2H+SNk
         dN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/leiLEvyGH8ClSVM70DTwmK1LrX0dAxR6pNPky3BgAU=;
        b=m4GIIE5zOayhrbX4Dq1xureua9Iumx+8mSbW973L7bpdWXxEDiGDsfDuQczqWdZMwG
         tMHUi2KW5w6KJFOpEfS3YCMBPqhsjf0n3Vzt87Yw1DhvM5jpV6Iob4MP0m3jYcCpdeyS
         SLkBZuf6AnoLKmOenFBKKGZwQHqil4zey6xlMg5SzDK0OzpQ6Xv9uSeYqh2t4X7S5tmf
         rFP2cDaQGtPpowb7YEZxy4D3vc8bCdAKRIcbmUSlHZ/pOwBMCNmRb4g0soqAb/WwUsDB
         0HyWP1W/i9iYQnKzZXIRL5wxb/nur8tdqHMFXRrkrPcmoaUtidXTAhYBdDyou/jMV8Yf
         CBXQ==
X-Gm-Message-State: AOAM531PK3mHwRA7NjPDXm/ONdhfaF0dbyX8nDQ3BcX2NNsY7wQPaVic
        Ij4BWOEv+ITk+JLDI1VpnLaFwWVtn6Kq4MMj8GA=
X-Google-Smtp-Source: ABdhPJyBieANgoKQhARCRbzH6ZmOGichsKNsWEuywlV7kd+fcqhaYgivbKOIgSoOdhudPkcv6ooU76dTn9d/K/swE/E=
X-Received: by 2002:a05:6e02:11af:: with SMTP id 15mr3002165ilj.5.1602770290153;
 Thu, 15 Oct 2020 06:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com> <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com> <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com> <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com> <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
 <95c90e7a-8f4c-32b9-2b0e-9efce2acfb8e@gmail.com>
In-Reply-To: <95c90e7a-8f4c-32b9-2b0e-9efce2acfb8e@gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Thu, 15 Oct 2020 19:27:59 +0530
Message-ID: <CAHjREB6i7ZSSXk10OAOXcL-Av3WzesCkMKL2ES_aBRsrynT9DA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, kaartic.sivaraam@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 7:09 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
Hey Phillip,

> As we store the config options in default_diff_options and then copy
> them across at the beginning of repo_setup_diff() we can use a flag in
> struct diff_options which is set by handle_ignore_submodule_arg() to
> tell if we need to initialize opts->flags.ignore_untracked_in_submodules
> in repo_setup_diff()

Even if we don't set a global flag it is working fine because we are
setting the default first, and would let the config override it. I
have updated the code in the PR and you can have a look at it. I have
also added --ignore-submodules=none in some tests to get the results
mentioned earlier.

> Are you adding the printf and then running t3600? If so then the extra
> line of output breaks a lot of tests which in turn breaks to setup for
> the test that was failing so there are uncommitted changes.
> Unfortunately it is hard to run a subset of tests in a lot the test
> scripts as there are implicit dependencies between the individual tests
> them.
>
Oh, okay it makes sense.

>
> I'm afraid I'm still no closer to figuring out why that test in t3600 fails

What it is like debugging in Git? I have seen people writing debug
statements(print statements in between the code) to figure out how
things are working. But I guess we might not be able to do that. Do we
have to create the exact environment that is been created by that test
to check for the code?
