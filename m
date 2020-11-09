Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C8C4741F
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DBA206CB
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etpzeWFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgKIWo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgKIWo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:44:57 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197C4C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 14:44:57 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id t16so12041552oie.11
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 14:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f1UkYdzmD8M8UJjZFX3rq5uSEGGboD6LyRDMkJsCgg8=;
        b=etpzeWFgcnvMccU2aZ+KQTg+IyatpAyVdffGa0MM9TdzbUuOIae7AGbxHIRvtDBlQM
         7AH3bBnzPFJZmjK/uUBeBC02e7VGeCVHizbcns7XE2TExjVFIDRZQM2rqPzotQGHmXC5
         8vOfGFcYczTtUUWBjRn9jmoPX7Nl6bHN5Zg5zy0e+ffMnUETZb4F47A+QmROfZ2DmYw1
         UurnH4MHGLidCWn9Z7SsO40fmTYMNHFaYU5LvLo92R0leaoWSpOfh2SM4+uGITbF3xiL
         c0qpQEa5gpgkWZKVsDN1sj33AMIGCYr7XQzXzInEonrsvJJqrWIhFt9nI/ibZh8Sy8Yb
         Yr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f1UkYdzmD8M8UJjZFX3rq5uSEGGboD6LyRDMkJsCgg8=;
        b=BD74tRyIuX+LuXWSEtkjIRmR9SchTVZOtPykPCcRTJNHLkPhr7V1DWlmEBeM5z7DR4
         SqJeDiV6yYQFQ57+0g/cfTK6WN90r+QcKn6f3Orjslyp7UYUmPffOdP+iPpYU3mzQYHq
         sMhc0/uG1kPRc3THN7CaaS1M8Vsvj3e7hUuz4tavqH/v7ymo/XuJy8nwngJXx2sWiCe8
         CMpzWquO9NpuMm63GBvWd8Co1a6KAOuG5TmGTiZogFSll7e49MIsqFiSwdbfAqdtE8IW
         CPE1ln4OADmUrzPo+gtKINE1IXZke3O4z0jw5X+1YO0qvDOYFmWSEyXW6k/8pruETe4S
         X2vQ==
X-Gm-Message-State: AOAM532c9MgPUCB7KpYkC33z+9lbJEdraDxpE8Iq+kvFjCg2xOzUe2lz
        7wcd1bjotiRLp/0rdblBVZWAJ+vhFmlsgq3ZLPo=
X-Google-Smtp-Source: ABdhPJyFDF8R4qI0pzUC3iin/LfmeyzzSF472XJWm1CnMOTtizLZuJbrAknIdVqtgytQ9FABvvEIDLfVpMe43uSSse0=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr1002415oif.39.1604961896315;
 Mon, 09 Nov 2020 14:44:56 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <0197d698-e966-f0bb-4d77-0183e93d9bef@gmail.com>
 <CABPp-BESfpqjrskz-UQikEfk_rV_QpQybo_hStVw=K8jXHYmfA@mail.gmail.com>
 <CABPp-BGvgdK8vEu5+mHjy9=GPg-aVtforC4-AAYgs3RWkBwQJA@mail.gmail.com>
 <ca61acbf-1757-5ddc-49f7-6da0cba4a647@gmail.com> <CABPp-BEzZ18KfX0kgOja+yeXbuEZmMORWjGePUMTdyzvqXLkFg@mail.gmail.com>
 <ee5cb3fe-4983-deba-2dba-b11a74adfbde@gmail.com> <CABPp-BHO7bZ3H7A=E9TudhvBoNfwPvRiDMm8S9kq3mYeSXrpXw@mail.gmail.com>
 <8b33b42f-2939-6fec-ef01-892ac5a0f581@gmail.com>
In-Reply-To: <8b33b42f-2939-6fec-ef01-892ac5a0f581@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Nov 2020 14:44:45 -0800
Message-ID: <CABPp-BEdcqaP4Le_31Mgo+u4-b+ZFVPw_HsEMKpNuHknc8pCqQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] fundamentals of merge-ort implementation
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Mon, Nov 9, 2020 at 11:51 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/9/20 12:13 PM, Elijah Newren wrote:> Actually, this was pretty enlightening.  I think I know about what's
> > happening...
> >
> > First, a few years ago, Ben said that merges in the Microsoft repos
> > took about an hour[1]:
> > "For the repro that I have been using this drops the merge time from ~1 hour to
> > ~5 minutes and the unmerged entries goes down from ~40,000 to 1."
> > The change he made to drop it that far was to turn off rename detection.
> >
> > [1] https://lore.kernel.org/git/20180426205202.23056-1-benpeart@microsoft.com/
> >
> > Keep that in mind, especially since your times are actually
> > significantly less than 5 minutes...
>
> Yes, the other thing to keep in mind is that this is
> a Scalar repo with the default cone-mode sparse-checkout
> of only the files at root. For this repo, that means that
> there are only ~10 files actually present.
>
> I wanted to remove any working directory updates/checks
> from the performance check as possible.

