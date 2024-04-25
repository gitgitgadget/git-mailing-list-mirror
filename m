Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D741757
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027251; cv=none; b=skBFbqqb91Tw26OAkXxgUjdxc0TnIonIdy3v2UerlywJUetHqTF/eRJtFPytYgIp8tMq/K44omkYusMLJY519Fl4B8yC7V4TQBaGX8jvg2BHLqCt8/luBzVlTeWNj1huvjStv0SyAWGeFW2ZmFOl0IZABKfdP699SFPCNU8fhtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027251; c=relaxed/simple;
	bh=jUj3w5bqayJaMKJsnhLtXa7fB2CEZzRMIZtH5pHM8g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaHWKBdz1gdlm9+6SH573KgwX7W0NxexICk3WJXvkc2K4te3aOt58k7hOT3fvrxDg1GGzktETRWJiOvazoCtFlO9kopMCyA7F4dAxR7Y6Rsi+AQDX+tdRTfuSBQcO6S6tU04a8cAX9556lQrHZQFqxsIEE57yjY3jgKOTe+r0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SeKnulIA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bbk8w78c; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SeKnulIA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bbk8w78c"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3193D1380142;
	Thu, 25 Apr 2024 02:40:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 25 Apr 2024 02:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714027248; x=1714113648; bh=XO4uFDb2Qh
	pZFn8l2FecTn6DmpPxqdhxuQR3mRpkcyE=; b=SeKnulIAprcihO26XqU3CA+dw6
	mgFvQih5euL+TxXPzUs44n7rTeNBbRBRZMrSlqTvKyawPPvRaDQ1AuM2qK1exkv6
	n9WigQWtt/HxMEx7uoiYHD1x1ey8qTS761B1LKHxsq0I+CEpzyOxMqtrz6cufM8/
	e6VIafEwH09qv1Oy4dALE2rEC375KZt+5IDgdCb/GWBjCiAC+RlfRAaG9vHAaxiA
	LGYUwkRlVOGwTxq81S0xL1g5epZJTrdJ7A93A20SSv5cf0U4029NGVuVM3RHY8k6
	rU6OyXG5b94bi7zuSweJ2oCqOHpaVVAruwfvSR1RU9X+CHNJpmp0hyZDMm1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714027248; x=1714113648; bh=XO4uFDb2QhpZFn8l2FecTn6DmpPx
	qdhxuQR3mRpkcyE=; b=bbk8w78clCZzUnehj23CXmIOJfYAXJlJXrW2BR3xwea0
	qpweLp8KrKX1O308mOZRbV4hPMC2bn1GQ78R6PANBhekq8DEmWkws+cRdqJ5eT5C
	T3h+Q613Aa5XQXPfKjFyI+ArfGbEBN7BqBDjQHbZMp0qSoWZ41wpK1JQQSUX3jn+
	YNIFNMwUM6PVQGkRS7clHdf3cO76+Y2yYMSmQdV408dCTANJSnjeGoNwm32DcNt+
	fh8no+OW4198F6EjRX/xMdJTDzPRk5Vgsb2xNonKLm3jJTbCYa9zmil9CaufMo16
	o/dgFP624ThybLKXrGRsqDMhVyeVtfQazbzuf4ow/w==
X-ME-Sender: <xms:7_opZgNnvd1BpkAVpIBANP4dP3ARyCwMsdVBzgEjqdD9q-x9m_ZdWw>
    <xme:7_opZm-q62xLvWRaImUZ0BfqReBQOCHLBeALcGPw6ehj-uZ12Bzqbj_x_7msUO08I
    Sn06sqW7GLovbDXcA>
