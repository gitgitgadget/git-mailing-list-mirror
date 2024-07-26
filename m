Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E132E3E8
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998602; cv=none; b=W9phaf9Vz+emAg/Y40XIpUkWy3RRZHnu6PrNW47QUb6y9zPOwxhvliUdgfjwoYwkvio3/61i1Y9P2IYmrkkeCp446eJ1Y2UVTnqmZxDvFUSbLgfh5cY5vM6SwJ05HoDwgZL4pP3HI53ujmZ1ldVErZRmk1yCq4QWCTDvh3Q5JS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998602; c=relaxed/simple;
	bh=ON40YodL+MexvLeo0mI7ErhY2tCY1b90xlz3hRVo0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4wpTN7ZS6yhTA6AUlZ540PpF9MAo8kGoqEjaDGxeihDThg3h9Z9C+WXmGMwew7wYUN5xIO2C3wKTKRXP6BbWN3XwMSTrrTMnRU5ZlRncnSRo2kK9dPQqpyp2OsMfhA12Y/TUGnNWED8mSz0Ztvz0mE7CU1c0Ij1GKJjAtit4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oH7Sl1dL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dB3CJjxU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oH7Sl1dL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dB3CJjxU"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id C610E13802C7;
	Fri, 26 Jul 2024 08:56:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 08:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721998598; x=1722084998; bh=FMfQNpjgWN
	4xXeIwpFAXFEEdztK4LratBRfhndOo4lQ=; b=oH7Sl1dL1CTToDoFJV/pWN7I/c
	GqkooqXwbWH15+swyvx2Z/sxFEJ71lnpW9cJxntYHei89L2YArbqdLfO1ztmdUwF
	Lq1WfdSj7wIm04zs7PXClI9MNEOkw4prlGrHbZJriHCMkSpF9+8FKmdpaLbaVKRF
	PfmPPXp3fyu3Wl/16Pp+BQa4UhJx0KKJf0Zm+u4x0Bk/IKkzPROAmI+SU7jgRfnj
	6DJxhuH1J8FQ/hI2Cn4Kv4zpltrarv9poaQ2Ev140gJSfm8C499urIjq/YpjBS7l
	S0OuAvZEa6J1rbclHBEZqYzz/2Khs0M9TWuO+8JlxpHtFocu5uQOvHvwuMCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721998598; x=1722084998; bh=FMfQNpjgWN4xXeIwpFAXFEEdztK4
	LratBRfhndOo4lQ=; b=dB3CJjxUpwwaUzKsdhhP6pQg+Ceiz2OgOjukDeyfO/PO
	N4lhxT1zvd4DsLRrzOirYEDESd+WhGBK7dOslasLtk3/uMSwkGjbgSHmr76GjCWE
	bCOE6XcG36voosOS9a27hgCd5B8qe2Zp4RWQJD/cDlCq9rHSda5eFfdg3b5tZ1CH
	Le04mirFfjhXnK2xFmcVyzAyANMW13r+wgfAykigqlNsk7X0kCt51VM/L9o0vrSg
	EUyIxrwPtu4s9t6lGE9qF4542p9bj1FJew4+J2oJeImveCYM9PC2Snv4mFdkYU4I
	sHp308CHLQ6WSXlVyG5uK3LUhSDBDJgYGYJkiqRkhw==
X-ME-Sender: <xms:Bp2jZvwthhrg1ew190H2XRTiekctMNdm11LfPQNhYNj8boDFtWwl-g>
    <xme:Bp2jZnQYuAwVO_F4fxwybuNy2rXkAxbb-wjVVuwF-Y9dOM09hNOvmf57Pnb-4fN3z
    -rGz_cvUD4Wxhn31Q>
