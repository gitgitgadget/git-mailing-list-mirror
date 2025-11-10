Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816323D7C8
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760070; cv=none; b=El2xK+BFFGxOmlyuI9DPysUooKR9NFjNvRvlBkzXDNWwLz8/mnhg+EJia1JnRqmviJIWBCVoZZpOPc6tN+e8dg3SKJr6GuK50LbM88kT2A5V93PtVVNE04Wl8PRoGuBrvD4L1do4e/z6/Ayo9o+Qe6mLScdnmcg9o7NjxplQlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760070; c=relaxed/simple;
	bh=ztsMLTzEeF1xTic+hSVfOryV8AlbMXjG/C+pe0PCYK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgkTlUGylNdKWfQYg6cgcezwIHxWKA23Mh3vewtvqHYNoUTHAd5IVN2nbd5xJ4OeWJr+tRN0YfkONDNR+yfraXW3XQvfnkzszhQxmkwQMXWOeNeqF53Fu/D6+6d5cTW2wlNPjg81hyjbm74CZdlLAFbEgPCwTUlBTzgnW/hlZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JO6AXUi6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9ZpsylK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JO6AXUi6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9ZpsylK"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06CB87A00E2;
	Mon, 10 Nov 2025 02:34:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 10 Nov 2025 02:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1762760066; x=1762846466; bh=avZqx9M1iA
	Fj8Li3i/hbjefYW9/NZ6CA5fzfpzD1Hlg=; b=JO6AXUi6H3nOEHR6+aHy1hU2v3
	upFcv16foko22yWve2iKLQGVP9qnlm/zF2GpQ8EZARqYgsgUuukwv5L8yqjVfM7o
	y9ArfkcKrCaL8qnPP9WEYfHdi7rQySjzAPbmI1ksl1rCtMlXP4ZW+uVMaebEWqqd
	1CmiX2qts/m4KFWGjNFHl0aqtWoZN9DPywG7Ys4Nfl4eDQpb4uG0+TQ/c0MXgyF7
	2ufUseW63o7e0jq3OfHO9ki9vdEQLCK8YOGxAWA6wM5UjqFmr7jiCb/krzc0Jmxb
	3g7IpGUrfCbDjooJou1jML/AdfiC5paJYKs+H4aYPFRDnKzKh+AiOe7oJdxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762760066; x=1762846466; bh=avZqx9M1iAFj8Li3i/hbjefYW9/NZ6CA5fz
	fpzD1Hlg=; b=T9ZpsylKnJstvKruObp7v56kn73kl+/V5OdXdvqIsJdfWuceW07
	eZCo8b6Spv68H4NOnlwCYd41kaVsRjA9o+VFAq1a+RubGsShTNA7kwNijdr9adLM
	R0ji/PMLHJRo+GYclQPKAMLb9aMzxcAwTontTF/LeEJf2YIb8jDdqXe6gMYgHmdL
	HQYGhdxpGPw67nX4tMXBlLoG0c4QhEzQw+jvUOwmmgotHjgyTfcAk3ilkzyCfCQy
	QWlI58rOEGQI3icgnWfKTuxog+rlJ+/N3xcwAZPf0zeykL1uX/k3FPv6lo5xb/tA
	0xKuXc874s0NWFHYJIBfCVIYUlvmOudmE1A==
X-ME-Sender: <xms:gpURabNwBU0bsB7U1woltOJJmYzzgfCTqMOCusLLSDoXuh9XpgEjoQ>
    <xme:gpURaeYoWRZBxMQ2Ky6J4bIRJvtXXFBCCmAwqQKTBIC5qgIC2WN4Qsg8RaIZkOXpG
    9hbJwQR51OAZajM68jXuOg2YFbnNPqaUQ3XvTiHfVZEcxRzAe5C7S4>
X-ME-Received: <xmr:gpURaat9qqqyWJqChSGouSN_ggGESqCETLLvKHW4_XNQiAxKuF5ar8K0KlOepCbuoIkRGHKxbG5MmtIaFNkdkViMQ2ZNQDYI8tqKh1bqhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    uggvsghohhhmrghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gpURaQPzmGFVuDqLZMZX_enLOcPCaWTay0uif8uqD87XCtjXGo-snw>
    <xmx:gpURaR5JaCgn_PrA1_tRXnA5N-CzlPTUx6QfOWFfY6FnfhsiMl_RbQ>
    <xmx:gpURaWSMyF_i1VCR92o28odJDPSs2RWSnZm5EGDUkzh3jz9wZt7ZNA>
    <xmx:gpURaeCigxlS6NTUlGxK_MZTWMCWoeA7U5UjVEfqW787vDC5DJ73eQ>
    <xmx:gpURaTs2lu3_KvPGrQ5CPDxCmjtIb61wO9dbbALpd-avROQ4MGN_KLzv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 02:34:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f6210fd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 10 Nov 2025 07:34:23 +0000 (UTC)
Date: Mon, 10 Nov 2025 08:34:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com,
	gitster@pobox.com, David Bohman <debohman@gmail.com>
Subject: Re: [PATCH v3 2/2] fetch: fix non-conflicting tags not being
 committed
Message-ID: <aRGVd7L2DV4DNM-h@pks.im>
References: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
 <20251108-fix-tags-not-fetching-v3-2-a12ab6c4daef@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108-fix-tags-not-fetching-v3-2-a12ab6c4daef@gmail.com>

On Sat, Nov 08, 2025 at 10:34:44PM +0100, Karthik Nayak wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 49e195199e..337ca2b0af 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1963,6 +1963,14 @@ static int do_fetch(struct transport *transport,
>  	}
>  
>  cleanup:
> +	/*
> +	 * When using batched updates, we want to commit the non-rejected
> +	 * updates and also handle the rejections.
> +	 */
> +	if (retcode > 0 && !atomic_fetch && transaction)
> +		commit_ref_transaction(&transaction, false,
> +				       transport->remote->name, &err);

I think this needs some explanation why this condition is safe. There's
quite a bunch of function calls and conditions that assign to it:

  - `truncate_fetch_head()` only ever assigns negative. This will be
    ignored as expected.

  - `open_fetch_head()` behaves likewise.

  - `prune_refs()` returns negative, but we then turn the return code
    into `1`. So we'd end up calling `commit_ref_transaction()` in this
    case, but we didn't in the previous iteration of this patch series.
    Was this intentional?

  - `fetch_and_consume_refs()` is one of the intended cases, and it sets
    up a positive retcode indeed.

  - `backfill_tags()` behaves likewise, and was intended.

So this looks good to me, with the only questionable one being
`prune_refs()`.

Patrick
