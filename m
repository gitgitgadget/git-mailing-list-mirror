Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0142633C9
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656724; cv=none; b=AYIdop7eq/7+eXGO82sROSdNHh+ara64kE866V8b//uCt/RXtj7o8thlXWk1760sWGJM+azuvHwZ17nz9ZZXhEaLn3QD0b7WySN8wu+l2c3N7HnW/C66ByIIUzf1MkeUtszT55vzvCQWGHc86M62U0+ZaHiRj+im0hEbZeowRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656724; c=relaxed/simple;
	bh=pmZu6yfon56u5voDEIL+o3qIu0IpMPfmrqd1TWclj/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7ZbRpjnrokrSg3cJJ898+pZwP8JDaeEsFIfKwaz40ZtHFPRDkkMi6HETB9ku967m0XHNHS+zSUmSFUM2De8LsoN0WmCdu+syjx17LN+U2CKyNf08ruXPvTvNCN0Vpf1mbgHGWnm9+QAPRzzgSROg4nVWSe4nGQk5gEldi3e/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JqJXO+YP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t7our4yf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JqJXO+YP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7our4yf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A567114019B;
	Thu,  3 Apr 2025 01:05:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 03 Apr 2025 01:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743656719; x=1743743119; bh=uCQMrWLvHv
	Vq+HlKKCw69nlpbads/7lIYtuCxeskbIU=; b=JqJXO+YPeKGo82RxtEL7mwQa9i
	L31T5/hMLGCi8QpoHK0bxjxdG+xQB27VQUpFnkg1oDzNQcz+Ng3kF2AKbyfcxACp
	9IoASoCnH1UuseUPeYEDb0FBeWBUbi5/h92Hya0s8wyULe62X0hUncEQ92oolRKQ
	pKtkaoIi0RJmKV0U8ihWzOB96iHsU/dJKgWcdi6ZQRQHAyxuiyUmChhvRLEtijPH
	Am+2BQ6ce7wiVLYyatALtMZmde6nsdlY7NDKs4mpndhKfhnaaznzYP7iCOEh16rW
	BnkzOiu0bH5THzQV2rlfyYLpixf9K06RFdUTqtcVrspEg7u48hXRL+6L+hLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743656719; x=1743743119; bh=uCQMrWLvHvVq+HlKKCw69nlpbads/7lIYtu
	CxeskbIU=; b=t7our4yf+KeK6O+ret+EeEppFVlpSrV8z6eSDMC22zhoXUmd/hI
	Eh5bP7glMPOMVW25Z1bKWWpmPEEUTuoo9ZMu/XWWeeZ8Dnm8xLaxbUcAsDkYx78i
	u7OeCZUpMVQivrbYGRhVWZcrYAnIYQukzJK9IE9y7Iol7QMRz/55KCWF2kTtFj0l
	8pVj4p6utXg/z4VeoeB4BPn2Nmd8jUHwVq1v1k2jhpadoIx/gAo+8tdtMDqMA7oA
	t7irdXsUJVI151TRu3/oryORsCrB1p+KpS3DaGoSpNc6Y1uvsKyCScRoXRiOvgcf
	04CIbA3SQP7f0vRtFOOYSDLt9M42+hnUCtQ==
X-ME-Sender: <xms:DxfuZ2mbfajgj8OZ5uBoUYixLr4_1oKMeZK6warrThpw7JlkQRc-_w>
    <xme:DxfuZ92d3TELfV9V3b0Fk1YwvH7mUBx_P4Ca5SDz5aFi0o5lTcTaht6yCnHyeYeFT
    QzVP6P5iixai-nEeA>
X-ME-Received: <xmr:DxfuZ0odTXwNmbyUBqfUuD2AXbPmtRMrhpmPcGrLanMMO8OOeYTYqUDzsL1M9CrP0t0vzxcGKLT_PeeCk-TZFF2-RYWeETAwCB_yg_n_39SLziI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhi
    nhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvd
    efsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DxfuZ6lgQabOA3jnf9LWp2vwMqKiIit-rxcNcmqVzc_HZ0AC_pDV-w>
    <xmx:DxfuZ03CvWycB1ltquYU8FfJcgeNhxKQvUrNXAfEMtrUr6_uW6OvoQ>
    <xmx:DxfuZxuFPy9mksaXj6Nm3ZDfg8y4TBNA_I2v8sDgo3gkINUsHdforw>
    <xmx:DxfuZwWAI8Ff5MIKEWJCXvLgiqCM5D8jRK2C-TkiGOKb3paZZosgnQ>
    <xmx:DxfuZ9vrsnfYpc6FmNYcoXtxc4Fl0Tw1ZVMbMQv_XG1AGupluM9K3tcz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:05:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a0dc6e7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:15 +0000 (UTC)
Date: Thu, 3 Apr 2025 07:05:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 06/20] t: introduce PERL_TEST_HELPERS prerequisite
Message-ID: <Z-4XBk6RrHirISYE@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
 <20250327-b4-pks-t-perlless-v3-6-b436de9da1b8@pks.im>
 <ee5e082f-6ab5-b996-9a0d-f7e5192c01be@gmx.de>
 <Z-zkQyRCM3BkovgY@pks.im>
 <5a344739-6556-858f-8769-c42e48f01a6f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a344739-6556-858f-8769-c42e48f01a6f@gmx.de>

On Wed, Apr 02, 2025 at 09:10:16PM +0200, Johannes Schindelin wrote:
> On Wed, 2 Apr 2025, Patrick Steinhardt wrote:
> > On Tue, Apr 01, 2025 at 08:26:36PM +0200, Johannes Schindelin wrote:
> > On the other hand, maybe the better fix would be to just convert tools
> > to not use Perl at all anymore so that we can eventually get rid of this
> > dependency altogether. It feels like we're quite close, and many of
> > these conversions are low-hanging fruit.
> 
> As for `git filter-branch`, we could simply -- what were the wise words of
> Elijah's mentor? -- "debug" it. I.e. delete it and be happy about it.

I wouldn't mind it, but we should probably have a proper replacement for
it first. Ideally in the form of git-filter-repo(1) being part of Git
itself.

In any case, meanwhile I have created a follow-up patch series that
adapts both git-filter-branch(1) and git-request-pull(1) to not require
Perl anymore.

Patrick
