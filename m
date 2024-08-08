Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B6418E74B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126025; cv=none; b=pGuZRvaRdY5LoI7fih00ksCumxXHA5eki1bIBNX0E6fY/5BgQzlyQQT7RAOBr6Hy0MA7akx0y+psTNTV0dsXm3zyX+Wl0AdntKZSNCI8yLgTPp0uMal5Pj6padHYLQcMyUx58CL48sJCmzskUVYlNA0gV5EYsaNKvCPCWWO0VlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126025; c=relaxed/simple;
	bh=y19g2xY97qY+X+R6tOwBd01wKKoRnEE0eqdCS4e7OSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxz55EveXEDM6BsbVUzD1TZl37uScPlhDJhWodlML+bo15iZ91ECSD1GYlV2mH3n/MS0xuQdTECBOYc3y9CsagT0iSAxgaVYEit8svr179OuRh2nZmghcjcQ98RctwA0iJsD4ozUaH3PnZiXTkE/I0sPa2dWySxQRhzqNW/3xBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j2bLVG/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gzuj0KJI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j2bLVG/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gzuj0KJI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9BB771151025;
	Thu,  8 Aug 2024 10:07:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723126022; x=1723212422; bh=c2emqa9Ij4
	q4ZqD5TP0N4Jbwh2OQavWjZHO6P8JcUP4=; b=j2bLVG/XQMmw/wr1pNII+OUm7Y
	zsEJWCgKKvLnUMkNfUnQbOhClw2dqGDr+Da2iJlx085F+bpH00r1EKaq5kR4rgq/
	CHRdv2JxZ0XG8OOVtUmsu9849+OgzS/G0eLfzYrDplZt4AxhB36ti+SWngffauYj
	BTzEj/gP3dOa4Z3TzyuqU8VgUoGS567StTMJQZAPoympzTkjZT0yb5Tx4GpsHIo9
	/nydrDKhh4u81SE/92YPR7igE/p77mTCjKC7fnBQikpLaWNGioltl4MPSV68aikj
	Mj63dLq/9L9NIZwUlONhDbdObxg3Aa9f60E58WwCUFxdzSjgd2miokYjNAPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723126022; x=1723212422; bh=c2emqa9Ij4q4ZqD5TP0N4Jbwh2OQ
	avWjZHO6P8JcUP4=; b=Gzuj0KJIae6aSNu/S9lB1j0WtoAqI8K5cda4+tM1qh2O
	T6YP5ERVlNI4yi3/nFpwTEHLVMX43iEG47TfE3v1EFnopm3xpfOlfOn1Tf9bSWhZ
	i9VxlivONPERmVlvFU2ih9GYVPLye7B0ExXudk+YaXiiTNz/XszcBc92+CmU36kR
	M1/v2yyHCukDUvMBrRmP9vc2fYf8BSBzFkYuZKPz7D9vSqHQit8tlxaqr1pgcj6v
	yCQpNg6yBA6QSZtmGUWhD4Ll00yztbS0TQHpBh1RA7MV0CjCFI8KZOsrh2Rj+fnO
	ESk/Ip1rKRkXEiTUEDfTczJ3EeE1VV0II50AXC9h3w==
X-ME-Sender: <xms:BtG0ZrJQBjHxGpH5cXR46nov6tvgqJ14lqAm3pNcCf1FL3Mi3eNU2A>
    <xme:BtG0ZvJjPpSq9G36VztW3wF-qtG65xkqTtDrl0Hwp2Wous3DTKDT1ySpbzCv2oQUv
    lQ6ab2JfQbs0p9AGw>
X-ME-Received: <xmr:BtG0ZjtS1CLc3vU_eEdvJ-6CmUfD1kdQZdMwbIRSwU4Z2_5ZqfwI8pxBzdlHN1gStdN1PphTfmVYB4nY_RhCV6x2Spi6Rzvx8VxhFkYmfaJkZwSz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:BtG0ZkZxj9MgvsNRgHhhcmoquTWPxTUTTfnZrTwNuJs8_kneMvvOag>
    <xmx:BtG0Zibjo1AX3bBUdaeSGVboaqlt8aSrSqt7jYjwZr1M16JrBhooXw>
    <xmx:BtG0ZoB3ym8oYSjBi1Ypo4uZpyc6XSF9gqUTUbL0krhmINYGpdgx0w>
    <xmx:BtG0ZgZzLx1tBBtx-d7C-xUjvaLlgW9rVp5QMTSPNcW_TneSOr_1vw>
    <xmx:BtG0ZpUcXupHUH-yIYlFoTzja2ZlXi3frjUJXHCoSG0TibYN3PkngDUQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:07:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f343e1df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:53 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 9/9] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <dc2fea145dba4b9e6c5aef2a57d18d5b8640aef1.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E/RGt+/HRHV05mPy"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--E/RGt+/HRHV05mPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When compacting tables, it may happen that we want to compact a set of
tables which are already locked by a concurrent process that compacts
them. In the case where we wanted to perform a full compaction of all
tables it is sensible to bail out in this case, as we cannot fulfill the
requested action.

