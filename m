Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84E1CABF
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742311; cv=none; b=VcH+CQere7nPiTlRGlkOFd/yPiyTJRzYDe9OEcmlNiGY5zDzWxX2cFiwLXxZ4QAxOnDOXu6lEBanVwg6uluazRAdCea9bo+LkDwLzMks/epTcwGen11fSErY91ENibt4FTTyU8XbpNcmEOkFJe4a7SSf+7kjKO8iR2gEgH2/Dxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742311; c=relaxed/simple;
	bh=Yhf3brKIXv92JvYx03I/V25XcJVOtgEbkIheNbKschI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVN0Ypoz5U6PMEup9bG2/L2P9yJTkk10YJHjyTD8ArMTa2ByZBceRu6BpfAb29VbMtADMDPyT3PkVfaWQ0mIPVM4Tkwpxm+MEyMm9ForgT40Y2eoEqZ+PzZ81B/oEDvZDWtR++hdNeUThAqsl7n8Qcj5f58C/5Gpe56uGw3NqJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kd69rm6d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZwgYDJIF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kd69rm6d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZwgYDJIF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id CC3AB13801ED;
	Fri,  7 Jun 2024 02:38:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742308; x=1717828708; bh=iEq6NJRiHp
	F1Ubhl+vGKDFtNdtNciKo787fZ8CYmaPc=; b=kd69rm6d+/q8SLuhyiva6lTzL2
	x76XCVYqsPS/uqmh4BOFsIidDp2xwrkTzleywHJv6XyTyDouYsYz4CYIFAULI6NK
	oe5L1OPbKNOZ2qv7jNSKWUJu00VzmZ8DOvNH2Ky4KfRlBEOurtkmZELBD/dnQVC7
	Q0Wf1SYCVa2Lh84VxNw48yHcYZU7GhBk0DGFElfDLWgTrrHrYC3hl7Q/LevobTXx
	W1x3DZ8hxug1QsccuF7EhX39ZhG1Ty5OiQ7iMC9MW/fMk1ws4I4ltI5cmQUuRU9+
	bTw+hU2RDUmJDkH4jD0iyTzb/EAak3M8IdOCoqPBS9evl9+DV4ONoVyfLiJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742308; x=1717828708; bh=iEq6NJRiHpF1Ubhl+vGKDFtNdtNc
	iKo787fZ8CYmaPc=; b=ZwgYDJIFpRt2y/FdWNGvBqVEnwTMSglr2SV1AdKJ98MZ
	WmkD99M2DcRtfBA46r7R95eBWmYdVdlTv2ojY1EjKTTPGa4Qq88G65FybKZ/PR48
	g2xceM/4SpwFVxp2ukEd9qwdr5MPqlHpBlL6Hi7QAqrHW/tsj7wEZ7p+LRYM57JH
	gAcptoE50heT7oZ2luuXDthfQQNeiUHeQoE0I0BbpZ9EQ8uO9XHNTqU6+ZAkuAnS
	+HgWcRQR4S6jLfJ6KTFyxptn6cETSulu9pjITLemALn49nup+owniKXxCbLAQ6Na
	WzGJWKObXoNbxhn1GzAL+dqI1vpbWc/gQaEWDdjeQw==
X-ME-Sender: <xms:5KpiZvPm7qVjhW-j5i4aXSTmBPpRxsjbzVWvDH9qsY9pFD_aEcLn5A>
    <xme:5KpiZp_DMDQjRRGaVyc0ccqrXsksVL9xw0S9d6xQ-PWQJGDydb_1TRNiUD5x0t4xU
    bdxxs9VsDDJRD9-gg>