Ah, that explains how you got under 20s.  I remember elsewhere on the
list someone (I think it was Ben again) mentioned that a "git checkout
-b <newbranch>" took 20s, despite no need to update the working tree
or index.

I have only done one cursory test of merge-ort with sparse-checkouts;
I should do more.  There might be a bug somewhere, though it does at
least pass the regression tests and I think for the most part it's
actually better: there are cases where merge-recursive will vivify
files outside the sparse-checkout which were not conflicted (see e.g.
https://lore.kernel.org/git/xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com/);
in contrast, merge-ort shouldn't have any such cases -- it'll only add
files to the working copy if they match the sparsity patterns or the
path has conflicts.

> >> $ /_git/git/summarize-perf git rebase --onto to from test
> >> Successfully rebased and updated refs/heads/test.
> >> Accumulated times:
> >>     8.511 : <unmeasured> (74.9%)
> >
> > Wild guess: This is setup_git_directory() loading your ~3 million entry index.
>
> I think there is also some commit walking happening, but
> it shouldn't be too much. 'from' and 'to' are not very
> far away.

Makes sense.  I suspect that with your commit-graphs this ends up
being fast enough that you might have difficulty even measuring it,
though.

> > Did you include two runs of recursive and two runs of ort just to show
> > that the timings were stable and thus there wasn't warm or cold disk
> > cache issues affecting things?  If so, good plan.  (If there was
> > another reason, let me know; I missed it.)
>
> For the rebase, I did "--onto to from test" and "--onto from to test"
> to show both directions of the rebase. The merge I did twice for the
> cache issues ;)

Oh, good call.  Thanks for pointing it out, I missed that on first reading.

> > .004s on label:incore_nonrecursive -- that's the actual merge
> > operation.  This was a trivial rebase, and the merging took just 4
> > milliseconds.  But the overall run took 11.442 seconds because working
> > with 3M+ entries in the index just takes forever, and my code didn't
> > touch any on-disk formats, certainly not the index format.
> >
> > _All_ of my optimization work was on the merging piece, not the stuff
> > outside.  But for what you're testing here, it appears to be
> > irrelevant compared to the overhead.
>
> OK, so since we already disable rename detection through config,
> the machinery that you are changing is already fast with the old
> algorithm in these trivial cases.
>
> To actually show any benefits, we would need to disable rename
> detection or use a larger change.

...or both.  :-)

> >> And here are timings for a simple merge. Two files at root were changed in the
> >> commits I made, but there are also some larger changes from the commit history.
> >> These should all be seen as "this tree updated in one of the two, so take that
> >> tree".
> >
> > Ahah!  That's a microsoft-specific optimization you guys made in the
> > recursive strategy, yes?
>
> I'm not aware of any logic we have that's different from core Git.
> The config we use [1] includes "merge.stat = false" and "merge.renames
> = false" but otherwise seems to be using stock Git.
>
> [1] https://github.com/microsoft/scalar/blob/1d7938d2df6921f7a3b4f3f1cce56a00929adc40/Scalar.Common/Maintenance/ConfigStep.cs#L100-L127
>
> I'm CC'ing Jeff Hostetler to see if he knows anything about a custom
> merge algorithm in microsoft/git.

Oh, I took your wording that 'These should all be seen as "this tree
updated in one of the two, so take that tree"' as an implication that
you had a special merge tweak and wanted to verify it didn't regress.
I think I read too much into your wording.

