Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C197BC636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC226613D4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 19:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbhGOTVL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243821AbhGOTU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 15:20:27 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A3C05BD33
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 12:04:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so7322412ott.1
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIXZPnUrxj8C09sdU/kQWy861BxHFP1HVFJ436NxdWs=;
        b=uZZR3PNVvzgixchBTZXXsu4mXwj5y4dtSiVQkLX+0MkAxKEx5Q2TvJ4hPL6ThQus3U
         S4pHCts6EllOPQcT7ZAha4BekbJ9uVuafM4I1ynRjZ56brqsr6LvC78aGmS9XgaCymjV
         wOmYFamVwPDpZ54TfNX3mTkwnj5HUua17+TKTRAspoRemqycOvilMpXwG3akDXN4RCQP
         1C+MuT8fyOGByICpQbTTmaI7jLnvTxK8cboP8MAFAegGXQNMVNsisKZkgPGDrqmrr17D
         yx6P49mClrUUgcWr2vhh0yuzlsKONemxVc3MRbUru2GZRRK+hapZH6Uve062I68VA0th
         XhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIXZPnUrxj8C09sdU/kQWy861BxHFP1HVFJ436NxdWs=;
        b=qJd0Lb36xMYWFsOCJb3ADIha6TQJEky/URLIqxvrn3SfvdqK2L2GFtG98Mkyp6QgC3
         +DyBmINzWIvrd81RwNxrRWkoH43o1HfBR1ONs4l8Bj+YbI/2umdBlhMMG0Rk29GhwZyz
         K8zFWyARgD/ITjvXJE0vTVlfK0rMuxwt9zTGOnGGJxFNKLn4/g7NlUAdapy52NZgU0bq
         1ILziWVocpDm7dZVZplbxaQO76d4Vwy9eaJTu/jEWDzHdejIY/+6IhhTr5TnL335+SSi
         hcmoVdlUKPJWYLMwZldtwzrcY+fCIaysV+62x45apEdO5mEcv/UJzgktPWpQ5WREeDIO
         p3Xw==
X-Gm-Message-State: AOAM5323JlAYtRlKNCuUizQbpwoZISCTSzqwLh60dFSyreIBx+L4Pnzs
        KGgTV5smZQD13Yn0RMSk2C5GB3zmL4XUtRDj2N0=
X-Google-Smtp-Source: ABdhPJyfRYVVBV0QKYl2cvmZPnP0ISz5f95JWblkkvWhzlNZ9ehvwx0tpgt8yXvEfUtZbNOU6ibcwL/E7kdT2Kha2V4=
X-Received: by 2002:a9d:5a8:: with SMTP id 37mr5006790otd.345.1626375889795;
 Thu, 15 Jul 2021 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
 <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
 <xmqq7dhrtrc2.fsf@gitster.g>
In-Reply-To: <xmqq7dhrtrc2.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 15 Jul 2021 12:04:38 -0700
Message-ID: <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 15, 2021 at 10:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
> > index 54048306095..e70ed99e408 100644
> > --- a/Documentation/config/pull.txt
> > +++ b/Documentation/config/pull.txt
> > @@ -7,12 +7,13 @@ pull.ff::
> >       line). When set to `only`, only such fast-forward merges are
> >       allowed (equivalent to giving the `--ff-only` option from the
> >       command line). This setting overrides `merge.ff` when pulling.
> > +     Incompatible with pull.rebase.
>
> This update may mean well, but I sense that the description needs to
> be tightened up a bit more.  Unless you mean to say that I am not
> allowed to say "[pull] rebase=no" when I set "[pull] ff", that is.
>
> Or do you mean pull.ff=only is incompatible with any setting of
> pull.rebase?
>
> Or do you mean pull.ff=only is incompatible with any setting of
> pull.rebase other than false?
>
> Or do you mean any setting of pull.ff is imcompatible with any
> setting of pull.rebase other than false?
>
> (You do not have to answer---the above questions just demonstrate
> that the description is unnecessarily loose).

Fair enough.

> >  pull.rebase::
> >       When true, rebase branches on top of the fetched branch, instead
> >       of merging the default branch from the default remote when "git
> >       pull" is run. See "branch.<name>.rebase" for setting this on a
> > -     per-branch basis.
> > +     per-branch basis.  Incompatible with pull.ff.
>
> Likewise.
>
> I think it technically is OK to say "only ff update is allowed" or
> "ff update is allowed when able" while saying pull.rebase=yes.
>
>  - For those who say ff=only, the actual value of pull.rebase would
>    not matter (i.e. the integration immediately finishes by updating
>    to what was obtained from the upstream because there is no new
>    development on our own on top of theirs to either replay or
>    merge).
>
>  - For those who merely allow ff, an update may fast-forward even
>    when pull.rebase is set to true (or any non-false value), while
>    we'll replay our own development on top of theirs when their
>    history is not descendent of ours.
>
> So I do not see need to declare these combinations "incompatible".
> But perhaps I am missing some subtle cases?

