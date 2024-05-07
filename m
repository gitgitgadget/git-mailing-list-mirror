Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105664EB56
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054842; cv=none; b=qKlV9D3zjEfbH7Ehr61E7ut7u9fSGl9hoYkw52jCFpNDatTvuhFp7xI7zcH8PhCFU/nQqMQNhbwH2Db9Zou4o8DasfddYKdw8E7sjXLBhKL1q4Uj2ZCtHbImiM9aTnnR+VePMQnCY3PLSSnnkCBk2HNPnUo1VpX1ziHlFxOIV/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054842; c=relaxed/simple;
	bh=60BjmTo8rveijFSviwv7XF9xubydX0HtuSWL0p+Wkl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/wWeEhLCSXSxWqfA7MHE3ydWg2oSqJG7a0NP9lRggEUf/mv9vGRRNGvPjMfJjonoSyWVDdsNY+cUqc+ULWBP92C5pl5wQiyBb9EoEO++Py4nBnAhVOmCXsz+gcA+U+qIvBI0IRQUYRQfrxu98aCVc8INzeFS3W7EuhtRhEbXjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ITFrCLjT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AikM5YeO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ITFrCLjT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AikM5YeO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D6D6911400F7;
	Tue,  7 May 2024 00:07:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 May 2024 00:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715054839; x=1715141239; bh=60BjmTo8rv
	eijFSviwv7XF9xubydX0HtuSWL0p+Wkl4=; b=ITFrCLjTx9TLJ0XjeR2EK7KTmj
	r4QPYGJ98K3Vm1/4EdWIzAbAvST7rntZbPGY6kq1AYqrUeREmCwrGW8sJZwps3Mw
	VN7NsRWq68ZuT3TMjwvBVDz1TtnneDh1dqoMz+YJk+gAg/evTc6fZAlMhnAueSsB
	xrE0KVwA6Ab4Ikmdn1bg+y1Rlb6xwipUUkbX7JYUX+xDDtsVFhhhrbBUcDUS+E3h
	26U8H35UEknq2Rj49ZUV0BwV3/KfjwEjVGvm6aB2REJtQN+igIqgL807SZS9seNx
	9+xsqo3nfpekyAn4R6qnFgfAZrWam8fzHy9WqSI5+2DDUimfPy3XGgLKOD2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715054839; x=1715141239; bh=60BjmTo8rveijFSviwv7XF9xubyd
	X0HtuSWL0p+Wkl4=; b=AikM5YeOdt9fM72iXQ2S52CDqJtDymBJOabgxus9EeEI
	oVi047kfvxcSvbCwKwhZXiXx3Tl1VKQHSm5MwQI+vqIZD4jSTO9bM2rBaViHV0wD
	qFvr5feXl2itYUvg0mqMnR/QlfBk/hNhXbVKkWrwiYhd6qKv60fpgcVoC0p3eivd
	5Zx/TIhnFvu2wbxwEdpzS5W08blY+yQvPmMn4cQEowsp705dmdI/CwGRzeAiV9JF
	/dxeMWuAy71rDfK56NNz9l/wdfMbHI7VeYdQuFKQOSVwqnbNy7u1IVtol5f3OKp5
	gqR7lJ+fXLv9jANNOJLSw9NAJTCqAIeQ7Ab0ARjvjQ==
X-ME-Sender: <xms:96g5Zsurb6uoWB2AxBK9-sSeyegxBmO4cxgA6N5VxWoCgvYQZ9nL8w>
    <xme:96g5Zpej_gMO_1TU2QKQOxz3lFeLsJ27eJf-Xq67XdsfjBdqPX5xJ6i1FTOdE3O9t
    CENXwSCEj1uOmG5vQ>
X-ME-Received: <xmr:96g5Znyp-TJ_aHo2vPbqa0kIk9k8uERcIEQnOdG1Rhd2omGseqJ-J_Xfaowim34ZG6Q4ABBLkNi3F4R-ygvx0cW8ajNXe961ptpKl78o9CzGo0H7vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:96g5ZvP9xQ1wW-hWp8WD5YtPFKClcsWUg-tES6nmJsRDKglbpUHKYQ>
    <xmx:96g5Zs82vdEtoDAif_DCSl4LSiu1qXKGbSn4-uk9C6SJHT1rN8Pwbg>
    <xmx:96g5ZnXsiNaJ6E5dU_Ht9IwnfwFYHaRz7efKhXE4rWeUq1prxJEcpw>
    <xmx:96g5ZlddN0EI9XMiOo6KuqzfOOAQJ--RYE7ZR_nB3kkYciPr1nGVPQ>
    <xmx:96g5ZgTplWjPNhzvrJMYKbZbd_TVldi9F8MqDrpYW2kd8eIj5NFb7_EY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:07:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 97706b71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:07:10 +0000 (UTC)
