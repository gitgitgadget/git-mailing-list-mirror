Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0D1DFE4
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 06:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027599; cv=none; b=jxwkvhBck1PeCR1xPc9a39v7AqXNBQw4oYfMz4qyqbA0JXIYday+wEbre9RpNo3ukTPGp4D6/OusLi75KQL8dwyPusOmIToVtpQGX3zo2gLmTLeIvkD3Hu+G8hRiLvuu7Qx1GuaHvYjqGGxl6m2Pe5DxtGLFiql7PORJx9bcDPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027599; c=relaxed/simple;
	bh=L2sGWO+/nb9rvVnv5FoSEG73uq1Gwlvnw6yfp3Lm354=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNEAILvB0eL2Tukirqx7bVa7iNRdMsg9RzOWnuvovFjFzh6oqCC5PTywDb/JOaSvn93UBxz7HnY/AuGLX1JcjZdBqVKW/8UFwrQ5fA5IMAMsYJ49PKYGAfpZbWhSin6OKo0YHQJEVSS0o0QDqhN3PuxVkgyaoarVvwI13WjH/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FMp1R8XL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NodFfvT+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FMp1R8XL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NodFfvT+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6A16E138006B;
	Thu, 25 Apr 2024 02:46:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 Apr 2024 02:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714027596; x=1714113996; bh=XLR2i+L9sv
	2wc6yYo51eBTo4q5qLNUmANO6Oe1Zv8zI=; b=FMp1R8XL7MwwepDvjXLOr7kBhz
	8zIZaGMjn8In3vuTwlySUwNrovsMbSQWaU6uW4kFS1OSOMKqTEyaUi7p+3QajO6m
	E2D8s2qfu+U+rD7EdyPdQ3GBf3pxchh6pfA2mYciSHwFi5jAoLzMkiGgeObt/MUm
	yKuRPYnby/WYQMao1jcF0bBUmdTI8TIKW9ipeFagfImXrvKmiDzKXUogMVrii8+5
	wAKh/LN1MbdUSkdw3sUhhCLbM38C8TuSafbmqTS5Nrwb6rb7pkNFDjnclWoeacPU
	85lNNt6gnkXzQ+EuGlw2sUu/P97jgL9YPg4yaepGI8nWSI7QYl8m5LojF4GQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714027596; x=1714113996; bh=XLR2i+L9sv2wc6yYo51eBTo4q5qL
	NUmANO6Oe1Zv8zI=; b=NodFfvT+74j/xoAR02pyFHrMAwd0lzzzFe3cfSw0+yNU
	Fz0L2J32gs4NzHeX0Ww/VZuJcph2occPc4BVK9vYXfPkfeuX2rT/ntFNt7RmBMD+
	8UL6nfi3L1sCmKN2HVfAYwSR1l1c6OGC5+qxH4B/BRIrSjOkgrgLHrCnaHxLQ6CR
	bTeBXWUEkdIgY2JoG+ovakwp8Oe/Csfdj98mQb8srUZYIyYESBa6iCMakQIBmXNr
	1r27wUfRVkAPT30Uj3pVaIJFctcROaPegm9aWJSLmjOEfBUUAq5o20uwILvgPXht
	l9a8ZjBxvMxCasDRsPrf1KLc51IQbIptEPgqe9tx9A==
X-ME-Sender: <xms:S_wpZrdlRISOKkerb8zJxRT9jYL3YpCHwh01dkbT-U9C6aw0IS1pEg>
    <xme:S_wpZhPVK4P8Sr9uaaif_N_hD-iMFQpCYBihhhJcSUX9mMyCJq4QMaZFegrU4iBoW
    xQuarUtk9QI94pGpA>
