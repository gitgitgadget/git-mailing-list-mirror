Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD7A1850B0
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250720; cv=none; b=sX9blx+mergOlJmU4TZiFfqRjg24oMvA9pyher7jD/I+BtKICivftpcWRNv8oAef+7DDREk4Cd+hPsDVjdHDOldmmTwxwgeTrEr1s6uYkX+D7V+5w9Ig7glPNX/Aty3sgl02D4xJN6vPyD4RSy+05COFbPnijy5LShZuuBhai7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250720; c=relaxed/simple;
	bh=szQd8O12Dr4/TXJVykx0yldblOuoHe0uA95vr3kNOKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iym0PZHkPcFny7q6dxt4f1hP0fKN26az5UbNLz7BhjK0T6Bp7DLYpGBwb0glSyXtDMdBaqp3WbD5NasU44kDNNOTMAz3SyW5poalofiPa8p29aq9qlIcOuuQcfNOC7GBhTA992gf5U2wHnDbEffBJP5sRuGu0oXHD7BCrmKHDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=E3q8Ic6b; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="E3q8Ic6b"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-654cf0a069eso873357b3.1
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721250716; x=1721855516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Zuh5KLOI7HuisR8Cfs+SUe4GyjbHmMZF9SFxmTYZzk=;
        b=E3q8Ic6bboY4K45zPU4hM5rFkdWUUi6z/6WjHZAPcoaLJqMp7nlBGa9j9FWd7wDlze
         vDOh4+MuasVOsmivdVLcJRcJ61K5F2zO6B2uQxfyVlD+y6nAWtYZhGm1RnbfSXJbgATe
         wvoVKa0qEmmN7p55BnsncwkN4RjDJQWYXb+44P5xHI0i/CJBPn3WbVjtaxaIzJLvIp4N
         xIUfHO0srDZ8YetTyxnNbmWfKDO/Hzl4XPnTg/GxDpsq324ck3jhxbMjcvaMvfSSCwiQ
         2Y8ZHZl9/IoZs7SDO32zjLBZ3S7OOMiT90OrRBpFUT+XB4FpjSJqFkhKfAcDsL08dXCh
         tcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250716; x=1721855516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Zuh5KLOI7HuisR8Cfs+SUe4GyjbHmMZF9SFxmTYZzk=;
        b=AU1edgMYNjvkaciOqzibu1le1NY5eNIWjMTnuP6eeuUTpBnOAuJrQ6uDJbCPchLcGe
         fqakh/LO6OeJj1/shaQ+G6/u0WJcPJUnpL1Bon3ZjnTiQMbkyAjgU2fQBiYPV7l3MkmM
         uS176DIngI8bDYi6kx1lfNecjjwvb//KDVjJB3ZgCF+K3qt50kubUC0Din9QjNPFNFfa
         Uld/xg8qjJTcsRiSmToGfTf3TqJkpLXEymtFYG4RH1ptwmIJNRyf03TfcxGxg9xMraGt
         y9DPX3WFuo+uKKQcumnultrJZ65wBAZWz7O2plA3JtTYhQZ1KTVE59vTE2mFdp6WaJvd
         XWKw==
X-Gm-Message-State: AOJu0YxhErdfLUQstbYlu/XFxK7ZJcMNwIcsH4rIjQ5eTrwP6g9W+7IR
	c+TXP0DaU57S6FPXStqycLB8aBUUjvrUWh9Ycs8gkZtAePz5JTZkki98Kwcpdv2ky4LO1Y516Ox
	4
X-Google-Smtp-Source: AGHT+IGwo0Y+ZM0sZZiZVbHXh65U1Z9PMU7HUOltP2/F4PFeQO8f1oDNd4CtJ7u1XDd9+PWuSP4JcQ==
X-Received: by 2002:a0d:f7c1:0:b0:648:3fb2:753b with SMTP id 00721157ae682-664fe9363b7mr34177077b3.24.1721250716510;
        Wed, 17 Jul 2024 14:11:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-666042beaddsm745167b3.146.2024.07.17.14.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 14:11:55 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:11:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 00/19] midx: incremental multi-pack indexes, part one
