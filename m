Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA037D401
	for <git@vger.kernel.org>; Wed,  8 May 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176516; cv=none; b=PDv6DoGxPlW5WE358mUSivNPbdFVhNciW57AfqXgqrnSBZL4XZwos3iFnUWHKYL8X1MYN2aNhO7iQI2W7c2a8Z0xO+9qvigJ1814EXEQ0rPfLvXwo+PG8LPpSZ0L5Pd/w7hdUnRaH6Qzn/1SoZHs/YveCmBm0HEm3Vbm57NMgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176516; c=relaxed/simple;
	bh=Pm/WwwJCJzc4FFK2qmoVQLuChenEoJmpBBVQeq6ePhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iurs3l7OeWQqXPPV+Dl+TrkiecaJlhqws6R8JsLuqcca7+2v5JJGWcFK7Ueeu/IoA0PnMSAeAUz6lx0n5esR4CKV5K6DXB3PyYaCcgpv7Xx83MhTELxqginW3rz3pzwbKJ2dFSDSXljF6hlkkQUFy3m7x20WdtBLUgRf3T2zvvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HSjh1wJN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkF+nyvb; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HSjh1wJN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkF+nyvb"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4704D13803A2;
	Wed,  8 May 2024 09:55:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 08 May 2024 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715176514; x=1715262914; bh=RUEkKmEnNw
	B+LiZxTlnXYMYqbYmkB+U14DMqFmlwqmI=; b=HSjh1wJNtk+WUyYJq8kPkqt3sN
	w+IPdb4Nh8kE4+H7q4V7YRPwZaqvNlR5y5I7MdFAH2pLuIt2Jujc9dZQzCevMcL6
	G+GV4faFKYlqzaLQf6yp07+zqW9YVEp8nTsy5KC/I9hvJVk9X0hRxQAvKwQUXKWG
	W5CGrXrxiIEcQXPZAkI8P6AIZxa0GmeNBW3xg67pta5Dal+9U3W6hAEtmXXd2OVw
	ta7j49N8LfLJfW50/JdSYh+tb+Bx/mlRCc24wO24k/igfh4Dl9eUqQYajjCZf4Uo
	ui1RxA151AwLD8Jh5m//dRXA7oynV24u0BS52PkTnbkAPzPRlRnm7ezTYiFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715176514; x=1715262914; bh=RUEkKmEnNwB+LiZxTlnXYMYqbYmk
	B+U14DMqFmlwqmI=; b=BkF+nyvbLP3nEpDG1Ih6T4Wl6ZiEQB2hJrIDacjieDdK
	UauW5MvACAVLtbcs+g+Rhoco0ZVgtKSpJ7T1RMxPbSrwnxg8O6FnrwJ3mMuDmRe7
	tKFNt/sj1JuMDu8VoJvUekgB7hdKx1OQgLfgR0ylDVNj0UpQztwb+N2J2hnd4EfG
	TzD8OnVwziX1tr+GLMmmcx1ENJCs7+0wOVyZoyLDE0Ml5juhjYAZNjjnOX1Opgus
	V9wLcYN1VT/ZxfqNDhOuHNxvya6dzz3quqDNHoyZ5db/QBm0qzbx3fNZ1yql5pbk
	m9Ahq5GT4PJG5Q/GvV5jUjKHAEwigWKMyBPNBXuY6A==
X-ME-Sender: <xms:QYQ7ZrOHj7oGgqYHiK1EdpidGC4yGYd-x2fk61ZSaDNhK17f_E4TxQ>
    <xme:QYQ7Zl-1Af41pccjTMTvepQOGtImze-Mp4jy6gasVQGJ2nnGO6n9HO1FMQQEM8u6m
    3EB02bVgDnkyKQ9hg>
X-ME-Received: <xmr:QYQ7ZqTroTyk0QmBHKId-hohZCniW_KKkLOowPl9-qsBsF9XyuUk8S408vk3g8MYZrHvjUAo4-4CSuIGDvVKDDEmzdG9eSQ1ETp4kNreuAWjUUgAvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QYQ7ZvsYugLycOOa8E7mEvs_RoiR9cG9i8ZXXVFQJvwQkGzuTMJhWQ>
    <xmx:QYQ7ZjfpVUllhVypN8mQg-F0LE82aGnjxU-9hzQChZl7iT_8A-JNBQ>
    <xmx:QYQ7Zr1StppHWcelVmjXZLXEQjfScE1EKGK3h6K6x_CoSoOD6QJ7LA>
    <xmx:QYQ7Zv-Z0Ex7gnHH9qndOYTjVXy3cCFmponuj92brLG_jY8PspKk4A>
    <xmx:QoQ7Zq7JVW5jOIGYPQa-tUpFDe0CkT9Cj91wW30j7QmBHjT-5piz4mnq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:55:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0e0d3570 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 May 2024 13:55:02 +0000 (UTC)
