Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C5C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED30622A85
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgLGJRL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 04:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLGJRK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 04:17:10 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15420C0613D0
        for <git@vger.kernel.org>; Mon,  7 Dec 2020 01:16:27 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so12981568wme.0
        for <git@vger.kernel.org>; Mon, 07 Dec 2020 01:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4H5VqW9h1AblSEnAFk0tU3ho4ecSpuviuCO+0O76/hk=;
        b=p9nYxBxcisprEhiQh825y68og4fKISA8fKYnzy0y7zFwv+fEZs7xiKsECs1QFPHirG
         n8epNFa+6Xr+BR3KyPb+Ew61c1xTHPW7ysofPeo0fTetNd5qGmPW8wpsjdrSb4S27PJE
         2i8gRHZ2Is7lkrFY0Q+fsWlDUYQLBdQ3GNZBYsF2GxN4QSkMJZAgJ3sStWNAXZymawFb
         3qA+WIXbLpSt6zrtM7oNQpfsGk1X913k0sRtQljn5ztLCcCw6Ookr7wSBxGG31zkytE9
         Mz00CfaajtdvJ8EPee3TSiHzJuhWlYWQKUdD7fAZVnmFvD6Js+9OZPsQjsKOgXlx0Gu3
         ZTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4H5VqW9h1AblSEnAFk0tU3ho4ecSpuviuCO+0O76/hk=;
        b=T8kbQnQPcxTVwtMvrbm/riJ0L2pGGBKp2PDB1RFAS/QafCPtHdjd6IxSjhcf69wDBE
         SYusuMl7WO0NSAEdPsU69oDYPSl0ya3y+NBmOHuPTPyUK1Mxdb9Xx/wSzu+6LjAMEm6I
         dHBE7tdTPymb2uIc87JsA4uo6lVx06aJlr5N8YqbSrUv+vexKIpkNrbEaXb+dhacKbJX
         5+9G5zYG/icWVMBe8Mly1mxREnMetsfHe98lmM1UZY87SoZG7DUgUvIMpH93DEpbIKv8
         yLcJevLCV+Av2lVGo24AtSiguJI4Jsv9sXz+shvOBc1s+4Kz2wfs4IFh9KSxvqRwtvR2
         KFdg==
X-Gm-Message-State: AOAM532mbRsogVrx/IC+lW34unVhY0fty0CxYWA98gxMEAsELqCk7XGR
        NCKm1RVPTVhhlI1VPB6BtgCyvGtSyIyST8ar+yU4Pt++SDmM290A
X-Google-Smtp-Source: ABdhPJwnM5noRa9n8Vv5J5aFblMVSkbCNg9OfLNpiPkUfWf1nmryAMFGgehLbbLzIXmEVt9Qod7GexH6W3Dx21sjjOI=
X-Received: by 2002:a1c:f619:: with SMTP id w25mr17197903wmc.55.1607332585655;
 Mon, 07 Dec 2020 01:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-3-felipe.contreras@gmail.com> <CABPp-BFdjj=+4jk0vo=kpNc6ug1=UgtKfXJZkseyyxut2VB=Uw@mail.gmail.com>
 <CAMP44s1eTc4+tbULbyz5ENgbcN4tOVBA3Z-4GS4yMpciUD_1Hw@mail.gmail.com>
 <CABPp-BFwWBLdFPsKi3o9hznFtAeWWfhNAyuymPS4BhMAHpnSfw@mail.gmail.com>
 <CAMP44s1=aZL7BMKSjzKJ7qYqg-usScwzRUJmaOhsCGvQ4ieYow@mail.gmail.com>
 <CABPp-BF4rXBOKsn8bG6y3QUEtNVV9K2Pk5NmwrU5818CqhRt_Q@mail.gmail.com>
 <CAMP44s2L24jhCG9ps72--ZiJkXUovR726jCf8JTLHAs0jV7Whg@mail.gmail.com>
 <CABPp-BGdNt8TBMTE9zvaicF5AtvyTBhpiJXqkuZc7mBLGbw0Qw@mail.gmail.com> <xmqqeek2cc14.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeek2cc14.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 7 Dec 2020 03:16:14 -0600
Message-ID: <CAMP44s2XFQoda_PMULWha-rj9HhNfEddO5fikmswk9=AWN4RCw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] pull: improve default warning
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
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

On Mon, Dec 7, 2020 at 1:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:

> >> Do you think the crew should disregard the passenger's volition and
> >> force him to pay attention to the safety demonstration?
>
> An example that is irrelevant.  Passengers who sit on the aisle side
> and clutter the floor with their luggages can pose public hazard,
> and it is quite sensible for crews to remove them from the plane.

That's a completely different example that mixes policy with
regulations. Apples and oranges.

> A team member who runs "pull --[no-]rebase" pushes the result, which
> may be a new history in a wrong shape, back to the shared repository
> probably falls into a different category.  ... Or perhaps in the
> same public hazard category?

Yes, but if it's a public hazard or not is up to the maintainers of
specific projects. Some projects are perfectly fine with those merges.

It's the maintainer of the project that should decide what is the best
policy for the project, and instruct his/her contributors.

It's not up for individuals to decide what is a public hazard, and
it's not up to Git either. Similarly; passengers can't decide what
raises to the level of public hazzard, but neither can a flight
attendant.

> > Useful link there.  Based on his comments, we may want to make
> > --ff-only, --merge, and --rebase all be mutually exclusive and result
> > in an error message if more than one is specified at the command line.
>
> I hope "his comment" does not refer to what I said.  Redefining the
> semantics of --ff-only (but not --ff=no and friends) to make it
> mutually incompatible with merge/rebase was what Felipe wanted to
> do, not me.

