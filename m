Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961EFC4743C
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694CD611C9
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhFWRdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWRdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:33:46 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA47C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:31:28 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so2688407ota.13
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJyvTOIE1252uSWuW9yGnOBa0QAKJ3s7e2bdS2xuFv8=;
        b=sD4zA9JJIMzZmrh/1DXUoO8JYlJ+hxtO6RhrFqJTKYsR0LxyJEfRMSwWT5mClaV28z
         1ersfJMPIwaBQ2vYY5J8rcia1E6mIwND2dkNUYjlwfTEMlB355BKWeFZ/fdkT/DuX0pV
         6AIJcssog+cQmVNPvunHwBJx1Rzl/rIIxlFEClwUD5nsV3VhSpFPei/ffHQD1ZuFpdTo
         VUIdRBCiQIT+Dzc2f8krtlT0hbESt9k/OGGAwNRAdHNoDyfRyg/DGh7/8UBQdL+21+fo
         gcMxm6nFyAiwMWCfFcTY7wgZXi5U5uqwgc4rxacAkNXlLiPM8egyoiz90Si/jdS2ahcV
         /ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJyvTOIE1252uSWuW9yGnOBa0QAKJ3s7e2bdS2xuFv8=;
        b=ZWaD2J6/YetV/9sqPy7Q0kVZCl9TyyEQkzUq5zSNOv8r/t+ul6LxVfvwxl9yjGD0WM
         vbO6V0U0MiEGgNAWWjR2RFnuk8H4sF8/ELkRozyP6m01QqQQXPJx0xEHUX1wRCThbK6x
         V4RniXRqblBNTblrb353QVhJsl6zgSGZyA+2JbkE76JDOUtp1a9WWAjo/LHwrrD9Ap/V
         ZsJa3qY/JM7t9RMwLCspQq7cuopRcoJdkj8wqk4nC/lCp64SQloEjZPJVVU/JKgx6v3y
         4VDUDqWXx8dhe5+muX+OxvxtATCW+muHjHdw9rtkg9G92+YMXRKSZKI5T5xNuM6gxXpC
         dl0g==
X-Gm-Message-State: AOAM531Vnk59/mXCi0AcNZt52rBPgYsGGcpJfbW6GLbpL256Ul22duNv
        zL6xYCu/THfsE/MgdbhT00Sz7zSQVi8OncxHjS0=
X-Google-Smtp-Source: ABdhPJxZDG31s5x7pjZXRCKR0qdiYTmlUgepsi2Lrub7ZXQO3xzU2OCGdxaKbGPB3ioXFjLeo8arwzasReejBncIUdg=
X-Received: by 2002:a05:6830:18fc:: with SMTP id d28mr936878otf.162.1624469487436;
 Wed, 23 Jun 2021 10:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
 <pull.969.v3.git.1624349082.gitgitgadget@gmail.com> <3a397e04-88a1-1205-a465-75dc2fd7e93d@gmail.com>
 <CABPp-BH9vy3otHvAxR2T6JmVKtH2+EKj-A7NxGsuoqnZA_Bykg@mail.gmail.com>
 <8f1edc60-f754-541b-1d66-7f5ec49eff55@gmail.com> <CABPp-BEuHbFbTWXKhW0MYkcW9ScJfUungwL6y9g=W=bZ=cmCbg@mail.gmail.com>
In-Reply-To: <CABPp-BEuHbFbTWXKhW0MYkcW9ScJfUungwL6y9g=W=bZ=cmCbg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 Jun 2021 10:31:15 -0700
Message-ID: <CABPp-BE3W0yfM3aB0hM+EG15zV=krSMv3kGRTjfVNV2rQtiDrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Optimization batch 13: partial clone optimizations
 for merge-ort
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 1:11 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jun 22, 2021 at 7:14 PM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 6/22/2021 2:45 PM, Elijah Newren wrote:
> > > On Tue, Jun 22, 2021 at 9:10 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > I want to focus on this item:
> >
> > >> 2. I watched for the partial clone logic to kick in and download blobs.
> > >>    Some of these were inevitable: we need the blobs to resolve edit/edit
> > >>    conflicts. Most cases none were downloaded at all, so this series is
> > >>    working as advertised. There _was_ a case where the inexact rename
> > >>    detection requested a large list of files (~2900 in three batches) but
> > >>    _then_ said "inexact rename detection was skipped due to too many
> > >>    files". This is a case that would be nice to resolve in this series. I
> > >>    will try to find exactly where in the code this is being triggered and
> > >>    report back.
> > >
> > > This suggests perhaps that EITHER there was a real modify/delete
> > > conflict (because you have to do full rename detection to rule out
> > > that the modify/delete was part of some rename), OR that there was a
> > > renamed file modified on both sides that did not keep its original
> > > basename (because that combination is needed to bypass the various
> > > optimizations and make it fall back to full inexact rename detection).
> > > Further, in either case, there were enough adds/deletes that full
> > > inexact detection is still a bit expensive.  It'd be interesting to
> > > know which case it was.  What happens if you set merge.renameLimit to
> > > something higher (the default is surprisingly small)?
> >
> > The behavior I'd like to see is that the partial clone logic is not
> > run if we are going to download more than merge.renameLimit files.
> > Whatever is getting these missing blobs is earlier than the limit
> > check, but it should be after instead.
> >
> > It's particularly problematic that Git does all the work to get the
> > blobs, but then gives up and doesn't even use them for rename
> > detection.
>
> I agree with what should happen, but I'm surprised it's not already
> happening.  The give up check comes from too_many_rename_candidates(),
> which is called before dpf_options.missing_object_cb is even set to
> inexact_prefetch.  So I'm not sure how the fetching comes first.  Is
> there a microsoft specific patch that changes the order somehow?  Is
> there something I'm mis-reading in the code?

