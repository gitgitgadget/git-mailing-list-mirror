Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923CF21A04
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714631254; cv=none; b=k9MM0Cvg6ja0UjHZRZtmlR/ogNZcXyQx1DrQGLY0dXnD3jQpwiyVyLvzQUXpmWfResgdJUO53qSi/2q2L18bgIrVc1fXKKbIJux8gvy9CC9eNrh7cAAfAWlKZBiHulrwHszU3ACoANMPoGU3OGAKZTTovPAXWwn11mL0rP5QhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714631254; c=relaxed/simple;
	bh=FbBgrGAS5LDhBTUjTzwylRkJS5eRiMdXOvU0Oue9sEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkntbWvBp0XfAHcFmciEU0y0oYVYRlE0qWu3A4mIW0iIiQ6gbO1r5JgR16KbvtQixuQIaQWBCKucxakqYtXmty7zlbuiJw8yPZ3zKZB1k+TluGK0T9EXn9RsERP/7aPM25kfcMdp12drgRHp3an879qCFcjzsJdQSbn5A6HJNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ohzc0Qpz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjHf+Rr7; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ohzc0Qpz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjHf+Rr7"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A3E2211400A7;
	Thu,  2 May 2024 02:27:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 02 May 2024 02:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714631251; x=1714717651; bh=FbBgrGAS5L
	DhBTUjTzwylRkJS5eRiMdXOvU0Oue9sEo=; b=ohzc0QpzGE/N+GAM/bd8nISm4B
	dN8blkUU8YnW4HXO8ZZ1EUFr44aoaopkQl+t+oYJcgMvOT5rICZrmFyBLZe209Pa
	7mL25vR/ltlzi1iYVSwur7i+r7udBX/JXoYqXnUdSRHZGHmt7nCzKXcxjDYk0VvZ
	46JHNYLu4ZAPqJLIHgmnMKF5aMJaasv1rytZLwAc+UWqMSvg692SC2X/3+BWojge
	S7C2jo1UaiQlXjL2R+179CY4QCPtdTzmv24qEOZ79dZ9p221+eaYYLf0L4nvNG4u
	u8Lt7LA+xxMLFWTo4mC2ZhVNt82m0AJqMR/RsWUYhZFcHXAgrqSPtUx2bhjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714631251; x=1714717651; bh=FbBgrGAS5LDhBTUjTzwylRkJS5eR
	iMdXOvU0Oue9sEo=; b=cjHf+Rr7pVrg9vQmkIM4GD7eZlwGWNAcRXu8eDwN+FMX
	FKYtVze+8iwJ5qZbg2ODKF0UIQuhKs0jEshYJw7y9cERYgPpIaLu5wcIpmzrcFqu
	8YA2Q2JNGofgZrMdvMzq1fWyWpY6EZ88BAekb++dzYm0hYAXf1zHYwXor82XCM20
	DQfAWPP0kfeMmQTPslMSNSsZK/uH27YRLpHrHBG6cSfvBwVbI+0w9Hv3mifSFTc6
	6xBhxVuPEyn5zD5xBm1QARPEwaORpQth0LGv+AKjvYV6Sc8Z28pHkMOIGWzHgQSB
	X291q3Ve6ppenKyxLgv6vo4zyg7Pyhq/zPECyb4FRA==
X-ME-Sender: <xms:UzIzZsTIU3930lJ8RiVi0vwWiI3MAI4Ud9a9Ws6sfYY0W1OXLys30Q>
    <xme:UzIzZpyvstGlWPmCHNLzpFsRW8LXMgdBmeuPGHAoeo38LXHsVSF-uBckXuc6hz_Lp
    nQ8Q3HVuu_nlDLQHA>
