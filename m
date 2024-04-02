Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693F15ADA5
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076497; cv=none; b=aDN6Jd52phGOhjZFsz3qx7MNGhNfxy2XtfvHAK8DqO4BhAZA9S6obRVnMVs+TwFm7V1NbvZ44FNbl0IVF1fg/S4NwtKUrb788XxC3/8hZw6fc5pPMCH9OvYx6/y+e/cgnSzMQxwSEdSELzccrWm9Mb5Rm1ZYee09CzsRA8nfHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076497; c=relaxed/simple;
	bh=B2nKsMM9fvUfKr0jljhAPk/1T5O18fHevQ/f0r4wcyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5VHziahiE6vEWJqa/kTph0sksPRkfuM6DMuX2S/HzNEbLG8TiU4+Je76BOg5Hm4AHySv4DXaVBmKSqsiIPq7FrBY+eWmyw2t3XaOXdBMlL7PcvFWnpxAeyZ5Ou/jwQNRhaQ9CpzMbswuNh3ka4iXzQhfpAt4XnmBSE/PfrRauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSvvoGhM; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSvvoGhM"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a58009fe88so3311680eaf.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076494; x=1712681294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC4hUsr02N7Krr/MzcmuUWb7wcwZ2tu0GjTetWBoSHM=;
        b=kSvvoGhM5uyjQhnd+ZhB1mVgNTaWwJ/VAB3UhhDz61kPIkb43qQRflOGngpbSNx4/k
         Pa6alnGM6E5eBt8y5Fzl3rldd/0QmY2esiZdSEwVUkmn9txonkKZ8zv4ERtWr4zWRNML
         4HZygTiOJk4Ttk06pjLaFJXqgNZmem842hwcRvz620WrAYkE9YiyLrVIkc9RN9hRhBJM
         E/QWPthLIa+zhEQ6vaNOF9wlan6EStQSrgZVTNiFkj/iD5rc5hcq38EaT/cx+Vdy3wmn
         BnxSBh5ongGlsh1AxU3YJErnX7vfp3BrLkn1QBZtmmqVPEkWfn6gpW1VUs3Muv0zyF41
         cA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076494; x=1712681294;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HC4hUsr02N7Krr/MzcmuUWb7wcwZ2tu0GjTetWBoSHM=;
        b=hH5CHBoG6CH6cQmcW/X1K7yS74mIYk/Tqr/x3JBVfmat0cBtIRkcoMwd87ME9evK+0
         lusB8h7UAxAEIxrSTb3oy9YvDmHtNizG3DSthTVODKo1ml57KuynRwT/I0Ml62fywxlw
         PrMEGsYKFF+3dkJtnAYnXFRcpcyNCfPDPOfpVvn9jhWDZ3hzlWN/DQ9h+q6gmtXmtA4q
         tccOy7jniIxBAqDNGQADBCJvwAaloJx8TTVZsrCcigoGKMppVgEh54/OuZjgfyRfzz+U
         geDc7F6nidnKnFcyjBAhkgeS8GCDhnRX4Dnr+SXggDXXjDy/2yILnOXgu/HZAS914Uyo
         p+Sg==
X-Gm-Message-State: AOJu0YwBmLP1m/POAwsHLXiCdp0vpShW1dkM2zotHfrb0YihrBUvfF9q
	RIJw7g2jnCQX6hMoG45ijbXQFd6HVbn7QXhgeWvCIQ52FbaW3xthVvjWxXiF
X-Google-Smtp-Source: AGHT+IEPvQ0HyO5WofVhapK0BxrkhQsuPMNcJdXCE3qCrW2CyTW1iSkZ6htihBszp5fZKsM0WQYsmQ==
X-Received: by 2002:a05:6820:3103:b0:5a4:852f:4c08 with SMTP id ev3-20020a056820310300b005a4852f4c08mr2705254oob.4.1712076494555;
        Tue, 02 Apr 2024 09:48:14 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id r1-20020a4aad01000000b005a5521a2c0dsm2799568oon.44.2024.04.02.09.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:48:14 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:47:16 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] reftable/block: avoid decoding keys when
 searching restart points
Message-ID: <eiyd2nmwxjaetkux4prwm6adcx7z77ry3wc62art6gnfklvgmw@hox32vwuu5sj>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <e751b3c536ace78f975b7d2553c22dbf6845a8d4.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e751b3c536ace78f975b7d2553c22dbf6845a8d4.1711361340.git.ps@pks.im>

On 24/03/25 11:11AM, Patrick Steinhardt wrote:
> When searching over restart points in a block we decode the key of each
> of the records, which results in a memory allocation. This is quite
> pointless though given that records it restart points will never use
> prefix compression and thus store their keys verbatim in the block.
> 
> Refactor the code so that we can avoid decoding the keys, which saves us
> some allocations.

Out of curiousity, do you have any benchmarks around this change and
would that be something we would want to add to the commit message?

-Justin

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/reftable/block.c b/reftable/block.c
> index ca80a05e21..8bb4e43cec 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -287,23 +287,32 @@ static int restart_needle_less(size_t idx, void *_args)
>  		.buf = args->reader->block.data + off,
>  		.len = args->reader->block_len - off,
>  	};
> -	struct strbuf kth_restart_key = STRBUF_INIT;
> -	uint8_t unused_extra;
> -	int result, n;
> +	uint64_t prefix_len, suffix_len;
> +	uint8_t extra;
> +	int n;
>  
>  	/*
> -	 * TODO: The restart key is verbatim in the block, so we can in theory
> -	 * avoid decoding the key and thus save some allocations.
> +	 * Records at restart points are stored without prefix compression, so
> +	 * there is no need to fully decode the record key here. This removes
> +	 * the need for allocating memory.
>  	 */
> -	n = reftable_decode_key(&kth_restart_key, &unused_extra, in);
> -	if (n < 0) {
> +	n = reftable_decode_keylen(in, &prefix_len, &suffix_len, &extra);
> +	if (n < 0 || prefix_len) {
>  		args->error = 1;
>  		return -1;
>  	}
>  
> -	result = strbuf_cmp(&args->needle, &kth_restart_key);
> -	strbuf_release(&kth_restart_key);
> -	return result < 0;
> +	string_view_consume(&in, n);
> +	if (suffix_len > in.len) {
> +		args->error = 1;
> +		return -1;
> +	}
> +
> +	n = memcmp(args->needle.buf, in.buf,
> +		   args->needle.len < suffix_len ? args->needle.len : suffix_len);
> +	if (n)
> +		return n < 0;
> +	return args->needle.len < suffix_len;
>  }
>  
>  void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
> -- 
> 2.44.GIT
> 


