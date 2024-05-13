Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65B147C88
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715590038; cv=none; b=mHH5ZhPP6toMB5S3U8Nnlc98mlFgG5pyIlCOKwaVT26tSQ0jlCapH8/i7EIMoEnyE63ZlipEDqQTJcImTdrahxbOnJjNada22nI/2lDs6PezQCWuRbP9ngpKrahEZ31Hf0fO689s11F8Sr1aG4+fUz/FGNMdiCU47vCC5LupwlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715590038; c=relaxed/simple;
	bh=RkT5upg2N3jlXzXX1utzuF3wWYpP21nbkZZFBAdhQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibl/Q9gHjw4xWESloBGFnakJCLXOuJ3yx7c0qV6glagzWBxtAC6nUlaPkV45DF+h6393uIa8Gdw6VpbMrPZgJRmbB+8nWmbYNOa1qOpV1h1j62xLA5TcGhqy74aE1uVnLv2qKzC6RMYhc1EpysxEribCaq5VGk/nO8r00ETyXZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J8YRXz0B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VSds1IU0; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J8YRXz0B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VSds1IU0"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id EA5B0180013C;
	Mon, 13 May 2024 04:47:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 May 2024 04:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715590035; x=1715676435; bh=kL+ieS8zjx
	1w8se1Ln+W441riKCQleRbZAJG/7Uhnn0=; b=J8YRXz0BGNWx7ErHfAt1auQn1Z
	/KcNhpar5Skdb5vbpeC2LYQ5Flle3fM6pf9AbZ8wtWzcAJUj1IrJRFp0OrbfvQlU
	z+eQPI/ayOLUrVwN2LxDQ5euoq5janRgshnEOVMHMnm1Qbp/nx593LPoQnNDcdlt
	ft8+MKi6u+ANTfogOyw7I/MLayOFY8VeVn+KGM/1YVx8jJi1sHEZ8Au6jiVmvbiY
	/3Y4MUl5vNM0oK2pvCrEmMQUpt+m6IiWOwJegPCb59FGLgAfK39wzCORt9XyszIv
	30ImRi6mgMj/S5NlGxDH07i/HK9oHGjEQ0yJ1CDdefiJXZU8VDy8Fdhd6Wcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715590035; x=1715676435; bh=kL+ieS8zjx1w8se1Ln+W441riKCQ
	leRbZAJG/7Uhnn0=; b=VSds1IU0jQdNj0znodBcWrW/BgcjQz73Mr7dwHmAkBFF
	DNA9Kr2Vak9Gm95LBvQQFpjY1BffI6K8I0b2NnH8Uj8wdASyomiL/s9tZ0aaQBrV
	Dt/G9JQ8kBSOkzYmvWyCZEV0K0o/6kSXKQJm2/z08f/XzFd8uqrQpcQRCB+20E+g
	XWo6ZvjefFsllPFZEcQXoUMwxhvE9bHCpWga5ofWjFj+hMLNKyncyyxfj0JM8dVM
	N/fniiocfzFLMqJ/USpFsxmtpJznL3SbylfmLsj3kioCg5aqmKLSAyyibcGCOubl
	me5fAEGt6GTez6p3uPT8qYvN4taz4IOQX9y6gJH+FQ==
X-ME-Sender: <xms:k9NBZgeFGffShCONi3GFl6w0k2E3puBFcgbDJp5qC31P2hulcSwe8A>
    <xme:k9NBZiMKzB8V0VTNjpQOZNi1XZZxjwPfD6rkFjgVcYyOWqbey1hxXmDnJ_5tCkbvR
    Yr-5dPAsvYqGTlTDg>
X-ME-Received: <xmr:k9NBZhgboIRM4h5b13goXED7rDvJHwIhDcXxGo5graywDlLKYr8O3qQ0KySun_lbOttEqAiyQdWuqdDcBMCB6jcWtj8m56ynbMWaGdF2GkaTTFI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:k9NBZl-Fhl-BY77oZjfRgiDwcfGsMiYSWQ24ApVKlqOAu8J5GFs6UQ>
    <xmx:k9NBZsvn8RmLd4GnTcBISG6z5GDW-BCMp3d0I-_tOQZkKZ5Q3i9DcA>
    <xmx:k9NBZsGvSpzjs8FA6jNQKq0ERUEOP4uxy7zQ0A2RIY44oORnIVrhSw>
    <xmx:k9NBZrPMPXzW4HQrU0j350pnnPZrR66x0AR6_Gw0yoSU89SR3hQfEw>
    <xmx:k9NBZoLsVrTdXORQgu72cSfRnNS04kbNDpufDITXDGYbOBGdrRQY0dRE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:47:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 78277313 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:46:55 +0000 (UTC)
Date: Mon, 13 May 2024 10:47:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 03/13] reftable/reader: unify indexed and linear seeking
Message-ID: <716863a580f9e1ef8ea796c25c97e50c63585a7b.1715589670.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
 <cover.1715589670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7g68tUQntogGc2U"
Content-Disposition: inline
In-Reply-To: <cover.1715589670.git.ps@pks.im>


--z7g68tUQntogGc2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `reader_seek_internal()` we either end up doing an indexed seek when
there is one or a linear seek otherwise. These two code paths are
disjunct without a good reason, where the indexed seek will cause us to
exit early.

