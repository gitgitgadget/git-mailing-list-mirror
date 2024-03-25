Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194C19F530
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361448; cv=none; b=QzR+dGKSK31NL3V68jbM1jIg/+r5kJ9K/rTXbLShQYuTTKn6Up31ffRJzTmt0hV1Nb+/m5TO3Xd510G649opN0j3NrWLSQNT4I+iH2Cnqdlt5oZwdMJWLvCrVz2Xy4bjCoLxdP2/4r/7sh9SAjyB8MHNhIfP9YCxOU/EjuWQ+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361448; c=relaxed/simple;
	bh=gE0TgUBdA/aO2A7jK1udRZ0JKND1yykEhVkywlYuh00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3Zwk6Pt8rA1afUVTftlz+XSHXGTpliGsvMlZKaLfCbswJqQr2LpUYtQDQWNUHAriEx5lzoVqI2WeQsfj4bO6HmMgf5kc7H6Y67B+s5BBknRt87b4Ii7pAdGZU0xuP65KFliAT+jKnQ7SjyWKpQsL8YlaJguumgxXoW6o9lSdhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a3+yKoCg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q2UVyzC2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a3+yKoCg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q2UVyzC2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id EC94D1380117;
	Mon, 25 Mar 2024 06:10:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361445; x=1711447845; bh=n4nglsMU3x
	rxH5x4tWJOSSrK7hEXfnRVL5jZZfokunw=; b=a3+yKoCgY2xleW5nzvCOyi0QYK
	cDacNjZe5S32STjBzAaVHsK0PSNszLJrRg52x+WZ/qhk3c9+Uy6fBktwE+3maS7O
	Nunfu7kTWPVmWeEXYeHywK7UqA8mkbny85Fy7eSXeVnHRQ+OH99bjKfJfxPPvcj6
	APuH2Il2t8JsXAFqVpHfqnuUcyOFrtI1uyxv6+xKEmUcZo4echqhUKkfsNuE2F/k
	4K313Rv8UKLaOONL07uICXORppNQXj6kiunRuxUkUAI1SchVOr1oEDxJs+WlYyNL
	HXe8A4jn4CzSmOUIIFJ9FUPdDQwz6UzYOkl+n6imdeqnJ9573p6LRUruC1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361445; x=1711447845; bh=n4nglsMU3xrxH5x4tWJOSSrK7hEX
	fnRVL5jZZfokunw=; b=Q2UVyzC227P6lj/VCLpqvD12rMAft54Ddh0QT3ITaly1
	HGx3ZCNyntbFUX+7jk1De96toXeCkQFHjdq0oc6CYJW3mTAzyhfPilduiaQlcvmu
	dke+j7wbNQr2PDO8BFsGU340hcuH1nwFy2QCDNy1b9sOlmM35hJ4KwzBT6W7wLsP
	4zqPgfoTG6S/5Idda9jDgoMsgPCvJ8IfN0PSMoQjDmBjS61mg+Cv9c5amUZKEraQ
	jaWyujbctB43yK6+wCzhlUCOKcwU1+j8r/s9gOpi+qrIWHZrDNzm9TMyNMEUOq6t
	/RnmJJRYim75tRSjF7FvVJwOS0FiY5nAaptNKrxCsQ==
X-ME-Sender: <xms:pU0BZrPyCeOAnW3eBpbql0noiAQz0pxExfl3OiDHKJw311rZZCItHg>
    <xme:pU0BZl9EQ9qiNIHdwvaVhwhJLn0qyIaVBZ0FiAoC6AX1sQzCjeGeRkBjMEhcsdJ7k
    35gCKBGMyL8v5ZbAg>
