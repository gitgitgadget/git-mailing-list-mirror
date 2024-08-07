Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5339E191F6F
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008229; cv=none; b=PHUpsCIH3cCE0ENYxNjyXNX+XEd0ISxNvrqooEXsouoh2ETqRhSL5XzsNcBqM2VJuTMjm4D4O/nAcakUpi2T83MwJFZQwE8lSDB2i1t9Efu1uDG9HBepXfbLFRBUNGNWj7Os/CFDkC9bG4edLtfbJdDzPQdDHaiC2hNgHFw1VeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008229; c=relaxed/simple;
	bh=tvZjuSuZ6+Gqu9+wsQ/AVn4cx3z6/XQovN+qX3RzAnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiB5YvedxqvPmYg/72bQjfXOgUO2SAiznC7St1QNUuDpOi8eNaeZkvx894bZFG3rkLuyocL9RcLt2q+czpz9sPcZ5ZWp+PRb6PC92uYQuANUcxuVlvwmppj956dplFPytdHpqJMWB5TjH/75K0n5pNkxuGutq9RXKpRUsBg9wJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DrR5okJd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UZ2YFc25; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DrR5okJd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UZ2YFc25"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3AAFE138FCA7;
	Wed,  7 Aug 2024 01:23:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 07 Aug 2024 01:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723008225; x=1723094625; bh=zoQuCxxEne
	u96nPWLWbmo5PRv4kgIfJjwqvFQHhhitk=; b=DrR5okJdT2oMQyR5pOUp8XpEES
	Oqhrhiz/s1VclxbFgmj0l5ujbiOJYCdgkxwOPG6oA6lczbSkL7k/T6idN0JA1Gpu
	vUGusOFjldCI0VjwJIaaaNOPJUSsU/eAGcrgo/7GhpKPM9v11HEc84Qtj//2lJ8y
	BlpJx7Kn1Z79wod6lPEEOLt5wmZOvg4ztuVRqAjEnDMhFUKWa28ebbcOX81Q0lJW
	qNUHLqq2/DEbbui2T4olwmBr39//hvF00bh4u9roa98yVvhozR8KarVp0WftTM5F
	NRWh962BUpWmQXYhMh3Q8bEsnyHsS0nZqAw5fpwFX2DTdEGE2bJts88nYqNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723008225; x=1723094625; bh=zoQuCxxEneu96nPWLWbmo5PRv4kg
	IfJjwqvFQHhhitk=; b=UZ2YFc25fhq8/GmTXogBEMKUb5f2dOkPPsaofAswG310
	FltR664Ull09e/BBBttU9gW782f5CQi5YljoBON1F8og64FH6I/UdzGkUzt50tFI
	v5m1cnWC5d9EyFRhgquWfZykSviIiS2N615iqo8pYZ5Vq4byGl4i/HVEMKKNhocQ
	1CwZlHz53tIAp9rfkjjBvuy6eoWHdZirEUgscaouvf6GQhSODFj/wdElGg/zpUuw
	vGJ73NTQwR+KLu57jNF85WvCqKyKxV9gpv0v7tEo4GX9lABLMlIJNuhUATpeU2c8
	0ezlRZ2JQLCK9GHspr9LE7J2t6GMXK7uLrJITMrOtw==
X-ME-Sender: <xms:4ASzZqGD7Lob6LWozNHt102t84f0PDSjlBKvnZUN8rFzomLAyIopGQ>
    <xme:4ASzZrXNWFNxDvwdGuLx66MbPvvWpMSnAq9HH7phoQVxChzRwaEJs6GYujZn092V0
    behL-KbCZiakVkMOQ>
