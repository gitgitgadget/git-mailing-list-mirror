Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0FDC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6BA22245
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngfZDg6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgKBSwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgKBSwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:52:35 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A6C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 10:52:35 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id s21so15753173oij.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 10:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiYIwZB5EPy+Az0p+mjL84fP+jEl8bMVlNptlLEOCLA=;
        b=ngfZDg6T09FKxnAIshLidcif6joqw935vMCvA3WTOx8SkFVjRn0SusRw6kweCOVCLX
         /uWGNZ51PULbkV+nNwzIj6P5R1g1bMynw+GznzHLL4ojw0hEnfpFqWWGzVaqgixVwi8H
         Fse1bzzHi08+2Z7gAmsjTK5MHQbAoqi4EUEt6ZlnmPF9CszczgfhIR3bCTb3IX+Xwcot
         FcIXv2C92Rv0Wf23WezatO7ZVYsr8JNRLHb0oTa3JECuB0w338FKdHW3ECPI2nmvnWNu
         Cis0U80r4yyQ16tc+daDpn6vZ/hS1TP4/jxBLrlsKZiRijp/QrzJFXN4VRR/fHwTWRYc
         hcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiYIwZB5EPy+Az0p+mjL84fP+jEl8bMVlNptlLEOCLA=;
        b=GeeS2Znf7F/Rvr+bVyfwaUff7EjfS091c5tcEXxpfE9/sehPxuqaVJ6gN/nZn/npOj
         oLUwR47fAIIlYkcmUuGdaMikC1wm0AHOkTchQJ727x6c0svYoEbvzzNWgT1h0Xn31mfk
         +wuvc/NLJ2gL2no/7lD9F4UxuOxiK0dZ4vXQX6KkeFYtwqktIBEAS3GUrsMXvHgN9TCI
         DAbWAoNmuXDqJloKxunssz/u8Z2Lv8Z9OoQg7BwqZ3X8egMu+EC179OghLQd4n8+nocH
         OhLBT3JXL7QFORo+5tp26jrqilBNRkKa0PEhecrVrEyk95Z6dpj3qtCtYjnDbGruUo7D
         4UEw==
X-Gm-Message-State: AOAM533jQjA/cckzvfQMlYiGXh+vLPzEshuxlIK6nO0hJnxyhxSmyDgU
        g82t5MH1e5fpsrf/5Y4ErTBN5+bL/ygnaOz28uQ=
X-Google-Smtp-Source: ABdhPJwb3qpNVRkgCNZTLnCTrRFKeApQBJx4GpHY318WHHNJDDU9dCYfKBO/RdZQVhGlV5r1+z9bknktrP56rsEpfbE=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr10521824oic.31.1604343154418;
 Mon, 02 Nov 2020 10:52:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
 <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com> <CA+P7+xqFrzT53vx70tRDFgZXM3i2FJJK9CpuJJfkfsN4Qj6ChQ@mail.gmail.com>
In-Reply-To: <CA+P7+xqFrzT53vx70tRDFgZXM3i2FJJK9CpuJJfkfsN4Qj6ChQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Nov 2020 10:52:23 -0800
Message-ID: <CABPp-BGELtrMa4TK-dkKWxrQ_iQHyEo1yaJBGC_ZyFWG7-9gKg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Beginning of new merge strategy: New API, empty implementation
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 1:28 AM Jacob Keller <jacob.keller@gmail.com> wrote:
>
> On Thu, Oct 29, 2020 at 1:34 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > In this series, I show the new merge API I have developed in merge-ort, and
> > show how it differs from that provided by merge-recursive. I do this in four
> > steps, each corresponding to a patch.
> >
>
> I'm definitely excited by this project. I'm curious if you have any
> further implementation as a WIP that could be played with to see the
> end result of the new merging?
>
> I definitely like this approach where you work in smaller increments
> to make the implementation easier to review!

I usually keep the 'ort' branch of https://github.com/newren/git
functional (no promises, though).  It has lots of ifdefs, super ugly
commits, todos & fixmes, and random additional (non-code) files where
I was tracking various things I was working on, so the code and the
tree may not be super readable, but it should be usable (and passes
all the tests) -- just set pull.twohead=ort in your git config, or set
the environment variable GIT_TEST_MERGE_ALGORITHM=ort.

One warning: git cherry-pick --continue fails with "Cannot specify
both --continue and --strategy"; my handling to set a --strategy
option when pull.twohead was set apparently needs some tweaks.  If you
spot any bugs or other issues, let me know.
