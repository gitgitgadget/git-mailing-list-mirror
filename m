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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D9C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D9464DA0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhA0RkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344041AbhA0Rhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 12:37:35 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2831C061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:36:54 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id e70so2462659ote.11
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaKJYJiWQ9oW8q7NHZBG2llC8AvoblSbwu+rPprhLIc=;
        b=R0XGz3GaGi7Tf8la8FRsN23mXlARsHgCREgMPWYkv2hdto+nZkdyIsAIhxMkiPIm53
         HSbBW1nu/6bRW1nFmuXz30v8xEHz506lsZdmaiofAAjyHRIPFePZmssofh/B6mDyh0cT
         zY6w4rE4IiMioZm7R6a9rwKjQtWOs0eqFloaZeK2ReMIAciouz+xVfJJc94JHTJgyNoi
         5Cjlau7yZmul2Pob/OqyZ6tn6wN/LaSNBlb+Jhj7jnL3Br72zEN20PFvyK9tCOZJSdhD
         OhBmNd0UWWJSD8VIXy/F5VyVO3J6RSjkHTvqS6eW7xFP0aMEOmz6Axxq9mlfHFHVLhj6
         T1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaKJYJiWQ9oW8q7NHZBG2llC8AvoblSbwu+rPprhLIc=;
        b=iZD7XavBdT+K9HjR+MtagvZgCex7tQN37lQzZyH604h33129oG+/vvtXEC2d+TzBdm
         1BK63DmcyZc8IN5yO9JuRaHHTfI3K5vpks/lL6vvWo355erxHPkKcDFdQJTCNHPXEZ/u
         e3NI2UFlgE5OBMpNOOudtXA5tVpAOEqlBGqTbrAA6dc+0sIUBp++S4Vf1kk3q5f/ho9W
         Wvb/tDdj848WUDkUwKeR4K2oncehelO0oF7SZMhebumUlHEJLrzL69ohZHdhFx4Hy6C7
         hxedqfMDGSrZlJvYlZYtXh/BL6OwL1ZMAOuSohd/Lfz6d5GrAZuuvUspKITtoaBKUQ2H
         l/kg==
X-Gm-Message-State: AOAM532pREhYo473RIlpEH47Kb2sS9b0EDUNzPJOqmniITsLRhO8VMgN
        hvbjf9B5ME0uxvV+ZT/LiedpCi6kGQocFsKPA3bHllAZt/o=
X-Google-Smtp-Source: ABdhPJy3wcx2199wfXK0+e3SmklEh+UqrsAa7J6pKvA7f5jf/i7ldQw/8KYEx261rN4UcsL8cfRbX2TmM6sQk697bto=
X-Received: by 2002:a9d:506:: with SMTP id 6mr8279461otw.162.1611769014177;
 Wed, 27 Jan 2021 09:36:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <09893b4a6bbe13e61395411bdae57ce041829042.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <09893b4a6bbe13e61395411bdae57ce041829042.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 09:36:43 -0800
Message-ID: <CABPp-BGPJgA4guWHVm3AVS=hM0fTixUpRvJe5i9NnHT-3QJMfw@mail.gmail.com>
Subject: Re: [PATCH 11/27] unpack-trees: allow sparse directories
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
> The index_pos_by_traverse_info() currently throws a BUG() when a
> directory entry exists exactly in the index. We need to consider that it
> is possible to have a directory in a sparse index as long as that entry
> is itself marked with the skip-worktree bit.
>
> The negation of the 'pos' variable must be conditioned to only when it
> starts as negative. This is identical behavior as before when the index
> is full.

The first sentence of this paragraph was really hard for me to parse.
Reading the code and then reading the sentence I could make sense of
it, but I struggled to do so the other way around.  Is there some way
to reword this?  Or is this just a reading comprehension issue on my
part?  (It might be...)

> The starts_with() condition matches because our name.buf terminates with
> a directory separator, just like our sparse directory entries.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 4dd99219073..b324eec2a5d 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -746,9 +746,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
>         strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
>         strbuf_addch(&name, '/');
>         pos = index_name_pos(o->src_index, name.buf, name.len);
> -       if (pos >= 0)
> -               BUG("This is a directory and should not exist in index");
> -       pos = -pos - 1;
> +       if (pos >= 0) {
> +               if (!o->src_index->sparse_index ||
> +                   !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
> +                       BUG("This is a directory and should not exist in index");
> +       } else
> +               pos = -pos - 1;
>         if (pos >= o->src_index->cache_nr ||
>             !starts_with(o->src_index->cache[pos]->name, name.buf) ||
>             (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
> --
> gitgitgadget

The patch looks pretty straightforward to me.
