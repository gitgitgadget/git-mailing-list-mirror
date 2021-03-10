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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC23BC433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE6964FD0
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhCJXFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbhCJXFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 18:05:09 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C44C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 15:05:08 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a17so18168164oto.5
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 15:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMBoGD9LQiawfXoPQXntwSkV42dC8zl3C67SWOHDJyg=;
        b=I6J7OCemGzkSV1Of92NUl2dCHiGhVw8PMBdMnIJHRKKFyKWvS0uJ4ZcUzFMmbBraU3
         GPfSj+025yr7tLxQpSWfKgfBxGcFA5u9s22BfwZKAeja1IcCgGeSZAnx7OV0IT5FxUJe
         2cQskKkpsw1lWxLUvVibgXCmdpVf5YuR66A3CDESu0DMjC7Ee/h2QtfkODY2faFHIn57
         TejTDUC9uLAZiX84wTT/1SLL2Y9SVxq54yJ0x2w8S0f/93VJ4eB+5KhfuqO6t0kGSCqD
         zptLcVVkWi8YlklTXXwv9eC0zFJqSkELY4V6sS2Uxj7NlPfL0dt6YLbIEhBcgWB5DQ2I
         ys1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMBoGD9LQiawfXoPQXntwSkV42dC8zl3C67SWOHDJyg=;
        b=jeluIxk/4Vs0i2GFcAzI8s7EZblgUDmqO6L7zcYtrJL4GwoFGphWoEUSSuqoW5BD3E
         6gf8DBnuH8RU1ueAwYqxEkkaBxJ+TALwP+eoqYk5rewQ7v12cCkvHUhQLR1676Ny4cB/
         U4Tue4iPGfLTy0mhKWKYUXaRcOBT5JuL1wZ0n8BEIPUobkFyBf25F5H5WsU4+6zh1OOn
         Xyy/RQByEl1Q3feUK+KohqpqI4IhPy12g2qNZsZkDY06HcU5PY8kRO2ENtOpvo7p8zsa
         iCihgCuuiFuZaND645AtKNLw6CkBo8g2hoPxpLEoYmqtcDryuiBXm/Tz4k1Zoa6ROnNm
         LaDA==
X-Gm-Message-State: AOAM530ltKpl7DhoEf9an8At7ez/+tvnjGAk71U5dutbdtxfqdJjClh5
        BCrZAdg7hU+W/2DxcBChOwUa6L6fjKa58qc+K+A=
X-Google-Smtp-Source: ABdhPJyUvp59KHRPlEBAV+0PfqhNpEM8V1Qkdx3v/1Ndkwl0umO+jNxVVp+sBqQ7LB3JJVArkdjNU5fDYfVNr7rkh70=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr4379901otf.345.1615417508272;
 Wed, 10 Mar 2021 15:05:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com> <eac2db5efc2297cffa9aba227e964bcc952d04ff.1615404665.git.gitgitgadget@gmail.com>
In-Reply-To: <eac2db5efc2297cffa9aba227e964bcc952d04ff.1615404665.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Mar 2021 15:04:57 -0800
Message-ID: <CABPp-BG6eSpjHVU5XShi17MOuPku=U388rL1=JXXF88M4ymFHA@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] t1092: compare sparse-checkout to sparse-index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 10, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
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
>
