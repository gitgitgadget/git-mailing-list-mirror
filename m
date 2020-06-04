Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E5C433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2292064C
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 15:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQOq2LcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgFDPFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgFDPFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 11:05:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF5C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 08:05:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j189so5328087oih.10
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ek8rw2RIrTlQmC/6Kyx65MMgnizYWAAEpMthRx0WLkQ=;
        b=NQOq2LcBPaAENCj16SeU2oq4v13/USa/eH3dIl1Zl27IfkyHwfBAC7ay5cKxUe/Xcu
         JoHYWayJzVp7QyDkQWLjYv7/AXXMSHW/ILxwao8owWk0KsnnW14GiD+kpugdAXCOq/xc
         Kr3MJl1fbLPWfVSJznn7mEiG2Y+2w1GytWI/quzrTp1T0SnT3l1eu7Z8qJ8zBRk7B/80
         roulEYjte8wg5JzuoNaNV4cCADxmqy4oTUqTZ3OFhB803BXaJtz0V448HczPf9jUdBBX
         bXb92dr69Vynwqi5zQXdohLVjVlw6eG8/6zU+2tmjtSlQuwr/Ehe1ZtnuoyeP7VNUxTu
         c0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ek8rw2RIrTlQmC/6Kyx65MMgnizYWAAEpMthRx0WLkQ=;
        b=PnHcDu+OVhRTqBODQZMsyOQa7DXDeXuncpfXWKCmj2x2yyiUQIBgq5b7DW+Z3nlegE
         cHJSfr6V+rp9b8TBIhy9FeavYVTDVuMwjyF8PDzt2bHU25Y825jsNXcKh4cBAtAahLao
         1JwzN4IunrsNeRjw+TpVEFL9pNaTnXOqg5KCZw5iL6nOOlRgSsmfw+BqKnK3fXhpNL+S
         s66rdlJYZxEwjCIviAWKz+GIfLqmm9/MrPOnC0lKYmW5wtG6WgZ/cQzjkmIfsyAvVbWy
         rrROteNuu+nu4AHR9W+VB6Fc7hPQKVEwQPWAhR1X7K3bfVB7na+76btP7SIFL9cYkQvs
         9ErQ==
X-Gm-Message-State: AOAM531SZqf5bhjJeRb+hmNR9S06o9Sfs1pPRzLil7VnFrtfFrK1NdZq
        OZ+93EMYMl+y1xn20JBZ2QUgnsJSnPvoXHtivyKNnpGq
X-Google-Smtp-Source: ABdhPJw7RuQd466THKA9Cc5vt2ADjK6NZwk0oiEqxr2dpZLNlll12OtMjji0y8rsrozko8TWKbJRl5hX6CR3ZZqXOrc=
X-Received: by 2002:aca:3f44:: with SMTP id m65mr3544257oia.167.1591283117619;
 Thu, 04 Jun 2020 08:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.801.git.git.1591258657818.gitgitgadget@gmail.com> <7c34da8e-87b8-5236-4536-4d8fbc3f1e80@gmail.com>
