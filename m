Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8FC18C33C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669709; cv=none; b=sVyOiZmH8oIm7jFYzO4k2OrIzrfVqhMTsMkCEA7NM9CO7Ivq8QTPomcTYl+7KCQB38c4e7D1pUVYX4lzSkQj1qDLMEIKXwb9bT5VBCIZJylLOtJmoA1HJturHOK163SGswIcZy4RJDCd82sxPtng6TCLAICfyu0b6v1QMo0JmXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669709; c=relaxed/simple;
	bh=XAtUDMPmQP9QATekYVI9n4kqH9l4ILABe4/9j3qvu9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHWAgNh/t2Ds9+By3/XaM/w0bTi0GO48yKO7Y1DPniU0Ss7nasQ7Uo+iylc/4geX18Nv+aBzpQB51iGaZIKRt3u5sY47qjJbdDurJyd5hAAgLTJ3lTOd/g9XKuixJhalDqngksvHvhp5NrVuHKfSg1tIkpOp77ruKvs8yqW3iqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PAfmk/O5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMh3vJhk; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAfmk/O5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMh3vJhk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 311BD11401AD;
	Thu,  6 Jun 2024 06:28:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 06:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669707; x=1717756107; bh=/Fu83bBSVI
	9YEqDZobyv8XRl7WwRKdznSJOWH2K6okI=; b=PAfmk/O5UqVDihgTXd5cnPXAZx
	k1T42wXvIcZ8bPZ7rKmWIdRxTIqyuriRM/iEc3DVyBfgwNEm1NoK1A4FpXFBKwIX
	VakOWNcGDs2g4wCGJGf/A+4vqzFejBvaJOEEjw/Hye6uJPIDCYqZYJ8gS3qGMG7j
	+9Oz4oO9VM4VK4bxSXEoysStyTm75YcRsT30Sivx5Z9Xvysbm1MuF9h1SHcwGpQg
	0b//sjaT6tLtRP6bQyKnNmNWPi6XSWrqOemNoyYzplcaVESjARZBgVDnXmpTH5S+
	9tBv5zWZp3IsHEwisEwNlOtz4azjtZLk5oeK/mCsS0qjP17IMqkwgDRM+IQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669707; x=1717756107; bh=/Fu83bBSVI9YEqDZobyv8XRl7WwR
	KdznSJOWH2K6okI=; b=PMh3vJhkeTfbByRJsP+jkxXJDX+oPsMC+aAGxjiZbdsk
	hVxJAVADvnhnhENlHhZgHwBoGXj4n2ksa3TlEyPz/d2leZky38riNSZB4Qrfnex6
	ouQI9C0AE30Ghfc1QMIAyd1F3KU+FWDfs3HRa6t5b5cTRTjEfX3VDdZ+UlmPNVmf
	VVgYbgqSneoj3qkhoTd0IkOjnxl0AuaNTRsyjBOVS3qGXY1E6JIUvLw7UQ/2IZ5A
	znLvyPNS3W+3B/DzI0KLG//KWa6W12p7Bw605aet2AkDzqPLqEKaeTuB0xqkHBcO
	61GhJGyEgl34HgDBviyCZ0AbgonGcj7SuC6W8EXSPQ==
X-ME-Sender: <xms:So9hZqpsBbRGynUMOXm_e7vAxfYzV4AQSKApu5QeOdqKoG0uMjEiIA>
    <xme:So9hZoocnmbIA5XruezeNdz6yUtDVMFbG24R0BOnpx835m1chm4dhsl9HE9fYk0Db
    pzHjZruAiA0xw_7dg>
