Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1653D4120
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943329; cv=none; b=tdk0Lcnr+8tLz+T8i0xe1rcNtxDH7Hbtj5CRSiwmPhtztniGDpqXioz98Jm8GcIIJkeOQqTHIHIph16wEpNU7bCG/twdfoiDBs1LmEYwdaSUXOXqFRdjcxpRchTcpEjwYUFhhaR0TSRwCOe1INBg3GbZSlVP5ivxs7eGcCEbrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943329; c=relaxed/simple;
	bh=lkRkDpe1wzQ8ocJa/r49SVV380W5iRn1vEpKuV7HhY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE6Tz3IdYeY8Ve7gAc6jc/z/+tYozd882zjI6fdwjNbNyGrxGcblVTcp6h10d8kglp7bJxlX+2oD2rKxTYJm7/Yd+zXfaRJeRkOsCKlLSktIRN0Zz6ScbBVTtF4ESxD/qYBWX3FI+ZsR5BsgI/Qa4oSXUXg5CeVTAK6lu0Z12uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L/w5fWAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cN9NeOxj; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L/w5fWAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cN9NeOxj"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EC33A1400259;
	Tue, 31 Mar 2026 03:48:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 03:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774943326; x=1775029726; bh=4cX4wOt/tU
	nkuZhyZrU7OWA+NHFM3tuhzyo+CspRbPE=; b=L/w5fWAzQDqduytziMF7Ffhri4
	BUbkUGFWXON2OY00B37S9bh3Z+BkbyfETH3WH0sQISC/86XObYJBmmAs3U7AoPTs
	hlk+qIwreXVuGFVoy96p6/CZoU2fzOCvjdp9NEtUyFgT4SJJIPq/EhXu7OOulYs+
	lv4yH22T+xKPL6S0LH+9L5ziYhoSC+dgH35OL5s8TytG6cSLKWDiFvFwicoRR3Pz
	vtE4kaN2vGrFdPUJteF48mN3/MLKDDrNIjgd1jAjdLcVoCzqCOjtrHY2pB9qmk0F
	mxs1DiybRcBHQ+e6jRckP5gfMY6NaeSrhjg15g6TB6sOaUbsHPiVFb5fHzVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774943326; x=1775029726; bh=4cX4wOt/tUnkuZhyZrU7OWA+NHFM3tuhzyo
	+CspRbPE=; b=cN9NeOxjCSAmcHydJZGkSKo5FcXkbGjw/aDuqmXd8Rs/WafPJW0
	OG02dGkwdAdG0zz7OJCftCcgzKJzeAovpHhS9KqEB83C49T9I/cCVjtlJWxgVDVI
	85VgfxDAahQOK5Z2M8ej9pquFXU/Uw3K8YS80BwKEKIEpiBBYQ2AdT8sVGQ2LWpI
	0apYo+1b36cJmhihZ5FsICU7bptPqxyJatTOuBsfEEjRlN92zWScriLVw2G26hSs
	53unuVNJpJq7/wBPjwnrE/TySYk+3BJC97eCXgb2iG95k/UVUb3bmyhVNDJDAuXn
	o7uDN0GY3b1TN6BZBB8Lwxy3O3DMH4BXGYw==
X-ME-Sender: <xms:XnzLaeRw7TRHU3xQgQQdKwihkGEBX68tU9Xm_LrPPiC4OnUfsPrryw>
    <xme:XnzLaZyISX_LAjBrAj9CS-sq9N_dA5A6yTi0GlxMYXrENsQ8uCN46G70QevU3ZR8F
    vf7wNVagC1paKrEuEAeBBKirAe9KU_Dkf-UxKeqdeEKaH-mI9UODA>
X-ME-Received: <xmr:XnzLaZdIJK_7ZH0OI6sencEqlelZStcvpobm9_CNtsgNpuaF81JjxRW7DFhXflI6HnQAKLl2zgfuuIm8FtJfyFVKHjx8m5C0g6O6Wwtr5wE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XnzLaVLbuDCJHcXLa9S3IfWqGod8k_jUHzi4IkQhSyR_0BxxeNmH8Q>
    <xmx:XnzLaaGLHwnWoyfRXUsgv5UK0lPbQTO6zDKrYuHR9sNNSoMFOyX_kQ>
    <xmx:XnzLafoE5S2U9oxfY46DD4jHXwtjQG7ilXw4F0YLMhNzfiYEwKeg0w>
    <xmx:XnzLaTRtCIt7f9rBH9N17QOEP5EbRatz3rsZFYi60iOj_S5RzJHRRg>
    <xmx:XnzLaSDaySY1imo6f0lCk5by_ojlzZk3k5IxMTEtmz0ZcAG6BR42lA-4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 03:48:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf1cb1bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 07:48:45 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:48:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] object-file: avoid fd seekback by checking object
 size upfront
Message-ID: <act8W1BEg6iyUpHB@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331033835.2863514-5-jltobler@gmail.com>

On Mon, Mar 30, 2026 at 10:38:33PM -0500, Justin Tobler wrote:
> In certain scenarios, Git handles writing blobs that exceed
> "core.bigFilesThreshold" differently by streaming the object directly
> into a packfile. When there is an active ODB transaction, these blobs
> are streamed to the same packfile instead of using a separate packfile
> for each. If "pack.packSizeLimit" is configured and streaming another
> object causes the packfile to exceed the configured limit, the packfile
> is truncated back to the previous object and the object write is
> restarted in a new packfile.
> 
> This works fine, but requires the fd being read from to save a
> checkpoint so it becomes possible to rewind the input source via seeking
> back to a known offset at the beginning. In a subsequent commit, blob
> streaming is converted to use `struct odb_write_stream` as a more
> generic input source instead of an fd which doesn't provide a mechanism
> for rewinding.
> 
> For this use case though, rewinding the fd is not strictly necessary
> because the inflated size of the object is known and can be used to
> approximate whether writing the object would cause the packfile to
> exceed the configured limit prior to writing anything. These blobs
> written to the packfile are never deltafied thus the size difference

