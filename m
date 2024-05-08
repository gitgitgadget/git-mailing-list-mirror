Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD9182CC
	for <git@vger.kernel.org>; Wed,  8 May 2024 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176510; cv=none; b=YVCtCFSJtsYi4u1VAUnzAaP01VNekFFxK8TZpppIZxRtN/UxAG67gBzVZ+C/pPbQ7kmTSnqA38N0ktEnqA5nbSe0GMMnj85KdPl5ElqUBgiGcnXZgXgxm31xwezvdq/RCgLefiW1VTcI0yysp2iBKkeVImG77CuVA2EdTiNV3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176510; c=relaxed/simple;
	bh=14l5P4RLFzup7qXxSuuVCHxt1kTDjnHVVpMa2GNaLIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBA6xNvI93QSEF8c8QnRkLxwMcgahoInYc2YwFb7KDARXhgwYYcu+NByLWyeJbVPmCGGPF62cYXJvt3C71Nkox3znnoYTFLA5vHynxVqnu/1ipaBOfmqyFETfC6a4cJ1VHaTCDHkZDUwPMYmjJft1xUh34qE9U8k3Ln5EC/4ZyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gWKWnBte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IbNgMVGm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gWKWnBte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IbNgMVGm"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C2DE5114016C;
	Wed,  8 May 2024 09:55:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 May 2024 09:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715176505; x=1715262905; bh=62UcU/gWdd
	d76INt4vckHVPgf4OC9JIbs3Mz9VyFA+E=; b=gWKWnBteSQAoV4zTxv6g1FcUY/
	5q/kWlQ7f/s3h6dpvkpFJHAbqpq3TjMccbu42NhaOP2t0FGF1PAtYaQKyWjhh9Mb
	78Je79GBaPg/blcNg+qhsc+xv6Lr9ssQHbfeOQ0YWmU8o7GfTPCPc4ZABu7u2/Tx
	nRRTGBDIsKIEgjrL+8/OMNSqIRNkdu2sHSOEcsZEdrCJXr4hYkqDGUQXbESlBEFp
	Uj0sY0X31Erc7rcAKBvIe17hAlrtamYmL+HKpAw0B7JF/w4iSDOf5txuKs/hI6q1
	gA2t13730KC4oJUP9as9+uoQMpmp7ypMhPu7gPPrrKHqYN2x3wAOkLal9y1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715176505; x=1715262905; bh=62UcU/gWddd76INt4vckHVPgf4OC
	9JIbs3Mz9VyFA+E=; b=IbNgMVGmhVYWfKarVzjBpBM70NHdySTRTZABhGMR+vX2
	3Q3ujGsOXKRM/Nb7D+yPfsa4HpyExxeuA6tiZYjwDAjkvXEMXADDTc6j3GpGgax0
	i1vJgtChpWbZcnEnLQLJLAHrMXA5B5LH0hBUZZyKIDhfXjFg02WljqVP51CqkWHP
	b4ZTkoDf6cAF37+tC7pXkAGeINCKdEmqIprwf6yQzk6nxPNcEUFbuq192ydirKEK
	9A3HGPYKVY7Cpe3PQ4QPI74zftKWFGaM//20hOIj+SSjSoiKe99wRSwyONN2A7d7
	PyyzFBim24PZkXOQdDxQkT2m+6mbWJgr+iY5dNkvFw==
X-ME-Sender: <xms:OYQ7ZhKf68jFJsxgEuEwSpR2M-xKIcNEgUrW9Xvc7U6KgiPo48t40g>
    <xme:OYQ7ZtICy8X1dsMx-Ed1XTjQq9kt4CMiW-mZHMg7VKr6_LzrbFwcnAz_NvhmHpPyF
    tGz2sUYIm0So11fiw>
X-ME-Received: <xmr:OYQ7Zps38Uh8LVtYSsBYCRY38-z9vnWE5knmOgaGkGIcrZWze4V8ICwCmxWxV0GjE09EMU7oUlSuVpKSSzLFG2alqJxHtqAx16sdHpaj3PZQmOjvjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OYQ7ZiZbcbgCijCtf6SsBI5zF6tJ33QnLN03JSA2EvSJkkt47BCqLQ>
    <xmx:OYQ7Zoa3c5f89MgJZOm_Drzv89rfAbRz2a9lTRWNmNaet9OJv6CLpg>
    <xmx:OYQ7ZmAklleiX6JNL9OsO8pD6N8qmwI4OgGtM2f6Z4872wVH0Uzriw>
    <xmx:OYQ7ZmZOuWq8NXIXR1ceTJux6E4Lc-qYujhH3lOg8g76cK2j-Erq6w>
    <xmx:OYQ7ZgG2elKjNTQk9pO08pudkv174skMaE6CLpMkTwasCDFILgK-aedm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:55:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0a579b9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 May 2024 13:54:55 +0000 (UTC)
Date: Wed, 8 May 2024 15:55:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <ZjuENtXjDZaX-0B0@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <e1350757-80d6-3ca6-3ef1-4b6ba496ba9e@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x25p+7owlnqFM/5P"
Content-Disposition: inline
In-Reply-To: <e1350757-80d6-3ca6-3ef1-4b6ba496ba9e@gmx.de>


