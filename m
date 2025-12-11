Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C41E2606
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442780; cv=none; b=t4EXrxlZx3OYqAEmyDEC/s2tHe+7nbYM4SLIPgTdJ7vk+qeC/n8nH9ZVoAVrgZDSXjtlInVAc7UjgHmDtJpBUqqj8lx0PWKqzkBwZ1ZvWKmr48qw4m603qxb2TuM6v3SW7R6jByd6Fo3tEBlvctL+PckSaOY38Jy0cLBlZd9AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442780; c=relaxed/simple;
	bh=SELb0RdphtF+93O03feAW8zaG8uKvOuroP+EbLf5HIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=azyOUUdi85GybG/LDjdezEwfUwi5xC8PBYQSHZFm3F/tNWehNgRCcY62dQhlgwxa2chfabRqnexd1EffXNjZQXAzDmWXcG2CzMDvKyl49LLwL3vy9ktRa4DCNhYaurWq595TeO9nRk5LVLXyfeewdF3HOgeRRSLOYMo9hYtSN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PEcq7xJA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r50ZHKSz; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PEcq7xJA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r50ZHKSz"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D6ACBEC0677;
	Thu, 11 Dec 2025 03:46:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 11 Dec 2025 03:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765442775; x=1765529175; bh=O7iW6CxPEl
	66d753RKBLz2VKR/dyAsTZKTut2jTrXZ0=; b=PEcq7xJAfWDZnmDImTz2LIYvmb
	z4he8/LhqqSk50b4vgt6syUX5ssL9FGWcsiITmBYtZmNYBB+MkaKhuT4DyDu9sk9
	Tvtkxsgju2wdY4jIecp0lGR08Osqcz5x+eZzCLCbf4V2aF7Kdom6pqA0P+PBfDLi
	zvELauqZFU5vVmv6pop7gmfxaQgtp1sxwUBfaLLiZOsTglAG0lLiCEHED5PhOhe3
	o+2hdQ3UsKnhfwQYehliojg1F2O4bPNPIU1mGebIMCBEH5Mid6x01wo3tJ9rKBXC
	oCqeYtGjbZbTAyWxmVGrbTpdc/wf40VDpRyinCRk4lvi9hQLW8EH45r5OPbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765442775; x=1765529175; bh=O7iW6CxPEl66d753RKBLz2VKR/dyAsTZKTu
	t2jTrXZ0=; b=r50ZHKSzubc7i9v6ppWMlioddgG5rVHusxgN2I7pu+tZyheNLUu
	kyzUzCAJYtVVJADaLZKDvHQQ8vLfLIYGkKJ/f3SQ1ryUqGwGnZOr7rH1VomsPHzv
	L3A3p6wUd+OUgWSOd5YKjVc/4SucZuDxahw/Ba51UEYaIwzPiRWm3/a4GnnVJnP0
	YjWsKcjydZaDT68p6gJsQazb6Mgs/0KFVPuS3DEUAGGcjQ9RXcY7nLhqsr5w5uXH
	e0Ki6GsLhbLZFLw7WUqfKsfC/K4x8Os3DplWVSwyduwIaINJjilxbf0na2qf0cE0
	Bqwap8bV31B/kudRfK4Sro5o6u9jNURs+0A==
X-ME-Sender: <xms:14Q6aRhF1DaKsE_V03B-sMj3MeR1-evHbh9ZL4RxkwqWiajTPueDcg>
    <xme:14Q6ac7hwasfgaR260xolt5EOmXhfka5nwZxM28GBq1ytKvNGzbIlvZQFFFIcxJ3z
    VhWr36ja5qJJS7WAK8Lwj6V8mH3c9r69K-jAvI6YBLR4RPco5v4>
