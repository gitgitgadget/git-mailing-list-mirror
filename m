Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D123C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC13D64DDE
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 18:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBMSfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 13:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBMSfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 13:35:42 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA519C061574
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 10:35:02 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a5so2441961otq.4
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4X29Bchnyh3N7hnLLgVSxPBSXv9qV+2Hi1h7bb9bNas=;
        b=BeNOIJi7Vu9wPUCdRSbYw7KVt76HxHOo52tOxWsCOJcvtBufg2jOx8lNIsFjkaSrod
         uB8aTyeUJdozONtMwn1GjglSvpTtvBBjpe1zKamjNrdUS9VVtCkNWFrJWqN9uiwC3KzG
         v6h4JdGHg2qtEmB9LHj5CK+nx5ygIF4NmDEmcycO8GTARHjuPamgID+4KFl5ICmRhQDJ
         vtlWvgXMGcW1DdBy+CCCBB9IV0Rube3flCedPhSgTyZZwzFHbMh6Jo4YIHiXhYcIZfFN
         ivRUz30nfyEmLuKYcUeUH+da7YVaimJgUiH6OFJo0qlOdBt/4d1JfuATpSP7iv50eC/o
         BdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4X29Bchnyh3N7hnLLgVSxPBSXv9qV+2Hi1h7bb9bNas=;
        b=jLbpcmNO+YwHHlKqsJwvzxXZ4D9CJJOwM2C3CimYFOkDT9pn7J/I5Yx0jAl9Ok6FFM
         A6quvmhm09rVteWMxL0tbWzzcfN1QagRIhsstEnHHP2m/y5ePS18UJiU2X24gli2owzJ
         uQLRUSZRfm2suyMbxISs4eABfyA1IzaLdhvLd/4z7A+x1RKgvRxeLtxhgSRYhc22JV3f
         u2v6PVZf+w/MMZceUtCaHbOS4XAZX12ig5UKJdD4FMR5yrEFYDrj/MkEKHgLsg/KLUZZ
         9g4ndTnizuq96fyWyHy7kpIYU+ycJVlBOul75/T43xyu+aF/RWSnuR8Sgn4fqHoP0Lue
         a0qw==
X-Gm-Message-State: AOAM531d8/twaZM53A+VufVATnJKadIDBD/icOtwXiChozIQbnYz2pB2
        T7EGpV0I8IH0NtQB0GV71mIIEgZuOlMjOyx9da8u3K+9mS8=
X-Google-Smtp-Source: ABdhPJyrJ9apwrr5FaMIfzcQ9ld6Qmz33P3iz7zWrO1ICT0RMU/d5aKk5lz1OD/UvnWVFy9olHqWWiAN6TSrFMyj6k0=
X-Received: by 2002:a05:6830:93:: with SMTP id a19mr6219795oto.345.1613241301955;
 Sat, 13 Feb 2021 10:35:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <dc26881e4ed3447c6efdcd492463be294f99b8c4.1612970140.git.gitgitgadget@gmail.com>
 <xmqqsg60u49i.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqsg60u49i.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 13 Feb 2021 10:34:50 -0800
