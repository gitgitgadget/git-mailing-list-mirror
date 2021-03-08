Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69902C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7AB65275
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 22:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCHWOG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 17:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhCHWOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 17:14:06 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6DCC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 14:14:05 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f33so10805261otf.11
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 14:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JKC5lIHLENBBNFV3LX/hxipC9gDHOL/1aFYN9XLDKyQ=;
        b=PEhopogetJG+q0OiJhz8IdiDSbfeyBaSHVeU1u8Yof4QEvoPmHC10Pl2be4glLzukk
         +JvDhgwEFqhefW91587vQGLF5xtjMtFGgTDIlfye70dTOTZWk8Gv00ocTPgUFiZiMYL5
         jN1oOWY0Hor0w1AY1UvADvAfa8V/OgShw9pLX6ORDm/dF7XGiFpnbysDvGuVmCyR9Ixh
         jjAq5oSsEv8MV6+E34cS+3DkAhx976yej4KE980f7zay1jvcMSD/x3K0zBkAJmikbSog
         pC2B3NE02xUMf05nFSYQmv2qTicKucEnwKKY3U1g393WGEw/Z8oEx0bnS3scCOTvphX5
         ePTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JKC5lIHLENBBNFV3LX/hxipC9gDHOL/1aFYN9XLDKyQ=;
        b=FJj4mC8x70M+xGDCASf5oNQrN2v+PTO8mxLwAUPhOqnJnSaYDlKs6o2/aRmr99SBmu
         uI/te3L4VaO8ghksCZxRWrBxOifY1rUVqblsGrsqvyaDozLgg2BcyMlJ0HxgAynISoMa
         r5RFBCsB3GvT+7tymwgsWue3qEJiihq70HdkvqbyqCLeX6l8KtUngQu4R9t6QOAsHppU
         Kp3at1fn8JaF7RaEivQRPTyL4/YbpC3fJ4mgiRt7GdJ2MHJ/LtSCb1h7fH1hr3JcNTQG
         TJpGdS0diFD0KoEtjGdjMSH7jGfUWQv49aYjLctR1LbxNxJbuIBk6/oafKXu/gAAGzBc
         PvQg==
X-Gm-Message-State: AOAM530wyMgNbjo24vgvwB8QifzWZCitXEIDK4HyQfhZ1P2sffdrAm9e
        M4PboyYXNtpWZnx9hMQeIg4KXzPSy6WUK542Jj0=
X-Google-Smtp-Source: ABdhPJxyq+C58+3T7djA7OJQP2lruyQ6sAIWatY/oig16rLJcY2SBM1d9KyMMRTmqYq0ls/4NQY25xXgM2KBb4tVqWQ=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr2875004otf.162.1615241645070;
 Mon, 08 Mar 2021 14:14:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com> <87pn09iu3j.fsf@evledraar.gmail.com>
In-Reply-To: <87pn09iu3j.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 Mar 2021 14:13:53 -0800
Message-ID: <CABPp-BHeR6m4-M=nSX5NZtA2js3E3EVbAyDSMtp3-rN2QnUjqw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Complete merge-ort implementation...almost
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 8, 2021 at 6:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:
>
> > In order to help =C3=86var test his tree-walk changes against merge-ort=
[1], this
> > series completes the merge-ort implementation and cleans up testsuite
> > failures...EXCEPT for some t6423 failures. It also leaves out a lot of
> > performance work, which incidentally will fix the t6423 failures and is
> > being reviewed independently[2].
>
> For those testing this in combination with their work, the expected
> failures are these specific tests:
>
>     ./t6423-merge-rename-directories.sh (Wstat: 256 Tests: 68 Failed: 4)
>       Failed tests:  7, 53, 55, 59
>
> Perhaps I'm missing something but why not have [1] below on top of this
> series? It makes that test pass in both modes, and means we could
> e.g. follow-up by running CI with "ort".
>
> That CI step seems worth doing sooner than later, even if it needs some
> GIT_TEST_SKIP for now...

