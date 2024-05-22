Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A82233A
	for <git@vger.kernel.org>; Wed, 22 May 2024 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362390; cv=none; b=mIUSCMR0V+UYPLlZSKKNXLdi5blrSH3pML889Dpaoxfw78IHOv2+LE0/8EVEvRdFl7jkCL7jzulUnIU6PsaGvplPc6FIHSEGoMNOmbx4tBzE2SkhdE2IWBybI/hl3kV5YLW6on/awY9FKApkidO3ND5Y+Xk/o69efvzL2bk0uGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362390; c=relaxed/simple;
	bh=2B/crQQr9wHzAwmym+TW1pNgr0Xczq9KpZ4NnXm6aJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwsXklyzEBGgJHg1vG9XqSd/qYVEL1/MKXW2WHjlf34YUBVcBxDRwFQbtvSSvxu0KRAIUPdVKmLWdqtB6/umf9NQS9+97TEuQi3jBBKKDXJuV22aWFXCCk9SxpTYl/J/FbGS2kT7dZdPJc+jxwhsn9N2IQoMshdOv7VgW79m18A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pwc1tCyI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QuP9WFhK; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pwc1tCyI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QuP9WFhK"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 764E81380105;
	Wed, 22 May 2024 03:19:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 22 May 2024 03:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716362388; x=1716448788; bh=1UnPUU6/1U
	g1s5DL0y6up2UrlhghQv8C4DTnRZ8zbcY=; b=pwc1tCyIdzab0FIOthJeoTmdAE
	T+72klT2TPQBK4UewiXguNe+yQC98yKUrnCpG5rwqEuZjQlUaubwHyCnB8P5qg/9
	V4tEmSmHH8Z4ONRaDCb5kGV659gkfk6xCKsr7esMMeiDHSLPM2ffOuWQMgIsTpkY
	t6A+5bI1bvA1zqXa7+lPtb3+oYLIKeJPR1PCMhfKzwUV42jmAVyYhNg3JmWF+DV2
	aXhDQXF9enqjzHCcAins8JEvwpfNdjud1tN9yRNg6XzJroFBuWlx2G7I6hRWqwLY
	5j5GWgKGmcOS/awaLppr3vJJMvrAstRrGn2046F2AnTSq8WPMlTzqiSnpQSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716362388; x=1716448788; bh=1UnPUU6/1Ug1s5DL0y6up2Urlhgh
	Qv8C4DTnRZ8zbcY=; b=QuP9WFhKcYX0IZpgvwUqr2xvFjEcYPOJ1Eki8lyBCQ7M
	z4TK6h48F2DqJE33PAag+b4cG3lQ15E4qxnsMUdguZbqMt6pBgGAfGxjsX+HYH09
	hArcxZXhdwCmf4oHgsNxBP9iWt+iyEMakhl601DuGAwRJyIwV85OB8/b091v55Vy
	JYsiAh+3JV9O2vJD4hWTg9ca0QG/NoFFZbtKZSCuO8oHy1PQdKmRX8z/iFHHv0Oc
	XIbaZgMXTAgUm1YmWYDBIgLv03MOFWDSrHXJBUBoNNHXbNqnE+e9YA30xXHIqlPq
	I4BSqWtFUqDP5X5DIZ9mKPOm2rnDUXIjjjoB0dnJag==
X-ME-Sender: <xms:lJxNZu39AZXjgOzxgzh1-fQUlJXAwGH-qmVGUaEZFRI1T8Cp2rMjyw>
    <xme:lJxNZhEobiBSzllMjwX-CBZ5RA0DWzUfK0rbUQdxVDN9cnxHclpqREtDOUuYIDN8G
    EBYi8eFjLzhJemdhQ>
