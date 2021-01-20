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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE9C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98BD2242A
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbhATRro (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732467AbhATRq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:46:57 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C624C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:46:17 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id f6so14936710ots.9
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pP51brDfaNMxTT48f7d1TrtEQhHFG96DV4fgSFjofMg=;
        b=egqc5qav+gRR5w5/39WtOMJxJ+qkke9iHPaORjvp3QtRKib4IVLWpuRYoNoB+yqzdD
         +Pzn/0CkDTMDgXtyspZumbGTP0EmSQgOnc7uDcMjxDCFLHfN0vEuvZSYT90yp9fh1Rq5
         kDAEOndxn4tsqffIugIRoXlMWwsKh4z+03HZ+rX4sv4kAoiITHlls3dkSB/EVDR6Ke2N
         65zawWIuiA/OIqWRNtSpJqk90KMlcU6AgFPamNvxHZ5V2L/fg6AzPDixOULXm+CDyVp1
         dL/GPy7g2vBiAIzSqbIruqVV6KEJCwgf1uTaY5T12VwHH330w5MyUeMGMYPnsnhMPmZD
         9BaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pP51brDfaNMxTT48f7d1TrtEQhHFG96DV4fgSFjofMg=;
        b=KyzCrN5hDIQxT8JJVL4BbMYO+0YQ2AEcdpao/+sjo+4O4hb2pXDyInCcdeGnAPj1Na
         3A0I7o69MUsmNwY7ue/81zzFSktJ2KwdEtefFFCVZKPCUF7ydFTTyvf2J/Uk/smKhVHE
         P8K8iS9C7AaFTEYj546Az5MgDXMg+ZslICw2YDoXw7kjPlbO1wQGsTPJVLEM0lBlrU8V
         8xUXUiboXObS6En80VJVGdw9Mez3bW5p0bOO58v7kWT0e8VZ6Pi0vE58p0Pjaf+xrwiQ
         n5iWZHcOA1mRhtz3hqIQoegYu3kvfQtjUMFPqbf4o3HWv7p82BxWsk0IHzrM/yARIEWg
         bWPQ==
X-Gm-Message-State: AOAM532lYjy2yoewyV1WnquMeA4rzV4GOdZ4uITRK8JDPUUMgWmil+HE
        K94PjCY1SE2g5JkGq41ehNQmoBv+qXm4QyxOkkI=
X-Google-Smtp-Source: ABdhPJwaaBD297BQFP1C4TXjRpE+u6KJjx7vH7Sbmfdz/CxJh1aAwjdOaX4JSBFSnL+o8PZ0owe4CnMahU4SL6Fg6eo=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr5764202ots.345.1611164777026;
 Wed, 20 Jan 2021 09:46:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <d4ff0468fc0e22fe3ef82f74603ac781fd7711e1.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <d4ff0468fc0e22fe3ef82f74603ac781fd7711e1.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 09:46:05 -0800
Message-ID: <CABPp-BGOVUDqDvTi0VOK7fD1EeFrhjCfZm241BqgA5_yMDH-VQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] repository: add repo reference to index_state
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
> It will be helpful to add behavior to index opertations that might

s/opertations/operations/

> trigger an object lookup. Since each index belongs to a specific
> repository, add a 'repo' pointer to struct index_state that allows
> access to this repository.
>
> This will prevent future changes from needing to pass an additional
> 'struct repository *repo' parameter and instead rely only on the 'struct
> index_state *istate' parameter.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache.h      | 1 +
>  repository.c | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index 71097657489..f9c7a603841 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -328,6 +328,7 @@ struct index_state {
>         struct ewah_bitmap *fsmonitor_dirty;
>         struct mem_pool *ce_mem_pool;
>         struct progress *progress;
> +       struct repository *repo;
>  };
>
>  /* Name hashing */
> diff --git a/repository.c b/repository.c
> index a4174ddb062..67a4c1da2d9 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -264,6 +264,10 @@ int repo_read_index(struct repository *repo)
>         if (!repo->index)
>                 repo->index = xcalloc(1, sizeof(*repo->index));
>
> +       /* Complete the double-reference */
> +       if (!repo->index->repo)
> +               repo->index->repo = repo;
> +
>         return read_index_from(repo->index, repo->index_file, repo->gitdir);
>  }
>
> --
> gitgitgadget

Since we have repo->index and we have index->repo, which are intended
to be circular...what if they aren't?  Do we want or need to add
assertions anywhere that repo == repo->index->repo or that index ==
index->repo->index ?

My initial implementations of --remerge-diff[1] played around with
creating a second repo, with a different primary object store but
everything else the same.  The index for the two repository objects
was thus the same, and thus clearly would have violated this assumed
invariant for one of the two repos.  I discarded that initial
implementation (which I didn't quite have working) because I
discovered tmp-objdir.h and was able to add some
tmp_objdir_make_primary() and tmp_objdir_remove_as_primary() functions
that merely altered the existing repo's primary object store, but I'm
curious if there might be other cases of folks doing stuff that might
have weird failures with this new invariant.

It's entirely possible that --remerge-diff was just so different, and
I was so unfamiliar with repo objects (and still kind of am) that I
was just doing weird stuff no one has done before, so perhaps no
additional checks are needed -- I'm just throwing my gut question out
there as food for thought.



[1] I have not yet submitted `--remerge-diff` to the list; you haven't
missed anything.  I'm waiting for merge-ort to be submitted, reviewed,
and merged first.  It's the remerge-diff branch in my fork on GitHub
if anyone is curious, though.
