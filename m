Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CB1C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855E722B40
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgLEANk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgLEANk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 19:13:40 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04942C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 16:13:00 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so6806099wmi.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 16:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67byRdExHOhGwoaXAtEIIz8tVu13n9dy3MNEYJxL804=;
        b=OefXE2UG2TRqmzSFD5TSpIbBRkZ5vZD9feSHuEseBdpkCbXgNAvfF/3DdgKyRLVoWx
         dLMZRJm6rr06Wk07VfL7Yj37Cb+8eQ6dnn+WtopansZk98tvMzM6124xFXj+1ZZsqav1
         XcyiOYaF/HkzPm1oyVwxz1PHLa3QKOqQ71bKPOJJ9NUjwzAVslg8HrH//rpCDyxuspoh
         LyHIyceXxCaVQ03EMgy66YvizK4FR21Q+8pCkjSphWO9a3TvE+FgVT8gMmx8EYaf2+ZU
         Qi1H3+rHgE7JR69rkIWfvgeOw7zC3snhaywaNq1LOE8OAaP0Ot3ZghpTgqE5UhiFjcNx
         uxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67byRdExHOhGwoaXAtEIIz8tVu13n9dy3MNEYJxL804=;
        b=LWOSpe92SCnvBHPOqMrWt/CJKUa9oedt2ofQ/pqBfsVEm2xBtuZRsff+H8EOJByyIS
         qc+9Myj1gBxEIP+lBTVofJi5tncwY0vRFVbHV6zxwtrwSNgnRgIFJxhfYyrqhs/JOb6o
         gDBQmjmUfeHmftrCInBYKbns+j+kNp1ATpVxkePZvK+S5g255bgRkI3iZ4sJhcMv8qaQ
         LYmsP0iPyWLywLVAFyTv/ZxTGbx80O7goCEf6sUuGsbWQ9GDxA9k/mFMr9SqWqB7gBY4
         lnuaZRr/oTAftyggqUYaFpS94xaBAp02eC9P+imE56Wsga//3+sgvK+s0W9IkKKuhfsj
         zF5A==
X-Gm-Message-State: AOAM530rD/rkjpa1TcCx9p5jf6jenUdamAn0HqFx6BACCqTkNxIzgyCf
        j4NnC55pVs+j4LKdfsJqDto49nhXqtFH7EZXN00=
X-Google-Smtp-Source: ABdhPJwcR5vYdJbu7iFHgMzTM8/bel2rJlSiCLUI0vVFoLWpNFm8xk/tVaDD6xe43Ofkx+yO8yGxeOIdui7U9RuYypM=
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr6822046wml.48.1607127178723;
 Fri, 04 Dec 2020 16:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
In-Reply-To: <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 18:12:47 -0600
Message-ID: <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
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

On Fri, Dec 4, 2020 at 5:00 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > We want to:
> >
> > 1. Be clear about what "specifying" means; merge or rebase.
> > 2. Mention a direct shortcut for people that just want to get on with
> >    their lives: git pull --no-rebase.
>
> This is a shortcut for what?

  git config --global pull.rebase false
  git pull

It's a shorter way of saying: "do a 'git pull' like you've always done
but don't warn me".

> > 3. Have a quick reference for users to understand what this
> >    "fast-forward" business means.
> >
> > This patch does all three.
> >
> > Thanks to the previous patch now "git pull --help" explains what a
> > fast-forward is, and a further patch changes --no-rebase to --merge so
> > it's actually user friendly.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  builtin/pull.c | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 1034372f8b..22a9ffcade 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -346,17 +346,18 @@ static enum rebase_type config_get_rebase(void)
> >
> >         if (opt_verbosity >= 0 && !opt_ff) {
> >                 advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> > -                        "discouraged. You can squelch this message by running one of the following\n"
> > -                        "commands sometime before your next pull:\n"
> > -                        "\n"
> > -                        "  git config pull.rebase false  # merge (the default strategy)\n"
> > -                        "  git config pull.rebase true   # rebase\n"
> > -                        "  git config pull.ff only       # fast-forward only\n"
> > -                        "\n"
> > -                        "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > -                        "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> > -                        "or --ff-only on the command line to override the configured default per\n"
> > -                        "invocation.\n"));
> > +                       "discouraged; you need to specify if you want a merge, or a rebase.\n"
>
> ...want a merge, a rebase, or neither.

There is no "git pull --no-merge". Years ago some people argued for a
"pull.mode=none" (essentially making "git pull" the same as "git
fetch"). But right now there's no option to do that.

There's an option to do --ff-only, but that's still a merge.

Perhaps: a merge, a rebase, or a fast-forward?

> > +                       "You can squelch this message by running one of the following commands:\n"
> > +                       "\n"
> > +                       "  git config pull.rebase false  # merge (the default strategy)\n"
>
> Should this be labelled as the default given the desire to make
> --ff-only the default?  Perhaps I'm jumping ahead and you plan to
> change that later in this series.

That's right.

In the previous series which does indeed make "pull.mode=ff-only" the
default [1], I do change the warning to specify the future default
[2], but in that series the warnings is changed to:

  The pull was not fast-forward, in the future you will have to choose
a merge, or a rebase.
  To squelch this message and maintain the current behavior, use:

    git config --global pull.mode merge

  To squelch this message and adopt the new behavior now, use:

    git config --global push.mode ff-only

  Falling back to old style for now (merge).
  Read "git pull --help" for more information.

Since that series didn't get any traction, I decided to only implement
step 1: fix the current situation. And later on another series would
do step 2: introduce "pull.mode=ff-only" and do the preparations to
make it the default.

> > +                       "  git config pull.rebase true   # rebase\n"
> > +                       "  git config pull.ff only       # fast-forward only\n"
> > +                       "\n"
> > +                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > +                       "preference for all repositories.\n"
>
> Good up to here.
>
> > +                       "If unsure, run \"git pull --no-rebase\".\n"
>
> Why is that safe to suggest?  The original text may not have been the
> easiest to parse, but this seems more problematic to me.

Because "git pull" has been doing the same as "git pull --no-rebase"
for more than a decade. It's safe for people to continue with this
behavior for a few more months.

Some people need to get things done today, and they are not interested
in future changes, nor changing their default configuration, or what
the warning has to say.

They just want "git pull" to do the same as yesterday, and the year
before, without being bothered with an annoying warning.

Those people can start training their fingers to do "git pull
--merge", and learn the problems with "git pull" later.

We want to respect the user's time, and not force them to read the
warning today.

> > +                       "Read \"git pull --help\" for more information."
>
> Nice addition.

Especially since now it explains what a fast-forward is.

-- 
Felipe Contreras
