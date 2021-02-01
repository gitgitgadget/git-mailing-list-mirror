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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708E2C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325EC64ECB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBAUvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBAUvE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 15:51:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE124C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 12:50:24 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id g69so20309912oib.12
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 12:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWZ8qE94bf3yNVYrmST9KzXqQDXE/6jeaBR57bY6C/0=;
        b=tF4AmRt6h3Aba5SukEyl46o9thEm3tai4Yf7SCoPccjO/wEOdn8UGRVFrcYWQQL1vY
         enKb/QxSI/tUDcNP+a2d3CUVYmNrZYpOdZ6pkKXdYuCPkK7Nmj50x0WMsxhio33zypLV
         Ra2iwxzsdZr4RDg3XC9B2N/fq8AYI2tWwnkColGGweE+XLjJeQXRzJY1GXCg2YJSz+f1
         L5mNIBXZxqJS7aJyCp2UqkbdwZvQJycAK/CZmvrSBTBaar7gvafhM4x1EojVFvED6O93
         elDNv3Cc9SILTXbgVxZ9nQRtysfXkK/E3RZ/L+LebZ9KmFgmHzM912ulDQceLfZZJRh4
         o0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWZ8qE94bf3yNVYrmST9KzXqQDXE/6jeaBR57bY6C/0=;
        b=ZAPdJ5OtYE6iRbiGIFbJv9kFo+IoIh3VZnr4Y3Hu1ZkpeZWSmEidg4/f8NKyTtRgVA
         pzGzad58lZE2an5ruWESyniMUF50xCtsTO2XvI9h69IOAIcKIWi1XgcOrXb5MXjhbHWA
         1Xc8gKLB0ukwGfOwA83OX4hCJ6B5Jw99qpg+p/GjcmrI9w4nBBLQ3Jg+5CBQ3IGsXqFj
         r9m/svDetxZUETVoQaxBiUm2JpA1HjQJyUOxnmJPxpYu5wKFSYPitH6IhMxo0il3b7a5
         FbaIFoNdax2SjlgGN79k7AwBJyJj88Uy/ok9QKPvRtonnEM3go0eM0GS5q/Ljhslqbci
         W3lg==
X-Gm-Message-State: AOAM533sP7ya0Lt+WO/VaiBQmdse1fR6nD89oJN0AOVpUXyfaOgrAc+/
        D8EmPwS1u2G+HaxLOirgL87Kkrz/vWt2QEYgzKE=
X-Google-Smtp-Source: ABdhPJx1VNmXs/x1fYSOtEolShENzeT19BamRxHE7gRoC2p2t9h8USDIdX0krm71rfdH73wgJOXXaNlOZy/Y6ej7JVg=
X-Received: by 2002:aca:a816:: with SMTP id r22mr488062oie.31.1612212623923;
 Mon, 01 Feb 2021 12:50:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <45cf57c9c40bebb7383b8aab19c82fc4e41d2cd3.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <45cf57c9c40bebb7383b8aab19c82fc4e41d2cd3.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 12:50:12 -0800
Message-ID: <CABPp-BEjm1NJ8GAn6iKJDvgFYw7mMrR8T66RZtUi6nwgPcXRHQ@mail.gmail.com>
Subject: Re: [PATCH 16/27] unpack-trees: make sparse aware
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
> As a first step to integrate 'git status' and 'git add' with the sparse
> index, we must start integrating unpack_trees() with sparse directory
> entries. These changes are currently impossible to trigger because
> unpack_trees() calls ensure_full_index() if command_requires_full_index
> is true. This is the case for all commands at the moment. As we expand
> more commands to be sparse-aware, we might find that more changes are
> required to unpack_trees(). The current changes will suffice for
> 'status' and 'add'.
>
> unpack_trees() calls the traverse_trees() API using unpack_callback()
> to decide if we should recurse into a subtree. We must add new abilities
> to skip a subtree if it corresponds to a sparse directory entry.

Makes sense.

> It is important to be careful about the trailing directory separator
> that exists in the sparse directory entries but not in the subtree
> paths.

