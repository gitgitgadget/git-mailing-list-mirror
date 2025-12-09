Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6650C221554
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765264907; cv=none; b=E0zhL7Sd8wLoBB6UVvWSZTZwtvaKjFqDvoS0X65TWk5jsYB+2zrqdjsyM8iUnpawXJ75mR77tVkuCFPKidpij0BSRpnxqJVoCcrJVog86gOEDXFyL83kcG4bMvRKrzwCzcB5NcX3PHtbqJvlSGaum4ijNIYnsTBx7VLJ/H6Aly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765264907; c=relaxed/simple;
	bh=3GKmQoPaMvtbJmtXUYCengIlIE4XUZmKM5Pge1PRIZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT8L3rYDBBci3HiU3UQFo8qizTIYT9Z/wpBthSlqdnqYQgcUirFaxuOssS10IYIlp8MZSxTs9BDBe4T43Uyp12M9nHc80zRoUoiDk8d/nnRaUYY+KBcnXpu8Ku38N2XKe0GSaf+y6i9saSqEGCd05Tc1MTiMU478VDOvsYFlnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZVsy7tc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzK2eT80; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZVsy7tc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzK2eT80"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 667FB1400085;
	Tue,  9 Dec 2025 02:21:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 09 Dec 2025 02:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765264904; x=1765351304; bh=7cFqFlrSti
	2lEF40o96Zrpocwn6j36GjZ8I1WIOgtKg=; b=eZVsy7tcll4wZdiCwo9byktxh4
	aS+43EF7dlj6Nuz2iAr5esfhOuINAWgUJbjznFjvd6HD/ESAlkLUDvB56qra4OQU
	SooSZXxlIw0MAGTnfIPKsMvgJib5BkcjuAYXdaI6RmEofxZlSN7qIEpNckqHO+ux
	LFdPaEaKiglmxZ1+4nPxP5mxGAsogqcNuSXBeTh8+g44fWNSVEH9pA6y3OHRC1oM
	DG0McMrUSU9HM6rlOtxSq4ZealHwlvVhIT2YVtVhZI+Aw161dxIoNAueMMubZRpF
	ELZ+c8NDuR10fdcHRJgJSgfvVx6po/SJg0EEMPg5YN/zcpPrIkSCwKs16aPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765264904; x=1765351304; bh=7cFqFlrSti2lEF40o96Zrpocwn6j36GjZ8I
	1WIOgtKg=; b=pzK2eT80bYLDHPqGkdsf8q0lgiNoKRPBgplJaiVR8I9gjAmQlwW
	vngHRS6ahYPSKgMu2d2EaNoSbwpifkMqiQTMYbiRVkP1FX4ZhgMhwdKszVoWwrkK
	EFA+pWkiZ/OtOI/MKoBWKm09c09uedTiLSwRgloi0IykxM2dJW8uuVzGIppQdLTC
	yH6Rp3HXG6sV9hn9M55IFGN7BQhUVzvTxvAVy7dL3k8ki9SpIkVmzYcumKqVdq6O
	B1LNC1dQB9bPKyQJs4gS/b3aXN4YKlBUiLOzJkS/oOxYTwx7Lw2DNUlj2FJnrohO
	cnVpDmVy18DflyRcL9GOvYK/cyMJtXbJz9A==
X-ME-Sender: <xms:CM43aTKn_G4E0VIlWKK-7rUXmSAgT0rzYdmfALH8NmSZjOOavP0z-w>
    <xme:CM43aeACD9lM22lbxXoFyJXdEft-K-dWBaEEM3beBHvsNuYDoMZyUxOBJfyouaOyt
    EL4FHn0eXp3fSjESabZRp8r1jj_OyNLSOZxYnbdKgD2JJh-YPEZ1Q>
X-ME-Received: <xmr:CM43aUAMjHFm_SvpuBa3a2nGYqppWTk0TWzmkEPzDs4YUVN-gqJmwbWgPXFeLUjAV3yZnEQZHPSR-IxFgxT-7hnqMGXso60oxZPIQ4hTYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:CM43aYDhQ3x8ZH9BZi1Pw3c8rtbZ-8crjicro28WCT-lI12Qr-khhQ>
    <xmx:CM43aXrAlfz1_H577v0T_jP3xktDJyNF_iw5lLRz0W-EjMes_IGuPw>
    <xmx:CM43aanpJFft7n4rihUVWUghVun67aSHwc25nKt7XaJdAoEt3tJaCQ>
    <xmx:CM43afyaqpDNaq23uR1akZjS8kRoDmMFeVVvgokB03AKayW6BJeNZw>
    <xmx:CM43aUg317Roy9k3ct1glrSrEa9QphFwYFnOUHOScPk9bJAbYjMfDL_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Dec 2025 02:21:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 99696b02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Dec 2025 07:21:40 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:21:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/17] midx: implement MIDX compaction
