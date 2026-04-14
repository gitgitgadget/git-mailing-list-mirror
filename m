Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5262824CEEA
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776206323; cv=none; b=sq0emo2wlmlwbMtJSlN37dTiWX2kWNAs90jM1era8OwOv/QQadlFx3DuIaEQYb0HdkKSCwZljKnX/S4a53kuAYD+hYV5UVm5WyIu8s9MRTaFhobn6O3ulqeDdyyYF1nbsvSeaB8rNeIhmdZyeVx7ba13KPOLCEklrvqr7pnqAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776206323; c=relaxed/simple;
	bh=sVfGx+U5kKCBK6Mx+QO4PuRyPGaHjE9GfvA6mZcRQPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfMGMPkMTL1OjvJt2VGQGtWh5ZGMrrm9T3h3waBA6FIDemOYkZ8UOM4Ts/BSkIHAcimxfbBR6nbCGA+7Zt3bGuLHdnjy4JZ/eZB7s417aylrFhnBFK/Mo0hV+ZrBtqO2sWSEl2GT3DLuP/8gC1Jtnb1RwL2aNfnDAywPTXsIfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZQBfFP7F; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZQBfFP7F"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-89f87257904so49918616d6.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776206320; x=1776811120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LwVouJmWwoeN+ck3lxynboOMbjS5y7+fh1JQhiOYqI=;
        b=ZQBfFP7FbsZFjeDhbnmfMqAqihdDIXs8OQSFesXKpfd6vUzEKKl9cxzRjEmw1LfK+R
         XiMdaXf4gGro21+NvIAOq4qwS09raZ70/WTX9J/6iMi2pTWNfApMNRtOWSjITq3RqKtt
         aQezVXPg7uy+L6njLikEko3aIIbgW0KIbVLGc6WcXIs65qO+q9Q8xDqpHVv3SPTFcchj
         mTN7m68UZUOt9iniqx3HgpVPtfxtvV5puCffv3C9UIbgb7SZ32YnfGijC/NVnACDjftv
         cWoqRWwq03qpsuSCl9hYAVbd99cRoJMXFMfzRcsuNE7GGwBuemddzh09SIf3swYpkB5f
         0Lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776206320; x=1776811120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LwVouJmWwoeN+ck3lxynboOMbjS5y7+fh1JQhiOYqI=;
        b=MMzRcVt0+z4p3T8FDPhFlWVcwvnQA9cZhS3gKLx3CTWwYZCuqIvsMHyckb3jpxzk42
         S04EtnLuRLFCwBAnpAhZLM5I0z2DcIkEjO2tUOXXHi2G3am7Ga2FM0VKnn2BnpOGZp64
         nWQ3oJTrDYyzBj5zg0BgDRvn8+CjU564SRSGNQ9g6bauvhcnjlIp/OH5Jp7IDP0iPziU
         bqdduWUI/WCwumPPtI2xJ+wSx4aYILNQmTe5weJ1SK/rxlQUadRiMmMqjewNs+4qoUHV
         8TW+3anqAcJ4KI8pRH3c2FvBc4phZ6zawIIqNw1I+63iDsK+2Qlf7nh7PZc5EoFcKlpd
         LdtA==
X-Gm-Message-State: AOJu0YxJtFyRVbRWwF3ZXZNAZs73GZL4qYKX1jL7Z+/042PaJQz5+Rza
	w1o2kzAPosHM1dzWpRkZQ5cEV0fnQzttfgxEayswfKpJIDwV180YnK5uSXHtLyWxAvE/knUyq9Z
	dk+S4rMU=
X-Gm-Gg: AeBDiev8elwodZOAuZ1j3Ai+xnEB5H4ZHiKxwxbB7UGSfHd7HE3RZK7j6uZtc9fKEZS
	lMR9f4rnjqT2GxfSyga4f1CCtexHV4VayfOUMUreGnsoVmtSkARrdRS7xVTrNPl5uoYXnt4aQYc
	FL0aztCKNgr3MFLexSu68LDmqFcd79ljVPBUhNAIHBXP6rh3vjlBotHswMyfqgjVgi8JDS9m+qM
	dIUydtk7DnqY5JaWDaPcZfTsltrcFWQdyio6ayOe6n1UZpaREik5dYUtJqfIXvnrGFz8GR7hG3J
	r1rVxykQ1iWThoaKLhavBpp3SF5+WJX2tZqDUqq9nFAAi9hiRYNFTtsIGrCe1YlbY4/BALsQk9m
	gIJcCN3nO3IIp4sJdBzJxNZeTJk/mrNiibhv6b56ctvbDtGCQhGZF0fAIRBM/ND/ZQAf1+b9teg
	hJyDc1S2duZrYQWbgJSk/xByp2dveE5jx9F7pZxrDCDmKoWMALJnRstNJeGyHCVbrXAdvmLubcu
	m/DBtBEI2vX98DdNRGEtD00HsL5FDoKoYTpXDBH7Ozu+KUGkO5qiirtTWOILww5IRNS5TeTjqhj
	11URnMSH8Zhojzfp7w4FD+lLrlQ=
