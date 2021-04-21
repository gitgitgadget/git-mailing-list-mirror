Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A4C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04604613F5
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhDUA6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhDUA6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:58:37 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617AC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:58:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i26-20020a9d625a0000b02902a2119f7613so733218otk.10
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+Ynm9BFGp1mEgdFrYJKFgsgSOS/FXaiLCsJ2C+ZoJo=;
        b=VRfJFIuVfT27yvu9mPYDjl32iK57OOhBTr90eaxzCwx4mIHe8FztYfTZTno4iSKZES
         o1dngFPU+pk4gmPNZaU+Pn/qLOqriiQObPX3S1/RkKroM/6YLFzOYd1n+fwDJ6eRQVSA
         ryM+2C8uNWxF2tgIwxhZdX1NdK3Lpu6zuyQmPCRzLi0xS3bMQ5lu2nJwik+n5NuEOr0e
         5+olcfIuR2EbiJtPop+hsuxZ5qDdjwz0BN/PVbEp+zkwArW6orA49XLR1zIwiBhzp2zM
         vsX//p7TzmVzXMNxPkceMgrM4eET2Jf8Oy4OaUBK6klFIbJQdSncuAGDlTl1R8LkI939
         0Tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+Ynm9BFGp1mEgdFrYJKFgsgSOS/FXaiLCsJ2C+ZoJo=;
        b=sjz4fEalD0qCIbYQZiso6j5itj70MLO0zHj09uRLbatxVwR0PCuMTKq2RQAnViLjkb
         9G2PIpP/eBk2TDPJFeFXtPDIfhKG8TT/iUc9aUKOYfM3vNVuDyPgnsSqv4CNjFy8qLSh
         Oq9d/KIpGKE8dBYtYXYBmrV3NeKisbHU6udvaaXz/bAm1A7arcLoI/2N6TbQSa47z3Vf
         Lrw2ruG2pIDceg2CWMnENVunDMnNADtjurTV+Kw2SnQKAAE6319RHeU6LCSL0xDBRyb5
         zqWWzd0E/Ykl16PjgrMwBK2X3xeplFocWMDqf9cplH/YIECXVeVEiJJvk/pISzfdkncK
         B7KQ==
X-Gm-Message-State: AOAM530hr41V9GyBr3NPf6H9OT231fV9vpJTZCTy9pbRHTBs9BXl/Jn1
        hg+6iPPIupEYMu/YC10gWRZ/6NYCgFXn+DFA5/g=
X-Google-Smtp-Source: ABdhPJxBgQHuFYskhhclVJiYnItFbUlceVxHrIha8T2LWxWkZhFI0PsN6+gqx/SkL0RCfXm8spJKMht2UhL9tWgnvW8=
X-Received: by 2002:a9d:8a6:: with SMTP id 35mr21032532otf.316.1618966684785;
 Tue, 20 Apr 2021 17:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <6d7f30f2b90ac2151645a29c6a12639074c8f2d3.1618322498.git.gitgitgadget@gmail.com>
In-Reply-To: <6d7f30f2b90ac2151645a29c6a12639074c8f2d3.1618322498.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 17:57:53 -0700
Message-ID: <CABPp-BHf-Tq7kmoWFGu5jA7j8-MiqhysG-vjVvGfUwKMe9Z2-g@mail.gmail.com>
Subject: Re: [PATCH 08/10] pathspec: stop calling ensure_full_index
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
> The add_pathspec_matches_against_index() focuses on matching a pathspec
> to file entries in the index. This already works correctly for its only
> use: checking if untracked files exist in the index.
>
> The compatibility checks in t1092 already test that 'git add <dir>'
> works for a directory outside of the sparse cone. That provides coverage
> for removing this guard.
>
> This finalizes our ability to run 'git add .' without expanding a sparse
> index to a full one. This is evidenced by an update to t1092 and by
> these performance numbers for p2000-sparse-operations.sh:
>
> Test                                    HEAD~1            HEAD
> --------------------------------------------------------------------------------
> 2000.10: git add . (full-index-v3)      1.37(1.02+0.18)   1.38(1.01+0.20) +0.7%
> 2000.11: git add . (full-index-v4)      1.26(1.00+0.15)   1.27(0.99+0.17) +0.8%
> 2000.12: git add . (sparse-index-v3)    2.39(2.29+0.14)   0.06(0.05+0.07) -97.5%
> 2000.13: git add . (sparse-index-v4)    2.42(2.32+0.14)   0.06(0.05+0.06) -97.5%
>
> While the 97% improvement is shown by the test results, it is worth
> noting that expanding the sparse index was adding overhead in previous
> commits. Comparing to the full index case, we see the performance go
> from 1.27s to 0.06s, a 95% improvement.

This is awesome.  :-)

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  pathspec.c                               | 2 --
>  t/t1092-sparse-checkout-compatibility.sh | 6 ++++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 54813c0c4e8e..b51b48471fe6 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -37,8 +37,6 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
>                         num_unmatched++;
>         if (!num_unmatched)
>                 return;
> -       /* TODO: audit for interaction with sparse-index. */
> -       ensure_full_index(istate);
>         for (i = 0; i < istate->cache_nr; i++) {
>                 const struct cache_entry *ce = istate->cache[i];
>                 if (sw_action == PS_IGNORE_SKIP_WORKTREE && ce_skip_worktree(ce))
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index c210dba78067..738013b00191 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -471,6 +471,12 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/extra.txt &&
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
>                 git -C sparse-index add extra.txt &&
> +       test_region ! index ensure_full_index trace2.txt &&
> +
> +       rm trace2.txt &&
> +       echo >>sparse-index/untracked.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index add . &&
>         test_region ! index ensure_full_index trace2.txt
>  '
>
> --
> gitgitgadget
>
