Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E72459E5
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761284719; cv=none; b=tFIAgsQf1UVwKgUDQkPrSl+IKwtBskSYLAe1vfvd+jYBANaofKgiqTn0HhVp9YoRwwMoBt/QqQFl3xzXTu3ozmVaPWFmMcYTajdMXyhMxaAGBv8EDenDpaCsTPDbYW7PMB01s55mKM4NKts90i/OtzGz3YrXyrYNyySH2viMOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761284719; c=relaxed/simple;
	bh=cWcR4QzWFvyuN5Tb6kp2O9P/1vbCD+vK8zyd1zBaKag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKQ0FvehTLajcvGrR2GSnFUc0Ts77zle7j7hwmwRACmSSq87w6Uv5aWpfrqYbv4IQ5j7tOEwVUINgx0mDYIMj1zspnDfCgFZJMHp37Zpdbjr/fncK25e6TDegenno82HzOQ4LfOVi54GVBBkzOsY9cL+5452KdlohQOxwwr+ylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KzWqPrz1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLI9SUa2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KzWqPrz1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLI9SUa2"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 470237A00A7;
	Fri, 24 Oct 2025 01:45:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 24 Oct 2025 01:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761284716; x=1761371116; bh=BwHmyF/Z1u
	RL9a/R1ISFZJ7b3ccO9qbYxXcVlbAOogE=; b=KzWqPrz1rwkenl6dpUmBGSdnNX
	UIXsH9rY88GeYcEkEXKTse8a0weuKfroYrG3Rbw71LH+2Smgnyh2voA1jI87Trvl
	3zfwsE/19Rgp+7jip2s9Myh/2lNWNI5nRCt+00bJvWwndy8UGzmWbQwrJ/CdPDNU
	Ta8w2s7qnMmgFCi+xCUPwbjjCLeDxvc31KlO9ZatULUU5ig3bUYw0BwoVLsfOvRy
	Ns2KS8PV63xcV3ggkUVcDXIoPg8LgFWWQcVHAcuOXauKEhla0xenMk5Aqs2N+Wpm
	Fh/J6ZFLDMFho8iGBAR7U9waF4wJJLNXCUDULN43bO0nJ5BkU/SdNr0EClSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761284716; x=1761371116; bh=BwHmyF/Z1uRL9a/R1ISFZJ7b3ccO9qbYxXc
	VlbAOogE=; b=VLI9SUa2+pkycucRJQa1jJ/qrgQdqXhKJeise6mYyUR1czHpWgD
	3V3gZiC4sVwEA7zvtWIDYqXEqUndJntOzfD2WerM9UWG4twywCXUR9QI0yyCmg7h
	MZo8u27Y3l+l/N7SX6A+2IdKskFTynnsfm6uHehFWiq+zdxviI8E3KMFCM4lrAPI
	e0RsTwQThJcAogwzefEU+ocEpfbkqjg3HWjPJhq0yMaCP/jFbI5XHkugJGI7DGrM
	bnZ2tnaTWuJJNCUk2I3ncKEEmjkqgdrgTP57Ww5u2H+C/oGQEQYPA+/w+sa3z3+d
	lMFypa9sN28orAXp5HZGoo2EjwSt+WrQg8w==
X-ME-Sender: <xms:axL7aNc6t0Fddh3KlqDog0TfprIfayxH7YswUGlOSix61oIw3UjJBw>
    <xme:axL7aCov5_uK3rRFKV2Ed-OIjt1j3yYnCK_fq8Bvo8Bwh9y_qIaYfW8gB8qoO8bsw
    2mNFJzfig3JwY90Sj_Aq0wqHArqVdIfJBAf3kMXshUz91YExa3APA>
X-ME-Received: <xmr:axL7aD7ZBBEoaOBA0Q5uj2FpKmnTTJ45Tc4QjBCIuE7QrV-3RLAYheMQC4-xat3k21qEJkv-d16-ry9KgQ2UNgD9BdxaJPSlymipttgZNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:axL7aAq3MIw8fO0DI9TnVoTfnOCO5pwZYgxFaJMkg7p1STguza7kDA>
    <xmx:axL7aNhmykih8JQ84vFz5Cy3WjSHREkAQ64V0CztdaJCrWdaJikbFQ>
    <xmx:axL7aCJbRQDNiZayCmuGQfxHQDCIE_GOSnhW2-Hmm4yeX07_4hbotQ>
    <xmx:axL7aFBjk1o6jV3i5Gf8qGuNsscE2eF6nXOVXYh7FlYcNmq7xOWVoA>
    <xmx:bBL7aFH-V3sJ8QwiTTIJ24LQnI3D0K7W_h7m1SexhTBtLxi8Y1St_q3u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 01:45:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 89059877 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 05:45:15 +0000 (UTC)
Date: Fri, 24 Oct 2025 07:45:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/9] builtin/maintenance: introduce "geometric-repack"
 task
Message-ID: <aPsSZ6IlbaEi9SPY@pks.im>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-3-f0d727832b80@pks.im>
 <aPqCBDLwVBKKaJU6@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPqCBDLwVBKKaJU6@nand.local>

On Thu, Oct 23, 2025 at 03:29:08PM -0400, Taylor Blau wrote:
> On Tue, Oct 21, 2025 at 04:13:25PM +0200, Patrick Steinhardt wrote:
> > +test_expect_success 'geometric repacking task' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +		git config set maintenance.auto false &&
> > +		test_commit initial &&
> > +
> > +		# The initial repack causes an all-into-one repack.
> > +		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
> > +			git maintenance run --task=geometric-repack 2>/dev/null &&
> > +		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <initial-repack.txt &&
> 
> Not a show-stopper of course, but I thought from the cover letter that
> these lines would have gotten wrapped. Whether or not we have lines
> longer than 80 characters is not a hill that I'd like to die on, of
> course ;-). But I brought it up because I am wondering if there were
> some changes that you meant to include as a part of this round that got
> dropped in the shuffle.

Nah, I guess I merely didn't do my due diligence to also wrap other
overly long lines. Let me fix those.

Patrick