Also, thinking over it more, I remember now that Ben also turned on
unpack_opts.aggressive when rename detection was turned off -- see
commit 6f10a09e0a ("merge: pass aggressive when rename detection is
turned off", 2018-05-02).  That isn't quite as advantageous as doing a
trivial tree merge, but if the algorithm that does the trivial tree
merge has to end up updating a complete index later anyway via the
checkout logic of unpack_trees, then the differences are basically a
wash.

> > It does NOT exist in upstream git.  It's
> > also one that is nearly incompatible with rename detection; it turns
> > out you can only do that optimization in the face of rename detection
> > if you do a HUGE amount of specialized work and tracking in order to
> > determine when it's safe _despite_ needing to detect renames.
>
> Perhaps merge.renames=false is enough to trigger this logic already?

Yeah, since I read too much into what you wrote and know that I
remember the "if (no_renames) o.aggressive = 1" bit, then yeah this
would be enough.

> > I
> > thought that optimization was totally incompatible with rename
> > detection for a long time; I tried it a couple times while working on
> > ort and watched it break all kinds of rename tests...but I eventually
> > discovered some tricks involving a lot of work to be able to run that
> > optimization.
>
> I will try to keep this in mind.
>
> > So, you aren't comparing upstream "recursive" to "ort", you're
> > comparing a tweaked version of recursive, and one that is incompatible
> > with how recursive's rename detection work.  In fact, just to be clear
> > in case you go looking, I suspect that this tweak is to be found
> > within unpack_trees.c (which recursive relies on heavily).
> >
> > Further, you've set it up so there are only a few files changed after
> > unpack_trees returns.
> >
> > In total, you have: (1) turned off rename detection (most my
> > optimizations are for improving this factor, meaning I can't show an
> > advantage), (2) you took advantage of no rename detection to implement
> > trivial-tree merges (thus killing the main second advantage my
> > algorithm has), and (3) you are looking at a case with a tiny number
> > of changes for the merge algorithm to process (thus killing a third
> > optimization that removes quadratic performance).  Those are my three
> > big optimizations, and you've made them all irrelevant.  In fact,
> > you're in an area I would have been worried that ort would do _worse_
> > than recursive.  I track an awful lot of things and there is overhead
> > in checking and filling all that information in; if there are only a
> > few entries to merge, then all that information was a waste to collect
> > and ort might be slower than recursive.  But then again, that should
> > be a case where both algorithms are "nearly instantaneous" (or would
> > be if it weren't for your 3M+ index entry repo causing run_builtin()'s
> > call to setup_git_directory() in git.c to take a huge amount of time
> > before the builtin is even called.)
>
> Thanks for your time isolating this case. I appreciate knowing exactly
> which portions of the merge algorithm are being touched and which are
> not.
> > 5 seconds.  I do have to hand it to Ben and anyone else involved,
> > though.  From 1 hour down to 5 seconds is pretty good, even if it was
> > done by hacks (turning off rename detection, and then implementing
> > trivial-tree merging that would have broken rename detection).  I
> > suspect that whoever did that work might have found the unconditional
> > discarding and re-reading of the index and fixed it as well?
>
> As you can probably tell from my general confusion, I had nothing
> to do with it. ;)
>
> > Heh, yeah 0.002 seconds for ..label:incore_recursive.  Only 2
> > milliseconds to create the actual merge tree.  That does suggest you
> > might have fun with 'git log -p --remerge-diff'; if you can redo
> > merges in 2 milliseconds, showing them in git log output is very
> > reasonable.  :-)
>
> Yeah, 'git merge-tree' is very fast for these cases, so I assumed
> that something else was going on for that command.

Oh, interesting.  I forgot about merge-tree.  Maybe I should make a
version based on merge-ort (and then it'd handle rename detection too,
something it doesn't currently do.)?  However, that wouldn't be
comparing merge algorithms, because builtin/merge-tree.c doesn't use
merge-recursive.[ch].  (It would be easy to get confused into thinking
it does, since merge-recursive.[ch] defines a function called
merge_trees(), but builtin/merge-tree.c doesn't use it despite the
name similarity.)

> > Could we have some fun, though?  What if you have some merge or rebase
> > involving lots of changes, and you turn rename detection back on, and
> > you disable that trivial-tree resolution optimization that breaks
> > recursive's rename detection handling...and then compare recursive and
> > ort?  (It might be easiest to just compare upstream recursive rather
> > than the one with all the microsoft changes to make sure you undid
> > whatever trivial tree handling work exists.)
>
> I can try these kinds of cases, but it won't be today. I'm on kid duty
> today, and answering emails in between running around with them.

One word of caution: merge.renameLimit may get in your way.  The
default of 1000 means that you're likely to hit that limit on your
first run, and get a warning message like the following printed out:

warning: inexact rename detection was skipped due to too many files.
warning: you may want to set your merge.renamelimit variable to at
least 27328 and retry the command.

You then need to undo your rebase or merge, bump the limit, and
re-run.  Also, you will need a higher limit for merge-recursive than
you do for merge-ort.  The default of 1000 is enough for merge-ort to
detect all the renames in my 26K-files-in-a-directory rename testcase
of the linux kernel, but the value needs to be bumped to 27328 for
merge-recursive.  And if you don't have the limit high enough, then
one algorithm is doing the work to detect renames and the other is
bailing and skipping it, so it's not an apples-to-apples comparison.
If that warning doesn't appear for either backend, then you have an
apples-to-apples comparison.

> > For example, my testcase in the linux kernel was finding a series of a
> > few dozen patches I could rebase back to an older version, but
> > tweaking the "older" version by renaming drivers/ -> pilots/ (with
> > about 26K files under that directory, that meant about 26K renames).
> > So, I got to see rebasing of dozens of real changes across a massive
> > rename boundary -- and the massive rename boundary also guaranteed
> > there were lots of entries for the merge algorithm to deal with.
> >
> > In the end, though, 4 milliseconds for the rebase and 2 milliseconds
> > for the merge, with the rest all being overhead of interfacing to the
> > index and working tree actually seems pretty good to me.  I'm just
> > curious if we can check how things work for more involved cases.
>
> I'm definitely interested in identifying how your algorithm improves
> over the previous cases, and perhaps re-enabling rename detection for
> merges is enough of a benefit to justify the new one.
>
> Eventually, I hope to actually engage with your patches in the form
> of review. Just trying to build a mental model for what's going on
> first.

Ooh, I can help with that; here's what's going on:  *** Magic ***

(Black, evil magic in the case of merge-recurisve.  Good magic in the
case of merge-ort.)

Glad I could help clear things up for you.  :-)
