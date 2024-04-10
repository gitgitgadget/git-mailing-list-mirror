Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EAB125CD
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742177; cv=none; b=HSD8f2B8tlYu+W65PLe2om55J9VNDZ0Iy/jlYkFzoHhtwAg55Gyxh2xvOcxWe9mrp/DBrCU3/vsIXLtDULfwVZxEi/Moew7vNu9MVlk/z3qCT0rl06x06XoxaYxeYYxfuBtukKiOKMcs3n99xvJTYhc07F82K2vJRDYV7kwIfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742177; c=relaxed/simple;
	bh=TSfGIcu4Tn6g4TtVPMmDWgT9Q1EdvUTnLHZW8akPfBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRNqxxy9x3HeiByQzf/SoVxU8zqeJVGI+L2wqeIY31ZlBW3Ecz0uo7XvXzzft+gb+jzJO1uS8LcMp1f/Vll5n+Z3dd7LyA/oqK4VF5TmJmrfg9T5I9M4RUUa9IECgicsPz4wssGkLVq5Z1/0devLuzYBF2S6+myzUoZfyCHe72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L8QCcwDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKRPjNq2; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L8QCcwDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKRPjNq2"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2B22911401A0;
	Wed, 10 Apr 2024 05:42:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 10 Apr 2024 05:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712742174; x=1712828574; bh=TSfGIcu4Tn
	6g4TtVPMmDWgT9Q1EdvUTnLHZW8akPfBk=; b=L8QCcwDTXsp0acQ7zq1Ui3gZJl
	zcVql5XArqo64ocDSlh59ZQiTCvQYQmUgkOqjHecFHuTP+C1w4MGP7vKt8fUVUP+
	1SWh1tSkCPEx4/RsBcbKzyVYB0KOTvpDF2sCHKp9ADKK6+0m2MCjoTuErGLWQKSG
	m8qly0g8TvUhFJgLMEoLNadjGfYAGaLZqLxmmMn1cP04Ec1fW1Omn1xkaB1jDUn9
	wHm/KylAGc1nVx3hLGI5VCrIQUPORBLUTldRcALI2oqFMKXFBg/XjEFM3XjY8XLW
	/Wj/2rzbh2wu+JD4UVlGDa280UWj17APbBykD59A5bh3MIPec+xN4saehUuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712742174; x=1712828574; bh=TSfGIcu4Tn6g4TtVPMmDWgT9Q1Ed
	vUTnLHZW8akPfBk=; b=EKRPjNq27U+O9u66PrTHG5FhOwKsAMY9rvuiILRocgKm
	Ix/cZ+2caX8RteaMDMSZpgCzYTBpHRq0/K9Wbki17S3kO0KRahhDHLO73tpJD7a6
	ARXTqNxhnYaemIK2ukbKp0ZYF+A14HmsY01ZBa8s87Flxw3PSum/zuq2NqKisK/d
	O2KjWdrP++r5NH8X1TmNNlwbzoHYixAOlm6+8sYfkQTe/6zS2NJdGMG+zo5kf9rW
	uCWcaeDiQpgQz33zoZx6FGaItWNVorde1J/L5mnJrzWekQQMw7A/IB8Q1KH0XYCO
	12YgcHRREujjC4F9XXUX0jMO5dI4mZEE9gDzcKr0Uw==
X-ME-Sender: <xms:HV8WZmlSL3v9BItctzcZWwvlssqzfPTHZ38JhuLibG9OLXqjWuVH0Q>
    <xme:HV8WZt2I8kWpCUbVKepUv7cWrxl9jCL72lPZ8E-Lz4zLJ7bVZaKFTx5WZySup4nNQ
    DSMC9dl2qwJ3iRB-g>