X-ME-Received: <xmr:S_wpZkgj_Rl-cyyucnGCp5BZ98DR4hZwgQBXVsdVmHTwc0a4h1YWjMs1VhWuxEsfTQo1gnfKc8mexBQDc2g6lyt5HHMYWwbD0aQYP3RJIOW3tAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeliedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:S_wpZs8hvrkhxoyVCqi5pwIpmDMXRcsHDAQT4Ox57tagf-0LXPYGXg>
    <xmx:S_wpZnsjbNEpmfi4upt4xuHiX-KCmITT6kBgoDQkYIKXT7AXYEFLtg>
    <xmx:S_wpZrE5NjNGvmqBwAP1in2L1lhUgyOu5l8d-SWtCjR9rfVSkB5lEA>
    <xmx:S_wpZuMntaWGoZbkEJzNUnqo6L86WZL2hdC2riYGG24RNSSe5cPbpw>
    <xmx:TPwpZhKw4PV-Z5sJNQMK1Rmusp_sFm8_7OjH8HKcmoyVndu45EB3lGRo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 02:46:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 465e93d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Apr 2024 06:46:23 +0000 (UTC)
Date: Thu, 25 Apr 2024 08:46:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, James Liu <james@jamesliu.io>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
Message-ID: <Zin8R_iS8_hiy2JE@tanuki>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g>
 <ZiirKgXQPLmtrwLT@tanuki>
 <7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com>
 <ZikSNSszRzBz715c@ncase>
 <xmqq34ra3iyj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SoGxwNbDycqd15wD"
Content-Disposition: inline
In-Reply-To: <xmqq34ra3iyj.fsf@gitster.g>


--SoGxwNbDycqd15wD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 07:59:16AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Filtering out advices would be doable. But we probably wouldn't want to
> > do so unconditionally whenever we execute Git commands.
>=20
> Can you elaborate?  Would you only sometimes show advice messages
> that come from "git" you invoke?  Based on what criteria would it
> decide whether to filter or not to?  Is it purely per location in
> your program (i.e., "every time the control flow reaches this call
> to an equivalent of run_command(), we would filter the "hint:"
> messages")?
>=20
> In an invocation where you would not filter, what effect does users'
> setting of advice.* configuration variables have, and what effect
> does a new and unseen kind of advice messages have?

The reason here is mostly that I do not know whether this can be rigged.
I cannot state without a doubt that no command may output "hint:" at the
start of a line that may _not_ actually be an advice. Think for example
(and I know this example is dumb because advice goes to stderr, not
stdout) git-cat-file(1) with a blob that contains a line saying "hint:".

Patrick

--SoGxwNbDycqd15wD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYp/EcACgkQVbJhu7ck
PpT/ZBAAhWnVDi3QJ3MCcfgKnvxjKTLMLkM16Xifwlj7HuMDFIwN1b1PRHpXxNBs
FkfUy+mj7Gdiz620+T7svg+ZGcIMrAXBEEDHbkd6GPwOgkRZO9iHH4xOHp6ZXdaI
+uzlFZgy5yZ8wFwolEd3Z/FbUI6FYocN+4e/ohf5EglW5AVCG8+ndqUFPP2iAPJ8
OpmOcogLz55tvcVLILMu+nETqOiD2bQx1e/qHN8vdoHZ4F+G/aRtleCsx2V+cBIm
slBEBsmBgoPWdUGnFUAJvh+Tw+bl8q5ZP5pLtF/sHxj/shYm6X869AoaGZJyHaLZ
GSHAvmEq/MI9FfrXVEcBW25JZIAlrX9zzRjbgY3U+xMxF4/Bb6NLG4m7lABUuIXV
8RqRFW+wrnur1y+WKzqoqlPvw0GsXeJcF1NolZGoJbm5IY0ZDU3/LPaor/n6S+vi
6BAtzpmoRdLv3iwnuJ5ql9HKpoOkVzA2pFd9F13XtqFdErQzSOzV++RVLA8wVaRH
vZ3/zCqE/AdGTsp4ZlvBHAlSAJiBLea0DGZ0qMTrFZ0pJ/EqJSplKdMxK1LotcRm
spuGsqoNE0yva4jVzy1bGwVyQ31CUtTHiaVymkYOczDOlJEGDT0FpJWMkH/rHiRL
L4G64UEtXO4Dq4Ry6KPWea3tPh3X8yhpAe0uTLtZTn1vi0RbtQU=
=WNVi
-----END PGP SIGNATURE-----

--SoGxwNbDycqd15wD--
