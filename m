Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FF10A14
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718002874; cv=none; b=QzIuE+22AEiG5tV3Bl8XbqBW1RRdpgcF4JY7ONxJIncccHyYsxZdzNGdAdGLq/DPhOYJADpooGewfMYlcpzwmRoMIE1D4pSUzTEyYiOBl9xxpSzN1plg22Jfh260oVeSMSMWWxrLD57hqg4F3/+RBtr49dDxmVzgmYoR8W6/vWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718002874; c=relaxed/simple;
	bh=hoAixqZwklrVltt6cd4YzwImsSdCVu9h/Byph7u3FUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLMQ3v8Qh9QEyP7sr14V4yxOBDWthQ4h5RK/k9u6bPwHQqftXYTJDOyNt4RaDEXs3nnE7Fw32UEd7722SEQsqGMddTDWYZWxlwTfcqS6bG3Dstn4rG5NLPdiXBVq8EPKbbiFCQeDhMxGtt1gMl5X+cOmfTTErSZs3uWZOd2Y6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QvTJvmfd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QunEKKeH; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QvTJvmfd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QunEKKeH"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0FE791800081;
	Mon, 10 Jun 2024 03:01:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 10 Jun 2024 03:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718002871; x=1718089271; bh=P8USY8egEw
	HDhxJHPvPpejYdW7dQyNARkNay+2Crzv4=; b=QvTJvmfdnawbKX/0ffzntnfE54
	dRbijGaGRotO+5ev+H57I2d1NuetOXmV7zyz9HAGxzEjp74zz4y9qB899CH4fWVD
	j1c2XghTg0daFyX5mwPIHpOg4OTltRJxuiXgMLVbcWcZqiwJlbr6nj0xqJVDbpEy
	6yTIx55q1nkqFmvEYXpd2DVNHDHZTqhHvVhwYfkEWA64DZNAca3rBxFdaYnUTnxF
	1ALuuJr5cA5ez3PKzr0IFNENFeQpGG4rQ2ETwFiC9GGu34zxFZgZRSLZIPJGFVyD
	/8FC/n0bcZPN8RMEeUYj4QUIgasInNHxK4oK4gnMn3EhYv7/lrUIneh1KyQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718002871; x=1718089271; bh=P8USY8egEwHDhxJHPvPpejYdW7dQ
	yNARkNay+2Crzv4=; b=QunEKKeHa3ZWs8xD/cgii/JeFoGbAKsFALvChz26AGsq
	+eqL9ZV7bIDYCg/9y8j1QLemRjEpcJbMh7I2fl0NsmOGMlQU5BT5Ss6vIFjr8Qsd
	iph6xKKPVh7HLii+RIo11brkWODth7TJ34otRFj2qn/Knf/qAtfM1Uv7NvgRTPWM
	1vdksJplx+/rZSJ/LgiCYXSOroORiW3yOdIjCgtJpEocDonZ7Q1THR6ysvj4LqTu
	zQtSMLBDfWQLmv9YHcQoiBlaUdfFKWKWHpzddZpOUmU/D9umkgiEUW1ysWAUjALE
	IzIk9meOzdVTwA3NO9mMkG0rIH0U41dK9bMMLWx+oA==
X-ME-Sender: <xms:t6RmZkU5volx1QxDILCmOqvAsODlfr8RebQEB4-rk5W-R-Zp2NSyrA>
    <xme:t6RmZol8BHcYttQ4dvNctqtwJHihw-yuBKqiTE7XVw-6FWZj9bsuN48hTENACMQ0Y
    kZkoFezIWchbbQqHA>
