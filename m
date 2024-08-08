Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485532F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093517; cv=none; b=uCfoirH+FA/9vZpE+zz0RznPCG6dCptRnDKXYBIj/JOrydEnF/QFc/HL0KgxhF6RnzFmZE50Gdx0wSqCEyQjPFW8lTzcg8y1EFRLUJ+cUnlg6Op5kWe9f/oKkSaQbK0nQJAJMWsDCUJjBDq/hW/6/JH1Ual89Fkao84FM++PODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093517; c=relaxed/simple;
	bh=GL2aPwTBP/ZSv9G0m5qixo5Ywtjl3YPznpZyk1qN1go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axFzdVClLkV8+TDDyUvXnsK0QpoO0F792vnpc0wNMfGsCLMmnn8HnrsS8KasWcmCG25Arm159ZmIuA90KkrB3VfBWEo9EYq4yYr7JMsBHariOUOR/pT+tOitzmQEnl5y4PlHvGSxIewYm7xDGm8DUkkJA+x3IFjhMrvG3gCioxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eSFBJ42I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ciEyn3FE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eSFBJ42I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ciEyn3FE"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8852D138FD92;
	Thu,  8 Aug 2024 01:05:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 01:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093515; x=1723179915; bh=6eDp+Q58Nl
	tj9buAuAfyLV+IHQF35XVwdyM976Fm72Q=; b=eSFBJ42I53fr/IctsBXQVpR5m+
	3hBs5wWU7UfWeIGo4I9NYPKAb3LzNAKgQwuJhNmhAcYaXAj8YrfXN3HhjZ2loX/n
	p1cMQ66kq7OYtzOHOplvSxTrKNf2rsKsgAEb0SrqaJIdIGAl/VSg9IobJDo9Wj4T
	cazuVbZ3wA2EXbnNqIUNYJcABVR5omcVr6BM1YyqKXr686GSTEw4zJCTfQsu+AC0
	sRJX+g8SKXpxcrl3yudvV/GXRyGQExYh9vSkaBmgMaqJC7tcPipa13C6IIH46asU
	HCTlPPP6WJ30djCrir1oOvkhSlWuV2aLOHnYVeOxaUsF9hWtqhNbO2j3r8Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093515; x=1723179915; bh=6eDp+Q58Nltj9buAuAfyLV+IHQF3
	5XVwdyM976Fm72Q=; b=ciEyn3FEilaEo+S69XOzW8903MrHvxHcaZjXVDotAN+D
	K+GEbxrwNIbvmR5VCdUX6eDXa1x3C9HhbVm8wtwVrw4eWTzlPEyS5BV3Y3N2MS6j
	EB+agHoU2kXDSC4BQJzqQ0rNKP8eFRy2WQc5VXYxYDTOc9ITCT4P/FlZwzz6Y/u8
	3V3e4/9bqk/YXg/c0jBppwru8g5HPs9HPkpivn549k8mdkcWe9LLkxiEQL5S9E1x
	iEbY9AlNXXEm+Y+Evgi/sARLFXY82s/GipYiSrfBTxsQo/MVgrCetlGqBtpcLHoM
	vQ1glnXQw1VhsxCzBOXGXfeUCsvUHAa6uU1wSLl6nA==
X-ME-Sender: <xms:C1K0ZrvHeEunDDow96066AQuPGG6t8THmdVOASmFUIOSrcjdnldVYw>
    <xme:C1K0ZscoOThdMxSWrgbhMqzj0JRhh8eyTtkuFTePdFyP3-ONrkTeVbkgqbUl6BT4d
    I2uM3pfidUKKQnRdQ>
X-ME-Received: <xmr:C1K0Zux-zWuJYKo3VOegih_Kt3EEnY4tsSyWK4DL7CGjtcisH44h6JkeJIq1b3wvTaBTI5Qsd0CBwhhA99swoamErKLXCuQ9f0zK_ziag3s92o7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:C1K0ZqN--nT58_7kvaGIS74qmOiUf5jyimSrDOrSgbisOqIGnuO1oQ>
    <xmx:C1K0Zr8h9jC0qQQV07KHqhcR6MiAJ_MUG08iKn7vX9z_LQwuuvOAfA>
    <xmx:C1K0ZqWUGDpg3j84aHNgWJol8dZoy4YOqn1SzjGBM4efPJ2GeRN4_Q>
    <xmx:C1K0ZscZvWI444CFwhWbopEyXht85-_62tyiNvPJbLZabRtfNxzyDg>
    <xmx:C1K0ZtIHFm3N72mX0rZJwW_C_qrWTPw_RnPYp6Bx0YILxmrZB81v8kr5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:05:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a958c79b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:05:07 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:05:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 18/22] builtin/format-patch: fix various trivial memory
 leaks
