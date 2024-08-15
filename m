Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A9941C64
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698796; cv=none; b=Cq/IBS2oaVR5zopOjgJBX4ch80bzoGqbEIEinR9zjomdPt9gnFQfUOLjGO0SWPjdpq7lKqAjbplrg+TKmFg8djyHSWz5TlresTT5chX9nEgJHeKZcV2emH9F4w+HYPUMIMAnqG0kt8SVaKj84ki6IqNlzc6bdn9YoGwLRnXMlas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698796; c=relaxed/simple;
	bh=OFCvRX16+IbyuyuVTvbQV0fKAk+IIcOImSpoNRkxWpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJxQsBR9H1SiAGnn6J0pFr8kzZ2q33gSyWjItBndstR72ESbAF/BCrR3J5kvzEeSmWrX2wnq/8PvCMRVjQPQeAC9kKHoYGzCc9fBscWbRJR8CLX5hwfaByZauRTow+V2Q551g6WRHnGj/a6oF6U+rhcR1fqHgwBGrvZH6AwZsBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GlnJpW6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o79MSx2O; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GlnJpW6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o79MSx2O"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3EA4C138FF88;
	Thu, 15 Aug 2024 01:13:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 01:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723698792; x=1723785192; bh=yWPGp01kj7
	/YIt78XCBr8BbL3Ugm2v9JfdWl84jZH+o=; b=GlnJpW6VhO18s7JX1b7nKc85oK
	2r778vaq8qg4Zspfxi/m25hc5+qXNxmS9dQ8UVif/ef/3pWLA5vaFpK2FfkptV7n
	rHcV9TdAoHD8PZRPZSevHzgBeWdXxcxS2pag3Bo9UKkr2RSG+mowCi2tM1/huVvq
	Ga5vFS4CsUUZHrqYmgglUD8Q487+893sRQ9TVpCyZgkZaszHxO3uMCpwmSfM30yk
	UUWnSZ9rHMMeqgWiu6zs3JqM43DeXKBCzNUJDauDFcnxEJ9sQNVcX7DKpbrlYk45
	vfJH7X7zRr7wPhpEBl2KFqYfAG6SvwHRSGWirK2w7vI7bvBJb9f724iDOtBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723698792; x=1723785192; bh=yWPGp01kj7/YIt78XCBr8BbL3Ugm
	2v9JfdWl84jZH+o=; b=o79MSx2OSwOtbiECtpAsICXHYrnRBUukyxtKzd5aqrgt
	pO3aslaU72qKwB0hOOsIyT5YXjSCpJ+SgK0/PvbmXHkohZ4RS2laRfGaQ2Prv8xr
	IKOsSjrwQKr6TY6mb39sJ9SIhaWZpie2iLwULZVrCb9tXv9U1l7ZqWrHM+0C7Jln
	F8sCIuNxGRhRVMmnMhLRPow9xKrU8oFoQ5dZMh/Uc4P7dNpsT4WusdOwcsl+gsa6
	jznrj1Gh25o/8++mDQQgaKPMIUk886KaWP+vLRgnimUbw6OYTJR0pXil9+BLFU+b
	MG3qZ2dllYYenBNLf9hvKT3LCV96ePOovh3A0/i9dQ==
X-ME-Sender: <xms:aI69ZuFGNZ2JZPo7cEksh7jzm4TI_e2AP3ziihTT8I_rvrNzzZnmIQ>
    <xme:aI69ZvVvv4rIGgXxX48mzSZ5iqPCPTpFG4yU_cQICEBXZDNd45sVF0_iL5l6r0Yfn
    5ILDECgqAP0n8pfkw>
X-ME-Received: <xmr:aI69ZoIhVbXQJPaROcYFXcDT9IeUQRMHJG_pq4aS6cTv1J9BA3_Rl86BjBTpNdlUNn3emdl7GNqmlBbpw6bJbo4W7wRPKYHisFE_QApogN4Z2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aI69ZoF8FZZjKAoOifmBpM0yJFXTDxwjZ07F6mZalqM0Lwx2MOCsbg>
    <xmx:aI69ZkWtMRa7D6XsvKTmsUUFYxpqm2o9syOc8vqJbr-ylaa5Qxegiw>
    <xmx:aI69ZrNgVSeJO_827AAIyfq5ICE-TNwIRo6OR0BbkwUz_CS9MMhyKw>
    <xmx:aI69Zr2P3EVuN6YgJr8CcfGXr46LJlc9FQM0YQGHTe6FyhX_9KacRQ>
    <xmx:aI69Zix593whkFX3x_k5Yrw-Xot4jdiB9Y8AzvEHcl3ea3Qj18yv-pF_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 01:13:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ed4f001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 05:12:48 +0000 (UTC)
Date: Thu, 15 Aug 2024 07:13:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/20] Stop using `the_repository` in "config.c"
Message-ID: <Zr2OXEwmySOc9gpL@tanuki>
References: <cover.1723540226.git.ps@pks.im>
 <20240814192957.1518560-1-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814192957.1518560-1-calvinwan@google.com>

On Wed, Aug 14, 2024 at 07:29:57PM +0000, Calvin Wan wrote:
> Hi Patrick,
> 
> Glad to see us slowly getting rid of the global, `the_repository`! I had
> missed your original series[1] introducing the
> USE_THE_REPOSITORY_AVAILABLE macro, but going thru it provided all the
> context necessary for this series.
> 
> I see there have been a few cleanups since the first version, and I
> didn't spot any typos on my end. Overall, this is a good step towards
> reducing our dependency on `the_repository` by removing it from the
> config subsystem. Additionally, this makes libifying that subsystem much
> easier since removing globals usage is a prerequisite for libification.
> I only left a non-blocking comment on one of the patches, but besides
> that this series LGTM. Feel free to cc me on any related series in the
> future!
> 
> [1] https://lore.kernel.org/git/cover.1718106284.git.ps@pks.im/

Thanks, will do!

Patrick
