Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C26191474
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723009940; cv=none; b=eG9YSGMZIgmUsdgJhNMgWNJb9RE3zcJnJEJ6CaSFplKMY6xOtCOnj/TPJnCpOonwOB+5B91Daf6H6Mc9uTjamZmz7Sz3hoVONaqmlaz0OSLDewnZmlnU+Z6uhc4TtZsdOCHGn6q8/NgmmU7FnllMZWNoukRZ53pMIiWx6knxh2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723009940; c=relaxed/simple;
	bh=mlqFoIDMiFEvVON4J2jOpsBpcGff6zKpV1snAwsxgQk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMkbRv6YilU8zkEM0uaBX9Kq8ppIQ82ahqu2yre2Y6NlYJI7nz3PS78/W6EDoY6QQfA+FBGXdI6HJUqv/PnT8vtEH9nUSZlHC5C0OH823ajJjWqoatSAuxIsUFIvHxr6YXW93n5/aHVsB3arHV+yVzwbILDX9rSsCNpRUqcA+Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dv0OwxXW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gYt6/hGY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dv0OwxXW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gYt6/hGY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 65F601151A2B;
	Wed,  7 Aug 2024 01:52:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 07 Aug 2024 01:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723009938; x=1723096338; bh=if2sN8aYbU
	IqhV7d+bSR+MeF8lsfG55VHkn9+QVxBqk=; b=dv0OwxXW1vkzQCg5WsohM0/XW/
	XhkPtn1cUzHh+XWsNsnROUg+JXPg93DlHb+kRgLFRWsFHppUFS4nGfB+4iOHmKXq
	I+aS47pyLQeeY3j3euCVwpUOzNxKpvDf9SWNxttnT6YDeTghbvjEsu2Cwbfb5ceh
	2ocSflPr+vtx0m/STduhVtZQJ1Fit569OKr0VInGcjphf4oiQI6Hy/O324TqjjLu
	06BvKsK9zKUYKJv6rxoEln8NuHCIQpAA31fGgov0KVdwt60PiVvLPyDiecNuCTHO
	1Fhryvb/bG4RIYIYLuRLeQAjcNvElkCZQz25L4qbsWTcg6p6/vimtPWP5ELg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723009938; x=1723096338; bh=if2sN8aYbUIqhV7d+bSR+MeF8lsf
	G55VHkn9+QVxBqk=; b=gYt6/hGYKPt9HmKpp3jOGdmN6b8umv5OA+65Dv1Gbdxh
	j0fKQ+Z263IT3fD6dWkCaI6zZt3kJUKufMncHZFEeqxnPDs2UNjY4Gvq7wWGMld5
	hcf63lPCKrdqr+5/6YfVrjGY0LfiLnLT+qkaDDMoPYM/amn8deU5OD6CSiN7f0cZ
	Yl9JZHlAAKImFJNahDvpcwmc4mT1ZPW0uVYR+MwXTA/52mQDa3a9O1kEdbFq634M
	Sfocsrv54rSi8buoMwd+G+s8dalSs2YOjxDVcKVcWgWMiPQchIr7dHORIMY5yHYu
	e5VkLO7o4MbubjjObmpH83SQ8R5070is4stHWMu/oA==
X-ME-Sender: <xms:kguzZnZeCQ98Oc0JNo4IA6Yj2MzWQyA-TAts47HvMl0NGumxPGoWBQ>
    <xme:kguzZmZYmYLmTsV8mD_XC4eKas7nBcINeCvtBTrZQVIBaUKQtO6HY464OIQt8eUYw
    3bQ39d_tPeu45bb_w>
