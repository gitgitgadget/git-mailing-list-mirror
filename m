Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8729AB
	for <git@vger.kernel.org>; Fri, 24 May 2024 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716540929; cv=none; b=VQLwDydipAqw3ZHYmXGHize3qxrUDSD5nwU069pKM4NMXZwpFO7mL0whFCprMvHCFuJ/lNZ8g6jkMxEFq3fsKydewDkNdNS4jBQgOMlWn/QQwI/ST/x+DbuwgQ09y3q81DD0xKMPA16o3lRgWmETXcUDNtQ41ImJ0K7NiJGlvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716540929; c=relaxed/simple;
	bh=zYaAps6bkQa+t2GpMRH4cXi3BxfQDwWZedWdYSZEMnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4dFK1iAGn/j/Z0ThcFirJ++FhfNGZyluvI4VNlxUvr7ePUNWKo0L3eAlf5Opp40L8yGt2SlTh7qmMxncrwOEOD+s0Y0PDeHvpTECL7WnlYMhZUK/L7ewFL+LkhVqeYy0nEeyqqt+cm7Lyg7dRc9eSKC517OSIAV4duFuxyOrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nhaZaiu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXqNvPZ3; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nhaZaiu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXqNvPZ3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5E44211401B5;
	Fri, 24 May 2024 04:55:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 04:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716540926; x=1716627326; bh=aYpHc8zwbA
	Ax/biXYlO/bz+sbt2pLzTG8Jkn028eCRI=; b=nhaZaiu9FlZvXI1OCnWM3F/YgH
	XBmdMRQxuXIRTZkFiu8aYlxJELcqhxiP8CjQokCrqJyezz2D8Q8UNyOfAsGf3jDH
	aas+iDJZAZ1qW+5mJCv6210J55XKh9QA1XVlxdWmrpp7nM/8Q5o7mSJPEs055IGb
	lWZR5aih+rpLQV/oRYWG8D5gEggX7c9iSJaA32zn5U7C/LK8igv0BwR8ZWO4J2po
	FhY0WqmkHFVH6/vIatayT/o947RWU4hOSKzoV7oXeYxrcikmM0U23gxW6ZPk2jtl
	Yoiy5BtRSQEe7MyoTs092Mp3+JRkgkI0c4Pej0Vx+bssq553oIi2npTmwMaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716540926; x=1716627326; bh=aYpHc8zwbAAx/biXYlO/bz+sbt2p
	LzTG8Jkn028eCRI=; b=YXqNvPZ3dDXHVLmlrn6LGIljY1rXJwD3780/pjAIPD+6
	BQp3WYObQfhcSL9vMYyH7gRERk/59b/w/PF2ygEVenf++VNg9xJ7ZzOmuk6i6L5n
	PoLys/iGyVJae2X5voQtsrfsSuGju/Ft5+YTYUiXqLusBwxwA9R2LXlyb0qXpf8n
	YypJiQ8OPMUDtbUYJP/aH72fa6SnwvMB/EoDxUl2UV1PqRI8kBv2REIYWOHJflLV
	HJezW4E/ZlW1rVikTtmAIuTkbuoUt0MXZJYMKirBnA/ZmAojK9pcQOk0mMV0A/2P
	weeSYZxSh7VmDHbJ7Bmw5WBvKXg/E7FiFnfBuz78Jw==
X-ME-Sender: <xms:_lVQZrhZ_XrE3Qf1sjnRJadVkLkBYO55mIOGmiwFvtqsfVxU2p9Pzg>
    <xme:_lVQZoCfEIruccZ-CctwmGUM9UO7BEyo5XRDva-yTCUA06WsBbkYr_sg6Q3RF5vF3
    KS6B8BqQYceyzP0mA>
X-ME-Received: <xmr:_lVQZrFBwbmbMdzqeQ2hfjvoBc6p6HsQbhn_4jUlsl6VEXAfR2e7h74KhzaVkgwHdue__KDC64A4FaVLsA5T4SbVJjOHy863gwabsVLWC6L-Ets>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_lVQZoRqXQoPqFi5r6klc0n1VI_Cw6ujp6lNB85H5hLgeRUBqEMxgQ>
    <xmx:_lVQZoy2bD28nLmvfPnVKZofiPtDbCZikJXw9rkLHRIhnBJCEUhizA>
    <xmx:_lVQZu4dQgU7YWYpwG3ONXuEgOBnUcni4m8lt-U22IcaTVnVZu4sFQ>
    <xmx:_lVQZtwjEBLoSPEmop_KQrcSn1HdrGOJTX_L3ZiEV9CdVoUGrKBpbw>
    <xmx:_lVQZj-Ja4MmFbdrAQ7i--Y8a-QO70w_Eghz2gvF9HIs4IPFf32irVrZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 04:55:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8a57df58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 08:55:20 +0000 (UTC)