X-ME-Received: <xmr:pU0BZqTOBb-ga79qQ6hEMlkSU9i4TMPQLf1gB2jJpwyM9S0AmPXfp8E4ZoLRtEqImrsrK8BRLgZu3W4hXnW1Zn2gcYq0Hgl21HkEIdqOg5MXNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pU0BZvu_M4lfSjYNXaZEOHXSfWPwUK-xFdHj5ysXjuocw6HrRGFK2A>
    <xmx:pU0BZjcELMv3aus-YEX5g0YZFTaxFXiD6dSG56kKAeGoqtLHZ2W-fw>
    <xmx:pU0BZr3RISOLu7rQ3NA3VdlxNo6EDgtFvk5pHsEsowaPiqP29DDulQ>
    <xmx:pU0BZv-srwq19fSEyHtBhf1ehKyBfvjVHB31Vg9mE7J2Ppdmv7nfAA>
    <xmx:pU0BZv7RmSGGQqbofOyFurtvcJTY5QC0C7H5zqeH0EkCgxoVb8c26g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:10:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54ea4049 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:10:35 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:10:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 4/7] reftable/block: refactor binary search over restart
 points
Message-ID: <5e20d93ae000359f2231bf950a930cfc4898ced2.1711361340.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="00gATv1vjKrA/mz4"
Content-Disposition: inline
In-Reply-To: <cover.1711361340.git.ps@pks.im>


--00gATv1vjKrA/mz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When seeking a record in our block reader we perform a binary search
over the block's restart points so that we don't have to do a linear
scan over the whole block. The logic to do so is quite intricate though,
which makes it hard to understand.

Improve documentation and rename some of the functions and variables so
that the code becomes easier to understand overall. This refactoring
should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 97 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 27 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 422885bddb..6cd4c053df 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -273,34 +273,36 @@ void block_reader_start(struct block_reader *br, stru=
ct block_iter *it)
 	it->next_off =3D br->header_off + 4;
 }
