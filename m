Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9AD19C540
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768420460; cv=none; b=GLgvjxJZ+uiWiFrqYQk1Xm0Z0UI1U7MCgHMpXAlTZdtd5tFCbfe4qNAR0A2HD7YmWmuuhdlyUsubDYFe33EjxTKysqpV2h0NuOg8sCQrCD3lW0D+vyRgn2fIy4iq2IdEpFl966B88ZxFznvUEk5ne2drAortSnXR9N1FCmR3Dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768420460; c=relaxed/simple;
	bh=UWFDx+qxWkVdBgWEq0yKuLYfmefCjeUKDSNvH6ddB+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMzaSn+dgcxikaHJ1KoqfFKtHqp+EOTv+8qkL4GDpSlXPXQN/JrV7LOhUCwNsU+VhQq89OH+Jo3lbJ7SV6B8FUVBj8TRa3SKQAZaRXUJylu88PHG7i6OxflTlhYHfaFJDXAQB3JUbAZTPMUWCjXXr9/UZSgEfpvMHNREuVl9Ld8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mUU8pxKZ; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mUU8pxKZ"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6446fcddf2fso112112d50.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 11:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768420456; x=1769025256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YLtB7jwX+CHG0JUnDA7ODGyeFtYHBou9sJ9XijiQ1bs=;
        b=mUU8pxKZEB/jzIq8Y0kMgtpBPjf7GDUdKkEKFF0RLdjX/n4WralPr95hSp3sE9KJwu
         Vcfk/iSVF1ZUiBHaZnJ3cJj3SgG9Pb5YMkJsl/yA+r4zpKxTKG6IfG0tGVyMprhcyez4
         i9SdaLm4jwFa/rOsIW22RfQ+/z3a9gVGFNwxqajrCn7xWYcn86AiR/T2wP0fc8+F5O5P
         1feCM1KXBOrUlpAurA+xX/uFt3ryaON55SH54ypqbYoms9imRM/TblhOKcPaVxa51jDy
         TsVrmfDfVLtkqgJa3PAmxfpiGhCMHuuDQFWEqrZtvVnSrgM6DKHP42YoadJuO5l1ZN5N
         i7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768420456; x=1769025256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLtB7jwX+CHG0JUnDA7ODGyeFtYHBou9sJ9XijiQ1bs=;
        b=ogpjnng54ckKqUlT40JDR+fhZokVd9Q78CSgeDFKnKB3ygzo1LGZTI7KOUhJJwDGLz
         OR/FvDrSfylXPePecFZaIM2wnJx+pAX/z19D5hh0BPMxA1//+hZh0JrTFSPLZJ3i+88v
         0TJIUoxSstldpkn6txE+5DNT2L6ttOnXP91UYSpLhlTqN2SZAM6Owp/Y8sUVobX4bP7k
         6c2kOoVl16LSyHIuH3SAWYkxaZeBePX6RQIRfo8PCUZLpmCeULRbPlfP0ZiWdNwHd9XR
         KsdvpB2V4vZeDjHOZ4XIoM097Cu8TTQKFNFiIsnsD/NaFcLg87yi2OEShfhTWQugWs/O
         HZmQ==
X-Gm-Message-State: AOJu0YzcSB0kHIRXyoaCwjqh0VfMBkgTwghMcLh7eGqSOqaZCgW4unht
	5RVmuCb3wkpFnPi2ArBfy1p6H7OEI6ZigEMag2PNvSedq9iz2MwPq7scpGaZUHcepaWCbVVuVGu
	oFKEwtUOKu+B2
X-Gm-Gg: AY/fxX5KCUagMUIgJnV6KJnVE654rV0G5l37bZk0nRPhU/O3nfDUvDK0CqoZB5Kr0Hm
	G+0rStpXlPX4sie1D5D1rAGJwSgW7xKNbkNMYM6lY//vEUupkl6VHL2vBeCmiuAThW0fuyNRSsu
	cRDxxgeicFa1Tz6EDplCdOKOHI08mF0PbjZ8uy7MHYuHhzMCpkPkza5WixLj0G7tspk7E4iUid8
	BoF4wtYDPsRn9mPu1CxEJ4cFZhwjjT0XYTOW5bnaqPBCczAZpHQruAhWRbeq/XOIF9QMDJlQoE5
	tZw9emHWhi2RJ+y8rNqifydI0wWQMypZ5cMaSK3Wr5YN7YJlfeHt+5/EPOCBgFJNvefguLZRnjB
	HQXSV9HKTHzrBQTRycG/lLnPW70vbcLPUv3kR1+JeE4IE4Jd18jcsrdKFsBPrKfisFqaTjI5/o3
	f7q3UPU5RuePukCVJ0RF2BuQqOJTIrGry52LHqgfi6eukT3XoxRtgJUu0bp9f/pmwnL9jFS1S0N
	BADenlqh3NZni04Zg==
X-Received: by 2002:a05:690e:1507:b0:640:b501:d7c9 with SMTP id 956f58d0204a3-64903b1101fmr2390198d50.21.1768420455606;
        Wed, 14 Jan 2026 11:54:15 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57a73csm93182077b3.19.2026.01.14.11.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 11:54:15 -0800 (PST)
Date: Wed, 14 Jan 2026 14:54:13 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/18] midx: incremental MIDX/bitmap layer compaction
Message-ID: <cover.1768420450.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

[Note to the maintainer: this is based on 'master' with my
'tb/midx-write-corrupt-checksum-fix' merged in and should produce zero
conflicts when applied on top.]

This is a reroll of my series to implement MIDX layer compaction
adjusted in response to reviewer feedback.

As usual, a range-diff is included below for convenience. The main
changes since last time are as follows:

 - The MIDX file format has been bumped to version 2 to avoid breaking
   external implementations which may not be prepared to gracefully
   degrade away from the MIDX when encountering a non-sorted PNAM
   chunk.

 - I adjusted the names of the two functions which were split out from
   "get_midx_checksum()" to be "midx_get_checksum_hash()" and
   "midx_get_checksum_hex()" to match the hex.h API convention.

Along with those, there are a handful of more minor/cosmetic changes
that are also included in this round:

 - Explicitly declared the write_midx_opts struct from
   expire_midx_packs() instead of making use of compound literal
   syntax, for which we have an in-flight weather balloon.

 - Docfix to remove an incorrect statement suggesting that the options
   "--bitmap" and "--incremental" are incompatible with one another
   when used in conjunction with "git multi-pack-index compact".

 - Explicit checks and tests for bogus compaction scenarios (e.g.,
   missing from/to, to as an ancestor of from, etc.).

 - Various wording changes and a small handful of typofixes.

