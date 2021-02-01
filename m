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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE19C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9233764E7A
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhBAXW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbhBAXWY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:22:24 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCD6C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 15:21:44 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id t25so7974918otc.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 15:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0a3baMn+9OU5RbriCeI8d4q+25+YnhJ7SeSMEKQgEBU=;
        b=kpKEcqlsxc6Dj7RQqdUQ0PmY8UWuSyUH1hsbT4exIm+gHJhehhjk2hX3wrzTuO8RgR
         zQm0QQPhMRZDoLHuAqRZFZIO2KZ6YzmuF3ibZqR/0IxUVLTJ9ZNBK7/FWlngDPOcoxWy
         JBUiJBuJWLrUe11UTxoK+VkYXusP2Ef7S3Rrvg7Hqu1Hpu4vQetGE1JItLUxxmf9Qosi
         q+ZPpoQP0AD3ZHIQLG+CnmKG2Kwj2yMOKWurEIteztlf3jvPXFWWOrmvMR6kGcsHMYwe
         QHV/JMbFBgTpT/012RTqVIZ/miVHtTDoqQXLtLwn6p43IVtV07pUVevjnHFGow935lIK
         CQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0a3baMn+9OU5RbriCeI8d4q+25+YnhJ7SeSMEKQgEBU=;
        b=ADKnctZnMcBMacKH+umBG0o8wzKqOqUiwWgx/k3hMXnJWHCYESQ0h/PlrjIxRFzcS0
         IDd9OCcCL8EwL9B9DZZMf5VseEwDizuQbXpLzjn11z9sTJkghEyQz7/ZNb27r/6Fzdl8
         W2Kl+KV80n21qxAKJW/kcK5pql0aZ28e6FfIeBs0Vab3dagz9yAMkyMNnmjs0vBCSB3F
         6PQkfiWWun8eWxwLrduFzbMkd4uHS8SNd5Oxe204YXKB1bHAFKpN95vl4T+/2QiuYzGA
         wqnXNdJf7lRB/TiiWVtb14BWXmWK+LJroopl78W9e5gswT8pVv2svp3O9crgi0NgeosY
         YugQ==
X-Gm-Message-State: AOAM532OJEgPYRJxkhYwQMfm8yBz7ekbh1AVsMfndzegBAIPr7e/wZTa
        bpMQQ4bpEe9bE+YOdMU4R6uOkIZoBo0B6aJJSVM=
X-Google-Smtp-Source: ABdhPJyMUg8zMPTfa4igALNVJAnk3pVml0ISHQ8EHGNEWTzLA1xmvwWcFKKQHSAPmEM6QBraKHlaFk1PyZAPSwpafes=
X-Received: by 2002:a05:6830:402f:: with SMTP id i15mr13193989ots.345.1612221703873;
 Mon, 01 Feb 2021 15:21:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <926a2e12cf7534339e1f9bedff50d97bf251ffa2.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <926a2e12cf7534339e1f9bedff50d97bf251ffa2.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 15:21:32 -0800
Message-ID: <CABPp-BHsiLTtv6AuycRrQ5K6q0=ZTJe0kd7uTUL+UT=nxj66zA@mail.gmail.com>
Subject: Re: [PATCH 24/27] dir: use expand_to_path in add_patterns()
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
> The add_patterns() method has a way to extract a pattern file from the
> index. If this pattern file is sparse and within a sparse directory
> entry, then we need to expand the index before looking for that entry as
> a file path.

Why?

Correct me if I'm wrong, but I thought the point of add_patterns() was
to read .gitignore entries, so that we can know whether to e.g. have
status report untracked files within some directory or have clean
delete files within a directory.  But if we have a sparse directory
entry in the index, we probably have no such directory in the working
directory.  And if we have no such working directory, getting
.gitignore entries for those directories is a big waste of time.

> For now, convert ensure_full_index() into expand_to_path() to only
> expand this way when absolutely necessary.

Not only should we probably not need to read these files at all,
expand_to_path() still expands a lot more than necessary, right?  If
two directories are sparse -- moduleA and moduleB, and we need
something from under moduleA/, then expand_to_path() will call
ensure_full_index() and fill out every entry under both modules, even
if moduleB is way bigger than moduleA.  Unless I've misunderstood
something, there's multiple ways we're falling short of "only...when
absolutely necessary".


Perhaps both of these things are future work you already had planned;
if so, some tweaks to the commit message may help keep this reader
oriented.  :-)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 21998c7c4b7..7df8d3b1da0 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1093,7 +1093,7 @@ static int add_patterns(const char *fname, const char *base, int baselen,
>                         int pos;
>
>                         if (istate)
> -                               ensure_full_index(istate);
> +                               expand_to_path(istate, fname, strlen(fname), 0);
>
>                         if (oid_stat->valid &&
>                             !match_stat_data_racy(istate, &oid_stat->stat, &st))
> --
> gitgitgadget

There's also a read_skip_worktree_file_from_index() call earlier in
the same function, which in your big RFC patch you protected with the
ensure_full_index() call already.  Perhaps it should have an
expand_to_path() conversion as well?  But, in the big picture, it
seems like checking if we can avoid reading in that pattern file
(whenever the directory doesn't exist within the working copy) would
be a better first step.