X-ME-Received: <xmr:So9hZvN6jrEDLIQbMxGmQzjJPUKVIKyDJ4NTzyO3W1004I4NvuwfGMGC59921XK70fFbtbbFa5E928_YTINleDfxgDIUOcpF61cZRmpOxHhHAqjW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:S49hZp4XCPOSSIRkGei_iHksioSiGaoBGq0OW84cSTplysOTVWxNDA>
    <xmx:S49hZp7GlcWvSzzuPxMI0qX5p5XzbqBZP2ERvL38Tc3oxg7zLpZdJg>
    <xmx:S49hZpghxk-vT6u1-XXemJMpsVZi_UjyBjrhGJ_1XfSv4_M9o2PrkA>
    <xmx:S49hZj5vSDSmzDaVrcSxjfBMdi9o2ZPYFMpOrblO4LoZru3ycnYhPQ>
    <xmx:S49hZs1nVaVU0nm0MDZz8Q5-oaV8Jz4PEz9zOWPqel5GC9nZn7Wl0JC8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f03d98b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:55 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 08/27] line-log: stop assigning string constant to file
 parent buffer
Message-ID: <ac164651a325476ecf041641c11785ac8c0c1501.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3+oQtgpOCWODF7km"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--3+oQtgpOCWODF7km
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stop assigning a string constant to the file parent buffer and instead
assign an allocated string. While the code is fine in practice, it will
break once we compile with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 8ff6ccb772..bd3e663c24 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1032,6 +1032,7 @@ static int process_diff_filepair(struct rev_info *rev,
 	struct range_set tmp;
 	struct diff_ranges diff;
 	mmfile_t file_parent, file_target;
+	char *parent_data_to_free =3D NULL;
=20
 	assert(pair->two->path);
 	while (rg) {
@@ -1056,7 +1057,7 @@ static int process_diff_filepair(struct rev_info *rev,
 		file_parent.ptr =3D pair->one->data;
 		file_parent.size =3D pair->one->size;
 	} else {
-		file_parent.ptr =3D "";
+		file_parent.ptr =3D parent_data_to_free =3D xstrdup("");
 		file_parent.size =3D 0;
 	}
=20
@@ -1075,6 +1076,7 @@ static int process_diff_filepair(struct rev_info *rev,
=20
 	diff_ranges_release(&diff);
=20
+	free(parent_data_to_free);
 	return ((*diff_out)->parent.nr > 0);
 }
=20
--=20
2.45.2.409.g7b0defb391.dirty


--3+oQtgpOCWODF7km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj0YACgkQVbJhu7ck
PpS+aQ//UbzltiSVb7N3QL+Ao3+MCJXKq/HDuCqbcDV8nO5qXE+jyN84Z2FWK8/Y
sNIcYvQEGHChfXkVHvnkR5rhYJLHx1xTRgS7Ku5Bsu4WBVXkhqeHe4xLjiPExIhj
PnFdDDZ2mWhKfNOafmECqtiWj+8sZ1/SIeIpiEXIGhl3p1QIjbjrLmPDhAr52WwF
GVVf6JAdkH642235ExNnaHu3n021HlgJIXzrEZRP1AIn+UP1JLDun8L/A6CVVsGA
pftkLqThChL/jlXEGT/VnNw8M1Qk2O9lRbexxaa+wKtH303PEEfVBuChdmwv6KGd
8lu/LLNdX3j9rE7UfKndpbSZVto7+2m46S5MgnQVT/MHDdsRclsQHL4F7Ypf/8e6
pfy3/VL9q5ON0S8Fv+0HZVSxuk5t1V9erjg5Gq6oQr2tTfv9F/3y4vVBkfXRFByr
6xHbjm7mBRfzyiJn8XvgwP2qgyJDuJtGvT8aIewLdK83EvpeP0kMLamKqzKx+99Q
3HjiWk3cMz7Pwd5C9AYCnEkGm6btfFTx6m+KbbcQyQwCgKZWUAezeLF48ZJUIfQI
GVCHzriXPhdGcTjJLEdKw0FeR4o4KY7rKdmyThf1KaAGhdpxVtJqVLzvwFB6qk3J
xvULBWh6APWz/JVsgW6ttVNAJ1FahsA8tQVbh9y7cl0trgZuJjY=
=+Fzw
-----END PGP SIGNATURE-----

--3+oQtgpOCWODF7km--
