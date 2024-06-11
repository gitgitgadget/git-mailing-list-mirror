Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8A175548
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718095336; cv=none; b=VHbWejBhVyBn/7Upk9X1CGyOSRvGS4u0bR4NRTPUnMOBSi7CDwxIJZPscgCbCOG4dmB2sduw/qGun0SmzvaFEAct1OumSv6JRFNnP2nsKKzoyyujX6mzxaqZLmTLD7GADHQZoLg/eH4hGVKgVNTuwzDR6zmi4+24REXg85NOdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718095336; c=relaxed/simple;
	bh=d5y/Xr+S033Gm21xOaDeJGKqMjDzpdvygaAIkhjez+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHWo89R3JfNYf04+pveBtbXVltHEwQewWzcJF5IvVyjWXCtZLOZB5iAMZNSm0jMg6/WjPSbQkkL71HWAHB5ZPlMDnx7wKrWb6mwC/pdGVYKjNRIe8jc3W/Cu2omHTPz+sWY7008mUY2cLK9keJxy3tgsB/9OFmtQLEWerkiZpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OsmIn6ce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zuy51Of5; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OsmIn6ce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zuy51Of5"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7CBE51800079;
	Tue, 11 Jun 2024 04:42:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 04:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718095333; x=1718181733; bh=YZioig+mQC
	o3CJiF/pMqrDgAOtQoEXmlA6Hg6GSEnY4=; b=OsmIn6ceubspkGYjHelSuMNXsU
	EfHJEAHin9NN3Uujh6RWfp78GlbzvOz8pYwbCCoityPMGdmafwWzKlVN88Nj3F6K
	OIBijLZeU0MJdlBKkLTUw+FbNRXCxxJRafzTDhFSj3kCUrCm+S51HqaU7419/FBO
	3BDv+9+cBp6HQepMBqJ6coAV0bcpgVx511J8qTQtXcZzSwrdZPTgMSNClkfo3oSf
	M6QQxFwW86TeoJQww4qDjLWZDfXUdKbBSVqm5hbtGK2ksVnS6qwJfOUBykuCciUF
	3nTy+QQtMVaXTRRZaVt83WB5whV4t/hqRgpa11A9VZVvMr7L9JGA91BEI03w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718095333; x=1718181733; bh=YZioig+mQCo3CJiF/pMqrDgAOtQo
	EXmlA6Hg6GSEnY4=; b=Zuy51Of5OnsmEdo4aNsofxFyP9eL3J4+JhGRtEvrCzYH
	35yhtBczaqTMh80TbPV/c+mzrKyVcj/FkXQmtasvhjFVNx50QLE1uRDRpn/KYz0T
	5guKAIeXb19noPQr2fuUCW4XLjKJsscEg/rdei3B3Hym5TeUbgp16xeJof305JyY
	w9MPXOXLRxugZogisE2Ddgx1eqiZXs7kfGPAWztd3OtnOEudkJNxY1CFcNac5v4l
	IW8iv3Who5LtQGloLXn6jpfOJg5fKuEpOrGRngRTT+xd/J9VEXmn1vF8a2NmQ9fN
	9xZU7xAXmj6lNojbvzHLJJsTYuoFeKQnIARyTBCTgQ==
X-ME-Sender: <xms:5A1oZuOJ93-eNL_5SQA_px5KwkvI70dji6HHfkrWXTpEl3F0tQDwCA>
    <xme:5A1oZs_DgSH8SpgYh3Zvv-emfZRSBNhSyOFjFoN8YHAZRg5a7ro_0kEq0Hg85L0iD
    BRcQVecvpffx0Fasg>
X-ME-Received: <xmr:5A1oZlSxYNbWCvkclzGT-Ox_nK4GTlbjTuxd4mdKuA3Z3Fb2RBZEPfZb3YMVLY5P3ZGzt9-cMlPfwiZZwnvUzIE_O0GtT9dpsd09zP_htbEweC7dI2a3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5Q1oZutk0LxSBwPXRrCqb7V4bBqspweU4PEJqNTL9ufZ_z4vY88XjQ>
    <xmx:5Q1oZmfeTa5Hsm6AT56p5CvFX1KqnGRfHdsGH3TRfGTg_KiNZsJKkA>
    <xmx:5Q1oZi3Y0gYjE6Ffh0NJpTIDYyhmlYkwGH_MdT_ORrHqaVczhFlKng>
    <xmx:5Q1oZq8KGBhxMkDYxfozskiYYIpszQmcUZh89j-wQ9Itfkrx5I96gA>
    <xmx:5Q1oZm42m-wJyeBwtJbAyB096bKmtinPXWiiLBBeiaSx0uCN-SPFfRO7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 04:42:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ffc4e333 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 08:42:03 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:42:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] object-name: don't try to abbreviate to lengths greater
 than hexsz
