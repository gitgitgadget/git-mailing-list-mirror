Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136918E03B
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422698; cv=none; b=nAQ3qq7E3oYuXgskzG4qOqbyoS2R6fnmFN4m6/x8LLh2Ov97fl7aDU1b0HURWt6Brr/JPtbbQscMM+8eRQp70mpTX3K7ETWrjmkq5Vp61G3U4ibhNCsCVgOnMCSGHy0ypvI5PjK731xhiEctPaK3QU+JGTVmt7cG77Wjc/iGGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422698; c=relaxed/simple;
	bh=VsPvULdZfy4uCiiqtkeWj7fp8Lc9/8wMQcJYcHbVoqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X48eSwEnCXbfyTNFpfDmPlEAfIqT6LIuFrLKGUtCc8hdnaNNdm2SevZQIN51ftAG/LOs/NtKBTEfPWvrIIC9ErGPgY44Kb6CRtDey+Idw7jgQkxcC7G5SyPvISaJysTZyH0d5xVYdy9d4BXLzbNqkgBU+XQPlg/t3Ja1fITiOnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gpf7tK0p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iY9toBdF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gpf7tK0p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iY9toBdF"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 73D5C1146D71;
	Wed, 31 Jul 2024 06:44:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 06:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722422695; x=1722509095; bh=VsPvULdZfy
	4uCiiqtkeWj7fp8Lc9/8wMQcJYcHbVoqA=; b=gpf7tK0pnEkHVV1N/HgPGA6uDO
	UgB4CksH8ZuWWcrCaapCEeUVPQWIjTao9Gxqa0/Bwosnzxo8piz2QQzoBn/rgQcc
	vv8PX6IlvXO0eye0z9tzXGGJxw/SidIQ9DMyvxFa94OS2mOxIcCQZZGHaZnx6+yt
	Sax6ZnFy6VaRa/XVmiFOdWqeJlit/vSryEMDKdlhLOFFZnKsd+XVP97x/Fq4dufD
	8otLhn2QUa75i35maVCSN0HedxXeSHJP85GR8peSyBVtOXp2WhyqKzH3ARP3RErJ
	HFw5BbriGtIjkYJmbtAPBDGn/AKuIPzhkP9fnrAkS7pO64MXuTmDWYp2mZMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722422695; x=1722509095; bh=VsPvULdZfy4uCiiqtkeWj7fp8Lc9
	/8wMQcJYcHbVoqA=; b=iY9toBdF33oWX84hsxsmHuN7cey4I9OTGlp0M2Dc3WyE
	euXj4yyryk7aKTf+DXSJD4pFUj0gnBQ5WKR6iYT3TLtERG1Rsd86uM3MBIcdPqjW
	SYUc0trORVmHmhvJ4nMuXKSvuVyT+G4p4FyZ/Hw5eN2m4lTmiiVKJa90krtqIjTk
	XoRQIKb1e8QP2y5ilHl5ffi2KhQZIAbahmmNlCkk4D4x4nI+Bo0SDtubB1jh7Nnb
	DoizrydWKSqveClieButXQCrb2Ur7fBrB9xEolvRkY8/VgiE61u2nPFQu90/wr0+
	c4dYPWe/Rp+7BJWVAKZ8CxK7B4/IpeXR0/7TCEsGdQ==
X-ME-Sender: <xms:pxWqZjY3mUn4DVqEr8YEH_Msah_z5A2Gegcf3lbz5aXfrO1yzxH8Gg>
    <xme:pxWqZiYilf9RyZHTQIcH6X8tw3k7fNEK1FbeR-Vr1ywnD0XpC_-69-O_xn9N_ngaR
    8KGuvGWt_9NGSjPZg>
