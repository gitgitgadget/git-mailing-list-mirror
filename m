Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32E3B2BF
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926494; cv=none; b=KQf5k9XiODqEGInwFMuaR5FBiqsWW3gVxw0Fkx6+9R4ShVgSMjvrHlULWd6sQay4/oc1uEKii6hKtemIPmpOjxZPjUf1xHPZrSGN5pvtaTJyq7IvxUJQ1XArK3bGgEMEWjRP2FXj+bawpwShT4R9EtK85RZFX3xrwK2nfyc/Og4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926494; c=relaxed/simple;
	bh=kJw5jE5eKIiqiK+VngDEDurwZ8lJLeUJ6+ZYqAqfeF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHcM+VfcsRYV1uejzSqta+K32AcRiMqq5CvEjQOWA6ruheYt0mjU3Krah3fiZlCgjGkswt9Oad68+zoAH7CtKp3yq+3krh7IW+w5mcfQrTKs4HcIn9zP5ts8zkrKx6PEOa+bGSHTt7d1FuUy7TegSHsi8bCgoBezNcoV5Jp+Vdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gYWSydYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYZCIv3T; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gYWSydYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYZCIv3T"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id AE35232002D8;
	Mon, 22 Jan 2024 07:28:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 22 Jan 2024 07:28:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705926490; x=1706012890; bh=kJw5jE5eKI
	iqiK+VngDEDurwZ8lJLeUJ6+ZYqAqfeF0=; b=gYWSydYaXXeq6FLkB1s1iUBgYB
	4h8lsEHDpXc0NUG34NtMw5Had68nmlFj81JhnOuzvztbdMLp+i/1XU9jcHzP1UxY
	KCIhLx3xo9rxLt+G68K6pMze/zBjicu+V4tjrBThKpDZy5/vY7Le1Vc649zwzZvc
	WGWqSG0PtmovFB79sQ7eYcaOpQYSzmPGXXVCP/1sK5lCAcqaqIzJnQa/UTVcLMNY
	YJrGW13BMmSyBLTAvUWoVcw57l+0+XEHCP20b58owWsIAHzTcclWVlIeFHDAaLhr
	pNesR3yprcNiuSvfXuWTUO9+8nk7AGBHWbyp6ac+52o2v3qzYtD8Aj81oaXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705926490; x=1706012890; bh=kJw5jE5eKIiqiK+VngDEDurwZ8lJ
	LeUJ6+ZYqAqfeF0=; b=pYZCIv3TnZDPg3iugbISLK9Nv+r4YxtUf8E+cwYQxE16
	RKB7LRWt2+pIT6PzlPhF4FKGZltJp0yhvGy6b3x3rF/pfaQar3bvkUWHD9vy46hx
	VQ49/Ic+rvI7L5pKFN/jfReqDKs1rLSN2ldZoThC4ZUzfGnWpZW/4rm3uiBpUgox
	UnJz/mLx2ubH1ZSImolF+U9VKAsH9WPnponrQzbhF/ikTVGja7o83zgj92loTlUJ
	MecSYEhv4LFax3PuVhmOuNtR04gNAFyOLlfgBcrQTCjLFlqfdtUiZmksLKdXCu7o
	wlXAFTO4Nw4NK4MAMXf7jVvXkyhHU2FYHgi4LSJneA==
X-ME-Sender: <xms:Wl-uZUamFZPVMnXvyx9npP8NZ-cDrEfG2mUTKMJN8X9rSgVD4ReWcw>
    <xme:Wl-uZfbLGFgIIIBNCyMCrmBnAAA1Cgd4yfEjMEXoeJ9osFtzOrlNml3iHNUJrzc47
    mXmkH1dIo8xXwWauw>
