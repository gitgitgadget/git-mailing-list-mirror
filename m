Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDBC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369FC206ED
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 23:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXVYNxbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgKIXJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 18:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgKIXJK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 18:09:10 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9357C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 15:09:09 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 79so10669599otc.7
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 15:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xu5XyYbwqyAEkQnxtzoqIkFGN4S0VKPe8StO3nUUJfQ=;
        b=NXVYNxbI3nn8hHvyD2FD7a/OXQgF2UobVaWznY8cPOhw2hmzST3NVH+DbFe3NMT+EW
         O68wRJ37oVUPjKel+LWYdglMzx10wkUjeqrD7+AEHWJGhqfdrsa7Z0Gp51Z0491M9H01
         kI3QVCIgNVTL3LpdvMC9CZyV3CVZrssmcQw2n3xHMW0T2jIXMG6/By/G4sb5avUnSrBS
         2tnN3PyHx6nP18IXDtJL0o9MZrkATrEsBIlrid7tE/djWBzeej1xtahH1YXh8HLab2O4
         S0SHoYOzjbImOmZIKPrCR+nL3/QCRC8MEfFsRCNNA2wXILxCzBRRvWAlH0bvRBSK3C+8
         xn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xu5XyYbwqyAEkQnxtzoqIkFGN4S0VKPe8StO3nUUJfQ=;
        b=Rr5EQ6IcM7lwhjg0YIKskQYoa77zPeVhUYvf1p5IPqJGhNaas2VSmIFPj7VNV4bIoz
         Cpe2UFvbStcpJ5i7hj5du0y3uCWqYE82VC8x8XXkwOBiDhbDoV36D5FAoIGbIC11akOv
         8LoEYD69g/zXlVDuzE2B0nnrADoa4wxg5qVIihjcg2QpmgR3CPORLw6gt3W/kxdCbkya
         /f2jy2uNSUgiTHjLC6JCsBwqcgs4K4HrWCQle6WMkEFZnGKNjQFdsdRVTnqAhhblgRmI
         r2+0fSoM/4K0H4QnKlsdN0aD807bb810XV93GU5rYtij/mxX2bfFvY06fRx+tjiw3Mxg
         9SfA==
X-Gm-Message-State: AOAM530/rlk6MDsmKzUCy925MYo7BpP1b0Hj3lEARB6fkOGAXwXrOEW4
        pddzQGKOi23eAL2qeicHteIJtc50A878k1uIBZk=
X-Google-Smtp-Source: ABdhPJxy8c9F1fC3Es9iZH09oXMx2ZAPWOFe8MobPii4369mSwHlv8cMVtVi2KgCE7aFHNm8qfXoKtkvpAgNL6qMcGs=
X-Received: by 2002:a9d:8d7:: with SMTP id 81mr12424298otf.345.1604963349231;
 Mon, 09 Nov 2020 15:09:09 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEyosjCpBr-8B19YXZV0mpn3oYAXoaaROKFNZQ+p4ZMnQ@mail.gmail.com>
 <20201109220903.2536706-1-jonathantanmy@google.com>
In-Reply-To: <20201109220903.2536706-1-jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Nov 2020 15:08:58 -0800
Message-ID: <CABPp-BE=4uTRyxsuBUz7iB7+kqKjtM1-J3qiSi4q1nvwC1Odvg@mail.gmail.com>
Subject: Re: [PATCH v2 09/20] merge-ort: record stage and auxiliary info for
 every path
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 2:09 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > > So these are placed in paths but not unmerged. I'm starting to wonder if
> > > struct merge_options_internal should be called merge_options_state or
> > > something, and each field having documentation about when they're used
> > > (or better yet, have functions like collect_merge_info() return their
> > > calculations in return values (which may be "out" parameters) instead of
> > > in this struct).
> >
> > Right, unmerged is only those paths that remain unmerged after all
> > steps.  record_unmerged_index_entries() could simply walk over all
> > entries in paths and pick out the ones that were unmerged, but
> > process_entries() has to walk over all paths, determine whether they
> > can be merged, and determine what to record for the resulting tree for
> > each path.  So, having it stash away the unmerged stuff is a simple
> > optimization.
> >
> > Renaming to merge_options_state or even just merge_state would be fine
> > -- but any renaming done here will also affect merge-recursive.[ch].
> > See the definition of merge_options in merge-recursive.  (For history,
> > merge-recursive.h stuffed state into merge_options, which risked funny
> > misusage patterns and made the API unnecessarily complex...and made it
> > suggest that alternative algorithms needed to have the same state.
> > So, the state was moved to a merge_options_internal struct.  That's
> > not to say we can't rename, but it does need to be done in
> > merge-recursive as well.)
>
> Ah, I see.
>
> > As for having collect_merge_info() return their calculations in return
> > values, would that just end with me returning a struct
> > merge_options_internal?  Or did you want each return value added to
> > the function signature?  Each return value in the function signature
> > makes sense right now for this super-simplified initial 20 patches,
> > but what about when this data structure gains all kind of
> > rename-related state that is collected, updated, and passed between
> > these areas?  I'd have a huge number of "out" and "in" fields to every
> > function.  Eventually, merge_options_internal (or whatever it might be
> > renamed to) expands to the following, where I have to first define an
> > extra enum and two extra structs so that you know the definitions of
> > new types that show up in merge_options_internal:
>
> [snip enums and structs]
>
> Good point. I should have realized that there would be much more to
> track.
>
> > > > +     result->string = fullpath;
> > > > +     result->util = path_info;
> > > > +}
> > > > +
> > > >  static int collect_merge_info_callback(int n,
> > > >                                      unsigned long mask,
> > > >                                      unsigned long dirmask,
> > > > @@ -91,10 +136,12 @@ static int collect_merge_info_callback(int n,
> > > >        */
> > > >       struct merge_options *opt = info->data;
> > > >       struct merge_options_internal *opti = opt->priv;
> > > > -     struct conflict_info *ci;
> > > > +     struct string_list_item pi;  /* Path Info */
> > > > +     struct conflict_info *ci; /* pi.util when there's a conflict */
> > >
> > > Looking ahead to patch 10, this seems more like "pi.util unless we know
> > > for sure that there's no conflict".
> >
> > That's too long for the line to remain at 80 characters; it's 16
> > characters over the limit.  ;-)
>
> Well, you could move the description onto its own line :-)

:-)