X-ME-Received: <xmr:HV8WZkosV3i46nwCvmgX5qcFwF5HAsiTheRBKHe_-LmIsn1rCDMbbSSr5GhhpzfMm1VNaKNZGVNzK7ThqPJ3N-HquJaF77VoK-KrMZhwr6iLABs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HV8WZqnDA9Q0Cyv9T_kLpYT3tIwUP3YD46MU8cBbvzdMPMu757zyTQ>
    <xmx:HV8WZk3pc9FJ_c4qwvjo9BVJqwJm4Ql7lOtVC37aJK5ekeQo0UTPJw>
    <xmx:HV8WZhsg2KvmAo3m0FA4T--tobYpyRfj-hrXP-8-BZ6ot8dPHSLEEQ>
    <xmx:HV8WZgV_X81bjqvDq7o8YP7MJZ6j-djshaebLlFNRr1rquifCKeWVw>
    <xmx:Hl8WZnQJ3pTzjRD0J8Tl-x0FUuY-tfQ2A_yK5enphptxvYr3C7YweHIW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 05:42:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6214c3ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Apr 2024 09:42:39 +0000 (UTC)
Date: Wed, 10 Apr 2024 11:42:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
Message-ID: <ZhZfF5YH-uwx-wYb@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev>
 <ZhYxNYR33ftEfcPk@tanuki>
 <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com>
 <784B5318-F155-4D93-8085-62ACA63432E5@archibald.dev>
 <CAPx1GvfUs-dR_RbqnBT3YhDJPMB7b=+fzyow8qjJgJQnJwg0Pw@mail.gmail.com>
 <6C467327-0DB1-4E1F-8CB5-23DE45271348@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TKRT0P4y6AuxYG/c"
Content-Disposition: inline
In-Reply-To: <6C467327-0DB1-4E1F-8CB5-23DE45271348@archibald.dev>


--TKRT0P4y6AuxYG/c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 09:14:16AM +0000, Thalia Archibald wrote:
> On Apr 10, 2024, at 01:51, Chris Torek <chris.torek@gmail.com> wrote:
> > On Wed, Apr 10, 2024 at 1:47=E2=80=AFAM Thalia Archibald <thalia@archib=
ald.dev> wrote:
> >> strchrnul does what I want here and I=E2=80=99ve replaced it with that.
> >=20
> > `strchrnul` is a GNU extension (found on a lot of systems, but not
> > part of C90 or C99).
>=20
> I can=E2=80=99t speak to Git standards, but it seems broadly used in Git,=
 including
> three times already in fast-import:

It's fine to use `strchrnul()` in Git. In case libc doesn't provide it
we have a fallback implementation in "git-compat-util.h".

Patrick

--TKRT0P4y6AuxYG/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYWXxIACgkQVbJhu7ck
PpQidhAApH9Ff1yCt6LzMwawU22WsJzPNcGW1nPUxMilRU+tm/k/TrNdUbw2yVhF
ESP6Z/wJFUfybMGmis1YEFCngZ70P6kHCG3tR1tNPdbY27HZ4HqGpbNSPDx/gbYP
XmnQe13f9PI2WUwubKDe2MQPFAPNrdRoJNJN+66RQXt+IaA1oNeUcug4KrsaSzzY
2TUx+1rtV5vZa44P0LrA+KYkrJfTXHFyKQKJ8KdNrkFpsGlAlxzZ3l2Nxa+tFScb
Ik7WGhpJDyHBwF3whT5AgDGTf4cGWcPlO4ussENrVEh9IgahE+uPQbCVmqyVJeB3
wvyN4XNAYcsTqR6MTerqV6MOJzmaatrXkOL+pTecIEiFgsN0IfpOqFr31vx3RoU6
kDh6OLY5vkXgIA5g5nsMtwIG++Ue+FVGplD9MljN2tbN236MiHjxfkH03wxObe46
lKwgFnrPNzIpE3WuqGiWhgNvxwMZwo/2PzlAbFaDYjkynhnbiGVrFsNCBUCjx0dk
4H7V+MontwGbPAgLB80wI1i9ADQBiZplTFJh5WCg0v+ePYESrDDf0r6HetMmH4ni
6xMmmlx5SUcKvZ1ZIxiY+R8V1ZtoqzYBba6LXQ2M6/DDeyV2cL5GpA/fIynZwYDH
XPEsUWPylcB6TR7FvLNP47iVUeek2DmpxBm/MFceGtAWTjE7L1g=
=/v0r
-----END PGP SIGNATURE-----

--TKRT0P4y6AuxYG/c--
