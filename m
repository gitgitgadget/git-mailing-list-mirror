Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836E4C83006
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568F720787
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 17:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5EuDYV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgD2RWK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726838AbgD2RWJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 13:22:09 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42411C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:22:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z17so2390557oto.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7udG51U+dtnvsYukQiTCGyYxzyitL3C/MLkW6yrZtI=;
        b=p5EuDYV6ZUBCevN4cj26Rmqbuj2Q1ok3NtXEZhwuiTuzDo64YbT464XcE0CsZ+hTY7
         mh5ZTqB54oT16eapEqF4bTV+iaUEdv5zVwOPuRxGsoBI10JYKCWiBZwlQOA3ClArqnOR
         hv/1Z09bJcIDFWwQk+4C7F3V5DzzCAdQoZWy4UIzXlSbjgMw7uGapDBwGHjVf7qzxn6b
         2c6oY/p25WDiZehUUTQ5hMUkXWBrpDEYo192g8++OGFzwlust94uXjquzG8Xjo3KEKha
         entwoHvIf59ViqndxYGPoFvWcu3jZ3OfGldKv74uBJ/tKD46CENvEWI2tPa1lEA6xLKl
         UbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7udG51U+dtnvsYukQiTCGyYxzyitL3C/MLkW6yrZtI=;
        b=Jjda48LfXrL+uVcwvYh/KvqQa8RhQBkcRMaWOQ9KpJPL1oGxpQValZ0d6K3/X1GJNH
         XU+xcYsZRUkUhXDt3lNb3NcbWJyX5Ulc+/M1zCb2+r+IiR71zIKr13pjkakodnqE+X5g
         miX8Hrl3qRhQPBDuSySmNB3wy9qGTZl1p/ZNUB3yC4kZbd4VIKFy7V4W+1Cr+ZwNNy2d
         z3to4FZV0diT7oTuREXgPGAO35777E31UI62tOzrkQ9UeyCWVHnUTqVuWYJsDDMCW5Bi
         WNseNhJET+Q6lvhVzc6H/sBD7yacq6c5dmeodpEJYcpvoL6G2kODQw91YJ7jlCJV+VH0
         mknw==
X-Gm-Message-State: AGi0PubEQai8OZ0UZHZmsA6BGAO5ugpS5D2SIpaJylmn21B2CfzY2YXd
        rZjHbvJvR4SGG3pcm3bWfx4/eB/BB+ZHog8RccQ=
X-Google-Smtp-Source: APiQypK0mBFkr0YAjwP0CGINtwVC5x+BhaXHVo2RLXT7yaXUBFqGdXFJdEXIf7ItI4XQhff94eXhIWUE4sS/H89EY7Q=
X-Received: by 2002:a05:6830:1d62:: with SMTP id l2mr26538022oti.316.1588180927222;
 Wed, 29 Apr 2020 10:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <xmqq7dz938sc.fsf@gitster.c.googlers.com> <CAHd-oW5qq=dtaSmqcSyxoHd3HPipxjfaiCXtdBQwk9yNVe9okA@mail.gmail.com>
 <CABPp-BE6zW0nJSStcVU=_DoDBnPgLqOR8pkTXK3dW11=T01OhA@mail.gmail.com> <49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com>
In-Reply-To: <49c1e9a5-b234-1696-03cc-95bf95f4663c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Apr 2020 10:21:56 -0700
Message-ID: <CABPp-BHKYR9QBcAG_pM6DniaeGS40X=ErKGGsvWa_KhogCZzEA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the super late reply...

