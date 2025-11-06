Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196C2DA774
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426151; cv=none; b=jvJp9Xh85Y99o7wIvV1KYXvYVoCUPGz/3C5xOLtYoU3NWfNUBtglL+hIJsL4pCyH046O+9p1mBASkKVXgLyUyPXMlk2jwpthE0SjaqodZZRUSY9cAmCcKbkkbLctR841GegBzi0p66NZovcO3rur8kO+g0SU4aC83+W14TZWyQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426151; c=relaxed/simple;
	bh=W5jAt7rSxzMZtGY4Otz+SMGkb8KMwd3IxIIjNdV9hMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQsrFmhgC6y2+UeiE1tUWyRil7Z9ZGMsRULm65D/6a4O5l+bqSakithMzzYg5SWZab9kD5BLLByJK+lpdrvS9dPbpxucBiw2gCKqng1mhYOQ+x0Fi/7L/7bUeirNQ7VL7AIRj5gPgTnrmD53dTDgDZ4I1uhhNLvj9q3l50QyA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMa93uZS; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMa93uZS"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47114a40161so7987415e9.3
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 02:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762426148; x=1763030948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq/tloacaHOd2ay4jG7ylk5FUm1erncCX/H7eAIMZNs=;
        b=cMa93uZS3Ln2WIQKPQIpEj/TLR77KwE2BkZLe6ZohHKye1ARrT6yUZhscEC2C8Nj9c
         FOATdDk9H4EIhPSaIZrdQgFknLfD8gop7pbe6MJMhMRRYeSzZcchpf0ghSEXvo1rR07s
         4wyfOwUCLXsCOHtsMNhzqWM/l6LEa5HKu0vLT750UmzgZ9rguRp8t8JsQ+BKuhGODGSH
         N8kkBcCB5Lcr+olyKSS0AyHISv6pflgsWFLTHWb+8sUCVccKm1Ys9XM5fmT5OWVGKKAf
         Wl+XOeALbvvMbX4fI0ocRQyV8JiNE9xap/lk/jYg7kc5LxI3IwAB1s5nr4hBP0gAX8U4
         2mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426148; x=1763030948;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tq/tloacaHOd2ay4jG7ylk5FUm1erncCX/H7eAIMZNs=;
        b=CXbBNLnp40sTfKOOV50wokkb/N1ENxitwhfH4/tQt8jVGv7iVhNQxJoqcDjbf6NqZJ
         avTzvfbN/KB9nvHf6fBAkL37+0Mz4UxUKiuiFcyz7i/7yWpobT9Nt275OcCcJAmaD5SS
         Ncg3oRCGBlTx7HexWFeC0xHGGIX3yaset7Clpxdk6dLudrVw/whKIwjCs3PCQik8TnO4
         ouFYNkNTW8hpI5jGo117fxTnytWeyacNsyKwACzqHiXiucEdfMwt91xv+MK3l+zVe8B1
         zeAjAfdDYs7ym+SZ33Q9yw5n2e7YmpRjC8MVwAa3bsY+S3+MOsUwNYddr2OET5eSoOz9
         2jag==
X-Forwarded-Encrypted: i=1; AJvYcCXkBDT7x4p00OnIp2cSm1gFbmsEm4wNca25SRO85oI7/1A4/dr0EfbkunCI0MpDVjXSL08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpaUJBfa2CucmTiu10waE0tIzxJv6ZsiTRiK24Q6kLqV2g2cdz
	72Lh04zKgu7RUDKovq0wHYBbcgKrJ9WuoUn2Wp0xomfbOY+lebgjoeQ1LYhYLA==
