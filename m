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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98947C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6941A61409
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 00:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhDUAxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 20:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbhDUAxT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 20:53:19 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15925C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:52:47 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v6so13031087oiv.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3B3n3qAo3GFdcNlSUr8Wjmfg1VxXCLbzLYUupqxdUE=;
        b=ZgZ0F9uyb8Y7caFCplODNaRyQTYIussRZCGwlq5sFM5PzXjnu5bUrVtS1iRtdHTeon
         4CYTiGuV4UhMELnZz8ZScMoTETxiU+Qw7molJggRiOeXZOd/YSlvy7QErv7cJKrR26OE
         vEbya5K5kFe+sXzaoptcjMtdm4ser241OKkLkQEd4JQZ94Dg8BGX8TrUXwJYaUBIh8mT
         mHMMmmbh97nw0sFw2q9u3VALY/ZJsg+at3q0PWxDFZH91wVgIMH4SCba2wGE7ZeLMbvN
         BDVt/xH2HPoU5/VZHJai6RaOkuxKCIhcpjXTRg3osqdRFSmTC7negPUOQ2h2zUtbp6Hy
         koPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3B3n3qAo3GFdcNlSUr8Wjmfg1VxXCLbzLYUupqxdUE=;
        b=U+GOSD/OM2zn9bOGpYfV8y6qRSDAUNogVSF4MRFrw/iouBK5NXuOw522BCynGbOJaC
         KODjsf+Glj7S52v2Hr3vB/mPJfigxx+9Y1Lr2gbFPEknQd6UxtSHLGZ0MolZemtU9Svz
         LOO88EHtqHREt0oo1od6oRyDcqflnaQKahM/Vz82Q7jS88e+IQaJXRnmBuArUH1wutUn
         GnVd/i4mk5px2tI2p8k60pYZnPS7+WM1owQ4JffEu05mNMD4J5Plq1gh0pOE09y2WmPm
         iojJeekpY+TPf4WaQGgFPa2tkkWH5J/QRr5/K4eeLiy8dziashm8W2Us7tHh5udL5TfK
         Zx9w==
X-Gm-Message-State: AOAM530dEWgnnNqTyC1juFy88dMLQxw1AiMHFgqHw6ot35GXtoVcorZg
        5GKtk5VqmsH8wOToPBakmYKq47a5dN+9JciwbYB+9UzD71c=
X-Google-Smtp-Source: ABdhPJwNT4ZqvAwZVpaMKm1StRhGkOni27bt714qlZdjmiIIAIgVQ0+OakysggazHYzKspAqoKiGSmyv7i+YTRJFzKk=
X-Received: by 2002:aca:1a0b:: with SMTP id a11mr4974335oia.167.1618966366482;
 Tue, 20 Apr 2021 17:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <434306541613cbd0b9bb4ebb3102d97e3df9eb94.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <434306541613cbd0b9bb4ebb3102d97e3df9eb94.1618322497.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 17:52:35 -0700
Message-ID: <CABPp-BE2qzvFwp0Gg_o+Sd5oC2itpkLNuhvEv1qWTvbCGUKWhQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] dir: use expand_to_path() for sparse directories
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
> The recently-implemented expand_to_path() method can supply position
> queries a faster response if they are specifically asking for a path
> within the sparse cone. Since this is the most-common scenario, this
> provides a significant speedup.
>
> Update t1092-sparse-checkout-compatibility.sh to fully ensure that 'git
> status' does not expand a sparse index to a full one, even when there
> exist untracked files.
>
> The performance test script p2000-sparse-operations.sh demonstrates
> that this is the final hole to fill to allow 'git status' to speed up
> when using a sparse index:
>
> Test                                  HEAD~1            HEAD
> ------------------------------------------------------------------------------
> 2000.4: git status (sparse-index-v3)  1.50(1.43+0.10)   0.04(0.04+0.03) -97.3%
> 2000.5: git status (sparse-index-v4)  1.50(1.43+0.10)   0.04(0.03+0.04) -97.3%

Um, I'm confused.  In the previous patch you claimed the following speedups:

2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%

I don't understand why the "Before" for this patch claims 1.50 as the
initial speed, if the "After" for the last patch was 0.04.  Should the
previous commit message have instead claimed:

2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  1.50(1.43+0.10) -38.3%
2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  1.50(1.43+0.10) -38.5%

?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 380a085f8ec4..b937d7096afd 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -456,8 +456,9 @@ test_expect_success 'sparse-index is not expanded' '
>         init_repos &&
>
>         rm -f trace2.txt &&
> +       echo >>sparse-index/untracked.txt &&
>         GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -               git -C sparse-index status -uno &&
> +               git -C sparse-index status &&
>         test_region ! index ensure_full_index trace2.txt
>  '
>
> --
> gitgitgadget

Oh!  So, the previous patch was testing without enumerating untracked
files (because it did those slowly), whereas this one enumerates
untracked files and is still able to achieve the same performance?
This wasn't very clear from the commit message.  Maybe I'm just bad at
reading, but perhaps the commit message could be tweaked slightly to
make this more clear?
