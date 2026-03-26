Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8AD3F7A84
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527655; cv=none; b=qqvsXxghVV4baaSvKKdWFbI9ZttwQ6wnRzdWOJ8GCuDVl7KnBb0Vu/g8+MwQV2xUq+NhpTXT3+Qm1v4+xEO6KCtqyMxd9/hnfJi6vnyFUJin/yGBx5CdsLl6fYXry0f8LUDPgBZvjTJWhs1H5xPNLAeaoBvTbC4fG6iadOUBwhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527655; c=relaxed/simple;
	bh=8gAgVSfQrBZW6aQwM+jo+BWxLmxDA97JakLZwAk+TrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O80v/WxrRWmUYxckl/T9zLHBeVH1z2F5wTPihZw6vr675/9buxJIhoARK4mqgAI3boA0KoRAP7VtUpp8dsE2fA1/4cRbTszhP8idC3+6KmtDINjjcamFh+SSnX9hn805/m0+9HfeeSgxFUMXYXUSB4AHdtrD7UTxjAFJv0pmUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QSkdFBAI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2DMaJXmt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QSkdFBAI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2DMaJXmt"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3033D1D00065;
	Thu, 26 Mar 2026 08:20:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 26 Mar 2026 08:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527652; x=1774614052; bh=G2ZhRT8l9X
	9tTTv5gpVmC1oOso2xCIMtcBpdjz602ws=; b=QSkdFBAIG1wLM5zTGAvDbgZLJX
	HX3r2BSC3gmRQqRR3+01/3FRYtN4vqD/6ezwVbNJumWTK4vDc41Ef0pcgq8RjmaE
	CsYY111VTHG3fg6yQBkNI9huFnhD22mB8XD5oJ/xF5/o1D3Sz/oYO8ZHBhPFjL8F
	dvUuQrpY7fDnpK7FO+BbN4JjoLxCCnGUgaMPLgIhQ/IKoMSmwPawBSELnU06viyd
	gKapB3gBGTUvIshf39EI6GD0Yg3jiosKtEVM6Qq+uiNC7SNAkYf8BG3CUt5EWCa1
	vtlIqJbheW5nBuZjicyt8nTxyX66n1ZLdJo71V77m4bPc2h13fAgLsQrUirQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527652; x=1774614052; bh=G2ZhRT8l9X9tTTv5gpVmC1oOso2xCIMtcBp
	djz602ws=; b=2DMaJXmtZvkr/u6ZCzvXjM7VvpI1qIh11K2mbVP0flM/Ow766AT
	HdUx/sfvUFvVVMm5g/BfO8TSGeU1UGiDXCB7v2NHambbLa9B0HtNFCr/i3xdll2Y
	gFL1zLw/nrnox4ohFY9ryGbm2zcBRH+zUab40uZdJtKBTl0vbkvNPyzqagc4b92C
	rPmU2z0kVOq56JinLE+370iuECoMqt3tMwKBYtFd1yiRYApN+VholxWAE2LHZiPx
	0ZQbKpAEu2wf0kJkeHa3kT1WHbiUJNPsQZszsHCD7VJTkJIgjQ/Lg0mpCgZcEe+3
	R02DcqFhdCv9vNulCQusYjFiRsmtsocnMsQ==
X-ME-Sender: <xms:pCTFaTr3CCCi4j76rChYXrC74jdOCcF79iMyUQ42SsQwfFQeFgfe4Q>
    <xme:pCTFaf5jNeYzosNdHX07h2R21wikYhJ-yizWNP3cARCqgmAiusMtoTJpocOsnJnvb
    lgT7SJvADH4X5Eu12zhQKVaLoO-HRM91QjHah3d0mnhrcagVlgDzIk>
X-ME-Received: <xmr:pCTFaSej_VmuINNCxZfEyabBR58PscHM5T_7DeQdw-RWLM7ah6GCo1uU7uVeQVqAPdyDxRY9PLmAkr50C6NQppxnUWWc10MKCDzx8pBuqxvZTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pCTFac7vNvp0DXMRI_Qyd99xQ2TVnxAOwS92zm5GirqbzHr5nyRKDw>
    <xmx:pCTFaRsDdOJX5To-Vq_wh0F8kwS1ljHvqeiP_Z2SNRZU1lpDt29TaQ>
    <xmx:pCTFaUj0YD_waAlIHJf5D5kfsW5I5Nm3LngunyTFbVqmaWnxNFKnlg>
    <xmx:pCTFaUoO-y2D4Efzxm3FMcMyzuLO5rpI-k1l-9ROUowObnh4PoFFNA>
    <xmx:pCTFacpRz2885ufv5D4NAgIC7xRb3ej3qmSWTSbyuMGqOoWQOsxk-02M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:20:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c262528 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:20:49 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:20:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/16] promisor-remote: try accepted remotes before
 others in get_direct()
Message-ID: <acUklLd07f04wOYi@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-2-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:04AM +0100, Christian Couder wrote:
> When a server advertises promisor remotes and the client accepts some
> of them, those remotes carry the server's intent: 'fetch missing
> objects preferably from here', and the client agrees with that for the
> remotes it accepts.
> 
> However promisor_remote_get_direct() actually iterates over all
> promisor remotes in list order, which is the order they appear in the
> config files (except perhaps for the one appearing in the
> `extensions.partialClone` config variable which is tried last).
> 
> This means an existing, but not accepted, promisor remote, could be
> tried before the accepted ones, which does not reflect the intent of
> the agreement between client and server.
> 
> If the client doesn't care about what the server suggests, it should
> accept nothing and rely on its remotes as they are already configured.
> 
> To better reflect the agreement between client and server, let's make
> promisor_remote_get_direct() try the accepted promisor remotes before
> the non-accepted ones.

Interesting, and it feels sensible to me. Is it documented anywhere that
the ordering of announced remotes is actually important?

> Concretely, let's extract a try_promisor_remotes() helper and call it
> twice from promisor_remote_get_direct():
> 
> - first with an `accepted_only=true` argument to try only the accepted
>   remotes,
> - then with `accepted_only=false` to fall back to any remaining remote.
> 
> Ensuring that accepted remotes are preferred will be even more
> important if in the future a mechanism is developed to allow the
> client to auto-configure remotes that the server advertises. This will
> in particular avoid fetching from the server (which is already
> configured as a promisor remote) before trying the auto-configured
> remotes, as these new remotes would likely appear at the end of the
> config file, and as the server might not appear in the
> `extensions.partialClone` config variable.

Not quite sure I correctly understand this paragraph. Is the idea that
in the future, we might not even store announced promisors in the config
at all but simply use whatever the server announces on any given fetch?

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 96fa215b06..3f8aeee787 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -268,11 +268,37 @@ static int remove_fetched_oids(struct repository *repo,
>  	return remaining_nr;
>  }
>  
> +static int try_promisor_remotes(struct repository *repo,
> +				struct object_id **remaining_oids,
> +				int *remaining_nr, int *to_free,
> +				bool accepted_only)
> +{
> +	struct promisor_remote *r = repo->promisor_remote_config->promisors;
> +
> +	for (; r; r = r->next) {
> +		if (accepted_only && !r->accepted)
> +			continue;
> +		if (!accepted_only && r->accepted)
> +			continue;

This can be simplified to `if (!accepted_only != !r->accepted)`.

Also, can we maybe add a test for this to verify that we use the correct
ordering now?

Patrick
