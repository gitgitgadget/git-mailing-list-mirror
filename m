Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E60C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C154860F35
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhHDOzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDOzR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 10:55:17 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6068AC0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 07:55:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y1so2703844iod.10
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Mz4Qz3uzWxd3Q8zxNSKDvvrw5b2dws6nD6s0BoePDII=;
        b=tpeFlTfpm9cdQK+WmqVyjR/BSjtRlhuX/AJxG3Mm6onjPDj5MIG1JB3SIIL3CT+ykX
         7yI1LdrrppMdWycDohk37w/4ANIQ2MtYEC3LnKv3etBC3Jf+ygYe3Jb+zQBHc9a6v/7w
         9VfY3Yh7HneST8UExobMkv8aPD8/rTChhkhwhXmKwo2YBpApbgb3xVbPy0OyVY2yQlu/
         VWHoU8qrvUSF413M7DZN0GM5erPy0JQuMLRh5AUcS3OCQTV+Rq4pOtKoYMvHjacf4Lx0
         c8X1YQLPM3WdMzmlAofg7RydhYYDNLCizyOjvJFmf87yFc0e1dLg03xE4zr6WBynZbDE
         wI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mz4Qz3uzWxd3Q8zxNSKDvvrw5b2dws6nD6s0BoePDII=;
        b=EDw7f5ISIofZlZIRPUBdecbb6h9g3cMuoufxOk2jUXblQoodx6KRC1D6y0aTDAdzUG
         7uGjNsHZSTrFGbgY4PemBxsPVqoWA/p77TQHRfImEAm6mIZzQRcrvYgLN5xPiqiMev4a
         XwmJUXhWaXBRjImdt7NCRjF99Q7sgsT4UMmG5PzaqPo9+bQq9dpiaMJQN23lVb8q5WDp
         dnnwJHB0v/aJ/qmAGRPX19gjwhz9oJ3mAZd3GbqFgG0dsXDf3KEyiLH270ZCxvuF3VLV
         8oXll/X3HmNcMLtxalUxjqWYNrZ20RNneSNcWXPSXbukRbZI4I8YEYRnUIoj/xOHL1K2
         LqGg==
X-Gm-Message-State: AOAM533fdvYYe17MBKTyFpHy9foPUFwwRaVXX+TWaRSssZPDShzdvgDn
        10NkOiohyKz3D5g2cno0oJNvtDvAN1NXmw==
X-Google-Smtp-Source: ABdhPJyZJ7eq3f1K2UxnzUubIP8/OU52LAML2gjzQEl56fMqgxvxhDEVstrOVhTB65U6Pvi+Hf7dMQ==
X-Received: by 2002:a6b:7801:: with SMTP id j1mr11631iom.32.1628088902436;
        Wed, 04 Aug 2021 07:55:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3da5:bc29:43f3:f85c? ([2600:1700:e72:80a0:3da5:bc29:43f3:f85c])
        by smtp.gmail.com with ESMTPSA id g9sm1246849ilj.70.2021.08.04.07.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:55:01 -0700 (PDT)
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9532b3a8-baeb-50ac-766e-e9844aa63051@gmail.com>
Date:   Wed, 4 Aug 2021 10:55:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 9:56 AM, Patrick Steinhardt wrote:
> When doing reference negotiation, git-fetch-pack(1) is loading all refs
> from disk in order to determine which commits it has in common with the
> remote repository. This can be quite expensive in repositories with many
> references though: in a real-world repository with around 2.2 million
> refs, fetching a single commit by its ID takes around 44 seconds.
> 
> Dominating the loading time is decompression and parsing of the objects
> which are referenced by commits. Given the fact that we only care about
> commits (or tags which can be peeled to one) in this context, there is
> thus an easy performance win by switching the parsing logic to make use
> of the commit graph in case we have one available.

Nice find!

> Like this, we avoid
> hitting the object database to parse these commits but instead only load
> them from the commit-graph. This results in a significant performance
> boost when executing git-fetch in said repository with 2.2 million refs:
> 
>     Benchmark #1: HEAD~: git fetch $remote $commit
>       Time (mean ± σ):     44.168 s ±  0.341 s    [User: 42.985 s, System: 1.106 s]
>       Range (min … max):   43.565 s … 44.577 s    10 runs
> 
>     Benchmark #2: HEAD: git fetch $remote $commit
>       Time (mean ± σ):     19.498 s ±  0.724 s    [User: 18.751 s, System: 0.690 s]
>       Range (min … max):   18.629 s … 20.454 s    10 runs
> 
>     Summary
>       'HEAD: git fetch $remote $commit' ran
>         2.27 ± 0.09 times faster than 'HEAD~: git fetch $remote $commit'

That's a great improvement. I'm sure that the remaining time is dominated
by ref parsing.

> -	if (type == OBJ_COMMIT)
> -		return (struct commit *) parse_object(the_repository, oid);
> +
> +	if (type == OBJ_COMMIT) {
> +		struct commit *commit = lookup_commit(the_repository, oid);
> +		if (!commit || repo_parse_commit(the_repository, commit))
> +			return NULL;
> +		return commit;
> +	}
> +

And this change looks obviously correct to me. I'm glad that the
implementation actually doesn't care about the commit-graph, but
instead cares about using the "standard" parsing approach instead
of side-stepping the commit-graph via parse_object().

I took a quick look for other instances where we use parse_object()
but also know to expect a commit, but did not find one.

Thanks,
-Stolee
