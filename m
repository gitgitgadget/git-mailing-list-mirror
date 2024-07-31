Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61531B29BB
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435330; cv=none; b=t4awThV+sl+L36sl+6tbUY687Q50oDvZvWpRbHYNVU1Fc4PiLsC1ADu2W4UStTD49AcPRJ4QfF0dGSI+WYf+k/IXnQm1NLP8wGwEdgUiEB3+x52UPT+Px4OvDc5Kh+1nko2NEOT9ltP2g7FxeMKqBEdBf0o/fUY+MDwPwZLovGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435330; c=relaxed/simple;
	bh=lZRSt/dG70/PRrEGpuMnUNfa70upEdtfoIunZu027hc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9gOiMWfP+5QQq3GdGZy2xwjscBXnP+JIV2P/2jtJs9G0bpaA/NEVgyjAy6FkRPQhG9tI5LywNEjg9Jwbn3oa/NjUjkmqMaDGCxadBXn8MRba8wR41UqBPaPdve2ZEKcoW1guWkWSHcX9u8Mq5GMXUwKPCMMbAAywCNW2yIenuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cecjgH99; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9AkgJv0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cecjgH99";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9AkgJv0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 09AC21146C8C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 31 Jul 2024 10:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435328; x=1722521728; bh=vyX6543lL5
	+yNmtZ8+OZPfcXOj4USEf1teePG8hvMdg=; b=cecjgH99GcmOz7H9hn2QJxTdFZ
	QL+QhFS358d08j59X72q9yTNHS3MHROKGINsvkcJe+bTF2n5LgghrshNLb+OvPwa
	cKkgmk6rxTNNHnfOpT4PTuM5CWCNkTHK3mVcjOQmcESBgW0Hbs4ScQzD/M7sGMJc
	2MlKwwhOEnCXLVBYTNIrtBsxG0gvpKlRzVSOHTdbz2+Z0BdiR8yvJYl8Mdqe/zbJ
	3M9f/YXl3BeY8q1YUszoN5mn60yoQaIAqv7ZT47y3sRbLt/AzFGvII5ycqMAmN3A
	Elqi+F/IYL0AZud5ggo3ZTU/U1N4L2bI9H97SLNlMEYRTwX3bYSqec0RQnow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435328; x=1722521728; bh=vyX6543lL5+yNmtZ8+OZPfcXOj4U
	SEf1teePG8hvMdg=; b=i9AkgJv0hcm8AL4G8SxnPyFCWLbnhmsqAGRe2cilC4kv
	gpb+CG4//0rl91xS621tUnLWsVKWQPjV03PbRee8BCmlnKS3RPy0QmlUdm+kNd7b
	4PJBgwCjLinWn26bU9iMgx8/+8HW66eHHKrw0/Lf7hnToAk4nMl3yR8j5zohPouO
	UKI3xePXU2MO4Jip5/e/HQ2jFA1KPyMgdN8rZMUAg6LXj1305mA5NC7ClGuMcDt0
	3EYm1z4jD/5TcrVA5WQb6SeVpb0bb8txRJX+AkuCTEs0RrVMaSKHDG4bT0RkwHcb
	CEEblR+32Ks1XKnJLVwor9ay/nCdrF+Jdd+mQAoKFA==
X-ME-Sender: <xms:_0aqZnMQztB_9YMIvP0lYoJvrjs-yCbJmquWJpE692APPbIy1QF0ww>
    <xme:_0aqZh9vfjbuDGfFFv2V3fCpuIgawjWe0qXNPQShdFuAeFPGEMqrXr3Ooonrh0OAX
    x29V-m_2p-rkeAIPg>
X-ME-Received: <xmr:_0aqZmSCnxWEU3qltAeMmeBRv7f2LmrpYqwOI2p9MHbjAWXvXJVTAmfso2I4P32pbKecMWXWKiRTDTIvfvlgDbTTgrPEpvAte7Z9adpJiPRMn6H3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:_0aqZrvII7WDg0FV1SkVb9-JSm8ElGAHVB-SkQQMKvQB6EPMg4n9nA>
    <xmx:_0aqZvc9PLmyh5W4od96-8HLQVw4e4dM6YYxzSHhxLHDpssyJOWd4Q>
    <xmx:_0aqZn3o7NAifo6IquxqCM3PF1cOkiX8ndoDpVvrG0EHz5MWGn43bw>
    <xmx:_0aqZr_cmPkfEhTZI7hZDaOUR8JApDdytJlbh8qOlYwgTBhmCwDsAQ>
    <xmx:AEeqZnEQp9Y87Bew03F4UKfsopULVOId8H7PZAbcLpDWOcCaer5LYvFv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1553a4d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:57 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:15:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 8/8] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <dc2217830700acaac50d96361352ff433aa57a4d.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="svOgH+gtZ6mYcyzu"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--svOgH+gtZ6mYcyzu
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
table that is locked already, we abort. If we succeded to lock two or
more tables, then we simply reduce the slice of tables that we're about
to compact to those which we managed to lock.

