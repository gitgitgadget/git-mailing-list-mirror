Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4797C200B9
	for <e@80x24.org>; Thu,  3 May 2018 16:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeECQ3S (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 12:29:18 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:40610 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeECQ3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 12:29:13 -0400
Received: by mail-ot0-f174.google.com with SMTP id n1-v6so21329035otf.7
        for <git@vger.kernel.org>; Thu, 03 May 2018 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=beEDd4DdI3/fFO4DjxdRyNeeFCTgm4sJxWadYgY1ZFU=;
        b=mq978wELS46I1ajIJm+Uw5PHHaoW6Kxn/k5pV/nOWOQXP0vBeaiFk0sMyJakJhtDdn
         BPdqmHo7dkfs8SFXl5I4Ci/k23qOpVB+PBtmWmUtS4ytJYsGUYYclC6Sr3FmtdXZ8BUw
         yoZ+OW8+TTJr8uehZBNHdL+3/hRWLQ6b11RaCgRASleSVGV8tSAEbuQ3duhvihNFueQ/
         QTmLVVM2Bv+M1TYJEXFl1+S36DnrwVhfMKlfRId0Evgu+gpqL8VCXHipYB/QAd+OvWxP
         H2qsVbvbNTmggf5SWQkC8dO0LUzYthGoeC/upNTsXLd8RiusZSIpnoKXAZVKu5IUufSI
         0+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=beEDd4DdI3/fFO4DjxdRyNeeFCTgm4sJxWadYgY1ZFU=;
        b=EuPAmG3E7HWiueBRuWvMSf+MqwUxDQ3hWStsQLM7kKIwfOftHbJrvKAdTivVpfelJP
         hjJzzKlBmOnpb0n+ZWGyiNbc/F/bwLCMHyaQQWFg+kwBJXOSLqgmHGFhTaonPpaGtIcA
         R6afufQm46Gte0zUCDinlvZU0eyOzHwJ5uNPNVC86Sc9kVrPgaMW2bXRhHRdhxSmyzm5
         I8RLtaWFbozJkwRmmyUciRFmdbqjdGJxj9QMavmc2XvaVvZ6X4R7p2OfesWwlbMDirpi
         hx2Xk/a/GMz4QtcMLK7jHFpn1ALuJNQM2Y8TxeWW9ze6up3o0R+GCxjSTS//q3/DMyKj
         29dw==
X-Gm-Message-State: ALQs6tA++40vEQJ9o2o13hD1lNblCLbX6+2qJy8GENna7BaHatO2usy6
        eRunuQIy1y/jQAc5fuLgCG7oqp58YOLw6qLlN4k=
X-Google-Smtp-Source: AB8JxZpcOMPtZodYWIiCR0kd3MfPLyQjC4ae/kofKXVtQ6U+QDnzzvCDbEce7UMVKFVqOmeGJ7F3VNy93OTRj+YqHIQ=
X-Received: by 2002:a9d:4197:: with SMTP id p23-v6mr17907802ote.75.1525364952251;
 Thu, 03 May 2018 09:29:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 3 May 2018 09:28:41 -0700 (PDT)
In-Reply-To: <20180430153122.243976-6-jamill@microsoft.com>
References: <20180417163400.3875-1-jamill@microsoft.com> <20180430153122.243976-1-jamill@microsoft.com>
 <20180430153122.243976-6-jamill@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 May 2018 18:28:41 +0200
Message-ID: <CACsJy8Dxz8dph=Ouy2C9PXQaJUJw86FHdobvJxcR-Dx+w5iO0Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] block alloc: add validations around cache_entry lifecyle
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "sbeller@google.com" <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 5:31 PM, Jameson Miller <jamill@microsoft.com> wrote:
> Add an option (controlled by an environment variable) perform extra
> validations on mem_pool allocated cache entries. When set:
>
>   1) Invalidate cache_entry memory when discarding cache_entry.
>
>   2) When discarding index_state struct, verify that all cache_entries
>      were allocated from expected mem_pool.
>
>   3) When discarding mem_pools, invalidate mem_pool memory.

On linux step 3 could be better achieved by allocating blocks with
mmap() and freeing them with munmap(). Access to already munmap()'d
blocks will result in segmentation fault regardless of values.  I
guess Windows also has something similar (I vaguely remember something
about "locking memory" and stuff, but my win32 knowledge is decade old
at this point)

(Actually with glibc on linux, i'm pretty sure mmap is already used
for large allocation so step 3 is achieved without doing anything; not
sure about other libc implementations)

