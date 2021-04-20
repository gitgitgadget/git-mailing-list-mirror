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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE2DC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1386141A
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhDTXV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTXV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:21:58 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A0C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:21:25 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so8842387ool.0
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Czqii3NtHXHdWSe4JlamXomWYIl2Z90FHaAAhytVYns=;
        b=AAeo0/AcS/lJNPB0GQd1cwJXsyNnbk+iuB4ta4pgNBIiR5+XVS0NofO7HNJ2zbR1um
         1L9hRdLhxUHsV0RWqozA6JQjNtn3kl56XtCJhMMuC/AxRIek3pDZ90UES3JPQ7VSal3M
         hiX4JeldvbwnXVPay5LQPU6jW9mrZXHhK7K9RxfTtQzct//w3bAf/AObjND/s8YFeng7
         wqbbV2AK7wwpvvmYfyRASgJoETubPMVhtRSNJ8nSN/aSf/EXPlngE6fLQYQLAbNtuqiM
         5O02e/W+kGj5qaX/2lgfJxjFkRnGPIRs5IOcUOwA39hB7eQ/3smxjMnv/FvVUuavB1LL
         n1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Czqii3NtHXHdWSe4JlamXomWYIl2Z90FHaAAhytVYns=;
        b=fEK6xJWfbPjXnolr8tn404WYXOe31S0gKQ3BUfnIFG64bVhKTHWUkAQ2B3AOvkd1/r
         wdwa6JujYsTpUhwts9ShuGKabk8wPdR9KCZBLhErt9mYkcMKPpqGKVHAH1N3YB9uoT/H
         B3nRLh20C+iC6sqBqUh0YKCfFWODu0mhthPg5b1FirmJl+xMaB2VzdQux683pWLg0zfP
         dO3eUHbQBfQkrSGhT8+A8dMJvxKXK5WAMk7mseh28H9UnXmaGjdenDXLmHWsM3SNgcr6
         24TbD5ohaRTkc3RH39NAIsqM+BjQZWzpm2m4sZfnocMjam4ddUXfbFTmIBKyw1ve4T5O
         C46w==
X-Gm-Message-State: AOAM531MG+gPhCD1e34Gcl/BXPqM1t0IG2ZeffuRtgR8JE1XgMX3OPfD
        dIIWAGjafkY9n12gtN6jQJJ4PRi6VrhOPY/2emE=
X-Google-Smtp-Source: ABdhPJztfJ6lXgcOQpMly/GcYSOQZ6PPE2Nv87lAJ3NsOog5yb6Y0vs0DcfwoEfrErB8kReR4brfBJuvtreFMBccM9s=
X-Received: by 2002:a4a:db95:: with SMTP id s21mr6816387oou.7.1618960884680;
 Tue, 20 Apr 2021 16:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <28ca717e6526f0b66df696f3237d72b9bee2ffc3.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <28ca717e6526f0b66df696f3237d72b9bee2ffc3.1618322497.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 16:21:13 -0700
Message-ID: <CABPp-BH8LHA_gvBF2pB2+S_5ttYoesDw_qScNrRiyYBVzPHdGw@mail.gmail.com>
Subject: Re: [PATCH 03/10] dir.c: accept a directory as part of cone-mode patterns
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When we have sparse directory entries in the index, we want to compare
> that directory against sparse-checkout patterns. Those pattern matching
> algorithms are built expecting a file path, not a directory path. This
> is especially important in the "cone mode" patterns which will match
> files that exist within the "parent directories" as well as the
> recursive directory matches.
>
> If path_matches_pattern_list() is given a directory, we can add a fake
> filename ("-") to the directory and get the same results as before,
> assuming we are in cone mode. Since sparse index requires cone mode
> patterns, this is an acceptable assumption.

Makes sense; thanks for the good description.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index 166238e79f52..57e22e605cec 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1378,6 +1378,11 @@ enum pattern_match_result path_matches_pattern_list(
>         strbuf_addch(&parent_pathname, '/');
>         strbuf_add(&parent_pathname, pathname, pathlen);
>
> +       /* Directory requests should be added as if they are a file */

"added" or "matched"?  Also, the description seems a bit brief and
likely to surprise; I'd at least want to expand "file" to "file within
their given directory" but it might be nice to get some summarized
version of the commit message or at least state that "-" is just a
random simple name within the given directory.

> +       if (parent_pathname.len > 1 &&

Is this line...

> +           parent_pathname.buf[parent_pathname.len - 1] == '/')

to prevent an out-of-bounds indexing?  If so, shouldn't it be "> 0" or
">= 1" rather than "> 1"?  And if so, doesn't the strbuf_addch() call
above ensure the condition is always met?

Or are we trying to avoid adding the "-" when we parent_pathname is
just a plain "/"?

> +               strbuf_add(&parent_pathname, "-", 1);
> +

Sorry for all the questions on such a tiny change.  It makes sense to
me, I'm just curious whether it'll confuse future code readers.


>         if (hashmap_contains_path(&pl->recursive_hashmap,
>                                   &parent_pathname)) {
>                 result = MATCHED_RECURSIVE;
> --
