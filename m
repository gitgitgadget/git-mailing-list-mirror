Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEB1C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4560A61019
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 20:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhG1UiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhG1UiF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 16:38:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F86C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:38:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ec13so4478559edb.0
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aitwgGB7tXSu1J4ROzsveJIlSi64fvOxRX239H3wnT4=;
        b=jjL6nit+kKHM89PE25OZ2idqZeNDpXwU75+ZBv1wb/UtY2QedfVxkV880Dgshqa+68
         SDDbFrPYi+0mBTLjCqiMw1HXTe5BJkQac69NYX4qjjZNJ5mlQDi0UP3bju8q+g/NyzFJ
         RrWWyOLh204eXCNKP1mqBaWhkp1U0pa2bSatzu1+d4MiLmT8d0EeAnN3ONWGctNRGyXg
         oYu/nCeRoUkBw8UEqseK2ICUcYP94L6csIZmWAdAGwcD1gUYnC8ReXpqWTUGkpa9nYbA
         wQJGwjOi0dAmWUlwth3N0KS8z945XKAVCQ7gi1C3i6hJk18FuuYZ3hbfpsJp1v9iwSl8
         xtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aitwgGB7tXSu1J4ROzsveJIlSi64fvOxRX239H3wnT4=;
        b=ckLRSZSbj2lpqO6ySjS2jagwZ1LyUut+ps73Og+k5p+SiIwijfdl4l+sLjCFg43Tv6
         0z2xgw8RtCoUbJWD2pfpWpge6064puw5EtybSVZEI97AVVQlSzl6FEZ2oQohEdonu0fR
         3+1Nj1SsFBLkhjzihmWJkTgfLATnBwX+O9AtDR3LVd2mo5akSmy/pSXShP05FFTnonzn
         TZoS3/9xaixCwRlGvCGDUoyyQa1q3loIAW1Y+xvzCTGO2H05dz0eoCOWwqgt0iFTRBeP
         DcVQu9azLiiXfbbNuOTkovK9vCrbi1TDymznNcRFWxNT/qmdU5l8Ku3imXDc3vVlZHvg
         Quiw==
X-Gm-Message-State: AOAM5331/ahCGzre5qxFmYbeFqzQHMzdIpwd3aDbs8sdaRbgRSnUHWwV
        6wW40ZZeT9CdjNLM9MoTLg2L89s785P/PSFV36XzSQ==
X-Google-Smtp-Source: ABdhPJxfMK6/T6k1PQp2nPlL+Pb+rG7zYVCFnOy60hNguEf5MLkTV58UEJ1leg9UeXeiuiMk9hxzczMUuFzJ/AWH9Uo=
X-Received: by 2002:a05:6402:1e91:: with SMTP id f17mr1902519edf.133.1627504681646;
 Wed, 28 Jul 2021 13:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210728024434.20230-1-jerry@skydio.com> <xmqqh7gfawlt.fsf@gitster.g>
 <CAMKO5CvZCMHuzRLSs2aHJ3iUH-LBJfFP3fG+GgwtQvsKQPtT5Q@mail.gmail.com> <xmqq1r7i9p7f.fsf@gitster.g>
In-Reply-To: <xmqq1r7i9p7f.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Wed, 28 Jul 2021 13:37:50 -0700
Message-ID: <CAMKO5CszNvzd6Y5VdTqw6JDGxOyQ-CNA3fxgf5ChQbGwZ9v_rw@mail.gmail.com>
Subject: Re: [PATCH] git-apply: fix --3way with binary patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, lilinchao@oschina.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 28, 2021 at 1:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jerry Zhang <jerry@skydio.com> writes:
>
> > So basically, another way of stating the problem would be that binary
> > patches can apply cleanly with direct application in some cases where
> > merge application is not clean. If i understand correctly this is unique
> > to binary files, although it would be possible for a user to supply a custom
> > merge driver for text files that is worse than direct application, that is
> > most likely heavy user error that we shouldn't have to cater to.
>
> Not really.  The built-in binary merge driver luckily had such
> characteristics to allow us to catch this regression, but I see no
> reason to believe that it is unique to binary.  Funky merge backends
> like union merges can turn an otherwise conflicting merge into a
> clean merge even for non-binary files.  And no, it is not an error
> for a merge driver to fail "apply --3way" merge on incoming data
> that "apply --no-3way" would apply cleanly.
>
> > However
> > the issue with binary is that the *default* merge driver is actually worse
> > than direct application (in some cases).
>
> > 1. do as you suggest and run 3way -> direct -> 3way. I would modify
> > this and say we should only attempt this for binary patches, since a text
> > file that fails 3way would most likely also fail direct,...
>
> No, I do not trust our (myself and your) unsubstantiated belief that
> it is limited to binary.  We saw a problem with binary, and I would
> think it is a tip of iceberg for any non-straight-text-merge backend
> (and I do not have any sound reason to believe that straight
> text-merge backend will not have this issue).  I'd rather treat this
> as coalmine canary.

I see, this could be true. But then we would also have the case where
a merge driver results in conflict and direct patch application applies cleanly,
*but* the direct patch application is actually incorrect (for reasons relating
to the original purpose of the patch to switch the order, that direct patch
application can be wrong for files of repeating content). In this case
the user might actually want to see the conflict as it is more correct, but
it is being hidden by our fallback.

If the backwards compatibility story is going to get messy like this, perhaps
the best solution is to make a new flag similar to "--actually-3way" that
will attempt 3way and nothing else, and users who know what they want
can use that to get what they want.
>
> I think the real problem, even without the "try threeway, fall back
> to direct application, and then try threeway again", is that after
> swapping the fallback order, a failed threeway does *not* fall back
> to direct application in this case.  Regardless of what ll_merge()
> and its backend does, if they fail, shouldn't the caller of
> try_threeway() notice the failure and fall back to direct
> application, just like the earlier code tried direct application
> first and then _always_ fell back to threeway if it failed?  I do
> not know exactly why today's code fails to do so, but I suspect that
> fixing that is the real solution, no?

Well it isn't really failing right? Failing 3way would be not finding
the object ids in the database, which would indicate a failure to
even attempt 3way. This would result in fallback to direct application.
What we're seeing is that 3way application results in conflicts where
direct application would not result in conflicts. Having a conflict is
currently not a reason for the code to fall back to direct application,
here is the relevant line:
"
         try_threeway(state, &image, patch, st, ce) < 0) {
"
try_threeway returns 1 in case of conflict, 0 for success, and -1
for true errors.

>
> Independent from that, I suspect that it may be a good thing to do
> to (at least optionally) allow ll_merge() to notice trivial merges
> that proper merge frontends would never ask it to do and resolve
> them trivially.  The patch you saw from me to ll_merge_binary() may
> do so at a wrong layer (doing it in ll_merge() before it dispatches
> to ll_merge_binary() and other backends might be a better approach)
> but would be a good starting point for that independent effort, but
> "apply --3way" should work correctly even with user-configured merge
> drivers (after all, the "direct application first and then fall back
> to 3way" code would have worked perfectly fine even with broken
> custom merge drivers in the case we are discussing right now).
>
> Thanks.
>
>