--x25p+7owlnqFM/5P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 12:38:31PM +0200, Johannes Schindelin wrote:
> Hi Patrick,
>=20
> On Tue, 7 May 2024, Patrick Steinhardt wrote:
>=20
> > Over time, Git has grown quite a lot. With this evolution, many ideas
> > that were sensible at the time they were introduced are not anymore and
> > are thus considered to be deprecated. And while some deprecations may be
> > noted in manpages, most of them are actually deprecated in the "hive
> > mind" of the Git community, only.
> >
> > Introduce a new document that lists upcoming breaking changes to address
> > this issue. This document serves multiple purposes:
> >
> >   - It is a way to facilitate discussion around proposed deprecations.
> >
> >   - It allows users to learn about deprecations and speak up in case
> >     they have good reasons why a certain feature should not be
> >     deprecated.
> >
> >   - It states intent and documents where the Git project wants to go.
>=20
> I love it.
>=20
> FWIW my first reaction was: These deprecations should be mentioned in the
> release notes of the current versions, as a heads-up. But then I saw the
> impressive list you accumulated and agree that it needs to have its own
> document.

Some of them are my own, some of them are Junio's.

[snip]
> > + - git-annotate(1) is an alias for git-blame(1) with the `-c` flag. It=
 will
> > +   be removed in favor of git-blame(1).
>=20
> This is the only item I am not quite sure about. Its maintenance cost is
> negligible, I would think, and the cost of using a judging command name is
> less negligible.

There is of course still the problem of having multiple ways of doing
the same thing, which does create mental overhead for users. But overall
it's likely going to be negligible, both on our and on the user's side.

So overall I don't mind this item much, and neither do I mind which of
both commands we use. I do see the argument that git-annotate(1) is less
judgemental though.

> > + - "gitweb" and git-instaweb(1) can be used to browse Git repositories=
 via an
> > +   HTTP server. These scripts have been unmaintained for a significant=
 amount of
> > +   time and will be removed.
> > +
> > + - git-filter-branch(1) can be used to rewrite history of a repository=
=2E It is
> > +   very slow, hard to use and has many gotchas. It will thus be remove=
d in favor
> > +   of [git-filter-repo](https://github.com/newren/git-filter-repo).
> > +
> > + - githooks(5) can be installed by placing them into `$GIT_DIR/hooks/`=
=2E This has
> > +   been a source of multiple remote code execution vulnerabilities. Th=
e feature
> > +   will be removed in favor of `core.hooksDirectory` and the new confi=
g-based
> > +   hooks.
>=20
> Since I already expressed interest in having this document, especially in
> the proposed form of being a _living_ document, i.e. subject to change, I
> would like to add:
>=20
> - The "dashed form", i.e. support for calling `git-<command>` instead of
>   `git <command>` in scripts, has been deprecated for a long time and the
>   intention is still to remove it.

Agreed!

> - The command to import patches from Quilt seems to be used rarely, if
>   ever, and will be removed.
>=20
> - Support for importing repositories from GNU Arch will be removed because
>   it would not appear to have any users.

What even is GNU Arch...? Never heard of it before.

> - Support for interacting with CVS repositories (via `cvsimport`,
>   `cvsexportcommit` and `cvsserver`) is of dubious use by now, judging by
>   the number of times these commands have been mentioned recently. The
>   code has been essentially unmaintained, too, and will be removed.

Fair.

I'd be happy to add these in v2 unless folks disagree.

Patrick

--x25p+7owlnqFM/5P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7hDUACgkQVbJhu7ck
PpQinQ//XYKbOS1cAkFaOKbfZts/Ic+gKt3PuR9Wg5DGA7R2Vr5Pd7v1yClhLLcq
rf5YnffQHbvz3n/ESIAfSnx+PBiMbW38ZHw4oZELGcOsySdDf9Ku9lP3QfgIeqp3
J/qDzMQgTcXXpbrWzzhm8kZj9an7zFlfQZfoaASf4R+K7m1xgMd5ZmWHv+DpG2MJ
J6xj1D+1oCKzFKIvzWj7iE6irhMfNir+sr4preTvNuSoy4sL5mWXxO7cG+ybF5Uj
TyHc02czzR77ZBrkzumHktCJ2A5JYVSwcC+Mus5GFV0eOFTsZLF89nvqVZ1uUuFV
H5ptWr7GgiRdPLw46gIDtVIMo9Ku7nb86mncPg0Ga9HmqJDcyZrIiZZftHIb1lJD
/5nsw/neKbWJOLiG8TQ7cO8u4kaf+aTAqBKbLhjt/5+rtmNwl7m+Q5nNXHFsqcGF
QokegWQHc8jdm/HlRrTDJRX3vpilMNf8mxeFxL3JkCNwAPWqfFGxEnrOpdkYGOo2
OMb2MwbRAW800wXsJx+u8U8fLiWuD661SkHarGMUn6w1u7Iwau/m4TQRdZ2jnVsS
qwymOy6oOkdG1zTIblsBisnKaO42EHfgpBwSlqEu3NnM4gNw3pZMrnUii0zgv9gb
jpCLFoQ9mrVBtyl2wqMrh2YFCPwpCQVmP2yxoz4KsE/dFMKUQuo=
=v3kJ
-----END PGP SIGNATURE-----

--x25p+7owlnqFM/5P--
