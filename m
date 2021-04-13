Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1406C433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 04:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B618D613A9
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 04:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhDME4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 00:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhDME4C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 00:56:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EEEC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 21:55:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ba6so17784348edb.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 21:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAUoe6oHVPHaK5sybxfz3NNBtZyOyH0778ZqDouI/LM=;
        b=CNSAiHuck8wLLuNLSQwwd9THrIxuwxmGuPylpXEcbsG+fyuIsZncMjyBpoj6zPLFzM
         Qn+ge4pZuq3dLZxDBforiAWHTil73fJix6Sv9BgAzXf3kritDvLuCdhZ18PEPd7+pqj3
         NlVWovu8GEAzxdY10ZC1EVyMjpmm02bC2BY5di6/teSWqqcVoq13nulrpnHVhkroHTa1
         exMlFsMJJ+dVIExWlXdxVfA/KB/y39UI0rB+M9F+fBnjKxfdvmTCiFvGy0BJNz5fP/uI
         hUzHPfpZnvDt4vWu2tAkNuq45g1sfDQoN08axYESeUqtBiSvmWVN/NiXQ7tyqE9oxLAk
         vYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAUoe6oHVPHaK5sybxfz3NNBtZyOyH0778ZqDouI/LM=;
        b=NeqP1aIoZe94mdoV6h82Po1okI2MqJqHFRrLOp09LXxF2QGgN3pRyNfZla/aL3QPge
         u9U+GWM7LnOsXsamtwzeeJpxvqu0JoIijaS9Tua3XQAeR1cyxjvA7/93nDq4vSEtcL9x
         t16T+GT1DTS87tNwGXpEyNtyyF3+ig3rORhZ+y1MHVKLvWGaxVeQrEUIBbHTRtMF7Lrz
         ir55SfPuO7tkKo1UkAv4Xa9gS42gBqk0BgTqXexhJFae1LUe2VQJI9Ymb+zv0L+sHreY
         xpULMVQ1mDpECj1E6f/wjdCOj8sAPWhj2hyhcxgEioy0gHe1NpMKSldgGYaasPhkDy03
         ZJpA==
X-Gm-Message-State: AOAM531ygLb9CQDySrIV0F0KCOV0iKDEEmr34zUp+L5+ybnVS+dRFqKC
        aJRV+sVMDVB+hTA6jviBEZJ9Fxgj3yRjrM3rnsQ=
X-Google-Smtp-Source: ABdhPJyuK5z63JxSFRjlLUeVxQc9Ua4aNswVFiVziPR4HmxfNtzekMnN7Qzef4GuT1LMO9oXWtQsc9jDO1aES4kqaLw=
X-Received: by 2002:a05:6402:48c:: with SMTP id k12mr32710854edv.237.1618289742173;
 Mon, 12 Apr 2021 21:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.624.git.1588616864222.gitgitgadget@gmail.com>
In-Reply-To: <pull.624.git.1588616864222.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 13 Apr 2021 06:55:31 +0200
Message-ID: <CAP8UFD13-osOHU7Ug_2iToQZyx2T2neOXzZB=ssmDZLEQoF4eg@mail.gmail.com>
Subject: Re: [PATCH] sparse-checkout: stop blocking empty workdirs
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 8:30 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> @@ -302,8 +300,8 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
>                 echo >file &&
>                 git add file &&
>                 git commit -m "test" &&
> -               test_must_fail git sparse-checkout set nothing 2>err &&
> -               test_i18ngrep "Sparse checkout leaves no entry on working directory" err &&
> +               git sparse-checkout set nothing 2>err &&
> +               test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&

It looks like this check is obsolete as the "Sparse checkout leaves no
entry on working directory" error has been removed by this patch
below...

>                 test_i18ngrep ! ".git/index.lock" err &&
>                 git sparse-checkout set file
>         )

[...]

> @@ -1706,19 +1704,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>
>                         if (apply_sparse_checkout(&o->result, ce, o))
>                                 ret = 1;
> -
> -                       if (!ce_skip_worktree(ce))
> -                               empty_worktree = 0;
> -               }
> -               /*
> -                * Sparse checkout is meant to narrow down checkout area
> -                * but it does not make sense to narrow down to empty working
> -                * tree. This is usually a mistake in sparse checkout rules.
> -                * Do not allow users to do that.
> -                */
> -               if (o->result.cache_nr && empty_worktree) {
> -                       ret = unpack_failed(o, "Sparse checkout leaves no entry on working directory");

...here...

> -                       goto done;
>                 }
>                 if (ret == 1) {
>                         /*

[...]

> @@ -1824,28 +1808,12 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
>
>                 if (apply_sparse_checkout(o->src_index, ce, o))
>                         ret = UPDATE_SPARSITY_WARNINGS;
> -
> -               if (!ce_skip_worktree(ce))
> -                       empty_worktree = 0;
> -       }
> -
> -       /*
> -        * Sparse checkout is meant to narrow down checkout area
> -        * but it does not make sense to narrow down to empty working
> -        * tree. This is usually a mistake in sparse checkout rules.
> -        * Do not allow users to do that.
> -        */
> -       if (o->src_index->cache_nr && empty_worktree) {
> -               unpack_failed(o, "Sparse checkout leaves no entry on working directory");

...and here.

> -               ret = UPDATE_SPARSITY_INDEX_UPDATE_FAILURES;
> -               goto done;
>         }

So maybe instead of the 3 lines below:

> +               git sparse-checkout set nothing 2>err &&
> +               test_i18ngrep ! "Sparse checkout leaves no entry on working directory" err &&
>                 test_i18ngrep ! ".git/index.lock" err &&

we should just have:

               git sparse-checkout set nothing &&

?
