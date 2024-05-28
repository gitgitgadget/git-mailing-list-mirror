Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF244C76
	for <git@vger.kernel.org>; Tue, 28 May 2024 05:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716873254; cv=none; b=R9pKUCO7Gk2eLK4nfBq44CilBzz+ssVbYt2vFidRwe/TE7VN3QRgmQJ9PHcxj2xg1TeENAQPHK/r43HVqWhErPXs6lol/VbTEpxs3Lhewxy/aXoj9zRC+7hlsYEQRRuKqXViR8BEUKFD2DGanWPjTaMOsgcHau4+fO/MVaT6ApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716873254; c=relaxed/simple;
	bh=0Gaw1FfiypYqdajmZZ8SS8pJh0W16Ss+mEjFmKTIQ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htYyqaE2ACBh9lvHnxuHv8d1ft4Dt6iDhRxlNu+vPBlLpSyPo+nqru5dC/K/7wWdeIQWWY2AM/BDkG9DuheuIhHQhrUlCoiV8OSImmjmBETu3H4xmT/+lR+qHm95VBbCJxU3gP8y9VUZ/aDXOKdZBTi6jfESyLLw7diUmDU/JZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fwXs8Ho7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fisV9XXT; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fwXs8Ho7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fisV9XXT"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2141B1800159;
	Tue, 28 May 2024 01:14:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 May 2024 01:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716873251; x=1716959651; bh=rVY+eoAdYu
	KKQZno1FrujpR+cZq9F9fLq5w7Ccg7J0o=; b=fwXs8Ho74j53M5LoR7wXrvHocL
	G1v4yw4uYJBH6qR86CPlvZIV85n+zna+E+JFvg108SFaMXv/W05ytcBmp0FpUiv2
	PCZ/dfyGjyV5Aj4k78n0NGAQzDsOD+ZikW9U+BJ41baEMA5TNe/1jhbFG48rcaVi
	oKU0srhxyXYRfQ3pROpytW8PS34vg899z+n76z3XN7/2S9Fcdj1UttEHfGdrj2EY
	gbfgeM0lgJW5jePPUWNjOgmBXTVeMXbHFVClgbNfEpzyzx+JL48GmPq7lL31pzk+
	WhYzXJ05fVR028Uds+6diUOv6HBCKimzRQr0P2+T4cr6nI8PuDjY7R1vgbRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716873251; x=1716959651; bh=rVY+eoAdYuKKQZno1FrujpR+cZq9
	F9fLq5w7Ccg7J0o=; b=fisV9XXTErFk+4+n9L4opApdLhz5V5UvRTtVHmetLO34
	/7kEswK/CwSRaCxjGHoRSBmY2aWy+XpM6DoGIM2ZJJ06Z/FGXmzOH8OD/NaAwU3J
	Hi61Qvfx6LCQz8OnFHcULW3C32p7uiHwRrSuAwCqqkpbpAT3CvxNIp5d7pPp/svV
	Kfg1QIog01jIT2G8kJaPARxYPOwwje3HHMBZcQDhhK9V/5yHauBaz0JbZof/Qnf7
	wQvdR1piQQ7DgpAcnT7+Xda3m8ezKWbtdnJ56f+5LvKitoJQ2ZBzK+D0J0BnghJo
	14J/DMd0x8hA9Z9K0CjGbkEENLNkDdvbJTbA0dx6Pg==
X-ME-Sender: <xms:I2hVZjZFuY1pmH3H8fcWJCypjilzarYFfeppLp6ZZFL5VtmoYT9ILw>
    <xme:I2hVZiYYz7XaG4j3VzLmNiEM6ewZ_Rt0bnskuUpnwiOmqyQ9WlsDXy2_cuk5b9D2f
    9aoCSWPwr-9PDDXRA>
X-ME-Received: <xmr:I2hVZl_ER6fi9Sf0pJq5hWP5MP5uIrv1-XPCVaAdRtrY8aUtuTc4PVGIBriQQ6tlP0hICoIhXjfeudQAemeyh8mt4wj7ri16m-DW9eJUuYCIekJn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdeiffelledvfffgtdejgfevvefhleetjeduhfeuhfeiledvleetiefgkeejueff
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:I2hVZppic2Lv7jh6PiG3SUt-FPQQNjN6vzQ_tXx1noyt3RA9VR8JOg>
    <xmx:I2hVZuob80MFbT7c6TMTsgFj2FXNA16kPvzTyLkzaQqzJQ7SQ2dc3A>
    <xmx:I2hVZvS6NYJjFis4dAUzIv8c68BNYnlJ-n6h4qW6hMkAEpPJeQqzSw>
    <xmx:I2hVZmpjZRrTjBVSBo0aAZz7tFtGCPoIDO54fwfLmfLFNOmYuZRwuA>
    <xmx:I2hVZnk1FOld0vWDrWMnjEr-GZI2-_5L3WK12kdgcQhCYFklGnlbLKL9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 01:14:10 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a30d8427 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 05:13:58 +0000 (UTC)
