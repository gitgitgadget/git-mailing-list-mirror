Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A185F1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 02:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeKFLdR (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 06:33:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41356 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeKFLdR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 06:33:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so11672684wrw.8
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 18:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sQyMFcN+vbK7SianhJg9q6zkp9J6994lIQK1qHAD+nk=;
        b=kRneZr5VFEcs84/CsEyZGHhcFLdHdci4teYKKyQd3qzwum2Q/KEdgbheBw3eOOdvyU
         0MJnrmOF2aQVtV9OCYD+b3rzVaJ5GS6w+CxhXHm1Zn+hZV5ANzrfKB5IxsFEctDrQVfV
         WT/YrJ6tc++vQMFpgzV3+AJhVqelOewayvbvUyx6AJDdu1nBhZUzxz3t+OA3hq5r8LsS
         xTT0uo8uzbuWEPbIZ7Y2FNTCV5MZ84L4NnTBN9aUoaRb+Kl1lmY2laEd2uXYKzYdew0e
         mYFjmxchrDPrvp5PwXyIBEHYaIyF91MTthTtkHV8KQFdV8NUVG+KhePK/4AtNN83zXf+
         uxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sQyMFcN+vbK7SianhJg9q6zkp9J6994lIQK1qHAD+nk=;
        b=d8VqjMh1gR6R8PNmBtXjbhmHEVTdrQoT2gvsLNEXJurcbJcifqeZPdp3m+QNGRwLxq
         alI8hW8XADt22gzYm/PYEOGhDkEgusO7dAfaVRhoOPwEiKdH9bHkrn9Bra2wDx3oHES5
         sSwMtSsP6JrA81l36bP4S9/E085IrvyHhFeSSKyqqYDwiKDV8+qNqx+YnSsdxDj7y350
         QI48swuYCfZZu2Jlp9KHx04L16JWsYYmwYda3tUvgh5utjrO0mHJn/a6fjB/5lh5GJTJ
         6XveXMD8bfrg0X87MDpYMzbqqRh3N00dvFfn+H8B+y65txnX5lFQQvkJ73kjhRudPPVH
         9j0A==
X-Gm-Message-State: AGRZ1gK5pIV6JrlCpmrMfpuMa6VGN2mzNb90sw5s/wd+5wu04yU7K4tZ
        avOZAVCZY811vo16rK5NWc4=
X-Google-Smtp-Source: AJdET5dA68cS9XkszR4vzItItVJXY6ceLSQyxkmiRICGBVsNGSzUzUxnV1Cb20CwXOXz7ZUEGdCKww==
X-Received: by 2002:adf:90d0:: with SMTP id i74-v6mr21122700wri.181.1541470230113;
        Mon, 05 Nov 2018 18:10:30 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k73-v6sm363996wmd.33.2018.11.05.18.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 18:10:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 05/16] read-cache.c: turn die("internal error") to BUG()
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181105192059.20303-1-pclouds@gmail.com>
        <20181105192059.20303-6-pclouds@gmail.com>
Date:   Tue, 06 Nov 2018 11:10:28 +0900
In-Reply-To: <20181105192059.20303-6-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 5 Nov 2018 20:20:48 +0100")
Message-ID: <xmqq7ehrgdm3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  read-cache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Makes sense; thanks.

>
> diff --git a/read-cache.c b/read-cache.c
> index d57958233e..0c37f4885e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -316,7 +316,7 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
>  			changed |= DATA_CHANGED;
>  		return changed;
>  	default:
> -		die("internal error: ce_mode is %o", ce->ce_mode);
> +		BUG("unsupported ce_mode: %o", ce->ce_mode);
>  	}
>  
>  	changed |= match_stat_data(&ce->ce_stat_data, st);
> @@ -2356,14 +2356,14 @@ void validate_cache_entries(const struct index_state *istate)
>  
>  	for (i = 0; i < istate->cache_nr; i++) {
>  		if (!istate) {
> -			die("internal error: cache entry is not allocated from expected memory pool");
> +			BUG("cache entry is not allocated from expected memory pool");
>  		} else if (!istate->ce_mem_pool ||
>  			!mem_pool_contains(istate->ce_mem_pool, istate->cache[i])) {
>  			if (!istate->split_index ||
>  				!istate->split_index->base ||
>  				!istate->split_index->base->ce_mem_pool ||
>  				!mem_pool_contains(istate->split_index->base->ce_mem_pool, istate->cache[i])) {
> -				die("internal error: cache entry is not allocated from expected memory pool");
> +				BUG("cache entry is not allocated from expected memory pool");
>  			}
>  		}
>  	}
