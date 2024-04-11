Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11312EAE5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825731; cv=none; b=Ntca3du3b8uNnPSx0YsGmvLB5+ahh9krA4fxPykKzasOI1Or2+2J0GkczVGOneIWkxbFh9Hkr+gTpWQ0H2cE1eRX9Q1xozioGr6bVbv04+ObB5l3GbWUwr3AVb+KdXmy6E5ESg8/jjArdtYOb++Nh6rGOQtMpuiY2Kck+aCw8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825731; c=relaxed/simple;
	bh=y46BAJL5/hMZud+nf9U4CNYL/4Nt3O4O6gKaKHuncss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmm/9UwEA7eJ07I/zQQGpt346tY5k09I3R4xRGsMqn5QwsjqwsmnZnJuRml6w3rPj8sbqkwi5ePPLf3bENbOxYDUH2PngYMVG2MExqs3uaO/Pq25dB7wbmNGobbNsNLif72kXf+jGAB36KtXVMj/rXCoIKrLY1fR8+ljKnnKrak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YtruaWBP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RJjkYMxL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YtruaWBP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RJjkYMxL"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C570B1140184;
	Thu, 11 Apr 2024 04:55:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 11 Apr 2024 04:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712825728; x=1712912128; bh=yFIMT/Kj7I
	yPRmw7daJ09Xz4HQ6zCzLUU/xm+Kxvf9o=; b=YtruaWBPbXJqauwQjhvXXgKi9U
	zaFQgBHZMymjY6OL3kGhu3bnGUW50GSX+OXYtBTJYAY2GNg1Vn45Wvr/tL/6W2Oc
	hQRdLjDKwfWtSXczWF87i/6ATCIY48o1KTHoT2OxGJTsjfumcWWfrZ9nhl7DTzCs
	DPJF3aBaKN4K1zR+v0rHRra7qh34qCUqNNcAWnhARu6r9+7s5uBATBvjFZTbZod2
	dsmCsPobBDi9k3MSg0pNOb3j9pEwMFxel6M7v1BW5RBWl4dDjsvnuOJpoDEzyaI7
	7vUnkBftSVPSOE+146zGFvY61TawwltTeQ7CFxD2jSzt24km/3f7As9zkj0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712825728; x=1712912128; bh=yFIMT/Kj7IyPRmw7daJ09Xz4HQ6z
	CzLUU/xm+Kxvf9o=; b=RJjkYMxL1kBMnoeUKYqWpNV1uobDCeP1LlLA+LhA+4v8
	emRc7l7YzjC9sJfQG4wwG1Iv450fjezfxhRG3LSnblp9NFp7yYp9/cvEzQwdKJ0c
	iFNX9mYEq6To5kQCdgLX/dSrIche1pvUwc5wBmNEIXlhby7ZRSmnTiVqXdDely0u
	st+KsjbJIzYlkPvSEl21YaDdvuAhM1k72V0hR3gLDRMsLsTwCNJWtbnokV9f+3X/
	abbsv2YOYxC9/B/txFOVpHoYkZr24lfuyS4+8+bNetrMLEq7MWBpf+Wn2yBnLV78
	ii1vuKmhFGmto7kvL8g9LEiHKuwxcQZdTJuG5KbNsw==
X-ME-Sender: <xms:gKUXZlTCpHKaENJ15nbZDC9ngv8Mwa-kf9q56tFisKIVqdPLMTsQ8Q>
    <xme:gKUXZuxRJBznn_nUWQLJ3loKqu9yRsFUw4Pyx7F1q9p0XTy9ePkuvd7FozoXce6Wn
    k3vWhObALcEuFT4wg>
X-ME-Received: <xmr:gKUXZq1BAcIkz6eqF9JiCYiJv_0zgSVN6k6c3-ZO7T02w0S1ARJIEsRsVpuTJW9fnKQ3VVUWO2CT8Fow8r1B_OTEhPpzmp_dikxibxqsd8-xBKDz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gKUXZtDQ6ZHqJyOm0Cvc1UZWue1a6yJje40uYjmIGlMw6b3vKCHfAw>
    <xmx:gKUXZuiMLE6jNxxmgbnJawsAdBtpO1qsL0piLK2zK8cEFw27oGTJNA>
    <xmx:gKUXZhoLV-ZIuZnAxtwkf2f6YSQ8TrCjNw27SLnQUgBrw3mX_lpcCg>
    <xmx:gKUXZpinnoH6Jvpsb25zB50fgPkAa63da-gxmmaJ-KtQBscmDqM7eg>
    <xmx:gKUXZigvNv9E8W1KKEOT4SPRp19GKayPnMxkdDo5aBS_llSlh9jN_eaF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 04:55:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5dc1b3ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 08:55:14 +0000 (UTC)