X-Received: by 2002:a05:6214:1d22:b0:8a1:88f7:d292 with SMTP id 6a1803df08f44-8ac8617d9f1mr318494976d6.13.1776206319805;
        Tue, 14 Apr 2026 15:38:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84c4d798sm131557036d6.25.2026.04.14.15.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 15:38:39 -0700 (PDT)
Date: Tue, 14 Apr 2026 18:38:37 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <ad7B7cxKP7tNCXUf@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:40:50PM -0400, Taylor Blau wrote:
> OVERVIEW
> ========
>
> This series implements the third and final major component for an
> incremental MIDX/bitmap-based repacking strategy. As a refresher, those
> are:

Thanks for the review on the first round. Review seems to have
stabilized (I somehow missed the handful of messages that Peff sent on
the 7th, but just read through them and only came up with minimal
changes as a result).

For now, I'll hold off on sending a v2 until we are on the other side of
2.54 next week. In the meantime, here is a quick summary of the main
changes that that version will contain:

 - Use a strset instead of a string_list for keeping track of the MIDX
   layers to retain when calling `either clear_midx_files_ext()` or
   `clear_incremental_midx_files_ext()`.

 - A new patch to rewrite the logic for determining which MIDX layers
   comprise the new chain via keep_hashes to build the array in order.
   The subsequent patch converts that into a strvec, which no longer
   requires direct manipulation.

 - The new "--checksum-only" option has been renamed to
   "--no-write-chain-file", and various small implementation tweaks
   (e.g., relying on `is_lock_file_locked()` to determine whether we
   should update the chain file as opposed to reading the flags).

For the curious, the v2 that I'll send is currently in my fork
(available from git@github.com:ttaylorr/git.git) in a branch called
'tb/incremental-midx-part-3.3'. A range-diff of what I will likely send
is below:

