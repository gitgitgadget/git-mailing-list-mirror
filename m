Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1483CC9
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028852; cv=none; b=e9kwl7zOCSdwmgPgkFkoX8sTACaEkJvNxVhuw3wH44b4D0iPPLERjxdDQZW0FwVfOyD28V6zTCDNGVOaDYDbnKSq1I7LUpD0HUt43L+ROjUATK78lWTQpicdx/+uwxz8aKfnPAnshRvAFo0UOOf8nrJH4j9JLFKnFT9t1tKIexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028852; c=relaxed/simple;
	bh=Ja+fUEYIcnNAcKT0bw9zoqjAdYezdx7fy4IFDbLPvqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnQtzy7wEeATd5N3bYMn8kbQHodX/cGP3GbVDRw0GroKULHLmHgFt2I+zWwuo+PuOcxuaD32dnTZ4VZhUiAtSVI6x/cxwEHiCfMgkWHz9qtKGVFHktRsWyiwKbfddsp+Y2rSs/vNgJYot0j6QhZQKB7M0wuL5E61CREdgzZS254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gZpzlV78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cx9aNH7F; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gZpzlV78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cx9aNH7F"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 85BDE18000C6;
	Thu, 21 Mar 2024 09:47:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 09:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711028849; x=1711115249; bh=5iz6zHOTTo
	dtxrSD745hwbdj8OlggqxuCMS6k3irRm4=; b=gZpzlV78tAqWelBM39fD+LO8HX
	JGItY6AGvSmrC5JKGKgK08n5gsvOKen/aXy3lS+Hk5NG8awa4jKZZZRXCdrku1GW
	WyeMHSB/5BDYkcPerQx2DFB0hMncOGzLkOe1oDjP0KJIXl5wQ6a9M98DsapqJWzO
	FhcROUShhLmbjddlxFjYnoGxmJvwEDJOMcT3SMGUjjhgoXSI5DuMPuQrPIOeIiqF
	BsyVm2CWNgzbFrM3/aDouzObFCwojhoAW+kuPJNVb9HeCmXXr5hQRfSq7HXxBN4f
	iyNJJO70Ujg6w3ApI8j2z1kOWK3/m01tGHswHpVnuRXthF6B9NxISjaoJ85A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711028849; x=1711115249; bh=5iz6zHOTTodtxrSD745hwbdj8Olg
	gqxuCMS6k3irRm4=; b=cx9aNH7FZqvzz83Y/D/FqQnmxDgYvFnaPhmsjg99M+wL
	58F/JKt4LzQtAG1+BjMJtj0sNhdHzJ7uBE4YpnhXaf+bw0oLm4pfnYFlh5i8x/ZV
	PjAEzsG5hs3yYHO3WYUhUHD2iGnYre7TQkCGLiDUexfHqkj8oVXYH+75V5z6PpTY
	bpY86Rh6bZCDJuDTetjLIM29kCy1dMQ6EaqxYN6qbkmirKvReEeo+CF/+GVk/j9N
	b8gXM8YIDhz9+KSvwTaUm4U1lgDYp2xHyayuZZ+keHl6QoOaJYn1kmBiWGkXISNZ
	BwE23souwDrLt3Yo50T7FtLGcziAZIvDv+eeVhnHBg==
X-ME-Sender: <xms:cDr8ZdwBapFRdVrpjdcWLynraxsVCE6q8yhabF0984CMNyMlDA2ihQ>
    <xme:cDr8ZdSOlO7I6R-KqyIG5sShP4bSAL8731Xt2MJJPxGHCnL6sND-69zXBBf8XaqBd
    5jTFp-ShY8rV9k79A>
X-ME-Received: <xmr:cDr8ZXWgY4i621nNfC_L9AWi6i7eK0vCe3m0BN8NN8pdxbzfV4SFp1VEkVaVshjOCyKUkpw_MwVrtTZXFlCnSAP5Z-KlZ16PNRzPXZyCvLuDxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cDr8ZfjbUzt2X_Y3IVqJenglrU6MV3lvuVFnthK3xNhSexc8EiViZw>
    <xmx:cDr8ZfA8Oa-knYGO4DIHHiAwFv4mDF4vezW7U1g2rx6JVf44kOpzEA>
    <xmx:cDr8ZYIuRdarchCyFwR-FA1R2VDOcY-ScSS9kaJHulXooFmQMC-t3g>
    <xmx:cDr8ZeAqs3En5BSeguKl0aM_TjR4RH7xn_qwfGov7wKE_0hvCTuQog>
    <xmx:cTr8Za81C5fv5rEmPR_rZ8PCfAW9-FHbb3daH9C60fPWDdE-kx6WLlsNmp0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:47:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 87354bc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:47:23 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:47:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t7800: improve test descriptions with empty arguments
