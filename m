Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0812032D
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499311; cv=none; b=WGwU8F1GavWB6JxnrDqphpY0y0OFB3XkaosxYyQ9ngobvl7d00Qpl71i0PVGLkUR5zpo3G8HsBQtKOPvKDU2QpZ2TPovd0MYuQi2GiDtvt6KDcsV2jvZivk3vShCpTwcCoN2FpsemyJ59tKhGyn1dbuG+D5raCMigV7K5K8ty4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499311; c=relaxed/simple;
	bh=tpJqlFsfZhDKhuyFhRpYBNeL3PaKjkaJZUg6U6cFHuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swjqzvSU4uHa3pvVjXKcGz5F9Ccj7tq1kR5NGN3vgEJB3gouA6llgfWFZf4+8OlHenfrtPRZUQss0EP3hJchJsslUHqv6A8Ce/DkfxK4txYtoaXQq1n2Eq25OaG7KwYEPBddMcsDe6qcd0LVizSZkex1UgWxuRyid6u0gzuAYIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GrqvwB0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G/hDmbYA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GrqvwB0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G/hDmbYA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FA7C1400304;
	Tue, 27 Jan 2026 02:35:09 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Jan 2026 02:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769499309; x=1769585709; bh=S0qCnkMhHb
	r7C6wqC90VrMji2lySC660JhCfVPSWyH4=; b=GrqvwB0MsAgXQLLm4CC2/l8A43
	dojET7Y8ULXKGK/hz4P+lFIbK0kvnvSpazOlWH6zXdwUpW1RCBYYO6/qcACfvOyp
	VWoyOw4Krls31EbOaoxP9QD9w5G3IxqakZ/pANitq7O4B/N57wOpQ4PWjjA15k/F
	Rx5NK23OnsUFe5QReQfje7Y+oqi5OzWSVFy/Yea5j2vob1Dz6yRnHqLxnK1CkAsi
	n9+0QINVgv5VnlzehphxH8C3uHc4Y007Vq92OsU9IIMrR7U/vysR3EuIi2q/cYhp
	avcPKfa/arlb8TIJsOCBek5uYSuIV0w1MD/7qlN5vidL5UaQdITL8jzL0TQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769499309; x=1769585709; bh=S0qCnkMhHbr7C6wqC90VrMji2lySC660JhC
	fVPSWyH4=; b=G/hDmbYAN6TqMWN3fVE6kJavzsQN/VYCz1QcTJyi+CoJlnMmds7
	Ty3tizJpvVvz7sJHlFE4TZU/v67RJdGXJGR5uzWQiTXoy64tWbSeywZv704t5uaZ
	J6w0AUYmq/pC070a0fpor9tfm6aTuPVN03wRCsuIcqdVbs2A81cy2G/9Fv+f6wj2
	Kxb+vFZcPzQCp1kOVnkrxSacL2nE5rmptHUu5ueSIQdrrlKPLOrGi6U7RolRYxsi
	4O/Zr3tLu8XUBU2AkYWYHd5KtU9KxgsWZB8vYLsk/VHqHmqhCkuUGKfc1V+ApMQU
	IkNqeVyie2Vo+hszEO4ikIQCMWQ9mCxhT1A==
X-ME-Sender: <xms:rWp4aS5LDL9zOYytkKIshfb6WUVTROtK-Exyb0S_29VFp-E17STyhQ>
    <xme:rWp4aSw9XLHtBjHZxiujh-KyH4LSD_PIOhgaHyztNWasQUscU_EfQs01qIbNFYLnY
    ME_gT8pXswdfpVukl_rsUGf6LgPyQNpK89TCtlUWBgn2LSyE8uhJw>
X-ME-Received: <xmr:rWp4aZwm3pKSV3AJMSxfNxv9SHFM83Y4x1FJ9VIJsa4OOTpZJUk1aSJukI6MG-pX3okH4cfIc-l7gEDbQcA3bM1BMxORbeH8xDD5EYJO71cT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:rWp4aazCt4TFWeAN8pRHkeEwR-DHnecvPmBwqJC3row4p_aM_Hrx7A>
    <xmx:rWp4aTYoym4Eqd_i3u9nBbrKWCBpvidW-L4WJXshMKKOMtFU5_A8Ww>
    <xmx:rWp4abX897WZTFXDlxkdrrdTg_gO711GJKDefO7YlVQbBpy89zWOxA>
    <xmx:rWp4aRh_toqkmDVaoSUhPRT_YX1OqGLhmZmg65_DOwtMqfMX40ybHA>
    <xmx:rWp4aXQwPbsMIu4k_IgBfZ52K2vTxIR7V-4AZiSgHP62FIZZw03Dqp1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 02:35:08 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9798a853 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Jan 2026 07:35:06 +0000 (UTC)
