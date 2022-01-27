Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B976C433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 01:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiA0Bk7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 20:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiA0Bk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 20:40:59 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE42C06161C
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:40:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ah7so2421845ejc.4
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 17:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+QMLs324ViS5F8v03FrKyy22jFtT/GR1STubryZuzmg=;
        b=O1aELv3zm5s+tb2mYDSauuhjE0UWIpWeoJ9DjJ2ojCrbvv98A9/YXbVgb1v0ZnU8vq
         DAgqZsabPEnAflO/oTQLHGebDWe1bYA97nyz5yCpGxltAxpt0r1mdiH/rkFV/iwt4WWF
         AFSnIG2z1ZWSz6FJfTuhTwhZBnbnSFihLxaO8T/6jByimoa/dxfw9Mrlow+48OnqAGWE
         qp7qxBlluBjLqZQOv4Qa2Bu+O3eFaV2S2XCGvxs+FyS7bSR0k1QxeErUXdV/ij7BiHSz
         h2VmtS5YaXTI79UBkKCRnpnuY26IgNRyiAdhNVw8zbPnm3ZEL/ltkMp1Jchl9ejEKxYq
         z6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+QMLs324ViS5F8v03FrKyy22jFtT/GR1STubryZuzmg=;
        b=k00SKCKRs2BqUbwPCaLQzyxvYoQ1ROo7TDz54m8ZtdlgkqeumvcVx8LhLo72JC7gnX
         hR5vAvU4I/jtzVhWLgL5hs2ShTXY1PbJ0jt40u7NpulRhD/c+7+zSOZCcDBraKd15dNg
         52qphKPe5y5xfY2z32kRQhd3xv3FIBlVK2fTQqi2fFzWVp0c6KMQ+w8jV9P1uklW4s7x
         M0hMyFQGRKBIN9wW+E8w7ozpOhmaeTQp/dJKoYGApTGeNoOGq4/UT4myyQ4Gd8iH7RLy
         hMl0z0hKnVL8l9Iaq9rwWwbEh6h45pha8mcQVz1Vo9PU2Z26LC/I8S4NRt05M239+pue
         rd/g==
X-Gm-Message-State: AOAM533ICjZ9ar9OhvZFtb0DNhNvcvvssSFMbCIuQCOndTBelDq6pjtS
        grxlCMu+z2U0jQA9shnRBYY04Xxa+c0hNMIx/tY=
X-Google-Smtp-Source: ABdhPJyT8B+G9Qs0CFmcgl961q0DMwQ7k2kP/EQWSn1V3Y0fWlZqH/5YmT02AqTD+RCnTgf4JPVKZCHe3Ts0+DrUhIU=
X-Received: by 2002:a17:907:2ce4:: with SMTP id hz4mr292237ejc.613.1643247657113;
 Wed, 26 Jan 2022 17:40:57 -0800 (PST)
MIME-Version: 1.0
References: <2a50d67e-364b-5927-801b-00f38179e904@gmail.com> <kl6lwnimyxbq.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lwnimyxbq.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 26 Jan 2022 17:40:45 -0800
Message-ID: <CABPp-BE6ZBjVv8f8af+M=yN2c50=dyefULfsAjqswych9BrJFg@mail.gmail.com>
Subject: Re: git worktree, submodule and force checkout/switch
To:     Glen Choo <chooglen@google.com>
Cc:     Federico Kircheis <federico.kircheis@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 26, 2022 at 1:57 PM Glen Choo <chooglen@google.com> wrote:
>
> Federico Kircheis <federico.kircheis@gmail.com> writes:
>
> > Hello to everyone,
> >
> > I would like to report what I believe is a bug, or at least an
> > inconsistent behavior when using submodules and worktrees.
> >
> >
> > Consider following test-case
> >
> > ----
> > # create 2 repositories with one commit
> > mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1")
> > mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2")
> >
> > # add submodule, a couple of branches, and a worktree
> > cd repo1
> > git submodule add ../repo2 && git commit -m "add submodule"
> > git switch -c branch1
> > git switch -c branch2
> > git worktree add ../repo1.w --detach
> >
> >
> > # test switch in the worktree
> > cd ../repo1.w
> > # git switch works
> > git switch --recurse-submodule branch1
> > git switch --recurse-submodule master
> > #git submodule update # (1)
> > cat .git
> > cat .gitmodules
> > cat repo2/.git # (2)
> > git switch --force branch1 # (3)error if no submodule update
> > ----
> >
> >
> > Notice that if one forgets to git submodule update (1) before git switch
> > --force branch1, even when using --recurse-submodule, there is no
> > submodule, as repo1.w/repo2/ is empty (2).
> >
> > It is confusing/unexpected that git switch --force fails and creates a
> > repo1.w/repo2/.git file pointing to the wrong location.
> >
> >
> > As comparison, when cloning a repository and forgetting to do "git
> > submodule update", then "git switch --force branch1" works as expected:
> >
> >
> >
> > ----
> > # create 2 repositories with one commit
> > mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1")
> > mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2")
> >
> > cd repo1
> > git submodule add ../repo2 && git commit -m "add submodule"
> > git switch -c branch1
> > git switch -c branch2
> >
> > cd ..
> > git clone repo1 repo1.c
> > cd repo1.c
> > git switch branch2
> > git switch --force branch1 # works, event without git submodule update
> > ----
> >
> >
> >
> >
> > Notice:
> > In both cases "git switch" and "git checkout" behave the same.
> > Also the parameter "--recurse-submodule" does not change anything.
> >
> >
> > Best
> >
> > Federico
> >
> >
> > PS: I'm not subscribed to the mailing list (yet), so please keep me in CC.
>
> Thanks for the report! This is very cosmetically similar to another bug
> that Elijah (cc-ed) sent a patch for [1]. However, in my testing, the
> test case doesn't even pass in v2.34.0, which doesn't have en/keep-cwd
> (which is the branch that introduced the motivation for [1]).

