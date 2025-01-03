Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8427916F8F5
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735886595; cv=none; b=b0qLBVzYcioEZzg2O8l1YgIan4tBwBcD7ccGCmb0yRjIergQLaHvE1fYctfLheXR3sGPklupQV3rmAwqdPEpmFImuoDyCFqsRxYOlrCfy5n+hCVtQkFh999MYm2FaZOQKsPsOb2bZxaA/vNLWgsY0FIrv7ueYiIf1GGy9+yd68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735886595; c=relaxed/simple;
	bh=N1FGCSo2FCIzgT4jM572hAbL0IBZRyJQOlcA/aZrxus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSeinA0ONcl/VBVarKwO4WgNna53Mdla6wxd201ko/Z/NMOv8eg+Q2YD+qFKk5VIGFXuzAfB1uZ6twNEv+iS16S/cmwMTG3Mh3qGM8enJt6fN8q3EXIhSo9NCE0wHiw6ugV7wT9m3gG2eAL8q0n7wg7avDeBV0OIzTwyDp14xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LNg71J+m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wu0QLJzT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LNg71J+m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wu0QLJzT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FCED13801CD;
	Fri,  3 Jan 2025 01:43:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jan 2025 01:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735886592; x=1735972992; bh=cmAtHcJilz
	tbIdAHFD9BGxgP3nNttkemTWgpiQOzXV4=; b=LNg71J+m65ui05BwdYtnTDCpKh
	IZw3H3quOLx+h6kNMvLGZVeKDe9hUEEXu26tLv0pq4tcO/+ZNW6o3fn6DEOJ9iM1
	kQaeEBi1QIo8hiCofeXcK/wiGFQ4pj949SZA073XZwl2mo0EFhrSmgIWm1DgBKOj
	IpswbyA5AXpwOozeEPcOoGwPHaYwh19D9wFPMBNJMNrrqAwwF3qXrSe+JWGKkkBO
	JbvcHpyeLBxx0+WcS4UCvNzRFOkjLWIUFYTB4tczT7hRsxQpNlw7oMAqEQCGmER7
	j72qtjSRbMcvAoJBNhro3mF27MRoaQcuD6Q2PAHfzth9tlpHMjONYAs9LVqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735886592; x=1735972992; bh=cmAtHcJilztbIdAHFD9BGxgP3nNttkemTWg
	piQOzXV4=; b=wu0QLJzT1KDX+fICgSPakqaN8r22hmqzwitJNkxS1p53kQC8TvX
	L38Ja9KHSAAqt8PeE9HY7ELYncUM26U4o2RjZxPhjPkr/nCcCNKb/xsajnyQDrPM
	/N1u1d7UoKzibnbkt/MdkmxF/u9N9Nkvim8UXWgJ2Gg3bMxwgOw9Kn8+3g+r+14D
	AopimFgky0iWhGX9m6wQVljlFO9ecxHPwatryq8SWM151Nd8ilIVJcvRHQhGjbXR
	ExvZWakmvHzkJ95Wi8aY+hL5yRNqsec9M6++mrnzNclNoj7lCbeI9KwJ9Uw0dQ4k
	sPqfnspTtDLjym0x8QhAS6EAExc+/wZBpbg==
X-ME-Sender: <xms:AId3Zx4li43E3JhLm-mzB1mCWW5hfULrx40QSNWZ0e1JIv26vgEhNw>
    <xme:AId3Z-7dNctdsGCVzbFtcXlyIa0Ihu49In97CMRisz8f8pRDbQfC-6HrdA-AEqGVY
    usrXN3SzuFk6lpy3A>
X-ME-Received: <xmr:AId3Z4eqG96uawiBehw02xWeMqXIejlAZReaUTIlMj39OekIe7BGpd_qMlKLtk6cTKfqIioveulswnRPuwEsRmIcaFSPZQfotJfGLbpRRbNzi3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghr
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:AId3Z6JRVPjZOTYU-haTsotoS_f2vdEJ_2qUn6JYubBtEkJ81LuDvQ>
    <xmx:AId3Z1IS2nYiHO93xspgx0x7LCepRup1FDKisex92cTzlCaGdczdZQ>
    <xmx:AId3ZzwVzgcmZFwRlZ9X2AVrbD4gskOCyrYt5dZeE_gAjelV_8YO1A>
    <xmx:AId3ZxKEwIfou83etLZ2tbeosXL7MnR1gopcBXO_m7unzGQ5VIyivw>
    <xmx:AId3Z11mFTxU-TOEnJzlfKC_E7KWb8vd0Yaaml0Xpv-R2uHhGY0RVtB_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 01:43:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb02d961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 06:43:10 +0000 (UTC)
Date: Fri, 3 Jan 2025 07:43:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 9/9] commit-reach: use `size_t` to track indices when
 computing merge bases
Message-ID: <Z3eG_ZPPMOa4KO3J@pks.im>
References: <20241227-b4-pks-commit-reach-sign-compare-v1-0-07c59c2aa632@pks.im>
 <20241227-b4-pks-commit-reach-sign-compare-v1-9-07c59c2aa632@pks.im>
 <s7b4o6elbbxrzp55mbgtj5tmfdtmdi4kczxad5ogy7quotrfhj@yq7ppxdjp4kd>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s7b4o6elbbxrzp55mbgtj5tmfdtmdi4kczxad5ogy7quotrfhj@yq7ppxdjp4kd>

On Thu, Jan 02, 2025 at 08:08:15PM -0600, Justin Tobler wrote:
> On 24/12/27 11:46AM, Patrick Steinhardt wrote:
> > The functions `repo_get_merge_bases_many()` and friends accepts an array
> > of commits as well as a parameter that indicates how large that array
> > is. This parameter is using a signed integer, which leads to a couple of
> > warnings with -Wsign-compare.
> > 
> > Refactor the code to use `size_t` to track indices instead and adapt
> > callers accordingly. While most callers are trivial, there are two
> > callers that require a bit more scrutiny:
> > 
> >   - builtin/merge-base.c:show_merge_base() subtracts `1` from the
> >     `rev_nr` before calling `repo_get_merge_bases_many_dirty()`, so if
> >     the variable was `0` it would wrap. This code is fine though because
> >     its only caller will execute that code only when `argc >= 2`, and it
> >     follows that `rev_nr >= 2`, as well.
> > 
> >   - bisect.ccheck_merge_bases() similarly subtracts `1` from `rev_nr`.
> 
> s/ccheck/check/
> 
> Small typo, but probably not worth rerolling.
> 
> >     Again, there is only a single caller that populates `rev_nr` with
> >     `good_revs.nr`. And because a bisection always requires at least one
> >     good revision it follws that `rev_nr >= 1`.
> > 
> > Mark the file as -Wsign-compare-clean.
> > 
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> Thanks Patrick! I reviewed the series and overall it looks good to me :)

Thanks for your review!

Patrick
