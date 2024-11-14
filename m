Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3E146588
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731572168; cv=none; b=WyCAm4hBvDTAXjOrBO1LajNA8x2TLw5ZAamrfKnb0iJBIjyOIHW5fJ2M6gFqUyfrxVyOX1IZi0XhJYjNOi2f6tqeKgNaxLjKOdwPTqB3JFadSXkS1m5fkdpgNbznxrvr/5dWy7DhkCw0E8UV4PqZsqMTD8YgguEDzkZU99GpXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731572168; c=relaxed/simple;
	bh=7biXX6uwtyI7JEUok/UodM3UeYZ6/CZEs5DJpUw8yrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmK7Qmzd0XZO7/T+EV+2n9wd7+uSdE1nQZaoP4mNjqhMseTWE7vapjWVE82a1Z+tcCEzeTZb1NnZMyGhYRAh0HUHvfRi1wFYAU1Xpc//AU2KmmdD9beJKSqvwkmz4UdwaoWsMcqjFjqOYlLSL79OtSncgJsJH2j9IPsrd3C4GTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=3A7vBWn0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fIGPlaAQ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="3A7vBWn0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fIGPlaAQ"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A018254021B;
	Thu, 14 Nov 2024 03:16:04 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 14 Nov 2024 03:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731572164; x=1731658564; bh=riuBxe37aZ
	0lexhhoj6GF6t8VP/zAFVmea9kbLuAW1g=; b=3A7vBWn0ohTvd7tk8HODN4i63S
	4SL7FqlldMHbJBgeGfBCNCQxLNjT/UFZqznZ5j2wuyCxI8+TGVrTb6yYD7TuTW/K
	EK5ICY9zyryOh/lIcOI8JG7N/YXFXo+QUvRTvZZa6jAM9+tkJSS5ijxl/yBLVzt4
	l2Mbp3siZEdKS8Q6aw4bIcBAgFtffV6FjkllwYUcvjkNlAbExsrgGltX+PPucXgA
	wWRlUF5Z8YblfX8+IyW3VafoXfHJV49Z5Soedbm6JdKi3SyWefQHPyNAtsXjx6yi
	z78h1a/F1LEzCYi5kPoDQaYs8eGJtqVIhxXV8I7zC9r/6RVJRQlwpy5u2jVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731572164; x=1731658564; bh=riuBxe37aZ0lexhhoj6GF6t8VP/zAFVmea9
	kbLuAW1g=; b=fIGPlaAQiJiKmASKW3XR2KL4nC2IEXxh/HuPVy0WEabsQ/bQBIa
	ZP/28L6Mv6kSWUwpJFShi6jprTzXPePrCQy7oFePA+z15Q1mhwy3LBp532ye/sBP
	ep/r+sAK8BeHpJyeXpyZYSAJnfZdfYqidQvtgEiTTNUQ27dlm7qfa/sFxHEGfPG8
	hoIVA3bCkYBdIF9Bq0zssHYs89DqGXmJ5pNa8So9NefYaGFD4c6GWBFrPLpLJE95
	PqlPvZGb/s69iE5Mwsukz7QUUytejspeKZXtoCYG90KdS5SktQo1FjhzwVc+6YBE
	7j2gSz2wdZPPJDU0JNtpOSzbI2e8BG1x5cA==
X-ME-Sender: <xms:w7E1Z5W-N2R8dIRv62VZzdBSsxZ8AT_WD3vgAYMbwUEx_8rzUGN0nw>
    <xme:w7E1Z5kfSPDszbZwEwb768TXMee_-wdPXSytkKa9q4UaZ95DaAALtBtYUBjW6F7qL
    aTmSs5qjCD5xwh1hw>
X-ME-Received: <xmr:w7E1Z1ZCheEsh5KesNGGELTnhh5q69hTZLFcLWDQYpbb6KiY5rGIYCFxkYANu5bk0ejRSn1GzSvRHuLRApyg8rQjU5ssmdqTWkjBRC5J-Bgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehrrghmshgrhi
    esrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhi
    nhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvth
X-ME-Proxy: <xmx:w7E1Z8Xugb-hmkFtRF0vHQpKznJayDzaP_TA53PNe1S3Gi86blcDfg>
    <xmx:w7E1Zzlst3ZaFFcX8_Fp46YUpn4tNKyZTAzUvRmuIVNwRjPUyo3bYQ>
    <xmx:w7E1Z5fmxgogPsk4nRIujN9nFxvqU_D09-3Ul8-KArXy_pD6m_70uw>
    <xmx:w7E1Z9FprUFzVtWgkuuY9vrGeLs-biSaVy-ku_Fi1QRxi8fRLLPTgw>
    <xmx:xLE1Z8hKNNJQqi8bOYVxddR2j_vq3G5EgRgZFleDxwDwOI3JpLZyyzhV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 03:16:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 855c0a69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 14 Nov 2024 08:15:19 +0000 (UTC)
Date: Thu, 14 Nov 2024 09:15:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: David Aguilar <davvid@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <ZzWxr0R05hjsksMp@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <Zy9ckDezMSKVA5Qi@gmail.com>
 <ZzHeMjqUjzWpdX-Y@pks.im>
 <ZzRvsOeLsq3dJbGw@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzRvsOeLsq3dJbGw@gmail.com>

On Wed, Nov 13, 2024 at 01:21:52AM -0800, David Aguilar wrote:
> On Mon, Nov 11, 2024 at 11:36:34AM +0100, Patrick Steinhardt wrote:
> > On Sat, Nov 09, 2024 at 04:58:56AM -0800, David Aguilar wrote:
> (3) Not all of the same files seems to be getting installed.
> 
> I don't see bin/gitk or bin/git-cvsserver when building with Meson.

gitk is intentionally committed. git-cvsserver is fixed now.

> The share/git-core/templates/ directory is missing completely.

Fixed.

> git-gui and its related files are missing. Perhaps this is
> intentional/todo at this stage and hasn't been added yet.

Yup, this is intentionally omitted for now.

> Meson installs bin/git-http-backend (symlinked to libexec)
> but in the original Makefile this file only exists in libexec/.

Huh, true. On my system (NixOS) it's also installed in 'bin/', but when
using the Makefile it indeed only ends up in 'libexec/'. Fixed now.

> The contents of libexec/git-core/ seems to be missing dozens of
> files compared to the Makefile build.

This is intentional, as I'm dropping the dashed builitins. Git does not
need these nowadays and resolves them internally anyway.

> share/perl5/ has a bunch of extra git-{cvsserver,send-email,svn,...}
> scripts so perhaps this is where some of those files went?
> The Makefile places these files in the libexec/ area instead
> of in the share/perl5/ area.

Fixed.

> The Makefile does not install share/gitweb/static/js/.
> Instead, it seems to mash everything together into a single
> share/gitweb/static/gitweb.js file which Meson does not install.
> Meson installs separate files in the share/gitweb/static/js/ area.
> Was that intentional, or is that just another todo?

No, this was unintentional, fixed now. What is missing in this context
is wiring up jsmin and cssmin, but I'll leave that as a todo for now.

Will send a new version later today with these fixes.

Patrick