Oh, um, mostly it was history and the fact that I just never took a
step back.  When I started adding merge-ort, there were 2200+ tests
that were failing, and marking them all as test_expect_fail was just a
useless code churn; we knew it'd fail when the implemenation basically
just called die().  At some point I got it down to 8 tests failing,
but felt I needed to quickly switch tracks to upstream the
diffcore-rename work since we had an Outreachy intern that was going
to be buildiing on it and/or making changes that might conflict with
it.  I was still in the mode of fixing them through completing the
implementation rather than stepping back and saying, "Hey, we only
have a few tests left failing; let's mark them as such.".

However, all that said, making this change _now_ would semantically
conflict with ort-perf-batch-9[1] (which was submitted first), since
it fixes one of the four tests.  It'd also mean a similar semantic
conflict for ort-perf-batch-10 (which fixes another) and
ort-perf-batch-12 (which fixes the last 2), or those series will have
to depend on a merge of ort-perf-batch-9 and this series.  Relying on
special merges for some of the earlier patches for merge-ort seems
like it was a bit of a pain and I'd rather not put Junio through that.
Also, if we do it, and don't have Junio mark the fixes as things are
merged, then we have to decide on a topic order.  So, Junio: thoughts?

[1] https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.=
com/

> > This 11-patch series could be submitted as 7 independent series, 1-4 pa=
tches
> > in length each, but it's probably easier for =C3=86var if we can merge =
just one
> > more thing and it's only 11 total patches. This series sub-divides as
> > follows:
> >
> >  * Patch 1: Fix bug in already-merged portion of merge-ort affecting
> >    rename/rename conflicts on platforms where qsort isn't stable. (Coul=
d be
> >    considered for merging before 2.31 since it is a new bug in the 2.31
> >    cycle that I just learned of last night, but not sure it matters sin=
ce
> >    merge-ort wasn't complete anyway and we're not even mentioning merge=
-ort
> >    in the release notes.)
> >  * Patches 2-5: Add support for renormalization
> >  * Patch 6: Add support for subtree shifting
> >  * Patch 7-8: Add test and support for conflicts affecting sparse-check=
out
> >    entries
> >  * Patch 9: Update submodule related merge tests to note the ones that
> >    merge-ort fixes relative to merge-recursive
> >  * Patch 10: New feature -- allow "git diff AUTO_MERGE" during conflict
> >    resolution to let user review changes they made since
> >    merge/rebase/cherry-pick/revert stopped and informed them of conflic=
ts
> >  * Patch 11: Add comments noting various bugs in merge-recursive
> >
> > The last two patches aren't needed by =C3=86var, so they could be left =
out and
> > submitted later. I just figured that it was only two more patches and t=
hey
> > were part of "completing the merge-ort implementation" in my view.
>
> This whole thing was a pleasant read, and helped me catch a subtle
> regression in my WIP "mode" work (which I'm now about to submit).

Wahoo for helping catch regressions!  :-)

> Reviewing this series suffered from the problem you have with writing
> code that's clearly good enough: Mostly all I had were minor nits,
> suggestions to re-arrange code differently etc.

Thanks for taking a look.  You had lots of good small suggestions that
I'll incorporate in a re-roll.  There were a couple that sounded like
they should be split off into their own sets of cleanup patches that
I'll defer for now.

> That being said I'm not all that familiar with the guts of the merge
> logic, so I may have missed other issues...

>
> > [1] https://lore.kernel.org/git/877dmmkhnt.fsf@evledraar.gmail.com/ [2]=
 See
