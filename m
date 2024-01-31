Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB7A3D99C
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680008; cv=none; b=RBZ/pQh602ow7FnwQ22DPw20NgojBdRv7U9emhN0llIs6+uyBzakYFea5nij1bOgyBCfnBHtB9XUIWx9j9gbGNPlQ68RyD1C9IzmMU2HCnwT+BkOBmFGlMzLpYcqjVt8HiTlXRsU/7YpJE5lho0mXfIP3bIF/BJDc6ehGBXFZIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680008; c=relaxed/simple;
	bh=6pOiMhxGmWxkIZGFmmY/FnwwnM6NZNkA735jUD4ESNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=or8e7l0qYHN+h4+dcRZHz3z/ubf/5XNjDzXR248/dzhWDHOSjXXVV8XahaRc6dWg6fBCP3mxUM4CGDQDtoKXzglWT3fsxwopPsR6X90VhJILCmCVdY1AzSL3dl+TIyR90BVDbr5LbJUpahcgSYxDis0aPQN6yRgC73ex4/xyZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gV0/PLj1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J0rxvVyF; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gV0/PLj1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J0rxvVyF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id D46C61C00087;
	Wed, 31 Jan 2024 00:46:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 31 Jan 2024 00:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706680003; x=1706766403; bh=fEBpbdrltl
	iQgoz/wBPtURtFP8ngwEarWlCgCd1Qboo=; b=gV0/PLj1OAvvZEfz2aMeg2KVQ8
	Ixpi2t/ydjQkGaGeVaVUEUZoOaWlKoEoujPVcApAbjJ0fyk61M1VznlawD5jrp6q
	dlYU5JuSCgzSgbkS9HFDMwQ0aEzvGJIJ+xjKQmEFdDDncoPGiPXv9cXpXIrAJ2wU
	zm7YvRmU5O/IacV2AyicDNC/q3lyeGUpt1QQxcxId4AHRlBctFEzsys12pWyVWaQ
	Pa7PQqjyWZgBboqay5pkBzuYS4QE27jos7rFu6wmA9p9xx/4wQPTyHNIWLOJz4fj
	kZ9P1zIrv4z3lr5EHeQDkmlkLbUFT55gjfBn+3YOvTSg3JvDqmknMKyn7DmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706680003; x=1706766403; bh=fEBpbdrltliQgoz/wBPtURtFP8ng
	wEarWlCgCd1Qboo=; b=J0rxvVyFUN/BLOfn/HnbxpLU98I/ZpHYayaSgX6rCmmW
	foj5vmK4BBate643TXGsrcYJrCRBdx345NymQDTlaGdEjyJoPj9iE6bbHthgYHsq
	YO9bEQ8E7L73Cl8EB3Cb8B+wq3nTFS5bKduuZ5TRsmYZ7JcdVCdlO2StvBFqOIte
	pa0nyQ0LTqrkxiIiLUW20sZkW2sBSo8Q7C/wbTzq0u/H/JqzF5TnRhGumvbnhU1i
	VokMR1a1GQx7XGKCGgdk6RfpDOc4kQVjSQA5P0+gOt0MfteQ/sjaA6TtrCG8AGYY
	HGbp8JVUaRZqeI8tgte9Q2UY0fZtt/ym55Nz2gLuSA==
X-ME-Sender: <xms:w965ZT780VEfjQtqhpSV-96S8sT3_3AWts76baNM049HGYBXfLqHZg>
    <xme:w965ZY42JhQtUyObKhyXlb1e_ofydtRhNUQIDipAmAzLmNzfD5B49ThpDWsi9LC5n
    6ROCUowp06KEzdUFg>
X-ME-Received: <xmr:w965ZacmkU9pcGRsNhPHAhijiP8Py23N0_b3OH-qcnrFFsaB93QfDSi7kZTi8NdYG3rR9iXsZiaG47bqb_VavmIlfrGT0OnIdJnblH0URmjjnPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtkedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:w965ZULrXgJJw_rgUQhNWn9TCBos6SVy_sQbnRKE64n6QWDvrs11ZQ>
    <xmx:w965ZXI746KFDBSYL8iRYWu_yTwqNON-VqSX5AvCQW2qfoR-gyd2UA>
    <xmx:w965ZdxXJ6wPH6teyCnh7U7In_Lh8eUDw2twaGJt8K8lIGp00hWYUw>
    <xmx:w965Zf1cGN1PCPti6UQD59uTzk7DJz3aLt2EZoB7kgkLeCEVKGhjLw0ne4g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 00:46:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d751d1d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jan 2024 05:43:19 +0000 (UTC)
