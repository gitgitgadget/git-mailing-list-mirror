Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B815AAC8
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776792; cv=none; b=KvSS34aMsUBmxzejUtLRVAPV+/tx7aj8+Dnyl2PHu33nW69K97BOWVliu8hjK/hloR2TmdazdM4cgT3Bg4QKb/POvnUxUU/WbK8796aYCvJsYLjumz9jiBOlWALq8vZHWO/5EtMfa6kErSyW7UNPcBFDoHKYfj0wfTKWVytQK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776792; c=relaxed/simple;
	bh=bnCsjc/vmdX38KotrmShJXA4JYm8Y12kBz5YZNn7xx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ0a0rJ+vUO+izs4Sz6f8zx96hw+ustfUFg4P2e0YK42avR3ryQgLf1YDQtb3lPLmggdAucYMkzpxEH1xX09DrCX3ssihebGTwPvswEe0830fZpKkU5yjozNzykeEq28GarEgkkKI9CtHZLIok47iUzGYF9BgLjCaRdHJTsGTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WDBLIAnn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tjqx13vu; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WDBLIAnn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tjqx13vu"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 705D81800085;
	Thu,  1 Feb 2024 03:39:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 01 Feb 2024 03:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706776788; x=1706863188; bh=R6TROvch+u
	8vTxffUB+Vkz4egxhFAEKsldg5yBWg/VQ=; b=WDBLIAnnYJ6TpK/ktzf/KbQ04Y
	oC/sbTjGF5gqwTdiv00xabDou2WSNYCcmgqlgTFXpGrHdD8zPuQmetB2UYICRvSe
	+SLKybKiM1N7IR/YBpTgbqr0p3XpXDHJvGJtxoSgcUDSlam02BgsBnAPHq/u8zsV
	CLimKpRr0XjgSGQc+Xj5HhYlNLqOIQSOKwicz/0pPOyesFdh8/kC9Lt1vCDK1YMH
	Y0YT8/TLlz7JfnvD4owbjQ8s6yD8WFZVGrs/yhAeXW3fC1IFkc2tMfHsT1C4VARa
	EEGGJrr/IVEA+LTmboAdWzlq81gbDnlOrWuw8COhh6NOyzqpYB/S/cX8QoCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706776788; x=1706863188; bh=R6TROvch+u8vTxffUB+Vkz4egxhF
	AEKsldg5yBWg/VQ=; b=Tjqx13vu7FAKgHcIJuVp6u8cWXPh0/DTtduC+UMnqRc2
	wPo8boMgxw634/AUhirary4pvTv7LSQenz7wN5t6MI414v9hehiOu0AAt/f1wCXW
	JfzhpxgA9RujfTcnGt8mLsvhywYHS+NBwwsQMiPHQGIrRY9U66V6lokR8XG3ctYZ
	56UVGq6BshxFzILP552iBp2wlWcKcocFGNWGbclWN0sh47el/KNi4/QKRPoir4K5
	yRVc52gdSPgEhrHIbAwv4Wk4MWDk3JP3EAVpMi0uEijxRQ8t1Zw2CmobTaKufvLF
	HFIzoqNopJrVSAQa+KPmFYjY+31ItEbF+LCP6xzOTA==
X-ME-Sender: <xms:1Fi7Za4sUlwYiaKy4OnPdvEuQ9U4B5CxwY441TTRyAkr33ZCUrplsQ>
    <xme:1Fi7ZT52f38cRMcXB-q0TvR4-y_0mkMgpeJQfWs4kENNLWCd9EAm-tjJwkrG1XGQL
    ZjWm3SXsNMKT4gEnA>
