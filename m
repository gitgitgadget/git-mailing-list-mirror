Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EB925FA25
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829948; cv=none; b=eSlPqKj+XcFhWtYWL11q1cMd+331aTLBxDDdk5kgK52ph5TpuroXje2cUc11e0ZcPVvACeQaF1mwNhCVbz1ovenG7Lt/5k80/ehlUV4XzfWrr9CAXV3X/n7v2H0gjOk3o+iZn/YSBgp6Nrd+Z6o2f+3hdNU3ZaocB3MHvQgL9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829948; c=relaxed/simple;
	bh=9hSK3GTMtgYxM2/jPBXpIRFkXNI/wP8sNyhxAvZZr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuR7PhdPM3sYm2t2faWmwantMaGFGQ9Gao3tdSN2JgGUF3IfNfg3b1ROwtk0IrWA36gSFt3erKItgHcJs/i/zaPgnvxa4+Bp7UD3QiNilAdC+lj3c95oNYPb4Bvg3oYWdbrpx/YiFisinqdatrrZsg0XOn9wzVCeBeYhObsWlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RjnWp1Q4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ddCoGtRW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RjnWp1Q4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ddCoGtRW"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 642EA25401AC;
	Mon, 24 Mar 2025 11:25:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 24 Mar 2025 11:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1742829945; x=1742916345; bh=AF7Ca1sj9c
	GSXXKUINjcT7ixtbtH8sEcsz33BpNNhGo=; b=RjnWp1Q45UxYCUO8A8HwTwzbtZ
	3g31NLNVc+dMqeBNPqVSZBE4HDZfIpgsXCXDE/zZ1I2JuNFiCthJus6JpqHLIFst
	x7hZDoFNk9vRHdKT3wSFfpDAJW9FrCNKs8Od9xImrIPywapyb7XGO86P40O0SLnX
	R8tpFKCPIDRYjby2UR3lcZsI1qv8JolWo+D+7f3Mt/ZyyX9RW2uRET0rzQ044tX1
	Ue6+PC9UZCrxdIYTOHDmef6edFG5t/DKborC17NdD/2zyDwouRUsvz/vwgGZ8szY
	HKWLXeUJ29O8U3Gxj7qICWtB7FuJUDQJcRPbuhqi7vXzrfmGWSotMpG59nzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742829945; x=1742916345; bh=AF7Ca1sj9cGSXXKUINjcT7ixtbtH8sEcsz3
	3BpNNhGo=; b=ddCoGtRWvaaXkDvEXOKxujkOyypfUxjIRhqfGpBtADQHSpQd+1Q
	r6Sgfxd2bh8QnkNrLbwcdbI9LBlM5+2FC8Sm3einnrHBYKoUYoa7bjYmEZGb1K3S
	qudFPvGKMvgFXtxxobG93BbuHO/uLT9wZHJ2mPMj0uiDXNsxxE6IDI+mYhJaBHVn
	I3i1Eq9xdBJ3JH4FYMHh2+rmlBZQPWKDLrP7GxDZZ+XD1SSEsKHXFnFtGQ2ia0bb
	MoqRDGa5a+ky+Aq2HpLmNIOset/z2hkMM6i2IlFuQ2f0dB04kWLS/OBEd2AOa/HV
	v4wzrNNDEFUJ1wpbdetxwoVwuYSU4PB00aQ==
X-ME-Sender: <xms:eHnhZySLsvE8TNLNB1jSPx231QwPY0vEmbLkhsFYd-FLfQwIIOZqZw>
    <xme:eHnhZ3yyLRfmotnvHBqItHJyQ1hDBizWf-kQSQpwM25cSyyl752tAVcYrE-7GB4RH
    J_Pb6-I0YQgvK3Ilg>
X-ME-Received: <xmr:eHnhZ_2-gPYWVWR-36bYg5pMor8OVJNy5CNG1v6nnCP4D1gFLqitrRw6mbZ4y2RKcRQA8PNZ4VYqYZccPf-CQBw9eSbil_TUy8cB3wgdjsh4CCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhikhhuihesohhstghhihhnrgdrtghnpdhrtg
    hpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eHnhZ-ALiFxjqfOUKlgS5Yw3M8QHWH3WcBMzqfq28a7LjJI1YdpYCg>
    <xmx:eHnhZ7gSXA9i-r-B-b1H2_5l97GrmbYds2Q8miFFjKAiY_BcvAgDZQ>
    <xmx:eHnhZ6rki5X3nPEWErcTEJVanJrUPQq5Y6aZO8apzrXKwSONenRbiQ>
    <xmx:eHnhZ-ipVgdkSaq001mD2b6ZFr20MgPxDhZLrubV3OyMgyUixMOSNw>
    <xmx:eXnhZ4t1SLKzHgr9oxqDIEYOn23nu5owsVyDyF7fagw1u3BR7pskTTS4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 11:25:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d294eb12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 15:25:40 +0000 (UTC)
Date: Mon, 24 Mar 2025 16:25:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, likui@oschina.cn
Subject: Re: [PATCH] builtin/fetch: avoid aborting closed reference
 transaction
Message-ID: <Z-F5dJXq0uCxpqoL@pks.im>
References: <g4baz2kt25ysb6wcesoqxhvw2ooxkmqio3dj6b44h6gt5l6z3r@rocsjlys5nqs>
 <20250321004437.505461-1-jltobler@gmail.com>
 <Z-E2ns9VziejSLB2@pks.im>
 <vmmr2cwiyd2iz7c3yfyzym3l2aono7lsx7wig3pwmw33gst37h@orjtfygfyow4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vmmr2cwiyd2iz7c3yfyzym3l2aono7lsx7wig3pwmw33gst37h@orjtfygfyow4>

On Mon, Mar 24, 2025 at 10:10:44AM -0500, Justin Tobler wrote:
> On 25/03/24 11:40AM, Patrick Steinhardt wrote:
> > That wouldn't help with the fixed bug though, which is that we call
> > abort after a failed commit even though the transaction was already
> > aborted.
> 
> I wonder if it would make sense to stop closing the transaction on a
> failed commit and require the caller to abort it. This would allow error
> handling to unconditionally abort the transaction during cleanup.

I think it might still feel somewhat awkward because now every caller
would have to both abort and free the transaction when the commit fails.
An alternative could be to make abortion idempotent, where aborting an
already aborted transaction is fine. But I'm not too sure whether that
would significantly improve things.

I don't really have a gut feeling here what the best route to go would
be.

Patrick