On Tue, Mar 31, 2020 at 1:02 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/31/2020 3:12 PM, Elijah Newren wrote:
> > // adding Jonathan Tan to cc based on the fact that we keep bringing
> > up partial clones and how it relates...
> >
> > On Sun, Mar 29, 2020 at 8:23 PM Matheus Tavares Bernardino
> > <matheus.bernardino@usp.br> wrote:
> >>
> >> On Tue, Mar 24, 2020 at 3:30 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>>
> >>> Elijah Newren <newren@gmail.com> writes:
> >>>
> >>>> On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
> >>>> <matheus.bernardino@usp.br> wrote:
> >>>>>
> >>>>> In the last commit, git-grep learned to honor sparsity patterns. For
> >>>>> some use cases, however, it may be desirable to search outside the
> >>>>> sparse checkout. So add the '--ignore-sparsity' option, which restores
> >>>>> the old behavior. Also add the grep.ignoreSparsity configuration, to
> >>>>> allow setting this behavior by default.
> >>>>
> >>>> Should `--ignore-sparsity` be a global git option rather than a
> >>>> grep-specific one?  Also, should grep.ignoreSparsity rather be
> >>>> core.ignoreSparsity or core.searchOutsideSparsePaths or something?
> >>>
> >>> Great question.  I think "git diff" with various options would also
> >>> want to optionally be able to be confined within the sparse cone, or
> >>> checking the entire world by lazily fetching outside the sparsity.
> >> [...]
> >>> Regardless of the choice of the default, it would be a good
> >>> idea to make the subcommands consistently offer the same default and
> >>> allow the non-default views with the same UI.
> >>
> >> Yeah, it seems like a sensible path. Regarding implementation, there
> >> is the question that Elijah raised, of whether to use a global git
> >> option or separate but consistent options for each subcommand. I don't
> >> have much experience with sparse checkout to argument for one or
> >> another, so I would like to hear what others have to say about it.
> >>
> >> A question that comes to my mind regarding the global git option is:
> >> will --ignore-sparsity (or whichever name we choose for it [1]) be
> >> sufficient for all subcommands? Or may some of them require additional
> >> options for command-specific behaviors concerning sparsity patterns?
> >> Also, would it be OK if we just ignored the option in commands that do
> >> not operate differently in sparse checkouts (maybe, fetch, branch and
> >> send-email, for example)? And would it make sense to allow
> >> constructions such as `git --ignore-sparsity checkout` or even `git
> >> --ignore-sparsity sparse-checkout ...`?
> >
> > I think the same option would probably be sufficient for all
> > subcommands, though I have a minor question about the merge machinery
> > (below).  And generally, I think it would be unusual for people to
> > pass the command line flag; I suspect most would set a config option
> > for most cases and then only occasionally override it on the command
> > line.  Since that config option would always be set, I'd expect
> > commands that are unaffected to just ignore it (much like both "git -c
> > merge.detectRenames=true fetch" and "git --work-tree=othertree fetch"
> > will both ignore the irrelevant options rather than trying to detect
> > that they were specified and error out).
> >
> >> [1]: Does anyone have suggestions for the option/config name? The best
> >> I could come up with so far (without being too verbose) is
> >> --no-sparsity-constraints. But I fear this might sound generic. As
> >> Elijah already mentioned, --ignore-sparsity is not good either, as it
> >> introduces double negatives in code...
> >
> > Does verbosity matter that much?  I think people would set it in
> > config, and tab completion would make it pretty easy to complete in
> > any event.
> >
> > Anyway, maybe it will help if I provide a very rough first draft of
> > what changes we could introduce to Documentation/config/core.txt, and
> > then ask a bunch of my own questions about it below:
> >
> > """
> > core.restrictToSparsePaths::
> >         Only meaningful in conjuntion with core.sparseCheckoutCone.
> >         This option extends sparse checkouts (which limit which paths
> >         are written to the worktree), so that output and operations
> >         are also limited to the sparsity paths where possible and
> >         implemented.  The purpose of this option is to (1) focus
> >         output for the user on the portion of the repository that is
> >         of interest to them, and (2) enable potentially dramatic
> >         performance improvements, especially in conjunction with
> >         partial clones.
> > +
> > When this option is true, git commands such as log, diff, and grep may
> > limit their output to the directories specified by the sparse cone, or
> > to the intersection of those paths and any (like `*.c) that the user
> > might also specify on the command line.  (Note that this limit for
> > diff and grep only becomes relevant with --cached or when specifying a
> > REVISION, since a search of the working tree will automatically be
> > limited to the sparse paths that are present.)  Also, commands like
> > bisect may only select commits which modify paths within the sparsity
> > cone.  The merge machinery may use the sparse paths as a heuristic to
> > avoid trying to detect renames from within the sparsity cone to
> > outside the sparsity cone when at least one side of history only
> > touches paths within the sparsity cone (this can make the merge
> > machinery faster, but may risk modify/delete conflicts since upstream
> > can rename a file within the sparsity paths to a location outside
> > them).  Commands which export, integrity check, or create history will
> > always operate on full trees (e.g. fast-export, format-patch, fsck,
> > commit, etc.), unaffected by any sparsity patterns.
> > """
> >
> > Several questions here, of course:
> >
> >   * do people like or hate the name?  indifferent?  have alternate ideas?
>
> It's probably time to create a 'sparse-checkout' config space. That
> would allow
>
>         sparse-checkout.restrictGrep = true
>
> as an option. Or a more general
>
>         sparse-checkout.restrictCommands = true
>
> to make it clear that it affects multiple commands.

As I mentioned to Matheus, would a "sparse" config space be nicer?

> >   * should we restrict this to core.sparseCheckoutCone as I suggested
> > above or also allow people to do it with core.sparseCheckout without
> > the cone mode?  I think attempting to weld partial clones together
> > with core.sparseCheckout is crazy, so I'm tempted to just make it be
> > specific to cone mode and to push people to use it.  But I'm
> > interested in thoughts on the matter.
>
> Personally, I prefer cone mode and think it covers 99% of cases.
> However, there are some who are using a big directory full of large
> binaries and relying on file-prefix matches to get only the big
> binaries they need. Until they restructure their repositories to
> take advantage of cone mode, we should be considerate of the full
> sparse-checkout specification when possible.

