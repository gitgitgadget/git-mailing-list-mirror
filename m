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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1354C433FE
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4B222E00
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgLEB5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEB5W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:57:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A187C0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:56:36 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so6955275wmd.0
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXH6+6YmuHRp8lutCC7o30KGan1UVdeFrP7PzdTNKBE=;
        b=bc+RLsOSqkLJodscwiAWzAZL/wOdguicJJWqePLheyy9mk0gg6kZ9vWYZIRNeesAzg
         LjnqjR6adHx3Og6Lt9lzo36UnDpmIe5khpRPD5K50aUD3scX1OgpFtQEc48zN1QGS7f4
         1BcxBrtpCLEj0H1FbzKMsdT/gCBtjidgyux0OmxdgltfNyIepHWpRRAsXwedSLoC9ytI
         tScUoSF0hvPaAupbGI1TSwNl5fEFvPfu+LZ7xReejvAmts8L0+aO0Q6cgXksTVOzY6XP
         ygH/y7eRwWhU4fgKkNFv4T5J8kNlqzKDJJ+moaA2lPH+D2hXzOqfpnhrcDVUKYhUSZA1
         PAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXH6+6YmuHRp8lutCC7o30KGan1UVdeFrP7PzdTNKBE=;
        b=W+F4smHv1rSRU7F+p7cZCANasx1kWC6CZsfOW9f5sN31312Da+Nx0O2+pP9o1npcQQ
         kPNtBV26FMNXgYjFjEvWJa2gNyW2e7GnFrV0neruvywxPvOauTdaElMom3+yPxCOxT1+
         uJz9d+wbsG6VQyGrBfj0+8K69B7H60oNlDGL2xyENEAIenO8LZCiW4h8up80xzZk260T
         eC+cmCCXcxOO+NfS0EEUoR0TT0hl7ClfXvnAR4hdyEkiGGMYJBBXhUBzO9KqtmMeMv7S
         TJj3H47Xs/FU7UGq9WREVWhRumoyymIbTg3CEDW4scgGUQOUHC3EVaOg6jmRFxXoQ44i
         yTww==
X-Gm-Message-State: AOAM533dkG5CERE452hyGr17iC42J+0D924lkiNqv5rU3X1+Z4gMiomP
        5K5ChY4oiUJyZv4fKY4onCgyoOLi3MRsRzBOEfq53QscVzUJ+g==
X-Google-Smtp-Source: ABdhPJyRHjkNZFLwH0YlbmjCu/5p0ReQmwVsgozFM//VymMrn8gy1o13utQ8zAa9e92NYHBzCg3faOBaGyd9TE4WAGM=
X-Received: by 2002:a1c:df57:: with SMTP id w84mr6889757wmg.37.1607133394522;
 Fri, 04 Dec 2020 17:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com> <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
In-Reply-To: <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 4 Dec 2020 19:56:23 -0600
Message-ID: <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
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
>
> Hi Felipe,
>
> On Fri, Dec 4, 2020 at 4:12 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > On Fri, Dec 4, 2020 at 5:00 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > >
> > > > We want to:
> > > >
> > > > 1. Be clear about what "specifying" means; merge or rebase.
> > > > 2. Mention a direct shortcut for people that just want to get on with
> > > >    their lives: git pull --no-rebase.
> > >
> > > This is a shortcut for what?
> >
> >   git config --global pull.rebase false
> >   git pull
> >
> > It's a shorter way of saying: "do a 'git pull' like you've always done
> > but don't warn me".
> >
> > > > 3. Have a quick reference for users to understand what this
> > > >    "fast-forward" business means.
> > > >
> > > > This patch does all three.
> > > >
> > > > Thanks to the previous patch now "git pull --help" explains what a
> > > > fast-forward is, and a further patch changes --no-rebase to --merge so
> > > > it's actually user friendly.
> > > >
> > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > > ---
> > > >  builtin/pull.c | 23 ++++++++++++-----------
> > > >  1 file changed, 12 insertions(+), 11 deletions(-)
> > > >
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

Right. Maybe my mind is tainted by doing so many fast-forward "git
merge"s to update the current branch.

