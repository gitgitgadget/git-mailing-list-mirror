Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D851EABBB
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572170; cv=none; b=jnSCh8rYeuiHHkcCJuNZdhlHbxTzef93UpubzLmtq9eudILbxob7gWJkgxgnhEgkR4YkHiMnD1hpi8EuOBdLJEeOk/ru46s0PRnQKI930qAX3YeSKKIo5+dZ9SUBsFSNClAwLOpIuSGuKp4uQRW8ppuJlYFzfze5iW+PW/2SOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572170; c=relaxed/simple;
	bh=de47MwkaqsWQ6vGP4OSYTQWcN+F6s33GSvz0lGuNfpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH8CO8FnZIhMUJuJVL8fBIYblAi+EE5MQKu5ZenPENgvEcpLV1eXi4V9o0KyQijm62lSxrQnBhfrh+Wh4i+MRsEy+pCfow+u0Af/lrpRyENTtFRnCOoycQafvp0/bYZMkHM4dtThZBIrU1Z+GVNxiWCH9v2KxJw9quhRCS0WESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQLvvW6e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VUK3R3/I; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQLvvW6e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VUK3R3/I"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 997802540227;
	Thu, 14 Nov 2024 03:16:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 14 Nov 2024 03:16:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731572167; x=1731658567; bh=q6G7+sWnxk
	gRMXBa93lY2IJrXuozAZaELrKGsw6re7U=; b=EQLvvW6eb41u+/GngGRUEBUtmm
	idR3hBuga5dxoP4e1GTwrSLJ2yR3WaUB2IMPJ8vr1cO0kaYKoSCbO31mSX0xRj+M
	00AAfynKnSf8n/iFFYoMsR/6ah3Uz8VYpg8Y9rqeZO9KbTxEX/Fwn+ncbClc6LIr
	9WtKLNfO5Pwubl6hxt34LOoPX9N4VibfXf0ji++KtkdDA64bW7trh2qfwK12+zT4
	pF+13M5KWZkaTIButJyoKKfeQJ1OueEOMJCbVj8oQCrWziMlpuCSeMaRFd/AqbnX
	NYIMlMi2wc+gDV1VuRf7E022u0jVvFNUn4jP2a82U1rJKePhhB4KR5uqgiBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731572167; x=1731658567; bh=q6G7+sWnxkgRMXBa93lY2IJrXuozAZaELrK
	Gsw6re7U=; b=VUK3R3/IoVVzPowQlc+W1aKLr0sJUB3XwVSIueYaiVKyyi4eTcs
	AbkgvqdFd7kzy06TgWl83XFHuEidUYp8xuL5GrxVWJAAJ2L5x4V+SOmfGZt0mHZv
	Z8ANZSS16yG6ttMnJ0X7CuhbKNcIAwelX7b4vIMf3DEmdZPHPexVdjEcmZyBOWlK
	KbIDOuCbVHXoNwKbYRt1CyeASTTyFF+VGgAc6m1W5w32qMw5rgbF0+Z2JCmZO13w
	eJPDhanfewe80ORKwE63MaNaQy6/Xc96fNJ6w+Mb8ooBEyat+yCmAG74IWPYr47X
	Dq8JlIoH3Ku+JbmNSy9PMFcbLSeAn3WSTlQ==
X-ME-Sender: <xms:xrE1ZyvwapytAbsxLo6ZOKYj8_F00-ugqp1M8Ut6XlIUloz_rxaF7Q>
    <xme:xrE1Z3cA6abs30KCKJKaKM42QLHYWq0rqnvJNHd317_Gsdi5SXjCd4odaVOzBHKWR
    KwZyU0NhVaDTEjEGQ>
X-ME-Received: <xmr:xrE1Z9x0tP6upx_Kp2ekYdZx4e4ODL2lUn00RsfrlcAWNEB6NFzuzITHEekZ7yg9pWLUKVnSMr83zmCwV_Wc0HDEZB-iCd7jykrILaWCEKnD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdugfeh
    tefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgv
    nhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:xrE1Z9PVhlvIKj1SjSEE1R7lo-bT29DRFFbfv8kOCg8BH7OUymsALw>
    <xmx:xrE1Zy9hTHFoLlOnSkm8NmnXASGtfjGoqnj15lZb2JdZB8ELrLuPQA>
    <xmx:xrE1Z1U3ELeidfU6r4BfhsqKLw-NvILZQmM5Ay0bMvYbHQ6I_o5TYA>
    <xmx:xrE1Z7d-l66qxICnU_sVeIbkh1MCxmcWIkqkKNSpdYATTHzCxk_sZg>
    <xmx:x7E1Z1YRmWsXw0xJoKA8DqihdxTnDvD-KbZwyEAS0CQVM5_XPhtuxr-S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 03:16:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6cefa3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Nov 2024 08:15:24 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:15:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: David Aguilar <davvid@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzWxu-mFdVQqrqZV@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
 <ZzRvsOeLsq3dJbGw@gmail.com>
 <ZzSprTl5Z3uIx0_d@pks.im>
 <c323599d-f60f-443c-8073-0942afbcdc04@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c323599d-f60f-443c-8073-0942afbcdc04@gentoo.org>

On Wed, Nov 13, 2024 at 09:57:55AM -0500, Eli Schwartz wrote:
> On 11/13/24 8:29 AM, Patrick Steinhardt wrote:
> > Fair. I don't really expect anybody to use the combination of muon/sumo
> > for everyday work, mostly because the usability is not quite up to par
> > with Meson/Ninja. But there are two use cases that I deem important:
> 
> (samu :P)

Heh. Just double checked that I got it correct in the docs, but seems
like I did.

> >> Thanks. I don't want to be the CMake champion, so here are a few
> >> helpful/surprising details about the Meson build to help make it better.
> >>
> >>
> >> (1) I first built w/out having "curl-config" installed. I was surprised
> >> to find that "ninja -C build install" ended up installing "bin/curl" and
> >> "bin/curl-config" into the prefix.
> >>
> >> Is there a way to have the install step only install Git without
> >> bringing along these other non-Git bits?
> > 
> > It definitely shouldn't install curl and curl-config, I'll have a look
> > at that. But other than that Meson is currently set up such that it will
> > automatically fall back to the subprojects in case certain dependencies
> > cannot be found. This can be disabled via `meson setup --wrap-mode
> > nofallback`.
> 
> https://github.com/mesonbuild/wrapdb/tree/master/subprojects/packagefiles/curl
> 
> could be updated to handle the case where meson.is_subproject() returns
> "true", by not installing tooling.
> 
> Alternatively, meson install --skip-subprojects can avoid installing
> *any* files from subprojects, on the theory that subprojects exist
> solely to provide static libraries linked into the real project.
> 
> (In theory, one could have a subproject where arbitrary data files from
> a subproject dependency are crucial at runtime. I think the gnome
> ecosystem does this, hence using GLib / Gtk as a subproject "needs" to
> install the subproject too -- but curl definitely doesn't have this
> issue...)

Yeah. `--skip-subprojects` is one way to do this, but that of course
requires the user to know about it. It would be nice if one could wire
this up in "meson.build" directly, e.g. by passing a `install: false`
flag to `dependency()`. We don't want to install any of the subprojects
as we build all of them statically and link them into the final
binaries.

Patrick
