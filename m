Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2474F5BAFD
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736327; cv=none; b=P4jSdxZeHE2Kr2TbyfJDl4sCe0fLZyT1peX0PxhfA8rgUVKgi0X65tpwQhms70r0VedeoEUEhinxZOJkIJzXQjvj5/H5LCplZrgdlEy043OYSXAsh4vQUa2c036T/tninAqj0XuPUVAPbR9cL7EU9u81XzKWkCeXSW3t18jpTeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736327; c=relaxed/simple;
	bh=PQXKTGKP2gB6W5t9VuA29dMrHv6KytVWF8OC7FRb+BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULfWcHjr+1/Q1S1sfTa/kLB2YOX5GUL77i7Etq5lvfYINoxmsIxsvZnH1AiEyiD9CVT7FpBv7O4Zo7n0t69xi1JEAvrTykT7ifNbluJEhraAkZFsFq5xuusW0IW9nUte3ezH7FvyQ4qHM/q3CvXKgSU9HLQ+8DTYvxqjJJX68pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sxz0NHbK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fTCHnc+2; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sxz0NHbK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fTCHnc+2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id D30AD180009D;
	Wed,  6 Mar 2024 09:45:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 09:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709736322; x=1709822722; bh=BTlc9gs/KJ
	D44gso4/fXJjJKeLrr6/9TLpgqvx9CI+I=; b=sxz0NHbKVUUzmtbW9fzqaql30b
	qssPLXWJhuo1ToAEK15WMiAUaX7q6kGmMal0aFiSwDsbFIzhP3I5w4OhG+ECaXcp
	5OlQi14FDK10AnET73CvkWlWK2cQWEj8GQ4Blj8dAm6UictQdjqIYdwKeF1viS5V
	uH/j+w70fyykFp5w8gANZMr7xyBm4g6uWf003Xs3osOsKcK+WgPCdlbuGhZ0Tu+o
	lg4xX915oTPQoe4NP+KI0IIc8K85rgFhVivgPHo/RErLNHMpOF7BMPNdDdvmM64p
	eENxp6/kN/Iu2LTO3uKn4PEram5/S4qoqYENaWVGbl9W+Pa5lfYm2RsOJnRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709736322; x=1709822722; bh=BTlc9gs/KJD44gso4/fXJjJKeLrr
	6/9TLpgqvx9CI+I=; b=fTCHnc+2E7BPOI0130H16zfDjqnVbnu+iJ2pUJpPdtZd
	5dfRx+xTtP2vuwv/kESiQoce2JjMuyYjjCQgLCyIsDQ0FdSqx4t/gT7+M1fnhoTt
	imwhyraiGpgDZd3r06OpEfPYcv5XP56LtnT6mF1DPAB4y4ady+tOHvLEi+pNEzYb
	XltBc6b809ySeNR5Ud/WoCch/WfbO5oyXqfoSG6NL7v4mkr+Vv7tarc2TgBmK9W1
	McNXNEz5nWyuPT0J0+6waKT7cx3xOa4AojmUsvJLge4UM9RgY/TZj+sTQUjDVABX
	prWiQws3hj6pGMIuoQcHrWqcj9NyVe3kN2Yf9bG5uw==
X-ME-Sender: <xms:goHoZfvD3UO94npN8BUTaC3iDgsi25A6JrRP-SqbK4A8HLIytZbaFA>
    <xme:goHoZQcQ2sAPfqEda3iiSvW9iy9FxJdcJj12zEpSvYdoolc9Ql8hRfXhWKOuskL4K
    w7owN50hVtAQCPAuA>
X-ME-Received: <xmr:goHoZSx1E9fMWjOopKu9zykPEqP5ir0WdvkShao1KafxbhmxraHjkhkASIb0F3PEZXoRDnnmn0yEoasaPzIx8-o9PNxW2SqslIQ8HRHdEp9dTbWBhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtro
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepleejffdtudefkedukeeuleevlefhueehue
    efgeeukeetueejleetueelteelgeffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:goHoZePXAYDmtEX2gmXgJC2rsMh6Cx9WHL59WEllCbHzCz3TTW7t3g>
    <xmx:goHoZf-hRkSRXDCci1Zi7DBp25HuYstUk_Il_5qRJ1FptxPEZpiwtQ>
    <xmx:goHoZeWvmIGb1HtavARQXjToXgdWTj1wk8d618r4X2eUuRLobPD7bA>
    <xmx:goHoZRJQXjO6WeS7-anFuYVqpn_fmqwskKvZFOlXzwkfq5UQnLoiJZ8WAzs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 09:45:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 539dd86c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 14:40:49 +0000 (UTC)
Date: Wed, 6 Mar 2024 15:45:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Discuss GSoC: Implement consistency checks for refs
Message-ID: <ZeiBfVyTCHUywliI@tanuki>
References: <ZehtpMtxPLuYYmgO@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rchqevAP6EKChe91"
Content-Disposition: inline
In-Reply-To: <ZehtpMtxPLuYYmgO@ArchLinux>


--rchqevAP6EKChe91
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 09:20:36PM +0800, shejialuo wrote:
> Hi All,
>=20
> I am interested in "Implement consistency checks for refs" GSoC idea.
> However, implementing a feautre is much harder. So I wanna ask you some
> questions to better work on.