Date: Wed, 31 Jan 2024 06:46:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable/stack: fsync "tables.list" during compaction
Message-ID: <ZbnevPIN5cudLU5w@tanuki>
References: <7bdafc9bd7f53f38a24d69a563615b6ad484e1ba.1706592127.git.ps@pks.im>
 <CAGAWz+4wyd13UYRH3ZSSZEq1Y=5HE_p+qaXeOJS-ENMpWoLabA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkx0gIEOi6SLWZdf"
Content-Disposition: inline
In-Reply-To: <CAGAWz+4wyd13UYRH3ZSSZEq1Y=5HE_p+qaXeOJS-ENMpWoLabA@mail.gmail.com>


--fkx0gIEOi6SLWZdf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 01:04:46PM -0600, Justin Tobler wrote:
> On Mon, Jan 29, 2024 at 11:23=E2=80=AFPM Patrick Steinhardt <ps@pks.im> w=
rote:
> >
> > In 1df18a1c9a (reftable: honor core.fsync, 2024-01-23), we have added
> > code to fsync both newly written reftables as well as "tables.list" to
> > disk. But there are two code paths where "tables.list" is being written:
> >
> >   - When appending a new table due to a normal ref update.
> >
> >   - When compacting a range of tables during compaction.
> >
> > We have only addressed the former code path, but do not yet sync the new
> > "tables.list" file in the latter. Fix this ommission.
>=20
> nit: s/ommission/omission

I knew this looked weird when writing it! Should've looked it up.

> > Note that we are not yet adding any tests. These tests will be added
> > once the "reftable" backend has been upstreamed.
> >
>=20
> Nice catch! I noticed a small typo in the commit message but otherwise lo=
oks
> good to me.

Thanks. I'll refrain from sending out a new version for this typo alone,
but will fix it if other feedback requires a second iteration.

Patrick

--fkx0gIEOi6SLWZdf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW53rcACgkQVbJhu7ck
PpTzmA//ebNsJ8x64V9Mm4mmp49yRDbr62sW65qTa1vLFktdaiM7S0SSd/cSi5P5
LsPbQrHNCsVaNxgqDOZLpxLKpnu0GHK5zeuzyIJ1rlQpcuWan1bj4t5s6PyczXlA
n6zXrd0FB66/ofaNPs+1HDaTAwtffrb+cH2kiDmUCn14qQPHUbUKHAIDCjLhCRkv
AhROAyOQLDl0sSj3aXvevvSy8GRaAefa1eb2CDZJbx46qqgdqq6lpZ0E2e50QAPJ
ptNSjPfoEd0VYXE9nfkRxskHITbs6tWW3eSPZPLsTQMLwdwiQeLtk/r9oSLm+U8b
eYmMMqXPjQ54Nf3NsZXWnueBErwsqucZ5ikdFgBkf9Wp985kSVxlwuVS1dZrMgNM
TWHIRvoTZd6lSOrD0nmODYS9zu7pODSF9aHE3D1v6zMRxS3Zt/KqzqmvaBM+0L6o
rTNdFySj7A/C4Hfl+O3fHQFVD+5obaS7z18/RBoMHce98CI5LMlU4M7hQcdStA20
wiDpyUwX2quQnTgJbrGuigV+atsshU8FOiGU99V6vJ9zq6JZxHVF++zDVnocw0uQ
qYEgncd5GU1A+wEsKhJ2VnKQ0pp44Oe8+KmMC4mg/NBFFaxObcWVz+sod6c0LhcX
7s3oKNcJosTsuBRcADKK2wzzevwfyOyVKr7qUlFAdkzp9MMN68M=
=RmML
-----END PGP SIGNATURE-----

--fkx0gIEOi6SLWZdf--
