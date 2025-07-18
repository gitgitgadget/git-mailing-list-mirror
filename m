Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32003D984
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845695; cv=none; b=LgrGraA0g02E1J5kWmLcB12NycU7O6wAveHskkzkBqwpK2dk+VtxooNMv1QDL6u9wiJK8u3xX+bkv5q2KFcKhSDVLOtybTMvBhZCGNGqB0VmUmL/XY3XCxK++WkM7KBRAKKac1/oiOiNLp05SDgdYhqO8ITmzi6rZWornlKGWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845695; c=relaxed/simple;
	bh=yQX2m0/q+a+kUilITmIe3M9hBF6j+I49NCqit+Nd/TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD4Gxn3FKFq0lvJAzZlFtquw1y+x6Z2emlIYQJU5jNJfxUz4dwiXdc1seZospIFGa+04qcHBqbmAbttL1U67yZGYhkl3JbHGotVNtuhlWmV+AP7QQQrrPhusmNnCok7TU79vYPu8OiFmqdclSEnKkSzGJbnOk0/rCAglgrK1LDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dse5C7IW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dse5C7IW"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a50956e5d3so1533824f8f.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752845692; x=1753450492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwqPTKimY9ySn/LvTyooIshMTPuVu/0CcXyuALlVSzQ=;
        b=dse5C7IWSVhD5p3Wiz4eMxpqOTDfgPQTkVWDjXigTrG8kZ9x4MDlwiO1csOJ0+1l4V
         psteedNI803oCUd3TTUUNwVo4ZkoA/7YlNI130wmdwuz32wxq3OWJSOBbb2VHQe0tNxr
         HSbOku3uWqJIOc482ZZrYpfH6AMtbkYCIKy6xF+ly2WjSoIwV20AVeVALMQqVF6svb61
         A/dp5v65xNl673M3h3NFworkpbkE30N+uswOimSPGqky7vYj4he40VH+ZSas1JQEKCpY
         110sE3NDfI8hvQYrnWVhkNNVDuctrkYachDDo89+MA/c1A4zaYJfJTfzK9RttcApzWBL
         shQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845692; x=1753450492;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwqPTKimY9ySn/LvTyooIshMTPuVu/0CcXyuALlVSzQ=;
        b=LwZutNfd9kJL8eZyFzCVXpEkV7KxgkVpVSVT3XVoFm2m+Hmc6KcM4CM6q2daf8nptL
         oKlq2LxagMsjpOhlXeuFpAum8WpkNCo7SVPdyemaWMNHOSnQvbs4R2qh/KmlGWPgFUs1
         /d2bNbzR9xumU4qZ0UsfvkYJtufEL25LQk/GNALu4xW5topXNRE3dT/8miCDO1zQ/iHk
         9j6fgoOH6oO/mAOEZucb9CliBx+Qyj4vDlYBKF7qbZleACteaLZeD3in13ev8TUc43iB
         32khuWY7r3fCBWFAA2V6U5UfjCNWEFb5f43Yu4lf793PteicEFFbuTP7k6UOiwM3ht72
         8h3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq/TWD66NF/GaTXaZg9mcGxpVuBP/AK3vdAAOMAW8iy/eUD2fOySTgHgU/jN3bT1IuFdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSThqsVIJ8ekSm048ZI/3u1EZTsLkRzo8E3VYHrOA9UpqtMZK
	4hgPpQZ2bX3+fvpAG1aRY9kFslg+AfP46phRdP4XzELGW6Ib/+69rqWg
X-Gm-Gg: ASbGncugVGhtawUB+u/9B4lZvMqu1bNy8T+LunxtTJ1D5i3a/M0oT/tvNTyHencJsj+
	IEwPER4BRPUxEi8W+KqY1v+kTrMicamPD26o6+yYRSAzC90ZF4BKvwlkl5TMkq3i2WK7+wS4JCK
	SU8dZWX5ZZV5/WpJ0BljM5c2k4SVIRpODL78we7AF+yVhdrpz4eGgz6LYEW6kTvpl0oDzdLPrAs
	Vd9VNfyaaf1ssE9HyXVumCdkib/o9u+p7023xk6XJEN6IfsqKuDxjLHLHJDX/IRuRENHsmSlmAb
	oxJVRmuY3Ub3CC2H6UFCaGGK8nkcu+/EDCJZYw0j9HgfWRHIi5GQqZgIH5/4XWGx/nM0qLLI0yE
	Trupe/KAdyWna8MJKY+Bk8VbAjOJogdrYjXdPnN5VQ0IYQ1IF0AYUmYwYXIfdBeCsvnAC6JGutf
	kOSw9k8jHuXpJoIZ+ilg==
