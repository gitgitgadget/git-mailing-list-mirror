Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C516C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6D364F67
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhBCFtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhBCFtF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:49:05 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715EC061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 21:48:25 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id z36so5744573ooi.6
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/629jk7IBcxS6SFsW1Z6S1UwCK3NYZLx3GqinBU3Lc=;
        b=ONm6F5RpiWQb56hZ08S2QHOwQ7hNujWf/t2S1xvi7RtzjRKBnieSyABhGpa42U//rs
         zzAfDPjs1dfPwwRaT46pqqDW5+ZTr6aBKzKu5BMBGU4lEl3GivMWyJnDb+UHzH5fyaW9
         m51AHkDKz8AF7cT3lFa4e+QEEtXvPHpMGw1LACm+TNLt7iiH3A4rkJi/hWMms5pXsB+5
         pkNt1YKf03gKmHUr0JMRan2ZVjfbQ6QnXuR3/FDPvWDfheaWLbCavmXeWiLwStEpxh6a
         MNTP6TbscMSpHs1ZEevkJj3788H1McH1egzMmPDisJYk8DpEIvZrfRiqa7zwUZWk8wP8
         pJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/629jk7IBcxS6SFsW1Z6S1UwCK3NYZLx3GqinBU3Lc=;
        b=MbVQsNTO2Nuh+D4lGMJW4d10nkCYW9uTPLgvqd+hqwepbnnpmKxvDNEEfnE7+CgfFw
         4rpoGvTTEAiMxvMKpKKcAo8xOvP62SW4MM8tnG+96ZAzDPrMgVt9C0S7qwGbCJqRrenw
         my0Lm2k5yb9qNPYg1fEYgPsrPGc4Le3VoxT+gJ+bo99lxIiFHHdBLwoq+u9CN9CT/dhi
         RNI7gBkpGhyVfMZMWiFgxcS14BxJU/vDGvEa4dQmTULwZO008ArsNUPO3xAI+40eTMZe
         dx0Z3kUAzhcYNB5JGWy7MpPdgsyRtju1hFvCd9V5ekXgWGarMmE60AQDzUpl9FwzbLY5
         Lf/w==
X-Gm-Message-State: AOAM530o9cCa7EQ0sWyd6O/jOExTBHqJW0dUkjRsueDyAiynJJHXJCz/
        H+runpwB7dvwF0r2IB8hgFq2IhOcAi4EbMAGXO0=
X-Google-Smtp-Source: ABdhPJzZ3wlLJ/VVCzgTI6oQ3thKNo5d4FDiIQTSqcdZufTVrdz1mgZrDNMl9ibnlnseAf+c1qrrAYBTsDnZETHzpkg=
X-Received: by 2002:a4a:decb:: with SMTP id w11mr1011481oou.32.1612331304336;
 Tue, 02 Feb 2021 21:48:24 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BHvk5RLq3OOYhcQZJ_9w6hbQUVurJiRrks8kcGq5-rn0g@mail.gmail.com>
 <bae3726e-25e1-90e5-b0e3-5c2d0c4cd26a@gmail.com>
In-Reply-To: <bae3726e-25e1-90e5-b0e3-5c2d0c4cd26a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Feb 2021 21:48:13 -0800
Message-ID: <CABPp-BHqk3UkauL-MmQ+JBJvhC6WRhJJM+yLvXiENZNn+CTw5w@mail.gmail.com>
Subject: Re: RFC -- making a plan for remainder of merge-ort
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 3:33 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/1/2021 10:52 PM, Elijah Newren wrote:
> > Hi everyone,
> >
> > There will be ~11 more series (with about ~6-7 patches per series)
> > before merge-ort is complete.  Now that gitster/en/merge-ort-perf has
> > merged to next, I can start submitting the next series.  Some
> > questions before I do so, though:
> > > * What's the right rate to submit them to not overwhelm reviewers? One
> > per week?  I didn't get much feedback on this for the past series.
> > [One per week, assuming the git-2.32 cycle is 3 months long, would
> > mean finishing in about 3 months, i.e. just a few weeks before
> > git-2.32-rc0.]
>
> I promise to get back to reviewing with a faster turnaround soon.
>
> If these are smaller series (and ~6-7 patches per would be smaller)
> then I could see most of them stabilizing within a week. I think the
> biggest thing for dependent series is to allow one to stabilize
> before starting the next one. OF course, we can _think_ something is
> stable and then a contributor appears with insightful comments a week
> or more later.

Yeah, smaller on average, but there is a long one early on.  The next
eight series' patch counts are: 2, 3, 11, 7, 8, 7, 6, 7.  I don't have
ones beyond that ready quite yet.

Also, for the next nine series, each one will depend upon the previous one.

> > * My focus for the next few series is on diffcore-rename.c, which will
> > also affect things other than merge-ort.  While each series is
> > self-contained, given that 2.31-rc0 is just over 3 weeks away I'm
> > wondering if it makes sense to hold my future diffcore-rename series
> > out of 2.31 and start merging them in the 2.32 cycle.  Thoughts?
>
> It might be fine to get the code under review, but ask Junio to
> delay merging into 'master' until shortly after release. This
> ensures that there is plenty of time to "simmer in CI."

Makes sense; I'll submit the first one.
