Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D84C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD3D601FC
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 21:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhFUVuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhFUVuS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 17:50:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD3C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:48:02 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id d16so25094675lfn.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 14:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V+3GrNoVTmZRqdpLqGxlIjlZ5W14S1GvhYTNJC2vYQA=;
        b=E1swwlV8iRkmcJe/JmQWz/i3JY6XJceZM7hBDbTqYO/V+grxR+s9gAA1sTfp4xyzpM
         hOZOpXopa5yeO8nkKA+ZZapUt38URJJqWdiqw+5cXuPGqs+yzTIfDjJl2mA8gOL80slb
         9Gt/iQOjoJnPoVqYJ4d1+JZzoQ52B9o2lndFGoeDvs9V0rzkOXPjtVZRDO6bsMvebagO
         nW7+Cr5NChB0YcrwY0LLc8t7q1v2pkqh8/5kPZpzHvdhHrjEryMT2wtzWK1WqLMesXF8
         kPr0dB/YEFyNCNFBnhfhqZRtNmLJS90X+udCk+sBhLoVios4QF6e+z/q/wR51LyrcQ0C
         RleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V+3GrNoVTmZRqdpLqGxlIjlZ5W14S1GvhYTNJC2vYQA=;
        b=h35yyaKwAcQM/mHhggJdo7zl2/xaE5dQI6oUAcQdpy+FTpu/QwymP7+BwicEjVfeaL
         oCEzNX0gpVK0WrHvo1HjPew1XebY/sY1Q1KF7B0Pr4I+L3WZXyntMX6VrYn0Ag9rDigi
         I74hb85G7S0rOSqim7dA81ho9MEtiPJfD4jTCz/Wi7ac2RqnmR0Ofhdcnjm6YO5cTJxc
         bDLxQIjxUAvFk3tIE9A1EgF9SfR3Wtbp/Fma2ZAi4L+IRfsZD58liZs2+mnRkhj7qMc4
         HMHnoexDj+F9VJkwod6yU1LW4OW+RBWvhAbPvZ7/DuFhDnK6XOI/AGL5J5YWX8r4+6X5
         7kGA==
X-Gm-Message-State: AOAM533UAzGcIrnDTa1kknjozbtFc4qkmFbguwatUksx8z+AsOftCNtz
        QV/i5u/wO748eo7SRfaF6CdcpnXKJm9FB2vBYCQ=
X-Google-Smtp-Source: ABdhPJxAqzaJAwz0JhuVWybUUPclBnpZcksyCUS3cSE0le6z5xUp3XsDne0/dQmzry1d3uX6hHNvAHB+dJZ2/wr1+yc=
X-Received: by 2002:a05:6512:308a:: with SMTP id z10mr281311lfd.148.1624312080829;
 Mon, 21 Jun 2021 14:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
In-Reply-To: <60d0df99d91e1_108e902085e@natae.notmuch>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 21 Jun 2021 15:47:49 -0600
Message-ID: <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 12:51 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Alex Henrie wrote:
> > On Mon, Jun 21, 2021 at 11:52 AM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > +                "If unsure, run \"git pull --no-rebase\".\n"
> >
> > I don't think the message should recommend merging over rebasing;
>
> This is the default strategy.

Yes, but it shouldn't be, and we shouldn't make the problem worse by
encouraging people to default to merging without thinking.

> > The eventual goal is to get rid of the default here and make the user
> > make an educated choice, which does imply some work on the user's
> > part, but it avoids the massive headaches created by users merging
> > without understanding what they're doing.
>
> Indeed, but any minute change in git's UI is a gargantuan task that
> takes several years--or even decades--to accomplish, if it ever happens.
> I started this patch in 2013, and here we are.

Although what needs to be done had been envisioned by some as early as
2013, the warning has only been around since Git 2.27 (released in
June 2020), and it was only restricted to pulls where fast-forwarding
is impossible in Git 2.31 (released in March 2021). The good news is
that (unless I'm mistaken) there are no more changes that need to be
made prior to changing the message from from "advise" to "die". All
that needs to be done is to set a date to make the switch. For
comparison, users were given from Git 1.8 to Git 2.0 (October 2012 to
May 2014, 1 year and 7 months) to acclimate when push.default changed
from "matching" to "simple". So how about we plan to stop merging by
default in Git 2.40 (due around the end of 2022 or beginning of 2023),
and update the warning message to advise the users of the pending
behavioral change?

-Alex
