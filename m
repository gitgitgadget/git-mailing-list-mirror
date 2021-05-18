Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A23C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB7B6124C
	for <git@archiver.kernel.org>; Tue, 18 May 2021 03:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240741AbhERD4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 23:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbhERD4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 23:56:37 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E7C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:55:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j75so8489934oih.10
        for <git@vger.kernel.org>; Mon, 17 May 2021 20:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVjWXClg/c38rVFD3epla5CnDG1YTUv1g2J8D1Di8H8=;
        b=JU3xCiZKTOwUV0B+HcPTBMs6OhHLG8PHt3GB4ZDcCmP8y3k4EzycFMIunzBD5u9c6v
         uWQk717NbDfkknE8d1Yb33BtZoGW+N9f82igg4liiT7+zdCFIjFiUSAlbEaGzwzh4r/s
         2Ymz8u+pmC+IcQ0IzA5skMbmrQMR4lyJiOZdybO7M11vNqp6PUx4jyTjjXGH4dmk4L8K
         zRvHPpudZZKV2WIb2CFyAY0hV6yI1MkXUbeKCZzavfE+i514zmtIWmPUo5sR3DzGpibv
         lwmoAHExsNxAxjKGjgin6OUzje7fL6dKMzlr29eiYBhtbRl2SV7G2blXTh3PVNOegdX1
         gmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVjWXClg/c38rVFD3epla5CnDG1YTUv1g2J8D1Di8H8=;
        b=YlwCWDI6X7e+Em5n9SficIChmRL8TgSKE9KvvxPwrDj8Lp4A+BMkmsmHNUzfWv6EFm
         QQupgIpk2uTxe21Wq2HHAhwQa1NwZnwGpkz5XuQBrE+JHataHJzwO+AGJsYChoZM8fq5
         to33TcxJFSSFRm3QJKKHXiF3HuRGnh8WSmbRnMYjpH3zEMJ5HBq/n0Z4yp49TkumTOOi
         x9JHIn477QoHlNHDw8WZtP/JyEApyaVSeeIJaO3KGJQTIlPqoNJJZw07Fu8lHQATZ7Ry
         P7k6aMr6OOK5npbDefCzY/hAePajZ/mmAWG+g7yRZ7Rc8Sax74r20LqKhYCu4LvFzENf
         sfGA==
X-Gm-Message-State: AOAM532lfuEWpg08pvfjpMhdllZkidFTNYHEcUId5ijSkND4z10WCOvK
        Gi08jYjh+vbUIAHp/1GpkRaax8sd99km3nZn1E4=
X-Google-Smtp-Source: ABdhPJzGJZD9ehsHmboyrlajv6x1LE5PLYcBljOVedFelTknWDp7vnDRVl68KM/MOph4Kw1DLDPl90mJ7vJAc0AYL7A=
X-Received: by 2002:aca:3e05:: with SMTP id l5mr1831535oia.39.1621310118725;
 Mon, 17 May 2021 20:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com> <2a9e73de2beef5f51ad76fe1d9aaaed926a5fce8.1620094339.git.gitgitgadget@gmail.com>
 <b9bb5b44-47ce-8198-c546-8f07d03ef863@gmail.com>
In-Reply-To: <b9bb5b44-47ce-8198-c546-8f07d03ef863@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 20:55:07 -0700
Message-ID: <CABPp-BFOSBVP-9A6BQegpaPRA+iU=ZQCiJYrTEkq0H9b+xRjEQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] merge-ort: add data structures for in-memory
 caching of rename detection
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 6:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/3/21 10:12 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When there are many renames between the old base of a series of commits
> > and the new base for a series of commits, the sequence of merges
> > employed to transplant those commits (from a cherry-pick or rebase
> > operation) will repeatedly detect the exact same renames.  This is
> > wasted effort.
> >
> > Add data structures which will be used to cache rename detection
> > results, along with the initialization and deallocation of these data
> > structures.  Future commits will populate these caches, detect the
> > appropriate circumstances when they can be used, and employ them to
> > avoid re-detecting the same renames repeatedly.
>
> I appreciate the definitions and boilerplate for these data
> structures being isolated to their own patch.
>
> > @@ -140,6 +140,37 @@ struct rename_info {
> >       int callback_data_nr, callback_data_alloc;
> >       char *callback_data_traverse_path;
> >
> > +     /*
> > +      * cached_pairs: Caching of renames and deletions.
> > +      *
> > +      * These are mappings recording renames and deletions of individual
> > +      * files (not directories).  They are thus a map from an old
> > +      * filename to either NULL (for deletions) or a new filename (for
> > +      * renames).
> > +      */
> > +     struct strmap cached_pairs[3];
> > +
> > +     /*
> > +      * cached_target_names: just the destinations from cached_pairs
> > +      *
> > +      * We sometimes want a fast lookup to determine if a given filename
> > +      * is one of the destinations in cached_pairs.  cached_target_names
> > +      * is thus duplicative information, but it provides a fast lookup.
> > +      */
> > +     struct strset cached_target_names[3];
>
> These two work well together. Very clear.
>
> > +     /*
> > +      * cached_irrelevant: Caching of rename_sources that aren't relevant.
> > +      *
> > +      * cached_pairs records both renames and deletes.  Sometimes we
> > +      * do not know if a path is a rename or a delete because we pass
> > +      * RELEVANT_LOCATION to diffcore_rename_extended() and based on
> > +      * various optimizations it returns without detecting whether that
> > +      * path is actually a rename or a delete.  We need to cache such
> > +      * paths too, but separately from cached_pairs.
> > +      */
> > +     struct strset cached_irrelevant[3];
>
> I'm having a hard time parsing what these "irrelevant" paths will be.
> It seems like diffcore_rename_extended() will report something other
> than "rename" or "delete" for some paths. Could we explicitly mark
> that state as "irrelevant"?

The state is better known as RELEVANT_NO_MORE, yes.

>         /*
>          * cached_irrelevant: Caching of rename_sources that aren't relevant.
>          *
>          * cached_pairs records both renames and deletes.  Sometimes we
>          * do not know if a path is a rename or a delete because we pass
>          * RELEVANT_LOCATION to diffcore_rename_extended() which might
>          * describe a path as "irrelevant" instead of as a "rename" or "delete".
>          *  We need to cache such paths too, but separately from cached_pairs.
>          */
>
> Does this make sense? diffcore_rename_extended() might need an update
> to match this extra, explicit state.

Hmm, let's flesh out the description a bit and try to be more
explicit.  How about:

    /*
     * cached_irrelevant: Caching of rename_sources that aren't relevant.
     *
     * If we try to detect a rename for a source path and succeed, it's
     * part of a rename.  If we try to detect a rename for a source path
     * and fail, then it's a delete.  If we do not try to detect a rename
     * for a path, then we don't know if it's a rename or a delete.  If
     * merge-ort doesn't think the path is relevant, then we just won't
     * cache anything for that path.  But there's a slight problem in
     * that merge-ort can think a path is RELEVANT_LOCATION, but due to
     * commit 9bd342137e ("diffcore-rename: determine which
     * relevant_sources are no longer relevant", 2021-03-13),
     * diffcore-rename can downgrade the path to RELEVANT_NO_MORE.  To
     * avoid excessive calls to diffcore_rename_extended() we still need
     * to cache such paths, though we cannot record them as either
     * renames or deletes.  So we cache them here as a "turned out to be
     * irrelevant *for this commit*" as they are often also irrelevant
     * for subsequent commits, though we will have to do some extra
     * checking to see whether such paths become relevant for rename
     * detection when cherry-picking/rebasing subsequent commits.
     */