This ensures that we can at least make some progress for compaction in
said scenario. It also helps in other scenarios, like for example when a
process died and left a stale lockfile behind. In such a case we can at
least ensure some compaction on a best-effort basis.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c           | 61 +++++++++++++++++++++++++++++++-------
 reftable/stack_test.c      | 12 ++++----
 t/t0610-reftable-basics.sh | 21 ++++++++-----
 3 files changed, 71 insertions(+), 23 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2b1ac58120..9657ca4418 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1000,6 +1000,15 @@ static int stack_write_compact(struct reftable_stack=
 *st,
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
@@ -1011,7 +1020,8 @@ static int stack_write_compact(struct reftable_stack =
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
@@ -1053,19 +1063,47 @@ static int stack_compact_range(struct reftable_stac=
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
@@ -1270,7 +1308,7 @@ static int stack_compact_range(struct reftable_stack =
*st,
 	 * delete the files after we closed them on Windows, so this needs to
 	 * happen first.
 	 */
-	err =3D reftable_stack_reload_maybe_reuse(st, first < last);
+	err =3D reftable_stack_reload_maybe_reuse(st, first_to_replace < last_to_=
replace);
 	if (err < 0)
 		goto done;
=20
@@ -1303,9 +1341,10 @@ static int stack_compact_range(struct reftable_stack=
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
@@ -1315,7 +1354,7 @@ int reftable_stack_compact_all(struct reftable_stack =
*st,
 			       struct reftable_log_expiry_config *config)
 {
 	size_t last =3D st->merged->stack_len ? st->merged->stack_len - 1 : 0;
-	return stack_compact_range_stats(st, 0, last, config);
+	return stack_compact_range_stats(st, 0, last, config, 0);
 }
=20
 static int segment_size(struct segment *s)
@@ -1422,7 +1461,7 @@ int reftable_stack_auto_compact(struct reftable_stack=
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
index 8739ff3d63..af5757c0f6 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -902,13 +902,15 @@ static void test_reftable_stack_auto_compaction_with_=
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
2.46.0.dirty


--svOgH+gtZ6mYcyzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRvwACgkQVbJhu7ck
PpQL/Q//ZbY1vDDxmBqVfh+5KFD3tJLbeMIy4RGWa7/iBobOVqY4e/LhMrtoFOar
wkToPzIpSTsuxt23leuS7a1ZrqdOzK/ae4zP2Y9S+gQA5j741ZHMfA7ODoyjSXgb
N0eVDJWZhfF95balWQ+ZGVjlat4o6/EmjfJ80BZOtUUJcQtEzJ7MzYPtYY33FKZH
tSeghF92DdYsAHCEWtoPJM79sow/qNAl/2/bwY+w7DAc72we2lfqxnDve0Kq3yoo
+wDvluYPKAf2OxhPoCgBhBErqlxBUSyNTmt4Fj/yqnOUIWjEqNbe2wuvuBfRWiAx
bwUIYzzvz1VeVI1gbTSO+597tnmEBbc+clU5hBOaim5fvJiVH57zTg83EEm0j20t
BLxTUGrJsLVTAVznvxLpEcCo+nFf9+Xv6r9Nu4Xid4fr+UqFb1eKksB7MPT2RHWl
mB7YbwlmopwiyWCsC1hSq/ZlD5cwz8oVJPs2k9Zp2za6LP8mh0QWPL0TrIUYklur
3KQYzzuPQCkEd+zljI0c4xowHms0vuHqakJ5TDOE0a9QY0CiFFDIuK2mKfO/WzWn
1QXxcj+6M2v1Noz4xCMQl5galDtPg60kExdOK3UcMqgu0vgl2G1p9+eTjUomcqnt
xFTS62MkR1wKPEn19FfitwN/gzg4KUzB/kISrKyCOT3oGblmKgE=
=4gQB
-----END PGP SIGNATURE-----

--svOgH+gtZ6mYcyzu--
