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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D68C433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F35E233ED
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391783AbhATRWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732935AbhATRWC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:22:02 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE12C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:21:20 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d189so25774898oig.11
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UC911Rz7qw1VyQzLahCJfuufRZn8nlCb1Arb4IfQDgc=;
        b=i4jJ6+VlNXR+EAYmv0aFZRhDY9OfK+PAJT8niAurcXoO5CNfZB52j5Zl1p2cHew6o+
         M2rLNYyDaufg3BEpnV7ivYieJiBy/W30kBBG4FThz4chQHtkuPmX7eBj5SnQQjs+Q8nF
         XPrT43iW3rkoWHTrOKfuZPZ0w3nmNpMSqgDuNNOCZ9YR3aO8AbJcBUKgqzHh1L5ZW2AJ
         dprhlYgnCxSEFpXQrYKlEi9L1ldZJWWq2Pyb/ICKmAufP4zuIrvEIoiP7gWFYXeGCx7F
         bEOI+2ygHgtImw2Y21hh3dLJzTCIQLK+xHMxduv0aSqF/6WUD+LaGv+w3NVKEM0ji7xA
         566g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UC911Rz7qw1VyQzLahCJfuufRZn8nlCb1Arb4IfQDgc=;
        b=IvFUTSEBTr0UD0mc2QNavpdax6RwOb4qxRM/NExRD8Bt0JiwabNJvYJp1Vr9l+A8RK
         cnQYDXqqwuUYOZiX9kg7NZtzhukgcId4OENnbuxv+A8uwE+bgj4hrzSRVtm3Zv+rkb9q
         P7gwa8JfR7UFcx7r1glID3Lt+Yecl+970RzC/+ZgEYkvGAmmhWJN1cWozI0jHKdkr2BJ
         NM1gOzDosJ6jE7wWi1tl2f7eOcy/20R86+MTXdzPbGda7Ws44YkvOzlFOZ+rNkCKNstg
         ZGQcq1uKCEFdl7dznNYGtsZVbawmb1y00to44+s4en4Jq7Ya23bOkdlza4lzSSHZvxdX
         R8YA==
X-Gm-Message-State: AOAM531uI27Z95NsSzcly3FINMEroxiXHp8MEXZzu7/0hB8ulRg48jH6
        AzoWPi+zc4CCwEa1q0DiROigSWTwGgk9CpTpnIU7GaePVPo=
X-Google-Smtp-Source: ABdhPJwbaz5K2WRtuti4DtpHzDrqR2Dj4zeLxv0KZPgb1tOdtUdTdRs4GJgU/XTklqjf64nctJT5rutGwbREl9lGnwo=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr3462928oib.167.1611163279858;
 Wed, 20 Jan 2021 09:21:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <0bccfd34ae5924aef0432fd6727debb75c052da5.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <0bccfd34ae5924aef0432fd6727debb75c052da5.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 09:21:08 -0800
Message-ID: <CABPp-BFiNvPaAffQ0uBfpkHY1WM2gR3ssvpwzxpDhrZmZZjiDA@mail.gmail.com>
Subject: Re: [PATCH 1/9] cache-tree: clean up cache_tree_update()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:54 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Make the method safer by allocating a cache_tree member for the given
> index_state if it is not already present.
>
> Also drop local variables that are used exactly once and can be found
> directly from the 'istate' parameter.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 3f1a8d4f1b7..c1e49901c17 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -436,16 +436,20 @@ static int update_one(struct cache_tree *it,
>
>  int cache_tree_update(struct index_state *istate, int flags)
>  {
> -       struct cache_tree *it = istate->cache_tree;
> -       struct cache_entry **cache = istate->cache;
> -       int entries = istate->cache_nr;
> -       int skip, i = verify_cache(cache, entries, flags);
> +       int skip, i;
> +
> +       i = verify_cache(istate->cache, istate->cache_nr, flags);

All mechanical changes so far; these look obviously correct.

>
>         if (i)
>                 return i;
> +
> +       if (!istate->cache_tree)
> +               istate->cache_tree = cache_tree();

This is the only substantive change.  It seems fairly innocuous, but
it makes me wonder the reasoning...I don't know/remember enough about
cache_tree handling to know when this would or wouldn't have already
been allocated.  It seems that this would have had to segfault below
if istate->cache_tree were ever NULL, and I don't see you mentioning
any bug you are fixing, so I presume this means you are going to be
adding new codepaths somewhere that cause this function to be reached
under different circumstances than previously had been and you need it
to be more safe for those.  Is that correct?  Or is it just an
abundance of caution thing that you're adding?  If the latter, any
reason you chose to allocate one rather than assume it's a violation
of design invariants and BUG() instead?  (Perhaps the commit message
could add a sentence about the rationale for the extra safety?)

> +
>         trace_performance_enter();
>         trace2_region_enter("cache_tree", "update", the_repository);
> -       i = update_one(it, cache, entries, "", 0, &skip, flags);
> +       i = update_one(istate->cache_tree, istate->cache, istate->cache_nr,
> +                      "", 0, &skip, flags);

Another mechanical update; looks good.

>         trace2_region_leave("cache_tree", "update", the_repository);
>         trace_performance_leave("cache_tree_update");
>         if (i < 0)
> --
> gitgitgadget