X-ME-Received: <xmr:4ASzZkKM3NWa0HpNFcHDG0HunSYet_iTqnQz0LqOK0Ztj7DdDolNNxHHtcokSWpvHYEk_VpXYzDzTOAfxBnxk9oe05olOmdxsTH55dkGTMFMVQBG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:4QSzZkFwpgK_pDYfK6kkkUrMJEcqWfqpiXvIzgYFLxDeTBbrmPGMGw>
    <xmx:4QSzZgX2578U7ViGdAuf9dNJkcinISWZTurxHzkm09ePkxu1fuoCeQ>
    <xmx:4QSzZnPaTsCFYST7aMitKfoZQhas3lgsWoW0IxhdfeFqsIMDbZs6EQ>
    <xmx:4QSzZn3md0i6da7rad2VlqFLzCWDY5B8vlzXGSQaI-ZQmJIatT9fmw>
    <xmx:4QSzZnT7HqmSvm1M8pGRryjYSvFrqU1MIoZi824Hw-qqBRBEUm3SAvMY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:23:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0b082308 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:23:38 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:23:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/6] t-reftable-stack: use reftable_ref_record_equal() to
 compare ref records
Message-ID: <ZrME3EXwf2qDfTew@tanuki>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240806142020.4615-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VybCzOQFO6ZQ61kc"
Content-Disposition: inline
In-Reply-To: <20240806142020.4615-5-chandrapratap3519@gmail.com>


--VybCzOQFO6ZQ61kc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 07:43:40PM +0530, Chandra Pratap wrote:
> diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-st=
ack.c
> index 14909b127e..0c15e654e8 100644
> --- a/t/unit-tests/t-reftable-stack.c
> +++ b/t/unit-tests/t-reftable-stack.c
> @@ -145,7 +145,7 @@ static void t_reftable_stack_add_one(void)
> =20
>  	err =3D reftable_stack_read_ref(st, ref.refname, &dest);
>  	check(!err);
> -	check_str("master", dest.value.symref);
> +	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
>  	check_int(st->readers_len, >, 0);

I think the change itself is sensible as long as we have tests that
verify that `reftable_ref_record_equal()` itself behaves as expected. I
don't think we have such tests anywhere though, uncovering a test gap.

Patrick

--VybCzOQFO6ZQ61kc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazBNsACgkQVbJhu7ck
PpRz9Q//Ym02zcyqn4IWG+4BQVtrm/bgBx7zPhAnL8dVduQIsw4Pb+kI9XVP5tzJ
6K2lrTwFnwMFGaW/EGh6fy6zQOm+JiwyL9ArMdc/er/E/MlishU1Hse9y515+ihx
6iZJ4qH/aW7qzV4D2zQbryuGkNpEBiBHMjhlVTAtjbMGG/mour4FvGlsbc0jYA8O
v57d4Qm5RVGR/km4Nm48CQ88KGQdIyImvBfKgS0o5jJcnyRCXBQosukGvg91SzJ/
yCn8bIYMW8t+PJV1IXbJWw2iVfE1k13s5QtL9kaiM7SzS0nEO+/4SZbUawdke1ad
OmXzVEOTzXCSN6rPVofiLCDZdRAvyba/NcJsPpSgqoOR239PIVI8bbBL/q8xPbL5
6zhMW3fajQxWU4bhdoMhqeWEzBodNsM6HsPpeP8SzgLRnXD4X33Ws2CYaYYlKzRg
l2IWNMSyAX0WCqTnblRaEDIg05K9bIb2wZJALsZK+5Rl0d8LMNDtSFPud+1n/FYA
fjPCrfNNWKO3pNbNcgXeOKFd+LxennnTs18aSy6UvDvzWYXyHaBY65LZiqGcno5o
lTTYB5x425U659pS0yGxMVBdOAPdC3FruYd0IPgBiFRcQljP317ftWdQ0C0VVXSV
5qvFGMG5bKUjpaRHZu5p4u5zvxPDS3aazNHQGCnvYLCLJnE5VRU=
=9Cct
-----END PGP SIGNATURE-----

--VybCzOQFO6ZQ61kc--
