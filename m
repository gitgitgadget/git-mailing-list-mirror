Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43282233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362384; cv=none; b=k6mwUiMTpkNQUQzAfJt0n5fzOVFrZcA3Oh/gP+8QjK1tX3hxuBaTptIIqAC6+1+R3h3VvS4JPGrSQnRUCBY/rn2oMmmC5Da/ehMVAxCDonmzOODUwq/IeaKofB4IJs419/4XmFgzIgNr0dAF6yv9MeMY4BmT2W11RhV19TtgqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362384; c=relaxed/simple;
	bh=pWY0ooIRGAc8iO3dyqSTyc4MGWtior7cDjpgenkBkvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc4otEu80qMNWUQuQ7D3f8QKE/x0La8P3v6JFDMJ5AR7vRepOvsJO7eiT6Ldvq0cXXcQvWzdSBOreuQE/IK2jnyqajY6EWxZ/LHZk5CwEpljLGY0fgbX1jKuFv+CcRc8bswpeZVmvgZ2QdORkUlzeYwnLHQOl6IL9pMkzIliUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bKxVPu9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mpa5kqRp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bKxVPu9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mpa5kqRp"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1940A11401F2;
	Wed, 22 May 2024 03:19:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 May 2024 03:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362382; x=1716448782; bh=dqZBMUfbyk
	WZR684sYnegODmwSAHyK+3BRMVKA/EY68=; b=bKxVPu9jKn5Xvpq9qz895JZ5eA
	v820MyV6Vf3IZBfM5aV1mWAipPhnXEordAvwO3dCzb6gCxeBdNOaBgezeB8MVoOR
	2OfuWOhuWp6NWmEP1rfmnPuGj9K1zoRwhiRBwSfi2aUWb4yd4qqMg3Ih3VYGuAGp
	DKiDzSKTKPQgpyeYSsDjvKQIu64qoa/+sEN0uHLAmSC+iVEaO0XkjvZAkvAbAJ5m
	PAIpmrq4zyIyN53hLVNugJ0BdUFB5GI/fg6cLxJeiiVy9fQJF4uYjvGo0luaaCX/
	IpGIwSalQNdLuKsgW+3xqWtIpMgeYb2IVZlnwduKlMkB+l3M7s7fJClZkSGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362382; x=1716448782; bh=dqZBMUfbykWZR684sYnegODmwSAH
	yK+3BRMVKA/EY68=; b=mpa5kqRpQrS90ReQ4Np99wNiJyD0WhN0vGV2U2oK9SLf
	41OKEyMFFTIHK6NXqE0Xr2XOkldjdphifhgFaZjAa7Op65NL4JxgoWDLzKnroopM
	/n8PzP5/WNmVC/J46sDkoz5yJyt6b34BHmp21/H3WUgd3FL6kckzhOyPU/sO/WZX
	HqSbTjhXHfTG7ApIg+CYIs7uaNZJqYy9pT7T5L0Ckn8eir0iEs16vKIa7TC9o15M
	mK0FiK599oTXCvClTStdLcmxkDV/TQT+M+qXB8dbDULeJWTX64osEGmTlB8WccEE
	qcNAhwdjo4GUqN31zjFvK5Ff6+w0gQHAENoWoajOOA==
X-ME-Sender: <xms:jZxNZiqo6cNJupwPhvoWJFDRldu85jsflSrBeFR_IraKRw4W3wdCjg>
    <xme:jZxNZgpyQBLDdC1Z4J5Lq6lHO-IdrO0Bov3fSMxbSfLokHf7tcMfhwNi0jLCcgXjt
    AMnOK7ncaDkCokLTg>
X-ME-Received: <xmr:jZxNZnPifXAa82CGXeQ84nN0ToLGNG6EyLWe_gcmS2CljHQzStVje3YQD4A-8Nf8M2XYel56yb_fsEx_do2poIqw203iEhERAKvbSKHkK93H2Pk->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:jZxNZh4p9L-pJTWI-hIwmwKJ_LXvJyJVvTt58pIdncNYKZttYOwV-w>
    <xmx:jZxNZh460j8d86sfI-VREXh20d2YZSfQJVkyDbbSS5c0KM8Wst2gcA>
    <xmx:jZxNZhhPSCV4f2qo7D2t5MWbAI6CXVnkTNhDQEjk_qQGszC0JTqvLQ>
    <xmx:jZxNZr7OlgMiPiIJ4Zd466Kgc2sz4ASkQhnOwW8vmQtES863mM8sSw>
    <xmx:jpxNZk03QFn3uKzcepEvqhUE_J_KJ-fwUmG6oL4GMNQtP8RmO-CZFcXI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:19:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 13ea4098 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:19:37 +0000 (UTC)
