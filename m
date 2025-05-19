Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4451E8322
	for <git@vger.kernel.org>; Mon, 19 May 2025 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747634557; cv=none; b=XS+mRvUFEYQ0APbka+d+wDoAUIxFWA63sv/DCaXfierCOkGTnnuIIEMmOO13Zn6TL1W76YwNCfNSwNzA0qELvtHzr6LGDEE7oAmpWZeDM7sUYnoMsgWyZED0IJr7W3oK/M4mTQvvBqR704QdffftBaUGdMF1bzGrLMMmYwGacC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747634557; c=relaxed/simple;
	bh=j2iqiABJy0rStUDwfks7mjylrMU8u1K9BOGQrJggQUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXYeZj9teKdqDA0ppNxNBJ2H3n7SbqpxDausvYbtoh9Q+CYyNsc3LvvEShKaSILkcZ1HWtEnEGRhvuAAPzuL0Kcj725OinVFlc38aTagNrTHkINuKrGouySsMGgbhlfHzd38C4Vs4TNF2uOhBChXj9EOASt79EpWtA94Tb1oEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wfx05s3w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bs3lbz1O; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wfx05s3w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bs3lbz1O"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B57B72540074;
	Mon, 19 May 2025 02:02:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 19 May 2025 02:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747634553; x=1747720953; bh=m45/LP/SvA
	kgxttSe8Mv4d+yz3AKg/YOqXZlZQQvTEY=; b=Wfx05s3wdlNCDR8oY05sWhEH90
	JbIRKK8X1KsOhS823Q6yHB5vvM+/f1pufWiO0O7fvumOw2+DYn5+y9V/InUlOEHS
	EQoZ8+hUm1ho1mDK5Yye7v8ICBIcDYGu4G1f6v4osdWjMRF6a+gnG/Lx4uC3+FSz
	Yy+jDYl/V4lNXDm9b23nx7Bj/90YiNETk9Ipeh9eFF2Mcq8Ug9HJrw/4jztOcg0/
	0RB1paLvssGIeSIiy2D3nnx7SMxvEASENVVavEfZ34cZhGwdMfrrsX2VG1yyDGYM
	fqgQHLz+728Zqo9zMVUni3Yu3Jp6dpk2I3i90g20GmH4Lnf3v+ndvqTd2ulw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747634553; x=1747720953; bh=m45/LP/SvAkgxttSe8Mv4d+yz3AKg/YOqXZ
	lZQQvTEY=; b=bs3lbz1OCeAK/wMgPMd/aWboh6UHdotRDbupYQXtnHdX2O6rwZ8
	erL6RM5891yV8yFiaS5Q93gZGy3vnTy5cHDg7vPXOVWt62Jecg85CigstE+8tDln
	DCSzYBtdxMboT13UkT1jYngQmpJehWdptQtzrttSlbtLnrdtWAwCRHyoNF8fFCf/
	YO/qp2/AZ5qqtdcknUeOuwP9Y7QtbHs+lgWqbnfY6vOzyTbIfNCYJWqPhXrQLovS
	q+DKzBVwGQ/oMpQpzQcb9T2iYnezk5QMpOXtMPEhebXAMKgZ2gIpWH1s/o9RJgeF
	EJY3WM4WAsiBGJzXbYwmq6NYtlarUZGPFzg==
X-ME-Sender: <xms:eMkqaC4UvF4Z-cDNbYfGqRrnQfnaHE8mEr1JT5NrRUJh-JPvS0irZw>
    <xme:eMkqaL4HlBb0DaFoz3jYG1QXYM93Yvg3e1hV84-Tw_cWGIRHQrwtEcyffX4IOTY90
    OXWYFkEasFKWvfZMQ>
X-ME-Received: <xmr:eMkqaBdYhHpVFUvr5-6ZGdOVG9a5AAzGGqs0j5FYGTLIeS_1S-4eVM31CJLwiQz_DFRqwKQBii8y6PtFUS_wToM1OLe8JAgqY3i6L5SjRWP9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddtiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:eMkqaPKXlX04mxlntrHIUJt_2XTWXmaP_bb0Xm6lknsft1g_mRD2Ig>
    <xmx:eMkqaGLikArwn-wA_8S9rtD4wW1UBbTGkUGIU8Y6eeslK_hD-i59LQ>
    <xmx:eMkqaAwMU9oXkzlL3xtMzvXLFHFqWI1PCPKp37szIlM1FVV8GXrTSw>
    <xmx:eMkqaKJ63If-KGzqR9GKNT_6IqDBBLVW5-osCvN5L3I_rFF12OzKbw>
    <xmx:eckqaPlMUXjaSg3ebnXhH5J1XFq6QAxbhZTVYDOXUPWNj3vUEiHC4mLf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 02:02:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a6a1dbc0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 06:02:29 +0000 (UTC)
