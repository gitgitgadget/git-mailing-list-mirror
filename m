Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C723769
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521455; cv=none; b=VUo6BK2zzl6wXIEPNOXgyF9gYWBVVA61ZMb+W3O+Y1tkyc6kkIu3feNMU9TSZdNys7AxYndFKejJQ5qo3pWqvvQbjuwKPcoHcbmwvQjXDgc6GKiyiXziSBv2Iri1FxIH/z5voq93XYcGXX6uwBdBKB2S6k8pCj8/2OAu6cCK3kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521455; c=relaxed/simple;
	bh=opKEGYfe1dRDmqOUnvYMfxPq9Erf9gJkk7J+ZcatUZ0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di54L8uN+v3YWZFFVx4GK4OuV+6yhw4pms1/Tute9hlT0bqElEdcEYcdM4lB66Klg/RpW6Ndm52dV4J5/SgOkNP5YXuiBJeat3FaCY093JDx7SpLi/336BfudRX9DCE+yiHJ5kAqfY/A+zXzNqHaqifEBkwSm8HLj3OwWpHUjkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EvT0iotu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptHhJ1Gp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EvT0iotu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptHhJ1Gp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A418513800C9
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 27 Mar 2024 02:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521452; x=1711607852; bh=TvE1UOMKol
	Sabs2BT8/D318MI+1rZEn5GdYTeMQe3qM=; b=EvT0iotuVRdoqgaLVkaEpgIjVP
	9HxDhVWStcym5HAKMHx/8+PdhSdvrdcqGOke8Mz/o2V0pv9gnQpilmLRLhGlhLf4
	hh/f6HP9HmYqvXIUo1em4hdVYNhQ0jijz8PTOlux72T4ZgzjfhG+9Huxp863b1jm
	w5VYmzwGvHbLuya44ds8nUa0gY0j9gRv9gNUsYqukftXUop7GwWPlWJQ9jQQVG4e
	0IFhWcFrY/CbSWtQ5S2TVHmtWHJPqOVnqCdJXiW1p5bQD2XqWtWrWh3EbyoWDRaO
	M/FQ1HDl8WljdmYAYEcaKWCoWi8JJwv07O2A29F5drPMXOeuOtlikSDC/Aww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521452; x=1711607852; bh=TvE1UOMKolSabs2BT8/D318MI+1r
	ZEn5GdYTeMQe3qM=; b=ptHhJ1GpKrpyjwm96R+AwmVc3H1oBoSXzsItwEr7EbPh
	7V2NgJwvoyixBVQ56lKk5hRHR14UXkoJIgStD1+39Xm/knMaOS7CICd+QzcWrnGB
	abth9tQ6mVGe6euYteFghlheC+DZFEQDwYhhOARzQWnz2GzBu2C2KrBvjHf1Uz4f
	BM9ke2MNdrgJdOHKaaQUNPtepeTwJmS5iyluK+Ge66BxCLuKv7AJezOwAwrvFybL
	Vi9qYjvQ7moxjXQyg/uVWu3gOPomNGhRM6C2XQ5j6Fnz3JqULFeQD0FYMnwlTwkU
	wQNpzLyRWs5TBn0t5+A6q/Fs/S67qqD3DlKiTVLAgg==
X-ME-Sender: <xms:rL4DZt1mRaE0nqZUUL-AqYOYfgBDrZSu3C1JY-0SkdaS-FEAdg1KXQ>
    <xme:rL4DZkF2qcbMM4duey1vRga-YxNLTTnZb2ahEGaymDAX8EQsiyCoGozTrXswKYkw-
    n1P4eP5ttLwuBY1Kg>
