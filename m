Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE9309EFA
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926727; cv=none; b=pOHx51ItHDSU1w3V45jAv/MM/ysZYif2jvGOa5E/hwIH4I+pd+/7LcJw0s1yR0fbfROafSZXlwISeK1eaba3DoQc3E3yuLpp2J/7o0hmguLCqY+IYwbnHosILJCT30ISQfbHQQQy8P16/g5dQe0iQec9g8QTxerJWLJ7yT209jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926727; c=relaxed/simple;
	bh=oGWdvxZF/Rr3o1MtWZJanf/awW5GgshuZSxSliIVK7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O82PTR1Hq74moCfl78tC1HXkcyLC0lG1S13pPtNpD/tRVAM+zjHGBCDxzjMZV32oETtB0b0MHdgXCoN6ZJWAqWsm880OSFPZptcGUJY8pd0joMYnL2eumiBIQhYBztjxXvkoey9Ys+ODN/wOgRqR62/mOq0OmWkeLJHyFQATmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5SSvejJ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5SSvejJ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso39530535e9.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768926723; x=1769531523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=moyhK2zacDQGKnpHlVH8Ks0KEb3+TLcq1P2wdn+IZY8=;
        b=E5SSvejJtD0+g6yNBaK1iJjSxV45uog9lW0iYb3lx8SQ+OELMk1dQTpTn0A3XHU3Dj
         5ojWoTQL3vZ4osbFKCpKDUCX+WyV1tF7+jpcGQJrVUvmCqe5gLBdNukSUwPYWVk0FmZJ
         uRr9aOPl43e/gNEk8wrtEXYxro/KOZ2I2/mhX0513fnuIa/JPnFJxvuxHzJ1HHURz+W5
         Pl0R3AkssoRYvDwYvoJnXM0IkSNtkBYipOaxZVus/xJzesFshApKUqXM6kcbwGOTOpMP
         YmPApISNjgl3ES0GKBqT0u+ncNcOeKJNS//bZ8sOWeMWgTqJJdBz1aj+oNnGtJYw/Cat
         0bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926723; x=1769531523;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moyhK2zacDQGKnpHlVH8Ks0KEb3+TLcq1P2wdn+IZY8=;
        b=R/eFdmekbozYbVfGkgBcbLYjk+YrbXSL65QMeaqIjZyBrgTyqPv3q0k79Lhs39z8mo
         SkgNvuda2BeKU17pCLrQdS8NXr/6yi7/mKiK5ZwKm92tUIICiv/cnvrmRyZPwAAXiLOZ
         Ee0eTpvLhkcu6sAR1GAqZgWXgbqrNjlk6yZiWUk+XwO/D1gz74SW5A4UwClAWlY9dcNY
         IxP6VxFSmIg+/EPafiFjRFWJeQWPV9d6x1458/N18i7NRa4Zbi4YObAtaBCk94vKVhsQ
         Q/rWPdhl/3cbocbUf+a3OuQ+PxZKAM2T2DoBeGNNDlALiw06IYq5gvx3Opft6bYt34rE
         0hxg==
X-Forwarded-Encrypted: i=1; AJvYcCXMGn4b43z/HjH9vWkGimTBxl8CZ2PzeXXo4kztGQ1WRPiNCRfFIqnwc8WW82XoZkmxHv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/SQ/U2UlQ4kZBzJofgeaZDlpY+3TkWejP4ZQl38610FJ4jNp
	64tskbv4c9OiSLLERNDyIoqV7xc1WanPkN6FmkupSfOzgrYuqVVP+6+0
