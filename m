Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4A215770
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418036; cv=none; b=nv74hWO9xttibSJqHtfMn+WZkMwJdGPfMJujKBjSOveSf/DUiNPwTcFnvlfPHmtMYZWux9oZpSPbYn9iBPfKHciZT+SQkVzz+VdrLtH31dsAOu50obDte69iunlUP72BzqWvnGYcKt8STi1k3/xcHfr1ZXAUnAUYU2PeT3pBPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418036; c=relaxed/simple;
	bh=g4kZ4m4RO1aPtEfnSLNZTu9G314kU2MchlOGB2IPojg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzD/b+bXFHsG2g9GBQzaaHWS7ILPemVKSOAQky220YfSc/a6VUcuras0cF+qI8aS89C01Mtmf5ay/ovSnDH5ymg07d1jFQ32xeU7EStFxHJqILmSU0VwlrzZ/BTRfOLEsTF14tvYJn3Fh0WOnswz8euOwkfa8qHKRI6L2QsCxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VBV/rx27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPsQkUeX; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VBV/rx27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPsQkUeX"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 457F61140170;
	Thu,  9 Jan 2025 05:20:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 09 Jan 2025 05:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736418033; x=1736504433; bh=3b06ab6sSO
	gY8TBIqLTecMQQAgaeu07cQkFo8RViu0E=; b=VBV/rx27kPSpBzr7GCy+hElMRs
	NdxaikeJ3/H0EP5jhRQprTha4WPWRBlV1+n+b494vPly2yZasgNGRYn0k+om4tYQ
	wPswtoWZKOHEMVWV3EWe0gOyykC5oVunwY21aHgeTqeB78oaHOrMylybZ3/kt4gT
	AQLXpByOS3KxVe0oP0pyUZoMywX1joLTWIdu6TjJU17PoTSFMbcG/ydhMo5E19nB
	iav0e6oM0YhRT5c0zoj1Q2xHWIwyeacoxxu7yhBe5ZFH4DH9FIWoEI+6xsM+SOjw
	+YueQaS7qlthxusCHmFZcrsZ/zh6MetpYl1m0/pedWQWMvs0X7NOGO8yL48g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736418033; x=1736504433; bh=3b06ab6sSOgY8TBIqLTecMQQAgaeu07cQkF
	o8RViu0E=; b=FPsQkUeXhdZPy6q60kHaDxZmzKvXcvpwduWIvSjyuBzbC95ti48
	vyPC8027T/eNqTmjhCAG2NxUfTJ2fNM0e21+OdLMonIYNUJmPTamgLcoHrdsIN7F
	T900AgWoWhkDYn95NrGv6tSPg9rYbaegFW7pWLF3r6gvzWaMuRQ7Iex0LSRXbCRC
	Siv3hhT2sByFe6H/vhfhoQNh60Jhf4MSE4J/Z2+oTgHKKChrCSCWruuZ16rvOVh3
	Ab34AhZ90MMmqjcfUsHyEgO/cIvbjZ8z6pEwDeYHtcVTdWRdPrueHjtfgJwWPtyF
	iB2fG30aEzawQ7yM77PwaptOZpKg7eCnrvQ==
X-ME-Sender: <xms:8KJ_ZyG3Lief3brCxOswdFxgGJdnNj5l5aocC0PioNtzx92nehUueg>
    <xme:8KJ_ZzW7zV_FKwx6Z27J2t0tRfQROccUdzFDsQQRqkh5thlmL4niYv8Ru0Ek1pqez
    UamEGDh7z9Wum1GfA>
X-ME-Received: <xmr:8KJ_Z8KrBiNnOJA4Db9i46VmtFrhr8QLReCArRnzgt607b5yXY4VH9p4744fv1mRWHsBWpciylnWKRNwhA0TkAi4qu0KLLh7pL10h9pEyISrWrQ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtg
    houhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8aJ_Z8HZ4r97Oqcl05N36ZdiQGbFxn6O7spYDQPvZoo_2RzzJEHJVg>
    <xmx:8aJ_Z4XhaduCUGJgy8amBLFWT33cwpoJq9Va3sNkOYDlzIX7V8dhOQ>
    <xmx:8aJ_Z_MfNUr8UeYelBaVe3Obhhq9YBGZdNfzZKkK_FujicL_u_1f5w>
    <xmx:8aJ_Z_199PPq39-1HtcKUAKoa4A1YFxUfwuynU28W2Vbyx0FoCjgXg>
    <xmx:8aJ_Z2zvRvpQMF_oPFqYQ5Aj8IXAqdYIuEyifJ2BhWaFyp63lRhvqIEX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jan 2025 05:20:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94ef5628 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Jan 2025 10:20:30 +0000 (UTC)
Date: Thu, 9 Jan 2025 11:20:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 5/5] remote: announce removal of "branches/" and
 "remotes/"
Message-ID: <Z3-i5mB4JVeONy4O@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-5-2ce87c053536@pks.im>
 <CAP8UFD0Lzazxyq9nnT-vwN=MijKAsYySFC2dvDEj33cS7VB0kA@mail.gmail.com>
 <xmqq34hw0whh.fsf@gitster.g>
 <Z30hnx43mEwjWqzA@pks.im>
 <xmqq8qrmvap5.fsf@gitster.g>
 <xmqq4j2avaam.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j2avaam.fsf@gitster.g>

On Tue, Jan 07, 2025 at 08:49:37AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Makes sense indeed. We can easily add for something like below diff.
> >> I'll roll that into the next version, thanks!
> >
> > It is a good start, but is probably a bit too noisy.  Can we make
> > them appear ONLY when the definitions read from these older sources
> > are actually USED?
> >
> > Thanks.
> 
> Something along this line is what I had in mind.  Not even compile
> tested, and I am not claiming that all the uses of remote will go
> thourgh the code paths to use it with a transport, but you hopefully
> got the idea.

I had a look at your idea now, but I'm not convinced that it would be a
significantly improvement over my version. In almost all cases where we
execute `remote_get()` we'd also end up using the remote itself. So we'd
either have to add the explicit warning to all such locations, or we
risk not warning in cases where we really should.

The result of `remote_get()` (and `remotes_remote_get()`) is also being
cached, so if we retrieve the same remote multiple times from the same
remote state we'd only see the warning once.

So I'm inclined to leave this as-is, maybe adding an escape hatch to
silence the warnings via an environment variable to give users a bit of
time to migrate.

Patrick