X-ME-Received: <xmr:Bp2jZpX5quoR2YQLfInG_qwQTGXWYO4Wkod_b65mWuSBiW4kFe9dPtUd3ElIK31QzjAIkxst5LrN3WHNqx6X9gZYutOLNokgVDSqgkoEchlrn0s2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Bp2jZpiORxcOYTUeTes-99iRdcr_mdOhb2sNIyyKw6-HXC5tECKlwg>
    <xmx:Bp2jZhAL-LMLVB7jNTqnJwpx1sTpvFPJJ9KnEDfHen0fJw7KtZal_g>
    <xmx:Bp2jZiKyMw5BE4bn3PJgw4QuN_eu0wTkDsGvn4DSKsZzkSw3r_cDSw>
    <xmx:Bp2jZgD2AqRa7mHKgSizs4zifUMlHNtxuYRAg5ro1xppeaO55hvzfQ>
    <xmx:Bp2jZj0KC8pHIt_gB_OXhXGZuhWIBd8RpkpjWORnR3KuvufHW2Titow9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 08:56:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 51db4b84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jul 2024 12:55:16 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:56:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kyle Lippincott <spectral@google.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
Message-ID: <ZqOc9vxdD4qttkFs@tanuki>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
 <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
 <xmqqfrrxjw8f.fsf@gitster.g>
 <CAO_smVhq=MkQV3a6qJtDiFykvR4im7AX4hMfKMNcL5SegnOSLA@mail.gmail.com>
 <xmqqv80szxgw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nYS2wm6hVchtVVJ9"
Content-Disposition: inline
In-Reply-To: <xmqqv80szxgw.fsf@gitster.g>


--nYS2wm6hVchtVVJ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 07:41:19PM -0700, Junio C Hamano wrote:
> Kyle Lippincott <spectral@google.com> writes:
>=20
> >> > Maybe it's because I'm coming from a C++ environment at
> >> > $JOB that's using Google's gunit and gmock frameworks, where every
> >> > test is in its own function and we usually don't even write the main
> >> > function ourselves, but I have a preference for the separate
> >> > functions.
> >>
> >> If we do not have to write the main at all, then it would make the
> >> separate function that implements a single test a lot more palatable,
> >> and we do not even have to implement and call TEST() macro ;-).
> > ...
> > I tried to think of a way to do
> > this, and they all involved some other system coming along and
> > identifying the tests and code-generating a main function, which also
> > seems like too much magic to me.
>=20
> I thought that automatically generating the boilerplates from the
> visible list of test functions and piecing them together with a
> synthetic main was what was brought up as how libgit2 project does
> this?  It does not sound all that involved and I do not find it a
> rocket science.

As I said when mentioning how libgit2 does it, I'd be happy to present a
working prototype for this if others think it was potentially useful.
Until now I didn't hear any positive feedback thoguh, you're the first
one saying that this might be something that is worth doing.

I just want to avoid wasting time on something that has no chance of
landing in the first place.

Patrick

--nYS2wm6hVchtVVJ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajnPUACgkQVbJhu7ck
PpQeTg//WQeCIlaZY+/FSJr4lfEaVZngOHTbEC556ruygsyV9C4dSeNURTmmJ5pS
BNpIqz3/QXKLx5kKJV8PyUEcWB/VCjqR0m0aLSB+thP3JV1fGR9juZXtpDb88eCN
/eHLlh3yJsupUmBQUwcAUb0H4ReJJLLfolG3H12a7ev4WllSui+sJLNCb6nJJyEe
TqChrQLwVpA77DgEJp8bNCBUEZABvVaaP5d76he4UIhP/Jh26NB+F7/f7ni/ESrD
7hHdvaTg8lYNAR5XlD/HSy7FmRf4H1AwTJFdTP0fArKZsE0PrGENOBmUU0C1G74+
ugyii2DDtacbb2mAkhouwLsSfZs47aWwvJZ/XqUak8ho6mDLfiDVJtV/1AxhzC95
cTjWz3ZuAuTCOO9rt1Yhlp7ruxtCuGvH0vhQZubYRZa2hwznmWno5klAs8YPnWqW
O1kw7sWWymoPrYu897qKin+xOkhNAoj0yP1JBuB9y22XgmXIxkcol0DzATmriZ5Q
9pvuGrVwWynO7wUh6DWfMHffOKBx3Eh9wZWoz/Ksxi4FAo+9pc2dmbnCPr4QMW4K
xleR6yapIh0T17f2IeAFnjq70Nchq9rc4a/+8vbCtRzvUwn4DzFF/QyfSPVvfinS
6lKgNkIlOgioG77nI5tyDMbS7DQIu9WUS784P9XmINrXWmyxBXY=
=gYee
-----END PGP SIGNATURE-----

--nYS2wm6hVchtVVJ9--