X-Gm-Gg: AY/fxX4KefOYq2lb+9fs91MIcds3m8POfQpQGJ/dYiWdWlRh/FjBONcpTQ9jYqw7fos
	OvSqDZqzNgtfXfkL4jKtranvGH1C3wI8pwq7ztS2XfJ7TEDwxMqtaSl+iJZgk75wS8B/Nbac/2S
	8YsghZc38aHXSr6NK/KgmIll1k+HinqB1wybaugTf2/UqbxVQ5mQ9vTH0viim0MnkyqOuD/jGPv
	6GEqRZENOSa09P1XXC//d1lYbEgzCBlY2DDVrocph1N3fGzQtMqFzxcGtZUx21UbLM2hwJ+ECJH
	JtqulmrXrqrwBJRaLF4NfS45MYIem18bojkN5YvABOVzt8Qw/r32KwnBOkc7trbFKbrkIc2ynUz
	EwVqw7aiG06TcecA2/+pIh3UfvRrvq0jKBkPGIfVFW1oYQfOT/JOjxKWQnD3UyFR1eKuAKf1O3v
	st6qa+lVFviDUkXaHzIiPcwHJp0nwvupqCp4joipBjHYSmJTzUtz9Jq/8GJ8vix/vPRw==
X-Received: by 2002:a05:600c:608b:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-4803e7a2cc0mr37070625e9.10.1768926722911;
        Tue, 20 Jan 2026 08:32:02 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe65883sm105008855e9.15.2026.01.20.08.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:32:02 -0800 (PST)
Message-ID: <e2ccd068-3ea7-4be1-9ed1-71b39382c064@gmail.com>
Date: Tue, 20 Jan 2026 16:32:01 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 05/10] xdiff: use xdfenv_t in xdl_trim_ends() and
 xdl_cleanup_records()
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <742f2d381af52cd8314a6a643e84b6b9daf99c7c.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <742f2d381af52cd8314a6a643e84b6b9daf99c7c.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> View with --color-words. Prepare these functions to use the fields:
> delta_start, delta_end. A future patch will add these fields to
> xdfenv_t.

I'm afraid this message doesn't make much sense to me. What are these 
new fields? I think it would help to explain what this up comming change 
is going to do and why.

