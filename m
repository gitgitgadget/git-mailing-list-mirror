Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE91E4A4
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617528; cv=none; b=kLPssBGY3m0tMpBWJZ+M1LazcdqXKbkI9abz/JFk0OK2ItxERoTuNCdvzkiqjHzuMFgu6qsVfqGwr3nXEp5tvL41su6jRMv4pP4ILiyHrteuk9k35E4YTFlxehTOsY5czQHgNSA5pdmkvv+q7HA/hIRU4M38nixjL/OckRXCOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617528; c=relaxed/simple;
	bh=oG5DV4EYZxrRZm10hKwW1lFynZIItjw0+Ly+FqnIQFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWU29KRCphhI7Vr8m//Ul+FV2lOj4pRugPGEso5eHVF/4cy+2J6A0Nzo13UZI5kRZaE025hkQP5gyqG9IJ1JW+pWlrOidcnlFwu7PQSodZgalihYwE67Fg0l1xQmeNpZnuoMLBVspzEMy5iQQNKS33NITC5dwTiWfl0bUPbV6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3PE98o1; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3PE98o1"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fcef5dc742so29816eaf.1
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743617524; x=1744222324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKLoe5apyrbZN0NhvZwRyJWLlMp3wwTCf6NDF6+Z6jk=;
        b=J3PE98o1er6cp7pJau42rMTKZeSHS7tE+9Gn4FHfMXCCpDdsRg660VFpzgaQM6+XNJ
         0osI5c3CWqepF+eiFyMdoGR8w/s4qr7T2jj87Lc3iHXS8yTgF/2Bdw8kO5PjYSXmZmF/
         Q/QYYHaUGIOSCiBJ7TsH7g2qRVqNfJC8e+XFvT1FrKhz7kvN5O0snk3zUcvbZxYG0rgB
         6ArSD9IE1OvVU90kvEY6eVYaNIIn7UeEAj37fhdgQC84ZtL9nWGE+zJA263nx+2BRoQj
         Tfyop6Q9sLtAT6pySgF9LhiCpp4V9zETzIVlPrxuCfXSczJfIGY1YCG6XxZnKQ/IRy+R
         Lc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617524; x=1744222324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKLoe5apyrbZN0NhvZwRyJWLlMp3wwTCf6NDF6+Z6jk=;
        b=kAftbPOm/cPNfKMgSnyD0xH8FJl/qU5RSuYsiDgL8v7vJcdcaiWFYGjvvyS2OMiQ+O
         FrlBTghX3QF7IfDWgtAXynt4NeWssx7hoB6fdXtRNELARuD1GzuhzSjjvyuDaZe3AmOV
         I7bczyrqa3WZFoR8p3daNAkmuuOdnBBXTMB22UNCKJ5ZYouPKgHdjZgzW/KYmoyHNLIt
         bJrE3Vz5Szterxjw5+QTe3GALkszcn5RsGJBthsF5AwgBZPA9lyBPnw90n9nFZnNRi9x
         JkquLBt/A+6qLfCYvVvxlICFRHDCQjttj5l2wNepLqLe7FUGhiXzzSVQEG+XoMpB7Uyz
         SGyw==
X-Gm-Message-State: AOJu0YxZIiuvTvRGyeI7AxzGbfl42WQp6CGFzwZVwWnAfCrGAWW6m7nx
	C+w/52C55MNRZJTupLBRW+BMKug7fFR5IVxZ62SvD85l3ZhW6g3rLSmGhg==
X-Gm-Gg: ASbGnctcBe24wBeKqWnz1n0VTiuOLgVp3Z44X24aBZhXc/us4QavdcpotaJPcD/VkBJ
	Serq8MM/Bfeg2WAHV5QT1Qe1W/P4vDzv5vwPVCaQ6chKSnt4KSqwt2sbzFTE+RnRhzuK6zD076W
	AhQ1Xn9/QsdwlpfX3ZfWv324TvzCAQzThr2Fuwx7CqqUnMRZid6pjv0d2fgn9N4a6tMozZKuefL
	tTC2H6wLpk3iUwfbDp8JELml85C8GiiuZfj1jSM7mYkgZkOqArkrBqMsL0G81zIw0KkkIAHMAVx
	y+LgX3pzytVx3pm7kMxZ6aYsNCoNGZzwp4yNfQ==
X-Google-Smtp-Source: AGHT+IEXUG1Lm+8s4wCBUhyfDw6Wmmzk6Z4AJzob62/O3CaYYlcSPEbFJQxKhrge2yltQQ7Yz88VJQ==
X-Received: by 2002:a05:6870:15d6:b0:2c2:3e54:553 with SMTP id 586e51a60fabf-2cc60d4cc46mr1774383fac.28.1743617524202;
        Wed, 02 Apr 2025 11:12:04 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c86a3f3db1sm2925420fac.4.2025.04.02.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:12:03 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:08:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 04/16] reftable/block: simplify how we track restart
 points
