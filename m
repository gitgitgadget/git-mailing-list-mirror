Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6210C433E9
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A9464E40
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhBCTUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhBCTUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 14:20:31 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65110C0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 11:19:51 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id d18so1074293oic.3
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 11:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZDtSzjpop2aCqUJ+3/vdXKNQNWUWR4A3Wp7sHuMi1TI=;
        b=Gcb508JtESS54SxhOilrTl59wZIJRquKDT20hR0HBLfquwr1fuj3LDWhkqkOWxo3Dv
         DXer2anPEgQalNTnomo3EB6zGpdx4/x+OMgqZKHpp1EF32A2IDLxQQT4QCiWIMkXIPiQ
         vfKAREVefTVw4MYl0NYg4BJA50IHVpbOXeCYrHw+k7N08dqNQot7XBNGcFLfrlIeC1OV
         zvX2nxs2/ShcuKDh9j82C9kdLblFZAF+LZcxxR3PG0pijH3HOOHPgX1WOn8kzcxB1Qm5
         WfbGZZ0p+P2HCz8oM/vy4p1acmefNc6z1X8iXBZF6/EGQ1sZD25SmjtjQmhXTj686qN8
         46CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDtSzjpop2aCqUJ+3/vdXKNQNWUWR4A3Wp7sHuMi1TI=;
        b=gWRYm+U1beXRiAyRhRk0MQhGUl0zE2bFdy7GggDrRd05c9LRcI1lbe02z5stn6VEgc
         /03+iE4TmgRBc8+7iO9kQroq4iV6BGdvE+YJcrOHnqkd9BUnWo5nGAmkdc7sXKrSQgAv
         XFp9LrhOpfBb8c0wEm+hncBBYo6CrXPp4UpSqEbA7pDLpzwBMXg6h4uGxzzrXLRkkg5m
         QYUGtbDN8YtIKxbLkzeolPIHPl7QZ2DVx1EA1y3+piITBGC4n8N0EkbQYVH87XKq8Ara
         iAgMJl7lcMcazKGIfBz3agzKqFCYGzqD041WNh2RczXgo5/CtFy7v14IN8AivxQKzfjo
         HyQQ==
X-Gm-Message-State: AOAM533ZOGY3f51hca6CQYcVyn5aYkMaiYLYCzd3RsV+MLzKIxXwoO0X
        rb4GbIbRumgPkjnQHjIyvjXc74buCP3TD9zbmEk=
X-Google-Smtp-Source: ABdhPJwV0+qvJpctOpxmvw7zpgHEWCRy/NI2qzHO9D1HYS/OUIyNL0x3P2o5K02I1WVrKyhtc5PkdbEUg9rfwtD24D0=
X-Received: by 2002:a54:4790:: with SMTP id o16mr2946165oic.39.1612379990815;
 Wed, 03 Feb 2021 11:19:50 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <580ba9a10f54c7a2e7f28d60395fc2edae25eec1.1612331345.git.gitgitgadget@gmail.com>
 <xmqqbld1c6dz.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbld1c6dz.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Feb 2021 11:19:39 -0800
