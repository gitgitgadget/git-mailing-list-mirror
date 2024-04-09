Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B974C69
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642657; cv=none; b=bamxyfXL+DRf263mGi3yIElJaolCDesSKCvXn6DO/ADl+HsB8fLx2ISnIw8J8PZ0KQcGQ+nO3/4BcPGJEKgNQ7VJ84vqebuKms8wf5jPwG2lTwSHzoBTsjdzXjSHKvlt7n6kcA+cWjFzgdL2UbG2BZp+IsaoFxCpIfnn8ejTysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642657; c=relaxed/simple;
	bh=RK03XWElM9292hkz27Z140Z2N+6MndRmp6z0wiMfRUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwIt0WnZgNlvBsazfus1zaubXvTCijXrWeEgytIXcoOYcep6FhUU3FFoYaLlmiX4yyczEdz9SU3H50dgWeiR7F16uKJAhQE902UekwZ8gr+VvXXhb3UT5nYXAEN3rpkIm5Y1iN7Djn6E74Bt81JFFAj7O8Xq1heotQ3QNIbXC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AfvuEAoj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r82FvFwE; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AfvuEAoj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r82FvFwE"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 082511C000F2;
	Tue,  9 Apr 2024 02:04:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 Apr 2024 02:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712642654; x=1712729054; bh=RK03XWElM9
	292hkz27Z140Z2N+6MndRmp6z0wiMfRUU=; b=AfvuEAojwJW5RlXSa63vQ44Ht2
	eJQTwiJc3EoePFCYHYDVg9aMYzBwu1VwlZxT6Hsa6FGtZ75+bcL9VpUGsGJs9vJY
	JYZVPowAFl+PKdLL8wGgYJ0g2w/Fp2YryGm/2FZouGJQQoJz62R4s9pKaVIDwqW/
	5kmpB3EhW/ShZ45nSB4dDVdpfPdYTAerBdgP/kbGsmAbr3+xgx6uPLRwp9aybrm6
	aQUBJJca+Z7YMVocn4daZfVAfsBpEk8u4gtL6+uyvoJPiubZtNibisubXg5A66vS
	PG6RTBrD6Jq/Pow9sWGa4oOjzMrcooUgFxo4+I4IbTqm50yV0SZj0IGlPB2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712642654; x=1712729054; bh=RK03XWElM9292hkz27Z140Z2N+6M
	ndRmp6z0wiMfRUU=; b=r82FvFwECOvmyHDyFlsDD/WeYQzXW2IM64ikHe0WMjT9
	vU97YX7Y1fMICimkwBlCQpdnemFgzsouTUYykfo1QKEjhSTPQPSpMNO34wL975CZ
	j138X/K0K2Gr6Xt06I5g1QC35ngB8Rie9rz16gXQNXVIEVLAtI8hKoitPEp3HV30
	8eG6bw31+SvasX7JueSCPC9tu+Xf67+QVahqFfnOQrlk+LilPUekE9jaq/ZBNjUv
	0gkvTB0WqWNhuVal0oCd+oULkRt3Vf7bhHhrg7eJOlYQDQcjHEn7llD/rQlDDj3u
	ZA2ILB21FmnQpV4rxIWIIo6vXAsWzGjLZnkaas8ohA==
X-ME-Sender: <xms:XdoUZoyTA77LILX3PA-9LhOJE0Far-SwMkZ4Lhu9eW_ToC1YEhxvyw>
    <xme:XdoUZsS2G9MGvrfZvWfPoe_c1vP6sWCkSvujosQQP3IHlgBPR5tsMmPrgjTpVFqsv
    F7cvtHySHAszBy1DQ>