X-ME-Received: <xmr:rL4DZt4Xsi-QQZoN5zWprwdIJ6_jEBIGjRO4tyMBrCLpAzZV11EAqrgCQaiIZkChrMQYBCfhuWMFuHOcwmIwmcEnH9DYPg8Ccsv_ubjuFeM4KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rL4DZq0J0RnRcV0SEt6Q8dsZR_R9D9r63NCR81DvQOPA8ZOIiv6MnA>
    <xmx:rL4DZgFRcvqgkTCIxtwmj0EN_7674DCtVx8qsQEiuMdxkOCc2CKh1A>
    <xmx:rL4DZr__RWOkbsNLuQLR1ltDpVPoJOV21MgJT9yCYNMSoIhInrJvYQ>
    <xmx:rL4DZtkPRQG2_AGQr6pDfw3ebx3BFQQ7ajXuahOGVVeV6FnOCR7mcA>
    <xmx:rL4DZlQd_Fnt3WPpe7XiKL8Om64MwsxNwV-KFhjDwGMMNPw86Y4SAA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 27 Mar 2024 02:37:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d4ddc901 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 27 Mar 2024 06:37:18 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:37:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 9/9] reftable/block: reuse `zstream` state on inflation
Message-ID: <43e6538968bbd4a0bc4217ebbaa834a98e2020c3.1711519925.git.ps@pks.im>
References: <cover.1711519925.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HwSU1J0Dg3OzcpUD"
Content-Disposition: inline
In-Reply-To: <cover.1711519925.git.ps@pks.im>


--HwSU1J0Dg3OzcpUD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `inflateInit()` and `inflate()`, the zlib library will
allocate several data structures for the underlying `zstream` to keep
track of various information. Thus, when inflating repeatedly, it is
possible to optimize memory allocation patterns by reusing the `zstream`
and then calling `inflateReset()` on it to prepare it for the next chunk
of data to inflate.

This is exactly what the reftable code is doing: when iterating through
reflogs we need to potentially inflate many log blocks, but we discard
the `zstream` every single time. Instead, as we reuse the `block_reader`
for each of the blocks anyway, we can initialize the `zstream` once and
then reuse it for subsequent inflations.

Refactor the code to do so, which leads to a significant reduction in
the number of allocations. The following measurements were done when
iterating through 1 million reflog entries. Before:

  HEAP SUMMARY:
      in use at exit: 13,473 bytes in 122 blocks
    total heap usage: 23,028 allocs, 22,906 frees, 162,813,552 bytes alloca=
ted

After:

  HEAP SUMMARY:
      in use at exit: 13,473 bytes in 122 blocks
    total heap usage: 302 allocs, 180 frees, 88,352 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 25 +++++++++++++++----------
 reftable/block.h  |  3 +++
 reftable/reader.c |  1 +
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 31e7255056..2e39640b1c 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -198,7 +198,6 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		uint32_t block_header_skip =3D 4 + header_off;
 		uLong dst_len =3D sz - block_header_skip;
 		uLong src_len =3D block->len - block_header_skip;
