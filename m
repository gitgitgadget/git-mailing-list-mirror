Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274F85260
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756051405; cv=none; b=iyxzMQMq9/qO+E+EuQ+lYOF4qwF3flBiIscxy5abJfbRpFbTHwsLCLPEUvrgEcwzBn6g2OZe3RzngpaPwDp7UHjTwJq4ZhnlnYzyyHPNa6Ho/OsRjwo2w7sepkXApj/Kw8ffR6DmYRKo5TTtzrt0DhIxWoDsQSHBmzcPXsjHXjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756051405; c=relaxed/simple;
	bh=9THX/HjpYlH4hFPntcMv2IYleQ70TnoF3uAsDpGAnkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf3dIE2d0ZBUm7mFCbGMc00aUnXmRN1LofJ8tUVP0YwLCm9pdkmXmFZuXbPzIO4aulD/fvP7qww03MDVolNZN/Av/aPITgF0pqeC2x6N9GimT6HLdaWwj4pysuNenRdVQqH9nFImRlQiYdKgH1qpiVrTvxKb4pjtUGIEBRkizs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c0ArH34V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YcCO1SrY; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c0ArH34V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YcCO1SrY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id CD3191D0010E;
	Sun, 24 Aug 2025 12:03:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 24 Aug 2025 12:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756051402; x=1756137802; bh=VI6Rgxv3RZ
	b1DzGeEjEdbsPKiqmaLbIzLa79d5rFFrA=; b=c0ArH34VdZN5W5UuSj6qXds7PO
	VtmccO8Lstxr8Pvv66TzCiH15vGhcCCD+z1+4nOiCyr0XXFRJQleYh2waKwKrFuO
	oDbAmttKIEkcU9DTKFZq/v2V3DEdLP3cnI1sfp2pamFJVCz40qOBC4/UfKDxw2+7
	EbNFKIIoYBOGCmyg6RqYe7+EoI7mUP6YB0HvraHWpwc0KJda9kvqd1TgphprFHsX
	Pk1/r3/zl87XocUvpKfddbKsbbAzCeXbZslxNEKAVga3H7K3vEzEX9pIULaeOZ9y
	lG4MRTG9+k6/iYN+/q/HJLX96VdH2M1ZhFT5LLo6LMywZk5E1EnuRjNwLkdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756051402; x=1756137802; bh=VI6Rgxv3RZb1DzGeEjEdbsPKiqmaLbIzLa7
	9d5rFFrA=; b=YcCO1SrYX+2NI7me8QIyBzVQKJHQu5LTReeMxbfaBR7MDYA8/rJ
	gk9U2QTon1yafmKPji5Vw6z3NJkkyCIXqk6yw4qiuos2wyuNOGVso2bF1Dcav55M
	whdxfaeiCbMxjs6Yvqk2AaXbrhr2aln8tUosHj1HL+WXhqkYNy19T8EmN1I/HxoT
	YkhAnwKWnLsiRtRnFWcB4kzPGb0+sKnWzhorsBucWT2BAkxFDCGl+QuK9fByRX3r
	WTo/5xp/n9uOIySYy3lP1oL6fQg1vhwA1a8r1pdv+w7skyhRYl2Z2w4wHz4ky+ub
	zw0h7GnAui1Qn216zCh8tUNBOx7ObQMaThA==
X-ME-Sender: <xms:yjeraK89wbDFFHvcXJQR3eshBzSrwDm9xpjMKq_-Nge2SFP9KYLAXQ>
    <xme:yjeraN-FhLPZjtC45xWhuUV02oZtSgN9C8xNkh-wpmmJdWApMzTw953B-j38Yjzpc
    blQQ4EaLoCAptZIbg>
X-ME-Received: <xmr:yjeraJfdETQDqoAv2q_VAHkkIknKfRFBWBjJh7qaT7gP7j1kkFPtF9wezhtPESa4Yu19EmGGi_4T-Sl8EKU3-w24aRNllYY_q81N8zJK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieelleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:yjeraOF-RtzFEqlKTqCyZRPvAR1Bif2YTuEsoEMDxA0O4LZKubCQQw>
    <xmx:yjeraPes_z-gxNVTENoDGLauq9i4favEWvvfYsJA4lOaOdHr29fLHw>
    <xmx:yjeraAGZyQgHf8xKc7ovDEsdNh82XSudLI2IcvsIEBm8bmN-EMc4dw>
    <xmx:yjeraAXMZyu65IH0QgYwrzg6XDsAf_7gqqzxy73TyYcNZF1dVbxxlA>
    <xmx:yjeraClnqBWaOskjJxv06nTDwhkOcb71FjJvrFpuyl-cH14fnrSs9gm2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 12:03:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5ad8a778 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 16:03:20 +0000 (UTC)
Date: Sun, 24 Aug 2025 18:03:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH RFC 11/11] builtin/history: implement "split" subcommand
Message-ID: <aKs3wnuzaObmf_PS@pks.im>
References: <20250819-b4-pks-history-builtin-v1-0-9b77c32688fe@pks.im>
 <20250819-b4-pks-history-builtin-v1-11-9b77c32688fe@pks.im>
 <CALnO6CBuwDVMZ-QTay+PUiXKsWMsABJcs1pAB=uUXf7-DJ4Mnw@mail.gmail.com>
 <aKhg8q-AAlsGDvFS@pks.im>
 <xmqqplcnw7op.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplcnw7op.fsf@gitster.g>

On Fri, Aug 22, 2025 at 11:08:22AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> Interesting. I can see using the original as the template for _both_,
> >> or the first instead of the second. jj's split works a little
> >> differently (especially with their notion of descriptions), so I can't
> >> use them as a reference for the behavior.
> >> 
> >> I suppose this is one of those "everybody has their preference"
> >> things, but I think giving the message in both new commits as the
> >> template gives splitters the most information available when writing
> >> the message. (Of course, in my editor, I can presumably do something
> >> like ":Git show -s <split-commit-ish>" if I want.)
> 
> In other words, removing is easy, while remembering and retyping is
> harder.
> 
> When I split an existing commit, that is almost always because after
> doing too many things in a single commit and the time I realize it
> is when I am writing the commit message.  So I would suggest to give
> the same original message to both, to avoid losing information.

For now I'll rework this a bit so that the editor will list all changes
in the split-out commit, similar to how git-commit(1) does it. That at
least makes it way easier to see what you're currently changing. I'll
think about this some more though.

Patrick
