Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF934C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8059A2075A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Olhgpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgKXA5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKXA5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:57:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5DC0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 16:57:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p22so1011655wmg.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BmCEvfohkguBRbXgRR/qU67wrIEj7pmR9h9lt13cWSg=;
        b=g6Olhgpz1F3xdIu/5npb+26nm74zlAgrVxC4aFtFTFTBS4Kjj1y74pB8rCU06/mc2x
         WYbiHB8yCLsvcp5b8J4NkhPRLycJG633RkN7JiqWS7AqJl9vrI3pX3TZFy9Ia8lKWeOD
         hyHkztFWOj3uxEocxXL0nmRYA0vvlIxcQKKKeI1mURMlaAiNBP4HRXGhIc+EWrLYlKSq
         05V5LyjHpfMNCw9dZvsBW6fkNjNvcdHap7IdgLgNtoB3GNmyCi5LvOPww2fVNeWb6fcX
         j3uDkToDuTkwyyImDbDD8lc2aO5pKjCANwac2mdjhprDVM/FmDQ0btfqTsA1/B9ti4yk
         ZcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BmCEvfohkguBRbXgRR/qU67wrIEj7pmR9h9lt13cWSg=;
        b=fQGToWH6hWzyPQf2Sp45fvvVt8TPArylS22JzvrE2CtkCnJe0LsuMX0gZGeENOCkjF
         9LVlba1+SIZNj0GjGbb5RQ1c3ofkHovy//iuLtz+7qp8rNclHIw1OnXT0KI6bmERpZm2
         VSy/msjzWMaL/h7DaMDTEIca97MmL2koaLgKKJLn4T2CCegU+po6O5EsiMC3VuQnHEmY
         u1Urt1425ATd47bV3xiZQv7xbjONUVs26zkU/7wzaWEP5nr+YOktqtkTrkWW7YvHMO61
         Qo9iWGl81ndJEdfjmtgrhCwbGMSCb8o4IAG2JawINq1lGLQ4dzFPF8TCHPL5zUOi8fL0
         7vdw==
X-Gm-Message-State: AOAM531nYNa7zdiJHPY9VxWItdTF2Rar0jzYLgep/A4Ebe987LsDUh0l
        6Kw9CQMs7Lqs44G/kKnLebi7blNR8qt5y/v01EM=
X-Google-Smtp-Source: ABdhPJzv0ZyJBt4wL60FpoI0UFgVbNlguIyWYFGGV5OkNr3+JsP3iglW/hZ1SOFTQSi/jzlWgRavtY2FUruyP40ozVU=
X-Received: by 2002:a7b:c843:: with SMTP id c3mr1535276wml.100.1606179449301;
 Mon, 23 Nov 2020 16:57:29 -0800 (PST)
MIME-Version: 1.0
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 <CAMMLpeRLsE=zNDjCRKmEMFxJBYcnTOdDGxEL9cZuVhuDMF=sLg@mail.gmail.com>
 <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
In-Reply-To: <X7xWSs3/vVqKl6sK@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 23 Nov 2020 18:57:17 -0600
Message-ID: <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Jeff King <peff@peff.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 23, 2020 at 6:39 PM Jeff King <peff@peff.net> wrote:
> On Mon, Nov 23, 2020 at 04:55:31PM -0600, Felipe Contreras wrote:
> > On Mon, Nov 23, 2020 at 3:48 PM Jeff King <peff@peff.net> wrote:

> > > There is pull.ff=only these days, which also squelches the message. But
> > > you're right that it was never the default.
> >
> > But that's not the same thing. The whole point of "pull.mode=ff-only"
> > was to print a message like:
> >
> >   The pull was not fast-forward, please either merge or rebase.
>
> Perhaps I don't understand the distinction you are making. I have
> pull.ff=ff set, and I get:

You mean "pull.ff=only" ?

>   $ git pull

Try the same thing with "pull.rebase=true".

> Which sounds like the same thing, modulo the error message not being
> nearly as helpful (which I would be happy to see rectified).
>
> Is there some other difference you're thinking of?

It's mainly the error message, but also the fact that pull.ff is
ignored when rebasing.

Additionally, using "pull.mode=default", I introduced the following warning:

  The pull was not fast-forward, in the future you would have to
  choose a merge or a rebase, falling back to old style for now (git
  pull --merge).
  Read 'git pull --help' for more information."

Which was triggered *only* when pull.mode wasn't set, *and* the merge
wasn't fast-forward.

This warning would have been much better than what we have now. I think.

Cheers.

-- 
Felipe Contreras
