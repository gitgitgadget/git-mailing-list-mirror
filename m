Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1984DA0B
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780332; cv=none; b=LNYBmD2RHXrzrn4UHifEbuiL59aCTDtNDBitPBfegwlKdyAiGXsCbd+eKbUFVpJ1rZaWTJBypOpmZZZlMvXWIOsEeWCDvWquL0CZqD4WU1VWOikurQJz53q5dKzOh/+yMW1BKB4Yspw93Exa9aNxaKsbWdaPwjNRwjfBgqNenSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780332; c=relaxed/simple;
	bh=9MY/Iqr7MQVkaBhcVxrk9tTQY9dJhTEfs3dIGkDJ6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyRxPw4bYKEdjL8ecYJNsmg2dNFHzJA5l5zC4XYCO1azVKPkXK/q2SWRJg/YGR50UfTVOfH2EsT23SfLxVkeaWygOr5ixxFuLBTT1/3p0nih9l7DuUGdLnsGXif8SpZ8AgKpJOKT1McG7Z09lF7u+va0INfsag2ZRlp4ZFe9ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e4kY1cfZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mw+K81BF; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e4kY1cfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mw+K81BF"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 69E303200A3C;
	Thu,  1 Feb 2024 04:38:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 01 Feb 2024 04:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706780327; x=1706866727; bh=9MY/Iqr7MQ
	VkaBhcVxrk9tTQY9dJhTEfs3dIGkDJ6Tc=; b=e4kY1cfZpSO5d9QDvj/0o6DyPP
	IsM3biQ/Zthxv/CcWyAr3PfaRpKLMwzugPpykms7vRRjp327MQWh08OgdDy8oC2i
	r4VwVg3a2VbBaPiMWpWlKzwt2363NGNfgJPtrArKW+ucQnwJRVdRtGgOUJBjukE5
	eL2EeCKNWdGtdVeminKJ9Qfv2bMjUbjX/HE6WYSeptVyP3n6HKzyFB+HgF3dRE5t
	AbxaLA1yRzgXXS2b9c+LsrBE+XUQiBftZs40DU5CoFVSaWqiL0gc/xt2/c4eRKYu
	8BW6VHOGs2knUNM1uwxTS4g1FGxa42PzE0V25LwAEY0lBYZtSUBw2Q1sBa0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706780327; x=1706866727; bh=9MY/Iqr7MQVkaBhcVxrk9tTQY9dJ
	hTEfs3dIGkDJ6Tc=; b=Mw+K81BFboAfQcK2kFZ+Nl8g4E+vQtsoO6JWQe2bClhd
	FcbOqqC6weh29WtygDVav/6PTe5GZx9LeeMY/FhjVXPwptwqaJxr4e5taW2ttlx3
	tnPxoFjVceQKFTSv4w9F0C9yVIhZMR23Glers8cm4U1B3piI3mgpUbC44wKAS6Gm
	bv5hLjJXkZzhlGy+3UFBE78Td/dXoVu/09SvJ1LeZT96qmBQP3IzKMXUhChJ4/KC
	p5IyxnaYcXGBJ1XoSiCPQSyvuKxM4nSYX0BKU9h7LUsr8NrOsBK2VM0WZ30YUcBq
	Lk9CZixZyUei1kwLkR35uSRZ4L20BNxkvfYdwZkJ2A==
X-ME-Sender: <xms:p2a7ZXUqoLi-Ivs-fW1dtjqeJsgZTIrldCGEa_vfTG-akdtnOg6LNg>
    <xme:p2a7ZflNKWR8VBxSHp8aNeCber37fW-SXBy4pGUI7lStxr-rh1ixU3ZiVkFnX_Vv-
    s9F0dL-I7-zP3i4MQ>
X-ME-Received: <xmr:p2a7ZTZBkIimE8kN-7O88yAr5DX_jJaiqiW5RLJLY5V7M4T_4mKy5lRIoYYmTsjBWdYAX8hqJJpL9iwGQOpk14rsXQGuW_hggHFmjNGIhy8WBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggu
    jgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuc
    eophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleehvdejtdfgteehfedulefh
    hfekffeugeffudettdeguedvieekjeefkeeuveeknecuffhomhgrihhnpehgihhthhhusg
    drihhopdhgohhoghhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:p2a7ZSW0rfYgHD-3KJg1MHv3hf-P5CAjE1OIe0Vcx3Cw6A4SSYJQKw>
    <xmx:p2a7ZRm2LnxSU3fGP0vTn_OEtRAwW1huF_nqGpSkyZfyNy3M021YDQ>
    <xmx:p2a7ZfeacOUR8GM7-7fvVvRtxEjL4pUYv93zDwhmS5-pClFVHH0L-g>
    <xmx:p2a7ZfYWcemSZI-Ctwy7R-TcA28qIUZMSZMCz7UbSN_dh9mHgeiZJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 04:38:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e737c38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 09:35:21 +0000 (UTC)
