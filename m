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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225EFC433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A2264EC4
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 06:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhBYGiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 01:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhBYGiw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 01:38:52 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677C2C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:38:12 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id r19so4740596otk.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6l3EoVvYOdha6QUqVM1PpGNv+pb+0Tl0pWzaDKTv4WI=;
        b=eZEjr4JBmCkVJF4jBHrKVTFtJ0ArxETaX27bA+s+mTRNdBXE5ExJ7eq50CXnKsiZ/1
         zZaMc0maPncr43QhDX+bmL9Qu53kFEckP/6cCGIwS3KFP8+l4LDN8LCwz8pRSz+mqoju
         UD5LqJiz6Q7B8MNWS2tJdMnKwuLQIV5HMoFTFUPQkGnBi3pOh3MO07DPXJPmfSWjg97a
         0kZCV9qBM1OzKwDSJfUdFtcZZTIcBAq0iBNqihcRuVcOBcSwTQaVb1RrRZ7UhmpVKtOO
         IQpHHWqYHvgWkurrfmNmPsOqM04/9rTsv1KP/GYpOrZAVTOxxqU7fjZYVIaz+AXgWibk
         aRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6l3EoVvYOdha6QUqVM1PpGNv+pb+0Tl0pWzaDKTv4WI=;
        b=KLfxvVShDOa6LVpHBaYbpSBf1LzcdTZiNdQlJ4nLIzn+Y2aJEGRplwBmPtqLNdLP0Z
         xVrhUV6Bxde4b1vR2r04RGdFmNQ0SfzlspACsnJo9MgovE41BjLqJxoIQ8+bFieXUtYs
         6WbDeNWccAjR88qTMyWu67FPjSHGxr69YhcnBMaPNTUKRyHc/CU2qOsneT2bKZ+hZhvW
         JvI/NyocZvMM5LWx0VrmvSyRTUHddD9ivgDLRT0LiP77rvuizYGSU8HELXqdL4mB/g28
         FehA0PxRAPkMbfOSctdPJzYDVQNH3uBfjMVByl0DgLuhJrAqMJVNCbe0zkXdLaJa9mci
         SDYQ==
X-Gm-Message-State: AOAM530Jycg/uitRdKA56CX2jXVfnXfPVZDNsRv7gZDlRoI350g/J+8B
        D/towET0nhVxWvxgz/eaw/SZ+U+TL5JabOY/J4Q=
X-Google-Smtp-Source: ABdhPJzOlgAPyCctGeSdlpuXVxkAtp10vfHAan1woaqywi3uVdBAlrXdhAvX569icSP6ZXLZKTFoKXVae6JZ0buoCK8=
X-Received: by 2002:a9d:7459:: with SMTP id p25mr1112956otk.316.1614235090689;
 Wed, 24 Feb 2021 22:38:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <c9910a37579c9a26f7721b60d82060e1766d050c.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <c9910a37579c9a26f7721b60d82060e1766d050c.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 22:37:59 -0800
Message-ID: <CABPp-BFt3nJ0bdY7CVyEYEnv_qDf=6znWQN1g3EHa_pVCwZ5_A@mail.gmail.com>
Subject: Re: [PATCH 06/20] t1092: compare sparse-checkout to sparse-index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a new 'sparse-index' repo alongside the 'full-checkout' and
> 'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
> add run_on_sparse and test_sparse_match helpers. These helpers will be
> used when the sparse index is implemented.
>
> Add GIT_TEST_SPARSE_INDEX environment variable to enable the
> sparse-index by default. This will be intended to use across the entire
> test suite, except that it will only affect cases where the
> sparse-checkout feature is enabled.

This last sentence was a bit awkward to read.  "will be intended to
use" -> "is intended to be used"?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/README                                 |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 24 ++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/t/README b/t/README
> index 593d4a4e270c..b98bc563aab5 100644
> --- a/t/README
> +++ b/t/README
> @@ -439,6 +439,9 @@ and "sha256".
>  GIT_TEST_WRITE_REV_INDEX=<boolean>, when true enables the
>  'pack.writeReverseIndex' setting.
>
> +GIT_TEST_SPARSE_INDEX=<boolean>, when true enables index writes to use the
> +sparse-index format by default.
> +
>  Naming Tests
>  ------------
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 3725d3997e70..71d6f9e4c014 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
>  test_expect_success 'setup' '
>         git init initial-repo &&
>         (
> +               GIT_TEST_SPARSE_INDEX=0 &&
>                 cd initial-repo &&
>                 echo a >a &&
>                 echo "after deep" >e &&
> @@ -87,23 +88,32 @@ init_repos () {
>
>         cp -r initial-repo sparse-checkout &&
>         git -C sparse-checkout reset --hard &&
> -       git -C sparse-checkout sparse-checkout init --cone &&
> +
> +       cp -r initial-repo sparse-index &&
> +       git -C sparse-index reset --hard &&
>
>         # initialize sparse-checkout definitions
> -       git -C sparse-checkout sparse-checkout set deep
> +       git -C sparse-checkout sparse-checkout init --cone &&
> +       git -C sparse-checkout sparse-checkout set deep &&
> +       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout init --cone &&
> +       GIT_TEST_SPARSE_INDEX=1 git -C sparse-index sparse-checkout set deep
>  }
>
>  run_on_sparse () {
>         (
>                 cd sparse-checkout &&
> -               "$@" >../sparse-checkout-out 2>../sparse-checkout-err
> +               GIT_TEST_SPARSE_INDEX=0 "$@" >../sparse-checkout-out 2>../sparse-checkout-err
> +       ) &&
> +       (
> +               cd sparse-index &&
> +               GIT_TEST_SPARSE_INDEX=1 "$@" >../sparse-index-out 2>../sparse-index-err
>         )
>  }
>
>  run_on_all () {
>         (
>                 cd full-checkout &&
> -               "$@" >../full-checkout-out 2>../full-checkout-err
> +               GIT_TEST_SPARSE_INDEX=0 "$@" >../full-checkout-out 2>../full-checkout-err
>         ) &&
>         run_on_sparse "$@"
>  }
> @@ -114,6 +124,12 @@ test_all_match () {
>         test_cmp full-checkout-err sparse-checkout-err
>  }
>
> +test_sparse_match () {
> +       run_on_sparse $* &&

Should this be
   run_on_sparse "$@"
in order to allow arguments with spaces?

> +       test_cmp sparse-checkout-out sparse-index-out &&
> +       test_cmp sparse-checkout-err sparse-index-err
> +}
> +
>  test_expect_success 'status with options' '
>         init_repos &&
>         test_all_match git status --porcelain=v2 &&
> --
> gitgitgadget

Other than those minor comments, looks good to me.
