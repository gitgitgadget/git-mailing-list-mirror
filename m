Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC439FD8
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724390584; cv=none; b=RurGGRSz6NZqsl5xjH4V2hO5eMViSPiEYZCUvHx2kWu3DHaVSiFT82VlfbbTJ99pw5j3P+hOvSttRZobFZ+MbEW7EX60o+Axc20FCOJMptvOGFgpBLIExvpvnpHk9U79nJAAk3w27FUZBkCUSOZO5xlVCKsO0svdl9ewR/qKhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724390584; c=relaxed/simple;
	bh=bA+/HEulhP4s1e8pluldJ0TUGnpKygJMDuO0qBm2E8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnEbgI20vsIh+LkdLMdFnfFKlR2GOSh7yfw/E3ZXpvV6msqBiiKcIr9SvIyT15dmgRyQRbjBkY3cxQhD74wCkYc8YVH78B1ri/9IsnJSqrs6ZO8Ki+Q5WDACHqHyxcNTYyfAokglHOx+Kjt95sYeAOnnZ6uAidMVYVV32BjNQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R8ITP7ds; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ECd6wLJN; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R8ITP7ds";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ECd6wLJN"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 77F881151ACC;
	Fri, 23 Aug 2024 01:23:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Aug 2024 01:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724390580; x=1724476980; bh=+i/cGm8mdb
	D61YTabFd54VVtU977ei4uex48ejy9TfA=; b=R8ITP7ds6enTNpt64OrJ1tSUaS
	r4eUqPKLG0X4xKTlGl5ZNDcuaKWTFbkcUksLzyOgIgxqSNlK3OXz5GSbiaobGyiD
	xVfq9h3pxCR5chILtIQfxppxEONymYQrNi/QC6Qgl5ULBoyqkzbgdkz4WPbKAhb6
	FfgRD1gUg/ewTfaY8eybgdjeWukRDqeG+i4sUsNaBlUAOQkTyZ4GrsH4MI4+oqBN
	Lskex25oneS6sFxwkKTRgIWNgPSBlLxSfzqMkk75icvl5kSPMJtyjplNuyBk4GNB
	PYapDTV+3mLd8cFZOkyrV+NdsSx4r4r4GwVICHdgR/psKjJP0jv7b6eTXeJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724390580; x=1724476980; bh=+i/cGm8mdbD61YTabFd54VVtU977
	ei4uex48ejy9TfA=; b=ECd6wLJNRGrYHGi5GrkbsDrYLpsj7uQfiGgdyW4IpEi9
	ziCtboCCbqMhdwYBGxrDOm3lN9E+eM10lhCB6JT5NSlK7VL0+i2SyoIjml/YrfX4
	Vao04SblCdiAyi6bk+anU3dnwRC+QnhI0y7dBBXwW9e7uCMuYe4rh4vJrcdjw4kR
	/HKoJEgtVgcXDZgAErnLVaQVu4buMtFSFtmKMP+R6HRZZSyHtq4b2towQMI04Ccx
	6u0mieYkXD2O900iYyFfF5MiBS4DL6Hcni8zCrBjtEH09dzAhwfSSNuSicqv8PdC
	dWct+5sIerk5Kbw+WCC4jdi35uFQhGZ2u2aoi0te8w==
X-ME-Sender: <xms:tBzIZiGxNu_3Fi_STetC4UsYA2DJUARx5PyHhaPf1r3_2WYd09x_Og>
    <xme:tBzIZjUtzy1QwamQI7ALEOHjXhx0ZwN8oZyisKkKbj8u6V8ypi9YPfKPiaFOEl_rt
    ox9D6t3jCdxLtXCTw>
X-ME-Received: <xmr:tBzIZsI1ED75tZkkee2kXdSWMv-Oh_ygcwERpKgJzG0VxgLcHMboEcbgIdudbEcdXvKooYfczDU_-ITXZkgBQark5t2RmdpQdyNJ3sTaCmIyJogOqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tBzIZsGb7gxEfWjQ6d1YVS5jSo7YSXxmsRDfMQyphYDC6auOUsvqNg>
    <xmx:tBzIZoV7txEzQeScB_uXb31sjOphJtzkr_DPkodf4xGbeB8kFVydBA>
    <xmx:tBzIZvOxmxluwYeb_a7Agrh9yLm0K-vPH9oCv1TmFrsGqkBtsLNEuQ>
    <xmx:tBzIZv2nzAHx3TOBczWqYGBzB7FuiYOzaTOx93DqrZ_kQL4jFujQcQ>
    <xmx:tBzIZmxZOheQyFvYiZfJPyGAC5LXIilCBveB92vL3HEPaRpJV9lBl2z6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 01:22:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2247c195 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 05:22:21 +0000 (UTC)
Date: Fri, 23 Aug 2024 07:22:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 03/10] reftable/reader: rename `reftable_new_reader()`
Message-ID: <Zsgcr6MkBbXSQlBA@tanuki>
References: <cover.1724080006.git.ps@pks.im>
 <e658b372f046616779cf49c6c9346a49c2ce1485.1724080006.git.ps@pks.im>
 <7qfrzzhsplzmmjdygglfyum7d6qroiggeqonqptkzltgtcrdw5@wlukk42x6thn>
 <xmqqbk1kqsr6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbk1kqsr6.fsf@gitster.g>

On Thu, Aug 22, 2024 at 12:09:33PM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > On 24/08/19 05:39PM, Patrick Steinhardt wrote:
> >> Rename the `reftable_new_reader()` function to `reftable_reader_new()`
> >> to match our coding guidelines.
> >> 
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >> ---
> > [snip]  
> >> -int init_reader(struct reftable_reader *r, struct reftable_block_source *source,
> >> +int reader_init(struct reftable_reader *r, struct reftable_block_source *source,
> >>  		const char *name);
> >
> > Here we also rename `init_reader()` to `reader_init()`, but do not
> > update its call sites resulting in build errors. Since we remove this in
> > the next patch anyway, let's drop this change.

Well spotted! I originally wanted to fix that function's name, too. But
then I realized it's not even needed in the first place.

> True.  The actual definition of the function is also left
> unmodified.  Let me locally edit the hunk out.  As you pointed out,
> the next step does mention the "new" name in order to remove it, so
> there needs a cascading adjustment there, but the fallout is fairly
> small (see the attached range-diff).

Thanks. The range diff looks as expected to me.

Patrick
