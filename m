Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8AC433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F13D22A85
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgLGJYs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLGJYs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 04:24:48 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CD5C0613D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 01:24:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so12040308wrn.3
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 01:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WA1iS8XJTzlS+nHyJUIO2zAyrAXip1mMJA4M0mrxyDY=;
        b=UmNeym4INXdAb/H+1UY8U4B9Y1oQ/6Wz2zKykb51MZvFANIKdAh2NxaVQd4ie9qG4b
         dr/ICgou+vXPWiH9MOYN0z1j2ZHkrp9gLsSHEYS+FoI+ipzuoh8ZaBT/Ck84lKEnScya
         ENBzVUSheILyowq1VZ0mZ+wNdn5HnZe5uLU/+6vhZj67hYpBLrRTS7rdHK260RqjAJGT
         Hb0xHg4GvOhi26nQoTvNbSZR4nLhbO6Qz6FVbLs5pF9xeHOuxis1hpnFDbBjf8HzrENM
         tiqiULSwYutqV5UpTOr/fgA6KG4sqaKvQMKi5Q8D4D1+UpFuibMAx3sQzeq1b2wdsTxo
         QM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA1iS8XJTzlS+nHyJUIO2zAyrAXip1mMJA4M0mrxyDY=;
        b=MRn7juvjLlgB1SsmgUqzaq5OrTqHY/P8CkWR/gNif8C3ASii6Jy+4tzTg6ALRlHWap
         cxsOooWFnruzepJ3LYZkQVIv0xuCLBKXy96n+RCb+TQ7k5gs9wmqJq5Zu8zmj2Yhajc5
         6zv/xUYSeXkih/cQEdwnMcp9ZoC2uUGfwx4Ts1KTsFWSy7ZLLgrL0wAEU+YezGxwzLCG
         xQ9lBwOBxIxoBO0qf90/IY6/S6k8rmBw3V0IW7sYgY4Iz7TRQXogJfEmbwdZ9Yj4BmFg
         YYmion8w87WJhdo1OuWIXg8WrUllMzEaYM+0Uu1wAiYFJjb1tmkEHvj5bZG6ljHHY+EG
         8QJw==
X-Gm-Message-State: AOAM532BMmqo+jf0du0YQ1xsGoKxEK1rrAGuwwSHhD3EjBwDOt2n3lWQ
        iLwHQmHExUPdNuSkB72VrOPXZbAYwtsVD2Ecw64=
X-Google-Smtp-Source: ABdhPJzNizBWdjpoB7sNabhuqwUEL7jS0Qtd8DzT5lkr3aIaWcaJDhhGyUGYSLinMahCGmn9RIGDvrz14sSwPXj6d8k=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr18736251wrv.255.1607333040739;
 Mon, 07 Dec 2020 01:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com> <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
In-Reply-To: <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 03:23:49 -0600
Message-ID: <CAMP44s2zxrf6u6Dxr+GvKJqYdF6jF4BwPqXm4rG_OvRXk9Rm-A@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Elijah Newren <newren@gmail.com>
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

On Fri, Dec 4, 2020 at 6:56 PM Elijah Newren <newren@gmail.com> wrote:

> > > > diff --git a/builtin/pull.c b/builtin/pull.c
> > > > index 1034372f8b..22a9ffcade 100644
> > > > --- a/builtin/pull.c
> > > > +++ b/builtin/pull.c
> > > > @@ -346,17 +346,18 @@ static enum rebase_type config_get_rebase(void)
> > > >
> > > >         if (opt_verbosity >= 0 && !opt_ff) {
> > > >                 advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > > > -                        "discouraged. You can squelch this message by running one of the following\n"
> > > > -                        "commands sometime before your next pull:\n"
> > > > -                        "\n"
> > > > -                        "  git config pull.rebase false  # merge (the default strategy)\n"
> > > > -                        "  git config pull.rebase true   # rebase\n"
> > > > -                        "  git config pull.ff only       # fast-forward only\n"
> > > > -                        "\n"
> > > > -                        "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > > > -                        "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > > > -                        "or --ff-only on the command line to override the configured default per\n"
> > > > -                        "invocation.\n"));
> > > > +                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
> > >
> > > ...want a merge, a rebase, or neither.
> >
> > There is no "git pull --no-merge". Years ago some people argued for a
> > "pull.mode=none" (essentially making "git pull" the same as "git
> > fetch"). But right now there's no option to do that.
> >
> > There's an option to do --ff-only, but that's still a merge.
>
> I disagree.  I'm well aware that checkout_fast_forward() (which is
> what is ultimately called to do the fast-forwarding) is in a file
> called merge.c, but that doesn't make it a merge.  I don't believe it
> was anything more than a convenient place to dump some extra code at
> the time.
>
> > Perhaps: a merge, a rebase, or a fast-forward?
>
> Sure, that works; in fact, that's much better than my suggestion.  I like it.

Actually no. If we are talking about divergent branches you cannot fast-forward.

The original text was fine.

-- 
Felipe Contreras
