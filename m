Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A061302161
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585174; cv=none; b=KHDlzlKmZ/EtVc0dydoFkWQRtP2EIZYpDrAOI360kuaHFGNPCaA2/CZfszVip3YVOAkO+6iSQ2N+sGUFvLdFOMmpaEMlH5J2SAR1+/uNXAPycRf6cSlrBpETchkVQJYrVZBlxaOd1L0DYlXOdqPPXZJllZ0UMoN0DMt/uHsG/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585174; c=relaxed/simple;
	bh=pqQOR867UsKrvHoNozDVS0+2tC6ev5Jqr6Wy6De443s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQvrdxBuxwk1euGoiXBOiaUBgt40Of3MT3PScFIl4oVV4zW9/bpBqZL2VHh4vEJ8mW+5PNE+3MnHpLgqJGkursWI/AETn65AmcOn+fyk24gzfbBY43Qni3EiFPjEYZvvzhFd1grpMY5I5B1fqDctmZsGqCBGdOcjKRIjFnEp7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vzeYkpG8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TeIYLR93; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vzeYkpG8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TeIYLR93"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACED91400013;
	Mon,  1 Dec 2025 05:32:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 01 Dec 2025 05:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764585171; x=1764671571; bh=pqQOR867Us
	KrvHoNozDVS0+2tC6ev5Jqr6Wy6De443s=; b=vzeYkpG8a7tQPqIgyIrWiIBMSL
	GqdQXO/7RWMwl6HaMENHgmWxTlQ/pZgxhsCwhJChPntz8fxasV/KO2dfyB8grQnW
	2I+mIFoDCtR12S5vCeeoD2fQ7t5I6DFR4Sx86JNibLLHXkb5H+M48aKKZ+98OqTj
	8jDJiyQdM2iLZqkArZfXDGsJ04/effFgyjFnbPitW4vrrD07xbwS/VqFcdX7H9x+
	HRJPdu8SFdsZ2/E9+XUb8yW2ew8yCjGMbfKe/byOtXOjC7k/LbyxFl6JRkYd7Gkf
	zs998LOJAUZNXJvgV5sGYymclMlavlSQSxgBtauc/c4fSvZlTnt2WpsFpsXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764585171; x=1764671571; bh=pqQOR867UsKrvHoNozDVS0+2tC6ev5Jqr6W
	y6De443s=; b=TeIYLR93DX0fSgKcR4FpDDoOP/snWDpIntgmf8HBD2PkoYMKKnd
	zaY/roH8Zc0qMm1bLSHreYZ7aFXgQvnwcZ6FXGSPAZgXfOoaS2Mc2cBYhRcKLAkY
	vU3iO3e6MylnGIEbpuYX6AY3KqaOp75+O12Bvi5eRtkQwEacIkrNTphy4upg+NkJ
	AyG6R0AnYMJ+EUeHMkkoDYfStf/eklYOHdoYFjpjyAP6s9ahnmW+WXpAVe5u6F/5
	MWAJLWt3h4Zs9bxfGhvO+JQF1pk0IcnNLgd7sV6WlDxXkY4swsZqRJAJ6wFZmnmN
	e0iJL1xJMVV3wjLTSu3l6qX8K/GRLg9zfpw==
X-ME-Sender: <xms:024taSwYYbaVC_BaPD9T7AZRVl3r3Gth2q5wqXN_6IKIOkAENH66mw>
    <xme:024taURyMixadRdY2p6bm4RvRIZ9_asUec8nr1hChkAAJ0jAubneysKTDDd2a6kKP
    hzQ52Zt2vciuHswOrpCtiTdjjTnJcMIBH2xFQWKN4X36yqPiL4>
X-ME-Received: <xmr:024taR-1HKeX9nPKWybrj7voV7HRkXG0r7KV3V6MbgTpnY38l16r6IXlHdzY5B9_xDIfy1x4iYWIvhT6TKgJ8j2v2UxrpQPXvr_QFw2r>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:024taTpBYfR8ADL0I5-Rm0zaRxQzBR0EaJ3hW5PBdxsoYDGw_769tg>
    <xmx:024taWlfQcVWAD0CFhqqwvZ_ZJIiHgo_b_kVkEwRhmZJyqupEkitkA>
    <xmx:024taSLh8Vg6JNBw_nr8PdS6TOoLq03nZRqBTV6c1UjJbWTUkOESkw>
    <xmx:024taTwaLhJWwxlnuDmPWV01IE0ULqBrQ0hdNveL0PcjMZehu_I-YA>
    <xmx:024taWKs4Tsh4jPGPuB6gKwlHq5J4hRp0A42U9U928ZYVkNCGPeRAiv5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Dec 2025 05:32:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4888f57b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Dec 2025 10:32:50 +0000 (UTC)
Date: Mon, 1 Dec 2025 11:32:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] last-modified: better document how depth in handled
Message-ID: <aS1uz6mc0WW9kjzN@pks.im>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126-toon-last-modified-zzzz-v1-3-608350df0caa@iotcl.com>

On Wed, Nov 26, 2025 at 07:09:45AM +0100, Toon Claes wrote:
> By default git-last-modified(1) only shows information about paths at
> the root level. This can be confusing. Clarify the command's behavior in
> the documentation.

Hm, that's confusing indeed. Is it possible for git-last-modified(1) to
do the "right thing" automatically? That is, given "sub/file", show when
that specific file has been last modified? Or is there a good
(non-technical) reason it behaves the way it does?

Patrick