Date: Wed, 8 May 2024 15:55:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <ZjuEPmSq3E28U6tJ@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <077b69f1-cffa-44d5-8614-7f83b63442f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gypwgVC7OTqLVGsS"
Content-Disposition: inline
In-Reply-To: <077b69f1-cffa-44d5-8614-7f83b63442f8@gmail.com>


--gypwgVC7OTqLVGsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 02:15:11PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> Thanks putting this together, I think it will be a useful way discussing
> deprecations and removals.
>=20
> On 07/05/2024 09:27, Patrick Steinhardt wrote:
> > Over time, Git has grown quite a lot. With this evolution, many ideas
> > that were sensible at the time they were introduced are not anymore and
> > are thus considered to be deprecated. And while some deprecations may be
> > noted in manpages, most of them are actually deprecated in the "hive
> > mind" of the Git community, only.
> >=20
> > Introduce a new document that lists upcoming breaking changes to address
> > this issue. This document serves multiple purposes:
> >=20
> >    - It is a way to facilitate discussion around proposed deprecations.
> >=20
> >    - It allows users to learn about deprecations and speak up in case
> >      they have good reasons why a certain feature should not be
> >      deprecated.
> >
> >    - It states intent and documents where the Git project wants to go.
>=20
> Is the plan to use this document to track the progress/status of proposed
> deprecations? For example the config based hooks implementation is stalled
> at the moment and would need some work before we can remove $GIT_DIR/hooks

I also have it in my backlog to propose a file that may keep a record of
long-running projects. The intent would be similar to this patch here,
but it should also help newcomers to find projects to work on.

This would track:

  - Large-scale efforts like the past SHA256 migration or removal of
    `the_repository`.

  - Small projects or microprojects like we have in GSoC to help out
    newcomers when they want to work on stuff.

  - Things we have already discussed, but simply didn't get landed yet
    like the hooks refactoring.

So agreed, the hook refactorings should not be part of the deprecations
document when it hasn't even landed yet.

> > +### Removals
> > +
> > + - git-config(1) has learned to use subcommands that replace implicit =
actions
> > +   (e.g. `git config foo.bar baz`) as well as the action flags (e.g. `=
git config
> > +   --unset-all`). The actions will be removed in favor of subcommands.
> > +   Prerequisite for this change is that the new subcommands have been =
out for at
> > +   least for two years to give script authors time to migrate.
>=20
> I agree we want to allow plenty of time for script authors to migrate the=
ir
> scripts here.
>=20
> > + - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/`=
=2E This has
> > +   been a source of multiple remote code execution vulnerabilities.
>=20
> I'm not sure about the reasoning here as a hook has to be enabled by the
> user before it is run. There are good reasons to prefer config based hooks
> such as the ability to run multiple scripts per hook event but I don't th=
ink
> they are inherently more secure.

I'll remove this item for now. We can discuss it again when (if) the
config based mechanisms land.

Patrick

--gypwgVC7OTqLVGsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7hD0ACgkQVbJhu7ck
PpS8PxAAriiMN6nQDJBq9bZNpxFpt8EQBGltdsxoxHyeUOxgmV4/YizqsH1OFz56
rz0rbRo1KRySZJndRh4AINzG0iuAmie5nhbfdiMaf+LJwzocP8pFCHkEINwNwn1V
1KqwQE3YR8iWAoaumv/Q/BG9O9mBdyAEBgu7f5MHYzFoOvOsp57wyGiIcuqnIvrL
yCc5hePfH4RAKppRm+yMV8s49Rz/5ab2Cp3BO7JskP1G3MEurkGOzDe6vAcqakmU
v5MA3Lcg7JPEasFDEYke8aRYfYjhvzUTVmz4Zl1+lDNwV4XP1K9mgdv6IUEP1uOe
GnHlDHk9EBa0t2wEYWHv07lP7GlXpy+1/4Sxwi+Xy37Y3Q/a5WmM1GXzVWL80XnN
X7w0qmFWzOcxkQL4TnOuzMd1FwlIOvc2bL58+hSbOpV5JU4G48Lebt1wZBTfG8fD
2eB2erz59QVC7MUu+Nlv6U/Ajpza6QpukW1j/KjXainHgrT7Uh1EyPLhWeaxfSjs
9RVBTknPhFjt8La8vxskpPBNwCJLtwAR53uqZyG3ZqWhTcOFyAAdLftDrFglJJSC
7ehqcNrM4WNaNVIAoc0QcBPjGkotw7dgQXHbWM3UNs9VNQmZ/0I1wPrbgmLoyhM2
F2kARgMVE1e1cJ/GeJpPWZ5qWdwFJCAge9UgnzshftbeyaEdDfQ=
=1B72
-----END PGP SIGNATURE-----

--gypwgVC7OTqLVGsS--
