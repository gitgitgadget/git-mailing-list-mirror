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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A6EC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F221764DAB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 17:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344176AbhA0Rrc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhA0RrW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 12:47:22 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A93C061574
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:46:42 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id n42so2491577ota.12
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZpN/KVJEoLo6sE45J55ILs1aBSFrf/P6ML1yU6sc/4=;
        b=TOiHXlWuy1qo/h54X1RZVj4upCa4WGpfXZXw8ELQb7VOjcaTHaAKXJ0TZsfE87d0G9
         1MLB4YBMw3SlSKUg6uFByR7fnS8yBj2wIj5iqvjlmDzOi+lIMcXb/hJ2+NGh8H08OiZZ
         CAe1hoAwD+9FrR/p3lp2krmCgOhdT6FoJMNCfUT92c7GpjJd394yxSs1LBy4nJcgOkJG
         /lv8qtn5JKWIu6O//Q4M6M+xzpLJg5qEKh3/l6tqFKpjI2abDYAfE3KIOUdedzsj8ZxU
         OCUIWbXM3N53uNrpSLEAUZfhzJNHGhX0A5NSyujo/mKib6++WIKfRkIyAnw/kfzo1Czf
         sPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZpN/KVJEoLo6sE45J55ILs1aBSFrf/P6ML1yU6sc/4=;
        b=MoNqbJFFdkkCCewxbLPDQqz8F41Y1eWDYI4/J5t86AHS5LMFL9FWgAUJ7OUaJ2w+5T
         5nnhDxRuALQnoOIdbGw91l88VW/RNiQu+FnMqPnJfsqFwh0EeUpq0vxUyiqy5H6I7bNN
         y/AkyZGM2VlyL2gipS2W79RMxrUFyEstNxSTEiSnoTb5A9R8aOq+oZtJhwRJJ35XydD7
         0gnjnjUw/gfXYZ8FbVyPOKG4sMWqkMODzAzLU+860a6g+vgo21kK47LuHdK4+ZlE4e+P
         RHwAI/DhR7l8s+ymyzqRPoQakwVgmaYGumGfZUoPnbJ+7FakqW/dNsr7c3C2s0QpdLre
         i64A==
X-Gm-Message-State: AOAM531a68QM7qK3/++SPd7lbZ9end295Ck+SZb+PxUcWY3U4LTJrQ1x
        DpTp1Ld1ox9nMN+2tMIr43/bTJLy+TwGkSbz4F0=
X-Google-Smtp-Source: ABdhPJy61tqvNN2OpL4MBvGOnpg2qVraFuFzWEXCMk//nudGMTGONClRTIakl27osE3I/A6L0/9iVTp15JgSjAWaGaA=
X-Received: by 2002:a9d:506:: with SMTP id 6mr8309273otw.162.1611769601448;
 Wed, 27 Jan 2021 09:46:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <9b2ae1bb6c49b67cc17691d58044bbb8efb114a3.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <9b2ae1bb6c49b67cc17691d58044bbb8efb114a3.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jan 2021 09:46:30 -0800
Message-ID: <CABPp-BEOQi1JF-S7XMNTAns0ckbikokk+-Rvw3peCFgts5D27w@mail.gmail.com>
Subject: Re: [PATCH 12/27] sparse-index: check index conversion happens
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
> Add a test case that uses test_region to ensure that we are truly
> expanding a sparse index to a full one, then converting back to sparse
> when writing the index. As we integrate more Git commands with the
> sparse index, we will convert these commands to check that we do _not_
> convert the sparse index to a full index and instead stay sparse the
> entire time.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 22becbaca2e..a22def89e37 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -374,4 +374,21 @@ test_expect_success 'clean' '
>         test_sparse_match test_path_is_dir folder1
>  '
>
> +test_expect_success 'sparse-index is expanded and converted back' '
> +       init_repos &&
> +
> +       (
> +               (GIT_TEST_SPARSE_INDEX=1 && export GIT_TEST_SPARSE_INDEX) &&

Drop the parentheses.

What system are you running on that this test passed for you with
those parentheses there?  I checked out this particular commit and ran
the test -- and it fails for me.  Removing the parentheses makes the
test pass.

Is there some shell where parentheses only function as grouping,
similar to bash's {...}, rather than as a subshell, the way bash
handles (...) ?

> +               GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +                       git -C sparse-index -c core.fsmonitor="" reset --hard &&
> +               test_region index convert_to_sparse trace2.txt &&
> +               test_region index ensure_full_index trace2.txt &&
> +
> +               rm trace2.txt &&
> +               GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +                       git -C sparse-index -c core.fsmonitor="" status -uno &&
> +               test_region index ensure_full_index trace2.txt
> +       )
> +'
> +
>  test_done
> --
> gitgitgadget

Otherwise, I like the test and this commit.