Date: Tue, 28 May 2024 07:14:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 9/9] builtin/refs: new command to migrate ref storage
 formats
Message-ID: <ZlVoIBKdFI3F-l1W@tanuki>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716545235.git.ps@pks.im>
 <0df17a51b43e1e9d007328aad6457363876b2e1d.1716545235.git.ps@pks.im>
 <54110fa9-02ba-4c9d-9ec2-c26e98a42730@ramsayjones.plus.com>
 <CAPig+cTV8eXHyFjG3gS+veQb_zUrdfz1zvNNE-aKMsaHoyG6hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TpQrcd19bsD/txLN"
Content-Disposition: inline
In-Reply-To: <CAPig+cTV8eXHyFjG3gS+veQb_zUrdfz1zvNNE-aKMsaHoyG6hg@mail.gmail.com>


--TpQrcd19bsD/txLN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 03:29:06PM -0400, Eric Sunshine wrote:
> On Fri, May 24, 2024 at 2:24=E2=80=AFPM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
> > On 24/05/2024 11:15, Patrick Steinhardt wrote:
> > > +--dry-run::
> > > +     Perform the migration, but do not modify the repository. The mi=
grated
> > > +     refs will be written into a separate directory that can be insp=
ected
> > > +     separately. The name of the directory will be reported on stdou=
t. This
> > > +     can be used to double check that the migration works as expecte=
d doing
> > > +     performing the actual migration.
> >
> > s/expected doing performing/expected before performing/ ?
>=20
> The "doing performing" bit was noticed earlier[1]. I suppose in trying
> to fix it, Patrick accidentally removed "before" rather than removing
> either "doing" or "performing".
>=20
> [1] https://lore.kernel.org/git/xmqqv833maxu.fsf@gitster.g/T/#m2c3eced90c=
6cd61bf3acda1acc354b4ab76011d3

Ugh, yeah, that's probably what happened. Thanks!

Patrick

--TpQrcd19bsD/txLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVaB8ACgkQVbJhu7ck
PpQhbhAAoVGoAICYMU+q/QGZmlPRV2RA8qmRc7zTCdfwLiVCzB1uJswGgiQsELk/
lkcKMFo9NUkRxgCzF/VjuG03XdKFA14jUIjMWU6pMijae0WmMuRzf5s7kPUly3cf
K8qgT19fOX5kJI4FoaaM7uj+4+rxmkvjGqJgUDH9VM8VHB3MOlAMkVkqqb7/21+8
Ejya6ZbE4eBimjvkxrkDxLCrHEbTODK6d6h+Bie6nzfEb7noBQsdwhN1MPWFaWrc
DXtBEaMlsXHJi1JPtW3SIU1etKZX49Juem/a/dGJ2u/QC5cnnTlh+VNf92RuCk51
yZugnmcr1JBbuhPVk0j5jFJ9W6mYr19nfmC9SaNHP+UjblSaHPov282Kl9vB8fdZ
4B05opWjWvhYHp2u9gHvJ4I0Oth9NLPq2oDgTz1UaDrcZPXT415UnbhuxOD9cpgw
OzMCjAlVl/u/mdsCQCHDVJkQQjhqnUEx+P6vSwpUfFkOqw2c9X29WMgbPSCMlJk+
bjl8RC3/5P0qD0fOi9i8XddEi6wJpNLfSQg1W4PmuEnstIxk5fe+N4YBQYIhtMKi
Rdhbe9eJWXH85fckd9k4frkqiko6fnA38bbHw/RTdAHhgFZGlGD/bcH6btzogUxO
gVPy16W9x6V1ETWo5BS63+GrNR5qKOqKlEh/l8CSfAWTNep0IrA=
=Oz0r
-----END PGP SIGNATURE-----

--TpQrcd19bsD/txLN--
