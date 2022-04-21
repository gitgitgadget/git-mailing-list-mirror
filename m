Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017A4C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 03:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383927AbiDUDY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 23:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiDUDY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 23:24:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E7BD67
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 20:21:38 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so4782091edw.6
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 20:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hKCFdqR0s3LEypc23UhHt44F6k6hNKgPCw7NlFzoZcc=;
        b=ToknjlGme16L2om3Z6PFSLb3K3fiFWt3ZumUXGAYY9iqxbXkWuvVSLq3sbjCAbH247
         +55xcMmjeiUalVS3YPyl0hfFN3PqQYPdhe4feeKlkrx04+CVYj2JXWutgdZl3GfT5GOV
         uAdgAkjFb6+YOCcTGWYRH5cjNE+rPN+knh2Su7Jq9z22RiACD9deW9nhoLKGZGSJG/O2
         7iOOevyxTNVRnLxhI75pz05SwJsiX9kAp4Oh+C+17ykSP+Bf3XoOc1ERu7qlHCRfPEi9
         1MOm4se5ZaP+czfw0NDUrsRtRXAIzqLqq4WUf1Cj0MnKiUQLrhCoHgoC0TY2HNGvNEg9
         VEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKCFdqR0s3LEypc23UhHt44F6k6hNKgPCw7NlFzoZcc=;
        b=yuUJnUt7ndULMMTCs9shiz6M2mdIWbX2j33VgZdihKxwDbMEyGEd3K24s4y02C7EaN
         7jAJr4Lygqn4/rVLR9+r5GEEoMKP0nKCR7ClF97aT4l7W03Z+6eXItlxsfzpTR4sf3tv
         IyAdqGINgH8djEbNoc+hxLRgChMJ4/zP2kgdUrFxRVteAVwmvptsuvxqX2nx5lQ2Nup3
         +zBfUeHB4cECIPd2Tgn8UCPn/anlcwpz3PqzYBJj7hLnqFv4SgehqCyhzFmbAcFFokSa
         tZV6OkxfWPLcJk4OjCKv1ZHUNjat6PHGXP1K/lJayJ9th3eq2TiBZxKwm59Z3CAMrAkm
         TxBA==
X-Gm-Message-State: AOAM53384/Mhpcd+K0HxXBC1IctKvKYTEbq5l7XDW+yN+Lffg+Eny71M
        xZXqzfyKD9/tLWyifh3rG3B9DnyRh/LEHzkmNB4Tq8Ul
X-Google-Smtp-Source: ABdhPJz+pKI3cT6+ny+UDD3Qb+DlfkyGQYf5KTeFSLaDHS1WeVQz9LFx64Wp7/z6dGV47rhB6D9wAqMnIcuoqADPpxw=
X-Received: by 2002:a05:6402:50d0:b0:423:f4a1:597d with SMTP id
 h16-20020a05640250d000b00423f4a1597dmr15834652edb.228.1650511297160; Wed, 20
 Apr 2022 20:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpojsNQuHe9iSUGyu_q2M4VObjDPj4c0QrFPsHdYypQ3aog@mail.gmail.com>
 <CABPp-BFAf+-ULwtd7WowsN2KSeJ0s1ucZZ1QSRYg8J+wM9MrZw@mail.gmail.com> <CAPMMpoj_aZTgiviv0OBYb-SwhgL9oecbBYkS9LQjcTf0cPmABg@mail.gmail.com>
