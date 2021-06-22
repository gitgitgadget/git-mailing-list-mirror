Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7544C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4DF6128A
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 08:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFVIFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhFVIFG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 04:05:06 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB156C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:02:50 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso5157882ooc.13
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpGQE54qHTpO8NweTV/AbbymuZ4cb9qHa8SXBCm8yM8=;
        b=eAvYNXtD69FPO0FSE5bxXXfHMD5Yl02q1WlR5RIUajLX5Oa1MONPXDvoB97mbCve5Z
         resMUSXgstLUERE+dOF2xkvUSwZEuzWwy6dkGRPlMfPogLIch8I53C0ReCv2dGJbw1kC
         PRJcuttexzsxbiwpUUYi+HMZMHGuZqrlUSGIVCAMPzxT/9Tm4QB21jAev0tINK96pC+N
         1uX2ZoTY8kqLG/wJhK4HV9ZOZP4z7M7d7Qs4CNyOhLEgWCGhyVGkuvi5sSCklIrlPxE0
         stqcXjSdR6H3pwNxl+uzcXnYEuef7s4sJPIj9ZuF71tT7dLsKJP/VdXoYI6oJdlEKR1q
         l0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpGQE54qHTpO8NweTV/AbbymuZ4cb9qHa8SXBCm8yM8=;
        b=jLgn5NCWps7SyUb6KoI7kn+f/tcNtYV/ir8oFDbubP1G/1g3v007kfzjLi3P0fAy2k
         N/bdDRxm/bdobkh1OhnIy2KRpLoiT0cE6HKaA0u7EZBgEbxn+5tSnzg+g0ZmAomWgb8y
         82uMFxAh9MT90NTVX10fCskdFVNlhKWDCMFyNCbT5UFxfq7YgKApRtUSuPDgegiQpAJX
         KERxbyivxbNHQM6BDYG7Yt8Fg9u42AKe+6byabxwC5mrnorkkXHPqChbPRbTzTvkUX5K
         buxbb+1PCj+HxEQF0C9ct/CzA+YQKBHkzDwxZZlg5yHCBTnpPrRja+fHd1bMhwqj2R+p
         OhWA==
X-Gm-Message-State: AOAM532cL+i13H4Zw/27SLOvFcxfC6dtTRtkC4prw4i6bNgKrv/vsuxR
        6eFnaeLHdxfOWVUcr9sAIgS5QwvEQI0qGDH2xoQ=
X-Google-Smtp-Source: ABdhPJxQVeoKt9jpVRTZvvFUQzLGNwN+fLPJgpb9HSHnDMxL/FMilmXbt6FZjYLxNXBu52Rkm8rjqf/vYkaBMwHH4+4=
X-Received: by 2002:a4a:d312:: with SMTP id g18mr2150336oos.7.1624348970185;
 Tue, 22 Jun 2021 01:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
 <pull.969.v2.git.1623796907.gitgitgadget@gmail.com> <317bcc7f56cb718a8be625838576f33ce788c3ef.1623796907.git.gitgitgadget@gmail.com>
 <xmqqfsxhm69b.fsf@gitster.g>
In-Reply-To: <xmqqfsxhm69b.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Jun 2021 01:02:38 -0700
Message-ID: <CABPp-BEEUD6UUuL4RmFfgukE=bm4CQjZ2Jy0ZmMaQVaA-Es+zQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] merge-ort: add prefetching for content merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 10:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +             /* Ignore clean entries */
> > +             if (ci->merged.clean)
> > +                     continue;
> > +
> > +             /* Ignore entries that don't need a content merge */
> > +             if (ci->match_mask || ci->filemask < 6 ||
> > +                 !S_ISREG(ci->stages[1].mode) ||
> > +                 !S_ISREG(ci->stages[2].mode) ||
> > +                 oideq(&ci->stages[1].oid, &ci->stages[2].oid))
> > +                     continue;
> > +
> > +             /* Also don't need content merge if base matches either side */
> > +             if (ci->filemask == 7 &&
> > +                 S_ISREG(ci->stages[0].mode) &&
> > +                 (oideq(&ci->stages[0].oid, &ci->stages[1].oid) ||
> > +                  oideq(&ci->stages[0].oid, &ci->stages[2].oid)))
> > +                     continue;
>
> Even though this is unlikely to change, it is unsatisfactory that we
> reproduce the knowledge on the situations when a merge will
> trivially resolve and when it will need to go content level.

I agree, it's not the nicest.

> One obvious way to solve it would be to fold this logic into the
> main code that actually merges a list of "ci"s by making it a two
> pass process (the first pass does essentially the same as this new
> function, the second pass does the tree-level merge where the above
> says "continue", fills mmfiles with the loop below, and calls into
> ll_merge() after the loop to merge), but the logic duplication is
> not too big and it may not be worth such a code churn.

I'm worried even more about the resulting complexity than the code
churn.  The two-pass model, which I considered, would require special
casing so many of the branches of process_entry() that it feels like
it'd be increasing code complexity more than introducing a function
with a few duplicated checks.  process_entry() was already a function
that Stolee reported as coming across as pretty complex to him in
earlier rounds of review, but that seems to just be intrinsic based on
the number of special cases: handling anything from entries with D/F
conflicts, to different file types, to match_mask being precomputed,
to recursive vs. normal cases, to modify/delete, to normalization, to
added on one side, to deleted on both side, to three-way content
merges.  The three-way content merges are just one of 9-ish different
branches, and are the only one that we're prefetching for.  It just
seems easier and cleaner overall to add these three checks to pick off
the cases that will end up going through the three-way content merges.
I've looked at it again a couple times over the past few days based on
your comment, but I still can't see a way to restructure it that feels
cleaner than what I've currently got.

Also, it may be worth noting here that if these checks fell out of
date with process_entry() in some manner, it still would not affect
the correctness of the code.  At worst, it'd only affect whether
enough or too many objects are prefetched.  If too many, then some
extra objects would be downloaded, and if too few, then we'd end up
later fetching additional objects 1-by-1 on demand later.

So I'm going to agree with the not-worth-it portion of your final
sentence and leave this out of the next roll.
