Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B125C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 16:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbiBCQzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbiBCQzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 11:55:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06154C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 08:55:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u18so7204292edt.6
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 08:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zXjAQ4yMOWtowauN12aDQDDFO6pAn2t8VIbeBcZLLs=;
        b=Y0caM5zTs8MnOly/m6oYkxvaG85CeGvZVtR39qq2Kyc+DABlwAyUOC/yYWl19E/4GX
         6nSfYCBK8gneIEkQtPp1HN35KuovCQKYMHk9ohypj71jyw53M58i9jG3qqrj95Zfxm3I
         cvxpAIGJ0Ap/NZnxEI79njWsaZFv2r2A6j8iqTybPLZg7RktiqepnZ8jN3wFAtzsBa50
         mMNEkT3jbeNFYg0B8iXseUxAv6MXXFWyxHxIkg+KO9/Z0avMjTcAExA4sXCVVRTNY0yz
         xAhH2ay+5aBPsgtjbeyzIVh5HWy2JJWJ1d/7AUeta1bXWW0lEofA1lCC0VoQQyoz+LFo
         y1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zXjAQ4yMOWtowauN12aDQDDFO6pAn2t8VIbeBcZLLs=;
        b=z0h0qVpUu1Oo94+waJLQJalHZsGHBv1y4SzvQ/DlAYmOEHZ5+g5HVpkQHQ4jdy6H91
         y9G7HWPsJx3hubBdHgmSYYhpeHAFdT7UPYiV0C46z7WjutyjiwKMDsx0dTKz7PqvGOGt
         n1nHgihwKO5QzivcTbMCIF/YN3A3AxHTuwzKLj8E0a1Pdq0gw1j4ouLL6cU31jdPj2Yk
         S/scoRv99kW4j6KVTufU/xOshRYKQ+l++xX3JEm/Fnrxkee62agK2A5Va9WCOs5erDBD
         RInr8fTp8wnhKNGOlDQIwCYX6V06Oyi/cfiH/2j8JYlhnSzXislZOys4u1sK7YVr45Cb
         JzNA==
X-Gm-Message-State: AOAM530Wr3anq6xQSJYGAZT17Ajs8YQUTAAf3HBYC2IYWZOirHeb8eGF
        4z5WHB0XoQWPUCEOpd7mWfOY3JchUI5ayHtfXvA=
X-Google-Smtp-Source: ABdhPJyoW5qTb/v0DvbuM9Uhl/NlXRaYZySqs10pXAlISqYpaZZcPnx7xb3Y59lyT74EoPFYO/kMh9nW1lmDRoN3mO8=
X-Received: by 2002:a05:6402:350d:: with SMTP id b13mr36163729edd.192.1643907304515;
 Thu, 03 Feb 2022 08:55:04 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
 <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com> <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
 <xmqqy22tx8t1.fsf@gitster.g> <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
 <xmqqh79hvsgn.fsf@gitster.g> <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
 <20220203104241.yvfragan6ucecfjl@gmail.com>
