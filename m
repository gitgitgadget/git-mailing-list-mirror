Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C9DC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 05:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524092076A
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 05:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Dx6rgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgJPF1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 01:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbgJPF1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 01:27:39 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B04C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 22:27:38 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o4so2239203iov.13
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 22:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXJev+sGATh8jc5fbjKzFODu6h9/7F1L4LLpy4Udhlw=;
        b=N0Dx6rgoKAuEVZpYNU++SEV/TvGPSr1FnXmSpAktkzgDUogxYmoNqG3WxMGWioL89c
         MPnyTueV59JggrJI5zOvsJhXQDZUhgqNu7DO1S+wut1wLB9112W8WFEIyqG6/PUOqt66
         m4XpyUWHaVtw1V0nDk0ebrIHZ9LxvRDn9dEdbZr+v3fLNEA9Dt7hPFwjezSuNyg5z2GU
         uYsR/phjwrSLB0ZjSU+5FypFzWjqD494fZnQ/Np+ll4ZX/N2jlFjjZ85iS/pRc1UiKF3
         zx61AjFQQVViNKMlnUvFYnvLaeBcDcsrl1kxiKHiOxQuvJTGYXvqqUI6xoj+CmWdFR8V
         aSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXJev+sGATh8jc5fbjKzFODu6h9/7F1L4LLpy4Udhlw=;
        b=A2H0Fy81H+KEE6QCrHUK2gKZZygG3pWS/PzhcqwAl61MrFoNhS60h7A7bYPBMk7bca
         Bu1vCORcEb1j6PUrXSD7PCYFy0KdebEy/QLzPi52kGBHIQ20Piralz+6ZTCnWJe1ocnX
         Hs3psT8uO6oZ0DWmGXC/ki8Bl8+DT72Zd3fXop3iI7WD6TEwPo5FwWqjxkNEnzZwXZMb
         4maKqGbyTMwLoFbvY7gC6+6U6yu1pByN3kfYoN60BcP5bgD55VXYtrZtQl5E7sHLubyx
         UxMmRtkHdFQJBZlAmFR9kYUbAJ7EmIn5c9a0FJyuqVGG6BJdjPYu4RDTGcnxWPsBMc+f
         ZFMw==
X-Gm-Message-State: AOAM530gD5k32LWIqxFNiV2rsja2+5Kx7ev9LoXviT5G09BG7DtGM/o4
        jNDL7X2/FN3Ek25Gc20U2rlSZzcRzdSkFOWabQY=
X-Google-Smtp-Source: ABdhPJzSPm+JpFffdQUagzrdelL7lwrEopv+lIWFls3bjrMlUIlaHmqXxVIFxKOY05UFRifgDWoP3RKCH/T0nsepnu0=
X-Received: by 2002:a6b:dc15:: with SMTP id s21mr1192970ioc.162.1602826058159;
 Thu, 15 Oct 2020 22:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHjREB4gsyOrdnhp0_9rs0wv5q5H47-3RcB3fm5NY+L=3SYnMA@mail.gmail.com>
 <22e3d737-8621-9f20-307e-fc4c2a47ec0c@gmail.com> <CAHjREB59HjZAs98wMPtMANcHUaXGou7CYg9vAacc3m4uz1yUug@mail.gmail.com>
 <7d691f37-b8b7-510d-ba46-51a4a7587226@gmail.com> <CAHjREB6j6BqZ49wX5uqEOiysTAm8Oo7N=EFpcoovWKkBghBjxQ@mail.gmail.com>
 <xmqq362jsahk.fsf@gitster.c.googlers.com> <CAHjREB4Qw78xS-T=LA80yVf_u3=Hbpxg5tqBnP1QK44FRkBFOQ@mail.gmail.com>
 <3c0bf417-b3d5-b615-c605-49a5d8be4e06@gmail.com> <CAHjREB7xhBWHUCJ+T78i6dDGQr055sMAaYzG4gaQSr0T88cseg@mail.gmail.com>
 <95c90e7a-8f4c-32b9-2b0e-9efce2acfb8e@gmail.com> <CAHjREB6i7ZSSXk10OAOXcL-Av3WzesCkMKL2ES_aBRsrynT9DA@mail.gmail.com>
 <8c9b409b-4e44-ca8a-9075-36a7332f9765@gmail.com>
In-Reply-To: <8c9b409b-4e44-ca8a-9075-36a7332f9765@gmail.com>
From:   Sangeeta NB <sangunb09@gmail.com>
Date:   Fri, 16 Oct 2020 10:57:26 +0530
Message-ID: <CAHjREB44_bjPF86fF3EToD6mVqeLbmtzsN8NPYu1QLes7kpwHg@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, kaartic.sivaraam@gmail.com,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

On Thu, Oct 15, 2020 at 8:15 PM Phillip Wood <phillip.wood123@gmail.com> wrote:

> diff --git a/submodule.c b/submodule.c
> index 8f6227c993..c4182be633 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1679,6 +1679,8 @@ unsigned is_submodule_modified(const char *path,
> int ignore_untracked)
>          strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>          if (ignore_untracked)
>                  strvec_push(&cp.args, "-uno");
> +       else
> +               strvec_push (&cp.args, "--ignore-submodules=none");
>
>          prepare_submodule_repo_env(&cp.env_array);
>          cp.git_cmd = 1;
>
> fixes it, I'm unsure at the moment if we should be adding the extra flag
> here or setting the appropriate option in status when -uno and
> --ignore-submodules=<option> are both omitted though

Ya, that does work and the PR passed all the tests after this correction.
I have submitted the patch[1] for it and would be glad to have reviews
on it from the git community.

[1] https://public-inbox.org/git/pull.751.git.1602781723670.gitgitgadget@gmail.com/T/#u

>
> Have you setup a config.mak file? Mine looks like
>
> DEVELOPER = 1
> SANITIZE = address,leak
> CFLAGS += -ggdb3
> CFLAGS += -fvar-tracking-assignments
> CFLAGS += -fno-omit-frame-pointer
>
> Which will build git with warnings enabled, debugging information and
> enables the address sanitizer. Then you can run the git you have built
> under gdb with
>
>         GIT_DEBUGGER=1 bin-wrappers/git
>
> If you want to debug a particular test then I find adding `test_pause`
> to the test and then running
>
>         GIT_DEBUGGER=1 git
>
> in the shell that the test opens (it sets up the path appropriately).
> You may want to add LSAN_OPTIONS=detect_leaks=0 to the commands above or
> set up a suppressions file
>
> I also use printf quite a bit but it does tend to break other tests
> which can be awkward.
>

No, not yet. I would set it up. Thanks again!

As my next step, I was looking for some #good-first-issue to work on
where I found an issue[2]. Has someone already worked on it? If not, I
would love to work on this.
Or if you have anything else in mind that I could work on please do
suggest to me.

[2] https://github.com/gitgitgadget/git/issues/486[3]

Thanks and Regards,
Sangeeta
