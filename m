Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50F261B99
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643021; cv=none; b=oLQSusY/MXYHSQqkiWlLrOoWYm3PoSY3hqURm6Zt6Xpr4AhKzgdXog3U6lTq1lmGgvpRZ1NhNyxWndtNDISeEEDs/RJWKIYf94htQ+0n5nJgvgFkKZxL5ghefReByLakg/anSh4oR8ZyfN2gBNHXek4l+UrhpLmlXD719mgJj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643021; c=relaxed/simple;
	bh=EVw3I0gNCU27qBa7w88voTBrnrS3GN0Iqr6qkiSwpN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzhqZv2wDIRCirPlyRSZ7DgklF6pPaB7B7T0eF0oQLPWtlum8zWwPZVfn7cpwHzp1MC84Y2uIa7jDgwTFDQvVsLOuI/qfZnCkd1Ph9fz1ORm+Qg4eEIc+dZtq2SG/qbR4MLfzQQR3/rO+rJIF06Fw8Ti6F46DyXuRR8vHX7iiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kvJ5HeGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VNQBGHN0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kvJ5HeGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VNQBGHN0"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF6EA14002D4;
	Tue, 28 Oct 2025 05:16:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Oct 2025 05:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761643017; x=1761729417; bh=4v5fepCoje
	hoKD1MamMEg5qD6wFn0eEA5wI/FihOkoA=; b=kvJ5HeGxjNddSQyJLF6FjeJRb9
	GmSIzHpo2QjN7owfbulYbjIgFi1oQPHAVvs6PPTmaukV+nley7knGrPUol2DhoNs
	epW5qRz1Np7mn6EIO3gdwHhbqUu/3DWd8mwlNr7rbE+hFFj/eLMqb8XR/LGXprbW
	cIgYfF/jbNNvcij5Wo6oDDfV1CR5QKqVgZdbsp4wb1PbzDXHr3u2FF4V7a4PL5Hl
	3GQssaP/dwh1yYwaLT8tpU9IHnrO2K1d3SPu/wI2/o0FtEIBQgVOa0WBUak7/TDI
	ezP7lmJtAaBZIYgAFmNVqTFSyH2QgWnfZBYMZh2LzbdyUaskdTFI+6/DR/CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761643017; x=1761729417; bh=4v5fepCojehoKD1MamMEg5qD6wFn0eEA5wI
	/FihOkoA=; b=VNQBGHN0CBQGHvje48x+YVbZbXrOqAs674lRXPvhKSygHreLtcY
	ZvLKKmW+iyduBUcORul2syG+6qyOlI0qzFB1tpgXuv7cfVG4Wezg5xh1CBnTtZWX
	7Rn8SPhWJvjC1cLrWWU8U6DE2Kfx6O7zKhyl3wMx4VSLnYcXgrci8h4F/cQkL6L5
	0Go9cCviuVE0jzxgJJQco8sYIV9zsN8HTRfBFGFG4IUCdLgjpsOIsZa0Sk6zBIqY
	Z8chm1zKV2ckWG7Nsns14hy7JkYkNbH5iGMK+TtWZNsQe8/Lb2uqAnlTH57tbQ66
	IGznR2mLc3WZX4S7BdAY4jcHeBpyT2wYSDg==
X-ME-Sender: <xms:CYoAaS5NiklNtTNTS_NR9ji2o0wgdLXardINs4nUOME5Hd7CnveRKw>
    <xme:CYoAaS7x0P5kc_qGYBZPLDyGQPPsXgPvBms5c1-ZlGGrx7wM1AJXoBNZpebl44KM6
    yMYSYZUmK_sX1abzSpK4k-JypUxcjFi6HaLGloGiU0YybU3bsRZFog>
X-ME-Received: <xmr:CYoAaWcS-N-nUgjRDKyAR0kzWeeGgJbaybvzDtb8Rm3QdJlZSKassvRt4L4fG3PTG74dxucJUFTjE69I43e-ksnoe6r_Tt6_pqISMSUulw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedtgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:CYoAaeBtPF-QvIkV7Ng03NhVYl_4yjZDpHHN9xbDy6UljDcvWDzsCQ>
    <xmx:CYoAaR8-Mw8ccJprJvfgeQ3CVFzlyLhrPXkmWil2AIuewWL3PWxpHA>
    <xmx:CYoAaRKby_fv68rbmwY8xJ6K0tCjTMwE4WuaFnkQSQg7eO9cICzVqg>
    <xmx:CYoAaShGhof_2-LVNOGCTyzq_H4hiXwh_Tt8icB0tYB8H2rPvu434w>
    <xmx:CYoAaejUjDuatuIFGcpe4CsBQlgDemu9T1o-0VOpOYC_l-5sIsRAorLW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 05:16:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 55b5a180 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 28 Oct 2025 09:16:55 +0000 (UTC)
Date: Tue, 28 Oct 2025 10:16:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 01/14] repository: require Rust support for
 interoperability
Message-ID: <aQCJ_UCkVRYkhdCI@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027004404.2152927-2-sandals@crustytoothpaste.net>

On Mon, Oct 27, 2025 at 12:43:51AM +0000, brian m. carlson wrote:
> We'll be implementing some of our interoperability code, like the loose
> object map, in Rust.  While the code currently compiles with the old
> loose object map format, which is written entirely in C, we'll soon
> replace that with the Rust-based implementation.
> 
> Require the use of Rust for compatibility mode and die if it is not
> supported.  Because the repo argument is not used when Rust is missing,
> cast it to void to silence the compiler warning, which we do not care
> about.
> 
> Add a prerequisite in our tests, RUST, that checks if Rust functionality
> is available and use it in the tests that handle interoperability.
> 
> This is technically a regression in functionality compared to our
> existing state, but pack index v3 is not yet implemented and thus the
> functionality is mostly quite broken, which is why we've recently marked
> this functionality as experimental.  We don't believe anyone is getting
> useful use out of the interoperability code in its current state, so no
> actual users should be negatively impacted by this change.

Yeah, I don't see much of an issue with this.

> diff --git a/repository.c b/repository.c
> index 6faf5c7398..823f110019 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -192,11 +193,17 @@ void repo_set_hash_algo(struct repository *repo, int hash_algo)
>  
>  void repo_set_compat_hash_algo(struct repository *repo, int algo)
>  {
> +#ifdef WITH_RUST
>  	if (hash_algo_by_ptr(repo->hash_algo) == algo)
>  		BUG("hash_algo and compat_hash_algo match");
>  	repo->compat_hash_algo = algo ? &hash_algos[algo] : NULL;
>  	if (repo->compat_hash_algo)
>  		repo_read_loose_object_map(repo);
> +#else
> +	(void)repo;

You can annotate `repo` with `MAYBE_UNUSED` instead of casting.

Patrick
