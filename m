Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126CF178395
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 09:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666313; cv=none; b=joMkA+/2JVR/H1Q7YdcPefQQjgRIC17s4A5sqFswJ3EUft5AxvvWqXmQSxFUtlXGKCTfYTLPjcTNgiy4FxWcFC5dYE3CdBS0fBK2rJCAwkM8/siJi9F8/XsJaWQ7klvmL0Xs3OZXeTYJtJ/V5SuKvAemcX62mdFMU8KIRoH1Ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666313; c=relaxed/simple;
	bh=s3O5p1J+UeQ2khwD8/2s030Pm2VUsZVJewLFqLgUeV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9ayaDWKJLDUTFGWVfpeR+4XhIAK4FFs8XLh1AKtAHlwVtTKM5cv5/K564QvYL+rQZKG5midZOoikm6xmlMDWhyCp1I9kz8oKScxcfW7yPPtv+qKI5zGv1X8uQlB5oCmNvoaOWwPDPPp77NFfMgueVA+4jI1pJ3yJVtZ0mDGvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ra9qrPoo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNZdbCs7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ra9qrPoo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNZdbCs7"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0B9C5138011C;
	Thu,  6 Jun 2024 05:31:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717666311; x=1717752711; bh=WFEJpE1oKw
	dgbR8KuQo+mk+YjsJ0gJJallABHnqOPf0=; b=Ra9qrPooez3oEqDrm6N6QVlLJJ
	BkP0Fw+OtBSpBNbhxWh2ckN1nDkR6mZEArYXjthx2SOgWEWpt4JZJcdVohystroM
	dLRMm5BRvNUkc80yRqeM2enQkXDL2LHfh9gPzGgVcT3AOaXddhlZfi4hwH38clJw
	vHREbYT2UWi6r9mGflTf2tMAO1d8Be+gQ3YT3P0FjQ+UVWNUNFv/5/jlJl8JMeVg
	agpXXexpmelW60gWnTKAW+qQWgU12ykcmp3hJfh6z66lqdse7mIqjIYeGnlWa/4j
	+369W6km/u3KMJBtxR+imHna1C9pFvI927/EPryyQkVpjAtmryULjoG3+O6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717666311; x=1717752711; bh=WFEJpE1oKwdgbR8KuQo+mk+YjsJ0
	gJJallABHnqOPf0=; b=TNZdbCs73q/KJp45BEOjM+chNWuXMxiBemf3bxNJLkGx
	bLd87GaaP7PgBw/8nzsxY+TVO3+1Wgjop8jroh0vRpASYvslF3lCEA2Xk5DbLYJQ
	w7yRPnexT2uJ5LXKSInldfUs/GyyDKyZY2zJ9MBlT33AKEn4urIoY6m9efJWw2cL
	ARYATgnjBaYdolaTPKx2DtYot43DadN1NCwCcTiswlGNg2obTnFsi9QgnvkLbgXy
	AlevIKE6g8ONJMkbyTOGWqJsT54DRM7NKpHjn5oMN/3ZFGuHgZNlO6WehmtdJ6CR
	W8w9T1IOnHxxOjaLLjwGEvlpxvJvWXy4+UQEw8/Kuw==
X-ME-Sender: <xms:BoJhZo8W2ew-JTfXQIdKKg4TKpwD6cLroUYkXXbNqRfFaxLW5wgVhA>
    <xme:BoJhZgsxffh4I3cK0ALZDkC4htQVyqDdd4MBBKfgnoRDVJuZqe1DwkoOnsL_HP6nX
    _-Th3rgbIYpxflO8w>