--- 8< ---
 1:  0c7a68ca5a7 =  1:  2db38d41b96 midx-write: handle noop writes when converting incremental chains
 2:  1391552dfc6 !  2:  99e2c8f0cd6 midx: use `string_list` for retained MIDX files
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    midx: use `string_list` for retained MIDX files
    +    midx: use `strset` for retained MIDX files

         Both `clear_midx_files_ext()` and `clear_incremental_midx_files_ext()`
         build a list of filenames to keep while pruning stale MIDX files. Today
    -    they hand-roll an array instead of using a `string_list`, thus requiring
    -    us to pass an additional length parameter, and makes lookups linear.
    +    they hand-roll an array instead of using a `strset`, thus requiring us
    +    to pass an additional length parameter, and makes lookups linear.

    -    Replace the bare array with a `string_list` which can be passed around
    -    as a single parameter. Though it improves lookup performance, the
    -    difference is likely immeasurable given how small the keep_hashes array
    -    typically is.
    +    Replace the bare array with a `strset` which can be passed around as a
    +    single parameter. Though it improves lookup performance, the difference
    +    is likely immeasurable given how small the keep_hashes array typically
    +    is.

         Signed-off-by: Taylor Blau <me@ttaylorr.com>

    @@ midx.c: int midx_checksum_valid(struct multi_pack_index *m)
      struct clear_midx_data {
     -	char **keep;
     -	uint32_t keep_nr;
    -+	struct string_list keep;
    ++	struct strset keep;
      	const char *ext;
      };

    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -		if (!strcmp(data->keep[i], file_name))
     -			return;
     -	}
    -+	if (string_list_has_string(&data->keep, file_name))
    ++	if (strset_contains(&data->keep, file_name))
     +		return;
      	if (unlink(full_path))
      		die_errno(_("failed to remove %s"), full_path);
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -	struct clear_midx_data data;
     -	memset(&data, 0, sizeof(struct clear_midx_data));
     +	struct clear_midx_data data = {
    -+		.keep = STRING_LIST_INIT_DUP,
    ++		.keep = STRSET_INIT,
     +		.ext = ext,
     +	};

    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_

     -		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
     -		data.keep_nr = 1;
    -+		string_list_insert(&data.keep, buf.buf);
    ++		strset_add(&data.keep, buf.buf);
     +
     +		strbuf_release(&buf);
      	}
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -	if (keep_hash)
     -		free(data.keep[0]);
     -	free(data.keep);
    -+	string_list_clear(&data.keep, 0);
    ++	strset_clear(&data.keep);
      }

      void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
      {
     -	struct clear_midx_data data;
     +	struct clear_midx_data data = {
    -+		.keep = STRING_LIST_INIT_NODUP,
    ++		.keep = STRSET_INIT,
     +		.ext = ext,
     +	};
    ++	struct strbuf buf = STRBUF_INIT;
      	uint32_t i;

     -	memset(&data, 0, sizeof(struct clear_midx_data));
    --
    ++	for (i = 0; i < hashes_nr; i++) {
    ++		strbuf_reset(&buf);
    ++		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
    ++			    ext);
    +
     -	ALLOC_ARRAY(data.keep, hashes_nr);
    - 	for (i = 0; i < hashes_nr; i++)
    +-	for (i = 0; i < hashes_nr; i++)
     -		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
     -				       ext);
     -	data.keep_nr = hashes_nr;
     -	data.ext = ext;
    -+		string_list_append(&data.keep,
    -+				   xstrfmt("multi-pack-index-%s.%s",
    -+					   keep_hashes[i], ext));
    -+	string_list_sort(&data.keep);
    ++		strset_add(&data.keep, buf.buf);
    ++	}

      	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
      				     clear_midx_file_ext, &data);
    @@ midx.c: static void clear_midx_file_ext(const char *full_path, size_t full_path_
     -	for (i = 0; i < hashes_nr; i++)
     -		free(data.keep[i]);
     -	free(data.keep);
    -+	string_list_clear(&data.keep, 0);
    ++	strbuf_release(&buf);
    ++	strset_clear(&data.keep);
      }

      void clear_midx_file(struct repository *r)
 3:  aea6aad6953 <  -:  ----------- strvec: introduce `strvec_init_alloc()`
 -:  ----------- >  3:  04f1c23884c midx: build `keep_hashes` array in order
 4:  5fc72d5049a !  4:  a71c8024c1f midx: use `strvec` for `keep_hashes`
    @@ Commit message
         value is used to determine the contents of the resulting
         `multi-pack-index-chain` file when writing with "--incremental".

    +    Since the previous commit already builds the array in forward order, the
    +    conversion is straightforward: replace indexed assignments with
    +    `strvec_push()`, drop the pre-counting and `CALLOC_ARRAY()`, and
    +    simplify cleanup via `strvec_clear()`.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## midx-write.c ##
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      	int dropped_packs = 0;
      	int result = -1;
     -	const char **keep_hashes = NULL;
    +-	size_t keep_hashes_nr = 0;
     +	struct strvec keep_hashes = STRVEC_INIT;
    - 	size_t keep_hashes_nr = 0;
      	struct chunkfile *cf;

    + 	trace2_region_enter("midx", "write_midx_internal", r);
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 	} else {
    - 		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
    - 	}
    + 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
    + 		die(_("too many multi-pack-indexes"));
    +
    +-	if (ctx.compact) {
    +-		struct multi_pack_index *m;
    +-
    +-		/*
    +-		 * Keep all MIDX layers excluding those in the range [from, to].
    +-		 */
    +-		for (m = ctx.base_midx; m; m = m->base_midx)
    +-			keep_hashes_nr++;
    +-		for (m = ctx.m;
    +-		     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
    +-		     m = m->base_midx)
    +-			keep_hashes_nr++;
    +-
    +-		keep_hashes_nr++; /* include the compacted layer */
    +-	} else {
    +-		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
    +-	}
     -	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
    -+	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
    -
    +-
      	if (ctx.incremental) {
      		FILE *chainf = fdopen_lock_file(&lk, "w");
    -@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 			for (i = 0; i < num_layers_before_from; i++) {
    - 				uint32_t j = num_layers_before_from - i - 1;
    + 		struct strbuf final_midx_name = STRBUF_INIT;
    + 		struct multi_pack_index *m = ctx.base_midx;
    + 		struct multi_pack_index **layers = NULL;
    + 		size_t layers_nr = 0, layers_alloc = 0;
    +-		size_t j = 0;

    --				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.nr++;
    - 				m = m->base_midx;
    + 		if (!chainf) {
    + 			error_errno(_("unable to open multi-pack-index chain file"));
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 				layers[layers_nr++] = mp;
      			}
    + 			while (layers_nr)
    +-				keep_hashes[j++] =
    +-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    ++				strvec_push(&keep_hashes,
    ++					    midx_get_checksum_hex(layers[--layers_nr]));

    --			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
    -+			keep_hashes.v[i] = xstrdup(hash_to_hex_algop(midx_hash,
    - 								   r->hash_algo));
    -+			keep_hashes.nr++;
    +-			keep_hashes[j++] =
    +-				xstrdup(hash_to_hex_algop(midx_hash,
    +-							  r->hash_algo));
    ++			strvec_push(&keep_hashes,
    ++				    hash_to_hex_algop(midx_hash,
    ++						     r->hash_algo));

    - 			i = 0;
    - 			for (m = ctx.m;
    - 			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
    - 			     m = m->base_midx) {
    --				keep_hashes[keep_hashes_nr - i - 1] =
    -+				keep_hashes.v[keep_hashes_nr - i - 1] =
    - 					xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.nr++;
    - 				i++;
    + 			for (mp = ctx.m;
    + 			     mp && midx_hashcmp(mp, ctx.compact_to,
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 				layers[layers_nr++] = mp;
      			}
    + 			while (layers_nr)
    +-				keep_hashes[j++] =
    +-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    ++				strvec_push(&keep_hashes,
    ++					    midx_get_checksum_hex(layers[--layers_nr]));
      		} else {
    --			keep_hashes[ctx.num_multi_pack_indexes_before] =
    -+			keep_hashes.v[ctx.num_multi_pack_indexes_before] =
    - 				xstrdup(hash_to_hex_algop(midx_hash,
    - 							  r->hash_algo));
    -+			keep_hashes.nr++;
    -
    - 			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
    - 				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
    -
    --				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.v[j] = xstrdup(midx_get_checksum_hex(m));
    -+				keep_hashes.nr++;
    - 				m = m->base_midx;
    + 			for (; m; m = m->base_midx) {
    + 				ALLOC_GROW(layers, layers_nr + 1, layers_alloc);
    + 				layers[layers_nr++] = m;
      			}
    + 			while (layers_nr)
    +-				keep_hashes[j++] =
    +-					xstrdup(midx_get_checksum_hex(layers[--layers_nr]));
    ++				strvec_push(&keep_hashes,
    ++					    midx_get_checksum_hex(layers[--layers_nr]));
    +
    +-			keep_hashes[j++] =
    +-				xstrdup(hash_to_hex_algop(midx_hash,
    +-							  r->hash_algo));
    ++			strvec_push(&keep_hashes,
    ++				    hash_to_hex_algop(midx_hash,
    ++						     r->hash_algo));
      		}

    - 		for (uint32_t i = 0; i < keep_hashes_nr; i++)
    +-		ASSERT(j == keep_hashes_nr);
    +-
    + 		free(layers);
    +
    +-		for (uint32_t i = 0; i < j; i++)
     -			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
    ++		for (size_t i = 0; i < keep_hashes.nr; i++)
     +			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
      	} else {
     -		keep_hashes[ctx.num_multi_pack_indexes_before] =
    -+		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
    - 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
    -+		keep_hashes.nr++;
    +-			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
    ++		strvec_push(&keep_hashes,
    ++			    hash_to_hex_algop(midx_hash, r->hash_algo));
      	}

      	if (ctx.m || ctx.base_midx)
    @@ midx.c: void clear_midx_files_ext(struct odb_source *source, const char *ext,
     +				      const struct strvec *keep_hashes)
      {
      	struct clear_midx_data data = {
    --		.keep = STRING_LIST_INIT_NODUP,
    -+		.keep = STRING_LIST_INIT_DUP,
    + 		.keep = STRSET_INIT,
      		.ext = ext,
      	};
    + 	struct strbuf buf = STRBUF_INIT;
     -	uint32_t i;

    --	for (i = 0; i < hashes_nr; i++)
    --		string_list_append(&data.keep,
    --				   xstrfmt("multi-pack-index-%s.%s",
    --					   keep_hashes[i], ext));
    --	string_list_sort(&data.keep);
    +-	for (i = 0; i < hashes_nr; i++) {
    +-		strbuf_reset(&buf);
    +-		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hashes[i],
    +-			    ext);
     +	if (keep_hashes) {
    -+		struct strbuf buf = STRBUF_INIT;
     +		for (size_t i = 0; i < keep_hashes->nr; i++) {
     +			strbuf_reset(&buf);
    -+
     +			strbuf_addf(&buf, "multi-pack-index-%s.%s",
     +				    keep_hashes->v[i], ext);
    -+			string_list_append(&data.keep, buf.buf);
    +
    +-		strset_add(&data.keep, buf.buf);
    ++			strset_add(&data.keep, buf.buf);
     +		}
    -+
    -+		string_list_sort(&data.keep);
    -+		strbuf_release(&buf);
    -+	}
    + 	}

      	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
    - 				     clear_midx_file_ext, &data);
 5:  41cb5471bb9 !  5:  51ffdb1382d midx: introduce `--checksum-only` for incremental MIDX writes
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    midx: introduce `--checksum-only` for incremental MIDX writes
    +    midx: introduce `--no-write-chain-file` for incremental MIDX writes

         When writing an incremental MIDX layer, the MIDX machinery writes the
         new layer into the multi-pack-index.d directory and then updates the
    @@ Commit message
         assemble the new MIDX chain itself before writing a new chain file and
         atomically linking it into place).

    -    Introduce a `--checksum-only` flag that:
    +    Introduce a `--no-write-chain-file` flag that:

          * writes the new MIDX layer into the multi-pack-index.d directory

    @@ Documentation/git-multi-pack-index.adoc: SYNOPSIS
      'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
      		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
     -		         [--refs-snapshot=<path>]
    -+		         [--refs-snapshot=<path>] [--[no-]checksum-only]
    ++		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
      'git multi-pack-index' [<options>] compact [--[no-]incremental]
     -		         [--[no-]bitmap] <from> <to>
    -+		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
    ++		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
      'git multi-pack-index' [<options>] verify
      'git multi-pack-index' [<options>] expire
      'git multi-pack-index' [<options>] repack [--batch-size=<size>]
    +@@ Documentation/git-multi-pack-index.adoc: marker).
    + 		and packs not present in an existing MIDX layer.
    + 		Migrates non-incremental MIDXs to incremental ones when
    + 		necessary.
    ++
    ++	--[no-]write-chain-file::
    ++		When used with `--incremental`, write a new MIDX layer
    ++		but do not update the multi-pack-index-chain file.
    ++		The checksum of the new layer is printed to standard
    ++		output, allowing the caller to assemble and write the
    ++		chain itself. Requires `--incremental`.
    + --
    +
    + compact::
    +@@ Documentation/git-multi-pack-index.adoc: compact::
    +
    + 	--[no-]bitmap::
    + 		Control whether or not a multi-pack bitmap is written.
    ++
    ++	--[no-]write-chain-file::
    ++		When used with `--incremental`, write a new compacted
    ++		MIDX layer but do not update the multi-pack-index-chain
    ++		file. The checksum of the new layer is printed to
    ++		standard output. Requires `--incremental`.
    + --
    +
    + verify::

      ## builtin/multi-pack-index.c ##
     @@
    @@ builtin/multi-pack-index.c
      	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
      	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
     -	   "  [--refs-snapshot=<path>]")
    -+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
    ++	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")

      #define BUILTIN_MIDX_COMPACT_USAGE \
      	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
     -	   "  [--[no-]bitmap] <from> <to>")
    -+	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
    ++	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")

      #define BUILTIN_MIDX_VERIFY_USAGE \
      	N_("git multi-pack-index [<options>] verify")
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
      		OPT_BIT(0, "incremental", &opts.flags,
      			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    -+		OPT_BIT(0, "checksum-only", &opts.flags,
    -+			N_("write a MIDX layer without updating the MIDX chain"),
    -+			MIDX_WRITE_CHECKSUM_ONLY),
    ++		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
    ++			N_("write the multi-pack-index chain file"),
    ++			MIDX_WRITE_NO_CHAIN),
      		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
      			 N_("write multi-pack index containing only given indexes")),
      		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      		usage_with_options(builtin_multi_pack_index_write_usage,
      				   options);
     +
    -+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
    ++	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
     +	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
     +		error(_("cannot use %s without %s"),
    -+		      "--checksum-only", "--incremental");
    ++		      "--no-write-chain-file", "--incremental");
     +		usage_with_options(builtin_multi_pack_index_write_usage,
     +				   options);
     +	}
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, co
      			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
      		OPT_BIT(0, "incremental", &opts.flags,
      			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    -+		OPT_BIT(0, "checksum-only", &opts.flags,
    -+			N_("write a MIDX layer without updating the MIDX chain"),
    -+			MIDX_WRITE_CHECKSUM_ONLY),
    ++		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
    ++			N_("write the multi-pack-index chain file"),
    ++			MIDX_WRITE_NO_CHAIN),
      		OPT_END(),
      	};

    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, co
      		usage_with_options(builtin_multi_pack_index_compact_usage,
      				   options);
     +
    -+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
    ++	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
     +	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
     +		error(_("cannot use %s without %s"),
    -+		      "--checksum-only", "--incremental");
    ++		      "--no-write-chain-file", "--incremental");
     +		usage_with_options(builtin_multi_pack_index_compact_usage,
     +				   options);
     +	}
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, co
      	FREE_AND_NULL(options);

      ## midx-write.c ##
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 	unsigned char midx_hash[GIT_MAX_RAWSZ];
    + 	uint32_t start_pack;
    + 	struct hashfile *f = NULL;
    +-	struct lock_file lk;
    ++	struct lock_file lk = LOCK_INIT;
    + 	struct tempfile *incr;
    + 	struct write_midx_context ctx = {
    + 		.preferred_pack_idx = NO_PREFERRED_PACK,
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      	}

      	if (ctx.incremental) {
     -		struct strbuf lock_name = STRBUF_INIT;
    -+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    ++		if (!(opts->flags & MIDX_WRITE_NO_CHAIN)) {
     +			struct strbuf lock_name = STRBUF_INIT;

     -		get_midx_chain_filename(opts->source, &lock_name);
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      		incr = mks_tempfile_m(midx_name.buf, 0444);
      		if (!incr) {
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 	}
    - 	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
    + 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
    + 		die(_("too many multi-pack-indexes"));

    -+	if (opts->flags & MIDX_WRITE_CHECKSUM_ONLY)
    ++	if (!is_lock_file_locked(&lk))
     +		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));
    ++	else if (opts->flags & MIDX_WRITE_NO_CHAIN)
    ++		BUG("lockfile held with MIDX_WRITE_NO_CHAIN set?");
     +
      	if (ctx.incremental) {
     -		FILE *chainf = fdopen_lock_file(&lk, "w");
      		struct strbuf final_midx_name = STRBUF_INIT;
      		struct multi_pack_index *m = ctx.base_midx;
    + 		struct multi_pack_index **layers = NULL;
    + 		size_t layers_nr = 0, layers_alloc = 0;

     -		if (!chainf) {
     -			error_errno(_("unable to open multi-pack-index chain file"));
     -			goto cleanup;
    -+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    ++		if (is_lock_file_locked(&lk)){
     +			FILE *chainf = fdopen_lock_file(&lk, "w");
     +			if (!chainf) {
     +				error_errno(_("unable to open multi-pack-index chain file"));
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)

      		if (link_midx_to_chain(ctx.base_midx) < 0)
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 			}
    - 		}

    --		for (uint32_t i = 0; i < keep_hashes_nr; i++)
    + 		free(layers);
    +
    +-		for (size_t i = 0; i < keep_hashes.nr; i++)
     -			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
    -+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY))
    -+			for (uint32_t i = 0; i < keep_hashes_nr; i++)
    ++		if (is_lock_file_locked(&lk))
    ++			for (size_t i = 0; i < keep_hashes.nr; i++)
     +				fprintf(get_lock_file_fp(&lk), "%s\n",
     +					keep_hashes.v[i]);
      	} else {
    - 		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
    - 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
    + 		strvec_push(&keep_hashes,
    + 			    hash_to_hex_algop(midx_hash, r->hash_algo));
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      	if (ctx.m || ctx.base_midx)
      		odb_close(ctx.repo->objects);

     -	if (commit_lock_file(&lk) < 0)
     -		die_errno(_("could not write multi-pack-index"));
    -+	if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    ++	if (is_lock_file_locked(&lk)) {
     +		if (commit_lock_file(&lk) < 0)
     +			die_errno(_("could not write multi-pack-index"));

    @@ midx.h: struct multi_pack_index {
      #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
      #define MIDX_WRITE_INCREMENTAL (1 << 5)
      #define MIDX_WRITE_COMPACT (1 << 6)
    -+#define MIDX_WRITE_CHECKSUM_ONLY (1 << 7)
    ++#define MIDX_WRITE_NO_CHAIN (1 << 7)

      #define MIDX_EXT_REV "rev"
      #define MIDX_EXT_BITMAP "bitmap"
    @@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'show object from s
      	git cat-file -p 2.2
      '

    -+test_expect_success 'write MIDX layer with --checksum-only' '
    -+	test_commit checksum-only &&
    ++test_expect_success 'write MIDX layer with --no-write-chain-file' '
    ++	test_commit no-write-chain-file &&
     +	git repack -d &&
     +
     +	cp "$midx_chain" "$midx_chain.bak" &&
     +	layer="$(git multi-pack-index write --bitmap --incremental \
    -+		--checksum-only)" &&
    ++		--no-write-chain-file)" &&
     +
     +	test_cmp "$midx_chain.bak" "$midx_chain" &&
     +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
     +'
     +
    -+test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
    -+	test_must_fail git multi-pack-index write --bitmap --checksum-only 2>err &&
    -+	test_grep "cannot use --checksum-only without --incremental" err
    ++test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file' '
    ++	test_must_fail git multi-pack-index write --bitmap --no-write-chain-file 2>err &&
    ++	test_grep "cannot use --no-write-chain-file without --incremental" err
     +'
     +
      for reuse in false single multi
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with b
      	)
      '

    -+test_expect_success 'MIDX compaction with --checksum-only' '
    -+	git init midx-compact-with--checksum-only &&
    ++test_expect_success 'MIDX compaction with --no-write-chain-file' '
    ++	git init midx-compact-with--no-write-chain-file &&
     +	(
    -+		cd midx-compact-with--checksum-only &&
    ++		cd midx-compact-with--no-write-chain-file &&
     +
     +		git config maintenance.auto false &&
     +
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with b
     +		cp "$midx_chain" "$midx_chain".bak &&
     +
     +		layer="$(git multi-pack-index compact --incremental \
    -+			--checksum-only \
    ++			--no-write-chain-file \
     +			"$(nth_line 2 "$midx_chain")" \
     +			"$(nth_line 3 "$midx_chain")")" &&
     +
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with b
     +		# After writing the new layer, insert it into the chain
     +		# manually. This is done in order to make $layer visible
     +		# to the read-midx test helper below, and matches what
    -+		# the MIDX command would do without --checksum-only.
    ++		# the MIDX command would do without --no-write-chain-file.
     +		{
     +			nth_line 1 "$midx_chain.bak" &&
     +			echo $layer &&
 6:  6b42d284b79 !  6:  48893baa339 midx: support custom `--base` for incremental MIDX writes
    @@ Commit message
         If no `--base` is given, behavior is unchanged: `compact` uses "from's"
         immediate parent in the chain, and `write` appends to the existing tip.

    -    For the `write` subcommand, `--base` requires `--checksum-only`. A plain
    +    For the `write` subcommand, `--base` requires `--no-write-chain-file`. A plain
         `write --incremental` appends a new layer to the live chain tip with no
         mechanism to atomically replace it; overriding the base would produce a
         layer that does not extend the tip, breaking chain invariants. With
    -    `--checksum-only` the chain is left unmodified and the caller is
    +    `--no-write-chain-file` the chain is left unmodified and the caller is
         responsible for assembling a valid chain.

         For `compact`, no such restriction applies. The compaction operation
    @@ Documentation/git-multi-pack-index.adoc
     @@ Documentation/git-multi-pack-index.adoc: SYNOPSIS
      'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
      		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
    - 		         [--refs-snapshot=<path>] [--[no-]checksum-only]
    + 		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
     +			 [--base=<checksum>]
      'git multi-pack-index' [<options>] compact [--[no-]incremental]
    --		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
    -+		         [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]
    +-		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
    ++		         [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]
     +			 <from> <to>
      'git multi-pack-index' [<options>] verify
      'git multi-pack-index' [<options>] expire
      'git multi-pack-index' [<options>] repack [--batch-size=<size>]
     @@ Documentation/git-multi-pack-index.adoc: marker).
    - 		and packs not present in an existing MIDX layer.
    - 		Migrates non-incremental MIDXs to incremental ones when
    - 		necessary.
    + 		The checksum of the new layer is printed to standard
    + 		output, allowing the caller to assemble and write the
    + 		chain itself. Requires `--incremental`.
     +
     +	--base=<checksum>::
     +		Specify the checksum of an existing MIDX layer to use
     +		as the base when writing a new incremental layer.
     +		The special value `none` indicates that the new layer
     +		should have no base (i.e., it becomes a root layer).
    -+		Requires `--checksum-only`.
    ++		Requires `--no-write-chain-file`.
      --

      compact::
     @@ Documentation/git-multi-pack-index.adoc: compact::
    -
    - 	--[no-]bitmap::
    - 		Control whether or not a multi-pack bitmap is written.
    + 		MIDX layer but do not update the multi-pack-index-chain
    + 		file. The checksum of the new layer is printed to
    + 		standard output. Requires `--incremental`.
     +
     +	--base=<checksum>::
     +		Specify the checksum of an existing MIDX layer to use
    @@ builtin/multi-pack-index.c
      #define BUILTIN_MIDX_WRITE_USAGE \
      	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
      	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
    --	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
    -+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]\n" \
    +-	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
    ++	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]\n" \
     +	   "  [--base=<checksum>]")

      #define BUILTIN_MIDX_COMPACT_USAGE \
      	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
    --	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
    -+	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]\n" \
    +-	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
    ++	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]\n" \
     +	   "  <from> <to>")

      #define BUILTIN_MIDX_VERIFY_USAGE \
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
     +			   N_("base MIDX for incremental writes")),
      		OPT_BIT(0, "incremental", &opts.flags,
      			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    - 		OPT_BIT(0, "checksum-only", &opts.flags,
    + 		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
     @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv,
      				   options);
      	}

     +	if (opts.incremental_base &&
    -+	    !(opts.flags & MIDX_WRITE_CHECKSUM_ONLY)) {
    -+		error(_("cannot use --base without --checksum-only"));
    ++	    !(opts.flags & MIDX_WRITE_NO_CHAIN)) {
    ++		error(_("cannot use --base without --no-write-chain-file"));
     +		usage_with_options(builtin_multi_pack_index_write_usage,
     +				   options);
     +	}
    @@ midx.h: int write_midx_file(struct odb_source *source,
      int verify_midx_file(struct odb_source *source, unsigned flags);

      ## t/t5334-incremental-multi-pack-index.sh ##
    -@@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
    - 	test_grep "cannot use --checksum-only without --incremental" err
    +@@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file
    + 	test_grep "cannot use --no-write-chain-file without --incremental" err
      '

    -+test_expect_success 'write MIDX layer with --base without --checksum-only' '
    ++test_expect_success 'write MIDX layer with --base without --no-write-chain-file' '
     +	test_must_fail git multi-pack-index write --bitmap --incremental \
     +		--base=none 2>err &&
    -+	test_grep "cannot use --base without --checksum-only" err
    ++	test_grep "cannot use --base without --no-write-chain-file" err
     +'
     +
    -+test_expect_success 'write MIDX layer with --base=none and --checksum-only' '
    ++test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
     +	test_commit base-none &&
     +	git repack -d &&
     +
     +	cp "$midx_chain" "$midx_chain.bak" &&
     +	layer="$(git multi-pack-index write --bitmap --incremental \
    -+		--checksum-only --base=none)" &&
    ++		--no-write-chain-file --base=none)" &&
     +
     +	test_cmp "$midx_chain.bak" "$midx_chain" &&
     +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
     +'
     +
    -+test_expect_success 'write MIDX layer with --base=<hash> and --checksum-only' '
    ++test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
     +	test_commit base-hash &&
     +	git repack -d &&
     +
     +	cp "$midx_chain" "$midx_chain.bak" &&
     +	layer="$(git multi-pack-index write --bitmap --incremental \
    -+		--checksum-only --base="$(nth_line 1 "$midx_chain")")" &&
    ++		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
     +
     +	test_cmp "$midx_chain.bak" "$midx_chain" &&
     +	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
    @@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremen
      	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '

      ## t/t5335-compact-multi-pack-index.sh ##
    -@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --checksum-only' '
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --no-write-chain-file' '

      		layer="$(git multi-pack-index compact --incremental \
    - 			--checksum-only \
    + 			--no-write-chain-file \
     +			--base="$(nth_line 1 "$midx_chain")" \
      			"$(nth_line 2 "$midx_chain")" \
      			"$(nth_line 3 "$midx_chain")")" &&

    -@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --checksum-only' '
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --no-write-chain-file' '
      	)
      '

 7:  2d377f53407 =  7:  b4bfaa699ba repack: track the ODB source via existing_packs
 8:  6af23849f1d =  8:  901f1401bb1 midx: expose `midx_layer_contains_pack()`
 9:  5c9fea0fc78 =  9:  dced4f38fda repack-midx: factor out `repack_prepare_midx_command()`
