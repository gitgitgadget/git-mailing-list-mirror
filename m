Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366DEC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041C1650E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 22:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhCIWko (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 17:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhCIWkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 17:40:12 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D7AC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 14:40:12 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a17so14494668oto.5
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEq8BxCu6HEjAFsxE2m7FxiIg6GdrjT2FYBW+ecgBCs=;
        b=uoHqc9rYcmSaXU0a/tAr1nfRhZtcBwXFmHi41spLHGN90WnwCmZB9Q43ft7ihBtfm2
         vcyxGT/9RUOZEHKiwjCZE9ueuYL3yb2lSQ+q9LCZgBAz99Sq7tboJaZSe554OfiQx6Jq
         odA86MA/mX3WOcgzja7lRQsQrPwUFu+KFcNPU6vp0G4PzSC32x9S3FmL9SiJKWH6NS6H
         Wgoyh4sc9FYJbWndyVOX9t9y/ztrsVTU4Hs0yP69AgwWKswaIhA/np88efUZA/atWiuI
         7Mr6yj1dkONNe4vdpI5S71thQ4OgUQCQ0spPN7laKB5L8npSHeno07Lii8Wq484V0/LJ
         kTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEq8BxCu6HEjAFsxE2m7FxiIg6GdrjT2FYBW+ecgBCs=;
        b=Na+Le1BYfxfoerPfqGa9qde1rpT3SmcBCPNjJl0b6f0h0S7T+wpHZ3OxFpBah/Mwag
         P+yuiMQfQzEY1kv+W+lR/z41jj/S6LMcKd4zTM+z/t83dwP+D9KDclZujH+j7uDrmnG/
         AcuvPM/AkLWeYUNagnXtvsc+6dCNKUOtTajAVpgylohHGUUlIFJ36S5C3oScX6cfqH4u
         1yvPCl+LeZB3sIKOlpzwA6hxIgsahLQUmzLsaHMRY67+GDakuidh3yXR+Fy2TcTSTA/r
         bznBHHvBokGaXMYzvBdBJli4yFhPEavWqxFLj0LgFTS6xTkwAXmOtJToA+eSuuf8B9Ii
         6hcg==
X-Gm-Message-State: AOAM530KalWej3EAkKsVP0RmSHtOpm5XQrdv0OUZvp7lR0ZlELhtZ2bN
        Sbv0myAq3e1q0IPodUWRswOoH5StK6p4U+cf2bM=
X-Google-Smtp-Source: ABdhPJyvERcYxlAsTsPTkaGDrb4xppsw78r0Qi+nprwDKXwOgvtMLXit9eRHGiY/2u/6OhhgDYxGpyejwa6/oJLLTsI=
X-Received: by 2002:a9d:4d0e:: with SMTP id n14mr309787otf.316.1615329611113;
 Tue, 09 Mar 2021 14:40:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.845.git.1614484707.gitgitgadget@gmail.com>
 <pull.845.v2.git.1615248599.gitgitgadget@gmail.com> <dab8e3c6aee5a852ad46c569c0be729d64310ad9.1615248599.git.gitgitgadget@gmail.com>
 <c646e320-566b-3b53-63d8-a97c6d17c5bd@gmail.com>
In-Reply-To: <c646e320-566b-3b53-63d8-a97c6d17c5bd@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Mar 2021 14:40:00 -0800
Message-ID: <CABPp-BFnkHMd_1roiXL1njJXCP+T-Qm0H2eCTOQiM2qUM7gDBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] diffcore-rename: enable filtering possible rename sources
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 9, 2021 at 2:21 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/8/2021 7:09 PM, Elijah Newren via GitGitGadget wrote:> @@ -1127,9 +1137,10 @@ void diffcore_rename_extended(struct diff_options *options,
> >               /*
> >                * Cull sources:
> >                *   - remove ones corresponding to exact renames
> > +              *   - remove ones not found in relevant_sources
> >                */
> >               trace2_region_enter("diff", "cull after exact", options->repo);
> > -             remove_unneeded_paths_from_src(want_copies);
> > +             remove_unneeded_paths_from_src(want_copies, relevant_sources);
> >               trace2_region_leave("diff", "cull after exact", options->repo);
>
> In this case, we are checking for copies. Perhaps there is a reason
> why we want to include relevant_sources in that case, so I'll look
> for it later.

There is no current caller making use of this.  I could have just
marked the two options as incompatible and passed NULL here for
relevant sources, but...I didn't see a compelling reason to.  If some
caller wanted copy detection and were only interested in copies from a
subset of sources, they could take advantage of relevant_sources in
the same way to limit to those paths that are relevant.  I guess it
comes down to whether you view this as designing the code for future
theoretical cases, or explicitly taking steps to limit future
possibilities.  I don't have a strong opinion here, but tried to
enable other future uses since diffcore-rename.c is used by many other
callers too.

> >       } else {
> >               /* Determine minimum score to match basenames */
> > @@ -1148,7 +1159,7 @@ void diffcore_rename_extended(struct diff_options *options,
> >                *   - remove ones involved in renames (found via exact match)
> >                */
> >               trace2_region_enter("diff", "cull after exact", options->repo);
> > -             remove_unneeded_paths_from_src(want_copies);
> > +             remove_unneeded_paths_from_src(want_copies, NULL);
> >               trace2_region_leave("diff", "cull after exact", options->repo);
> >
> >               /* Preparation for basename-driven matching. */
> > @@ -1167,9 +1178,10 @@ void diffcore_rename_extended(struct diff_options *options,
> >               /*
> >                * Cull sources, again:
> >                *   - remove ones involved in renames (found via basenames)
> > +              *   - remove ones not found in relevant_sources
> >                */
> >               trace2_region_enter("diff", "cull basename", options->repo);
> > -             remove_unneeded_paths_from_src(want_copies);
> > +             remove_unneeded_paths_from_src(want_copies, relevant_sources);
> >               trace2_region_leave("diff", "cull basename", options->repo);
>
> This seems backwards from your cover letter. You are using the exact renames
> _and_ basename matches to remove the unneeded paths. Why are we not stripping
> out the relevant_sources in the call further up, before we call
> find_basename_matches()?

Yeah, good flag.  I should add a comment to the commit message about
how these are still needed in initialize_dir_rename_info() for
basename-guided directory rename detection...and will also play a role
in some of the special cases where renames are needed for more than
three-way content merges.  And add a comment about how by the end of
the series, relevant_sources will be passed to find_basename_matches()
so that it can skip over those paths.
