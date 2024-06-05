Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A02D2F24
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717565563; cv=none; b=Ilt3WgShiIZMDFdxxqE5ZLDddOvOjBQ5INVMmuO/HxV0eRifTl94dSj2//Brq63hmis/4Smc2VeqLoj7BAVEEq7JimBbYH8ySSXw47le6vXv4ipyUP4fwvaf9h6pmTVsoFRT40+jzo3iQEfLxkhbtHcmZ7u1GNPbInQSMB/rc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717565563; c=relaxed/simple;
	bh=FbTN9IprpRWsoeQsBpF4i+laDy0I5/CvlgmeSDnvHWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hpqq2VEEieR8F2zlfL/ORXQohU+cAF/unoEddL1xX9eLrozvstNA3mgVCK0ukeBy4+1BlfjU9OVpKonQuqs/bYbqS9XO01jDQJYuj9cHzD1dlDSZMPKzpzkqunpYgrWxQSczZwBUAsAl1gMV4nq11KgHSoTbt4Y6tOlClYSK9v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F8p3o45s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ep3wjNyn; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F8p3o45s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ep3wjNyn"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3980C180011A;
	Wed,  5 Jun 2024 01:32:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 05 Jun 2024 01:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717565560; x=1717651960; bh=8gNZWLW/og
	6ZFdkpUrqXodmm6T+pcDTn0oTRQAp3Ao0=; b=F8p3o45sKVBhLgowmO4eGW3a9B
	aPSwcVFELTbBUbE8w1+JjxA8yE/RvsghoI2HyeVnFFDZ15SIao7W2pQkPUx3wZr5
	h+jKshdaRkCQQMbD7mYGvWp95vH0orh4XhGsuHGhdKVvALARY4Ahc169vYMutcb/
	1SdMcSpL3nZi0rq2nKsGFUxysPq0IsRn6c26kwLUZLYhfFOidXpVw7JcZTu18Xwr
	b2dsbFqhPP/bLKx72lQBWLoW2Wr/oS5ugtyz37Ik9NCW8jUgVAgid5tn79+Qx98P
	OOm4QUQ5MPg6Ve0G22diiq1QIHuQQS8rASvdlcepERLpc8zq4sdsvFAIi2Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717565560; x=1717651960; bh=8gNZWLW/og6ZFdkpUrqXodmm6T+p
	cDTn0oTRQAp3Ao0=; b=Ep3wjNynSRqczmzQlClocQsIpAtBpyuMghXT9KdTjMl0
	7p3DR+jrSNTt5SyNaQhrYjX7NoUAlYt8tCPIm4YJifu/D148NJQ7vMmuls8AdyPm
	TE0rpu7OsaLVa23XUYTg0deE+kLIfyY/gpRUZ2agmtkWze9ISjhWQiHqg1yTqAFo
	BgeB/LAptrPOnnPEP7EkOQi9JWuM/MXyPeQYallfSIgDAf8VJ8pa2fmY+VK/57LK
	muXpBgodFLRmfMoQy2b7ixsagke18YSfJiGjmOELieKgpzPn2gzBPAk2EnhAnkHz
	L+9A9mqh0mLjPlo9hnv3Ts80oAn/VgTBGlpSEke1bg==
X-ME-Sender: <xms:ePhfZrxd9BTtQSEhARi_1ui3GyPTDwUJx64Tr0hLO54AA8B-rWr40g>
    <xme:ePhfZjTtiDGdhDpsS3MUZZcTciIYCS3HzDvWphVnCdA2tsinYWo8vspFy1lddv9mL
    bnRhDrt8BQGHp2hnQ>
