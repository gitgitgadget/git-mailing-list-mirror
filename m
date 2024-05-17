Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB389288A4
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934415; cv=none; b=R557LonXKoeWeZ5M8knHHMOk+4WLY5guaAQFEZZVz2PiNXXrVT6Dwmb1PK0TOA/NP+vys0P729PW7rqr4tUl4Xw+X0Ia0s+UAhu9K04Lfw7O2N/hlWoI6x6MEF2rNhsoIwsBPzRPp76adUznrpl3tm60vOBoVP9OV3OyHRrRK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934415; c=relaxed/simple;
	bh=SfbqgTl+4Jagh3399+nqqmJCt8gHXnKPyVds3g83Zfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQtKH5UII7FUadCBSM/8XpJmrmC7/ajBDvYoJT/9EogwgFBYDNHqyEno4j4+ooero0iZgd8xg+yOEaKd0yqEDC3mqlfGbDJI69FETRijlMLzZ0jQXXgB8vcMD9vVZDOuusQymymqB+JIe4zOxMaEsDUl3ONSNJivOv3pprEf9U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NWTFUG38; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UqAulXQJ; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NWTFUG38";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UqAulXQJ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 895F9180017E;
	Fri, 17 May 2024 04:26:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 04:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715934412; x=1716020812; bh=zDDrG7lmnX
	gfhI9xjfIB3UKQarMooJMfnOZ6F+UWsJ4=; b=NWTFUG38gnGut+7XP+SHGop7Zg
	iwgpbyIBL+jUHik9Cohk8zsS5N0JTQRtVXUSqUy+9j3H1m1vhJWbwY/LhmP1Lt3D
	YIbCJxR+WNukSOdNRQIGAn0Py4Z+jrK4aZQzYasybXkAirba4uDo0h6ZPoNGOGhf
	mEV/f3Fb+9Ca1BibXEIZP4AaKtQSK1fZHzR3YkCCprI8n2lz49wKd3FIoFYAa1HH
	9Wh63q4qVPzvXxyXQb2lZ/7i5odv8B7nNe8BxtO4kNVBtB6+yk6aK5rqq+xWERYA
	tIT6o/lYitdG3d50q7OT/1IYzr5wvC7kjbIAEn1EJ2Usolk+zYU9RCsAWtTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715934412; x=1716020812; bh=zDDrG7lmnXgfhI9xjfIB3UKQarMo
	oJMfnOZ6F+UWsJ4=; b=UqAulXQJyvmvJECVbd8707SQLq/AEgLUUebC89HNnqe/
	HHnjzKXtZZEvn0OAzaKkHUtCL99NNKVMY3KtYXDVRCjoYS3HyaVxm0gBlDS2UrlI
	kyvNUtIeKtU0ulHFjcKVzA8iDjzCv2f6D54dmF6FP4E1ukZUrxnPiYkOe4rK378J
	xSj/i2gJz82S3bBGrrWex7I6TCrQajuyrGlKSd+AR9JuKxU7f6GaDl6uaE5j+iGO
	3DhBQP0F3N+14848YCK057QcsvLzwGywHmZG4tx44Xai9nfT7CShLKIELqr7jau/
	pisV+KMYRV7bqYZIH53CsIyh0B11gb4bXPiHXdkTXA==
X-ME-Sender: <xms:zBRHZkaKov2oLgnVwjrE2O7xZ_nllKIsywmw2tsZRy4hBocJaySlaQ>
    <xme:zBRHZvbf7Xp6yzgIBgpFrjZJCjI4W0qDTymKaeoyPBe6aZqMYPSQj748MsYCAjOLL
    SVrEcQAMmsi4mq4ew>