> This should provide extra checks that mem_pools and their allocated
> cache_entries are being used as expected.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  cache.h      |  7 +++++++
>  git.c        |  3 +++
>  mem-pool.c   | 24 +++++++++++++++++++++++-
>  mem-pool.h   |  2 ++
>  read-cache.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/cache.h b/cache.h
> index 7ed68f28e0..8f10f0649b 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -369,6 +369,13 @@ void discard_index_cache_entry(struct cache_entry *ce);
>   */
>  void discard_transient_cache_entry(struct cache_entry *ce);
>
> +/*
> + * Validate the cache entries in the index.  This is an internal
> + * consistency check that the cache_entry structs are allocated from
> + * the expected memory pool.
> + */
> +void validate_cache_entries(const struct index_state *istate);
> +
>  #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
>  #define active_cache (the_index.cache)
>  #define active_nr (the_index.cache_nr)
> diff --git a/git.c b/git.c
> index f598fae7b7..28ec7a6c4f 100644
> --- a/git.c
> +++ b/git.c
> @@ -347,7 +347,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>
>         trace_argv_printf(argv, "trace: built-in: git");
>
> +       validate_cache_entries(&the_index);
>         status = p->fn(argc, argv, prefix);
> +       validate_cache_entries(&the_index);
> +
>         if (status)
>                 return status;
>
> diff --git a/mem-pool.c b/mem-pool.c
> index a495885c4b..77adb5d5b9 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -60,21 +60,43 @@ void mem_pool_discard(struct mem_pool *mem_pool)
>  {
>         int i;
>         struct mp_block *block, *block_to_free;
> +       int invalidate_memory = should_validate_cache_entries();

Heh.. cache-entries logic should not enter mem-pool.c.

> +
>         for (block = mem_pool->mp_block; block;)
>         {
>                 block_to_free = block;
>                 block = block->next_block;
> +
> +               if (invalidate_memory)
> +                       memset(block_to_free->space, 0xDD, ((char *)block_to_free->end) - ((char *)block_to_free->space));
> +
>                 free(block_to_free);
>         }
>
> -       for (i = 0; i < mem_pool->nr; i++)
> +       for (i = 0; i < mem_pool->nr; i++) {
> +               memset(mem_pool->custom[i], 0xDD, ((char *)mem_pool->custom_end[i]) - ((char *)mem_pool->custom[i]));

"if (invalidate_memory)" missing

>                 free(mem_pool->custom[i]);
> +       }
>
>         free(mem_pool->custom);
>         free(mem_pool->custom_end);
>         free(mem_pool);
>  }
>
> +int should_validate_cache_entries(void)
> +{
> +       static int validate_index_cache_entries = -1;
> +
> +       if (validate_index_cache_entries < 0) {
> +               if (getenv("GIT_TEST_VALIDATE_INDEX_CACHE_ENTRIES"))

There's a safer version that you can use, get_env_bool()

> +                       validate_index_cache_entries = 1;
> +               else
> +                       validate_index_cache_entries = 0;
> +       }
> +
> +       return validate_index_cache_entries;
> +}
> +
>  void *mem_pool_alloc(struct mem_pool *mem_pool, size_t len)
>  {
>         struct mp_block *p;
> diff --git a/mem-pool.h b/mem-pool.h
> index 34df4fa709..b1f9a920ba 100644
> --- a/mem-pool.h
> +++ b/mem-pool.h
> @@ -63,4 +63,6 @@ void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src);
>   */
>  int mem_pool_contains(struct mem_pool *mem_pool, void *mem);
>
> +int should_validate_cache_entries(void);
> +
>  #endif
> diff --git a/read-cache.c b/read-cache.c
> index 01cd7fea41..e1dc9f7f33 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1270,6 +1270,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>  {
>         int pos;
>
> +       validate_cache_entries(istate);

Validating _all_ entries every time an entry is added sounds way too expensive.

> +
>         if (option & ADD_CACHE_JUST_APPEND)
>                 pos = istate->cache_nr;
>         else {
> @@ -1290,6 +1292,8 @@ int add_index_entry(struct index_state *istate, struct cache_entry *ce, int opti
>                            istate->cache_nr - pos - 1);
>         set_index_entry(istate, pos, ce);
>         istate->cache_changed |= CE_ENTRY_ADDED;
> +
> +       validate_cache_entries(istate);
>         return 0;
>  }
>
> @@ -2013,6 +2017,8 @@ int is_index_unborn(struct index_state *istate)
>
>  int discard_index(struct index_state *istate)
>  {
> +       validate_cache_entries(istate);
> +
>         resolve_undo_clear_index(istate);
>         istate->cache_nr = 0;
>         istate->cache_changed = 0;
> @@ -2035,6 +2041,43 @@ int discard_index(struct index_state *istate)
>         return 0;
>  }
>
> +
> +/*
> + * Validate the cache entries of this index.
> + * All cache entries associated with this index
> + * should have been allocated by the memory pool
> + * associated with this index, or by a referenced
> + * split index.
> + */
> +void validate_cache_entries(const struct index_state *istate)
> +{
> +       int i;
> +       int validate_index_cache_entries = should_validate_cache_entries();
> +
> +       if (!validate_index_cache_entries)
> +               return;
> +
> +       if (!istate || !istate->initialized)
> +               return;
> +
> +       for (i = 0; i < istate->cache_nr; i++) {
> +               if (!istate) {
> +                       die("internal error: cache entry is not allocated from expected memory pool");
> +               } else if (!istate->ce_mem_pool ||
> +                       !mem_pool_contains(istate->ce_mem_pool, istate->cache[i])) {
> +                       if (!istate->split_index ||
> +                               !istate->split_index->base ||
> +                               !istate->split_index->base->ce_mem_pool ||
> +                               !mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cache[i])) {
> +                               die("internal error: cache entry is not allocated from expected memory pool");
> +                       }
> +               }
> +       }
> +
> +       if (istate->split_index)
> +               validate_cache_entries(istate->split_index->base);
> +}
> +
>  int unmerged_index(const struct index_state *istate)
>  {
>         int i;
> @@ -2828,6 +2871,10 @@ void move_index_extensions(struct index_state *dst, struct index_state *src)
>   */
>  void discard_index_cache_entry(struct cache_entry *ce)
>  {
> +       int invalidate_cache_entry = should_validate_cache_entries();
> +
> +       if (ce && invalidate_cache_entry)
> +               memset(ce, 0xCD, cache_entry_size(ce->ce_namelen));
>  }
>
>  void discard_transient_cache_entry(struct cache_entry *ce)
> --
> 2.14.3
>



-- 
Duy