X-Google-Smtp-Source: AGHT+IFMEuZe9mosiEdWbGkg3KijFFu3vNZniV8cmp2Kq6VUB+CxjAwtarhQXsI+CYugUxTNFZJsTw==
X-Received: by 2002:a05:6000:2a83:b0:3a5:2923:8006 with SMTP id ffacd0b85a97d-3b60dd54d6fmr8271625f8f.25.1752845692117;
        Fri, 18 Jul 2025 06:34:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:41df:4602:3bdd:d83b? ([2a0a:ef40:7a5:4701:41df:4602:3bdd:d83b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25459sm1885916f8f.3.2025.07.18.06.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 06:34:51 -0700 (PDT)
Message-ID: <ec15f63f-1ddd-4b10-9c7d-c21d81ead953@gmail.com>
Date: Fri, 18 Jul 2025 14:34:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] xdiff: separate parsing lines from hashing them
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ezekiel Newren
 <ezekielnewren@gmail.com>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <2db30cc739efadf8383bd9dc1b7825ce863e8f5a.1752784344.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <2db30cc739efadf8383bd9dc1b7825ce863e8f5a.1752784344.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> We want to use xxhash for faster hashing. To facilitate that
> and to simplify the code. Separate the concerns of parsing
> and hashing into discrete steps. This makes swapping the hash
> function much easier. Since xdl_hash_record() both parses and
> hashses lines, this requires some slight code restructuring.

That makes sense though unfortunately we seem to have lost some error 
handling in the restructuring. How much does this extra pass over the 
input data slow down the cases that don't end up using xxhash?

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xprepare.c | 75 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 44 insertions(+), 31 deletions(-)
> 
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 747268e4fdf7..c44005e9bbb8 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -129,13 +129,39 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   }
>   
>   
> +static void xdl_parse_lines(mmfile_t *mf, long narec, xdfile_t *xdf) {
> +	u8 const* ptr = (u8 const*) mf->ptr;
> +	usize len = (usize) mf->size;
> +
> +	xdf->recs = NULL;
> +	xdf->nrec = 0;
> +	XDL_ALLOC_ARRAY(xdf->recs, narec);

This should return error if the allocation fails like the original code. 
Although that does not make any difference for git a number of other 
projects such as libgit2 carry a copy of our xdiff code and want to be 
able to handle allocation failures.

> +	while (len > 0) {
> +		xrecord_t *rec = NULL;
> +		usize length;
> +		u8 const* result = memchr(ptr, '\n', len);
> +		if (result) {
> +			length = result - ptr + 1;
> +		} else {
> +			length = len;
> +		}
> +		if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
> +			die("XDL_ALLOC_GROW failed");

We should return an error rather than dying here

> +		rec = xdl_cha_alloc(&xdf->rcha);

We should return an error if the call fails like the original code

> +		rec->ptr = ptr;
> +		rec->size = length;
> +		rec->ha = 0;
> +		xdf->recs[xdf->nrec++] = rec;
> +		ptr += length;
> +		len -= length;
> +	}
> +
> +}
> +
> +
>   static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
>   			   xdlclassifier_t *cf, xdfile_t *xdf) {
> -	long nrec, bsize;
> -	unsigned long hav;
> -	char const *blk, *cur, *top, *prev;
> -	xrecord_t *crec;
> -	xrecord_t **recs;
>   	unsigned long *ha;
>   	char *rchg;
>   	long *rindex;
> @@ -143,50 +169,37 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   	ha = NULL;
>   	rindex = NULL;
>   	rchg = NULL;
> -	recs = NULL;
>   
>   	if (xdl_cha_init(&xdf->rcha, sizeof(xrecord_t), narec / 4 + 1) < 0)
>   		goto abort;
> -	if (!XDL_ALLOC_ARRAY(recs, narec))
> -		goto abort;
>   
> -	nrec = 0;
> -	if ((cur = blk = xdl_mmfile_first(mf, &bsize))) {
> -		for (top = blk + bsize; cur < top; ) {
> -			prev = cur;
> -			hav = xdl_hash_record(&cur, top, xpp->flags);
> -			if (XDL_ALLOC_GROW(recs, nrec + 1, narec))
> -				goto abort;
> -			if (!(crec = xdl_cha_alloc(&xdf->rcha)))
> -				goto abort;
> -			crec->ptr = (u8 const*) prev;
> -			crec->size = (long) (cur - prev);
> -			crec->ha = hav;
> -			recs[nrec++] = crec;
> -			if (xdl_classify_record(pass, cf, crec) < 0)
> -				goto abort;
> -		}
> +	xdl_parse_lines(mf, narec, xdf);
> +
> +	for (usize i = 0; i < (usize) xdf->nrec; i++) {
> +		xrecord_t *rec = xdf->recs[i];
> +		char const* dump = (char const*) rec->ptr;
> +		rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);

I think we should update xdl_hash_record() to stop updating dump and use 
the length from xdl_parse_lines(). Now that we parse the lines before 
hashing we should use that length in the hash function so we have a 
single definition of line length.

> +		xdl_classify_record(pass, cf, rec);

We should return an error if this call fails like the original code

Thanks

Phillip

>   	}
>   
> -	if (!XDL_CALLOC_ARRAY(rchg, nrec + 2))
> +
> +	if (!XDL_CALLOC_ARRAY(rchg, xdf->nrec + 2))
>   		goto abort;
>   
>   	if ((XDF_DIFF_ALG(xpp->flags) != XDF_PATIENCE_DIFF) &&
>   	    (XDF_DIFF_ALG(xpp->flags) != XDF_HISTOGRAM_DIFF)) {
> -		if (!XDL_ALLOC_ARRAY(rindex, nrec + 1))
> +		if (!XDL_ALLOC_ARRAY(rindex, xdf->nrec + 1))
>   			goto abort;
> -		if (!XDL_ALLOC_ARRAY(ha, nrec + 1))
> +		if (!XDL_ALLOC_ARRAY(ha, xdf->nrec + 1))
>   			goto abort;
>   	}
>   
> -	xdf->nrec = nrec;
> -	xdf->recs = recs;
>   	xdf->rchg = rchg + 1;
>   	xdf->rindex = rindex;
>   	xdf->nreff = 0;
>   	xdf->ha = ha;
>   	xdf->dstart = 0;
> -	xdf->dend = nrec - 1;
> +	xdf->dend = xdf->nrec - 1;
>   
>   	return 0;
>   
> @@ -194,7 +207,7 @@ abort:
>   	xdl_free(ha);
>   	xdl_free(rindex);
>   	xdl_free(rchg);
> -	xdl_free(recs);
> +	xdl_free(xdf->recs);
>   	xdl_cha_free(&xdf->rcha);
>   	return -1;
>   }

