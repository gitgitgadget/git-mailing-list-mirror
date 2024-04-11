Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7532142642
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826671; cv=none; b=OBmnZDWAV1N6XpejA+QYAThQMBi0s9NJJ6ghakbWqqRLX6Zo8grLjHNGFBb6UzolVsKb/uat628AdJgSj9QaBFjuDx1JhWxYDggfgvAFt7xSyxN8W4OeC5FH/CEn5ndutEQLc20lIaB7AcEvjEPm6h2WxsoY7cPbFRRh8AiFU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826671; c=relaxed/simple;
	bh=uHd+CRm64yrilAsejITRSIG5pxeOjd5S68kSZwpJrD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBfRh2kt0h6GgdUGiFuYRN+J/16G2hXPpe1xnqTC+Rks8HQZr8RLB3JjYl/AAgTKqGWoMRmMu5uiAvf3LdJrl9gOdWtTiV5V5oTxivu6Ob2kiR+uo4Y7oU9vDE0OkFDmwg6MX/LX9XEEzI8BI3r/upSLoGqfnXZ2htMusyklYNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CLzedELG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7zzEaRv; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CLzedELG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7zzEaRv"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C543A1380249;
	Thu, 11 Apr 2024 05:11:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 11 Apr 2024 05:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712826668; x=1712913068; bh=p17Hk86N1S
	Qdz9j034h2CkWHBQhy2eKA2Ri7IFVYdmI=; b=CLzedELGnSUmxvGjvt7S7sFD4K
	uK5EP8AlFcqh8xeh9aIqGVmRVNkBNn7BKtCUk7T8gX1s6M1a1fDxs8AYxSugvoYv
	7lsIwwIcq3H27YDEGsD954nodRD1+6D5YqpFndCVYwJyPwOyHBJTJ4Er9+/MPyy6
	zsRvI4k4GssgbC6cbydUBBkLBkdv2clT1wDNsDWndZeJkT8615c9fGHb/F7/6wk0
	sSIEvEFQSTtK/8HER4wB7iBCnhNoBx70bBMlSkCB5DCunm0yyvmrUIpC127d/APN
	IoxCyRMlHREL8t7zE8QS6AsU4MMluO+g9ahyRuBxjqwsiNKQ/PVFJh5y3Huw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712826668; x=1712913068; bh=p17Hk86N1SQdz9j034h2CkWHBQhy
	2eKA2Ri7IFVYdmI=; b=j7zzEaRv+5weI6xUbvRjojwU/gxqr6SkyZKp7g7G7UiA
	kuTUBVD1FLWxfWkYlpnCq8Oq8pN9Gjyi3mndO+qi0kr7aGTb0c/xkkXl0LxLt+Cz
	SIOG1hn/kOeijFbVinubEL+g+AqY8dp39mgRp9UE/TkaY37Cz79Qmr9QGu/5mwXb
	KMazXvyvCm6Mzdk0G8CxXao6Op5dAy5YAndNtgcSkKh3zQRKNTzbKn9+hF4pR2YH
	kN7OR4t6F6Tq1qW8RJgfavINyelbbozDtgXPUTd4BagHYmce0npTVI4rO91QGH0x
	ExfOJdwGNhZ1DeSn4ySBN0hMBX9inu7YY7GBLEpXRQ==
X-ME-Sender: <xms:LKkXZpw24cZr8hybxrPjLugC6qWjJdn-UCRw4AN29rd5fSg7weG9cQ>
    <xme:LKkXZpSEuuxoCPzJTw0vC6NB_UvfWhXBsYK3xLl6f19jcNkP1W82sCU2suOHzg0Ft
    8GPk8zBRDKsUXr7QQ>
