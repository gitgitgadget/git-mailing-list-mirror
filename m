Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3BC145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504654; cv=none; b=MbW5UDsTANKmsXSOhbYaV/fB4pcANLh8XIPkrDZNbGB03suGd6GW1dZbm4xYkjAUXl/oW9R90XwSER73aU4ycmjZ+u2ZZdlPBoelM26Lxj0Vmd4TilQBXGgg4rDYWpcpBin+YwMHvdcKHph7jwb4leNmwZJn1tDW3oUzjomM+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504654; c=relaxed/simple;
	bh=jvWXij6FuVdDJy/qzuoYVm4v9sHXr9r5jGNnAuZ1RyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4Y19opmosyXid/tTg99+tdqmqHkzjMVmQgOQ23PlvIUlsXx/QEb3AiyJY6x9YadVWKCd6k3HbL7/vTnB7g9X0gICmMQ7zV1VfyQcjIsu0q4a//GNhCK2P77RsTJ+witG+LaxojpvpiMfFE8Qj0hFkpEWAWvTqmRdtDrkYFMPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nW5wVD9O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9E2b2Pk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nW5wVD9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9E2b2Pk"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0EE0611400DB;
	Tue,  4 Jun 2024 08:37:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 08:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504652; x=1717591052; bh=ULMD23WIIp
	7swQk234ZyzUHzUlbvRVxuKane3B3DJ4E=; b=nW5wVD9OHDC2FICKFa/3Nyeiha
	qx5mQtJoZq1Zyr4KFUENo7IpPdbLBhUC6xo6oy5qggMWDVrzbo0/6QGbsUp8iZ5B
	IuqrhMXFQyJje1xFXQsdTxwQMfIqrpeDy/fMrfQnOE9w6Gk6VSFidg4ZfkZds3X0
	eB3ko8lkz5tvi/5Ul/jXIEzgqkGRElsSuUhPF2pIovzXpd/j20IcY+hpSof3ueg/
	iHGkX1tJEQleEQrVyfxnzm0YIXauuP9eKkiEqJwPlnCBQa/O3P8yL50uLY8WwKLE
	RySgRjFNH/khItYxcYPdaPqQd2QvfgUFAQgASb5OFlZ43VK+kufT2xzfsa3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504652; x=1717591052; bh=ULMD23WIIp7swQk234ZyzUHzUlbv
	RVxuKane3B3DJ4E=; b=j9E2b2Pkp3K2h1X4OSnHsJ+7gMAoa4KG3/OxvkRzIo1C
	c1WOio/sJGaWrrJfKUGTHHyeZawKCsECWaB8fQzoqcWNKP/j2gThH/YGcRqBSJ6/
	tR1z9KfsWtRwZ5XAr/9MDpGc/df9e5eFupYpE5CC/Z9HSPzPDGxR4gjiHTo3xvFc
	0NBAK7Z9R902HztfnST9660xwRfH78D4QO7D7YO9RFO3e3FNdJYCrhw0yynwNceu
	gOoGq8ABB+WkvOf7WB46M38s6pUthMmLDWN+fm3dGXV0cZV3FegN9al0K40m7l16
	vRQZ42ntvNvsPv7W2O1OLyZxlD+nZV0MJ0c3AeDheA==
X-ME-Sender: <xms:iwpfZsaomQ1fsXBh10iObgMx0jv1dr5Af4ETh7VbHujJMbxC-8T7EA>
    <xme:iwpfZnbcjGq56N_Mu8O-HjSJF01OKM71yu4V9gjOXnO8olO3UjvKxsLExxcJJ7N3B
    hwQUnVfXh-uCH72Mg>
X-ME-Received: <xmr:iwpfZm86NHQLyVt7oXPTYhFxNwqIO7q0K3-aJNqRm18EWLXEMnOjmUQv3MrK31Ngtf-m2f9Tq1lkyw2I99BFAJJZL-GzLj8O-QEln07wlZoKqx-3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:iwpfZmoH9Ms701od4FZ0TwMxjR_9Bp334vU4BURnRKhyGfiKWtCjvg>
    <xmx:iwpfZnoojBPEC_AN-_G0ewMwnXiSSSFTB6ROejSTF8qAgAIJhft-5Q>
    <xmx:iwpfZkR0adzUeTM39O3QmoGSuMT-pKuxFcMuYBn_k5LyFBnca2uk2w>
    <xmx:iwpfZnoqqTDRaM3ly-d5LwL3USPGQhjDMyKRn9knEliA9W3NomnYdg>
    <xmx:jApfZonOw5VLmI-q5OSy8oJujLsZluL3VgaM-d4yHx-uI7cNNh97Mv6J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 17ddddac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:04 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 08/27] line-log: stop assigning string constant to file
 parent buffer
Message-ID: <ac164651a325476ecf041641c11785ac8c0c1501.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZbvQMWZBTmlQ49Y1"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--ZbvQMWZBTmlQ49Y1
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
2.45.1.410.g58bac47f8e.dirty


--ZbvQMWZBTmlQ49Y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCocACgkQVbJhu7ck
PpRL7hAAqhI2IlAnJVyydEl5AehwG2BFXGcyDtS/UHAF93q0GHfley+8HBrhaJ++
njxl71EOivSwlmdhdMuR11llwnAE8NUSzF8HnkX8Gf0DUSaHiYHj7QMuGh714VSm
N8t0FtUer6X73UaQX8CYLCWQmtv/CrZNZDqM5hpImLHFuOPvLgyjW9/XYip3+c8p
pZyHA8xl0VN9vKpmYUG+6b24HrobGePsKIPGaoF5U7L1jfcsOSD2MhDELBw2fj1n
FooYONh220tSfKSVTdgi+oFpRX2fUcol1cDPB1R8Pe3RuxI4FAx+qZxwdKag5N1d
IPS+sqfzwotJa8+jSyDHnUp+8PqbqbAdbFaVF5BtVSHwP211bBDfGpRHsMOYv1Z/
nqIuzkVZr3o4oL6OEhJahXDw8AVqD6UyDisFk+5/19PSshuJJ+g+I1rpP7cq1bgP
3MbNsVFROLte8iN9sKyRH3u3A6pUQj2kw2DL3BPsC6+3WNP8rZWac6FD0T//HPEn
r6N5g/aqDLuYL+83BvRRwGgg/2zhRjObeLjd/QWO/UUs5bs5BiUGq0aNSFIoJ3qZ
ZcFF2txNx3JPOgY4XlY5hI+s7qkM/9mkhqikzCJFzoRab2MByAhYiBmFABWwVLF+
WxZbDnX8WIDN1X2XGmvjQh8dwgrh7k7SXJ2Im8fAeR2jQcD5CNk=
=AV+i
-----END PGP SIGNATURE-----

--ZbvQMWZBTmlQ49Y1--
