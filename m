Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF38C433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 12:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726B122C7C
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 12:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbhAWM5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 07:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbhAWM5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 07:57:53 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C5C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 04:57:13 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 3so9729119ljc.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcJ2800EyCxJIF3shgr9AlAVM1fn74pr2tiYQzL8xJE=;
        b=AdzMGQXbTZlpspZO7ADNC55uLpmgq4SFNw62TTjvkMOFvTpF5oLdBcENliUb2whc4A
         oa+P9XpySwCa9R9nIrn7CrE1c3kJaWPX7tRGsEG4tT7HMLmZUqJz+aGRWeVvduOi6tIe
         pAsz+WmzBjN0VPeNDzoO9UgBz6CoTzCdoDEyGzbmQZK+lIObEGIy5O1WY+3fkdWtTu8X
         DV8xXTWPfvEwEArKe5EXjFihhmAEeX0WX64XQpXmLCClOU3Al+FzFMlWazzabwO0yHBf
         n6rtN+KcpwDHTpSVIkLa5jjvTH2HvKWep+nrFwMDiA73GT4YsLEpG8zaV5yudUs+zMId
         1TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcJ2800EyCxJIF3shgr9AlAVM1fn74pr2tiYQzL8xJE=;
        b=YBrAGq1KQR+oKrYW1mhVOi4uoY6j9aEK+1Gbsk1eo8L+SsDDFf105KUKpn2Bj/Ahlv
         yawSWh2pMZb0onjTRlICe3ZdWzOHqm0MUwLuMmEyJWBxqLRGy74bwiRTBAX1FrvrTagx
         xK5GjQNiPPq04g3oAHOKt/ZiPC12S/djH5TaUAuY02ZL5MCFurLDovZe4QNPfH7/5RYO
         DtbYkiitQidXM3SXvb2hbd9OBtrWJCDru5TX/hEXLONS8e2z2HiFP9qayAE4SGsK9JlL
         1HtW1J3lwHhNGAjSg++PX8//OwcqmKR0vgb3aTvgEz/E0Wg3JNAiCviYGo6yGkOgt9Uf
         wFaw==
X-Gm-Message-State: AOAM530roQlAc3xIL/08091IOwMzRbJ9P/FUVqw1z094T4/E445f1ZPi
        9YTrlOQcVkI3nWb2yVV7BVf8Y8/lIt+3NhYzHdk=
X-Google-Smtp-Source: ABdhPJwH123Q4BN0574Acw1ps6kY41YZBSjGDhb6PU64cByS62TQwHTd6fOqnATLa5hyDJmzlEOTjkbSzLFIDHX/Rxs=
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr826607ljc.305.1611406628839;
 Sat, 23 Jan 2021 04:57:08 -0800 (PST)
MIME-Version: 1.0
References: <CAK8LAYVZKjbMEDWTyvQv2eY+qR0qw1=mn=c4KCZvit7gsqTibA@mail.gmail.com>
 <CAP8UFD0fZBdZ6qwDP9_yW7VAfskTKPC7HVSpK4rD=bORuECpJA@mail.gmail.com>
 <xmqqpn1w95dj.fsf@gitster.c.googlers.com> <CANiSa6gEJ8ezVLhHf+TkGpqvEwvb8HhqtU3ETKiopjLQj6E_QQ@mail.gmail.com>
 <xmqqh7n85qwd.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7n85qwd.fsf@gitster.c.googlers.com>
From:   "Patricia B. C." <pati.camsky@gmail.com>
Date:   Sat, 23 Jan 2021 09:56:57 -0300
Message-ID: <CAK8LAYUsebOau+XJ66fEesLm4MfMuxJjse0YL408-2jih1d1eg@mail.gmail.com>
Subject: RES: Can git change?
To:     Junio C Hamano <gitster@pobox.com>,
        Martin von Zweigbergk <martinvonz@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, thanks for the replies, guys.

Yes, as Junio said, my intention was to understand a bit about what
you were doing, so thank you for the explanation!

The idea isn't really to imitate what you are doing, but just to use
it as a benchmark to show that changing the name of the branch might
not seem like an important thing, but it is a global movement that is
being adopted by many renowned developers.

Quoting one of the comments on the discussion topic I raised:

"It's only the default name for repositories created inside GitHub.
Since our students only create their repositories locally on their
computers with Git, I don't see how GitHub's decision will affect
them. If Git decides to change over from master to main, and there is
an industry-wide push to adopt this change (which doesn't seem very
likely to me), then I might agree with you"

So, I just wanted to show that guy that this is an industry-wide push :)


Best regards,
Patricia Camiansky.


De: Junio C Hamano
Enviado:sexta-feira, 22 de janeiro de 2021 23:27
Para: Martin von Zweigbergk
Cc:Christian Couder; Patricia B. C.; git
Assunto: Re: Can git change?



Martin von Zweigbergk <martinvonz@gmail.com> writes:



> This is probably quite off topic for the thread, but I'm curious why

> you think it was a bad idea to have octopus merges in git.git's

> history (there seem to be 37 of them).



Octoupi in our history, at least the older ones, solve no real life

problem; it only gives us "now we have something cool-looking that

other people's version control systems never had", which is of

dubious value.



And their presense makes bisection less efficient than it could be

around them, which is a real downside.
