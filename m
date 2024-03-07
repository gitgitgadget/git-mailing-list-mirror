Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930D5B5CD
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796824; cv=none; b=HoBcLHyhxmkUFShNl6kYkMRES4MLkR68Eb36NnOwXkZuNIEjhlPX7dnzgvZt+msY/GGR7NaIAZonH5XZIup9AVEmxeg5Zs73KjUNt4Dr6k5I40fpoHGdl30Bmpc8Fi0twZSEYWhmYaliZ0BmXvDtAkGOVA4RLRZE6bxTNNHAD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796824; c=relaxed/simple;
	bh=2qqOJEYwt5Jlujwx3cCk/ub2P4UWcHLlJ5zIfdMNe6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji9il9P01/pRScKg59pSXkDByV2HPxOBzTuW4dPljInIOurG1ZIZ2pvYRHyRLL7ejDQTLPDbe2OZAw8gf0jzAfhPJQ9vYlMU2GueC6HgpiqVeIrh55KgqcGe5WXicgyBGcKwsSKcdL9KKFdpZH3AIp96VOOTYDQHKmmkfvYaUHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Abgb2mw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ezNkQQpe; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Abgb2mw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ezNkQQpe"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 000FF1C0007D;
	Thu,  7 Mar 2024 02:33:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 07 Mar 2024 02:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709796821; x=1709883221; bh=OdhppIEl61
	3mjMguVsvg0VYKKGISOOpZL571PtIr7jc=; b=Abgb2mw1AXFI73pqyjCKnZfZnf
	uoCzW2e0P1ASYaaXA5hq3zBXVXDDBxP+aC82JrbW4wiL+gRb8pSM8nBw40S5xGi8
	axrQNL/plui/04EOcIZ09K//C/1YAtBbeUulrTPrkFn36D0zSCxjqylPRuhm5yxB
	HqQlhoyifOmMRi9Fo01DBsTQbI6TRHQllGoVF2Yj/hJLmrgSiFkUi0QiqomwHbxu
	UcDoMAEH81d6g6zjr9wLQN6TLTjXjOZc3dQ1PRM8tm9VYlor/CUmPxscGX2dfSI6
	94tvsBLXWcgxC3zKpWGjQkxD4DqDw8EZMtorkOQMbu5pN0jJfDCU4hm1Nr8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709796821; x=1709883221; bh=OdhppIEl613mjMguVsvg0VYKKGIS
	OOpZL571PtIr7jc=; b=ezNkQQpeg6W6HAoFA9Iruc4QCki4RfreAzZl5PVizyQx
	DHy78cZkU8jz1cKnljch4oCRw36qBu/m8RYI62BQGifeiiA+IQhKh8aPG2m+AL4t
	coZ3kjt/QT5lr8n1qS/s5wIAJdoo+ViHINUNd9f50p0nmOfzsD3fpngbNRk14mKX
	UqjQNG2p6kkLpzR2N+a0A6dqsanadVEc9r+/+uqVwq12YuVmFU9sOyXuVg7/ZJDD
	jBJYDvSHz5JNfqj0egHApBRMYaRzuNdf76AjYyM3dmXl2qVxI+q3Q71Pbnk9QaTm
	kLdBOvfsYTMoDdPPRfRxqNq6RDw5lnmY9UIrLpDeFA==
X-ME-Sender: <xms:1W3pZaAmLJsoXWpbnX8FCCZUavQVMDlJAOvIoP8RIiRAK9YSfVMwcA>
    <xme:1W3pZUhO9l9EgoKGQO7bSXWSbvulSRH5O_jQ2KOUlOZSRoOZppnkF8xL78GhTebnF
    9VRj33pyEqae7eJzw>
X-ME-Received: <xmr:1W3pZdlc9Le9haZ6LqwwUsy8IwvDTRGtJ-9zKVwP1Z-1BA9iOQXFBtbc7FjPACNnwo9JXbRG4wQW0EQCjH9YAa_kQmgDFsTIDH7oZzctmulKXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1W3pZYzqZekqMaBe3zRPyiC6tcNh3bLi7_sAAGIlWfP0HiM4gHopvw>
    <xmx:1W3pZfRpcs4HaTkEzDy_iF9IV_c2jDSqExWM4GkGbFnkABU80r_DTw>
    <xmx:1W3pZTbxvnfF8-70Rw9fH8DLAdcAyAEpLjEH_EOQ8byKGLdksinEPA>
    <xmx:1W3pZadBnUXnMsso_X3tsbwGScWJB3c5RQLIHH5eME9wyKY59v8xnKNfH3M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 02:33:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b672bad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 7 Mar 2024 07:29:07 +0000 (UTC)
