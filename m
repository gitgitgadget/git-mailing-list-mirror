Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB310E0
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573632; cv=none; b=LjA+Dws2KI4r3M/oqEKpXBGxxbZGg0uDBZpfQajF4ceSKrwA1aWq3TBCEYdmFLPbjtnxkRBVqmNLUR9WhXn7/q0X+8ufFLCaNkm1tjw+t/P7NZ6m1HxH5KBRJMhhmajwLyKjWeSo1XF/M0io5rhFWlfqzAeLymhMK2KUuXwEBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573632; c=relaxed/simple;
	bh=v7Z+Uiu4Kea3ljCGoHBA3qATQT+lwPNhGcotOx0Xwdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SCj4YQ/UpvnJoEdAUEZPmh/IT8hKJpgrSz+2HU01Hm/dSbFagItzmGy9zNWOlivvAQTNmr9iWnDA3OIjOzE3e89efsw8p+sTm+xmYeAV9nnfK6vRurhITCLJA3YLoP+zPK0UszjUSEx4jKcvoRj5psF0Al0tuyLfu0e/eZZ+RQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ADyolboz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFSqHGPT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ADyolboz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFSqHGPT"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EFF71140225;
	Tue, 22 Oct 2024 01:07:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 22 Oct 2024 01:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729573629; x=1729660029; bh=CYz1OXqTUX
	JV2mFWgZIMA4UVbcubIdUGpIealtxDAQU=; b=ADyolbozVL2G2Nv6Qr7T7VEspf
	44eXdzIh8C5aUD0k/j0KB0EZLLYPgYAdxl0Y2yj8tf0UpHg5RwxHeHohfi3bYnze
	QEzrE1RGz7jHlyFdPS2fOyRvJpk6Hhcq0wRDpmkmaFDmH/u5uVEYe/GFw5TmkGO/
	c78+ZeOV1YykqQAU3w1xiSArh+zffnPopG9qILQa4dVPISUCxck1udPsx7rAwKlj
	CizE7M+5x0UAKJ3DgqcOfUPpAfybZyP9nEJ7cVhmG2Vz0kOBjza+XVMPWuQA5oUx
	ZSmFyNQja8r65EZ4kmp6+3rWX9TWYEZE7tEkpMhSd27RA6s/EZFaUU3UJRiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729573629; x=1729660029; bh=CYz1OXqTUXJV2mFWgZIMA4UVbcub
	IdUGpIealtxDAQU=; b=UFSqHGPTk7/TqXRtZ2LwKoajs80uzUopAOxF3F48YaLB
	B1g2YA3KO/6L/YpUjO0hie7B/eTdWn9ozreuyS7SXQILb1iCtSVlDhSRT2Zvzwd0
	zPqSZqWl6FrqKuXJC7wvpT9OZv7moiqYA4g36mxwx9KBCImN7nKbnS4k55O6RtY/
	G6icM7nmM6nSpVMmSO4QepiEi22xRxv+MB9v4UpafrcOw3SvTFB8YTCYUOn3kD4Y
	ATJIICx6NM7LQ2dxDO50bPj/oqudCjxTRbDVcdkqft11uGTcHAjzncDImMv3I6GJ
	d8FE88KggdrbZKrXtFOlvjdC6cNU+bjeGxW+aJiRvg==
X-ME-Sender: <xms:_TIXZ-c9Ekd6OP7RpfgK9kaaRsyKjrNFg0Yv4uT-C9tVTyEe8wboQQ>
    <xme:_TIXZ4MBTFGFJ96Gc_KFIdLkbvfDnxi8i0TtbqxdkhXsVZYO09rUR6BUCy6txCNGm
    ioHEKUQUmcXnGkuAQ>
X-ME-Received: <xmr:_TIXZ_iu3NxDjUI6ue08Lg5KKzIp2XV1oOWYCYJ_LhXlTOmUyzfg97Hf5QmKAEgytFNvQOX5QTqkwcC69CWT3FhrVusbp3YEzzH8fWEr4F5R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeifedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghmrghilhestghsqdifrghrvgdruggvpdhrtghpth
    htohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_TIXZ7-7rPBy91ju3SRKv6ZTqKyIIppPZU_SUe2BI4Aj1eC93M8k6A>
    <xmx:_TIXZ6tOkZxzcDKGts25mUc8AfCOIupq1NhqWEmfP0Y_a9o0CXJ2HA>
    <xmx:_TIXZyG9FockOIOlv8ZvGuc1FgW-gymGq_o5Kel22QpUODvEqGjhqg>
    <xmx:_TIXZ5O-o13rox4I6iZTPU7eTTyVHFpTXbuDSJ8VniDiEs8DO00vgA>
    <xmx:_TIXZ-JF00MYifSfK3vs5Vmk-2vcKcbceNbn5cF3J9Ny7NF1CVliE-gl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 01:07:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9118cdd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 05:05:39 +0000 (UTC)
Date: Tue, 22 Oct 2024 07:07:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sven Strickroth <email@cs-ware.de>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2] global: Fix duplicate word typos
Message-ID: <Zxcy9W0DXnaCR9FJ@pks.im>
References: <b50f9706-bb45-4bf0-8d32-59149615301b@mrtux-pc.local>
 <e1ee980d-d8d2-4c9c-9a73-ba6af9009ba2@app.fastmail.com>
 <ZxYjISSiV-vlE96W@pks.im>
 <89ee8fab-ac1e-4e9b-98b7-f2ad25e8f0d0@app.fastmail.com>
 <6ce47185-690d-415e-95c9-06a3b828be29e@cs-ware.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce47185-690d-415e-95c9-06a3b828be29e@cs-ware.de>

On Mon, Oct 21, 2024 at 05:12:26PM +0200, Sven Strickroth wrote:
> Used regex to find these typos:
> 
>     (?<!struct )(?<=\s)([a-z]{1,}) \1(?=\s)

One more nit: the first word after the area should be lower-case. So the
subject should be "foo: something" rather than "foo: Something". Other
than that the patch looks good to me. I don't really think that this is
worth a reroll, but others may disagree with that.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 74b430be23..bfa1fe370b 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -62,7 +62,7 @@ trap "end_group 'CI setup'" EXIT
>  # something went wrong.
>  #
>  # We already enabled tracing executed commands earlier. This helps by showing
> -# how # environment variables are set and and dependencies are installed.
> +# how # environment variables are set and dependencies are installed.
>  set -e
>  
>  skip_branch_tip_with_tag () {

This one has a stray "#" in it, but it's perfectly fine to not fix this
as part of this commit.

Thanks!

Patrick
