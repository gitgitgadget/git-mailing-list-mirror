Return-Path: <SRS0=euRE=EN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF3C55178
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 06:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C47D20888
	for <git@archiver.kernel.org>; Sat,  7 Nov 2020 06:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=webstech-net.20150623.gappssmtp.com header.i=@webstech-net.20150623.gappssmtp.com header.b="Kz1PQCVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKGGvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Nov 2020 01:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKGGvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Nov 2020 01:51:36 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066CBC0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 22:51:35 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so2452377qtb.10
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 22:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=dyrgy54iVPYiMLe1lv2KyMtVqJpJ/pRinao/FOYbhmI=;
        b=Kz1PQCVBJ1e6HcQkPUbvY4sLH4KQJ54/2rcASu/fPjhhtINUqnqVb5zZ6XHt1TyUIq
         JJTEj0W/btYBy9OXsY8FKEMmu7Ycq3nTGCxVUb98uLbAffUYwU0it7D7Zt2YFSEvExyn
         r7eudsM8mRv7wjpMzR2o8ZBNVz1dcv9OShJhsyJTRx2hyvvAu12CQKuQNZXUgkUYMwNQ
         wCloTfcU3C0FUO3kclQhIQpp3WzXNQCc6WIILjHGxSMplxhzdSpUyhRvV3r4uNswcVzB
         pbxSw1oJ3F6y4YCH0RzIgvO9f+5H2cuvln7DUyjx2bQHiDGUoFluMzdVuKZBi1BioCgm
         mAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=dyrgy54iVPYiMLe1lv2KyMtVqJpJ/pRinao/FOYbhmI=;
        b=Y0ib8BCMN0sBFiXtBeCP6FmUnvxIHnSU4DntZozev3h1kJkb/iVYEc/uSZxpppbCH8
         yHz0hvjGgawWmK61qo1yt7zawoBcLTruu8KSAfQWwcEUvo0OF2CiylqKjgRORQ5Ci7K7
         v2Gy+KrRhocIgnMaL8aJKKj1kDk6bGgNBO7KnPU7wJNhMuk6nEOYI/1i7AaP84YWW1OX
         6GXp6l4XMjXNyp8HhLVt6jF+inEo9TQPU4i0JkYLd7LohpNq+cVx1dd6IbeHzvjZZsIu
         1dglm0aLZy/JCwmXXC/DbI2Xtuggp7NW8WVq2z5s77cyshzxYuZsRwAmdIc50rCDXPf8
         bJSQ==
X-Gm-Message-State: AOAM531ZWEAJa6ojnXRkZH/zcxHR9RtFyQRW8iIGphZfkTIQCf6TWYx+
        Y0gdHTq8xh3nCuCN1lBWN1JqaxoNVBYJsk/5joo1t4g5m347jQJ+c6M=
X-Google-Smtp-Source: ABdhPJzjylFTO0s//OZmhIa48672i4/XDtEZiPmDO5z1CN+GI7mjeOCjqlCck4Xn4RhoDBnDJFlh+37WQLAUnwSU/Wc=
X-Received: by 2002:ac8:2aad:: with SMTP id b42mr5247956qta.62.1604731894922;
 Fri, 06 Nov 2020 22:51:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.781.git.1604712106219.gitgitgadget@gmail.com>
In-Reply-To: <pull.781.git.1604712106219.gitgitgadget@gmail.com>
From:   Chris Webster <chris@webstech.net>
Date:   Fri, 6 Nov 2020 22:51:43 -0800
Message-ID: <CAGT1KpXgzaFUdvmZXHHTC6r2FjYY_6MCiZPHu++eje1mRJfmPQ@mail.gmail.com>
Subject: Re: [PATCH] ci: avoid using the deprecated `set-env` construct
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks good.  Doing a similar change in a related repo.

...chris.

...chris.
chris@webstech.net
webstech.com


On Fri, Nov 6, 2020 at 5:21 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `set-env` construct was deprecated as of the announcement in
> https://github.blog/changelog/2020-10-01-github-actions-deprecating-set-env-and-add-path-commands/
>
> Let's use the recommended alternative instead.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     ci: avoid using the deprecated set-env construct
>
>     This avoids an ugly warning (see e.g. this run
>     [https://github.com/gitgitgadget/git/actions/runs/350443139]).
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-781%2Fdscho%2Fno-set-env-in-github-workflows-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-781/dscho/no-set-env-in-github-workflows-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/781
>
>  .github/workflows/check-whitespace.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.github/workflows/check-whitespace.yml b/.github/workflows/check-whitespace.yml
> index 9d070b9cdf..c74b47de9e 100644
> --- a/.github/workflows/check-whitespace.yml
> +++ b/.github/workflows/check-whitespace.yml
> @@ -14,7 +14,7 @@ jobs:
>      steps:
>      - name: Set commit count
>        shell: bash
> -      run: echo "::set-env name=COMMIT_DEPTH::$((1+$COMMITS))"
> +      run: echo "COMMIT_DEPTH=$((1+$COMMITS))" >>$GITHUB_ENV
>        env:
>          COMMITS: ${{ github.event.pull_request.commits }}
>
>
> base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
> --
> gitgitgadget