X-ME-Received: <xmr:t6RmZoZ0eEin0Zrs6smA5PUNCY6cpWJj0G-oltjWp6D6CyWsELG1jtXaskA5LKMc-p32DLoKAMvIlqaKUZ3izZzYN7TtJlZXunCmM46s7iL5cSSK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:t6RmZjVtZfgdPNEs3G_RLRsFqhesjVBDtTvAoNOc6-efdnKqsxNCtA>
    <xmx:t6RmZunhbMLoJvwr2DwGvsgScTAHO28Qurk9ol39oBYcAojQTvLs2w>
    <xmx:t6RmZociBm0hLHBFumkTDSkRcyJFA6kuWz8s0kb_h0mOS16dC3gmXg>
    <xmx:t6RmZgGPs0c4i2Ob-oUPaVE_7tfroq9v9EKi1chN2VszIwZDe5n-wg>
    <xmx:t6RmZgiyZ5mBslcckz2PMeUlGrNGQU7X0Hvl94VgYN5lm13gr-Hm3DbE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 03:01:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fb43a85b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 07:01:01 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:01:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] Makefile: add ability to append to CFLAGS and
 LDFLAGS
Message-ID: <ZmaksqGEpLcMCjrn@tanuki>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
 <d68539834f3827fa3ffe91517e053c043243a378.1717742752.git.ps@pks.im>
 <20240608085528.GD2390433@coredump.intra.peff.net>
 <xmqq4ja3cl87.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pSF9xpcNOk+W8wSb"
Content-Disposition: inline
In-Reply-To: <xmqq4ja3cl87.fsf@gitster.g>


--pSF9xpcNOk+W8wSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:01:28PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Another way to do this is just:
> >
> > diff --git a/Makefile b/Makefile
> > index 2f5f16847a..9cd3b252ff 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1446,8 +1446,8 @@ ALL_COMMANDS_TO_INSTALL +=3D git-upload-archive$(=
X)
> >  ALL_COMMANDS_TO_INSTALL +=3D git-upload-pack$(X)
> >  endif
> > =20
> > -ALL_CFLAGS =3D $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
> > -ALL_LDFLAGS =3D $(LDFLAGS)
> > +ALL_CFLAGS =3D $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS) $(CFLAGS_APPE=
ND)
> > +ALL_LDFLAGS =3D $(LDFLAGS) $(LDFLAGS_APPEND)
>=20
> Much nicer.

Agreed, this is much nicer. Will adapt, thanks!

Patrick

--pSF9xpcNOk+W8wSb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmpLEACgkQVbJhu7ck
PpTOtQ/+PuuuEeyzqlNCIvaSKF51MBFbzBsI98yyj32KN/Upb9EyORtu8/GEk14s
ZukRiHniiqmURLJUgLyxnEQSMSphc+5HE/XS91djHYUJljYCiP8CsW3F7tfMn4yq
BbIHdZ9XnRjyRImu1oftMfaTcqBick3dW5tVyG0nJh88vpC9y/j8wpzWUein+5Eo
zUu7woWmoSy6lSRg64wvU/CLHtBKr3/qBtDImfcgjKn+F+mO+7IkEeIBQ1g3H+7k
s25jykng5QqbO/CoybxcV8wBIxd5w166PUp49FR4B0tomdkmr7hqwEDZW9DUCjW7
eZGQ16YIJ+mneKRYljznvYodhwqUpE+Frx736cymLDodYieagiNHCAOG2P7NApQu
GAEkGtP7R2+iCaflNWjg/1mFt2NFJD8qmenv0dNCZhLGBiM6Zhmfqs9BZDh3etcL
Yc2qc0gilUd/K6ii2zWu6L/4B7OCtvlc7UvQbmUV2Ieh0/s7Cfwpsw9GHOEHD9LH
Km8zQbAY50Hq4aCO8T1A1VbPoVMcOQ8LOkraxHomNWpftP4VaYFprvaJVdqY6RbJ
SXx0zhQnrTwC4aUIuD2a8wQEJG1JTq3vKnABBaUpztwJ6HomDs9wx9UtPKD0oeiW
Hf0PaBfqR2SNEkUVAk7pepLZinqZVQqOoJug7igdC3zyvwyW2mM=
=8IQq
-----END PGP SIGNATURE-----

--pSF9xpcNOk+W8wSb--
