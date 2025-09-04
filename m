Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792028850D
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969803; cv=none; b=Af8SPpgir9AOtEXN6QWaYXz7yg0owjqigOOhIzdsJ42OALOT3NVFRVZsKuzQmBbdm5s8AQwCY8AgoDBmsRgZ3mdOhi9NbpWK36Kuzqx+J3K1syoBuuS9IDeTkN1DuqPF9zvzF9OnCqcpgnxPOL6NlJSkgvFawFRl9lpzKCxd/c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969803; c=relaxed/simple;
	bh=k69pTlneR+Mg4xtuJkc0JcvKa/LF/Q/9xl+DNNPp8Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvT6Qig+KZObR5uQSMzWZf+uuOYF9stW3CpJSogRX9evWVPHwRvF3RqitHIg8EWOEP3zmjFRbaYYINyNo8O+1Ik45C63oDxpRms3b0UKHuPuRs3SeJoUd1J1Iu11AwQO8nKnICG9GT58kqkFJgbeGM72F4ccklNQ2FESom/Z2k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W9jXPHW5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLbftzEU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W9jXPHW5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLbftzEU"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7993414001FB;
	Thu,  4 Sep 2025 03:09:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 04 Sep 2025 03:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756969799; x=1757056199; bh=edCgRNSLp/
	gzkJZ7OsIXWIkDohELZf+lD4uXMArWs3I=; b=W9jXPHW5JjtHEi/kT6JeeFs6Pb
	o1Ptu/IFB/RDXAnSv8Kb8M9DbN413TU4xO+/3xLqOUtAkxKVaLUAYEMJ8OZdlcAT
	XqikKflJ0u+Vksgfm7VOt1DKwRY71SlAx+/Xb2N5ohkitioxWO2c1b72FTh8V3vQ
	8jubX01cf2rI1Wz7uxVDcjOALMItWnnTygosZdQv49OsMffPWZDAz5WVgLKw6zTF
	+lfGGdxOC7Fl+svsCjoF6/fpO5yuiC0xiJ+0aUSbpAPDncqScfAXTN6O89kqt1JB
	QR7e8eaqlusKNHpQ6PdtWSRpj4ZWL6R43hNGbzxt85L0Abz5ApGyzMwce83Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756969799; x=1757056199; bh=edCgRNSLp/gzkJZ7OsIXWIkDohELZf+lD4u
	XMArWs3I=; b=ZLbftzEUBR8OpdJ9l4kmHI+FGg1t0Vw+fncz7loJEMrjasdd3Os
	EAQxKt4+DONjRuzq0CjSp8b4+Op1fyUo+XGYhcskr2MMdOwPOM+qeFf+eQAlAR0Z
	xYmAkm3EqSuJ6dkSEjfi9vLOiCKZlYzL19XhGN73u4uwCzLC0haOUzTqcPw84sG1
	lG2KtfKFmUDyvVPEyv+NWI2F+64I62z8rXDwvn9eBfBcfg0hHWr7IaKUY/tcZrzH
	ttYDMAHtDp+XWiDPXGKMPhr1wV1n8vCacoFO84mx8K4/7G8+E5WpH+xOvDzctJVH
	O+M81iihjV3WjOpdIyFqfaCGZlMnvmZcIIg==
X-ME-Sender: <xms:Rju5aCeILBrDVaGguYmkiakVg4bJANt8HNYJEiE0CMG3DuiY_duvOQ>
    <xme:Rju5aM_RsuOXYyO1qPm-DXFAhv3oSwOEonyf3_mfR7_OHGWqjXoZCdcv4TmBeN1oU
    QN-xmdTYvarY07ImA>
X-ME-Received: <xmr:Rju5aPptpxeVrGBb01ixrFbgEwiTO2K7AHuUNVpLax3mUlAQMz9TnKohVCXFFgTV6xQyWFvczSHypT7iGBIbB7HoCouJb9SX1pmA7Tl0RRu_OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdif
    ohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhurghnghhsvghnfeeihees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Rju5aBDmmLsdAO7KRolO7JhaB6tXgh1O8ahKvkaX9DTUMyKMTDXCbw>
    <xmx:Rju5aBxZWjRiElDPNWNnZF4uH2_l6Ga0tFCXDEUdHLz7pf6HBIV96Q>
    <xmx:Rju5aO30ms-SIf64VEjOeXTWtOGM72a0eRXjtQd4C6E4vrhWAC81lg>
    <xmx:Rju5aBylMnxDPcQgLOe5tjK9tTdI9AGQ3VpOBUZQleswmz9f9Qxh0g>
    <xmx:Rzu5aGpQfMEiYNJlLj-0eIqCv1R63sWi1R04rjnPmAjWm7_k-fi7_74m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 03:09:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fc190366 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 07:09:56 +0000 (UTC)
Date: Thu, 4 Sep 2025 09:09:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>
Subject: Re: [PATCH 6/6] breaking-changes: switch default branch to main
Message-ID: <aLk7QEEWy4nWxsQK@pks.im>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
 <aLbWuGQhriQCMFbO@pks.im>
 <96e128d9-e5e3-4bfc-9e33-3caa75cacfe6@gmail.com>
 <aLfHvl5JuttXrI0y@pks.im>
 <9d52f24e-d495-44d4-b122-7d80d1f4b77f@gmail.com>
 <xmqqcy87fkhm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcy87fkhm.fsf@gitster.g>

On Wed, Sep 03, 2025 at 11:40:05AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > When the variable was introduced in 704fed9ea22 (tests: start moving
> > to a different default main branch name, 2020-10-23) it was described
> > as "This `GIT_TEST_*` variable is meant purely for the transitional
> > period while the entire test suite is converted to use `main` as the
> > initial branch name by default." The way it has been used is to allow
> > tests to continue to hard code a fixed name for the default initial
> > branch.
> 
> Yes, but ripping it out would mean that you make it much harder to
> transition out of 'main' and move to the next correct name when the
> need comes, wouldn't it?

I guess it depends. If we transition our tests towards becoming mostly
agnostic of the default branch name then we can strip out the whole
infra but still remain agile.

> > ... like to keep the patches that switch the tests from using
> > "master" to "main".
> 
> I have no problem with that.  I am still unsure about that "reftable
> cares about the name being 'master'" thing.  If that can live with
> any 6 byte name, we may want to fix it to something different from
> 'master', for the sake of removing 'master'.  Perhaps 'banana' or
> something?

Huh, did I miss anything? I scanned the thread for reftables but
couldn't find any discussion around it relying on a 6 byte name. Could
you maybe provide a pointer to what you are referring to?

Thanks!

Patrick
