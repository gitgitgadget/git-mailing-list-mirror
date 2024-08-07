Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFA191478
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723006174; cv=none; b=VSFeNA40qB78FtxCqM1ymTmL/7wQ60bxZaovD/AwYkyE7+29KOqtu28mV0rRFfikt6mswXxzdf5kCLFhYmUchjstAjt4p/VcBBF6GLbNUQeMXK2VXettsQ9OGtiIh76v5IDLZb9wCfkuyNCaTWLKFrmRoaI/MTh1p9/IqIxzo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723006174; c=relaxed/simple;
	bh=YzBYPRrN5UMi/z8MTT5hr46OznEKDogzDdM/KGjoLgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gn7PXFD7haCok7RfVQ8ZfaUtiH8yEl15HDKmmkCItHdoq2MUbVv3gMJzqSjhza7xnBYUDMLK+QfIM/QUwBZT6013xDO2rEDWAEO5I7Ra5bHtn3RCz47TFmyzdQKXjgw4xOYcIQu4PMxtLSbtGoqloYQLHMUAsI2JwN1DBtvUr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YHjySlFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p5ys1sr5; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YHjySlFV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p5ys1sr5"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 47E2D1151B15;
	Wed,  7 Aug 2024 00:49:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 00:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723006170; x=1723092570; bh=Ba5dAFumNJ
	8cmnnJ5F9dztl5sS3BD3BFDyHNw40pV6g=; b=YHjySlFV1BECW0QVrYEuDD+MeM
	Mk6BrBleQaOuWwa9tP323u5YyZdyxqMITirTJdYHLiMFMH82Kq16G2trHvCXskq0
	9mZgtLgmZVYSpJ2TvBZ66/XZi4F/QnHD5pt9ri5iJ1Le0+p2WMmEt+s0qELnuPSm
	EsGWrbUXuQZxIWmmUbpX8/GMPj6AN5OrxhHcizn3D1JyOqZOnsROS332/oP3/peX
	FVoqX4i1L+pE/vQ67KsYtXxFt76LDcJPzow0u5cs6L0d9FBGfCERx3TYZo6Ao0fA
	7ebZLLxy3Xv60fgj1xBEczHc/Ts724Wa+Jk1V8EJ1+GQMptGqmsA0QJRh5jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723006170; x=1723092570; bh=Ba5dAFumNJ8cmnnJ5F9dztl5sS3B
	D3BFDyHNw40pV6g=; b=p5ys1sr56BzStHsmsCJmLf3jsbaS4DuiPCZZX2gdRety
	hWlMEGKa10A0AyatzK+fBgL6c35RIFYcPLqiZGXJB6zM02peoEWl5zpaRubU38Tx
	xpG2NyFp+OHphLnplEbQt8TUPp1/A7N2Se+XG0s9dPTWkt9PXQiskVF8Dt95NDs8
	0GgABbBuoFSzcRO8dR2P+Djjz//5F6RCJ5ZBMCxwKovU54wIB4ZMKCxzeDt2bcim
	9tuXoxL5XGtptL1CguH65h/N4p4cTHnYll+3XN2dZJy3gqdZixz7iGG/DuQpker5
	y0p9fyZ2ipJrzbVrs33QginAwdMs8XXMYu6Tw+Xf+Q==
X-ME-Sender: <xms:2vyyZqJ6GE-w39uq1FTplQgBBLn2n8GuCivS7_bGYN5lO1paDAYeww>
    <xme:2vyyZiLf53x8EHi1U0UO9quvWU19krkILBiYRwzKumQJvMoJ5NM9R5IruKWO-XiRP
    iqAN_PISok2qTVJOQ>
X-ME-Received: <xmr:2vyyZqvl6qc8o8azmCMXVDEKegZ-4c4efoMhuS-3gGE1GpZHpqRqSarhBHVPBGGq22DMnXYhYLmuewP3SFQLlaACSqqX7Z2GRriFqq5W4TEH2ZtH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:2vyyZvbX4tEX3wocV-BVRSNJQc2PV5VamyDgNMCwGMZJtSmpd700aw>
    <xmx:2vyyZha8qNKHvPCufSuKzHdG_0bZ3lhcmk2ydg02ND4nGgnTh2xNag>
    <xmx:2vyyZrB1AkT_iSXBkozTsNtYFahFQKXcxijCuJfbwO2Prh8Li8Ygyw>
    <xmx:2vyyZnbNpbteROkROwNl8RS5k8Mmo8k0hJoSZecZ21VRLGIIUFsyxw>
    <xmx:2vyyZmPMAUMq1CIf8uo1CGQx53DTtjvpktTBs0GDD4dLk0GYFxqF-9Gr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 00:49:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a4998f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 04:49:23 +0000 (UTC)
