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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CCBC43381
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F14C23603
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 19:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbhATTvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392858AbhATTvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 14:51:03 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC197C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:50:21 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id f132so26298267oib.12
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NcvGzpqvMhEd/ITq1tZte/wkh4Gkp35OasOIJ3tlj0=;
        b=dZ5wwPxhOk0Mfhi3yoD5CWGdqARHocf4GOp9yldC8/VjQOcxW6fXl7G/bbHipqZscC
         CUGuc5butI7qBOoepuhS/ghnHUexwvRJpNJn+iUODmXc+PLKatFqoMSQKWRudNgqDi5X
         oRzQQOa1J1SuCYlwG7zQj8jm89K/05gC+TfmvF6mrXKnu0CjrT4VEBXZPjc1GMpIiD2H
         HvX0qOkJC1czrFBL4K4EkCA0DYEhreJb9uSgMCTqDJa8aHpmP6ffZ+kgsULr/mgkQpDP
         cfVbXLMSlFkvkBRioCnS+y80SoQZsu9YwCMkv/7QVY20ymGz5XfH2Sa8TAib3OuSaegj
         naWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NcvGzpqvMhEd/ITq1tZte/wkh4Gkp35OasOIJ3tlj0=;
        b=YyzXuYYYBAqKqeyTcAXMDjTjn0SxzFCajvRWTpJ1+xfp6UlKBTh3YAme4FKhAb0XZ1
         LEU5e+d0XdPtAsc062R2zYU5Fy6UyMCuZtCNjdNs9Ato3CMHEX2HRlScrNbUt5zqyzeb
         e28md77C/V2UcOjCG+E/RFzRWuYT8Ne2BDEIeHpZcP2g1f0TU4YNQTI6vUmca54TKVJo
         SAGB/bgEsBTMtmPgVYo2oXR3dCgg68zcbuT02ro1nRrNHU9AY4sDLAJw6nYPmwgmb1f6
         EchpiEw+eNFmGp73szPdHryo9Rvd6Ylxgzpq3o/hZutDNmdke9KOD7TxNQ5sZtK6vaEO
         ogDQ==
X-Gm-Message-State: AOAM532oi5vkMjlvBBuNdHJNMZs2hrzvWw/7PVsAZ2KA99BVFZhptTqg
        qA8lf3N/b0/I1Ux+kBvTYuF09h+QYCr/WPUhTiI=
X-Google-Smtp-Source: ABdhPJwDx3Oec44hOy8MsEnwQZinnFLfPVcI9isIuJBbf4xh9SSxufsCow7grdLZNd1WOv9H6oqhulxzZ6cgLRhpxGU=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr3809666oib.167.1611172221271;
 Wed, 20 Jan 2021 11:50:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com>
 <d4ff0468fc0e22fe3ef82f74603ac781fd7711e1.1611161639.git.gitgitgadget@gmail.com>
 <CABPp-BGOVUDqDvTi0VOK7fD1EeFrhjCfZm241BqgA5_yMDH-VQ@mail.gmail.com> <f790db9c-0c6d-3661-93d9-0339e22c12ff@gmail.com>
