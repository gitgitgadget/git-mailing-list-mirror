Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5E200A5
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292105; cv=none; b=uwTSbetWpnNVgwSfrhunJfAmNpfKHlKqSJ50wVFHkeTG0j2g8RvrbX9NXs1hJ7bxGkoEY41xZxiuvFp37NOGbl26K9/rYvOuLUFWNtzUd98G7lQSyYKs5UoZmbf3UstgeleDOkwi0db2z/9NMrYXkxA52VRe2fblKVfVCxjfW3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292105; c=relaxed/simple;
	bh=GxX1kDjODRtf28HtEuPenaNwrlbAZGUHnRE6XFQrLNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClA3fQyjBgkElEWUBkjHG5CuawknFrsb+TbkeLcTTYZz/uQ+iUj5bxIucwuwMwgajpgMCj+yFiCY7Ws8fo4PHJSkiEZ+WK29STac/7WgKRL84N+HtGyR4laBugVUfF+WeO/EyD8icNzJIdm+OjG2pppdc3jV0kUpJjcoqItpoMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VFPy+qLI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=de5nTO9W; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VFPy+qLI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="de5nTO9W"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A2FC3114009F;
	Wed,  7 Feb 2024 02:48:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 02:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707292102; x=1707378502; bh=9rx7c1yUJ6
	Vlk6DWyhaSGCbMXrr41ULGSnI9WxJ8PZo=; b=VFPy+qLIclvWZ78SCpacWHFdtm
	FNQwxOolNjeHPVQ/0lFqsBP4PqnLHwcAwPIqspwwU//Bgg4xigdJ0dakZH6NGJSt
	emEuDkP8zx+j/tcjmfzYa0cIJl3AxJqDgBmhYTbRGRNRXQi0HO831LQq8pXfQwSV
	ljkEkZ4+Hdl/+sveLCu1ZkOCvgMYK6nKjxTByo9XxU6hYxPwQPrdZ/Diq+RGYDhR
	KUKp8y4fXgyIVULQgbOtYrAmDzjB+Y9c46IxSJco+AHQc2VgZ0zjwF7SvLMbuYOZ
	j4wXpBphJw4Cb8nzHCH6rtmrGgVIqISUqEMYEqd2rio7IfeVEIxOr2WwYlTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707292102; x=1707378502; bh=9rx7c1yUJ6Vlk6DWyhaSGCbMXrr4
	1ULGSnI9WxJ8PZo=; b=de5nTO9WVRttNxTBTxpUTSK14a0e+QpZkUe3jmMrfQm1
	uUCwx6Gv4xGaScaTno08Ifit7yOigJ+ZwXFf+ahOMb029eVfDQXR7UiQ+WTr8RvS
	ya0kczU22fGhu0vTy6AAp2mT8g5Jb4AJJ6E8wPdqug1BJ6jKSjOgKDJb327XCFzz
	ca28TQphnrmSVr2s44Yev0QdP2d6T8fleJEdC4xORg05nnOCVr8kSLvAV/Ep3nwZ
	ywc+EXs91GU4LEujD7b+uXIQMO4OMyt9OXihZTBIRE50FZCN/qAdLsEWVHA7UhTC
	IzaFqOt/ILir0BhnC0JF9Wio+L1RcCJ06MBsmsQtSQ==
X-ME-Sender: <xms:xTXDZXa5IAvORZox5bp6EjLumnYwkiKHF28Jb4uyPvIcTDdpg7YWSg>
    <xme:xTXDZWYXTbhZq8kqxr0He8C0Qd_TDYKOg1MjuqUDpI9P9EIT9SGI6AKDmRWQ83UOp
    8COO7JYXWr62gHi_A>
