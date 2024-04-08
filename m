Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C45B1E0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712593338; cv=none; b=HzwXFfJS4J3ikyOF9nz2p+v3CSUG+klo/IrEmfDGJG+0c3+cPn+MtmRNI8qQgbH8OuOXT1Ee0dCNZ0LN+x46iVd7wmL3le0xnHChxDLnVHXwAsuMhRfZI0eCkbR3XuhDIMZkU7SadboRoeWUx+qGEyR+eNgktJ84p0msJbF4tO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712593338; c=relaxed/simple;
	bh=Xg2bQSM+Ap7vuHbi5NAbw4f4dkO9cvbsXfV5H+6wUU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGKmGHhJcwi1sgE8BkQcnpOJ5Q4F3X0/8XagzGpTtL6N7F7iy5TFVV7RZP9Jcnfsim2ECO5sH2+LCNh/14DoAh2ZOy9u7U4a6gBsp9dZiL/Tls7wqJM/I/FkBbyW0dCuPrv6wRn66sazo5nUWN23dYq3uQYru1wWg99odevr5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DCnd2quz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kRMdldl1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DCnd2quz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kRMdldl1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 51EB313800A9;
	Mon,  8 Apr 2024 12:22:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 08 Apr 2024 12:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712593335; x=1712679735; bh=79peLczafZ
	DSrBzRnOfHVyrztHpayf3TMLbo8ei+JOM=; b=DCnd2quzTK7MdMN81m4IHVaMaR
	F+I0IMPAkfrepEbETppaaKtz+aC6lqdQzA0LX56DsZAwGFBco65K0akjNLRkqCgB
	Qv8Lfxo69rrtnxgKGFUo1xvdrMYnaxSjFIusY/HopsVhhvL0ubyU4QOSShnMk7Ki
	hS4EgYSYl3Wfl/cFL/S4XnMPcrEID0vbchsSHz3ZadJjJfp1hqdapo50chEjvC2r
	inQJbe40KlyhS6Lu3v8xBBd0mjI3BtPmZ7+1Xy0iEisXvtzbniPY5Qr2gb23BJGY
	ZA0cBZevEa/XgBkZWtXnovW2pMNrNAN2SLcoAFtN6QzTujmlLLWWv4AMMmYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712593335; x=1712679735; bh=79peLczafZDSrBzRnOfHVyrztHpa
	yf3TMLbo8ei+JOM=; b=kRMdldl10cMFukaGckQ1W7BU0IUhap1npl6Tk9ep14G6
	rR9o4IyoMoG1MWTbKQZ9JcxyrE9RwJOg7A7nFT8+1/RUIr5/AiT9wTAWCri/0VXg
	7CL/gSS3+QuGiIwsuKPLxSKBtx7UgoyG/3EMFjnMtkfSKbcV8Ia3GsB3G+OfsciG
	W8htFtbdGrkW/Uk2HPn2/jh1+ylIzoYqSq5p9Vi2d179GlP8VeuKGAlEVlchDbCn
	WX5ahehWHWWplH2snZjGTqLX9E1rXFtRdAIbAv5MlKugynuVy4NLOLJJnOwvRpzF
	b9cXxBYkmfRenQY7DpMeVKqghWCh9VQMS0FWmswVAg==
X-ME-Sender: <xms:txkUZv8-DS_R62k9-4oABDv5bmZd20GKcio_UN-MnchESasYJN-GfQ>
    <xme:txkUZrsIR2ymvLDH1oziUwDOHp2h-oIW6DteTMK3oqFdnO2vgZM474UI5cQ37CgS6
    lk0Iu6Susy0WE1NHw>
