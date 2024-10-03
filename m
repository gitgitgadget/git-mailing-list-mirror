Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89731758B
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917054; cv=none; b=Dw1gzI7O5FNmY4zkXj1XbM4471kBnYTWPbFF5n6Qs2NcE9X+V9rdzWTH/fiLhtE6dwaiVsDYQlWGwWPOpRiw0No0oxcnm2qsmlI4VY96Nl7cD49boVi/jkyTvLSVDM6ytGOQyNh6uyo3ATCkSKesAFMmxKGfgh6uzpQaAPCZRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917054; c=relaxed/simple;
	bh=BxzgoiqbnoXGdXzrcWbWDn/zOSOEM5ort7w/nLnz3XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjp6tPTCjLVFtX7MbJM+gQ7JwkI+DxqS0CdlZx4CoAx0uJJC/1qaYWBckbWKYgxX509r+BuVyC5vvXiEayMIMsqck7g7BFvByB6Q2r7LIwU6MmL3+/+EQ0g5rn+eJb+bZNBzl16HLRqNsBi3gzCxdEs8gfdEG/91zwVlPZP1pCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=gpT0SPZN; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gpT0SPZN"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d9f65f9e3eso3831267b3.3
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 17:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727917051; x=1728521851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPk916gG2nx3ntglpgjgo7XShU2zIEoF1jfhHayK4YU=;
        b=gpT0SPZNgEym0N1oYfCDayMhAgxxzr4USqyH0hPBY1eCh9FLQIU8B5VHZxS/POw+wf
         gf5NJ6m2Z2K9Rqp9x35wInWYPrHJGFU1Lr1FR0+kBZr7laD2P33dSTog+OTLNvc+MOcO
         9axLYdC3smnqFHhiUnvlZ2ErwffKv1t39Z7W+iBLoPP3ofcRvxPkhFyIUvPOze1MhJ3x
         +GIAfo0gIq2IePaplcCzoI/DGO4oPulwolUhG2ogyg0PlHmWawxMjpIaPyciGPvVVrxa
         nRiZIPn7Imtctq8JC8/bYK9qATwmSYRloJtAY1ChVBBsQrKpHxQHC93h3IxzknxxlGpu
         ZsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917051; x=1728521851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPk916gG2nx3ntglpgjgo7XShU2zIEoF1jfhHayK4YU=;
        b=YFBpJ4K9PKgPAwAfZTk1VN5ZrlOuOs968ouMYTNZ+JVXgecBNRn3vJA+Oxr9lz4Nxt
         NjPJPmYf2RXmjObiyVDmjSafwT+FLjPm1GLf9mQ0jfUz62UCbUT+twefe6gZsWhmAULo
         9crbw8k0mHvVVI8mUMMrlCK5mj+cYgCRlYbmRc2aCmJZtD1Npi+C/WwUEsrLk6JY3J90
         TQcBA/g1LvtW+oth8+/ZW7XlvUfNzhAec6uN5mwGXK1zucIRYZ9dtbBLaXkPKLgKpUJp
         oDDiy/eOSXJDb/7aPAG75CKM8zf0bWtt/GiJBkgQHEwDjDPpFLL725EQQwN3S90J3Koe
         SR8A==
X-Gm-Message-State: AOJu0YyDZ/5tVxuUdGZcFRag3Ffh81nQ0cu7ebGU1/mzUJLm4JGGUpEU
	McUAsoXi2JS+DPM9yW7giwjivvmgX74j62cWXtYUMjHKF5GQrSgbLl/Ev6koFss=
X-Google-Smtp-Source: AGHT+IF2tUBjmhNfBjYBjdVeY6A+bTVfxD77o1JLYHV+nlKB555YqMvKlxmjYl2aM1FEithuUz2VTA==
X-Received: by 2002:a05:690c:6282:b0:699:7b60:d349 with SMTP id 00721157ae682-6e2a2caf87emr52150677b3.11.1727917051483;
        Wed, 02 Oct 2024 17:57:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2bc1bff96sm133487b3.129.2024.10.02.17.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 17:57:31 -0700 (PDT)
Date: Wed, 2 Oct 2024 20:57:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (v2.47 regression)] hash.h: set NEEDS_CLONE_HELPER_UNSAFE
 in fallback mode
Message-ID: <Zv3r9FBd+Nog3wb7@nand.local>
References: <20241002232618.GA3442753@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002232618.GA3442753@coredump.intra.peff.net>

On Wed, Oct 02, 2024 at 07:26:18PM -0400, Jeff King wrote:
> diff --git a/hash.h b/hash.h
> index f97f858307..756166ce5e 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -82,6 +82,9 @@
>  #  ifdef platform_SHA1_Clone
>  #    define platform_SHA1_Clone_unsafe platform_SHA1_Clone
>  #  endif
> +#  ifdef SHA1_NEEDS_CLONE_HELPER
> +#    define SHA1_NEEDS_CLONE_HELPER_UNSAFE
> +#  endif
>  #endif

Gah. I could have sworn I wrote something like this myself, but I must
have dropped it or hallucinated writing it in the first place.

Thanks for finding and fixing.

Thanks,
Taylor
