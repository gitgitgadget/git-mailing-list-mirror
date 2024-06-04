Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B04146580
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504673; cv=none; b=kaOoPW8uvBv2BOclWiWxgbxWevOt8RB3R507m+wFnqrAh6T6QF7gAAOGHFO6L/FPsWxF+Gqv1OGsDzU4PVQZwU6bT9BW0NU66saigKqX0Tazxoh+veV4iZNvwE/DhoxAIn1+yssPYhGKkORUmwraXd6eqM/bp0kr4ub6t/gppUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504673; c=relaxed/simple;
	bh=x5WSYdDe5VUt5zDj0y0arR8V0Sh4ra8qwhXbWAzzuP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3EZfSKpJ7b3bQYWlOw+HIVj9Ms1h6Jhnyc58NfSDKQzD4mq8EzDdDsdVhTVSN4x3x3jVMl/e3gkseC9xNitWbsOMGaGSVQ+W/KhdwHLuGe54tKD4Cms3pxlay1jLwydD06nPY1vO48oZHJgFuSyZUTWNSxfKdLXeODBjCTcEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=brSCAD+q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3Luw6Jk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="brSCAD+q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3Luw6Jk"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 93B771140164;
	Tue,  4 Jun 2024 08:37:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Jun 2024 08:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504671; x=1717591071; bh=ErPO2QBPq7
	T/IwpxHgLp2fKlFiLf9RRI5A8agxpXOI0=; b=brSCAD+q9l9ruCsA907EwXqCdO
	0CRCrYRG55ciMIPrJ13cYJYM6Mj2l8zCY2DWNxYZVKtjcyrB0Ih0o3/wc/VOQ8ID
	ryN6sEFOJGjZdH72HMOnU1dVnoC8RqAoISiKXc3G3iHuldN+eqKJjtVWFiYjJF8X
	E1vu68lqKd3aQWkUWEGMho7nWiXwTK3fsSs8a0b1y+mlPYCWkVkwKWBnwm32NQdl
	e8k9gpZwGO+9CQVpVdb9OHB9H1lgL2eVFAXVtLP0qQMedmOkVV3hV4dgG6LhXtBP
	YtNeOpCbdvrw2BpCVlS9cKXGSsReTeKYezs3oMMifiJ70RtjfSJBQ6kRY2Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504671; x=1717591071; bh=ErPO2QBPq7T/IwpxHgLp2fKlFiLf
	9RRI5A8agxpXOI0=; b=H3Luw6JkwPfz6Ra3ZbmA7I4UKA+IHJJdgV4PWUY2J+5H
	A/jvGislrkwaPbC0LUG5FoTHUxtE6m0J9nUTVHSVvbSKgzsREr22kOAtTEoUr33H
	V3Zc7bcoqyA87TByC+W3T6RCWpmr/iNSJR3eSLsdWrXtE2Ptqk2aWpHZCONGjxrM
	vHiz9eImxciaYccIK/OfIOT2ouzzmeCM5tvWiszJdxqAX98SZPbKpx4raeDGxXfE
	u0YQnsSrY2RiXEmwcCvvBRtDQpjAl/cfKjL1zNp1sh+r0BiY+W7RCTYpaxlDyv06
	oB+j54YPDWguV8sqy878OmTyUayWdKVm7BrW2v8wtQ==
X-ME-Sender: <xms:nwpfZsvUqprGW-eGPQi5twbpazwyJh_j66DjcwdBIZgs_l1IYDXcGQ>
    <xme:nwpfZpcYBdPK21jREDN8VC1MJaI1F1mxyWXy0QXlmxfQfGuGofGPT_sJsMOUqL4Vn
    kDsRY2bfejPEh8BYA>
X-ME-Received: <xmr:nwpfZnx61wEwsPiUDBfV85ECSgIKyJVpspCSRXwKlAK60KL5nIEVvfZtwrwrKsMoKG9_D2BjrAW5_fEYVdAQMlL9ZETpQVbcC9PHuF92PpT4U-75>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nwpfZvP6_Re2pxM94MFSjIykw4hwxHtVLrJJx3CIsv9Tmox2LbZwMg>
    <xmx:nwpfZs_v4bQ0evaGR2R1B7AOVBWzoQjpndse2Hsry3631P77oTQUTg>
    <xmx:nwpfZnWxYRf4bBi-bTXTelkIL9gNq49TH8xr4m6LQZ9XNCcSsJh3TA>
    <xmx:nwpfZlc-gTpSR4ifT0RyXEQYmjn7nNo4O2liX8kKlGjpxoLwiLKLcg>
    <xmx:nwpfZgah5TCOnjATCl5x1m42p7oCRoHXTqgAuUxjsHb_rMj9Pq7SaJxo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9e497fa1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:23 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 12/27] object-file: mark cached object buffers as const