Message-ID: <aTfN_PycU9ag8c0u@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <c136b2e179d02321de7e7b3f1b6c748cb434d68d.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c136b2e179d02321de7e7b3f1b6c748cb434d68d.1765053054.git.me@ttaylorr.com>

On Sat, Dec 06, 2025 at 03:31:47PM -0500, Taylor Blau wrote:
> diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
> index 164cf1f2291..a9664e77411 100644
> --- a/Documentation/git-multi-pack-index.adoc
> +++ b/Documentation/git-multi-pack-index.adoc
> @@ -12,6 +12,8 @@ SYNOPSIS
>  'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
>  		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
>  		         [--refs-snapshot=<path>]
> +'git multi-pack-index' [<options>] compact [--[no-]incremental]
> +		         <from> <to>
>  'git multi-pack-index' [<options>] verify
>  'git multi-pack-index' [<options>] expire
>  'git multi-pack-index' [<options>] repack [--batch-size=<size>]
> @@ -83,6 +85,17 @@ marker).
>  		necessary.
>  --
>  
> +compact::
> +	Write a new MIDX layer containing only objects and packs present
> +	in the range `<from>` to `<to>`, where both arguments are
> +	checksums of existing layers in the MIDX chain.
> ++
> +--
> +	--incremental::
> +		Write the result to a MIDX chain instead of writing a
> +		stand-alone MIDX. Incompatible with `--bitmap`.

Interesting. What would happen if you compact a subrange of the MIDX
chain without incremental? Would the MIDX be completely replaced with a
MIDX that only covers these packs?

Also, the "--bitmap" flag does not exist yet, so the second sentence
probably needs to be introduced in the next commit.

> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index c0c6c1760c0..9b0c2082cb3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -195,6 +204,63 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
>  	return ret;
>  }
>  
> +static int cmd_multi_pack_index_compact(int argc, const char **argv,
> +					const char *prefix,
> +					struct repository *repo)
> +{
> +	struct multi_pack_index *m, *cur;
> +	struct multi_pack_index *from_midx = NULL;
> +	struct multi_pack_index *to_midx = NULL;
> +	struct odb_source *source;
> +	int ret;
> +
> +	struct option *options;
> +	static struct option builtin_multi_pack_index_compact_options[] = {
> +		OPT_BIT(0, "incremental", &opts.flags,
> +			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
> +		OPT_END(),
> +	};
> +
> +	repo_config(repo, git_multi_pack_index_write_config, NULL);
> +
> +	options = add_common_options(builtin_multi_pack_index_compact_options);
> +
> +	trace2_cmd_mode(argv[0]);
> +
> +	if (isatty(2))
> +		opts.flags |= MIDX_PROGRESS;
> +	argc = parse_options(argc, argv, prefix,
> +			     options, builtin_multi_pack_index_compact_usage,
> +			     0);
> +
> +	if (argc != 2)
> +		usage_with_options(builtin_multi_pack_index_compact_usage,
> +				   options);
> +	source = handle_object_dir_option(the_repository);
> +
> +	FREE_AND_NULL(options);
> +
> +	m = get_multi_pack_index(source);
> +
> +	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
> +		const char *midx_csum = get_midx_checksum(cur);
> +
> +		if (!from_midx && !strcmp(midx_csum, argv[0]))
> +			from_midx = cur;
> +		if (!to_midx && !strcmp(midx_csum, argv[1]))
> +			to_midx = cur;
> +	}
> +
> +	if (!from_midx)
> +		die(_("could not find MIDX 'from': %s"), argv[0]);
> +	if (!to_midx)
> +		die(_("could not find MIDX 'to': %s"), argv[1]);
> +
> +	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
> +
> +	return ret;
> +}

Is it valid if `from_midx == to_midx`?