> > https://lore.kernel.org/git/pull.845.git.1614484707.gitgitgadget@gmail.=
com/;
> > there are five more waiting after that -- viewable by the curious at
> > https://github.com/gitgitgadget/git/pulls?q=3Dis%3Apr+author%3Anewren+O=
ptimization+batch
> >
> > Elijah Newren (11):
> >   merge-ort: use STABLE_QSORT instead of QSORT where required
> >   merge-ort: add a special minimal index just for renormalization
> >   merge-ort: add a function for initializing our special attr_index
> >   merge-ort: have ll_merge() calls use the attr_index for
> >     renormalization
> >   merge-ort: let renormalization change modify/delete into clean delete
> >   merge-ort: support subtree shifting
> >   t6428: new test for SKIP_WORKTREE handling and conflicts
> >   merge-ort: implement CE_SKIP_WORKTREE handling with conflicted entrie=
s
> >   t: mark several submodule merging tests as fixed under merge-ort
> >   merge-ort: write $GIT_DIR/AUTO_MERGE whenever we hit a conflict
> >   merge-recursive: add a bunch of FIXME comments documenting known bugs
> >
> >  branch.c                                      |   1 +
> >  builtin/rebase.c                              |   1 +
> >  merge-ort.c                                   | 230 ++++++++++++++++--
> >  merge-recursive.c                             |  37 +++
> >  path.c                                        |   1 +
> >  path.h                                        |   2 +
> >  sequencer.c                                   |   5 +
> >  t/t3512-cherry-pick-submodule.sh              |   9 +-
> >  t/t3513-revert-submodule.sh                   |   7 +-
> >  t/t5572-pull-submodule.sh                     |   9 +-
> >  t/t6428-merge-conflicts-sparse.sh             | 158 ++++++++++++
> >  t/t6437-submodule-merge.sh                    |   5 +-
> >  t/t6438-submodule-directory-file-conflicts.sh |   9 +-
> >  13 files changed, 449 insertions(+), 25 deletions(-)
> >  create mode 100755 t/t6428-merge-conflicts-sparse.sh
> >
> >
> > base-commit: f01623b2c9d14207e497b21ebc6b3ec4afaf4b46
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-9=
73%2Fnewren%2Fort-remainder-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-973/=
newren/ort-remainder-v1
> > Pull-Request: https://github.com/git/git/pull/973
>
> 1.:
>
> diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-d=
irectories.sh
> index 5d3b711fe68..4f6ead11e51 100755
> --- a/t/t6423-merge-rename-directories.sh
> +++ b/t/t6423-merge-rename-directories.sh
> @@ -507,7 +507,7 @@ test_setup_2a () {
>         )
>  }
>
> -test_expect_success '2a: Directory split into two on one side, with equa=
l numbers of paths' '
> +test_expect_merge_algorithm success failure '2a: Directory split into tw=
o on one side, with equal numbers of paths' '
>         test_setup_2a &&
>         (
>                 cd 2a &&
> @@ -3060,7 +3060,7 @@ test_setup_9g () {
>         )
>  }
>
> -test_expect_failure '9g: Renamed directory that only contained immediate=
 subdirs, immediate subdirs renamed' '
> +test_expect_merge_algorithm failure failure '9g: Renamed directory that =
only contained immediate subdirs, immediate subdirs renamed' '
>         test_setup_9g &&
>         (
>                 cd 9g &&
> @@ -4267,7 +4267,7 @@ test_setup_12b1 () {
>         )
>  }
>
> -test_expect_merge_algorithm failure success '12b1: Moving two directory =
hierarchies into each other' '
> +test_expect_merge_algorithm failure failure '12b1: Moving two directory =
hierarchies into each other' '
>         test_setup_12b1 &&
>         (
>                 cd 12b1 &&
> @@ -4435,7 +4435,7 @@ test_setup_12c1 () {
>         )
>  }
>
> -test_expect_merge_algorithm failure success '12c1: Moving one directory =
hierarchy into another w/ content merge' '
> +test_expect_merge_algorithm failure failure '12c1: Moving one directory =
hierarchy into another w/ content merge' '
>         test_setup_12c1 &&
>         (
>                 cd 12c1 &&
> @@ -4797,7 +4797,7 @@ test_setup_12f () {
>         )
>  }
>
> -test_expect_merge_algorithm failure success '12f: Trivial directory reso=
lve, caching, all kinds of fun' '
> +test_expect_merge_algorithm failure failure '12f: Trivial directory reso=
lve, caching, all kinds of fun' '
>         test_setup_12f &&
>         (
>                 cd 12f &&
