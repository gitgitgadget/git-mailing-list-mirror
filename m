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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C571AC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 05:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8629061580
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 05:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhCRFXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCRFXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 01:23:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70366C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 22:23:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso4102223otq.3
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 22:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOzjtvKDkUYvTd0Gp6f5F2rOa8zLXU0ecZEq7mjbIPw=;
        b=qD/WVYJJPGphGVnnQI9/zkBtqn+O5bAF8bOohqVxuUhYz0Dby7FQ+r53fUwv6skfIf
         45rUTcNv0kJEKsK5JzrK2d8zmGafl0+Jz+dXuVNVD9GecRjIWV9u6mhL4rPAt2h7lYs6
         7kHP9Q4s4CBAdhG+6uHzaGb7DRCbiPUilt1LpWgkxDMe0z18iWzz66hq5E2zlUz1v7zG
         vNttp7meNobklYNllB/q7OwrS5396JdzOORVqGeOTNq2Hz2SKxwwDR3WU7EoYDI9JZ3+
         yqwITvsZ7GlgUr0wgRQr+sH+Hu7gkSAA7O9R/SZs3BQwavSY4huzjiUoPu5SmgCq5u4S
         sisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOzjtvKDkUYvTd0Gp6f5F2rOa8zLXU0ecZEq7mjbIPw=;
        b=IWv8nw831Kzjkola52ZrHMbjH630xYhmq4q3fThuMa8riFEe+whOrOw5YyVH+wCEPv
         ecz501Ou0q60QTx3m22Sog7ai7Tw4kcthCtweWu069jUorKMC3apeVZyeydZ51qpdlB9
         C2U6hOLmf4vM77VRzndK8w2Hj7zCU1GMpFVzVGdnmMqMZryhSTXuJL3qVW/quoRF3zfV
         J0SahGA8mzYhTkvD3zSwomxP6k5U+w87TD1ERhglsEsfolynCXaquckObtUBJcT5PKy2
         EpiTeNiUaIzi4la6EgtbAnDXbXgDt5EiBoCmcTJjJOhJpTXKG2B1iEPCGeKXgSVRW7rF
         nB5g==
X-Gm-Message-State: AOAM532YAclmGpjc1y5Y5QPxWVkbwlCuGHW2uKv70eUvJwTKj0S1WodW
        Xc9sRxxGRyDqLhdetjeaKe9G2GwVumr8AHysd/8FkrMgJ+BNRw==
X-Google-Smtp-Source: ABdhPJxjuVGw9Z/BUy1zwB/paHBPQyIp//i8M0tTBFN8f3+6VKZaV0b/IKJ3D92HZfCViQQQ9irN1vGSodVjoLT/ZSw=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr6111584otf.345.1616044985627;
 Wed, 17 Mar 2021 22:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com> <92ccd31dd343c20bad4a6b8d89c50559209e7236.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <92ccd31dd343c20bad4a6b8d89c50559209e7236.1615929436.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 22:22:54 -0700
Message-ID: <CABPp-BF4YVSNB1c=y11MZfTDAu=KHryNb5JQZ1kKRpigPALPxw@mail.gmail.com>
Subject: Re: [PATCH 15/27] sparse-checkout: ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When adjusting the sparse-checkout definition, ensure that a sparse
> index is expanded to a full one to avoid unexpected behavior. This is a
> top candidate for later integration with the sparse-index, but requires
> careful testing.


I was going to comment on most of these collectively, but your commit
message is completely divorced from the patch; it appears you either
place the wrong commit message here or copied it from the one for a
sparse-checkout.  The code modifies stash, though.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/stash.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index ba774cce674f..b3d4fe814b6b 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1350,6 +1350,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>                 int i;
>                 char *ps_matched = xcalloc(ps->nr, 1);
>
> +               ensure_full_index(&the_index);
>                 for (i = 0; i < active_nr; i++)
>                         ce_path_match(&the_index, active_cache[i], ps,
>                                       ps_matched);
> --
> gitgitgadget