The original cover letter may be found here[1].

Thanks in advance for your review!

[1]: https://lore.kernel.org/git/cover.1765053054.git.me@ttaylorr.com/

Taylor Blau (18):
  midx: mark `get_midx_checksum()` arguments as const
  midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
  midx: introduce `midx_get_checksum_hex()`
  builtin/multi-pack-index.c: make '--progress' a common option
  git-multi-pack-index(1): remove non-existent incompatibility
  git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
  t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
  midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
  midx-write.c: introduce `struct write_midx_opts`
  midx: do not require packs to be sorted in lexicographic order
  git-compat-util.h: introduce `u32_add()`
  midx-write.c: introduce `midx_pack_perm()` helper
  midx-write.c: extract `fill_pack_from_midx()`
  midx-write.c: enumerate `pack_int_id` values directly
  midx-write.c: factor fanout layering from `compute_sorted_entries()`
  t/helper/test-read-midx.c: plug memory leak when selecting layer
  midx: implement MIDX compaction
  midx: enable reachability bitmaps during MIDX compaction

 Documentation/git-multi-pack-index.adoc |  27 +-
 Documentation/gitformat-pack.adoc       |   6 +-
 builtin/multi-pack-index.c              |  91 ++++-
 git-compat-util.h                       |   8 +
 midx-write.c                            | 499 +++++++++++++++++++-----
 midx.c                                  |  39 +-
 midx.h                                  |  12 +-
 pack-bitmap.c                           |   9 +-
 pack-revindex.c                         |   4 +-
 t/helper/test-read-midx.c               |  21 +-
 t/meson.build                           |   1 +
 t/t0450/adoc-help-mismatches            |   1 -
 t/t5319-multi-pack-index.sh             |  18 +-
 t/t5335-compact-multi-pack-index.sh     | 293 ++++++++++++++
 14 files changed, 879 insertions(+), 150 deletions(-)
 create mode 100755 t/t5335-compact-multi-pack-index.sh