Date: Mon, 19 May 2025 08:02:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] pack-bitmap: add loading corrupt bitmap_index test
Message-ID: <aCrJcK6ml4r4S-mF@pks.im>
References: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>

On Sat, May 17, 2025 at 02:26:22PM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> This patch add a test function `test_bitmap_load_corrupt` in patch-bitmap.c
> , a `load corrupt bitmap` test case in t5310-pack-bitmaps.sh and
> a new command `load-corrupt` for `test-tool` in t/helper/test-bitmap.c.
> 
> To make sure we are loading a corrupt bitmap, we need enable bitmap table
> lookup so that `prepare_bitmap()` won't call `load_bitmap_entries_v1()`.
> So to test corrupt bitmap_index, we first call `prepare_bitmap()` to set
> everything up but `bitmap_index->bitmaps` for us. Then we do any
> corruption we want to the bitmap_index. Finally we can test loading
> corrupt bitmap by calling `load_bitmap_entries_v1()`.

Okay. We _can_ do that now, but the patch doesn't explain why we
_should_.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index b9f1d866046..9642a06b3fe 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -3022,6 +3022,71 @@ cleanup:
>  	return ret;
>  }
>  
> +typedef void(corrupt_fn)(struct bitmap_index *);
> +
> +static int bitmap_corrupt_then_load(struct repository *r, corrupt_fn *do_corrupt)
> +{
> +	struct bitmap_index *bitmap_git;
> +	unsigned char *map;
> +
> +	if (!(bitmap_git = prepare_bitmap_git(r)))
> +		die(_("failed to prepare bitmap indexes"));
> +	/*
> +	 * If the table lookup extension is not used,
> +	 * prepare_bitmap_git has already called load_bitmap_entries_v1(),
> +	 * making it impossible to corrupt the bitmap.
> +	 */
> +	if (!bitmap_git->table_lookup)
> +		return 0;
> +
> +	/*
> +	 * bitmap_git->map is read-only;
> +	 * to corrupt it, we need a writable memory block.
> +	 */
> +	map = bitmap_git->map;
> +	bitmap_git->map = xmalloc(bitmap_git->map_size);
> +	if (!bitmap_git->map)
> +		return 0;
> +	memcpy(bitmap_git->map, map, bitmap_git->map_size);
> +
> +	do_corrupt(bitmap_git);
> +	if (!load_bitmap_entries_v1(bitmap_git))
> +		die(_("load corrupt bitmap successfully"));
> +
> +	free(bitmap_git->map);
> +	bitmap_git->map = map;
> +	free_bitmap_index(bitmap_git);
> +
> +	return 0;
> +}
> +
> +static void do_corrupt_commit_pos(struct bitmap_index *bitmap_git)
> +{
> +	uint32_t *commit_pos_ptr;
> +
> +	commit_pos_ptr = (uint32_t *)(bitmap_git->map + bitmap_git->map_pos);
> +	*commit_pos_ptr = (uint32_t)-1;
> +}
> +
> +static void do_corrupt_xor_offset(struct bitmap_index *bitmap_git)
> +{
> +	uint8_t *xor_offset_ptr;
> +
> +	xor_offset_ptr = (uint8_t *)(bitmap_git->map + bitmap_git->map_pos +
> +				     sizeof(uint32_t));
> +	*xor_offset_ptr = MAX_XOR_OFFSET + 1;
> +}
> +
> +int test_bitmap_load_corrupt(struct repository *r)
> +{
> +	int res = 0;
> +	if ((res = bitmap_corrupt_then_load(r, do_corrupt_commit_pos)))
> +		return res;
> +	if ((res = bitmap_corrupt_then_load(r, do_corrupt_xor_offset)))
> +		return res;
> +	return res;
> +}
> +

Does all of this logic really have to be part of "pack-bitmap.c"? It
would generally preferable to not have our production logic be cluttered
with test logic. Sometimes we don't have a better way to do this, but
you should explain why we cannot host the logic elsewhere in that case.

My proposal would be to either move the logic into "test-bitmap.c", or
to even better to write a unit test in "t/unit-tests/". After all, we
expect that the code should fail gracefully, so a unit test might be a
good fit after all.

Patrick
