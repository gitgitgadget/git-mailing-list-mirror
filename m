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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F14C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399832229C
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL3Tt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 14:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3Tt3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 14:49:29 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2127C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:48:48 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id d203so19767448oia.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IdNMDPgZ4M9x9si1IWqgqmSuY4SI0MVTvJez1wjUzcA=;
        b=VzEI7ALwcg0SnYHn0mwRGTWmOoMTcho70LwHnH38Utpw9cKLE0/9c+MU5Cnc5jnT6H
         dmY83Kd1rmxuI9txqZRtBg9dBVrp0fzk7Ppy98xVc/AYcf3cn9/l9oBl599iV61nZdRP
         ut+fbWZP8r7aQ/yctZlV/iEH1hH5HauZw9TLZZK6GeFUy9i7Yaz1oOwW8M/htWnihjol
         4gAhl3UVty3GYFnsVeUM35Dq0tyaxnfFfcdO6xc11GFZ/d6Lz1s4lFBugSY/eHbHJIWs
         0AXrU6y8aqoyZWqBq7ksFZpXMayRQhCgMT9c/6cthcyQmFIECCIYRxAbX4nFlwrhw0yl
         Uxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IdNMDPgZ4M9x9si1IWqgqmSuY4SI0MVTvJez1wjUzcA=;
        b=ZNA1bneOfNLx93VkCffT3WtnR9oGxwLAOOGryejX3sKSPjK9NXwiDv0CQykUwxV2Gr
         y68muv7slqCmz3DF8kPBigquxaBB4OBjU+UtKs5XFIrc1EsAaf6txHbyw6Ojw6kfQn9t
         vCo3sD/T9denY4F8mE9LjRSAUfhWd0rqEfW5DNotESBXP04Jb/kC8rLHdiHDJXB2LMPE
         90yeuchX+Rxq1fRB/LhfZUQ/Ku+7edi7fLRh/LKynRTbFCrLOuLZ/p/YAKJWtKNddzu2
         jelmmBkVSQJqI1T1iIfCTsKuiyBe8fZr+w7ZGuejKOUUgk8xM0jBfv/0dEffMQ7KRAIJ
         Biiw==
X-Gm-Message-State: AOAM531BEhtYyJ58LljXPVn1RvPlwiZ5qy1PjyM0MASPJzYkyqwzGqTO
        mUV9+2m5u68POqKb5zzb3QdCT0D9DRz/tSNVNEM=
X-Google-Smtp-Source: ABdhPJwAr0+p6iVaSR29BnE3otlTFS9CTNN8CNgpF5kF4vLidokHCfZKiI460yF3cz4vwDesJiWeSxFEJnbsS5Z1G68=
X-Received: by 2002:aca:3151:: with SMTP id x78mr6116939oix.39.1609357728161;
 Wed, 30 Dec 2020 11:48:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.829.git.1609356413.gitgitgadget@gmail.com> <5d1c9c8a356b9003be21059c7ed6232732fd26c0.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <5d1c9c8a356b9003be21059c7ed6232732fd26c0.1609356414.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 11:48:37 -0800
Message-ID: <CABPp-BGTXvNjwQkqSzqLJwL6T2a_Ly_9=wiejqpt-3sq6oPGEw@mail.gmail.com>
Subject: Re: [PATCH 5/8] cache-tree: trace regions for prime_cache_tree
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:26 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Commands such as "git reset --hard" rebuild the in-memory representation
> of the cached tree index extension by parsing tree objects starting at a
> known root tree. The performance of this operation can vary widely
> depending on the width and depth of the repository's working directory
> structure. Measure the time in this operation using trace2 regions in
> prime_cache_tree().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 45fb57b17f3..f135bb77af5 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -746,7 +746,10 @@ void prime_cache_tree(struct repository *r,
>  {
>         cache_tree_free(&istate->cache_tree);
>         istate->cache_tree = cache_tree();
> +
> +       trace2_region_enter("cache-tree", "prime_cache_tree", the_repository);

Shouldn't this be at the start of the function, a few lines up?

>         prime_cache_tree_rec(r, istate->cache_tree, tree);
> +       trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);

...and this be one more line down?  (or the string "prime_cache_tree"
have a "_rec" added to it?)

>         istate->cache_changed |= CACHE_TREE_CHANGED;
>  }
>
> --
> gitgitgadget
>
