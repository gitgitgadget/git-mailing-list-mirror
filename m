Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC18B22301
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622798; cv=none; b=SdhmBAUP0GQtGJAQ3bCNTta3GARJmIJu51IEXYK64efEDs9a9L1OFfLx31kWKuWkX2ytaLYIBUA8TEvY2Hb3TkWz9HL2S4mTSayOQspOoMBgNpa+mU0pWl9UW1Caxp1XFVHEI8sGvLjCsH6Zpt/ELDiR4fxnEx3qrTzUwa9wPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622798; c=relaxed/simple;
	bh=UIlxQPTY6yINDkfcW1fClyDfxvZ1IOmg9NUWDZC/AOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho9RuJW2T7QnrnaIfgKOsItcR3SD8Q0mMTCezrujjIoshsUAPoe/ku+xYEsYDxJiLdraWCwsDgj58jAVIsb9cVEZ8ZvjJfbUftQvR74XUZ997G79CRaNG+wUTa7brBdhG9Bkdc0974BOlIdWq/fcw2Z+M4/BskjX4BS2ohzUK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AWHFjLrr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cgBN4TCq; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AWHFjLrr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cgBN4TCq"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4A6551D00066;
	Fri, 27 Mar 2026 10:46:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 27 Mar 2026 10:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774622795; x=1774709195; bh=TExpS/Ctal
	X5/3CL6Tb0JN2tDBdvcwCOwVAGS8/FAY8=; b=AWHFjLrrmTdESL9if/WzIS5ntY
	8Fs6G1CiAZ8AeX+uAOqTOrY0Qg/sj41nfPFmL4YohY73VPEU6KHO8bG2C5yOU3lc
	ocP+jh/vyJybp1lWbSOfkoALX/YPzUPzx9kH00a8RoE5dSiJVoUUj8Ghz0K2ULy0
	F+a/e48WHXSyld2TfQAgyahslnDzcVJATc5+L9KNgISDGWmGDBogYz8BqsLcpDXd
	arVgHuzuLBSd+pantjEo56o2O5gwNktZCr+Gwyp5LkkgY13DGULshl+yUkYfJd1j
	IMEjI9N0vwjKFQnCp2zL/BdWmd6aqER/HKrcZg4TrrP6G8BFWU/dvfjiggZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774622795; x=1774709195; bh=TExpS/CtalX5/3CL6Tb0JN2tDBdvcwCOwVA
	GS8/FAY8=; b=cgBN4TCqXrRUgH6p1HVXO4E3/OJbY+Ur2SMKTTJopPVYZ/DFQgp
	VxJLrtrIwxT4wTZbYmYE8TBvU+g9itfm/vIsE3fWo62rnf5YIdbcHkaa8Y/hWkvi
	X5iWvmcWP4ujoDDBS5exK1+tpHQJhRbmVkOP3Tz9W+3yxqj4eQMN5FSbF6VHYJHf
	G/BBwS/AuQhkEWX9k+d2EHSTgxOAgKo4sH07irUgjoSa6/TdIs1hFysVd/28ychp
	dhanGhCJwT+fxmx5khwxvJYwVpxYqV+JJCb0TcPQm2JT4qGcOzP+jmLk8xS7XmOa
	xNfuVAgyFcJhbtBHkSurkEX07JUsnXcSmWA==
X-ME-Sender: <xms:SpjGaTkp5OY5I0t-TGZWI4lPWNs5CSbGU3LBCwszbgD-hJ2TND0ySQ>
    <xme:SpjGaZajbu37qmMN4kCz-LcFJe9yZI8lWxi6T9UxEsJrwkTnKNVRZ7o_giw52qWSv
    cYvJ56Xn-H9eqdNGqbrzUaSvF5OUdDpn1BUqe9UCRjOX-By2-4E_A>
X-ME-Received: <xmr:SpjGadQ_eugicTYubLSK-smY6cnoXsdPOLuHIeAyGYRpvSuxgNuod93EoW_PFYSZqQCBxg_TAhT0p18NABWaIJSED6mYdu3a_e8MDvAuLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedtheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegvmhhilhihshhh
    rghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegrvhgrrhgrsges
    ghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:SpjGabtaYo7rYvYOqk7CxlKzjB8j8p3oyCKNwmqhj4_NnciOijzJEg>
    <xmx:SpjGaXHTSE0cCMoFFdGi7Bib0EqrLqgRqTOy1Hpha5C2W9VoMqGMCw>
    <xmx:SpjGaUxDx1GJ_AohdD_yHz_aTZeH4qCQ2PcjuMvuwVSh2kUbsGsOYQ>
    <xmx:SpjGaZ3rZJNJHhpqbrU3Z9hupMaJ41Cq89_dCjZPN8V6XJ8rZoHLpg>
    <xmx:S5jGae8WBOoJbktcMdBGEEEyotikqLFE5He_oXikh_puvtQJPFtuKjaT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 10:46:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d62ae6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Mar 2026 14:46:31 +0000 (UTC)
Date: Fri, 27 Mar 2026 15:46:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 07/12] hook: add -j/--jobs option to git hook run
Message-ID: <acaYQC8d97p2qzhw@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-1-adrian.ratiu@collabora.com>
 <20260326101819.1307742-8-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326101819.1307742-8-adrian.ratiu@collabora.com>

On Thu, Mar 26, 2026 at 12:18:14PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
> index 318c637bd8..46ea52db55 100644
> --- a/Documentation/git-hook.adoc
> +++ b/Documentation/git-hook.adoc
> @@ -147,6 +148,23 @@ OPTIONS
>  	mirroring the output style of `git config --show-scope`. Traditional
>  	hooks from the hookdir are unaffected.
>  
> +-j::
> +--jobs::
> +	Only valid for `run`.
> ++
> +Specify how many hooks to run simultaneously. If this flag is not specified,
> +the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If
> +neither is specified, defaults to 1 (serial execution).
> ++
> +When greater than 1, it overrides the per-hook `hook.<friendly-name>.parallel`
> +setting, allowing all hooks for the event to run concurrently, even if they
> +are not individually marked as parallel.
> ++
> +Some hooks always run sequentially regardless of this flag or the
> +`hook.jobs` config, because git knows they cannot safely run in parallel:
> +`applypatch-msg`, `pre-commit`, `prepare-commit-msg`, `commit-msg`,
> +`post-commit`, `post-checkout`, and `push-to-checkout`.
> +
>  WRAPPERS
>  --------
>  

Great, this is now where we explicitly call out that "-j" overrides the
configuration.

Patrick
