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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1DBC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB3C613B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbhERBu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhERBuz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 21:50:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3CC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:49:38 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so7293295otc.6
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zXCAxcyiDJXRE0OwqIMVMz4uv9wjQG7e/jyEInbgYQ=;
        b=mOIu+kteJI9agMUwtxrox1Awh6atL7sLodLBJAxanEwrThjU29fVhBzAWg6Zg+8dS5
         QfcTPv9mf34BVljxV5Z9ihWzREBMc6hRzK9dlJWH8rkGtQ1+d73Q5LJo3O/vq3dIiC0X
         ujHjCYJJfuskvwBMEBDSJJI47TNj1iqMBDbW119omaUADelYoLKNqNhh5/ac0MKbH5Rm
         KrLNdXA+MkM4LMhgD7j8TJ0gDWShJIkUajxj7GaYdVqmEDC7/tQAuyfvbgnEobtz6JHO
         G9SkdTMbIVN+W8n9AXHeLTIkVFtpS7VUlcA9i7eA/OlFATEY0Fyw43RyVCxYIxNXAr5k
         sApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zXCAxcyiDJXRE0OwqIMVMz4uv9wjQG7e/jyEInbgYQ=;
        b=co7C3VgEMpSzKHuB/TdoAmUtbCkoIrwfDRJpjKPbPVLGa+BpXri47Bfsq63xn4yW+P
         BSn7KBBXEEBf6EppfT5IzIX7rruirJiCvNHMMHTyJKg+lyrWkpoAX3BVCDmAMHKSVspC
         iunonQ9wnCseMI3JO+rpmKZ+xHLqJMiT5eI/bTHYdWKbYkmcIh2xYpT16PQh03QhJCrS
         fcpAGQoiGZElHMJFuDQ/a1io4n9AADhIfzKMlVZB164lNOhU/cXPLo4fWXxPSvlPmdT/
         et7ggT3RHa7y0wgP7CLjHc5NYGCXX6rPzoMwudyN3KJbdJyGNgx7G8qObw6Tf6avrQRJ
         a7ow==
X-Gm-Message-State: AOAM530/GeaK9f2YkQKue/AbOsA20PSc4HcK0qtGTnWMCGtH4CLbSo0D
        ZMo33mHffVWJ+jilEyNoxfVc3Htke+nTkLYLx3w=
X-Google-Smtp-Source: ABdhPJxcjrqlhZPZsZlqqMZdC/Y1XKcpFVgJP5UHSg02/3G/xR3Js3PNBPANdEt6emJ8bzICOVFKmQl51g+fVFt9NDQ=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr2110836otq.316.1621302578254;
 Mon, 17 May 2021 18:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <70971b1f9261f2623ad6d6393be1a8e191003eb4.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <70971b1f9261f2623ad6d6393be1a8e191003eb4.1621017072.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 18:49:27 -0700
Message-ID: <CABPp-BG=5huMt2FOrzscNrg9rCpo40we7ms8K=508+Kur0yGnQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] t1092: expand repository data shape
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

On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As more features integrate with the sparse-index feature, more and more
> special cases arise that require different data shapes within the tree
> structure of the repository in order to demonstrate those cases.
>
> Add several interesting special cases all at once instead of sprinkling
> them across several commits. The interesting cases being added here are:
>
> * Add sparse-directory entries on both sides of directories within the
>   sparse-checkout definition.
>
> * Add directories outside the sparse-checkout definition who have only
>   one entry and are the first entry of a directory with multiple
>   entries.
>
> Later tests will take advantage of these shapes, but they also deepen
> the tests that already exist.

Makes sense.  Do we also want to add ones of the form

   foo/bar
   foo.txt

?

Here we'd be particularly looking that if foo is a sparse directory,
we want to avoid messing up its order.  ('foo' sorts before 'foo.txt',
but 'foo/' sorts after, and thus 'foo' the directory should be after
'foo.txt')


> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4f2f09b53a32..98257695979a 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -17,7 +17,7 @@ test_expect_success 'setup' '
>                 echo "after folder1" >g &&
>                 echo "after x" >z &&
>                 mkdir folder1 folder2 deep x &&
> -               mkdir deep/deeper1 deep/deeper2 &&
> +               mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
>                 mkdir deep/deeper1/deepest &&
>                 echo "after deeper1" >deep/e &&
>                 echo "after deepest" >deep/deeper1/e &&
> @@ -25,10 +25,16 @@ test_expect_success 'setup' '
>                 cp a folder2 &&
>                 cp a x &&
>                 cp a deep &&
> +               cp a deep/before &&
>                 cp a deep/deeper1 &&
>                 cp a deep/deeper2 &&
> +               cp a deep/later &&
>                 cp a deep/deeper1/deepest &&
>                 cp -r deep/deeper1/deepest deep/deeper2 &&
> +               mkdir deep/deeper1/0 &&
> +               mkdir deep/deeper1/0/0 &&
> +               touch deep/deeper1/0/1 &&
> +               touch deep/deeper1/0/0/0 &&
>                 git add . &&
>                 git commit -m "initial commit" &&
>                 git checkout -b base &&
> --
> gitgitgadget

Looks good.