-		z_stream stream =3D {0};
=20
 		/* Log blocks specify the *uncompressed* size in their header. */
 		REFTABLE_ALLOC_GROW(br->uncompressed_data, sz,
@@ -207,16 +206,21 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(br->uncompressed_data, block->data, block_header_skip);
=20
-		err =3D inflateInit(&stream);
+		if (!br->zstream) {
+			REFTABLE_CALLOC_ARRAY(br->zstream, 1);
+			err =3D inflateInit(br->zstream);
+		} else {
+			err =3D inflateReset(br->zstream);
+		}
 		if (err !=3D Z_OK) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
=20
-		stream.next_in =3D block->data + block_header_skip;
-		stream.avail_in =3D src_len;
-		stream.next_out =3D br->uncompressed_data + block_header_skip;
-		stream.avail_out =3D dst_len;
+		br->zstream->next_in =3D block->data + block_header_skip;
+		br->zstream->avail_in =3D src_len;
+		br->zstream->next_out =3D br->uncompressed_data + block_header_skip;
+		br->zstream->avail_out =3D dst_len;
=20
 		/*
 		 * We know both input as well as output size, and we know that
@@ -225,15 +229,14 @@ int block_reader_init(struct block_reader *br, struct=
 reftable_block *block,
 		 * here to instruct zlib to inflate the data in one go, which
 		 * is more efficient than using `Z_NO_FLUSH`.
 		 */
-		err =3D inflate(&stream, Z_FINISH);
-		inflateEnd(&stream);
+		err =3D inflate(br->zstream, Z_FINISH);
 		if (err !=3D Z_STREAM_END) {
 			err =3D REFTABLE_ZLIB_ERROR;
 			goto done;
 		}
 		err =3D 0;
=20
-		if (stream.total_out + block_header_skip !=3D sz) {
+		if (br->zstream->total_out + block_header_skip !=3D sz) {
 			err =3D REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
@@ -242,7 +245,7 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
 		reftable_block_done(block);
 		block->data =3D br->uncompressed_data;
 		block->len =3D sz;
-		full_block_size =3D src_len + block_header_skip - stream.avail_in;
+		full_block_size =3D src_len + block_header_skip - br->zstream->avail_in;
 	} else if (full_block_size =3D=3D 0) {
 		full_block_size =3D sz;
 	} else if (sz < full_block_size && sz < block->len &&
@@ -275,6 +278,8 @@ int block_reader_init(struct block_reader *br, struct r=
eftable_block *block,
=20
 void block_reader_release(struct block_reader *br)
 {
+	inflateEnd(br->zstream);
+	reftable_free(br->zstream);
 	reftable_free(br->uncompressed_data);
 	reftable_block_done(&br->block);
 }
diff --git a/reftable/block.h b/reftable/block.h
index 79275d67f1..93f4338771 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -56,6 +56,8 @@ int block_writer_finish(struct block_writer *w);
 /* clears out internally allocated block_writer members. */
 void block_writer_release(struct block_writer *bw);
=20
+struct z_stream;
+
 /* Read a block. */
 struct block_reader {
 	/* offset of the block header; nonzero for the first block in a
@@ -67,6 +69,7 @@ struct block_reader {
 	int hash_size;
=20
 	/* Uncompressed data for log entries. */
+	z_stream *zstream;
 	unsigned char *uncompressed_data;
 	size_t uncompressed_cap;
=20
diff --git a/reftable/reader.c b/reftable/reader.c
index aacd5f1337..481dff10d4 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -459,6 +459,7 @@ static int reader_seek_linear(struct table_iter *ti,
 		 * we would not do a linear search there anymore.
 		 */
 		memset(&next.br.block, 0, sizeof(next.br.block));
+		next.br.zstream =3D NULL;
 		next.br.uncompressed_data =3D NULL;
 		next.br.uncompressed_cap =3D 0;
=20
--=20
2.44.GIT


--HwSU1J0Dg3OzcpUD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvqgACgkQVbJhu7ck
PpQeAQ//UJLUSUWBjLiZvVesTI/YKmlmKEr03Xr2dsa2rvyTNXSuAIYDsoaXVyDh
niB/Dbr4GebbblM9AT7JBgglv9+9Br+EgwNsYCK9CggjnaLoeaZ50MYlbvS74WWV
G0n8Avhm3D0WgLT+oE0bgbQ5mwo2x2CWajGevuqxgrc/v5q+bTd+MVEuuJQg/v4i
YY0R4S1DEkO2BWPzER8gY3Dy9m5V+rrxbmAaA84ISsLy9G9YIKcXuyfZ8Q9OOzoI
iz7ikPtD8Ln8SdZgwxV6OtbhWoojhvN463waVtFypB9rcEb+/oJaA/16gbeXnuHF
3tSye8JDyullIhcqPefo8DrWHXCLgSlvMOQ9V9IpnUI1eS5Au2u8bMY6T22tai9/
Zv2NpucpSzAjt8cYSW8qq9vUWX8Qe1fKTCJr3bW7oxzDwpSopO3X/WCjRLIm96Nu
NsqLy/TsofdOLi1pRvxQm6I/Ps9Tu5nzoSfCHPZTk/KzoY8a8bCpnq+wesca3AZf
nYgn/PFK2MkUtbbdLZkIOxhKYs/Mv5cCqd0Mp588mbaQ9Ir8VHOo4BNtmTYw7RgR
8cEGSrodspK9SpAmewevtE7hAkyaxNP0eaDjP42WkvyBGOKfqYg7bcC+fLLEzyBQ
nzf2namAU/GhLsyuLVu+vnwx3vk+8iURsGsrYVnMDU0LOuU+83s=
=SnVO
-----END PGP SIGNATURE-----

--HwSU1J0Dg3OzcpUD--
