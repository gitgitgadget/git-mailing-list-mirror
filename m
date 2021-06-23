Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ED2C4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326A560720
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFWH44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhFWH4y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 03:56:54 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376EEC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 00:54:35 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s17so2461485oij.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZ0zbe3pa4Fb1Vkl5HxtfPLej/iti7MYlKufP6dbp80=;
        b=pOtOMWq1WsbzAYk/jsN7D5Bgag4kxbA/GWs092HPeglMBUw1pA3KkVm+n+tuDKtIvS
         3U31ig91gycasvunyZnDRowNsTYBbst3Pm3jNaOMk3CtiYawBftZZG6if9jNXM2grOdA
         KdaIWS/bB6Vb98ewycrgc6XtvbuD0enU2oVw2NqFmBl8xoUZ2UQenOKIYjA/t1Hl0KlR
         Eqv4uzv5fJyDUrp2YurQk4c1R/q/5wBqlbeS5PIziM+TgpETKwS/Wji2vRW/5dcZgtCX
         /B+U8qOrruC0ADs24rNxCKtgKGfNkLWsnG8uljZqo/qQJm4nV+wMKXoQSLnckQM45RiY
         PWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ0zbe3pa4Fb1Vkl5HxtfPLej/iti7MYlKufP6dbp80=;
        b=Ji9H45MhQ+FeWbaQEpmOjHWIAweJRqo1QG+LJLjbiSaAeniI600sJlM+vAtla6yFfP
         PBkBzZImqOydT9lIb5cEznz5MyxDpB3yhoo4DtQdnEiD7XOIKbOB6Lxy9bjsGkDMYgT2
         8UpmqN6ayjhkbcfaXkRJrkVlfcIqGa2vA8LnRVD8o9qVNjpL91u6mk8RheLWEBZVPom+
         hL0ccFfGILBEeRM0SJMlK6iTdK4+qRTW4iMcmfZki/L6IUS6LGkQfbECfh81Bf1Qidwh
         RAw/jmxe6zP5Mekeg83uDkXffB/8OeDfzeq7Qnd4eUOAvnri6eNyMiIUsdHqOgJrAx+m
         XBAg==
X-Gm-Message-State: AOAM530aWCwcBTF11XXbY8ldgf7wfNtodeAi7ffK/AjX8PBM16eeHIDb
        EPPjFMhZggfx+Uxkv/GlSyJexgTK1ZhBGGLmdbU=
X-Google-Smtp-Source: ABdhPJy6ivCdrRS1KDwohJN88b1Y5Qd8kHsWB8J91gaH76fyhNiBkEhTKSTz4uOsDa/SPVgeuw1lD956RYIaqMqlX/s=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr2215129oib.39.1624434874472;
 Wed, 23 Jun 2021 00:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com> <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch> <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
 <60d10ebd99d86_113139208cd@natae.notmuch> <CAMMLpeRa3atkZxEtV--YD6-JSf0Bp9xRw9kS5wSWerxpsGrvrw@mail.gmail.com>
 <CABPp-BF1noWhiJadHzjJmnGo8hdZj6Fk7XnZ=u6BVVSGfHE7og@mail.gmail.com> <60d289c84fadf_312208dc@natae.notmuch>
In-Reply-To: <60d289c84fadf_312208dc@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 Jun 2021 00:54:22 -0700
Message-ID: <CABPp-BHSxNT0rG3LMrDVH64mBwTgeF197oZFnbHvvKk=SB--WA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 6:09 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
...
> > You're not alone, Alex; I objected to that part as well.  (See e.g.
> > https://lore.kernel.org/git/CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com/
> > and various other emails in that thread, ending with "agree to
> > disagree" later).  I still object to it as I did then.
>
> You made your disagreement known in [1], I responded to it with a
> devastating argument in [2], and you immediately withtdrew from the
> discussion in [3] without engaging my argument at all.

I didn't find anything new or persuasive in your rehashing of your
arguments.  I had stated my disagreement twice already, and having us
both repeat our arguments does no one any good, so I just stated we
can agree to disagree.

> > I'm curious whether it'll just be resubmitted again multiple times,
> > eventually with a cover letter that repeats something along the lines
> > of "these are the non-controversial changes from last-year series
> > which...don't have any reason not to be merged."
>
> The fact that **one** person was not 100% on board with a change doesn't
> make it controversial.

This is a disconcerting response.  I would have thought perhaps you
might say "Whoops, forgot about that part of the thread", or "Sorry,
didn't mean to include that line".  Perhaps I shouldn't be surprised
that you instead decided to try to redefine goal posts, but it's still
discouraging.

I also find your characterization of the old thread disappointing; I
clearly cared enough to state my objection in three separate emails,
so it's more than just "not 100% on board".  And Junio referred to the
analogy in your "devastating argument" as "irrelevant", so it's not
clear you convinced others either.

> You made the conscious choice to withdraw from the discussion
> immediately, so just like a person who abandons an election cycle and
> decides not to vote, you are leving the future of the matter in the
> hands of others.

This is quite a disappointing argument.  If this position were to be
accepted broadly within the project, it would suggest scorched-earth
last-man standing tactics -- just arguing until the other side runs
out of energy.  If that was used to determine our forward strategy,
it'd result in a massive waste of energy, people feeling drained and
losing motivation to contribute, some people just deciding to leave
the project, and a myriad of other negative outcomes.  In fact,
occurrences of such behavior has already had such outcomes.

Rehashing the same arguments repeatedly damages the discourse within
the project as well as the project itself.  There's no point in doing
so.
