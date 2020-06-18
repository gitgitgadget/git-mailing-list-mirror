Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CFC433E1
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 00:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522C82073E
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 00:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZDIlxIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFRAYl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFRAYk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 20:24:40 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A15C06174E
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 17:24:39 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id i74so3510288oib.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60bjcUjoH5u0EPOAggFahHIMU/BSXtin75JYMtqtv/w=;
        b=LZDIlxIxPNzT5Ibg4qKETXNqB7X9bLkBIIn+BkygElV7/l8TqVQpEoSHmnOJMTPh7P
         Q+Ev8IdV2TV1qxl+yKW9rixdl2+CujyotNzHAZjW3TwJUlO8Kmb6Q3TT7SOEhcI1j/KI
         FrLviuTbZrSivI4gQ91HLog7E/DnB0mTIj9v3E/fMYz4D3PapCXGahemYD+WC4e9LKpw
         h0vlu9ai4pusl2KkzrJqBTDf0Q9+WDZyI0wyfDlVDGB24TTMtD4kh565ZfQqlHpxPn3v
         L7TCm7KQgUo39V3r9It4GYE/IiTGzrgDZnG7n52dzc/N1ZGYSyU7boYXc5bKbHIvFrws
         qfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60bjcUjoH5u0EPOAggFahHIMU/BSXtin75JYMtqtv/w=;
        b=a+da3vOUxOCxmZqKGakzUtAxjB5v//MY6kcIWowBX4EZw41MYR61FUvIvZlZ6Cl+9G
         z9sRKaYsV5ZuhkKSLSTq12zQebzPT3tuEK8PvePRSh71rKs8y+LrSjT0Lf2avER7zK2P
         3daBzVVwjNsZJWhoauIC41ECmdsq+Gc3BIvsZnXs0VmS0Lg0jiHup+6McUHHtqIlLLyt
         31i5fS0vns2hyncrF9uGSYD1y+Zqe5kIVNuAMVmz7u2aW7jcPPnggpigHHj/TIjZs/dL
         IjdBswdfq45gGweU2HrHiPTUROnkZXyY0ecK0QIOtyM9BXeMFWj6zB5COy96/oLWye6t
         TTcQ==
X-Gm-Message-State: AOAM531yEzc/j0IFiMSzj/pxYl+mqCnbavr1zDNgHjJTTQxFFqj+1L+t
        HejoNnL56pe22OwbBb+kxZJ1obFh6WXoWOtuunA=
X-Google-Smtp-Source: ABdhPJy8pKshKJKNk7v9bKwRu3Sjrvkk+LBB72TuI/LSAGkpSKulnPWpPXQ41rmfn6JsDsh1T2YEPwBEz1QZrWjQCsM=
X-Received: by 2002:aca:6287:: with SMTP id w129mr1071912oib.167.1592439877528;
 Wed, 17 Jun 2020 17:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.809.git.git.1592356884310.gitgitgadget@gmail.com> <CAHd-oW5gTJO=6pYXvg3v=JfjffcajPyMpsUOoqXnozwYrg3WwQ@mail.gmail.com>
In-Reply-To: <CAHd-oW5gTJO=6pYXvg3v=JfjffcajPyMpsUOoqXnozwYrg3WwQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Jun 2020 17:24:26 -0700
Message-ID: <CABPp-BHtwifTHXxoxTKvz0mx45e2N-4SBTTfoRePcmMFAn1O2g@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: do not set SKIP_WORKTREE on submodules
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Wed, Jun 17, 2020 at 10:58 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Jun 16, 2020 at 10:21 PM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Elijah Newren <newren@gmail.com>
> >
> > As noted in commit e7d7c73249 ("git-sparse-checkout: clarify
> > interactions with submodules", 2020-06-10), sparse-checkout cannot
> > remove submodules even if they don't match the sparsity patterns,
> > because doing so would risk data loss -- unpushed, uncommitted, or
> > untracked changes could all be lost.  That commit also updated the
> > documentation to point out that submodule initialization state was a
> > parallel, orthogonal reason that entries in the index might not be
> > present in the working tree.
> >
> > However, sparsity and submodule initialization weren't actually fully
> > orthogonal yet.  The SKIP_WORKTREE handling in unpack_trees would
> > attempt to set the SKIP_WORKTREE bit on submodules when the submodule
> > did not match the sparsity patterns.  This resulted in innocuous but
> > potentially alarming warning messages:
> >
> >     warning: unable to rmdir 'sha1collisiondetection': Directory not empty
> >
> > It could also make things confusing since the entry would be marked as
> > SKIP_WORKTREE in the index but actually still be present in the working
> > tree:
> >
> >     $ git ls-files -t | grep sha1collisiondetection
> >     S sha1collisiondetection
> >     $ ls -al sha1collisiondetection/ | wc -l
> >     13
> >
> > Submodules have always been their own form of "partial checkout"
> > behavior, with their own "present or not" state determined by running
> > "git submodule [init|deinit|update]".  Enforce that separation by having
> > the SKIP_WORKTREE logic not touch submodules and allow submodules to
> > continue using their own initialization state for determining if the
> > submodule is present.
>
> Makes sense to me.
>
> I'm just thinking about the possible implications in grep (with
> mt/grep-sparse-checkout). As you mentioned in [1], users might think
> of "git grep $rev $pat" as an optimized version of "git checkout $rev
> && git grep $pat". And, in this sense, they probably expect the output
> of these two operations to be equal. But if we don't set the
> SKIP_WORKTREE bit for submodules they might diverge.
>
> As an example, if we have a repository like:
> .
> |-- A
> |   `-- sub
> `-- B
>
> And the [cone-mode] sparsity rules:
> /*
> !/*/
> /B/
>
> Then, "git grep --recurse-submodules $rev $pat" would search only in B
> (as A doesn't match the sparsity patterns and thus, is not recursed
> into). But "git checkout $rev && git grep --recurse-submodules $pat"
> would search in both B and A/sub (as the latter would not have the
> SKIP_WORKTREE bit set).
>
> This might be a problem for git-grep, not git-sparse-checkout. But I'm
> not sure how we could solve it efficiently, as the submodule might be
> deep down in a path whose first dir was already ignored for not
> matching the sparsity patterns. Is this a problem we should consider,
> or is it OK if the outputs of these two operations diverge?

