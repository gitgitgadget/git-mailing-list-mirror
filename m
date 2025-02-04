Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A24CB5B
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652463; cv=none; b=EzZSQPnWrZOUsPa5V6zuwrLvx5YG9+gzrKq16UcHf2RWZ7DSj3aZgQ9vKr3y2i1NO+mgl2CcDQlxi9c63ohtJX7Utl7HERV57cZS7doJyxEgfXDb4g1lNnlrK1XSwdYiHucpvn2Qv+HFMG60B1SW0Ue5vHYILoVlyIvfI2++aJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652463; c=relaxed/simple;
	bh=Du8YTcOoIhA6RV5dZ+XOReozFnD06gGeS9rTsvuLppY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWhbPtvaZhWFobnXX1vED2l8f955NownJ/7XUwbORzPPItda/fiORPXXr9uzOAUSwz4lPrSxfcdZuX3Btww2nK1ZuNWZMjJFUJuu8UkpNlrnKrWL7wz+rbF5y3bas3kxClxY9pVOsipl1ML9VituVQm3B2amwtXf7Ng/1MEI2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R9KQV5rQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IdINdnd3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R9KQV5rQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IdINdnd3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B1D51140154;
	Tue,  4 Feb 2025 02:01:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Feb 2025 02:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738652460; x=1738738860; bh=tJfSvJHF5P
	gx5ALNnIisGn+rXc2bN5S/zKLRweIVQPM=; b=R9KQV5rQGX7YGTNUnWxMaN8g5R
	Tu6vcYEqxIp++F+WXiKOhOuNPluQkym71czd5QpipfRieV2+T2zl+Qt9pyL5dn4H
	mTkhvv21OIBs6A6GTEd9OX3o1du/JyC2tJdlYKbWp5ZwjtgbXBzqrLDgYDXEYTb0
	W11SESiCHLPHwt1ABmHN3ShSlpl91n7Wu0cpmCunD0PCpxfsKN/emO1DaVL4OiML
	xJn8+5QIrxouLa8x5elXqiJFUSdtr5iDKWgneDFhN9M94UZxgfWYK8AYKuBe+Ej2
	jXswqd6MffY2wTl3R8NfupOrjCLptNGtP2W5hNBX3DiimN8iUL5zcaA2YAQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738652460; x=1738738860; bh=tJfSvJHF5Pgx5ALNnIisGn+rXc2bN5S/zKL
	RweIVQPM=; b=IdINdnd3JpG4esJOs3+Y8A5A8FEGKOBJfVxggdHF5LQAt7v3koJ
	e+nKxB0+o7CyRcOCjMzX1bauMqoqKKZG+h5lyGYtBo325AOc5o39NejcqHQstTJW
	dK1WczB1b5JzyTRPcYXSIFcR/oZ5uDiXjn9mGup/NujSrwZTMhBvepWCyN4D+BlL
	+RRCEhj8OHnPLo5wpEZ0Nu9xmwxqY4VR52er9LzFUwooMa/dbUtH29bp2oQIftLP
	Sewbag4hgBKahuK6KEnDzbFcy2TlH48HjhryZteolJPiMvxjyC9yYjU5M1OIK0wD
	5wyXt72VXT7woVnIyHLs5/fvvLw2+JSxeKQ==
X-ME-Sender: <xms:K7uhZ6cQJQee1Jj9zvCLa0rtSqNxL8nP-H3LvnSu2EAV1nXcwC9c0w>
    <xme:K7uhZ0M9qMuLdKzIVK9unGJ9tpqGl-bcGIMZpaYROshedtD7Jz8UCkNOSjHDjspwc
    rTILuxwAgWQcbEREw>
X-ME-Received: <xmr:K7uhZ7if0GizG03WBVYhHpadPwBHLqURTVgtxntiVBv6dvS5DSxjvRn5C5u0d-ijpSvuTPz1OjENya2yhBQudQzEOMo-QZa3JRWrWGCJU3yUwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:K7uhZ3-91iKhHiZiWKmfCtEKGjEup8gFFiC_u1tt1oOOPisvHSV_Dw>
    <xmx:K7uhZ2uNBtN5j8aOsvCQrkieKlVCd2kQ_spK82WtITfCiF4nXcfhjw>
    <xmx:K7uhZ-H0YmY9s1lyMf0mU2cwO6gntsi9dfoBUVUUx3JPUlnoCqoSWQ>
    <xmx:K7uhZ1P7LdBjdPnqB3oMQLKP-VTm7GFVRYyn7iVha_lmCpZcw--RUg>
    <xmx:LLuhZ6K1BrKlG2k7wiDt513JSdGNjea4tkiAxkavTRkIdPtPiP3M1onR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 02:00:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 59ff0e6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Feb 2025 07:00:58 +0000 (UTC)
Date: Tue, 4 Feb 2025 08:00:57 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] t7700: add tests for `--keep-unreachable`
Message-ID: <Z6G7KSCAGKeHP060@pks.im>
References: <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-0-7c4d69c5072c@pks.im>
 <20250203-b4-pks-repack-unreachable-objects-wo-packfiles-v1-1-7c4d69c5072c@pks.im>
 <20250203183224.GA4183065@coredump.intra.peff.net>
 <xmqqcyfyzit1.fsf@gitster.g>
 <20250204023538.GB23954@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204023538.GB23954@coredump.intra.peff.net>

On Mon, Feb 03, 2025 at 09:35:38PM -0500, Jeff King wrote:
> On Mon, Feb 03, 2025 at 03:53:46PM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Mon, Feb 03, 2025 at 02:06:54PM +0100, Patrick Steinhardt wrote:
> > >
> > >> We don't have any tests for `git repack --keep-unreachable`. Add three
> > >> tests that exercise its behaviour with different packed states for the
> > >> unreachable object.
> > >
> > > There are a few in t7701. It's spelled "-k" there, so a grep for
> > > "--keep-unreachable" would not find them.
> > 
> > Ahh, good eyes.  Thanks.
> 
> I got to cheat a little as the original author of the flag. ;)

The file is even *named* "unpack-unreachable". I didn't figure to grep
for "-k" though. Thanks for the pointer!

Patrick