But when performing auto-compaction it isn't necessarily in our best
interest of us to abort the whole operation. For example, due to the
geometric compacting schema that we use, it may be that process A takes
a lot of time to compact the bulk of all tables whereas process B
appends a bunch of new tables to the stack. B would in this case also
notice that it has to compact the tables that process A is compacting
already and thus also try to compact the same range, probably including
the new tables it has appended. But because those tables are locked
already, it will fail and thus abort the complete auto-compaction. The
consequence is that the stack will grow longer and longer while A isn't
yet done with compaction, which will lead to a growing performance
impact.

Instead of aborting auto-compaction altogether, let's gracefully handle
this situation by instead compacting tables which aren't locked. To do
so, instead of locking from the beginning of the slice-to-be-compacted,
we start locking tables from the end of the slice. Once we hit the first
table that is locked already, we abort. If we succeeded to lock two or
more tables, then we simply reduce the slice of tables that we're about
to compact to those which we managed to lock.

This ensures that we can at least make some progress for compaction in
said scenario. It also helps in other scenarios, like for example when a
process died and left a stale lockfile behind. In such a case we can at
least ensure some compaction on a best-effort basis.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c           | 59 +++++++++++++++++++++++++++++++-------
 reftable/stack_test.c      | 12 ++++----
 t/t0610-reftable-basics.sh | 21 +++++++++-----
 3 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 3f13c3eb34..2071e428a8 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -999,6 +999,15 @@ static int stack_write_compact(struct reftable_stack *=
st,
 	return err;
 }