In-Reply-To: <f790db9c-0c6d-3661-93d9-0339e22c12ff@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 11:50:10 -0800
Message-ID: <CABPp-BE7wg9YBvFidrQaB3EP+zNb3u9W9_VRhWFdsS85vuYP5A@mail.gmail.com>
Subject: Re: [PATCH 4/9] repository: add repo reference to index_state
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 11:16 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/20/2021 12:46 PM, Elijah Newren wrote:
> > On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> It will be helpful to add behavior to index opertations that might
> >
> > s/opertations/operations/
>
> Thanks.
>
> >> trigger an object lookup. Since each index belongs to a specific
> >> repository, add a 'repo' pointer to struct index_state that allows
> >> access to this repository.
> >>
> >> This will prevent future changes from needing to pass an additional
> >> 'struct repository *repo' parameter and instead rely only on the 'struct
> >> index_state *istate' parameter.
> >>
> >> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> >> ---
> >>  cache.h      | 1 +
> >>  repository.c | 4 ++++
> >>  2 files changed, 5 insertions(+)
> >>
> >> diff --git a/cache.h b/cache.h
> >> index 71097657489..f9c7a603841 100644
> >> --- a/cache.h
> >> +++ b/cache.h
> >> @@ -328,6 +328,7 @@ struct index_state {
> >>         struct ewah_bitmap *fsmonitor_dirty;
> >>         struct mem_pool *ce_mem_pool;
> >>         struct progress *progress;
> >> +       struct repository *repo;
> >>  };
> >>
> >>  /* Name hashing */
> >> diff --git a/repository.c b/repository.c
> >> index a4174ddb062..67a4c1da2d9 100644
> >> --- a/repository.c
> >> +++ b/repository.c
> >> @@ -264,6 +264,10 @@ int repo_read_index(struct repository *repo)
> >>         if (!repo->index)
> >>                 repo->index = xcalloc(1, sizeof(*repo->index));
> >>
> >> +       /* Complete the double-reference */
> >> +       if (!repo->index->repo)
> >> +               repo->index->repo = repo;
> >> +
> >>         return read_index_from(repo->index, repo->index_file, repo->gitdir);
> >>  }
> >>
> >> --
> >> gitgitgadget
> >
> > Since we have repo->index and we have index->repo, which are intended
> > to be circular...what if they aren't?  Do we want or need to add
> > assertions anywhere that repo == repo->index->repo or that index ==
> > index->repo->index ?
>
> Here, we are pairing them together and the loop is complete. I don't
> view that as a permanent thing. This only initializes istate->repo
> when we are parsing an index from a file, but not when we create one
> in memory.
>
> I imagine it will be likely in some cases to have multiple index_state
> instances for a single repository. However, having the pointer "this
> index belongs to this repository" seems helpful (to me).
>
> > My initial implementations of --remerge-diff[1] played around with
> > creating a second repo, with a different primary object store but
> > everything else the same.  The index for the two repository objects
> > was thus the same, and thus clearly would have violated this assumed
> > invariant for one of the two repos.  I discarded that initial
> > implementation (which I didn't quite have working) because I
> > discovered tmp-objdir.h and was able to add some
> > tmp_objdir_make_primary() and tmp_objdir_remove_as_primary() functions
> > that merely altered the existing repo's primary object store, but I'm
> > curious if there might be other cases of folks doing stuff that might
> > have weird failures with this new invariant.
>
> This is an interesting concept, and definitely violates my expectations
> that an index belongs to only one repository. I'd need to know more
> about why this was a good design decision before being convinced that
> the relationship should not be many-to-one (index-to-repo).

I'm not sure what I did was a good design decision; I was kind of
exploring and trying to figure things out.  In retrospect, I think it
was probably a bad idea.  But we have various guard rails in the form
of BUG() calls and such when basic assumptions are violated, and here
it seems that you are now making a new basic assumption that an index
belongs to only one repository.  (Even if all current callers happen
to satisfy that assumption, it's not clear to me that git previously
cared if this condition were satisfied or not).  Hence my question
about safety checks.

> > It's entirely possible that --remerge-diff was just so different, and
> > I was so unfamiliar with repo objects (and still kind of am) that I
> > was just doing weird stuff no one has done before, so perhaps no
> > additional checks are needed -- I'm just throwing my gut question out
> > there as food for thought.
> >
> > [1] I have not yet submitted `--remerge-diff` to the list; you haven't
> > missed anything.  I'm waiting for merge-ort to be submitted, reviewed,
> > and merged first.  It's the remerge-diff branch in my fork on GitHub
> > if anyone is curious, though.
>
> I'm interested in what others might say about this idea. I'd be able
> to do most of what I want to do without this patch, but it just gets
> a lot messier. (istate->repo is used in the very next patch in a way
> that would be less clean without it.)

I'm less concerned with your patch as-is (I think your assumption
seems reasonable and I'm fine with labelling my former unsubmitted
patches as erroneous), and more wondering whether others in the future
will accidentally violate assumptions your patch starts encoding...and
whether we can or should do anything about it.  If there's a simple
place we can add a check for such an error, then it probably makes
sense to add one.  If there isn't...then at least we considered it?
