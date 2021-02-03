Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1DAC433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A8464E93
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 17:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhBCRNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhBCRNi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 12:13:38 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFEC0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 09:12:59 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id k25so567013oik.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Efc/V799mE9VEstmK7X5SOmboyWqUMoSXZEDZqdWnSo=;
        b=tRDjVxxANJwZEcHlvU/U85+qu/IGeb+wYY8iTOaiWw8q3+2IqZFROeEDT/9H7bGlNy
         0UOh8omW2d9X5MVCVgsPHys4tvbnzJ0X73YznohM4NxnJsG757e8Lzy1sud9EaSPYGF+
         aEUw954J4OxXbHxk0zL9+qP1OC9qe9x/hFONRf66MW5r/3tjBpes4x7EuzqOs2fB37DR
         4qhar3+70hCNigEquC9XNnF1dNMymkYquVOWvj25KtLkSpcxLA0stGz2iqWcCC70mRim
         j042scG4rSUI9upCnwFUHpjuD7w00vMO95zfac+0Jna1Ik6g2CILc/LPHCnT1iFfJX17
         SC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Efc/V799mE9VEstmK7X5SOmboyWqUMoSXZEDZqdWnSo=;
        b=pDWdhazx4GcqHxFy+jrjoq6pfZ/UxwIoYijx4s5Qn4eRC2NWqzdTNo3gQEH+/JQARv
         y4QnGso2L+GzufOzft3tiLJx0O2BvukNRpCbJXoKymrUbM3RSTpVv2nrIriXNa4bdcp6
         DGNbAf8z1lPeuLPQAfw/i58b6L1IC+77aD+2/wveStPyjQXUebWlqBNuxmK3d+b4INW5
         z1FVb56PVt4ewyotnXcJkxgeNJHWqOCEmtYUjmWI1IRfuHqz+Wrplm8I+OOK13HC4GBT
         YuwXC00pPGclj/G5xCnzxqPJ8Tc3DiaZ6F6D/KWLLc0Ej/Ngb3qqVh+5AmxDYTBWOa6X
         p2gg==
X-Gm-Message-State: AOAM533uGY7+wznIw6hEyhU/iuLoii87llG2S8gmq245R80jEm377xml
        TY9ONrhV8AACRfRu7rgvswAxP+B0O0e0r3v276s=
X-Google-Smtp-Source: ABdhPJxLFN+bdalzcMT9nK8m1YlMCM2eu8JVQNEuFLKY9KhpNun10YOEX0BrtQrPZhWQn8GF3peeuyK3WhfiUJ/76as=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr2617780oib.167.1612372378507;
 Wed, 03 Feb 2021 09:12:58 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <580ba9a10f54c7a2e7f28d60395fc2edae25eec1.1612331345.git.gitgitgadget@gmail.com>
 <13feb106-c3a7-a26d-0e6e-013aa45c58d4@gmail.com>