After thinking about it more, I wonder if the following is what is happening:

* Some directory was renamed (and likely not a leaf), resulting in a
large pile of renames (or some other change that gives lots of renames
without changing basename)
* basename_prefetch() kicks in to download files whose basenames have
changed (even for "irrelevant" renames)
* Basename matching is performed (which is linear in the number of
renames, and not subject to the merge.renameLimit)
* After basename matching, there are still unmatched destinations and
relevant sources; which would need to be handled by the quadratic
inexact matching algorithm.
* Since there are enough renames left to trigger the renameLimit, you
get the "inexact rename detection was skipped due to too many files"
warning.

and then you assumed the prefetching was for the quadratic inexact
rename detection when in reality it was just for the linear basename
matching.

If so, there's a couple things we could do here:

* The easy change: modify the warning, perhaps to something like
"quadratic inexact rename detection was skipped...", to make it better
reflect its meaning (basename matching is also an inexact match)
* The more complicated change: be more aggressive about not detecting
renames via basename match for "irrelevant" sources...perhaps avoiding
it when it involves prefetching, or maybe just when we can somehow
determine that we'd bail on the quadratic inexact rename detection
anyway.

The second point perhaps deserves a bit more explanation.  Basename
matching has an advantage of removing both sources and destinations
from the later quadratic (O(N*M)) inexact rename detection, so it was
generally beneficial to just always do the basename matching even if
the path wasn't relevant for either content or location reasons.  But
that was presuming later quadratic inexact rename detection was going
to run and not be skipped.  It was one of those tradeoffs in
optimization.  But if the file hasn't been prefetched and we're likely
to skip the quadratic inexact rename detection, then trying to do
basename matching for an irrelevant rename is wasted work, as is
prefetching the blobs in order to be able to detect that irrelevant
rename.  But how do we know if we'll skip the quadratic rename
detection if we don't match the basenames that we can, since every
matched basename removes both a source and a destination from the
unmatched pairs?

Maybe we should reorder the basename matching as a two-pass algorithm,
where we first detect basename-matching renames for all relevant
sources, and then repeat for non-relevant sources.

That would also allow us to insert a check before the second pass,
where if the first pass removed all relevant sources (meaning both
that no relevant sources were left out of basename matching and we
found a match for every relevant source included in basename
matching), then we can exit without doing the second pass.  That might
even improve the performance in cases without prefetching.  But it
would mean adding another prefetch step.

After doing the above splitting, then we could add extra conditions
before the second step, such as bailing on it if we think we'd bail on
quadratic inexact rename detection (which may still be hard to guess).
Or maybe even just bailing on the second step if prefetching would be
involved, because we'd rather lump those all into the quadratic
inexact rename detection anyway.

> But I'm still curious what the particular shape is for the data in
> question.  What does the error say merge.renameLimit would be need to
> set to?  If it's set higher, do some of the files resolve nicely (i.e.
> they really were renames modified on both sides with a different
> basename), or are they modify/delete conflicts and we're paying the
> cost of rename detection to verify they were deleted and we really do
> have a conflict?  I'm curious if there's more to learn and more
> optimization potential, basically.  Your repository is bigger, so
> there may be more to learn from it than from the testcases I've tried
> so far.  :-)

We might have just identified multiple additional optimization
opportunities above, neither of which is included in my pending
optimization series.  It would be helpful to get more details about
how frequently these kind of cases occur, the particular renameLimit
in use, the number of paths involved (number of unmatched source and
destinations), how many of the sources are relevant (perhaps even
broken down into content relevant and location relevant), etc., as
these all may help inform the implementation and whatever tests we
want to add to the testsuite.

However, some of that info is currently hard to gather.  I could
probably start by adding some trace2 statistics to diffcore-rename to
print out the original number of sources and destinations, the number
matched via exact matching, the number matched via basename matching,
the number of sources removed due to being irrelevant, and anything
else I might be overlooking at the moment to help gather relevant
data.
