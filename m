Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE324CDF9
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124259; cv=none; b=diKLLz9EFXnOao+VnRi2h38ew22wJH7z+g2Knru3bWE8nC061YLs/KEUHxf+LmkKdHXSE3VkqENsCNEKsFhNneoeB5ajTgNHU2+XN4vJQA+cJ9WWm77QJ6wkxj+ln11MONTJgOX8gA4dbnE/Ou8iWsEwvDZW6gxwxVGk/rvpPB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124259; c=relaxed/simple;
	bh=3UtKotODABPblYgwSHUgqcSnTML6ASa1GFNwjRSle6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBKx20KPlWojmNxNaUKgmtT/jM6AWZwfZ35S9UzKdpgk4l1S1/97udvqGgPtE8ra7CRUpYXqguareKsMzyZAPGUA6TUI6eTXSbT5E70mX0OOM+9A7Y361MqpTFczyWAVBR1YOXgLRiSClHpvTYFEV7YjaWuOLGZHf3RVnFMZA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kXcmozT8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NzI6zTSv; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kXcmozT8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NzI6zTSv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8D77D1140101;
	Wed,  3 Apr 2024 02:04:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 02:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712124256; x=1712210656; bh=vjEflN+rEy
	hf+FQQLxxVuM1+9uEF3dgx5yt4odH0rYE=; b=kXcmozT8j405cEM2tI7qRISo2s
	AJlLYfF4pWZjHpOD8tx+biWVSceXWF8N5eGRpSN5SMeODKX1posJ5wXEHWBHUqGU
	TjCeFoY1r41u0Pm+pGTMoyubU20WPB91TLo8wl4XVAeNuD54OYBc/R7mCTz5l9Gl
	2+LGu3p1N7cBw73HAaH6Eb3cPCqh6560RQMiQ69+sjtQ936byQfXIjXIakj8QAcD
	1ijClZCjEVLA/OIHUHQtjDodR4EGDQz9ftF8vU1OEmBlM7Osg/otJJNLcUu2EFZH
	GZCKcfM6NzcASVmbvW8yY6e+nSzEV0IZjsnAigWefWAnEXecPTUj8BIZUKkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712124256; x=1712210656; bh=vjEflN+rEyhf+FQQLxxVuM1+9uEF
	3dgx5yt4odH0rYE=; b=NzI6zTSvgUD6XKTMc/LS/QAOrrUWV99HBBt2g3QX075L
	pJOwPfcqEfPJx1++OaJmlcjNl7UmGuS2xmK2dWK4rB+OIkfS6888aaZsHFfrvc0k
	b+YrUeNT8s2+Uz2ZLM6VuYeIgYIhJMHwlxVo51PP318mMRn7N+pVSBSEEJFgGKLN
	K5qfNuiWCWYi0oapCBJmrQNIV8cdjjZCUOVU4n8bHe4HtivYolgTKCLX0zftnv7o
	J7041dHU8+85s8v6SjipzGmiczj07FXjRR0L6vOyqdkMnQh+NVpt8SFo/RgQ4C81
	3isIGTHOPuOXr7nihRPdpQc3dulO/F9oHyWHzW7MHg==
X-ME-Sender: <xms:YPEMZlIP61QizAFIVtdL0YlzOkM-yK1wTl4yO2294BfbiXKhEtpt0g>
    <xme:YPEMZhJOZ9sHyYWdbkQhKV1qwXZxpNFMeBvzgkUPmoB7t6rzNd1lMB9MFSNACH8VF
    PU21dbdJQNZE4RK7Q>
X-ME-Received: <xmr:YPEMZtvBGMcScNDJqybRoZM8IaeAJbMYgYqwxRezDHjnuF707Xx90G3bmZ6KLXShEUJZSS73q0YTsX3fC1cZBLxwVMHid-cTSH164DcqYq5ngw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YPEMZma4fOhJyb6IcNh-Mmv5RNABYlZwkJd-3kXdogOFl6ftz1Ek0g>
    <xmx:YPEMZsbrEbnADPxbruCoPPmXqq0qzoGV62De1P5JDeYoKuAbpp5yOw>
    <xmx:YPEMZqDj43VqYX3ZoO-OBi20Pe2fiWT18esjZ-WSyHpgpomPxvnIVw>
    <xmx:YPEMZqY8p_qstIJwwdCS7g_fopDayW32C-Avx4o-Ta0O1XpC8efqJQ>
    <xmx:YPEMZkEdiehUj51e0xQjwFDYZpYVaBINjjGPJVHdHBxDFFnoxJGJbiR1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 02:04:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 61be2e93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 06:04:06 +0000 (UTC)
Date: Wed, 3 Apr 2024 08:04:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 4/7] reftable/block: refactor binary search over restart
 points
Message-ID: <6d4a79f3e26f24e8eeec9abcad1d7fdaa3d6e252.1712123093.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712123093.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r+A92ctzbArVFvJI"
Content-Disposition: inline
In-Reply-To: <cover.1712123093.git.ps@pks.im>


--r+A92ctzbArVFvJI
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
 reftable/block.c | 100 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 73 insertions(+), 27 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 422885bddb..57e3dbf658 100644
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
@@ -390,7 +392,38 @@ int block_reader_seek(struct block_reader *br, struct =
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
+	 *   - `i =3D=3D 0`: The wanted record is smaller than the record found at
+	 *     the first restart point. As the first restart point is the first
+	 *     record in the block, our wanted record cannot be located in this
+	 *     block at all. We still need to position the iterator so that the
+	 *     next call to `block_iter_next()` will yield an end-of-iterator
+	 *     signal.
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
@@ -399,21 +432,34 @@ int block_reader_seek(struct block_reader *br, struct=
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


--r+A92ctzbArVFvJI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM8VgACgkQVbJhu7ck
PpSBHBAAjztmWP2uTsV9p/h5FqM1XMkE0s/KVBTOMKkgz10I9kUcuLDv4rm543LO
XTEY6iewCogTGsY3/YqhCQ0/k5muGAtJSSF+jJQjCA382jXkxNHlRMcTYdabrh7k
nwgUHiZ0ZT0NUJC8ml4aWLv0SZCT5EQ3ejKYVXmF57PqRq9IqL9SCRpzrAltVcE+
Q9+ZJ3nU1z1YclUM8g1KNp52i4SjWvVvgYTn/T35zSRHffDcm/ms/LG4nKsK0V1H
S2ksypjhN4sMMHFiopNs819GdZ88TWnWDU5HOzbJTF5DfOgI+FuEl3pUQ/qi3eo+
q/tw8YEqAKUs6YlStmdPEvWMtn+hqZOHSosUuQKBEfORriFwoY3vl+KWR0HowdQ6
Z4FJs3ICvFlqoaC4AkepoNYeizCgCyt7HXE6RXqbnOgtUzDH8AoeIj/n5C1FokzG
FNXIUJPLYyDUlyUwn1prn2+6Wi1r2vUx7UEgycvMUnOc8JAiMdPZScD2ItBbv1xi
pSFDzUyHbsfwxIJrLy4pKxsVvwvmGmZLSUOlqI9xlY7KGUbSub1mVJAoOnnOYaIc
7L0wWJDeqEz4Nhx3JScZpqV0eE3jWDLq1DiXT2mQlj2X6qP0MBxDwxpB2S2Da4uH
l0V7GvLsiZzGTHkhWRvMbQ5aihVWpmIUbdbT6QF3XCxDIWusuI0=
=O7dC
-----END PGP SIGNATURE-----

--r+A92ctzbArVFvJI--
