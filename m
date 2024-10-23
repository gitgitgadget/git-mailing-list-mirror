Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E606136331
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685067; cv=none; b=Mt4TpylwIswuihZYu0ab0NZHy7h8O4QBka5H9AJ5hQugv1qq7YUUkvKnSRjjtx1ei4xyzUsv3hJOHSHpTc2TFnnyAQ9xATd7s+MxGoVccpul7iU0iIdUEpyvWlYtlgBLJoSqNh3EK8CGM+dD4iOtQmF3xCdLMlJ5mh8Zj3PPE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685067; c=relaxed/simple;
	bh=GqZPImMcCXiP+zpeZFQyIfgyaNtbtPpMYZCE4uKOqjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jkms/ryfdRIVltPlUfsIOiIlk5kdHaOwxjtCjT5VA5ItqJq4ISsVmGObVv4gw2cDWJqujUi6Ry/Ccp+UgW4cvqQfPuAJ6xY+s3nHHKPJ9kBLKIihYMT9+lBTDf8QNBSENvDmD5CjahBMr2bmMZcAQHsbMMNGLXuC4WCk7sNtHYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bdbBdyA4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l7TGhA3z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bdbBdyA4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l7TGhA3z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 871941140128;
	Wed, 23 Oct 2024 08:04:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 23 Oct 2024 08:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729685064; x=1729771464; bh=uj4chGXvVW
	ADRcF1K1UfCCE3NxF4jaPs0LdnS3Eg2Vw=; b=bdbBdyA4whPAPoswzl1hd3S5Ik
	cYsUZbV0SRffywGfEHImqkIweUhj22PAJPljpehF74nZjcq7teBJQC74i3AFXu/1
	v88ftGePAfnBNVARkrC/fFoeqi28FJMxfbnWjVm5fHAwntA3NAP0w1nYmkka3YjH
	aiD0n6owemtFuGPuVLOFLQAF4KzkgL6l4mpZWVuSP1oFFn1crV15famAxeKR9HOk
	eysp+cqAmW6sEoqXFpxVxGBC7fPUAijRLtkvqWWfNBNKXa2Aevg0TRK+F4HK/wrq
	CBsvp45UDBj9In6h4S5zVmuxGR8AjDMtz7q0b3YEWhAWj9WXMLvngQHyYhiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729685064; x=1729771464; bh=uj4chGXvVWADRcF1K1UfCCE3NxF4
	jaPs0LdnS3Eg2Vw=; b=l7TGhA3z6U5F+o1SVbMtskrlZUPt48kasDZTKH8v96cp
	Tr/RHcq3CEuQ9N3hfGrRq8udlPt3EqbgFhfnidjyvfm1PEm0yhpUvQMiqr6sTRI4
	/xABAUNOE/TfCii2WTyGtAKylU1MmCGCd5tsqXQpUVqpvtLGONTUmtYrCiI2rmMr
	14E3urPMZC1PFsDSB6eXU2OO78thTXByFKadPLBNm6OERyZrXJofamO3l9FdmDLv
	Iy8XZS0ghFas5p642EfF1JZpRcQhgHpeHiofayScUkc45iA4DCuUWJCjOmte9P//
	kX8LS4tOSo2RzdWxVH+PQ2D7nZFEjqClD8j7ET0dhQ==
X-ME-Sender: <xms:SOYYZ3STJVySUGJ8mQHbBrMTSGDBdZWjd1erdUuqbqUFsSvQNlPyYQ>
    <xme:SOYYZ4wcYM0CxIhYa15tBcK3SEIQbeFXtG87FZaK7WUx_zMyyNL9kZfdqTod_A0co
    dsAPHoFlZ_eNT_Mjg>
X-ME-Received: <xmr:SOYYZ81HAnwE5j7oxcUn_3JEOpxzPY4u4HX1YLeV4HYqkZxzkTb_taLmwBk-6DikaOVuYYw4NAnswWGYi54Mmv-Pyw2O0pjtXL2uL5geUhv9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheprhgr
    mhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiies
    ghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SOYYZ3AsWhU55-7FOD5_wSktPXj27csFEPbWjlosZwJvowSjMkDrWA>
    <xmx:SOYYZwhQ1W5eC9OPss0IBTQRNWR5R-bi1yQbN_onCm8Ys_h68VZ63A>
    <xmx:SOYYZ7rfAA_FiZD_IqIxpHQNiMoE3oja7AIoUs3QdlLz26QS2DK-FQ>
    <xmx:SOYYZ7jvdSpBLF9beBpbdvUBC6Tslsz7XIeOhEnbMPUTvhyfVD0VCQ>
    <xmx:SOYYZ8jheUczJpzqJwmbEP3Rm7xdyO0RgY07ikPHrtGDT8gpAdtpW2am>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 08:04:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8db62bfb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 12:02:51 +0000 (UTC)
Date: Wed, 23 Oct 2024 14:04:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <ZxjmRQVh7osfAzP0@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729254070.git.ps@pks.im>
 <ZxbRQjQQ4TDdaFgl@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxbRQjQQ4TDdaFgl@nand.local>

On Mon, Oct 21, 2024 at 06:10:10PM -0400, Taylor Blau wrote:
> On Fri, Oct 18, 2024 at 02:23:47PM +0200, Patrick Steinhardt wrote:
> > This series is based on 15030f9556 (The second batch, 2024-10-15) and
> > has the following dependencies:
> >
> >   - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
> >     dependencies for generated clar headers, 2024-10-15).
> >
> >   - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
> >     generating "clar-decls.h", 2024-10-14).
> >
> >   - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
> >     FreeBSD, 2024-10-16).
> 
> While this is still sitting on my review queue, I rebuilt this topic
> based on the above (extremely helpful) information, but it seems to
> produce some conflicts when I try to merge it in at the end of 'seen':

Huh, interesting. The first two series had conflicts with each other, so
I wouldn't be surprised if what you see comes from that. Those two
topics have been merged into a single topic now.

I'll send an updated version of this series at the end of this week that
also aims to fix conflicts with 'seen'.

Patrick