In-Reply-To: <CAPMMpoj_aZTgiviv0OBYb-SwhgL9oecbBYkS9LQjcTf0cPmABg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Apr 2022 20:21:25 -0700
Message-ID: <CABPp-BHF5j9XTrJOreHMaQ+TrZB1VgZvs-Bq2vFD1yhLBdkV3A@mail.gmail.com>
Subject: Re: Unexpected conflict with ort merge strategy?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 4:10 AM Tao Klerks <tao@klerks.biz> wrote:
>
> Sorry for resurrecting such an old thread, and thanks again for your
> detailed response last year.
>
> On Thu, Nov 11, 2021 at 6:57 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > Sorry for the late response...
> >
> > On Tue, Oct 19, 2021 at 3:44 PM Tao Klerks <tao@klerks.biz> wrote:
> > >
[...]
> > === (a) what's happening and why ===
> >
> > In your testcase, you can drop all files other than
> >   * folder1/firstfile.txt
> >   * folder2/secondfile.txt
> >   * folder2/secondfile_renamed.txt
> > and any commits not touching those files can be dropped.  In simpler
> > terms, your testcase is:
> >   * Merge base: Has both folder1/firstfile.txt and folder2/secondfile.txt
> >   * feature branch: delete folder1/firstfile.txt
> >   * master branch: delete both folder1/firstfile.txt and
> > folder2/secondfile.txt, introduce folder2/secondfile_renamed.txt which
> > is very similar to both deleted files, but more so to the latter
> > If you're thinking my description of the master branch is funny (as
> > per your wording, you renamed folder2/secondfile.txt to
> > folder2/secondfile_renamed.txt), remember that git doesn't track
> > renames.
>
> I actually disagree with this as a simplification of my testcase. In
> my testcase, the deletion of "folder2/secondfile.txt" and introduction
> of "folder2/secondfile_renamed.txt", the "high-percentage rename" as I
> call it, is *separate* from the deletion of "folder1/firstfile.txt".
>
> I can understand how any given algorithm might choose to gloss over
> that fact, but it has very clear significance in my testcase.
> Obviously I'm not talking about the "_renamed" suffix, but rather the
> fact that in the *individual* commit, rename detection will 100%
> correctly/reliably detect this as a rename.
>
> When I provided the test case, I assumed this was something like
> "Recursive uses the information of each commit individually, whereas
> ort elides some stuff (and potentially introduces lots of other stuff)
> in the name of performance, hence there seems to be a correctness
> issue here". I assumed that the "recursive" strategy was logically
> equivalent to iteratively merging all the changes, along some chosen
> path from the merge base (eg the shortest?), and ort was... something
> else. Hence my assumption that in this case, where iteratively merging
> master into will get you the *right* result, regardless of whether you
> choose "recursive" or "ort" to do it, there was a correctness
> regression in ort.
>
> If I understand some of what you describe below correctly, this is an
> incorrect understanding of "recursive" - it does not, then, do the
> equivalent of iteratively merging all the commits along some selected
> path from the merge base.

Yes, recursive looks at exactly 3 commits -- the merge base, HEAD, and
the tip of the other branch being merged.  The history of how it got
there is ignored.

This is documented explicitly, and the manuals even provide an example
for users who mistakenly assume that the merge algorithm looks at
individual commits.  The particular example in the manual shows that
the merge algorithm handles that case in a way that could negatively
surprise such users.  Look for "if a change is made on both branches,
but later reverted on one of the branches" in either the git-merge or
git-rebase manpages.

> Insofar as a majority of my users (and, I suspect, a majority of git
> users overall) typically deal with large merges in a context where
> some upstream branch has had lots of changes, very iteratively, and
> *there is meaning* in those iterations, it scares me a bit to think
> that users are at risk of getting painful or wrong merge outcomes
> because that upstream branch's history is actually being ignored, or
> not used to its max potential.

Ignored is correct; the history is only used to find the merge base
(or merge bases).

> I would welcome some more-primitive and
> slow algorithm that could use the *knowledge* that
> "folder2/secondfile_renamed.txt" was in fact a rename of
> "folder2/secondfile.txt", as encoded in one of the individual commits
> in the path from the merge base to the tip being merged in. I would
> want to be able to offer this "slower, but more correct" algorithm to
> my users when a merge turned out to be more conflictive than they
> might have expected, as here.

Such an idea was suggested early on when git was introduced (and I
think other version control systems did something along those lines
for different reasons).  IIRC, Linus flatly rejected it saying the
three commit handling is better.  However, we didn't have pluggable
merge backends back then.  We do now.  So, if you want to write a new
merge algorithm that folks could use which inspects each individual
commit between the merge base and the two branches being merged, feel
free.