X-ME-Received: <xmr:xTXDZZ_yQLkamiRV_QBBy3NpK8mzOnVpcw3Ecj6-1raXCkQve0m-hOaEeYtHPD0Uem73_HaV0G0PBxvQhVqQI-q0Eggv96SUK4t2X2wbVtKWfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xTXDZdqTGQxQc12hQkyB7W3eBEkGjlvpM9WWSD0-1JZU7k94IQhHQQ>
    <xmx:xTXDZSqU9bZUc37kkK-LhMYf4dHjiaJSAM6mnxpQf9w6wJO3a0tWgA>
    <xmx:xTXDZTRuTA1Ty4JZSPtujSPO1g_-4M0yLaeTRAbCTGXHbxwAZzeWSg>
    <xmx:xjXDZfDdTRoMt5hYw-yS-g0l_gPYUSn6jDJnvHCt8KGMCtJmoke9cw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:48:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36ac1dc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:44:47 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:48:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Message-ID: <ZcM1wTrS3cqln8yF@tanuki>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com>
 <20240129113527.607022-5-karthik.188@gmail.com>
 <98d79d33-0d7e-4a9c-a6a3-ed9b58cd7445@gmail.com>
 <CAOLa=ZR=_tt=ppphGMkxqj_YB5G+YkTMWGzRzcHTbrZz4ysb5w@mail.gmail.com>
 <92ba680d-0b48-49f0-aafc-f503e5a5e0ea@gmail.com>
 <xmqqle7xjzic.fsf@gitster.g>
 <xmqqr0hph1ku.fsf@gitster.g>
 <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TFkT504CY2ATb4op"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSZJ=_VCppHXcJeE=Z61go4_040xyc1NBTu-o=xysLrdg@mail.gmail.com>


--TFkT504CY2ATb4op
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 02:10:41PM -0800, Karthik Nayak wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > Junio C Hamano <gitster@pobox.com> writes:
> >> Phillip Wood <phillip.wood123@gmail.com> writes:
[snip]
> > For now, let's block the kn/for-all-refs topic until we figure out
> > the UI issue.  Which means this (and the reftable integration that
> > started to depend on it) will not be in the upcoming release.
> >
>=20
> I think it makes sense to remove the kn/for-all-refs topic for now.
>=20
> I also think that the reftable integration branch can go forward though,
> since the difference between v2 and v3 of that series was simply that
> v3 was rebased on top of kn/for-all-refs. So we can continue using v2.

I've sent a rebased v4 that evicted the kn/for-all-refs dependency. This
also allowed me to adapt to some fixes for the reftable library which
have been merged down to `master` now so that the corresponding tests
are now with `test_expect_success`.

Patrick

--TFkT504CY2ATb4op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDNcAACgkQVbJhu7ck
PpT1Dg/8DW0As8V5JHysXL4+3Pe7oZMIir1fN7T00s7MZ/Iuf/JB5Rweu1r0QpiL
Wn1WQAFwQK8c5Mew+vUUQoIfPG1Eh0e1QD7ODMBe8NL5LZzDndZmS6MwKSnraF4h
wTCrEv6zkBZpzgyD12vlOndU0Pi7UU/zsfyIfY8zKlmDAD43eeTDXkF+dn6yTRa7
SJEt1HPEeNXa37CLM1cROy2eaw2MEs4IGSgbmW2G6kU87HJ8XY8EHqATM9l8mg7g
LqAfyOdu2DBBi/gQhF3V5OmG52nckDL23dCfYOgoJioPo1UWGH5b7ZJNST8f/0y6
vj2EP1Izq0VeIp6Cj0SAGuJtkBzqroujoyV/mkNrNVAD+pBovUDkytnRIAW14ICu
HC/bmw2ccdgP7uKvAj+mrMja/Xc1CXcvdys7sANNp9iz1MUz6feVi/iyBcpHJO6R
o6J5Wv7JhvdROdWR0fp2/aVUCnxF5KHaNfMKv6u+URf97VAntjK5viv/yhFmbvqR
DMi/iaV0AKoejDYnyRhjGsrntxrpf3fsqa2zXrR3rlXJqeIDI14x2RPfJYYFp4U2
IudNyJkyXmrVjy+WlbRwN9dqQczjRd0uPOn+gZW4Ylni8xJVJSfaneXA0sHzmdjV
mWLXi6Jhj52i/Cm4uHbVDLPxieL5GTjI713xwBhZHjYuZ0MaRvM=
=JKsa
-----END PGP SIGNATURE-----

--TFkT504CY2ATb4op--
