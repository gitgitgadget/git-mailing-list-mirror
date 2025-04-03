Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2C24C080
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693473; cv=none; b=lqEXrg0a4PJtbNGw2xSKBTdkPQTj0MRoEG6834coLxe4MDJdwGX+E52ESNLXq0XL9ld6NGR9G9btmUx0jiJTsIWHaqx2RVAOeSbWHEoOTcv/dw+Y8cW4GRmmARfm4KpP31a7pUiOObsBE/F1EXsxTrBsgHOt2vH9K5XYhlj+3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693473; c=relaxed/simple;
	bh=cTKWzhUYhrRY2qkkpGpqy9xJmOsdxVD4pJjs9rcOsKY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=rrY9MDJrXXUY3q83diaek0GMWabmfGDMEXGddyNIjJnUsgCJPCO5UOiai7LH14hVfXaQpr/FEf8tOLbsmNcsKSZzp3d2cwXb45hDylkFVGXZLSz+YK1NQdEHaxNVIHO52vZuJaiKWjY0ksR0hyauq8W8Uibto5uwLicNqDqbv6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVFKgvxR; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVFKgvxR"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso492131241.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743693471; x=1744298271; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ck7eRiXPtGTCbwgVeakz+QoKBzJn6R3oobFOzqxtrDU=;
        b=iVFKgvxRhayRR4i8Zpmp/tXe5cecFeCCpwglicYQJ5f76SpwMPBq5XL29ay9qJHryy
         O6KtIh3MEV2XwEyo4xea3jv1Abccj0mY2zBXETcwaYhtlgIujyhoh2liuxpZ0akYXcHj
         bLX8R5me1moRSTh4PXDFptYR2uz8xyjYXKYd1HB1hWQB2QKMcSRCBnwK7yJTDvVK7sbL
         enfpkBkivn8fRKUfdGUVYvxD7m8kp6dQZgDH48e+v8SjGvyg+aJiGdLSeOxYaxehi+/T
         uSWtvmyE/H3sKBLrpVl6dXirXRTpQTbTtGK6ymMWNEd9opQq1InyeXytz9GNVhGUzxW0
         yIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743693471; x=1744298271;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ck7eRiXPtGTCbwgVeakz+QoKBzJn6R3oobFOzqxtrDU=;
        b=hoaVJzcHhCBSFtEGZsmB2yKd1ZmRr7Wo3O6hfaJJFTZA3ggweyb0a+WhWpgTqRf1Hj
         iGbA7lWuScF8qulmXDlG9P4VA8eOjTCEHP6wrPKkuVHhIr1SHX4PxNrZTpFUULyhuYC4
         af6/a1lkDomPE6ntzFaYfKSzLKnnteV/nqWchcO9WUZYIpIrtR3zYy2q7Y3Y6gTwF0ef
         JaRZoW8f2DjBtK6Z9uXioUVlG33JqbSxmJDKxE4wd6ssDw3FZXr1N1K1L93d4QsTW23n
         erU6DhMtFx4Z0YT4jy6qsuugRNJbh/sZ3fdna3LC0jAUAWL/9kZrII+4tVU2yuo78Mgr
         xA0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwGm3FIp0fGqz7+dbfdKKjdzy5LaSw0Id97pesQa0aznqkHp4DPkZ56kCSyKWYc7SHO1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1uaYV7wicrHS380e5ObpV9bEVf8mVh0AlIQODvk5O8H3WAoS
	H39o+Dh2/v09kaiVq/3uoNiyRvNAS7N1Cmi30bLuJBdOW+2H+km0RKZufsQpqReSTA9Tg5PJ9En
	b8nTo1lXm6iYYeklv7TC3YsHDwpprwr4J
