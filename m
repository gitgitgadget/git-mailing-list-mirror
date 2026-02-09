Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F323374174
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654860; cv=none; b=Jr4B9pdwwkwOVXW4PJ7VCU7rUd6wtlLLwjOMh/WxHdKbgqiX96WTzNGzqFy7eBegj3eNdFN16QH6wF4P+FvIG3o6+Wq4JcA2C26cmBNzgUZ87iBhTOdgdr4KH83eIsSeCiyCB3UtxFoW/IxAVwPWWBxAI0ygY8SKRoS2nikP7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654860; c=relaxed/simple;
	bh=2DDUBGBs/noJPwp/q57vWTWKAXq8EVXq9srGu3BQqDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McoJ0LGwdc8IM9BiD7U+2VNfFXvtbCbJMtJhNk+QeCOtSGqWUkMnzvEf3lXoucKKHu0sv7qjPkosCgpES5VzSET5A0BmpB4QZwMb31mb8HXjGhJsq8Pxo5BWlkHGYQsFhLXP4LGLejZ4gFb2o3tjb9ni7QdnTCWUb90GneQyi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rSdjfDRM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dIreJ4ru; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rSdjfDRM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dIreJ4ru"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C7677A025C;
	Mon,  9 Feb 2026 11:34:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 09 Feb 2026 11:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770654858; x=1770741258; bh=4aLAj1wc/1
	ExMZz19hVGYCwWpeyjwMrdPV+xZi2TZa4=; b=rSdjfDRMkf3JlFrpvMcNz/lW+4
	uPU2Z/cOQfDCnrozqKkJCkTEgicfP9dLgvHiJ631xfhGG3oen9QVIjz0V02i3Q6r
	8kYI9T+H8zHgRZRfaDGk/hfNaUPOUpj6j3tIW1Yk2lxDngT1DaSlrIS/zJ8LsuCa
	quEOqnJC7AHAiEzC8r75c1oi9oJ/WLpvjWptFCggiRpJ2unef3lgxQ6bmdN/iIke
	hvnymkIxwHbNfkc+KkCQvDLH1ZS+kfpzI4IpR1aq0JOgIszEIkD1iYa9v9skx2fI
	Wo5rTmm2hTFHY0BGNaY8FK0seCwG9fbe/WBHz5/Emi6mBRlSh69cpuZ6bYrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770654858; x=1770741258; bh=4aLAj1wc/1ExMZz19hVGYCwWpeyjwMrdPV+
	xZi2TZa4=; b=dIreJ4ruCUeRdbyrtrdYMc23GDiz9NaZ64vqPsZZ5RRB8i+cQ9N
	7Z5+UTjtvQ8bAFeih+oROWPZKUUgvUaa0remN/G3mOgmbMHjPjz4VHwCWPn+04oa
	J4AUfs2j09OeX0N0GDLOmeKIYExeSW7awLKArZFECExzLxdsRWPDfRgF/1qbVRuG
	OG/V6X+hewYtoVgLy9p8L8SCSiQ37xbw8h1Fk83/x6SsogbQVMGwijrBxTibJqKJ
	L/1R6W6ONc/Opf5loCXUMX0zIjivjfQKdiUVmgALEThYZjqR2sqXZoEaWVcFxqZd
	Opuu2LgV4T+5Bw3opPtZLpKzDjwW5Z4s6bA==
X-ME-Sender: <xms:igyKaZr_l8R23dtGUj33pKHLifq1ZJlc16XO7hMgLu2yE1QCap0vzw>
    <xme:igyKaSrxgtWdRA2nlqRbsoyjfNqK8aEtQsLVN6d0M3OYHLDLwtJZUEPsnXZ3cm1Fv
    O0h48pd0qzNwKa5Sz2lZGhhUlzvbXU9nEeVnQH936a4xD6hznG1hA>
X-ME-Received: <xmr:igyKabN4Drq6vx65Ak63QPU_qgehBRhzPvQyTbo0UM_DVyd4PwNTPQW_ndsR_HmqIscTqS4WXBZ3moeUu0S04hmhEVy-25A9193JQFoYv-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleejfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhr
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:igyKaTxEvpAiFrv1puzCZIYsBD3mV6lR_T_FHnpf58Bb4Ig9YDJuzQ>
    <xmx:igyKaUsr4i7QJdKiBHCCGx5-5ChogK3GkIrlUqAebJJ_zs9usFIXcw>
    <xmx:igyKac4e7GosbIPZvQ6D4GP2FMR4yVRuU9P9MuEti15u6vG5KkjJ0g>
    <xmx:igyKaTRFCTzykcnZ9wwthXrZqymhdmbm-cJWs3-7dj5TodkM70Svsw>
    <xmx:igyKacOCbRw8mmJP--titeoPKsRixKnIWha7A3cLYsgLut70CpAiRWyO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 11:34:17 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id db945f04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 16:34:16 +0000 (UTC)
