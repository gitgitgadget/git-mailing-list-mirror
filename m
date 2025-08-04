Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B65914A4CC
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754315390; cv=none; b=PBMukdZSWBzfiS93x1O72d0ebq6W33Mk9H/p3h8n2uq3HAhE6FG5Qk/NlZHN6XXRmMpRFh89n7WHah83x3/dy8hX+mGyFN8CpM/oFJOJ1n2Vzy3AiSAlCD4G+7zo2yC8U4Yh+BI4uV1Bac7sWtgnxtGNB30nbsa8j5BUTiISN90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754315390; c=relaxed/simple;
	bh=IxJoM4RkFlwVSuSCLkjJSQwkEljI2aQycH8kzYohR9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOIzVOMGbGiWPZMi0FYtK6QB/YN69cryELipIDPex2ZXWo9IeJ36bP7A5JuIqV41vd+Utty+HlkwirypGckfzeDXA/F33ZwcbUdwWeZIMGMICTNEEmJysp2DBlvNIQE4HuQNWbiH6BPt/+9+051RjCZJ9RBWtjl0I9PZxHBLASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD2M7fNy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD2M7fNy"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso2623305f8f.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754315386; x=1754920186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=anAxMy9i8H3uFjixZ1HM2KlhtHnBmx7jkt39bpDQGmI=;
        b=PD2M7fNyR9c1YrejyUoCGmW4K/9ynMDeH09wiWQsDkqtx/yUiOIrmpJzBmT9Q7Xrf5
         wYFnY9xSy9R90KUABiZpjvCc7iRn5RfnG5iretTBuek8gghWC+w87rVt1zC7NUIYS3dL
         2cyAAoXg5xzMWDRYZMiDFNZIsmSl9OS1K/Z6EtEoT63UHr48k5sLTnw/lwT90iruYd1E
         2O05EWLfNli3E4RAeJLwnL+4IsEqc6Y2U3Ar2Z/RCsuePzJlsKUlQNnm3BMx71TvOa3M
         Q6Omv0zQ2gOs8kh42IFInIRpHEMB3TFXLOLmy8P5I5/pTzXF3sxJs/SKqsbFJmXgF+ZF
         AQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754315386; x=1754920186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=anAxMy9i8H3uFjixZ1HM2KlhtHnBmx7jkt39bpDQGmI=;
        b=Ml4IqTfP2oUkmj8RLCJ1XcjXgTfj2/lYu7GfJCJfuW2MboYZ79g6Xrg5EDbyUp9CxC
         n7NiYqktxMzmChSoqwR55AnMO6/12us3+nMHywP/Q/l1m6Qdh/PzgB0xsB7LygNsn4DQ
         dxY+ZdMlzEkL7pu5OqYsIPHSn8g5fgUrpQJ/21BLqgF0o73YcRFMauxlNs9RmdNg7k8z
         RrNCC2Kmxogub0GYc8MsMU2YupCq46BK1QR0H5Vpc+gw/nfbN+6RHtvinl/xvqbPO3QO
         I0R5DMhcW7ysIhqWoheOZtq5zQLo6xPSNF88tvV0T9moPY18EQaGlqNNpzIASPhND9wG
         lhBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeifQhpHzM+lbvuzB5LWOB4GPwlbS+tcv0hz4iAZNGvPH/BPoxScPRD+SPYC+MCqfY3CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhO8jRCDeInFGvL8ZhBYU5b9ZL4eAiTItGfv1IihbmD6Gk15eG
	MeQIE02Ew5uD5iwI1ti4P4pCqgM1JnLVyU0dh3mJ7+JE4nWehj8J3XuKbqjZfQ==
X-Gm-Gg: ASbGnctr/QXznSAZQbtjptiDAAVvqc7CsN7xD8+dQngHFaJv6PsK26DBFvRmfxZxLxn
	dYqK7M+AE7c9dZ6z7KKSehV6hUmEMVbTlyqKQMe6b2LGi7GBbjSZpZGW44/PH4eNoHnwq5wqbKq
	DDsF2rVF9IZDzfSU6lsF/ifPaFEomE5CDSjCfU9qP0hBV5WXKkxp6fbs7iSz66oINfpgwN8BgWS
	uOXk4LkKxQPmomNw8LNdYNe3jhOaJFu36FXsTEjz6rplgSMit4BDFF3JL1G5nu3SXr6Q9voaFB2
	WLO8h89PvOw3c0tAuwcDUEkumO2ndgDYGCKwmgooAAV7u/9EmetoSrA4pbu1lbYCHG/EHwc7NFu
	XKZxiERDmbU9Mb30De2yee6lv9ZOT0r2/0KEyLP3NLtXyc6AbLcHQWdidPkTxATSpNIiuBxKuHI
	4K
X-Google-Smtp-Source: AGHT+IEoC4NJrH/+FhrQ0BjyydYtHtYgKM7TzE9imN80AePlbMqjmVTB/CElRAXunWoJsuT+gc40cg==
X-Received: by 2002:a05:6000:288b:b0:3a4:ee40:715c with SMTP id ffacd0b85a97d-3b8d94747camr8596934f8f.14.1754315385913;
        Mon, 04 Aug 2025 06:49:45 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm16243910f8f.8.2025.08.04.06.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 06:49:45 -0700 (PDT)
