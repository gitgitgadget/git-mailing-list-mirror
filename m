Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEA801
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717483374; cv=none; b=iOvqzT2qJQn7+0bdcDJ0LgRdo2eeTRYTS7mewFAvp/cN7uNVhJJ0q30VoUiSlKtIZsTTxbrPLeaY84RyTyJ3wB1fcaTMl7MuuZe8k9ygmFry29Q27L9nvrPnKKrwIuCAoQRU+h9uaJV3IcXD1niCY6TQC8KXazSslK1XhW6wsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717483374; c=relaxed/simple;
	bh=2TeApOQit8iCIx9sQqeQDocOLnG7nY8wDmkD9rnGQyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK2j5H1V8esXvkNf98EM/kPP3+r25MMn5wzDXJ0czNWrqleHUp+pezDMOpffj+xP6YYOedQqyZq6oKDMUaiAXqAxTW7MiIKDgnBiho/8dycHAnn8/035KzTod/6ScH98Q4eJzUM+Q6Shhu6TFuLJ24sihGqRpfouOAgiSXi/DZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hk5Nhv4N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfE0Rv+I; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hk5Nhv4N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfE0Rv+I"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 3AAEE1C001B4;
	Tue,  4 Jun 2024 02:42:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 02:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717483369; x=1717569769; bh=avZ5bHaLvj
	tVyM+SH2yXoZwiq0W/MeSmcnkcrx+RT+Y=; b=Hk5Nhv4N5Gk7jEeVrp5PuzWgVo
	T5KA+Wnd8uxsp1v2MeVxgCiqFPOvFMWeBYKYRLTLOac1kkkUK12+OFEZowonQT7P
	41N4iEMIC1zWq5MkjeCtiL77gUGKclyeaCul3Ig4pxbDexdi/+pZzYzA1QDZZS5X
	rTZC41KRbd6qpF/M8q6F+zrxAW38Mu2qLrWOImoBfOhAjg2YaRtiOIPg5iNLkyPa
	4ye/gVLM70YXneuxZkidqgWmBUFFoKEisVWUe3yBkM9mh34rC5mPSVBOMYH3gf90
	rDIEGK475j2KvbE0siiHrzDN8SOBtDiq1j/vPPiUHLLQ5oHMV4b6WejX46IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717483369; x=1717569769; bh=avZ5bHaLvjtVyM+SH2yXoZwiq0W/
	MeSmcnkcrx+RT+Y=; b=lfE0Rv+IMqgHl7dwkez/MFejFxHuqRBeKB0BwaWe7P7T
	/UZ+rYFDDxmyZuBU61EFKzHjto5djGz5v5Nyx4rngG+34oMXykIY//orPgfhrNR2
	xuGtKgIejYrciAQUaxa6PMc8z1JAaAgiQSMWJCNbMsx+yJ8tj6Q6UoWfSy/RCf6y
	cHKcRdea1C4Y/+vBqpfR3qqkiuB5IVtYWQUodej5rb0yztEP0l85OoYCEr5W6YnS
	ZXHNdyluW8QC5x/Yw/H4fLyqWdvvtgwd4mukDnpAudXUlDu5CeOcRBVsQj5c86/n
	PgGxseXzD0HxwI8Xh2RoJfEnAFw/53Ts4RUfRRX4PQ==
X-ME-Sender: <xms:abdeZj9izEljlfPF9Ixa2y53KMsWEn_OQiPhR7APksDa5eD1uJCT6g>
    <xme:abdeZvuKVIjabx23htIejjb1ZHbySmJ0q_1MtL_vcmo05jFfUT11tIgm_37Kj9Qoc
    0pH3nDK0kmv7-1XmA>
X-ME-Received: <xmr:abdeZhAHocH9fQTkpREOA1fHzm5yYqksTbzpsEiE-K-cN33FABVUZXGvEYMy18P33ijd-blxi51xCSdrtk0yOSQeIG8sG0-hNhCUMFBGUvxIJvWM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:abdeZvfNi8XbfMHuZ6UQNEnZTH0WUENkdVfMZpW-xOFn8ZmJFu_FoQ>
    <xmx:abdeZoNgigWhUHUSV3bb5BwB8MzbL3xO28rqDBzLqUm-PbBX5Fejqw>
    <xmx:abdeZhlmS8IrvsdWAoocfOXwKiwUhpJtkuRlG2GCTK1rN41Jl6QyVg>
    <xmx:abdeZiuAfreFQN1VVEXXnbihI9YhgSD2v0l0Jol2-Rh3q4uV-WvHHg>
    <xmx:abdeZlrJEcmGwp7Q5hh7D_85YEnx-IMM0dv0MTmLZMP9DDJn412OHsQ8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 02:42:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9bd2be7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 06:42:20 +0000 (UTC)