X-ME-Received: <xmr:7_opZnSjK3Nf9RM-wCIFT8ZcRYzMMb3hqpc3Z_TOFoLWpK91HjyJFihmOy5caROtNWtYz4e8sJPJF7aG2QuCgDRxItCNnut6I1xbrG3A3UnGsPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:8PopZos8QsojTGTcGHsfFTWektER_ViVrbHZof5go92eujus0-JSjQ>
    <xmx:8PopZodtADdsLVg07vDDLgB70ucWimNk0vOD4p2zm4FQ7_kP523i7g>
    <xmx:8PopZs2I8FiK7GcTh2qsSUUnVezoR2goIsgy1ZB8Xygmmv1FMQRcQw>
    <xmx:8PopZs_-604SDJ-tuk9dyghVEcOkjnNhHfdory5yPyF5gPxTnEWMhQ>
    <xmx:8PopZtH33SdAQoXI4Vb_OuN7AjDjiWzBfENxFj-6bDvY_P9fSwdVjbzL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 02:40:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f9d9050b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Apr 2024 06:40:35 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:40:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>, chris.torek@gmail.com, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v3 0/8] refs: add symref support to 'git-update-ref'
Message-ID: <Zin67FKk6XXOotQh@tanuki>
References: <20240412095908.1134387-1-knayak@gitlab.com>
 <20240423212818.574123-1-knayak@gitlab.com>
 <20240423220308.GC1172807@coredump.intra.peff.net>
 <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lfFa1+IYNCft+GOD"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRk8QR4qkbkRm6AirapdrAqz6bG-tXfY3zRQU_9XkJM1Q@mail.gmail.com>


--lfFa1+IYNCft+GOD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 09:25:27AM -0700, Karthik Nayak wrote:
> Jeff King <peff@peff.net> writes:
> > On Tue, Apr 23, 2024 at 11:28:10PM +0200, Karthik Nayak wrote:
[snip]
> Also on a sidenote, it's worth considering that with the direction of
> [2], we could also extrapolate to introduce {verify, update, create,
> delete} v2, which support both symrefs and regular refs. But require
> explicit types from the user:
>=20
>     update-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
> [(oid <old-oid> | ref <old-target>)] NUL
> 	create-v2 SP <ref> NUL (oid <new-oid> | ref <new-target>) NUL
> 	delete-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
> 	verify-v2 SP <ref> NUL [(oid <old-oid> | ref <old-target>)] NUL
>=20
> This is similar to the v3 patches I've currently sent out, in that it
> would also allow cross operations between regular refs and symrefs.

One could put this new syntax behind a feature flag to avoid the "-v2"
suffixes, e.g. `git update-ref --with-symrefs`. But I'm not sure whether
this would be beneficial.

Patrick

--lfFa1+IYNCft+GOD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYp+usACgkQVbJhu7ck
PpQySw//a/KE1vTNiYvadOE1LaWtlilHPeWud9YwrcGYxCrmsF3IJsP+G1hEzlGB
h9tFVILxsRITeOdOIEFWyVTvvceSB54MLvIC+CJezTU+aR291SmwRF7zZQNuOdwc
XhXV299eRaCbG0Wklt5HEPQJpcdv4LCD5SslPUUhJ96w/8FtaLExGVnSsG5ebDAh
5CYcDr5lwHISqF/5LyhUirOsXHViQxiReIM3zOXItd/Te3py8wwVVhSTfhTkCioc
5Rtcij5q9bpKDJbppcAzPMwuT/abkjm6CTH3UWvhuI5DmoToZdXYRW8EQMdg6QWI
I8E8rG5PjXJT1s/7uMCKZX8pgHgNG5p9Svg11S1HCZxgIRsSq9tEEN0outdjDxvQ
tQw8zrbn2FAuR0tPz1ba3YzBylohoHWvwrmipdX9lmcP5BB80itLOXRiErQImlqi
/+dqZcYEmqF7jBqaOJ2Mta3Cdjt1F9qniuyhGsosjZx5iwnA172chALzk+5AceuZ
w+VwdncJIfSgEUpLM+f/dWNCg5Q2Z1Kfrb1czdXxTdRis94m4TKZE2on5EL0RSzT
NNXBl3IYbZIEFcPTV732wUyHg123HaYUs6VqUVu2nXg8bAZTXPgtuUXFOcR0skBH
zNeee9by1YtQQkemkpDEfsGoOX9YjMbQa9s9ZHJIWc+7mjv07us=
=eF6K
-----END PGP SIGNATURE-----

--lfFa1+IYNCft+GOD--