Message-ID: <CABPp-BGm6A7vrkehQx0br4h-D8vDNJAB+oEOdkTrzvD3OM+BQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] diffcore-rename: filter rename_src list when possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 11:12 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static int remove_unneeded_paths_from_src(int num_src,
> > +                                       int detecting_copies)
> > +{
> > +     int i, new_num_src;
> > +
> > +     /*
> > +      * Note on reasons why we cull unneeded sources but not destinations:
> > +      *   1) Pairings are stored in rename_dst (not rename_src), which we
> > +      *      need to keep around.  So, we just can't cull rename_dst even
> > +      *      if we wanted to.  But doing so wouldn't help because...
> > +      *
> > +      *   2) There is a matrix pairwise comparison that follows the
> > +      *      "Performing inexact rename detection" progress message.
> > +      *      Iterating over the destinations is done in the outer loop,
> > +      *      hence we only iterate over each of those once and we can
> > +      *      easily skip the outer loop early if the destination isn't
> > +      *      relevant.  That's only one check per destination path to
> > +      *      skip.
> > +      *
> > +      *      By contrast, the sources are iterated in the inner loop; if
> > +      *      we check whether a source can be skipped, then we'll be
> > +      *      checking it N separate times, once for each destination.
> > +      *      We don't want to have to iterate over known-not-needed
> > +      *      sources N times each, so avoid that by removing the sources
> > +      *      from rename_src here.
> > +      */
> > +     if (detecting_copies)
> > +             return num_src; /* nothing to remove */
> > +     if (break_idx)
> > +             return num_src; /* culling incompatbile with break detection */
> > +
> > +     for (i = 0, new_num_src = 0; i < num_src; i++) {
> > +             /*
> > +              * renames are stored in rename_dst, so if a rename has
> > +              * already been detected using this source, we can just
> > +              * remove the source knowing rename_dst has its info.
> > +              */
> > +             if (rename_src[i].p->one->rename_used)
> > +                     continue;
> > +
> > +             if (new_num_src < i)
> > +                     memcpy(&rename_src[new_num_src], &rename_src[i],
> > +                            sizeof(struct diff_rename_src));
> > +             new_num_src++;
> > +     }
> > +
> > +     return new_num_src;
> > +}
>
> Essentially we are compacting rename_src[] array from num_src
> elements down to new_num_src elements; we are losing pointers, but I
> presume these are all borrowed pointers that we do not own and we
> are not responsible for freeing?  If we were to free them, the
> compaction would leave duplicates after the new tail (new_num_src)
> and we'd end up having to worry about double-freeing, so hopefully
> all we need to do is just to free the entire array of pointers, and
> not the pointees.
>
> Having to do this just once and being able to reduce the number of
> entries we need to iterate over does sound like a good simple
> optimization.

Correct, they are all just borrowed pointers and we only need to free
the array, not the pointers within the array.

> >  void diffcore_rename(struct diff_options *options)
> >  {
> >       int detect_rename = options->detect_rename;
> > @@ -463,10 +512,11 @@ void diffcore_rename(struct diff_options *options)
> >       struct diff_score *mx;
> >       int i, j, rename_count, skip_unmodified = 0;
> >       int num_destinations, dst_cnt;
> > -     int num_sources;
> > +     int num_sources, want_copies;
> >       struct progress *progress = NULL;
> >
> >       trace2_region_enter("diff", "setup", options->repo);
> > +     want_copies = (detect_rename == DIFF_DETECT_COPY);
> >       if (!minimum_score)
> >               minimum_score = DEFAULT_RENAME_SCORE;
> >
> > @@ -529,13 +579,10 @@ void diffcore_rename(struct diff_options *options)
> >               goto cleanup;
> >
> >       /*
> > -      * Calculate how many renames are left (but all the source
> > -      * files still remain as options for rename/copies!)
> > +      * Calculate how many renames are left
> >        */
> >       num_destinations = (rename_dst_nr - rename_count);
> > -     num_sources = rename_src_nr;
> > -     if (detect_rename != DIFF_DETECT_COPY)
> > -             num_sources -= rename_count;
> > +     num_sources = remove_unneeded_paths_from_src(rename_src_nr, want_copies);
>
> OK, this is in a sense an extended version of the previous step.
>
> I am not sure if rename_src_nr can be left out of sync with reality
> like this patch does, though.  The reference to that variable in
> register_rename_src() and find_exact_renames() are OK as we are not
> going to call them after we futz with the rename_src[] array, but
> the reference in prefetch(), which does not actually happen early
> but only when we start running estimate_similarity(), which is after
> we compacted the rename_src[] array, would be affected, no?

Yes, good catch.  This is the same issue Stolee caught.  I did set
rename_src_nr to the new num_sources in my "ort" branch, but when
breaking up the changes to upstream them, that line of code somehow
got separated into a later patch (that I haven't submitted yet) and I
just didn't notice it when reviewing this early series.  It belongs in
this patch as both of you pointed out.
