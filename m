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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E984CC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47FF64DA0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhA0RDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbhA0RBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 12:01:45 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67F0C0613ED
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:01:00 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d1so2324562otl.13
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lTErWkiW2rjiffgpeQl4QDNzOHrpIvhtk0F5bBbWz1s=;
        b=qNZNjYsF4JLgz1tt7DVSyuZc59l269siGFfWWXZ3uyA63L/aMNmkz4aPDvf7yCyFME
         b+qbWUrYxJcQD8QCwNX3P6/zMzQCEhq8Je8o2QPVJe1VFxVd5Xmy/gMiYzJ6tsWaAisy
         rki4e7hbjmmEfIYZDe815kQ/+DX9Cfh2FkObd/kMaQmx5jabEfpN9DvuH+g54pWRMEBd
         zTwZ/sYvWEU42bQ7xcbH40aQwcuk/CH5yTl+vBwsxpI+w10zFJ4u2ooJUSgWD7Z0X12n
         3DEtQJkBj/HYzBbZ2cL/Qij7iX1dsD9R62+fnfx3lxjG/YQrstbLoWl0qwu2jgs7+KeR
         j2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTErWkiW2rjiffgpeQl4QDNzOHrpIvhtk0F5bBbWz1s=;
        b=CIcRowyBzcBgPOSCsbFWLswiZ6IHzkGliBii4HSH+6zqdiWBSpCQ5QY/VAwjjpj5ny
         JkhC7IxihTVWwdIqe25MkrM/Pjp/DBl7r6hazpRUkgGXGbyQMa1rDSu18ktGIlu4fBaA
         jMHy4OQmL7XBv/v0Ki0pxmzkjc3pO2bu2NCIRlQlmVZUiBYT08nprUb47B5aUCH9wqvz
         OM2lCAU5OaCeqcEjQfSuE6pCdfPHlT48DwXIny9ZCm7Aj7pLFBceMC6VEQSSG3vywAr6
         d4yTRJKidOChXeoMFlBT6D2/QDhCDEJmNjTIXK5kyiNG/lpOHayP6dNP1tZzR2H+R/sJ
         2omw==
X-Gm-Message-State: AOAM530cUrUJChjsaF2dUNja7r53RE8nIdKP99dNtDkG8Hng5Piqq2eY
        z94It3l04Mp8aYZixGSRWNwALVt6x/LRNrsl4ns=
X-Google-Smtp-Source: ABdhPJzbd4STfjMxQm+nZr4r7BRvDRMQ8QLlOuOZ30ZQbsKj69BJaoZLSv7GGAYmWL1AvJ9lk3eyXoXNf4DoRrWXSkI=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr8309598ots.345.1611766855982;
 Wed, 27 Jan 2021 09:00:55 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <80aac5b8b71da96d6287f19e30f4ee8f786ca07b.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <80aac5b8b71da96d6287f19e30f4ee8f786ca07b.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 09:00:44 -0800
Message-ID: <CABPp-BEA5B3TzA-w-aBC1ZvFEYzvZfB-hkc=rXqgSVjrBNTLcA@mail.gmail.com>
Subject: Re: [PATCH 08/27] sparse-checkout: hold pattern list in index
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
> As we modify the sparse-checkout definition, we perform index operations
> on a pattern_list that only exists in-memory. This allows easy backing
> out in case the index update fails.
>
> However, if the index write itself cares about the sparse-checkout
> pattern set, we need access to that in-memory copy. Place a pointer to
> a 'struct pattern_list' in the index so we can access this on-demand.
> This will be used in the next change which uses the sparse-checkout
> definition to filter out directories that are outsie the sparse cone.

s/outsie/outside/

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c | 17 ++++++++++-------
>  cache.h                   |  2 ++
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 2306a9ad98e..e00b82af727 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -110,6 +110,8 @@ static int update_working_directory(struct pattern_list *pl)
>         if (is_index_unborn(r->index))
>                 return UPDATE_SPARSITY_SUCCESS;
>
> +       r->index->sparse_checkout_patterns = pl;
> +
>         memset(&o, 0, sizeof(o));
>         o.verbose_update = isatty(2);
>         o.update = 1;
> @@ -138,6 +140,7 @@ static int update_working_directory(struct pattern_list *pl)
>         else
>                 rollback_lock_file(&lock_file);
>
> +       r->index->sparse_checkout_patterns = NULL;
>         return result;
>  }
>
> @@ -517,19 +520,18 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>  {
>         int result;
>         int changed_config = 0;
> -       struct pattern_list pl;
> -       memset(&pl, 0, sizeof(pl));
> +       struct pattern_list *pl = xcalloc(1, sizeof(*pl));
>
>         switch (m) {
>         case ADD:
>                 if (core_sparse_checkout_cone)
> -                       add_patterns_cone_mode(argc, argv, &pl);
> +                       add_patterns_cone_mode(argc, argv, pl);
>                 else
> -                       add_patterns_literal(argc, argv, &pl);
> +                       add_patterns_literal(argc, argv, pl);
>                 break;
>
>         case REPLACE:
> -               add_patterns_from_input(&pl, argc, argv);
> +               add_patterns_from_input(pl, argc, argv);
>                 break;
>         }
>
> @@ -539,12 +541,13 @@ static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
>                 changed_config = 1;
>         }
>
> -       result = write_patterns_and_update(&pl);
> +       result = write_patterns_and_update(pl);
>
>         if (result && changed_config)
>                 set_config(MODE_NO_PATTERNS);
>
> -       clear_pattern_list(&pl);
> +       clear_pattern_list(pl);
> +       free(pl);
>         return result;
>  }
>
> diff --git a/cache.h b/cache.h
> index 884046ca5b8..b05341cc687 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -311,6 +311,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>  struct split_index;
>  struct untracked_cache;
>  struct progress;
> +struct pattern_list;
>
>  struct index_state {
>         struct cache_entry **cache;
> @@ -336,6 +337,7 @@ struct index_state {
>         struct mem_pool *ce_mem_pool;
>         struct progress *progress;
>         struct repository *repo;
> +       struct pattern_list *sparse_checkout_patterns;
>  };
>
>  /* Name hashing */
> --
> gitgitgadget

Isn't this the same patch you put in your index cleanup series, or am
I getting confused?  It looks very familiar.
