Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B4D529
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651183; cv=none; b=toGckscX7XBpOeKZIlVMejN5jL7/LHjtjFCBs/ERcuKVoHH+hkS7q9uKnopb707HoTRc7vHicJ09HTJBaMg9cs2QWh9ru2n2ULvGHUwR5HeBf9ZYouHprty/VR+j7LZatEI4bWAy8z45VBSQXDvw3TIEZ7+sKSVUBG5/2+6m2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651183; c=relaxed/simple;
	bh=xuSvKA8GFKk8X9UqUGRn2f0I5UvD9kayRCsSp7i2nDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNJF02gkaDcrxdhOs97pULTENW269xtzEMoAMjAgZUZJ8Q2Lja4kpQiDjKZzEYSV4VaQKX2JgnlFN6Wz7kmkK+SO3w59mEK6hg0uw7WI2fozMzwuCPZCPOJVZKoa+VnoIzODv3b7ylBLZqnM8qXLYaUAWIXVRK1AjlEc99fOnWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TAKkhUqp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+JfGkcn; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TAKkhUqp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+JfGkcn"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 682473200AF9;
	Fri, 19 Jan 2024 02:59:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 02:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705651180; x=1705737580; bh=xuSvKA8GFK
	k8X9UqUGRn2f0I5UvD9kayRCsSp7i2nDY=; b=TAKkhUqpBq/uuEzB509rn9t1Ci
	yk5T3Qg7PBip4MJpVL0y8+0tfume18rrsqyIXftinE1+CgL0YIiwW7tpgEnuyEbl
	f1+AZAK7vwf5MgMkOlxgFErGUDSDYMxuvTg/vv6BnqaobTyGuxjw1sh9DSvEs6Yz
	3aOWvoY4Pxw1Scy8aSCsYT/a/SX/pr3vMtDQBe9muyjK0KgajpSRfUNH+dmMLvHw
	4LCi4yImhNOBv2My05TLjP3kmoU005Zlr095VrjfB1aBDZVfAzMENKjEjKkMkrF5
	bgFFC6wrLnShnBKUZ3eWpZ3XfMl5e8T6nQxx4ojvnjBS4LQdq3KWMetTHflA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705651180; x=1705737580; bh=xuSvKA8GFKk8X9UqUGRn2f0I5UvD
	9kayRCsSp7i2nDY=; b=U+JfGkcnJCuTeH0qkeynkYpvzDtPdGPktUiVCDwepyRD
	A3N0W7JwAEf4CH5zoI7HCW+1ed24kN7HDq3MU0wUXCEmKzsiw/bg82wkO6f371+Q
	Tq5JGihJyzgxhUDFs8F+jfjR6g58BiFRZb4M9XThFw16A1SNw6GbGP5mu+6CHi6n
	/dPEWyQRMCXmpisvBEIarMU87cnV0sXUs/SBZhD2Oy8HHy7sZgDAsrNGQQJ7rWcO
	VSl/51fweG03Aw+gg+ChSCH4jGGUwa5HErUlM0p4Z4wy743UoQMtIjg2cJX5lQec
	9lhVOxbPgRcxwCGRxSVCZdj1jxBt6POGQSV9l9Hu4A==
X-ME-Sender: <xms:6yuqZW0AmlHzAP4DBntCsCnGq12aDDOoJh5nFQ-JeUyxnAOJr-7crA>
    <xme:6yuqZZE4Zk1PSOdHw-78I_nHqMS2Q3RH78FGg-ui-1qmrAg3eQklQQm-zbUGOj0d5
    tMWTo0gU-CzAlcbSA>
X-ME-Received: <xmr:6yuqZe6zZKZnbUs9TeltH140LaHVHaoQT9qe0WPzaSTRuRCFwByhDLqH_Qt8TPbszg4HRndPEGfZ_qQgu_Gw_reADcRW6vrZZqP3oU4RvouEBgIMyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:6yuqZX3c09qqMGk17yNmiIxdMF60IpnKZGfhLwBwNsi1fpo1Si1gKw>
    <xmx:6yuqZZHzzGkvPA7Ti2yJheM_vSexSC40GhInHR159XA30Takqh9lgg>
    <xmx:6yuqZQ-XqveYLYYWQC57hQxsT7SMdUELu9Mta4-8iu6bB27-rZTyHA>
    <xmx:7CuqZdg_iu9Nl_Gf4PeS1V39JWoKX0PdTEE1KJ2M4g1o3zf37E9sEA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 02:59:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5fb435fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jan 2024 07:56:40 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:59:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, stolee@gmail.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] config: factor out global config file retrieval