You always have an eagle eye for catching these things.  Good point.

So, ignoring submodules for a second... In the case of unmerged files
that do not match the sparsity patterns, we previously felt it was
fine that
    git grep $revision $pattern
won't search through $revision:${currently_unmerged_file} despite the fact that
    git grep $pattern
will search through ${currently_unmerged_file} from the working directory.

If we follow that analogy, then we're fine having those two "almost
command equivalents" diverge.

Let's dig a little further anyway and compare these "almost command
equivalents" a bit more, which as a reminder are (1) "git grep
--recurse-submodules $rev $pat" vs. (2) "git checkout $rev && git grep
--recurse-submodules $pat".  (I just wanted to give them simple
numerical labels.)  In all cases, we'll be considering a $FILENAME
which does not match sparsity patterns but is present in the working
directory for reasons listed below:

First case: $FILENAME has uncommitted changes:
(Command 1) This will search only through files in $REV that match
sparsity patterns; $REV:$FILENAME will be excluded
(Command 2) If $FILENAME is different between HEAD and $REV this fails
and shows nothing, even if other paths in the sparsity patterns had
matches.  Otherwise, it searches through $FILENAME.

If the command is modified to add a -m to the `git checkout` command
to make the checkout not fail, then the second command will always
search through $REV:$FILENAME, as modified by the dirty changes being
merged in.  If the user cleans up the file with uncommitted changes
first, then the checkout would make the file go away and thus it
wouldn't be searched after the switch.

Second case: $FILENAME has unmerged changes:
(Command 1) This will search through files in $REV that match sparsity
patterns; $REV:$FILENAME will be excluded.
(Command 2) This will always fail and show nothing, regardless of any
other matches.

Here the checkout command always fails due to the unmerged entries and
won't even allow the user to switch with -m.

So, my comparison of commands #1 and #2 isn't quite right, even for
non-submodule cases.  But let's dig a little further.  If someone were
to try do change their sparsity patterns or even just run a "git
sparse-checkout reapply" when they had the above issues, they'd see
something like:

    $ git sparse-checkout reapply
    warning: The following paths are unmerged and were left despite
sparse patterns:
            filename_with_conflicts

    After fixing the above paths, you may want to run `git
sparse-checkout reapply`.

This basically suggests that we consider uncommitted and unmerged
files to be "unclean" in some way (sparse-checkout wants to set the
SKIP_WORKTREE bit on all files that do not match the sparsity
specification, so "clean" means sparse-checkout is able to do so).  So
I could amend my earlier comparison and say that IF the user has a
clean directory, then "git grep --recurse-submodules $REVISION
$PATTERN" should be equivalent to "git checkout $REVISION && git grep
--recurse-submodules $PATTERN".  I could also say that given the big
warnings we give users when we can't set the SKIP_WORKTREE bit, that
we expect it to be a transient state and thus that we expect them to
more likely than not clear it out by the time they do switch branches.
That would lead us to the follow-up rule that if the user does not
have a clean directory then "git grep --recurse-submodules $REVISION
$PATTERN" should be equivalent to what you would get if the unclean
entries were ignored (expecting them to be cleaned before the any `git
checkout` could be run) and you then otherwise ran "git checkout
$REVISION && git grep --recurse-submodules $PATTERN".

That suggests that grep's implementation we agreed on earlier is still
correct (when given a $REVISION ignore submodulees that do not match
the sparsity patterns), but that unpack-trees/sparse-checkout still
need an update:

When we notice an initialized submodule that does not match the
sparsity patterns, we should print a warning just like we do for
unmerged and dirty entries.

So my patch needs a bit more work.