But in my mind "fast-forward" is not a noun, it's an adjective, so I
still expect a noun: fast-forward $what. And I don't have any other
noun to put there but "merge".

> > Perhaps: a merge, a rebase, or a fast-forward?
>
> Sure, that works; in fact, that's much better than my suggestion.  I like it.

Great.

> > > > +                       "You can squelch this message by running one of the following commands:\n"
> > > > +                       "\n"
> > > > +                       "  git config pull.rebase false  # merge (the default strategy)\n"
> > >
> > > Should this be labelled as the default given the desire to make
> > > --ff-only the default?  Perhaps I'm jumping ahead and you plan to
> > > change that later in this series.
> >
> > That's right.
> >
> > In the previous series which does indeed make "pull.mode=ff-only" the
> > default [1], I do change the warning to specify the future default
> > [2], but in that series the warnings is changed to:
> >
> >   The pull was not fast-forward, in the future you will have to choose
> > a merge, or a rebase.
> >   To squelch this message and maintain the current behavior, use:
> >
> >     git config --global pull.mode merge
> >
> >   To squelch this message and adopt the new behavior now, use:
> >
> >     git config --global push.mode ff-only
> >
> >   Falling back to old style for now (merge).
> >   Read "git pull --help" for more information.
> >
> > Since that series didn't get any traction, I decided to only implement
> > step 1: fix the current situation. And later on another series would
> > do step 2: introduce "pull.mode=ff-only" and do the preparations to
> > make it the default.
>
> I like this longer plan.

Yeah. It's a better plan, just more work for me.

> However, on the shorter scale plan...I think
> the suggestion to use "git pull --no-rebase" makes the current
> situation worse rather than fixing it.

Well, I already said I partly agree with you: in the --ff-only case
the suggestion should not be brought forward.

But in the "git pull" default case, *today* it's doing a merge. If
uttering --merge and thus making the current behavior explicit instead
of implicit seems dangerous it's because it is. But not documenting it
doesn't make it any less dangerous.

> > > > +                       "  git config pull.rebase true   # rebase\n"
> > > > +                       "  git config pull.ff only       # fast-forward only\n"
> > > > +                       "\n"
> > > > +                       "You can replace \"git config\" with \"git config --global\" to set a default\n"
> > > > +                       "preference for all repositories.\n"
> > >
> > > Good up to here.
> > >
> > > > +                       "If unsure, run \"git pull --no-rebase\".\n"
> > >
> > > Why is that safe to suggest?  The original text may not have been the
> > > easiest to parse, but this seems more problematic to me.
> >
> > Because "git pull" has been doing the same as "git pull --no-rebase"
> > for more than a decade. It's safe for people to continue with this
> > behavior for a few more months.
> >
> > Some people need to get things done today, and they are not interested
> > in future changes, nor changing their default configuration, or what
> > the warning has to say.
> >
> > They just want "git pull" to do the same as yesterday, and the year
> > before, without being bothered with an annoying warning.
> >
> > Those people can start training their fingers to do "git pull
> > --merge", and learn the problems with "git pull" later.
> >
> > We want to respect the user's time, and not force them to read the
> > warning today.
>
> The warning was added because sending users down paths that break
> things badly is a waste of user's time, and often a much bigger waste
> of user's time than making them read up on the meaning behind the two
> different choices of what kind of changes they can make.  I agree the
> warning went too far, but I fully agree with the original folks who
> put this warning here that we need to have it for at least some cases
> and that there is a decision to be made.  Though I am just one voice,
> and perhaps others will agree with you on your point here, I'll
> continue to disagree with blindly suggesting "git pull --no-rebase".

I think the warning is good. I implemented something like that years
ago, and I believe Junio did so too. It should have been implemented
differently though.

And yes, we want to annoy the users, and nudge them in the right
direction, but still leave them the *option* to easily ignore us.

I'm against forcing anyone to do anything. If the user wants to
analyze the warning, they can do so, if not, they can just do $cmd and
go about their day as usual. But they were warned.

Cheers.

-- 
Felipe Contreras