X-ME-Received: <xmr:UzIzZp1FC_aF9kyHDN2DZIs5oScI4-XBGi_s_09Pozt-B0Y866A5YJiY5P3kLvHh_6wvwUug1-4G06Xc0KUAV8Z1bAZO-fkmDQ6ZSVNmVHraONs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeelgeetheefhffgueeludffffejleetgefgffdvfeegvddtfffgfeejudevveef
    leenucffohhmrghinhepjhgthhdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UzIzZgAe93qV5JF3Oeedaxh-UmyjDTun0z5adbI_MNdKKJDuEiJI5w>
    <xmx:UzIzZliKb0SqiNpwVIVvgMNaiUEdlTntHnWUTl58ijJzcBleYr7ZZQ>
    <xmx:UzIzZsqTz7PRn2LqTK-axbKimIGJzyYr-IgDgHzVlOnN22wa3Bde2Q>
    <xmx:UzIzZoj6_upBr59EDgsLA59eNWWHnUPHz9hCww2IaswHhB-P33pfBw>
    <xmx:UzIzZldSEquDvsdd-YqxVB1djlEvMGu2R8sqi-Lf2poy_4wg8I-y3piK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 02:27:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 660cadea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 06:27:04 +0000 (UTC)
Date: Thu, 2 May 2024 08:27:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: John Passaro via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Passaro <john.a.passaro@gmail.com>
Subject: Re: [PATCH v4 0/3] builtin/tag.c: add --trailer option
Message-ID: <ZjMyTyOb1PoqP2DH@tanuki>
References: <pull.1723.v3.git.1714416863.gitgitgadget@gmail.com>
 <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sTW4G38P91fE0DO4"
Content-Disposition: inline
In-Reply-To: <pull.1723.v4.git.1714488111.gitgitgadget@gmail.com>


--sTW4G38P91fE0DO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 02:41:48PM +0000, John Passaro via GitGitGadget wro=
te:
> 4th follow-up patch taking welcome feedback from Patrick and JCH. Net new
> changes include separating from a 2-patch series to 3.
>=20
> Since git-tag --list --format=3D"%(trailers)" can interpret trailers from
> annotated tag messages, it seems natural to support --trailer when writin=
g a
> new tag message.
>=20
> git-commit accomplishes this by taking --trailer arguments and passing th=
em
> to git-interpret-trailer. This patch series refactors that logic and uses=
 it
> to implement --trailer on git-tag.

This version looks mostly good. There are two tiny nits, but other than
that I don't have anything else to add.

Patrick

--sTW4G38P91fE0DO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzMk8ACgkQVbJhu7ck
PpSirQ/+N816+KFw09lEk0gl+TJkIltSK4xDcB2WC1hokmWNJrkK+z2CC1q+NS88
e1p/0HlOj+wzBMgfPkN+IFJASsSToHcHqW04VkL9gk6I9CK1rCeHDUr9wRkCejPK
ihRGhuTa51P8u5dHbg+kejjFB6gkJ0FxHDGfTbbcCidiYCTLIc4VtJqXuUwAVu+p
o1JnRQEtmLaS/FhTI6fawWG0Z02Ky4JLxTXHEebOgmy+fIOhW+/RxT4VA4OQRkJw
Ztf4Uv5fqxD+6rowCcM0+0EsLC215pgfjOpS7X1sO7+QvgijgPZslXhZw3LQtnCz
QrSVUno2jtIaWKXRve1au1KAKeJvf14Z099gZiyOXPuZqxS8M+rwgR42AYOCRb+7
kCo8MuQ8SiEtp8RP7Dua4bmN6KDhX1bncd5PdhDQErRmpWRinbzWPliKDwvumSzH
Osj4DguJ5VvIy5U7o4v6bYvXqLjKyvg7cIDnicspNY4ASfSw8pV+Z0l5ysrddIGa
M0OZVgjGPdHgSx3x4QNd0gdhxcMga8ZDRraLaO/aJa15cTg8lBxndoM/UGearDJs
FVvQgikAUxQ0mgGVKtqnVhR8SLLTnNfoqhzjJAOqN/c2zQTL/HgoYysUH8jxFfSt
r/oGIyYRPG0pRjwBtJhS07xSx4TQOnRQhdfMFg3ikfB+0UhJJho=
=YFec
-----END PGP SIGNATURE-----

--sTW4G38P91fE0DO4--