Range-diff against v1:
 1:  1ee8b752279 !  1:  2e549ea6443 midx: mark `get_midx_checksum()` arguments as const
    @@ Metadata
      ## Commit message ##
         midx: mark `get_midx_checksum()` arguments as const
     
    -    To make clear that the fucntion `get_midx_checksum()` does not do
    +    To make clear that the function `get_midx_checksum()` does not do
         anything to modify its argument, mark the MIDX pointer as const.
     
         The following commit will rename this function altogether to make clear
 2:  57125303758 !  2:  7255adafe70 midx: split `get_midx_checksum()` by adding `get_midx_hash()`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx: split `get_midx_checksum()` by adding `get_midx_hash()`
    +    midx: rename `get_midx_checksum()` to `midx_get_checksum_hash()`
     
    -    When trying to print out, say, the hexadecimal representation of a
    -    MIDX's hash, our code will do something like:
    +    Since 541204aabea (Documentation: document naming schema for structs and
    +    their functions, 2024-07-30), we have adopted a naming convention for
    +    functions that would prefer a name like, say, `midx_get_checksum()` over
    +    `get_midx_checksum()`.
     
    -        hash_to_hex_algop(get_midx_checksum(m),
    -                          m->source->odb->repo->hash_algo);
    -
    -    , which is both cumbersome and repetitive. In fact, all but a handful of
    -    callers to `get_midx_checksum()` do exactly the above. Reduce the
    -    repetitive nature of calling `get_midx_checksum()` by having it return a
    -    pointer into a static buffer containing the above result.
    -
    -    For the handful of callers that do need to compare the raw bytes and
    -    don't want to deal with an encoded copy (e.g., because they are passing
    -    it to hasheq() or similar), introduce `get_midx_hash()` which returns
    -    the raw bytes.
    +    Adopt this convention throughout the midx.h API. Since this function
    +    returns a raw (that is, non-hex encoded) hash, let's suffix the function
    +    with "_hash()" to make this clear. As a side effect, this prepares us
    +    for the subsequent change which will introduce a "_hex()" variant that
    +    encodes the checksum itself.
     
    +    Suggested-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx-write.c ##
    @@ midx-write.c: static int link_midx_to_chain(struct multi_pack_index *m)
      
      	for (i = 0; i < ARRAY_SIZE(midx_exts); i++) {
     -		const unsigned char *hash = get_midx_checksum(m);
    -+		const unsigned char *hash = get_midx_hash(m);
    ++		const unsigned char *hash = midx_get_checksum_hash(m);
      
      		get_midx_filename_ext(m->source, &from,
      				      hash, midx_exts[i].non_split);
    @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
      			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
      				error(_("could not load reverse index for MIDX %s"),
     -				      hash_to_hex_algop(get_midx_checksum(m),
    --							m->source->odb->repo->hash_algo));
    -+				      get_midx_checksum(m));
    ++				      hash_to_hex_algop(midx_get_checksum_hash(m),
    + 							m->source->odb->repo->hash_algo));
      				goto cleanup;
      			}
    - 			ctx.num_multi_pack_indexes_before++;
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
      		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
      			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
      
     -			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
    --								   r->hash_algo));
    -+			keep_hashes[j] = xstrdup(get_midx_checksum(m));
    ++			keep_hashes[j] = xstrdup(hash_to_hex_algop(midx_get_checksum_hash(m),
    + 								   r->hash_algo));
      			m = m->base_midx;
      		}
    - 
     
      ## midx.c ##
     @@ midx.c: void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
    @@ midx.c: void clear_incremental_midx_files_ext(struct odb_source *source, const c
      			 const char *idx_name);
      
     -const unsigned char *get_midx_checksum(const struct multi_pack_index *m)
    -+const char *get_midx_checksum(const struct multi_pack_index *m)
    -+{
    -+	return hash_to_hex_algop(get_midx_hash(m),
    -+				 m->source->odb->repo->hash_algo);
    -+}
    -+
    -+const unsigned char *get_midx_hash(const struct multi_pack_index *m)
    ++const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m)
      {
      	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
      }
    @@ midx.h: struct multi_pack_index {
      #define MIDX_EXT_MIDX "midx"
      
     -const unsigned char *get_midx_checksum(const struct multi_pack_index *m);
    -+const char *get_midx_checksum(const struct multi_pack_index *m) /* static buffer */;
    -+const unsigned char *get_midx_hash(const struct multi_pack_index *m);
    ++const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m);
      void get_midx_filename(struct odb_source *source, struct strbuf *out);
      void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
      			   const unsigned char *hash, const char *ext);
    @@ pack-bitmap.c: char *midx_bitmap_filename(struct multi_pack_index *midx)
      	if (midx->has_chain)
      		get_split_midx_filename_ext(midx->source, &buf,
     -					    get_midx_checksum(midx),
    -+					    get_midx_hash(midx),
    ++					    midx_get_checksum_hash(midx),
      					    MIDX_EXT_BITMAP);
      	else
      		get_midx_filename_ext(midx->source, &buf,
     -				      get_midx_checksum(midx),
    -+				      get_midx_hash(midx),
    ++				      midx_get_checksum_hash(midx),
      				      MIDX_EXT_BITMAP);
      
      	return strbuf_detach(&buf, NULL);
    @@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
      		goto cleanup;
      
     -	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
    -+	if (!hasheq(get_midx_hash(bitmap_git->midx), bitmap_git->checksum,
    ++	if (!hasheq(midx_get_checksum_hash(bitmap_git->midx), bitmap_git->checksum,
      		    bitmap_repo(bitmap_git)->hash_algo)) {
      		error(_("checksum doesn't match in MIDX and bitmap"));
      		goto cleanup;
    @@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
      		if (bitmap_is_midx(found))
      			fprintf_ln(stderr, "Located via MIDX '%s'.",
     -				   hash_to_hex_algop(get_midx_checksum(found->midx),
    --						     revs->repo->hash_algo));
    -+				   get_midx_checksum(found->midx));
    ++				   hash_to_hex_algop(midx_get_checksum_hash(found->midx),
    + 						     revs->repo->hash_algo));
      		else
      			fprintf_ln(stderr, "Located via pack '%s'.",
    - 				   hash_to_hex_algop(found->pack->hash,
     
      ## pack-revindex.c ##
     @@ pack-revindex.c: int load_midx_revindex(struct multi_pack_index *m)
    @@ pack-revindex.c: int load_midx_revindex(struct multi_pack_index *m)
      	if (m->has_chain)
      		get_split_midx_filename_ext(m->source, &revindex_name,
     -					    get_midx_checksum(m),
    -+					    get_midx_hash(m),
    ++					    midx_get_checksum_hash(m),
      					    MIDX_EXT_REV);
      	else
      		get_midx_filename_ext(m->source, &revindex_name,
     -				      get_midx_checksum(m),
    -+				      get_midx_hash(m),
    ++				      midx_get_checksum_hash(m),
      				      MIDX_EXT_REV);
      
      	ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,
    @@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir, con
      
      	if (checksum) {
     -		while (m && strcmp(hash_to_hex(get_midx_checksum(m)), checksum))
    -+		while (m && strcmp(get_midx_checksum(m), checksum))
    ++		while (m && strcmp(hash_to_hex(midx_get_checksum_hash(m)), checksum))
      			m = m->base_midx;
      		if (!m)
      			return 1;
    @@ t/helper/test-read-midx.c: static int read_midx_checksum(const char *object_dir)
      	if (!m)
      		return 1;
     -	printf("%s\n", hash_to_hex(get_midx_checksum(m)));
    -+	printf("%s\n", get_midx_checksum(m));
    ++	printf("%s\n", hash_to_hex(midx_get_checksum_hash(m)));
      
      	close_midx(m);
      	return 0;
15:  c2149ae5bc5 !  3:  25b628fda97 t/helper/test-read-midx.c: plug memory leak when selecting layer
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    t/helper/test-read-midx.c: plug memory leak when selecting layer
    +    midx: introduce `midx_get_checksum_hex()`
     
    -    Though our 'read-midx' test tool is capable of printing information
    -    about a single MIDX layer identified by its checksum, no caller in our
    -    test suite exercises this path.
    +    When trying to print out, say, the hexadecimal representation of a
    +    MIDX's hash, our code will do something like:
     
    -    Unfortunately, there is a memory leak lurking in this (currently) unused
    -    path that would otherwise be exposed by the following commit.
    +        hash_to_hex_algop(midx_get_checksum_hash(m),
    +                          m->source->odb->repo->hash_algo);
     
    -    This occurs when providing a MIDX layer checksum other than the tip. As
    -    we walk over the MIDX chain trying to find the matching layer, we drop
    -    our reference to the top-most MIDX layer. Thus, our call to
    -    'close_midx()' later on leaks memory between the top-most MIDX layer and
    -    the MIDX layer immediately following the specified one.
    +    , which is both cumbersome and repetitive. In fact, all but a handful of
    +    callers to `midx_get_checksum_hash()` do exactly the above. Reduce the
    +    repetitive nature of calling `midx_get_checksum_hash()` by having it
    +    return a pointer into a static buffer containing the above result.
     
    -    Plug this leak by holding a reference to the tip of the MIDX chain, and
    -    ensure that we call `close_midx()` before terminating the test tool.
    +    For the handful of callers that do need to compare the raw bytes and
    +    don't want to deal with an encoded copy (e.g., because they are passing
    +    it to hasheq() or similar), they may still rely on
    +    `midx_get_checksum_hash()` which returns the raw bytes.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## t/helper/test-read-midx.c ##
    -@@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir, const char *checksum,
    - 			  int show_objects)
    + ## midx-write.c ##
    +@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
    + 		while (m) {
    + 			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
    + 				error(_("could not load reverse index for MIDX %s"),
    +-				      hash_to_hex_algop(midx_get_checksum_hash(m),
    +-							m->source->odb->repo->hash_algo));
    ++				      midx_get_checksum_hex(m));
    + 				goto cleanup;
    + 			}
    + 			ctx.num_multi_pack_indexes_before++;
    +@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
    + 		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
    + 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
    + 
    +-			keep_hashes[j] = xstrdup(hash_to_hex_algop(midx_get_checksum_hash(m),
    +-								   r->hash_algo));
    ++			keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
    + 			m = m->base_midx;
    + 		}
    + 
    +
    + ## midx.c ##
    +@@ midx.c: void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext
    + int cmp_idx_or_pack_name(const char *idx_or_pack_name,
    + 			 const char *idx_name);
    + 
    ++const char *midx_get_checksum_hex(const struct multi_pack_index *m)
    ++{
    ++	return hash_to_hex_algop(midx_get_checksum_hash(m),
    ++				 m->source->odb->repo->hash_algo);
    ++}
    ++
    + const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m)
      {
    - 	uint32_t i;
    --	struct multi_pack_index *m;
    -+	struct multi_pack_index *m, *tip;
    -+	int ret = 0;
    + 	return m->data + m->data_len - m->source->odb->repo->hash_algo->rawsz;
    +
    + ## midx.h ##
    +@@ midx.h: struct multi_pack_index {
    + #define MIDX_EXT_BITMAP "bitmap"
    + #define MIDX_EXT_MIDX "midx"
      
    --	m = setup_midx(object_dir);
    -+	m = tip = setup_midx(object_dir);
    ++const char *midx_get_checksum_hex(const struct multi_pack_index *m) /* static buffer */;
    + const unsigned char *midx_get_checksum_hash(const struct multi_pack_index *m);
    + void get_midx_filename(struct odb_source *source, struct strbuf *out);
    + void get_midx_filename_ext(struct odb_source *source, struct strbuf *out,
    +
    + ## pack-bitmap.c ##
    +@@ pack-bitmap.c: void test_bitmap_walk(struct rev_info *revs)
      
    - 	if (!m)
    - 		return 1;
    + 		if (bitmap_is_midx(found))
    + 			fprintf_ln(stderr, "Located via MIDX '%s'.",
    +-				   hash_to_hex_algop(midx_get_checksum_hash(found->midx),
    +-						     revs->repo->hash_algo));
    ++				   midx_get_checksum_hex(found->midx));
    + 		else
    + 			fprintf_ln(stderr, "Located via pack '%s'.",
    + 				   hash_to_hex_algop(found->pack->hash,
    +
    + ## t/helper/test-read-midx.c ##
     @@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir, const char *checksum,
    + 		return 1;
    + 
      	if (checksum) {
    - 		while (m && strcmp(get_midx_checksum(m), checksum))
    +-		while (m && strcmp(hash_to_hex(midx_get_checksum_hash(m)), checksum))
    ++		while (m && strcmp(midx_get_checksum_hex(m), checksum))
      			m = m->base_midx;
    --		if (!m)
    --			return 1;
    -+		if (!m) {
    -+			ret = error(_("could not find MIDX with checksum %s"),
    -+				    checksum);
    -+			goto out;
    -+		}
    - 	}
    - 
    - 	printf("header: %08x %d %d %d %d\n",
    -@@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir, const char *checksum,
    - 		}
    - 	}
    - 
    --	close_midx(m);
    -+out:
    -+	close_midx(tip);
    - 
    --	return 0;
    -+	return ret;
    - }
    - 
    - static int read_midx_checksum(const char *object_dir)
    + 		if (!m)
    + 			return 1;
    +@@ t/helper/test-read-midx.c: static int read_midx_checksum(const char *object_dir)
    + 	m = setup_midx(object_dir);
    + 	if (!m)
    + 		return 1;
    +-	printf("%s\n", hash_to_hex(midx_get_checksum_hash(m)));
    ++	printf("%s\n", midx_get_checksum_hex(m));
    + 
    + 	close_midx(m);
    + 	return 0;
 3:  d35c709632b =  4:  2aedd72db8c builtin/multi-pack-index.c: make '--progress' a common option
 4:  6111a1f5abd =  5:  a00598a36a3 git-multi-pack-index(1): remove non-existent incompatibility
 5:  630a53adbd6 =  6:  92e6d868a45 git-multi-pack-index(1): align SYNOPSIS with 'git multi-pack-index -h'
 6:  6dd59967876 =  7:  ff599c11f68 t/t5319-multi-pack-index.sh: fix copy-and-paste error in t5319.39
 7:  7f498a02ce7 !  8:  315a0ea2985 midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
    @@ Metadata
      ## Commit message ##
         midx-write.c: don't use `pack_perm` when assigning `bitmap_pos`
     
    -    In midx_pack_order(), we compute for each bitampped pack the first bit
    +    In midx_pack_order(), we compute for each bitmapped pack the first bit
         to correspond to an object in that pack, along with how many bits were
         assigned to object(s) in that pack.
     
 8:  687a2f50337 !  9:  af174e22e1e midx-write.c: introduce `struct write_midx_opts`
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## midx-write.c ##
    -@@ midx-write.c: static void clear_midx_files(struct odb_source *source,
    - 	strbuf_release(&buf);
    +@@ midx-write.c: static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
    + 	return needed;
      }
      
     -static int write_midx_internal(struct odb_source *source,
    @@ midx-write.c: static void clear_midx_files(struct odb_source *source,
     -			       const char *refs_snapshot,
     -			       unsigned flags)
     +struct write_midx_opts {
    -+	struct odb_source *source;
    ++	struct odb_source *source; /* non-optional */
     +
     +	struct string_list *packs_to_include;
     +	struct string_list *packs_to_drop;
    @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     -			if (flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
     +			if (opts->flags & MIDX_WRITE_BITMAP && load_midx_revindex(m)) {
      				error(_("could not load reverse index for MIDX %s"),
    - 				      get_midx_checksum(m));
    + 				      midx_get_checksum_hex(m));
      				goto cleanup;
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
      	start_pack = ctx.nr;
    @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     +	for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
      	stop_progress(&ctx.progress);
      
    - 	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
    - 	    !ctx.incremental &&
    --	    !(packs_to_include || packs_to_drop)) {
    -+	    !(opts->packs_to_include || opts->packs_to_drop)) {
    - 		struct bitmap_index *bitmap_git;
    - 		int bitmap_exists;
    --		int want_bitmap = flags & MIDX_WRITE_BITMAP;
    -+		int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
    +-	if (!packs_to_drop) {
    ++	if (!opts->packs_to_drop) {
    + 		/*
    + 		 * If there is no MIDX then either it doesn't exist, or we're
    + 		 * doing a geometric repack. Try to load it from the source to
    +@@ midx-write.c: static int write_midx_internal(struct odb_source *source,
    + 		if (midx && !midx_needs_update(midx, &ctx)) {
    + 			struct bitmap_index *bitmap_git;
    + 			int bitmap_exists;
    +-			int want_bitmap = flags & MIDX_WRITE_BITMAP;
    ++			int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
      
    - 		bitmap_git = prepare_midx_bitmap_git(ctx.m);
    - 		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
    + 			bitmap_git = prepare_midx_bitmap_git(midx);
    + 			bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
    - 			 * corresponding bitmap (or one wasn't requested).
    - 			 */
    - 			if (!want_bitmap)
    --				clear_midx_files_ext(source, "bitmap", NULL);
    -+				clear_midx_files_ext(opts->source, "bitmap",
    -+						     NULL);
    - 			result = 0;
    - 			goto cleanup;
    - 		}
    + 				 * corresponding bitmap (or one wasn't requested).
    + 				 */
    + 				if (!want_bitmap)
    +-					clear_midx_files_ext(source, "bitmap", NULL);
    ++					clear_midx_files_ext(ctx.source, "bitmap", NULL);
    + 				result = 0;
    + 				goto cleanup;
    + 			}
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
      		goto cleanup; /* nothing to do */
      	}
    @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
     -	if (flags & MIDX_WRITE_BITMAP) {
     +	if (opts->flags & MIDX_WRITE_BITMAP) {
      		struct packing_data pdata;
    - 		struct commit **commits;
    - 		uint32_t commits_nr;
    + 		struct commit_stack commits = COMMIT_STACK_INIT;
    + 
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
      
      		prepare_midx_packing_data(&pdata, &ctx);
      
    --		commits = find_commits_for_midx_bitmap(&commits_nr, refs_snapshot, &ctx);
    -+		commits = find_commits_for_midx_bitmap(&commits_nr, opts->refs_snapshot, &ctx);
    +-		find_commits_for_midx_bitmap(&commits, refs_snapshot, &ctx);
    ++		find_commits_for_midx_bitmap(&commits, opts->refs_snapshot, &ctx);
      
      		/*
      		 * The previous steps translated the information from
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
    + 		FREE_AND_NULL(ctx.entries);
    + 		ctx.entries_nr = 0;
      
    - 		if (write_midx_bitmap(&ctx,
    - 				      midx_hash, &pdata, commits, commits_nr,
    --				      flags) < 0) {
    -+				      opts->flags) < 0) {
    +-		if (write_midx_bitmap(&ctx, midx_hash, &pdata,
    +-				      commits.items, commits.nr, flags) < 0) {
    ++		if (write_midx_bitmap(&ctx, midx_hash, &pdata, commits.items,
    ++				      commits.nr, opts->flags) < 0) {
      			error(_("could not write multi-pack bitmap"));
      			clear_packing_data(&pdata);
    - 			free(commits);
    + 			commit_stack_clear(&commits);
     @@ midx-write.c: static int write_midx_internal(struct odb_source *source,
      		if (link_midx_to_chain(ctx.base_midx) < 0)
      			goto cleanup;
    @@ midx-write.c: int write_midx_file_only(struct odb_source *source,
      
      int expire_midx_packs(struct odb_source *source, unsigned flags)
     @@ midx-write.c: int expire_midx_packs(struct odb_source *source, unsigned flags)
    + 
      	free(count);
      
    - 	if (packs_to_drop.nr)
    +-	if (packs_to_drop.nr)
     -		result = write_midx_internal(source, NULL,
     -					     &packs_to_drop, NULL, NULL, flags);
    -+		result = write_midx_internal(&(struct write_midx_opts) {
    -+					     .source = source,
    -+					     .packs_to_drop = &packs_to_drop,
    -+					     .flags = flags & MIDX_PROGRESS,
    -+					     });
    ++	if (packs_to_drop.nr) {
    ++		struct write_midx_opts opts = {
    ++			.source = source,
    ++			.packs_to_drop = &packs_to_drop,
    ++			.flags = flags & MIDX_PROGRESS,
    ++		};
    ++		result = write_midx_internal(&opts);
    ++	}
      
      	string_list_clear(&packs_to_drop, 0);
      
    +@@ midx-write.c: int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
    + 	struct child_process cmd = CHILD_PROCESS_INIT;
    + 	FILE *cmd_in;
    + 	struct multi_pack_index *m = get_multi_pack_index(source);
    ++	struct write_midx_opts opts = {
    ++		.source = source,
    ++		.flags = flags,
    ++	};
    + 
    + 	/*
    + 	 * When updating the default for these configuration
     @@ midx-write.c: int midx_repack(struct odb_source *source, size_t batch_size, unsigned flags)
      		goto cleanup;
      	}
      
     -	result = write_midx_internal(source, NULL, NULL, NULL, NULL,
     -				     flags);
    -+	result = write_midx_internal(&(struct write_midx_opts) {
    -+				     .source = source,
    -+				     .flags = flags,
    -+				     });
    ++	result = write_midx_internal(&opts);
      
      cleanup:
      	free(include_pack);
 9:  66ae4bc8c0a ! 10:  72bcd4ed6c7 midx: do not require packs to be sorted in lexicographic order
    @@ Commit message
         lazily instantiate a `pack_names_sorted` array on the MIDX, which will
         be used to implement the binary search over pack names.
     
    -    Note that this produces MIDXs which may be incompatible with earlier
    -    versions of Git that have stricter requirements on the layout of packs
    -    within a MIDX. This patch does *not* modify the version number of the
    -    MIDX format, since existing versions of Git already know to gracefully
    -    ignore a MIDX with packs that appear out-of-order.
    +    Because this change produces MIDXs which may not be correctly read with
    +    external tools or older versions of Git. Though older versions of Git
    +    know how to gracefully degrade and ignore any MIDX(s) they consider
    +    corrupt, external tools may not be as robust. To avoid unintentionally
    +    breaking any such tools, guard this change behind a version bump in the
    +    MIDX's on-disk format.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## Documentation/gitformat-pack.adoc ##
    +@@ Documentation/gitformat-pack.adoc: HEADER:
    + 	    The signature is: {'M', 'I', 'D', 'X'}
    + 
    + 	1-byte version number:
    +-	    Git only writes or recognizes version 1.
    ++	    Git only writes version 2, but recognizes versions 1 and 2.
    + 
    + 	1-byte Object Id Version
    + 	    We infer the length of object IDs (OIDs) from this value:
    +@@ Documentation/gitformat-pack.adoc: CHUNK DATA:
    + 	    strings. There is no extra padding between the filenames,
    + 	    and they are listed in lexicographic order. The chunk itself
    + 	    is padded at the end with between 0 and 3 NUL bytes to make the
    +-	    chunk size a multiple of 4 bytes.
    ++	    chunk size a multiple of 4 bytes. Version 1 MIDXs are required to
    ++	    list their packs in lexicographic order, but version 2 MIDXs may
    ++	    list their packs in any arbitrary order.
    + 
    + 	Bitmapped Packfiles (ID: {'B', 'T', 'M', 'P'})
    + 	    Stores a table of two 4-byte unsigned integers in network order.
    +
      ## midx-write.c ##
    +@@ midx-write.c: extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
    + 
    + static size_t write_midx_header(const struct git_hash_algo *hash_algo,
    + 				struct hashfile *f, unsigned char num_chunks,
    +-				uint32_t num_packs)
    ++				uint32_t num_packs, int version)
    + {
    ++	if (version != MIDX_VERSION_V1 && version != MIDX_VERSION_V2)
    ++		BUG("unexpected MIDX version: %d", version);
    ++
    + 	hashwrite_be32(f, MIDX_SIGNATURE);
    +-	hashwrite_u8(f, MIDX_VERSION);
    ++	hashwrite_u8(f, version);
    + 	hashwrite_u8(f, oid_version(hash_algo));
    + 	hashwrite_u8(f, num_chunks);
    + 	hashwrite_u8(f, 0); /* unused */
    +@@ midx-write.c: struct write_midx_context {
    + 
    + 	uint32_t preferred_pack_idx;
    + 
    ++	int version; /* must be MIDX_VERSION_V1 or _V2 */
    ++
    + 	int incremental;
    + 	uint32_t num_multi_pack_indexes_before;
    + 
     @@ midx-write.c: static int write_midx_pack_names(struct hashfile *f, void *data)
      		if (ctx->info[i].expired)
      			continue;
      
     -		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
    --			BUG("incorrect pack-file order: %s before %s",
    --			    ctx->info[i - 1].pack_name,
    --			    ctx->info[i].pack_name);
    --
    - 		writelen = strlen(ctx->info[i].pack_name) + 1;
    - 		hashwrite(f, ctx->info[i].pack_name, writelen);
    - 		written += writelen;
    ++		if (ctx->version == MIDX_VERSION_V1 &&
    ++		    i && strcmp(ctx->info[i].pack_name,
    ++				ctx->info[i - 1].pack_name) <= 0)
    + 			BUG("incorrect pack-file order: %s before %s",
    + 			    ctx->info[i - 1].pack_name,
    + 			    ctx->info[i].pack_name);
    +@@ midx-write.c: static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
    + 	if (!midx_checksum_valid(midx))
    + 		goto out;
    + 
    ++	/*
    ++	 * If the version differs, we need to update.
    ++	 */
    ++	if (midx->version != ctx->version)
    ++		goto out;
    ++
    + 	/*
    + 	 * Ignore incremental updates for now. The assumption is that any
    + 	 * incremental update would be either empty (in which case we will bail
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 	struct tempfile *incr;
    + 	struct write_midx_context ctx = {
    + 		.preferred_pack_idx = NO_PREFERRED_PACK,
    ++		.version = MIDX_VERSION_V2,
    + 	 };
    + 	struct multi_pack_index *midx_to_free = NULL;
    + 	int bitmapped_packs_concat_len = 0;
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 	ctx.repo = r;
    + 	ctx.source = opts->source;
    + 
    ++	repo_config_get_int(ctx.repo, "midx.version", &ctx.version);
    ++	if (ctx.version != MIDX_VERSION_V1 && ctx.version != MIDX_VERSION_V2)
    ++		die(_("unknown MIDX version: %d"), ctx.version);
    ++
    + 	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
    + 
    + 	if (ctx.incremental)
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 	}
    + 
    + 	write_midx_header(r->hash_algo, f, get_num_chunks(cf),
    +-			  ctx.nr - dropped_packs);
    ++			  ctx.nr - dropped_packs, ctx.version);
    + 	write_chunkfile(cf, &ctx);
    + 
    + 	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
     
      ## midx.c ##
     @@ midx.c: static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
    - 		if (!end)
    + 		      m->signature, MIDX_SIGNATURE);
    + 
    + 	m->version = m->data[MIDX_BYTE_FILE_VERSION];
    +-	if (m->version != MIDX_VERSION)
    ++	if (m->version != MIDX_VERSION_V1 && m->version != MIDX_VERSION_V2)
    + 		die(_("multi-pack-index version %d not recognized"),
    + 		      m->version);
    + 
    +@@ midx.c: static struct multi_pack_index *load_multi_pack_index_one(struct odb_source *sou
      			die(_("multi-pack-index pack-name chunk is too short"));
      		cur_pack_name = end + 1;
    --
    + 
     -		if (i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
    --			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
    --			      m->pack_names[i - 1],
    --			      m->pack_names[i]);
    - 	}
    - 
    - 	trace2_data_intmax("midx", r, "load/num_packs", m->num_packs);
    ++		if (m->version == MIDX_VERSION_V1 &&
    ++		    i && strcmp(m->pack_names[i], m->pack_names[i - 1]) <= 0)
    + 			die(_("multi-pack-index pack names out of order: '%s' before '%s'"),
    + 			      m->pack_names[i - 1],
    + 			      m->pack_names[i]);
     @@ midx.c: void close_midx(struct multi_pack_index *m)
      	}
      	FREE_AND_NULL(m->packs);
    @@ midx.c: int cmp_idx_or_pack_name(const char *idx_or_pack_name,
      {
      	uint32_t first = 0, last = m->num_packs;
      
    -+	if (!m->pack_names_sorted) {
    ++	if (m->version == MIDX_VERSION_V2 && !m->pack_names_sorted) {
     +		uint32_t i;
     +
     +		ALLOC_ARRAY(m->pack_names_sorted, m->num_packs);
    @@ midx.c: int cmp_idx_or_pack_name(const char *idx_or_pack_name,
      		int cmp;
      
     -		current = m->pack_names[mid];
    -+		current = m->pack_names[m->pack_names_sorted[mid]];
    ++		if (m->pack_names_sorted)
    ++			current = m->pack_names[m->pack_names_sorted[mid]];
    ++		else
    ++			current = m->pack_names[mid];
      		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
      		if (!cmp)
      			return 1;
     
      ## midx.h ##
    +@@ midx.h: struct git_hash_algo;
    + struct odb_source;
    + 
    + #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
    +-#define MIDX_VERSION 1
    ++#define MIDX_VERSION_V1 1
    ++#define MIDX_VERSION_V2 2
    + #define MIDX_BYTE_FILE_VERSION 4
    + #define MIDX_BYTE_HASH_VERSION 5
    + #define MIDX_BYTE_NUM_CHUNKS 6
     @@ midx.h: struct multi_pack_index {
      	uint32_t num_packs_in_base;
      
    @@ midx.h: struct multi_pack_index {
      
     
      ## t/t5319-multi-pack-index.sh ##
    +@@ t/t5319-multi-pack-index.sh: midx_read_expect () {
    + 	EXTRA_CHUNKS="$5"
    + 	{
    + 		cat <<-EOF &&
    +-		header: 4d494458 1 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
    ++		header: 4d494458 2 $HASH_LEN $NUM_CHUNKS $NUM_PACKS
    + 		chunks: pack-names oid-fanout oid-lookup object-offsets$EXTRA_CHUNKS
    + 		num_objects: $NUM_OBJECTS
    + 		packs:
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'verify invalid chunk offset' '
      		"improper chunk offset(s)"
      '
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'verify invalid chunk offset' '
      test_expect_success 'verify missing pack' '
      	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
      		"failed to load pack"
    +@@ t/t5319-multi-pack-index.sh: test_expect_success 'verify incorrect checksum' '
    + 		$objdir "incorrect checksum"
    + '
    + 
    ++test_expect_success 'setup for v1-specific fsck tests' '
    ++	git -c midx.version=1 multi-pack-index write
    ++'
    ++
    ++test_expect_success 'verify packnames out of order (v1)' '
    ++	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "z" $objdir \
    ++		"pack names out of order"
    ++'
    ++
    + test_expect_success 'repack progress off for redirected stderr' '
    + 	GIT_PROGRESS_DELAY=0 git multi-pack-index --object-dir=$objdir repack 2>err &&
    + 	test_line_count = 0 err
10:  9231fdca112 = 11:  c0c1769464b git-compat-util.h: introduce `u32_add()`
11:  12211c9ad53 = 12:  c11214a51f0 midx-write.c: introduce `midx_pack_perm()` helper
12:  978d7bf8bbc = 13:  b9244a04297 midx-write.c: extract `fill_pack_from_midx()`
13:  61deab3f731 = 14:  c6f8d323477 midx-write.c: enumerate `pack_int_id` values directly
14:  4f920a328ef = 15:  e71aa575463 midx-write.c: factor fanout layering from `compute_sorted_entries()`
 -:  ----------- > 16:  dbbcb494563 t/helper/test-read-midx.c: plug memory leak when selecting layer
16:  088673c762d ! 17:  13336e864f4 midx: implement MIDX compaction
    @@ Documentation/git-multi-pack-index.adoc: marker).
     +--
     +	--incremental::
     +		Write the result to a MIDX chain instead of writing a
    -+		stand-alone MIDX. Incompatible with `--bitmap`.
    ++		stand-alone MIDX.
     +--
     +
      verify::
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
     +	m = get_multi_pack_index(source);
     +
     +	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
    -+		const char *midx_csum = get_midx_checksum(cur);
    ++		const char *midx_csum = midx_get_checksum_hex(cur);
     +
     +		if (!from_midx && !strcmp(midx_csum, argv[0]))
     +			from_midx = cur;
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
     +	}
     +
     +	if (!from_midx)
    -+		die(_("could not find MIDX 'from': %s"), argv[0]);
    ++		die(_("could not find MIDX: %s"), argv[0]);
     +	if (!to_midx)
    -+		die(_("could not find MIDX 'to': %s"), argv[1]);
    ++		die(_("could not find MIDX: %s"), argv[1]);
    ++	if (from_midx == to_midx)
    ++		die(_("MIDX compaction endpoints must be unique"));
    ++
    ++	for (m = from_midx; m; m = m->base_midx) {
    ++		if (m == to_midx)
    ++			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
    ++	}
     +
     +	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
     +
    @@ midx-write.c: static int fill_packs_from_midx(struct write_midx_context *ctx)
      static struct {
      	const char *non_split;
      	const char *split;
    -@@ midx-write.c: static void clear_midx_files(struct odb_source *source,
    - 	strbuf_release(&buf);
    +@@ midx-write.c: static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
    + 	if (ctx->incremental)
    + 		goto out;
    + 
    ++	if (ctx->compact)
    ++		goto out; /* Compaction always requires an update. */
    ++
    + 	/*
    + 	 * Otherwise, we need to verify that the packs covered by the existing
    + 	 * MIDX match the packs that we already have. The logic to do so is way
    +@@ midx-write.c: static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
    + 	return needed;
      }
      
     +static int midx_hashcmp(const struct multi_pack_index *a,
     +			const struct multi_pack_index *b,
     +			const struct git_hash_algo *algop)
     +{
    -+	return hashcmp(get_midx_hash(a), get_midx_hash(b), algop);
    ++	return hashcmp(midx_get_checksum_hash(a), midx_get_checksum_hash(b),
    ++		       algop);
     +}
     +
      struct write_midx_opts {
    - 	struct odb_source *source;
    + 	struct odb_source *source; /* non-optional */
      
      	struct string_list *packs_to_include;
      	struct string_list *packs_to_drop;
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      
      	trace2_region_enter("midx", "write_midx_internal", r);
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    - 	ctx.source = opts->source;
    + 		die(_("unknown MIDX version: %d"), ctx.version);
      
      	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
     +	ctx.compact = !!(opts->flags & MIDX_WRITE_COMPACT);
     +
     +	if (ctx.compact) {
    ++		if (ctx.version != MIDX_VERSION_V2)
    ++			die(_("cannot perform MIDX compaction with v1 format"));
     +		if (!opts->compact_from)
     +			BUG("expected non-NULL 'from' MIDX during compaction");
     +		if (!opts->compact_to)
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
     +	}
      	stop_progress(&ctx.progress);
      
    - 	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
    - 	    !ctx.incremental &&
    -+	    !ctx.compact &&
    - 	    !(opts->packs_to_include || opts->packs_to_drop)) {
    - 		struct bitmap_index *bitmap_git;
    - 		int bitmap_exists;
    + 	if (!opts->packs_to_drop) {
     @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
      			ctx.large_offsets_needed = 1;
      	}
      
     -	QSORT(ctx.info, ctx.nr, pack_info_compare);
    -+	if (!ctx.compact)
    ++	if (ctx.compact) {
    ++		if (ctx.version != MIDX_VERSION_V2)
    ++			BUG("performing MIDX compaction with v1 MIDX");
    ++	} else {
     +		QSORT(ctx.info, ctx.nr, pack_info_compare);
    ++	}
      
      	if (opts->packs_to_drop && opts->packs_to_drop->nr) {
      		size_t drop_index = 0;
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
     +			for (m = ctx.base_midx; m; m = m->base_midx)
     +				num_layers_before_from++;
      
    --			keep_hashes[j] = xstrdup(get_midx_checksum(m));
    +-			keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
     -			m = m->base_midx;
     +			m = ctx.base_midx;
     +			for (i = 0; i < num_layers_before_from; i++) {
     +				uint32_t j = num_layers_before_from - i - 1;
     +
    -+				keep_hashes[j] = xstrdup(get_midx_checksum(m));
    ++				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
     +				m = m->base_midx;
     +			}
     +
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
     +			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
     +			     m = m->base_midx) {
     +				keep_hashes[keep_hashes_nr - i - 1] =
    -+					xstrdup(get_midx_checksum(m));
    ++					xstrdup(midx_get_checksum_hex(m));
     +				i++;
     +			}
     +		} else {
    @@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
     +			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
     +				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
     +
    -+				keep_hashes[j] = xstrdup(get_midx_checksum(m));
    ++				keep_hashes[j] = xstrdup(midx_get_checksum_hex(m));
     +				m = m->base_midx;
     +			}
      		}
    @@ t/t5335-compact-multi-pack-index.sh (new)
     +	(
     +		cd midx-compact-lex-order &&
     +
    ++		git config maintenance.auto false &&
    ++
     +		write_packs A B C D E &&
     +		test_line_count = 5 $midx_chain &&
     +
    @@ t/t5335-compact-multi-pack-index.sh (new)
     +	(
     +		cd midx-compact-non-lex-order &&
     +
    ++		git config maintenance.auto false &&
    ++
     +		write_packs D C A B E &&
     +		test_line_count = 5 $midx_chain &&
     +
    @@ t/t5335-compact-multi-pack-index.sh (new)
     +	)
     +'
     +
    ++test_expect_success 'setup for bogus MIDX compaction scenarios' '
    ++	git init midx-compact-bogus &&
    ++	(
    ++		cd midx-compact-bogus &&
    ++
    ++		git config maintenance.auto false &&
    ++
    ++		write_packs A B C
    ++	)
    ++'
    ++
    ++test_expect_success 'MIDX compaction with missing endpoints' '
    ++	(
    ++		cd midx-compact-bogus &&
    ++
    ++		test_must_fail git multi-pack-index compact --incremental \
    ++			"<missing>" "<missing>" 2>err &&
    ++		test_grep "could not find MIDX: <missing>" err &&
    ++
    ++		test_must_fail git multi-pack-index compact --incremental \
    ++			"<missing>" "$(nth_line 2 "$midx_chain")" 2>err &&
    ++		test_grep "could not find MIDX: <missing>" err &&
    ++
    ++		test_must_fail git multi-pack-index compact --incremental \
    ++			"$(nth_line 2 "$midx_chain")" "<missing>" 2>err &&
    ++		test_grep "could not find MIDX: <missing>" err
    ++	)
    ++'
    ++
    ++test_expect_success 'MIDX compaction with reversed endpoints' '
    ++	(
    ++		cd midx-compact-bogus &&
    ++
    ++		from="$(nth_line 3 "$midx_chain")" &&
    ++		to="$(nth_line 1 "$midx_chain")" &&
    ++
    ++		test_must_fail git multi-pack-index compact --incremental \
    ++			"$from" "$to" 2>err &&
    ++
    ++		test_grep "MIDX $from must be an ancestor of $to" err
    ++	)
    ++'
    ++
    ++test_expect_success 'MIDX compaction with identical endpoints' '
    ++	(
    ++		cd midx-compact-bogus &&
    ++
    ++		from="$(nth_line 3 "$midx_chain")" &&
    ++		to="$(nth_line 3 "$midx_chain")" &&
    ++
    ++		test_must_fail git multi-pack-index compact --incremental \
    ++			"$from" "$to" 2>err &&
    ++
    ++		test_grep "MIDX compaction endpoints must be unique" err
    ++	)
    ++'
    ++
    ++test_expect_success 'MIDX compaction with midx.version=1' '
    ++	(
    ++		cd midx-compact-bogus &&
    ++
    ++		test_must_fail git -c midx.version=1 multi-pack-index compact \
    ++			"$(nth_line 1 "$midx_chain")" \
    ++			"$(nth_line 2 "$midx_chain")" 2>err &&
    ++
    ++		test_grep "fatal: cannot perform MIDX compaction with v1 format" err
    ++	)
    ++'
    ++
     +test_done
17:  b96c4e04266 ! 18:  b599f1ad4b0 midx: enable reachability bitmaps during MIDX compaction
    @@ Commit message
         layer compaction by combining all existing bitmaps from the compacted
         layers.
     
    -    Note that the because of the object/pack ordering described by the
    -    previous commit, the pseudo-pack order for the compacted MIDX is the
    -    same as concatenating the individual pseudo-pack orderings for each
    -    layer in the compaction range.
    +    Note that because of the object/pack ordering described by the previous
    +    commit, the pseudo-pack order for the compacted MIDX is the same as
    +    concatenating the individual pseudo-pack orderings for each layer in the
    +    compaction range.
     
         As a result, the only non-test or documentation change necessary is to
         treat all objects as non-preferred during compaction so as not to
    @@ Documentation/git-multi-pack-index.adoc: SYNOPSIS
      'git multi-pack-index' [<options>] verify
      'git multi-pack-index' [<options>] expire
      'git multi-pack-index' [<options>] repack [--batch-size=<size>]
    +@@ Documentation/git-multi-pack-index.adoc: compact::
    + 	--incremental::
    + 		Write the result to a MIDX chain instead of writing a
    + 		stand-alone MIDX.
    ++
    ++	--[no-]bitmap::
    ++		Control whether or not a multi-pack bitmap is written.
    + --
    + 
    + verify::
     
      ## builtin/multi-pack-index.c ##
     @@
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with n
      			"$(nth_line 2 "$midx_chain")" \
      			"$(nth_line 4 "$midx_chain")" &&
      		test_line_count = 3 $midx_chain &&
    -@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with midx.version=1' '
      	)
      '
      
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with n
     +	(
     +		cd midx-compact-preserve-selection &&
     +
    ++		git config maintenance.auto false &&
    ++
     +		test_commit A &&
     +		test_commit B &&
     +
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with n
     +	(
     +		cd midx-compact-with-bitmaps &&
     +
    ++		git config maintenance.auto false &&
    ++
     +		write_packs foo bar baz quux woot &&
     +
     +		test-tool read-midx --bitmap $objdir >bitmap.expect &&
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with n
     +	(
     +		cd midx-compact-with-bitmaps-non-trivial &&
     +
    ++		git config maintenance.auto false &&
    ++
     +		git branch -m main &&
     +
     +		#               D(4)
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with n
     +		git checkout main &&
     +		write_packs G &&
     +
    -+		cat $midx_chain &&
    -+
     +		# Compact layers 2-4, leaving us with:
     +		#
     +		#  [A, [B, C, D], E, F, G]
    @@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with n
     +		#  [A, [B, C, D], E, [F, G]]
     +		git multi-pack-index compact --incremental --bitmap \
     +			"$(nth_line 4 "$midx_chain")" \
    -+			"$(nth_line 5 "$midx_chain")" &&
    -+
    -+		cat $midx_chain
    ++			"$(nth_line 5 "$midx_chain")"
     +	)
     +'
     +
-- 
2.52.0.457.gb599f1ad4b0
