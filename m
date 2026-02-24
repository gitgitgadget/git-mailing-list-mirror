Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BCC171CD
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771891643; cv=none; b=GuLqsH4K9D/0xmOpPoM53NhanVV8qR/VqZABNlEA8NXHcQvylaJjj5PJ7Fmbyww1xOKqdmrYx80lfiuhZ622KwjMoso4ax2OBdlIIcvmMi/H2yqmCHyGlRO1Bz84jvNbUhUAgxJ9lHANzFNjObaMuuH3IoeJZjj1n7jAW6IE9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771891643; c=relaxed/simple;
	bh=OUnzSPoApnMUEZAecpGkBbSBIbXz0U3JYGlNmVM/ddA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q/nGMF/eVYCpGjwR1xU8nV5H3cZ4R7jcN2dhbmorAKkBLbNOPpga1c9Pq71QUNlyI1GTqjlKErhHfc9rZtdFvENuf5yhQidcPXpimUXgMqczuvdII957q6Se90zEzNlLCXyv7ZEJAc+yai2kjeanrhBJ71qdsyAp+kd+bWeOFDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wclIzNSP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NDP0wz34; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wclIzNSP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NDP0wz34"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA4AF7A01C1;
	Mon, 23 Feb 2026 19:07:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 23 Feb 2026 19:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771891640; x=1771978040; bh=y9qOs+iAj6
	q1/3LNfaqDGGe0DBDEP45p2twA5wzbC9s=; b=wclIzNSP4v1orBdRn0WqN8cEku
	4sMbCYilK5ymd0gvDGTBJnD4P1OlhmIpuW5o3a9yStSH2+LLZiuQj9yp2vqR/wVe
	6LdgBQWGz/I7zmm9Ra6BVMiNbL7+Bs4NWQso37KHICrGRWNqWCMFo047vgvD2CTp
	s9UgVvj03PFjLqWxLpWsD6j2yzXwSlmJrqVYidVlZ4deGSIXYHXUKLJiglhjjEBJ
	ca+TkNhp5awuGhABC/FuZdhmwZ2pQ/d+dRKrfxp16CIZj3Etwrw80Wb70KaGEm7v
	NxfG/dO875GciVnNul7vbmwjawLJsjt5P/is9s4Mvt1w1FuOizpQ1mmMLUOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771891640; x=1771978040; bh=y9qOs+iAj6q1/3LNfaqDGGe0DBDEP45p2tw
	A5wzbC9s=; b=NDP0wz34iYzEDtjKZEx4gheMRadRqBb/nK7NSJ6dF+9JktfmuR3
	F3MgO8KMvtsDtLv0bkvr8zjm4yanTk0XXjFgTDyT2NroVsjQfuNMfrWxjOOi6Sb5
	Pq/striF32+Czr7ir6UbvoqLfOruRDR+hr+RGdkNXZ8GTSwWcHl3P/2zm+2KiQac
	MZy9w0s6aF273NAf9HO4CAV+U3icuPtp0tj8HA5NrHTYXLVz0Y8BK0zbXTtzGQg5
	5vOZs6jF4Bx2tZdKP8LlRp+nlP8a/Ug14JJ6PTZTvyRKins8wZsORYu9IR3fbEtx
	pi9rOWW0tBCnq0TCuMx1mWAC507XjzR5qNA==
X-ME-Sender: <xms:uOucac2KIM6fXJDFk65UgdYZwjDkuLW3Tf5yL1Dbl2rs04IdFE0duA>
    <xme:uOucaayI_LIRcEEk4KMiNMSOet_rBKE3107XOeez8eO2v7a-ZVyxlVyF0lbGXFPkh
    9nZMXcwIiPqMfq05fSsNPPN4jZ_LIg8Aq4MN3KuRxfVY0oZt7D0EAc>
X-ME-Received: <xmr:uOucaesTpIdhOFsY_b--_Wf_yqWcRdyOHt5lW0g1-Wo4wd125na1JDS0Pc8VeH5ric78EUw5u90hcBi9_fbPI2xRzqfsmL0Cpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehvrghiuggrshdrphhilhhkrghushhkrghssehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:uOucacwMUzVIr7Qwnu8k6VnY75D-CoBOSviyhNfsFDQ8HQp8YGPoTg>
    <xmx:uOucaRCKYWxGK8FBfc1A3cbWhRM93KJ6ug1OM4Wa1GVGFFPhen0wNg>
    <xmx:uOucaadHgn1F4Xrn2wa6LUD6NI9qaVQj0jqyZt81q-Og_dy15s2OCA>
    <xmx:uOucabkC1WopzE56fTdZs3Kcat0cqeEnX0x-vNA-1OimHy3JOy7Skw>
    <xmx:uOucafv7DjOoZT1ZZqOVemhWkTOs3xcN3mre_afx1USRc8diyrc9Osez>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 19:07:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v5 0/4] http: add support for HTTP 429 rate limit retries
In-Reply-To: <pull.2008.v5.git.1771856405.gitgitgadget@gmail.com> (Vaidas
	Pilkauskas via GitGitGadget's message of "Mon, 23 Feb 2026 14:20:01
	+0000")
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 16:07:18 -0800
Message-ID: <xmqq5x7nknrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v4:
>
>  * fix only strbuf_attach() calls which don't need reallocation
>  * remove patch, which enforces strbuf_attach() contract via BUG()
> ...
> Vaidas Pilkauskas (4):
>   strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
>   strbuf_attach: fix call sites to pass correct alloc
>   remote-curl: introduce show_http_message_fatal() helper

These three patches looked quite reasonable to me.

>   http: add support for HTTP 429 rate limit retries

I'd feel comfortable to see somebody more familiar with the HTTP
transport code base to take a look at this step before we declare
victory.

Thanks.
