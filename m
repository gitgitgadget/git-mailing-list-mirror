Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D684C19F28
	for <git@archiver.kernel.org>; Sun, 31 Jul 2022 01:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGaBqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 21:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiGaBqM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 21:46:12 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E43E0BD
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 18:46:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o1so6217839qkg.9
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 18:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7GkaFAFhLBK7H9Qu7yCYvaSTrTJgQVDxyo/RKa+OffY=;
        b=m3KahSqr1zyVm3fCyv011nx3uC4N3QTuv2ZbbaEkTEYTpLYkG7HDkH6vC20HLmK0Xs
         D5EDIsINzrGd7Lo9Pw5+aI+6xr+MkT/17q+EkdqOOkyQzdjVCY7ID11kvFrkoGm+IGuj
         knQuzHeGkwgeUrRMpdSI17KIvaoGcoR70sysdmA3R/AAzvIuckfbdPYLLHIGK1yB7fgC
         p4N+gD5OOCjEmDpjXG7O0re+NQL7qsRiSHXPH8r7lz44w3D35P/oVtLERsztk4AxTyC4
         2NvYHm1BiaGdt6E8VJ67QGxcLnaFXRQPs7QzAlRbPSIUNletJCgNxjSvT2jbRWoKkbRr
         l7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7GkaFAFhLBK7H9Qu7yCYvaSTrTJgQVDxyo/RKa+OffY=;
        b=l0HJK2VwuhHlqorvRAuCT+AC5G06T2tJb1nX1mOqDnQEBeu0+3iriUCDqbSaYJnVYc
         /mkBgiPJg05IWO3g3448SOXRV27MPxYScWLg29FClbkd7Dv4KqEMVkZ+G501F62aiK4y
         vW4b2RUCmlpfGDauTDOxvDLk+8wCOtIccXcGSFlRGskreFYB/Z4Ux7coXQvvmizj1h7X
         YGLvfAvf1Ii/HkmStgnnLbZC143u+JSB+A9DcRUziW+0Ilo/Mg7OYMhCOewfUU6mQblL
         XqJpHN1O64b4+AWUtYM6zqR6SI1+zoWKIGQz36okvdGJGSJVxIfngd6PtUVWOHPrS5nJ
         /AHQ==
X-Gm-Message-State: AJIora8cM21BtpuAs6jC5YAYoDpkXDQU8Gz7HovqtwNg5rDYVfOrGvIT
        47Bwv1TkBdcL+vbHb+w2tB0xuJ2jfX+jss9lVmBrpITulHjlzg==
X-Google-Smtp-Source: AGRyM1t86AsuPjGkIHkU1mBJcDLzfdfrdSkzw8M5CxdoG5h79IRltZQSu+orsTM96SdUE4gGoosL+QRpYXwVKzBjtOU=
X-Received: by 2002:a05:620a:741:b0:6b5:ee4f:35e8 with SMTP id
 i1-20020a05620a074100b006b5ee4f35e8mr7586661qki.131.1659231969382; Sat, 30
 Jul 2022 18:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
 <220728.865yjhl8wk.gmgdl@evledraar.gmail.com> <xmqqilnhcgd7.fsf@gitster.g>
 <701c318c-1a1b-1793-90e8-807cf97dc948@web.de> <CABPp-BE4saKAboS=SPQmQe6n2=Fnhv7pL4_JfF2Zwg5Zhp7Vjw@mail.gmail.com>
 <d461718f-cc72-96e2-4de6-4cc67e3b95a5@web.de>
In-Reply-To: <d461718f-cc72-96e2-4de6-4cc67e3b95a5@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 30 Jul 2022 18:45:57 -0700
Message-ID: <CABPp-BF5S6QT6Hn-1wf6w67-ayWfX5WZLZqueNMMeqp1jtXirg@mail.gmail.com>
Subject: Re: Lost file after git merge
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?TGHEj2EgVGVzYcWZw61r?= <lada.tesarik@olc.cz>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, you nerd-sniped me into responding why I'm super skeptical of this pa=
th...