[...]
> > Is that better?  Worse?  For which backend?  Before you make your
> > call, let's consider the following slightly different case:
> >   * Merge base: Has files A & B (very similar, but not exact)
> >   * feature branch: Modify B, in an area where it differs from A
> >   * master branch: Copy A to C (while modifying it slightly in the
> > area it differs from B) in one commit, then delete B in another
> > commit.
> >
> > From the point of view of "best matches", we would have "A was left
> > alone, B is modified slightly on one side and deleted on the other,
> > and C is a new file" so the result should be "the original A, the new
> > C from master, and a modify/delete conflict on B".  However,
> > merge-recursive and merge-ort will instead claim there was a B->C
> > rename and since they have conflicting content changes in the same
> > area, fill C with conflict markers from these "unrelated" files that
> > the user then has to separate.
>
> My knowledge of copy-detection is very limited - I don't know what
> purpose it serves, when it is used, etc. I've always assumed that from
> a "file destiny" perspective, creating a copy, without removing/moving
> the original, should have no impact on where later changes to the
> original are considered to go - they stay with the original, even if
> it drastically changes. I would only ever expect rename detection to
> kick in if one thing was added, and another removed, in the *same*
> commit.

If there's a copy and the original is later renamed (or deleted), how
does the merge algorithm tell which filename is the original one?
Especially given that recursive/ort only look at the endpoints and not
the individual intermediate commits?

> If I were to apply an "iterative-ort" algorithm (that is, first merge
> in the "Copy A to C" commit, then merge in the "delete B" commit,
> using ort both times), I would get the "best match" outcome you
> describe, right?

An iterative merge algorithm that handles commits individually has all
kinds of research issues (including questions about either extremely
heavily nested conflicts or else N+M separate conflict resolution
steps for users to wade through for each merge).  I don't assume I
know how such an algorithm would work or behave.

I'm sure you'd probably code it to give you the "most similar within a
single commit" match since that's what's important to you, but I don't
know how that pans out in the wider scheme of things.

[...]
> > === (d) some warning/advice for folks dealing with multiple files
> > whose contents are quite similar (or even multiple directories of
> > files whose contents are quite similar) ===
> >
> > During the testing of merge-ort, I dug through many repositories and
> > remerged all existing merges to see which might give different results
> > with merge-ort vs. Git v2.30's merge-recursive.  I did find some,
> > though they came from the basename-guided matching change (discussed
> > in my section (b) above) rather than the unmodified-one-on-side change
> > (the case you pointed out in your email).  However, every single one
> > of the examples I found came from an interesting type of situation: it
> > appears that a number of big projects sometimes make a complete copy
> > of some directory (a library, a driver, whatever), and keep them both.
> > Many times this might be to keep one stable, while making
> > modifications to the other copy to add new features or abilities.
> > It's also possible that there was an earlier rename involved before we
> > got the current two names as well.  So, with that in mind here's a
> > question: what do you do when cherry-picking new features added to an
> > older version of the code?  If we use your "highest percentage match"
> > as you mentioned earlier, we'll likely end up applying the
> > cherry-picked changes to the _stable_ files rather than the new
> > version, because the copy meant to be stable is more similar to the
> > older version.  That's likely the wrong target.  But it gets worse...
> >
> > Some new feature is probably going to touch several files in the
> > relevant directory, not just one.  That raises the question of where
> > do the files each match individually?  I saw multiple examples where
> > the "best" match for individual files left half the files matching the
> > current stable version of the library/driver/whatever, and the other
> > half of the files matched against the new version of the
> > library/driver/whatever.  That means that porting those patches using
> > merge/cherry-pick/rebase/etc. is going to apply half the patches to
> > one copy and the other half of the patches to the other copy.
>
> If I understand you correctly, this is a problem that both "recursive"
> and "ort" share, but my imaginary "iterative-ort" does not. Is that
> right?

"recursive" and "ort" both share this quality, yes.  It's hard to
opine on an imaginary algorithm, though since it seems to be the
motivating factor for your new algorithm I would assume you'd either
solve that case or find it too hard and give up.  (Note that I have no
idea if achieving this goal of yours is easy or hard.)

