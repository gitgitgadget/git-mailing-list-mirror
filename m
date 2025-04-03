Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E881F4CBA
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743676967; cv=none; b=Fctw1bXzYRjaXTfvjPyj4uEQhwgojsFDSRiQWSAXrVsIMhQh269y071Ny/HDnWrNHe8iMR80ndLRZJU0PnjI099qPJTWTOVgX/Txv7Q7XE5c2KB0coGvkajp7xvzdFXyWbbTxfeAPiO2ZTUuXe37nAd9rerhciApW7DqPJ3vmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743676967; c=relaxed/simple;
	bh=dIfvl4w9NrsSk6+sJ/9EfgXt8aoaB7h49rNxy4W44N4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LwKKsq+GMpIfJhfP8lQsuEQq/2g4mzxG7Vnk9/ABYzuE7GK4XXJ4RxJQOJGJQfLCiCdCSBYDDUCmxQRWDUHSSk3OKRHHL32BXIZCPIfuxiYy7GO73NRKeX+40YVN+WPn1R+f4ivOzEvf1cItWN0KheLA/I1PmIVWZYD4u5smvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULPqo/+w; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULPqo/+w"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d6fd581f4so1629917241.1
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743676963; x=1744281763; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQl/uVgC+13cxV+rgl3HyYPXBEHB2HCVFvX3w7DHOF0=;
        b=ULPqo/+wH1Dgrfj6GCfAgQtjaPhUI6JLLNnruVQp73Qpn6XVPqYGmNUFJYPXnLiW1m
         rux7yK0Pu8oAKBb9i3+NLh75QEzuBL3KmTVpcOrGA5HOHQjjh9GBEj42/EEXDCNnTHUY
         NCGBv/oM0dSEn5hhgcTGfHUm0MhauIyqq+dNyyJT7Wd7ioBkx+45emifoA6KIufSga5Z
         3wtgsjmUw3KdYSz2SB7SEGDgu0q4tJpYuLej4EgpUTDdq/qylaN05TFM/oOrtBkmsUKJ
         qWkivF+FNzQcIqBlN90r6EbOOJ+T7XxE7/4lkBpfYQUuKHiTXo8l52aUvt/cKl15W28M
         B4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743676963; x=1744281763;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQl/uVgC+13cxV+rgl3HyYPXBEHB2HCVFvX3w7DHOF0=;
        b=EYPqMnRcxQzoLXQYJ+40vuR2MIXUk5jNaifSzkraQ3CUcD/BHKyhNVQhvyTkpNBDL/
         QzXJtYDF6hjQa5ioKCXFeGcAZiL7JV7JxycomJDLpmd6F8IaUoMomScEanEqfXN9Qlci
         cWJzzGAU++UJjbmCF+3GF3wT6cDbfvtSWzVZdNmOYaMNGHDaOZgLKB9/qa0ufwcw5Vkp
         8BTPh9UDKQvSUrdtW0Pg5Eu9lRsuf0N2GfoXDzcln10lEZbGCL2bBunrC5fy59PWgH3O
         u0OjkESuSB4A5wCAvjSnE/5xWYsL1IubOcoIYqNQbCI6I1g5kzGJn38ODd4PXfjM899h
         lc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKNGN3MQhJa0dLdi3yVWE0R4gu7CrI56P9ShA7eyVJio5xXwlJi5uOgzCmYJiNjTmYxao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XRah5aZv8bilfusXxOgAxTcC5PHBNTOZnukzTpF+E+BqTfJ5
	AmXhO5IF+pAuDWUxV+zFFfsDnN+syxf8LS18Kmbaa+M3JSxcMKvhnAQKQTmRYJ4b6lw8Bh/jdTp
	YOEVgIU5M0OiGyqk6YK9WZ1ANZcZCYBkK
X-Gm-Gg: ASbGncsGasJdedjpHNMVt1ryuRmkMscru917bVJVRulJ4uDMcbnPZ8/fl/2rf3lhGeo
	VHa2A5f56773rTDZjL/SkObdJ6V2tgZXs4hyYR/5qF8pImD0ghJNIaeOjPjW6JLrwkF2GgYU8KH
	IW+VFjGwZj3VDEYtiqAAva3LGO70sW3bHMK1XIOG5+ze0lYCPL40FmSzf6zwQF
