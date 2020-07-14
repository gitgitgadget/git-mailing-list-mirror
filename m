Return-Path: <SRS0=b2TE=AZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A3EC433DF
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 05:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97340221EB
	for <git@archiver.kernel.org>; Tue, 14 Jul 2020 05:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnMThJQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgGNFqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgGNFqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 01:46:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F72EC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 22:46:11 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id x83so13007640oif.10
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5lU61zzROiAYrB7axITLAiNdWTKDWw5PvnPgvPOxML4=;
        b=DnMThJQmhP0JOp/WYd3//NQny/osdq549pY/jvcXHk8ZhImFFqi8S3AlGIW1m+ornL
         vJzZim7s+uf/obPY2ZupGnMcC3bXOq59MMFhsaUEP2hl0+z3qKqwOqp//ZwAx0tuJker
         YXwW8SQYnnPewIneH64rNlPs9gk1OmOhAATWAF+oZIDuodr5nFLfN1B+b0waNvq80GF6
         3zvfnSX8qp8+1aYBSQ8O4di+9yC1EfLm0uUfTgNTFpHq0BQ9ZRRenBsekZR+Aqc6R+4C
         rDr+g4NA6WROvmnEM9CRdUPwfVe8VRZ4U15MK7aMQUkCjAvskY0hXmrCZAXQy64+AcbL
         OU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5lU61zzROiAYrB7axITLAiNdWTKDWw5PvnPgvPOxML4=;
        b=hObngoOPpNHcvJIJlxivWzGDabhEQDv8Ie4X6BAzJTMQjNEMgq5LxzyN5r3Eqp2zlr
         NcUVzKuGS5PAVOLbe/Ys6YjPXT+a7InrbjQ1U1AQrp2pBuM7KAdyAtik20PlfUol1tt6
         j45M1YDj8vOrpnDVhiG01rTUqKa93cVvpvvCab8m3Zwn55ERXLaSrfU1ISX2EOsj3mAL
         6BTbeUF746GoSSJT4kgbJq22WHEsYb9rEFTLbae3Hfx6v4/4jr4fVMuzbPFWejUhj0q6
         NSEMQ5GigBiL9+ZFsR/6cYKwz63u2jYNKHEYqXEHL3f3AOrcvNmJn1bmHNblcS2rjLCV
         FwYQ==
X-Gm-Message-State: AOAM533OvYn1wPdi0kuTlsAokpNfZ5XAdDsH4ljolpyBd8vr5Bz91/AO
        HTDIsaoWkFQTrT7POOtYiXqIufu0QphgZ5MSo9E=
X-Google-Smtp-Source: ABdhPJyNkodNcezky4ri27SkXRsRRHdxFLARwwY10vRN9l+7l6CGi+QdGZw1rdivofH34yNQHkE+DqpHygQYLsGEWvY=
X-Received: by 2002:aca:3dd7:: with SMTP id k206mr2333638oia.31.1594705569471;
 Mon, 13 Jul 2020 22:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <7A30EA48-72E3-47E1-9792-136D7B96DC84@gmail.com>
 <CABPp-BEu=7xSLk5AE8sQX+S-vvYXxgn+avQ8+9ttdSKDjikb9w@mail.gmail.com> <D99E27A0-04BC-40B7-A073-66E1301FFE5D@gmail.com>
In-Reply-To: <D99E27A0-04BC-40B7-A073-66E1301FFE5D@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Jul 2020 23:45:59 -0600
Message-ID: <CABPp-BGrSYHzf0oLHUPJOz0XQ5sSV-kXxvVAdxjuR2rVsd4oBA@mail.gmail.com>
Subject: Re: rebase - "fixup!" conflict applied at the wrong code location,
 why ?
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, Jul 13, 2020 at 8:42 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Elijah,
>
> > Le 9 juil. 2020 =C3=A0 00:07, Elijah Newren <newren@gmail.com> a =C3=A9=
crit :
> >
> > On Wed, Jul 8, 2020 at 5:07 PM Philippe Blain
> > <levraiphilippeblain@gmail.com> wrote:
> >>
> >> Hello,
> >>
> >> I've been working on a branch for a while. I've been using `git commit=
 --fixup`  and `git commit --squash`
