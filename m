Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1924C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFF460EE4
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 15:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhKQP6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 10:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhKQP6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 10:58:03 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48192C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:55:05 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so5501087otg.4
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 07:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0eCLaFQja3zCxBKY7qJ9k6pt5GLc7XbtxVxuty5AFz8=;
        b=UKAqQfX7Upwzgm/wwW3CQK4yUHWqQRxCGZNonPkP8YHtGtCaL6rAnUIFEr9lGplQqs
         DgHCpNPdPQEoYlNVWM54qxgvUP3F2a8nk7WUhkWUoPaeJP9G6emwOOyvh0QqjuHadH3u
         g0wEBIMFcy5dp16UcHbI3UmB7WaonehJ0uz1BEfQEPCRT4IzxSzhboxlKWWQliUYAhmg
         FXTKc15xixOny7leF+OZ/zaJBImw5PnxEe5fmlV8LMb/h9ckG5Xep01Y5OPVwDepnLkg
         qlnSA0na6A4ZVytcvY7gKSXxGC9T7bwu8/IF+9XVVzn71mDNvyhJcO1OEW6ipYQCtI/w
         785w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0eCLaFQja3zCxBKY7qJ9k6pt5GLc7XbtxVxuty5AFz8=;
        b=nzJlUsp5NdymijjUSjZVaQ9pKjoaysbqBVUOMecloXWHQQcl8MUegNRv38hohSiezD
         XpF+cp/WlmHX/oVF1SbxedXQDMoELSeOSBX2JpQY528VgigLiOAUm+zqQynS6fvqG/8z
         thp9c17qtTu15u8A4wUNlJPHZCH8d9QWnVar1CRkHRDYg9iAtvRTw1t8aM4fL75LesD5
         fVCXT+Q9mgVFdMirJO/596uXQdvWV/wAbtLjw8KCGDxqjRoMEYG7BkhqOmmvZ+miVEsF
         JW8/AsklJGIb+3PMm+ApmbKT+59VbCnRD/Z2QjPI3kNG4gt0ff3fraB7HFNJw0tDXcJB
         cp9A==
X-Gm-Message-State: AOAM532mGCYNnFNDURT//KkA7o5dxnFjMj+X7J9GQbQujOLK7/k6PT3B
        TPF2i11Ds0C9aDNSD/XGPxEgi0r2xXg=
X-Google-Smtp-Source: ABdhPJw9iJxFNELrBE8P39fwi1+zGRgxiFx2AEQl+b+UzoAZZnY2KWYQyQlEPyLLk+QWIs5yfwJ1LA==
X-Received: by 2002:a9d:a64:: with SMTP id 91mr14423478otg.198.1637164504557;
        Wed, 17 Nov 2021 07:55:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d1ee:6c8f:319:f5? ([2600:1700:e72:80a0:d1ee:6c8f:319:f5])
        by smtp.gmail.com with ESMTPSA id b26sm40085oti.56.2021.11.17.07.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 07:55:04 -0800 (PST)
Message-ID: <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
Date:   Wed, 17 Nov 2021 10:55:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Content-Language: en-US
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/17/2021 6:20 AM, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> Histogram is the only diff algorithm not to call
> xdl_classify_record(). xdl_classify_record() ensures that the hash
> values of two strings that are not equal differ which means that it is
> not necessary to use xdl_recmatch() when comparing lines, all that is
> necessary is to compare the hash values. This gives a 7% reduction in
> the runtime of "git log --patch" when using the histogram diff
> algorithm.
> 
> Test                                  HEAD^             HEAD
> -----------------------------------------------------------------------------
> 4000.1: log -3000 (baseline)          0.18(0.14+0.04)   0.19(0.17+0.02) +5.6%
> 4000.2: log --raw -3000 (tree-only)   0.99(0.77+0.21)   0.98(0.78+0.20) -1.0%
> 4000.3: log -p -3000 (Myers)          4.84(4.31+0.51)   4.81(4.15+0.64) -0.6%
> 4000.4: log -p -3000 --histogram      6.34(5.86+0.46)   5.87(5.19+0.66) -7.4%
> 4000.5: log -p -3000 --patience       5.39(4.60+0.76)   5.35(4.60+0.73) -0.7%
> 
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  xdiff/xhistogram.c |  5 ++---
>  xdiff/xprepare.c   | 24 ++++++++----------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index e694bfd9e31..6c1c88a69a1 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -91,9 +91,8 @@ struct region {
>  static int cmp_recs(xpparam_t const *xpp,
>  	xrecord_t *r1, xrecord_t *r2)
>  {
> -	return r1->ha == r2->ha &&
> -		xdl_recmatch(r1->ptr, r1->size, r2->ptr, r2->size,
> -			    xpp->flags);
> +	return r1->ha == r2->ha;
> +

nit: stray newline.

The only meaningful change here is that you are relying entirely on
the hash and not checking the content again. This means that hash
collisions on this 32-bit hash could start introducing different
results. Are we worried about that?

I see that a similar hash-comparison is done in xpatience.c without
further checking the contents, but xdiffi.c compares the hashes and
then checks with xdl_recmatch(). So, we are still not reaching full
consistency across all diff algorithms with how we handle these
comparisons. I think it is good to have at least one that can be used
if/when we hit these hash collisions within a diff, but it can be hard
to communicate to a user why they need to change a diff algorithm for
such an internal reason.


The following bits looked scary at first, but you are just removing the
special-casing of XDF_HISTOGRAM_DIFF from the preparation stage.

> -	if (XDF_DIFF_ALG(xpp->flags) == XDF_HISTOGRAM_DIFF)
> -		hbits = hsize = 0;
> -	else {
> -		hbits = xdl_hashbits((unsigned int) narec);
> -		hsize = 1 << hbits;
> -		if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
> -			goto abort;
> -		memset(rhash, 0, hsize * sizeof(xrecord_t *));
> -	}
> +	hbits = xdl_hashbits((unsigned int) narec);
> +	hsize = 1 << hbits;
> +	if (!(rhash = (xrecord_t **) xdl_malloc(hsize * sizeof(xrecord_t *))))
> +		goto abort;
> +	memset(rhash, 0, hsize * sizeof(xrecord_t *));

> -			if ((XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
> -			    xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)
> +			if (xdl_classify_record(pass, cf, rhash, hbits, crec) < 0)

> -	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF &&
> -	    xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)
> +	if (xdl_init_classifier(&cf, enl1 + enl2 + 1, xpp->flags) < 0)

> -	if (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)
> -		xdl_free_classifier(&cf);
> +	xdl_free_classifier(&cf);

The existence of these conditions gave me pause, so I went to look for where they
were inserted. They were made in 9f37c27 (xdiff/xprepare: skip classification,
2011-07-12) with the justification that 

    We don't need any of that in histogram diff, so we omit calls to these
    functions. We also skip allocating memory to the hash table, rhash, as
    it is no longer used.

    This gives us a small boost in performance.

But you are actually _using_ these preparation steps, which means you are
re-adding the cost of hashing but overall improving because you use the
data correctly. Excellent.

Thanks,
-Stolee