Date: Fri, 24 May 2024 10:55:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/20] config: plug various memory leaks
Message-ID: <ZlBV-QtqoNX-7m8a@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <b2f8878b55564c4bf4848642e419c44c1a9d9005.1716465556.git.ps@pks.im>
 <xmqq7cfkv4cr.fsf@gitster.g>
 <ZlA6jZmKomOu1p_S@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H7JF9cfpip+ANEPr"
Content-Disposition: inline
In-Reply-To: <ZlA6jZmKomOu1p_S@tanuki>


--H7JF9cfpip+ANEPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 08:58:21AM +0200, Patrick Steinhardt wrote:
> On Thu, May 23, 2024 at 10:13:24AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > The "message" part in it says that it is encoded in iso-8859-1:
> >=20
> >     --ovDSRLSkA00eIgbN
> >     Content-Type: text/plain; charset=3Diso-8859-1
> >     Content-Disposition: inline
> >     Content-Transfer-Encoding: quoted-printable
> >=20
> >     ...
> >     diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
> >     index 75216f19ce..7120030b5c 100755
> >     --- a/t/t4210-log-i18n.sh
> >     +++ b/t/t4210-log-i18n.sh
> >     @@ -1,6 +1,8 @@
> >      #!/bin/sh
> >     =3D20
> >      test_description=3D3D'test log with i18n features'
> >     +
> >     +TEST_PASSES_SANITIZE_LEAK=3D3Dtrue
> >      . ./lib-gettext.sh
> >     =3D20
> >      # two forms of =3DE9
> >=20
> > But the source in t/t4210-log-i18n.sh actually is written in UTF-8.
> > The thing is, the "-u" option (recode into utf-8" is supposed to be
> > the default for "git am", and it is passed down to the underlying
> > mailinfo machinery in builtin/am.c:parse_mail().
> >=20
> > But apparently that is not working correctly.  I see in the patch an
> > unrecoded byte E9 in the resulting patch file that is fed to the
> > underlying "git apply" machinery, failing the application.
>=20
> Hm. I'll double check mail headers before sending out the next iteration.

I've changed my mutt configuration to prefer UTF-8 over ISO-8859-1, so
the next iteration should hopefully work alright. But as you say, this
is probably something that needs to be fixed in the git-am(1) machinery.

Patrick

--H7JF9cfpip+ANEPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQVfgACgkQVbJhu7ck
PpRM/A//XVjH0U+ymdDDwF26f5yRLkSL/Y2hJpUDkYRancB5wjWSHiPBnfQmqoZM
Y0CSqKEYNc0PtD2/tMIf/e9+v40/ADItfxZROL5fSVMxIKkza1J42M/lhNvkHHIS
D9lujKHIoWUQ4avDh9NUbyeiNIjUTUx/l7fA6+EZ1WZjYiev/PHTPXW1xzsQ5qs3
lIGmFkaJ4OqZzFGkGJl+bHC+pK3md1SeOyFHYYEvcNPe1RRADQtA9P2vU5PJumRh
dXPijMEAVcMlle/vYN/6xn4SFUiiciEF3f+hF74tzsgAthJuYIkluLh/MqSiuW0a
BNaFdnKBX6k7QA8eowHk00b0MB1nzDmCAvXMGv0S2zep/lkGgLqf5Wzg2o2dv6le
L4qWQZq0FHJYXPMOKJ1nkFcKFTcZYenooef9u+/0pKwFdzq3cTUhKMaSPf307bAu
OH73j2hImHMuxYSvxTaYjRPIFhGkcUH73RnbbomaQFwt7etpWu0VONf9KfwJcq6d
DtPq+uCu433nzeSkLn1BMaPWxlbyGLc26NB5ypLTLByBBEJa4dQNCt2hf6/AOlxN
U2+pYZuDGGSg2/ik0K8hfsv1Q4lYw3qDitqGTblfyHQxKO6aPeZzyPgZZnzej2qC
GWhPZ7LF8gcF1azY40HN8OXgricpRvFmbefn2Prm/Un6+VCjHdY=
=g0Qb
-----END PGP SIGNATURE-----

--H7JF9cfpip+ANEPr--
