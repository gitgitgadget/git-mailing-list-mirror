Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696B86CDBC
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712578593; cv=none; b=u2Pn/NCSNSX2hfK6MaALaS40MsInTKXATuVA36c0QvNryPTNK473pAt3ecATPOdsYJUcHNpXsnBWjnWlxe7QvUNPVio084qXkXW0J9oEf460YmV/8b1/EEvZoMysXRLgOiTTCCRTMeBoAAbwFD3Z0Q4Far8vtcH8SVRdQ9OKk/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712578593; c=relaxed/simple;
	bh=cRwBXdp+TTnkxuWtqOrfl4PG3MNnA/Ma2F79eIrIxyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/QzUgL3w9E1ghLTbvoINzfz4lk4xjvvk3kyVL3SjZyyvAiRwEBR63CKnJnAMsUgrkVDjUf7B3nS9BUxuQIYbFfYrC6JEJh5KZkVV4UcryPvcA340YruAh7j3rwYk9G6a75HuGBsPAnBLJ/J8w/nybRxySJoBLwT3M6hgUWsFcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G92pJ48n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nha6WSkr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G92pJ48n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nha6WSkr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7889213800BC;
	Mon,  8 Apr 2024 08:16:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 08:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712578590; x=1712664990; bh=rYl9npi/Kk
	ASR8TCsOw8QkvKpQAQq1W79+txgBN3EwU=; b=G92pJ48niqZuE2bOHu+JnIvy4q
	c0uO8wCHrPG8GYj11zdejZdRziIcmnp+IeXcDlSW1H4fXXvQjcEQj7A1TMsKMUkP
	U/mHpnuV5dmcP2CLTsFOmRZ6G5gym7rg1Nj3nmM575Qa7Ld4FBAHLIiUe58hUQ5i
	7+Q/1vx1E0LAkudRKMQR3/MSzAMCgTfPMc+s6KNFKeJEN+Hv40q1KnH9X//KjUom
	jQuGVE+K8HJ7C/WK+PG77qPxqxfUhthk4ZsgpK4ZnS7VVuc7PCnodISuDwWTouHj
	WWY5qtTqsnx+RAwbUc9dTTvklfBa7qADe24jh4J3FwQ510zppRqRPoHlTFAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712578590; x=1712664990; bh=rYl9npi/KkASR8TCsOw8QkvKpQAQ
	q1W79+txgBN3EwU=; b=nha6WSkrRxWeD7cp3a5C9kleD/0RRTalmSjYOfFknUli
	J0d7ONnCWUMDTeyVZJswLwsWsamFARWG1rT8t5Q4Kk56vGz6wQsN3aAdQ8c4TyYm
	NNMTSRRm5O5keuwPJ8XKqqjvgYOypI4Ag5hh5EewxAni246Bc2UE76CvnvDiB6xh
	TVliae1gfJ4SqOhu8/tKHEesw66s1GzecPBRd8RP8R79aLl66+8vwpuZgR8azeho
	W+zw2KgTaBYCz7iZVgGFyjTf0g+xrARgRmx+x5nKTECFejeH6gmdImcldPQ7/LVZ
	TIU/IgUHeh6m+uxU+Rc/JyucFXRFNc9uUx8ykziFHw==
X-ME-Sender: <xms:HuATZj3z14d8B6AWcgylUPUUu3nDpmIfFwQOVpEVJ25DsJe6hfsNww>
    <xme:HuATZiF7rUVmP_OylNCNyGzwjzWLPHHvZfXzxgVELX63ADfsBon_Ey5_OL-dAMVLF
    9EDy4EX9VyrAa4Skg>
X-ME-Received: <xmr:HuATZj5rSZ__poRo4KbWojucs7yvyHXHVYGtU3yMt1qxaYYTsS5tNLOxfuJW6M0fqOte15Y8nRr0qzOFXeKBJplMp5ku0ZO3p5MCu3wo2Tmd8sC7dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HuATZo3Jp64IHtRMhAbnMzoziYHITInKIm-Jn2A6Jh3XSZWDqDrYBQ>
    <xmx:HuATZmFDxWy0ywB_UzCb5mZb7CxjeDDmS9g0XdUu0pxfUNZia1rLCg>
    <xmx:HuATZp9y2Ua_nynxdPc4tuRCzLVQsrEQc6vZVOVA3L0KCieENbc9uA>
    <xmx:HuATZjk5woZ0L4fg_g-nnB5cdFzLHD8w9FVltGqBS446IHBK92jGfg>
    <xmx:HuATZihWwgGg5HYWyvlpb_Jjq22US25ndxATWVxg2QV6oQM3YLyirUKb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:16:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 24934707 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:16:23 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:16:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 01/10] reftable/block: rename `block_reader_start()`
Message-ID: <eb487557a8b5fa26c87101ec297221ddc916f3b5.1712578376.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
 <cover.1712578376.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xkLLKt8YlGUl5c84"
Content-Disposition: inline
In-Reply-To: <cover.1712578376.git.ps@pks.im>


