Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056130E848
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926766; cv=none; b=p7KEo3PJEFegMLBvAv3VGQSu4ytk9i0zqxlzlBohTHYGX0+JMahkuhxOta4k5MDjvu3tc/+4Z1eQIm2S2Nl9Fv9JkBRlQEVwb/vu6J6ZQJBi6SxXwHQpLnKIDgTjpb6craOkHvXj9SyZF4gijM/GMUN/ms5fvZMcqap8jS3c28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926766; c=relaxed/simple;
	bh=ExyXKuznZqExYob9ITwWqPlEhmYThd5A0y4iv2nMa9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HvCbiUdzAq/bpgFvXQCCWku/govvyUW33EmPWFUvTPe1uJSc4KDI34esZzBRcXmvjXrmWyVDzsTVvKuVubKlUED3nM9fh2jsjIf6VrFzAkyVU3lO4kQoJFkKrzJVlxBaXlrgcgQlqglxg2shsYig9+UoNDNC1OEq/2uGjnhSNZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUj7oCeY; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUj7oCeY"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee2715254so26290545e9.3
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 08:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768926763; x=1769531563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TKbYgWY6weBcY9aO49SL+kneu3dy65gwkzvt5Q8mPO0=;
        b=aUj7oCeYy2NTH9EyRgtTn9lUHW3171E+tSy05KLHaKxXVIINoUu2zvWi98zjIOKA7s
         Q83OK4+udyvkR2GmTZiA7sEy9NTTX0VfNgWgMkk0dj8ruYnYfnVSPxkUQ/w7uxThNHnU
         3UjQ4wwTJHoIkE+Hx1jMGFy7JqSMS8gW389I/hW2NY54Pasc03wgyoOgvMwWnYPQmG1C
         2axC154KMpgHMWxmEIt8J9A8gC552+Xvc57xJPEpAXN0VnwJlNQKXyLDiuc87wF5aWa3
         CwsB8upBw+pM7mmH7Sj0oX/HmWaPJ+3aJXCTAu0Ne87HWdoiKJFmYeY3YPiyJO9VoqEg
         v1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768926763; x=1769531563;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKbYgWY6weBcY9aO49SL+kneu3dy65gwkzvt5Q8mPO0=;
        b=TMUFYIGt4RwRH+XTSnjCMTzMuGHVWb/Y3q5r5wCEMT1H9yqyYumc7tXGSJNYwRJzxz
         8xXIrys1IO90ot+6yRR8yvpr3tzECJQn3nRAiEdmGt6HQ42j114nuBv1W88/XmRxGmBS
         nfKA9Wv0MBtuXFdGXUqnwUee/i8j9ql5hZLCADDt/28p0q5d1S4M0Zi15WjIadAw/Ouw
         4Xn5IwJiprrTR0ZLXpSuM0lJmD5cOhUyox8QqCzVpv8O9vc9L1kNslXhbPdsTLyvlTme
         tZN07rFx4jNkV046VEfmfunBzkaeFhBfLOMMQ8mC6fUv7TONoadcYCU74lfFGCWndyxG
         NFvg==
X-Forwarded-Encrypted: i=1; AJvYcCVMtK1MbJcy/iH11/Q6sQWDzdPqeHhTPcGk4F83+uTjW8Oirj+YlSkrmpnnvSr2+1LGq9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIvJ9E65GoKzTDsJQ+X+66hmOOLb5KKTj8vIdEavvfDTGTQT9n
	yo9oh28KK/JCVhcpSlaIQ/Q5MImx7/pKlKX9BJABHIhjTLfX04Kb/jvd
