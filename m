Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7534E15D5B6
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400056; cv=none; b=Fie1ZtQFqrS2bwwyWR55YA9Wc3LXXiNWYqRrCHyx8XYu2TihPtG+RxVFuSjfoNXloN4mnyE0E7NJ8E1poKXevNpmI+fImYje4Z9/JBdAhYceW5409waoE1YhWLB/wSzrceq5Nk2Mg2qlEcOg2929FrDfLOdgTmIgDh4tVOrEnEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400056; c=relaxed/simple;
	bh=nrR0jrozicSKzGm/7T+I0f2qiY2lS8aihYMlAhOiPyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxg/hc+SjmnBN47ROyRNI27sJ6otZJk4196DQ26KezHI7nw2LiThhc/YGwJhNf3mSf/Mphfq22QDp0WxJFgTo+LMnwiFgPihjrcBI23hGeFMzwTZ186g52SGnTZiuUazXBTbSseNRliRwHlI59qL/W0cm303tWUeDgk2hiTvspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FOTJQRxn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1TYmI1xt; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FOTJQRxn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1TYmI1xt"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B8551140166;
	Wed, 19 Mar 2025 12:00:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 19 Mar 2025 12:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742400053; x=1742486453; bh=keZD9ZbRQy
	NeYwYTjOm7AVmIQkpS09MxmpGmbyVA3pg=; b=FOTJQRxn01xP+sGafVwM9vq+8G
	hQc4TQquluT5eiCdEf2ej6AEreYBmes2ZIsAm4uPhMoRjkFrPUpQrLQ3pGg44mAa
	gkh+xJjgOEV7x7AHS1WF1lswNTaKGd/uhEOxHTZG9YFHhhteVgyz7fQE6PfW6X4S
	QoXh5sNw7gD7+OqCb7PBcxjL2Rbvi6LAk770Mr7LiWPxlw9o6QS6OPxV6/xxyiuX
	zbZldqop9UWK3F7b9lrn7dwv0411l0x3q3jn0Q7zw+PkB6WbPGromkQw6D48Uvl4
	aRDgKTQ3EepxOPBleBInewfPxBcyhemM6ah4koVAfl3j9NjhUPHxt+HdlntA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742400053; x=1742486453; bh=keZD9ZbRQyNeYwYTjOm7AVmIQkpS09MxmpG
	mbyVA3pg=; b=1TYmI1xtmpK6jDKZ22nbg+j/J3UzjIq1JfWBKtBt4K5wSuQKbl7
	jqjIiev04776Joe840eK1hkBjuod/5tdgoA8lwbtsqOMJ0rdFmaMheOcmLPq2Cag
	fFuORToyuSaR8xVYJu3OmyJCAdIwAiHTMNj+DhcmKsHSgaWNHfXUjoOzgOljqF4I
	6pFwffxMlTkPSGryRftDO8T47koeHkxdulqKTjDpFb9Y33WrIe5Rq/1p/rQLoZ7n
	npCtrI8WYyHLbMrO7qoaJhB6xpr6pFvhFBWN5+EhOdldVqzE8r0AXLrzPpDgwixb
	RzIF8DPDTs0p53PvGUp/NDNG7DQ2X0FRpfg==
X-ME-Sender: <xms:NeraZzgzTM4gM97FCNM_5yGyzPTtYxGGPrzjq8anTOIqzlDe-EXfCQ>
    <xme:NeraZwA7DFx0IO1ZuHMUrIIvwdFI16c7d4z25Pgx5sQfPKU0rmtEFd8h0vfuhPi7n
    Pg-hLY08Jzq2rTzJg>
X-ME-Received: <xmr:NeraZzF3l4kE4dTErZYzBPizI-WYy3AuW4-od3NF7QeY6i5HZSz6PlbLEqzbLFMUTU1t9OPssVprNfzqGp0Ke4ILNuCugZ5ed3LIsTNL7dzCw-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtg
    homh
X-ME-Proxy: <xmx:NeraZwQyo04QYC-UCmn971jkEgEChnh_1PkL3hfNBcNQZFRmUckOKg>
    <xmx:NeraZwyoX-oh3oeSlWc0KTTm-yurO8yvsP6kL29xtp-k44xaW7TK8g>
    <xmx:NeraZ27xq4_Y7N37HSJ8VOSbTQd7B5DRx-9gNu7UlhGknSPayTSv-w>
    <xmx:NeraZ1wxJA9HPd-WgQCvHVx-h3Mx3XDoJZhF2YQz1WO_1u2pzIdX6g>
    <xmx:NeraZ6sPkAnotPs0o3lvc8QIiOwVuSS-FgwZNPiDBlJSFKh99C8UIZFO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 12:00:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56522d68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 16:00:51 +0000 (UTC)
Date: Wed, 19 Mar 2025 17:00:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] http.c: allow custom TCP keepalive behavior via
 config
Message-ID: <Z9rqMxlt1F7lbGk7@pks.im>
References: <cover.1742336481.git.me@ttaylorr.com>
 <d84041580895a653648ee2370e21d7d2aa4fc4bb.1742336481.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84041580895a653648ee2370e21d7d2aa4fc4bb.1742336481.git.me@ttaylorr.com>

On Tue, Mar 18, 2025 at 06:21:41PM -0400, Taylor Blau wrote:
> curl supports a few options to control when and how often it should
> instruct the OS to send TCP keepalives, like KEEPIDLE, KEEPINTVL, and
> KEEPCNT. Until this point, there hasn't been a way for users to change
> what values are used for these options, forcing them to rely on curl's
> defaults.
> 
> But we do unconditionally enable TCP keepalives without giving users an
> ability to tweak any fine-grained parameters. Ordinarily this isn't a
> problem, particularly for users that have fast-enough connections,
> and/or are talking to a server that has generous or nonexistent
> thresholds for killing a connection it hasn't heard from in a while.
> 
> But it can present a problem when one or both of those assumptions fail.
> For instance, I can reliably get an in-progress clone to be killed from
> the remote end when cloning from some forges while using trickle to
> limit my clone's bandwidth.

Does this mean that our defaults are insufficient, as well? It's nice to
add a way to adapt those settings for the future, but ideally no user
should ever have to manually tweak them and Git should work out of the
box.

> diff --git a/http.c b/http.c
> index 526f9680f9..c13c7da530 100644
> --- a/http.c
> +++ b/http.c
> @@ -557,6 +561,19 @@ static int http_options(const char *var, const char *value,
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.keepaliveidle", var)) {
> +		curl_tcp_keepidle = (long)git_config_int(var, value, ctx->kvi);
> +		return 0;
> +	}
> +	if (!strcmp("http.keepaliveinterval", var)) {
> +		curl_tcp_keepintvl = (long)git_config_int(var, value, ctx->kvi);
> +		return 0;
> +	}
> +	if (!strcmp("http.keepalivecount", var)) {
> +		curl_tcp_keepcnt = (long)git_config_int(var, value, ctx->kvi);
> +		return 0;
> +	}
> +
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, ctx, data);
>  }

Are the casts really necessary? The compiler shouldn't complain when
promoting from `int` to `long`.

Patrick
