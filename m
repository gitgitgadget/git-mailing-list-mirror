Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0FC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F8264F33
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 22:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhCQWhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 18:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCQWg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 18:36:58 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7298C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 15:36:58 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso3353332ott.13
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=978LiSVyyZjV5QBa26DYsgF7Im+5bPeqIhRTegFPWKg=;
        b=O3pcFd+h3VjQHI4Tv13rBspCektK5yGMN1Xw+0WiBV1ch67rFgM5W8KEfLmPQVkQd/
         sdYVZtW+bNhz7t4okXRQvh8e6a4TrQ7WZlX1CBOowWS22DrVj5b0JoPuFf67Y9aiFBCq
         XwvNc4dLOtqmCYUvvXILSsxxDVuUtFxJKIZR5vuYqG7oAT+cK3VTnkFXCO1GkoiFdqFo
         dqXOoDmDr7PvPmBoQHGm+XZXuNNrBnPmi6vzINrBdSSTyr44DXTA6yRvXt5bNx3AIZq6
         uK7lsX7FwhztCZBoYFHEYM1MoF1t9chXFUIN4fdl38CLiPPgEmzyoF83lCD9EFq/xaK9
         ZRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=978LiSVyyZjV5QBa26DYsgF7Im+5bPeqIhRTegFPWKg=;
        b=toCv0ClRRLsWlWq5lfcLF2VZtSCpEiNXt5CUNQoYmYCllqiHYTRxI37lri3K9T8244
         64qnE0/O4mgtNw7ELfwzHGuTLt3njgPrOro9bVwKunGttzioSwqlhMAcs/mYwqnvZ6V3
         JK9ZOxDPhhBI2XtqKvEmHYPrgPDpEDBEjFIGWnL6VFQDih0Z46aqjoeAWlBG/wEiPZxf
         thecTxAOdXZYJXuhSG7/LdAdz4qdqGctJ2VInDUvNK8bX/wMHJ/KsAkv/JelQ/F+n3FP
         PYPIJ/jB05Aj/FEPlu3kte8dS2MRmVtgklyeGFsQFpk1pb5hVMDLoB9u2kihE+57EWby
         k3lA==
X-Gm-Message-State: AOAM5321LJBS4vBjpsGpXaD17n4OpjGCFX+w5J0XesDEW9E+GJZoaemF
        ge/f70iDELekxbwZm7QXoB3iz9sbbYGQYyVCc20=
X-Google-Smtp-Source: ABdhPJylBF0SRPXLiIydbUgaBA9P17ZxLVYXZyinDBsnGTOMgmpOxwojoxQ4vCg3qOUeSFlBaAJaSIt+LYiFZh27AlM=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr5061892otf.162.1616020618023;
 Wed, 17 Mar 2021 15:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BF=-2qD9YodpnhYP49EnKEV=MOFDMUnB-agd-d69jVeQA@mail.gmail.com>
 <08ffff48-7b9c-7113-1a5a-557f3efff26f@gmail.com> <CABPp-BH-c8gzrkOFFNb=8b8R+X+VRXsziKoE_RtcR4mh6zjR4g@mail.gmail.com>
 <5c886fd7-710d-ac4a-c63a-c1d000c29126@gmail.com>
In-Reply-To: <5c886fd7-710d-ac4a-c63a-c1d000c29126@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 15:36:46 -0700
Message-ID: <CABPp-BFaNOY8xPCTBzU+5p7FtWuC0kazh6DpQ1oKYVJNKw+UXg@mail.gmail.com>
Subject: Re: [PATCH 06/27] checkout-index: ensure full index
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 2:33 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/17/2021 5:10 PM, Elijah Newren wrote:
> > On Wed, Mar 17, 2021 at 1:05 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 3/17/2021 1:50 PM, Elijah Newren wrote:
> >>> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> >>> With the caveat in the commit message, this change looks okay, but
> >>> checkout-index may be buggy regardless of the presence of
> >>> ensure_full_index().  If ensure_full_index() really is needed here
> >>> because it needs to operate on all SKIP_WORKTREE paths and not just
> >>> leading directories, that's because it's writing all those
> >>> SKIP_WORKTREE entries to the working tree.  When it writes them to the
> >>> working tree, is it clearing the SKIP_WORKTREE bit?  If not, we're in
> >>> a bit of a pickle...
> >>
> >> Perhaps I'm unclear in my intentions with this series: _every_
> >> insertion of ensure_full_index() is intended to be audited with
> >> tests in the future. Some might need behavior change, and others
> >> will not. In this series, I'm just putting in the protections so
> >> we don't accidentally trigger unexpected behavior.
> >
> > I think this may be part of my qualms -- what do you mean by not
> > accidentally triggering unexpected behavior?  In particular, does your
> > statement imply that whatever behavior you get after putting in
> > ensure_full_index() is "expected"?  I think I'm reading that
> > implication into it, and objecting that the behavior with the
> > ensure_full_index() still isn't expected.  You've only removed a
> > certain class of unexpected behavior, namely code that wasn't written
> > to expect tree entries that suddenly gets them.  You haven't handled
> > the class of "user wants to work with a subset of files, why are all
> > these unrelated files being munged/updated/computed/shown/etc."
> > unexpected behavior.
>
> My intention is to ensure that (at this moment) choosing to use
> the on-disk sparse-index format does not alter Git's end-to-end
> behavior.
>
> I want to avoid as much as possible a state where enabling the
> sparse-index can start changing how Git commands behave, perhaps
> in destructive ways.
>
> By adding these checks, we ensure the in-memory data structure
> matches whatever a full index would have created, and then the
> behavior matches what Git would do there. It might not be the
> "correct" behavior, but it is _consistent_.