Message-ID: <Zaor5zNLKE3UXhHM@tanuki>
References: <cover.1697660181.git.code@khaugsbakk.name>
 <cover.1705267839.git.code@khaugsbakk.name>
 <32e5ec7d866ff8fd26554b325812c6e19cb65126.1705267839.git.code@khaugsbakk.name>
 <ZaoUOPsze7rhtT2M@tanuki>
 <7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Pac5pRDPz1+UGKOL"
Content-Disposition: inline
In-Reply-To: <7f0864ad-c846-42a6-8ddc-85d6be58a4ee@app.fastmail.com>


--Pac5pRDPz1+UGKOL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:40:51AM +0100, Kristoffer Haugsbakk wrote:
> On Fri, Jan 19, 2024, at 07:18, Patrick Steinhardt wrote:
> > But second, I think that the new function you introduce here has the
> > same issue as the old function that you refactored in the preceding
> > patch: `git_config_global()` isn't very descriptive, and it is also
> > inconsistent the new `git_config_global_paths()`. I'd propose to name
> > the new function something like `git_config_global_preferred_path()` or
> > `git_config_global_path()`.
>=20
> The choice of `git_config_global` is mostly motivated by it working the
> same way as `git_config_system`:
>=20
> ```
> given_config_source.file =3D git_system_config();
> [=E2=80=A6]
> given_config_source.file =3D git_global_config();
> ```
>=20
> (The extra logic imposed by XDG for =E2=80=9Cglobal=E2=80=9D is implied b=
y `man git
> config`. I don=E2=80=99t know what the guidelines are for spelling that o=
ut or not
> in the internal functions.)
>=20
> Your suggestion makes sense. But should `git_system_config` be renamed as
> well?

Yeah, you're right that `git_system_config()` is bad in the same way. In
fact I think it's worse here because we have both `git_config_system()`
and `git_system_config()`, which has certainly confused me multiple
times in the past. So I'd be happy to see it renamed, as well, either
now or in a follow-up patch series.

But as I said, I don't think it's a prereq for this patch series to land
and others may have differing opinions. So please, go ahead as you deem
fit (or wait for other opinions).

Patrick

--Pac5pRDPz1+UGKOL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqK+YACgkQVbJhu7ck
PpQKag//QcfQuavNuvzgzW67jTb4NLdhfSRHoOftYmk6zZhi146fwXu2A0Btn6Zh
mF/x5LdB6xHK4OmF8AZj050PiptICqu2mNlmcMsUujkYWXzf4kS4I2Y1Dr9W+vAj
OYv+qRIJaUMz3pONlaQ/X4x1pi9d3KGBn/4wBId4besk9tr4Cu4Gpug//soIVdV/
j1lPSb/KKtmeO94bOmOgafAzYbDTnqnnvV5NECuHzePfFSl8wd9mqjgWtyvYYiFx
rdL96VZsyI+FwnyvbtUN03V/Pi5INpchBmK0Lvz6qItMW+/87S+rFrCOPwd6EPrw
HZPLs1Ek9/9Nug8yj/IKhMfPxe+dbx6hx3T+jvImjIe3WFVDGseC/xZc7i5vqttg
GouN2KD1kSrc9VR47KlY6BtOeFdvjX+gVBhmiLnbmC/7CeFcz1UM9ZKUuJe5WbK+
ceuNMPi1g9Q0JqIxEB2TcN84xzsFPO8vGuhPlAlff5Zp0EG2Cj4B8vBo16EVTrg/
ZLCRJ6Ye5LsXrCWVLBLM7Iqzn1oOchpa0qGNCxBkKpQa6CVfczQ9W60SLTohXVPN
T2/WLlj8IPMFuUnTFVKv91aTptljylANqMG28ZoPG4G0GDKuc2TG96Lei9i4QPJS
EV2UII7CXVqP4Tca2krvNKRr5psQzaj95k2tXV+7CiLjmZDgJAI=
=OcBd
-----END PGP SIGNATURE-----

--Pac5pRDPz1+UGKOL--
