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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7B9C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EA160EB0
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 20:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhGWTpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhGWTpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:45:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BB0C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:26:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t14so3199098oiw.0
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+H6faYGB2cl1YtWPkM8wfrtjoVbgYVrTH8BLPfYtReI=;
        b=Q6ZvUJcGUsCGUTAEh5IPJeFyKUtG2l9fBrwidusUc1dK7rwKXa3Xh9tumz9gjgBuMd
         jaBnUTP8Aa7z7rqyainefhm6bXogusCK2EQNrY9qrJEHYbc6dpeUB8Ne9FAKWrEfKfNd
         HXFCW836SEFVYLbiMl5abSSspuY8KcKxDFnKqgnPcpbBoMEPSfSUTq14yqtNDSjVMxxk
         j4sjkgiOnc8TyXiwYnpuFSeI7Wo+sxzqpd1+ti+mw4Wxwko/eSH/AkCrDL6FPUzi388v
         1/jvuETaZuOftPOq8rgIWZewHXGDEh50rI7/kK90AfT4uXbPOtD4eVtueGSsa40RaNOI
         eU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+H6faYGB2cl1YtWPkM8wfrtjoVbgYVrTH8BLPfYtReI=;
        b=D0wBNZefJ9MdzrxIVja1CI1e4FKcz8isoEMuNm2A1sqB/BTeg0YNsg1waxE2LBbilU
         U84YOY/hwlGz+iCDCvilwvjfi9DZpY3ub7/yU2g2WymPFgkEYypgJhk40r4NWd8wHukA
         5hAK/ig6qyweDgno/jFX72Q8sMHERKI7lDuf4emYOUTJjpq3Fkj3X9e5K7e3sQXLHkcI
         hqztMzMdJi7FWx1BdWQjgfeThY9kB2Qu3x5OEoJKNhBP8q/o+CoAEVc37E0NxPQWzw80
         WSrmNBhs7cZ6EfdxBCEDX3RdagzYoY6ffzTRGq732v6RLPpxEVCTj0Jo74Sfk6Y22mAm
         fZ8A==
X-Gm-Message-State: AOAM532yS51KTXhtQVD2KkUP54lwC94dRtm2vX2SUYfexzMo2t8ng5yT
        oqwm7gB7kbHHfaRwVwSB3RGEbVIWhGi/DX0yp2E=
X-Google-Smtp-Source: ABdhPJxM59BizHEBJOSRzLnw8I7QTrLya5U0YzRVS0OtAg08IPuhyII+SEmO31bKepraqhIzYquc22X85GpS/yTWJNI=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr9723012oie.167.1627071978611;
 Fri, 23 Jul 2021 13:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627066238.git.jonathantanmy@google.com> <f502997d159c7a30862fab3c3b443291539b6f29.1627066238.git.jonathantanmy@google.com>
