Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F639AC5
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549385; cv=none; b=WgorfiFiT1oSBI3JV2LnXDT9xygNlrk0HmFXQvlK0N1YzQFex8DknwuKjmNIXidMyWZv+vWV+Nh+5DcRy3CqeV/PMMbK5uvfiUliCgTZuzF6O/s3u1HeihJZJXCGCnzoDKhByXNHG9SKCvfSVdPNxz1YuzyIVWtnPYPgFhLCAjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549385; c=relaxed/simple;
	bh=VuTOlBoW6+nLMAMDcdh88HurEDIQ330ZYDvBquPnWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHGWgYTcxpgVCKwkZhZB9mPO0GDxBx4bUywD0XvCHdaK68DA8AB8eL3Jza79J6RZBLmghV/K7vKmcWr24h8adN0WLEgmnuqAPjlwPkL8Kj2jlKFvuY2/oykbJ4XnnGAJU9tktERJJIAEhxbHD+0yuKYxJT7tYDVwd+68emNfYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jbEy9NZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTih2vJU; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jbEy9NZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTih2vJU"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 312BA18000C9;
	Mon,  4 Mar 2024 05:49:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 05:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709549382; x=1709635782; bh=Bt8cI77Z7I
	fp+qqujXP1KNS0o625AI8DASHi7iVaGgc=; b=jbEy9NZ71U3/l7K1iUQBoLN9+V
	rL8VJh5YZk0mswOKxD/W6lBRnoxFl/UyCqvKNALKvM59nd6Que4iysv4RMKhqTcI
	xgECaQz2w07Ho8WVMguNzX5G0UQCHSqChme7bCefhZmaGcm0nDy1oWhbQksJ0cx1
	xMr6bwTet8smHQWhC5MHHPiqqLEZnQsjCe1XptDacc0QSXJQe4YN6l0EUSl6GCe+
	7zQo2SYLvUGTq50xu1akd+snggbFj+xU2vd1EWaOvg8TUujhkwxY8WQtE4mLrmJf
	ocMD5t40XH70xIFobx0Z6cnzoDrfMI5GFfq6U78s5EXaMMuFO6m9+CieOYfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709549382; x=1709635782; bh=Bt8cI77Z7Ifp+qqujXP1KNS0o625
	AI8DASHi7iVaGgc=; b=YTih2vJU5oEcQPRurL/AAdlGd773BcYlGKPf1TlPWE2p
	BEEF/1N7OU/+dFt0NJ7BbbswUMQwdZ4OBdrAyQ336a21MGFb6drutfr6cZTfimta
	zDWHtf52X6T4DNvkJ7fXYLHXnnJWdZZMDZgTT5BrAe4ZDyLqENlhvOknXrfncGoP
	8FTwEQdn7MLqQzfb46yMgFNWPvikzWEo1aj4L5ZQYzzYCx9+7cTWG37bXiwS2KTO
	Ri4XuoEhpoMs2F0Y2l79BhVmzHqKKH3sG4BKmLdxyfG9G3bznFXv+JtWmXc9r+nK
	nDruW62JuWMT4UZfE4McHiVRVpY4xaAVG76rS49+EA==
X-ME-Sender: <xms:RqflZYFPYVe3i-_jlsoPssJwsWD7XntZpLs0ux0kMoiL-EimdGLcRw>
    <xme:RqflZRXcvhJfB7363LetHhdgz4IObAT3tXXlU9Wl0pYDVBWaatAblopMqFb6CAvsc
    HJ28NFSCOyW1Ui1Qw>
X-ME-Received: <xmr:RqflZSLruoWZWCDJ30yeDHxTL3Ed_33hZHExfZKCDlZMECvEc_huFvoKGJ4Cau-D-UZrCZdPeRSWJsOTUlWuIU00VCRtkDGkMmIh44Mj4CLO5sM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:RqflZaEVEmTu-GLjQFY812-2FXWvxAotm-U076IJJ9T3XybfzGKUbg>
    <xmx:RqflZeWf0aWFGCUmTBGTEfcJoRqqV3fVLxbDgAOCdf2p8oiEu9CJEA>
    <xmx:RqflZdNu622jdK536gPF-v0KqlExIsgKl8clzTsME011hMJ_iWmIbg>
    <xmx:RqflZdS7VVyDylFTvzoH1WM5k2FSSOEiCiaM7LiZ6PVEgbqibR5LSWCJlx0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 05:49:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0ac9118 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 10:45:16 +0000 (UTC)
