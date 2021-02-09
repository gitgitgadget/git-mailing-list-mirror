Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85912C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3930964E54
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhBIRSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhBIRSD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:18:03 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6230C061756
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:17:23 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id g84so6406913oib.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22sDOB6xW4BIepbtOhNx/m2LUOs00qcV06mNNE3VIk0=;
        b=Y8V4lh4UlHRaGoocdu3v0dU4nFERVgudnIpF9ZZyL3ozaYFkqmzMSJ4yllAQa8LMOJ
         Sj+s1zoG2zU9ahQ88g+lZ7Cc88TLDxKOwGACE83cVxg0SXq5G5paXaVK/8x0p+q50/a7
         LnBcodEaPlF/s4pMraGwIWh84BOvjHooSTzcs1DtN/PMONHzJ1XyypcCc6h0mq6BcOBy
         +gdJyqliQtkxBbnYHTSUdMjRBODkJKsHFv48PDM/lLXRgnVfeu8FhG4Ho1jsEAX4ToTT
         kDQRdKvQohNiLppG4EikYQgr6hV0ExgDRFJXXp9YOtcCgm3Yl5TkIV+61rCVCtSQIBAk
         CL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22sDOB6xW4BIepbtOhNx/m2LUOs00qcV06mNNE3VIk0=;
        b=h9Do/+jD+X3sm0ihbkyl5uXeWYS3z/aRo4UXdEu/6L5U2LJ+gUXMcko3uPndjgsKUW
         Kxg2AUasmpoagKZTEVj/shOvV+p23OA69+kctCDw30HCjPos+CSzG9fEVwRGFpg3S7ue
         +OVsnXI31s8oqV/HTmQBSfVvG3ygN+ohd+wF6ofNrb3LcVdH3rgcUmc/dEszwEA8Asjh
         /i3oX+G1Kpdv8ek+xzLjfUN6NuRfUay5DD3YV9xUZa7qJ4h19UN/fExSKeOG6na7lb09
         7KVrdFy7/IPtoUu54dn0ZQH6ZTcC5hPr78kBqFFUFdOWJ4YlcMuyWsgeqCcX8nOA1dDZ
         cHuQ==
X-Gm-Message-State: AOAM531MTpyTTXMeSEHVVaTOezhTxdDCH58rW/k4jnimkWxKgKcyy97B
        u0tz+zOyBfhQ9ZCBvLrqSYllSUTVDdBSJVy0wu1+D+lDmYk=
X-Google-Smtp-Source: ABdhPJxjgvg2CFMLoFMeUjVNH+4bHvBQ6sg1HxIvbvBBvWFRHTqGU1hUrhu3YUv/aoNLgS5TimPJO/IrbnPfbXCE0ug=
X-Received: by 2002:a54:4790:: with SMTP id o16mr3113857oic.39.1612891043169;
 Tue, 09 Feb 2021 09:17:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com> <dcd0175229aa6fba576425e78875b95385acb58d.1612870326.git.gitgitgadget@gmail.com>
 <b64e30ab-9cb3-ffee-ec5e-1b94529ce636@gmail.com>
