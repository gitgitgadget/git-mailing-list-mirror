Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354F1420DA
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044194; cv=none; b=oC9Xqx5vtE0zP/9vvBjMS//cj2wiNv0BeJ+RQcvZOXv/tib0HjPwU1ZephNcsr5sKmAyTBgRVyhEt9BLQ/EgdlAxhUCpFVvnLvvvFqi3EX71svaIdiv3onjIwhlBzl3OECYgL2XYzuwC/LctJe/5X1xVpSdTjZ2a1xJ/Gaky5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044194; c=relaxed/simple;
	bh=r2G3O3Tbo5H2h1yri181DKQnCOUMTqUh00hYx5VWbNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KloJbHN+QwAisKS4a2pGYr1EbKV+fKUYWJGuAldsS2LBGRdNOust4c2D2l4Hh43DnZ1j2pvnYX/zQvA0526YS27QIHLGjtvYxAyBLJcjKh6tXLWOmPtHTZRtanYVTaDLuPV24HrzP6nnpHF2ZljA1N3BdVSv8i1IpcMS6HIE8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GvxLypb2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gW4tGSWE; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GvxLypb2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gW4tGSWE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 556143200B14;
	Tue, 27 Feb 2024 09:29:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 27 Feb 2024 09:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709044190; x=1709130590; bh=Pr7j6XOrPe
	aqqr6L/OzgalNeLfN3Q4Vv0vPWwVM6sWw=; b=GvxLypb2GxQwQrDn439XY04q8i
	acLB4AB8uVwwDmiQsvhYwlMvcOfu/Yk745tCEENqMNP+2z88sufwepntN0yDJumP
	t6V6oUZMcoaRqh39TioO44AxFau1MHK9b1sZbIyf8yR8qEBgWbdakB17vIfc2wT1
	h2TIDpVY/F4jGB3KPq3mcrpLjIMx/S2vVugrLDnUQArxgPZfCdbjJoNFXJ4vw2EX
	oARqLGB1xTfkRJrQVIgyEgr/BJ9XTUC44Z878MKst4rph9Cr6FCRAiUrIZwgoXrO
	5POuC5KumBN4Hw3hXV/UyUT4WTgzB9wzP2hUJiWEt808Tom5u+6BqXukFKlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709044190; x=1709130590; bh=Pr7j6XOrPeaqqr6L/OzgalNeLfN3
	Q4Vv0vPWwVM6sWw=; b=gW4tGSWE6hQHTttqfPH8jfONIAzA0RK144BSvJffXgoY
	hXLAwhBgm2jBX0urNKc47FGeJlN7n08qT+t0IY9tRpCtX9Zhc1tSzVhdtGyujw52
	tEkco1QiTTwmiS2X6o2y0/jZ02z9AJtval+PJg4RNZPLoYMzBKNWK6757r/2uEBc
	zWazhQtg8e2V3yA+2dxiNwmRtZTa4z4Zuma/2voXkyfH+w4ytKX0XZ5T8jlS5kTz
	wLtjdpBMmz+GW25phyr5g/kD5K7FQkkDObt4qhNlgdDKJcEWNnDwXlxJ8mlc+X0W
	R197ShTdqHy1XEZBkcBbb2TKPBnfo8l/PAOBzeWO+g==
X-ME-Sender: <xms:3vHdZWkw0ClDvux5zNuKQuNWnvtSN6TbwPp13QEPDidQ4-tXpDTP_Q>
    <xme:3vHdZd0O5c-rq9d05vSNTffVcFELPxx7k4H6B4GF3t78BB9oDP9If9P2b5zZGkJ5O
    K02PZoZ1JCvyoBIJQ>
X-ME-Received: <xmr:3vHdZUo6_qDMkkEuSoJq9YwbUDluaEkDiQq0qIcuhX7FPURT3-vfdg5q-KeDTzasA1wV2AcBA-afegjlw5wxRC0Yq9e88A3zGewq-HAfHrGO91Os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfelgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3vHdZam5uCHnXSnt6rBdihY9MNhBv3rCmK444xMVMXYMH2wCTkvtHg>
    <xmx:3vHdZU2nhESDNsB-uoTnW88N7ocIXMzUTy1VtqOIu9g9zA0XH8bifQ>
    <xmx:3vHdZRsGrdw4_ksIsqAGiSpn0PR9xrP2QUUPMh0zR37bjacDg3Iawg>
    <xmx:3vHdZRz0p3WZKRCDj6Irhx7tBj6R5RHvKaqd_4ZiR-MeoIuBhd3eUQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 09:29:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8613aa7d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 14:25:32 +0000 (UTC)
Date: Tue, 27 Feb 2024 15:29:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.44.0
Message-ID: <Zd3x23jVejP7VL0c@tanuki>
References: <xmqqbk87w164.fsf@gitster.g>
 <20240224051040.ftuo24smozqugbde@glandium.org>
 <ZdmOZRjJ-mClBR02@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvG+OBSlc7bDcruc"
Content-Disposition: inline
In-Reply-To: <ZdmOZRjJ-mClBR02@framework>