Date: Mon, 4 Mar 2024 11:49:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, James Liu <james@jamesliu.io>
Subject: [PATCH v3 13/13] refs/reftable: precompute prefix length
Message-ID: <de4a1e22396bae955d428251d475476885176fa8.1709548907.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709548907.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="61rsa6t9bDFRTrmz"
Content-Disposition: inline
In-Reply-To: <cover.1709548907.git.ps@pks.im>


--61rsa6t9bDFRTrmz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're recomputing the prefix length on every iteration of the ref
iterator. Precompute it for another speedup when iterating over 1
million refs:

    Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
      Time (mean =C2=B1 =CF=83):     100.3 ms =C2=B1   3.7 ms    [User: 97.=
3 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):    97.5 ms =E2=80=A6 139.7 ms    1000 runs

    Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
      Time (mean =C2=B1 =CF=83):      95.8 ms =C2=B1   3.4 ms    [User: 92.=
9 ms, System: 2.8 ms]
      Range (min =E2=80=A6 max):    93.0 ms =E2=80=A6 121.9 ms    1000 runs

    Summary
      show-ref: single matching ref (revision =3D HEAD) ran
        1.05 =C2=B1 0.05 times faster than show-ref: single matching ref (r=
evision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6c11c4a5e3..249a618b5a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -346,6 +346,7 @@ struct reftable_ref_iterator {
 	struct object_id oid;
=20
 	const char *prefix;
+	size_t prefix_len;
 	unsigned int flags;
 	int err;
 };
@@ -371,8 +372,8 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		if (!starts_with(iter->ref.refname, "refs/"))
 			continue;
=20
-		if (iter->prefix &&
-		    strncmp(iter->prefix, iter->ref.refname, strlen(iter->prefix))) {
+		if (iter->prefix_len &&
+		    strncmp(iter->prefix, iter->ref.refname, iter->prefix_len)) {
 			iter->err =3D 1;
 			break;
 		}
@@ -481,6 +482,7 @@ static struct reftable_ref_iterator *ref_iterator_for_s=
tack(struct reftable_ref_
 	iter =3D xcalloc(1, sizeof(*iter));
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable);
 	iter->prefix =3D prefix;
+	iter->prefix_len =3D prefix ? strlen(prefix) : 0;
 	iter->base.oid =3D &iter->oid;
 	iter->flags =3D flags;
 	iter->refs =3D refs;
--=20
2.44.0


--61rsa6t9bDFRTrmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlp0MACgkQVbJhu7ck
PpQgZhAAg9XO15K06fDusS4Rg5O8+2Lm3LMjDtuyXMu5ZcXPJnKj9LXfOLq52T+X
a6laHtQJRenmBUUIfOAs++wKCo2smkAxxD4sigBDIKDYGJWNuCiYvheMUtc6yT7u
EOOsKuwWHR2cuDeXxYm8Ez4IGLQj/RLKsBeJ0VE9+vsQ+i8UW9cEu/KI6B8oyasq
Kjmgw7DLQ66XqkLaZaFltJ2kQRqiQT5ZNR65Pf/uxXqfev8P5pzF+Ph3yyp4iH4n
yo8hO1S5vZtzX02syxK7H3Q55qp2COBcnid0kRiu2C8No+iPLKWvBdIP0lJjjFYl
rP3hUAN0Y97+NESmabZ0rh+JTbuU6GSNGLOvDR2m/pWB+QExMp2zg+/vggooN7RI
aZsatgyRaYygaqrv9iw9rUY6tK4qudFOFdcvrmJa/VaK2CyQByC4Y0TvEAQ+mhqJ
TDOVoBQAJg/nKdigFRRg8aXQOkhtPH1cIwTRGOWyG7NnTizbf9Htr8MYKRA1tJYS
EqKQK0xlJh8p9ajwFdbZJ+Td06mb2liikBP4L0bEOTAjL/40qeBjJqbn6YnzT6PJ
2LLMMeimKpvTK4ya60lhC+gE+ZafMGfZqs3/9Fk3MM/TndLLi2VkvM6InFfWaj6H
HKHf18yiGGzr6Ddp5B+zeQC8KXEbGYVmleMFXlMdVZBCNuft/7o=
=Dq4X
-----END PGP SIGNATURE-----

--61rsa6t9bDFRTrmz--
