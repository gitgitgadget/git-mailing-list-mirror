Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33433C433DF
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 15:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA61214F1
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 15:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4BzyVlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFQPqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFQPqw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 11:46:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646DBC06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 08:46:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a21so2162500oic.8
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rg/MJYcwvn1k7ly8SBKC1tNVTyPNdDeSsQ2755AJEC0=;
        b=Q4BzyVlHaIh+blgTNk3W0/DhYJXSxHLc6CCqdbG7vl2hdz0dh3I3lNX5wen32fJBde
         5SVCH0+QXyWoNYTD/H1M02zgCCRp6kubTsSjD70tuLUTMg+ORZPPIitjUG7RxVQW69LN
         E1neMzI3vJUQLk9G3M92OBY1csi7Uyt1jPR0MoTzgj9NTD4vT+f9HaROrozqi1Dka+/H
         DOrUtMGFhr/SgexuJGXASMrG4MJtD7hpEsaLjUbw4f/CrcmGi8bFkKKiE1szl55kWSQi
         nS3W/R26tMksU48+wTxD1t3W5QF9JspiOc6vHkIBxPdWKqQR2TRrV120U9/60RZp0F7p
         JnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg/MJYcwvn1k7ly8SBKC1tNVTyPNdDeSsQ2755AJEC0=;
        b=fYKblsFMxE0QngvIkgyrwzlfAofQy+WEyNrW8JZSGYzS7uR+kXLJ10ahWg+PG+lIkl
         9fsvv6D5DnOldR2louhPZin2zCLl/iPLUcOo2239bzR65ddpCwQ9kDDxmZRbbcn93Gn5
         HpYL85QIPFCEE9lnclvfAUtzzEfFNFtnY5KOsGjnMIx0g4/SMpWy6whPMnu/QfBlh0z4
         xNCb1mw2WdVSWuCb45c6KqeK7vWFV1CyPrhHJ1nT2gL8iwsdFEQ5XgHSyzP6Qa9RbZzu
         BWf+wessNyPqzxHYyBSXj1YWDF7WIho57XZuOom9ti8Vdv9nUDotPNB6tjSkOsfMsxcu
         KYpA==
X-Gm-Message-State: AOAM531I10GIEYblcyzqivtsA6mTgayStGA+X4e2jFEzACCAqWHnXr1y
        lnSFxqSJ5oVkYWkfjSBra8A5Lr68yMi0cbQWI2g=
X-Google-Smtp-Source: ABdhPJwC6NFtS1VNqohVpK0sFBgYK87/GeHVH8n14CxwOQRRLfrpiptqM0W9UF7uEITeBUWaDgYGoeoxgXWmw7O69bs=
X-Received: by 2002:aca:2b0d:: with SMTP id i13mr8239228oik.39.1592408811363;
 Wed, 17 Jun 2020 08:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.808.git.git.1592350413.gitgitgadget@gmail.com>
 <462cee857ef30c413eda0abe655b123f32b3877e.1592350413.git.gitgitgadget@gmail.com>
 <e8e59662-7e8b-6aae-da28-c4b5ee225ac8@gmail.com>
In-Reply-To: <e8e59662-7e8b-6aae-da28-c4b5ee225ac8@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 08:46:39 -0700
Message-ID: <CABPp-BG1AhRaz5oWQMhLnsbMoiNr8-xmV1CoTvTQj0Lg4_Np0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] [RFC] wt-status: show sparse checkout status as well
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 17, 2020 at 7:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/16/2020 7:33 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Some of the early feedback of folks trying out sparse-checkouts at
> > $dayjob is that sparse checkouts can sometimes be disorienting; users
> > can forget that they had a sparse-checkout and then wonder where files
> > went.  Add some output to 'git status' in the form of a simple line that
> > states:
> >
> >     You are in a sparse checkout with 35% of files present.
>
> I like this idea.
>
> Aside: I think there was some ideas around a "git sparse-checkout stats"
> subcommand that would help users identify how large their sparse-checkout
> definition is compared to the full index. That would also want to drill
> down into directories, so it would need to be more advanced than what you
> have here.