Refactor the two code paths such that it becomes possible to share a bit
more code between them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 6bfadcad71..cf7f126d8d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -425,7 +425,7 @@ static int reader_seek_linear(struct table_iter *ti,
 	struct strbuf want_key =3D STRBUF_INIT;
 	struct strbuf got_key =3D STRBUF_INIT;
 	struct reftable_record rec;
-	int err =3D -1;
+	int err;
=20
 	reftable_record_init(&rec, reftable_record_type(want));
 	reftable_record_key(want, &want_key);
@@ -499,8 +499,8 @@ static int reader_seek_linear(struct table_iter *ti,
 	return err;
 }
=20
-static int reader_seek_indexed(struct reftable_reader *r,
-			       struct reftable_iterator *it,
+static int reader_seek_indexed(struct table_iter *ti,
+			       struct reftable_reader *r,
 			       struct reftable_record *rec)
 {
 	struct reftable_record want_index =3D {
@@ -510,13 +510,9 @@ static int reader_seek_indexed(struct reftable_reader =
*r,
 		.type =3D BLOCK_TYPE_INDEX,
 		.u.idx =3D { .last_key =3D STRBUF_INIT },
 	};
-	struct table_iter ti =3D TABLE_ITER_INIT, *malloced;
-	int err =3D 0;
+	int err;
=20
 	reftable_record_key(rec, &want_index.u.idx.last_key);
-	err =3D reader_start(r, &ti, reftable_record_type(rec), 1);
-	if (err < 0)
-		goto done;
=20
 	/*
 	 * The index may consist of multiple levels, where each level may have
@@ -524,7 +520,7 @@ static int reader_seek_indexed(struct reftable_reader *=
r,
 	 * highest layer that identifies the relevant index block as well as
 	 * the record inside that block that corresponds to our wanted key.
 	 */
-	err =3D reader_seek_linear(&ti, &want_index);
+	err =3D reader_seek_linear(ti, &want_index);
 	if (err < 0)
 		goto done;
=20
@@ -550,36 +546,30 @@ static int reader_seek_indexed(struct reftable_reader=
 *r,
 		 * all levels of the index only to find out that the key does
 		 * not exist.
 		 */
-		err =3D table_iter_next(&ti, &index_result);
+		err =3D table_iter_next(ti, &index_result);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D reader_table_iter_at(r, &ti, index_result.u.idx.offset, 0);
+		err =3D reader_table_iter_at(r, ti, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D block_iter_seek_key(&ti.bi, &ti.br, &want_index.u.idx.last_key);
+		err =3D block_iter_seek_key(&ti->bi, &ti->br, &want_index.u.idx.last_key=
);
 		if (err < 0)
 			goto done;
=20
-		if (ti.typ =3D=3D reftable_record_type(rec)) {
+		if (ti->typ =3D=3D reftable_record_type(rec)) {
 			err =3D 0;
 			break;
 		}
=20
-		if (ti.typ !=3D BLOCK_TYPE_INDEX) {
+		if (ti->typ !=3D BLOCK_TYPE_INDEX) {
 			err =3D REFTABLE_FORMAT_ERROR;
 			goto done;
 		}
 	}
=20
-	REFTABLE_ALLOC_ARRAY(malloced, 1);
-	*malloced =3D ti;
-	iterator_from_table_iter(it, malloced);
-
 done:
-	if (err)
-		table_iter_close(&ti);
 	reftable_record_release(&want_index);
 	reftable_record_release(&index_result);
 	return err;
@@ -595,15 +585,15 @@ static int reader_seek_internal(struct reftable_reade=
r *r,
 	struct table_iter ti =3D TABLE_ITER_INIT, *p;
 	int err;
=20
-	if (idx > 0)
-		return reader_seek_indexed(r, it, rec);
-
-	err =3D reader_start(r, &ti, reftable_record_type(rec), 0);
+	err =3D reader_start(r, &ti, reftable_record_type(rec), !!idx);
 	if (err < 0)
 		goto out;
=20
-	err =3D reader_seek_linear(&ti, rec);
-	if (err < 0)
+	if (idx)
+		err =3D reader_seek_indexed(&ti, r, rec);
+	else
+		err =3D reader_seek_linear(&ti, rec);
+	if (err)
 		goto out;
=20
 	REFTABLE_ALLOC_ARRAY(p, 1);
--=20
2.45.GIT


--z7g68tUQntogGc2U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB044ACgkQVbJhu7ck
PpTuBxAAqYRgzGOvGzvd+p5tYAhr/ZTbsKzoYDWayxlKjnfvqCWCkIYihhvWvxvJ
TjVIoVWYNRMpdddtbM4ADe0prE95LxZT0RbgrSpGiRrJ/NZlBkj6/NJ2+7TUPBVq
VH/n4zOezbjTiq6WNHLGCxs9t3hCzfF7lAMrTzq+3c9aJzX4s0Q/YAYB618mrjMa
J9osMNw/L0fKRtr1BngyJL4V5S/6C4Kher5bx5rdO0ZJf8fzZTbpObTgE/12UukH
S/7fhZWR7DyTIqeoHHG8skS9ySzCwAmmjwC2yVb/oCeeUeEkx/Z+m4KjqAQGRkYA
mW6JNVlfRCSV072wBRw9HZsqpOyBP2+Z8Z/aMKY1kmkZKi/W9brCaukfZpmnxFOz
aSJQqCtRBTf4TKEtSSaanWAKsNS3RGca5Fv4eqLJ5bITBoPFRZV+5m3ZYh+SzliR
Fmf4L6an/7sLW30uNBD/yVqU+mqgdwrQ69JOsXGhXZa3ThdsZ2sUeGsdA0POwmny
4NTGCzN7/j9RtOZlKUq9syd0MecThUIxGx2eouXeKTOOAHpxXKxXoz5haB5TS7Mv
ZjQLzj3ixP1nsfW9Ite7QBDwZLmEOIOjQjj9r7QV4/QcwWKGyCZkDM+5/h17Bcot
QsE3V7Dfy6FpG+eoEXZlAhMZpYe4lK6QC8VHrQNVYzkdu5O+0Nk=
=deED
-----END PGP SIGNATURE-----

--z7g68tUQntogGc2U--