Date: Thu, 7 Mar 2024 08:33:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] Documentation/git-config: update to new-style syntax
Message-ID: <Zelt0F-2ALVoBOfG@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <5ff2bf4a2286431a3b3048e0ea04d6551006d0d7.1709724089.git.ps@pks.im>
 <CAPig+cQevQKb8YA1Yf-t=AHg11P7i848gELx2kPc39g5cOWbqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pSgY8X69asdJpUmq"
Content-Disposition: inline
In-Reply-To: <CAPig+cQevQKb8YA1Yf-t=AHg11P7i848gELx2kPc39g5cOWbqw@mail.gmail.com>


--pSgY8X69asdJpUmq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 01:57:41AM -0500, Eric Sunshine wrote:
> On Wed, Mar 6, 2024 at 6:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > Update our documentation of git-config(1) to stop mentioning the old
> > syntax while starting to mention the new syntax. Remove the help
> > mismatch in t0450 so that we start to ensure that the manpage and
> > builtin synopsis match.
> > [...]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> I'd like to push back on the part of this patch which completely
> eradicates mention of the old syntax. Doing so makes it difficult for
> people to figure out the meaning of git-config commands which they run
> across in blogs and existing tooling. For instance, the following
> recommendation is commonly encountered in the wild:
>=20
>     git config --global user.name "Your Name"
>     git config --global user.email "youremail@yourdomain.com"
>=20
> Typically, we instead retain the old syntax (or options or whatever)
> in the documentation so that people who want to learn can learn, but
> we rewrite it to make it clear that it is deprecated, and explicitly
> point the reader at the modern replacement command or option (or
> whatever).
>=20
> So, perhaps you can have a SYNOPSIS section for the deprecated usage,
> as well as a "DEPRECATED OPTIONS" section (or such), so that we don't
> leave readers entirely in the dark.

Fair point indeed. I will update this patch accordingly, thanks!

Patrick

--pSgY8X69asdJpUmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXpbc8ACgkQVbJhu7ck
PpQOnxAAlMINJjz4TMYGnqGhso/DUGFoqBlb7P8kQYhhg80Q3gKKZ+DPZwpcI9uk
r7CYu8By38exgMx+80Tg6inSuHi8avWY9MERi1gxBdAD4nDM64Y+XyGVlC9o67UO
ZLinX7eNHrHBpGTnZtz8zuMgh1YSbcA4+zyB01TlhYpoMXrBx392vGtwRtLASpYy
NW1bSmMbR+vj07h7m8NG7EexLnu9dB0CEJlQ50VbMftt0Jac0NU6MNkGBAg6n+gW
dRdFY5z80gpz3vtD79scorb5zzStq9aW87GVLyi5/r1dk734DHyzwedHHGT1BDDK
bA79bUc8I8C4TZ8uJMahH0iEkZbfcdkX24cRTfBime8NqULbhBUkTGKa7WKsJC9j
gPVREydZl172LOK9DuCZdwcy00SQtARwjgN0DLQ2k+8ypLj+DKDyigpe1nvDpGl1
i99OJOGsyxQh+v8wP0Y54YpuO6TdytnTEzfh+WrCuHb32gWXmMfZQTiEgx6uVM2Z
GGng39BGBED2ttRUH9D+J1yeqzApguFVcy5Rh326pNYfHSmM3hq98Zq6FJnYgQG3
RJdX2uc/aVJVGFaKe05KohSdfyolze4Kyj56pewfWv1I8Ce279bJFYu35QGaQ/71
Agi2Ck+JIdOBHnCvN+IrM82F8JcNBIZhFm/qap7YksEuLE/HeHo=
=zMvT
-----END PGP SIGNATURE-----

--pSgY8X69asdJpUmq--