In-Reply-To: <20220203104241.yvfragan6ucecfjl@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 08:54:52 -0800
Message-ID: <CABPp-BH_TiJaDpn2+VVjCb83NEFjL9teSk06+YiZyFGiTu8Lpg@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Feb 3, 2022 at 2:42 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
>
> On Wed, Feb 02, 2022 at 04:18:39PM -0800, Elijah Newren wrote:
> > On Wed, Feb 2, 2022 at 2:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Elijah Newren <newren@gmail.com> writes:
> > >
> > > > Yes, you are reading right.  I think the cherry-pick/rebase
> > > > replacement actually deserves a separate command from what merges
> > > > should use; replaying a sequence of commits just has a number of UI
> > > > differences and abilities that I think pull it in a different
> > > > direction.
> > >
> > > I completely disagree.  Each individual step in a sequence of
> > > replaying commits in order (or in reverse order) should be
> > > scriptable as a single merge-tree that takes "apply the change to go
> > > from A^ to A on X".  Sequencing and placing UI around it is a job
> > > for the script that drives merge-tree.
> >
> > Adding such an ability to merge-tree would be trivial -- it basically
> > involves just two things: (1) accepting one extra argument, and (2)
> > calling merge_incore_nonrecursive() instead of
> > merge_incore_recursive().
> >
> > However, I think forking a subprocess for every merge of a series of
> > commits is a completely unreasonable overhead, so even if we provide
> > such an option to merge-tree, I still want a separate plumbing-ish
> > tool that does non-worktree/non-index replaying of commits which is
> > not written as a driver of merge-tree.  That other tool should just
> > call merge_incore_nonrecursive() directly.  And such a tool, since it
> > should handle an arbitrary number of commits, should certainly be able
> > to handle just one commit.  From that angle, it feels like adding
> > another mode to merge-tree would just be a partial duplication of the
> > other tool.
>
> I wonder how the UI of a tool that does non-worktree/non-index cherry-picks
> will look like.  I'd expect it to produce the same output as merge-tree,
> except cherry-pick should probably output a commit OID, not a tree.
>
> Maybe we want a unified command that produces commits from any sequence of
> merge/cherry-pick/revert/reword steps. The obvious UI would use something
> like the rebase-todo list as input.  For example:
>
>         $ echo '
>         pick commit1
>         reword commit2  # edit commit message in $GIT_EDITOR
>         merge commit3 -m "log message"
>         ' | git create-commit commit0
>         <OID of final commit>
>
> we start from commit0 and apply steps one-by-one. Obviously, one unsolved
> problem is how to pass parameters like commit messages if no editor should
> be invoked (my sketch uses -m).
> If any of the steps fails when merging merge, then we get the tree with
> conflicts
>
>         $ echo '
>         pick commit1
>         pick commit2
>         pick commit-that-does-not-apply
>         ' | git create-commit commit0
>         <OID of commit after step 2>
>         <OID of toplevel tree after failed merge>
>         <Conflicted file info>
>         <Informational messages>
>
> Replaying a series of commits might look like this:
>
>         $ echo 'pick commit1 ^commit0' | git create-commit new-base
>
> I'm concluding that this is a difficult UI problem

I agree.  I've got a lot of thoughts on it, and some work in progress
towards it (https://github.com/newren/git/tree/replay -- _very_ hacky,
not even close to alpha quality, lots of fixup commits, todo comments,
random brain dump files added to the tree, based on a previous round
of this patch series, not updated for weeks, etc., etc.)

> and having a merge-tree
> command that accepts a "common ancestor" parameter could make it easier
> to experiment.  Of course that depends on who is experimenting.

I think that would result in experiments and eventually full-blown
scripts designed around forking subprocesses for every merge, and
pushes us back into the world of having a scripted-rebase again.  Yes,
I know people can transliterate shell back to C; it seems to always be
done as a half-way measure with the forking just being done from C or
have other UI-warts guided by the shell design.  In fact, *that* was
the primary reason for me not providing a merge-tree option based on
merge_incore_nonrecursive(), despite how trivial it'd be to provide
it.  If someone wanted a merge_incore_nonrecursive() mode for
merge-tree for reasons other than attempting to build a
rebase/cherry-pick replacement based on it, then I'd be much happier
to provide it.

If someone wants to experiment with what a plumbing-ish
rebase/cherry-pick would look like, the _right_ way to do it would be
making using of merge_incore_nonrecursive() directly.  If they want
example code, I already provided some a year and a half ago and got it
merged into git.git in the form of t/helper/test-fast-rebase.c.  My
"replay" branch is based on that code, but (a) moves it from t/helper
to a real builtin, (b) removes the hardcoded very strict input, (c)
removes the line of code doing the index & working tree updates, and
(d) modifies the output to be a more plumbing-ish style.

We'll certainly have discussions on what that should look like.  But a
plumbing-ish replacement for merge was much simpler, and made sense to
do first.  I would prefer to concentrate on getting that hammered down
first.  Then I'll start discussions on a plumbing-ish
rebase/cherry-pick.  And if that doesn't fulfill all the needs that
folks think they want out of merge-tree, then we can add a
merge_incore_nonrecursive()-based mode to merge-tree.  It's all
coming, but having fought transliterations-of-scripts in
merge-recursive.c, sequencer.c, stash.c, rebase.c, etc. for years I
really, really don't want any more of that.  Let's end that insanity.