--cvG+OBSlc7bDcruc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 07:36:21AM +0100, Patrick Steinhardt wrote:
> On Sat, Feb 24, 2024 at 02:10:40PM +0900, Mike Hommey wrote:
> > Hi,
> >=20
> > On Fri, Feb 23, 2024 at 09:17:07AM -0800, Junio C Hamano wrote:
> > > Patrick Steinhardt (139):
> > >       builtin/clone: create the refdb with the correct object format
> >=20
> > I haven't analyzed how/why exactly yet, but I've bisected a regression
> > in the behavior of is_git_directory() during a clone to originate from
> > this change.
> >=20
> > Here's a way to reproduce the problem:
> >=20
> > ```
> > $ cat > git-remote-foo <<EOF
> > #!/bin/sh
> > git config --local -l >&2
> > exit 1
> > EOF
> > $ chmod +x git-remote-foo
> > $ PATH=3D$PWD:$PATH git clone foo::bar
> > ```
> >=20
> > With versions < 2.44.0, it displays the local configuration, e.g.:
> > ```
> > core.repositoryformatversion=3D0
> > core.filemode=3Dtrue
> > core.bare=3Dfalse
> > core.logallrefupdates=3Dtrue
> > remote.origin.url=3Dfoo::bar
> > ```
> >=20
> > but with 2.44.0, it fails with:
> > ```
> > fatal: --local can only be used inside a git repository
> > ```
>=20
> Thanks for your report!
>=20
> This has to be because we now initialize the refdb at a later point. The
> problem here was that before my change, we initialized the refdb at a
> point when it wasn't clear what the remote actually used as the object
> format. The consequence was twofold:
>=20
>   - Cloning a repository with bundles was broken in case the remote uses
>     the SHA256 object format.
>=20
>   - Cloning into a repository that uses reftables when the remote uses
>     the SHA256 object format was broken, too.
>=20
> Both of these have the same root cause: because we didn't connect to the
> remote yet we had no idea what object format the remote uses. And as we
> initialized the refdb early, it was then initialized with the default
> object format, which is SHA1.
>=20
> The change was to move initialization of the refdb to a later point in
> time where we know what object format the remote uses. By necessity,
> this has to be _after_ we have connected to the remote, because there is
> no way to learn about it without connecting to it.
>=20
> One consequence of initializing the refdb at a later point in time is
> that we have no "HEAD" yet, and a repo without the "HEAD" file is not
> considered to be a repo. Thus, git-config(1) would now rightfully fail.
>=20
> I assume that you discovered it via a remote helper that does something
> more interesting than git-config(1). I have to wonder whether we ever
> really specified what the environment of a remote helper should look
> like when used during cloning. Conceptually it doesn't feel _wrong_ to
> have a not-yet-initialized repo during clone.
>=20
> But on the other hand, regressing functionality like this is of course
> bad. I was wondering whether we can get around this issue by setting
> e.g. GIT_DIR explicitly when spawning the remote helper, but I don't
> think it's as easy as that.
>=20
> Another idea would be to simply pre-create HEAD regardless of the ref
> format, pointing to an invalid ref "refs/heads/.invalid". This is the
> same trick we use for the reftable backend, and should likely address
> your issue.
>=20
> I will have a deeper look on Tuesday and send a patch.

I've sent that patch in a separate thread at [1].

Patrick

[1]: https://lore.kernel.org/git/cover.1709041721.git.ps@pks.im/

--cvG+OBSlc7bDcruc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd8doACgkQVbJhu7ck
PpSEIhAAm6I7oTcBc33xg/NVFgUX12HcJqxhPCZYhxpVox/rt3Gl2M/4oN9WlVfZ
zWv/thKsIW4rw/JY5dFtfzdqS66b/+fzICkxHh/qCxVbQuuEBlEzaDtvOrW39LrA
KzLbTTknDMCtRD/18AD16+yb2fSBfNhPVVSfw0R2rJYn4x3jBhM28pZaO2Cxhxc9
wU/8Gi4Yv7aNfn06RpGbHLhjxrKCjFbV3V/bqlQagLgCxjrgYjEkLgsf5AJs+CXX
jYvweEZhD4ncOyNSRjUVMXAUaNdlvqeOKIZrOOQQcgpZ/ukotUl8+tHytLcpDaO5
W5dFdhphqYL418xwPrzbxwFFFX446Xyi8jN4PLaBvwz58ZfNt92ueifpJ+KVbLMt
++Eo//mgHVbieLtGkz/CYdmk203Tw+AiAU3AgbPKMs3NhAFnO7yIfHnQIhuJD9c1
HWJhgMhs7eqlpNknN6F5wXzHmN9SZFcb5SbhUmpxhD2gLyXhoOrXqvx7WSCdVPoU
XGOm1WYHiYWYaxmekb+pk4IQF7jysrCJuKz5uPoy1VCiy4W5y1sFabsLFIebL4gq
zBMAyL3d6YrSgq4jSI4etgw8/MXyENC+0QbgMnONOumpROVceGfrfMGTR12+XKYK
bq6OFe0tTxnv3jEDXLtKMvB9O/dmimBycCCUXjfiMBsYiVA1J7c=
=7vvA
-----END PGP SIGNATURE-----

--cvG+OBSlc7bDcruc--
