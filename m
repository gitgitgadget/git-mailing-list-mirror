Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57E9C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhLIFXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLIFXx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:23:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0929C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:20:20 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so15372154eda.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6Rh8ZGAs5XLYefNMc0eLf6RnnmRGhwhtDxkzi9hz8g=;
        b=JhdWpNjTCdarHheeW3/iqqPkXM8MSRy52VgavaO65z4a8QRdfBfzeVtiGiHi1nzlQr
         pGb6sE5F2atrx82Lnk0UCwjo9iVI/DD5o+niVn6YPmTD5ph8ZBV643g4Uc/cqneJ8WYO
         8CDSDN1CqnTA3v/HW1O72W+GqqCyzTv8O2VxQ7eiUYcmkuh8ME5/Cd1fNzUm1QAZRR8S
         uQ06kQwDIEAxnSVs7t9TFXdGxThZbG/J/tZNxgGl9d2cxgHiFa/X8cYh9eFKhb4jo6pY
         yurWBEJo6t74rDqq9ydWJOVwv7PAeqJYnLV0F+RmY+ANppkiI18HjiawcuLJr1T+inJW
         goXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6Rh8ZGAs5XLYefNMc0eLf6RnnmRGhwhtDxkzi9hz8g=;
        b=yBQXKcZu9fo7oWZFBjUL3wWalK0DsPcBPwX+q8ZfqbCGgem6/aIVcWRmHf194tmX4U
         9T660hXZa/Vyb5Y4XfcvFIY6wi4ga3WOrg+mAIu+9tLry7gnv5R65LbZjn1aoBs+WLx6
         /xASKWGzEqwvk2GzfQo/zDp4eit42phV0vioboFp6gNcbeMEqxt6CE3fZ3wXtTd7B7kT
         oN1ptcmRpzjssgYmOH8nIjOIF7VxWvG5OPpCXyfH5Mn0t329baqaNsri3HilEfrmdzmu
         9v2BEqxGP58h4tsiYAmvxIwk3N7a4fec3v2KFxacVR1OtyZTMPf0m+0E+7zn3J0r6Z+0
         fDsA==
X-Gm-Message-State: AOAM53310iX3PXX5AeSUWRH668k5lIJjnoM88rt82tPt41lqsfOGkX9F
        Eop9eSICoO+Bv79XcZGanhB+3AjR4L0eORWdfuk=
X-Google-Smtp-Source: ABdhPJx+oTy9zWI8dPU2vyz0aA2d2XrFmzWINxnpys3jrCdPEne/YAFfvgNQQ5is1TivXJTG1Thx/+0Bj40sWD96XKY=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr13132442ejc.520.1639027219416;
 Wed, 08 Dec 2021 21:20:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com> <b98e5e6d2bc921ea76d8b5419d1f00e9db30a55a.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <b98e5e6d2bc921ea76d8b5419d1f00e9db30a55a.1638992396.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 21:20:08 -0800
Message-ID: <CABPp-BHkdyMD1RVptCgROnd=1pw_xvhOj4b1pvYFRmukqyvbNQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] t1091/t3705: remove 'test-tool read-cache --table'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 11:40 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Now that 'git ls-files --sparse' exists, we can use it to verify the
> state of a sparse index instead of 'test-tool read-cache table'. Replace
> these usages within t1091-sparse-checkout-builtin.sh and
> t3705-add-sparse-checkout.sh.
>
> The important changes are due to the different output format. In t3705,
> wWe need to use the '--stage' output to get a file mode and OID, but

s/wWe/we/


> it also includes a stage value and drops the object type. This leads
> to some differences in how we handle looking for specific entries.
>
> In t1091, the test focuses on enabling the sparse index, so we do not
> need the --stage flag to demonstrate how the index changes, and instead
> can use a diff.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1091-sparse-checkout-builtin.sh | 25 ++++++++++++++++++++-----
>  t/t3705-add-sparse-checkout.sh     |  8 ++++----
>  2 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> index 272ba1b566b..680e0043c36 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -212,12 +212,27 @@ test_expect_success 'sparse-index enabled and disabled' '
>
>                 git -C repo sparse-checkout init --cone --sparse-index &&
>                 test_cmp_config -C repo true index.sparse &&
> -               test-tool -C repo read-cache --table >cache &&
> -               grep " tree " cache &&
> -
> +               git -C repo ls-files --sparse >sparse &&
>                 git -C repo sparse-checkout disable &&
> -               test-tool -C repo read-cache --table >cache &&
> -               ! grep " tree " cache &&
> +               git -C repo ls-files --sparse >full &&
> +
> +               cat >expect <<-\EOF &&
> +               @@ -1,4 +1,7 @@
> +                a
> +               -deep/
> +               -folder1/
> +               -folder2/
> +               +deep/a
> +               +deep/deeper1/a
> +               +deep/deeper1/deepest/a
> +               +deep/deeper2/a
> +               +folder1/a
> +               +folder2/a
> +               EOF
> +
> +               diff -u sparse full | tail -n +3 >actual &&
> +               test_cmp expect actual &&
> +
>                 git -C repo config --list >config &&
>                 ! grep index.sparse config
>         )
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> index f3143c92908..81f3384eeed 100755
> --- a/t/t3705-add-sparse-checkout.sh
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -181,13 +181,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
>         # Avoid munging CRLFs to avoid an error message
>         git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
>         test_must_be_empty stderr &&
> -       test-tool read-cache --table >actual &&
> -       grep "^100644 blob.*sparse_entry\$" actual &&
> +       git ls-files --stage >actual &&
> +       grep "^100644 .*sparse_entry\$" actual &&
>
>         git add --sparse --chmod=+x sparse_entry 2>stderr &&
>         test_must_be_empty stderr &&
> -       test-tool read-cache --table >actual &&
> -       grep "^100755 blob.*sparse_entry\$" actual &&
> +       git ls-files --stage >actual &&
> +       grep "^100755 .*sparse_entry\$" actual &&
>
>         git reset &&
>
> --
> gitgitgadget