X-ME-Received: <xmr:1Fi7ZZdkCYrwbQVfZMKd08QTB_DSJBX_KIcDIy1QNT6gXRDbDLoeDBkbbXBOXuxLEevr-0sIiPaiIa8jR60VRu3xp6DEGo28T6n_u3vzJncqTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:1Fi7ZXLqdijYDtrwrBAPw4kIpYjSrfAWy2C9ePhtZaX_kcoGLI-y4w>
    <xmx:1Fi7ZeICoEowFf8bumiYqFkZy0mz8vKnmefw-wP2OXHeK0N74sFsbQ>
    <xmx:1Fi7ZYzi9q05owKpHyeZR5VSQcKSDZNgWT-LdubWc12timA1tf7WMQ>
    <xmx:1Fi7ZVXK34VXvPb5G7K9lvfzylFgd5aTZkks43CDPMFwYm3FgXaYVJnW7qk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Feb 2024 03:39:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47e39812 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Feb 2024 08:36:19 +0000 (UTC)
Date: Thu, 1 Feb 2024 09:39:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] reftable/writer: simplify writing index records
Message-ID: <ZbtYy4ZdjATQ4yi_@tanuki>
References: <cover.1706263918.git.ps@pks.im>
 <b0982baacf74a4501ce5c543b294bc15d6937875.1706263918.git.ps@pks.im>
 <87sf2dppjt.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZF+JdpHz2PbT0BRn"
Content-Disposition: inline
In-Reply-To: <87sf2dppjt.fsf@iotcl.com>


--ZF+JdpHz2PbT0BRn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 02:44:38PM +0100, Toon Claes wrote:
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > When finishing the current section we may end up writing index records
> > for the section to the table. The logic to do so essentially copies what
> > we already have in `writer_add_record()`, making this more complicated
> > than it really has to be.
>=20
> I didn't feel like this commit message made it easier for me to
> understand, because I interpreted words differently than you intended.
> Using "may end up" makes it sound like it's unexpected behavior. Also
> the use of "copies" implies to me it's doing a copy operation. I would
> rephrase it to something like:
>=20
>   When finishing the current section some index records might be written
>   for the section to the table. The logic to do so is essentially
>   duplicated from what we already have in `writer_add_record()`, making
>   this more complicated than it really has to be.
>=20
> Other than that, I don't have any comments about this patch series.

Thanks, I'll use a slightly adapted version of this.

Patrick

--ZF+JdpHz2PbT0BRn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW7WMoACgkQVbJhu7ck
PpTbsg/8C+jChylOCVd+bN+BF4mOVSCpdeaKcvvX0Ov1Q8w+QFPWUM7tDN39SoSe
wq1k1g/OXrPGY+GEiw1lwjxAs89EjBgIKpcenjMx0XSOJK56BXsqekTMOWdUKD+o
6W/WPicrhzcV1u4snu3OFz8EZDLfT0T5H/SB6P0PAMyLoO4uBTh/Hyx9P19S8jZK
QUMUIS4Aw1Dvxxye68lIr9Ir1Vdc0aQNPIPECNEhI52lZaTRZKqwYhcYylzRwvlL
1m8rAU0fDbhnLqDJxVxj5fHqlcneWhGXtG4cTbnu3jGA2KYUKk5+89LVrLUbVnow
wVR46bfN7dkROWbTIt32fJJm91fdDWcMrbWyzchvNrC406nRnBRazm5wvRQWT9OY
LE+JAfe4v1DeH6e9nzwSOVnY0WaBeExbzETfyoAxTNS1X/c/6Gi7SNHPLuDZksBw
xPpDYJejd4prwnHneZTstTd5Fry8DLPGjxyJ+uibO8mn5srxdM3waZt/AdAjaOnj
RRwTk6fvn+clzFY/OxTkyv/IWgcrR5yFCPuGNv3wm1gSklGz4IZvY9zdEgy/qTBa
msuNU+qJ70nUeQ57iDc6Vbxl7+0lV0Si/xa8mQC2oGXo84aEizIL/xFxNYxOeyKO
ntT3Qlg/vHnaLyiHukJUidciJj2CRaT9vGmcekSQYxuJ6vfsq5U=
=Y8xM
-----END PGP SIGNATURE-----

--ZF+JdpHz2PbT0BRn--