Date: Wed, 22 May 2024 09:19:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/11] refs/reftable: allow configuring restart
 interval
Message-ID: <Zk2ciqJje6cH11tz@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <2b1579570798a325f8a5c97438b1fdeef65aa049.1715587849.git.ps@pks.im>
 <2zq4lspmqkcw6ssaxgc5txaubivwvghwgf4kmsmk3nfsizbmnf@twznyofqazml>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NnZvOQTvqGKk+hQa"
Content-Disposition: inline
In-Reply-To: <2zq4lspmqkcw6ssaxgc5txaubivwvghwgf4kmsmk3nfsizbmnf@twznyofqazml>


--NnZvOQTvqGKk+hQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 06:50:58PM -0500, Justin Tobler wrote:
> On 24/05/13 10:18AM, Patrick Steinhardt wrote:
> > +reftable.restartInterval::
> > +	The interval at which to create restart points. The reftable backend
> > +	determines the restart points at file creation. Every 16 may be
> > +	more suitable for smaller block sizes (4k or 8k), every 64 for larger
> > +	block sizes (64k).
> > ++
> > +More frequent restart points reduces prefix compression and increases
> > +space consumed by the restart table, both of which increase file size.
> > ++
> > +Less frequent restart points makes prefix compression more effective,
> > +decreasing overall file size, with increased penalties for readers
> > +walking through more records after the binary search step.
> > ++
> > +A maximum of `65535` restart points per block is supported.
> > ++
> > +The default value is to create restart points every 16 records. A valu=
e of `0`
> > +will use the default value.
>=20
> Out of curiousity, if for some reason we didn't want any prefix
> compression, would the best way to do this be via setting the restart
> interval to 1? I guess this means the number of references would also be
> limited by the maximum number of restart points.

Yup, exactly.

Patrick

--NnZvOQTvqGKk+hQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnIkACgkQVbJhu7ck
PpSQ4g//ZFOmPp3W03FJ4qjckg7+o+oK4ECL22XPN+kIyPG/FVSDqN4xu5eU7/CG
Rl1LUcAPXaLtcAH9y5TUiHyHINg/MwjMxjWkabSl/MW6yQsm88CFPJiSLR4R7ZD7
CH0CqoPKWwWIeBZmqq3tcsf756QWNqQzI7lrgTidFBu2g/kpKoyNH+TCcm6YJCOd
T+FaooZx9nn6qYBJ0KR1jfbEFNo/Uq3yvJiF1JXBfodzTv0juOlKxfboaz3nm+lG
1wSsSqBuDw80xnB/G2dHDp8VSRX/Hj6Q76wrcmBJitB8Z9PSx1JKqS5P4QxfOnm4
N004ozdosTEtOpHx4DUqGnMvXOE7TsECw1hsOPJnrckatnRkCjmK/NpN3FoBpBE5
f1ayfKVV96ycYs2sXP1FZbQv8/8KGs0BC4CpemGMW/F2fMOuGNoDbcNC57ZpHJfp
4ny0CdS5R/dNMDbNw9msJZROYCKx7FYNJ8MuOqgWw08fYJNSAdCXkZpEpnIMnEWh
LNkuX6wiak9gunKZrE+iQgd/QNA5tgJjO4+TBzL5niWOD6BXmUQ8ThsC4kLxZG7h
QjVQFjqjWVBlABXzJOl8hsnOKBz5w4Z9V5NZ3lUNbrrhD0CBa1QaR7UBwUCfCUri
SeeCj2uxhipFYnn7gMudU58Kn3GmHTI33zcisvJ2IKt8zhE72J4=
=qXNd
-----END PGP SIGNATURE-----

--NnZvOQTvqGKk+hQa--
