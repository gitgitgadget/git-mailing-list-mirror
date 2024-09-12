Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490514F9E6
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140749; cv=none; b=ieLJrJ/cp4b8OxsVAltbD0tAMT0Vqt6+aqibw0VpHQxN4BXaBZkl9oFoOqEQ2DujObHR+PBOA6n15KuxdJFRasVCKKeMYgdZUIQeI+M0ONBpaU8DfDdrAjIDpX258zuiPkINtsj+GAzIeASu+vdfUapH7o/eP/jFIdSlO2t+/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140749; c=relaxed/simple;
	bh=2LGAxtIewaL7+2OT4S28v6I3EgrGpnhKO3K6eAeTFPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN0O2aRtqndUXXtAtBxvr8uI93JIGU6AHU3uwm3aBB8XZWjYJHoH3S9j2cuC155Ac9W46MpF2jCi6CvPydKM8Q1E/u26z++TYgU7lnT3zvzKcS51rRv/DSNhMjXKt0p4J+lbMCHhRq/H1lIrEThGD1IZ+z/RsVlPFEAEa6bZ2e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Diw5Uunx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XpEjk5lo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Diw5Uunx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XpEjk5lo"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FBFF138023D;
	Thu, 12 Sep 2024 07:32:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 12 Sep 2024 07:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140747; x=1726227147; bh=2LGAxtIewa
	L7+2OT4S28v6I3EgrGpnhKO3K6eAeTFPw=; b=Diw5Uunxz8IrViDxP9UthdWfE5
	T11DsXm7ilKEEmTbpjrJGFLT4v2TjLNhNcTSqGs7+LwlnrPcbpmEzJGyBOKUZa0B
	3fAbQagloeUGmykeHC/tpuMHuSyagsswmsvtBejfKrynlXbOPT6x/5a2LZUhMS4v
	bcjFpQuI4P4WZyt/MF/q/bIHEYEE/7/gj4chj70gEp9KNH4RVX9cSRihRV/8+iaQ
	WjyNAIVyDXD5O3thvh8chyMCEfy9MPvPlj0fOy6SXXx6XAjOxcUEX8EVpwc0ySHX
	Qb1YrHLr9CmnHsy5jBvdbz8oGYEMO2Bo0T29KgV8ipdO/wTrJgQYjXnTDBHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140747; x=1726227147; bh=2LGAxtIewaL7+2OT4S28v6I3EgrG
	pnhKO3K6eAeTFPw=; b=XpEjk5loQrfDW8fNqkv1cyJM8LDDnG+tZA0QsW6eRBZ2
	/2avpZmDF8PabuEDdNu5O+VYR84zqcieqLcuyg+4Zjp/kmGio3GaWnpEx0t61RmL
	A0ujRH4UlCw0lH5L9H+gOITaKNMT1MX6Y+VL0yv/UymZFyzIx7G2BIoibWJgX9Xb
	gGFV9e/xJlQ0rrdTLdYwSaClk3ZEX4BzsH8gDaoXMB37us9mJPdoirkfTu/7uuhZ
	r22ZiyR5IkQpE8VyPVGAzQMCmyhaN0i0CdQENtdMVCMSNY3GzBQLrOIWzzfJEmR9
	GHBwfiBf1u2TnWvQjjXE5oihMet8oAS5xKZO5+SJsg==
X-ME-Sender: <xms:S9HiZsgWD-S7ppNd5BLKKigaq3Io2CcLIuW2Y0utGN82lWid_ED0OQ>
    <xme:S9HiZlB_OmFcERQNH9j-e3mnO_DhAr0rCdIvRQ_3Hxqa8s3jsF00BlbX-B8j_4nwt
    MGuN60mRZ6oa6p2ew>
X-ME-Received: <xmr:S9HiZkFtaqn-f5rTDXlV7r6e7wwe2nXMOnSTAAEcc9hA3ae4W-h8x7EJJfF5nMrLkDFJ7YY4mKeTnzdVf_MMIWRz5kWJHLyieRqm9QwqoZ6O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvth
X-ME-Proxy: <xmx:S9HiZtRWSBvQqRcPWFywXhhiszZfwmugLE8GBt6SQgYQ9-bOkeMJ3Q>
    <xmx:S9HiZpw0g7uRSIzZtXrlxqltPTtAHuVwL56YaMKgeqxW73Rs64dXtw>
    <xmx:S9HiZr4q2AAeyu78I23D8O2nCKFVGVPy2Uzi381n21jPzScC02rpxA>
    <xmx:S9HiZmx4NjCja07ox-uRTJprScOcRzW03mJ6uWAGUtYe2YCtK2gmSA>
    <xmx:S9HiZrsoXtwoP0SGwhRZOOb1jb-smCmUEeerqSevLV5bFvl1SoliZd1U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:32:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e948a1cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:32:16 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:32:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
Message-ID: <ZuLRRGELzNl5VH_R@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
 <xmqqseu7jvz3.fsf@gitster.g>
 <ZuLA0SBqhBbBdcd1@pks.im>
 <20240912111858.GA617985@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912111858.GA617985@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 07:18:58AM -0400, Jeff King wrote:
> All that said, I am content to leave it for now. Even if it's a real
> leak, it's one that happens once per program right before exiting with
> an error. Most of the value in cleaning up trivial leaks like that are
> to reduce the noise from analyzers so that we can find the much more
> important leaks that scale with the input. If the analyzers aren't
> complaining and we think it's trivial, it may not be worth spending a
> lot of time on.

Agreed. Thanks for digging!

Patrick