In-Reply-To: <f502997d159c7a30862fab3c3b443291539b6f29.1627066238.git.jonathantanmy@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 13:26:07 -0700
Message-ID: <CABPp-BEUpXehjgh3-d4=r+V8CrYJxxBJ80Z8+EaJ=4ewvyGVDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] unpack-trees: refactor prefetching code
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 23, 2021 at 11:55 AM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> Refactor the prefetching code in unpack-trees.c into its own function,
> because it will be used elsewhere in a subsequent commit.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  cache.h        |  9 +++++++++
>  read-cache.c   | 23 +++++++++++++++++++++++
>  unpack-trees.c | 27 ++++++++-------------------
>  3 files changed, 40 insertions(+), 19 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index ba04ff8bd3..6f952e22c6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -410,6 +410,15 @@ struct cache_entry *dup_cache_entry(const struct cache_entry *ce, struct index_s
>   */
>  void validate_cache_entries(const struct index_state *istate);
>
> +/*
> + * Bulk prefetch all missing cache entries that are not GITLINKs and that match
> + * the given predicate. This function should only be called if
> + * has_promisor_remote() returns true.
> + */
> +typedef int (*must_prefetch_predicate)(const struct cache_entry *);
> +void prefetch_cache_entries(const struct index_state *istate,
> +                           must_prefetch_predicate must_prefetch);
> +
>  #ifdef USE_THE_INDEX_COMPATIBILITY_MACROS
>  extern struct index_state the_index;
>
> diff --git a/read-cache.c b/read-cache.c
> index ba2b012a6c..4e396bf17f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -27,6 +27,7 @@
>  #include "progress.h"
>  #include "sparse-index.h"
>  #include "csum-file.h"
> +#include "promisor-remote.h"
>
>  /* Mask for the name length in ce_flags in the on-disk index */
>
> @@ -3657,3 +3658,25 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
>                 strbuf_add(sb, &buffer, sizeof(uint32_t));
>         }
>  }
> +
> +void prefetch_cache_entries(const struct index_state *istate,
> +                           must_prefetch_predicate must_prefetch)
> +{
> +       int i;
> +       struct oid_array to_fetch = OID_ARRAY_INIT;
> +
> +       for (i = 0; i < istate->cache_nr; i++) {
> +               struct cache_entry *ce = istate->cache[i];
> +
> +               if (S_ISGITLINK(ce->ce_mode) || !must_prefetch(ce))
> +                       continue;
> +               if (!oid_object_info_extended(the_repository, &ce->oid,
> +                                             NULL,
> +                                             OBJECT_INFO_FOR_PREFETCH))
> +                       continue;
> +               oid_array_append(&to_fetch, &ce->oid);
> +       }
> +       promisor_remote_get_direct(the_repository,
> +                                  to_fetch.oid, to_fetch.nr);
> +       oid_array_clear(&to_fetch);
> +}
> diff --git a/unpack-trees.c b/unpack-trees.c
> index f88a69f8e7..ed92794032 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -392,6 +392,11 @@ static void report_collided_checkout(struct index_state *index)
>         string_list_clear(&list, 0);
>  }
>
> +static int must_checkout(const struct cache_entry *ce)
> +{
> +       return ce->ce_flags & CE_UPDATE;
> +}
> +
>  static int check_updates(struct unpack_trees_options *o,
>                          struct index_state *index)
>  {
> @@ -442,28 +447,12 @@ static int check_updates(struct unpack_trees_options *o,
>         if (should_update_submodules())
>                 load_gitmodules_file(index, &state);
>
> -       if (has_promisor_remote()) {
> +       if (has_promisor_remote())
>                 /*
>                  * Prefetch the objects that are to be checked out in the loop
>                  * below.
>                  */
> -               struct oid_array to_fetch = OID_ARRAY_INIT;
> -               for (i = 0; i < index->cache_nr; i++) {
> -                       struct cache_entry *ce = index->cache[i];
> -
> -                       if (!(ce->ce_flags & CE_UPDATE) ||
> -                           S_ISGITLINK(ce->ce_mode))
> -                               continue;
> -                       if (!oid_object_info_extended(the_repository, &ce->oid,
> -                                                     NULL,
> -                                                     OBJECT_INFO_FOR_PREFETCH))
> -                               continue;
> -                       oid_array_append(&to_fetch, &ce->oid);
> -               }
> -               promisor_remote_get_direct(the_repository,
> -                                          to_fetch.oid, to_fetch.nr);
> -               oid_array_clear(&to_fetch);
> -       }
> +               prefetch_cache_entries(index, must_checkout);
>
>         get_parallel_checkout_configs(&pc_workers, &pc_threshold);
>
> @@ -473,7 +462,7 @@ static int check_updates(struct unpack_trees_options *o,
>         for (i = 0; i < index->cache_nr; i++) {
>                 struct cache_entry *ce = index->cache[i];
>
> -               if (ce->ce_flags & CE_UPDATE) {
> +               if (must_checkout(ce)) {
>                         size_t last_pc_queue_size = pc_queue_size();
>
>                         if (ce->ce_flags & CE_WT_REMOVE)
> --
> 2.32.0.432.gabb21c7263-goog

This might have been slightly easier to review if you had introduced
must_checkout() first, and then made the new prefetch_cache_entries()
in a separate commit, so that comparing old and new code I didn't have
to try to deduce the separate steps.  However, that's a really minor
point since must_checkout() is so small.

Anyway, this patch looks good to me.