=20
+enum stack_compact_range_flags {
+	/*
+	 * Perform a best-effort compaction. That is, even if we cannot lock
+	 * all tables in the specified range, we will try to compact the
+	 * remaining slice.
+	 */
+	STACK_COMPACT_RANGE_BEST_EFFORT =3D (1 << 0),
+};
+
 /*
  * Compact all tables in the range `[first, last)` into a single new table.
  *
@@ -1010,7 +1019,8 @@ static int stack_write_compact(struct reftable_stack =
*st,
  */
 static int stack_compact_range(struct reftable_stack *st,
 			       size_t first, size_t last,
-			       struct reftable_log_expiry_config *expiry)
+			       struct reftable_log_expiry_config *expiry,
+			       unsigned int flags)
 {
 	struct strbuf tables_list_buf =3D STRBUF_INIT;
 	struct strbuf new_table_name =3D STRBUF_INIT;
@@ -1052,19 +1062,47 @@ static int stack_compact_range(struct reftable_stac=
k *st,
 	/*
 	 * Lock all tables in the user-provided range. This is the slice of our
 	 * stack which we'll compact.
+	 *
+	 * Note that we lock tables in reverse order from last to first. The
+	 * intent behind this is to allow a newer process to perform best
+	 * effort compaction of tables that it has added in the case where an
+	 * older process is still busy compacting tables which are preexisting
+	 * from the point of view of the newer process.
 	 */
 	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
-	for (i =3D first; i <=3D last; i++) {
-		stack_filename(&table_name, st, reader_name(st->readers[i]));
+	for (i =3D last + 1; i > first; i--) {
+		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
=20
 		err =3D hold_lock_file_for_update(&table_locks[nlocks],
 						table_name.buf, LOCK_NO_DEREF);
 		if (err < 0) {
-			if (errno =3D=3D EEXIST)
+			/*
+			 * When the table is locked already we may do a
+			 * best-effort compaction and compact only the tables
+			 * that we have managed to lock so far. This of course
+			 * requires that we have been able to lock at least two
+			 * tables, otherwise there would be nothing to compact.
+			 * In that case, we return a lock error to our caller.
+			 */
+			if (errno =3D=3D EEXIST && last - (i - 1) >=3D 2 &&
+			    flags & STACK_COMPACT_RANGE_BEST_EFFORT) {
+				err =3D 0;
+				/*
+				 * The subtraction is to offset the index, the
+				 * addition is to only compact up to the table
+				 * of the preceding iteration. They obviously
+				 * cancel each other out, but that may be
+				 * non-obvious when it was omitted.
+				 */
+				first =3D (i - 1) + 1;
+				break;
+			} else if (errno =3D=3D EEXIST) {
 				err =3D REFTABLE_LOCK_ERROR;
-			else
+				goto done;
+			} else {
 				err =3D REFTABLE_IO_ERROR;
-			goto done;
+				goto done;
+			}
 		}
=20
 		/*
@@ -1308,9 +1346,10 @@ static int stack_compact_range(struct reftable_stack=
 *st,
=20
 static int stack_compact_range_stats(struct reftable_stack *st,
 				     size_t first, size_t last,
-				     struct reftable_log_expiry_config *config)
+				     struct reftable_log_expiry_config *config,
+				     unsigned int flags)
 {
-	int err =3D stack_compact_range(st, first, last, config);
+	int err =3D stack_compact_range(st, first, last, config, flags);
 	if (err =3D=3D REFTABLE_LOCK_ERROR)
 		st->stats.failures++;
 	return err;
@@ -1320,7 +1359,7 @@ int reftable_stack_compact_all(struct reftable_stack =
*st,
 			       struct reftable_log_expiry_config *config)
 {
 	size_t last =3D st->merged->stack_len ? st->merged->stack_len - 1 : 0;
-	return stack_compact_range_stats(st, 0, last, config);
+	return stack_compact_range_stats(st, 0, last, config, 0);
 }
=20
 static int segment_size(struct segment *s)
@@ -1427,7 +1466,7 @@ int reftable_stack_auto_compact(struct reftable_stack=
 *st)
 	reftable_free(sizes);
 	if (segment_size(&seg) > 0)
 		return stack_compact_range_stats(st, seg.start, seg.end - 1,
-						 NULL);
+						 NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
=20
 	return 0;
 }
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 3ed8e44924..8c36590ff0 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -917,13 +917,15 @@ static void test_reftable_stack_auto_compaction_with_=
locked_tables(void)
 	write_file_buf(buf.buf, "", 0);
=20
 	/*
-	 * Ideally, we'd handle the situation where any of the tables is locked
-	 * gracefully. We don't (yet) do this though and thus fail.
+	 * When parts of the stack are locked, then auto-compaction does a best
+	 * effort compaction of those tables which aren't locked. So while this
+	 * would in theory compact all tables, due to the preexisting lock we
+	 * only compact the newest two tables.
 	 */
 	err =3D reftable_stack_auto_compact(st);
-	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
-	EXPECT(st->stats.failures =3D=3D 1);
-	EXPECT(st->merged->stack_len =3D=3D 5);
+	EXPECT_ERR(err);
+	EXPECT(st->stats.failures =3D=3D 0);
+	EXPECT(st->merged->stack_len =3D=3D 4);
=20
 	reftable_stack_destroy(st);
 	strbuf_release(&buf);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index b06c46999d..37510c2b2a 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -478,19 +478,26 @@ test_expect_success "$command: auto compaction" '
=20
 		test_oid blob17_2 | git hash-object -w --stdin &&
=20
-		# Lock all tables write some refs. Auto-compaction will be
-		# unable to compact tables and thus fails gracefully, leaving
-		# the stack in a sub-optimal state.
-		ls .git/reftable/*.ref |
+		# Lock all tables, write some refs. Auto-compaction will be
+		# unable to compact tables and thus fails gracefully,
+		# compacting only those tables which are not locked.
+		ls .git/reftable/*.ref | sort |
 		while read table
 		do
-			touch "$table.lock" || exit 1
+			touch "$table.lock" &&
+			basename "$table" >>tables.expect || exit 1
 		done &&
+		test_line_count =3D 2 .git/reftable/tables.list &&
 		git branch B &&
 		git branch C &&
-		rm .git/reftable/*.lock &&
-		test_line_count =3D 4 .git/reftable/tables.list &&
=20
+		# The new tables are auto-compacted, but the locked tables are
+		# left intact.
+		test_line_count =3D 3 .git/reftable/tables.list &&
+		head -n 2 .git/reftable/tables.list >tables.head &&
+		test_cmp tables.expect tables.head &&
+
+		rm .git/reftable/*.lock &&
 		git $command --auto &&
 		test_line_count =3D 1 .git/reftable/tables.list
 	)
--=20
2.46.0.46.g406f326d27.dirty


--E/RGt+/HRHV05mPy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00QEACgkQVbJhu7ck
PpS22Q/+M3UyQXSPo4XJP/rviYb+oPfT/kqZwFLKEDTw/Q+WgvNR9BmLZb5hw+ap
Hqi2NiwOnN3q5n5wrxyvWjCOm6QIL+VHOgoFVPNukLBNdOVA8mLKehVVA6UHjz+X
KuapdL/WYjFZi9mJTlYEVGAPWb2+VC4L2j7Ux/fNY1V2KG5UR4eDWDkJ3L5mYRuH
af21slW05154kaIrwJaMupS+2IKiBcaNqP7xpNyc/0qFidSrsGBHxgbPPmf+9Kf6
3tdKxKcGMtJ6KjxwFfw/ZSpxWuaFqSIMdpdlEDl6pbV6fmDk1LcyhBgTgiSGRrAf
DigxY/VMCg/VJpJFZ8A0LFW8zVauNVviJf5NCg1Rzf+NS7yZaRfJS236utm6nrc2
RJOAlDwflddWGqebHg6/xenCX9/ldcS5Dc9O1wlyBntOsihK9d4ZBAlN7EMCTCyd
9+Qn1W3fmX5hv+k6WDOJ2iALOJfqylB1W0Qf7xBI4qv4dAq7v/PA3xB1dg/a08vf
EPL7AUx2NqiqrPoxjfHd7x/ADokYCTcSTWsm1wcTWqy5tKfhB268ZeQKBKJ38zfc
JSumaSqmHFPiVcUoxtnqojlSIRpjjlXjSfq3Rkoj2XEFTlbU8VIHtLhw3mHRQEEc
8YpgKzrCF+p98mSLCsKIztD1gaKLW7DQ9CObc1SbRSUy+5gbFTM=
=CZC7
-----END PGP SIGNATURE-----

--E/RGt+/HRHV05mPy--