On Sat, Jul 30, 2022 at 7:44 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 30.07.22 um 04:16 schrieb Elijah Newren:
> > On Fri, Jul 29, 2022 at 1:34 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> >>
> >> Am 28.07.22 um 19:11 schrieb Junio C Hamano:
> >>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> >>>
> >>>> On Thu, Jul 28 2022, La=C4=8Fa Tesa=C5=99=C3=ADk wrote:
> >>>>
> >>>>> 1. I added a file called 'new_file' to a master branch.
> >>>>> 2. Then I created branch feature/2 and deleted the file in master
> >>>>> 3. Then I deleted the file in branch feature/2 as well.
> >>>>> 4. I created 'new_file' on branch feature/2 again.
> >>>
> >>> It heavily depends on how this creation is done, i.e. what went into
> >>> the created file.  Imagine that a file existed with content A at
> >>> commit 0, both commits 1 and 2 removed it on their forked history,
> >>> and then commit 3 added exactly the same content A to the same path:
> >>>
> >>>           1---3
> >>>          /     \
> >>>     ----0---2---4---->
> >>>
> >>> When you are about to merge 2 and 3 to create 4, what would a
> >>> three-way merge see?
> >>>
> >>>     0 had content A at path P
> >>>     2 said "no we do not want content A at path P"
> >>>     3 said "we are happy with content A at path P"
> >>>
> >>> So the net result is that 0-->3 "one side did not touch A at P" and
> >>> 0-->2 "one side removed A at P".
> >>>
> >>> Three-way merge between X and Y is all about taking what X did if Y
> >>> didn't have any opinion on what X touched.  This is exactly that
> >>> case.  The history 0--->3 didn't have any opinion on what should be
> >>> in P or whether P should exist, and that is why there is no change
> >>> between these two endpoints.
> >>
> >> The last sentence is not necessarily true.  You could also say that
> >> 0--->3 cared so much about path P having content A that it brought it
> >> back from the void.  Determining whether a de-facto revert
> >> - intended to return to an uncaring state of "take whatever main has" =
or
> >> - meant to choose *that* specific content which incidentally is on mai=
n
> >> is not possible from the snapshots at the merge point alone, I think.
> >>
> >> Checking if 0...3 touched P and leaving that path unmerged out of
> >> caution shouldn't be terribly expensive.
> >
> > I think it might be terribly expensive.
> >
> > Walking history can easily be the slow part of such an operation, e.g.
> > can_fast_forward() taking roughly 100 times as long as doing the
> > merge_incore_recursive() portion that creates the new merged toplevel
> > tree[1].  (And can_fast_forward() is a form of history walk that
> > doesn't involve traversing into any trees, so I suspect it's a cheaper
> > history traversal than what is being suggested).
> >
> > Focusing on the tree traversal side, this suggested change would
> > essentially disable the trivial directory resolution optimizations in
> > merge-ort[2].  (Note that the trivial directory resolution sped up a
> > rebase that didn't involve very many renames by a factor of 25).  The
> > whole point of that optimization was to avoid walking into trees that
> > were only changed on one side, where possible.  Your proposed change
> > would be saying we always have to walk into trees that either side
> > modified...and do so for every intermediate commit as well so that we
> > can fully enumerate all (temporarily) changed files.
>
> True: Compared to just checking if a path was touched by 3, a history
> traversal can take arbitrarily long.  At least it's bounded by the merge
> base and a specific path.

How is it bounded by a specific path?  How do you know which path to
check?  Can't this affect many paths?  I think to fix this issue, you
either have to walk all paths for all intermediate commits, OR:
  * get the list of paths modified between the merge base and one side
of history (just an endpoint diff, not a view of history along the
way)
  * get the list of paths modified between the merge base and the
other side of history (again, just an endpoint diff)
  * take the symmetric difference of those two lists above (let's name
the resulting set SD so we can refer to it later).
  * Walk all intermediate commits between the merge base and the two
endpoints being merged, and for each one investigate every path in it
corresponding to one of the paths in SD.
  * As we do the above walk into trees of all intermediate commits,
look for a sequence of commits that does some change and then later
reverts it

Also, I think using the phrase "the merge base" points out some
ill-posedness in this problem.  For actual merges, I think it's well
posed.  But...

What about cherry-picks, rebases, and reverts?  Those pass a funny
merge-base to the merge machinery.  Using that merge-base does allow
us to construct a valid commit range, but in that context, is that
range still correct to use with your rule?  Perhaps it does make sense
to use that range and apply your same rule, but...

What if we instead cherry-pick a different way -- using format-patch
and `git am -3`?  At the time git-am runs, it only has one commit
available to it.  It cannot determine any merge-base.  So what range
of commits should it walk to see if the upstream side has both made a
change to some file and then undone that change?  Do we walk all of
history?  Do we attempt to find some point in history that appears to
have the same versions of the files in the "from" versions of the
patch being applied?  What if such a commit does not exist?  What if
many such commits exist?  If many such commits exist, what if using
one of those commits would give us a different answer than using
another commit (meaning, what if we do see a change-and-then-unchange
if one of them is used as the merge-base, but do not see such a
sequence if the other one is)?  I'm certain I could construct examples
of each of those "What if" scenarios for git-am.

>  And renames complicate the picture, but only
> full renames (same blob or tree ID) need to be considered.  That feels
> doable in a reasonable amount of time, but it's not as cheap as ignoring
> the history.

Making things 25x slower and calling it "not as cheap"?  That's some
literary jiu-jitsu there.

Also, I think the 25x figure may well undercount the expense, perhaps
even dramatically, since I'm not sure things can be limited in the
form you envision...

> Assuming that one side doesn't care about a path because it has the same
> content as the merge base is tempting.  And reverts that break this
> assumption are probably quite rare.  Still it led to an unintended
> outcome here.  Reminds me of a recent chess robot incident [3].  Speed
> is nice and safety has a cost, but do we already make the best possible
> tradeoff here?

I mean, if you want to make an alternative merge strategy that isn't
based on a three-way merge, by all means go ahead.  We have pluggable
backends, after all.

It's not clear to me that your suggestion actually leads to a
situation with fewer unintended outcomes, though it is clear that
performance could be dramatically worse.  Let's explore this for a bit
(more than I already have above)...

Let's say you aim to fix this "unintended outcome" via paying
attention to the changes from individual commits along the way.  This
isn't the only such issue users report that is intrinsic to how
three-way content merges work.  Do you decide to also address the
others?  From the top of my head, others include:

A) generalize your logic here -- apply it to individual hunks rather
than only to whole files.  Using your exact same rationale would
suggest that if someone modifies a hunk on one side of history and
undid it later, then that region of code should not cleanly resolve to
what the other side of history has but should instead be marked as
conflicted.
B) handle commits cherry-picked to both sides "better".  If someone
applies the same cherry-pick to both sides, and they then further
modify the same lines on one side, there should be no "useless"
conflict, because both sides "built on top of" the same cherry-picked
state.
C) make rename detection match files based on changes in individual
commits rather than on the overall diff since the merge base