X-ME-Received: <xmr:kguzZp-fHkpz5F6E9PjErERrCy0YsVOfOjQFbzHHx771d-gS064Wq2zuUSp6f66TFKZhOS_mcwQ6TwryFMJ5bEBzgAcR2jzJ4k97CaNYs4TATQEq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:kguzZto86l-U_OZGif0wroHE3mNABdAl0c-iYzm__Vw2o3TeqwfYlg>
    <xmx:kguzZiqJo6raDeIg7mVEiYkR63RhTq-FgX4v7uOwOFFmheX2GZwdxQ>
    <xmx:kguzZjS_e_QZ5UeQNumZ7tZiao_PvNNzDIiUGdAJHEEhSkXhf5ooBQ>
    <xmx:kguzZqqyBhV0KDQgnpOrqH2Wv9Yef5kmS82Tz2fOMyrOMehZFzqPlw>
    <xmx:kguzZuetwDpzFuDsmEhep1pBVExsaPyI6E8VAxekLsiVkNcerwOPFwuU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:52:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 250012f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:52:12 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:52:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [RFC PATCH v2 6/7] t/unit-tests: convert strvec tests to use clar
Message-ID: <ZrMLjjaz79s7O8B0@tanuki>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
 <578e657269dd448d3de2964bba03fbff869560ba.1722952908.git.ps@pks.im>
 <6a6z3xduic3c6v27zeag5mxclupb4rc7a3gvoov5odpa7vqz4u@glpita3ojyxx>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iRN9gjIILy59a/fh"
Content-Disposition: inline
In-Reply-To: <6a6z3xduic3c6v27zeag5mxclupb4rc7a3gvoov5odpa7vqz4u@glpita3ojyxx>


--iRN9gjIILy59a/fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 04:05:46PM -0700, Josh Steadmon wrote:
> On 2024.08.06 16:14, Patrick Steinhardt wrote:
> > -static void t_static_init(void)
> > +void test_strvec__init(void)
> >  {
> >  	struct strvec vec =3D STRVEC_INIT;
> > -	check_pointer_eq(vec.v, empty_strvec);
> > -	check_uint(vec.nr, =3D=3D, 0);
> > -	check_uint(vec.alloc, =3D=3D, 0);
> > +	cl_assert_equal_p(vec.v, empty_strvec);
> > +	cl_assert(vec.nr =3D=3D 0);
> > +	cl_assert(vec.alloc =3D=3D 0);
>=20
> Is there a reason you used cl_assert() instead of cl_assert_equal_i()
> for the .nr and .alloc checks here and below?

No, there isn't. Let me adapt these indeed, thanks!

Patrick

--iRN9gjIILy59a/fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazC40ACgkQVbJhu7ck
PpTXWg/9G5lYq3eUlTcK61xy9xcovqQ2TZmATeVCVR9Y+zgBErPHK+JzzjPwqaai
1ESm6esrqsSRW9K9GmYue9l3SXrgvayMSMUXu9oc3Pyn6JwJK8cPg0lBxOHXszsr
Aakg/Nlq6uPYsiBLb/SSwRelDQ+gpZ+rbhyhg54w8vte13qkpr4x9hu4aQPFqwg0
goiItoHBf8ARuDzlACHpQruGiJRIOyiP4vQCXhc22mIWe4EHtW9t/9MVpCivDWaz
iwuAvfkk5/KPGaULTO5DLZzVrXD0zFaCxXNgvj/KKOn3BGB8XFIqb2UK3xNtS/jS
LZ7MSGj+zHWCXCVTWyli3rnLLW93ynWLbLzopRCk4jcFkF5CIF28Y59bqqKPNRxS
CUPUsHM/S07Ic75Qq9w8bpSmNTZ/W42JgXcs4K+SJ/mJaP3GQ9x6GDMxsiEGwaDo
6DSnYZng6XpSUtbQRkkBhPiwil1rUXBvOQU6tQmIcqP4DSMaBVGFEqoxbgISawx9
MaJGOUyA9ntr2YMFnxHoZWtqh5TZUxMHU1kzcxdV3i8LzAyNmOLe+RsFsmCt+Jje
UUrnuUBIOv1Vdl6eh7g9Gy2x756x1GOJ/0P4LvzobTcGR7siLeOk6fu7CZ/SmJmO
wTGjCoGpEsaXcUJ9BtzI8y4moe9oiRQvV8u75xpOwWkSmv6uiWA=
=a8q1
-----END PGP SIGNATURE-----

--iRN9gjIILy59a/fh--