I agree with everything you say here except the last word; if you
replaced "possible" with "practical" then I'd agree.  In particular, I
like the idea of a partial clone that defaults to grabbing all the
blobs in the sparse path specification; I think it'd be reasonable to
transfer the sparseCone specification to the server and have it use
that to walk history and make a packfile.  Transfering a sparse
specification that does not match the cone mode requirements to a
server and making it use that as it walks over all of history sounds
like a good way to overload the server.

> >   * should worktrees be affected?  (I've been an advocate of new
> > worktrees inheriting the sparse patterns of the worktree in use at the
> > time the new worktree was created.  Junio once suggested he didn't
> > like that and that worktrees should start out dense.  That seems
> > problematic to me in big repos with partial clones and sparse chckouts
> > in use.  Perhaps dense new worktrees is the behavior you get when
> > core.restrictToSparsePaths is false?)
>
> We should probably consider a `--sparse` option for `git worktree add`
> so we can allow interested users to add worktrees that initialize to
> a sparse-checkout. Optionally create a config option that would copy
> the sparse-checkout file from the current repo to the worktree.

Okay, but if someone runs a future

$ git clone --sparse $RELEVANT_DIRECTORIES user@server.name:path/to/repo.git
$ cd repo
<Blissfully work in their smaller repo without commands suddenly
downloading reams of unwanted data>

should the clone command automatically set this option for the user?
I don't like the idea of users having to remember to set this option
(and the restrictToSparsePaths option, and whatever other options are
needed to work in their smaller environment).  I'd really like there
to be a single flag, in the form of some clone option, that sets all
of this up.

> >   * does my idea for the merge machinery make folks uncomfortable?
> > Should that be a different option?  Being able to do trivial *tree*
> > merges for the huge portion of the tree outside the sparsity paths
> > would be a huge win, especially with partial clones, but it certainly
> > is different.  Then again, microsoft has disabled rename detection
> > entirely based on it being too expensive, so perhaps the idea of
> > rename-detection-within-your-cone-if-you-really-didn't-modify-anything-outside-the-cone-on-your-side-of-history
> > is a reasonable middle ground between off and on for rename detection.
>
> The part where you say " when at least one side of history only
> touches paths within the sparsity cone" makes me want to entertain
> the idea if it can be done cleanly.

Yeah, I still have to dig in and verify that this really works.

> I'm more concerned about the "git bisect" logic being restricted to
> the cone, since that is such an open-ended command for what is
> considered "good" or "bad".

If the sparse checkout has sufficient information for them to build
and test whatever predicate they are interested in, then surely
bisecting in a way that restricts to the cone would be a nice
optimization, right?  And if the cone doesn't have enough information
for them to build and test commits, then they would need to leave the
sparse checkout in order to bisect anyway.

> >   * what should the default be?  Junio suggested elsewhere[1] that
> > sparse-checkouts and partial clones should probably be welded together
> > (with partial clones downloading just history in the sparsity paths by
> > default), in which case having this option be true would be useful.
>
> My opinion on this is as follows: filtering blobs based on sparse-
> checkout patterns does not filter enough, and filtering trees based
> on sparse-checkout patterns filters too much. The costs are just
> flipped: having extra trees is not a huge problem but recovering from
> a "tree miss" is problematic. Having extra blobs is painful, but
> recovering from a "blob miss" is not a big deal.

Sounds like --filter=blob:none already solves your issues.  It doesn't
make me happy; I really want the history within the sparse cone to be
downloaded as part of the initial clone.  (I can see various ways that
downloading all trees would be easier, so if we end up downloading all
commits and all trees and just the blobs within the sparse cone, that
sounds fine to me.)

> > But it may also be slightly weird because it'll probably take us a
> > while to implement this; while the big warning in
> > git-sparse-checkout.txt certainly allows this:
> >         THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
> >         COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
> >         THE FUTURE.
> > It may still be slightly weird that the default behavior of commands
> > in the presence of sparse-checkouts changes release to release until
> > we get it all implemented.
>
> I appreciate that we put that warning at the top. We will be
> able to do more experimental things with the feature because
> of it. The idea I'm toying with is to have "git clone --sparse"
> set core.sparseCheckoutCone = true.

Sounds good to me.  We might also want to set worktrees.copySparsity
and sparse.restrictToCone (or whatever these end up being named) as
well.

> Also, if we are creating the "sparse-checkout.*" config space,
> we should "rename" core.sparseCheckoutCone to sparse-checkout.coneMode
> or something. We would need to support both for a while, for sure.

And, if we automatically migrate the setting and delete the old one,
do we prevent someone from successfully using an older git version
with the repo?  Or, if we don't automatically unset the old one, do we
risk the two values getting out of sync if they do switch to an older
git version?
