Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A7155C83
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036302; cv=none; b=LV4d7h4QfXh3Q/RizoDsZ6sKOaIVklyvcZnh4x4EjEtJ6M69hPPTupBzL00hhX0NUH5JTFQbvMq4yWf50udxQ8A17g8a9HAAWI468PPtGuI4ZCnUzqTdyO/sVmYnMuRz6GHdvQBI9yOhhMq7r8nGwOmB5N6sMrRLwZqUHTPvqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036302; c=relaxed/simple;
	bh=I1w2qsRlhrWbD/grIqbWvO1n8rpqOa4a3E/EXWLYXI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WywIHqkguHoNt6CPoWklPYsJdt/Bn+l53z78fjN7AdWWYUxijfs42EvDIvHUhn3yaOvPY4Y3KDfnQp5L13JP2mSqObVkoSc4ec4Ju0fK4mceUV9HwpexGZr07n2LUJWXvMTyK5IDSk61Wkh1JZj6/noGlwH4nlvbZHERQF7IQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N4FTiJcQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIkeCMNt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N4FTiJcQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIkeCMNt"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0D004138CC6A;
	Wed,  7 Aug 2024 09:11:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 07 Aug 2024 09:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723036300; x=1723122700; bh=I1w2qsRlhr
	WbD/grIqbWvO1n8rpqOa4a3E/EXWLYXI8=; b=N4FTiJcQn2CnIuJnykU9rRZm4b
	WdlziOU7VIo64lNBBe1ChJdvRtkSN3GImYTtZI4bCoqliT5A2wlmPyFUWh1dOv3F
	xp/oSjmMYsFU48MSoy4Gr4ckWrPW61o5S89Xdf4W+6cURgpodi272OrZcKpajTfM
	1sv9cUzbgKVtNPIN9qhD5WJuLlm/gl1lW30znlonvPeojO1lYVNue/A7YTRULMeO
	3cvg4Nzy0X5Z3e3NE6ELj70/P+VacsoBy7uupv05yJMWEzsWQJWj6G7pnZkqJSsu
	3LCYhpC6Ebw61VWXSSarGefHGljJ0DipzlF2AwRrWenCHZtVJoXcuvuqV8Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723036300; x=1723122700; bh=I1w2qsRlhrWbD/grIqbWvO1n8rpq
	Oa4a3E/EXWLYXI8=; b=RIkeCMNt9QlmHG7wQZQVoq+EyXOOz3YG6lO2TAWjFw1B
	gHCdo6VogC4+lu9pGuOf44n55AcC7FqIfV22Ekn8pVyH6Tf9QnJKg4V0cF02fLJc
	hFSTiBLqGtTHB6wm4UiiOziidIg24eQm2NfS6ooajdzJNuv2klJ/oX/vqrf/Fc4h
	iBq9bjKrVF8GekCgO+R7hHSPIUAXiTomE/QASLx1czpE4vAXtgmC0dIaN7Du4KE0
	wgf9K0UMBQMEa8WVEceEUKarnx4SkgQC1/tDR1tfhJQUgdAsKDC10EcQauhlvZR6
	wIpXuV56enR8jNogQYzSYs9gSUuhgbnXv5Wvcaw3Cg==
X-ME-Sender: <xms:i3KzZlzkFw8n72GQ5YOw2vHarGyAZpDLSP4qYahrQGJ1cXoqOERCgQ>
    <xme:i3KzZlT_HHmoY2FQFgVXDyLRMURxD1Jcdr7qr2wg7QxMJkJKMEQKfX3x2L6tB-4RG
    VryKXSgKuuYY2y7GQ>
X-ME-Received: <xmr:i3KzZvWGjs9ihD3k3V3Zn0jk64IQIq_KTnuvHWuQKTpTC4CWeHCLLWWvMN8fqSyh2drpTcM9VOYzkjSwHdBeJkiBpnUDrUggO962ZeOopgD5CIiJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:i3KzZngAr5EElqPTyPo5dJv5fyYThk1nC2VGg5SEyogz3Zmd05pTjA>
    <xmx:i3KzZnDH0vyNTucdiF-tFpQcGw2wjNGLhf_pJn_qTAjhkNvvWukK8A>
    <xmx:i3KzZgInFIF9WhvbFnsYROWLmhXLPpKja8ViuaX6nw_cl_uyxjVhBg>
    <xmx:i3KzZmD5FTUzWh88qPp6RUpE4Tnum8JDSNxowe3O6En4KLudejYUFg>
    <xmx:jHKzZqNSBaGkgZ0TftoTOGGuu4VTJloD6njJIguLfRlKjD8XoSbbXP6Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 09:11:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a16559b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 13:11:32 +0000 (UTC)
Date: Wed, 7 Aug 2024 15:11:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/20] Stop using `the_repository` in "config.c"
Message-ID: <ZrNyh_2Gl6Eqi18u@tanuki>
References: <cover.1723013714.git.ps@pks.im>
 <D39L2L3K6I94.3JFA6EEDPYNQC@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y4C2XYVEhpom5eSu"
Content-Disposition: inline
In-Reply-To: <D39L2L3K6I94.3JFA6EEDPYNQC@gmail.com>


--Y4C2XYVEhpom5eSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 03:18:30PM +0530, Ghanshyam Thakkar wrote:
> Patrick Steinhardt <ps@pks.im> wrote:
> > Hi,
> >
> > I found that there had been a bunch of callsites in code
> > not marked with `USE_THE_REPOSITORY_VARIABLE` that still implicitly
> > relied on `the_repository` due to calling interfaces of "config.c".
> > This patch series has the goal of fixing that and making the dependency
> > implicit.
>=20
> did you mean 'making the dependency explicit'?

D'oh, of course. Thanks!

Patrick

--Y4C2XYVEhpom5eSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazcoYACgkQVbJhu7ck
PpRy5w//VYm87+gGvwIVBgGPU+KUHsqSYh8UQ27Tikg9SS5J554YSI0QISShfFG5
tuvelideq4fvWWcOgf5Qx7zfvprWLGLLEESccvW5qAG5yJqKziJFA+7jjTlIoBDs
ES0xeSQ9YXsGWrCm66RAZ1q9zjTujOe9ox5AValnu/+q9QEzh/0euSC6l+s7uZuM
VXADhdPL10QHG1EDLzCgguM518I31sUo9cR32tAZ5nwinpLC0XJpWMqCUMn9pNFh
G6GS82n9Sgsz84O2yAz2moOxGPpektOFzB+2opedUnkizVB74TRNGAJ5Eej02tuY
SyVoUJ83r6L+/KWEszef8hgqNq9ckWe62ajKLOx1K0DA1inPEoNAKXnkSji6O49o
hWZVn0sea6n9Ya6Mj77vUXtyjz/l3D+ZaYmZv4RqwK+DcYvEFjUT8nmWj41ttLr0
2jTWYpCAJkKRVblI93aQw8FNsEJTCVV4ci69Yiu3iVquvb/D5tkmOSvn09GdjvK4
PVXY2lr6Hjs3eFASq/UXRFggCpyhO7CNo565WU5tQfYo9iN8lI6+ILSVeFa2hNr8
h4np5bkK2UHcT+BfsPSpkeO6KJiKcuD+SgVQ0A8yYsMh2gAOF8A2X35XR3oUiaA5
QT0kOfnhardT5aDcPcdlpCEO78aZV0/UGhmTYnmmI6MI3NV6ozU=
=oC3t
-----END PGP SIGNATURE-----

--Y4C2XYVEhpom5eSu--
