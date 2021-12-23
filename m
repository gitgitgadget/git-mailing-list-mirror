Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3511C433EF
	for <git@archiver.kernel.org>; Thu, 23 Dec 2021 00:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbhLWAsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 19:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbhLWAsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 19:48:13 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDA7C061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 16:48:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bq20so8887114lfb.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxt5sX++e5JmWRZzNJr8ZHaZjibW9gZ/gq4mz77rgeE=;
        b=REaYAnuqxRowGcDUog9ZPjygP6OYBp2e/CrFPGA87jRCyZkmgfQIUoJSnG2sm+hDp9
         htKcIsRBObRgZg/47uWoZpwvne1UF70YfCvq+DDUricyd3LlI/2iY9NiZDPy8PJ2C8Ge
         yxEFbsw7Lx9GOjHm9ifJFCJe3VmvMbLvbJEj69ngr2OIwbfPiqwoMD5ovVsqCJy/K870
         8cxobksDZRPDIf6ctNDxYzr+gfBngLT5Zmz4yJcya3YWMROFLJH2fX/uQM0SBzk+ypiM
         L0Qv1eVAxe4mnGo2s30/VaMhEIYTPIHaMexIyAHRhU5XJr0EGBymxP8wjZcOoEB9ttFy
         2yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxt5sX++e5JmWRZzNJr8ZHaZjibW9gZ/gq4mz77rgeE=;
        b=xvrL4qtdQZJTZ9fbMD++/BcgHgBBDiljbnBUCQlx+thjC79bzwI5cz9JJYnd0KBLrL
         2L/ed9BYnbK2Vi61b+F4tcCGHCVzHmwQfB+mavgjbuENNN7AOaWnTKMjfBBrLGkBfMF8
         4LzLwwjYtY37w3OE9lvjH+fRcvg9uwAfhmCKiNIaJKzdejoS3vYTGN2b3KcuovztU+h4
         JPVXAT6L8riXJyyD44mHpisGj239qEbqkq0tcV4ZPKaGi7mY6Mgd2f8t8LrFjoEutmZi
         X6MFmCzEnVL+CK65LRVIYndNzBsX9jJfFysFQCZZLhyAYCFkHcCchs/t1owojhsVLxsR
         o91g==
X-Gm-Message-State: AOAM532+N8ZFkVMAI1jkV24yltCBGExtmTuFrq90Piv1tI3XOjc11opX
        2Y72IaOFRtSkrnB0iw3jvN6EHr6iR48mT2vwiMNWHlrsIh4=
X-Google-Smtp-Source: ABdhPJwCR8BUQ/vkDxzmX6u4W00NnNNSQ1lM3P2XYkoUBOKCrOGcJEff3BNtRpsNbUbHdNXcXrlmwvKCq0vPH0EXVtU=
X-Received: by 2002:a05:6512:a8d:: with SMTP id m13mr163512lfu.664.1640220491142;
 Wed, 22 Dec 2021 16:48:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
 <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com> <09b13280c2619e9dcbf33422c5dcfba84f0e52be.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <09b13280c2619e9dcbf33422c5dcfba84f0e52be.1639454952.git.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 23 Dec 2021 08:47:59 +0800
Message-ID: <CANYiYbE+1o-8KxY2UGaCMdZJEPtnbTWgBrcFf7E-_ra76=kWmQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/10] sparse-checkout: enable reapply to take --[no-]{cone,sparse-index}
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 3:24 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Folks may want to switch to or from cone mode, or to or from a
> sparse-index without changing their sparsity paths.  Allow them to do so
> using the reapply command.
>
> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> Reviewed-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 16daae84975..0dae44c5759 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -759,13 +759,22 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
>  }
>
>  static char const * const builtin_sparse_checkout_reapply_usage[] = {
> -       N_("git sparse-checkout reapply"),
> +       N_("git sparse-checkout reapply [--[no-]cone] [--[no-]sparse-index] "),

Found a trailing space in [1], which came from this commit.

[1]: https://github.com/git-l10n/git-po/blob/pot/next/2021-12-22.diff#L19

--
Jiang Xin