In-Reply-To: <13feb106-c3a7-a26d-0e6e-013aa45c58d4@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Feb 2021 09:12:47 -0800
Message-ID: <CABPp-BG8mu4qGQCz5sMWqJHSb9o1ipk9FgxUS34SbArhQcPutQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] diffcore-rename: filter rename_src list when possible
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Karsten Blees <blees@dcon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 4:00 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/3/2021 12:49 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > We have to look at each entry in rename_src a total of rename_dst_nr
> > times.  When we're not detecting copies, any exact renames or ignorable
> > rename paths will just be skipped over.  While checking that these can
> > be skipped over is a relatively cheap check, it's still a waste of time
> > to do that check more than once, let alone rename_dst_nr times.  When
> > rename_src_nr is a few thousand times bigger than the number of relevan=
t
> > sources (such as when cherry-picking a commit that only touched a
> > handful of files, but from a side of history that has different names
> > for some high level directories), this time can add up.
> >
> > First make an initial pass over the rename_src array and move all the
> > relevant entries to the front, so that we can iterate over just those
> > relevant entries.
> >
> > For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
> > performance work; instrument with trace2_region_* calls", 2020-10-28),
> > this change improves the performance as follows:
> >
> >                             Before                  After
> >     no-renames:       14.119 s =C2=B1  0.101 s    13.815 s =C2=B1  0.06=
2 s
> >     mega-renames:   1802.044 s =C2=B1  0.828 s  1799.937 s =C2=B1  0.49=
3 s
> >     just-one-mega:    51.391 s =C2=B1  0.028 s    51.289 s =C2=B1  0.01=
9 s
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  diffcore-rename.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 57 insertions(+), 10 deletions(-)
> >
> > diff --git a/diffcore-rename.c b/diffcore-rename.c
> > index e3047da3aaf..2a8e7b84b9c 100644
> > --- a/diffcore-rename.c
> > +++ b/diffcore-rename.c
> > @@ -454,6 +454,55 @@ static int find_renames(struct diff_score *mx, int=
 dst_cnt, int minimum_score, i
> >       return count;
> >  }
> >
> > +static int remove_unneeded_paths_from_src(int num_src,
> > +                                       int detecting_copies)
> > +{
> > +     int i, new_num_src;
> > +
> > +     /*
> > +      * Note on reasons why we cull unneeded sources but not destinati=
ons:
> > +      *   1) Pairings are stored in rename_dst (not rename_src), which=
 we
> > +      *      need to keep around.  So, we just can't cull rename_dst e=
ven
> > +      *      if we wanted to.  But doing so wouldn't help because...
> > +      *
> > +      *   2) There is a matrix pairwise comparison that follows the
> > +      *      "Performing inexact rename detection" progress message.
> > +      *      Iterating over the destinations is done in the outer loop=
,
> > +      *      hence we only iterate over each of those once and we can
> > +      *      easily skip the outer loop early if the destination isn't
> > +      *      relevant.  That's only one check per destination path to
> > +      *      skip.
> > +      *
> > +      *      By contrast, the sources are iterated in the inner loop; =
if
> > +      *      we check whether a source can be skipped, then we'll be
> > +      *      checking it N separate times, once for each destination.
> > +      *      We don't want to have to iterate over known-not-needed
> > +      *      sources N times each, so avoid that by removing the sourc=
es
> > +      *      from rename_src here.
> > +      */
> > +     if (detecting_copies)
> > +             return num_src; /* nothing to remove */
> > +     if (break_idx)
> > +             return num_src; /* culling incompatbile with break detect=
ion */
>
> While the comments here are certainly descriptive, they could probably
> be sidelined to "return when culling is incompatible" with this before
> the big comment:

Yeah, I guess at this stage a bigger explanation isn't needed.  But I
think I'd end up just adding these comments back in later at an
unrelated time if I were to take them out at this point.  By the time
merge-ort is finished, I'll have over a dozen additional
optimizations, many of them in diffcore-rename.c.  There will be files
for which four different optimizations are all applicable, but they
are mutually exclusive so we have to pick one of the four and exclude
the other three.  Best results come from knowing which one provides
the best speedup and why (and which is second if the best doesn't
apply, etc.).  So what I'll present as four optimizations originally
felt to me like 10 or so different ones, because I didn't start
knowing the best, meaning I kept adding later additional optimizations
that fed the appropriate data in all the right places so that I could
tweak which one(s) took priority and get the best speedups.  You'll
get the cleaner version to review that pretends I knew the right
answers all along.  (Not to mention that I think I tried a lot more
optimization ideas that failed than the number I tried that succeeded,
and longer comments of mine sometimes highlight details that could
have prevented the need to attempt some of the failed ideas.)  Anyway,
long story short: at some point along the way, the more detailed
description felt very appropriate, but I don't have a clear breakpoint
for where that is and the longer description most logically goes along
with this early patch so I squashed it in here.  *shrug*

>         if (detecting_copies || break_idx)
>                 return num_src;
>
> This is a very minor nit pick, though.

Moving these conditions above the comment makes sense, yes.  I guess
combining the two if conditions here could also be done, though the
reasoning is different as noted by the comments so I would have to
toss the comments.  Since a later optimization will need to add an
additional condition that is only relevant for one of the two reasons,
I would just need to split again later and I think I would want the
comments back at that time.  So I think the split and keeping the
comments seems more natural to me.

> > +
> > +     for (i =3D 0, new_num_src =3D 0; i < num_src; i++) {
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
>
> 'struct diff_rename_src' is currently just a pointer and a short, so
> this is a very small amount of data, but this conditional move doesn't
> hurt.
>
> > +             new_num_src++;
> > +     }
> > +
> > +     return new_num_src;
> > +}
> > +
>
>
> >  void diffcore_rename(struct diff_options *options)
> >  {
> >       int detect_rename =3D options->detect_rename;
> > @@ -463,10 +512,11 @@ void diffcore_rename(struct diff_options *options=
)
> >       struct diff_score *mx;
> >       int i, j, rename_count, skip_unmodified =3D 0;
> >       int num_destinations, dst_cnt;
> > -     int num_sources;
> > +     int num_sources, want_copies;
> >       struct progress *progress =3D NULL;
> >
> >       trace2_region_enter("diff", "setup", options->repo);
> > +     want_copies =3D (detect_rename =3D=3D DIFF_DETECT_COPY);
>
> I was looking at this and thinking "why wasn't this in the previous
> patch?" I see that you delete the "if (detect_rename !=3D DIFF_DETECT_COP=
Y)"
> below in favor of the call to the helper.
>
> _If_ you were re-rolling, then maybe it would be slightly cleaner
> to add 'want_copies' to the previous patch?

Oh, yeah, I think that does make sense.  And you highlight some good
reasons to re-roll below, so I'll do that.

> >       /*
> > -      * Calculate how many renames are left (but all the source
> > -      * files still remain as options for rename/copies!)
> > +      * Calculate how many renames are left
> >        */
> >       num_destinations =3D (rename_dst_nr - rename_count);
> > -     num_sources =3D rename_src_nr;
> > -     if (detect_rename !=3D DIFF_DETECT_COPY)
> > -             num_sources -=3D rename_count;
> > +     num_sources =3D remove_unneeded_paths_from_src(rename_src_nr, wan=
t_copies);
>
> So here we update the local variable...
>
> >
> >       /* All done? */
> >       if (!num_destinations || !num_sources)
> > @@ -573,13 +620,13 @@ void diffcore_rename(struct diff_options *options=
)
> >               for (j =3D 0; j < NUM_CANDIDATE_PER_DST; j++)
> >                       m[j].dst =3D -1;
> >
> > -             for (j =3D 0; j < rename_src_nr; j++) {
> > +             for (j =3D 0; j < num_sources; j++) {
>
> ...and drop the use of the static global. However, don't we need to
> update the global itself? There are other loops limited by
> rename_src_nr that should only work on this smaller list, right?
>
> In particular, it seems that the prefetch() method would benefit
> from looking at this smaller list. It fetches the blob contents in
> a partial clone inside of estimate_similarity(). When there are a
> lot of exact renames but even one possible inexact rename, it seems
> to currently download the content for all of the blobs including the
> exactly-matched ones.

Ah, indeed.  The prefetch() method didn't exist at the time I wrote
this patch, but there's always the possibility of other reasons.  It
turns out I did make rename_src_nr match num_sources, but that diff
hunk got placed in a later series.  I agree with you that it should go
here instead.

> For interesting tests around this prefetch() call, I think the
> 'diff with rename detection batches blobs' test in t4067 should help.
>
> >                       struct diff_filespec *one =3D rename_src[j].p->on=
e;
> >                       struct diff_score this_src;
> >
> > -                     if (one->rename_used &&
> > -                         detect_rename !=3D DIFF_DETECT_COPY)
> > -                             continue;
> > +                     assert(!one->rename_used ||
> > +                            detect_rename =3D=3D DIFF_DETECT_COPY ||
> > +                            break_idx);
>
> Looks like you could use 'want_copies' here (and in the previous
> patch).

Yep, good catch.  I'll make the change.

> Thanks,
> -Stolee

Thanks for reviewing!
