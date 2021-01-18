Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FB8C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 15:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D041222AAA
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 15:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406073AbhARP7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406144AbhARP6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 10:58:33 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D6AC061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 07:57:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id v126so18997737qkd.11
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZMZ553dp2FFXdPPxUWLZTYqg5ZvuktlR2uLtuHAwYM=;
        b=mxAPC45qNuop1xirhB/pl6QvVTXpi26hUi1EfOaDnasWKoXV+0nU+uVH7IZIXF/pHb
         AtIGkV16LYNhdXPnejtLChp9jcX9ly+15PN5cgPYEhZKgC2Ir5XjL6wr+JgNgwzehpyr
         sNL4wFfSDz5FqplnsT14q4TNLGtNdaNFq+T+Ka2IVsotUeq/YszurP8cjblbyhRKflCJ
         eARTa7yH1yPg+XeKBVl6bd81iamfyUNJXdiwkrg64TYj0/VA5LCa4eoXVy+fRvYOdiaJ
         rhpipyyeWDMSAsSv3yME9ii/6L35VkYTk9eg9sduraBOzTkiQRtEY0i9ic24cn4w3wku
         7xXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZMZ553dp2FFXdPPxUWLZTYqg5ZvuktlR2uLtuHAwYM=;
        b=Xr8p9do2A53YXquUAK2NKwOgpV74Zbdhkw3ianQLGp9/pYGdOL+psS1EX5SmyZmYNY
         VpRbLqMnXZRh/lpWfj9rAxSHVooWZVAkBZr6Fv1oRusNYQ7eEng+wFtpy3BQdiwNspVj
         CIXtWS26tgLPQPUZv9nKTbclWb7Gjq2zovYOYdtXAMg9P3gPepWv7+Usm4CgmqW1yRaX
         C/Ba5EpOavSJFJHVH9dHU3UQ0yVx2FTFpFqxD1CMQrUy04I8r81nl/uZXb5qC+rC4EtQ
         yYpRhF6wfT+HK+PDCow1Eunf8lNP7Srhhudrnf7vOTE++ShNxxRJrCPh3tLOmBpdCCWq
         rUpQ==
X-Gm-Message-State: AOAM53104144Vnis6oMjZlWgypyEDwr2QfrhplgLeIOB9eff6ZUFYGuf
        /ZXdxS0VOVTyAecdgW0ZRSxdig==
X-Google-Smtp-Source: ABdhPJyEcqFEQqlUfxVaeCBrnWo4Kxay71zJMgLVDbvek7+kd7BJQUxRyRUKNvO0vv9pDonVA7pdHA==
X-Received: by 2002:ae9:e119:: with SMTP id g25mr276823qkm.124.1610985471041;
        Mon, 18 Jan 2021 07:57:51 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2483:e3d9:d273:1d4b])
        by smtp.gmail.com with ESMTPSA id 190sm11098336qkf.61.2021.01.18.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:57:50 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:57:47 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/2] maintenance: set log.excludeDecoration durin prefetch
Message-ID: <YAWv+5HDxEvBK+8R@nand.local>
References: <pull.838.git.1610940216.gitgitgadget@gmail.com>
 <5b2ce9049a69d4c450093433e4fa15c4e5e0c412.1610940216.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b2ce9049a69d4c450093433e4fa15c4e5e0c412.1610940216.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not related to the patch below, but in the subject line: s/durin/\0g/.

On Mon, Jan 18, 2021 at 03:23:35AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index b315b2ad588..54bae7f0c4c 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -897,6 +897,12 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
>  	struct string_list_item *item;
>  	struct string_list remotes = STRING_LIST_INIT_DUP;
>
> +	git_config_set_multivar_gently("log.excludedecoration",
> +					"refs/prefetch/",
> +					"refs/prefetch/",
> +					CONFIG_FLAGS_FIXED_VALUE |
> +					CONFIG_FLAGS_MULTI_REPLACE);
> +

OK; this is a good way to ensure that you're not constantly appending
'refs/prefetch' into the config.

I did notice that we have a 'remotes' string list just above, so I
suppose we could only ignore 'refs/prefetch/<remote>' for just the
remotes that we know about, but I doubt that this would be all that
useful. (I.e., are there really users that are using refs/prefetch
already and don't want to hide the parts of it that aren't managed by
maintenance? Doubtful.)

> +test_expect_success 'prefetch and existing log.excludeDecoration values' '
> +	git config --unset-all log.excludeDecoration &&
> +	git config log.excludeDecoration refs/remotes/remote1/ &&
> +	git maintenance run --task=prefetch &&
> +
> +	git config --get-all log.excludeDecoration >out &&
> +	grep refs/remotes/remote1/ out &&
> +	grep refs/prefetch/ out &&
> +
> +	git log --oneline --decorate --all >log &&
> +	! grep "prefetch" log &&
> +	! grep "remote1" log &&
> +	grep "remote2" log &&
> +
> +	# a second run does not change the config
> +	git maintenance run --task=prefetch &&
> +	git log --oneline --decorate --all >log2 &&
> +	test_cmp log log2

Great, this test matches what I would expect. Thank you!

Thanks,
Taylor
