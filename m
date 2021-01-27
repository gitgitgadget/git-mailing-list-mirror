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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB2C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5165205CA
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 06:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhA0G2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 01:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhA0DJo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 22:09:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B442AC061756
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:09:03 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id k8so357005otr.8
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 19:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nT9F1i5K+pXBv1s1LuWdJFhuv6kKxxnVNKReh/V/gOg=;
        b=pnrL92WZDDhGjwQwgqBStKeCk7pmiz2UygMq1cfH83AtoSbc1kLzUFyyZlK+7+QKt/
         M3sVWreAHEFrdDPXLXvg2WNEFuQKm+iAch5XtSQRsntl7rI4IcGfARynOTkn7CqWPv3T
         xEXySVENOTKPP3wkRAJsQ9KyXUwntMc6vONkUSE5p1nzil+QM3VMYqQN57b0rzRetcT5
         QYkm+8wEORexG9FVTBHMz+2C0aE7yuI4F5D4IM8umQWRIHRskOde4QSt2M8mCbb9+VOy
         mEJtaMZPhSbyXJxIUNjAQz8Nbpo1YMsN7v48OK80QaZ0yPKlEAEpQQy0pKlS5UWKJpnF
         fogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nT9F1i5K+pXBv1s1LuWdJFhuv6kKxxnVNKReh/V/gOg=;
        b=Rs3BQiUttcgDcGTQOE4VVvyAapAMY0JZqMlshN0GRfNs4PMBUACm9V03f+Fa6d/bzC
         JbeJG9P8V/002MmquvTU4gM9fCpQAZQMXAnHNs4n3pTA1l9jtDmZo39llNvBIeJIzLGB
         V31EhaaT+olaWL5AJs5sjosddbMmORJJefWqWfgEkaoECqH3yKuKrj7h70D0Qit8BAxk
         9gpd6aAvCS3YUT5MbrNWMuLbkqa8M3KWC+UeBmq5w1Jf1wgUpFcaGHsmftjPqGh+D0sx
         +YbNeyU4oYUbdHY74wxMBdSTEZft8YXnDko8CdY2c+5oRH1BZ6O7lORbTXD5EGxsGKUI
         hH2g==
X-Gm-Message-State: AOAM531DCz3eXqmE+0vDaN0jKfM/YxCZEDbmI6o+rYaPGUmnWgl7u7L8
        OuQ51M+a17pcuKM1s6/Fl//wa8V6eVZ4yBoR3zw=
X-Google-Smtp-Source: ABdhPJx1Vou6uO+EsHBHnhCde2pXw8Kz/UbE1LTNXZvwCFHd21RZAkk2y0TuSSB1UPCWpnnC2seERNqdhWhXfPzLud8=
X-Received: by 2002:a9d:506:: with SMTP id 6mr6008723otw.162.1611716943084;
 Tue, 26 Jan 2021 19:09:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <b3696c823a24547be391c4ee35b99ba76cce42af.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <b3696c823a24547be391c4ee35b99ba76cce42af.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jan 2021 19:08:52 -0800
Message-ID: <CABPp-BHKva46dZ7zqhy9Ey=cKfMpBNie-2h=yq6URa40WhGDjw@mail.gmail.com>
Subject: Re: [PATCH 03/27] t1092: compare sparse-checkout to sparse-index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Add a new 'sparse-index' repo alongside the 'full-checkout' and
> 'sparse-checkout' repos in t1092-sparse-checkout-compatibility.sh. Also
> add run_on_sparse and test_sparse_match helpers. These helpers will be
> used when the sparse index is implemented.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 29 ++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 8cd3e5a8d22..8876eae0fe3 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -7,6 +7,7 @@ test_description='compare full workdir to sparse workdir'
>  test_expect_success 'setup' '
>         git init initial-repo &&
>         (
> +               (GIT_TEST_SPARSE_INDEX=0 && export GIT_TEST_SPARSE_INDEX) &&

I thought parentheses started a subshell; once the subshell ends,
wouldn't the setting of GIT_TEST_SPARSE_INDEX be thrown away?

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
> -               $* >../sparse-checkout-out 2>../sparse-checkout-err
> +               GIT_TEST_SPARSE_INDEX=0 $* >../sparse-checkout-out 2>../sparse-checkout-err
> +       ) &&
> +       (
> +               cd sparse-index &&
> +               $* >../sparse-index-out 2>../sparse-index-err
>         )
>  }
>
>  run_on_all () {
>         (
>                 cd full-checkout &&
> -               $* >../full-checkout-out 2>../full-checkout-err
> +               GIT_TEST_SPARSE_INDEX=0 $* >../full-checkout-out 2>../full-checkout-err
>         ) &&
>         run_on_sparse $*
>  }
> @@ -114,6 +124,17 @@ test_all_match () {
>         test_cmp full-checkout-err sparse-checkout-err
>  }
>
> +test_sparse_match () {
> +       run_on_sparse $* &&
> +       test_cmp sparse-checkout-out sparse-index-out &&
> +       test_cmp sparse-checkout-err sparse-index-err
> +}
> +
> +test_expect_success 'expanded in-memory index matches full index' '
> +       init_repos &&
> +       test_sparse_match test-tool read-cache --expand --table-no-stat
> +'
> +
>  test_expect_success 'status with options' '
>         init_repos &&
>         test_all_match git status --porcelain=v2 &&
> --
> gitgitgadget
>