X-ME-Received: <xmr:Wl-uZe8z9hvZLQPlPn3vWZmKAhX35m96I6I3Idwk9nYAZEIxio9U2UDy0maZt9ZFoy9BC9n-Qc3F_FyaRgKd4EdVJnojTkAEJ3725lJrynxMVCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Wl-uZepCtIHY76SH1UY4wAeEflABeUOIVJBBOPMAXN62vh_Eet26OA>
    <xmx:Wl-uZfp92gVTLzfcT7LVGNdPgKFOAVG1mJo691yJZdYUkWxxBLOq7Q>
    <xmx:Wl-uZcTblDp_zhhWk3MDwOptPmhRjDThPZnq69IiJ-soyKYIZ5GJXw>
    <xmx:Wl-uZeQ_1p_tBDo93Wu9CJm0U4vtu7anYBKFQxhmYJf4N65kjGQkuA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 07:28:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f00e2a8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 12:25:04 +0000 (UTC)
Date: Mon, 22 Jan 2024 13:28:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] sequencer: clean up pseudo refs with REF_NO_DEREF
Message-ID: <Za5fVWZ8oUEpA04F@tanuki>
References: <cover.1705659748.git.ps@pks.im>
 <48b95fe954c1dbdd080ce7a0cc871f4850bddeae.1705659748.git.ps@pks.im>
 <CAOLa=ZQakWpRgFZdLnALq9f+acAR3hBwgO_kxJ6gb_yv+vrX=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="znZVhXPzhYpgqROf"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQakWpRgFZdLnALq9f+acAR3hBwgO_kxJ6gb_yv+vrX=g@mail.gmail.com>


--znZVhXPzhYpgqROf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 03:49:37AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When cleaning up the state-tracking pseudorefs CHERRY_PICK_HEAD or
> > REVERT_HEAD we do not set REF_NO_DEREF. In the unlikely case where those
> > refs are a symref we would thus end up deleting the symref targets, and
> > not the symrefs themselves.
> >
> > Harden the code to use REF_NO_DEREF to fix this.
> >
>=20
> Just a question for my understanding. Is that that currently
> CHERRY_PICK_HEAD or REVERT_HEAD are never symrefs, so we don't really
> worry about this, but adding this change makes it safer?

They shouldn't ever be, at least Git would never end up writing symrefs
there. So for those refs to be symrefs the user would need to manually
create them as such, and in that case it would certainly be unexpected
if we deleted the symref targets when cleaning up state after a revert
or cherry-pick.

So yes, it's about hardening the code for edge cases that shouldn't
really happen in the first place.

Patrick

--znZVhXPzhYpgqROf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuX1QACgkQVbJhu7ck
PpSgpQ//f9gLr3TsrQukl026XhRtZkbNsugR/o95QfDrduUG1e0bBKUJdGp0BZ4G
t9Tg4sHBt8+xPsL1V7QSP2FlpDou0+7dSN+RMXFEY8iwgDsNTiBnEmLOoWPrm1FR
8EK6/B+WhNYlwTW0U+EvkJXBH4r6ci08M1FXbwqF7bD5pUN4ma0wHva2SiyTWBF8
p4oMsRoQHjt29JO9ZGHwlbjSMK0Ma6MFckTVgLVdv/FQK7RuKgsCpea+OKVif3aM
Mk7wwZuakjDBOSay72F2ObHOKu+LZqt55GOzmrUTsXxGK8ymot//ffCvKiPNflLq
YRNAO7CaPPsNyLns7fF34F5Ztw6ygOPByxXvQR+1fBLBMDI4XR/v2CsNqaX+x2aI
RXe20lkI9MAc7popmnPBiabURoVKbKaaHQ+66juKM1kyye+hwpnTPuxD/bB8Caiv
DVErwQvxWFZPMt0JfPQPzOoioprxCxbv7Z19Hbgf6kb9XMl3iUhPwS8l3CcSJ0uF
/pmb/6RzBcnRlf/T6caghwf5h5lJce+SGTRinWA05RbsRBezFTekCbV0pz9R1zvA
OHKAJub2IIH7PA+UBCPgYrFrnGwmOGX/7G/qn/zPFyf/HMgl7gGLvr6TA0p+9AXx
L0HBW78cbAUlMwTOdZNCGeDfWcmFup8xA0aDIBcWDhfBMiwAHFw=
=oOqM
-----END PGP SIGNATURE-----

--znZVhXPzhYpgqROf--
