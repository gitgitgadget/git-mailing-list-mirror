Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776C347530
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527664; cv=none; b=d05HK3R2oR4QMPfR48QOBXF6Fdr4yliz1PRcwZU8+/m5yLW4u+6xD9vCX1s4trhRSxV+95P2X5zKRcijizUhGWVOBd7PID7pH2BkY5FGPJyU0FznSq9afIyGpu0QsMtyplRBvfJ40njXU3quxhDIrHJUPZF/IxXx7mgZYuQ5Plc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527664; c=relaxed/simple;
	bh=PhvTMSVtCOaWgWKts5DypqdnMYKuCnuoYIMiNMTHl34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOB3J7x1j6OTWPFejkLM5ECWbnDySnFqSeSA17EmYCD0DJEJthC9FF1J47UXFs1QblaOXN61rT1TjJi4OgOb/DmYUzMkwcCoaG394S+35EkHQEWEVB+1xCbLJ1taCCnw8G1Rk/yA+Gxwjl65tR7Etv06KNbmIYGnGkt9QotR/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hdcLg6eM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SoqwMJQ1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hdcLg6eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SoqwMJQ1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F3FE7A01D4;
	Thu, 26 Mar 2026 08:21:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Mar 2026 08:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774527662; x=1774614062; bh=wsYLD+gzGx
	vMZl+3/v21G8kdNT+s2Q5ZczL9QVeb5S0=; b=hdcLg6eMgoyZhyJGb/NtD9PE7H
	51enjmiC5ZSXpvqtrz7JPGVPH54nC11y1lU/JGlLVTouAbuNoVB9LLlJAV8HUyh6
	gQaUnqtdxzJNHv/W6EhkOYtifPLBXikWW0n300LH4VQGS+xoeUj3zNvuq2nJZa44
	gjQ4PC8Q5yxBu3mibHTSfOajyZumsjAGXwutHg10x0NGZ7uMT3Dk3QA710UCfxIx
	1dzVKSVhvQKABDWsxkDlqBb7Y8jkUCErwS0uR4ZT+4xZYjtG8XDFhnEvF8giMdUg
	l/sjZSrxmfQM4RinBApRxDLZ5bHE0Udj/us0Ghe6nidMe3M2S3RkRrIGrucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774527662; x=1774614062; bh=wsYLD+gzGxvMZl+3/v21G8kdNT+s2Q5ZczL
	9QVeb5S0=; b=SoqwMJQ1AiS0Oz/dqcG9Qda5kChoRJx3wFljJo5rlORYNnUhcL6
	s9d203anW277I4a7IqGghxG/7KMOC4fY5M5MljuYUNHkNgVrIsWpbGUChZSuo5MD
	H67nJqasOPbeYPY2EHXHS5LVJDf0ZrzRX//tYks9uEOlXjCMlaZe73iw5N1xcHuj
	MmlRH6Oyq+fpT7fQzCA2uqBit+oTpE1cnbwA8csLGPAGRHROkoARvjlimalwFI6m
	+xgDptQUKcYrq5Ccdf4E4Ru3vWXVJ9R5kW8Kb42j4i2rdHLcoSd0WHcwJj4aEkTo
	o35vgreFGbtNyz5n0HFry/i+zvboeNELjOA==
X-ME-Sender: <xms:rSTFaWmUSc4YoE3GFNYDIq7VesiOR_MZ7cThlbFiMQkMJRnZBcyg1g>
    <xme:rSTFaQGLRM7h_lVNIoSDtC-E5Gx5IFib01ysY3IVFBpWSabpeOKFh2dtoTaDf3QOn
    NDC4drZMAW6jisuXVUuRawVWgfd9gUAPpvFRO4lTUc5R4vUw6p00aY>
X-ME-Received: <xmr:rSTFaW7xQVYjISNflpWkzez7vo4FUcdUHmUjdelgugPJwm7-V7fSpqfYEsKTbckteeUMpqEeICGO6L-J-gsw0ArR65nIN0XVCpmA7lIcsR7o3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdejfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhih
    rdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:rSTFaQkOFH3_Re8lt8uTBkYJFBzPhsP5xzpf0-cUqHLON8NtZtg4uQ>
    <xmx:rSTFaTrkJkwd9KerRR7RSs4nILb2qOyqVlumAoLdSi3XNth4f3yngw>
    <xmx:rSTFaXuoYGHXmVWoR5Wuc4hx_Z8U-hDvCsbfn1gktalibR9qFI1gIA>
    <xmx:rSTFaQGaxLyu2boWiDUkNSu9pzn3-PSW2a1ZhpI54ADoTUYva89CsA>
    <xmx:riTFaUpn3jdDFiT_TbX8VeYUkbqPJZyzzhvv6g3YQmyhxY1Himrp6kLc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Mar 2026 08:21:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 96d94708 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Mar 2026 12:21:00 +0000 (UTC)
Date: Thu, 26 Mar 2026 13:20:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 04/16] promisor-remote: clarify that a remote is ignored
Message-ID: <acUkqRUSyRUysf-I@pks.im>
References: <20260323080520.887550-1-christian.couder@gmail.com>
 <20260323080520.887550-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323080520.887550-5-christian.couder@gmail.com>

On Mon, Mar 23, 2026 at 09:05:07AM +0100, Christian Couder wrote:
> In should_accept_remote() when a remote is ignored, we might tell users
> why it is ignored in a warning, but we don't tell them that the remote
> is actually ignored.
> 
> Let's clarify that, so users have a better idea of what's actually
> happening.

Interesting that this doesn't result in any test changes. Don't we have
test coverage for `should_accept_remote()`?

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 3f8aeee787..f5c4d41155 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -660,15 +660,16 @@ static int should_accept_remote(enum accept_promisor accept,
>  		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
>  
>  	if (!remote_url || !*remote_url) {
> -		warning(_("no or empty URL advertised for remote '%s'"), remote_name);
> +		warning(_("no or empty URL advertised for remote '%s', "
> +			  "ignoring this remote"), remote_name);
>  		return 0;
>  	}
>  
>  	if (!strcmp(p->url, remote_url))
>  		return all_fields_match(advertised, config_info, 0);
>  
> -	warning(_("known remote named '%s' but with URL '%s' instead of '%s'"),
> -		remote_name, p->url, remote_url);
> +	warning(_("known remote named '%s' but with URL '%s' instead of '%s', "
> +		  "ignoring this remote"), remote_name, p->url, remote_url);
>  
>  	return 0;
>  }

The change itself seems sensible to me.

Patrick