s/deltafied/deltified/

> between what is written versus the inflated size is due to zlib
> compression. While this does prevent packfiles from being filled to the
> potential maximum is some cases, it should be good enough and still
> prevents the packfile from exceeding any configured limit.
> 
> Use the inflated blob size to determine whether writing an object to a
> packfile will exceed the configured "pack.packSizeLimit".

I agree that this is a reasonable tradeoff:

  - For small objects it's probably not going to make a huge difference,
    as we'd at most waste a couple kilobytes.

  - For large objects we can expect that we wouldn't use deltification
    anyway due to "core.bigFileThreshold".

  - We can expect that in many cases large files will be not compress
    well, either, as it's more likely than not that a file >512MB (our
    default limit for "core.bigFileThreshold") is going to be a binary
    file.

We also nicely document "pack.packSizeLimit" as "rarely useful, and may
result in a larger total on-disk size" in git-config(1), so I think it's
fair to not bend ourselves over backwards just to make a rarely-useful
feature work exactly the same.

> diff --git a/object-file.c b/object-file.c
> index 493173eaf4..1de2244ac5 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1473,15 +1461,10 @@ static int stream_blob_to_pack(struct transaction_packfile *state,
>  			if ((size_t)read_result != rsize)
>  				die("failed to read %u bytes from '%s'",
>  				    (unsigned)rsize, path);
> -			offset += rsize;
> -			if (*already_hashed_to < offset) {
> -				size_t hsize = offset - *already_hashed_to;
> -				if (rsize < hsize)
> -					hsize = rsize;
> -				if (hsize)
> -					git_hash_update(ctx, ibuf, hsize);
> -				*already_hashed_to = offset;
> -			}
> +
> +			if (rsize)
> +				git_hash_update(ctx, ibuf, rsize);

Is this guard really needed? I wouldn't expect that we ever try to read
zero bytes into `ibuf`, and we bail in case we didn't receive the
expected number of bytes.

And even if we did, `git_hash_update()` works just fine with no data.

> @@ -1592,48 +1566,34 @@ static int index_blob_packfile_transaction(struct odb_transaction_files *transac
>  					   size_t size, const char *path)
>  {
>  	struct transaction_packfile *state = &transaction->packfile;
> -	off_t seekback, already_hashed_to;
>  	struct git_hash_ctx ctx;
>  	unsigned char obuf[16384];
>  	unsigned header_len;
>  	struct hashfile_checkpoint checkpoint;
>  	struct pack_idx_entry *idx;
>  
> -	seekback = lseek(fd, 0, SEEK_CUR);
> -	if (seekback == (off_t)-1)
> -		return error("cannot find the current offset");

Okay, no seeking necessary because we don't restart the write anymore.

>  	header_len = format_object_header((char *)obuf, sizeof(obuf),
>  					  OBJ_BLOB, size);
>  	transaction->base.source->odb->repo->hash_algo->init_fn(&ctx);
>  	git_hash_update(&ctx, obuf, header_len);
>  
> +	/*
> +	 * If writing another object to the packfile could result in it
> +	 * exceeding the configured size limit, flush the current packfile
> +	 * transaction.
> +	 */

Do we want to document that this intentionally works on the inflated
size, not the deflated one, with the arguments mentioned in the commit
message?

> +	if (state->nr_written && pack_size_limit_cfg &&
> +	    pack_size_limit_cfg < state->offset + size)
> +		flush_packfile_transaction(transaction);

And we now flush the packfile before writing any object that may cause
us to bust the size limit. Makes sense.

>  	CALLOC_ARRAY(idx, 1);
>  	prepare_packfile_transaction(transaction);
>  	hashfile_checkpoint_init(state->f, &checkpoint);
>  
> -	already_hashed_to = 0;
> -
> -	while (1) {
> -		prepare_packfile_transaction(transaction);
> -		hashfile_checkpoint(state->f, &checkpoint);
> -		idx->offset = state->offset;
> -		crc32_begin(state->f);
> -
> -		if (!stream_blob_to_pack(state, &ctx, &already_hashed_to,
> -					 fd, size, path))
> -			break;
> -		/*
> -		 * Writing this object to the current pack will make
> -		 * it too big; we need to truncate it, start a new
> -		 * pack, and write into it.
> -		 */
> -		hashfile_truncate(state->f, &checkpoint);
> -		state->offset = checkpoint.offset;
> -		flush_packfile_transaction(transaction);
> -		if (lseek(fd, seekback, SEEK_SET) == (off_t)-1)
> -			return error("cannot seek back");
> -	}

Hm. I was briefly wondering whether we'd loop indefinitely in case the
object alone is bigger than the packsize. But we have an escape hatch in
`stream_blob_to_pack()` that special-cases when we haven't written any
data yet, so the answer is "no".

> +	hashfile_checkpoint(state->f, &checkpoint);
> +	idx->offset = state->offset;
> +	crc32_begin(state->f);
> +	stream_blob_to_pack(state, &ctx, fd, size, path);
>  	git_hash_final_oid(result_oid, &ctx);

Thanks!

Patrick