> > That
> > just cannot possibly be right.  merge-ort didn't fix this, it
> > basically just meant it'd sometimes choose a slightly different mix of
> > application targets, but still split them across the two copies.
> > Well, technically merge-ort is marginally better here because the
> > directory-rename-guided-optimizations in merge-ort means that it's
> > slightly more likely to apply all the changes to one directory than
> > merge-recursive is.  But only slightly.  So these are situations where
> > both algorithms are likely to provide results that users will almost
> > certainly classify as wrong (and maybe even as "extremely wrong").
> >
> > If your repository is one where each file is pretty unique, then
> > rename detection seems to be a lot more reasonable and straightforward
> > to just run automatically.  But if you have multiple near copies of
> > the same file, and especially if you have multiple near copies of the
> > same directory, then relying on git's automatic rename detection
> > without double checking is a bad idea.  Git does a good job during a
> > merge of printing out which files it has detected as renames and
> > displaying which files have three-way content merges performed on
> > them, so I'd recommend looking at those a lot closer if you've got
> > multiple near copies of the same file or directories.
> >
> > > Is ort supposed to choose the "best" rename choice, for a given set of
> > > trees, and failing to do so here? Or is this a case of recursive
> > > *accidentally* doing a better thing?
> >
> > As noted above, neither the ort nor recursive strategies promise to
> > choose the "best" rename (by which I presume you mean closest match);
> > they both have situations where they'll pick a different one when
> > there are multiple choices.  Further, as shown above, finding the
> > optimal rename choice is an ill-posed problem space when dealing with
> > multiple near-copies of the same files or directories.  I would not
> > label either recursive's or ort's behavior as "correct" or "better"
> > for your testcase (nor as "incorrect" or "worse").  As to your last
> > question, while there have been cases in the past of the recursive
> > strategy accidentally getting good results in some cases (e.g. due to
> > serendipitous cancellation of different bugs for certain inputs),
> > there's no such accident in anything I've discussed here that I've
> > found; it's all a clear expected result of the algorithms in question.
> > I hope that this all answers your particular questions, but I think
> > there's a deeper point here that is important for people to generally
> > realize for this situation or others like it:
> >
> >
> > TAKEAWAY: Whenever you are dealing with multiple files or directories
> > that are near matches, the person doing merges/rebases/whatever really
> > does need to be responsible to pay close attention to any such
> > files/directories (and this is not new to merge-ort; it has always
> > been an issue with merge-recursive as well).
>
> This conclusion I find deeply scary and problematic. If I have 1000
> users of a repo, and there are 3 sections of the folder structure that
> have been split off / duplicated, and many of these users might change
> the original ones or the copies, you're saying *all* of these users
> merging "upstream" changes down into their feature branches need to be
> *aware* of the "there are multiple similar directories" problem, and
> need to *actively* recheck that git is not doing anything "wrong" by
> eliding commit history when merging, even in the absence of warning or
> conflicts from the tool???
>
> Sorry if I'm misunderstanding and mischaracterizing... but this
> seems... bad. It seems very much in violation of the general principle
> that Junio outlined that "[users needing] to look for mistakes in
> _all_ merges made by the tool, [...] is
> not something we would want."
>
> Understanding that the default choice of merge strategy needs to make
> compromises, and apparently recursive *already* made these particular
> compromises, is there in fact an "iterative along the shortest merge
> path", or "iterative-ort" strategy or that I could try / play with, in
> terms of performance testing?

No such thing exists to my knowledge.  Michael Haggerty's git-imerge
(imerge == incremental merge) is similar-ish, but it avoids doing each
step by trying to bisect through to find where you first hit
conflicts; if it doesn't hit conflicts, it skips over a large range of
commits.  That might be problematic for you, since handling multiple
commits at once might result in the "best match" for a rename picking
the most similar match over the range of commits rather than most
similar within individual commits.  But perhaps the git-imerge code is
useful to you and you can modify it in some fashion to actually run
through each individual commit.
