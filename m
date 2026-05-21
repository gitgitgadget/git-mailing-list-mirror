Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C019DF55
	for <git@vger.kernel.org>; Thu, 21 May 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341966; cv=none; b=mcLaCkEdt6lxRMP358DAsFTt+Qa+NzpLZLZwZneHeTAhBvKthp8P0gl3L2tUJCjRjgDhrslavpFL+ifjzQttU3g/PTV4g+QpUBoChMAgrUKxgXnF0uiU81IiAA0FI9+pX2dOANWpk5F+jtCZxfdwV0hDNiF1Dt3mSNo/nqV/Fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341966; c=relaxed/simple;
	bh=XaAgs8eKYVb+xnuCTA+CfDmwh7OLWWg3dbr1RLdi8Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQrdfllcHtX+OSXqr43iIGdQ3gqfxzUxy7i0Q/+fEzxOuWAaEyjCO8eMTaMSyJUiLluPF3kBrZyN16pdVglOntM/40VO5EKlVXzlCenQofqeTxOCYEp7Vq5S8RdDhPWS349tD7+1+JPrTHQOC+hV05kmUixh9/HPCYCYxYYmnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SQrmM7eL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uem75X1J; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SQrmM7eL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uem75X1J"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CD40EC0094;
	Thu, 21 May 2026 01:39:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 21 May 2026 01:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779341964; x=1779428364; bh=XaAgs8eKYV
	b+xnuCTA+CfDmwh7OLWWg3dbr1RLdi8Ro=; b=SQrmM7eLVw9NzMCCPbLq7t4dCU
	YACXYp4yNO4J4X2jt7Tm0x54sWDo9UfEdOy9zHTCROm1P5AKP9VMKbnYtRCS4Y9F
	ZCHRLBZLh4U5BALWmRGPGvEUk41dDbuWHOOfIzC2ikgsp9DDHZAiYZqpnK+aUZn4
	Cw0olUf1rQr0zbEoZjwgB5nv2eGQ1/uVF5zO+RNBormqJ95QGChpg+cFO1YrSMVd
	5nyK74I95tBFKFbLhd/rOMMtktL6vMCJdNfjJWNiwGHoqxSCv8rPf+Teu3E+Mxaq
	l2GYY2hE6y3R3T7WQ6AfgPW0Joqu0zgCA62IepJ+l+8j8n4oIxTW4jWjeMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779341964; x=1779428364; bh=XaAgs8eKYVb+xnuCTA+CfDmwh7OLWWg3dbr
	1RLdi8Ro=; b=uem75X1JJi9QKTClVnrdoQqXFZsoN5XXRMU0pCnTlKzAjHF6x8+
	gezlINCUPyzsqE3sSJRhS2Y4jnTk54MBzrjFjkhRgF5D0R38kjaJeQjHSQGfHFCC
	a46m9Nc6Ikl7uzlRXOnP+fVwDtgo0dvINW9gL70EDe5sCr9ggkZHkCi7LZxDdxH8
	x+hOgw1KQzSdk7o9zwEAQzg8KLtCKyzKiBEO/UBaaT6DDsMW3WCuTlUNPfhS8UP9
	k6TiJ3qZB9c6RpqY+F4YR/oCC+4ts/M+qlQmVpeqrTuM0cidyndJ9KoKgYGj5skH
	bJxG9ip2Y2nfT7dpGTEhyHnl7XznD5ed7Sg==
X-ME-Sender: <xms:jJoOamzA6T0SPV_nC1ZlH7lNu8vnDS0Rb57VbNJZ9mxfQwg-FsvDpw>
    <xme:jJoOakj6xWlEx-vH7_Um-X2rbj9dzg7hfvfRjplq_wyuOhL6Js5PFsi-kA6ksJ4Zx
    X2WZ2oB8UMJmY3XGjIms9_jhij44AeQxppUN31dYb9BjRZOeLz2>
X-ME-Received: <xmr:jJoOaqkczP3U6uUt332dgNITcJTvj3KV9tLT4MX-bJz21dxftTmJs20Q3ISpNudHtTP0fxcdO_kNBP0QR2v08gFn8lXX1b634XjUSputmoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhhikhgrtghhuhesghhmrghilhdrtghomhdprhgtphhtthhopegrtghtihhonhhmhi
    hsthhiqhhuvgesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:jJoOaih4I_qmEAmeNrgA9fMzNKnKe286rA1Yuoy1tEbAx5KH9lqhcg>
    <xmx:jJoOam3tohti9muOXurP9odh8XiPhlGIOTlD-roDpukph6jEr-SPbw>
    <xmx:jJoOajJleN5iloa1mKCOsEQu3QCBKf7KypNrIFIgP9GgZXY77CxYXQ>
    <xmx:jJoOauxdIP6YpWbEl1sZ4noC1Fjv1xlWLb90JQsUzty_RjthATrtpQ>
    <xmx:jJoOahi4qfIxMUPh8k6wUlGy9GNKiqICjcOQEZ1Oi7UcSpxVMfZG-S0b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 01:39:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87d2a038 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 05:39:19 +0000 (UTC)
Date: Thu, 21 May 2026 07:39:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jean-Christophe Manciot <actionmystique@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] builtin/maintenance: fix locking and respect
 "gc.auto"
Message-ID: <ag6ahXA104_70g3e@pks.im>
References: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-pks-maintenance-fix-lock-with-detach-v1-0-ccd7d62c9a40@pks.im>

Hi,

On Mon, May 11, 2026 at 02:29:54PM +0200, Patrick Steinhardt wrote:
> this patch series addresses the issues reported in [1]. The series is
> built on top of Git 2.54.0.

Junio: I saw that you are starting to prep for Git 2.54.1, and
a89346e34a (Start preparing for 2.54.1, 2026-05-21) explicitly mentions
a couple of additional topics that should land in that bugfix release.
This topic here isn't mentioned though, but I very much think that these
fixes should be included.

Thanks!

Patrick
