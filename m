Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC52F0C71
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771319127; cv=none; b=tQ2lf3n07ic4c1JxXtWo23WTEvjqi4vFtfCEAKiys1lOnK2i6yi8ZMu3Nji24jfKOxbXS2ZVIEiiQHtB/s+isQLUqJ/0N7m46DtUHhk+flhInme1HyEBPn67jRguwn5iB3QPd1sy2u4T/qMUJjIQfmfgnx1Vz47D1U5VMl4zpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771319127; c=relaxed/simple;
	bh=5dMoDKXslr8sLE4WV90pxhtbVaniSeNbbqUBnTAq+uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlDLD6qldSb7HC12o0Fdlqkj6ZODqJ5ZrFrsFAxgxO1axenJ1W3oWxXGqZrn1KWC3D10JH9zFr3YLjvHS5tqmk2IOnKbK8iGaG1b+bfgApK1eJak91BkRxxzz80PBzEnXUz085CHhZP2Jmr+FKPG/XFVYbZbczrzh58hu5U0Whc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gq6cFbGy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s04u9Qk+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gq6cFbGy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s04u9Qk+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 123A07A053D;
	Tue, 17 Feb 2026 04:05:26 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Feb 2026 04:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771319125; x=1771405525; bh=NH/JWzmmw/
	4cI2U3FPlp3df4aHztIDk30s89kj5L0Lw=; b=Gq6cFbGyUd6FGi3cI61/6H4x2A
	Fz/oN3s3EBwKqp03Eq6rX5UvJqbwEO+8/JIT1LyO7ghLICu/BYr8HkAARQfcBh+2
	gr7wMW3POWBcmvytPWlMC90m3FaG6vKhmUXEHYuVPxNVge9HlCu/qd4dE/EIT0DP
	QrMIYYFxxlXqtNfshgsAXXjXtAE1FXCqm/e9Fj7G/N6fgtD72xuyHljzy9znxLSk
	O31Z0Nq+0HpjLdG+pmwWHDX5n3bccMskVnpjToNkognY+0ch3J0K/OzEFef9Uq0W
	Vzk244/6tijskhCsE67gUUDHpWpQ28j9oMkgS2y94/d84TgeRQlvjR0VW6Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771319125; x=1771405525; bh=NH/JWzmmw/4cI2U3FPlp3df4aHztIDk30s8
	9kj5L0Lw=; b=s04u9Qk+MKRZRs9TJHFc6YUGB2JXsx0mLgcE8YL77pi3tP3PaS+
	1OBV2XnZgZCz1U7ZT9GMBzJ9svuasX+FyINRA0KsHjaNhI6u10HlVCzdlvHqCyA+
	04ijYXVm3YU2reUtOlZ3P0cPbyMTPYpkZDNF2OKP1vQOBm9bHCE4RwFry+X6o2VX
	6AtNT7fsh0OPiYBFgBxnplBjVC9YnlTvQE04dLf/0hy+nWZu2RSUBX+rG+V6yH1j
	px4Rl3BFwvCYVOF9AKIdgDVKXsha+noHD1OMpILP6c5oyUD8wQDDDbsijksWcqiV
	sgd3PAobc6vVSFGP3+7mahqbcKGkaP5JZSA==
X-ME-Sender: <xms:VS-UaTanR9MeEX7k0CqVocA9n8jXuUlKDgjdAAhXLu1ou-V8I-A3WA>
    <xme:VS-UaRex7d1tY6r7HIAPjkHVTJ_96ikEkcmzgjbUK2QIqtNFUaAfz5TCzrqknXOc_
    65QA86plMcjZ431hFAVu6AqN4kxpLv7COJiQQdjJ3Hb52MmRqcYWg>
X-ME-Received: <xmr:VS-UacLOD9J5b_0cGS9XqL7d3t7N1U-km-bXc7KokMs65K6pidxrFJX58ESqEIPYi4qtMONGJqL0bDPyzayHXPvTsGPvFhQ63LguqFM7tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:VS-UaWJyPvBhR8H0dgZik7DLipcZRtGhH0uBuMXwF9QSRF80mDxMEw>
    <xmx:VS-UaTVO8fukDk__mC8qeT9WVyj8b3r54SiKCkaAFxH0vuLOSKoHow>
    <xmx:VS-UaXnolQHEKJyIvamL3hDwz3--Q5Vmn_v3Ze_VK0_CyTcGMvQ8QQ>
    <xmx:VS-UaRkCAByuEodVzLcAW4PHOD9AZ7CQBJqTK-EzjJwVqDf3zCbS6A>
    <xmx:VS-UaXQ3OfF3yZU9TXOnr5TxseD9unDtcNf36uE7FrZAwKvpnKT01N7p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 04:05:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 72e7c6f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 09:05:23 +0000 (UTC)
Date: Tue, 17 Feb 2026 10:05:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 11/13] color: add color_parse_gently()
Message-ID: <aZQvT_fTlUIJd1DM@pks.im>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <ddf6131ac9283bfbf4ec9ec000606765d887e6ec.1771026918.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddf6131ac9283bfbf4ec9ec000606765d887e6ec.1771026918.git.gitgitgadget@gmail.com>

On Fri, Feb 13, 2026 at 11:55:16PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/color.c b/color.c
> index 07ac8c9d40..ec8872d2dd 100644
> --- a/color.c
> +++ b/color.c
> @@ -264,7 +259,8 @@ static int color_empty(const struct color *c)
>  	return c->type <= COLOR_NORMAL;
>  }
>  
> -int color_parse_mem(const char *value, int value_len, char *dst)
> +static int color_parse_mem_1(const char *value, int value_len,
> +			     char *dst, int gently)
>  {
>  	const char *ptr = value;
>  	int len = value_len;
> @@ -365,10 +361,25 @@ int color_parse_mem(const char *value, int value_len, char *dst)
>  	OUT(0);
>  	return 0;
>  bad:
> -	return error(_("invalid color value: %.*s"), value_len, value);
> +	return gently ? -1 : error(_("invalid color value: %.*s"), value_len, value);
>  #undef OUT
>  }

As far as I can see this isn't really about whether or not the function
should be gentle. It's rather whether or not the function should print
an error message when it sees an error.

So should we rename the parameter to `quiet`?

>  
> +int color_parse_mem(const char *value, int value_len, char *dst)
> +{
> +	return color_parse_mem_1(value, value_len, dst, 0);
> +}
> +
> +int color_parse(const char *value, char *dst)
> +{
> +	return color_parse_mem(value, strlen(value), dst);
> +}
> +
> +int color_parse_gently(const char *value, char *dst)
> +{
> +	return color_parse_mem_1(value, strlen(value), dst, 1);
> +}

And if so, this should probably be called `color_parse_quiet()`.

Patrick