Oh, having read patch 7 we're removing dstart and dend from xdfile_t and 
replacing them with delta_start and delta_end in xdfenv_t. It would be 
useful to say that here.
> -static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
> +static int xdl_cleanup_records(xdlclassifier_t *cf, xdfenv_t *xe) {

Maybe we could add xdf1 and xdf2 as local variables to avoid having to 
change the code that accesses the members of xdfile_t that are not going 
to be moved to xdfenv_t.

Thanks

Phillip

>   	long i, nm, mlim;
>   	xrecord_t *recs;
>   	xdlclass_t *rcrec;
> @@ -273,11 +273,11 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	 * Create temporary arrays that will help us decide if
>   	 * changed[i] should remain false, or become true.
>   	 */
> -	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
> +	if (!XDL_CALLOC_ARRAY(action1, xe->xdf1.nrec + 1)) {
>   		ret = -1;
>   		goto cleanup;
>   	}
> -	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
> +	if (!XDL_CALLOC_ARRAY(action2, xe->xdf2.nrec + 1)) {
>   		ret = -1;
>   		goto cleanup;
>   	}
> @@ -285,17 +285,17 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	/*
>   	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>   	 */
> -	if ((mlim = xdl_bogosqrt((long)xdf1->nrec)) > XDL_MAX_EQLIMIT)
> +	if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
> -	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart]; i <= xdf1->dend; i++, recs++) {
> +	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart]; i <= xe->xdf1.dend; i++, recs++) {
>   		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
>   		nm = rcrec ? rcrec->len2 : 0;
>   		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>   	}
>   
> -	if ((mlim = xdl_bogosqrt((long)xdf2->nrec)) > XDL_MAX_EQLIMIT)
> +	if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>   		mlim = XDL_MAX_EQLIMIT;
> -	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart]; i <= xdf2->dend; i++, recs++) {
> +	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart]; i <= xe->xdf2.dend; i++, recs++) {
>   		rcrec = cf->rcrecs[recs->minimal_perfect_hash];
>   		nm = rcrec ? rcrec->len1 : 0;
>   		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
> @@ -305,27 +305,27 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	 * Use temporary arrays to decide if changed[i] should remain
>   	 * false, or become true.
>   	 */
> -	xdf1->nreff = 0;
> -	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
> -	     i <= xdf1->dend; i++, recs++) {
> +	xe->xdf1.nreff = 0;
> +	for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart];
> +	     i <= xe->xdf1.dend; i++, recs++) {
>   		if (action1[i] == KEEP ||
> -		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
> -			xdf1->reference_index[xdf1->nreff++] = i;
> +		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xe->xdf1.dstart, xe->xdf1.dend))) {
> +			xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
>   			/* changed[i] remains false, i.e. keep */
>   		} else
> -			xdf1->changed[i] = true;
> +			xe->xdf1.changed[i] = true;
>   			/* i.e. discard */
>   	}
>   
> -	xdf2->nreff = 0;
> -	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
> -	     i <= xdf2->dend; i++, recs++) {
> +	xe->xdf2.nreff = 0;
> +	for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart];
> +	     i <= xe->xdf2.dend; i++, recs++) {
>   		if (action2[i] == KEEP ||
> -		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
> -			xdf2->reference_index[xdf2->nreff++] = i;
> +		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xe->xdf2.dstart, xe->xdf2.dend))) {
> +			xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
>   			/* changed[i] remains false, i.e. keep */
>   		} else
> -			xdf2->changed[i] = true;
> +			xe->xdf2.changed[i] = true;
>   			/* i.e. discard */
>   	}
>   
> @@ -340,27 +340,27 @@ cleanup:
>   /*
>    * Early trim initial and terminal matching records.
>    */
> -static int xdl_trim_ends(xdfile_t *xdf1, xdfile_t *xdf2) {
> +static int xdl_trim_ends(xdfenv_t *xe) {
>   	long i, lim;
>   	xrecord_t *recs1, *recs2;
>   
> -	recs1 = xdf1->recs;
> -	recs2 = xdf2->recs;
> -	for (i = 0, lim = (long)XDL_MIN(xdf1->nrec, xdf2->nrec); i < lim;
> +	recs1 = xe->xdf1.recs;
> +	recs2 = xe->xdf2.recs;
> +	for (i = 0, lim = (long)XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec); i < lim;
>   	     i++, recs1++, recs2++)
>   		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
>   			break;
>   
> -	xdf1->dstart = xdf2->dstart = i;
> +	xe->xdf1.dstart = xe->xdf2.dstart = i;
>   
> -	recs1 = xdf1->recs + xdf1->nrec - 1;
> -	recs2 = xdf2->recs + xdf2->nrec - 1;
> +	recs1 = xe->xdf1.recs + xe->xdf1.nrec - 1;
> +	recs2 = xe->xdf2.recs + xe->xdf2.nrec - 1;
>   	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
>   		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
>   			break;
>   
> -	xdf1->dend = (long)xdf1->nrec - i - 1;
> -	xdf2->dend = (long)xdf2->nrec - i - 1;
> +	xe->xdf1.dend = (long)xe->xdf1.nrec - i - 1;
> +	xe->xdf2.dend = (long)xe->xdf2.nrec - i - 1;
>   
>   	return 0;
>   }
> @@ -393,10 +393,10 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>   		xdl_classify_record(2, &cf, rec);
>   	}
>   
> -	xdl_trim_ends(&xe->xdf1, &xe->xdf2);
> +	xdl_trim_ends(xe);
>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>   	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF) &&
> -	    xdl_cleanup_records(&cf, &xe->xdf1, &xe->xdf2) < 0) {
> +	    xdl_cleanup_records(&cf, xe) < 0) {
>   
>   		xdl_free_ctx(&xe->xdf2);
>   		xdl_free_ctx(&xe->xdf1);

