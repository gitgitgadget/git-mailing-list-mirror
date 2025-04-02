Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9792AEE9
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 20:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743625016; cv=none; b=TM9/emTdFO4haFo2EAftaI2xINUXLdYaNwR3JYBtT9o/tSWUUtqG3/0TGoVoQbYK6d5vDezF04dhS5dutR3+RV1eFFgaYq99NXamQK2XrAhXuQPr1AjXcB4RPmTF75UfciYEAq9zGwlkzibQAk2Mx4iYyB+CoLOvuQezXcXimfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743625016; c=relaxed/simple;
	bh=InFzUxfVcTYO6zG5i4x23XpgWKQqVeDtz7EGOk62Zps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjgpHWjw8BNi1dy2Z53/1Hpv6sAJ7qCOnJuHzIVd5mC6d+FrrCfpNZzg6gdA5Idzw0i+DS1SJMQORhYFmOB4Z6mPWYMmj7e69qUpbAVpXn77gHJpuU69DEkL9ig/z2MO8U1H09JwJdEFlNcBf7xPXo52QRgBb1ERx3H/zahLzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENkowQPn; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENkowQPn"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fbc00143d6so96535b6e.3
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 13:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743625013; x=1744229813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OflrglGInMpLOT3ho5ArEtBs2fIlsZnbDFJZuP1ms+I=;
        b=ENkowQPn4X8b0Dp9bq6zY9Oc19Q391UGLbH94tCvQtmbRO2wq2Y01vNljA5uQ7XeuO
         OyCs7KuOqwN6n5Pi53Isfp8DqX2rLBTHHD3KN9n7BD9dlOZRhZ5mlEStE2s7qf+arEeR
         i0y89SG7/w8JHgKsMjAISzpdEphRmyVm2sNQ4N9dnYV1fOaNyxQfeMzIl32qx7+4jdV7
         82VdL7JTGKjgS129gRJabSAJnEiT6aNu00TyTTry/F/93erQiuKLnufQkTOnMd12SgjV
         woxSqafIkcVdnfvzz8tATHi0fFWrlLweUt/Tixk3zcAhreIg5yHCqU+V5mub3UETRZhN
         8gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743625013; x=1744229813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OflrglGInMpLOT3ho5ArEtBs2fIlsZnbDFJZuP1ms+I=;
        b=Sey4XHg+XR08TJAUkYJ9xZKj+ZSJ13Px/SNS7/W+dh9YIch2NSfUhvAP6oMY3qivok
         BalGfMsIf56CRrCL293ZPJ/O+sxbSf155kVj23p1MfVZmnb376OoQmnML2x9ZnIV3jSA
         9RftyL2k6sxUnRGO//XrL9R19XECCfJ3vBMDn6SkzERtXMwnCGD/C6QFJo8Kc5tFenSE
         hXzQgMThUQrgfyq2l5MEcd6ovsj+phH5dlhKkzMjw7UaJv27VqZyMWBL8f8S03GexJV7
         FImnAx+WdQvRy5efz6+HYFdaaJ+ajVgUIggFf7U+iYtHJMCninK6aymHu/o+droQMDmO
         GeEg==
X-Gm-Message-State: AOJu0Yx5w/7qaK+aVBEM+TZyvFDaQRN2HIjGlnYOIppdwQKcRbYbT4Ta
	EBtz7VbEFYuSEywa1H6Lmo5nx0Z7rQ+myZIUl22Sb/IAkf/O58g+AbrrkQ==
X-Gm-Gg: ASbGncu5wvBOa/GX81A2PuEwBhw2Ddd9U8e7g0cxGcOrtNRE9Y60/3a6J6qYj2FQ3Ic
	uqdy6mLkuG++NhkUqBE06AbUtXQ5ngRT5JERJ9M+K3oGoUhvV9i/5AM8B7C59iT835Mzl5K0RF7
	Qx0UQP5amo7+ixqyby8anzx3lHc3jUdWpilBfTx++1c4KpPxxPpe4ZlhrKfDoASgl7UkxtGx6hI
	26EU4ilqstDie73L4X+Ut6mTAHPKOiI9guMPoz5P3F64/fTb38HBtrAhXX/HdTkZg8cuY5LxzhG
	oe+GN0PEIMd2OecjIOYERaHorZ8tH0VkXNKmtA==