X-ME-Received: <xmr:XdoUZqVBETXrmuoIgdJa2-PQ8MZ1adnsDSyfX5LdhHbukmPcAazZZGXbrDrAjJV4yv5LQa9b-LxxVKWAUr4NSAiYvVYfZQJnewxYJ3RLyf_5lzroFFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:XdoUZmidUviDNMxW-_nR0u8JwGZvG_6DTRMXyAJXOOCcFnrp2AZZYQ>
    <xmx:XdoUZqA5vHz2R8CGWLo6SdxMiQOa93uUp4_L0ak3E86uS3k4FbNcmg>
    <xmx:XdoUZnLlUJghyfXtdXpV4dFDAzQsaEOVekX87RZsZ-24xtQGLoPf5w>
    <xmx:XdoUZhCvS1wPNyGOwIbKoV5ia-FGQQDFl5UFhqwbDPq_3we2wIz7nw>
    <xmx:XtoUZgB6sBQSsAU7zAQim_8AEcffV5TyCRJn6MEDNqpUlX4U7j-_pzZ0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 02:04:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fbd884d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 06:04:00 +0000 (UTC)
Date: Tue, 9 Apr 2024 08:04:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/2] rebase -i: improve error message when picking
 merge
Message-ID: <ZhTaVfEEza0Z00em@tanuki>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <pull.1672.v2.git.1712585787.gitgitgadget@gmail.com>
 <fbc6746e0188ed7b69c238935ec85b69112ddd79.1712585788.git.gitgitgadget@gmail.com>
 <xmqqle5n7ajt.fsf@gitster.g>
 <ZhS-IllueSZa1NXs@tanuki>
 <xmqqh6gb2kdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GtsckzvyIeyZGubd"
Content-Disposition: inline
In-Reply-To: <xmqqh6gb2kdz.fsf@gitster.g>


--GtsckzvyIeyZGubd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 10:08:24PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > So I think it's okay to not mention the exact commit here because we
> > cannot reliably second-guess the ultimate extent. My basic assumption is
> > that in many cases the user may not even be aware of them trying to pick
> > a merge commit, and that it may not have been their intent.
>=20
> Hmph, if that assumption is really true, would suggesting "merge -C"
> be the right thing in the first place?
>=20
> I do not deal with non-linear stuff in "rebase -i" or sequencer, so
> I may not be a good person to judge how good your basic assumption
> is, though.

Yeah, neither do I. The assumption really only comes from my own gut
feeling, which can certainly be quite wrong.

Patrick

--GtsckzvyIeyZGubd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYU2lQACgkQVbJhu7ck
PpT/kg//UG3886oR4XhSggDEBYafkd/18QDW1lSIdC6V7jWltUViFtieR3sh2TRH
FjJp6hoy+8LaAU6MxTecJMpzxugZZdzL8tXe+pBU1836d+gO9h5u5BYBgryR6vIW
rB8YaSTTg84WLcQRtlPCdaGAYB66PME9/oDFN2nG65D3HVcKnO/ltMVcKi9N3iIS
RhyHMI3di0QGolVYtzHrfA9NZlzWYsvdqz+ScgqOFre71CzoROB7h3eLak4ggbcG
11as5Y9UtxGj9Cd1tSB+8Wj2a6sWlz0dA/vbedWBW2FPpQyvZN6GipQKsA85cbwU
BRcaZt3ewiqbqf/Ilk/vd3zx/RNYkWJke1Rn2QmOEApbYaU/AbA1u+D58fQmVr/y
zvvD9VnoBNhl0heC4kPy8vfiZZYE21IjYhQU6q5dH40Jr6FsN4zvJ8viNpnNn+J2
Ny3Y9LLsUsNB3U6iFcoGxeqTCPk1Q1XPjw3LxTyDAuIyeBZtTsNpZ10oJZTSGnMV
uDfVhO+rf6qWDi0RMW+noLmocRw2ilM58Kqeu2Il9X30YJ5sKemShCOjNPT8C4Kd
m5wrHLP3n/f9jRlrHu+kfuElleDT71to/Nl9HYJucTSeX07PGN0zogvfEh3el/+E
fxKBl/fQFPJs87p4PQT9OJuORTVIE0zaWJKR1uePn+PpLEgODJs=
=+KfF
-----END PGP SIGNATURE-----

--GtsckzvyIeyZGubd--