Date: Tue, 4 Jun 2024 08:42:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 15/27] compat/win32: fix const-correctness with string
 constants
Message-ID: <Zl63Y7AIkguoA55l@framework>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
 <3d92528125ee419aefdac790dc1a4106be632c60.1717402403.git.ps@pks.im>
 <CAPig+cTC83ZE2kGy=epeRFJ7a3jjRQXsvUYzB6jdOYfmy0yVOg@mail.gmail.com>
 <xmqq4ja93l16.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uweHOtEgi2pgWLfo"
Content-Disposition: inline
In-Reply-To: <xmqq4ja93l16.fsf@gitster.g>


--uweHOtEgi2pgWLfo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 12:04:37PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > On Mon, Jun 3, 2024 at 5:46=E2=80=AFAM Patrick Steinhardt <ps@pks.im> w=
rote:
> >> Adjust various places in our Win32 compatibility layer where we are not
> >> assigning string constants to `const char *` variables.
> >>
> >> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> >> ---
> >> diff --git a/compat/basename.c b/compat/basename.c
> >> @@ -1,6 +1,8 @@
> >> +static char current_directory[] =3D ".";
> >> @@ -10,7 +12,13 @@ char *gitbasename (char *path)
> >>         if (!path || !*path)
> >> -               return ".";
> >> +               /*
> >> +                * basename(3P) is mis-specified because it returns a
> >> +                * non-constant pointer even though it is specified to=
 return a
> >> +                * pointer to internal memory at times. The cast is a =
result of
> >> +                * that.
> >> +                */
> >> +               return (char *) "";
> >
> > The change from returning "." to returning "" is unexplained by the
> > commit message. Did you mean to return the newly-introduced
> > `current_directory` instead?
>=20
> I suspect that these places wanted to return (char *) "." instead,
> without introducing a new variable.

Oof, that's bad. Thanks for catching this!

Patrick

--uweHOtEgi2pgWLfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZet14ACgkQVbJhu7ck
PpRBphAAnSDd9NJGQTCBhm8eP+IuXHl6tep8ijWroeP9MEHYCze2XQF+yv9TkgZA
Vuf/c3kUS0buLQKKqYHppPzVnEyn9uLMwAp8/4kzF0sNkd3J1CGfCzjVYWLYd9s0
5sW7x1VhV33a6A2plB+Ptb0OpHgbmeGJi1fvhVkui37RUh6gDOE7H2/3C+zwpkS3
ETuQp9UUCmwfRvoRh3hD2K1iNjVBbJaLrB8DdqA8iT/0vtrWxPkpLWjMpI3KeM12
m26FsDe6KQeTKjazanjAIQ0fSDHJ3RSAxAofaNwl6nY9a9k+xH4h/ki5GgurFoCW
8cQUCkIvYISa76QbqBMbVuvIp8//foM6/MeJq01RmbcQdGM/TCTqEPcCy8rKSt8w
+M3L0brycN8R1wd8WcZ7B77UYOWNx0tPOdOPMLdbuEvr/Sh/AXXyRe03cUINQAot
FeTS9QjELjrUP+WpxcSeYmuIridLdb90833Q9w6L8He5d9qdFIIydBmswK5yUx0b
fkvgCyC71ZjObf5oP1FsIMAGu6cankFcI2CY0uClA5IBIVWxmK5khFyXYn5/jBEe
LwGlGqs20epPXN2Yuo2eGCUtUNtX/ZILWxK8zUeKkS7loAqYpLCub7D1+R9gtjOU
vLIkwzkIyqYt60gMBPbD8IFGjnRgJg7WImdln+dPs/m1Pgn6+no=
=lHOf
-----END PGP SIGNATURE-----

--uweHOtEgi2pgWLfo--