Let me ask two questions:

1. When is it beneficial for users to set both pull.ff and pull.rebase?
2. Is it harmful to users for us to allow both to be set when we will
just ignore one?

I believe the answer to (1) is "never", and the answer to (2) is "yes".

For the second question in particular, I can think of two example cases:

2a) Users start with pull.ff=only, perhaps suggested by someone else
and left in their config for a long time.  When users hit a case that
can't fast-forward and they either ask for help or find a post on
stack overflow that suggests setting pull.rebase=true, they do so and
then get no warning that the setting they just added is being ignored.

2b) Perhaps users start with pull.rebase=true (suggested by a
colleague and forgot about it as they are more of a tester than a
developer and thus usually only see fast-forwards).  Then at some
point they need to function as an integrator, and they read the docs
and determine that pull.ff=false should do what they want to create
merge commits.  But then they get shocked that they've rebased public
commits (and perhaps also pushed them out) when they wanted merges.
Our docs have pretty clearly stated that pull.ff=false and --no-ff
create merges.

Additionally, pull.rebase=interactive seems like a case that interacts
poorly with pull.ff.  It may be that if you disagree that pull.rebase
and pull.ff are more generally incompatible, then we may still need to
micro-document individual incompatibilities.  (And does that list grow
and get confusing?)

> > diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> > index 5c3fb67c014..03e8694e146 100644
> > --- a/Documentation/git-pull.txt
> > +++ b/Documentation/git-pull.txt
> > @@ -121,6 +121,9 @@ When false, merge the current branch into the upstream branch.
> >  +
> >  When `interactive`, enable the interactive mode of rebase.
> >  +
> > +Note that these flags are incompatible with --no-ff and --ff-only; if
> > +such incompatible flags are given, the last one will take precedence.
> > ++
>
> I am not sure about these, either.  Again, --ff-only (whether it is
> combined with --rebase or --rebase=no) would mean that the operation
> would fail when we have our own development on top of their history,
> and we repoint the tip of our history to theirs when we do not.
>
> We see "--no-ff" is explained to "always create an unnecessary extra
> merge", bit I am not sure it is the right mental model to apply when
> the user prefers rebasing.  The merge workflow is to treat our
> history as the primary and merging theirs in, so when theirs is a
> descendant (i.e. we have no new development of our own), some people
> may want to mark "we were there before we updated from them" with an
> extra merge.  Without --no-ff, the resulting history would be quite
> different in the merge workflow if you have or do not have your own
> development.  But the rebase workflow is to treat their history as
> the primary and replay our own development on top of theirs, and the
> shape of the resulting history would be the same whether you have
> your own development on top of theirs.  We start from their tip and
> then replay our own development on top (which could be an empty
> set), and there is nothing "--no-ff" would need to do differently to
> keep the resulting history similar to cases where we do have
> something of our own.  IOW, "--no-ff" becoming a no-op in a "rebase"
> workflow is a natural consequence, and there is no strong reason to
> say it is incompatible.

I think you're overlooking a variety of ways this could harm the user.

But first let me check if I understand you correctly:  I think you're
suggesting that
  * if --ff-only is given along with any --rebase[=*] flags, then we
silently ignore the --rebase[=*] flags.
  * if --no-ff is given along with any --rebase flag other than
--rebase=false, then we silently ignore --no-ff.

Let me ask the same two questions as for the config:  Does it benefit
the users to allow them to specify both flags?  Does it hurt some
users, especially if undocumented that one of the flags will be
ignored?

I think the same usecases from the config settings apply, though the
fact that both flags are present simultaneously on the command line at
least makes it less problematic in the case of --ff-only (users will
more quickly discover why their --rebase=<whatever> flag was ignored).
But there's an additional reason why treating --no-ff as a no-op is
harmful when --rebase is present:

git rebase has a --no-ff flag (a synonym for --force-rebase).  Some
users may intend for git pull --rebase --no-ff to run `git fetch
origin && git rebase --no-ff FETCH_HEAD`.  The fact that --no-ff will
be ignored and sometimes results in a fast-forward when the user
explicitly requested no fast forward seems buggy.

I thought this was the biggest hole in my proposal: there is both a
git merge --no-ff and a git rebase --no-ff, and they avoid
fast-forwards in different ways with different results.  It _might_ be
beneficial to allow both to be triggered directly from the pull
command.  However, allowing both has some backward compatibility
problems because (1) --no-ff is documented as making a merge, and (2)
people could have pull.rebase=true set and forget about it and then
get surprised when they add --no-ff to the command line and get a
rebase --no-ff (or even a plain rebase without --no-ff) rather than
the documented merge --no-ff.  I think the split config/parameters of
git pull make it really hard for us to determine whether users intend
to get a merge --no-ff or rebase --no-ff.

I think silently ignoring and not even documenting these pitfalls is
problematic.  We should at least document them.
