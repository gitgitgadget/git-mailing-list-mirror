Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931B1DF256
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039500; cv=none; b=n6wbNP1qdIf1x95HuVy5OL2EnPJl6TjAVdHj4fqQ1c8EcKxRju7i9cUGOMiY+IpDjUsxLa3Izh/CJ5St/menB4/vFqOcLMniW8JNsDim+VkYmcNnY8YBQ6q8uvsK1M8oZFDp3LI5M+O/N6ph9R1ogHPQvERRZSKnAq/OTkTL7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039500; c=relaxed/simple;
	bh=PW/DeoP42c9E431Myb27G/5C0xBpdUQYIdDPOtGjTPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9OW11sY72eDhsBexwjCRLtphstmSSCWv9dPtc9LaUE2vjdur59fmEJRfC50iTiPHiF5ww+/3n6FgcM5RbzmQ0FYJkuQGVnYD7OoPsLAEAW9vw5qxOxKv17sl9vDu5jdJ7XAY5/uqEwYr/xQA2YXEQSlUgpCPRfiijwjUnu9DxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dwfVdg4C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MyOEwf9j; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dwfVdg4C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MyOEwf9j"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C694D1D00095;
	Thu, 18 Dec 2025 01:31:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 18 Dec 2025 01:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766039497; x=1766125897; bh=HYL5tMGuHg
	PN9hVgfd0KfYMdRDfOrtjM31TGFpKqcV4=; b=dwfVdg4CAjwGDUto8DhbaCtic3
	7+CM6dau8VeoY9BEglUHUBpHjsjdX6c+sQ3Wa/HOWYpkiGan/5zGnNXUqa0cH8wM
	5B8v09IZLInPI8onIT5rPn4qEM3Qv91KYS+bawCyhz0mrRIeTy/5M1MehO965UjC
	ng855TcUO+697lAKDsUhQHwf9hddSgW7491o7ej6BO5QlRd8by2DFuPtPfgbCvuh
	a/xo1pVaI1u+mXeF/P9IE/s2XtdB5P4XwJnaQDJhahNQAGICqlvv2QiihHz5e8DQ
	IlKs3zwo7gXGO26NT/7pS2RLYnoMZp+mUHZcg2RFtuohkcecR9L3EqafCKCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766039497; x=1766125897; bh=HYL5tMGuHgPN9hVgfd0KfYMdRDfOrtjM31T
	GFpKqcV4=; b=MyOEwf9jaojS0g8W/SbOdVUjgmyMeJs5aWx363FLrnfivmgPHwr
	4jvlG4KkPq7BJRbsGtjG5ZSznRJIraGU+jo1AeQG17u4/h576DdXh9oOtmRWn9j2
	m33p9/ep7DcRGDBnYDuZxrqUyqDUNwF3ecTtymliLx0Bud/JXDZWzo9MutVQYwe8
	JyEs9Agtva7BJR9B8MFFf/LL/fiDbmeHlGqMaD3UD4rmEzF4WxhHY165KsNU6GP3
	RnJEGHizfVqmGE7dRm5NTpb9IWXmcjSgPY40GGJwWzF7UAHI/xL4wXbNuJKNuU96
	LzhrzXEQ4tFY0ge9u1jpB7QOVnP0/nhWWBA==
X-ME-Sender: <xms:yZ9DaQRXLNCJVYacpCPMpr0b4Jx9xxC0ECxLF3mgOibiZFYhGhwzig>
    <xme:yZ9DaVOckNp6bIQaI_Hw9yvMIP37mwY4vdP5W8D2gdp851RxKptIYCZQs6HY4idoL
    -cQyMRR-hJFX5lMziLlgfCZCbZHKLNlAkHjip5EdUqKIfXVCC442yg>
X-ME-Received: <xmr:yZ9DabMpB0doW6YfRKbRglJhcZ6-4UlQ5mn9jyIYrtvhR3OsO8paweqjROde5cTjHFowppvQQeWl5slDI4A8y5cvZztz42oxVwOfTPJg-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejvedugefgffffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegrphhlrghtthhnvghrsehnvhhiughirgdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:yZ9DadsWUkHJIBsehv_HPOS2jUlMDS4Coe0KTSm4qAFwNdiqFsiARw>
    <xmx:yZ9DadX4wfbDD3MmGGvninsCx7udRWUO25D75_Foi9RBFifwzyjA1Q>
    <xmx:yZ9DadvRE3tuOMEVmr3Dc6x-1P2dn92zm0XPFkfuQM8eJsyD9PTYzw>
    <xmx:yZ9DaRUmsgOpHAav6TIMI6g7P-rgbLmkE4evLjJ0_oazPoUV9X_BsA>
    <xmx:yZ9DabXPnPqxMMVikD6w7ZsGguKWe-Dn1cIJLUEn51L8VM_ZsZ-d1dVt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:31:36 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de551a05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:31:35 +0000 (UTC)
Date: Thu, 18 Dec 2025 07:31:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>
Subject: Re: [PATCH] odb: do not use "blank" substitute for NULL
Message-ID: <aUOfxNGdkJe8ARM1@pks.im>
References: <xmqqpl8cxy0j.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpl8cxy0j.fsf@gitster.g>

On Thu, Dec 18, 2025 at 12:35:40PM +0900, Junio C Hamano wrote:
> When various *object_info() functions are given an extended object
> info structure as NULL by a caller that does not want any details,
> the code uses a file-scope static blank_oi to pass it down to the
> helper functions they use, to avoid handling NULL specifically.
> 
> The ps/object-read-stream topic graduated to 'master' recently
> however had a bug that assumed that two identically named file-scope
> static variables in two functions are the same, which of course is
> not the case.  This made "git commit" take 0.38 seconds to 1508
> seconds in some case, as reported by Aaron Plattner here:
> 
>   https://lore.kernel.org/git/f4ba7e89-4717-4b36-921f-56537131fd69@nvidia.com/
> 
> We _could_ move the blank_oi variable to a global scope in BSS to
> fix this regression, but explicitly handling the NULL is a much
> safer fix.  It would also reduce the chance of errors that somebody
> accidentally writes into blank_oi, making its contents dirty, which
> potentially will make subsequent calls into the callpath misbehave.
> 
> By explicitly handling NULL input, we no longer have to worry about
> it.

Thanks for handling this, Junio!

I've sent out an alternative fix via a patch series that I already had
cooking locally in [1]. It also goes a bit further than your series as
it also recognizes the case where the caller passes a blank object info
again.

That series also contains some other fixes related to reading object
info where we had been inconsistent with returned results, and another
performance improvement where we can skip unpacking packed objects.

I'm happy to go either route though -- I can hold off my series for a
bit longer and rebase it on top of your fix, or we replace your fix with
my series. Just let me know your preference.

Thanks!

Patrick

[1]: <20251218-b4-pks-odb-read-object-info-improvements-v1-7-81c8368492be@pks.im>
