Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302D313E21
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706766; cv=none; b=WTJbW4ucMi4meWuOVrz7xbDAY7qjNG0hlwNlq4ge8tQ61Q0YfrqpUhKeN4peWXxHisVqtclcTQmVOtIakVDmIZtpxiWS8M19hy7ZG7exBHlbOrUn3n4uo9zzGKGaYom0Hu+alHk88A2UYTRQ+lHjYJONam0Q1T3tnwpEcp/N2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706766; c=relaxed/simple;
	bh=zFVgk6M3Jh5ltxggVNrIQdl0jNVjnMkvKKXy+VcStbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBThPxQUw+sOTP6Ph9ROk9gYUr+HdnXcRORqXfKnI0YCHAtNdEm11oHHuy0867kjL/plgCtIiHrT4uq9JlCdqcW22h2FISDVUy/LBQdlRBXGhd8v784L9eDonpKtblY+bDfWDxljQ2T7aI+OHzzKcX+aLdmqip4AOYyA4MqFGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L8DCu8k2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYdiW6qp; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L8DCu8k2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYdiW6qp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8440C7A01D3;
	Fri, 21 Nov 2025 01:32:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Nov 2025 01:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1763706763; x=1763793163; bh=6uFj9z/J0F
	1vEM5Pa18+kvaJUdFtIv75sRPmtqwcpfg=; b=L8DCu8k2ssaplusNwgcgX+SIX0
	DW2iZy7kcQl+Gt5e6w6SGj1bJbfmKnkccqpE3hgsQx5wDuzrfNEOlPTvA+IiCQKg
	Ri9ltff8c7l9OZ8tdhyKiIq2hu6CSH0XyiaAM72BnMhb7081xb6A/smP3qhpYg15
	kaY3RqmXmSM2WxfX9bk8eu2nUhMyAlYW23sw8ySbBf7leA2AfsX7c+hYLdTQZvJP
	RwQDBQMl3DFr4Pr/2GoIkE1X9P0vUyx0GMroWvCEa027/TiGZ2TooE8O3Eps2RH/
	XjxAJsqxWZK1oKfAywAuDIdI2w/cEFEkowzl7flIE7SbmNX2EJibHVAFeeUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763706763; x=1763793163; bh=6uFj9z/J0F1vEM5Pa18+kvaJUdFtIv75sRP
	mtqwcpfg=; b=WYdiW6qpD4ZiZNpfh2bvN37FHOqIfdEVuGjU1uvIqILRbfna4An
	Zqm6flCc+h+jV/6l2VCtVV9A0lLMUhzDHnC30HSpVNBJ4ZyBF15dCr/qgThXDaOx
	khnvg52Nj8sdJq7r823vkObApfhoMzC2yUa/jEgZszUxPollYisvvfGZWl6aYzL8
	s/W77xOimnrTEjSt5eOFon2DEiCQEAOF1ZPanauQLw91nVwjzQV1l5ynZkAu0hF2
	weaGTZPhAJPoieRnL2ZSnlC+c7dTiF7IT8Yo34BICRdrWQDpdJzlKk/oqXRH78GH
	ouC8ltl6rX01PGufiO0tb01sZ8dOMhcKX4w==
X-ME-Sender: <xms:iwcgaQsKSG3S26kaxloP9pU18ZXaqDDoezyNDsqqGyzi89E3LdRIaQ>
    <xme:iwcgaTfIaeV4zadU8SKudI7Gmje5iQMfPh-ex8QJFHtctCS43dWu2QbLAs4ff6k7A
    ObEbAi4AgPjAiSaufEkpGzn_FJWzBMMBir8kx13_9M8t5SeWsrWXA>
X-ME-Received: <xmr:iwcgaZaf6DCBrE5eUhHop9VoWVEh7wHtFyeySrMNhYqsrTDua0gt2nI1lWtpUC2CYfctPehPku6xOTia61e3fyabBYLJi7rSAL_vRACa6TbP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iwcgaeX_jiz78t8ZM9qHPfM8NGa0KpaNG7cNzQwLpmC1GWYB41pJOg>
    <xmx:iwcgaTgwrdmZu6yRl_u_Dz7qCVPfjg43romnxLWIMgpAzBgvMi4nnA>
    <xmx:iwcgaUXDR-l-g5LIZ1QcFC4O6qblISQpX6Q9dGHrdxd2NhULgS-_jA>
    <xmx:iwcgaSPVLoJnGK25kJnKjXeAUXr8I2QRFyE2CV9EAyKnRA5sCph8AQ>
    <xmx:iwcgabdtK6aBWFpEp6Hv0HoRtKGM_Q2vdG2Ys_uPUA1FxwtxOEukBK9U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 01:32:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba027772 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 06:32:41 +0000 (UTC)
Date: Fri, 21 Nov 2025 07:32:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/18] streaming: propagate final object type via the
 stream
Message-ID: <aSAHhUGzG-c2o98d@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
 <20251119-b4-pks-odb-read-stream-v1-3-adacf03c2ccf@pks.im>
 <cuvoz5gl7d6xgj757jgb26kj3qeunc4w3pg72it53zi6rs5lka@2nc5x4b2e3eg>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cuvoz5gl7d6xgj757jgb26kj3qeunc4w3pg72it53zi6rs5lka@2nc5x4b2e3eg>

On Wed, Nov 19, 2025 at 01:25:29PM -0600, Justin Tobler wrote:
> On 25/11/19 08:47AM, Patrick Steinhardt wrote:
> > diff --git a/streaming.c b/streaming.c
> > index 5ce6350123..9596a94c58 100644
> > --- a/streaming.c
> > +++ b/streaming.c
> > @@ -496,6 +495,7 @@ struct odb_read_stream *open_istream(struct repository *r,
> >  	}
> >  
> >  	*size = st->size;
> > +	*type = st->type;
> 
> So even though `open_istream()` returns `odb_read_stream` which contains
> the object type, this function still accepts an object type pointer. At
> first I thought this was a bit strange, but `odb_read_stream` is an
> opaque structure so this make sense and is also what we do for object
> size.

Yeah. I was a bit torn here to be honest, but ultimately decided against
dropping the type pointer. At the end of this series we _can_ do this in
theory as the `struct odb_read_stream` becomes public.

I'll add another patch to do this conversion at the end of this series.

Patrick
