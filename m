Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59118BC07
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138557; cv=none; b=UR8SLuq1DEeosdbnA2gpJQb/6mh6YLUmCw5rOVGlt3+ptFri0H/KbPdzGrXkmu6g/Mkk3hTk8/wXQUf2uyNKoH7k0tjg1FOfH14rKle0JFz8qqtkgU4WVeBlqtS0uW75S31rWOiNtHI0gOIwXLHjf3cmKh8lxUiMMR5ND0beufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138557; c=relaxed/simple;
	bh=XOHjnYPcIh9zSfaA74OokBK7WmLG354NCvGrK3C+YVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MupqwjbtVq3nOgUzuSgxf1IELT+2a2PuZ0ogCbzBeRk3pdeZ21WAQmkXNBwf55gtPV9RHCeMTbyilePd/o0LdixeHY5RIR33+lK8lNCsF5nB9Et7G4/c4scg21ei0VneGhLTfhYX1f3U4TcmFSbv9D1iVpy2Hw6vm86s66JweZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jKmVeucr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHN5A6NO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jKmVeucr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHN5A6NO"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE460114059E;
	Thu, 12 Sep 2024 06:55:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 12 Sep 2024 06:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726138554; x=1726224954; bh=buM9ZOp7eE
	9hQ3kBiyEyyOryLgapfZZP8uactnirZVE=; b=jKmVeucr11/sfwFHLssfGPKBSc
	Kdw8YO7hDliebfu7u5wjBVjETW0GBt6j3vu67pSLdRXdrWQEEcsmIeV3xb7/Ptcl
	dC52dHknIabvACbq6Dk7sbpSzVKS79cttnSAng6HuTsWEEtBs8MfH2H/4EhRygvD
	lrY4m4hZkSgRB2VMzixPb0iBXrP/+JrElgFp+osxUh4nhaCnO3Z10oJSvQpLWXtB
	H6qhzKbiwyFh2XTdcPhn5VRatlynwtaiummmIA/vOMlt7+OffovH0limB6787C9W
	61oPDY2ndkIcVF4H1aTR+jlhPTB2kg4zVK12YvpvLRcu2p8mf39tVhVQH/dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726138554; x=1726224954; bh=buM9ZOp7eE9hQ3kBiyEyyOryLgap
	fZZP8uactnirZVE=; b=EHN5A6NOBJr4ordhTbzUQfxzc6IE0qyPqorRVlAWSpG5
	erd0/Pi1v8JGrwoQR6bfPlpIzuG3rZM/M9iTOWAeydTGdnPUmEFqHpZF+40XaUPI
	DuOHIKX6W21AhThpA6p/gl8KrZCx0LYa39JPDpnmQPYyghPUySFwdr/9kgS2Vdvw
	rSNuY2FokCTok/u1wbL3h7OaMmnEMSFshE163lfu03+o3RVH/NMYXOXSTdEMl4Cu
	XwIsUf2ihVwxrxNzejN0tPLJFO6gEHa+g1BioQd3CE6b2o93tXRNL60eFtJXd1r9
	n7eBbqdnUV+mmBzciUQJMDFvl+Py1XORdNdBeiTbhQ==
X-ME-Sender: <xms:usjiZm2-JHtQ15bR1N_XAbBjXawpgUjnRZn9ZMOF0hvb9VXUSUHTyg>
    <xme:usjiZpEeLcxCMnWh1QQ2YavXMKs1uB_wc7bGFLlpkKvaM2AkK4-I-WqBOo79fGENe
    wCPg1XEDAtVIX8m2Q>
X-ME-Received: <xmr:usjiZu6huFur1vQsf5XXV4Ro9hu5Aikh4p9yZaLWjWVh2uusyHXFJem6RGSiXP1TH6xVPInbp9hTSRy440vF5g6AP2FXMcAHwkcH60TUjWpZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhgihhtghgr
    ughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:usjiZn0yZN-Th9ercXBDOo-RtiEWKFLas7xp14XIYvKWJNPjMjelyA>
    <xmx:usjiZpGRhVCMh1ZM-D7AyeDYboadNzP6o_ku36-lIausraFasxxzrQ>
    <xmx:usjiZg_dObpwSit55L4DzO8w9wXIFqwZDSLFbMRRiAPgAjQMovqgrA>
    <xmx:usjiZukqsIXqn1CNcqx3Cja8Hb2wy8taw75rrAkW39ET3h_gy_OUIA>
    <xmx:usjiZiOrIoj9gHpklvnAX21REVuGu_Qm_JLsnLiXfD684agtNLUK7Id4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:55:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6e89a048 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:55:42 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:55:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin
 functions
Message-ID: <ZuLItS8eruz2b_D7@pks.im>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
 <9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
 <xmqqed5rdw61.fsf@gitster.g>
 <xmqqfrq56gqm.fsf@gitster.g>
 <ZuK4RXMfherFBIxP@pks.im>
 <20240912104319.GA593177@coredump.intra.peff.net>
 <20240912105040.GA603079@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912105040.GA603079@coredump.intra.peff.net>

On Thu, Sep 12, 2024 at 06:50:40AM -0400, Jeff King wrote:
> On Thu, Sep 12, 2024 at 06:43:20AM -0400, Jeff King wrote:
> 
> > I do feel like I have only started seeing it in the last month or so. I
> > wonder if a new version of binutils changed behavior or something.
> 
> Since I had that Makefile reproduction, I ran it against an older
> version of binutils. And yeah, it produces the same outcome. So it is
> probably just some kind of Baader-Meinhof phenomenon.

I was also reading through recent changes in binutils and couldn't spot
anything. But in any case, I also had the feeling that this only started
to pop up recently. Maybe it's not a change in binutils, but in our own
build instructions. I couldn't find any smoking guns there either,
though.

Patrick