X-Gm-Gg: ASbGncsX9Zk5kJK3STjR+4uE2714mWjkL4s0/OvkvfAwPwu/qBn3JGzEDV6Kut8DJdD
	sjjj+vDUEMZ0uedGlFU00Sr0dkp1ckTroPKNrfNgQffs7Vn3u2+ElzUPK/cmw/FRclKRyuwXEIJ
	pxXfbya+kDgZSQEIbTNnLs0A0jLLgcEQPDDYsAkAMPV1QrfkdxoEjted2Q4euIflQnKsicr7NB9
	G7bg7lm1/TsPVLn7ltdRWahxY3pZl8prulp72mO2MOkJzgjQEvGsRNAQ1IvBYN4ZldMKK0nG+Mz
	LqiaMX+fOgv0yb9RBwgHhAlZaEP3Y/loe82VHUp1utKtQ44EqREtMG2zICmGf5eo/T2fe55HbFx
	PiY6Z0YurfdhRcmVF6opiSd/ml4nJws4AgkUtTPznexyu2TEKNe0F590cxvQ/KiQHk6i8BKAiAK
	rd3+gNxqKoxjPSV/3rvuCbM3WyFhwjpjXjdEp1M+kLAuuy4R10Q7ttFCkP255hH0RG6dYNE3IRs
	zlK