X-Gm-Gg: AY/fxX62Q4WujLbYkj25FwItQi2fHLtsxIwI3nFj++4Q/Dlz/VqUkoA+/6Iv8wYr1Bi
	EIfM51b+K3cSrlwOW0MpurVEJZRTCrhf4oJM5q5FcD1FG7gCsru5qLqW8vRruLRX4HorAFT2RKC
	COH+uHOcQcihiEwS3tVJO8yV4t2OfSkh/HODpxF8gLVFpOaqLALTSqHEHoh4+fcRl+InVO2zWFJ
	AG4EdvNXplNqZMhKhOTsRLJAbyvYcSamwCi601jQU/zsD6wb2vAdH8txNXOZbxDQvMitOI5wbu2
	Hv0Mpf2KOHfiZTFux0LeBpj1T0XNHeQVa8BRUqpbVqomhtRc6CDHZqS2czu7/6AfoM2XcV29LHn
	6CTm+1aM58o1LFm7ppkj+oAf6GuK82S9fx52bt98i1pONe9HUpbeOlMT2JSR44+3qxy0wiZTwN1
	TRybV810SbL1eOKh1+iVCMbb55JzZUFhDPZE3QPU9iPCswXdjBmVzkxXKurQNicH5MJ+zpo5u06
	/8m
X-Received: by 2002:a05:600c:1990:b0:480:3b26:82c3 with SMTP id 5b1f17b1804b1-4803e7e819dmr32945185e9.20.1768926762995;
        Tue, 20 Jan 2026 08:32:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm318504355e9.5.2026.01.20.08.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 08:32:42 -0800 (PST)
Message-ID: <2b6592f6-1d20-4cdd-8af7-f524920ad1a7@gmail.com>
Date: Tue, 20 Jan 2026 16:32:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 06/10] xdiff: cleanup xdl_trim_ends()
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <65da408da9589420ec341368d0853e6183aee922.1767379944.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <65da408da9589420ec341368d0853e6183aee922.1767379944.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> This patch is best viewed with a before and after of the whole
> function.
> 
> Rather than using 2 pointers and walking them. Use direct indexing with
> local variables of what is being compared to make it easier to follow
> along.

I think using direct indexing makes things clearer, but I'm not sure 
this is a faithful conversion (see below).

> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 0acb3437d4..06b6a6f804 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -340,29 +340,29 @@ cleanup:
>   /*
>    * Early trim initial and terminal matching records.
>    */
> -static int xdl_trim_ends(xdfenv_t *xe) {
> -	long i, lim;
> -	xrecord_t *recs1, *recs2;
> -
> -	recs1 = xe->xdf1.recs;
> -	recs2 = xe->xdf2.recs;
> -	for (i = 0, lim = (long)XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec); i < lim;
> -	     i++, recs1++, recs2++)
> -		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
> +static void xdl_trim_ends(xdfenv_t *xe)
> +{
> +	size_t lim = XDL_MIN(xe->xdf1.nrec, xe->xdf2.nrec);
> +
> +	for (size_t i = 0; i < lim; i++) {
> +		size_t mph1 = xe->xdf1.recs[i].minimal_perfect_hash;
> +		size_t mph2 = xe->xdf2.recs[i].minimal_perfect_hash;
> +		if (mph1 != mph2) {
> +			xe->xdf1.dstart = xe->xdf2.dstart = (ssize_t)i;

The type of dstart is ptrdiff_t, not ssize_t.

The original set dstart and dend unconditionally but here they are not 
set if all the lines match.

Thanks

Phillip

> +			lim -= i;
>   			break;
> +		}
> +	}
>   
> -	xe->xdf1.dstart = xe->xdf2.dstart = i;
> -
> -	recs1 = xe->xdf1.recs + xe->xdf1.nrec - 1;
> -	recs2 = xe->xdf2.recs + xe->xdf2.nrec - 1;
> -	for (lim -= i, i = 0; i < lim; i++, recs1--, recs2--)
> -		if (recs1->minimal_perfect_hash != recs2->minimal_perfect_hash)
> +	for (size_t i = 0; i < lim; i++) {
> +		size_t mph1 = xe->xdf1.recs[xe->xdf1.nrec - 1 - i].minimal_perfect_hash;
> +		size_t mph2 = xe->xdf2.recs[xe->xdf2.nrec - 1 - i].minimal_perfect_hash;
> +		if (mph1 != mph2) {
> +			xe->xdf1.dend = xe->xdf1.nrec - 1 - i;
> +			xe->xdf2.dend = xe->xdf2.nrec - 1 - i;
>   			break;
> -
> -	xe->xdf1.dend = (long)xe->xdf1.nrec - i - 1;
> -	xe->xdf2.dend = (long)xe->xdf2.nrec - i - 1;
> -
> -	return 0;
> +		}
> +	}
>   }
>   
>   