Date: Tue, 7 May 2024 06:07:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: rsbecker@nexbridge.com
Cc: 'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org,
	'Kristoffer Haugsbakk' <code@khaugsbakk.name>,
	=?iso-8859-1?Q?'Jean-No=EBl?= AVILA' <jn.avila@free.fr>,
	'Eric Sunshine' <sunshine@sunshineco.com>,
	'Junio C Hamano' <gitster@pobox.com>,
	'Dragan Simic' <dsimic@manjaro.org>
Subject: Re: [PATCH v5 00/14] builtin/config: introduce subcommands
Message-ID: <Zjmo8xMkN-hypRHz@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
 <Zjk73l5l6AqQOz6N@nand.local>
 <04ef01da9ff5$700fab90$502f02b0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kv86HGaKHvrCoLEd"
Content-Disposition: inline
In-Reply-To: <04ef01da9ff5$700fab90$502f02b0$@nexbridge.com>


--kv86HGaKHvrCoLEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 04:38:59PM -0400, rsbecker@nexbridge.com wrote:
> On Monday, May 6, 2024 4:22 PM, Taylor Blau wrote:
> >On Mon, May 06, 2024 at 10:55:51AM +0200, Patrick Steinhardt wrote:
> >> Hi,
> >>
> >> this is the fifth and hopefully last version of my patch sthat
> >> introduces subcommands into git-config(1).
> >>
> >> The only changes compared to v4 are some fixes to commit messages.
> >> Otherwise I'm not aware of any other feedback that would need to be
> >> addressed.
> >
> >Thanks for the new round. I took a close look through the series, and co=
uldn't see
> >any remaining issues. I appreciate the translation guide you included in=
 the
> >documentation to indicate "git config --add" is replaced by things like =
"git config set
> >--append".
>=20
> Please make sure that there is a compatibility mode available for some
> large period. There are huge numbers of scripts in the customer base I
> deal with that use config extensively. Changing the CLI for this will
> be dire consequences.

Yes, that's a very sensible thing to ask for. I think the bare minimum
we should aim for is a year (4 releases), where two years (8 releases)
feels a bit more sensible. Do you feel like that is reasonable, or do
you think it would be too short?

Patrick

--kv86HGaKHvrCoLEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5qPIACgkQVbJhu7ck
PpTWYg//WayvVHhGS7XuDwTHo2BojQxw5b1lgxNrJJGUPfisaME/8FMrWx33T8Hk
LX0v+kXbFoWfgL421AEyBtVrj0LaRBFCxR/2MsSQmt+QpD4PlDBYpLROicu7zlF8
HnzMCyt04FTlsT6ixKgRDl7Ks4x09VA0BFNi/uRx6FGCII4QWW6HS+ta4LG4nvRl
6xzxy+DIcl9IXHdIXQt4g0JnQ8EJd38urKB5dJB36pcy5jpM5n102V9YTGni9DxM
j6vQXR5vQgE7ZAVgAE2bomqTC8yneE9GDdum+wAdkIHbe6jmQhvIoQuE86wc9jto
QIVGBuAexaUQ1ZPXbH2U6QeG+iHc4F6k9c6JUr9NSVbqfahWO9Jrr55Mln55/QfB
NEYwIi0iDE2rFlGBrOwUfOvdQ/+yLXsfhf6x6y+2CrA7HUZYOlDD/dYn+gQN7z2R
kGppOSQwEJtShzbeXKvmSLHHRBNk23JWTzb2HNys6cjdoQax54vwBCFeg8gk23mo
vatLQumpxVJrmJ5GW0myq3/qWN6kYLrDtGbF7pERFL8Enng+NXTDXDeoBbt5EYGO
PdG0AS6VggH3phjxytANfS0N7kaP5jk5L0+N3w9dJRILpxHfzpvLEW1KmoZ/AkKh
lKQklF771zhmOwp6s3l0qUfun8Qn9DQ74V0Tx78msQPSz0BiwmU=
=wE/7
-----END PGP SIGNATURE-----

--kv86HGaKHvrCoLEd--
