Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24186C433E0
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 23:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C5D64E3D
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 23:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhBCXIR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 18:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbhBCXHS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 18:07:18 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAD4C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 15:06:38 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id x19so296081ooj.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 15:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKvXyxNesLHeVc6TGTsvTCjF7T2MlUkuNVfFu0+wloY=;
        b=n6vCG+Ob+j1I4fz7IWQZVD6AnGJYGP1MLizuZbJgRFN4boRmUU12RV2Xuncj168ChR
         XryJn+AXoQ5wf++si9can8AW3GG/cUDiXneFKC42SD8Z1+aPdGh/c5UjX/YpW1qhKgUg
         0RQunZN4mWy0e7jmFyBaQTbSzXtIZoZKtd8i1bbDY31qKsFWaY8Y7VCP5taaY2RVpPnF
         frblUQ6cdrJCZYqvJaUqWocvB1Ss/VdEFwVQcZLe19NZlKAIS+vIfDORk0tfSwnES8EJ
         gZAoEpSElwWiQ/qqcsEeZ3b/NpRjS0EyU2WerYtrClgeDJi2sXBFMVQawHodShUcZstD
         l21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKvXyxNesLHeVc6TGTsvTCjF7T2MlUkuNVfFu0+wloY=;
        b=TrNrXDLtg+5hFh/nVDU6ISeaZl32qbo9Hyi6yd6v6o6YEDoJUVoQAFe1GZ+rvsKBN1
         WxGJiNI5HLwQjj5mnvyIs0mr716zV6bR7yF8NZxePZkmPx6/ULjlRn1opGr1EMLgxAWO
         aDHib0LOSf7eh2nmF2UK2OMjorwJEtYD4YzIygr+ue1RdyXo6sPUE1SIRUhryfjMX1/4
         GuApvX4qVz1XDywCYIv1xLZzKJqmLglHT79ZreBeZtf4qbFf1GzJeIWvuTuehtmYsSzI
         rEQQLr+gSaMurAznCtv7KTs04mRlPVbchcDvkOBrwCxC0FVK/TZ2XLthAadehMQjgV93
         AksQ==
X-Gm-Message-State: AOAM531juVZ2AmOQ0CDdgzGgij+F90PX8B9DKCryFk1FnZOpk+TijIYL
        4qnQzK2VbMbrH9HM4FwzsxDXnfEtNzdHP8jhCFo=
X-Google-Smtp-Source: ABdhPJzvFrW/F60+QJLk+xPZTlmhx7B7s+qHsguv0gV//y1WjXeLxIBqB9PnxszOJQpKjRpJzujtq4ap37pzrMeYNrY=
X-Received: by 2002:a4a:d789:: with SMTP id c9mr2185862oou.45.1612393597549;
 Wed, 03 Feb 2021 15:06:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <pull.842.v2.git.1612382628.gitgitgadget@gmail.com> <xmqqlfc4byt6.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfc4byt6.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Feb 2021 15:06:26 -0800
Message-ID: <CABPp-BEgwfv70NRGgyAnHnQBPx4APSyYxNCbvH9F=7WGSj4DLQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Optimization batch 6: make full use of exact renames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 1:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This series depends on en/merge-ort-perf and makes full use of exact
> > renames; see commit messages for details.
> >
> > Thanks to Stolee and Junio for reviewing v1.
> >
> > Changes since v1:
> >
> >  * Update rename_src_nr when updating rename_src
> >  * Introduce want_copies in the first patch and use it in a few more places
> >  * Move a comment below a few exit-early if-checks.
> >
> > Elijah Newren (2):
> >   diffcore-rename: no point trying to find a match better than exact
> >   diffcore-rename: filter rename_src list when possible
> >
> >  diffcore-rename.c | 69 +++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 61 insertions(+), 8 deletions(-)
>
> Thanks, these look bettrer.
>
> With these changes, I guess there are only two things I find myself
> somewhat embarrassing in the rename machinery that is still there
> since I invented it.
>
>  - We still need to go full matrix while finding the "best"
>    pairing.  I cannot think of a way to avoid it (that is what makes
>    it embarrassing) but wish there were some way to.

It turns out that exact renames aren't the only thing that can reduce
the size of the matrix.  My next few series will add some more.

The matrix does remain, even at the end of all my performance work,
but multiple ways to shrink it certainly help a lot.

