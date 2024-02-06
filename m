Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2C127B73
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201347; cv=none; b=fu2dZCET8Jx5YtLAHAOIgkbuVWNUveBY5f7LP43ACouZqi+G1HTQC7TATER4UHj2J+xyXD4bXjyY4nISvZzag5HUL4X7j9hjp3wtwBoz4LQK0xAK9j0LWeIOZFlWHmWtubunFZ1ueoTg7uCyyCpYdKriufOgf0OyAMR4B5qE6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201347; c=relaxed/simple;
	bh=COwpNOQM+SONE9WAqdJL5k1pfQqmWxC43X4xS9BXG50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5I4mn5YTyRY/3H0lxK9rRr16YEK8KJBdq+XnX5+ZVfG0dLQPy2xaLwoTDI9acMeFPv436ALQJFfX+7MB3u26CJrEb/TQc3YokO0Hn49KnNqVFc75N+haDH+Yc3A9Vl9o5xY3x2FsuI4x3gVIWVjG3ms52UPTkVhUYO8fShrVe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EWBTE7iy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRqnbUOZ; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EWBTE7iy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRqnbUOZ"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id AA63B1C00077;
	Tue,  6 Feb 2024 01:35:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Feb 2024 01:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201344; x=1707287744; bh=62K3t9qscP
	b9/DYwiC0LJ5maw+cCqQUxLEJ9fjUv+Fg=; b=EWBTE7iyro8EyboIO3UhwfVq8d
	NqK54W0N/oqXdSAp9VG5Fmjr9+QSgZK9pylwAOlRowFQR4cKF5FZcetyo4rhfGCD
	ETzVlpLyD2ugqJuJS2OSNrOAgZy7QXjfyIZPJzJuRY45CznGUWGnXb4LqiwEogHG
	m+xrdIxhlAoME35iXi13i2nwMoSoE5zGKy65w72Yrao37+XalGx+aihLIGBJEQZu
	oEmedY0naIw/dX2sZkdFpdq+kp7Iz/qtU8yRP9nhdg6EMYdzhSQnm4YhIT/mm84R
	YZGBPD8y4uYtZyG6+EFvrBnlmk0bg7ZX/Btg1OQYblboQaPY2yQnFoio9b/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201344; x=1707287744; bh=62K3t9qscPb9/DYwiC0LJ5maw+cC
	qQUxLEJ9fjUv+Fg=; b=LRqnbUOZWKytHzpKexPl8aK9QfjyCrczEQMoX74ZlgN5
	hkZVfBWKMjSKoeDrTcBsl9m8J6432e8QDQk9iw29ERIJCmHSngW5Tz0E+td+diRo
	Sds49q+eakaWoe1bJIjQ/AguJn5SK+QmDkEOIahjZ20hWXcmhyFXqh5DoSXrucBE
	3EHKjYFaUzn83BsHTEXKNdGB8eHlv9OHMmuv/gKwImqVFx+vT16qh/I30TPRgGv5
	noY5LYv1PHcToIPBHqmQVkX35dfb3/IY5ppY/OTqW2abcZvr6YC1UqPEDOlAMOWY
	R25kz2DgUTg60KPzmvR9h4ohJpNrX9rkftZsG/M8Qg==
X-ME-Sender: <xms:QNPBZYO41I5u6G3HzY88liFiaDxjxdcTPQX1yMBtpNw66Oy_iOlwrw>
    <xme:QNPBZe9dEum7rTNAro0G0BkXKB0RgHQzdCz7cCkAkVhl0SkitCps9aGVExL9hnVuv
    ESs3AjKnWyFC7Ic0w>
X-ME-Received: <xmr:QNPBZfQQ647NcRrpoeTwmrFlVOiR4z8-ok2ld06Hc8ElVexEf3sDgqd9naUyLgm8KNEMrUwQOTqtWgGzw1zbb8OywpvAHoviKJtIX64KLbVkJj4c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:QNPBZQvcJInJHStImQ50NrqnSZBNJA7htitLnCWdA35mGD4z33LWGQ>
    <xmx:QNPBZQdXyyICRWfvIKvojO0ig26gbaGsJVxm4n21Lui6sqOXkSflVQ>
    <xmx:QNPBZU30Hk7KWA-WXJX7lKsKYtO15t7_rvKIRR536uZUQlQwA1oBCQ>
    <xmx:QNPBZVF_1raQhwFNqK6bQAw113hOYsHxkTgS_QWZ--23_CgtIqPXXK6GLAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfd1a286 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:13 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 5/9] reftable/stack: use `size_t` to track stack slices
 during compaction