Date: Thu, 1 Feb 2024 10:38:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Git in GSoC 2024
Message-ID: <Zbtmoo8qTmj-yt99@tanuki>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki>
 <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LXYk5VC9gHkci+YD"
Content-Disposition: inline
In-Reply-To: <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>


--LXYk5VC9gHkci+YD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:27:13PM +0530, Kaartic Sivaraam wrote:
> Hi Patrick,
>=20
> On 31 January 2024 6:40:36 pm IST, Patrick Steinhardt <ps@pks.im> wrote:
> > On Tue, Jan 30, 2024 at 10:08:53AM +0100, Patrick Steinhardt wrote:
> > > On Tue, Jan 30, 2024 at 09:38:48AM +0100, Christian Couder wrote:
> > >=20
> > > Yes, the tests in t0032-reftable-unittest.sh should be ported over to
> > > the new unit test framework eventually, and I think that this might b=
e a
> > > good GSoC project indeed.
> > >=20
>=20
> Nice. Good to hear that.
>=20
> > > If there is interest I'd also be happy to draft up some more topics in
> > > the context of refs and the reftable backend. I'm sure there should be
> > > some topics here that would be a good fit for the GSoC project, and I=
'd
> > > be happy to mentor any such project in this context.
> >=20
>=20
> Great. Thanks for your interest in willing to mentor!
>=20
> I created a fairly rough SoC ideas page for now including a barebones
> information about the unit test migration idea:
>=20
> https://git.github.io/SoC-2024-Ideas/
>=20
> Note well that the existing idea's description is far from complete and I
> mostly just cooked it up to serve as a template for how the idea entry co=
uld
> look like. Kindly contribute towards elaborating the same :-)
>=20
> Also, feel free to suggest ideas you have around refs and reftable backed,
> Patrick. Those would be helpful.

I'll have a the beginning of next week and will think about topics
meanwhile.

> > I noticed that the starting period falls right into my honeymoon from
> > June 17th until July 19th. This unfortunately makes it quite a lot
> > harder for me to mentor projects alone. Still, I'd be happy to co-mentor
> > or help out in other ways.
> >=20
>=20
> I too don't believe your vacation is going to be a deal breaker for you
> being a mentor. It should be totally fine given that we get a backup ment=
or
> who is also willing to mentor the candidate. (side note: I myself have no
> knowledge about refs backends. So, I suppose I might not be able to help
> co-mentor this one).
>=20
> Reg. the timline [1] Jun 17th won't be much of the start. The community
> bonding period starts May 1. Many contributors typically start dipping th=
eir
> toes into their project right away. So, you would have ample time before =
the
> start of the vacation to set the contributor up and going with the projec=
t.
>=20
> [1]: https://developers.google.com/open-source/gsoc/timeline

Yeah, as long as there is a co-mentor that can take over during my
absence I'm happy to do it. Karthik said that he'd be willing to cover
me, which I think would be a good fit given that he's already got quite
a bit of exposure to the reftable backend internally at GitLab. Thanks!

Patrick

--LXYk5VC9gHkci+YD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7ZqEACgkQVbJhu7ck
PpRWjA//QiAS49/G9r+Yf027GCDgB4HvZy4Sry2f4QaBeRZP4lyismS3R4paeWjg
Fg3oD+VzAPhq0sVdjxmliCXD+PaVw47h2OOOGwV//eJlFl/5snJTYvCAENyDIS23
ZtMuvQT9ud1Hqzn4NcSUoA2M89SrmYGvOk6Pk5n+h/khOJcxhBXaUJuZfGB9ZbUN
8ycKer3maA56e3KjoIqBoZqTEZKTNeailsoaKWSW48dBwFBvclO5QhbtGEGPXZjr
cc1Rk9lmCaTE+xHkV18DW/hSTHFLcK0Am18WjQ4TZQlwGo1/k7+DpUbMW+OVCx9P
rMF5eGozPLfS4gcFRsennkKeR1CxvwkOQjKVu9HEXXfpozp/aKN5faq8bmh8sHPN
xTlzw8XyCNIhLYqgrTUj1ddShyoZfv2GKs2usWtaFVsCe8caQHeIppYOG3kWFUv5
7iMskhkrxo9uiZt5caEEietBHEKfjOr+yWVODQ5y+Gu3T9x/mnUnt/XJ4y3rlMLK
QTCWfSlMOJyPY7ByLKStgn8Ks5oeUS+SjcfRgsraqQ8Ulk9RfD96GFAwEF+imlh1
Cyd7eJF5jYcf6nPRqsHtwZHmhnFay8YGckhtMCUtQwtYiNRdCr3ihECydrvVrKIs
8Hw2mFXTUzS305ilz42WX0p9tn6QwPP7Bdiknx0vKvoZuoxCQXE=
=licr
-----END PGP SIGNATURE-----

--LXYk5VC9gHkci+YD--
