Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB93C4338F
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 02:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B0C60F5E
	for <git@archiver.kernel.org>; Fri, 30 Jul 2021 02:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhG3Cak (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 22:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhG3Caj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 22:30:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29103C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 19:30:35 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so7922798ota.11
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 19:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IqwGVxytREbWk14O/k2WtfDGXvOdFaARBegue5Q2ExE=;
        b=lI/pKHFCBpAkj1vQ8vuMxBWaRJEq7n1dQ32mfxGPptI4rpQ70U7mR52ukrQzB3e0HE
         Lw+CWqpAlfJOVkwOk7AMUsHDjwc8qyy3nTcM65TuIvf/D2Rhd5bfxkiquCt8tEArWVhb
         lm5K9xp5cAvPQiH9sGcNv6umEcHedOVhuyRjbIUhU33gUG5qbsCcPxnDE1DxLyNQIKRy
         k8I1boAD2fliaktEy579Zp+uNh56xgWaFjWUxHfuFcqtlUkUOe+I7lsE2FFIfG2FVWxA
         TvzIrcb1dKs7c28rEXjxF6t87GejwS1Lm4JHJA8AI3pm9YDFLczrVNzDfiX3Cs6icN7q
         IbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IqwGVxytREbWk14O/k2WtfDGXvOdFaARBegue5Q2ExE=;
        b=VK55vKtuSGAIKVxC559IwWocePMOr2p76w7aDc41UdFVr8JQp12Be+rJtEfB+bTosm
         zxGU1v4Dw9Xk6MZVDf36qAXNrP9GfLM7pk6ui3kZfwA3hRZpOc0c1ZxqV/pDrRIxaB8L
         h+pLTZaWVtJYKpfVdWs0c24ksSAAByOcYAkbKH5lvDQY/wxV2VpTlxoMEodaYbtOt9Ol
         sswtW1XqTHzi8oYkizlX1X0586PTJoDjWdDm7YK7+vAcc9WJLJcjoyWFyg/AIkFVmoom
         iLiuuJ1vJmDnS54GqIvnz4bNUeX6QqJ45Lu6lPWJ1z0hh0RRTN9suV4HS6ZIA1sb3GlK
         M6dg==
X-Gm-Message-State: AOAM5317b/FlykZI/nAppcFd/Le/llyaw3qR2rJmiJta3HeZ7xK67WJP
        i1L+uNy2et4IJoTyFAq/iRhZ7Ej+jEPHMOJSM8U=
X-Google-Smtp-Source: ABdhPJwL/Vl0XtywIgrH0Q4WW7aZGfuc4qq9/YTNmp0u5ndWsOuwr0a5LgvA6Gm+hJrurbtX/cQoX3TZHUxS1eLj7H8=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr341731ots.162.1627612234520;
 Thu, 29 Jul 2021 19:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com> <dd8839b284330892a3bbcafbc03d71489fc9b01f.1627531121.git.gitgitgadget@gmail.com>
 <YQLJOsvATnTBd9pB@coredump.intra.peff.net> <CABPp-BHzJ365Jed38s-VQb2PqRy7t=58sZwgmeVG=mqKeA2neg@mail.gmail.com>
 <YQMLBW6LAZmQ8nDz@coredump.intra.peff.net>
In-Reply-To: <YQMLBW6LAZmQ8nDz@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 29 Jul 2021 20:30:23 -0600
Message-ID: <CABPp-BE8OEjcMrJO8uijLFsvvpQH9KA=a+p_6bH71Z6QxXLB6w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] merge-ort: switch our strmaps over to using memory pools
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 2:09 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 29, 2021 at 12:37:52PM -0600, Elijah Newren wrote:
>
> > > Arguably, the existence of these function indirections is perhaps a sign
> > > that the strmap API should provide a version of the clear functions that
> > > takes "partial / not-partial" as a parameter.
> >
> > Are you suggesting a modification of str{map,intmap,set}_clear() to
> > take an extra parameter, or removing the
> > str{map,intmap,set}_partial_clear() functions and introducing new
> > functions that take a partial/not-partial parameter?  I think you're
> > suggesting the latter, and that makes more sense to me...but I'm
> > drawing blanks trying to come up with a reasonable function name.
>
> It does seem a shame to add the "partial" parameter to strmap_clear(),
> just because most callers don't need it (so they end up with this
> inscrutable "0" parameter).
>
> What if there was a flags field? Then it could be combined with the
> free_values parameter. The result is kind of verbose in two ways:
>
>  - now strset_clear(), etc, need a "flags" parameter, which they didn't
>    before (and is just "0" most of the time!)
>
>  - now "strmap_clear(foo, 1)" becomes "strmap_clear(foo, STRMAP_FREE_VALUES)".
>    That's a lot longer, though arguably it's easier to understand since
>    the boolean is explained.
>
> Having gone through the exercise, I am not sure it is actually making
> anything more readable (messy patch is below for reference).