The extent of the similarity to me seems to be that both testcases use
git-worktree.  So yeah, I think only cosmetically similar.

en/keep-cwd was very specifically about running commands from some
subdirectory, not the toplevel.  Here, the command being run is from
the toplevel, so that series couldn't really affect anything here.

The previous bug also was about GIT_DIR being implicitly set and then
forking subcommands; but the issue being observed here seems to be
with git-switch, which I don't think forks out to subprocesses.

So, I agree that this looks like some older issue.

However, I played with your testcase a little bit...

> So despite the unfortunate timing, I am inclined to think that this is a
> longstanding issue with worktrees and submodules (and not a recent
> regression in 2.35). I'm sending this out quickly just to say that it's
> not a regression, and I might take a closer look when I have time.
>
> This is the test case I used:
>
>   test_expect_success 'bugreport' '
>     # create 2 repositories with one commit
>     mkdir repo1 && (cd repo1 && git init && git commit --allow-empty -m "repo1") &&
>     mkdir repo2 && (cd repo2 && git init && git commit --allow-empty -m "repo2") &&
>
>     # add submodule, a couple of branches, and a worktree
>     cd repo1 &&
>     git submodule add ../repo2 && git commit -m "add submodule" &&
>     git switch -c branch1 &&
>     git switch -c branch2 &&
>     git worktree add ../repo1.w --detach &&
>
>     # test switch in the worktree
>     cd ../repo1.w &&
>     # git switch works
>     git switch --recurse-submodules branch1 &&

So, the 'checkout' subsection of the 'update' command in git submodule
has this interesting tidbit:

"""
If --force is specified, the submodule will be checked out
(using git checkout --force), even if the commit specified in
the index of the containing repository already matches the
commit checked out in the submodule.
"""

The test repository in question has the same submodule commit on both
branches, so I think it's hitting some short-circuiting logic to avoid
doing anything based on that.  Given that hunch, I added a "-f" (short
for --force) to this switch command, and then saw the following
output:

    ++ git switch --recurse-submodules -f branch1
    fatal: not a git repository:
../../repo1/.git/worktrees/repo1.w/modules/repo2
    fatal: could not reset submodule index

and indeed, you'll note that repo1/.git/modules/repo2/ looks like a
git repository, but there is no
repo1/.git/worktrees/repo1.w/modules/repo2 directory; in fact, the
modules directory is missing.

If you insert a
     ln -s ../../modules .git/worktrees/repo1.w
right after the 'git worktree add...' command and keep the -f I added
above, then the whole test runs to completion.

So, I think the relevant bits are potentially interesting:
  * git submodule appears to look for the submodule repository
information in $(git rev-parse --git-dir)/modules/$MODULE_NAME, but it
actually exists in $(git rev-parse
--git-common-dir)/modules/$MODULE_NAME.  For primary worktrees those
are the same, but not for added worktrees.  Some code probably needs
to be updated somewhere to look in the right location.
  * There are config values (submodule.repo2.url and
submodule.repo2.active) that were set from repo1.  I think you want
these same settings shared with other worktrees, so this probably
makes sense.  So you probably don't have to worry about
worktree-specific config (see the extensions.worktreeConfig
documentation) in the way that sparse-checkout does.
  * 'git worktree add' does a checkout, but doesn't have a
--recurse-submodules setting.  So it's not bothering to check them
out, but it kind of looks like it is active and checked out due to the
shared config.  It might make sense to add a --recurse-submodules
option to 'git worktree add' to initialize these better.
  * If your testcase setup would have had different submodule commits
for the different branches, you might have found this easier and not
needed the -f.

>     git switch --recurse-submodules main &&
>     cat .git &&
>     cat .gitmodules &&
>     cat repo2/.git &&
>     git switch --force branch1
>   '
>
> [1] https://lore.kernel.org/git/pull.1205.git.git.1643161426138.gitgitgadget@gmail.com

Anyway, I won't be looking at submodule issues anytime soon, but I
hope those pointers help someone else who wants to get this running.