X-ME-Received: <xmr:BoJhZuAb4v54Y87n19aUST-x3hv7Y9To6G5roN13lSihsLFgU2d5srnHQC6O-mlC-BRm5Cc0piyLtNmhIDQzfUlNctu2_IPBy_ixtvcT5uMNFwUR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BoJhZoeKtOKer9fxqLZXDo8bXIp_ad1W7hrUkF5LD-I9y1Y3elB6-w>
    <xmx:BoJhZtMJDL4hIZwYPYXM1kMmuG0e27c9Y5AAGkGumpW6ngaOs_DQlA>
    <xmx:BoJhZildXkXYhgLcyvyWInCwBWvgJBEepQaS6yjLCFGSoAt0xX-jaw>
    <xmx:BoJhZvsRSjM9iRHq2o0l5V-5VOEc1aiBd5NSHLTcBB2ymjltBmKGUA>
    <xmx:B4JhZurem2AfG8dH9x9cuklKw1OZkuwsOuX8_npQIsF7huh6d3cbH1g3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 05:31:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fbc1c5cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 09:31:12 +0000 (UTC)
Date: Thu, 6 Jun 2024 11:31:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] ci: fix check for Ubuntu 20.04
Message-ID: <f91004a4382c95b1b87bf3d1aafc018af2b7b92e.1717662814.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717662814.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2j/ByfiJNcJopjCl"
Content-Disposition: inline
In-Reply-To: <cover.1717662814.git.ps@pks.im>


--2j/ByfiJNcJopjCl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5ca0c455f1 (ci: fix Python dependency on Ubuntu 24.04, 2024-05-06),
we made the use of Python 2 conditional on whether or not the CI job
runs Ubuntu 20.04. There was a brown-paper-bag-style bug though, where
the condition forgot to invoke the `test` builtin. The result of it is
that the check always fails, and thus all of our jobs run with Python 3
by accident.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 1f4059b1b8..814578ffc6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -328,7 +328,7 @@ ubuntu-*)
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
 	# have it anymore. We thus only test with Python 2 on older LTS
 	# releases.
-	if "$distro" =3D "ubuntu-20.04"
+	if test "$distro" =3D "ubuntu-20.04"
 	then
 		PYTHON_PACKAGE=3Dpython2
 	else
--=20
2.45.2.409.g7b0defb391.dirty


--2j/ByfiJNcJopjCl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhgfwACgkQVbJhu7ck
PpR7ug//SvWPoQxQe74JU9BiTVkIPs882jrDfgZb9Eay09yLzyArwMtde2V2cjUw
p0QPcvSkAAovWGsxiw61g2Hil2oPYYEthvr7t2sFp/v3BZSfy7EfkC2lAE2Q+15G
i2lHWvR8Fa3/AnzA0PoovSvjIEs9Ur6xUMab7FQI6rdKBj8B0QX+7iFbOSKpgJ2X
BP5U7wiNNqiBSJ/RUYm8NPSfDB77pcQoJskY4SbSSLm9/VGPW17dbaugCLiHGOMw
+ijtLem27m2HsfWq9dtGHHSlbAYCacnbpU7aC7QSVW1O1ldSkaz/4xgV4iPY/Wuu
x3t+fuH2bb//VvbUx0aBMGgtVCjQnPV/8iUaBHuGh21XSfr+SQZYFMilc7OmCal/
5cXKWD4ehIRDIsFkYFVAVjLzZeok9ZWsTlQYAo5Ki8uwfGxWOlGCPegQHgpk255p
C6j0LdtuUz5efVig1Uv4Zu+3/DsuZD2DD1bUkoYTQqiJDb4kWv8iNYY/KcZCXm/4
o6LqptLKCXtVyvyHd6Z0Vl6jPLhesglLau1udjiMg/L9dcIeVziLwvg7ejgZyw/v
mRYlS8eeLLFVLqbfABXuyGGMcm9zsAci3lsOE2e1SFofTQCE7slgXIp24XBAUisw
gnH5Lps3CV+t2R1fMeccZioETA33EbYEb7+ngAiQ2egVjRZrVPE=
=gPpU
-----END PGP SIGNATURE-----

--2j/ByfiJNcJopjCl--