Message-ID: <fd37c2931904bc64fb6ea14331aea60278f495eb.1711028473.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FqT1J1fm3Hi8Byk6"
Content-Disposition: inline
In-Reply-To: <cover.1711028473.git.ps@pks.im>


--FqT1J1fm3Hi8Byk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t7800 are executed repeatedly in a loop with
different arguments. To distinguish these tests, the value of that
variable is rendered into the test title. But given that one of the
values is the empty string, it results in a somewhat awkward test name:

    difftool  ignores exit code

Improve this by printing "without options" in case the value is empty.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7800-difftool.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 96ae5d5880..80bf108f54 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -93,40 +93,40 @@ test_expect_success 'difftool forwards arguments to dif=
f' '
=20
 for opt in '' '--dir-diff'
 do
-	test_expect_success "difftool ${opt} ignores exit code" "
+	test_expect_success "difftool ${opt:-without options} ignores exit code" "
 		test_config difftool.error.cmd false &&
 		git difftool ${opt} -y -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} forwards exit code with --trust-exit=
-code" "
+	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code" "
 		test_config difftool.error.cmd false &&
 		test_must_fail git difftool ${opt} -y --trust-exit-code -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} forwards exit code with --trust-exit=
-code for built-ins" "
+	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code for built-ins" "
 		test_config difftool.vimdiff.path false &&
 		test_must_fail git difftool ${opt} -y --trust-exit-code -t vimdiff branch
 	"
=20
-	test_expect_success "difftool ${opt} honors difftool.trustExitCode =3D tr=
ue" "
+	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D true" "
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode true &&
 		test_must_fail git difftool ${opt} -y -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} honors difftool.trustExitCode =3D fa=
lse" "
+	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D false" "
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode false &&
 		git difftool ${opt} -y -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} ignores exit code with --no-trust-ex=
it-code" "
+	test_expect_success "difftool ${opt:-without options} ignores exit code w=
ith --no-trust-exit-code" "
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode true &&
 		git difftool ${opt} -y --no-trust-exit-code -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} stops on error with --trust-exit-cod=
e" "
+	test_expect_success "difftool ${opt:-without options} stops on error with=
 --trust-exit-code" "
 		test_when_finished 'rm -f for-diff .git/fail-right-file' &&
 		test_when_finished 'git reset -- for-diff' &&
 		write_script .git/fail-right-file <<-\EOF &&
@@ -140,7 +140,7 @@ do
 		test_line_count =3D 1 actual
 	"
=20
-	test_expect_success "difftool ${opt} honors exit status if command not fo=
und" "
+	test_expect_success "difftool ${opt:-without options} honors exit status =
if command not found" "
 		test_config difftool.nonexistent.cmd i-dont-exist &&
 		test_config difftool.trustExitCode false &&
 		if test "${opt}" =3D '--dir-diff'
--=20
2.44.0


--FqT1J1fm3Hi8Byk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8OmsACgkQVbJhu7ck
PpQyOw/+IDwcNrh12cdwTmfbcROL0ZsulNQ+WrmkoQGRffh3e0d9rrkidsOtBGKP
i9qDgjU5BGYMBEXT4YTJju6K9yuAghuUDUjLcHBRHbAlZENVBbiFId7FStJSnIkB
KkCEMAjLZU82BXbouoBQ30tlj34wXASV5y1ceBwR+Q1++qWKB20zOLSeqpiOsOjy
L+LPXat+X+wh28Ypp8ZH2i2Eeqeh4terQ5n8DClRnqqQByZtDqpIZ0HmBGRMGZhk
dA3ru8T7EOMcjGuUM7R3atdBdSxx0hdgO9J/w9IZG+Eu3Se+AWaK5BOw145pDlEK
f2bKTn90tu0be76Aj31qBXO7mbJuM9t/oJxGJxozy6pPJ0gich/4qvnJKApMIjCi
cjysclImD+73NBLC6FBSacx2YgsdOrcWb1Dk/4vN7Tae6b1hMdRGxOEZAC2dXSaq
UUxBlsNEXdp0dETIy/dWzg72J199zSS1KHtiM30fS6eMcgQPlSheG7h7QPow3pEm
xp1LMHDYSv6exipV4adTlcooSSGdK7hfq1+BVLPpwafQ6Hziu1kSCpTKpAFGxy9F
vwufB6hxgZi/PSr46bDmaqk2iOoFWk3BTuGnQqZqy8l40H9LpqllqVj0BU4A3w7M
a448q7pbDyc0ydLGSxyKLet5+tpC6WNyaFZvvNMA0GQHd0A/zbA=
=lYJR
-----END PGP SIGNATURE-----

--FqT1J1fm3Hi8Byk6--
