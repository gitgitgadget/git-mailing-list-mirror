Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC3238C1B
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738584; cv=none; b=FjW9xouZFBTLzd5sGI+MeuDopc3zrVP/DZ91CE3fErV3R2R1qzpaKk2kx1Q9hIg6BpgWu9aYOkIkyuWaGd6G/kLahDA/33Bh4LxfkzkLpDtxsWp/G8utsc8Sx18PNIzyoMnIWXbEe+eXwqBclx+OYUdugeSJUQDv5mLgfm1U/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738584; c=relaxed/simple;
	bh=52T18nlfH4v8cHQI4X3wkA8BcEuHS1wwW1KzFSasmKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GMBc4uCBkjGVKiDLogWrblXyyHUoCbf2ns58C8J6MAGlnRMjbIp8vlSpXkIbc3Wbk8w70uJCcqp+ETNVAdy6E8VXvomVo87VooO2LP/boLpuBF73nGAaTw9fLm/WlhhCi6UwyRcvZVFR94apUU6mHQsACqruEeNBDmAxs82L98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pe7YRJd9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDkUyCWH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pe7YRJd9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDkUyCWH"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB42A14001D3;
	Thu,  5 Mar 2026 14:23:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Thu, 05 Mar 2026 14:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772738582; x=1772824982; bh=52T18nlfH4
	v8cHQI4X3wkA8BcEuHS1wwW1KzFSasmKc=; b=Pe7YRJd9xFO9pzuah27NkzhtrS
	dl1wktXx652hhFYl11ZwpDjW1B+QOnxCqHzL/ZP8IkUQHfmqHryWouQiMA5YMre0
	+dPI2RCf2puo1KtlrBpN0t+mdN35CLZlGsWS6zUeS7XxQUwyyX8p+7fNluqD0a6T
	1c/BUkzTCkq/nvvWhZxxO/H9ZSEZ0H2Zo9zngl8oxXx1tcHcIZ12TLw1idBVdh4O
	j3TB3jDvsC9VDrS3RIKM2Xm4LRY18NIGhkrEGEGOpgKadgNBjuzJkmlcnXGegnbo
	fvQhzd+noIrtjAXXdjmEX5a27PNJprttkUzsydKEyIgTLi5P5KaI/NIu0omA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772738582; x=1772824982; bh=52T18nlfH4v8cHQI4X3wkA8BcEuHS1wwW1K
	zFSasmKc=; b=oDkUyCWH9sUTvBtLYOBUy1r1TWgLsoNQXgNxaGcfygENoV0jJwF
	Nd4THAnx5sCwCShM15ei/+eBBTFmqC2rTeOTrFbd7aEFmM363EEB1P0kNYpJjb4/
	j1B3Nk7FYg7BjWAT5hvdb9OIYWVrIS5EVGZSgNwK51YsBtpmPXcVj3wJbtSVfZ/C
	jhcu+2iEqxUZRuXfANBvDzy9j7Mp95rM6TXk9C78hKillJSlgqOUqvFIoFmL71n2
	y+bNDguTTw31+0OdprBJMDx+gmUw2lqe1RK2TOEYzhZk4vhDJphXqi/PGJYtavje
	isEMibmuc2UbjDmVDdXGrCw3gfkxXQB7E2g==
X-ME-Sender: <xms:FtipaYmajXZy-LTyCJb_hi6AJVMZEqLLHLC8jG4ZWBxMyWugW1HNnA>
    <xme:FtipaaHmO_ZH3H_my4hxlqSuwpE8WNMXKHewy4X7UNknhm8rwmLTddSdc83EfrEK3
    JXDYNo7Eky6PdxFE7jB66abDjxe5PUBlSViTxzizNSzqICKZhdG_g>
X-ME-Received: <xmr:FtipaY60Zc7fcACnr4Xx4PnY0PxzBlUp2ZAKlnpsMIFx3b7-SoM5CrfDB_ApKhMwzP89JuZVAW1uhQJ54mjxqHy6xx69LPPqvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhp
    rdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrghnughrrghkrh
    esphhmrdhmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FtipaaniHGfY5RmHbyPHEIpdV6h6T0u_8DYintGaWL8OUMZWufTdVw>
    <xmx:FtipaVoscaQIXD6NnXPU1Axu9OvIK_jPlivgmkGfzq8dCvQpEnrEaQ>
    <xmx:FtipaRseTvNzR8hE3MRXyohyc7BTUg4GzQrzapdmMiiOgnDTTZL6uA>
    <xmx:FtipaSFvDWZsLr3U-c2DkVe7U7g1edMYbFjv33bBgYUe83PA9IUtMw>
    <xmx:FtipaTiSjLFpMmcJRpaixpDiFzaBTg7KRwT9W3oCEUJWFuoxW508iGsf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 14:23:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Chandra Kethi-Reddy <chandrakr@pm.me>
Subject: Re: [PATCH v5] add: support pre-add hook
In-Reply-To: <87o6l2xuku.fsf@collabora.com> (Adrian Ratiu's message of "Thu,
	05 Mar 2026 15:41:05 +0200")
References: <pull.2045.v4.git.1772710566599.gitgitgadget@gmail.com>
	<pull.2045.v5.git.1772714253412.gitgitgadget@gmail.com>
	<87o6l2xuku.fsf@collabora.com>
Date: Thu, 05 Mar 2026 11:23:01 -0800
Message-ID: <xmqqwlzq2i96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:


> The turnaround in minutes between v4 -> v5 is also surprising.
> Please give humans a chance to review & respond, at least a couple of
> days between resvisions. :)

As we saw Patrick did in another thread, I often take such a short
turnaround as a bad sign that the humans are not paying enough
attention to what they are sending out on the authoring side, i.e.,
the new iterations are probably outpacing not just reviewers but the
authors ;-)
