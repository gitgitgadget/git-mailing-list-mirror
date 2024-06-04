Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ECC146A87
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504721; cv=none; b=dHDTSyD7/gJJhsE8X6ddTJOO53PZW2ud8Zam+ByXJa+jEQj3TJ89ppEs0MtsG8gP43OU8e9aCWdcK0EtEyC3v+vFJyT1gdi8Y1rNt65YQyl9Ozsiw4IqN+QCA67iZCjQFMnjRvFDffDdygzkqAP47+5i4MS/cWkN7J8ZMG+k8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504721; c=relaxed/simple;
	bh=jhSVqpK7ZPDOQ5FUGRwSbdzk2eN5+G+DEfRgeGsu3vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaQcz0j2B2NzjWbaXxy1LGrLUIgFUdNMaM9yjkAvIS5utAmDf/ekzcMkEagIwc7xgAZWOHKWcUYAjGnZQFUAheO3VFGNAOPmpcEoU/l/H6HD+fM+09adXJCjCkWyeHeNx46czKDF01L8ECrX/AoFQ6etCM6vy4NrkjR8NkT7Cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VHmd5DGQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cnJAlgSV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VHmd5DGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cnJAlgSV"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 528A811400DB;
	Tue,  4 Jun 2024 08:38:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504719; x=1717591119; bh=EOdldt/KB8
	FZ+pE61RMrFEAhho4DHIAgmFzgns35j6k=; b=VHmd5DGQnJ3ZrbQcYRAJBCpdi1
	u91sDoQqs63kuebAM3NnHei/qOejPvq0FcN0j2m6BB1oOFrnNguVBBR+bQXnEpM/
	6xtt5zV+ORTY8EoRO7GVGdPq4I6AeWyu13xZtPGWMA2ZbGzZ9tNFPZ8shi3AxYyy
	vExp7/Pr2wq/LcOO7iVvUGQbz8UBlx87BZCROGbJ/j8qvn2OyCp6klMA18C9qpjA
	PBRBArOO92aNPdqV1eBL/M5R1AWb5Gyu7ACVetzarjXO+xDGVxupWYZs8Pxr6x9g
	gA1tR9cb9wmY5rw+XhJemtYEH3QBjWFjsUrZkq7Z85oRqP1Nc4vFrol2yCig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504719; x=1717591119; bh=EOdldt/KB8FZ+pE61RMrFEAhho4D
	HIAgmFzgns35j6k=; b=cnJAlgSVWidsssRmY0kvU7O3rDncVO3vGgT0Btikj/Bu
	SK/oAyHGt2AMrzN1qkCZGx8lttOpn4+r8Hc/SOdYixpgNSonX2Q4AaFFuxb8zDhH
	Kq/D98XtZl5bBZ9n2g5m58ZRsQWASyrsrqGdtmwSknN0xCyFy6im9xpnbxghzxiG
	rNHd3BI3bxe2bDFzqPra+b0Lc6MvT7kzwkxnxwPCgFLEzL77WkCgwW38M+WR/A7F
	WJvY0pIa0bsgx/EFus+RQJkrV4YPf37FxT/ZEUblYGIu29UFDQWF9uA4b7LYjG9B
	zYgWg2o8liVuorD1FylwGrK1xmorZa6tq8KfeC2SmQ==
X-ME-Sender: <xms:zwpfZlozS9u6PaPWJqA6-WtDsB0x4QKFOesYzr7MHuVpsffI77wi-g>
    <xme:zwpfZnrVFZpPqtJlhoHFFV34I5OZuXWpuBku_pPTaxfgkqwKVs1u-TjmsDN1toO7B
    uor9YDePAc7Lu0R6g>
X-ME-Received: <xmr:zwpfZiPZ78jFSaopFnKAqBYNe0geiNDPB6uQbVSSif6z07ZTjonYoFqpuyW03z2d6u9hbpqMU1lfcgYf9Qzm81SVMpDGpfn7l1-yf0X9ahMMkiVS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zwpfZg5SXNbXoBBFylFUJJmJpDHqn-3GcVUYpQRS7jwlc7E8cWLNMg>
    <xmx:zwpfZk5IMzw54eGgHvE_jKpxmXapOhQgPfXtu0errtvuOhXsPcyI9A>
    <xmx:zwpfZoh5moF_aPf9wrllxxWZKMnJeV95bu6Y0_C7MIacSkxvHMkOHA>
    <xmx:zwpfZm6A82OJZP2BmC8hF0LO-zNSMlr7j7rlMzglHMpEcZHJxwnFYA>
    <xmx:zwpfZv1u_1U8S-kCDRc-fvBgjwXe1Kxz8aFhD5Q002wUlUVYrLUY8Bf6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 40823236 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:10 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 21/27] mailmap: always store allocated strings in mailmap
 blob
Message-ID: <ef43c1b18f1f2d891ac1677c7dc1406b80e2add0.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NEx4RunodnNYy7c3"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--NEx4RunodnNYy7c3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with the preceding commit, the `git_mailmap_blob` may sometimes
contain an allocated string and sometimes it may contain a string
constant. This is risky and can easily lead to bugs in case the variable
is getting re-assigned, where the code may then try to free the previous
value to avoid memory leaks.

Safeguard the code by always storing allocated strings in the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..3d1e092fef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ int read_mailmap(struct string_list *map)
 	map->cmp =3D namemap_cmp;
=20
 	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob =3D "HEAD:.mailmap";
+		git_mailmap_blob =3D xstrdup("HEAD:.mailmap");
=20
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |=3D read_mailmap_file(map, ".mailmap",
--=20
2.45.1.410.g58bac47f8e.dirty


--NEx4RunodnNYy7c3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCsoACgkQVbJhu7ck
PpSPUw/9F9IOW5Wzw2wFimhCQuGrzBoyN91jr2tIQ7Q3OItwlXz/lSoRrwhWXfOx
S+StZieRvPyET+NfZFw4N/Am0LCXDMbfZ0WtU+Je7Zu3l2lFpxDJUxcE+JYUiMXW
n+JCS1ZDAeq/DhuTv6hskNDy/v5/VVPp7lKNhdV3Cs5MBPeTDFEljEeAkKpTbqph
tKN04UdW47SFUT6FkZRh0X99klUz3R8PgQrmia5/HIzDYv8vcOe3Bu+BIB2tuUQ1
Pq7RSBmmL9Ezu5hFriQcP5lE4SntPUulwjujuhvM8AV5foSj1nFXvhbnuuVsQFPq
dgMCB1yHto2eS8t05GNRRQ1qtEmcxmqV8/uvsGWD1r3Np6ydLIuPE5rePPlRBY4K
0ucise87GDFmeL8QlgNM2Wy/scnKQbmkqZ81IFUkZFRgPf7PLo7qD7RTg0iM6izZ
1glhfINVzjmTxKvgbOKHK7SxqDIJiX6fKP1Q6kmmLhQcEXx4/4krKooqoVgsdf0i
QBk+/kiyPbZPEwDrJlQ36UQ+KLIdgwCGIKwmbXVJKfkMeHEhB4SGrQQLLI18yxS+
+pMp7xOQB6hUzsPGn7MlhDcDusl/cXvSixrdGyZc3eOpT7Z3zXIRZijfLlFi2Mk5
Yk7GXMomcXOxqn4Ssr9zP/FJokXbtRQjgjmoZXKa1k1u6XIHqQw=
=uH+X
-----END PGP SIGNATURE-----

--NEx4RunodnNYy7c3--