Message-ID: <cover.1721250704.git.me@ttaylorr.com>
References: <cover.1717715060.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717715060.git.me@ttaylorr.com>

This series implements incremental MIDXs, which allow for storing
a MIDX across multiple layers, each with their own distinct set of
packs.

This round is mostly unchanged from the previous since there has not yet
been substantial review. But it does rebase to current 'master' (which
is 04f5a52757 (Post 2.46-rc0 batch #2, 2024-07-16), at the time of
writing).

Importantly, this rebase moves this topic to be based on an ancestor of
0c5a62f14b (midx-write.c: do not read existing MIDX with
`packs_to_include`, 2024-06-11), which resulted in a non-trivial
conflict prior to this rebase.

The rest of the topic is unchanged. I don't expect that we'll see much
review here for the next couple of weeks while we are in the -rc phase,
but I figured it would be useful to have it on the list for folks that
are interested in taking a look.

Thanks in advance for any review! :-)

Taylor Blau (19):
  Documentation: describe incremental MIDX format
  midx: add new fields for incremental MIDX chains
  midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
  midx: teach `prepare_midx_pack()` about incremental MIDXs
  midx: teach `nth_midxed_object_oid()` about incremental MIDXs
  midx: teach `nth_bitmapped_pack()` about incremental MIDXs
  midx: introduce `bsearch_one_midx()`
  midx: teach `bsearch_midx()` about incremental MIDXs
  midx: teach `nth_midxed_offset()` about incremental MIDXs
  midx: teach `fill_midx_entry()` about incremental MIDXs
  midx: remove unused `midx_locate_pack()`
  midx: teach `midx_contains_pack()` about incremental MIDXs
  midx: teach `midx_preferred_pack()` about incremental MIDXs
  midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
  midx: support reading incremental MIDX chains
  midx: implement verification support for incremental MIDXs
  t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
  t/t5313-pack-bounds-checks.sh: prepare for sub-directories
  midx: implement support for writing incremental MIDX chains

 Documentation/git-multi-pack-index.txt       |  11 +-
 Documentation/technical/multi-pack-index.txt | 100 +++++
 builtin/multi-pack-index.c                   |   2 +
 builtin/repack.c                             |   8 +-
 ci/run-build-and-tests.sh                    |   2 +-
 midx-write.c                                 | 326 ++++++++++++---
 midx.c                                       | 410 ++++++++++++++++---
 midx.h                                       |  26 +-
 object-name.c                                |  99 ++---
 packfile.c                                   |  21 +-
 packfile.h                                   |   4 +
 t/README                                     |   6 +-
 t/helper/test-read-midx.c                    |  24 +-
 t/lib-bitmap.sh                              |   6 +-
 t/lib-midx.sh                                |  28 ++
 t/t0410-partial-clone.sh                     |   2 -
 t/t5310-pack-bitmaps.sh                      |   4 -
 t/t5313-pack-bounds-checks.sh                |   8 +-
 t/t5319-multi-pack-index.sh                  |  30 +-
 t/t5326-multi-pack-bitmaps.sh                |   4 +-
 t/t5327-multi-pack-bitmaps-rev.sh            |   6 +-
 t/t5332-multi-pack-reuse.sh                  |   2 +
 t/t5334-incremental-multi-pack-index.sh      |  46 +++
 t/t7700-repack.sh                            |  48 +--
 24 files changed, 959 insertions(+), 264 deletions(-)
 create mode 100755 t/t5334-incremental-multi-pack-index.sh