That sounds good.  Could this be included in
Documentation/technical/sparse-index.txt?  There's only an oblique
reference to it when talking about grep and rm, which incidentally
were already updated by Matheus.  Perhaps also a reference to the
warning in Documentation/git-sparse-checkout.txt would be worthwhile.

> > I'm worrying that expectations are being set up such that working with
> > just a small section of the code will be unusably hard.  There may be
> > several commands/flags where it could make sense to operate on either
> > (a) all files in the repo or (b) just on files within your sparse
> > paths.  If, though, folks interpret operate-on-all-files as the
> > "normal" mode (and history suggests they will), then people start
> > adding all kinds of --no-do-this-sparsely flags to each command, and
> > then users who want sparse operation have to remember to type such a
> > flag with each and every command they ever run -- despite having taken
> > at least three steps already to get a sparse-index.
> >
> > I believe the extended discussions (for _months_!) on just grep & rm,
> > plus watching a --sparse patch being floated just in the last day for
> > ls-files suggest to me that this is a _very_ likely outcome and I'm
> > worried about it.
>
> It's these behavior changes that I would like to delay as much as
> possible and focus on the format and making commands fast that don't
> need a change in behavior.

Delaying sounds great, just so long as that delay doesn't also cement
the behavior and confuse consistency for correctness.

I still think we don't have correct behavior for sparse-checkouts in
many cases (I mean, when "git reset --hard" throws errors about not
removing files and then removes them, we've obviously got some
problems), but we had a decade long cementing of sorts with
SKIP_WORKTREE and now a year-or-two long cementing since
sparse-checkout was introduced and we never went through and cleaned
up the commands. We should at some point, especially since we put the
huge scary warning in Documenation/git-sparse-checkout.txt expressly
for this purpose.

(I would have started this sooner, but trying to feed merge-ort and
keep up with patch review already keeps me at less time on non-git
projects than I think is expected for me.  Once merge-ort is done...)

> (Yes, there will be exceptions, like when "git add" specifically
> adds a file that is in a directory that should be out of the cone,
> but the user added it anyway. Atypical behavior like that can be
> slow for now.)

I agree that there will be exceptions where we can't make the behavior
be fast, but I disagree with that specific example.  "git add" should
just give a warning message and not add any file outside the cone, for
both sparse-index and sparse-checkout.  That can be done quickly.

I know you want to delay the discussion of behavior fixes for specific
commands somewhat, but this particular discussion has already been
ongoing for about 4-12 months now (started at [1] and [2]) and it's
reached a point where I've put my Reviewed-by on it; see [3] for the
git-add piece specifically.

[1] https://lore.kernel.org/git/9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br/
[2] https://lore.kernel.org/git/0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br/
[3] https://lore.kernel.org/git/66d5c71182274c78e1fcfe84e77deb17e4f0d7e6.1615588109.git.matheus.bernardino@usp.br/

> >> Since tests take time to write and review, I was hoping that these
> >> insertions were minimal enough to get us to a safe place where we
> >> can remove the guards carefully.
> >>
> >> So with that in mind...
> >>
> >>> Might be nice to add a
> >>> /* TODO: audit if this is needed; if it is, we may have other bugs... */
> >>> or something like that.  But then again, perhaps you're considering
> >>> all uses of ensure_full_index() to be need-to-be-reaudited codepaths?
> >>> If so, and we determine we really do need one and want to keep it
> >>> indefinitely, will we mark those with a comment about why it's
> >>> considered correct?
> >>>
> >>> I just want a way to know what still needs to be audited and what
> >>> doesn't without doing a lot of history spelunking...
> >>
> >> ...every insertion "needs to be audited" in the future. That's a
> >> big part of the next "phases" in the implementation plan.
> >>
> >> As you suggest, it might be a good idea to add a comment to every
> >> insertion, to mark it as un-audited, such as:
> >>
> >>         /* TODO: test if ensure_full_index() is necessary */
> >>
> >> We can come back later to delete the comment if it truly is
> >> necessary (and add tests to guarantee correct behavior). We can
> >> also remove the comment _and_ the call by modifying the loop
> >> behavior to do the right thing in some cases.
> >
> > If it's "needs to be audited for both performance reasons (can we
> > operate on fewer entries as an invisible doesn't-change-results
> > optimization) and correctness reasons (should we operate on fewer
> > entries and given a modified result within a sparse-index because
> > users would expect that, but maybe provide a special flag for the
> > users who want to operate on all files in the repo)" and there's also
> > an agreement that either audited or unaudited ones will be marked (or
> > both), then great, I'm happy.  If not, can we discuss which part of my
> > performance/correctness/marking we aren't in agreement on?
>
> I will mark all of the ones I'm inserting. My hope is to eventually
> remove it entirely except for when disabling the sparse-index. That
> is likely too far out to really hope for, but it is the direction I
> am trying to go.
>
> As I indicate that we should carefully test each of these instances
> where ensure_full_index() _might_ be necessary before removing them,
> it is even more important to test the scenarios where the behavior
> changes from a full index with sparse-checkout. Preferably, we just
> change the behavior under sparse-checkout and then the sparse-index
> can match that (see "test_sparse_match" in t1092).

Makes sense.  I agree that it'd be nice to have the two generally
match, though I think we should be open to there being special cases
that differ.  The only one I can think of right now is `git ls-files`
(list the entries in the index) -- since there are tree entries in a
sparse-index, ls-files would naturally show the tree entries.
However, we can discuss that and any other cases -- if there are any
-- later.
