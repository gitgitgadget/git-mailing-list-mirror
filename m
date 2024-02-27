Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FA149DF6
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046433; cv=none; b=vBBNr11A6N6J/oD7uXLaJBYzSRADcyUQiDBvP8MIOpgvAXqBB98ZUu0wPrF/fINcLdr1d3F4T70tzjOth12g4GLkpNDdDICu0Bdj+CYTLyXG5EJfa7RDbNFUaQpoUYrIf5aU4IY0wSE9ZNPOKTRKxS99C4sylXLVTX9dVyxj/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046433; c=relaxed/simple;
	bh=OktEPnKBx7ZbzNth0zv9JV6n0MBuUSjKcoETOE7/xxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qitsSsaWFMBGGAnXnYhKmYWG4Nwhdbfn3PQfcuY1RN2KR4BwysEN+W/b/NBDH2GHRvLSWK++Hsk5ByxfyEzNg8WiTJuXELhwrtCp6Pgt83BI2NMD5tqiWOqtxoAVWYls1DATQe+Ze1aQcGhXc+0DvjFWyyB6+SxIl3k622saCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oEAdH7Qg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m2JHu7zP; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oEAdH7Qg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m2JHu7zP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 2C6823200B90;
	Tue, 27 Feb 2024 10:07:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Feb 2024 10:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046430; x=1709132830; bh=DVrWmMXGuC
	cpTMW+tHYF+EqntUr7mX4DD/lpAb/mE4I=; b=oEAdH7QgPn3XL2orW+f0WlFB8n
	TOC+Yzav3jF832e8O6cIPcY++iimX5bEaHC/sedh4qqvogGl4xKloOXsHlo7t30q
	XA7x23PMuT8OPN0AKCdSYuJR5gqPw8CfzdsPRNA6CkBJ96q8DbhhlMGl9K1cQO3/
	+rA4+fjFed3WJtnEnsORRWmxcZhSu9op3YVpFCA9zCzBWFd8VOAWh+wu8YaNyJ0r
	QlQLSEUs+CxwOc+1tIsQNuH1rcgWBc9fIp0f1Dh6sNxkD3l2c/wywrTB5qwz6CQM
	WRbhTIxo0wKDNcby6o4byfEUaTG1ER53EtD3ARjrq7+iFzUWKCFdB642/YjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046430; x=1709132830; bh=DVrWmMXGuCcpTMW+tHYF+EqntUr7
	mX4DD/lpAb/mE4I=; b=m2JHu7zPfo5l3ZBeNzM7jsu6grK/4Z0DmGcYWtcHYwgC
	MF4w/6asWYtFurcmlpKGFWbtzg+Xm+RZHxCOlVCodQdKAT5C9Brzyf1dafbg307D
	Kst0O20/D97swRYJ3xDVInUAQFT9K0YCVwizdgc8DiNb+WlG5qQrjyDWBJAdwCtc
	4+t7mJB/WxDxaj4ywxUjTEypks6jAj7NFLAHvgeL/g1dVqETIPntJr3QmPAsnQ5I
	9u7KR4E6DtOV0U1eF4z+hN+QsJtvXol1p6m8wHZhOzf0jhhnI+VEsBS71QRNRyVr
	Z53Bzg39lKc52evcKGwaw0Ys6Ogw63vaqHQSAbcHww==
X-ME-Sender: <xms:nvrdZcHuhObCyeLBs-M2ieYlOm9KK21w04u1dN0S-qDSkzOMky0-Pg>
    <xme:nvrdZVUq_VQkYcV_siCb4dSUHw2gC3Wik7sViws7J0439WCXKde4LjE5rn6WTdsyX
    nF0QGJIeRV_BvYvDw>
X-ME-Received: <xmr:nvrdZWK8j1deSFBnYSBlPEmE_JxOr3DLC6xkbOxHjxZQqG4ZIEi_SUff4CS0kgyP7bol2KpuJd_YOoffvuz4U9urEgcDOSf3k6_K9xTfC9YKG8pr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:nvrdZeGtrlYRyOxBA_Ilhk5Ms3Eoo1-5p8vD7BruYDGukKPax12bYw>
    <xmx:nvrdZSXzR37grulABs4p8PTEuUjq_9qfMcc6-h1nLJLZFaLfBpLblA>
    <xmx:nvrdZRNhGCbYYn5vtwuV19tjCO1Swqj9NGujH57OmOn2ezrxvMfxww>
    <xmx:nvrdZVc0X6amTnhT4Ut9Adqr76DhC3Qg-QHI4yXw4Nd4plg2UlSowg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:07:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ad171441 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:52 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:07:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 13/13] refs/reftable: precompute prefix length
Message-ID: <627bd1f5f784a2a34d7dabf95c3adf279c3a81a9.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tJdeVw4Vm+TFzb8h"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--tJdeVw4Vm+TFzb8h
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
index a14f2ad7f4..4d27fdde54 100644
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
 	base_ref_iterator_init(&iter->base, &reftable_ref_iterator_vtable, 1);
 	iter->prefix =3D prefix;
+	iter->prefix_len =3D prefix ? strlen(prefix) : 0;
 	iter->base.oid =3D &iter->oid;
 	iter->flags =3D flags;
 	iter->refs =3D refs;
--=20
2.44.0


--tJdeVw4Vm+TFzb8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+poACgkQVbJhu7ck
PpRR7A//SrlB0ZjlqUrsaKCpdwR9LktkebQERMzK+VKZRX0h655FWlHsXZK9iPpL
kEdLOONLO3KnFZGuEzcNOIm93E49RN/8FKbyJAJOusNgYj7ggMJpjl0oeonV7lr3
MFO6MvEbwpBqCQMSjRgPv7J2CKI38h0WArRApptZs8/BBM58JBBdi3Ai3p++c9pP
olyLsDQU1rvjrfAfcli8V2K+lcTZA/oAADljr/c+m4MVP/5qQroiJ9rIOdvxNRlo
jirTEXJyASsaT5D58uuWSlfYJ/1x2t0fuX4BoSqqguVxu7MExUXOO8NAcWZSUOOL
BsTCS/iDyVoabqAxX+qn2LmUGxhBr9wChBVfHiOfy0nG8aDhqYALDM/Az4SP+5Ot
fBw6IDlANtkZczaq27IMVT+riFJsk8WRcrY06fEAXdMTYYUpRAqKeTj0RS85uKGL
k8OtHlzT8m5+XgnUoDpmK8WJXKW4CcS7ybkr3i6KF82tU7bA/blPIofbc3vyAtc6
5fDOFw9dyNf5OntS3JtmZKtJM2bapWijmGYJvL3O1o5LcWWAKytLlRC7ACAJlCP7
6V6YROrngQmHiquGqKkZYdz7x4Nhf+OuzGWBLBdNfUXt2tFJVsfihUTjW/IsIecy
FImZGv3/h/z/PszjgVFxPABkqv93UEXdKyEUQ3YkmGBCYLhv9Lk=
=kAT7
-----END PGP SIGNATURE-----

--tJdeVw4Vm+TFzb8h--
