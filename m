Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DE9C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 11:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiGKLCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGKLCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 07:02:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A5BA149
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:06:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v14so6313513wra.5
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 03:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GaB6G+MxZBcdKs/ow5Sc8aggZuOi0KiWQQuplbhr4xI=;
        b=prIHQDS1Sfp1x2yUQz2/KdBofowFzekcM0bYg36ZPEe5MDiRIXlFPTNQ2Wx366NetL
         jzs/mmqqxh93VqiL8OY2nLiKuI7ZjLcLeD1cAkbetHleUxpl+pWt4tV+XDVW0HKwPkXU
         f+0fdlmhSw6DcZkz0KVzLgqKHu4grQpvDeHmIEkS6dpnhI32DKmOps+9YxU7fKLDsSI+
         StBoesKPmbbvM1kkXgIwjNgEKQu42UrGnYNhxY4snE9xvq7W/dKDbcsqWg4OTgYhsF5M
         ngMHfFRfqgFevBvnSgYYaRIsgc/cXSe0us4QL4GShpaR+YP5hOKM3mEaNur/O2ZGsfcb
         9wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GaB6G+MxZBcdKs/ow5Sc8aggZuOi0KiWQQuplbhr4xI=;
        b=fa5ZyCC+/8i2e9YCwf49PwMflQbd0gn3nAbyvOTj5j2F31K5/IoYBP3+RkinrN5o2J
         x0GYGo57SLo/BVlgCRIsOQwPvwkPMX0iBSKDNXYfS3sJtrU5nTgoW8Xa/EBW5XgBQRZg
         pSt9leA7/LKNRN3+T6nujypi/S/c9T07leR+RfQUDCzSi+0/jBqpgUJunhncYNm6N+DQ
         fOTJG3oX1oxqiPnc1NbP/WT0wCVTYQTtEmE+eOUHin5/xp5CcyHNSw1lOX55JEsGvoMk
         6GCoPcBFT5kCRfmGHHnEPf/rpEF/rgVOcVGMmc6jh9tfKuXEY9uJcM0P+GS18I0R1Dfq
         Z5tw==
X-Gm-Message-State: AJIora8V37kjXmk9kUzNPozDMl0RSsvWBI5FcRwvUoTKEWTnSLbiQCSh
        97QkvLrcHH4cx+IuWT9tjDU=
X-Google-Smtp-Source: AGRyM1ux/YeKQ4/pJ+Uo9Zlo/N+kfSo4jA322XwI4pi/kuSHQQjZVJhWGh2LV9AeyndWNP6bVoyzCg==
X-Received: by 2002:a5d:64e8:0:b0:21d:2fc9:20dd with SMTP id g8-20020a5d64e8000000b0021d2fc920ddmr15416911wri.101.1657533994484;
        Mon, 11 Jul 2022 03:06:34 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c511400b003a2d3ed9297sm18355518wms.1.2022.07.11.03.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:06:34 -0700 (PDT)
Message-ID: <622ae936-b45d-885a-d779-64156cb8e3ba@gmail.com>
Date:   Mon, 11 Jul 2022 11:06:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/7] git-shared-util.h: add G*() versions of *ALLOC_*()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
 <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
 <patch-3.7-d7c14a1cad8-20220708T140354Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-3.7-d7c14a1cad8-20220708T140354Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 08/07/2022 15:20, Ævar Arnfjörð Bjarmason wrote:
> Add "gently" versions of ALLOC_ARRAY(), CALLOC_ARRAY() etc. using the
> naming convention G*() as a shorthand for "GENTLY_*()".

It might be nicer just to call them ALLOC_ARRAY_GENTLY() etc. As the 
return value needs to be checked it would make sense to implement them 
as expressions as I have done for XDL_ALLOC_ARRAY() etc.

> Nothing uses these functions yet, but as we'll see in subsequent
> commit(s) we're able to convert things that need e.g. non-fatal
> "ALLOC_GROW" behavior over to this.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   git-shared-util.h | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/git-shared-util.h b/git-shared-util.h
> index 7b4479a0f72..718a8e00732 100644
> --- a/git-shared-util.h
> +++ b/git-shared-util.h
> @@ -8,8 +8,11 @@
>   #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
>   
>   #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
> +#define GALLOC_ARRAY(x, alloc) (x) = malloc(st_mult(sizeof(*(x)), (alloc)))
>   #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
> +#define GCALLOC_ARRAY(x, alloc) (x) = calloc((alloc), sizeof(*(x)))
>   #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
> +#define GREALLOC_ARRAY(x, alloc) (x) = realloc((x), st_mult(sizeof(*(x)), (alloc)))
>   
>   #define COPY_ARRAY(dst, src, n) copy_array((dst), (src), (n), sizeof(*(dst)) + \
>   	BUILD_ASSERT_OR_ZERO(sizeof(*(dst)) == sizeof(*(src))))
> @@ -71,17 +74,25 @@ static inline void move_array(void *dst, const void *src, size_t n, size_t size)
>    * added niceties.
>    *
>    * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
> + *
> + * GALLOC_GROW() behaves like ALLOC_GROW(), except that in malloc()
> + * failure we'll return NULL rather than dying.
>    */
> -#define ALLOC_GROW(x, nr, alloc) \
> +#define ALLOC_GROW_1(x, nr, alloc, gently) \
>   	do { \
>   		if ((nr) > alloc) { \
>   			if (alloc_nr(alloc) < (nr)) \
>   				alloc = (nr); \
>   			else \
>   				alloc = alloc_nr(alloc); \
> -			REALLOC_ARRAY(x, alloc); \

This leaks the old allocation if realloc() fails because it overwrites 
the original pointer with NULL, that is particularly bad as if realloc() 
fails we're already short of memory. XDL_ALLOC_GROW() shows how a 
possible way to do this.

Best Wishes

Phillip

> +			if (gently) \
> +				GREALLOC_ARRAY(x, alloc); \
> +			else \
> +				REALLOC_ARRAY(x, alloc); \
>   		} \
>   	} while (0)
> +#define ALLOC_GROW(x, nr, alloc) ALLOC_GROW_1(x, nr, alloc, 0)
> +#define GALLOC_GROW(x, nr, alloc) ALLOC_GROW_1(x, nr, alloc, 1)
>   
>   /*
>    * Similar to ALLOC_GROW but handles updating of the nr value and