X-ME-Received: <xmr:LKkXZjXDV-aysU254wZGvfTHibhSP9k-Hws9hpu5K8efI0HpvHPVcujs8KbL4yqpUMk9wk2tssTy3mKb4xrjQ-nDvU3RlwfatvB9Zo1UMz67iCAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:LKkXZrgnfxzy2nvCaKOQ9r4r7DgEkjYpDRdUbstm9RXezNXl7HVniQ>
    <xmx:LKkXZrD9tskHeNfHlUKEpcfJ-_Ks9qVcvsblY84rbL4avhETgjcEWg>
    <xmx:LKkXZkLA_EndXbas7QDOyLoivHmtEVOU94D61FgN5PrHJTLqrYB-zg>
    <xmx:LKkXZqC5zoDfKifJZA7FcDenHo7NqnEkIQnBmVUyfFDHad4LGRl3IA>
    <xmx:LKkXZtBb3hUDi60JzxWedaU7R4f19eEGFlXtMKJVzZNifGupCzR1zdWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 05:11:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9604cf71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 09:10:55 +0000 (UTC)
Date: Thu, 11 Apr 2024 11:11:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 12/13] t0610: fix non-portable variable assignment
Message-ID: <cf4ee9c427b45491b191fa1d4bc06cdd7844467b.1712825204.git.ps@pks.im>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712825204.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C6RitZ9mXvZAQ/r7"
Content-Disposition: inline
In-Reply-To: <cover.1712825204.git.ps@pks.im>


--C6RitZ9mXvZAQ/r7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Older versions of the Dash shell fail to parse `local var=3Dval`
assignments in some cases when `val` is unquoted. Such failures can be
observed e.g. with Ubuntu 20.04 and older, which has a Dash version that
still has this bug.

Such an assignment has been introduced in t0610. The issue wasn't
detected for a while because this test used to only run when the
GIT_TEST_DEFAULT_REF_FORMAT environment variable was set to "reftable".
We have dropped that requirement now though, meaning that it runs
unconditionally, including on jobs which use such older versions of
Ubuntu.

We have worked around such issues in the past, e.g. in ebee5580ca
(parallel-checkout: avoid dash local bug in tests, 2021-06-06), by
quoting the `val` side. Apply the same fix to t0610.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index fd0ddb96ae..b6e67724ce 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -78,9 +78,9 @@ test_expect_success 'init: reinitializing reftable with f=
iles backend fails' '
 '
=20
 test_expect_perms () {
-	local perms=3D"$1"
-	local file=3D"$2"
-	local actual=3D$(ls -l "$file") &&
+	local perms=3D"$1" &&
+	local file=3D"$2" &&
+	local actual=3D"$(ls -l "$file")" &&
=20
 	case "$actual" in
 	$perms*)
--=20
2.44.GIT


--C6RitZ9mXvZAQ/r7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXqSgACgkQVbJhu7ck
PpRSFw/7B3yfWuWXsHmi8ZpCore9OxtuoNjzzkBXyM9zUY6karZSI4YjPjitLoNa
a7EU8hK0JdLKlf3Wv5lD1AjGWkSU2hlaBJXBzSALHa2p0Nau+5LzH+X17XjebYsn
s01xVCtFLnFANGClhMxspn/lRtdYnxWibgrVC0LhPoPGg5s5pgPtM2K8hbtOL4u0
Velx6nmaNwxbn/6Lmd0qBVXeqNYpc6u7K0YlDyDs3tm9KOe3MIR9xxOqxxV7WKWZ
KFVAth/W/BqlXcY0O3Xte1h7DGFnqVgsYy+jIVNKiYq2UogGxdAiOLxhJ49gC+XT
j9nRwjZsqcpCYFif1F6Exh+obLasT3boS1r0+0g2S7MtguXWR2sMiEWQ1DJesM/N
4IPpT/xjthUHQ/2QUAmH+HmBbVRRQZjoCu/f6gW8MJgd2TDt7CWRYEptZ4jNMr76
My8cbDzrKRi8h8GL+Pz2WbzTK1LdBneT3UoXq/WSKWm9wDZMiqrqKUuOIQpAoO2I
IXn2CKNbjv1mZbkFSz5K8incOSqPIY2GxYXI/GCdTM4H0AjkI8D4iDIGB1WUU4nj
unh86RtHObkNiZ3wd8asn34C1LrY99R9gT3Lf5Qur4U9m3kpq+2oWceIuW//C24L
LAuiOveV/aOn0e86/r2ME0kwOzIvWf1Mmq0iaEaI5EPYkp+rS1Q=
=S9hT
-----END PGP SIGNATURE-----

--C6RitZ9mXvZAQ/r7--
