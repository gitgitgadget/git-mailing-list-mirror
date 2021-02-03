Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD9C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 16:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2CF64E4F
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 16:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhBCQci (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 11:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhBCQcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 11:32:36 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD548C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 08:31:56 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id d18so490862oic.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrsIe3DzPXtCmREBGfc7HG7AckPKOcFdlTr5CWxFtHM=;
        b=o3cXKL/zRLlTf+xbceZ3nt5E4oz/nYNUVtGVABniQsKJPybdyZx5iUi0fRk88KK1QA
         Rgb2p5FIwVrwLpwAD7Z/xBzM00WCY/G/nTb6VlIZxE7rbldc+p9tQl/za4Axxd9NPQz+
         30clephEWhv6420xphjp3aydlmlXDHr4OoW5YGH5vfZqDPttrN2BOAVSEpBTsq3f/z0+
         rOs288onYPqANdeCNWbkhd0XQq5sq61lU0KItZkRt/1QycZb6wFngXa+1Lo54iQGLdDh
         rQMEYnqQt8WNNtmuiCgKsXvsWM5BW6FkTTFjJU8JtqmCprTAUtGY7OcLoMR0mcTV8mBD
         jJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrsIe3DzPXtCmREBGfc7HG7AckPKOcFdlTr5CWxFtHM=;
        b=LdFjpgeAw4mldqOsI0kjX95upnWCMtQGtFsDnmyvzZyqH3Vf2ZhxUM69kCQ6ZX1+rk
         0+8Z31B/2xQ3tZkLfF2mS47SQ+/SNSLeukJD4503m9EYUAb0c5+3nIqQ/N6Eso8us7R9
         s3vUTvtQ+O/1bvGA/olSz5SNX9aA3v8Gl3Top9GPyCWeIx+ksFTQGPpb8+oAfrOq0X83
         bVFmVpl21SZDPAb6PQM07pgrUGL5rkYiAC+/hH2+4t13CdQ3+lw3RoM5mJHVfTkyW3yV
         +wT3BXetsB2wM9oX7HTxe17zRXFrHrAZtXYVcsW0EtNyiu+U5bFbG9WRKE79GSNwou9h
         c+3Q==
X-Gm-Message-State: AOAM531Zkg83bgOAHa2r+Sc+xf8nH+GE6jCa0YcQ5lWubQGwPy95BJwH
        1ai2bdL7AoyhPu5mLVetigBYO1lKD6rGAMWgIewQruSDV/M=
X-Google-Smtp-Source: ABdhPJwOTV0JgcPb/8MEwOBJt3ooJlLmPzrtMm+PMtMCyUx8jB79/Z06c7IJkuZurv7pooNWJ39aj0RJ5fqCtghT0/M=
X-Received: by 2002:a54:4790:: with SMTP id o16mr2495075oic.39.1612369916122;
 Wed, 03 Feb 2021 08:31:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <3e69857f37e12540f7986245b99916b68702217a.1612331345.git.gitgitgadget@gmail.com>
 <515f55bd-90e2-9a7f-0973-501c9351969e@gmail.com>
In-Reply-To: <515f55bd-90e2-9a7f-0973-501c9351969e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Feb 2021 08:31:45 -0800
Message-ID: <CABPp-BEvu1ZQ5X35dDU-Skd71ZNLWQjj9Ow2HVvdc=faSBkGiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] diffcore-rename: no point trying to find a match
 better than exact
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 3:44 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/3/2021 12:49 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > diffcore_rename() had some code to avoid having destination paths that
> > already had an exact rename detected from being re-checked for other
> > renames.  Source paths, however, were re-checked because we wanted to
> > allow the possibility of detecting copies.  But if copy detection isn't
> > turned on, then this merely amounts to attempting to find a
> > better-than-exact match, which naturally ends up being an expensive
> > no-op.  In particular, copy detection is never turned on by the merge
> > machinery.
> ...
> > +     num_sources = rename_src_nr;
> > +     if (detect_rename != DIFF_DETECT_COPY)
> > +             num_sources -= rename_count;
>
> Ok, delete the renamed files from the sources. Using a new variable
> because rename_src_nr is actually a static global to diffcore-rename.c,
> describing the number of entries in the rename_src table. This is
> scary, but I think your new local is a good way to change the local
> logic of this method without adjusting that global.

I thought about changing rename_src, rename_src_nr, rename_dst, and
rename_dst_nr to all be in some struct and make one of those on the
stack locally in diffcore_rename() and then pass that structure
around.  Would be nice to get rid of more global state.  But I've got
enough things in the queue that I never made the jump.

> >
> >       /* All done? */
> > -     if (!num_destinations)
> > +     if (!num_destinations || !num_sources)
> >               goto cleanup;
>
> And add an extra quit condition which is very possible to hit.
> Is it only hit when every "delete" is actually a rename?

Right, when every "delete" gets paired by exact rename detection to
some "add" and is marked as a rename, meaning we have no more
"deletes" to pair with anything.  In later series, there will be
additional reasons for num_sources to decrease and possibly hit 0.

> > -     switch (too_many_rename_candidates(num_destinations, rename_src_nr,
> > +     switch (too_many_rename_candidates(num_destinations, num_sources,
> >                                          options)) {
>
> This is all about checking if we need to skip inexact renames. Makes
> sense to use the new number.
>
> > +                     if (one->rename_used &&
> > +                         detect_rename != DIFF_DETECT_COPY)
> > +                             continue;
> > +
>
> Have we "consumed" this input? Skip over it. Good. And this is inside
> a double-loop:
>
>         for (dst_cnt = i = 0; i < rename_dst_nr; i++) {
>                 ...
>                 for (j = 0; j < rename_src_nr; j++) {
>
> Keeping rename_src_nr in the inner loop makes sense, but this new
> 'continue;' gives most of the speedup, I imagine.
>
> This is a nice speedup for such a simple optimization.
>
> Thanks,
> -Stolee
