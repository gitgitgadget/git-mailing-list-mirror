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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6C5C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1287E60EB1
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhGWQxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhGWQxj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:53:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2423C061757
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:34:11 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id l126so2637202oib.2
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iLcK+lEyiew2VmGdE3HMd69ylqpuX243KjXNJrKa06Q=;
        b=j99NAhBqiE2kDwy6NcTcbOIN6q1ptlLoxTb9FKoyBnecsWTZg3mTUgMfFXDFo7R3OV
         8vcoWzAbn5595S3YPm8PGO/GlLrC9mZUkSFOsrAC3sgU1cNip78YYL35JTnGmn4MHCHX
         t2BO6hi8ex2f2ZhvzAJJ1OsbY0oXLKp75Xw8x0bllKi9p9J69Ei127Z09aMvFT/FFust
         2jD2F9x9qDA1S5UP9YqVK5dTfQxZOVYp6Qe61j1ZPI5iiIsHAGHewf41DLDdOFmJM9XT
         3o+so7c1MV+2Db8tmePIDha8tNj0XzRpMmf+jsPgFB2JB2J9yuiQrSB/c4/52nKbTaLn
         WaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iLcK+lEyiew2VmGdE3HMd69ylqpuX243KjXNJrKa06Q=;
        b=piRJ1WlRgdKRrCVECt/HfRs/DDubyARjCcNTFGB8qe2X6UMTxh23jOc3Wc9QP/ELKm
         jE5slHnpz0smFH/SJDOeJ+TcoEY4umQ3hLSrUs/MZPIrXBLFv9RSyCTzAPs9WNOCrG/X
         zchL775ovQjge+2KKOB6gd9CClMH2gZ8zhwaPr/s/sq38XIEPZ0FEPPAfEkToyYhUS63
         aD5oVUlfbarK8WYQ50ZqhphMfpIyoQpyMRJr6psIlaACWGahcnXh57ezzIxVD8+iAbsd
         3vk08wJqYbCFlstU8t/1qB1RfloQNA117ev4K79OBt8knfwGsBUQmWCbq0Ij0Q5iaycW
         G1FA==
X-Gm-Message-State: AOAM532twnSPSQtJ6BgTASa2Ntke4f5Gxp0QHKpyU+S43SSHzO9uL1b/
        GYLoJyCnPYpFIzpgriq48/W6VnV90nkST/vwC3o=
X-Google-Smtp-Source: ABdhPJyP5usTwLGzbhX+kAWgbhmuOSykxRn3FSLtIP0gunWnDhY8kRueuIM7i7XHP++LEMbcg4ipmoF9/zfiNcwCl8w=
X-Received: by 2002:aca:d644:: with SMTP id n65mr3747420oig.31.1627061651196;
 Fri, 23 Jul 2021 10:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com> <a763a7d15b8e92dec61c1fa328ecb647b6f61682.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <a763a7d15b8e92dec61c1fa328ecb647b6f61682.1626901619.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 10:34:00 -0700
Message-ID: <CABPp-BF-UVZKWmsohjCzRLpbHZii+1g=SShEYg_cwScsOHi=5g@mail.gmail.com>
Subject: Re: [PATCH 1/5] t1092: test merge conflicts outside cone
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 37 ++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 91e30d6ec22..a3c01d588d8 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -114,6 +114,16 @@ test_expect_success 'setup' '
>                 git add . &&
>                 git commit -m "file to dir" &&
>
> +               for side in left right
> +               do
> +                       git checkout -b merge-$side base &&
> +                       echo $side >>deep/deeper2/a &&
> +                       echo $side >>folder1/a &&
> +                       echo $side >>folder2/a &&
> +                       git add . &&
> +                       git commit -m "$side" || return 1

Why is this "|| return 1" here?

It looks like there are a number of other cases of this in the file
too, which I must have overlooked previously, because I don't
understand any of them.

> +               done &&
> +
>                 git checkout -b deepest base &&
>                 echo "updated deepest" >deep/deeper1/deepest/a &&
>                 git commit -a -m "update deepest" &&
> @@ -482,6 +492,33 @@ test_expect_success 'merge' '
>         test_all_match git rev-parse HEAD^{tree}
>  '
>
> +test_expect_success 'merge with conflict outside cone' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b merge-tip merge-left &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match test_must_fail git merge -m merge merge-right &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       # resolve the conflict in different ways:
> +       # 1. revert to the base
> +       test_all_match git checkout base -- deep/deeper2/a &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       # 2. add the file with conflict markers
> +       test_all_match git add folder1/a &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       # 3. rename the file to another sparse filename

But...that doesn't resolve the conflict.  Shouldn't this be titled
"accept the conflict & rename the file elsewhere"?

> +       run_on_all mv folder2/a folder2/z &&
> +       test_all_match git add folder2 &&

'mv' rather than 'git mv', then followed by 'git add'?  Any reason for
this order rather than git add followed by git mv?

Also, if you really do want to move first, did you use mv instead of
"git mv" due to the latter's shortcoming of only operating on stage 0?
(https://lore.kernel.org/git/CABPp-BGJdwpwhQUp4Wa4bKBp4hQFB9OM3N1FXH7SzY0mvLDa7Q@mail.gmail.com/)

Regardless of order, though, I still think mv or add should require a
--force to rename or add a file outside the sparsity paths given the
deferred negative surprises for users around such files.  (Or come up
with a solid way to remove those surprises.)

> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git merge --continue &&
> +       test_all_match git status --porcelain=v2 &&
> +       test_all_match git rev-parse HEAD^{tree}
> +'
> +
>  test_expect_success 'merge with outside renames' '
>         init_repos &&
