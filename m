Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1AB1514DB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742805; cv=none; b=rLs8lUFoLwZSgLW0sE+BoKsplEcE/zpF0JtmSeXQIo9tNKrKmuTlqAkirXy0lbJwYOWjHz/6mavNCSzAc6Uheor3xQI2JeXEtZpq5TUUhqh1SE0s1rRvsBVJlAxX+/PSxBsIbzuEdb/OfbP8Bz+drDwLvi6zOeay6pt4sphAP7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742805; c=relaxed/simple;
	bh=SJjSif4ka3maRNXxihYMAq4pUCWFXuEuF4l8kjdYOyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzouLxJdETSRK1Dx8MUKrsfi7v7XO2bNaLM9QpLZJ/BOgXkdpat1kbb+F/PyXhA8m8tGguBYymCayHgCI6ozpX+SecPWEa52Aih0/SUYwdUp/Uru40zrT0VT3iIe9qc6q3yJ/NbfuLU/WI2vivb9FRduCq1HqjrwcXLgfLeAlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NHALjx2i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6Nd0ghi; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NHALjx2i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6Nd0ghi"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C7CB81140223;
	Fri,  7 Jun 2024 02:46:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 07 Jun 2024 02:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742802; x=1717829202; bh=zw/ujqq+eq
	gv54VlnGCI4r80AdycRyfdH8R+Jhrx+l8=; b=NHALjx2ij95nCytqXbgJ5XEqEz
	Ub4IoVP2HJH6ErQ677PAXpRiN2OCMJ9z3imCINUWwws1DOPDv+0sSexV3/FoDtWP
	6BZFZQCu8o/2ARL6LpJRhyRxsQhlF4ve0X5F9h95OgNS6UAXj3RKe/enxMPYHA4S
	QuA3ImcbyeJA4TfdUkbPtaNzcivf0LU4xfcl3cWeBwoH9Y3XPt+JdULqCJBR/Cxx
	2ZsT90JvIpqmjBUp7WfEOkCiVIO0sIxM+I1gR0riSov5OxsI3KzScKkM9Z8FrgFX
	BGdBeAdroM9Sz5i3262hEW2eRdzi5B88ztUIZlj9CwNsShYlDwCILmHfMrRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742802; x=1717829202; bh=zw/ujqq+eqgv54VlnGCI4r80Adyc
	RyfdH8R+Jhrx+l8=; b=h6Nd0ghiy9A5mZ/xVxs+BYYz17OMIE9CLa4N0zEPRcnM
	QIRWIji47fY9QdPRgwiePatVbslTaCSw2DzrJJ00G7FYtCxCp4BGTMhUnlnP7iTU
	a0Afr92E7wTTW7KTYzYuKIra+HQ2MogKDhI6RgjfTSlf7585Hy+eXrZgzZlVtW/+
	TkJ/JQteO6+mmhf80s7VyAzAsXKerrg/lSZKEG7AYiGvMQMcJlV0ETiZqVLNQcXz
	yWvn0uf+ZWxeSLiSKKKj7CJJpY3TjCpJHKizkmEJ+VCQggRy6NexQrbSVxpv/izV
	+f48vF+Jh6v+2r6QtHBrUtiFZfW/OWa9JRQt93Rb1Q==
X-ME-Sender: <xms:0qxiZlQHHkoxABQA1Q_J_y-WOGeGuCUL1UwPvGBoQVGnxKnBQR-Ebg>
    <xme:0qxiZuyyxGou5b5iJd7TdU9Eo6eQoI5Gjx2644LJsFsSGe9-ueOb6yFMGIJEeHTQv
    7QwpM3jj6x50ddr7w>
X-ME-Received: <xmr:0qxiZq2OcL-srgrdKUL0fIigCOotXvt9y7ogLUilQLZrtAr7wPGAiGBtogo8phrIxnot-cHTmmce28aefr2aPG5cJldQadzDysl3hz-gQM_08xpK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:0qxiZtCZe3UBzTquOA505q-yDi4VdAikisi9xJBhwkTIL7bG9iucYQ>
    <xmx:0qxiZugh1XlWEWtHuIDq3COtLicoXkH979nYTgnoLZJhbn3E-nrWEQ>
    <xmx:0qxiZhp8_E5wAgrK7UVNMYYn3xhhOWhlWeJl_XeGG6x0xSpiHm-Qsw>
    <xmx:0qxiZpjEld87J-SZSiDK5lllescxJWUcHbHsQvMDng3fJwxlk5vP2A>
    <xmx:0qxiZvuKCvtodK6CQOTtFDZ_tzf6z0Hea3Apv9ToYKwVbvuCfFb-DhCf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:46:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 919b8372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:46:40 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:46:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/4] ci: compile code with V=1
Message-ID: <a3dfb7092a4aeb09cd9863e3e9ced2b4685f8576.1717742752.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OtDNITS3LNt5GHOH"
Content-Disposition: inline
In-Reply-To: <cover.1717742752.git.ps@pks.im>


--OtDNITS3LNt5GHOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's hard to see which compiler flags our CI uses because we do not
compile with `V=3D1`, and thus we only see beautified output. This
information can be important at times though and may help developers to
see what's going on in a CI job. Furthermore, both GitLab and GitHub
have sections in their output such that the build output can be neatly
hidden away, so it doesn't clutter the output, either.

Compile code with `V=3D1` to improve debuggability.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 98dda42045..2aaaf40f94 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -48,7 +48,7 @@ pedantic)
 	;;
 esac
=20
-group Build make
+group Build make V=3D1
 if test -n "$run_tests"
 then
 	group "Run tests" make test ||
--=20
2.45.2.436.gcd77e87115.dirty


--OtDNITS3LNt5GHOH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZirM0ACgkQVbJhu7ck
PpQKJA//Qq/UXEgynRSpJekUFKnWY04sqiAk0fUzgwQhyHQZZwGlEFUf+CRGfoUJ
NI5mfSwszx7xqi2zwsDl0fgZVlr5B0lev+u3fKtHP65OyBIKJvgdaHr7ZLVaCvlT
HmQI49UGS+8Dfypg1PL/TCRflUd4/M+LYVQF3tc/dLAio41AQieTMmUYDvk5MgCc
H2e6eNdSQUfdHiLiWpF5bDDJAFaurlmu4ZGOsJqGEu4HghjmeWdiNHnst+NT5W39
0vf8cjDu22NmKcG6/gnrN2Qnmuercf1GNjLTwE8zOJOGGr09pR3m0f0XHP0jYrh3
M+ph7vzAoD2gFLf4huI1Nwl5CWKfmDgVXjExtaC6+/75SCamF085xnB1VP6YiArB
DQkpNz/qR9mMeViVrOZzt24ll4xmy1mKdZW2Oiub01zkMigRUaoHx5YwH9mrTuZ/
nFfz5HHEPcPKJ3MRBRfJ8uXi/+YLF9cXm3RjIiy9KDwEuUzixsOmezLKQSVVdnq8
W6OrC9qvXzXLfc6YiWvq6UFzdSQ84/PwTZjgHGuWimF5u5BuxmPEt9ol0ojufRVX
2n8ZwH0uoR+WVf302ap9+hmBWzKQye1jL/kxqsbI2nYRWN6SjlNj+P6pfDfJjm/s
qWBws76GngpiArMuTfmh0nFlDw0b2fdrSEICCAbVovr/Evh1u+o=
=EkZ1
-----END PGP SIGNATURE-----

--OtDNITS3LNt5GHOH--