X-ME-Received: <xmr:14Q6aZbLZsPI1jU1Vt79zQu05dY33rad0IGOGvkipS8o46ihpStD_zsjyiVeTk417UEl7n18Y24GBLJNH5Lw3RBlpQU7UJB8ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:14Q6aR6dltVvbMrzCrYJlHWJOMHkWe4TqsFBN8auV1thRpJo-o7d-A>
    <xmx:14Q6acCWB1MUdjSIIHbp2LwuMefn3liwOHz3aLTId_NwNWQajyfnSQ>
    <xmx:14Q6aXcJqKgk96kv7NgG83MBD9VQ2ZSdn7gbCw8zu-X3-NmHoYt7qA>
    <xmx:14Q6abI5-gkmAfnhH6QPy0HLi4ISA2gnMJ1wnFWczpsy85mBiP8J0A>
    <xmx:14Q6adJQU6j8F3EOG1kupr9RB6LqHjK2dZe6e3M_6ekl9O8VYkC7Qx0y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 03:46:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/3] builtin/repack: avoid rewriting up-to-date MIDX
In-Reply-To: <20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
	(Patrick Steinhardt's message of "Wed, 10 Dec 2025 13:52:17 +0100")
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
	<20251210-pks-skip-noop-rewrite-v2-0-f813a9e44f28@pks.im>
Date: Thu, 11 Dec 2025 17:46:13 +0900
Message-ID: <xmqqsedhe78q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

This and Taylor's incremental part 3.2 have a slight conflict in
that this topic factors away the logic to compute if we need
recomputing MIDX while the other one tweaks with yet another flag.

My tentative resolution in 'seen' looks like the attached.  Sanity
checking is very much appreciated.

Thanks.

diff --cc midx-write.c
index ce459b02c3,f2dbacef4c..66c125ccb0
--- a/midx-write.c
+++ b/midx-write.c
@@@ -1014,73 -1131,30 +1131,89 @@@ static void clear_midx_files(struct odb
  	strbuf_release(&buf);
  }
  
 +static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_context *ctx)
 +{
 +	struct strset packs = STRSET_INIT;
 +	struct strbuf buf = STRBUF_INIT;
 +	bool needed = true;
 +
 +	/*
 +	 * Ignore incremental updates for now. The assumption is that any
 +	 * incremental update would be either empty (in which case we will bail
 +	 * out later) or it would actually cover at least one new pack.
 +	 */
- 	if (ctx->incremental)
++	if (ctx->incremental || ctx->compact)
 +		goto out;
 +
 +	/*
 +	 * Otherwise, we need to verify that the packs covered by the existing
 +	 * MIDX match the packs that we already have. The logic to do so is way
 +	 * more complicated than it has any right to be. This is because:
 +	 *
 +	 *   - We cannot assume any ordering.
 +	 *
 +	 *   - The MIDX packs may not be loaded at all, and loading them would
 +	 *     be wasteful. So we need to use the pack names tracked by the
 +	 *     MIDX itself.
 +	 *
 +	 *   - The MIDX pack names are tracking the ".idx" files, whereas the
 +	 *     packs themselves are tracking the ".pack" files. So we need to
 +	 *     strip suffixes.
 +	 */
 +	if (ctx->nr != midx->num_packs + midx->num_packs_in_base)
 +		goto out;
 +
 +	for (uint32_t i = 0; i < ctx->nr; i++) {
 +		strbuf_reset(&buf);
 +		strbuf_addstr(&buf, pack_basename(ctx->info[i].p));
 +		strbuf_strip_suffix(&buf, ".pack");
 +
 +		if (!strset_add(&packs, buf.buf))
 +			BUG("same pack added twice?");
 +	}
 +
 +	for (uint32_t i = 0; i < ctx->nr; i++) {
 +		strbuf_reset(&buf);
 +		strbuf_addstr(&buf, midx->pack_names[i]);
 +		strbuf_strip_suffix(&buf, ".idx");
 +
 +		if (!strset_contains(&packs, buf.buf))
 +			goto out;
 +		strset_remove(&packs, buf.buf);
 +	}
 +
 +	needed = false;
 +
 +out:
 +	strbuf_release(&buf);
 +	strset_clear(&packs);
 +	return needed;
 +}
 +