Message-ID: <ecca8e973df77cfc8233ab63bf7d1f6fa83031a3.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8y9GqS5qmtZH2O/C"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--8y9GqS5qmtZH2O/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The buffers of cached objects are never modified, but are still stored
as a non-constant pointer. This will cause a compiler warning once we
enable the `-Wwrite-strings` compiler warning as we assign an empty
constant string when initializing the static `empty_tree` cached object.

Convert the field to be constant. This requires us to shuffle around
the code a bit because we memcpy(3P) into the allocated buffer in
`pretend_object_file()`. This is easily fixed though by allocating the
buffer into a temporary variable first.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/object-file.c b/object-file.c
index 610b1f465c..3afe9fce06 100644
--- a/object-file.c
+++ b/object-file.c
@@ -277,7 +277,7 @@ int hash_algo_by_length(int len)
 static struct cached_object {
 	struct object_id oid;
 	enum object_type type;
-	void *buf;
+	const void *buf;
 	unsigned long size;
 } *cached_objects;
 static int cached_object_nr, cached_object_alloc;
@@ -1778,6 +1778,10 @@ int pretend_object_file(void *buf, unsigned long len=
, enum object_type type,
 			struct object_id *oid)
 {
 	struct cached_object *co;
+	char *co_buf;
+
+	co_buf =3D xmalloc(len);
+	memcpy(co_buf, buf, len);
=20
 	hash_object_file(the_hash_algo, buf, len, type, oid);
 	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUIC=
K | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
@@ -1787,8 +1791,7 @@ int pretend_object_file(void *buf, unsigned long len,=
 enum object_type type,
 	co =3D &cached_objects[cached_object_nr++];
 	co->size =3D len;
 	co->type =3D type;
-	co->buf =3D xmalloc(len);
-	memcpy(co->buf, buf, len);
+	co->buf =3D co_buf;
 	oidcpy(&co->oid, oid);
 	return 0;
 }
--=20
2.45.1.410.g58bac47f8e.dirty


--8y9GqS5qmtZH2O/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCpoACgkQVbJhu7ck
PpSbhBAAnw9zQrROH4M6tKmZ1wJcG6TtJsTlptynGucNYb8SO0QNTPxa51W6P2zX
oU0DlFUiHEIgYW4I0ytULGfKxGKIuORvKPiI/rZJUC0eK1UmAGBnvc7k0kWZOKZQ
q1MQM18L13LRDSOcJ75VSgchWljnAi9sYthWOfLFGKxhO3Q2rkzstg0nQ7XjELJ4
dvxl6lZnf1GRVkC7uYZi13dijs0o+eNrajWRlAVKoQPy3d3TnH4gLovn8yB7pbEu
VxEPiDjdGka4ddUC/+zraPLb7pUtU4dChgmsMTS5jWXfTUIjFT3RffxHTeujQvh5
d6SiZVkASMiZjtrX+i895UHVrnJqV3t0udYoj8ktklfVX6PzF/cBC44TSbvo89KS
3/7798xsxo0Kz7bZ6Lf8C1WMqsWqDY0lVk+biARgHjLyJlTmOk86/LbpWR8I51sL
W3WLFcdJ42O/NW1h/VBg5LhfqvPvQ05QILTlKbATKRzbpJPmQCe9XmrUBVXfobG8
oFhue8R5o5UGlV6JvOc91wAhjz5cg4W5pTPphi+ut3L3z5wcNA0gP+Jh6yBVDpKs
HBY+IzF3bR+MqXORmr09HAltWqe7bA0fl+q0uV2EGPwH38xgRaulpVSVfORzTsbQ
j8uGpSI49dxXee6sz2DGzSEp2orXO5EosuxXmBc563FhqusZbqI=
=ToQO
-----END PGP SIGNATURE-----

--8y9GqS5qmtZH2O/C--