X-ME-Received: <xmr:pxWqZl8GljUiy80cYDHVZczvorkERWvngIzrRMssYEHnqCWo7Jul4Cati8NQd0DtlcUuea-uElm0Q1FN5Pgb4xWO0TrKvM5PDkKbxZ0jOERO8WbW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:pxWqZpp8ESGqQhKwklMAEeorM8bSj0yd-RsREOnvgkUEnLe83Q0i4w>
    <xmx:pxWqZuotoHCQvC4PwQPZpza9iFBIWocUbKm6HPmulTdQhN2vSdDn1Q>
    <xmx:pxWqZvRkEp7wM6-3i8cCVgpyD2op_smcfaMnZwriW1Bgz1-3Lnl5fw>
    <xmx:pxWqZmrFFfB2Lo0xgPJqX02eEos9z8W6YszBCusZYSO_kWfKI-udvw>
    <xmx:pxWqZl1Ox7akTOmQc61KUqSrl1E92q5JufDe7X9i49jwqz2Zi3VbYoEG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 06:44:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a42be33b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 10:43:23 +0000 (UTC)
Date: Wed, 31 Jul 2024 12:44:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/23] Memory leak fixes (pt.3)
Message-ID: <ZqoVo-Vl2tqlelLA@tanuki>
References: <cover.1721995576.git.ps@pks.im>
 <CAOLa=ZT==H9VQp_Z_VcQEmXVBUPWWui1CfmRQbLnOyyqMwxjmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Os1xlruaM8trrJTn"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZT==H9VQp_Z_VcQEmXVBUPWWui1CfmRQbLnOyyqMwxjmg@mail.gmail.com>


--Os1xlruaM8trrJTn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 07:09:57AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > I originally wanted to hold off with sending out this series until v2.46
> > was out. But I saw that Junio sent out some patches which are plugging
> > the same leaks as I did, so I dedcided to send it out now to avoid some
> > duplicated work.
> >
> > There isn't really any structure to this series, I just happened to pick
> > some random test suites that fail with the leak checker enabled and then
> > fixed those. Naturally, I've also got part 4 of this series of patch
> > series in the pipeline already :) As mentioned elsewhere, I hope to get
> > the number of failing test suites to zero this year. Let's see whether
> > this is realistic.
> >
> > Patrick
> >
>=20
> This was quite easy to review since there wasn't much to add and it was
> clearly split into small commits. Apart from some nits, the series looks
> great to me.

Thanks for your review! Given that until now the only thing that needs
fixing is smallish typoes I'll refrain from sending the whole thing out
just to fix those. I've fixed them locally though and will send them out
in case anything else needs fixing.

Patrick

--Os1xlruaM8trrJTn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqFaIACgkQVbJhu7ck
PpSJ2hAAmnRdMYqGtKCJ1ezDXlWN0vJq85DOxQV1jQm2p0LfVCouADCED2RvBMDU
PDBXNFhr2bc7fVyANzoNdsW018zypDRrSRKU1E+hFwkVHZ6zGUaZp8xk25j4q/yl
96Ahtlc69krh5yjxO2CyUJSG5zrV/FHkuxuTBGmSH5WB6ZkbmtPnplrcOT9QyD6X
YHS0+jnvebKxztBpqZavYvislG0maCJ6ODyf21avBk1ic4yl2iNoSWM+3xNL4AzK
UQPxO4XLfk0KpnDkeCrVaa1PNBuROLqaxVhNX1K2rstWIZmA/C9J+tFj5QvwfmJB
g41RbMdQ8vK+GfJlcNzWS9iF1NVhBuVaBoyveG0ZbqBOO3VqdMq7aJ2nig1A0bwU
CtZRiLporP8Qs0PxtL7FX2KttlJl+jHxGIq440EF7qrQN3ntGlm/EZomzNXO852w
84G3Tu5YSBUlv84clIaTCndePRwzVg2CFRnplYxkqbW/vtQtqkdfUhl7TN/SSRPT
+03FU2laFKT22IFzHgEsA2wXeO919+YdG2wooXis1fMJgXeKoVweNpyPF8BS6L2e
SfGi/sQTFnkKfbArADNQPGb/9IeNZTilWhNqghpFVg+Fsww7/JbEpbqW/cu5OfSz
54GwAM1I40jXoCUcqCuBtWnGu9B6r1ESg0+LzPPWNxD6nW+HHws=
=2hP1
-----END PGP SIGNATURE-----

--Os1xlruaM8trrJTn--