Sure!

> As [1] shows, I think the idea is easy to understand. We need to ensure
> the consistency of the refs. The current `git-fsck` only checks the
> connectivity from ref to the object file. There is a possiblity that ref
> itself could be corrupted. And we should avoid it through this project.

I know this is splitting hairs, but git-fsck(1) doesn't give us the
tools to avoid corruption. It only gives us the tools to detect it after
the fact.

> I have read some source codes. Based on what I have learned, I know
> there are two backends. One is file and another is reftable. I have
> no idea about the reftable currently. So at now, I will focus on the
> file backend.

Yeah, the "reftable" backend is new in the Git v2.45 release cycle, so
it's totally expected that most peeople have no idea about it. It's also
part of the motivation for this project though. Because as you noted, it
is a binary format that is thus not as readily parseable by a human as
the old "files, backend. This makes it much more important to provide
the tooling to detect whether things look as expected.

> I think the principle behind the `git-fsck` is that it will traverse
> every object file, read its content and use SHA-1 to hash the content
> and compare the value with the stored ref value. So if we want to add
> consistency checks for refs. We may need to add a new file to store the
> last commit state (not only last commit state, do we need to consider
> the stash state). However, from my perspective, it's a bad idea to use a
> file to store the refs' states and we cannot use object file to check
> whether the ref is corrupted.

I agree a 100% -- tracking ref states in a secondary database is not a
good idea.

> So this is my first question, what mechanism should we use to provide
> consistency? And to what extend for the consistency. And I think this
> mechanism should be general for both text-based and binary-based refs.

The exact extent will need some discussion. What's clear is that it does
not need to be perfect from the beginning, and we are sure to discover
more checks over time that may make sense.

Some ideas from the top of my head:

  - generic
    - Ensure that all ref names are conformant.
    - Ensure that there are no directory/file conflicts for the ref
      names.
  - files
    - Ensure that "packed-refs" is well-formatted.
    - Ensure that refs in "packed-refs" are ordered lexicographically.
    - Check for corrupted loose refs in "refs/".
  - reftable
    - Ensure that there are no garbage files in "reftable/".
    - Ensure that "tables.list" is well-formatted.
    - Ensure that each table is well-formatted.
    - Ensure that refs in each table are ordered correctly.

This list is not exhaustive, there may of course be other checks that
may make sense. Any additional ideas by you or other interested students
are be welcome.

For what it's worth, not all of the checks need to be implemented as
part of GSoC. At a minimum, it should result in the infra to allow for
backend-specific checks and a couple of checks for at least one of the
backends.

> And I have a more general qeustion, I think I need understand `fsck.c`
> and of couse the reftable format. However, I am confused whether I need
> to understand the ref internal. And could you please provide me more
> infomration to make this idea more clear.

You will certainly need to learn about ref internals a bit. There are
some common rules and restrictions that are important in order to figure
out what we want to check in the first place. Understanding the
"reftable" format would be great, but you may also get away with only
implementing generic or "files"-backend specific consistency checks.
This depends on the scope you are aiming for.

Patrick

> Thanks,
> Jialuo
>=20
> [1] https://lore.kernel.org/git/ZakIPEytlxHGCB9Y@tanuki/

--rchqevAP6EKChe91
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXogXwACgkQVbJhu7ck
PpT4/g/+N6rY43EVN8wHg9uZAIMDoj46b0yNpQsF9rw2T7W2HxIvAy1UmzPZNs03
v4eaRABER45j35/CXjFhRA7Q5KHFIy/wLvCh9Z39ZXkGSuQwa6I/MSaaefJbiODN
JMTbyiUThfeKXVQjteRdtYbrNv4W3UKsxAjNlcEbO94p+miOiiaPRQycG1YwIU0W
26USbXbqutnmhaiPnCYyNfl0AkEq2Dm+P9nJXE9gw377YmDR8ajXsjqkVIdF87k7
lfIXlEdtYbus9z/ymX22adW91bWP/iYNvhRIk/2ItnDCwk4eL3QVKAZfnrTnpKqG
zYN/yOe+Y3TVIqTr1nLZfLtdBf+8xlV7g8nxdffiMDwu2vGx8bnywtwc5JqScBzE
NV181UhHDdQzjnwoviFkjWIWVwOb24cOmYfWp4R9y61DYpMriWmLH7kxjP5k43+m
ODoFQlSNP8/0G4VAAuAdQ1G9g2Lw8ixrJRvesHyiVoO3FIZWlwiVA6B5jYTmArBP
iEWCb1furAVLYHSShDVI3OBs3+81cxK8ASLSISO5CQxFqBfIvs7ZzhMEv3tmpUXC
VrvW7zXnOfyl0FBGOHN+rGc07OEE1pO01bEdfJObSme2mLewoXkXVyAPsGg7ttxl
9jEVwxzTQv6H5HIp6j4h6D+E4BOFl7nWgSCVcEc//THNzGZgIzs=
=4o5F
-----END PGP SIGNATURE-----

--rchqevAP6EKChe91--