- static int write_midx_internal(struct odb_source *source,
- 			       struct string_list *packs_to_include,
- 			       struct string_list *packs_to_drop,
- 			       const char *preferred_pack_name,
- 			       const char *refs_snapshot,
- 			       unsigned flags)
+ static int midx_hashcmp(const struct multi_pack_index *a,
+ 			const struct multi_pack_index *b,
+ 			const struct git_hash_algo *algop)
  {
- 	struct repository *r = source->odb->repo;
+ 	return hashcmp(get_midx_hash(a), get_midx_hash(b), algop);
+ }
+ 
+ struct write_midx_opts {
+ 	struct odb_source *source;
+ 
+ 	struct string_list *packs_to_include;
+ 	struct string_list *packs_to_drop;
+ 
+ 	struct multi_pack_index *compact_from;
+ 	struct multi_pack_index *compact_to;
+ 
+ 	const char *preferred_pack_name;
+ 	const char *refs_snapshot;
+ 	unsigned flags;
+ };
+ 
+ static int write_midx_internal(struct write_midx_opts *opts)
+ {
+ 	struct repository *r = opts->source->odb->repo;
  	struct strbuf midx_name = STRBUF_INIT;
  	unsigned char midx_hash[GIT_MAX_RAWSZ];
  	uint32_t start_pack;
@@@ -1166,44 -1257,43 +1317,54 @@@
  	else
  		ctx.progress = NULL;
  
- 	ctx.to_include = packs_to_include;
+ 	if (ctx.compact) {
+ 		int bitmap_order = 0;
+ 		if (opts->preferred_pack_name)
+ 			bitmap_order |= 1;
+ 		else if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
+ 			bitmap_order |= 1;
  
- 	for_each_file_in_pack_dir(source->path, add_pack_to_midx, &ctx);
+ 		fill_packs_from_midx_range(&ctx, bitmap_order);
+ 	} else {
+ 		ctx.to_include = opts->packs_to_include;
+ 		for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
+ 	}
  	stop_progress(&ctx.progress);
  
- 	if (!packs_to_drop) {
 -	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
 -	    !ctx.incremental &&
 -	    !ctx.compact &&
 -	    !(opts->packs_to_include || opts->packs_to_drop)) {
 -		struct bitmap_index *bitmap_git;
 -		int bitmap_exists;
 -		int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
 -
 -		bitmap_git = prepare_midx_bitmap_git(ctx.m);
 -		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
 -		free_bitmap_index(bitmap_git);
 -
 -		if (bitmap_exists || !want_bitmap) {
 -			/*
 -			 * The correct MIDX already exists, and so does a
 -			 * corresponding bitmap (or one wasn't requested).
 -			 */
 -			if (!want_bitmap)
 -				clear_midx_files_ext(opts->source, "bitmap",
 -						     NULL);
 -			result = 0;
 -			goto cleanup;
++	if (!opts->packs_to_drop) {
 +		/*
 +		 * If there is no MIDX then either it doesn't exist, or we're
 +		 * doing a geometric repack. Try to load it from the source to
 +		 * tell these two cases apart.
 +		 */
 +		struct multi_pack_index *midx = ctx.m;
 +		if (!midx)
 +			midx = midx_to_free = load_multi_pack_index(ctx.source);
 +
 +		if (midx && !midx_needs_update(midx, &ctx)) {
 +			struct bitmap_index *bitmap_git;
 +			int bitmap_exists;
- 			int want_bitmap = flags & MIDX_WRITE_BITMAP;
++			int want_bitmap = opts->flags & MIDX_WRITE_BITMAP;
 +
 +			bitmap_git = prepare_midx_bitmap_git(midx);
 +			bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
 +			free_bitmap_index(bitmap_git);
 +
 +			if (bitmap_exists || !want_bitmap) {
 +				/*
 +				 * The correct MIDX already exists, and so does a
 +				 * corresponding bitmap (or one wasn't requested).
 +				 */
 +				if (!want_bitmap)
- 					clear_midx_files_ext(source, "bitmap", NULL);
++					clear_midx_files_ext(opts->source,
++							     "bitmap", NULL);
 +				result = 0;
 +				goto cleanup;
 +			}
  		}
 +
 +		close_midx(midx_to_free);
 +		midx_to_free = NULL;
  	}
  
  	if (ctx.incremental && !ctx.nr) {