Range-diff against v1:
 1:  e5ce916f67 =  1:  014588b3ec Documentation: describe incremental MIDX format
 2:  6569289ca7 =  2:  337ebc6de7 midx: add new fields for incremental MIDX chains
 3:  d2e845a9d4 =  3:  f449a72877 midx: teach `nth_midxed_pack_int_id()` about incremental MIDXs
 4:  2100c6ddfa =  4:  f88569c819 midx: teach `prepare_midx_pack()` about incremental MIDXs
 5:  454c3d2fe7 !  5:  ec57ff4349 midx: teach `nth_midxed_object_oid()` about incremental MIDXs
    @@ midx.c: struct object_id *nth_midxed_object_oid(struct object_id *oid,
      
     +	n = midx_for_object(&m, n);
     +
    - 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n));
    + 	oidread(oid, m->chunk_oid_lookup + st_mult(m->hash_len, n),
    + 		the_repository->hash_algo);
      	return oid;
    - }
 6:  7d945c41bc =  6:  650b8c8c21 midx: teach `nth_bitmapped_pack()` about incremental MIDXs
 7:  4d4d924aa2 =  7:  bfd1dadbf1 midx: introduce `bsearch_one_midx()`
 8:  86d88bc6a3 =  8:  38bd45bd24 midx: teach `bsearch_midx()` about incremental MIDXs
 9:  eb9ed10ca3 =  9:  342ed56033 midx: teach `nth_midxed_offset()` about incremental MIDXs
