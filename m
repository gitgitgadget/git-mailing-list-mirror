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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EF4C433E6
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1BF223E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 17:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbhATRs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 12:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731598AbhATRso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 12:48:44 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B44C0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:48:02 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q25so25875204oij.10
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 09:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPYSIVowYOtVFeW8R0APLoJ9DWUvM3bgz35+ypZi3Us=;
        b=jY/iuj3CixyFuRYzWqPNp9vcAIaSzaHOa6801SvIDp1XlEQB0djlBR3PqGsdtDUr7W
         1krEVmT/4hahBrWSHIbfDTayxBZrEUMB7H2FvfeS8AexHNRWTYsMQzeRLrWtHe0wHAiy
         PYq8dQAa5nQ+sLvnU9wenWm9oNUEBbat1zgHwA4EuPHrBopauIwJWcenwPFeLhTHW0K0
         rRDJR2xty1LG6CMjuZthQA0HtOxZRTccq2D4MYpu3sxVO9MxKbEjhHlkm4rCA7m1q/n8
         8r3XUanj52WCGiiTgA6IAdUp7ead8lXcAvgJXqp3W5Q11AdLNKbS2vmzQnvWNTGN2J8r
         c7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPYSIVowYOtVFeW8R0APLoJ9DWUvM3bgz35+ypZi3Us=;
        b=ZF8TH/Wklg6UnpadnrD/ZIIx4RMhipHgxappY9ozZXJ6YWlX36y80SLEsjM283SVfT
         Y5NEp8odr+0b5OGAYN7mqFrUJ0ukA+my1HfB32uXH8s3EuaqZCV/sbWJ58LWwRJ2Yydf
         516pPiZ0VcXZnZmnI6Qnz8UbgMyqvpUBLfSmYN81hO8io/ugqDEAH9Xg7WFG+sSUDqdV
         GNhdEfROc8LzZazJ5YMkNC9Soh9vpb/7gtMh+5Idz0yncsYDD+YGsHnQ/jhES9R5H3Dd
         mUWCYAwDw+opKmAJNWA5Q6mtMX5vLU+AFtAQo0rm8fi8kSUzsPwxhBB1ouLQxLKBRVn9
         wUjA==
X-Gm-Message-State: AOAM532/z8FqPgo25O65glCmCYBT2J8qOyilcRBPJs5lFsPWLPAsYoMC
        ZQrtI84u8z1TDuSX4yxFAyqEE2L7zYB942PqPw0=
X-Google-Smtp-Source: ABdhPJxvD41QLmSO+BoA2infHOG+OzMclswc+kYL3CLC83DKJe3FBIRenDkZba+HxbtlxKt04hY0qZmSWmx5TzfQ0TI=
X-Received: by 2002:a05:6808:83:: with SMTP id s3mr3650487oic.31.1611164881792;
 Wed, 20 Jan 2021 09:48:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.839.git.1611161639.gitgitgadget@gmail.com> <3ba4b35f09cf3dc313787cdec6856286fe97d8a8.1611161639.git.gitgitgadget@gmail.com>
In-Reply-To: <3ba4b35f09cf3dc313787cdec6856286fe97d8a8.1611161639.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jan 2021 09:47:50 -0800
Message-ID: <CABPp-BEhJDd=Om49Cpb2CuuHn_UBuNaxJjGKZEhWfY3r3vcefA@mail.gmail.com>
Subject: Re: [PATCH 5/9] name-hash: use trace2 regions for init
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
> The lazy_init_name_hash() populates a hashset with all filenames and
> another with all directories represented in the index. This is run only
> if we need to use the hashsets to check for existence or case-folding
> renames.
>
> Place trace2 regions where there is already a performance trace.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  name-hash.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/name-hash.c b/name-hash.c
> index 5d3c7b12c18..4e03fac9bb1 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -7,6 +7,7 @@
>   */
>  #include "cache.h"
>  #include "thread-utils.h"
> +#include "trace2.h"
>
>  struct dir_entry {
>         struct hashmap_entry ent;
> @@ -577,6 +578,7 @@ static void lazy_init_name_hash(struct index_state *istate)
>         if (istate->name_hash_initialized)
>                 return;
>         trace_performance_enter();
> +       trace2_region_enter("index", "name-hash-init", istate->repo);
>         hashmap_init(&istate->name_hash, cache_entry_cmp, NULL, istate->cache_nr);
>         hashmap_init(&istate->dir_hash, dir_entry_cmp, NULL, istate->cache_nr);
>
> @@ -597,6 +599,7 @@ static void lazy_init_name_hash(struct index_state *istate)
>         }
>
>         istate->name_hash_initialized = 1;
> +       trace2_region_leave("index", "name-hash-init", istate->repo);
>         trace_performance_leave("initialize name hash");
>  }
>
> --
> gitgitgadget

Yaay for trace2.  :-)

Total sidenote: Are we ever going to get rid of the trace1 stuff?  I'm
sure this was discussed somewhere, but I don't know where.