In-Reply-To: <7c34da8e-87b8-5236-4536-4d8fbc3f1e80@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 4 Jun 2020 08:05:06 -0700
Message-ID: <CABPp-BFmFd7gxN7cd04GFD9kCFEMbfXdv7dHCYRB4z21AUpZWQ@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: avoid staging deletions of all files
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Shaun Case <warmsocks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 4, 2020 at 7:48 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/4/2020 4:17 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > sparse-checkout's purpose is to update the working tree to have it
> > reflect a subset of the tracked files.  As such, it shouldn't be
> > switching branches, making commits, downloading or uploading data, or
> > staging or unstaging changes.  Other than updating the worktree, the
> > only thing sparse-checkout should touch is the SKIP_WORKTREE bit of the
> > index.  In particular, this sets up a nice invariant: running
> > sparse-checkout will never change the status of any file in `git status`
> > (reflecting the fact that we only set the SKIP_WORKTREE bit if the file
> > is safe to delete, i.e. if the file is unmodified).
> >
> > Traditionally, we did a _really_ bad job with this goal.  The
> > predecessor to sparse-checkout involved manual editing of
> > .git/info/sparse-checkout and running `git read-tree -mu HEAD`.  That
> > command would stage and unstage changes and overwrite dirty changes in
> > the working tree.
> >
> > The initial implementation of the sparse-checkout command was no better;
> > it simply invoked `git read-tree -mu HEAD` as a subprocess and had the
> > same caveats, though this issue came up repeatedly in review comments
> > and workarounds for the problems were put in place before the feature
> > was merged[1, 2, 3, 4, 5, 6; especially see 4 & 6].
> >
> > [1] https://lore.kernel.org/git/CABPp-BFT9A5n=_bx5LsjCvbogqwSjiwgr5amcjgbU1iAk4KLJg@mail.gmail.com/
> > [2] https://lore.kernel.org/git/CABPp-BEmwSwg4tgJg6nVG8a3Hpn_g-=ZjApZF4EiJO+qVgu4uw@mail.gmail.com/
> > [3] https://lore.kernel.org/git/CABPp-BFV7TA0qwZCQpHCqx9N+JifyRyuBQ-pZ_oGfe-NOgyh7A@mail.gmail.com/
> > [4] https://lore.kernel.org/git/CABPp-BHYCCD+Vx5fq35jH82eHc1-P53Lz_aGNpHJNcx9kg2K-A@mail.gmail.com/
> > [5] https://lore.kernel.org/git/CABPp-BF+JWYZfDqp2Tn4AEKVp4b0YMA=Mbz4Nz62D-gGgiduYQ@mail.gmail.com/
> > [6] https://lore.kernel.org/git/20191121163706.GV23183@szeder.dev/
> >
> > However, these workarounds, in addition to disabling the feature in a
> > number of important cases, also missed one special case.  I'll get back
> > to it later.
> >
> > In the 2.27.0 cycle, the disabling of the feature was lifted by finally
> > replacing the internal equivalent of `git read-tree -mu HEAD` with
> > something that did what we wanted: the new update_sparsity() function in
> > unpack-trees.c that only ever updates SKIP_WORKTREE bits in the index
> > and updates the working tree to match.  This new function handles all
> > the cases that were problematic for the old implementation, except that
> > it breaks the same special case that avoided the workarounds of the old
> > implementation, but broke it in a different way.
> >
> > So...that brings us to the special case: a git clone performed with
> > --no-checkout.  As per the meaning of the flag, --no-checkout does not
> > check out any branch, with the implication that you aren't on one and
> > need to switch to one after the clone.  Implementationally, HEAD is
> > still set (so in some sense you are partially on a branch), but
> >   * the index is "unborn" (non-existent)
> >   * there are no files in the working tree (other than .git/)
> >   * the next time git switch (or git checkout) is run it will run
> >     unpack_trees with `initial_checkout` flag set to true.
> > It is not until you run, e.g. `git switch <somebranch>` that the index
> > will be written and files in the working tree populated.
> >
> > With this special --no-checkout case, the traditional `read-tree -mu
> > HEAD` behavior would have done the equivalent of acting like checkout --
> > switch to the default branch (HEAD), write out an index that matches
> > HEAD, and update the working tree to match.  This special case slipped
> > through the avoid-making-changes checks in the original sparse-checkout
> > command and thus continued there.
> >
> > After update_sparsity() was introduced and used (see commit f56f31af03
> > ("sparse-checkout: use new update_sparsity() function", 2020-03-27)),
> > the behavior for the --no-checkout case changed:  Due to git's
> > auto-vivification of an empty in-memory index (see do_read_index() and
> > note that `must_exist` is false), and due to sparse-checkout's
> > update_working_directory() code to always write out the index after it
> > was done, we got a new bug.  That made it so that sparse-checkout would
> > switch the repository from a clone with an "unborn" index (i.e. still
> > needing an initial_checkout), to one that had a recorded index with no
> > entries.  Thus, instead of all the files appearing deleted in `git
> > status` being known to git as a special artifact of not yet being on a
> > branch, our recording of an empty index made it suddenly look to git as
> > though it was definitely on a branch with ALL files staged for deletion!
> > A subsequent checkout or switch then had to contend with the fact that
> > it wasn't on an initial_checkout but had a bunch of staged deletions.
>
> Thank you for the detailed summary of how we got to this point and
> what is going on. When I asked you to look into this, I did ask for
> you to spend "less than an hour" only because I hoped the fix would
> be easy. Clearly, there are a lot of things going on here, but you
> seem to have a firm grasp on everything.
>
> > Make sure that sparse-checkout changes nothing in the index other than
> > the SKIP_WORKTREE bit; in particular, when the index is unborn we do not
> > have any branch checked out so there is no sparsification or
> > de-sparsification work to do.  Simply return from
> > update_working_directory() early.
>
> This makes sense to me. The sparse-checkout file will still be
> modified, so when the user performs a checkout then Git will
> respect the set patterns. Your test confirms this, too!
>
> I think this behavior is a reasonable compromise from the
> previous behavior and being as correct as possible now. Before,
> the "git read-tree -mu HEAD" portion of "git sparse-chekcout set"
> would populate the working directory, and now it will not.
> This more closely matches how a user interacts with --no-checkout
> in the non-sparse case.
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     sparse-checkout: avoid staging deletions of all files
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-801%2Fnewren%2Fsparse-checkout-and-unborn-index-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-801/newren/sparse-checkout-and-unborn-index-v1
> > Pull-Request: https://github.com/git/git/pull/801
> >
> >  builtin/sparse-checkout.c          |  4 ++++
> >  t/t1091-sparse-checkout-builtin.sh | 19 +++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 95d08824172..595463be68e 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -99,6 +99,10 @@ static int update_working_directory(struct pattern_list *pl)
> >       struct lock_file lock_file = LOCK_INIT;
> >       struct repository *r = the_repository;
> >
> > +     /* If no branch has been checked out, there are no updates to make. */
> > +     if (is_index_unborn(r->index))
> > +             return UPDATE_SPARSITY_SUCCESS;
> > +
> >       memset(&o, 0, sizeof(o));
> >       o.verbose_update = isatty(2);
> >       o.update = 1;
> > diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> > index 88cdde255cd..bc287e5c1fa 100755
> > --- a/t/t1091-sparse-checkout-builtin.sh
> > +++ b/t/t1091-sparse-checkout-builtin.sh
> > @@ -100,6 +100,25 @@ test_expect_success 'clone --sparse' '
> >       check_files clone a
> >  '
> >
> > +test_expect_success 'interaction with clone --no-checkout (unborn index)' '
> > +     git clone --no-checkout "file://$(pwd)/repo" clone_no_checkout &&
> > +     git -C clone_no_checkout sparse-checkout init --cone &&
> > +     git -C clone_no_checkout sparse-checkout set folder1 &&
> > +     git -C clone_no_checkout sparse-checkout list >actual &&
> > +     cat >expect <<-\EOF &&
> > +     folder1
> > +     EOF
> > +     test_cmp expect actual &&
> > +     ls clone_no_checkout >actual &&
> > +     test_must_be_empty actual &&
>
> My only comment on the test case is to see if you could use
> the "check_files" macro instead of "ls". See 761e3d26
> (sparse-checkout: improve OS ls compatibility, 2019-12-20)
> for details.

I attempted to do so initially, but that function fails badly when
there are no files (other than the "hidden" files '.git', '.', and
'..') in the directory.  The reason for this comes from the "printf
'%s\n' *" -- the glob won't match anything and so it prints a literal
asterisk, which is not helpful.

I thought about writing an asterisk out to the expected file for
comparison, but that just made the testcase look confusing.  It was a
lot cleaner to just use ls with no glob coupled with
test_must_be_empty.

> > +     test_path_is_missing clone_no_checkout/.git/index &&
> > +
> > +     # No branch is checked out until we manually switch to one
> > +     git -C clone_no_checkout switch master &&
> > +     test_path_is_file clone_no_checkout/.git/index &&
> > +     check_files clone_no_checkout a folder1

However, when I did have files in the directory, then I used your
check_files function as seen here.  :-)


Does that make sense, or is there a better alternative?