=20
-struct restart_find_args {
+struct restart_needle_less_args {
 	int error;
-	struct strbuf key;
-	struct block_reader *r;
+	struct strbuf needle;
+	struct block_reader *reader;
 };
=20
-static int restart_key_less(size_t idx, void *args)
+static int restart_needle_less(size_t idx, void *_args)
 {
-	struct restart_find_args *a =3D args;
-	uint32_t off =3D block_reader_restart_offset(a->r, idx);
+	struct restart_needle_less_args *args =3D _args;
+	uint32_t off =3D block_reader_restart_offset(args->reader, idx);
 	struct string_view in =3D {
-		.buf =3D a->r->block.data + off,
-		.len =3D a->r->block_len - off,
+		.buf =3D args->reader->block.data + off,
+		.len =3D args->reader->block_len - off,
 	};
-
-	/* the restart key is verbatim in the block, so this could avoid the
-	   alloc for decoding the key */
-	struct strbuf rkey =3D STRBUF_INIT;
+	struct strbuf kth_restart_key =3D STRBUF_INIT;
 	uint8_t unused_extra;
-	int n =3D reftable_decode_key(&rkey, &unused_extra, in);
-	int result;
+	int result, n;
+
+	/*
+	 * TODO: The restart key is verbatim in the block, so we can in theory
+	 * avoid decoding the key and thus save some allocations.
+	 */
+	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
 	if (n < 0) {
-		a->error =3D 1;
+		args->error =3D 1;
 		return -1;
 	}
=20
-	result =3D strbuf_cmp(&a->key, &rkey);
-	strbuf_release(&rkey);
+	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
+	strbuf_release(&kth_restart_key);
 	return result < 0;
 }
=20
@@ -376,9 +378,9 @@ void block_iter_close(struct block_iter *it)
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
 		      struct strbuf *want)
 {
-	struct restart_find_args args =3D {
-		.key =3D *want,
-		.r =3D br,
+	struct restart_needle_less_args args =3D {
+		.needle =3D *want,
+		.reader =3D br,
 	};
 	struct block_iter next =3D BLOCK_ITER_INIT;
 	struct reftable_record rec;
@@ -390,7 +392,35 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 		goto done;
 	}
=20
-	i =3D binsearch(br->restart_count, &restart_key_less, &args);
+	/*
+	 * Perform a binary search over the block's restart points, which
+	 * avoids doing a linear scan over the whole block. Like this, we
+	 * identify the section of the block that should contain our key.
+	 *
+	 * Note that we explicitly search for the first restart point _greater_
+	 * than the sought-after record, not _greater or equal_ to it. In case
+	 * the sought-after record is located directly at the restart point we
+	 * would otherwise start doing the linear search at the preceding
+	 * restart point. While that works alright, we would end up scanning
+	 * too many record.
+	 */
+	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
+
+	/*
+	 * Now there are multiple cases:
+	 *
+	 *   - `i =3D=3D 0`: The wanted record must be contained before the first
+	 *     restart point. We will thus start searching for the record in
+	 *     that section after accounting for the header offset.
+	 *
+	 *   - `i =3D=3D restart_count`: The wanted record was not found at any of
+	 *     the restart points. As there is no restart point at the end of
+	 *     the section the record may thus be contained in the last block.
+	 *
+	 *   - `i > 0`: The wanted record must be contained in the section
+	 *     before the found restart point. We thus do a linear search
+	 *     starting from the preceding restart point.
+	 */
 	if (i > 0)
 		it->next_off =3D block_reader_restart_offset(br, i - 1);
 	else
@@ -399,21 +429,34 @@ int block_reader_seek(struct block_reader *br, struct=
 block_iter *it,
=20
 	reftable_record_init(&rec, block_reader_type(br));
=20
-	/* We're looking for the last entry less/equal than the wanted key, so
-	   we have to go one entry too far and then back up.
-	*/
+	/*
+	 * We're looking for the last entry less than the wanted key so that
+	 * the next call to `block_reader_next()` would yield the wanted
+	 * record. We thus don't want to position our reader at the sought
+	 * after record, but one before. To do so, we have to go one entry too
+	 * far and then back up.
+	 */
 	while (1) {
 		block_iter_copy_from(&next, it);
 		err =3D block_iter_next(&next, &rec);
 		if (err < 0)
 			goto done;
-
-		reftable_record_key(&rec, &it->last_key);
-		if (err > 0 || strbuf_cmp(&it->last_key, want) >=3D 0) {
+		if (err > 0) {
 			err =3D 0;
 			goto done;
 		}
=20
+		/*
+		 * Check whether the current key is greater or equal to the
+		 * sought-after key. In case it is greater we know that the
+		 * record does not exist in the block and can thus abort early.
+		 * In case it is equal to the sought-after key we have found
+		 * the desired record.
+		 */
+		reftable_record_key(&rec, &it->last_key);
+		if (strbuf_cmp(&it->last_key, want) >=3D 0)
+			goto done;
+
 		block_iter_copy_from(it, &next);
 	}
=20
--=20
2.44.GIT


--00gATv1vjKrA/mz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTaEACgkQVbJhu7ck
PpQGJw/+J48rSe27NmzMV9oG47JGTfZgf0PyEj4z1x8ISwSViXUJRWqZNhkD96jK
H/KKXcaQSKfF1asPpZkowJl5Gri7g9AnWWSWXMC4l03pZPr4Yy617ALjeDAV77Ja
30iaC2ANPcMvicVgL1QmcoJDqpoK1U/VyvPnrL+pYW37xRBQyf09QatsNEIB5shk
OQlr2RrO8Ikls+qh/e/JEFL22u8Rmedl87z+Z9RgrFAdZ7cx8+15ZpuFQTs0itG0
CH1NiXVOyyOIl4TVzNdHLA6TIxQSRdtHMkDYhAi/4l1UuRn05dFGJuAjEVqhwVAS
CLFbJakq4VUsRXU2lKU+K7jHdfx+zhpbHWrBxx8GVt7XABwYa568txFZvCRc/ICk
DRzHadIDwnC5hDZ51onruA8qWjW7C27W//P8D1aaBklB45XHLxSkUNl4PjMRWkL+
IOuVS+wDQu6POxt+B4pblB0zsCkGs9OFAYy084SDRfEXdchJpwyx7keAd03JNX6I
k5UqsfaSupME/tD0dfR+iUmq7TfLCQiXqAWkQlCIZNHW2Ae5GEF6ug0JV0HZIEIG
9hXwnTd00244rzzir/6Cbb1dBeklrGT6bN3sW3yFPom9ZqR4LkgrIBBAH0b4GHoG
7lUv2xK/RmzNrhBfsZZ2xxvoi2WEBl0nl+M3faGJ5mDOJXvYuwQ=
=dKNG
-----END PGP SIGNATURE-----

--00gATv1vjKrA/mz4--