Date: Wed, 7 Aug 2024 06:49:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 09/11] builtin/fsck: add `git-refs verify`
 child process
Message-ID: <ZrL81Q6hp8kDjWVL@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumdJz3-0mqh6Rc@ArchLinux>
 <ZrDMdEJR6DV5HyLD@tanuki>
 <ZrDtVJYoJJZDesB4@ArchLinux>
 <xmqq4j7y3kmt.fsf@gitster.g>
 <ZrEbllB6WjLfWqNZ@ArchLinux>
 <xmqqsevi220s.fsf@gitster.g>
 <ZrFxb1FNRCzu-NuW@ArchLinux>
 <ZrG89e6IVMEuq0IK@tanuki>
 <xmqq7cctzlxh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zkuvag6C6/3t32WD"
Content-Disposition: inline
In-Reply-To: <xmqq7cctzlxh.fsf@gitster.g>


--Zkuvag6C6/3t32WD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 08:54:34AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> > But if "git refs verify" does exercise all the new code paths (and
> >> > the refactored code that existed before this series, sitting now in
> >> > different places), then I do not have to worry about it.  My question
> >> > was primarily to extract "even though we do not wire this up to fsck,
> >> > we already have another code paths that uses all these changes" out
> >> > of you.
> >> ...
> > So, to summarize: the refactored functionality is both used and tested
> > and I think it's sensible to defer the integration of git-fsck(1) and
> > git-refs(1).
>=20
> After refactoring, existing functionality about objects are used, of
> course, (there is no other code that does so), the refactoring lets
> the code to learn to perform checks on references, and these new
> checks are exercised by "git refs verify".
>=20
> I took what shejialuo said that way, and that is fine by me when I
> said the above ;-).  So I think we all are on the same page?

Yup, we are. I was mostly aiming to reassure Jialuo, who was a bit
uncertain whether his answers had been sufficient or not.

Thanks!

Patrick

--Zkuvag6C6/3t32WD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmay/NAACgkQVbJhu7ck
PpSZ3hAAraTDdM4ZPxYZBTmYOE6prS8Y6hMXqbXjr+eddUJ7AOIxHiikZxSTITcX
QcNLT81royOMXpkSckX7XRU9sdX5/S4qnv1F+8MsHCpPieFGPY2cc31ZyNG+uTT6
EBd5+7AMYMxNLUgQ1YMLpaUFXVoHFBe+GRRYqP/AFYhAfp1QT96iBNIAr2gRY3wZ
Q8i99zmYYim4xKBADSOyTkNRQ8MoccYrAlUWuoOc2X10Np8oji+HcTfpWGzZspcw
cZr2KuYBWlMxBaqikOm/9GkacB6tm/5XjcT0NsS70Yo8jPhA9m561VuxkQXJFsw+
W6tUgiuPyVFOsL1oiM6Fj9CX+IsUVvcN1mN2socgXvuItadYfEXpoKtxRFajIpAb
Vu0wBCzaOGm9RyLqmIo1qOBMUTbQVFIzdiTvZzeCyKESDZf01+TZZBTbdXm7lNAu
gKy/F0eafmHf7ylodCjdEDUUJnftFpUdmgXwMxsv74Sx3SkIdP23caUQIKU8GTqo
w82T62n/FCcM5HA+yelMlptE7mS+lVxWJa9TvPcqDMKuDmj/v72u7LGMbIEYbHmg
hy9U0gcOBui4/++/ZefyDZTAz8LjBWlfQMtfNEhyU3n5Ll5XUZwZXaQWrP5o2ZXC
MOtVi3lQX9uUM3pJc7siZLaQOOnnv8JO3pR/clW4IB3jbgaZqyo=
=4rxc
-----END PGP SIGNATURE-----

--Zkuvag6C6/3t32WD--