That's not true.

What I want is to introduce a "pull.mode=ff-only", not change the
semantics of --ff-only.

What I have been saying is that you can't make --ff-only the default
without changing its semantics.

But since the patch series that introduced such pull.mode [1] was
completely ignored, I decided to take a shot at making --ff-only work.

You said [2]:

> > What we want to see can be done without such backward incompatible
> > changes, e.g. declaring the combination of "--ff-only" and
> > "--[no-]rebase" incompatible and/or the last one wins, I would say, and
> > I suspect Alex's RFC was an attempt to make the first step in that
> > direction.

But in all my attempts the desired result cannot be done without
backwards incompatible changes. I'm just the messenger.

To be crystal clear: I don't want to change the semantics of
--ff-only; I want to introduce a new "pull.mode=ff-only".

> FWIW, I see the general direction as
>
>  - When the history you are pulling is not a descendant of what you
>    have on your current branch, you must show your preference
>    between merging their history into yours or rebasing your history
>    onto theirs.

Agreed.

>  - In such a case, we error out, with an error message telling them
>    that they must tell us which one they want in this invocation
>    (e.g. with "--rebase" or "--no-rebase").  We further tell them
>    that pull.rebase can be used to record their preference, if they
>    almost always use the same.

Not quite. See below.

>         Side note: I earlier said "see below" to refer to this.  I
>         think the message should offer what they can do right now
>         with command line option first, and then give an option to
>         configure.  IOW, the message quoted in the beginning of this
>         response gives information in a wrong order.  Also,
>         "discouraged" is misleading, isn't it?  When we give this
>         message, we refuse to proceed until the user specifies.

That's why I keep pointing out the end goal. In the end it's not one
message, it's *two*:

You can see my suggestion for both messages in my patch series for
pull.mode [1].

When the user has specified "pull.mode=ff-only", the command dies with:

  The pull was not fast-forward, please either merge or rebase.

When the user has not specified any mode (by default), the command
would output a warning:

  The pull was not fast-forward, in the future you will have to choose a
  merge, or a rebase.

  To squelch this message and maintain the current behavior, use:

    git config --global pull.mode merge

  To squelch this message and adopt the new behavior now, use:

    git config --global push.mode ff-only

  Falling back to old style for now (merge).
  Read 'git pull --help' for more information.

But in order to reach that point we first need to decide what will be
the default mode, and how it will be configured (--ff-only or
"pull.mode=ff-only").

In the meantime this particular series is not committing for any
particular decision, and thus it's changing the warning message for
the *current* situation in which the command does not fail, but only
shows a warning. So today it's merely discouraged.

This particular patch is pretty far from the end goal. It's just patch
#2 of part 1.

>         Another thing to consider is that pull.ff=only (and
>         --ff-only) may be wrong choice to offer in the error message
>         quoted above, if one of the objectives is to reduce the
>         "annoying" message that tells the user that they must
>         choose.  By definition, we do not give the message when our
>         side do not have our own development, so "I could run 'pull
>         --ff-only'" is a unusable knowledge to those who see the
>         message and want to get out of the situation.

Those commands will squelch the warning, but won't change the
underlying nature of the warning, which is that the user must choose
to either merge or rebase.

The temporary warning will disappear, but the permanent error message will not:

  The pull was not fast-forward, please either merge or rebase.

>  - But when the history being pulled is a descendant of the current
>    branch, and the user does not give us preference between merge
>    and rebase (either from the command line or with configuration),
>    there is no need to give such an error message---if you do not
>    have your own development, we can just fast-forward the current
>    branch to what we fetched from the other side.  This does not
>    happen with the current system, which is what we want to fix.

It's not an error message, it's a warning. But yes.

>  - Also when the history from the other side is a descedant and the
>    user has preference, either to rebase or to merge, either from
>    the command line or with configuration, we can fast-forward the
>    current branch to their tip, but there are wrinkles:
>
>    . when --ff=no is given and the choice is to merge (not rebase),
>      we must create an extra merge commit.

--ff receives no arguments, it's --no-ff.

Yes.

>    . when the choice is to rebase, by definition, rebasing what you
>      have on top of theirs in this case is the same as fast-forwarding
>      the current branch to theirs, because "what you have" is an
>      empty set.

Agreed.

>    . I am not sure how "pull --rebase --ff=no" should interact if we
>      don't have our own development.  Rebasing our work on top of
>      theirs is philosophically incompatible with marking where the
>      side branch begins and ends with an extra commit, so it either
>      should be rejected when the command line and configuration is
>      parsed (i.e. regardless of the shape of the history we have at
>      hand), or --ff=no gets silently ignored when --rebase is given.
>      I haven't thought this one through.

I thought of this instance as well. In my opinion such combination
should fail. But it doesn't actually affect anything.


Just to put this series in context: it's only part 1; it does not
introduce pull.mode, and it doesn't make --ff-only the default.
There's one patch prefixed with "tentative" that changes the semantics
of --ff-only to see how it could look like when making it the default,
but in no way am I proposing that patch to be merged.

The series is entirely about improving the current situation, nothing
contentious.

In part 2 I will introduce pull.mode, which is the solution I propose,
and that would be basically rebasing [1] on top of this series
(hopefully).

I would have hoped that by this point it would have been clear why
--ff-only is not the way forward. But oh well, we'll see what happens.

Cheers.

[1] https://lore.kernel.org/git/20201125032938.786393-1-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/xmqqpn3qfhps.fsf@gitster.c.googlers.com

-- 
Felipe Contreras
