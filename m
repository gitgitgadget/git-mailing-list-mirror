Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59119E992
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408526; cv=none; b=Fgjct9Y5xZdUimvavfw/zoz5hyX9gI+gTRFlUMxJMZmLJioA05XcT4kBEn0hrz6RqkAwpwJtrIjvCWh3wnXxwInU/ZVCpU8j3jPt6J0OIVx5VthwDA0HLt0hJNyenoIYPdaV/11Ob8NaTu4UjcpXeM7+NPCN4e7ib8yTPb7OSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408526; c=relaxed/simple;
	bh=kfMFy9qHNX7hS/QBgIQbyGSbmfO+cBpR1ZN1TD0ecnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZfZIu7R3M9iBfuEBi8lRc63N21u2mtWpxZrnRg/Vwvd3PBewLV9jpZUMtN6j34lTKZH42rq9l+W/PNNjaR+pMTa5N+b9ggwO1Qjp6oYjWfkXtVqqYm3dYpFOgXPPRP3NdYZgbecdd/VbHPEhpAEm3vr9szwpx2c7Whs8dCdE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hCLM5uKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GOcY7gsU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hCLM5uKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOcY7gsU"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8194A2540195;
	Tue, 12 Nov 2024 05:48:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 12 Nov 2024 05:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731408522; x=1731494922; bh=VIzazEr7yj
	Mstczm7eTQylTpHz4SEPX2i46IyAC7efw=; b=hCLM5uKDY61XNZZeT5FhbG83Pv
	CEXAnvuXerRWjnrCdO728AGjA2oM3SmaCcx7ye+PlwfyYNv8GzZwRAAGvYlmqOA3
	pNID6fOqDr8+jsv6QUqEJMmpVMy9Q+oMYnPwBGDC5FXHw1Tv3L5tqqST7jzxtc3s
	81kBiet8N+t6RVl23az/cEH4jnh39VR7WQDK61hWsXB0RwQHcLYZw7c2mwOSGXL6
	zJSOeD2b7aVvttN2NKsws3ggTmpjGeizdaTEuzhKk+j3sT/AV4/0DPQDc9FHeruC
	KXlcsSJ2BRSn/JT+pLWj8xAqkqPi/N4EQR1WASLkenw8m27kWvklJrMiEssg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731408522; x=1731494922; bh=VIzazEr7yjMstczm7eTQylTpHz4SEPX2i46
	IyAC7efw=; b=GOcY7gsUc6G2dO4aMuE0LHWVpyB5FpivkDV07id96g2OzsT4GCk
	O18R3U6GkthKd09lOFNvkbvG8EOYtTYw1wIoM9N2ArZPRtNPktA4s/zG//2b50O9
	/PaqIDjuXnfDBx9MLraUXYwyqsz41Y9fh4bYfbityCW6LvTtEGJV+dlBDrPdsoqF
	YPZySPymhSpDsKr85aA2MIDPGE+ftEMcy3+/I0st/rco2Eu30+uPMycXsTi7yN8y
	4KUIa+UY4HxfXtnamPEnt4SgQaGKE0HIQHqawFDF0gjkPA7v0Rnj+xeca12jPaWF
	3+qMAwDm5ZfYc6zzy1iEhKWxG3fDW8ftSRQ==
X-ME-Sender: <xms:iTIzZ8zAz_zXGW1PgZ8TsNFueYg1OcwLVv6DfDyatwiTEePxglOSsQ>
    <xme:iTIzZwR7sje3QAqrgmY6dbP-vPwxoyfcOnuNSLLA1hTu2Wr-V-JihyMcBBgnH2MMg
    Czm_QZAHV5nmyP-lg>
X-ME-Received: <xmr:iTIzZ-VQlOjBJ4r0-Zl3NoFR8UsXlHA0gang_gINr2o6ZtPriAamjtYLXg29dgtDbmik7il2FqgdQMBWBFJtFneINmzg8ekel_Mec2m_BiQs_UI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeejudehgfevjeehfeeugedvgeekgeeugedvgeeutdefledv
    vdfgieelvdfgjeejffenucffohhmrghinhepmhhuohhnrdgsuhhilhgupdhsrhdrhhhtne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehp
    khhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhp
    lhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepuggrvhhvih
    gusehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ijIzZ6ib07W_iWkgNyInP7Y4LJybhGmcCEohl9E0K40wxALlDP8eIA>
    <xmx:ijIzZ-D6FfSLMQF-Ec1ZcFWVHHGwSkrDR2bNBmQE9mUVQ4PCHb9NRw>
    <xmx:ijIzZ7KtJ7RhzQHxZ3FOZ26D067AUw5YQJFyS45ACOXFlJoR8xKCyg>
    <xmx:ijIzZ1ByqEnhQFiQyd1EiVEfKvaJkOYlTmBigaCfPq2eTZyvHlRxQw>
    <xmx:ijIzZ608vfV-nyZALL6OyTNatAwgeQnKlPkgGOwDGTn_Kqs03GfKHj7V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 05:48:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f45e97ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 10:48:03 +0000 (UTC)
Date: Tue, 12 Nov 2024 11:48:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzMyf2GOtmpMhKNH@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
 <89a2621f-2c30-473b-9a0c-48135244f33a@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89a2621f-2c30-473b-9a0c-48135244f33a@gentoo.org>

On Mon, Nov 11, 2024 at 04:48:14PM -0500, Eli Schwartz wrote:
> On 11/11/24 5:36 AM, Patrick Steinhardt wrote:
> > On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
> >> The one thing that no one has mentioned is dependencies.
> >>
> >> CMake has less dependencies. Python is arguably a liability in the build
> >> system arena, and Meson requires it.
> > 
> > Eli has menitoned [muon](https://muon.build/), which is a drop-in
> > replacement for Meson written in plain C99. I don't know whether it is
> > currently able to compile the Git project, but if this is going to be a
> > concern for people I can try to make sure that it does.
> 
> I was wondering whether I should say something, because I don't really
> feel the criticism was on-target to begin with. But...
> 
> I am delighted to be able to confirm, that muon works quite well here.
> 
> It did require two small tweaks for not yet implemented features in
> muon, that meson had and which this patch series depends on:
> 
> the iconv special dependency, which I provided a patch for:
> 
> https://git.sr.ht/~lattis/muon/commit/75d33f6b6d482344d969e4ad6ce1527353f91cce
> 
> using fallback from gnu99 to c11 for the sake of MSVC, which I reported
> and got the muon developer to implement:
> 
> https://git.sr.ht/~lattis/muon/commit/a70e9687f3bfb8b9c21baf9acdfe84f97a42b11f
> 
> 
> (Note the commit author dates by the way. I had the same general thought
> about whether muon could satisfy git users such as, frankly, ones more
> interesting to me than "python has too many dependencies". Such as
> perhaps HPE NonStop users, and I tried muon out a month ago. Yes -- even
> though I am a *meson* maintainer, I consider this a useful alternative
> to have. Meson's FAQ includes discussion about whether it makes sense to
> require Python, and notes that we specifically avoided providing any
> "provide your own python extensions" functionality because it would
> prevent being able to ever rewrite in another not-python language. We
> also document muon as an alternative in our FAQ.)
> 
> 
> With these two small changes, muon compiles git successfully, and passes
> all tests but one:

Thanks, I'll have a look at the test failure.

Patrick