X-ME-Received: <xmr:ePhfZlUPute_Wzv3qi0tXfCKXlv5ixeGCa31toFtkGiVdShKdHHv5RUSobtKz9d387d6P8sPe7-wuq-NzJDczNCtpmbkkG6SBmX15-QOIkoHqEJAb1o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ePhfZlhRPiFKHTylIZRUtSnQefrMmm_1RVdUqCeUi_8K-IGffEwXTQ>
    <xmx:ePhfZtB2Aa6lPKhJtcIO_QXlUh-TK1cOp-bEkz_7ZZTJ5oagO_9NRA>
    <xmx:ePhfZuISBdA2485ZLQAzRwLpkspKngI3K02wUwxwclFkPKr38jYkIw>
    <xmx:ePhfZsCnFfhDJrEruh82H_l-qmAvUn_e2hcYEJcfodotjciOnYWeQg>
    <xmx:ePhfZh13j0SNzdJ5VB-RgdsDzc4OKUhmilSfVrEHmWRx0EeCaj-cEaVW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 01:32:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7ccd458b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Jun 2024 05:32:10 +0000 (UTC)
Date: Wed, 5 Jun 2024 07:32:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6 0/4] docs: document upcoming breaking changes
Message-ID: <Zl_4dDkmj8sJegrp@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717504292.git.ps@pks.im>
 <f231d5ff-08e5-47b3-aadc-0f88566c2588@gmail.com>
 <xmqqjzj4vb7y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E+sVN0N6G02v9zC2"
Content-Disposition: inline
In-Reply-To: <xmqqjzj4vb7y.fsf@gitster.g>


--E+sVN0N6G02v9zC2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2024 at 11:01:21AM -0700, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>=20
> > Hi Patrick
> >
> > On 04/06/2024 13:32, Patrick Steinhardt wrote:
> >> Hi,
> >> another day, another version of this patch series that aims to give
> >> a
> >> framework for documenting upcoming breaking changes in Git.
> >> Changes compared to v5:
> >>    - Note that Git 1.6 was a breaking release, despite the fact that
> >> its
> >>      major version wasn't bumped.
> >>    - Several smallish rewordings.
> >>    - Note that items on the lists should only be discussed anew when
> >>      circumstances have changed.
> >>    - Add some conditions to the move to "sha256". Also, note that we
> >> do
> >>      not plan to deprecate "sha1".
> >>    - Note that replacement refs are also superior over grafts
> >> because
> >>      they can be carried across repos.
> >
> > This version looks good to me
> >
> > Thanks for writing this document
>=20
> Yup, aside from two typos and a misstatement I did not spot anything
> that need correction.  Will queue.
>=20
> Thanks.

Thanks to both of you!

Patrick

--E+sVN0N6G02v9zC2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZf+HMACgkQVbJhu7ck
PpS4tA/9EZ98sjsiuD4HfyVMCQuZA/Jz+7WLdDH5HhWzECeoHWdUFZuzt5gYVHFn
jThVA/vODR9fLM+tybtqbCS0xGcMmnB7Z4C8zxPaJUK99igt4CKR5PDNdQX0sb6m
fQqBSf0YwsyjuDssJyErDJANfwcp41Fwx8Yo/Hwwqadpq8WT4dvcGYLWYsySyPiu
Tb0mOFlIUTIlO7qwhtSoWGJC96vRaBLAubmlnOqV1+Zm863xGcWY2Sst/yVEBTsV
OeA9r2pnoLwWkXIQHeUVTjhPEDgUenWbTAVraE6vjrB6P0Zod7ghz762gdINRaHp
aWDOr/mXL6pIrCbUe5TAguU6BU1mTGeEBCRZjnvb/nXSbv8uuF/20W9Ago0hqDQG
eA6K97InfSfiyHg24DOvkmzsjdmftItMegp17/jHSJXNqGNgSRUb4XfF24i8xlcQ
KUxezg6L4jNo1NrwKXLEW9lINrx7W8jFVmgYPwUHVlLe56o9akjR3eoNBraU5m4f
IhbPyFRRzVOb6dpoOjtFnm7vUoBLDqf9zV+lj8wAvb5/QYW6Wf8JTQi9y8K0gsnw
k76Lv+mM7QnL169OLqvfnY0Xqw3UkHv61BEa0quGoWsaM4QIXIBX4s6t0dVBjhoi
AT1MPIcBASkLCdCU1fd1OXIJKn2UzpI4S16EE17m9llborE3QQo=
=8lo6
-----END PGP SIGNATURE-----

--E+sVN0N6G02v9zC2--
