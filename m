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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEDC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751B860E78
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhHJRCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhHJRCT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 13:02:19 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B2EC0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:01:57 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o185so29715842oih.13
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y1qkpDDbfhmOoQ3Q0sippAqeD/yIW1fqu91J5OMiCD0=;
        b=kNORVgFGCmLKxRV6EZT2dfhvgsaFaY25T8rYmd7UBUrDu+4+zearMxVMjcAqEttnRm
         Dfgw+C4u6DPgPEkhv1oNJYqm24wyAKai9G+/LQ1V0ESDR3LuES5XchFHcs4mHYpXHeHn
         fT/GqwV3jj0yb9IZ3nJYONCjGNhMapKGN8z4MLa+DGAkBUh69g3tcy/LxGY39zkQOfjM
         iys4NtXRFX+wF2hufsG7h4QRvd1e48UoKePJ0vBIbAEZ+uBlAwGFqIvRhdZtL1E9bdVB
         2gxA8AeMYm+RT3BGaZdHLqndRG/h5g6gfMm9vCxHEPjWzXx2LgdAfTfNTDgkzdvHyq7c
         zCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y1qkpDDbfhmOoQ3Q0sippAqeD/yIW1fqu91J5OMiCD0=;
        b=gqbMnXRlqnD7SQb7NKoU59pgIhdNONh+sZ4qiZJHVTEPApdCW98eBs6XmMruKX3Ewz
         9PWHjh6caeLvX7LUajtDhFBjGpauG51ov/dxkNpS1sSlpKzUoO+64/fETYaTYzj576ho
         kzpnCWvLUkZEYtw/cQ4S+akzL6hO/uACWikuIEFDuXCCx2dwKRCBcCx4wMJiho4crwAe
         rjfNVM7FU8ya9Zp93CKSvQ6Po5071Pzv4HJcWxTK8RwpRFYZfQdOinASWd1hMw1DhHTp
         pxL174/PUEixS6zdW+mOELPTxg5DiRFGXvOkmzoKl2x+M4+lL1C+qJlsRTRK+hBP3tQj
         5Baw==
X-Gm-Message-State: AOAM530LuuAObQcLqAWTV73/R/Fmq9J3LNnFLBUnRVCYRImTGEW3Pl/k
        Qab6TAL0xw6bdJpP7Rgz74zaN7qGYnSt1D+G++s=
X-Google-Smtp-Source: ABdhPJz/v073YE2tJ0KzwlGsMVt6lad0QKyztAGgQm9OjKP3OEF6ibu77YZarkv1a3VVo/zZOO6V5GCjgPZBc9ygAVI=
X-Received: by 2002:a05:6808:85:: with SMTP id s5mr819291oic.31.1628614916798;
 Tue, 10 Aug 2021 10:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com> <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
In-Reply-To: <7559781ca92096f89a6dcbfeeaa4d2b4d7b98094.1628587917.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Aug 2021 10:01:45 -0700
Message-ID: <CABPp-BFFTLgtrs_m9Gp7tSRwpBnAEoArhMZhhJcuzqNS_g8sUw@mail.gmail.com>
Subject: Re: [PATCH 1/3] t3403: fix commit authorship
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victor Gambier <vgambier@excilys.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 10, 2021 at 2:32 AM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Setting GIT_AUTHOR_* when committing with --amend will only change the
> author if we also pass --reset-author
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  t/t3403-rebase-skip.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
> index e26762d0b29..6365c5af2f7 100755
> --- a/t/t3403-rebase-skip.sh
> +++ b/t/t3403-rebase-skip.sh
> @@ -36,7 +36,8 @@ test_expect_success setup '
>         test_tick &&
>         GIT_AUTHOR_NAME="Another Author" \
>                 GIT_AUTHOR_EMAIL="another.author@example.com" \
> -               git commit --amend --no-edit -m amended-goodbye &&
> +               git commit --amend --no-edit -m amended-goodbye \
> +                       --reset-author &&

Makes sense...but doesn't the fact that this test worked either way
suggest that the specifying of a special author name/email was totally
superfluous and could just be removed?  If there really was a reason
for specifying a different name/email, then is the test faulty for not
checking for it somewhere?
