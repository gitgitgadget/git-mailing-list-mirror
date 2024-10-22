Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BD1A0718
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605368; cv=none; b=Z5cPJVblTFeX9ROTlIDB9z+CV3LBMV6k7ArH9mF9kMl9umOYT2pZLYebtnxHEnLdJpmh+gFIlYAqn39jDwPO6MwKZzWPLRS8f682IOca0FiR2q6FxnE81wdE51Wv44rNnPX/MR9GF0o1eETkOJWNPwNMW8oqhlO/Jy1ErKnEaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605368; c=relaxed/simple;
	bh=k+J7LStBJbzbl195k4lecdIFo/pGfL1pCJHZ5OSCO7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUybhViggSqVqexPdaQ2d6h8Agi9I9RQ3t87Jgu+kIoce9w7Y9Iz5SZQrluMyDxLh/8ntCjwyuDG2OQ4z9VpFjXRojzHC/jgUAhBCHENZH9rtstAonilCATL0do2vLSGyzNEpWXfH749842jnz8kseiqzwsDHz6gYEg2+B5v7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=u5c5S974; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glwdK06E; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="u5c5S974";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glwdK06E"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B57A71380236;
	Tue, 22 Oct 2024 09:56:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 22 Oct 2024 09:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729605365; x=1729691765; bh=k+J7LStBJb
	zbl195k4lecdIFo/pGfL1pCJHZ5OSCO7I=; b=u5c5S974oobL7J5lEqwBWlrWOI
	ujVeb6XAQHYGFjCxZhkf/EtjEv5qN7GBQzYalOKCFtkV+RKD+1TcVW6LVTtDda65
	MlFZaZcB4GIuKx7T+BkDih0z+awceYTMwY8vBOn/i4pt2Gl0vGYyiMcflb1SWcmr
	a0AXQcTVeqq96XQpAgQq9lWcV/yqWgCejBnwOrPFw0FbbIw2ql2LCaKIxzc5D54B
	S6lbg2UoZcfyZN7NLbJTTxLU8ia8c2FQsqQMLvB8bJV4EAtWHP26GpF2eZaYZAO6
	Krl1SdOom7viQEUQUCC9y+T/os2U4mx0lALynDw8fg2oVvwjbz0HCshK1CJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729605365; x=1729691765; bh=k+J7LStBJbzbl195k4lecdIFo/pG
	fL1pCJHZ5OSCO7I=; b=glwdK06EjwyD1lBtgxbZvPdlyaSdYGbIdPrRqPT8S1WA
	7uoKwt1OFa5UgCECDU0MsSglcyqVL/XoBa8j0JnIzkeT0QuHi0TCUVFTgeeoTzEt
	A2LrSCOl7WMg64iWKM2pUUF7v5YrB5dbsfjgbwY9w72Z5sunGAS6ZWjKWjZaUdmg
	OyjdqMEkH30UrZin97d+cls8uyJUbAyqrYrlk1bguageLywxmBFuRI41SRgDh9Jh
	KixkYZKgTIcbehr8l2ll359LtXcOLfcaI37PT6dWaDamMBgnDO7DinOqhCr0MwUs
	Jr2K+qSGhBbWu/QgOwMgo/EhRYd3RnWGG+MeYldDhg==
X-ME-Sender: <xms:9a4XZzOBw1lqPkdrE3SQdOUuF_nNOaCRHuPhaCZjJNBkCeyhJnBkrA>
    <xme:9a4XZ9_wS3teBBkCc2udF5pF_G4yRmU5LYOUS0eeXU6zwmuWsHr9mxxukzhG2mu7i
    a5RKml9AD54s6YWmA>
X-ME-Received: <xmr:9a4XZyRBsiDg9TnB0D7MdhbcMe-Nvykd0m4dB-3YwP8a6EI2Nr2Kaz8R6QGHdVucYJjgPpDsfrLK2w7K2X5rHwLe8ecTwLzz9rUdVfc3RW5l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeihedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjeevudeggfffffeigeethffgieekveeffeehvedvgeei
    teegueejleeihfeitdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhgvsehfihhrvggs
    uhhrnhdrtghordhukh
X-ME-Proxy: <xmx:9a4XZ3uAf5wXHOxJM-fjUjhEEJ2B--8S4yTBetkSjuszYTzD7sW1jA>
    <xmx:9a4XZ7f6X4dWxuuFHe9fxpjkhPa9jL3q6XgRay53rQmQG0nsR2rCTQ>
    <xmx:9a4XZz3GuDJECkkj3NqIDfQ7g6jKQ6KlV_A3PzJy4dQ8XI8I7gn-jg>
    <xmx:9a4XZ3_HoLMvnbcoMrD_8UwZv3ZGi1_1SA1xq--yeWU0cF0-gXbexQ>
    <xmx:9a4XZ8oHVbJCMQyrqrlHeTWpWCurqNvBMu_IuMTCAQf5edRx4y5Cta0c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Oct 2024 09:56:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c38309d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 22 Oct 2024 13:54:31 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:55:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: git@vger.kernel.org
Subject: Re: Build failure on RHEL7 with 2.47.0
Message-ID: <Zxeu7GbcXa-kOzLf@pks.im>
References: <CAHbf0-GMV9VS7BAjvZiNENNOdZqV3jQ4+0k1kTZLkQhFT=6D-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbf0-GMV9VS7BAjvZiNENNOdZqV3jQ4+0k1kTZLkQhFT=6D-Q@mail.gmail.com>

On Tue, Oct 22, 2024 at 02:04:52PM +0100, Mike Lothian wrote:
> Have I done something silly or is it just too old?

No, you haven't done anything silly. These are all getting fixed by the
patch series posted at [1]. I'd be happy to hear whether those patches
fix the issue for you.

Patrick

[1]: https://lore.kernel.org/git/cover.1729506329.git.ps@pks.im/
