Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF3182F11
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361444; cv=none; b=P7H5cWhjKUhtaJebrVtzx34iVVqfpgQlSfNLLjpVqMyOIkaeS+BiZscXIgWUxKdqrEYvwEZYfGPrCxpYYgVLUaXOJk5ONrsUNAyUUWN+kCzeEqYDR075ByPsE/A/eueVgURPyGkECGLpKYf7nKJX5nc/dMi2n375f9B/gpbKXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361444; c=relaxed/simple;
	bh=4Vf1P6CPjMDSpVwDibKZmpg4BOBTrngWUSo7U5uVZbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoGovdOpeSE7fmg13Vse95Q3EEApX8nd4o6J4I/azbd9cNFe0DgOYXiLe6hVtWGgE5J9idic+3vidupdjyx2ulsSFU3QTvnMSEFAgrcZyo/zCnK2PnlmX0KzOUvyWvUGUIy7r/vPKn90wQmbF7S2JX3Co482iPTuL8kDAB6QU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SUJKNzte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qfUPcckD; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SUJKNzte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qfUPcckD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DCDDD1380117;
	Mon, 25 Mar 2024 06:10:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361441; x=1711447841; bh=4rfdMfjyHS
	WxEGTVfQ3kYteq4R+tmXdiE9P8vFJeizA=; b=SUJKNzteiM05SlQ3H0axS54JS/
	KvUWrscD/EjXLYrT2iK2tvClRB/+5lvQaL1ivK55Hp12oeKnwka80CyG2dsyazU6
	L83tUowJSwBBH6SRPk/AteChBy8Oy6t3iS7ybHM9FFXQllkwa3KipN9UIm0U6i7k
	cNyWywqs98cornzAax5gvarzOFQbvfFxbyR4bg9eEx1TEOS6m50XzIpjqjWr046H
	+kenLrBiUqrt+oZJ0gijjjGq8l8WMAwc+zvEYP6qMMG8kz5BPFW1t4i2znPCvgYH
	K+ZBDA4tvO696oCI8cBP6W7LnO+b7TXDTW5jyzPU7mC/3mQOhXCfe8oKzBZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361441; x=1711447841; bh=4rfdMfjyHSWxEGTVfQ3kYteq4R+t
	mXdiE9P8vFJeizA=; b=qfUPcckDZ8uudAAhge+LVPP71v7qaqeafqN8dtw7EP3T
	iLLI2KBFGzY9zCXRESK8YGJZFBYnAkuUtMABGlL4Y+ms6z+Lfj3FfB8wg80WUAFr
	pWe12ROozvYvUc1/eexJBWpFxPYeErRHx+UQdOCCqC5v9we59h/RyWN8BTAy6xsB
	/0MiWOYpto64s2Rc1kAhjYEkofXNS7BO3R7LgMUf6Khj49Xk/vwYguv/4AjrvRTT
	0reivgvoFnxdHgLylKzOc0uhBjI4kjnm2EVTo6jtSfS/jWuYxkM9xZACBwD8Qpzq
	GAqN9mXPeAMGNEeuH/rlng6RWseSmsqj8P1Yo42VYA==
X-ME-Sender: <xms:oU0BZtimuE4I67PIpc8MKGVFM0d_5_wzSE5eeI_ONo6uyoyCMN64QQ>
    <xme:oU0BZiA2m9F3-RlsNpxcitg2uhSAVODC7-R5yXdMngrzMHubHsrygeX6L7VoH_pM-
    5FUuy7kKT95Y1aFpw>
X-ME-Received: <xmr:oU0BZtEjl05P4m1w1aiMedJ9o-oqX1vwGQiz8oi9nuHgcGunsYVx1v4ldmzulFRhsoETWgO3QvTg9P-zOUXpfWkxhEsHVghSce0R-usWoWaNww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:oU0BZiRyF8iVofghHRsUW4EZjFMP2lE4D_QH8hKtzDXsDMJPx21eoA>
    <xmx:oU0BZqy1--9BIEEOZOWnVJoBcP6qXkvc8PA97okqXIOgI0n0x9wZIQ>
    <xmx:oU0BZo5-23bRDHvyJ1Xam7qOY9yOW5pQpKgXD54MYN9Yw-VJY3876A>
    <xmx:oU0BZvwHrhAgSAHfJ0Hu4NDkWfDaayJ9BiaPrBMJZn1nNEBItY2F-Q>
    <xmx:oU0BZu_nEwjiagZ0LHRXV9gWNx-hAZ274vZQVp1SMu6ZyZPWp4Xnwg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 31923232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:30 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/7] reftable/refname: refactor binary search over refnames