X-Google-Smtp-Source: AGHT+IE0tKQDd8QXlrsbMDFeh732xUAnsjIbFrgM+f5MWiu8zw95MAySWnUvb0HyQkLQi/JleWR5Yw==
X-Received: by 2002:a05:6808:218d:b0:3f9:3de3:c8de with SMTP id 5614622812f47-3ff0f523e06mr10312627b6e.12.1743625012839;
        Wed, 02 Apr 2025 13:16:52 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c86a91606fsm2903223fac.49.2025.04.02.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 13:16:52 -0700 (PDT)
Date: Wed, 2 Apr 2025 15:13:03 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] reftable/table: move reading block into block
 reader
Message-ID: <umaolgemnks4g4cgwgnurl7alic2a3pzrfx2ws3s7uxypiedia@7mwqxvhw2zxg>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-5-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-5-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> The logic to read blocks from a reftable is scattered across both the
> table and the block subsystems. Besides causing somewhat fuzzy
> responsibilities, it also means that we have to awkwardly pass around
> the ownership of blocks between the subsystems.
> 
> Refactor the code so that we stop passing the block when initializing a
> reader, but instead by passing in the block source plus the offset at
> which we we're supposed to read a block. Like this, the ownership of the

s/we we're/we're/

> block itself doesn't need to get handed over as the block reader is the
> one owning the block right from the start.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c                | 87 ++++++++++++++++++++++++++---------------
>  reftable/block.h                |  8 ++--
>  reftable/table.c                | 65 +++---------------------------
>  t/unit-tests/t-reftable-block.c | 76 ++++++++++++++++++-----------------
>  4 files changed, 107 insertions(+), 129 deletions(-)
> 
> diff --git a/reftable/block.c b/reftable/block.c
> index f2567a8f0fd..2517108b8ef 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -209,31 +209,57 @@ int block_writer_finish(struct block_writer *w)
>  	return w->next;
>  }
>  
> -int block_reader_init(struct block_reader *br, struct reftable_block *block,
> -		      uint32_t header_off, uint32_t table_block_size,
> -		      uint32_t hash_size)
> +static int read_block(struct reftable_block_source *source,
> +		      struct reftable_block *dest, uint64_t off,
> +		      uint32_t sz)
>  {
> +	size_t size = block_source_size(source);
> +	block_source_return_block(dest);
> +	if (off >= size)
> +		return 0;
> +	if (off + sz > size)
> +		sz = size - off;
> +	return block_source_read_block(source, dest, off, sz);
> +}
> +
> +int block_reader_init(struct block_reader *br,
> +		      struct reftable_block_source *source,
> +		      uint32_t offset, uint32_t header_size,
> +		      uint32_t table_block_size, uint32_t hash_size)
> +{
> +	uint32_t guess_block_size = table_block_size ?
> +		table_block_size : DEFAULT_BLOCK_SIZE;

Out of curiousity, in what scenarios would the table not know the block
size and we have to rely on the guess?

>  	uint32_t full_block_size = table_block_size;
> -	uint8_t typ = block->data[header_off];
> -	uint32_t sz = reftable_get_be24(block->data + header_off + 1);
>  	uint16_t restart_count;
>  	uint32_t restart_off;
> +	uint32_t block_size;
> +	uint8_t block_type;
>  	int err;
>  
> -	block_source_return_block(&br->block);
> +	err = read_block(source, &br->block, offset, guess_block_size);
> +	if (err < 0)
> +		goto done;

Ok, so now `block_reader_init()` handles reading the block itself and no
longer relies on the read block being provided to it. This makes block
ownership more self-contained and clear.

> -	if (!reftable_is_block_type(typ)) {
> -		err =  REFTABLE_FORMAT_ERROR;
> +	block_type = br->block.data[header_size];
> +	if (!reftable_is_block_type(block_type)) {
> +		err = REFTABLE_FORMAT_ERROR;
>  		goto done;
>  	}
>  
> -	if (typ == BLOCK_TYPE_LOG) {
> -		uint32_t block_header_skip = 4 + header_off;
> -		uLong dst_len = sz - block_header_skip;
> -		uLong src_len = block->len - block_header_skip;
> +	block_size = reftable_get_be24(br->block.data + header_size + 1);
> +	if (block_size > guess_block_size) {
> +		err = read_block(source, &br->block, offset, block_size);
> +		if (err < 0)
> +			goto done;
> +	}

Instead of relying on `table_init_block_reader()` to determine if
`guess_block_size` was correct and reread the block, this is now handled
as part of the initial `block_reader_init()`. Make sense.

[snip]
