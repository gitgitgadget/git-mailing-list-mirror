Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1F247284
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760099348; cv=none; b=dRycxAr1qL2UJ3cl10G/qzpKQxKrOee1hkGIhsD6xuEb4Ow1Lq8Ty508tTv3Flzxx+pRxqECw/d5ONro9k62UoYMIYstP0umtkjqjeqDLtUecUepxaV8Zj+hWWIXAi1N5I3t414D5RWLOZ6UHuaK9JjKoM7TIW31AgvD+FqWvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760099348; c=relaxed/simple;
	bh=DQziKhQqyAwS+mtD+OElx9nY3vilUUsuInJ5GakAZ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z9cdQIs/lb/9YmFHorIGCzzVAZY9pVkOvyIG57SbLX70a0zI2SJiO1VkJm7u0vY4iBlU4k8acCJcNfb6Zj0+hbh/rE+fBBOXryfYDs56+17t9QZm98lxskSWGYUKHUe/QnjfyanBQUQAXdV8QlHnkS9vXU/XPMqbrJI6KKDlSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UDSMiQlB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgB4LUA4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UDSMiQlB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgB4LUA4"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F893EC025D;
	Fri, 10 Oct 2025 08:29:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 10 Oct 2025 08:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1760099343; x=1760185743; bh=ph9b3BH2e1
	tZcpGaAjgooq8GEPdUJ3Ls1qTFW7hwMLE=; b=UDSMiQlByMWyaT6ePvRtG+bjkX
	OhTgFTHGDwFMQyY61YA2928Rlx8Sa45zmtYjtYMjH18xfzIOUV3HrP6bqxZEObhY
	RalkYy43K0iZv2U7k55WMiLOeE9cy7aBM0UhcuQ6bPIu2rFiE9sZ5xFmKF/P2GVU
	qcrT6XBm5GI36xSoq3onYY3ntYvyBgZfipuNzuAmQxtoh/5pWcH6zOFrvfLSWnnH
	tNIvAxxjP5P3qEsaT8GsPtha7rpILGNG3Ab+tvvLMGpccUnZNgP7pnbBUGMu6vAx
	qCgMP5l2tlQbfm6e/+gg+5aw1FVZ4Dwj4JDLTqXRn5z+11tAsqgu7oC4uQ9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760099343; x=1760185743; bh=ph9b3BH2e1tZcpGaAjgooq8GEPdUJ3Ls1qT
	FW7hwMLE=; b=XgB4LUA4VKbaHgE084SYiVX7ZlT6HeXrQ0Ia8/EErnKjDfiyP5h
	CIAfucpTMCUOB5AysCsvroDYfSsvoHa/SDpvyCb8aUe1Bn+3PvTheu9RZ6TN33rZ
	jyCsWelSL42vQskfONZOD/oOjvc9L+nNsu4qD27fW/zbqukT5ZYPEZP+txT/kD6x
	IdD8UOTMtrpmJKRydyxdDthMaJ+GjzVGA8rsimFMiJyjWBwJZIVusIYauiPoDB0y
	NEt8d1DktFWcRnBW1nuLKyTXZdsWScBv5TfUQxO7BaHfAi1mwfOwQUf39h0wOPcJ
	MvbnlzV9eIwdDkFnZPVejFK2ie5vfci7JmQ==
X-ME-Sender: <xms:DvzoaJSsY0-RY7nyymR3rnLw4vRJxi2GXrXD9vLzwomePAZWaDmIeg>
    <xme:DvzoaGe0XsKFat-3NmP0zEkKgtLeTUjqBZX2TRoqhZBK7EoAKeDjLQp_0VHT80Cm5
    AhEBq6c01GTSCxKASEjlLb5qLfum4Bce3TOYE3xJUY8AnJAfz86kQ>
X-ME-Received: <xmr:DvzoaIq0HsKRuqgeexqXczjXE0sYMxtSoUEQ7aPlTiYUqyeqEP7IfrfFqbXuKW10fhs9_hgpQAUxJHiuZtl1N4zMlnsvKHyy5X2M9VmAHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdeltdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D_zoaH9KbDz74qkVkPv8Hp7IWCmGJKnTRzr4dHt0BNtCDhxLfuTepA>
    <xmx:D_zoaEehkzrIT5xQq9KTWV1V5mXcQ_OgSXDZdJlIjAmjoBn-HSHL3g>
    <xmx:D_zoaBKUZWKVJ7O3TMjswxfwE2Tia6xXs5Fy6LDDb16Gnr-XeJUypw>
    <xmx:D_zoaEiu6FIk8l5fB7AUkPQa7FeHfXMIvFpVJTE4BELjmlwJU4kY0g>
    <xmx:D_zoaCup2-l7LVW8B8fcCb2f4U0nCg7r9JHQ6CI0TkyK8JD_wsVMvG0S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 08:29:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 678e49a9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 12:29:01 +0000 (UTC)
Date: Fri, 10 Oct 2025 14:28:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 43/49] repack: extract `write_pack_opts_is_local()`
Message-ID: <aOj8CUgapqZEhnlK@pks.im>
References: <cover.1759097191.git.me@ttaylorr.com>
 <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fbe3d0d7f37840b2d9faf6f62e94abd6a664ded.1759097191.git.me@ttaylorr.com>

On Sun, Sep 28, 2025 at 06:10:08PM -0400, Taylor Blau wrote:
> diff --git a/repack.c b/repack.c
> index c4326a532d..7af297ae48 100644
> --- a/repack.c
> +++ b/repack.c
> @@ -77,6 +77,12 @@ const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts)
>  	return pack_prefix;
>  }
>  
> +int write_pack_opts_is_local(struct write_pack_opts *opts)
> +{
> +	const char *scratch;
> +	return skip_prefix(opts->destination, opts->packdir, &scratch);
> +}
> +
>  #define DELETE_PACK 1
>  #define RETAIN_PACK 2
>  

Now that we accept booleans in our codebase, should this function return
a `bool` instead?

> diff --git a/repack.h b/repack.h
> index 46d2312fa9..16f2de2ea9 100644
> --- a/repack.h
> +++ b/repack.h
> @@ -40,6 +40,7 @@ struct write_pack_opts {
>  };
>  
>  const char *write_pack_opts_pack_prefix(struct write_pack_opts *opts);
> +int write_pack_opts_is_local(struct write_pack_opts *opts);

It would be good if all of these these new library functions could come
with some documentation what they actually do.

Patrick
