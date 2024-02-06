Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554977F00
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707198668; cv=none; b=m0MFopTghfzuYYFQq+hnlPQ7Wjp9syc3mio2mi7m/LhX1qlV7Y2DyrZFSRAqiWIwQ6+XtYYwNLT9UW9scHzbRF478d2nZCTIsLb5XGsB44OZfwpZR8xzo+RFPPSlKTDwWThTT5MJblLUqVmRjiAwSJvC4bBH6VA2jXmM4yaofd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707198668; c=relaxed/simple;
	bh=KjbRpXOoFxVXiC9RN0Z2LCznHmrlXxtu8kGNGFaiPsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmfNkK/uaMnOk5lBSWYImbytDXv18Rk90dFNRJHqCB6Gj/SBC4lcYuSr9CyJ0uMj9QRE+QLJV1I1rGIi8ukaSC+JaSXOxbIngPXaQ+NDA7TQfVAp/IyOPVYhcSDxp95YO6SfiqD/chmt9PsvmCI11xhccPQ67gwCFhkCa+Gh3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZlBKbZS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAevfFTh; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZlBKbZS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAevfFTh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E1EE21140063;
	Tue,  6 Feb 2024 00:51:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Feb 2024 00:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707198664; x=1707285064; bh=guuQPWKvJN
	9fdzBBgAeBrGX4k9VvZttSbHg5tEn9Ut0=; b=TZlBKbZSDCxZ3aqqmabUV/39F5
	wMnbZq/S/n8vOoC4Dc+DS6SfmHTsLYmg6Q+G0Hi9frKlRYovCkJRsJcC9qUmH32W
	xGPjw2mKSQFHrEd4hZRKt9exq6pgJKiP3DYNbDFap+twI8oH017HHElrRfSeHjtK
	nsFgsjcLWDSXnN/IciRG9ol3JkqHvAEELAusXFuR4hSDy0kZ2LETCfX5JBhF/0OB
	RZVIdjAJ1NmG8UOSOau0niyuSguI2Rg4yWzMd641anKnJnS8Qdr97FWvTrDBUVzN
	RUajr9l/eveUeLlFxchdEUesQmNzZYhWSn+Q+lLBpelnRjb5EywpHZqhEW9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707198664; x=1707285064; bh=guuQPWKvJN9fdzBBgAeBrGX4k9Vv
	ZttSbHg5tEn9Ut0=; b=gAevfFThuQfmO0wCxGveBHi09xOW53FeMF6CT/gkv8LZ
	SXBksBbLImgw1U0RcgY3DghFjT+JhtkZKduxrwPzxstHnqUOs51/UdNlVb1oJg8y
	Hf1NHhdrVj+ur/bOidxpDnJzt+OEjbFzTDm5DxWS31aAYw4koSeOo3zANBmsP6VA
	yoJotPtpIEHvu6SWAv5o6TXpgjKOnf00JnSn7VlcQPM3bP4bEQb4B9V9y3CvTiVT
	KkudrFai+0T2gq/wBiJVy1GzEB9QeJqa/yyptCvCORvh50PvjLJgBkl9tWaIlxkt
	JvSvJCf9M312FGkHl5yEnG5DKRzVmUlKggBx1UBHtA==
X-ME-Sender: <xms:yMjBZc2mQJWrDcYWG1Myy98re4Tra7jpKk8RQGttDi5_kunoxe1eXA>
    <xme:yMjBZXFPVXXXDit_lorkfvbWZeN-G0n5oGhlFNl8vU393YneiYQXLJDWxhIDsmylM
    djuMR_i-uU8EEVprA>
X-ME-Received: <xmr:yMjBZU6xPsxQxT6aA_PrqksnlSyvf_Ea4tIebUThfW_yEAFHsGXUsgiqW0FKHHgdDC3aHKYLapwN4tqiqOFFGx-njvJ0F-2SBUAmvUQxkCN17m9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvefhjefhkefgiefgffejtdfggeejtddvheelgfejkeduiefhteekffehvdfggefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmpdhgihhtqd
    hstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yMjBZV3-yKYGNZNUslADpr5W2nNW6pQYEEhdj13-aiIu5ghQp8xQ-g>
    <xmx:yMjBZfGfG_iLFww6UCjdzTYX3RLIC5_3c2TmJC7uCXutHMIzUemKzA>
    <xmx:yMjBZe87iGYV1YRsKjBQfzOtM-CHKejjb8FzUC8ov63rIll2zE_55A>
    <xmx:yMjBZe2X5cbij2w0FSWB1zIp1ElqByv8OB63T7bl3Y2FCXqY8miWjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 00:51:03 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f856a813 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 05:47:33 +0000 (UTC)
Date: Tue, 6 Feb 2024 06:51:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] Add ideas for GSoC 2024
Message-ID: <ZcHIxcrKbgyhdyWn@tanuki>
References: <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <106b8e7be9ddc2d24670b01d54347dfcf9aef196.1707122040.git.ps@pks.im>
 <CAP8UFD3F95TzytdpKO=LLf6Y_ejxwh9QtgAxRNKgMXW-72hjgQ@mail.gmail.com>
 <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ic5yB1Y78sawGb+k"