Date: Thu, 11 Apr 2024 10:55:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon claes <toon@iotcl.com>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs
Message-ID: <ZhelfC2wJmcnWr7L@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <16603d40fdf96948580c04a7c2b791a97ec64fe7.1712555682.git.ps@pks.im>
 <874jc9kvls.fsf@to1.studio>
 <xmqqjzl5uo9f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yHN1nWLyxQEmzIs7"
Content-Disposition: inline
In-Reply-To: <xmqqjzl5uo9f.fsf@gitster.g>


--yHN1nWLyxQEmzIs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 10:21:48AM -0700, Junio C Hamano wrote:
> Toon claes <toon@iotcl.com> writes:
>=20
> >> [PATCH v2 03/12] ci: allow skipping sudo on dockerized jobs
> >
> > I think this title is somewhat misleading. While it's true, I don't
> > think it's limited to dockerized jobs. Something more along the lines of
> > "allow running install-dependencies.sh as root" would make more sense to
> > me.
>=20
> It is true that dockerized is not the essential part of this change;
> and it is that we skip sudo when we are already root.  So I agree
> with you that the original title is misleading.
>=20
> "allow running as root" is somehow a bit unsatisfactory, though.  It
> sounds as if _we_ were not allowing it before---what was preventing
> us from doing so was a system without sudo.
>=20
> Stepping back a bit, I wonder if install-dependencies.sh will stay
> to be the only one among ci/ scripts that need to run things as
> root.  If we moved the new logic in this patch to ci/lib.sh that is
> included by everybody, then the title of the patch can become a
> short and sweet
>=20
>     ci: skip sudo when we are already root

Agreed, this title reads much better than what I had.

> > That's the only tiny remark I have on this patch series.
>=20
> Thanks.

Thanks to both of you!

Patrick

--yHN1nWLyxQEmzIs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXpXsACgkQVbJhu7ck
PpR7sA//WfzQ90A0QmMoeiOuBlDnPZKdDbTrVlEwdiHuoEK3ibb5maAdefj9V8GS
7Tw9qeg+4JPi9NM90tRzm4JNUARpTYlkyJood9XH0sc1VTxK1htj3Jqr6MM9/t5L
60kqsZh/FAYCQL0+DjySDehTap4ml/fI7fCjY4LR0ZExas6MBDJDN24XggNgMoxC
Zn1WsqjF4VxcG/r9Ids4WjLAUo5uVF8y5lMxR/aTsozB329dhCr/Ilqhl6uuL7Ic
AGcLVPa/lnwVyCDrJA/nZlROSwV6aiZN78LpR7pdUMygOUmRLwWIH4MlA9/wXxO5
7Ow5PDoCQzVjvp4vPvYyJQasZ9VdDrFaAZLK3XQ8ZefWds3ryixLlh4Cw7cedwMQ
rFKIM7aypTdV5NccNDB5AH63cl8iGUVsWH88Zbl0p6BvcE9m+fOcmnQwQWZDd94f
DD/4lxsy5SEQktCtSy601Nby4GPVttdI+U7c2FtCG2X3FOvA1nhK0w0EfbZ2O9IF
UvPvbRhKyUCCKtz/HUPXJUZ8I1Wx7f3/zLZt0L8I0Ufx5ryTrjD+QXMvI5YUd2kR
MPmkU42ZUS8slZzvHHQUrWDTm0rLy3+RQNt2nuC/gxJgJsH9Klqrto1HnvMxofBy
7Sj2/OWe2Nw8xAABHs3DUxxApis397UixbsGv4dVNtnlOCh6eE4=
=nlCG
-----END PGP SIGNATURE-----

--yHN1nWLyxQEmzIs7--