Message-ID: <CABPp-BF_cj1GEYT75aj9funUk1mYvtM2OvKiNb1JAZzA6E5mgQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] diffcore-rename: complete find_basename_matches()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 12, 2021 at 5:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     /* Now look for basename matchups and do similarity estimation */
> > +     for (i = 0; i < num_src; ++i) {
> > +             char *filename = rename_src[i].p->one->path;
> > +             const char *base = NULL;
> > +             intptr_t src_index;
> > +             intptr_t dst_index;
> > +
> > +             /* Find out if this basename is unique among sources */
> > +             base = get_basename(filename);
> > +             src_index = strintmap_get(&sources, base);
> > +             if (src_index == -1)
> > +                     continue; /* not a unique basename; skip it */
> > +             assert(src_index == i);
> > +
> > +             if (strintmap_contains(&dests, base)) {
> > +                     struct diff_filespec *one, *two;
> > +                     int score;
> > +
> > +                     /* Find out if this basename is unique among dests */
> > +                     dst_index = strintmap_get(&dests, base);
> > +                     if (dst_index == -1)
> > +                             continue; /* not a unique basename; skip it */
>
> It would be a lot easier to read if "we must have the same singleton
> in dests" in a single if condition, I suspect.  I.e.
>
>                 if (strintmap_contains(&dests, base) &&
>                     0 <= (dst_index = (strintmap_get(&dests, base)))) {

I can change that.  I can also simplify it further to

        if (0 <= (dst_index = (strintmap_get(&dests, base)))) {

since dests uses a default value of -1.  That will decrease the number
of strmap lookups here from 2 to 1.

> It is a bit sad that we iterate over rename_src[] array, even though
> we now have a map that presumably have fewer number of entries than
> the original array, though.

Oh, interesting; I forgot all about that.  I just looked up my
original implementation from February of last year and indeed I had
done exactly that
(https://github.com/newren/git/commit/43eaec6007c92b6af05e0ef0fcc047c1d1ba1de8).
However, when I added a later optimization that pairs up non-unique
basenames, I had to switch to looping over rename_src.

For various reasons (mostly starting with the fact that I had lots of
experimental ideas that were tried and thrown out but with pieces kept
around for ideas), I wasn't even close to having a clean history in my
original implementation of merge-ort and the diffcore-rename
optimizations.  And it was far, far easier to achieve the goal of a
clean history by picking out chunks of code from the end-state and
creating entirely new commits than attempting to use my existing
history.  But, of course, that method made me lose this intermediate
state.

>
> > +                     /* Ignore this dest if already used in a rename */
> > +                     if (rename_dst[dst_index].is_rename)
> > +                             continue; /* already used previously */
>
> Since we will only be matching between unique entries in src and
> dst, this "this has been used, so we cannot use it" will not change
> during this loop.  I wonder if the preparation done in the previous
> step, i.e. [PATCH v3 2/5], can take advantage of this fact, i.e.  a
> dst that has already been used (in the previous "exact" step) would
> not even have to be in &dests map, so that the strintmap_contains()
> check can reject it much earlier.

Good, catch again.  The previous step (v4 2/5) actually did already
check this, so this if-condition will always be false at this point.
Looking at the link above, this if-condition check wasn't there in the
original, but again was added due to altered state introduced by a
later optimization.  So, I should pull this check out of this patch
and add it back in to the later patch.

> Stepping back a bit, it appears to me that [2/5] and [3/5] considers
> a source file having unique basename among the sources even if there
> are many such files with the same basename, as long as all the other
> files with the same basename have been matched in the previous
> "exact" phase.  It probably does the same thing for destination
> side.
>
> Intended?
>
> It feels incompatible with the spirit of these two steps aim for
> (i.e. only use this optimization on a pair of src/dst with UNIQUE
> basenames).  For the purpose of "we only handle unique ones", the
> paths that already have matched should participate in deciding if
> the files that survived "exact" phase have unique basename among
> the original inpu?

Yeah, I should have been more careful with my wording.  Stated a
different way, what confidence can we associate with an exact rename?
Obviously, the confidence is high as we mark them as renames.  But if
the confidence is less than 100%, and enough less than 100% that it
casts a doubt on "related" inexact renames, then yes the basenames of
the exact renames should also be computed so that we can determine
what basenames are truly unique.  By the exact same argument, you
could take this a step further and say that we should calculate the
basenames of *all* files in the tree, not just add/delete pairs, and
only match up the ones via basename that are *truly* unique.  After
all, break detection exists, so perhaps we don't have full confidence
that files with an unchanged fullname are actually related.

From my view, though, both are too cautious and throwing out valuable
heuristics for common cases.  Starting with break detection, it is off
for a reason: we think unchanged filename is a strong enough heuristic
to just match up those files and consider the confidence of the match
in effect 100%.  Similarly, we put a lot of confidence in exact rename
detection.  If there are multiple adds/deletes with the same basename,
and all but one on each side are paired up by exact rename detection,
aren't the remaining two files a (very) likely rename pair?  I think
so, and believe they're worth including in the basename-based rename
detection step.  We do require basename-based matches to meet a much
higher similarity scoring threshold now, which I feel already
adequately adjusts for not doing full content similarity against all
other files.

Also, in the next series, I find an additional way to match up files
by basename when basenames are not unique, and which doesn't involve
pairwise comparing all the files with the same basename.  I only pick
at most one other file to compare to (and the selection is not
random).  So, my overall strategy for these two series is "find which
basenames are likely matches" even if I didn't word it very well.

I do agree, though, that I should add some more careful wording about
this in the series.  I'll include it in a re-roll.