It turns out that others have explored part of this space before, e.g.
Bram Cohen's "Precise Codeville Merge"[4], which had names for
behaviors (A) and (B) (see [5] and [6], respectively; also note that
it points out that requirements (A) and (B) can come into conflict).
Perhaps if you are interested, you can port his code over and use his
algorithm?  However, it might be worth noting that he later gave up on
it and recommended that people use three-way merges instead[7].

Since Git seems to be the only system that does rename detection, (C)
is new territory.  But it's also relevant in that a user requested
that the merge algorithm incorporate information from changes in
individual commits along the history in order to solve a "bug" they
ran into[8].

Also, besides implementing Bram's "Precise Codeville Merge" in Git,
there may be another pre-existing solution available: using Michael
Haggerty's git-imerge[9] and making sure it fully fills out its matrix
of merges instead of opportunistically attempting to skip some.  That
would certainly make sure that changes from each individual commit was
considered.

But let's say you don't want to use either Precise Codeville Merge or
git-imerge, and want to make a copy of our default strategy
(merge-ort) and modify it.  Once you implement your new strategy, I'm
sure the other cases in (A), (B), and (C) will be brought up by people
and it's hard to see based on your rationale so far why your new
algorithm shouldn't attempt to solve those issues as well.  If you do,
your performance will really tank.  Not only did you kill the trivial
directory resolution optimization, you also kill the irrelevant
renames optimization (which, IMO, was the crowning jewel of the ort
optimizations).  But it's also worse than that because (A) and likely
(B) force you to compute pairwise diffs of every sequence of commits
since the merge base, and (C) forces those all to include rename
detection (both for full and partial renames).  But it gets worse.
Some of those commits in the history back to the merge base will be
merge commits, for which we have to be careful with the diff
computation.  We can't just ignore merge commits, because
change-and-then-unchanged code might have been done in merge commits
as part of an attempt to fix semantic conflicts.  So, to address merge
commits, we have to see the changes made by users in those merges
relative to the auto-merge state.  If we do that, the upshot is that
handling (A)-(C) implies that to merge two branches, we have to look
at all merge commits in the history of the two branches back to the
merge base, and remerge every one of them.

Maybe you're okay with all of the above, even with others giving up on
merge strategies other than three-way merge.  Maybe individually
merging all commits since the merge base doesn't phase you.  Maybe you
can make some kind of distinction where some of (A)-(C) don't matter.
Maybe you just capitulate and say you only care about the problem that
started this thread and ignore all three of those requests.  Maybe you
don't care about git-am and exclude it, overlooking the extra
difference we've added between it and the other commands (a bit sad
since merge-ort had removed one of those differences and I like
commands being more consistent).  Maybe the resulting "mere" 25x
slowdown is good enough for you for your repository sizes.  Or maybe
you'd be hiding this behind some non-default option that people could
select, allowing them to make the tradeoff.  Whether any or all of
that is true, I just don't see how to maintain it with the rationale
and description given, so I'm not comfortable with it affecting the
code I have to maintain.

So, I'm skeptical.  But feel free to create a new merge strategy and
prove me wrong.


[4] https://tonyg.github.io/revctrl.org/PreciseCodevilleMerge.html
[5] https://tonyg.github.io/revctrl.org/ImplicitUndo.html
[6] https://tonyg.github.io/revctrl.org/Convergence.html
[7] https://bramcohen.livejournal.com/52148.html
[8] https://lore.kernel.org/git/CABPp-BHF5j9XTrJOreHMaQ+TrZB1VgZvs-Bq2vFD1y=
hLBdkV3A@mail.gmail.com/
[9] https://github.com/mhagger/git-imerge