10:  36cfdd9b95 = 10:  2b335c45ae midx: teach `fill_midx_entry()` about incremental MIDXs
11:  1ae5fd7e89 = 11:  22de5898f3 midx: remove unused `midx_locate_pack()`
12:  e3319967b9 = 12:  fb60f2b022 midx: teach `midx_contains_pack()` about incremental MIDXs
13:  3b8dffa051 = 13:  38b642d404 midx: teach `midx_preferred_pack()` about incremental MIDXs
14:  35fbe05a4a = 14:  594386da10 midx: teach `midx_fanout_add_midx_fanout()` about incremental MIDXs
15:  a5eedb15fa = 15:  dad130799c midx: support reading incremental MIDX chains
16:  186b15e6bd ! 16:  ad976ef413 midx: implement verification support for incremental MIDXs
    @@ midx.c: int verify_midx_file(struct repository *r, const char *object_dir, unsig
     -		{
     -			close_pack_fd(m->packs[pairs[i-1].pack_int_id]);
     -			close_pack_index(m->packs[pairs[i-1].pack_int_id]);
    -+		    m->packs[pairs[i-1].pack_int_id]) {
    ++		    nth_midxed_pack(m, pairs[i-1].pack_int_id)) {
     +			uint32_t pack_int_id = pairs[i-1].pack_int_id;
     +			struct packed_git *p = nth_midxed_pack(m, pack_int_id);
     +
17:  94362c057a ! 17:  23912425bf t: retire 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
    @@ t/README: GIT_TEST_MULTI_PACK_INDEX=<boolean>, when true, forces the multi-pack-
     
      ## t/t0410-partial-clone.sh ##
     @@ t/t0410-partial-clone.sh: test_description='partial clone'
    - 
      . ./test-lib.sh
    + . "$TEST_DIRECTORY"/lib-terminal.sh
      
     -# missing promisor objects cause repacks which write bitmaps to fail
     -GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
18:  4442e7ca52 = 18:  814da1916d t/t5313-pack-bounds-checks.sh: prepare for sub-directories
19:  0cbe34b0bd ! 19:  e2b5961b45 midx: implement support for writing incremental MIDX chains
    @@ midx-write.c
      extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
      				const char *idx_name);
      
    +@@ midx-write.c: struct write_midx_context {
    + 	size_t nr;
    + 	size_t alloc;
    + 	struct multi_pack_index *m;
    ++	struct multi_pack_index *base_midx;
    + 	struct progress *progress;
    + 	unsigned pack_paths_checked;
    + 
     @@ midx-write.c: struct write_midx_context {
      
      	int preferred_pack_idx;
    @@ midx-write.c: struct write_midx_context {
      	struct string_list *to_include;
      };
      
    +@@ midx-write.c: static int should_include_pack(const struct write_midx_context *ctx,
    + 	 */
    + 	if (ctx->m && midx_contains_pack(ctx->m, file_name))
    + 		return 0;
    ++	else if (ctx->base_midx && midx_contains_pack(ctx->base_midx,
    ++						      file_name))
    ++		return 0;
    + 	else if (ctx->to_include &&
    + 		 !string_list_has_string(ctx->to_include, file_name))
    + 		return 0;
     @@ midx-write.c: static void compute_sorted_entries(struct write_midx_context *ctx,
      	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
      		fanout.nr = 0;
    @@ midx-write.c: static void compute_sorted_entries(struct write_midx_context *ctx,
      			if (cur_object && oideq(&fanout.entries[cur_object - 1].oid,
      						&fanout.entries[cur_object].oid))
      				continue;
    -+			if (ctx->incremental && ctx->m &&
    -+			    midx_has_oid(ctx->m, &fanout.entries[cur_object].oid))
    ++			if (ctx->incremental && ctx->base_midx &&
    ++			    midx_has_oid(ctx->base_midx,
    ++					 &fanout.entries[cur_object].oid))
     +				continue;
      
      			ALLOC_GROW(ctx->entries, st_add(ctx->entries_nr, 1),
    @@ midx-write.c: static int write_midx_revindex(struct hashfile *f,
     -	uint32_t i;
     +	uint32_t i, nr_base;
     +
    -+	if (ctx->m && ctx->incremental)
    -+		nr_base = ctx->m->num_objects + ctx->m->num_objects_in_base;
    ++	if (ctx->incremental && ctx->base_midx)
    ++		nr_base = ctx->base_midx->num_objects +
    ++			ctx->base_midx->num_objects_in_base;
     +	else
     +		nr_base = 0;
      
    @@ midx-write.c: static int midx_pack_order_cmp(const void *va, const void *vb)
      
      	trace2_region_enter("midx", "midx_pack_order", the_repository);
      
    -+	if (ctx->incremental && ctx->m)
    -+		base_objects = ctx->m->num_objects + ctx->m->num_objects_in_base;
    ++	if (ctx->incremental && ctx->base_midx)
    ++		base_objects = ctx->base_midx->num_objects +
    ++			ctx->base_midx->num_objects_in_base;
     +
     +	ALLOC_ARRAY(pack_order, ctx->entries_nr);
      	ALLOC_ARRAY(data, ctx->entries_nr);
    @@ midx-write.c: static struct multi_pack_index *lookup_multi_pack_index(struct rep
     +	struct multi_pack_index *m;
      
     -	for (i = 0; i < ctx->m->num_packs; i++) {
    --		if (!should_include_pack(ctx, ctx->m->pack_names[i], 0))
    --			continue;
    +-		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
     +	for (m = ctx->m; m; m = m->base_midx) {
     +		uint32_t i;
    - 
    --		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    --
    --		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
    ++
     +		for (i = 0; i < m->num_packs; i++) {
    ++			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    + 
    +-		if (flags & MIDX_WRITE_REV_INDEX || preferred_pack_name) {
      			/*
      			 * If generating a reverse index, need to have
      			 * packed_git's loaded to compare their
    @@ midx-write.c: static struct multi_pack_index *lookup_multi_pack_index(struct rep
      			 */
     -			if (prepare_midx_pack(the_repository, ctx->m, i))
     -				return error(_("could not load pack"));
    -+			if (!should_include_pack(ctx, m->pack_names[i], 0))
    -+				continue;
    - 
    --			if (open_pack_index(ctx->m->packs[i]))
    --				die(_("could not open index for %s"),
    --				    ctx->m->packs[i]->pack_name);
    -+			ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
    -+
     +			if (flags & MIDX_WRITE_REV_INDEX ||
     +			    preferred_pack_name) {
     +				if (prepare_midx_pack(the_repository, m,
    @@ midx-write.c: static struct multi_pack_index *lookup_multi_pack_index(struct rep
     +					error(_("could not load pack"));
     +					return 1;
     +				}
    -+
    + 
    +-			if (open_pack_index(ctx->m->packs[i]))
    +-				die(_("could not open index for %s"),
    +-				    ctx->m->packs[i]->pack_name);
     +				if (open_pack_index(m->packs[i]))
     +					die(_("could not open index for %s"),
     +					    m->packs[i]->pack_name);
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      	if (safe_create_leading_directories(midx_name.buf))
      		die_errno(_("unable to create leading directories of %s"),
      			  midx_name.buf);
    -@@ midx-write.c: static int write_midx_internal(const char *object_dir,
    + 
    +-	if (!packs_to_include) {
    +-		/*
    +-		 * Only reference an existing MIDX when not filtering which
    +-		 * packs to include, since all packs and objects are copied
    +-		 * blindly from an existing MIDX if one is present.
    +-		 */
    +-		ctx.m = lookup_multi_pack_index(the_repository, object_dir);
    +-	}
    ++	if (!packs_to_include || ctx.incremental) {
    ++		struct multi_pack_index *m = lookup_multi_pack_index(the_repository,
    ++								     object_dir);
    ++		if (m && !midx_checksum_valid(m)) {
    ++			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
    ++			m = NULL;
    ++		}
    + 
    +-	if (ctx.m && !midx_checksum_valid(ctx.m)) {
    +-		warning(_("ignoring existing multi-pack-index; checksum mismatch"));
    +-		ctx.m = NULL;
    ++		if (m) {
    ++			/*
    ++			 * Only reference an existing MIDX when not filtering
    ++			 * which packs to include, since all packs and objects
    ++			 * are copied blindly from an existing MIDX if one is
    ++			 * present.
    ++			 */
    ++			if (ctx.incremental)
    ++				ctx.base_midx = m;
    ++			else if (!packs_to_include)
    ++				ctx.m = m;
    ++		}
      	}
      
      	ctx.nr = 0;
     -	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
     +	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
      	ctx.info = NULL;
    - 	ctx.to_include = packs_to_include;
      	ALLOC_ARRAY(ctx.info, ctx.alloc);
      
     -	if (ctx.m && fill_packs_from_midx(&ctx, preferred_pack_name,
     -					  flags) < 0) {
     -		result = 1;
     +	if (ctx.incremental) {
    -+		struct multi_pack_index *m = ctx.m;
    ++		struct multi_pack_index *m = ctx.base_midx;
     +		while (m) {
     +			ctx.num_multi_pack_indexes_before++;
     +			m = m->base_midx;
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
      	 * have been freed in the previous if block.
      	 */
      
    +-	if (ctx.m)
     +	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
     +
     +	if (ctx.incremental) {
     +		FILE *chainf = fdopen_lock_file(&lk, "w");
     +		struct strbuf final_midx_name = STRBUF_INIT;
    -+		struct multi_pack_index *m = ctx.m;
    ++		struct multi_pack_index *m = ctx.base_midx;
     +
     +		if (!chainf) {
     +			error_errno(_("unable to open multi-pack-index chain file"));
     +			return -1;
     +		}
     +
    -+		if (link_midx_to_chain(ctx.m) < 0)
    ++		if (link_midx_to_chain(ctx.base_midx) < 0)
     +			return -1;
     +
     +		get_split_midx_filename_ext(&final_midx_name, object_dir,
    @@ midx-write.c: static int write_midx_internal(const char *object_dir,
     +			xstrdup(hash_to_hex(midx_hash));
     +	}
     +
    - 	if (ctx.m)
    ++	if (ctx.m || ctx.base_midx)
      		close_object_store(the_repository->objects);
      
      	if (commit_lock_file(&lk) < 0)

base-commit: 04f5a52757cd92347271e24f7cbdfe15dafce3b7
-- 
2.46.0.rc0.94.g9b2aff57b3
