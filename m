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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A24C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEA964E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBYHQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbhBYHPd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:15:33 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55DCC061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:14:52 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i21so2899313oii.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKDajeOauz5GR3zXv0euqXwv2BexsLBpv9Ez/haYBOQ=;
        b=FZysYWzhKJ68EC0W+GIQYgHbldYsgslpBZ4PkcEKN54HncaX1ZfNSZ98cO0JT9K0Dq
         lNcWZ1JY4j36ERzPONn4e7pH6LlHr3einAnfr4kCjqtLB7mYTVgBxBXQEpxIEFH7Hy86
         3oKD3rLRaDmdxrGJloESXpf4+kkeT7uDk8xOUwtGCvDkn+gjG1HzY5Khybigvhqm2WYN
         aRBMYAh7AynyIEIorY+X1y++gEkVLz5FtipRS0bw+67fUQyErJsJxb8jU7PUsTIBIIw/
         LOPMEII6PNxdyjl9Jof64RAfICdcABsVsm753NGIgZYxsfYIKRCLAtqSEzqTpLW+sZYw
         LXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKDajeOauz5GR3zXv0euqXwv2BexsLBpv9Ez/haYBOQ=;
        b=kUf3k98lzDBM7KV7Mjtoq0NyV1lS8WMP3/xpC99bN+ACbHFC/usNFUdERgYNGGksFi
         jj+/WKadfz93dre9posltbhDg1hpEMZ7JV+aXJt/lzBbpzrfXXgHbwuaoL1iPboj36k7
         4eD2+iLrp9gVmITsgl0qFyi8DmHZhuP4TsI6C8qzL381EbaqYHxqNpJOdtj0BwLuPZeQ
         DEpkb7l6Z5uxQBwBH+hXnUh+PbILSkov045oKV/iQwBNf6VBk40RKmv6iCVS2x7ipIJm
         7NKoNrdZ7DNRV3fxIIlRCp+POiPXh99K3wDS9p/Bzfcxn5FEB151iXg2s/EyvjK1ZXpm
         hggg==
X-Gm-Message-State: AOAM533DRgdGeFX0vVWk05Bc+X4BPYBOt4iu/wmZAngFoy7dsf5A8rGp
        J7bx9BlYkoOreleZs/+ctl4VSjq5aY3F2DMvtK8=
X-Google-Smtp-Source: ABdhPJwxAb331RUvU80Y52bY6oMzjBB42uXd4+ooWEA9cSiSOwLXSi1PuDt2E04qzU2CqprvxW1DI0qF4s1UmzkraE8=
X-Received: by 2002:aca:b407:: with SMTP id d7mr1040818oif.167.1614237292184;
 Wed, 24 Feb 2021 23:14:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <f86d3dc154d172912c23bdc157afb9d9cc545a85.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <f86d3dc154d172912c23bdc157afb9d9cc545a85.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 23:14:41 -0800
Message-ID: <CABPp-BFH1ixDYxy2O1C=5DwWu99BDnow_F8gXQQFdhpEC=OTbA@mail.gmail.com>
Subject: Re: [PATCH 10/20] sparse-checkout: hold pattern list in index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
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

Looks like you still have the "outsie" typo.  ;-)

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/sparse-checkout.c | 17 ++++++++++-------
>  cache.h                   |  2 ++
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 2306a9ad98e0..e00b82af727b 100644
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
> index 1336c8d7435e..d75b352f38d3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -307,6 +307,7 @@ static inline unsigned int canon_mode(unsigned int mode)
>  struct split_index;
>  struct untracked_cache;
>  struct progress;
> +struct pattern_list;
>
>  struct index_state {
>         struct cache_entry **cache;
> @@ -332,6 +333,7 @@ struct index_state {
>         struct mem_pool *ce_mem_pool;
>         struct progress *progress;
>         struct repository *repo;
> +       struct pattern_list *sparse_checkout_patterns;
>  };
>
>  /* Name hashing */
> --
> gitgitgadget
>