X-Gm-Gg: ASbGncsUMIJeGMK/VGpoUo9+oOzqXJPVUrwMjcUzDh+mgdIxZf1xUIzc0DAcNfbW+AT
	AFa8TOGgMDL+Pedvf0UldCDIPKULhFJI1qHZU4+ak8IScetxTq9xVPvxJNPROjzYcMg7RiEDnIF
	xiV4Ry56uZr+SZ6GpSkF5zOVrpIz/tuWFIVMU16fhVcLn0NQI0N5wwYWLBvw==
X-Google-Smtp-Source: AGHT+IGqFGTJXyMICrXQ5uNp6NRqM3PeJggeQh52DlmNLGL0lA/KJiUgL3D+NRVdwcdefVPEM20sSuD/KlML4AcLUaY=
X-Received: by 2002:a05:6102:5108:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4c8478849damr2473143137.19.1743693470960; Thu, 03 Apr 2025
 08:17:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 08:17:50 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250331-pks-reftable-polishing-v1-4-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im> <20250331-pks-reftable-polishing-v1-4-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 08:17:50 -0700
X-Gm-Features: ATxdqUEJmnXtDE6Y9bNm2m40kb6XzFddkb8jG-vlWyMuB9DN5dl-hIm7r2YselQ
Message-ID: <CAOLa=ZRwRkV56HAxtfX3EM1Lr3D938bY7d-zv+xUF4G40f-O2A@mail.gmail.com>
Subject: Re: [PATCH 04/16] reftable/block: simplify how we track restart points
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ef2a7c0631e14540"

--000000000000ef2a7c0631e14540
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

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

Nit: This para makes it seem as if we'd eliminate 'block length' in
support of having/keeping `restart_bytes`, but we remove both.

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

Nit: I guess this is to be consistent with `header_off`, but I would
think spelling it out as `header_offset` is much easier to understand.

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
>

So each block looks like:

'r'
uint24( block_len )
ref_record+
uint24( restart_offset )+
uint16( restart_count )

So this does make sense.

>  	/* transfer ownership. */
>  	br->block = *block;
> @@ -309,11 +307,12 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	block->len = 0;
>
>  	br->hash_size = hash_size;
> -	br->block_len = restart_start;
> +	br->restart_off = restart_off;
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

The patch looks good.

--000000000000ef2a7c0631e14540
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 525b6b0d5ea6b01e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdXBwd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDZ1Qy85OGlFb2RPaVhEanVpeDdjMTVtOERpM3QzbwptdUh1YmsvUFVT
a00rMk5pdzY5RHZsY2NiMWU4OUxOK2tkTDl3b2wyR0krcWpnVG9ySThJbEJ3eWw4M3NDeEZPCi9W
UEd3T2Z0RzE4a2lHS0ZSM1cxeGxxajlwRTg1ZldKYy9ENVI3NXBKTFNydURHQ2VVVEtvSDUyemlE
Z1hsZEwKYmZHdnYyeFJNUVlyQzl2VnlJaXl5U2g0MFkvbEhXY0ZSVVJTL0NSSStNYk9LU1lySjZy
VzdpbjJEdDdacHBYeQpoY3ZVQWcya3IrdG82NFJOKzUrb3VTQTMweEc3ZE1MQ3hRN2VieDk2eDZ6
UkZmWjJFaURjSVArTTd6ZkdiNmsyCnR1ZVREcUg4M2l4UHJvV3kyT0hDNkwreUhzSkVTWXMvelJU
TjhiTlpJQkVyaGIwT3JqSThBdytpRGpoak82clcKdlFyb3plSDJaU1lTRGtwN0N1M3RKeUlmaXVo
V3hDd3k1N1c2YnpxR09Fam93MTNoVkc2YnJJR2luQlBlRUZhaApXZlYxREtLRUsxeE1MdlQvajh3
eXVVZnFrK2hWUEcvUmNyRy9Xci9UWVJjZkJ1QW55QlAxcG1IUms1OFRsNmRPCkpPcy80dDlJWGtK
d24wMXlSSS8vT3VtVUtWRVZ1cEEyc3pjL0hGYz0KPWFmYm8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ef2a7c0631e14540--