X-ME-Received: <xmr:lJxNZm6t8mtPYfC3TfmQBjQPMWkyjugXTH2I5pIDAl1cG6da7PAPSK0kwzmqncN6WLAra6_dhLdKXHV9vHomNQTEd2S7J92MuXIVjZU4wxWgMXz->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeifedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:lJxNZv0XcIgdbgtjZt53iXioQak7PpKJh8XRT51jm82cOAx9uRWDvw>
    <xmx:lJxNZhFJx4yh36dQ2zIO4wpfm9ORHJ6HdsTm5ICkQRaedwTrw91unw>
    <xmx:lJxNZo_-EZc6nrl1A9YxpcVavtVeTtLOhCIZ6fb3b6rv8CYB9rsFvQ>
    <xmx:lJxNZmluz53jfH6A4KKufSQSFeVNFZ9_RNnJ5UYl0zqacJo8B8bdlQ>
    <xmx:lJxNZlgBb66ZsdPEGrbd7m62WtVST3aDyK1V37Dh8zyNzl7fkIlOMb3R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 03:19:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 514523a7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 May 2024 07:19:43 +0000 (UTC)
Date: Wed, 22 May 2024 09:19:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/11] reftable: expose write options as config
Message-ID: <Zk2ckCckDT8WhI9k@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <akuvjnvz43fzcggytbkyjhq6htljucucmexecel3h4eooqrcca@j5umyot7clwe>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Na4Q1HsEBwD8WLaT"
Content-Disposition: inline
In-Reply-To: <akuvjnvz43fzcggytbkyjhq6htljucucmexecel3h4eooqrcca@j5umyot7clwe>


--Na4Q1HsEBwD8WLaT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 06:54:33PM -0500, Justin Tobler wrote:
> On 24/05/13 10:17AM, Patrick Steinhardt wrote:
> > Hi,
> >=20
> > this is the third version of my patch series that exposes several write
> > options of the reftable library via Git configs.
> >=20
> > Changes compared to v2:
> >=20
> >   - Adapted patch 2 such that we now pass options as const pointers
> >     instead of by value.
> >=20
> >   - Removed a confusing sentence in the documentation of the restart
> >     points in patch 8.
> >=20
> > Other than that I decided to rebase this on top of the current "master"
> > branch at 0f3415f1f8 (The second batch, 2024-05-08). This is because the
> > revamped patch 2 would cause new conflicts with 485c63cf5c (reftable:
> > remove name checks, 2024-04-08) that didn't exist in v2 of this patch
> > series yet. Rebasing thus seemed like the more reasonable option.
>=20
> Thanks Patrick! I reviewed this version and left a couple
> comments/questions, but nothing that would neccessitate a reroll. :)

Thanks for your review! As mentioned, I agree that there is no strong
motivator to reroll this series as the only changes would be a typo fix
in the second patch.

Patrick

--Na4Q1HsEBwD8WLaT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZNnJAACgkQVbJhu7ck
PpR2IBAAqb+5LPPC8I0Ic+PANB8qUWao67959Ti3WNFX2tQfrtrovGrCPuSH8D19
e5KZcTq4HHz5JtUHBhApoOMVLGd1JigSW4KdHVS1hEXk87BlsxqfPL07N3dUTxGh
9s1qO4kSqkqqMybfTVsTF6CsYuTqLLBdNYd/eNoRIScoNZxsrdqrtRplP0z1xE7h
beqFrr6f0Q6AHGgOv6Yak3zVJXblsxtsWSTdFP0JFgLkriRkFkeW1agHxE0DckYC
/cajnSyH4QP5/uJ0SPWPv46HUWOHMPT3et7EtHKjg+juaJKUZm5rdC+xO1LPZMFC
DNbmur20AcGIu0Kl4VYD0763GJAQS8ltS/VdzvuvfpGYJb+uf4j+GwEhgxF9d2Oo
ykGOopZ1smp0csqGZsp26fmH5rjZ7ucY6ie7NF5cS0S1UT26Qf9fIeiitMFGbt8w
dqqPok1SnZgDhf7CwlzVT/534KhzIEw+86YR7uZTsTIZg6FiukJO5VrZjslcjh6l
m9ghsHHNf9FRvWWzWMc2FklieHXGHu27Iu45iCZYE/JCEB0yexTSrH6TzLPcDtGn
Oo5lU+lqAQLofn7r7SOYLANTlJx2ZJeGZXvdqlCcuq3ewtTb6mw3bYyriKoUXJfG
t0FCsVP4Ragg8zEWqM+m2YlxJaNZ0MuwVk0xJubY4ovWgmOm4SI=
=hOme
-----END PGP SIGNATURE-----

--Na4Q1HsEBwD8WLaT--