In-Reply-To: <b64e30ab-9cb3-ffee-ec5e-1b94529ce636@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 09:17:11 -0800
Message-ID: <CABPp-BEz7ZUUUPF6EkK0RzWq5O=kYbNFFtg=iMbk607kQ-nmbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] diffcore-rename: complete find_basename_matches()
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 5:25 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/9/2021 6:32 AM, Elijah Newren via GitGitGadget wrote:
> > +     /*
> > +      * When I checked, over 76% of file renames in linux just moved
>
> Perhaps "In late 2020," instead of "When I checked".

In early 2020 (in fact, it might have been 2019, but I have no records
to verify the actual year), but sure I can change that.

> > +      * files to a different directory but kept the same basename.  gcc
> > +      * did that with over 64% of renames, gecko did it with over 79%,
> > +      * and WebKit did it with over 89%.
> > +      *
> > +      * Therefore we can bypass the normal exhaustive NxM matrix
> > +      * comparison of similarities between all potential rename sources
> > +      * and destinations by instead using file basename as a hint, checking
> > +      * for similarity between files with the same basename, and if we
> > +      * find a pair that are sufficiently similar, record the rename
> > +      * pair and exclude those two from the NxM matrix.
> > +      *
> > +      * This *might* cause us to find a less than optimal pairing (if
> > +      * there is another file that we are even more similar to but has a
> > +      * different basename).  Given the huge performance advantage
> > +      * basename matching provides, and given the frequency with which
> > +      * people use the same basename in real world projects, that's a
> > +      * trade-off we are willing to accept when doing just rename
> > +      * detection.  However, if someone wants copy detection that
> > +      * implies they are willing to spend more cycles to find
> > +      * similarities between files, so it may be less likely that this
> > +      * heuristic is wanted.
> > +      */
> > +
> > +     int i, renames = 0;
> >       struct strintmap sources;
> >       struct strintmap dests;
>
> ...
>
> > +      * copy detection.  find_basename_matches() is only used when detecting
> > +      * renames, not when detecting copies, so it'll only be used when a file
> > +      * only existed in the source.  Since we already know that the file
>
> There are two "only"s in this sentence. Just awkward, not wrong.
>
> > +      * won't be unmodified, there's no point checking for it; that's just a
> > +      * waste of resources.  So set skip_unmodified to 0 so that
> > +      * estimate_similarity() and prefetch() won't waste resources checking
> > +      * for something we already know is false.
> > +      */
> > +     int skip_unmodified = 0;
> > +
>
>
>
> > -     /* TODO: Make use of basenames source and destination basenames */
> > +     /* Now look for basename matchups and do similarity estimation */
> > +     for (i = 0; i < num_src; ++i) {
> > +             char *filename = rename_src[i].p->one->path;
> > +             char *base = NULL;
> > +             intptr_t src_index;
> > +             intptr_t dst_index;
> > +
> > +             /* Get the basename */
> > +             base = strrchr(filename, '/');
> > +             base = (base ? base+1 : filename);
>
> Here is the third instance of this in the same function. At minimum we should
> extract a helper for you to consume.

Where by "this" you mean these last two lines, right?

And perhaps explain why I'm not using either basename(3) or
gitbasename() from git-compat-util.h?  (The latter of which I just
learned about while responding to the review of this patch.)

or maybe gitbasename can do the job, but the skip_dos_drive_prefix()
and the munging of the string passed in both worry me.  And the
is_dir_sep() looks inefficient since I know I'm dealing with filenames
as stored in git internally, and thus can only use '/' characters.
Hmm...

Yeah, I think I'll add my own helper in this file, since you want one,
and just use it.

> > +             /* Find out if this basename is unique among sources */
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
> > +
> > +                     /* Ignore this dest if already used in a rename */
> > +                     if (rename_dst[dst_index].is_rename)
> > +                             continue; /* already used previously */
> > +
> > +                     /* Estimate the similarity */
> > +                     one = rename_src[src_index].p->one;
> > +                     two = rename_dst[dst_index].p->two;
> > +                     score = estimate_similarity(options->repo, one, two,
> > +                                                 minimum_score, skip_unmodified);
> > +
> > +                     /* If sufficiently similar, record as rename pair */
> > +                     if (score < minimum_score)
> > +                             continue;
> > +                     record_rename_pair(dst_index, src_index, score);
> > +                     renames++;
> > +
> > +                     /*
> > +                      * Found a rename so don't need text anymore; if we
> > +                      * didn't find a rename, the filespec_blob would get
> > +                      * re-used when doing the matrix of comparisons.
> > +                      */
> > +                     diff_free_filespec_blob(one);
> > +                     diff_free_filespec_blob(two);
> > +             }
> > +     }
>
> Makes sense to me.
>
> Thanks,
> -Stolee
