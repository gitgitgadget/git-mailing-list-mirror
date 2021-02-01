Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C231CC433DB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9605264EBD
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBAXZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhBAXZd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:25:33 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4B4C0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 15:24:53 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id h192so20817347oib.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 15:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6ysMNoJe8v6cYVsM2C6GGhI5NldC3sfhhKwaDyvqpE=;
        b=oNwWgHz0hnk2vs0ZISWDl603OSaSKZOE70rMkErQZ9SOpRMijZHF9LGCFbBeM+3kDm
         2e1DOKYeO5DTjD46ZBsqIXc71uckJ01FgHCUVxLa1zrhIpBB5aJ2eNigOfIxG9fhMEph
         B3vZAcGzIwf+K5rb3JzIdbyKo913/WoqbuYwNl4nyHltcUPmA+3eIkEOD+vVwH0znTPS
         kXS50qwpHP05rMZsEw5gBMKVLacK1tSUdOvmbkHxs4b5eVSDDfsaxfp+bz7QltDvflyw
         cEbJvvVaorLo9Ish3dHNm6DR04p82FsaNn4gxs+zmOssLAa8vH6xoSWQGdvrmIJc9Aiu
         646w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6ysMNoJe8v6cYVsM2C6GGhI5NldC3sfhhKwaDyvqpE=;
        b=nkjfdZ1bteAEgdTfxZyP1o9NPI7m2jpVUJ+1Yc1JNqOYKVzvooVsxYvnFtPfqVd18A
         9YqHt7gQJIHokhNnCAichY5z/SsaYyPq1i2OEzVle9zj9L2f27tLw3c5+yhI236FQ0pm
         6K8GV/Ba2hMVTugu2syChvlJQXGWHfKXai7QqVp1oSiyVs5E0aPgv1jCVSx++ZKfZqe8
         wEqdLgrEiNOYeUWk01qiKrGxK/jvSHkUkDn1qL79GR7dBBq34eHPobvIRCi3m2XeyOtP
         PJhW4q62ciFANVrQ00bfTjD9aOfWD+TL6ngvEFzHTPAIRNbrwGxlzXfECoE6Nb8v/zNN
         6EtA==
X-Gm-Message-State: AOAM530YTLjd0M3iu/f7VrWKqU9KPKXqGZEhqbVLnISGzsFxk2vF1yai
        g9jlLFs86FIZdDcOiImG0540JWVQ/W0eDbLOiMtQ86Kstpw=
X-Google-Smtp-Source: ABdhPJzdc9ND2kTtXYj5dud4lr1GVpUV2Ex813QEAuOcXIKOjI1ef5HMPaxJv9BE13D/Q3fSH361dst77mM+lZyNgRM=
X-Received: by 2002:a54:4790:: with SMTP id o16mr828855oic.39.1612221892718;
 Mon, 01 Feb 2021 15:24:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <5f53b08225771adc0be12c39e7be169d8620f146.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <5f53b08225771adc0be12c39e7be169d8620f146.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 15:24:41 -0800
Message-ID: <CABPp-BHv+kAV5BfrhdQ+Vo-q_eVs7a3MvLYg0wYhZQoyvCoqaw@mail.gmail.com>
Subject: Re: [PATCH 26/27] pathspec: stop calling ensure_full_index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The add_pathspec_matches_against_index() focuses on matching a pathspec
> to file entries in the index. It is possible that this already works
> correctly for its only use: checking if untracked files exist in the
> index.
>
> It is likely that this causes a behavior issue when adding a directory
> that exists at HEAD but is outside the sparse cone. I'm marking this as
> a place to pursue with future tests.

Sounds like you're unsure if this patch is good.  Should it be marked
RFC or something?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  pathspec.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 9b105855483..61dc771aa02 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -36,7 +36,6 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                         num_unmatched++;
>         if (!num_unmatched)
>                 return;
> -       ensure_full_index(istate);
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
>                 ce_path_match(istate, ce, pathspec, seen);
> --
> gitgitgadget
>
