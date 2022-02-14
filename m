Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75110C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 15:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbiBNPpH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:45:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiBNPpF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 10:45:05 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6E4925B
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 07:44:57 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b35so14690244qkp.6
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 07:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uuvTb5Nu0wTRpOKSaGjxDgvvq/iXHmVEBLn8/v3dLKg=;
        b=F7VZPBSBErGbTU/YA0gjIsIMfT/NRpJgbv0sg/LFWJPisoLW3UL5mi2nfVq4ohKo5a
         YTe96CTZQp1ZLXUGi1p9nTA+yY96Xf+im4stRBmgBtbeG9TBJ1s8tFy6sOLfVcEI8M3N
         b7TZswD8igqkClp9otYyqIaYjZZMdks9Z9xsBRJg3ww26K3esn7bqHreABt8j6TUrIWG
         YY5gSIlAuxCHTZTZcv+IxUG7inAWI6rGphNBGzDQEuLhbJPtFn88is6Q9NSfmeSirW13
         iIrV0gIvE+WOT4jwrYAe3/BLVkwLXpeqStx5DGucYylthEBqjhpcJZ9EYKtDV3e+RoW1
         yHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uuvTb5Nu0wTRpOKSaGjxDgvvq/iXHmVEBLn8/v3dLKg=;
        b=ecfRfJ0YhQf/J92eI/blKV/PGQlUc8khM3i5SXTuFq/WjWbyhWCPj1ikKx2mxRSSio
         +Cd6R1pMHlkVWUh0LDOSEOjpsK8MGVTNd5VCpgIoVQ3eXkNEIAcjgEuJilQedYcUQtGb
         lzCpJE2AChfq3WJkVTNbID0gQXtOFkRi+AJq+SCYYyapiDPZVSdxVvelvZp+GPUvdUwx
         vikEj8WItxvRAAHOf0+TltwgCbU/DQsEeRHWxHT4qru3z5PcTEmwwu1FTxy+YPbAhRcM
         UIouHU+9Di6vngZPqzx3QDPgFTq3xzkcPpApNu4yFGzWnFENFXmdhyPU9lxA04CQT0Ms
         ndfQ==
X-Gm-Message-State: AOAM531YMDchLWM57SpMmTk6iuq76ART6pziK78/hpGV3LOf6UigmhSP
        TnRn/Pov2MW9ff/U1dd/p1R1
X-Google-Smtp-Source: ABdhPJzrYD7idHRoLclquDcyLY780Z0W+a/Wqw8jska/fzQ1pehlQFEidRblZBOtksbEU9IfnvUNsA==
X-Received: by 2002:a05:620a:4116:: with SMTP id j22mr99757qko.483.1644853496891;
        Mon, 14 Feb 2022 07:44:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:eccf:bfbc:c638:47f4? ([2600:1700:e72:80a0:eccf:bfbc:c638:47f4])
        by smtp.gmail.com with ESMTPSA id m5sm15653190qkp.132.2022.02.14.07.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 07:44:56 -0800 (PST)
Message-ID: <40a88efa-a07f-417b-a5c5-0a6e651cfa8c@github.com>
Date:   Mon, 14 Feb 2022 10:44:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/7] sparse-checkout: correctly set non-cone mode when
 expected
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
 <3bab59604046facb1e31ff1496e5bdb1afc7bf22.1644712798.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <3bab59604046facb1e31ff1496e5bdb1afc7bf22.1644712798.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/12/2022 7:39 PM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
> sparse-checkout mode", 2021-12-14) made the `set` command able to
> intialize sparse-checkout mode, but it also had to function when

s/intialize/initialize/

> sparse-checkout mode was already setup and the user just wanted to
> change the sparsity paths.  So, if the user passed --cone or --no-cone,
> then we should override the current setting, but if they didn't pass
> either, we should use whatever the current cone mode setting is.
> 
> Unfortunately, there was a small error in the logic in that it would not
> set the in-memory cone mode value (core_sparse_checkout_one) when
> --no-cone was specified, but since it did set the config setting on
> disk, any subsequent git invocation would correctly get non-cone mode.
> As such, the error did not previously matter.  However, a sbusequent

s/sbusequent/subsequent/

> commit will add some logic that depends on core_sparse_checkout_cone
> being set to the correct mode, so make sure it is set consistently with
> the config values we will be writing to disk.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/sparse-checkout.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 510cb89b544..8d595189ea3 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -399,6 +399,8 @@ static int update_modes(int *cone_mode, int *sparse_index)
>  		core_sparse_checkout_cone = 1;
>  	} else {
>  		mode = MODE_ALL_PATTERNS;
> +		if (record_mode)
> +			core_sparse_checkout_cone = 0;

Is there a special reason why this is guarded by "if (record_mode)"?

Thanks,
-Stolee