Message-ID: <aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
Date: Mon, 4 Aug 2025 14:49:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
To: Alexander Monakov <amonakov@ispras.ru>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250728190520.10962-1-amonakov@ispras.ru>
 <20250728190520.10962-3-amonakov@ispras.ru>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250728190520.10962-3-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexander

On 28/07/2025 20:05, Alexander Monakov wrote:
> xdl_hash_record_verbatim uses modified djb2 hash with XOR instead of ADD
> for combining. The ADD-based variant is used as the basis of the modern
> ("GNU") symbol lookup scheme in ELF. Glibc dynamic loader received an
> optimized version of this hash function thanks to Noah Goldstein [1].

Interesting

> Switch xdl_hash_record_verbatim to additive hashing and implement
> an optimized loop following the scheme suggested by Noah.
> 
> Timing 'git log --oneline --shortstat v2.0.0..v2.5.0' under perf, I got
> 
> version | cycles, bn | instructions, bn
> ---------------------------------------
> A         6.38         11.3
> B         6.21         10.89
> C         5.80          9.95
> D         5.83          8.74
> ---------------------------------------
> 
> A: baseline (git master at e4ef0485fd78)
> B: plus 'xdiff: refactor xdl_hash_record()'
> C: and plus this patch
> D: with 'xdiff: use xxhash' by Phillip Wood

I think it would be helpful to say that B is the previous patch and 
provide a link for D.
> The resulting speedup for xdl_hash_record_verbatim itself is about 1.5x.

While that's interesting it does not tell us how much this speeds up 
diff generation. Running the command above under hyperfine it is 1.02 ± 
0.01 times faster than the previous patch and 1.11 ± 0.01 times faster 
than master. Using xxhash (D above) is 1.03 ± 0.01 times faster than 
this patch. How do the changes below affect compilers other than gcc and 
clang than do not see the re-association barrier? We'd want to make sure 
that it does not result in slower diffs. Can we use 
atomic_signal_fence() on compilers that support C11? (we don't require 
C11 so we'd have to make it optional but it is supported by things like 
MSVC)

Thanks

Phillip
> 
> [1] https://inbox.sourceware.org/libc-alpha/20220519221803.57957-6-goldstein.w.n@gmail.com/
> 
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
>   xdiff/xutils.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 55 insertions(+), 4 deletions(-)
> 
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index e070ed649f..b1f8273f0f 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -294,16 +294,67 @@ unsigned long xdl_hash_record_with_whitespace(char const **data,
>   	return ha;
>   }
>   
> +/*
> + * Compiler reassociation barrier: pretend to modify X and Y to disallow
> + * changing evaluation order with respect to following uses of X and Y.
> + */
> +#ifdef __GNUC__
> +#define REASSOC_FENCE(x, y) asm("" : "+r"(x), "+r"(y))
> +#else
> +#define REASSOC_FENCE(x, y)
> +#endif
> +
>   unsigned long xdl_hash_record_verbatim(char const **data, char const *top) {
> -	unsigned long ha = 5381;
> +	unsigned long ha = 5381, c0, c1;
>   	char const *ptr = *data;
> -
> +#if 0
> +	/*
> +	 * The baseline form of the optimized loop below. This is the djb2
> +	 * hash (the above function uses a variant with XOR instead of ADD).
> +	 */
>   	for (; ptr < top && *ptr != '\n'; ptr++) {
>   		ha += (ha << 5);
> -		ha ^= (unsigned long) *ptr;
> +		ha += (unsigned long) *ptr;
>   	}
>   	*data = ptr < top ? ptr + 1: ptr;
> -
> +#else
> +	/* Process two characters per iteration. */
> +	if (top - ptr >= 2) do {
> +		if ((c0 = ptr[0]) == '\n') {
> +			*data = ptr + 1;
> +			return ha;
> +		}
> +		if ((c1 = ptr[1]) == '\n') {
> +			*data = ptr + 2;
> +			c0 += ha;
> +			REASSOC_FENCE(c0, ha);
> +			ha = ha * 32 + c0;
> +			return ha;
> +		}
> +		/*
> +		 * Combine characters C0 and C1 into the hash HA. We have
> +		 * HA = (HA * 33 + C0) * 33 + C1, and we want to ensure
> +		 * that dependency chain over HA is just one multiplication
> +		 * and one addition, i.e. we want to evaluate this as
> +		 * HA = HA * 33 * 33 + (C0 * 33 + C1), and likewise prefer
> +		 * (C0 * 32 + (C0 + C1)) for the expression in parenthesis.
> +		 */
> +		ha *= 33 * 33;
> +		c1 += c0;
> +		REASSOC_FENCE(c1, c0);
> +		c1 += c0 * 32;
> +		REASSOC_FENCE(c1, ha);
> +		ha += c1;
> +
> +		ptr += 2;
> +	} while (ptr < top - 1);
> +	*data = top;
> +	if (ptr < top && (c0 = ptr[0]) != '\n') {
> +		c0 += ha;
> +		REASSOC_FENCE(c0, ha);
> +		ha = ha * 32 + c0;
> +	}
> +#endif
>   	return ha;
>   }
>   

