Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F321C6FF9
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 20:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625817; cv=none; b=eJzGcEfO1tFeg8pa3zyCcI2zIUpUzObmMn5mmUmO/qpaPVrx1WoheCJezDdgPw3vM65E/c9aLQw5PcA6/56HEWmN+cLHX5361yecT1ZsDTu2DsqXK9gQqIIgI/V3H8YXNHRkrwNB6Xusf1RdfhTy7AcqhbacyqBhk5d7WreBlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625817; c=relaxed/simple;
	bh=MFxdvdlCCrsHKP6LAlcsn7sg/sPcXmgotQlabMqVClk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHus9gHMcl8gK2UngoL0mgFlcoihf2hWAs8QXnGNKS9/npKx48gy6C4BBGpkElRKpQC+MCsppAhkJE7YrsBfjTn5NUs+GafJkshK7RucAZH+XBHAdN7stpcBaYz4YFtx+HFnnLMP51yO+ysok3Yrwe7N8BpOhGQmVdBZnneSHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2oLhzRN; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2oLhzRN"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-72b82c8230aso82047a34.2
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743625815; x=1744230615; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01RbzqDhGdSsQv6Y7XT20KnSLfXDHJsLGihsgBURhX0=;
        b=d2oLhzRNzKw9NNjgCdf3etAdAcY/nv6iLA857dJoVTa6+OfPH1kHFzDCbxD6SxRxrX
         6mg+vSc5v0rTycsX1uYUitY8jWKWL9k5v6AozuZo0As8U7YFdBGyPTLmg2LeFBmX4stz
         vP16cXU5WxTNtSKczSP6tqc9ZDTYS/cj85SilvkiO1l7pmEiMHI2xqUNfQEGWBMpKLgE
         nanhyBY9YWnaydsYO8RS8CwbkQfP5VAHmYWQlnnImv2mxioGTKFbz4AGG49lk4Dg1Rsm
         tAMhu4HIGk1U+clsGqdQk7DdtgvsdMmqpDU3KHK86EbgZ5izGp8JDS0PRGotbAtRvg5m
         TB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625815; x=1744230615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01RbzqDhGdSsQv6Y7XT20KnSLfXDHJsLGihsgBURhX0=;
        b=eiumeDBN0jAD6qfFRz5XXi6BCCaanD1Jj2nGaLffWE3Pf9RPW//3X5nTob8r4f8TCZ
         dTZGiMIVDFNi8fgQNa0i0JSEn6h1SIYcEtsUCJKgMI3TZBuNx0AOkduX7xwUMF5zglZX
         hRKxJV4dp92JPAL4m5xGi5wTgfWUpfsz4X2ULsqTTRO1gF7Wmd9p4D/S8KBVI9NK78uI
         j6MiPfBzGezxLWg3zjFzQNBDFTC2stgoN6H9f3UjO3YNY0J/9SvzHKX6rL39nd/eIRx0
         C0g/gnhvymMtHi7rkRQho7ur7XkIHhzv27XeXpZjO3KN+JVA2qB98/1ijBt2LiDNJ3Co
         GG8g==
X-Gm-Message-State: AOJu0Yw4IBmRjyadPRdKT8E+xGiGJz5n5D/MqRvHra8yhl/5iqJLYPwJ
	RfNeIFOH9d563BM0UDaz+NB4BsLvLcwI71vIdFMn6yBZbQ2YjabjvAYI+w==
X-Gm-Gg: ASbGncuiY1D2ain1NPbfoG/rFmubbsJzoFyeyG+gXigBtawh6ygJowKJsQRVa8s1h4R
	ccLoa4C22MaL9/2e8ldAdr+Xw13Ftcmt0JPTzCmSvkY/ETLWaOgLTDkmUGaQOv1KmesFnKG7Rqb
	QWwVD7oH+Ax5/4Lsni/NO59o7wXEQ52xpQv4DxORTpU0SazHAugaOwiwLTOdOOg658FZSTBd8PS
	DjKIRXJRReuVEZzP3d+FsPfU714Zwwwp7kIcq5JOFkrH7ZbIRNlu40IgBcj5X63pLg88gDFP2Vf
	GXeTDvf/ZhteJ/QjHxLJV/FtdDht7gsRc7iZw9yY3U2HRR3S
X-Google-Smtp-Source: AGHT+IEqlq3f1FM09MFVL7btRKb8Y7GEKfo8CBp5tatEx95/eeXPawbbtrEVYUHHp5aO1HxG8Yag0Q==
X-Received: by 2002:a05:6808:1449:b0:3f6:6d8f:1365 with SMTP id 5614622812f47-4003618e160mr2123863b6e.3.1743625814981;
        Wed, 02 Apr 2025 13:30:14 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-3ff051ba9d4sm2532672b6e.30.2025.04.02.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:30:14 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:26:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/16] reftable/block: rename `block` to `block_data`
Message-ID: <y3lbo4dnuv46kgy7fhzcksdea2pdm6nsy43tjai6tcgd6b3w5u@w5zqty5tgpmt>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-6-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-6-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> The `reftable_block` structure associates a byte slice with a block
> source. As such it only holds the data of a reftable block without
> actually encoding any of the details for how to access that data.
> 
> Rename the structure to instead be called `reftable_block_data`. Besides
> clarifying that this really only holds data, it also allows us to rename
> the `reftable_block_reader` to `reftable_block` in the next commit, as
> this is the structure that actually encapsulates access to the reftable
> blocks.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c                    | 10 ++++-----
>  reftable/block.h                    |  2 +-
>  reftable/blocksource.c              | 44 ++++++++++++++++++-------------------
>  reftable/blocksource.h              | 10 ++++-----
>  reftable/iter.c                     |  4 ++--
>  reftable/reftable-blocksource.h     | 14 ++++++------
>  reftable/table.c                    | 14 ++++++------
>  t/unit-tests/t-reftable-readwrite.c | 10 ++++-----
>  8 files changed, 54 insertions(+), 54 deletions(-)
[snip]  
> diff --git a/reftable/block.h b/reftable/block.h
> index 6afb1b2952a..c55d47c3c52 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -71,7 +71,7 @@ struct block_reader {
>  	uint32_t header_off;
>  
>  	/* the memory block */
> -	struct reftable_block block;
> +	struct reftable_block_data block;

I wonder if we should rename the `reftable_block_data` here from `block`
to `data`. In the next commit we rename `block_reader` to `block` which
leads to `block->block` in some places which I think looks a bit funny.

-Justin