Message-ID: <pole54ty25p4w2whskjpdpld4okwwbiiqufzzjwqzd3n7bqds5@foo67s5pgk7r>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-4-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-4-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> Restart points record the location of reftable records that do not use
> prefix compression and are used to perform a binary search inside of a
> block. These restart points are encoded at the end of a block, between
> the record data and the footer of a table.
> 
> The block structure contains three different variables related to these
> restart points:
> 
>   - The block length contains the length of the reftable block up to the
>     restart points.
> 
>   - The restart count contains the number of restart points contained in
>     the block.
> 
>   - The restart bytes variable tracks where the restart point data
>     begins.
> 
> Tracking all three of these variables is unnecessary though as the data
> can be derived from one another: the block length without restart points
> is the exact same as the offset of the restart count data, which we
> already track via the `restart_bytes` data.
> 
> Refactor the code so that we track the location of restart bytes not as
> a pointer, but instead as an offset. This allows us to trivially get rid
> of the `block_len` variable as described above. This avoids having the
> confusing `block_len` variable and allows us to do less bookkeeping
> overall.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c | 25 ++++++++++++-------------
>  reftable/block.h |  8 +++++---
>  reftable/table.c |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/reftable/block.c b/reftable/block.c
> index 97740187259..f2567a8f0fd 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -216,10 +216,9 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	uint32_t full_block_size = table_block_size;
>  	uint8_t typ = block->data[header_off];
>  	uint32_t sz = reftable_get_be24(block->data + header_off + 1);
> -	int err = 0;
> -	uint16_t restart_count = 0;
> -	uint32_t restart_start = 0;
> -	uint8_t *restart_bytes = NULL;
> +	uint16_t restart_count;
> +	uint32_t restart_off;
> +	int err;
>  
>  	block_source_return_block(&br->block);
>  
> @@ -300,8 +299,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	}
>  
>  	restart_count = reftable_get_be16(block->data + sz - 2);
> -	restart_start = sz - 2 - 3 * restart_count;
> -	restart_bytes = block->data + restart_start;
> +	restart_off = sz - 2 - 3 * restart_count;

Ok, since `restart_bytes` is derived from `restart_start`, instead of
having both, we just track the offset which is `restart_start` and rename
it to `restart_off`. Make sense.

>  	/* transfer ownership. */
>  	br->block = *block;
> @@ -309,11 +307,12 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	block->len = 0;
>  
>  	br->hash_size = hash_size;
> -	br->block_len = restart_start;
> +	br->restart_off = restart_off;

The `block_len` is always the size of the restart offset. I assume we
rename it here to keep naming more consistent.

The remainder of this patch looks good.

>  	br->full_block_size = full_block_size;
>  	br->header_off = header_off;
>  	br->restart_count = restart_count;
> -	br->restart_bytes = restart_bytes;
> +
> +	err = 0;
>  
>  done:
>  	return err;
> @@ -337,7 +336,7 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
>  	int off = br->header_off + 4, n;
>  	struct string_view in = {
>  		.buf = br->block.data + off,
> -		.len = br->block_len - off,
> +		.len = br->restart_off - off,
>  	};
>  	uint8_t extra = 0;
>  
> @@ -354,13 +353,13 @@ int block_reader_first_key(const struct block_reader *br, struct reftable_buf *k
>  
>  static uint32_t block_reader_restart_offset(const struct block_reader *br, size_t idx)
>  {
> -	return reftable_get_be24(br->restart_bytes + 3 * idx);
> +	return reftable_get_be24(br->block.data + br->restart_off + 3 * idx);
>  }
>  
>  void block_iter_seek_start(struct block_iter *it, const struct block_reader *br)
>  {
>  	it->block = br->block.data;
> -	it->block_len = br->block_len;
> +	it->block_len = br->restart_off;
>  	it->hash_size = br->hash_size;
>  	reftable_buf_reset(&it->last_key);
>  	it->next_off = br->header_off + 4;
> @@ -378,7 +377,7 @@ static int restart_needle_less(size_t idx, void *_args)
>  	uint32_t off = block_reader_restart_offset(args->reader, idx);
>  	struct string_view in = {
>  		.buf = args->reader->block.data + off,
> -		.len = args->reader->block_len - off,
> +		.len = args->reader->restart_off - off,
>  	};
>  	uint64_t prefix_len, suffix_len;
>  	uint8_t extra;
> @@ -505,7 +504,7 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
>  	else
>  		it->next_off = br->header_off + 4;
>  	it->block = br->block.data;
> -	it->block_len = br->block_len;
> +	it->block_len = br->restart_off;
>  	it->hash_size = br->hash_size;
>  
>  	err = reftable_record_init(&rec, block_reader_type(br));
> diff --git a/reftable/block.h b/reftable/block.h
> index 203b07d9a44..b78f322e646 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -79,10 +79,12 @@ struct block_reader {
>  	unsigned char *uncompressed_data;
>  	size_t uncompressed_cap;
>  
> -	/* size of the data, excluding restart data. */
> -	uint32_t block_len;
> -	uint8_t *restart_bytes;
> +	/*
> +	 * Restart point data. Restart points are located after the block's
> +	 * record data.
> +	 */
>  	uint16_t restart_count;
> +	uint32_t restart_off;
>  
>  	/* size of the data in the file. For log blocks, this is the compressed
>  	 * size. */
> diff --git a/reftable/table.c b/reftable/table.c
> index d18e17b0d44..ec84545707c 100644
> --- a/reftable/table.c
> +++ b/reftable/table.c
> @@ -838,7 +838,7 @@ int reftable_table_print_blocks(const char *tablename)
>  		printf("%s:\n", sections[i].name);
>  
>  		while (1) {
> -			printf("  - length: %u\n", ti.br.block_len);
> +			printf("  - length: %u\n", ti.br.restart_off);
>  			printf("    restarts: %u\n", ti.br.restart_count);
>  
>  			err = table_iter_next_block(&ti);
> 
> -- 
> 2.49.0.604.gff1f9ca942.dirty
> 
> 
