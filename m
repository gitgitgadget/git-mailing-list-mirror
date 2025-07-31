Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A882E189F5C
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987236; cv=none; b=Y5G2xVDRNAzS4zDW0IseyO8SmpOtGmE5MVUvbgIZma/LgB87edDDSp9GSxPrWNUyvMogA6cDKrmaN6M7N750+jt76bILHtzINphyyfx+MOJS7yqFc9RcW6RVpR1Wb9Syic8B7RXUq0SGwfq87tJNL0oVv+SVYz6ynAOXDRCpHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987236; c=relaxed/simple;
	bh=h2Y/t1rz0JJsGTba1WnG17OMp8UqFG1qA1N30o8x2Jk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxwC62NicO1m4mIxZqJbqmyl0JOeYg/ZTxbuMoX76mEkHnob0GjTMxJLCjTezwpOWk2hmKR2t2cUvKFRv9qpssRUXPnYVUyBJd6DYxhT1LQTUu4rWuizhi3o2PZjV4faEK7tSrJrpng71pfBxdQ10f+Dsr/s/i7afwoBWSX1S1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FqI23rEK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVEEyzqS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FqI23rEK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVEEyzqS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B2191400240;
	Thu, 31 Jul 2025 14:40:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 14:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753987232; x=1754073632; bh=l7xhiYFV8b
	ixMpqxPHqQzJzMAl2+RWw2gHiAoadIV0A=; b=FqI23rEKpT9Ons+HbxWJIeM7Nb
	enPykrA5NVvCZu9dm/XXXeA2aHi02sND9Q8dWcnSAuNijPmqbBbdjSrL6myCMmOW
	AAGPZQLEsxo1qUBqo12G73DixEopXSfS3d/ytDKQKzlbnJJx731Arw31bbwkN8uk
	yzFRgNt9uK7z3E6spOI+VL2nZPiZR7NahPKNuyO8ZfbU83/INyk6khD3wFBLgaPr
	GSAyV8V8r4Agb4VncAxhj8x7Z/6y3DVJLNx8b3rT4MyEURFQ1M62m/DpIyM+UhKf
	01rMixWMl8c9iN952WWK+k9tY75b+Ld9Z/HB42HdBQjEEa7ZdSjcvlsmP9Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753987232; x=1754073632; bh=l7xhiYFV8bixMpqxPHqQzJzMAl2+RWw2gHi
	AoadIV0A=; b=XVEEyzqSCbB4nhTqOA+IVZzIGBmuppOGJsmdQvB+h5v/8Q7UWlE
	kvwC8hzFPrbN4BfxSguzjMRBvjE4ujLrx6qVcdTmhrSNlHAu0e6bJZVwvSukFlck
	c7ABU8yhjEUws74ZHOkcLh36AdfmMSlDJfNe/zlEBzlmdJGJdpboY1bl/fVaa932
	y5apchuqi7vvRjDr+LUp0dEoTkqBitOZwgOwqF2jLLt0sUZfucgckJdv3hSmlJWk
	Rm5xfdNAt7XIoIJf9h0HQ1p6wsKOVJXMPgTQDdnp3lKO6DBOL0sqBnhqYUKPKTIK
	NfkaeyS+WBmFawQyjRnU17+Ts9lXnLuR+gw==
X-ME-Sender: <xms:n7iLaBm0PqUi3_e7BUBoCwWDF06JvKQ8W6io30BYRfosReIPbFtL4g>
    <xme:n7iLaJziGfpVUTYLiORer7DmiD0rG-679k5TO9ir7TKCOOYLnIW7lEeHVjvQKJvoB
    mf-dGcQRg7W9fBFSg>
X-ME-Received: <xmr:n7iLaDTCVmOAcVD9RojsCsZIKPwvCbm1GmQlX5Ck2wJtzQCzECny1cdyAMc7uBNW_bOQEfn0uuaJ-8V6eIumBgC5qir1W9rts3Gz0bU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:n7iLaJ_2mYaucW_gw0qaOucjrIuMlUPxIpvD6vJwpk9A9dx6xLej7w>
    <xmx:n7iLaJvZbMBbXeqygtWcHJ8DE7iPPchRqYxZwlmxU9-4d2b-AklGoA>
    <xmx:n7iLaJM5gUGIDtPPOEkGJTNNlRPBCYWPpRQpS9bN1jggEXgAQNzzCQ>
    <xmx:n7iLaOh1972iHfbCUwN70Ew3xlD89lrFK3iL3GtcqBOKLqT9w_Yk6w>
    <xmx:oLiLaNxmg7GcXw4jxvZBA7L0p1BmWNWZ2i65py4mSCF2A-rxTSVwj9wJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 14:40:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Derrick Stolee <stolee@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v6 0/4] Introduce git-last-modified(1) command
In-Reply-To: <20250730175510.987383-1-toon@iotcl.com> (Toon Claes's message of
	"Wed, 30 Jul 2025 19:55:06 +0200")
References: <20250716133206.1787549-1-toon@iotcl.com>
	<20250730175510.987383-1-toon@iotcl.com>
Date: Thu, 31 Jul 2025 11:40:29 -0700
Message-ID: <xmqq1ppwryoy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v6:
> - Only the first 3 patches are kept. The last 3 patches worked toward adding an
>   extra option `--format`. The way it was implemented was heavily debatable and
>   in the end it is not required for a first iteration, so they are dropped.

OK.

> - Function prepare_commit_graph() is exported and used in
>   generation_numbers_enabled().

OK.

> - Since the library layer was removed and all the code was moved into the
>   builtin, there was still some leftovers from using a callback mechanism to
>   display the results. This is removed (as far as possible) and instead
>   last_modified_emit() always, this function was called show_entry() previously.

OK.

> - Code is rebased to use refactoring in the bloom filter API.

Ah, bloom_key_fill() and bloom_key_clear(); sorry to see you become
a victim of an unfortunate churn X-<, but hopefully it is for
greater good in the longer term.

Will queue.  Thanks.
