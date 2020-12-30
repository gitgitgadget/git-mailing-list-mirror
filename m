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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A8EC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274BE20729
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 20:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgL3UPR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 15:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3UPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 15:15:16 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20DCC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:14:36 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q205so19774370oig.13
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 12:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZqfTHZlon7H13FEH+pzFmjqFNzxupamsWuhOqIyYbE=;
        b=Ps8whHzgRFQYzZrRqjHENxR7H4DU9km79/LY7Y3kVxA/xmkdgXdadE9qmXqVl5jdDA
         laEa8CT22rVRJL7jziiNBKXlyaV6eFYDNfrEBBlVuiUiNfOOeOlyfIvaNWp0yJLVGhiK
         sQ55GrmIB2z/fYAf8FkspGK5/REt2xY/SGNJj5MFXapq48SPv5sEarGQehRWqCRScYTK
         UiXilXx8HdS7B/cfV7ws0Np7257ivMAFJV38f64MsRKchQFpzYcIpZB8MvsIIVqOboGD
         CC/CrNygaZEoVSt1eQSTKs4MYMkPUE3ZBGuluTyjkmdeaJXRgrFwuMyiReh6/vVK5htE
         Yl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZqfTHZlon7H13FEH+pzFmjqFNzxupamsWuhOqIyYbE=;
        b=dLI8hJkIlqI5dOUv+O3h6TAMpG5n9ujR6WJFjUPQLW9PvkIYmozU5TEuzWtyL9maBh
         8x9ltfBo3HoaqrXi5m2mkGIkE7FzbEy0dVei7utcxRqEtIYlY1KfthuxlPpdoCa8IwKP
         56ZfRXSqoT8JW1O2Nk1OPDW4YWIqbj49h08luf8tBwddv7cenKpILQfyd1uyrAZ/6u+K
         VC/HIW31EI2Ju5fpR/KXGBBY5qpd8tB2YlMHdb7JXD5k6L0QHvZAkgPpmSXbxJNwUtRP
         oIAXfhj1WsYfKOZ7u8QYN/Yt3M4+suedCvJOfEggnqKcOBbCHMS4jpNwSn5PVjUVIx5/
         0uNQ==
X-Gm-Message-State: AOAM530vV66p1NOnf41Kyy9B+LbqrqCIR44NpBE/jmTHaz3BzTbBZnjb
        zqG0lZsr09Ue5AinPsHC4OBqjuWUqI8EWQlV5Ak=
X-Google-Smtp-Source: ABdhPJw1/unUfq1RPwYdqsXJX2ir6frUOurpMweP0iHHqvr0ok9ec1scj/hawnXm+8aRQ6Ar4WWU6blorXaMX8uhyOs=
X-Received: by 2002:aca:3151:: with SMTP id x78mr6175019oix.39.1609359276064;
 Wed, 30 Dec 2020 12:14:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.829.git.1609356413.gitgitgadget@gmail.com> <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
In-Reply-To: <20ea7050324cdd78b0966f54366b26224dfc7814.1609356414.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Dec 2020 12:14:25 -0800
Message-ID: <CABPp-BFp5=C+6B1WUarXzabo0fU4xotP5UG91-hYahCHDA6Cng@mail.gmail.com>
Subject: Re: [PATCH 8/8] cache-tree: avoid path comparison loop when silent
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 30, 2020 at 11:27 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The verify_cache() method is used both for debugging issues with the
> cached tree extension but also to avoid using the extension when there
> are unmerged entries. It also checks for cache entries out of order with
> respect to file-versus-directory sorting.
>
> In 996277c (Refactor cache_tree_update idiom from commit, 2011-12-06),
> the silent option was added to remove the progress indicators from the
> initial loop looking for unmerged entries. This was changed to be a flag
> in e859c69 (cache-tree: update API to take abitrary flags, 2012-01-16).
>
> In both cases, the silent option is ignored for the second loop that
> checks for file-versus-directory sorting. It must be that this loop is
> intended only for debugging purposes and is not actually helpful in
> practice.

Looking through that code, I come to the same conclusion, though it
might be nice to have Junio confirm (and to explain the "if (10 <
++funny)" section; did that help debugging too?).   The second part of
the loop was part of his initial commit adding the cache-tree
extension in commit 749864627c ("Add cache-tree.", 2006-04-23)

> Since verify_cache() is called in cache_tree_update(), which is run
> during 'git commit', we could speed up 'git commit' operations by not
> iterating through this loop another time. Of course, noticing this loop
> requires an incredibly large index.
>
> To get a measurable difference, I needed to run this test on the
> Microsoft Office monorepo, which has over three million entries in its
> index. I used 'git commit --amend --no-edit' as my command and saw the
> performance go from 752ms to 739ms with this change.

Nice catch; I always appreciate when we can speed up a section of code
by just not running it.  :-)

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index f135bb77af5..c6c084463bd 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -175,10 +175,15 @@ static int verify_cache(struct cache_entry **cache,
>         if (funny)
>                 return -1;
>
> -       /* Also verify that the cache does not have path and path/file
> +       /*
> +        * Also verify that the cache does not have path and path/file
>          * at the same time.  At this point we know the cache has only
> -        * stage 0 entries.
> +        * stage 0 entries. In silent mode, we do not want these messages,
> +        * and they should not exist unless a bug was introduced along
> +        * the way.
>          */
> +       if (silent)
> +               return 0;
>         funny = 0;
>         for (i = 0; i < entries - 1; i++) {
>                 /* path/file always comes after path because of the way
> --
> gitgitgadget

Change seems simple enough.  Thanks for adding the comment explaining
the early return.