Thanks for diving in.  Since it's not clear if it's helping, I'll just
take your earlier suggestion to rename the "strmap_func" variable to
"strmap_clear_func" instead.

>
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 3e7ab1ca82..dfbdba53da 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -242,7 +242,7 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
>                 insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
>         }
>
> -       strset_clear(&dups);
> +       strset_clear(&dups, 0);
>         strbuf_release(&ident);
>         strbuf_release(&oneline);
>  }
> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 7e6b3e1b14..0c960111d1 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -665,9 +665,10 @@ void partial_clear_dir_rename_count(struct strmap *dir_rename_count)
>
>         strmap_for_each_entry(dir_rename_count, &iter, entry) {
>                 struct strintmap *counts = entry->value;
> -               strintmap_clear(counts);
> +               strintmap_clear(counts, 0);
>         }
> -       strmap_partial_clear(dir_rename_count, 1);
> +       strmap_clear(dir_rename_count,
> +                    STRMAP_FREE_VALUES | STRMAP_PARTIAL_CLEAR);
>  }
>
>  static void cleanup_dir_rename_info(struct dir_rename_info *info,
> @@ -683,15 +684,15 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
>                 return;
>
>         /* idx_map */
> -       strintmap_clear(&info->idx_map);
> +       strintmap_clear(&info->idx_map, 0);
>
>         /* dir_rename_guess */
> -       strmap_clear(&info->dir_rename_guess, 1);
> +       strmap_clear(&info->dir_rename_guess, STRMAP_FREE_VALUES);
>
>         /* relevant_source_dirs */
>         if (info->relevant_source_dirs &&
>             info->relevant_source_dirs != dirs_removed) {
> -               strintmap_clear(info->relevant_source_dirs);
> +               strintmap_clear(info->relevant_source_dirs, 0);
>                 FREE_AND_NULL(info->relevant_source_dirs);
>         }
>
> @@ -716,7 +717,7 @@ static void cleanup_dir_rename_info(struct dir_rename_info *info,
>
>                 if (!strintmap_get(dirs_removed, source_dir)) {
>                         string_list_append(&to_remove, source_dir);
> -                       strintmap_clear(counts);
> +                       strintmap_clear(counts, 0);
>                         continue;
>                 }
>
> @@ -1045,8 +1046,8 @@ static int find_basename_matches(struct diff_options *options,
>                 }
>         }
>
> -       strintmap_clear(&sources);
> -       strintmap_clear(&dests);
> +       strintmap_clear(&sources, 0);
> +       strintmap_clear(&dests, 0);
>
>         return renames;
>  }
> @@ -1700,7 +1701,7 @@ void diffcore_rename_extended(struct diff_options *options,
>         FREE_AND_NULL(rename_src);
>         rename_src_nr = rename_src_alloc = 0;
>         if (break_idx) {
> -               strintmap_clear(break_idx);
> +               strintmap_clear(break_idx, 0);
>                 FREE_AND_NULL(break_idx);
>         }
>         trace2_region_leave("diff", "write back to queue", options->repo);
> diff --git a/merge-ort.c b/merge-ort.c
> index 0fb942692a..0765e23577 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -532,15 +532,10 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>  {
>         struct rename_info *renames = &opti->renames;
>         int i;
> -       void (*strmap_func)(struct strmap *, int) =
> -               reinitialize ? strmap_partial_clear : strmap_clear;
> -       void (*strintmap_func)(struct strintmap *) =
> -               reinitialize ? strintmap_partial_clear : strintmap_clear;
> -       void (*strset_func)(struct strset *) =
> -               reinitialize ? strset_partial_clear : strset_clear;
> +       unsigned flags = reinitialize ? STRMAP_PARTIAL_CLEAR : 0;
>
>         if (opti->pool)
> -               strmap_func(&opti->paths, 0);
> +               strmap_clear(&opti->paths, flags);
>         else {
>                 /*
>                  * We marked opti->paths with strdup_strings = 0, so that
> @@ -550,15 +545,15 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>                  * to these strings, it is time to deallocate them.
>                  */
>                 free_strmap_strings(&opti->paths);
> -               strmap_func(&opti->paths, 1);
> +               strmap_clear(&opti->paths, flags | STRMAP_FREE_VALUES);
>         }
>
>         /*
>          * All keys and values in opti->conflicted are a subset of those in
>          * opti->paths.  We don't want to deallocate anything twice, so we
>          * don't free the keys and we pass 0 for free_values.
>          */
> -       strmap_func(&opti->conflicted, 0);
> +       strmap_clear(&opti->conflicted, flags);
>
>         if (!opti->pool) {
>                 /*
> @@ -579,24 +574,24 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>
>         /* Free memory used by various renames maps */
>         for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
> -               strintmap_func(&renames->dirs_removed[i]);
> -               strmap_func(&renames->dir_renames[i], 0);
> -               strintmap_func(&renames->relevant_sources[i]);
> +               strintmap_clear(&renames->dirs_removed[i], flags);
> +               strmap_clear(&renames->dir_renames[i], flags);
> +               strintmap_clear(&renames->relevant_sources[i], flags);
>                 if (!reinitialize)
>                         assert(renames->cached_pairs_valid_side == 0);
>                 if (i != renames->cached_pairs_valid_side &&
>                     -1 != renames->cached_pairs_valid_side) {
> -                       strset_func(&renames->cached_target_names[i]);
> -                       strmap_func(&renames->cached_pairs[i], 1);
> -                       strset_func(&renames->cached_irrelevant[i]);
> +                       strset_clear(&renames->cached_target_names[i], flags);
> +                       strmap_clear(&renames->cached_pairs[i], flags | STRMAP_FREE_VALUES);
> +                       strset_clear(&renames->cached_irrelevant[i], flags);
>                         partial_clear_dir_rename_count(&renames->dir_rename_count[i]);
>                         if (!reinitialize)
>                                 strmap_clear(&renames->dir_rename_count[i], 1);
>                 }
>         }
>         for (i = MERGE_SIDE1; i <= MERGE_SIDE2; ++i) {
> -               strintmap_func(&renames->deferred[i].possible_trivial_merges);
> -               strset_func(&renames->deferred[i].target_dirs);
> +               strintmap_clear(&renames->deferred[i].possible_trivial_merges, flags);
> +               strset_clear(&renames->deferred[i].target_dirs, flags);
>                 renames->deferred[i].trivial_merges_okay = 1; /* 1 == maybe */
>         }
>         renames->cached_pairs_valid_side = 0;
> @@ -1482,7 +1477,7 @@ static int handle_deferred_entries(struct merge_options *opt,
>                         if (ret < 0)
>                                 return ret;
>                 }
> -               strintmap_clear(&copy);
> +               strintmap_clear(&copy, 0);
>                 strintmap_for_each_entry(&renames->deferred[side].possible_trivial_merges,
>                                          &iter, entry) {
>                         const char *path = entry->key;
> diff --git a/strmap.c b/strmap.c
> index 4fb9f6100e..7343800df5 100644
> --- a/strmap.c
> +++ b/strmap.c
> @@ -37,10 +37,11 @@ void strmap_init_with_options(struct strmap *map,
>         map->strdup_strings = strdup_strings;
>  }
>
> -static void strmap_free_entries_(struct strmap *map, int free_values)
> +static void strmap_free_entries_(struct strmap *map, unsigned flags)
>  {
>         struct hashmap_iter iter;
>         struct strmap_entry *e;
> +       int free_values = flags & STRMAP_FREE_VALUES;
>
>         if (!map)
>                 return;
> @@ -64,16 +65,13 @@ static void strmap_free_entries_(struct strmap *map, int free_values)
>         }
>  }
>
> -void strmap_clear(struct strmap *map, int free_values)
> +void strmap_clear(struct strmap *map, unsigned flags)
>  {
> -       strmap_free_entries_(map, free_values);
> -       hashmap_clear(&map->map);
> -}
> -
> -void strmap_partial_clear(struct strmap *map, int free_values)
> -{
> -       strmap_free_entries_(map, free_values);
> -       hashmap_partial_clear(&map->map);
> +       strmap_free_entries_(map, flags);
> +       if (flags & STRMAP_PARTIAL_CLEAR)
> +               hashmap_partial_clear(&map->map);
> +       else
> +               hashmap_clear(&map->map);
>  }
>
>  static struct strmap_entry *create_entry(struct strmap *map,
> diff --git a/strmap.h b/strmap.h
> index 1e152d832d..d03d451654 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -46,16 +46,14 @@ void strmap_init_with_options(struct strmap *map,
>                               struct mem_pool *pool,
>                               int strdup_strings);
>
> -/*
> - * Remove all entries from the map, releasing any allocated resources.
> - */
> -void strmap_clear(struct strmap *map, int free_values);
> +#define STRMAP_FREE_VALUES 1 /* 1 for historical compat, but we should probably
> +                               update callers to use the correct name) */
> +#define STRMAP_PARTIAL_CLEAR 2
>
>  /*
> - * Similar to strmap_clear() but leaves map->map->table allocated and
> - * pre-sized so that subsequent uses won't need as many rehashings.
> + * Remove all entries from the map, releasing any allocated resources.
>   */
> -void strmap_partial_clear(struct strmap *map, int free_values);
> +void strmap_clear(struct strmap *map, unsigned flags);
>
>  /*
>   * Insert "str" into the map, pointing to "data".
> @@ -148,14 +146,10 @@ static inline void strintmap_init_with_options(struct strintmap *map,
>         map->default_value = default_value;
>  }
>
> -static inline void strintmap_clear(struct strintmap *map)
> -{
> -       strmap_clear(&map->map, 0);
> -}
> -
> -static inline void strintmap_partial_clear(struct strintmap *map)
> +static inline void strintmap_clear(struct strintmap *map, unsigned flags)
>  {
> -       strmap_partial_clear(&map->map, 0);
> +       /* maybe clear STRMAP_FREE_VALUES bit for extra protection */
> +       strmap_clear(&map->map, flags);
>  }
>
>  static inline int strintmap_contains(struct strintmap *map, const char *str)
> @@ -232,14 +226,9 @@ static inline void strset_init_with_options(struct strset *set,
>         strmap_init_with_options(&set->map, pool, strdup_strings);
>  }
>
> -static inline void strset_clear(struct strset *set)
> -{
> -       strmap_clear(&set->map, 0);
> -}
> -
> -static inline void strset_partial_clear(struct strset *set)
> +static inline void strset_clear(struct strset *set, unsigned flags)
>  {
> -       strmap_partial_clear(&set->map, 0);
> +       strmap_clear(&set->map, flags);
>  }
>
>  static inline int strset_contains(struct strset *set, const char *str)