X-ME-Received: <xmr:zBRHZu-3p9AG45-ehactV8IIz4szD_g8FM_7-CZtZ27JLJcXholDSDyNJKiB_I1cOT58wmBzgEKauiukY-FIeEn22aU6fNITcVS4bhUvh21c_MP0rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zBRHZup24Z33VC7B_vp6E1VznedEWBiwZySM0cJvrFzCt16XIFJI6w>
    <xmx:zBRHZvqh0ZFI8-0q3Zs_BaDWO-LVCb-2yI9d3wxcKRnSM-cbDqRqlw>
    <xmx:zBRHZsQvJw07DH9q29ObGZuGcOK-XOeIjiFhVgZ7mBwcc6hFzbcYZw>
    <xmx:zBRHZvr_5kEeGxG8QBzzn_CQFtm3EjQGDO7duBhmIEPkzj57wSdl6Q>
    <xmx:zBRHZgnU1pE1T22UFsyIYvaAuH1SQsgAcFP3xzv8cfXOAQc0hS2mlWtF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:26:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d944aae2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:26:23 +0000 (UTC)
Date: Fri, 17 May 2024 10:26:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] reftable: expose write options as config
Message-ID: <ZkcUyISlLsGqtOmC@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <CAOLa=ZQE2mFrDNGyNEwYXneW3Vw6wqg160WOpFL7+NfSfOfDhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I8BPG7OZeZAS9HHA"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQE2mFrDNGyNEwYXneW3Vw6wqg160WOpFL7+NfSfOfDhg@mail.gmail.com>


--I8BPG7OZeZAS9HHA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 10:14:19AM +0200, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Hi,
> >
> > this is the third version of my patch series that exposes several write
> > options of the reftable library via Git configs.
> >
> > Changes compared to v2:
> >
> >   - Adapted patch 2 such that we now pass options as const pointers
> >     instead of by value.
> >
> >   - Removed a confusing sentence in the documentation of the restart
> >     points in patch 8.
> >
> > Other than that I decided to rebase this on top of the current "master"
> > branch at 0f3415f1f8 (The second batch, 2024-05-08). This is because the
> > revamped patch 2 would cause new conflicts with 485c63cf5c (reftable:
> > remove name checks, 2024-04-08) that didn't exist in v2 of this patch
> > series yet. Rebasing thus seemed like the more reasonable option.
> >
>=20
> I did go through the patches and only had a small nit, but not worth a
> re-roll.

Thanks!

> I was also wondering what happens if users tweak these values when a
> repository already contains reftables with different values. Seems like
> it'll use the new configuration during new table creation and also
> during autocompaction. Which makes sense.

Yup. It should be fine to change the values at will and for different
tables to be written with different configs.

Patrick

--I8BPG7OZeZAS9HHA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHFMcACgkQVbJhu7ck
PpQmORAAp4IZlL7S+7Hth7e5UL6yoaMw8MTGvy5zgJFPHOp/LA3i61Ockxw7Q16P
yr3ab3O/wPfZT/vUP7rM6PE8CCwk4zyCPb1oLRQI5FCITbw9JIS9zelU0GrXBlsC
6IcCEqYpzOv8moqRrganaq9TGkZKpdEXvxnKyDE/q++UzbMWw6lC4TZwOqjKCP59
DaWn3fAGamgGYWsq8W/RntoIaMuSVc0Ft8GBZbVhtfKfG3ZBQa5gSrQKPZt4o5a0
k2807hETbVHzQIXRYTqZHiaJVMDidqNJY77mmNNek7O3LhHQLEh5kAEQJcwG4F0N
7CUCOcEkMhYKbJIWLS+roTAF7SjHS7/q1CEfGv/1g9UrjFmIOxvs9gEbefMZqAWH
ao9sfIwmnDo0B1b4EcI4G+4jgeoG7x62tB5vxhlQA6SRWgOGl4BNsI9nymROEXaE
Z3IRIKtlfwJe8TT1DKSRuVr0+BDALQOZmHxMJpG92IQdDErc4VZtwJTP9FImlYG8
7ym70c7c1LuWNDoytMBHp15rv8TA9Ue0+sxdjKW/TmK9yYWvFrXr9IAIqoKtYnL0
fvLILDUe4Ns98RM84v5Wl01otApsmvw11avb/oiHbXASEUDkZ8mGkiFO+HOaQj0Q
M7uA1qvhYKt4ykQ3fVyc56YHxxbA2ZOMz2v2MjJfjyDb+HgkCEw=
=F1wp
-----END PGP SIGNATURE-----

--I8BPG7OZeZAS9HHA--