X-ME-Received: <xmr:txkUZtAR2xk47Qnlco6bVPzNB-_ygwhmpYC2gJavjamMdvZpb772cT-ZB-lJUh7h2CKg6kxdcNMrGTsX6HfYzcCophWnLqdfIeNyvMQkdIE4ZV-_WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:txkUZrfh6uTmgwQbvDX-2Y7BOAXuq-WZORuHbImGDsjbEr0-obthDA>
    <xmx:txkUZkNJxIE1442_QrLf9fGEq9nh5P7_VU7TdRzkC6r4awH4s-EP4Q>
    <xmx:txkUZtn_D787Tug_2MfzrfaUu8GnC-1UUZPfIqxQtF1u6JpluNgsIw>
    <xmx:txkUZut2VjaEVaXE71TWbN_yFoqzdWnkgxmWk3L__OHEnqDsmywT8w>
    <xmx:txkUZgBi1ONbWMiF7hNYxDOBZhBnm2It7DgHZ9pUtUKnGwYevoMdi9i3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 12:22:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 19ad5a28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 16:22:06 +0000 (UTC)
Date: Mon, 8 Apr 2024 18:22:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>
Subject: Re: [PATCH v2 12/12] t0612: add tests to exercise Git/JGit reftable
 compatibility
Message-ID: <ZhQZsq5_NyXmWM-b@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <160b026e69547739a526fb6276a895904a4d33a8.1712555682.git.ps@pks.im>
 <CAPig+cT3kvvHL+wLTFj58e5BnB7yBA=HD3C4vWC4zQhys3GCHA@mail.gmail.com>
 <xmqqpluzet2z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="A37xH7S2tm7Lnvq5"
Content-Disposition: inline
In-Reply-To: <xmqqpluzet2z.fsf@gitster.g>


--A37xH7S2tm7Lnvq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 09:07:32AM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > I was going to suggest that you could accomplish this more easily
> > directly in shell (without employing `awk`):
> >
> >     {
> >         echo start &&
> >         printf "create refs/heads/branch-%d HEAD\n" $(test_seq 0 9999) =
&&
> >         echo commit
> >     } >input &&
> >
> > but then I realized that that could potentially run afoul of
> > command-line length limit on some platform due to the 0-9999 sequence.
>=20
> As xargs is supposed to know the system limit, perhaps
>=20
> 	test_seq 0 9999 | xargs printf "...%d...\n"
>=20
> should work?

Is there a reason why we want to avoid using awk(1) in the first place?
We use it in several other tests and I don't think that the resulting
code is all that bad.

Patrick

--A37xH7S2tm7Lnvq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUGbEACgkQVbJhu7ck
PpQCwBAAm4NoH9R0xm+wcQLaNtam7RBbsM/HDYOplLwANtxZ9489R/guAPxS8kpZ
r193drvVTpF+fNKd1NjbODEd/BZXFqo+9TdT0QehkIA97HN+roEBQkvojPOvexw9
6ITUVFfd3wZ2IACyemqxM+PgIoIdnzf5b2Uy5nmteeWf151MBAOEfhWaHacDKHf6
rJlvLLAnd7RGtKFp6IVYzKaDAc/2bsUn3RlmujF48LZVWKBPu4rcFNzboveIJY0Z
gvY5wkRDvJ/MJ0MyHKaui+sSFVqUp4ykl+XX/Sub79RL9ksToF5Th7mQTRpX5PuS
t19AFkuqtzX/irKbMlFJDsCwOVcFFJM3TEJ1SL9BZl2e/LEoeNzK96E+KXocHs5C
7lYBSbWVnVlkzrNT+VrSiOV7VEhFYzARwhDisjmprTOD1ui6TfJNTuPFmn2aE636
G/BiJTBPGsf4/cItMvaEiKwdX9Y9YSQzvRpKoToTUtsi8hAC+d/GZkSWeDWuwnCw
4PGscS1MOBplI+wdM+S2rnqFgL88ut26Qj9Q7bmNHACBvutMyq8qZL4n/ARckEDN
44hbzWap8RctGSTCK/r7lpAhcRQmFO5mvcCHwwEXo0c4Myxrmw+SNyBwzBViUaQy
62YNeCwT+QbaviKOfsse5l2kMzlnusFSQWg5kPdtxAjx9gyLmcg=
=3n2l
-----END PGP SIGNATURE-----

--A37xH7S2tm7Lnvq5--