Message-ID: <ZrRSB46ZxHFU1X-5@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <bf818a8a79385af739345e22c74550acd5f31a0b.1722933643.git.ps@pks.im>
 <D39JV83QXD5C.3U74JE9YD5SGO@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a29GwF9JIEIQt6mT"
Content-Disposition: inline
In-Reply-To: <D39JV83QXD5C.3U74JE9YD5SGO@jamesliu.io>


--a29GwF9JIEIQt6mT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 06:51:52PM +1000, James Liu wrote:
> > diff --git a/builtin/log.c b/builtin/log.c
> > index a73a767606..ff997a0d0e 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -2023,6 +2024,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> >  	const char *rfc =3D NULL;
> >  	int creation_factor =3D -1;
> >  	const char *signature =3D git_version_string;
> > +	char *signature_to_free =3D NULL;
> >  	char *signature_file_arg =3D NULL;
> >  	struct keep_callback_data keep_callback_data =3D {
> >  		.cfg =3D &cfg,
> > @@ -2443,7 +2445,7 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
> > =20
> >  		if (strbuf_read_file(&buf, signature_file, 128) < 0)
> >  			die_errno(_("unable to read signature file '%s'"), signature_file);
> > -		signature =3D strbuf_detach(&buf, NULL);
> > +		signature =3D signature_to_free =3D strbuf_detach(&buf, NULL);
>=20
> Do I understand this correctly, that the multiple assignment here allows
> us to maintain a reference to the pointer returned by `strbuf_detach()`
> in `signature_to_free`, and we do this because `signature` can take on a
> different value below?

Not only below, but also its default value is `git_version_string`,
which is a string constant. So we use the multiple assignment such that
we can avoid freeing `signature`, which may contain string constants,
and unconditionally free `signature_to_free` because that variable
always holds an allocated string or a `NULL` pointer.

Patrick

> >  	} else if (cfg.signature) {
> >  		signature =3D cfg.signature;
> >  	}
>=20
>=20

--a29GwF9JIEIQt6mT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UgYACgkQVbJhu7ck
PpQLkA/5AdSLe0shMf5bASpNmxUQqSKCnW6LaAq4IkfFs4OHDIKvtOgV9xrhRfUF
gyJ3uD9300bohNrdovCDVQUZ7Ttz+XdydiqPTyO2X3P2Zqcbu6pBeLyZkyhQmDYq
EHrYvQlEvUaCgpOAGZF9MotV418mdiMVK2p6h9N0Ny5d9NwaNlvpG/+i418FPrbv
32dmPCBFjN89gKcAeMwwdDjoKTiThY9Dux7DCmAf48kIDGvZMqu+N2P+CPTbotLp
iXDQBQtQr1NKdFJFieKB0O22t+oROxNiiZLlmphHWHJ9Q4p3zrEbkdEkM/1LWK+V
TciEb9u3EZKcBLPnPhRzjEhJt9KR1Wlt5hH9krQNlX6GL3JOOG/dI9Z3eNvIo73Y
E5K256c4w+jQulX7sh0l0wlibu1wnoE0hWmrTUYyDK19jSd9xImnkTt+d9HhDA0I
tUhtBlNGJ4SaSR/UScdu+AJFdTRMs6HXT9M9T2meFK1dzoSWvQpmWnPaJSxZuSVg
Rxb0wUBLWpVc7EIn7YLU3e+5MAL7orBX3nhN96Ve0fOz4LLXVSlujcO/7G4mDyYq
u9dwSvjye2EC39DPJk32UNL3Ohjb3BVWYCuSbbTHKSNdfcREQTg5yY/xwA+385A+
sbWDQHNODZ+B/HcHfFUgVdcIrQPyK+0F0wobncl8PW976OE1K4Y=
=9ptg
-----END PGP SIGNATURE-----

--a29GwF9JIEIQt6mT--