10:  cd5eba0f665 = 10:  42a70e4edbe repack-midx: extract `repack_fill_midx_stdin_packs()`
11:  d2c667e8413 = 11:  6eb1277edca repack-geometry: prepare for incremental MIDX repacking
12:  56dc6d55974 = 12:  a1272a25fca builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
13:  e304e316ac4 = 13:  f0c3152c085 packfile: ensure `close_pack_revindex()` frees in-memory revindex
14:  8d5aa3d6fa7 ! 14:  961413b89f3 repack: implement incremental MIDX repacking
    @@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opt
     +	}
     +
     +	repack_prepare_midx_command(&cmd, opts, "write");
    -+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only", NULL);
    ++	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file", NULL);
     +	strvec_pushf(&cmd.args, "--base=%s", base ? base : "none");
     +
     +	if (preferred_pack) {
    @@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opt
     +	int ret;
     +
     +	repack_prepare_midx_command(&cmd, opts, "compact");
    -+	strvec_pushl(&cmd.args, "--incremental", "--checksum-only",
    ++	strvec_pushl(&cmd.args, "--incremental", "--no-write-chain-file",
     +		     midx_get_checksum_hex(step->u.compact.from),
     +		     midx_get_checksum_hex(step->u.compact.to), NULL);
     +
15:  e8e22d7958d = 15:  eade33bf8cb repack: introduce `--write-midx=incremental`
16:  79d5a12a390 = 16:  e674ba7741b repack: allow `--write-midx=incremental` without `--geometric`
--- >8 ---


Thanks,
Taylor
