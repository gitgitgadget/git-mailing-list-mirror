Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F1C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B669610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 01:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhJ1B13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 21:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJ1B13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 21:27:29 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800BC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 18:25:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r194so6046587iod.7
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 18:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dHJhILp0zh1Lr9LJTtrr2P+ofOTzX+aXNcMpR/Mx5eE=;
        b=QC3S1ZGKVWHgqMvK+Pk+b4hxYx1VH7XN3USOGZua8Yw7KnIKydBLrj2ZWLU9Kt+Ilg
         svsnwz3WxnEcqY8RC/lk66K3EbccpdWTbGk3Cu8hcVLyTAqjTdsQfp+WCS1Q7nH92xY9
         XYS1wPI2ueGzv7awMrHSacZcZIL0lz/HzofISqbisnVmGvtePIoTa4yswvVsrfxAme2v
         nMvzFU6ZWKZu3uaGJkUwvMTdO2PQnzG5Nc5XbgeKuMV0HIzatLapnmaUruxSkMurkCkL
         /W3PgCcHiaaoqapnY/8Pc4wo/u4rc9FlOFZVXAZW/hNfIV/YfFkKfY+U0Ty7/To9Mibh
         1wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dHJhILp0zh1Lr9LJTtrr2P+ofOTzX+aXNcMpR/Mx5eE=;
        b=yRhDtleLPo4pgrQs5tvdTvYq5Cwt38AYHipY0wThVMtUT7l9nGAyZZna96J8T/dFse
         yP7QwFXH+5eZHNadJZ1BRPGYSDs46tuSBxLM/w5iKCDl2gucPtc2BdEjItx2yp/auxAb
         jTU4VQZqDm3X37x8emxa1NjpvS5bK/YC3+7kyxjYGPCHgovFyN7x5R4X4jv2IpRgc2xT
         bz32iLveop6O7Vz5cczzOaarPYw59Ut1nP2wA9R9FP4toB6Y3R5NQ1bvPNTMX+sU0eKf
         bf1usYgU4U4qm3aPrXS9mr88vWDHGupP8Fv/gC54vde0MV3Q/YMuMvCaRYPev3LpDX7H
         P7Yg==
X-Gm-Message-State: AOAM5323MOiAinmeXC49YCQEuZ2BQMdxqvN/h1+uRwIsgHtV/LvQsTIX
        TWS5qGxwj5aV0uhCNBK74qg=
X-Google-Smtp-Source: ABdhPJwk1I9UF3rfdjgnQvIOMDR0UgAeNetLQIAuAw9WZbX53aXIi7h/WNDo6KozZUKyLPS6Ljr/5g==
X-Received: by 2002:a05:6602:2c49:: with SMTP id x9mr772676iov.77.1635384302342;
        Wed, 27 Oct 2021 18:25:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id b8sm961640ilv.21.2021.10.27.18.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 18:25:01 -0700 (PDT)
Message-ID: <bc960863-7ff2-d6bf-9710-6803f3784751@gmail.com>
Date:   Wed, 27 Oct 2021 21:24:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 2/3] sparse-index: add ensure_correct_sparsity function
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
 <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
 <9d6511db0728e9880a96f3d9e3a025a9ddc5bc9e.1635358812.git.gitgitgadget@gmail.com>
 <bf73e2d2-a2ab-8364-d505-1bd5bba3efd2@gmail.com> <xmqqbl3aupbh.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqbl3aupbh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 5:32 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> +int convert_to_sparse(struct index_state *istate, int flags)
>>> +{
>>> +	/*
>>> +	 * If the index is already sparse, empty, or otherwise
>>> +	 * cannot be converted to sparse, do not convert.
>>> +	 */
>>> +	if (istate->sparse_index || !istate->cache_nr ||
>>> +	    !is_sparse_index_allowed(istate, flags))
>>> +		return 0;
> 
> Shouldn't we also at least do this?  Blindly blowing away the entire
> cache-tree and rebuilding it from scratch may be hiding a latent bug
> somewhere else, but is never supposed to be needed, and is a huge
> waste of computational resources.
> 
> I say "at least" here, because a cache tree that is partially valid
> should be safely salvageable---at least that was the intention back
> when I designed the subsystem.

I think you are right, what you propose below. It certainly seems
like it would work, and even speed up the conversion from full to
sparse. I think I erred on the side of extreme caution and used
a hope that converting to sparse would be rare.

>  sparse-index.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git c/sparse-index.c w/sparse-index.c
> index bc3ee358c6..a95c3386f3 100644
> --- c/sparse-index.c
> +++ w/sparse-index.c
> @@ -188,17 +188,19 @@ int convert_to_sparse(struct index_state *istate, int flags)
>  	if (index_has_unmerged_entries(istate))
>  		return 0;
>  
> -	/* Clear and recompute the cache-tree */
> -	cache_tree_free(&istate->cache_tree);
> -	/*
> -	 * Silently return if there is a problem with the cache tree update,
> -	 * which might just be due to a conflict state in some entry.
> -	 *
> -	 * This might create new tree objects, so be sure to use
> -	 * WRITE_TREE_MISSING_OK.
> -	 */
> -	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
> -		return 0;
> +	if (!cache_tree_fully_valid(&istate->cache_tree)) {
> +		/* Clear and recompute the cache-tree */
> +		cache_tree_free(&istate->cache_tree);
> +		/*
> +		 * Silently return if there is a problem with the cache tree update,
> +		 * which might just be due to a conflict state in some entry.
> +		 *
> +		 * This might create new tree objects, so be sure to use
> +		 * WRITE_TREE_MISSING_OK.
> +		 */
> +		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
> +			return 0;
> +	}

I think at this point we have enough tests that check the sparse index
and its different conversion points that the test suite might catch if
this is a bad idea. Note that this is only a change of behavior if the
cache-tree is valid, which I expect to be the case most of the time in
the tests.

Thanks,
-Stolee