Yeah having an "info" or "status" or "stats" subcommand to
sparse-checkout I think would make sense.  I think having some simple
message of some kind in "git status" would help alert/remind someone
that they have a sparse checkout, and then they can run some
sparse-checkout command if they want to drill down more.

> There is some prior work in the "gvfs health" commmand in VFS for Git.
> We use this to help users self-diagnose when they have "over hydrated"
> their working directory. Here is a sample use:
>
>   /c/_git/t/ForTests/src (master)
>   $ gvfs health
>
>   Gathering repository data...
>
>   Health of directory:
>   Total files in HEAD commit:           548 | 100%
>   Files managed by VFS for Git (fast):   30 |   5%
>   Files managed by Git:                   1 |   0%
>
>   Total hydration percentage:                   6%
>
>   Most hydrated top level directories:
>    19 / 524 | GVFS
>     0 / 8   | GitHooksLoader
>     0 / 3   | Scripts
>
>   Repository status: OK
>
>   /c/_git/t/ForTests/src (master)
>   $ cd GVFS
>
>   /c/_git/t/ForTests/src/GVFS (master)
>   $ gvfs health
>
>   Gathering repository data...
>
>   Health of directory: GVFS/
>   Total files in HEAD commit:           524 | 100%
>   Files managed by VFS for Git (fast):   19 |   4%
>   Files managed by Git:                   0 |   0%
>
>   Total hydration percentage:                   4%
>
>   Most hydrated top level directories:
>    0 / 33 | FastFetch
>    0 / 92 | GVFS.Common
>    0 / 97 | GVFS.FunctionalTests
>    0 / 22 | GVFS.GVFlt
>    0 / 7  | GVFS.Hooks
>
>   Repository status: OK
>
> This is just a reference for something that has been helpful
> for some users. In VFS for Git, the hydration is not explicit
> but instead implicit by filesystem use. There could still be
> some value in the sparse-checkout case.

Yeah, I think a `git sparse-checkout` subcommand named 'info' or
'status' with some kind of extra details could be useful, especially
if/when your in-tree sparse checkout definitions are in use.  Our
local 'sparsify' script has an --info flag which reports some
information, though not as detailed as your gvfs health command:

    $ ./sparsify --info
    You are now in a sparse checkout with only 9874 of the 56079 files.
    Sparse modules requested:
      $MODULE_1
      $MODULE_2
    No user-specified additional paths -- tools/scripts/etc.
    Note: You have leftover .gitignore'd files in 197 directories;
          these likely represent build artifacts.
          To remove, run: ./sparsify --update --remove-old-ignores

The last three lines are a repeat of the same output shown at
'./sparsify --modules ...' time; I sent a separate email about that.
The fifth line might bear some explaining and be interesting as well:
since we have a dependency system where users specify some modules
(directories) and then sparsify figures out all the other directories
that those ones depend upon, there isn't flexibility to select
additional files or directories the user may want.  We instead allow
the user to populate .git/info/sparse-checkout-user (not sure I'm
still a fan of the filename/location, but it's what I picked at the
time), which provides a list of additional directories that will be
added to the sparse-checkout on top of the dependencies of the modules
the user specifies.

