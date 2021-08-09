Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12604C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEDB461019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhHIVCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhHIVCK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:02:10 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F86C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 14:01:49 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so4762246ooi.4
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xvpNksmu5BDYb/7FYKUF7qJ+9g2KS3A/TaEEdcaS9E=;
        b=fpXfny/8WxeIpCqWzfHmwuIlhHyTS4CUGDHjyqe658R4nBXK5jSlFkZU/pJBvHmT7a
         WkhZwaLhepneGsB0XsuoZ3+0Z1oGWHVGQ7MTbCFPhDlZVDG1Li4SheCe3HRyD5KJTenb
         RNW5HZK5Q+Ywog4HI9B1dBkQllx6thb+dEiXadomlw8Dip+Hqi/JBoWPbe0lrtZ8RT+1
         +m6kly/TDdICSlp118xMFun54IDzHyqQ/F1TVKCOBOIc0+GNhsrFQ1jbQL9d4oYGEjy9
         FqbfsREubRJMTxElaUMZdEOyrnI68/xlmt9bQAqJZAIzpJhan9SfteNokf66pQ6lzzL4
         77Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xvpNksmu5BDYb/7FYKUF7qJ+9g2KS3A/TaEEdcaS9E=;
        b=huklKNboKNtjuLyR6HTZ6UsOtj7ILZ/Brwbe7x2beNv3dlWX85sD+TGrY4rZ+eLwjk
         5Ixkl50vF+acF7ouTk/W5MaxaWaROxYguQzBMJluaZIBIdP5F6Hq/8KBvYoES+KhuMJO
         Q8o6TKG0/aD0A3bncYr463GtQ42rMDVxSmoeeGRVbrFy9MtD+Z9YGjll4B5m01H05EyB
         NVk7Qtbwsw2Um0pQvck6qly8OlT5yNgZfxasLTK03eF2qFs0CjtNVfxaI6DY+SwH3ibD
         I/KRDe+NCO4stxIy3xvg7/VbLz676B2/LIIxZN8woxaTQ/J3O8zJntedl+seodgDPmkq
         D+9Q==
X-Gm-Message-State: AOAM533htA3anjpXAJYT6sGfmA0W72RtqfFOzGc6so4ZlzoyhfPOwGa7
        +rt5G62DpxlJC55CSqN7O8eilY3SOYcRQUO0jY0=
X-Google-Smtp-Source: ABdhPJyGcdFy8QUAsqSSfSUlO5hoM8rOSfSXOHCsXgAWmAUM6tZmLYIy4ywvXmkZDl/Q1DAs9QQsuf3wHvyTV9Qqq1E=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr16160203ooe.45.1628542908306;
 Mon, 09 Aug 2021 14:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1011.git.1628055482.gitgitgadget@gmail.com>
 <4a0f088f3669a95c7f75e885d06c0a3bdaf31f42.1628055482.git.gitgitgadget@gmail.com>
 <f6e79035-1412-4f8b-5949-8e9cc7215785@gmail.com>
In-Reply-To: <f6e79035-1412-4f8b-5949-8e9cc7215785@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Aug 2021 14:01:37 -0700
Message-ID: <CABPp-BEtkFkr=dw+A4K=jOY5wCDFtZicsShwwjmM1-aFRS1bSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 10:38 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
...
> > === Extensibility ===
> >
> > Being able to perform merges without touching the working tree or index
> > makes it possible to create new features that were difficult with the
> > old backend:
> >
> >    * Merging, cherry-picking, rebasing, reverting in bare repositories...
> >      or just on branches that aren't checked out.
>
> Rebasing without updating the worktree for each commit is exciting.

Yeah, there appear to be some interesting twists from my initial
investigations so far.  I may need to start some interesting
discussions in the next cycle or two about what we should do here (and
also for merges in bare repositories.)

> I agree with others that this should be merged into next sooner rather
> than later. I also agree with Peff's point about moving it into master
> to get more people using it rather than sitting in next for too long.

:-)

> I think the sequencer changes below are easier to follow in this
> version.

Thanks for taking a look.

> One thing I did wonder is whether there needs to be any change
> to the CI scripts to ensure we keep testing both merge implementations.

There did need to be such a change, but it was made previously in
commit f3b964a07e ("Add testing with merge-ort merge strategy",
2021-03-20).  That commit changed the default merge backend *for
testing* to be merge-ort, and modified the linux-gcc job to explicitly
specify recursive.  This commit doesn't change the testing story, so
the recursive backend will still continue to be tested with the
linux-gcc tests, or whenever someone requests it with
GIT_TEST_MERGE_ALGORITHM=recursive, and otherwise merge-ort will be
used.

> Best wishes and congratulations on an impressive achievement

Thanks!