Message-ID: <9ffcf45c32f22245c9978436affcefa914fc6927.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o/sjcYcywn+CaBp1"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--o/sjcYcywn+CaBp1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is comparatively hard to understand how exactly the binary search
over refnames works given that the function and variable names are not
exactly easy to grasp. Rename them to make this more obvious. This
should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/refname.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/reftable/refname.c b/reftable/refname.c
index 64eba1b886..9ec488d727 100644
--- a/reftable/refname.c
+++ b/reftable/refname.c
@@ -12,15 +12,15 @@
 #include "refname.h"
 #include "reftable-iterator.h"
=20
-struct find_arg {
-	char **names;
-	const char *want;
+struct refname_needle_lesseq_args {
+	char **haystack;
+	const char *needle;
 };
=20
-static int find_name(size_t k, void *arg)
+static int refname_needle_lesseq(size_t k, void *arg)
 {
-	struct find_arg *f_arg =3D arg;
-	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
+	struct refname_needle_lesseq_args *f_arg =3D arg;
+	return strcmp(f_arg->needle, f_arg->haystack[k]) <=3D 0;
 }
=20
 static int modification_has_ref(struct modification *mod, const char *name)
@@ -29,21 +29,21 @@ static int modification_has_ref(struct modification *mo=
d, const char *name)
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D name,
+		struct refname_needle_lesseq_args arg =3D {
+			.haystack =3D mod->add,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
 		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
 			return 0;
 	}
=20
 	if (mod->del_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->del,
-			.want =3D name,
+		struct refname_needle_lesseq_args arg =3D {
+			.haystack =3D mod->del,
+			.needle =3D name,
 		};
-		size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
 		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
 			return 1;
 	}
@@ -71,11 +71,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 	int err =3D 0;
=20
 	if (mod->add_len > 0) {
-		struct find_arg arg =3D {
-			.names =3D mod->add,
-			.want =3D prefix,
+		struct refname_needle_lesseq_args arg =3D {
+			.haystack =3D mod->add,
+			.needle =3D prefix,
 		};
-		size_t idx =3D binsearch(mod->add_len, find_name, &arg);
+		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &arg);
 		if (idx < mod->add_len &&
 		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
 			goto done;
@@ -90,11 +90,11 @@ static int modification_has_ref_with_prefix(struct modi=
fication *mod,
 			goto done;
=20
 		if (mod->del_len > 0) {
-			struct find_arg arg =3D {
-				.names =3D mod->del,
-				.want =3D ref.refname,
+			struct refname_needle_lesseq_args arg =3D {
+				.haystack =3D mod->del,
+				.needle =3D ref.refname,
 			};
-			size_t idx =3D binsearch(mod->del_len, find_name, &arg);
+			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg);
 			if (idx < mod->del_len &&
 			    !strcmp(ref.refname, mod->del[idx]))
 				continue;
--=20
2.44.GIT


--o/sjcYcywn+CaBp1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTZ0ACgkQVbJhu7ck
PpQbXw//RXfk/dVfmByABDmeZar4vSbkdqgmE45X7Iq0C62cc0GFKVlssOoMO8Bw
hiY30GiZgtQIK92neGw8LMYvLw8GwYgawT50L+mI5+i9VTSvcxknuC+FoxCtG0YF
J2UywFyBkTtCrbPB0p+Q0KcTEVBXXLRm7Girn3/ydr9jvAv/bZI3yN1WbsBIT23L
nviT104TSA9QKoeRw1EA5gHsjgcEreUkckzROdn2KW8zaZA0ZUPc+CtsWoDrN9Nq
0+2u2BEakrjOiJyEXURLJE+/cFZXZ+ytnX95VwkA+agr7vl5zjULSLAcjyOsY9Yg
jWavTjSsJaXzxej3l+mVB06ZCe+Pi9rtGOJRxY4kZEzAUkgPfKOcgBzJqI8uFdKr
kdFI8gOBehmg+zswaTyvPIF9JSlP+yRiVVvr22LNMCVTwvj+JHJH4Af/sELXxdT/
cvlyY/X74k46Fq8NaKGoqJQkk3DpxqiqJneZtI1I/0PZ/mwfTtlmBLk0x9Y42kGk
DSAooiRdigio4lcjXk+mGmtfBCMxE4jIcgu2fCYqyhvcy5JVoPpyZQ5oTKRDjoYY
iJlLznfge/rvjZ84x8EJtYQ27s3D77t0CoJSPB0/bFXXYlax5aM2O6oO1pTMMKfe
cTU+6scNWtavdli1CDPkDkxmWaZHk9GzNme+QRBS+fYdDoN81u0=
=ZFZJ
-----END PGP SIGNATURE-----

--o/sjcYcywn+CaBp1--
