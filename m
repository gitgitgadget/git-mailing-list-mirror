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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67114C433DB
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302232070A
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388828AbhATRdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbhATRYf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:24:35 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832CC061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:23:55 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id w8so4014397oie.2
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D+RpBB6vsplLnlFDQevsR0NQg9z4WVCbs1tyfRU7u7w=;
        b=aZcdzxl9+7QivbLQ91vMcNs3/S+AzSo3HLOim023UhQoD29I/H3PomUCwQLofg5gAh
         lmvitOERWQnYtijCC2t8iaQ0BASU3zLtsyhT/W39Vucq8z+XnKGDtKecy38RsKQ+i4sk
         zW9nd1xmvKjRuoJDHH6leMVRJIeZd1nMcQEJ5M0RFeQ9awTEE2UX15iWz1zA8tlfB/qU
         qtDfszbh2J4CIrUDYGtyxLHTen/S+eaj+AHGIWjCMW0IJzspVn3t1MsEWwJAqdU+ZfDz
         ZpAAuDFpCA8rMFSIK6Mib3FTvACz1Sa5rTL97p2dV4p4cJz3IHPgemq5PAtvMpxeTJ6I
         CVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D+RpBB6vsplLnlFDQevsR0NQg9z4WVCbs1tyfRU7u7w=;
        b=E42KS/dXpz8j3iuJ0/UC4WMj+poROP5ev8V1zegzJM8Prsmbb7Vef6w8GuKBWLKrel
         FB7rmbL7uYsc25qoi7qLJRMZ/u2QzNqR9F5bnO2L7NLiZGUAqSO6+J8fKu/aqSfm2qBH
         0a+YOM3vre1HVhTT+EQHRBsof6+tsNEtzMjJADxLGe96M5Flt7ZhGm2jhnOWVhSr6Iee
         Ls8rjqflhXo/qAyGmtOGTzSzuPxERsg9goQzV8iJBgtlH62f+Q2tOtO90EP61KwT53/q
         zqIQ/TTqBMWmcPvg3qHo3Ag/97/w7MxajZiMTQJF1iopaQqZjZygqj7ikK0v29X5em9j
         Qymg==
X-Gm-Message-State: AOAM531eY5KPVOFTWTO+RRZ+nlbeVKdTgGBR9jy23dD9x080TCuqxxp5
        N8QFxJLngm7KzSmwAmzmEOsbiPQFqh4I6L+AbTc=
X-Google-Smtp-Source: ABdhPJzPddDiESfvNWdXHQBmddztIR2+nMHm/Z2HhP94HZkNR8CgVsmXjWnKyi03lPiuez4VIul0ucrkwtcYgbofS90=
X-Received: by 2002:aca:cf03:: with SMTP id f3mr3513004oig.39.1611163434900;
 Wed, 20 Jan 2021 09:23:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <a6f2406a79512f517a1bc2700f806c546bbe9ed6.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <a6f2406a79512f517a1bc2700f806c546bbe9ed6.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 09:23:43 -0800
Message-ID: <CABPp-BH7K3ddUEJ2aKqZ4D5bkNh43JNm5LuvDRbC5e2nQfVa0g@mail.gmail.com>
Subject: Re: [PATCH 2/9] cache-tree: extract subtree_pos()
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
> This method will be helpful to use outside of cache-tree.c in a later
> feature. The implementation is subtle due to subtree_name_cmp() sorting
> by length and then lexicographically.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c | 6 +++---
>  cache-tree.h | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index c1e49901c17..2b130dd5e19 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -45,7 +45,7 @@ static int subtree_name_cmp(const char *one, int onelen,
>         return memcmp(one, two, onelen);
>  }
>
> -static int subtree_pos(struct cache_tree *it, const char *path, int pathlen)
> +int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen)
>  {
>         struct cache_tree_sub **down = it->down;
>         int lo, hi;
> @@ -72,7 +72,7 @@ static struct cache_tree_sub *find_subtree(struct cache_tree *it,
>                                            int create)
>  {
>         struct cache_tree_sub *down;
> -       int pos = subtree_pos(it, path, pathlen);
> +       int pos = cache_tree_subtree_pos(it, path, pathlen);
>         if (0 <= pos)
>                 return it->down[pos];
>         if (!create)
> @@ -123,7 +123,7 @@ static int do_invalidate_path(struct cache_tree *it, const char *path)
>         it->entry_count = -1;
>         if (!*slash) {
>                 int pos;
> -               pos = subtree_pos(it, path, namelen);
> +               pos = cache_tree_subtree_pos(it, path, namelen);
>                 if (0 <= pos) {
>                         cache_tree_free(&it->down[pos]->cache_tree);
>                         free(it->down[pos]);
> diff --git a/cache-tree.h b/cache-tree.h
> index 639bfa5340e..8efeccebfc9 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -27,6 +27,8 @@ void cache_tree_free(struct cache_tree **);
>  void cache_tree_invalidate_path(struct index_state *, const char *);
>  struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
>
> +int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
> +
>  void cache_tree_write(struct strbuf *, struct cache_tree *root);
>  struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
>
> --
> gitgitgadget

Simple, straight-forward patch for exposing the function outside the
file scope; looks good.