Content-Disposition: inline
In-Reply-To: <e1c04f67-5981-4393-8a8e-a28cc53858eb@gmail.com>


--Ic5yB1Y78sawGb+k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 12:25:31AM +0530, Kaartic Sivaraam wrote:
> Hi Patrick, Christian and all,
>=20
> On 05/02/24 22:13, Christian Couder wrote:
> >=20
> > Thanks a lot for these ideas! I have applied your patch and pushed it.
> >=20
>=20
> Yeah. Thanks for sharing these great ideas! I've submitted the application
> using the new ideas page now as mentioned in the parent thread.
>=20
> > > +### Convert reftable unit tests to use the unit testing framework
> > > +
> > > +The "reftable" unit tests in "t0032-reftable-unittest.sh"
> > > +predate the unit testing framework that was recently
> > > +introduced into Git. These tests should be converted to use
> > > +the new framework.
> > > +
> > > +See:
> > > +
> > > +  - this discussion <https://lore.kernel.org/git/cover.1692297001.gi=
t.steadmon@google.com/>
> > > +
> > > +Expected Project Size: 175 hours or 350 hours
> > > +
> > > +Difficulty: Low
> >=20
> > "Difficulty: Low" might not be very accurate from the point of view of
> > contributors. I think it's always quite difficult to contribute
> > something significant to Git, and sometimes more than we expected.
> >=20
>=20
> Makes sense. Also, I'm kind of cat-one-the-wall about whether it makes se=
nse
> to have two projects about the unit test migration effort itself. If we're
> clear that both of them would not overlap, it should be fine. Otherwise, =
it
> would be better to merge them as Patrick suggests.

I don't quite mind either way. I think overall we have enough tests that
can be converted even if both projects got picked up separately. And the
reftable unit tests are a bit more involved than the other tests given
that their coding style doesn't fit at all into the Git project. So it's
not like they can just be copied over, they definitely need some special
care.

Also, the technical complexity of the "reftable" backend is rather high,
which is another hurdle to take.

Which overall makes me lean more towards keeping this as a separate
project now that I think about it.

> That said, how helpful would it be to link the following doc in the unit
> testing related ideas?
>=20
> https://github.com/git/git/blob/master/Documentation/technical/unit-tests=
=2Etxt

Makes sense to me.

> > > +### Implement consistency checks for refs
> > > +
> >>
> >> [ ... snip ... ]
> >>
> > > +
> > > +  - https://lore.kernel.org/git/6cfee0e4-3285-4f18-91ff-d097da9de737=
@rd10.de/
> > > +  - https://lore.kernel.org/git/cover.1706601199.git.ps@pks.im/
> > > +
> >> [ .... snip ... ]
> > > +
> > > +### Implement support for reftables in "dumb" HTTP transport
>=20
> Would it worth linking the reftable technical doc for the above ideas?
>=20
> https://git-scm.com/docs/reftable
>=20
> I could see it goes into a lot of detail. I'm just wondering if link to it
> would help someone who's looking to learn about reftable.

Definitely doesn't hurt.

Patrick

--Ic5yB1Y78sawGb+k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXByMQACgkQVbJhu7ck
PpRWtQ/+MViVZAM/seyvvQomTWxEVZNVB/UO/S3jMkNAkwMrwhSvipulKR8hqgTU
E6KDdiRdVQjYINq7U45WCY916aNXPi6wdOkObtDb+KvQufvhQnV760OBiPLPnjOO
gG1tZbWBa/pyi7hU5J0eDQfIKMHYYLuXclqEvSh0pVuoCu0lChlk3TvSYf9+GUG3
NYdwRyqW5ilQ209RkibY01Kz7N15pLMXXtTFElFNuFiou87xtQlCTz2dCKlBPa9L
oq+WW+74qpe7bPXJMdwTVaUR8jbFmD5cvUPRrrXUfGZRdJnxdR67uAKiWHYLk0IN
LHmKx9KXUJlWqnfunHeW7M4OJVXibKtT1I6O3Y3q4GnPGhGUyaEiajlsD1U9CC3C
XlQ+6BLsx0CUl+PjruTjptHMmumdHF2QmniQvPBCdvcOG6g2oOWxtvPuV6KElJbf
zBF3c82y+T41+nxHpyuzxj9uBGD3Gn9UU4UFXUS7jNjiqMTZoVE7ZH/9GryXBBmM
DUPmffXYKH49OGv49I/ZTV+so76uEUcNDoPG1gwdgZxlsjd8fDEA1B8YqYxdpfRE
Momq0tAmRCd6x/67k+p3LiYe1UjlIwPjuhoqWEcg9KsJlK6UVaI+1xF9vr6fulza
qz+w99AHkz1QgE6APfsoiPQ1xFmkgMkssyVRGleZnoIEgp5+ClQ=
=KPsV
-----END PGP SIGNATURE-----

--Ic5yB1Y78sawGb+k--