Date: Tue, 27 Jan 2026 08:34:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/18] midx: do not require packs to be sorted in
 lexicographic order
Message-ID: <aXhqo3f-NeUcO2IM@pks.im>
References: <cover.1765053054.git.me@ttaylorr.com>
 <cover.1768420450.git.me@ttaylorr.com>
 <72bcd4ed6c7f685f58bb3b905fe553173abe1845.1768420450.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72bcd4ed6c7f685f58bb3b905fe553173abe1845.1768420450.git.me@ttaylorr.com>

On Wed, Jan 14, 2026 at 02:54:45PM -0500, Taylor Blau wrote:
[snip]
> Because this change produces MIDXs which may not be correctly read with
> external tools or older versions of Git. Though older versions of Git
> know how to gracefully degrade and ignore any MIDX(s) they consider
> corrupt, external tools may not be as robust. To avoid unintentionally
> breaking any such tools, guard this change behind a version bump in the
> MIDX's on-disk format.

s/Because t/T/?

> diff --git a/midx-write.c b/midx-write.c
> index 8a54644e427..5c8700065a1 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -36,10 +36,13 @@ extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
>  
>  static size_t write_midx_header(const struct git_hash_algo *hash_algo,
>  				struct hashfile *f, unsigned char num_chunks,
> -				uint32_t num_packs)
> +				uint32_t num_packs, int version)
>  {
> +	if (version != MIDX_VERSION_V1 && version != MIDX_VERSION_V2)
> +		BUG("unexpected MIDX version: %d", version);

Asking the function to write a MIDX header of an unsupported version
would be a bug indeed.

> @@ -105,6 +108,8 @@ struct write_midx_context {
>  
>  	uint32_t preferred_pack_idx;
>  
> +	int version; /* must be MIDX_VERSION_V1 or _V2 */

Tiny nit: this could be converted into an `enum` for implicit
documentation.

> @@ -1100,6 +1113,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	struct tempfile *incr;
>  	struct write_midx_context ctx = {
>  		.preferred_pack_idx = NO_PREFERRED_PACK,
> +		.version = MIDX_VERSION_V2,
>  	 };
>  	struct multi_pack_index *midx_to_free = NULL;
>  	int bitmapped_packs_concat_len = 0;

Okay. Here we set the default version, ...

> @@ -1114,6 +1128,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  	ctx.repo = r;
>  	ctx.source = opts->source;
>  
> +	repo_config_get_int(ctx.repo, "midx.version", &ctx.version);
> +	if (ctx.version != MIDX_VERSION_V1 && ctx.version != MIDX_VERSION_V2)
> +		die(_("unknown MIDX version: %d"), ctx.version);
> +
>  	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
>  
>  	if (ctx.incremental)

... but the user can change it. Good.

> diff --git a/midx.c b/midx.c
> index 19ef230d3fd..1327d0a3695 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -656,17 +658,40 @@ int cmp_idx_or_pack_name(const char *idx_or_pack_name,
>  	return strcmp(idx_or_pack_name, idx_name);
>  }
>  
> +
> +static int midx_pack_names_cmp(const void *a, const void *b, void *m_)
> +{
> +	struct multi_pack_index *m = m_;
> +	return strcmp(m->pack_names[*(const size_t *)a],
> +		      m->pack_names[*(const size_t *)b]);
> +}

Okay, this took a second to figure out. The `pack_names_sorted` is an
array of `size_t` indexes into `m->pack_names`. So what we get here are
these indices, and we can compare by using those indices via
`m->pack_names`. Makes sense.

I was wondering whether this would be easier to follow if
`pack_names_sorted` was a simple array of unowned pointers. So it would
contain the same pointers as `pack_names`, but properly sorted. It would
have the downside of more confusing ownership semantics though.

I assume we cannot live with a simple `bool sorted` field and then sort
`pack_names` lazily?

Patrick