The comment makes me wonder if leaving the trailing directory
separator out would be better, as it'd allow direct comparisons.  Of
course, you have a better idea of what is easier or harder based on
this decision.  Is there any chance you have a quick list of the
places that the code was simplified by this decision and a list of
places like this one that were made slightly harder?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.h           |  2 +-
>  preload-index.c |  2 ++
>  read-cache.c    |  3 +++
>  unpack-trees.c  | 24 ++++++++++++++++++++++--
>  4 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/dir.h b/dir.h
> index facfae47402..300305ec335 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -503,7 +503,7 @@ static inline int ce_path_match(const struct index_state *istate,
>                                 char *seen)
>  {
>         return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
> -                             S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
> +                             S_ISSPARSEDIR(ce) || S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));

I think this hunk becomes unnecessary if you use ce_mode = 040000 for
sparse directory entries.

>  }
>
>  static inline int dir_path_match(const struct index_state *istate,
> diff --git a/preload-index.c b/preload-index.c
> index ed6eaa47388..323fc8c5100 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -54,6 +54,8 @@ static void *preload_thread(void *_data)
>                         continue;
>                 if (S_ISGITLINK(ce->ce_mode))
>                         continue;
> +               if (S_ISSPARSEDIR(ce))
> +                       continue;
>                 if (ce_uptodate(ce))
>                         continue;
>                 if (ce_skip_worktree(ce))
> diff --git a/read-cache.c b/read-cache.c
> index 65679d70d7c..ab0c2b86ec0 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1572,6 +1572,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>                 if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
>                         continue;
>
> +               if (istate->sparse_index && S_ISSPARSEDIR(ce))
> +                       continue;
> +
>                 if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
>                         filtered = 1;
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index b324eec2a5d..90644856a80 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -583,6 +583,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
>  {
>         ce->ce_flags |= CE_UNPACKED;
>
> +       /*
> +        * If this is a sparse directory, don't advance cache_bottom.
> +        * That will be advanced later using the cache-tree data.
> +        */
> +       if (S_ISSPARSEDIR(ce))
> +               return;

I don't grok the cache_bottom stuff -- in general, nothing specific
about your patch.  But since I don't grok that stuff, it means I don't
understand how your comment here relates; you may want to ping another
reviewer about this portion of the patch.

> +
>         if (o->cache_bottom < o->src_index->cache_nr &&
>             o->src_index->cache[o->cache_bottom] == ce) {
>                 int bottom = o->cache_bottom;
> @@ -980,6 +987,9 @@ static int do_compare_entry(const struct cache_entry *ce,
>         ce_len -= pathlen;
>         ce_name = ce->name + pathlen;
>
> +       /* remove directory separator if a sparse directory entry */
> +       if (S_ISSPARSEDIR(ce))
> +               ce_len--;

Here's where your comment about trailing separator comes in; makes sense.

>         return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
>  }
>
> @@ -989,6 +999,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
>         if (cmp)
>                 return cmp;
>
> +       /* If ce is a sparse directory, then allow equality here. */
> +       if (S_ISSPARSEDIR(ce))
> +               return 0;
> +

This seems surprising to me.  Is there a chance you are comparing
sparse directory A with sparse directory B and you return with
equality?  Or sparse_directory A with regular file B?  Do the callers
still do the right thing?  If your code change here is right, it seems
like it deserves an extra comment either in the code or the commit
message.

>         /*
>          * Even if the beginning compared identically, the ce should
>          * compare as bigger than a directory leading up to it!
> @@ -1239,6 +1253,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>         struct unpack_trees_options *o = info->data;
>         const struct name_entry *p = names;
> +       unsigned recurse = 1;
>
>         /* Find first entry with a real name (we could use "mask" too) */
>         while (!p->mode)
> @@ -1280,12 +1295,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                                         }
>                                 }
>                                 src[0] = ce;
> +
> +                               if (S_ISSPARSEDIR(ce))
> +                                       recurse = 0;
>                         }
>                         break;
>                 }
>         }
>
> -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> +       if (recurse &&
> +           unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
>                 return -1;
>
>         if (o->merge && src[0]) {
> @@ -1315,7 +1334,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                         }
>                 }
>
> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> +               if (recurse &&
> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>                                              names, info) < 0)
>                         return -1;
>                 return mask;

The unpack_callback() code has some comparison to a cache-tree, but
I'd assume that you'd need to update cache-tree.c somewhat to take
advantage of these sparse directory entries.  Am I wrong, and you just
get cache-tree.c working with sparse directory entries for free?  Or
is this something coming in a later patch?
