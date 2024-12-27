Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939683F9C5
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735307929; cv=none; b=oTZiyuL9wSr37oPXcKM796/r6SompFVhKav3wnQaIOz9vDokNXScdnuT9Nn+H7PdzwHHHDPx3MYuHw3FwonGz7T6n5EYOOmIU5nqR1yJtNMV/TpG7wL8GvbhmGnP/ELRCKp4dhBzIvqDLsCj26cCtDJSK0vCYyNgCwRTFUMMcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735307929; c=relaxed/simple;
	bh=L9yDsGHb6UgVqkUrXyKZFybB/C/miRLCWrSKwd8qBXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYiCLqKhoGwXVVI+b4NYXH5qgX6Hl76eAqIQ95u6H0rxtBBXiYbN8gwDmruAUQRlYJVFV4rDbqQYRAw43XZd7Ghul4kPazGKcTjE0ZYgER0nmyI5QzVmUi/Gj8PapIdbsLM8pQWgRmm6qRKL8MEpMQH4jnBKYDd+9EUMdum0osg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q5OEb3u3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s/w2Zkz1; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q5OEb3u3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s/w2Zkz1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id A02F211400D3;
	Fri, 27 Dec 2024 08:58:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 27 Dec 2024 08:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1735307926; x=1735394326; bh=uWhboIpJlO
	6Q3cx9zbixo7ugtxzwx877Nv2XNBmaRJo=; b=Q5OEb3u3IwoON+9QqP0F1/lP8x
	Lsdph+xrwvjUCkZnJVAZd5jgP6uLPvgR67lStnFUHr0CYOMI6aq7lSe/KmtQXWh6
	qLRgqC35N5F2MFe1/OS7cBkguohklShpdX3rDOdcO+g/z7jVngs9AGhY8oQNyl/m
	IHWm+lvf41CXTuXjacX4QDLmIDzNt7KYOoNH3ajJ+LHa6zzy/IWyUyFFhir8L2qF
	4+dJQfKx4aSYvfLIqLBOuubynD3AMPf1u0ubuIvYZV5IF2QtsYSIwUzdsbucCwHk
	U9Fy8XCDVl3ShQBiV6MoE7gjUcpTl96JVwp0QK8YhaUuh9a+rg7MddBfTdZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1735307926; x=1735394326; bh=uWhboIpJlO6Q3cx9zbixo7ugtxzwx877Nv2
	XNBmaRJo=; b=s/w2Zkz1bLF7bKZW0QvlU3K8a5kS3p/kHfZqX/NvZaNZH6BxagD
	ZlOKetrsjzhobbjRVdAKen2CdQNBXuN0Hk3HgOkTcIeHhq2bt8BsxpaU2GcuKQd4
	LS3Yfb3vogwA2UtnEMcN2nfSrUeiPfaF+v5BEkSlsB3GlxGxNjtPgcoQ/RmP7rRw
	0dsquLo3FN8F8jk2KJYv1CUb06F66ODPBRDUKJvidBXQ0Lc9szIyH6WxivzaxH1H
	NVvUkfmKP2Hmf1TE+z5STJv/00lu7Gf7eL6fxo/1fSAyxTD7RGkhtfWXGj5njyEK
	Ny2wAOf18hPA/npGj1WPFtzo+ItueRdEfvA==
X-ME-Sender: <xms:lbJuZ4EsVbMwVc27Lnsagk-6G6gEqiA-6cHMxKkRX5Ev3XElLYV3ig>
    <xme:lbJuZxX1IQ7QKCIzn4bcTHbz8LcTXGYa8Ek6hU-3KA0vrS0qEL1B0H4rph5sojUeV
    N4ZdJovUvzBrItKFQ>
X-ME-Received: <xmr:lbJuZyKQYqPAXouKEmF3wVEqxYiz50fYDFiYLNFEIkJkyOfB0pkvAm8MzbUCRNPPR2haaBuP3EYhyV-Ha7C2UJPUzJ4A1M_ZOZkumNo5391NVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:lbJuZ6FWsb4CbONWf6-8uapu8M4zTMY2-IdvKGdl-pVmDbTCuitXeA>
    <xmx:lbJuZ-VMBjzGIbY100CVvhsYKBrx6k8XuW_51MCrcqccuSzh9e9mRg>
    <xmx:lbJuZ9MXxzEPwYzpZJfsqD87kN8fFOohF3nMru4M2__kgj9xE92kNQ>
    <xmx:lbJuZ11ITnTICKW_48_20Wmx-19Q6MBZMTaoIAYOBWA0yWqkhr1A-A>
    <xmx:lrJuZ7gxdrsuWCq9JY26fZrKfoHkaApmbltNA4N-TzAIyselYGWDFAGB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Dec 2024 08:58:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b718f77c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Dec 2024 13:56:41 +0000 (UTC)
Date: Fri, 27 Dec 2024 14:58:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/10] meson: wire up missing HTML documentation
Message-ID: <Z26ygb_4-DP7Ufab@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
 <87wmfqfwh1.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmfqfwh1.fsf@iotcl.com>

On Mon, Dec 23, 2024 at 12:51:54PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Hi,
> >
> > this patch series wires up missing HTML-based documentation with Meson.
> > This includes a couple of missing manpages, the user manual as well as
> > the random set of articles that we have. It also starts to generate the
> > indices for API docs and howtos so that the result is a complete set of
> > HTML docs, same as with our Makefile. It also fixes a couple of smaller
> > issues I found while working on the series.
> >
> > Notably missing yet is an integration with CI as well as sanity checks
> > for any kind of missing docs in Meson. I'll work on this in a separate
> > patch series once the initial CI integration as well as this patch
> > series here have landed.
> >
> > Further missing is the generation of both info pages and a user manual
> > PDF. I couldn't find any users of these anywhere in downstream distros,
> > so I decided to not care for now until somebody complains.
> >
> > The series is built on top of caacdb5dfd (The fifteenth batch,
> > 2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
> > build system, 2024-12-06) merged into it.
> 
> Hi Patrick,
> 
> I've been reading through the patches, and as far as I understand it
> makes sense. But to be honest, I don't know how to use this. I have
> almost no experience with Meson and I only know `meson setup` and `meson
> compile`. But the `meson.build` from Documentation/ is marked as a
> subdir() if option "docs" is given. But I don't understand how this
> should be used. For `meson test` there are some instructions in the
> root-level meson.build, but not for the docs. Should we add this as
> well?

I don't really think it makes sense to explicitly point out every option
that we have. We already document how to discover and set options, and
from hereon it follows that you can wire up docs by running for example
`meson setup -Ddocs=man ..`. It's just another option, and as such it
can be discovered by running `meson configure`.

The benefit of this is that it cannot grow stale like the build options
in our Makefile. These may or may not have documentation, and may or may
not be stale. With Meson, every build option is listed explicitly, has
documentation and is discoverable via `meson configure`.

> And a bit related to this, I saw you use `env: script_environment` in a
> few places, how does this get injected from the root-level meson.build
> file? Due to this, I assume it's intended to only use the root-level
> meson.build directly, and not run `meson setup` in the Documentation/
> folder?

Yup, you are always expected to set up the top-level source directory,
not any of the subdirectories. The build instructions are then processed
linearly in Meson, so variables declared before a call to `subdir()`
would be accessible in the subdirectory, as well.

Patrick
