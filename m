Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36357C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF7861184
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 23:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbhDEXkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 19:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241886AbhDEXkp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 19:40:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F6C06174A
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 16:40:37 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a1so14388334ljp.2
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfGb4jzeR8BFU0ImRfhIkO8JlejMNS+QnMwyj1tzT3E=;
        b=epOune/7acKAawWwRvgmfn2n2D6pO0byRge5/E/7MtblmAsdridTH5dF/ThtqM2ZHr
         BzI1teD8FKs9ii7EjjWJAVT2myN98FELPnNUH+OOt49ZGX/j9XcEW9b/Ul3bKZ3yCWmj
         tau1f1se6GNwOybVR2oV1UJfXV6k5JcK/T9SZqRZsO+5496bPi75qWtOvOZhxyiSiw9j
         rra2MqpoEz6C9hzAXWL/uQdhkHneUoPtpP3R4iAEb+wzU7FUPFGae6EDkM/n+5Vp9bYQ
         04Eam00HqBgiVmgl7G4xhyDtbL8CfE7oubyAWfwv8nK04ZTBDdymLwdDAHEga0n5Q1Yj
         0xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfGb4jzeR8BFU0ImRfhIkO8JlejMNS+QnMwyj1tzT3E=;
        b=Hp8BeZTOORg2PV18TTjEULgzW+NNYtFGznGEKxB2YQHQJGkRxt/L+nYgZzF1J7rhjQ
         EmCHCWCKqXxTq20xB2fNBZVnRhvgF7Uj8DzAoluGRT/SctcfG2VSi2sJEN8t8hsXTaNR
         YrAOcU7WbfBxS9k5BQRifEEKWsfcbDblKB6fcjg5rwjIsOzGAaWGn/cKdIJ6WRR9On+6
         az8lEc5oNrfxbo1GNqbxhjDfhZwZZtJpuLAWMb6nvuaPHpJFps7aCbMdECBKE0qfu/z+
         eEgvccaA69OWvfty/nmZO8ohGIueo4VNFms/xPyfuIbi4Uv79hCZ3cDtikaanzx7BPT9
         qzwg==
X-Gm-Message-State: AOAM533xe6ZJiR0RyprDNB0p8DSo4dzroVKLLZc8ipx+rmd58VxNGjaQ
        ij/4nLQaqy/UMlO2DrCrJIwVs9Agm5M/NOXbYyQyGcWuVFA=
X-Google-Smtp-Source: ABdhPJy0+seWcfoohzDudzC2rD1LkZB4zhylmPcNnDfSdk4iyCePYqxW1Rj3k5BJrzABv5R46Wddmj0MpVbx1qCYjuY=
X-Received: by 2002:a2e:9811:: with SMTP id a17mr17504366ljj.52.1617666035887;
 Mon, 05 Apr 2021 16:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.908.git.1616105016055.gitgitgadget@gmail.com>
 <pull.908.v2.git.1616723016659.gitgitgadget@gmail.com> <ec031dc8-e100-725b-5f27-d3007c55be87@gmail.com>
 <CAMbkP-S-9cccMpU4HG0Wurqap-WkTmD2zk50nKd9kJ_oWO__qw@mail.gmail.com> <xmqqmtuc49cm.fsf@gitster.g>
In-Reply-To: <xmqqmtuc49cm.fsf@gitster.g>
From:   Albert Cui <albertqcui@gmail.com>
Date:   Mon, 5 Apr 2021 16:40:24 -0700
Message-ID: <CAMbkP-SBQMLeM14d9KSnzE44KsfhHPsxWQ1PaskauWPynTJvWQ@mail.gmail.com>
Subject: Re: [PATCH v2] hooks: propose project configured hooks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Albert Cui via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 4:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Albert Cui <albertqcui@gmail.com> writes:
>
> >> Requirements like these make me think that these repositories would be
> >> better off with a script that configures the hooks after checking if
> >> these things actually exist on the PATH (and installs them if not). I
> >> would lower the priority of this one for now.
> >>
> >
> > As mentioned, for enterprise deployments, this can be solved by administrators
> > installing any necessary software automatically.
> >
> > Otherwise, I think ensuring the tool is installed feels out-of-scope
> > (as written in
> > the doc); it's not like Git makes sure compilers or build tools are
> > installed today,
> > and even today, users could set up Husky hooks that rely on $PATH tools, so
> > we're not introducing a new problem.
>
> I am afraid that this compares apples and oranges.
>
> I may "git clone" and try "make" to find out that I needed a special
> compiler, and that would not be the end of the world.  It is
> guaranteed that "git clean -f -x -d" followed by installation of
> necessary toolchain followed by "make" would work.  And that is
> partly because "git clone" does not do any more than just clone and
> checkout the initial tree.
>
> If a new version of "git clone" told me "I can install the project
> recommended hooks to use", I answer "yes", and then failed while
> installing and configuring the project-recommended hooks because of
> missing dependencies, then I wouldn't know in what state the result
> would be in.  In some projects, it may be enough to just install the
> missing dependencies, and in some others, it may not be enough and I
> have a broken half-configured mess depending on how the "installing
> and configuring" step failed.

I'm a little confused, and maybe it's because we have different
definitions of what
"installing hooks" means. By installing hooks, I meant the addition of
the hook command to the config, e.g the outcome of:

`git config --add hook.pre-commit.command pylint`

This works today; Git won't complain if I don't have pylint installed, so
I don't see how we'd get into a "broken half-configured mess."

It will complain when it tries to execute the hook, and this is where I see it
as the same as the 'I may "git clone" and try "make" to find out that
I needed a special compiler, and that would not be the end of the world' case.
