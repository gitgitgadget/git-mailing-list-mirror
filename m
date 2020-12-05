Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89DAC18E57
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797F422E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 18:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgLESmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgLEQ5U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Dec 2020 11:57:20 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C6C02B8FE
        for <git@vger.kernel.org>; Sat,  5 Dec 2020 08:28:28 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id d8so459634otq.6
        for <git@vger.kernel.org>; Sat, 05 Dec 2020 08:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oeafyg1SbLRB7zrjyBFt+2wmlv8OJgMU917sNpGN3FQ=;
        b=cPgobkYuNkr0GwTPR3jjLOxA2H6/m/ACKq5xTuKUfxwBWKUwP568tDYYb53U/6zJmm
         LkaX4LpNwXy04isKaBXnCx+xURn7YvygQKFP1tYReypCs05doMevnQ4WGYUhl+3DbUx1
         KzVlnj6r31f/Klokks9EOyry0Ros0/IFjuxAX0dEMFAvDYvzZlfiY3yRCrcGms1xMOwA
         WZ61IgQ4k+5I6YBu0hy7FNUZkYlGToqH51QEmsw0tGzh3+MnbRb69mGNRA0X7ETEIE8X
         HURcm/BX9/Mzc1dJ16mMKRTNqz5rDcYh1+lS51PTUr9hPk3vTibJduGSRlQz2E1hdoNK
         LLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oeafyg1SbLRB7zrjyBFt+2wmlv8OJgMU917sNpGN3FQ=;
        b=huX53pnhQUuvQ2t3y5QvzeWXJDTrRJPE58SvHiUS+6/MwfGAKWd3gx0MXCSLxowbXQ
         Hw5ZZ3LailnHi9q9IG1fM6Lk+rg4R9vqqkfZLhJOacwxouTEBO68kAZVv5pGIXqu145N
         xe+FT+h7SlTJQgxoCzZf0QY5F5LIOx0W0jUbqiEaiSpjNwzYDmSmP2k6F+Q75OWWgbFw
         OAbXqqYzcFYhCeiRtMgsaOqkShM39Htz4pQBE4NvGdE0+/qkhxCPjDOnNn6bpotEA+w0
         XmPhz1N8mIuxj7DrG4//qbdFQC5aj240Ou3Q80ijyI7N0Z2/jFotlyW1BzmxJQb/qePj
         QsxA==
X-Gm-Message-State: AOAM530IN6MVAqs7FVZWivRcUh+x6zZvCIM5Q8HDzfEO+gtNL3QRPAku
        bqV9lDMjpNOGgYyBTsqG/8FSxMjEFL3G9goynSk=
X-Google-Smtp-Source: ABdhPJzfgKg1WWTiKDjGpocXDxCsR0yrQMrOrAdtMUP5zvpLsSqC3/9S2nAPv0YiTjQZx3UVqx8SVgi+tV2+C4sY6PA=
X-Received: by 2002:a05:6830:1d6a:: with SMTP id l10mr7445501oti.345.1607185708034;
 Sat, 05 Dec 2020 08:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com> <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
In-Reply-To: <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 5 Dec 2020 08:28:16 -0800
Message-ID: <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 5:56 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 6:56 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > Hi Felipe,
> >
> > On Fri, Dec 4, 2020 at 4:12 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > On Fri, Dec 4, 2020 at 5:00 PM Elijah Newren <newren@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> > > > <felipe.contreras@gmail.com> wrote:
[...]
> > > > > +                       "You can squelch this message by running one of the following commands:\n"
> > > > > +                       "\n"
> > > > > +                       "  git config pull.rebase false  # merge (the default strategy)\n"
> > > >
> > > > Should this be labelled as the default given the desire to make
> > > > --ff-only the default?  Perhaps I'm jumping ahead and you plan to
> > > > change that later in this series.
> > >
> > > That's right.
> > >
> > > In the previous series which does indeed make "pull.mode=ff-only" the
> > > default [1], I do change the warning to specify the future default
> > > [2], but in that series the warnings is changed to:
> > >
> > >   The pull was not fast-forward, in the future you will have to choose
> > > a merge, or a rebase.
> > >   To squelch this message and maintain the current behavior, use:
> > >
> > >     git config --global pull.mode merge
> > >
> > >   To squelch this message and adopt the new behavior now, use:
> > >
> > >     git config --global push.mode ff-only
> > >
> > >   Falling back to old style for now (merge).
> > >   Read "git pull --help" for more information.
> > >
> > > Since that series didn't get any traction, I decided to only implement
> > > step 1: fix the current situation. And later on another series would
> > > do step 2: introduce "pull.mode=ff-only" and do the preparations to
> > > make it the default.
> >
> > I like this longer plan.
>
> Yeah. It's a better plan, just more work for me.
>
> > However, on the shorter scale plan...I think
> > the suggestion to use "git pull --no-rebase" makes the current
> > situation worse rather than fixing it.
>
> Well, I already said I partly agree with you: in the --ff-only case
> the suggestion should not be brought forward.
>
> But in the "git pull" default case, *today* it's doing a merge. If
> uttering --merge and thus making the current behavior explicit instead
> of implicit seems dangerous it's because it is. But not documenting it
> doesn't make it any less dangerous.

Sounds like we agree that the future should be ff-only-as-default.  I
also agree with you that the primary problem is the current default
behavior, and I'll agree with you that documenting the current default
is okay.  However, I disagree that your wording here:

+                       "If unsure, run \"git pull --no-rebase\".\n"

does anything of the sort.  It does not mention that this is the
default behavior the users would get if they provided no flags.  More
importantly, it makes a recommendation...and one that undercuts the
point of the message.  It makes it feel like the message shouldn't
exist at all in any circumstances.  I even suspect that adding that
sentence may undercut any efforts towards changing the default to
ff-only-as-default.  While I'm a big fan of most of what you've done
in this series, I will object to its merging for as long as this
stays.  (I definitely don't have veto power or anything close to it,
just stating what my opinion is.)