--xkLLKt8YlGUl5c84
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `block_reader_start()` does not really apply to the block
reader, but to the block iterator. It's name is thus somewhat confusing.
Rename it to `block_iter_seek_start()` to clarify.

We will rename `block_reader_seek()` in similar spirit in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c      | 2 +-
 reftable/block.h      | 2 +-
 reftable/block_test.c | 2 +-
 reftable/iter.c       | 2 +-
 reftable/reader.c     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 298e8c56b9..53ea92d04e 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -266,7 +266,7 @@ static uint32_t block_reader_restart_offset(struct bloc=
k_reader *br, int i)
 	return get_be24(br->restart_bytes + 3 * i);
 }
=20
-void block_reader_start(struct block_reader *br, struct block_iter *it)
+void block_iter_seek_start(struct block_iter *it, struct block_reader *br)
 {
 	it->br =3D br;
 	strbuf_reset(&it->last_key);
diff --git a/reftable/block.h b/reftable/block.h
index 47acc62c0a..44a9a8de7d 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -98,7 +98,7 @@ int block_reader_init(struct block_reader *br, struct ref=
table_block *bl,
 		      int hash_size);
=20
 /* Position `it` at start of the block */
-void block_reader_start(struct block_reader *br, struct block_iter *it);
+void block_iter_seek_start(struct block_iter *it, struct block_reader *br);
=20
 /* Position `it` to the `want` key in the block */
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
diff --git a/reftable/block_test.c b/reftable/block_test.c
index e162c6e33f..a719be7c50 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -69,7 +69,7 @@ static void test_block_read_write(void)
=20
 	block_reader_init(&br, &block, header_off, block_size, GIT_SHA1_RAWSZ);
=20
-	block_reader_start(&br, &it);
+	block_iter_seek_start(&it, &br);
=20
 	while (1) {
 		int r =3D block_iter_next(&it, &rec);
diff --git a/reftable/iter.c b/reftable/iter.c
index 7aa30c4a51..aa9ac199b1 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -115,7 +115,7 @@ static int indexed_table_ref_iter_next_block(struct ind=
exed_table_ref_iter *it)
 		/* indexed block does not exist. */
 		return REFTABLE_FORMAT_ERROR;
 	}
-	block_reader_start(&it->block_reader, &it->cur);
+	block_iter_seek_start(&it->cur, &it->block_reader);
 	return 0;
 }
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index b113daab77..d7d47e8640 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -345,7 +345,7 @@ static int table_iter_next_block(struct table_iter *des=
t,
 		*brp =3D br;
=20
 		dest->is_finished =3D 0;
-		block_reader_start(brp, &dest->bi);
+		block_iter_seek_start(&dest->bi, brp);
 	}
 	return 0;
 }
@@ -429,7 +429,7 @@ static int reader_table_iter_at(struct reftable_reader =
*r,
 	ti->r =3D r;
 	ti->typ =3D block_reader_type(brp);
 	ti->block_off =3D off;
-	block_reader_start(brp, &ti->bi);
+	block_iter_seek_start(&ti->bi, brp);
 	return 0;
 }
=20
--=20
2.44.GIT


--xkLLKt8YlGUl5c84
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4BkACgkQVbJhu7ck
PpR6wRAApa5gMMwyzWAA0BHUcy+117ik6NOjWF9IELmueyCh/ERs+yAZz8s2sMAj
UaPECcW3bFGXTguGguXjbMUVenPFB0iCTCOJ6D1S07Ggz/Z27YkxXgraGrSSLU83
m/osJqiIUPKq/1EJsRjEjxLrarLbjuawv/YEz9P/BlTTCnD4IDjt7BdjOrVq2pDj
kd1jJzKfyrZuYrO3O/6X6MjGbz0DGh6wkon6NXSIP1Rt/DdPLSvIgkGBp23zvVW0
LHeX/mu6svoN9evhfBaXsylB283cl4bN+z+8CfzJ4X8dJP/Ku1xEGxRt1ctSa1cR
DjyJq3/AJT8jGtZMCQCNKOOgSfamPxc3kunDAs1t84HEhg4aJUt9tlGO1Jxu4TUK
ynpzv3+Nok0nypohidJ9Xo6DIdHoQE1SW4TmrqCE49/pgyAmUZA+KMHumOQAnP8e
noEejAI63mBMWTjjK/MCMI7T6ZKevZ4JkiZRQGdobeVLxlRKE+lGej86NMtU4iVz
KkHPyFNEABC7kZER2kEpT7CMutT/MRa2otFqv2cAGYI/ACyHKQBQCMkzFP4imPkQ
n56nzZbFSMEdn/JZLiwj8n2d6BydWu5TfBRWkxVnm0s/4JBGwZongJy6EicbC/vu
rSMM7+ktimschdXDm0GGqC/RmTWcK9ZUWp9XtC/fdIjp9eWa6Uw=
=Zklo
-----END PGP SIGNATURE-----

--xkLLKt8YlGUl5c84--
