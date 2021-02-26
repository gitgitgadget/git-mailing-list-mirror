Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E63C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D0664F13
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 20:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBZU74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 15:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBZU7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 15:59:55 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026AC061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 12:59:14 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q20so7057660pfu.8
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 12:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1lp9Q/3MtWUV6Ad/Cp+cAgpR8/5IrhWGPiWNA0P3S0=;
        b=sq+lFpoTZ0CR+y8sdVSlsZ+Fbbs4fXCqCZNj41XNtJG1sAlq5vNBBbQXaHcXp1Di6J
         X0+4FOvvYi42qcXyOd0J2fHF26+yztVunlI04skwekBBSdt1UrudEzPeHs/D0BHbi1d8
         50j6C9PEDDDtOr/m8bkHQ7I9zVgWztflO7MXHXS4/Z4tHnJVjlWShqCrEZKD4KsMMvu6
         JbK9Cu34qr0yXzJVD0m0n/+FFkplcIUQJcOddbycq7RnUGTYq+Fy+/+2rZd0y/a9EQPE
         uEEeTbOA4QEuiCjkVXl6fYrV9g7Dxv9jr1Y+46Bf2O0fmyW1v3wBoBDKJN+X7g08b4M0
         AJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1lp9Q/3MtWUV6Ad/Cp+cAgpR8/5IrhWGPiWNA0P3S0=;
        b=sYhT+TAs6FeIk1D9gT/Ntj8Cu6Dn1UU25wu6MLALz9OmTT9ix3jzGA7uq3Sq0A9an4
         HIHo/PJhoCZSeg5hFb+jrEFyqAZB7ZfReDenVlNPFquqQWM6+mMA5HmGwdavkEwHbylU
         b2mCgA7LTfOlwRIeou5DvvrViIcf+O//0kllSazmTQcnH8uB9ETTH6wcYmxbsgJMxJ06
         f/oB490gMyvoTPSTxsYYNlub/h947AWZsjq76rYGfWGVsNt48rueLqBpPtEPJjxlpOoy
         lZ049QOSktmFWIQCHEUrSjZBIF7UEmbqKR25/MTi6/pvLYB2FRDq0StFrnXfS5/cGvWB
         UmoQ==
X-Gm-Message-State: AOAM531ZmkzToCfgK7N8otFcdO31kFr6rVFThtnnhx38zZZb9KRkGCpQ
        jUzDI/Z0SmIR2sqqVOXqzEY/wrjM2huimc4Knqw=
X-Google-Smtp-Source: ABdhPJxgJEwvyiSPtHTV0QxQZTSBzBxaq9hn8ozjowYGN52ZcFD1+q1SPMZbZkIXG8Ubvnf7ukZjEPnx4OX4sbRMOtk=
X-Received: by 2002:a63:d506:: with SMTP id c6mr4487034pgg.77.1614373154393;
 Fri, 26 Feb 2021 12:59:14 -0800 (PST)
MIME-Version: 1.0
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net> <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net> <YDc3dinQ37FY8fhD@ncase> <YDiOXDbN/JtUWgWu@coredump.intra.peff.net>
In-Reply-To: <YDiOXDbN/JtUWgWu@coredump.intra.peff.net>
From:   Yaron Wittenstein <yaron.wittenstein@gmail.com>
Date:   Fri, 26 Feb 2021 22:58:37 +0200
Message-ID: <CAGgn8PdYsfbSE2vRunOXO1JqXoM8LxoD+5Zn74jmb9vpqDXh+Q@mail.gmail.com>
Subject: Re: [QUESTION] Tracking HEAD changes?
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all!

I'd like to make sure I understand the way things are right now:

1. The reference-transaction hook as it's today doesn't intercept
symbolic-references changes. It means that when HEAD changes due to
branch-switching the hook won't
get called.

Are there any other cases that today the transaction won't execute? (I
couldn't think of one)

2. The mechanisms that handle the changes to index and working-dir are
isolated from the one that manages the refs updates.

A side-effect to that is the post-index-change hook running before the
reference-transaction one.
Future code changes to the way git operates could result in the
reference-transaction hook running before the post-index-change one.

Is that correct?

  Thank you!
      Yaron

On Fri, Feb 26, 2021 at 7:59 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Feb 25, 2021 at 06:36:54AM +0100, Patrick Steinhardt wrote:
>
> > > Hmm, I would have thought that the branch switch would trigger the hooks
> > > because they're updating HEAD. I wonder if that is a bug (or lack of
> > > feature :) ) in the transaction hooks, or something Patrick did
> > > intentionally.
> >
> > It was done semi-intentionally, or at least with the knowledge that
> > symrefs aren't covered. This is mostly because they're not covered by
> > the reference transaction mechanism itself.
>
> Ah, right, I forgot about that. That might be something that we'd want
> to fix if anybody wanted to use the transaction hooks to track the
> complete state of refs.
>
> At GitHub, our repository replication does track symbolic ref updates,
> but we handle it outside of Git. Our normal ref updates use a few custom
> bits of code similar to your transaction hooks in order to implement a
> 3-phase commit. But our symref updates don't; they just take a lock, run
> git-symbolic-ref on each, and then vote on the result. This is slower
> and less robust, but symbolic ref updates are relatively rare, so it
> hasn't been a big deal.
>
> -Peff