> > where, obviously, the exact figure changes depending on what percentage
> > of files from the index do not have the SKIP_WORKTREE bit set.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  wt-status.c | 35 +++++++++++++++++++++++++++++++++++
> >  wt-status.h |  1 +
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/wt-status.c b/wt-status.c
> > index 98dfa6f73f9..687d2ab1ba1 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -1484,6 +1484,16 @@ static void show_bisect_in_progress(struct wt_status *s,
> >       wt_longstatus_print_trailer(s);
> >  }
> >
> > +static void show_sparse_checkout_in_use(struct wt_status *s,
> > +                                     const char *color)
> > +{
> > +     if (s->state.sparse_checkout_percentage != -1)
> > +             status_printf_ln(s, color,
> > +                              _("You are in a sparse checkout with %d%% of tracked files present."),
> > +                              s->state.sparse_checkout_percentage);
>
> There is some concern over breaking third-party tools that
> parse "git status". However, we have had the machine-readable
> formats out for a long time.
>
> I briefly thought about putting this message to stderr to be
> safe, but some tools scan stderr (incorrectly) to say "any
> output to stderr must mean an error in the process."

If we hadn't taken steps over a decade ago (Sep 5, 2009) to avert this
exact problem, then I'd be sympathetic to this concern.  But since
we've had --porcelain for over a decade I'm just not.  Third-party
tools that are parsing git-status have had far more than enough time
to switch, and if they haven't, maybe we could consider changing the
status output to help remind them that they need to.  ;-)

However, there is another point here that is very interesting: I only
modified the long status output, but it's possible I also should have
modified other formats too.  In particular, both the --short and
--porcelain=v2 formats (Porcelain V2 defines an extensible set of
headers and explicitly says that parsers should ignore headers they
don't recognize, so adding a header to it is in line with its design
and won't break existing parsers.)

>
> > +     wt_longstatus_print_trailer(s);
> > +}
> > +
> >  /*
> >   * Extract branch information from rebase/bisect
> >   */
> > @@ -1623,6 +1633,27 @@ int wt_status_check_bisect(const struct worktree *wt,
> >       return 0;
> >  }
> >
> > +static void wt_status_check_sparse_checkout(struct repository *r,
> > +                                         struct wt_status_state *state)
> > +{
> > +     int skip_worktree = 0;
> > +     int i;
> > +
> > +     if (!core_apply_sparse_checkout) {
>
> Since this method is static, we can assume that it is only
> called after the index was loaded, which requires reading
> the config and initializing this value. Good.
>
> > +             state->sparse_checkout_percentage = -1;
> > +             return;
> > +     }
> > +
> > +     for (i = 0; i < r->index->cache_nr; i++) {
> > +             struct cache_entry *ce = r->index->cache[i];
> > +             if (ce_skip_worktree(ce))
> > +                     skip_worktree++;
> > +     }
> > +
> > +     state->sparse_checkout_percentage =
> > +             100 - (100 * skip_worktree)/r->index->cache_nr;
> > +}
> > +
> >  void wt_status_get_state(struct repository *r,
> >                        struct wt_status_state *state,
> >                        int get_detached_from)
> > @@ -1658,6 +1689,7 @@ void wt_status_get_state(struct repository *r,
> >       }
> >       if (get_detached_from)
> >               wt_status_get_detached_from(r, state);
> > +     wt_status_check_sparse_checkout(r, state);
> >  }
> >
> >  static void wt_longstatus_print_state(struct wt_status *s)
> > @@ -1681,6 +1713,9 @@ static void wt_longstatus_print_state(struct wt_status *s)
> >               show_revert_in_progress(s, state_color);
> >       if (state->bisect_in_progress)
> >               show_bisect_in_progress(s, state_color);
> > +
> > +     if (state->sparse_checkout_percentage != -1)
> > +             show_sparse_checkout_in_use(s, state_color);
> >  }
> >
> >  static void wt_longstatus_print(struct wt_status *s)
> > diff --git a/wt-status.h b/wt-status.h
> > index 73ab5d4da1c..4550004003a 100644
> > --- a/wt-status.h
> > +++ b/wt-status.h
> > @@ -90,6 +90,7 @@ struct wt_status_state {
> >       int bisect_in_progress;
> >       int revert_in_progress;
> >       int detached_at;
> > +     int sparse_checkout_percentage; /* -1 == not in sparse checkout */
>
> My only complaint is that maybe this "-1" should be a
> #define macro with a name such as SPARSE_CHECKOUT_DISABLED.

Good point, I'll update it.

Thanks!
Elijah
