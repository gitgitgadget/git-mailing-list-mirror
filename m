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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84CC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED02C60F91
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhH0Veu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhH0Vet (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:34:49 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552CC0617A8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:34:00 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso9675649otp.1
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+UfqFgwfvfTaJ7RnbFBX2veCA6r+mcLXbk/CMameFQ=;
        b=kbvCPeFbfh91gCkXqu5EHgzjTg44v+vOjQKkcbI0H2iKObP98I9VHuiEFCtgkPoBNJ
         dd4Grt1IRG203bUEtRL9uhQ+hgq8VcNax3Yj7bmUWS/kTO8F4XiNpEHZFrCOdmTwoyni
         i35huVK77E+4miI0xp/5cHlB9r8zZ5AAQj1cxhjbLHOBHErsJDmW2zW95TgL9jxCt+7y
         9k+jZ9fUKUO2DEj8uRCyeBFRaKQNXqEDc1B+BITC6XeafJxEz2+DRzDzXny7poNvCCP5
         K/3pG7smEN7LkTnE+g5U2JsWEWpTy77d97xgB9Y18MDmOnvNqLtptzJAsOQ64NqJGFkk
         scew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+UfqFgwfvfTaJ7RnbFBX2veCA6r+mcLXbk/CMameFQ=;
        b=pU+pSHnamuMIGzqnCZrEHT8Fgr6ynQtyUgA3fU2G1ba9GqXed0pBhHohsh0ztX1pEU
         HV9bgMrCNC6KDMJpkeFGsYf1xoJZUgdnzKEpnxMHvX75Wmeh509i7fR7T4AG5u21iqb/
         vcXRqV7M18HfeVCa4ssY0Ezdtsogy0LnRGga+e2FxXwtiFI0s3XmkcDnPw4XbWk6OtOi
         mJDF3l7V2fIQPg88VikHdOOdVT23T6GMI/REmPaN8lgm+gJ28c2CE1V0CcPrywEgClJe
         BR5NSLOXcEWZdhaW+qrb5CJmS62S3YXaRr3+bOHWdOHSebtJt+2d0jg9Sxm2cnjh+N0o
         47tw==
X-Gm-Message-State: AOAM531DRjSdIxDnt4NxhdSWwx6QMIHNUhfLPYC/h0LbiNZ/ibeJ5r+e
        YCXcdmHEcHBE23F3vlI31jJOFZor1SE4ms+ozE4=
X-Google-Smtp-Source: ABdhPJxHghmPY5AEQWYT9XndWgoeqFTbJx/QqlE6f7+UH+1SkmVcIYqxQo/weJwqxQKsIpSu1j/q8UfiGE6WU3DXVFw=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr9641664otk.316.1630100039668;
 Fri, 27 Aug 2021 14:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <pull.1009.v4.git.1629841904.gitgitgadget@gmail.com> <b379b8fc61af8a8c39ff8b73aae03ad4999a456c.1629841904.git.gitgitgadget@gmail.com>
In-Reply-To: <b379b8fc61af8a8c39ff8b73aae03ad4999a456c.1629841904.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 14:33:48 -0700
Message-ID: <CABPp-BFcySug2kSvxT7YdJ1Oorza5AfxKPJgMBE2wN8qOw+=Eg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] sparse-index: use WRITE_TREE_MISSING_OK
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 2:51 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When updating the cache tree in convert_to_sparse(), the
> WRITE_TREE_MISSING_OK flag indicates that trees might be computed that
> do not already exist within the object database.

Okay.

> This happens in cases
> such as 'git add' creating new trees that it wants to store in
> anticipation of a following 'git commit'.

This doesn't make any sense to me.  Does 'git add' call
convert_to_sparse()?  I don't see why it would; wouldn't the calls to
convert_to_sparse() come via sparse-checkout init/set commands?  If
I'm correct on that, and 'git add' wants to create new trees, then by
the time convert_to_sparse() is called in some subsequent git
operation, then convert_to_sparse would already have the trees it
needs.


I thought the reason you would need this is someone modified and
staged a change to a file underneath a directory that will be
sparsified away; at the time of convert_to_sparse(), a tree object may
not have yet been written for the new tree with the newly modified
file (because those tend to be written at commit time), but you'd need
it at the time you sparsified.

> If this flag is not specified,
> then it might trigger a promisor fetch or a failure due to the object
> not existing locally.

Good point.

> Use WRITE_TREE_MISSING_OK during convert_to_sparse() to avoid these
> possible reasons for the cache_tree_update() to fail.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  sparse-index.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index d9b07695953..880c5f72338 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -181,8 +181,11 @@ int convert_to_sparse(struct index_state *istate)
>         /*
>          * Silently return if there is a problem with the cache tree update,
>          * which might just be due to a conflict state in some entry.
> +        *
> +        * This might create new tree objects, so be sure to use
> +        * WRITE_TREE_MISSING_OK.
>          */
> -       if (cache_tree_update(istate, 0))
> +       if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>                 return 0;
>
>         remove_fsmonitor(istate);
> --
> gitgitgadget