> diff --git a/midx-write.c b/midx-write.c
> index 7854561359d..fcbfedcd913 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -953,6 +980,72 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
>  	return 0;
>  }
>  
> +static uint32_t compactible_packs_between(const struct multi_pack_index *from,
> +					  const struct multi_pack_index *to)
> +{
> +	uint32_t nr;
> +
> +	ASSERT(from && to);
> +
> +	nr = u32_add(to->num_packs, to->num_packs_in_base);
> +	if (nr < from->num_packs_in_base)
> +		BUG("unexpected number of packs in base during compaction: "
> +		    "%"PRIu32" < %"PRIu32, nr, from->num_packs_in_base);
> +
> +	return nr - from->num_packs_in_base;
> +}
> +
> +static int fill_packs_from_midx_range(struct write_midx_context *ctx,
> +				      int bitmap_order)
> +{
> +	struct multi_pack_index *m = ctx->compact_to;
> +	uint32_t packs_nr;
> +
> +	ASSERT(ctx->compact && !ctx->nr);
> +	ASSERT(ctx->compact_from);
> +	ASSERT(ctx->compact_to);
> +
> +	packs_nr = compactible_packs_between(ctx->compact_from,
> +					     ctx->compact_to);
> +
> +	ALLOC_GROW(ctx->info, packs_nr, ctx->alloc);
> +
> +	while (m != ctx->compact_from->base_midx) {
> +		uint32_t pack_int_id, preferred_pack_id;
> +		uint32_t i;
> +
> +		if (bitmap_order) {
> +			if (midx_preferred_pack(m, &preferred_pack_id) < 0)
> +				die(_("could not determine preferred pack"));

`midx_preferred_pack()` only returns a valid pack ID in case we've got a
reverse index, and as far as I understand we seem to only generate those
when computing bitmaps. I assume that this means that we can only
compact MIDX layers in bitmap order if they already were in bitmap order
before?

That would at least also make sense. We of course cannot randomly change
the order in the middle of our layers, as that would break later layers
that build on top.

> +		} else {
> +			preferred_pack_id = m->num_packs_in_base;
> +		}
> +
> +		pack_int_id = m->num_packs_in_base - ctx->compact_from->num_packs_in_base;
> +
> +		if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
> +					preferred_pack_id) < 0)
> +			return -1;
> +
> +		for (i = m->num_packs_in_base;
> +		     i < m->num_packs_in_base + m->num_packs; i++) {
> +			if (preferred_pack_id == i)
> +				continue;
> +
> +			if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
> +						i) < 0)
> +				return -1;
> +		}
> +

So the condition that should hold after this loop is `pack_int_id ==
m->num_packs`. Which is somewhat obvious: we skip one pack, but that
pack is the preferred pack that we have populated first.

> @@ -1101,11 +1216,18 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  			 */
>  			if (ctx.incremental)
>  				ctx.base_midx = m;
> -			else if (!opts->packs_to_include)
> +			if (!opts->packs_to_include)
>  				ctx.m = m;

I'm a bit surprised by this change here. I would've expected that we
never pass `packs_to_include` when compacting, so why is this change
necessary?

>  		}
>  	}
>  
> +	/*
> +	 * If compacting MIDX layer(s) in the range [from, to], then the
> +	 * compacted MIDX will share the same base MIDX as 'from'.
> +	 */
> +	if (ctx.compact)
> +		ctx.base_midx = ctx.compact_from->base_midx;

Okay, here we overwrite `ctx.base_midx` that we might've already set in
the condition above. It's a bit confusing, doubly so because we may be
warning about the invalid MIDX and claim to ignore it, but ultimately we
don't.

> diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
> new file mode 100755
> index 00000000000..f889af7fb1d
> --- /dev/null
> +++ b/t/t5335-compact-multi-pack-index.sh
> @@ -0,0 +1,102 @@
> +#!/bin/sh
> +
> +test_description='multi-pack-index compaction'
> +
> +. ./test-lib.sh
> +
> +GIT_TEST_MULTI_PACK_INDEX=0
> +GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
> +GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
> +
> +objdir=.git/objects
> +packdir=$objdir/pack
> +midxdir=$packdir/multi-pack-index.d
> +midx_chain=$midxdir/multi-pack-index-chain
> +
> +nth_line() {
> +	local n="$1"
> +	shift
> +	awk "NR==$n" "$@"
> +}
> +
> +write_packs () {
> +	for c in "$@"
> +	do
> +		test_commit "$c" &&

Nit: it might be sensible to disable housekeeping here. You strongly
depend on the on-disk shape of the objects, so if you by chance wrote
two objects starting with "17" we'd end up repacking and racing.

I've also got an upcoming patch series in mindthat I've got cooking to
make geometric compaction the default for auto-maintenance. We've got
many test suites that implicitly rely on the current algorithm used by
git-gc(1), so I'd love to avoid adding more.

[snip]
> +test_expect_success 'MIDX compaction with lex-ordered pack names' '
> +	git init midx-compact-lex-order &&
> +	(
> +		cd midx-compact-lex-order &&
> +
> +		write_packs A B C D E &&
> +		test_line_count = 5 $midx_chain &&
> +
> +		git multi-pack-index compact --incremental \
> +			"$(nth_line 2 "$midx_chain")" \
> +			"$(nth_line 4 "$midx_chain")" &&
> +		test_line_count = 3 $midx_chain &&
> +
> +		test_midx_layer_packs "$(nth_line 1 "$midx_chain")" A &&
> +		test_midx_layer_packs "$(nth_line 2 "$midx_chain")" B C D &&
> +		test_midx_layer_packs "$(nth_line 3 "$midx_chain")" E &&
> +
> +		test_midx_layer_object_uniqueness
> +	)
> +'

It would be nice to also test for requests that don't make sense: "from"
larger than "to", "from == to", missing "from" or "foo" and so on.

Patrick