X-ME-Received: <xmr:5KpiZuR8eDg5u0BnyhTFvK-i2RO_KHPRG0QnZCagEtlDAI3aLcSE9ceAg15KQ_mhW03Pumfg3AgCNj1bflXWy0mQQGbmRL7e9M0GSCUu9VqIL87O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:5KpiZjtxlWqdfMy46YhEcjxOruiLPUmVkDpLkZCRCi-K9ekEC29iCw>
    <xmx:5KpiZnf8A27hD78MWzVKVv5ClYpuBkrbZggSrCbhltj6e4YzmaH0PQ>
    <xmx:5KpiZv0EIN0ViT2t7A3QIhE2HIHehm9VNP9-yBPBd3idc8hy-L8X6A>
    <xmx:5KpiZj__9lx9CnLHvSEDp2DDYaWse5jgXrUpCmqsisvFp9NQpYETwQ>
    <xmx:5KpiZu6Wa76m-pb-PAhHmNCpp9tCVMfAtzjBX5a894rkc6HRAscc6pXd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e9f20832 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:27 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 11/27] ident: add casts for fallback name and GECOS
Message-ID: <0d36b6e5d777864559e48b0af874f11e46cb852d.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G1rLFVgiaEUC6T6Q"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--G1rLFVgiaEUC6T6Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `xgetpwuid_self()`, we return a fallback identity when it was not
possible to look up the current identity. This fallback identity needs
to be internal and must never be written to by the calles as specified
by getpwuid(3P). As both the `pw_name` and `pw_gecos` fields are marked
as non-constant though, it will cause a warning to assign constant
strings to them once compiling with `-Wwrite-strings`.

Add explicit casts to avoid the warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ident.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index cc7afdbf81..caf41fb2a9 100644
--- a/ident.c
+++ b/ident.c
@@ -46,9 +46,9 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	pw =3D getpwuid(getuid());
 	if (!pw) {
 		static struct passwd fallback;
-		fallback.pw_name =3D "unknown";
+		fallback.pw_name =3D (char *) "unknown";
 #ifndef NO_GECOS_IN_PWENT
-		fallback.pw_gecos =3D "Unknown";
+		fallback.pw_gecos =3D (char *) "Unknown";
 #endif
 		pw =3D &fallback;
 		if (is_bogus)
--=20
2.45.2.436.gcd77e87115.dirty


--G1rLFVgiaEUC6T6Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiquAACgkQVbJhu7ck
PpSihA//ZrSyc3kke4GL/nKZbbw5iC3RdBd4RahIVQeQktcK1X4viv2ngxvAAboB
e4AfiDyU01ca3+tQSCNm0Ay4wZL1Xsdocd9w3US/Je3yyZWrslFU7/06uxDCUs7S
Ea1DLKBvLUAQafHFMEtTkvGvjrfhj026XdbtSO2woSnpKIeUN22Xem+VOe3wC9Xp
LGhHoBDTycNFN+R58m5d9ldUIADq5LZHsAuXigmedfZbA1Db52+cWCoSNP0ZcVwx
EJMIhAhMSWsXgNryYp6MfwetkWWBmr9+ZO1LJRkNopuhSwFl9BgBXD5bjid78mEw
cw+iJ94+ca+IiNCJ0pMLQpFz+54VdcIazxZeZylQ/ewPfJB0uBsouvNz31FlfX3+
IxqB61z4Gat32N5lYSRIK8nEeHiJgyI2JUWKTtwY8hNl1ReMQRRD9SBPX5vYj3vN
OxBSG6MZGts0aWg0fRJ2zAC1XuTCobXGf8sooVguExfdZFUg4b/N5c4qBqSZASWG
OscD9dR5dsuFNIQpB/pigomLsVIQKNdIKNUY3ZIthocxDaDcUWajfMeE+oH7JASG
FZ8jQS5mxfXI9yb5SrnT0jqmjcEfeRf6/VN0G0KQLJCO7ITWBf8pzAuzzcGKmB4E
rR8ojxuCvEwywQt+X4ry5Lf8x4CZ78NIxrUhS5FSIbS1Ys4yPpc=
=m960
-----END PGP SIGNATURE-----

--G1rLFVgiaEUC6T6Q--