X-Google-Smtp-Source: AGHT+IF4eeJjYFt4nzRBb17qoYIOsLuFA+xmCn52mcEBCVtLXRN/30PgzicSptyGV1qykKdvo1SUiT4+6SD7PWRBK+I=
X-Received: by 2002:a67:fd42:0:b0:4c3:878:6a62 with SMTP id
 ada2fe7eead31-4c845b65f9bmr1776181137.8.1743676963077; Thu, 03 Apr 2025
 03:42:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Apr 2025 05:42:42 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250331-pks-reftable-polishing-v1-3-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im> <20250331-pks-reftable-polishing-v1-3-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 3 Apr 2025 05:42:42 -0500
X-Gm-Features: ATxdqUEjXdykd1H0jSscJr4nIKFKMCU1d_1oYs6NhZD7lElUe6k8r_drE_UNxBo
Message-ID: <CAOLa=ZQV5ixN4TuM3KL=AuMYE=cW+KPqB7sLof7E4=F8Ep1Kag@mail.gmail.com>
Subject: Re: [PATCH 03/16] reftable/blocksource: consolidate code into a
 single file
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fce1740631dd6db0"

--000000000000fce1740631dd6db0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The code that implements block sources is distributed across a couple of
> files even though. Consolidate all of it into "reftable/blocksource.c"
> and its accompanying header so that it is easier to locate and more self
> contained.
>