>    In an early attempt, I tried to retire rename_src[j], once
>    rename_dst[i] has been found to be a "good enough" match for it,
>    from the pool of rename src candidates to find a good match for
>    rename_dst[k] for i < k, but naive implementation of it would not
>    work well for obvious reasons---rename_src[j] may match a lot
>    better with rename_dst[k] than rename_dst[i] but we do not know
>    that until we try to estimate similarity with rename_dst[k].

You may really like the next two series I submit.  I have a smarter
way to find a "good enough" match (comparing to exactly one other file
and often finding sufficient similarity), and one that'll make
intuitive sense to users.

Then I have other series after those that optimize in different ways.

>  - The .cnt_data member was designed to be a concise summary of the
>    blob characteristics so that two .cnt_data can be "compared"
>    fairly cheaply to see how "similar" two blobs are [*], but (1) it
>    is rather big to be called a "concise summary", and (2) it was
>    not chosen after real performance measurement, and we've been
>    using it for the past 15 years without revisiting its design.

.cnt_data seemed kind of clever to me, though it did have a few things
that seemed surprising:

1) Small "lines".  The similarity works by mapping each "line" to an
integer using some simple hash, and keeps track of the list of hashed
integers for each file.  Once you have a list of hashed integers for
each file, similarity is determined by looking through the two lists
for two files and seeing what percentage of integers is found in both
(but see item #3 for how percentage is defined).  One special
consideration here was "lines".

I think because of a desire to handle binary files, there was a
decision to split at 64-bytes or LF, whichever comes first, so each
real line of code might be broken into multiple "lines".  The 64-bytes
thing might make things a little weird, though.  If you have a lot of
lines that are just over 64-characters long, they'll be split into two
"lines", with the second ones being very short.  Really short lines
are much more likely to look like other really short lines, which
might pad your similarity count.  I'm not sure what to do differently,
though.

2) Size-agnostic hashing.  The integer that each "line" is mapped to
is strictly between 0 and HASHBASE-1, where HASHBASE is #define'd to
107927.

By the pigeon-hole principle, since this hash size is fixed, any two
sufficiently large files will be marked by this algorithm as similar.
I created some testcases and verified that this was indeed true.  I
created two files at random using disjoint "alphabets" (e.g. one file
only contained letters, the other file only contained digits), and
found that at a certain size the algorithm would always return >50%
similarity.  The size was somewhere between 1MB and 8MB; I can't find
the table where I recorded that anymore.  So, basically, sufficiently
large files that are sufficiently close in size (since the algorithm
checks for size similarity as an optimization) will always be marked
as a rename or copy.  I think we haven't gotten reports of this "bug"
because files that large are for all intents and purposes binaries
that people likely won't modify.  And if they do modify the files,
then they'll conflict, but people won't look at the files to resolve
the conflict; instead, they'll generate a new "good" binary externally
and then stick it into place.  I investigated this just a little bit,
and even considered turning off rename detection for sufficiently
large files, but sizes aren't available until the tight inner loop and
adding any extra checking there actually costs enough to offset most
any benefit.  There might have been a way to avoid that, but
ultimately I just dropped the issue and did nothing.

3) It uses a similarity measure that diverges from what researches
used for MinHash and other fancy algorithms.  In particular,

   size(A intersect B) / size(A union B)  != size(A intersect B) /
max(size(A), size(B))

The formula on the right hand side would mean that if file A is a
subset of file B, say the first 10% of file B, then it will be treated
as 100% similar when most humans would look at it and say it is only
10% similar.  The MinHash definition for similarity measure seems like
it makes more sense...though if people have been passing numbers like
"60%" to -M, then this change of definition will force them to
recalibrate what numbers they pass.  I think it'd be really nice to
use the MinHash definition and that it might even fix bugs to do so,
but I was worried folks might perceive it as a backward incompatible
change if they need to recalibrate their numberings.

So, I ultimately didn't do anything here either...yet.  But this is
the one that I'd most like to do something about.  Are others
concerned about the possible need to recalibrate, or is that okay?
Maybe the performance gains I'm adding elsewhere will offset possible
grumpy users?

>    Side note: In a very early prototype, the approach to assess
>    similarity between two blobs was very different---there was no
>    attempt to compute "concise summary" for each blob, but we just
>    attempted to create delta (as in the pack data) between src and
>    dst blobs and measured how small a delta we can use to transform
>    from src to dst.

Interesting; I didn't know that.