Message-ID: <31c0405f85552b6f30468607b7a210d5961ea416.1718095090.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XJwn9eBPl5yVAQ+a"
Content-Disposition: inline
In-Reply-To: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>


--XJwn9eBPl5yVAQ+a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When given a length that equals the current hash algorithm's hex size,
then `repo_find_unique_abbrev_r()` exits early without trying to find an
abbreviation. This is only sensible because there is nothing to
abbreviate in the first place, so searching through objects to find a
unique prefix would be a waste of compute.

What we don't handle though is the case where the user passes a length
greater than the hash length. This is fine in practice as we still
compute the correct result. But at the very least, this is a waste of
resources as we try to abbreviate a value that cannot be abbreviated,
which causes us to hit the object database.

Start to explicitly handle values larger than hexsz to avoid this
performance penalty, which leads to a measureable speedup. The following
benchmark has been executed in linux.git:

  Benchmark 1: git -c core.abbrev=3D9000 log --abbrev-commit (revision =3D =
HEAD~)
    Time (mean =C2=B1 =CF=83):     12.812 s =C2=B1  0.040 s    [User: 12.22=
5 s, System: 0.554 s]
    Range (min =E2=80=A6 max):   12.723 s =E2=80=A6 12.857 s    10 runs

  Benchmark 2: git -c core.abbrev=3D9000 log --abbrev-commit (revision =3D =
HEAD)
    Time (mean =C2=B1 =CF=83):     11.095 s =C2=B1  0.029 s    [User: 10.54=
6 s, System: 0.521 s]
    Range (min =E2=80=A6 max):   11.037 s =E2=80=A6 11.122 s    10 runs

  Summary
    git -c core.abbrev=3D9000 log --abbrev-commit HEAD (revision =3D HEAD) =
ran
      1.15 =C2=B1 0.00 times faster than git -c core.abbrev=3D9000 log --ab=
brev-commit HEAD (revision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 523af6f64f..1be2ad1a16 100644
--- a/object-name.c
+++ b/object-name.c
@@ -837,7 +837,7 @@ int repo_find_unique_abbrev_r(struct repository *r, cha=
r *hex,
 	}
=20
 	oid_to_hex_r(hex, oid);
-	if (len =3D=3D hexsz || !len)
+	if (len >=3D hexsz || !len)
 		return hexsz;
=20
 	mad.repo =3D r;
--=20
2.45.2.436.gcd77e87115.dirty


--XJwn9eBPl5yVAQ+a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoDeEACgkQVbJhu7ck
PpQCwQ/+NVCDD4LqKst7T1L/stKyFtxFm0zEZkrDqWNZe92Si6B/h4R4Y3qacqtM
iZs+ep5NvchiAV9jgPks0OYVA5LFZDyJGwZxJ31FSN+jR7Elc4U9rFTJ2yAsWTar
/UxA1tNP33G/M9h8rknQTCVtgOY8vaBX0LERmcCUaAEDeDbsQgH901T3SdDQKemt
/YgAPDKm5E6bk1tmsHT1JqfZKhLC0mk2F+jJZ/wowLraGBxALp+QyMalfYINHTmO
Rl8OaG6oWO0GXmOHVnne/wYeDN149WYpFbNSXazKAk3ncfi1UWYhZBCnFas5WX9W
RCWLAc37bTlzIk/Ug+vVlrMFaouu2KEF+J14nvLm5e/vdBn/FPVGrkRfEDrt06cw
g8+zfdF7AvHCLuyVNEJ5XOgvSB6IVZ9mdAtft+qmZ05h/YD9oYtmHHVED1V/HNji
dhhDmEYXB5A7cRztZTHksQ+wrP/KMJSzzhFMJY1hgJWaXtblToAwQYJ3g+qDqzLK
+8DRA6OWteFgfCHJ4pj9hiejkIRQnRSVJ1yJnRDU8Ani8OL1gQfwOTyNxTaNNmfq
6aMynospcu2aoqig4b9kQJNX90O/64fk/3A8GYi60NYE5SeDfWpog71FGgUiry0p
0RMZSWG+xe74YetaKQXySOIZ19L4aNah5HvntBLJoeTsAGaHVqo=
=5Rjc
-----END PGP SIGNATURE-----

--XJwn9eBPl5yVAQ+a--