So 'reftable/blocksource.c' is an existing file and we're moving related
content into this file. Makes sense.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/block.c                    | 17 +++--------------
>  reftable/block.h                    |  3 ---
>  reftable/blocksource.c              | 35 +++++++++++++++++++++++++++++++++++
>  reftable/blocksource.h              | 27 ++++++++++++++++++++++++++-
>  reftable/iter.c                     |  5 +++--
>  reftable/reftable-blocksource.h     |  3 ++-
>  reftable/table.c                    | 33 +++++----------------------------
>  reftable/table.h                    |  7 -------
>  t/unit-tests/t-reftable-block.c     |  8 ++++----
>  t/unit-tests/t-reftable-readwrite.c |  4 ++--
>  10 files changed, 80 insertions(+), 62 deletions(-)
>
> diff --git a/reftable/block.c b/reftable/block.c
> index a5734d44415..97740187259 100644
> --- a/reftable/block.c
> +++ b/reftable/block.c
> @@ -221,7 +221,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  	uint32_t restart_start = 0;
>  	uint8_t *restart_bytes = NULL;
>
> -	reftable_block_done(&br->block);
> +	block_source_return_block(&br->block);
>
>  	if (!reftable_is_block_type(typ)) {
>  		err =  REFTABLE_FORMAT_ERROR;
> @@ -285,7 +285,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
>  		}
>
>  		/* We're done with the input data. */
> -		reftable_block_done(block);
> +		block_source_return_block(block);
>  		block->data = br->uncompressed_data;
>  		block->len = sz;
>  		full_block_size = src_len + block_header_skip - br->zstream->avail_in;
> @@ -324,7 +324,7 @@ void block_reader_release(struct block_reader *br)
>  	inflateEnd(br->zstream);
>  	reftable_free(br->zstream);
>  	reftable_free(br->uncompressed_data);
> -	reftable_block_done(&br->block);
> +	block_source_return_block(&br->block);
>  }
>
>  uint8_t block_reader_type(const struct block_reader *r)
> @@ -570,14 +570,3 @@ void block_writer_release(struct block_writer *bw)
>  	reftable_buf_release(&bw->last_key);
>  	/* the block is not owned. */
>  }
> -
> -void reftable_block_done(struct reftable_block *blockp)
> -{
> -	struct reftable_block_source source = blockp->source;
> -	if (blockp && source.ops)
> -		source.ops->return_block(source.arg, blockp);
> -	blockp->data = NULL;
> -	blockp->len = 0;
> -	blockp->source.ops = NULL;
> -	blockp->source.arg = NULL;
> -}
> diff --git a/reftable/block.h b/reftable/block.h
> index eaeffdffc90..203b07d9a44 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -142,7 +142,4 @@ size_t header_size(int version);
>  /* size of file footer, depending on format version */
>  size_t footer_size(int version);
>
> -/* returns a block to its source. */
> -void reftable_block_done(struct reftable_block *ret);
> -
>  #endif
> diff --git a/reftable/blocksource.c b/reftable/blocksource.c
> index 1397cbe7800..bc785506fb1 100644
> --- a/reftable/blocksource.c
> +++ b/reftable/blocksource.c
> @@ -13,6 +13,41 @@
>  #include "reftable-blocksource.h"
>  #include "reftable-error.h"
>
> +void block_source_return_block(struct reftable_block *block)
> +{
> +	struct reftable_block_source source = block->source;
> +	if (block && source.ops)
> +		source.ops->return_block(source.arg, block);
> +	block->data = NULL;
> +	block->len = 0;
> +	block->source.ops = NULL;
> +	block->source.arg = NULL;
> +}
> +
> +void block_source_close(struct reftable_block_source *source)
> +{
> +	if (!source->ops) {
> +		return;
> +	}
> +
> +	source->ops->close(source->arg);
> +	source->ops = NULL;
> +}
> +
> +ssize_t block_source_read_block(struct reftable_block_source *source,
> +				struct reftable_block *dest, uint64_t off,
> +				uint32_t size)
> +{
> +	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
> +	dest->source = *source;
> +	return result;
> +}
> +
> +uint64_t block_source_size(struct reftable_block_source *source)
> +{
> +	return source->ops->size(source->arg);
> +}
> +
>  static void reftable_buf_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest)
>  {
>  	if (dest->len)
> diff --git a/reftable/blocksource.h b/reftable/blocksource.h
> index 7b67898ae22..639b9a1a3c5 100644
> --- a/reftable/blocksource.h
> +++ b/reftable/blocksource.h
> @@ -12,9 +12,34 @@
>  #include "system.h"
>
>  struct reftable_block_source;
> +struct reftable_block;
>  struct reftable_buf;
>
> -/* Create an in-memory block source for reading reftables */
> +/*
> + * Close the block source and the underlying resource. This is a no-op in case
> + * the block source is zero-initialized.
> + */
> +void block_source_close(struct reftable_block_source *source);
> +
> +/*
> + * Read a block of length `size` from the source at the given `off`.
> + */
> +ssize_t block_source_read_block(struct reftable_block_source *source,
> +				struct reftable_block *dest, uint64_t off,
> +				uint32_t size);
> +
> +/*
> + * Return the total length of the underlying resource.
> + */
> +uint64_t block_source_size(struct reftable_block_source *source);
> +
> +/*
> + * Return a block to its original source, releasing any resources associated
> + * with it.
> + */
> +void block_source_return_block(struct reftable_block *block);
> +
> +/* Create an in-memory block source for reading reftables. */
>  void block_source_from_buf(struct reftable_block_source *bs,
>  			   struct reftable_buf *buf);
>
> diff --git a/reftable/iter.c b/reftable/iter.c
> index 7376f263c99..6af6eb49396 100644
> --- a/reftable/iter.c
> +++ b/reftable/iter.c
> @@ -11,6 +11,7 @@
>  #include "system.h"
>
>  #include "block.h"
> +#include "blocksource.h"
>  #include "constants.h"
>  #include "reftable-error.h"
>  #include "table.h"
> @@ -113,7 +114,7 @@ static void indexed_table_ref_iter_close(void *p)
>  {
>  	struct indexed_table_ref_iter *it = p;
>  	block_iter_close(&it->cur);
> -	reftable_block_done(&it->block_reader.block);
> +	block_source_return_block(&it->block_reader.block);
>  	reftable_free(it->offsets);
>  	reftable_buf_release(&it->oid);
>  }
> @@ -127,7 +128,7 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
>  		return 1;
>  	}
>
> -	reftable_block_done(&it->block_reader.block);
> +	block_source_return_block(&it->block_reader.block);
>
>  	off = it->offsets[it->offset_idx++];
>  	err = table_init_block_reader(it->table, &it->block_reader, off,
> diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
> index 8692cd017e9..96430b629e4 100644
> --- a/reftable/reftable-blocksource.h
> +++ b/reftable/reftable-blocksource.h
> @@ -11,7 +11,8 @@
>
>  #include <stdint.h>
>
> -/* block_source is a generic wrapper for a seekable readable file.
> +/*
> + * Generic wrapper for a seekable readable file.
>   */
>  struct reftable_block_source {
>  	struct reftable_block_source_vtable *ops;
> diff --git a/reftable/table.c b/reftable/table.c
> index 440fb559ad1..d18e17b0d44 100644
> --- a/reftable/table.c
> +++ b/reftable/table.c
> @@ -10,35 +10,12 @@
>
>  #include "system.h"
>  #include "block.h"
> +#include "blocksource.h"
>  #include "constants.h"
>  #include "iter.h"
>  #include "record.h"
>  #include "reftable-error.h"
>
> -uint64_t block_source_size(struct reftable_block_source *source)
> -{
> -	return source->ops->size(source->arg);
> -}
> -
> -ssize_t block_source_read_block(struct reftable_block_source *source,
> -				struct reftable_block *dest, uint64_t off,
> -				uint32_t size)
> -{
> -	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
> -	dest->source = *source;
> -	return result;
> -}
> -
> -void block_source_close(struct reftable_block_source *source)
> -{
> -	if (!source->ops) {
> -		return;
> -	}
> -
> -	source->ops->close(source->arg);
> -	source->ops = NULL;
> -}
> -
>  static struct reftable_table_offsets *
>  table_offsets_for(struct reftable_table *t, uint8_t typ)
>  {
> @@ -249,7 +226,7 @@ int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
>  	}
>
>  	if (block_size > guess_block_size) {
> -		reftable_block_done(&block);
> +		block_source_return_block(&block);
>  		err = table_get_block(t, &block, next_off, block_size);
>  		if (err < 0) {
>  			goto done;
> @@ -259,7 +236,7 @@ int table_init_block_reader(struct reftable_table *t, struct block_reader *br,
>  	err = block_reader_init(br, &block, header_off, t->block_size,
>  				hash_size(t->hash_id));
>  done:
> -	reftable_block_done(&block);
> +	block_source_return_block(&block);
>
>  	return err;
>  }
> @@ -666,8 +643,8 @@ int reftable_table_new(struct reftable_table **out,
>  	*out = t;
>
>  done:
> -	reftable_block_done(&footer);
> -	reftable_block_done(&header);
> +	block_source_return_block(&footer);
> +	block_source_return_block(&header);
>  	if (err) {
>  		if (t)
>  			reftable_free(t->name);
> diff --git a/reftable/table.h b/reftable/table.h
> index 9cd8f80a207..8d8dd2b413d 100644
> --- a/reftable/table.h
> +++ b/reftable/table.h
> @@ -14,13 +14,6 @@
>  #include "reftable-iterator.h"
>  #include "reftable-table.h"
>
> -uint64_t block_source_size(struct reftable_block_source *source);
> -
> -ssize_t block_source_read_block(struct reftable_block_source *source,
> -				struct reftable_block *dest, uint64_t off,
> -				uint32_t size);
> -void block_source_close(struct reftable_block_source *source);
> -
>  /* metadata for a block type */
>  struct reftable_table_offsets {
>  	int is_present;
> diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
> index 22040aeefa5..8bb40482347 100644
> --- a/t/unit-tests/t-reftable-block.c
> +++ b/t/unit-tests/t-reftable-block.c
> @@ -100,7 +100,7 @@ static void t_ref_block_read_write(void)
>  	block_reader_release(&br);
>  	block_iter_close(&it);
>  	reftable_record_release(&rec);
> -	reftable_block_done(&br.block);
> +	block_source_return_block(&br.block);
>  	reftable_buf_release(&want);
>  	reftable_buf_release(&buf);
>  	for (i = 0; i < N; i++)
> @@ -190,7 +190,7 @@ static void t_log_block_read_write(void)
>  	block_reader_release(&br);
>  	block_iter_close(&it);
>  	reftable_record_release(&rec);
> -	reftable_block_done(&br.block);
> +	block_source_return_block(&br.block);
>  	reftable_buf_release(&want);
>  	reftable_buf_release(&buf);
>  	for (i = 0; i < N; i++)
> @@ -273,7 +273,7 @@ static void t_obj_block_read_write(void)
>  	block_reader_release(&br);
>  	block_iter_close(&it);
>  	reftable_record_release(&rec);
> -	reftable_block_done(&br.block);
> +	block_source_return_block(&br.block);
>  	reftable_buf_release(&want);
>  	reftable_buf_release(&buf);
>  	for (i = 0; i < N; i++)
> @@ -365,7 +365,7 @@ static void t_index_block_read_write(void)
>  	block_reader_release(&br);
>  	block_iter_close(&it);
>  	reftable_record_release(&rec);
> -	reftable_block_done(&br.block);
> +	block_source_return_block(&br.block);
>  	reftable_buf_release(&want);
>  	reftable_buf_release(&buf);
>  	for (i = 0; i < N; i++)
> diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
> index c4c27242ba9..3fba888cdaa 100644
> --- a/t/unit-tests/t-reftable-readwrite.c
> +++ b/t/unit-tests/t-reftable-readwrite.c
> @@ -32,13 +32,13 @@ static void t_buffer(void)
>  	n = block_source_read_block(&source, &out, 0, sizeof(in));
>  	check_int(n, ==, sizeof(in));
>  	check(!memcmp(in, out.data, n));
> -	reftable_block_done(&out);
> +	block_source_return_block(&out);
>
>  	n = block_source_read_block(&source, &out, 1, 2);
>  	check_int(n, ==, 2);
>  	check(!memcmp(out.data, "el", 2));
>
> -	reftable_block_done(&out);
> +	block_source_return_block(&out);
>  	block_source_close(&source);
>  	reftable_buf_release(&buf);
>  }
>
> --
> 2.49.0.604.gff1f9ca942.dirty

The changes look good to me!

--000000000000fce1740631dd6db0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 522b24bd03acb57b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdVpoOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMFlzQy80emdzZFZNN0xnUHlwbDBUYVpPU3p2UTA4MApyK3pDVUdKdHgr
YnU2MFJYVUhJVi83SGZxaTZJR20rVytEdThBZlM3RkdkaFQ2YUNTaGdDajc0WFdhNE9NdXpnCnND
ZXY4bUJXSC9OSW5NM3NWdE0rdksyRElHZUEzZ3RZc0xmN2E3T1FqblhXTlNEOTNzZzZGV0ZlaVNE
ZkRkanEKbXR4WTUzVC9qM012NndSalF4WjJQU0NJRTBFWDNOQlhiM1JDRmo2aHZ5ZXJVYjR0bFdS
SFdVTUNsM0QrL3dNNwpQVDFpREFlaURLOHZOQ2VDRjFCclhRNzRNSUxoT3EyWWZna29qZ2pxRG5y
dUZSY1h3Sk5kckxYZEg0alVpT2ljCjg4dlFkSXBVMklVN2RRQ1JpU3llYTNjcVBEMmhJK1dSVXhI
RUhGRGFzL09wKzB3ZVFTRmJtNlhFMnJ5QTNyNE4KNGx4d0huMEtKYy9PUmV6aUFqWmRxenNTeDNy
ZGZFcjJLRktnQTVvOVJiaVU4VlJtMEJzaXd2Rk5Dd01uWFRLcwprOVdrbDZiNGhzSXdSVlQ5NGh3
Z1BYVDVGNURGSFZkeGh0aWxCcmlrK1phbndreW5zY1ZwZGdjQW1XUVlsenY5Cno3R0NwaU9sc3R2
TjlTQUJMYWVkQkczMVY5blI2N3o0MkVZaEdMTT0KPUhFSXEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fce1740631dd6db0--