Message-ID: <a0867c037831b4a73e465e630ca6810663b34dac.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N6dOVqSjTsJwlpgg"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--N6dOVqSjTsJwlpgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use `int`s to track reftable slices when compacting the reftable
stack, which is considered to be a code smell in the Git project.
Convert the code to use `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 5da4ea8141..a86481a9a6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -24,7 +24,8 @@ static int stack_try_add(struct reftable_stack *st,
 					    void *arg),
 			 void *arg);
 static int stack_write_compact(struct reftable_stack *st,
-			       struct reftable_writer *wr, int first, int last,
+			       struct reftable_writer *wr,
+			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config);
 static int stack_check_addition(struct reftable_stack *st,
 				const char *new_tab_name);
@@ -820,7 +821,8 @@ uint64_t reftable_stack_next_update_index(struct reftab=
le_stack *st)
 	return 1;
 }
=20
-static int stack_compact_locked(struct reftable_stack *st, int first, int =
last,
+static int stack_compact_locked(struct reftable_stack *st,
+				size_t first, size_t last,
 				struct strbuf *temp_tab,
 				struct reftable_log_expiry_config *config)
 {
@@ -864,22 +866,21 @@ static int stack_compact_locked(struct reftable_stack=
 *st, int first, int last,
 }
=20
 static int stack_write_compact(struct reftable_stack *st,
-			       struct reftable_writer *wr, int first, int last,
+			       struct reftable_writer *wr,
+			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config)
 {
 	int subtabs_len =3D last - first + 1;
 	struct reftable_table *subtabs =3D reftable_calloc(
 		last - first + 1, sizeof(*subtabs));
 	struct reftable_merged_table *mt =3D NULL;
-	int err =3D 0;
 	struct reftable_iterator it =3D { NULL };
 	struct reftable_ref_record ref =3D { NULL };
 	struct reftable_log_record log =3D { NULL };
-
 	uint64_t entries =3D 0;
+	int err =3D 0;
=20
-	int i =3D 0, j =3D 0;
-	for (i =3D first, j =3D 0; i <=3D last; i++) {
+	for (size_t i =3D first, j =3D 0; i <=3D last; i++) {
 		struct reftable_reader *t =3D st->readers[i];
 		reftable_table_from_reader(&subtabs[j++], t);
 		st->stats.bytes +=3D t->size;
@@ -963,7 +964,8 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 }
=20
 /* <  0: error. 0 =3D=3D OK, > 0 attempt failed; could retry. */
-static int stack_compact_range(struct reftable_stack *st, int first, int l=
ast,
+static int stack_compact_range(struct reftable_stack *st,
+			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *expiry)
 {
 	char **delete_on_success =3D NULL, **subtable_locks =3D NULL, **listp =3D=
 NULL;
@@ -972,12 +974,10 @@ static int stack_compact_range(struct reftable_stack =
*st, int first, int last,
 	struct strbuf lock_file_name =3D STRBUF_INIT;
 	struct strbuf ref_list_contents =3D STRBUF_INIT;
 	struct strbuf new_table_path =3D STRBUF_INIT;
+	size_t i, j, compact_count;
 	int err =3D 0;
 	int have_lock =3D 0;
 	int lock_file_fd =3D -1;
-	int compact_count;
-	int i =3D 0;
-	int j =3D 0;
 	int is_empty_table =3D 0;
=20
 	if (first > last || (!expiry && first =3D=3D last)) {
@@ -1172,17 +1172,17 @@ static int stack_compact_range(struct reftable_stac=
k *st, int first, int last,
 int reftable_stack_compact_all(struct reftable_stack *st,
 			       struct reftable_log_expiry_config *config)
 {
-	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
+	return stack_compact_range(st, 0, st->merged->stack_len ?
+			st->merged->stack_len - 1 : 0, config);
 }
=20
-static int stack_compact_range_stats(struct reftable_stack *st, int first,
-				     int last,
+static int stack_compact_range_stats(struct reftable_stack *st,
+				     size_t first, size_t last,
 				     struct reftable_log_expiry_config *config)
 {
 	int err =3D stack_compact_range(st, first, last, config);
-	if (err > 0) {
+	if (err > 0)
 		st->stats.failures++;
-	}
 	return err;
 }
=20
--=20
2.43.GIT


--N6dOVqSjTsJwlpgg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB0zwACgkQVbJhu7ck
PpSW4xAAke+vC8qekac2UaREKqvzYh+5TPC0e6pY9oqqcRjZK0UYQgrC4fggIlDq
btT1ccDUp6FEz/wtgBYsC3Y2kkVJ+czwragz2I0WZGMKaj+d4JmiEN5Gj+ZyI9wc
Fgmpf85PUEo/Grq6RripUZ0gZjqaHLh5Gp/IshFLyxpDGVC97wwIEjQX1rCenKp6
kEDCiDLE0qnQ2Tdwl3hJEVMtW/HCvZHxWmz4tUQ/JYdtlZKPaXwh/Z5RO+qUnKfC
BtKeSeFsubtXeqekz4D8oypb9EEwuRsEfjrkH6oDN6cNPUd1ig6aoOLyh84Vy3B6
J+HVEKlCK0t1bNsm5JSAn/Yp2Lvk/JA3ibtWngG+1I39WeZ3o/7xcKKx2DKmK8ze
7ZIG0Vx1Kivyz6oGpvn+qjT0ELjmSR1AXFbAgGg8Cojzem2/Uou6xj+nFT+rxMHb
+InYbrdW/5EVGO/7VDadwiPVMRzlgBr6R/vPVjAKoBpY8gd6B028Q60hgs8pTEiV
vwFQEXsh5cfnGJDsKlT0+qPKSiM5JmP/niihFWEsgbg4XNkDs/SwT8n6KpAKodOX
QdD9XgBZ7jQUKKffWg3ikrsWCFs2dlLtRTsPzhl6ZiVXcRVPzcExtpqjvxQDEijR
AEMyrJCxJ7pN6hkjWz4sI8Gfwv7qZk0OaCcY0KtbgvToMi/R3Ss=
=O3ZS
-----END PGP SIGNATURE-----

--N6dOVqSjTsJwlpgg--
