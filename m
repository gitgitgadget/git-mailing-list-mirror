Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C68C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBCD61008
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 19:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhFHTWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:22:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:46890 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239189AbhFHTVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 15:21:14 -0400
Received: by mail-ot1-f53.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso21377363otl.13
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XztXjagZFDSvkLwss3rq/JWH4N9cO3m3qefI/ZxRYbs=;
        b=AW3ktFoObAzReutTuKPhPUwNCw7flYjpkX+w3fVaH1MeGjUq8LwBBemXwNk3yd60J/
         blflVZ0HphDThv0f5sNXcRiM2Qt6bnEB9nXpBwUzF/xXFhDzdXvifUA4tT/bdG5xA9SP
         fciSDiqA8beUDARzAkZpvhFBw5UYSIuS/fQSdehD/2QRS/FInWFgqGcZVFx69j5BZjOc
         NJYrbkcflhGMddgXZwyfm0f5OybpIZ7Z8xt/YqJPoGr50jBmbC5YXvCmEcqnTfZaxVLa
         n/DBL0I4Lt+ptqqX7uMfY7aGGsGiI6Me8YHCX3pcqsaPkrhYyz3Pba3JWbreVW/Buxy6
         WJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XztXjagZFDSvkLwss3rq/JWH4N9cO3m3qefI/ZxRYbs=;
        b=r66tZPKqJER7jmHky8eNq1gEDy2wdFyNjE3/EebDS7CiTfy6mVLrRJrieiXAex9I+P
         RfJJW/6C59jFYnDf+HoNHJ3KA9uyP/CoeBZ94D+zIyWzZQ1rFUtIoRLXQNlNcyf9laEe
         Yq7+W2fskbZRkJDCbf1McVAsWqypYLsfcijTSaaNQgqL/tdNapSUaY6StFVevPcykUZ/
         b5ahubJIkkIJhkf/Ez8RYlPO4PXXzPGrikd+kLT4jiQmOQ7NOkjYMGad/algXsL5dojs
         olVAEWu+cInN3QJfpsetZ2+d5yviJTfwR2MxvYIZPtG+AgmS0rkvOx9QR0t/ktNejPYi
         S+8A==
X-Gm-Message-State: AOAM533KkGMyVz+Cmg7rFNxJ8y2ZDrNkVcZEhi0Qds9iD/zCxFnN+fim
        4aZ30a2ygjSJUX55rbtnH0ZHUBmvbd+lyn1UGwo=
X-Google-Smtp-Source: ABdhPJyg9zxBf8LuaU7v1lOGXD/lYat87dD6vZSDv1/cArAqFUJYWg31ksOEp7Gt6a0y4Sx2fW1mbY7Xo0mJ9ts3sMc=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr19041540ote.316.1623179895071;
 Tue, 08 Jun 2021 12:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <b99371c7dd61bad552231ac964605cf738f90c7f.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <b99371c7dd61bad552231ac964605cf738f90c7f.1623069252.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 12:18:04 -0700
Message-ID: <CABPp-BGnSeACeXra8pRWEELMS5E0g4bWgBca-21duGp6+nockA@mail.gmail.com>
Subject: Re: [PATCH v5 03/14] t1092: replace incorrect 'echo' with 'cat'
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

On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> This fixes the test data shape to be as expected, allowing rename
> detection to work properly now that the 'larger-conent' file actually

s/conent/content/

> has meaningful lines.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 4f2f09b53a32..d55478a1902b 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -40,7 +40,7 @@ test_expect_success 'setup' '
>                 done &&
>
>                 git checkout -b rename-base base &&
> -               echo >folder1/larger-content <<-\EOF &&
> +               cat >folder1/larger-content <<-\EOF &&
>                 matching
>                 lines
>                 help
> --
> gitgitgadget
