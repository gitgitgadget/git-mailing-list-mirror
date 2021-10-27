Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48692C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2722360F38
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbhJ0UJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243784AbhJ0UJj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:09:39 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10509C061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:07:14 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v17so3683470qtp.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=IgYqZq2uUvFZP1QbDjIf8QopiYbOQhiMdwNep92l6bs=;
        b=idXqvxvq5TDApLdYZnpNet/QgyYJ+TQZkdxz8w3BHEmD5ulYyao6+XNn7GYhz5QM/h
         1ytEi0cszrM5TkEQIVQ9/EIXEnz45hhc2Apw8sexCaVdrv/iL8ExdoUaI+kVoiX1Qq5n
         3e3jLOclm7NBEvk3imKM/nKbkpUt1YYHMjMvFXqBEMjWkkGoNcvIaNyZcmJXSr3eB0Qi
         AledEcaEIHeeOlTVjMWzpwU9PQJ9em8YhGr7lkRetFB2sTVvsptzg6Wc2RMdUjtO+3un
         XgIsB5haseBWHr18onKUmzp/BSpnedw8a14voiCiJLc8OvB3uR6hexA6uANXHwYDPyrb
         3KFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=IgYqZq2uUvFZP1QbDjIf8QopiYbOQhiMdwNep92l6bs=;
        b=vF9tRpnI9MOh9C2OTrXT/Ordrb8yQADF9pNnCqT7Eevxpx2TpIhhjHlMPKXEulWHUM
         9KYhGXYGh86Zgc1sfsBGLwZAOk489O340aQecCaws8lpvm6fl3I8Z8OS+GsI7YU7ICNF
         /bAvBLvXJMgQUiK1KcQdGy0zgilvpNNTJaeG4R2SdFl6JVgR/yRrIFF8La3Ug/PcJx50
         YdQIW/KP1oL3hATYYvpYkyn2wvOfw6c5c65i8CB8o1Cq5/MXrkbHrfiDr9JmgCP/dyYe
         9K54GwGHAednk/x8qIYWa23PuwoxpXONMWTdK6BzV1FnABRlnZjXZao4NoYjzg/qH6Z9
         LE0w==
X-Gm-Message-State: AOAM531QZo/u/jR02YLMiEglzKppHk4H0WXz8RC1e+78bk5y4rycoEzh
        PYPGLZAqX8LR6akUoA7mY3cbdKzLXLE=
X-Google-Smtp-Source: ABdhPJwcvLIHE7qKyHdvMbTP0gMV8Dnw2k9vJi1STP8KWN3wvwTmdRFKWf80OAXYwBd678wAJ//Gsg==
X-Received: by 2002:a05:622a:1894:: with SMTP id v20mr31464911qtc.355.1635365233173;
        Wed, 27 Oct 2021 13:07:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id d23sm575914qtm.11.2021.10.27.13.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 13:07:12 -0700 (PDT)
Message-ID: <bf73e2d2-a2ab-8364-d505-1bd5bba3efd2@gmail.com>
Date:   Wed, 27 Oct 2021 16:07:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 2/3] sparse-index: add ensure_correct_sparsity function
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
 <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
 <9d6511db0728e9880a96f3d9e3a025a9ddc5bc9e.1635358812.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9d6511db0728e9880a96f3d9e3a025a9ddc5bc9e.1635358812.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 2:20 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>

> +static int is_sparse_index_allowed(struct index_state *istate, int flags)

I agree this name is better.

>  {
> -	int test_env;
> -	if (istate->sparse_index || !istate->cache_nr ||
> -	    !core_apply_sparse_checkout || !core_sparse_checkout_cone)
> +	if (!core_apply_sparse_checkout || !core_sparse_checkout_cone)
>  		return 0;
>  
>  	if (!istate->repo)
>  		istate->repo = the_repository;
>  
>  	if (!(flags & SPARSE_INDEX_MEMORY_ONLY)) {
> +		int test_env;
> +
>  		/*
>  		 * The sparse index is not (yet) integrated with a split index.
>  		 */

Nice that most of the implementation comes over without showing
up in the diff.

>  	if (!istate->sparse_checkout_patterns->use_cone_patterns)
>  		return 0;
>  
> +	return 1;
> +}
> +
> +int convert_to_sparse(struct index_state *istate, int flags)
> +{
> +	/*
> +	 * If the index is already sparse, empty, or otherwise
> +	 * cannot be converted to sparse, do not convert.
> +	 */
> +	if (istate->sparse_index || !istate->cache_nr ||
> +	    !is_sparse_index_allowed(istate, flags))
> +		return 0;

> +void ensure_correct_sparsity(struct index_state *istate)
> +{
> +	/*
> +	 * If the index can be sparse, make it sparse. Otherwise,
> +	 * ensure the index is full.
> +	 */
> +	if (is_sparse_index_allowed(istate, 0))
> +		convert_to_sparse(istate, 0);
> +	else
> +		ensure_full_index(istate);
> +}

These two methods become very simple. Excellent.

-Stolee
