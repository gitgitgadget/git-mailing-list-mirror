Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC622747F
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 05:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134297; cv=none; b=jvfLAzNr3gxV0ViAc74XjW8Xc55IW7fr+W+R9iJ/iypB8vb5ipQCuxcVjRK/OeKMWwk6g2Lk7k/Fb07m+IZdniGoCNIL7zDDImlbNvN6xUrOiY7SLzqNst6l2akLyGbEHARx2WSQwqvevkk3dWcaadA0vEqwat4K9AC6MigY8y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134297; c=relaxed/simple;
	bh=BVYCOFXKbHlgqrjfFGxvb9x0EWtVa+wvllJG2bVcDiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI8Wxa0siG+oBakZ8e/TLfPFXGmmKnYCr6X1O8QH/j8qHl4NwZoGyl5uPtIGqY+16jUIY0Mmd79rF4WWCM0zYOCr2O0BqttYnaeH/IpC5ffpy3NOZyRsjtDWiyO5/lv+0GvHJ+hm+L7lnIdSbOCppKNIJTeBZ/IY7G5DCG/Vd7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tCaz5/d1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dHgsXTyH; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tCaz5/d1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dHgsXTyH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7324C1380090;
	Mon, 11 Mar 2024 01:18:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Mar 2024 01:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710134292; x=1710220692; bh=TQpRIMdbgz
	nLXN4a1GfCyOcNSvoctwKAmkwYfAB2JT8=; b=tCaz5/d1GGd3SgIoOzMpDKdhvS
	kLxru9GxWZ8Vp1j0odHRdcTiKS0PFs4xswkAEfISNgrzvIHv4ymPdxSeDN4vyFv+
	E0VeCotD5u3yywq+hC8joYKJx/v38+VJot6ocejjn52MYFxZbX5UFwMeCELiFoCK
	nD73cUCOaqqnus56TtEMlBIeGleZs+fygUrn+M0Okr5EIJK9eTqlPRWSTbeLspIf
	sbqc5cSNgy72e3zZqXNixo0gp1LH2W7WCvZaWNS4R2mikqrwkARSaWmHh1emf9iq
	ErnkzHdsQ1ll85SAEu0ZE29//XTJSUPT+5VELW9+107k+0HCWgFx/4q99B3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710134292; x=1710220692; bh=TQpRIMdbgznLXN4a1GfCyOcNSvoc
	twKAmkwYfAB2JT8=; b=dHgsXTyHKd3WpJYSrKTStujIoEZewAF0yZFLd/qICHl9
	om6KdXJQ2l6kf/QpFURR799VM9dqQX/WPvB+Osfnswx9CoaD8/NJTI0y1+BWlMbZ
	3627JjJKWqEW7EGytpkRmn9Nuo1HtZtlRg/oB5JBA5FT78oJ5iNejp/rICwIfwML
	p0mPsTZz+MfadolOkerprCRur5NU8eSJ265r3Wsj69FBG6dTRbHp57w4mqc4maeC
	mrO8dbivVWC0SyGgljKqWBHYgz/bsiKZ6wWW5J5jEWX/I8laxDw1vzsIm5r2+p8+
	JygUj4gOxrlmp2hAPwlxUyEZ2c6ENYlyroWwpu9swg==
X-ME-Sender: <xms:FJTuZf8-8lr6EY5l1dscpCYjSyybtQ4CPBkiyY2U5KtGL9PusK9p0A>
    <xme:FJTuZbsIyNpF_O3uJrAZcZLwRh8P1sddpQZITayyOsbI_DljUmA2eTT2H0jdV-JBo
    0XRczq8vZk2P_NHCQ>
X-ME-Received: <xmr:FJTuZdARyAzs3LWD-SmUap0vNWAk9z2kzHewV8wrQFdA0Ukla0gJFtyhc-tt1cEa_8VwJZyNShMX7bXw9ZRiN6snSxFvTi2zVA79_gWOOWj3vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedtgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FJTuZbfh00GG88uWpt5Ux4IqZRA49tT9nfAMMLA9Ez2PrGc3X49XBw>
    <xmx:FJTuZUNJ-WbD0cbk9tObNT-yrt020LAHu45zdD5mdstk2JnsSk_SQQ>
    <xmx:FJTuZdn_oPT7ZFQ6ELzqzzJ5PG_CXNsIV1AgT1BpnHvaHpkCu8mDuw>
    <xmx:FJTuZdYbHQs4nBtF9Q6bbWgLw0Dn7OZZyZ74sIb3BEjvVARWnUOpag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 01:18:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff91243b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 05:13:33 +0000 (UTC)