X-Google-Smtp-Source: AGHT+IGWcdzaaSpExyaZgCUv4iYci86PP5LGy/qn97ioxEOAO+qghXflqnhte95OE6vMLt4HChQtcw==
X-Received: by 2002:a05:600c:621a:b0:471:14f5:126f with SMTP id 5b1f17b1804b1-4775ce206f3mr51434725e9.33.1762426147831;
        Thu, 06 Nov 2025 02:49:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:7b5:6701:5a25:209b:be41:f23f? ([2a0a:ef40:7b5:6701:5a25:209b:be41:f23f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ec767edasm3551821f8f.43.2025.11.06.02.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:49:07 -0800 (PST)
Message-ID: <299e25d6-caaf-4672-8160-53fdafe96134@gmail.com>
Date: Thu, 6 Nov 2025 10:49:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] xdiff: make xrecord_t.ptr a uint8_t instead of
 char
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.git.git.1760563101.gitgitgadget@gmail.com>
 <pull.2070.v2.git.git.1761776388.gitgitgadget@gmail.com>
 <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <46bc1b3e25885fbd324a6428ee7ac3b5d272c4ce.1761776388.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 29/10/2025 22:19, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Rust uses u8 to refer to bytes in memory. Since xrecord_t.ptr is also
> referring to bytes in memory, rather than Unicode code points, use
> uint8_t instead of char.

The reference to unicode code points here still makes no sense to me. I 
thought the reason for the conversion was to match rust's u8.

> Every usage of this field was inspected and cast to char*, or similar,
> to avoid signedness warnings/errors from the compiler. Casting was used
> so that the whole of xdiff doesn't need to be refactored in order to
> change the type of this field.

Thanks for adding this. Having played a little with changing some 
function parameters to avoid adding these casts I agree this patch is a 
good place to stop as the number of changes required quickly spiraled 
out of control.

Thanks

Phillip

> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>   xdiff/xdiffi.c    |  8 ++++----
>   xdiff/xemit.c     |  6 +++---
>   xdiff/xmerge.c    | 14 +++++++-------
>   xdiff/xpatience.c |  2 +-
>   xdiff/xprepare.c  |  8 ++++----
>   xdiff/xtypes.h    |  2 +-
>   xdiff/xutils.c    |  4 ++--
>   7 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 6f3998ee54..411a8aa69f 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -407,7 +407,7 @@ static int get_indent(xrecord_t *rec)
>   	int ret = 0;
>   
>   	for (i = 0; i < rec->size; i++) {
> -		char c = rec->ptr[i];
> +		uint8_t c = rec->ptr[i];
>   
>   		if (!XDL_ISSPACE(c))
>   			return ret;
> @@ -993,11 +993,11 @@ static void xdl_mark_ignorable_lines(xdchange_t *xscr, xdfenv_t *xe, long flags)
>   
>   		rec = &xe->xdf1.recs[xch->i1];
>   		for (i = 0; i < xch->chg1 && ignore; i++)
> -			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
> +			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
>   
>   		rec = &xe->xdf2.recs[xch->i2];
>   		for (i = 0; i < xch->chg2 && ignore; i++)
> -			ignore = xdl_blankline(rec[i].ptr, rec[i].size, flags);
> +			ignore = xdl_blankline((const char *)rec[i].ptr, rec[i].size, flags);
>   
>   		xch->ignore = ignore;
>   	}
> @@ -1008,7 +1008,7 @@ static int record_matches_regex(xrecord_t *rec, xpparam_t const *xpp) {
>   	size_t i;
>   
>   	for (i = 0; i < xpp->ignore_regex_nr; i++)
> -		if (!regexec_buf(xpp->ignore_regex[i], rec->ptr, rec->size, 1,
> +		if (!regexec_buf(xpp->ignore_regex[i], (const char *)rec->ptr, rec->size, 1,
>   				 &regmatch, 0))
>   			return 1;
>   
> diff --git a/xdiff/xemit.c b/xdiff/xemit.c
> index b2f1f30cd3..ead930088a 100644
> --- a/xdiff/xemit.c
> +++ b/xdiff/xemit.c
> @@ -27,7 +27,7 @@ static int xdl_emit_record(xdfile_t *xdf, long ri, char const *pre, xdemitcb_t *
>   {
>   	xrecord_t *rec = &xdf->recs[ri];
>   
> -	if (xdl_emit_diffrec(rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
> +	if (xdl_emit_diffrec((char const *)rec->ptr, rec->size, pre, strlen(pre), ecb) < 0)
>   		return -1;
>   
>   	return 0;
> @@ -113,8 +113,8 @@ static long match_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri,
>   	xrecord_t *rec = &xdf->recs[ri];
>   
>   	if (!xecfg->find_func)
> -		return def_ff(rec->ptr, rec->size, buf, sz);
> -	return xecfg->find_func(rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
> +		return def_ff((const char *)rec->ptr, rec->size, buf, sz);
> +	return xecfg->find_func((const char *)rec->ptr, rec->size, buf, sz, xecfg->find_func_priv);
>   }
>   
>   static int is_func_rec(xdfile_t *xdf, xdemitconf_t const *xecfg, long ri)
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index fd600cbb5d..75cb3e76a2 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -101,8 +101,8 @@ static int xdl_merge_cmp_lines(xdfenv_t *xe1, int i1, xdfenv_t *xe2, int i2,
>   	xrecord_t *rec2 = xe2->xdf2.recs + i2;
>   
>   	for (i = 0; i < line_count; i++) {
> -		int result = xdl_recmatch(rec1[i].ptr, rec1[i].size,
> -			rec2[i].ptr, rec2[i].size, flags);
> +		int result = xdl_recmatch((const char *)rec1[i].ptr, rec1[i].size,
> +			(const char *)rec2[i].ptr, rec2[i].size, flags);
>   		if (!result)
>   			return -1;
>   	}
> @@ -324,8 +324,8 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>   
>   static int recmatch(xrecord_t *rec1, xrecord_t *rec2, unsigned long flags)
>   {
> -	return xdl_recmatch(rec1->ptr, rec1->size,
> -			    rec2->ptr, rec2->size, flags);
> +	return xdl_recmatch((const char *)rec1->ptr, rec1->size,
> +			    (const char *)rec2->ptr, rec2->size, flags);
>   }
>   
>   /*
> @@ -382,10 +382,10 @@ static int xdl_refine_conflicts(xdfenv_t *xe1, xdfenv_t *xe2, xdmerge_t *m,
>   		 * we have a very simple mmfile structure.
>   		 */
>   		t1.ptr = (char *)xe1->xdf2.recs[m->i1].ptr;
> -		t1.size = xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
> +		t1.size = (char *)xe1->xdf2.recs[m->i1 + m->chg1 - 1].ptr
>   			+ xe1->xdf2.recs[m->i1 + m->chg1 - 1].size - t1.ptr;
>   		t2.ptr = (char *)xe2->xdf2.recs[m->i2].ptr;
> -		t2.size = xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
> +		t2.size = (char *)xe2->xdf2.recs[m->i2 + m->chg2 - 1].ptr
>   			+ xe2->xdf2.recs[m->i2 + m->chg2 - 1].size - t2.ptr;
>   		if (xdl_do_diff(&t1, &t2, xpp, &xe) < 0)
>   			return -1;
> @@ -440,7 +440,7 @@ static int line_contains_alnum(const char *ptr, long size)
>   static int lines_contain_alnum(xdfenv_t *xe, int i, int chg)
>   {
>   	for (; chg; chg--, i++)
> -		if (line_contains_alnum(xe->xdf2.recs[i].ptr,
> +		if (line_contains_alnum((const char *)xe->xdf2.recs[i].ptr,
>   				xe->xdf2.recs[i].size))
>   			return 1;
>   	return 0;
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 669b653580..bb61354f22 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -121,7 +121,7 @@ static void insert_record(xpparam_t const *xpp, int line, struct hashmap *map,
>   		return;
>   	map->entries[index].line1 = line;
>   	map->entries[index].hash = record->ha;
> -	map->entries[index].anchor = is_anchor(xpp, map->env->xdf1.recs[line - 1].ptr);
> +	map->entries[index].anchor = is_anchor(xpp, (const char *)map->env->xdf1.recs[line - 1].ptr);
>   	if (!map->first)
>   		map->first = map->entries + index;
>   	if (map->last) {
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 192334f1b7..4cb18b2b88 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -99,8 +99,8 @@ static int xdl_classify_record(unsigned int pass, xdlclassifier_t *cf, xrecord_t
>   	hi = (long) XDL_HASHLONG(rec->ha, cf->hbits);
>   	for (rcrec = cf->rchash[hi]; rcrec; rcrec = rcrec->next)
>   		if (rcrec->rec.ha == rec->ha &&
> -				xdl_recmatch(rcrec->rec.ptr, rcrec->rec.size,
> -					rec->ptr, rec->size, cf->flags))
> +				xdl_recmatch((const char *)rcrec->rec.ptr, rcrec->rec.size,
> +					(const char *)rec->ptr, rec->size, cf->flags))
>   			break;
>   
>   	if (!rcrec) {
> @@ -156,8 +156,8 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>   			if (XDL_ALLOC_GROW(xdf->recs, xdf->nrec + 1, narec))
>   				goto abort;
>   			crec = &xdf->recs[xdf->nrec++];
> -			crec->ptr = prev;
> -			crec->size = (long) (cur - prev);
> +			crec->ptr = (uint8_t const *)prev;
> +			crec->size =(long) ( cur - prev);
>   			crec->ha = hav;
>   			if (xdl_classify_record(pass, cf, crec) < 0)
>   				goto abort;
> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
> index 7c8c057bca..b1c520a378 100644
> --- a/xdiff/xtypes.h
> +++ b/xdiff/xtypes.h
> @@ -39,7 +39,7 @@ typedef struct s_chastore {
>   } chastore_t;
>   
>   typedef struct s_xrecord {
> -	char const *ptr;
> +	uint8_t const *ptr;
>   	long size;
>   	unsigned long ha;
>   } xrecord_t;
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 447e66c719..7be063bfb6 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -465,10 +465,10 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t const *xpp,
>   	xdfenv_t env;
>   
>   	subfile1.ptr = (char *)diff_env->xdf1.recs[line1 - 1].ptr;
> -	subfile1.size = diff_env->xdf1.recs[line1 + count1 - 2].ptr +
> +	subfile1.size = (char *)diff_env->xdf1.recs[line1 + count1 - 2].ptr +
>   		diff_env->xdf1.recs[line1 + count1 - 2].size - subfile1.ptr;
>   	subfile2.ptr = (char *)diff_env->xdf2.recs[line2 - 1].ptr;
> -	subfile2.size = diff_env->xdf2.recs[line2 + count2 - 2].ptr +
> +	subfile2.size = (char *)diff_env->xdf2.recs[line2 + count2 - 2].ptr +
>   		diff_env->xdf2.recs[line2 + count2 - 2].size - subfile2.ptr;
>   	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>   		return -1;