Date: Mon, 9 Feb 2026 17:34:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	gitster@pobox.com
Subject: Re: [PATCH v5 2/4] refs: forward and use the reference storage
 payload
Message-ID: <aYoMdqDDbt-BArQQ@pks.im>
References: <20260209-kn-alternate-ref-dir-v5-0-740899834ceb@gmail.com>
 <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-kn-alternate-ref-dir-v5-2-740899834ceb@gmail.com>

On Mon, Feb 09, 2026 at 04:58:19PM +0100, Karthik Nayak wrote:
> An upcoming commit will add support for providing an URI via the
> 'extensions.refStorage' config. The URI will contain the reference
> backend and a corresponding payload. The payload can be then used for
> providing an alternate locations for the reference backend.
> 
> To prepare for this, modify the existing backends to accept such an
> argument when initializing via the 'init()' function. Both the files
> and reftable backends will parse the information to be filesystem paths
> to store references.

Maybe add: "to store references. Given that no callers pass any payload
yet this is essentially a no-op change for now."

> diff --git a/refs.c b/refs.c
> index 36f3441632..d9df25d7c0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3425,3 +3426,33 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>  
>  	strbuf_release(&path);
>  }
> +
> +void refs_compute_filesystem_location(const char *gitdir, const char *payload,
> +				      bool *is_worktree, struct strbuf *refdir,
> +				      struct strbuf *ref_common_dir)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addstr(refdir, gitdir);
> +	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
> +
> +	if (!payload)
> +		return;

I think you should add a comment here that explains why it's not
necessary to modify the `refdir` in case `*is_worktree`. I'd arguably
even move that code into `if (!payload)`, as we otherwise only set it to
reset it later. So:

        if (!payload) {
                /*
                 * We can use `gitdir` as `refdir` without appending the
                 * worktree path because...
                 /
                 strbuf_addstr(refdir, gitdir);
        }

> +	if (!is_absolute_path(payload)) {
> +		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
> +		strbuf_realpath(ref_common_dir, sb.buf, 1);
> +	} else {
> +		strbuf_realpath(ref_common_dir, payload, 1);
> +	}
> +
> +	strbuf_reset(refdir);

And then you can drop this call to `strbuf_reset()`.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 240d3c3b26..b192ce606d 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
>   * set of caches.
>   */
>  static struct ref_store *files_ref_store_init(struct repository *repo,
> +					      const char *payload,
>  					      const char *gitdir,
>  					      unsigned int flags)
>  {
>  	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
>  	struct ref_store *ref_store = (struct ref_store *)refs;
> -	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf ref_common_dir = STRBUF_INIT;
> +	struct strbuf refdir = STRBUF_INIT;
> +	bool is_worktree;
> +
> +	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
> +					 &ref_common_dir);
>  
> -	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
> +	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
>  	refs->store_flags = flags;
> -	get_common_dir_noenv(&sb, gitdir);
> -	refs->gitcommondir = strbuf_detach(&sb, NULL);
> +	refs->gitcommondir = strbuf_detach(&ref_common_dir, NULL);
>  	refs->packed_ref_store =
> -		packed_ref_store_init(repo, refs->gitcommondir, flags);
> +		packed_ref_store_init(repo, payload, refs->gitcommondir, flags);

It's a bit weird that we end up passing the payload even though we
unconditionally ignore it in `packed_ref_store_init()`. I'd argue that
we should either pass a `NULL` pointer as payload, or let the packed
backend call `refs_compute_filesystem_location()` itsefl.

> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 4ea0c12299..028fbc0585 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -212,6 +212,7 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
>  }
>  
>  struct ref_store *packed_ref_store_init(struct repository *repo,
> +					const char *payload UNUSED,
>  					const char *gitdir,
>  					unsigned int store_flags)
>  {

And here we should probably explain why we don't have to respect the
payload.

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index c7d2a6e50b..bd09b1280c 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -666,4 +667,18 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
>  					  unsigned int initial_transaction,
>  					  struct strbuf *err);
>  
> +/*
> + * Given a gitdir and the reference storage payload provided, retrieve the
> + * 'refdir' and 'ref_common_dir'. The former is where references should be
> + * stored for the current worktree, the latter is the common reference
> + * directory if working with a linked worktree. If working with the main
> + * worktree, both values will be the same.
> + *
> + * This is used by backends such as {files, reftable} which store references in
> + * dedicated filesystem paths.
> + */

I guess we can say "This is used by backends that store store files in
the repository directly."

Patrick