Date: Mon, 11 Mar 2024 06:18:06 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] reftable/block: fix binary search over restart
 counter
Message-ID: <Ze6UDkipgNsDVCwf@tanuki>
References: <a4312698cceab5f2438c9dd34465da21d719e256.1709825186.git.ps@pks.im>
 <cover.1709843663.git.ps@pks.im>
 <370b608f9007abe9c0562d76894e2475d19867a1.1709843663.git.ps@pks.im>
 <xmqq7cidk4e4.fsf@gitster.g>
 <xmqq34t1k12p.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="89LvlXqT8VTETYaT"
Content-Disposition: inline
In-Reply-To: <xmqq34t1k12p.fsf@gitster.g>


--89LvlXqT8VTETYaT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 04:40:46PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> The consequence is that `binsearch()` essentially always returns 0,
> >> indicacting to us that we must start searching right at the beginning =
of
> >> the block. This works by chance because we now always do a linear scan
> >> from the start of the block, and thus we would still end up finding the
> >> desired record. But needless to say, this makes the optimization quite
> >> useless.
>=20
> >> Fix this bug by returning whether the current key is smaller than the
> >> searched key. As the current behaviour was correct it is not possible =
to
> >> write a test. Furthermore it is also not really possible to demonstrate
> >> in a benchmark that this fix speeds up seeking records.
> >
> > This is an amusing bug. =20
>=20
> Having said all that.
>=20
> I have to wonder if it is the custom implementation of binsearch()
> the reftable/basic.c file has, not this particular comparison
> callback.  It makes an unusual expectation on the comparison
> function, unlike bsearch(3) whose compar(a,b) is expected to return
> an answer with the same sign as "a - b".
>=20
> I just checked the binary search loops we have in the core part of
> the system, like the one in hash-lookup.c (which takes advantage of
> the random and uniform nature of hashed values to converge faster
> than log2) and ones in builtin/pack-objects.c (both of which are
> absolute bog-standard).  Luckily, we do not use such an unusual
> convention (well, we avoid overhead of compar callbacks to begin
> with, so it is a bit of apples-to-oranges comparison).

Very true, this behaviour cought me by surprise, as well, and I do think
it's quite easy to get wrong. Now I would've understood if `binsearch()`
were able to handle and forward errors to the caller by passing -1. And
I almost thought that was the case because `restart_key_less()` can
indeed fail, and it would return a negative value if so. But that error
return code is then not taken as an indicator of failure, but instead
will cause us to treat the current value as smaller than the comparison
key.

But we do know to bubble the error up via the pasesd-in args by setting
`args->error =3D -1`. Funny thing though: I just now noticed that we check
for `args.error` _before_ we call `binsearch()`. Oops.

I will send a follow-up patch that addresses these issues.

Patrick

--89LvlXqT8VTETYaT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXulA0ACgkQVbJhu7ck
PpQc7Q//UUA1P6UVTvjo1iyOVDZMI31q+Uz6j0Wba2Hk7sJrUzH5/XSQMB4sUiz9
uFsh/yW+mwlkbTVTWv6idd3DT587WIhDaEQqkZbxLj3/RyTAp1xWC5oL13DtxO+H
Vpq7dhNmd50DMWBxbXZ8DKuNCvVEDLU3FIjPGZIDKJRwu+fwug+PLV2cM17CSCL4
DnKBUP0sYEyv3cLkz21A8BO5UbtFQxqBx/KSPKUAAkEqN7tyen3f2RQfw/AxKUoC
Qor0YFbpVvxgnjLtwTlzvul+1IVZSdh7LKTHNFtoR6hMQu6VdAD4vhwXMCzX3cvh
7YzNIv2iVhKLBj1s17LZBN9Sj1Wonae1pBdQcUvH0OkNyycsm0i/ccGqiRcoc9bw
LjpwgENLJz687Ut2Uo65maTEIV5WxKioPiRNkbZN8CtRj9wW1STryspv2UlNvB1l
si+ZOnVU9PnbKiaHNmdfUnqbYt8KKF4OZDqOJ9B1H/0lPFsM6l+qcJw/eEBZ43s0
S64LhzHpd4huEXBsBOcPM70hZ6atTeLOsFciZBThu7s+C2glUE6eHC5IX+/iGawp
5K8hs4vsdoJ9iEfkA+zNHekDz0VnliNa+nDkp5pcg9xSeApAR2YvwhBdORAaBpJQ
9JpBdQRPCsIv07L34MRzJi0BofXcdDPbiQSXV4/vXfQ1bMIcYqY=
=WCse
-----END PGP SIGNATURE-----

--89LvlXqT8VTETYaT--