> >> when I noticed that I had forgotten to add something to a previous com=
mit.
> >> Today I did `git rebase --autosquash` to clean up my history, and the =
rebase failed at the
> >> first 'fixup!' commit with a conflict. However, the conflict is not lo=
cated at the right place
> >> in the code (it's not in the right subroutine!). This is very surprisi=
ng to me, and I would
> >> like to understand why it happens.
> >>
> >> Steps to reproduce:
> >>
> >> git clone -b branch-to-be-rebased https://github.com/phil-blain/CICE.g=
it cice
> >> cd cice
> >> git rebase -i --autosquash my-first-commit
> >> # save the todo list without modifications
> >>  Auto-merging <file>
> >>  CONFLICT (content): Merge conflict in <file>
> >>  error: could not apply e8bfa55... fixup! <commit message of f4e1ae6>
> >> # the rebase stops at f4e1ae6
> >> git diff
> >> # tangential question : for some reason the hunk header does not appea=
r here, I don't know why...
> >> git diff -2  # but it appears here
> >> git grep -p -e '<<<<<<< HEAD' -e '>>>>>>> e8bfa55...'  # or here
> >> # ok, the conflict appears in subroutine 'picard_solver'
> >> git show REBASE_HEAD -U5
> >> # but the original "fixup!" commit only modifies the subroutine 'ander=
son_solver' !!
> >>
> >> I would have expected that the conflict be created around lines 1118-1=
132
> >> (line numbers in f4e1ae6), in the 'anderson_solver' subroutine.
> >>
> >> I don't know if this plays a part here, but commit f4e1ae6 (where the =
rebase stops)
> >> is the commit where the 'anderson_solver' subroutine is added to the c=
ode...
> >>
> >> Thanks,
> >>
> >> Philippe.
> >
> > If you take a look where the rebase stops, you see:
>
> First, thanks a lot for your answer. I have a few questions.
>
> >
> > $ git ls-files -u
> > 100644 ee4377f1ec6836fa05573976a473373906c37d9f 1
> > cicecore/cicedynB/dynamics/ice_dyn_vp.F90
> > 100644 30c699ac371c2a751052fa98d04317e84a96ec47 2
> > cicecore/cicedynB/dynamics/ice_dyn_vp.F90
> > 100644 276f224e9048fe0bbd7c25822695049547362c87 3
> > cicecore/cicedynB/dynamics/ice_dyn_vp.F90
> >
> > The difference from the merge base to "other" (index 3) is pretty
> > tiny, you just moved one line in the "anderson_solver" subroutine
> > about 10 lines down.
>
> Yes, the output from
> $ git diff :1:cicecore/cicedynB/dynamics/ice_dyn_vp.F90 :3:cicecore/ciced=
ynB/dynamics/ice_dyn_vp.F90
>
> seems to be the same as the one from
> $ git show REBASE_HEAD
>
> This is a little confusing to me, in the sense that I don't understand wh=
y
> the merge-base is what it is. At this point, I do
>
> $ git merge-base HEAD REBASE_HEAD
> f4e1ae67b7d6ca36c6f3ea7c9da43d81caf24067
>
> Ok, so 'git merge-base' finds that the merge-base between HEAD and
> REBASE_HEAD is HEAD; this makes sense to me (no previous commits
> have been rewritten so far, so REBASE_HEAD is directly ahead of HEAD).
> But, if I try to find the commit that contains
> the blob ee4377f1ec6836fa05573976a473373906c37d9f (index 1), I find
> REBASE_HEAD's parent:
>
> $ git log --all --find-object=3Dee4377f1ec6836fa05573976a473373906c37d9f =
--format=3D'commmit %H%ntree %T%nparent %P%n%n    %s%n'
> commmit e8bfa557d3c81b75116d6557784b0439b792a308
> tree f6fecb8193c3b877f22bcb8f4d8d2c203e17f06f
> parent 7a8d5a82984dfedd7fac1d7ed7c7fbd1781c1f61
>
>     fixup! Add Anderson acceleration for Picard iteration
>
> commmit 7a8d5a82984dfedd7fac1d7ed7c7fbd1781c1f61
> tree 11fd096851015c0c16b793d9bbb5db039776483b
> parent 63d4c73c1dd973f620307833bd363a1d5069d090
>
>     ice_dyn_vp: introduce 'CICE_USE_LAPACK' preprocessor macro
>
> $ blob=3Dee4377f1ec6836fa05573976a473373906c37d9f
> $ parent=3D7a8d5a82984dfedd7fac1d7ed7c7fbd1781c1f61
> $ git ls-tree -r $parent^{tree} | grep $blob
> 100644 blob ee4377f1ec6836fa05573976a473373906c37d9f    cicecore/cicedynB=
/dynamics/ice_dyn_vp.F90
>
> I don't understand why at this point of the rebase, Git
> determines that the merge-base between HEAD and
> REBASE_HEAD is REBASE_HEAD's parent... this commit
> is not even an ancestor of HEAD (or maybe I don't understand
> what the "merge-base" is in this context?)...

First, remember that this is a rebase or cherry-pick, and not a merge
(we are not creating a new merge commit, but just a commit that
"cherry-picks" the changes from one commit).  But since the wording
and the machinery comes from a merge, let's start by discussing how
merge works.

When you merge two branches (e.g. 'git merge other' will merge branch
'other' into HEAD), git determines the merge-base, i.e. the point of
common history between two commits.  For simplicity, let's assume
there is a common point of history and exactly one common point of
history for these two commits.  Given these assumptions, we have a
merge-base and two commits.  Let's label the merge-base as A, the
commit at HEAD 'B', and the commit at 'other', 'C'.  So we are doing a
three-way merge between A, B, and C.

The thing about a three-way merge is besides thinking of it as a
three-way merge of A, B, and C, there are two other equivalent ways to
look at it: applying the changes between A and B to C, or applying the
changes between A and C to B.  These alternate ways of looking at
things come in handy when looking at rebases and cherry-picks.

When cherry-picking or rebasing a commit, we do NOT want to use the
normal merge-base of HEAD and the commit being picked; if we did that,
it would merge ALL the changes in the history of the commit being
picked into the current branch instead of just the changes from the
one commit we want to cherry-pick/rebase.  Noting that we only want
the changes from that one commit, we can word it similarly to above by
stating that we want to apply the changes between REBASE_HEAD^1 and
REBASE_HEAD to HEAD.  Looking at the above wording for three-way
merges ("applying the changes between A and C to B"), that means we
want to do a three-way merge of REBASE_HEAD^1, HEAD, and REBASE_HEAD.
And when we're done and create a new commit, we do not make a merge
commit but instead record HEAD as the only parent.  Hopefully, this
makes it clear why we use the parent of REBASE_HEAD as the
"merge-base" in the merge machinery; it's not really a "merge-base"
because we're not doing a merge, but we're using the merge machinery
with a special commit as the merge-base because it gives the results
we want.

Hope that helps,
Elijah
