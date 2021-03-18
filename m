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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45723C433E0
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 05:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B3E64E77
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 05:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhCRFcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 01:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhCRFbx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 01:31:53 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22FC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 22:31:52 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t21so522031oih.6
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 22:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kjkj04x7EJCfnggb8EjOkZhLLpddiq4SWqHTINlQ9tQ=;
        b=De9h2KU4qyYBMtFcmTj7gGvtnk17LZIQDftGsuvAd/xZEUnbaM3pGIoEvYVQTbHoOu
         /Ya8KAxLDmwwJoOz2Qdl5fzS5ooCtNUUpp8vylREsFc17CpLimWkNY3njZzSo7rSHv71
         OU4qAr0i3SZWb19rvwRUOwqcVq8CiTCxDOM2803apfLP7s7JKxrRSpY7yijX2PMCKoei
         g494+bOEdS17pzwKQy8Fo6SNUjgrvafYmzAlqfMsoIusMxengvGIi0aqtxmZEkpL0hH+
         mFNSs9lvtwRvhUnjqYjnL9d66Me4FFyr6OOSxnFexeA8R5q9jTpi2juW5jmPY+3zZMK5
         bqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kjkj04x7EJCfnggb8EjOkZhLLpddiq4SWqHTINlQ9tQ=;
        b=awGEj0zctUik5oU1b2hhL+HDkMDoS+bgXWUVWnqPTH09PvZPiKFyHy4HNDJ2ycFHuU
         RGuabaoQYRk6TuJWiIHcQQYUMhb5hcdYe1F4UDpu/sOXZca3M616Piy8j6mZZYSiPG1u
         xafR4LKi36/pyEnbKaTzz4vtX6CSBx0gI9xMbC8gqN1tJSiKT7MruzbwLmJFKB12RiEq
         /SX5sUcx8l2G6yfjo9jz29sHV6Ngt0PYFjveqr22ZM30VbySZWQ7xcKuLomJalx+up4m
         yOrTIdvXC2znvDS0K8IS7knXaXQ5/DbtkXUjURkRyalTUiWRN04r2+iZ1s3D0e+Rr9Ah
         AGhA==
X-Gm-Message-State: AOAM531v+He4VBYzbpf4ijxgd/SWAxOQMzhxWUxzL5wW2IS/zl0Qn5sz
        /w2Ne+8MfHLYcFL0g60cGpuSGXbL1wdeEc8QkAE=
X-Google-Smtp-Source: ABdhPJxuh3uEKiTyodXojtln8tGeQU/gt/3Jol26bNwrfdtETUAIuhTrvUaxDg12DQ0nQ+5LSc2LeANObxqQsFCa4IE=
X-Received: by 2002:a05:6808:14cf:: with SMTP id f15mr1807542oiw.39.1616045512236;
 Wed, 17 Mar 2021 22:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com> <fb4c7038b7468c77c4d3c5181f0cb0de85d1149f.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <fb4c7038b7468c77c4d3c5181f0cb0de85d1149f.1615929436.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 22:31:41 -0700
Message-ID: <CABPp-BF93UaU7JnwxQiEp2wf1jffLfQax+z4_8Q3-6DxXPUgRg@mail.gmail.com>
Subject: Re: [PATCH 20/27] merge-ort: ensure full index
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
> Before iterating over all cache entries, ensure that a sparse index is
> expanded to a full one to avoid unexpected behavior.
>
> This is a top candidate for updating later with a proper integration
> with the sparse index, since we will likely enable the ORT strategy by
> default when the sparse index is enabled. This appears to be the only

s/appears to be/is/   :-)

> place where the ORT strategy interacts with the index in such a global
> way, so that integration should be clear once the ORT strategy and the
> sparse index topics stabilize.

Right, there is one more patch that will touch this function -- patch
7 from the series that marks merge-ort stable over here:
https://lore.kernel.org/git/pull.905.v2.git.1616016485.gitgitgadget@gmail.com/

While I have more optimizations for merge-ort, none of them will touch
this function.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  merge-ort.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 603d30c52170..9f737212555d 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3112,6 +3112,7 @@ static int record_conflicted_index_entries(struct merge_options *opt,
>         if (strmap_empty(conflicted))
>                 return 0;
>
> +       ensure_full_index(index);
>         original_cache_nr = index->cache_nr;
>
>         /* Put every entry from paths into plist, then sort */
> --
> gitgitgadget
