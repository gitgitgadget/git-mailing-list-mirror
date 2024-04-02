Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E499215A4B2
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078699; cv=none; b=DWeOg8mddp113f7J4EfvoCUU5PA5JRlDVQCsl04T6lox0JR7lntRv4VZUlW+enFEUgHEKnQpQuUmRSuxq69Nqc6XAFQ70SKSn8tzPniP4Ei5r/4qj/JK2Y+scOY54Bl/W+c3dneplGw2WsQyDB4uOn7M0tXEwLibiGTAYOscAbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078699; c=relaxed/simple;
	bh=/heaQc/7XQY8eyVSeEAnNBLnMcwnF1jReptKUbyPj+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z241aqFHyQ5BLwybmMkglv3SDT5hiJGpQIM3Rq21C+WqipLxEUyFJG+SOaKNLgOdGX3ui+ZLPcJbZ/NhKZHylinCvuEAfRxVx5aQk4jnQsA5jWVQd4+vWf3QfMonUOxUYwxmr+/oTX5NcLiNNtTQhECu4WQnRwSoIaW1ouCsHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hp16MD6+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/Rb6YV6; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hp16MD6+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/Rb6YV6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 294431C00082;
	Tue,  2 Apr 2024 13:24:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 13:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712078696; x=1712165096; bh=gsTWtaNSrM
	K8v+xL0MxE58SrTEnQXoN4Io7/R9x2aBI=; b=Hp16MD6+OMXOK51xGeyXnb2qBD
	7n3oIAgwyYCC/UqnS+8H0kyAFi5lqClLRmXPdfHBRLpakAFYAZmxK4ngeqq/uK6U
	kc3/+gpvKQUsyPcsUAArnXkTvLs2sR9DJ9caTIOs5JSOr8DmGL+hLp2MZR5Q/87v
	VPB4CRLOXsVewwVa/m9gaGZUMoP9ePM1cR0QkpcneQkRc+yJIXqx0FdUxiTMoAj4
	1kzHONAw2O37gdTrqN3axFIsY2ExaCdrOJIjixoWZn3ZT6W5L08O/QFcqTucLXwb
	/zbjPVyrCDHi/LeDsLZgsW97UMde6MDVL2qkIGrD+zGJ0aDOrwtc+IQBZUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712078696; x=1712165096; bh=gsTWtaNSrMK8v+xL0MxE58SrTEnQ
	XoN4Io7/R9x2aBI=; b=J/Rb6YV6Ho3tms/DzrHYjmSijEgrTfJhDU04jxRVCpd/
	MJYuX0g1/1/6QfpUPYFyJa85CONLErHd76MadTiBrCdG6m/ZmScfOy8baMfI18lc
	EAjABB7ClDlqczui5Xo3kCejOrjJUQ6ftD+TzLpPEDQocPgnvGUGAz/wdEozY5T9
	TAJQIwlxr3sNAuWxg+5DNpw/Z0vL7Q3BlrSsiGy17quRAtsaSPOB0bpytO/deoH7
	LFPKr8zF8xQ+z9cxHhh/yCXf96/wXZusSw1BUruwyZxz9ZcwQ2RfAQu2CjDmPpBz
	Apl9spzD2wBRhnAHkbZTCU3TVg9HiCxgdFnhgH/LWA==
X-ME-Sender: <xms:aD8MZnqkGvkcjzvgrWy4H24F8fbFO-1AIQk-YXlhfWEaKzWETFAJnw>
    <xme:aD8MZhrAi7QugOugJu0hqmPM2JFUXMOIb2hr-FCC3cfZojMVPVSyuqZ9Jwd5hG7RV
    qsPhY2BiB3stTftNw>
X-ME-Received: <xmr:aD8MZkN_cAnaKSHe7IpHj57fqbVecuLFsusKCRLqSdrodXUKE2yIQ-g5p8Vzygxpe8tjWf1laxGp1pcqg83XfXsJewYNp84W1_lEP29BFfPCSD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:aD8MZq7N48coZTxswIK7BLRmzoN62wh4XSXdKta4ra1MINSFVLEdsw>
    <xmx:aD8MZm6rdIOjtpqC3hAlvukgTt0eEXCRZ4KbhJY68M0xgCNiO-Z_uA>
    <xmx:aD8MZihuALkH7BmF8k9raQA5JXK8m-Hn1yZM4vdN_4tkfq4hdpqzOg>
    <xmx:aD8MZo5opNfC3pBqqJc-v7WOpJqgtjGt2vAFZ45EKt0mZjG2-YLJeg>
    <xmx:aD8MZslw6ca1XoxPZmpXkLVc96HzRhEOhKbeyy-gbmy9QjLC1wOKPZe_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 13:24:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3938415 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 17:24:46 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:24:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/7] reftable/block: refactor binary search over restart
 points
Message-ID: <435cd0be949d65f53d2ccd1cdbfe13f097af5e50.1712078263.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
 <cover.1712078263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/rCVGCNhyKTSGhkV"
Content-Disposition: inline
In-Reply-To: <cover.1712078263.git.ps@pks.im>


--/rCVGCNhyKTSGhkV
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


--/rCVGCNhyKTSGhkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMP2QACgkQVbJhu7ck
PpROIA/6ArHpyZTQBVJZMOHMGi5W57+PABlGYDUm/uCSqnFFmY/ad5h7PLXPSuYQ
MAkUcU8xHH6yiEN5O0bo8rFR96KTxvMDfldBzl5OU+kv+6Eo0qFAFtLixf9CwKot
dB2efpvkpMbMT/sINyMWlhL2PxRewvb1R2f9blYsK6+iop1IhLYDvM1gx3tfn0Gv
BXrfZyxaR/xw94xv0/qBsZFeI5AYWVmo4i+Fpf1K3/lexW41Lxc8Dix+/d749IZg
gTwmhHYg9wD3hXsXzWoTWCAL6dAVrpJw5QSKFfrXFXOYsssJesfsHZg+1euN+80x
ivEwRanErPcYBPuamiUr8BR+iGL/nJWNjokFYDFlMYHgn5h3GkncdjBobBDWgFiH
HU8Mmu+iaudab0SU7EfM1mjy4gRC1n1Y2cQy2nrZY1QKBKzLKy8TGwA+DPOIlVo7
KWxrR0FUJohDgzNGwaLBNNjEpQwX+Mht64NfWpxpcIH7Ed1q2ES8nhwnHVYR689o
ZsQ833MYOK5zWtmOOIhptjc9Dr8LTrAX4E+q9OLjsOlMCY8S2VHcPCne5XgJe7t2
jjxJGSFbxYvnDNVAhedr9NiPhmoXeOt2+P8xrTZBJz/5i8v7bArgTfWMZ50DudCE
gMEbO4Z7BYrzPcwokY0m6XvYPOH5MX/TyYmeFkPuZQP8auedq3g=
=+lvC
-----END PGP SIGNATURE-----

--/rCVGCNhyKTSGhkV--
