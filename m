Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126D18026
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863311; cv=none; b=olKoy7a3luQ8M46I/RXnesAZzAUc0xwBQQZfQjUVHmYyzIuNdXR3Pd1Df2wL0aEiHl6ZM8Gc353LT8y6IUB9MNaubqXLN+nYVE4nLo2mYiTVZXeem4WM1lSh82rE5F2lm8LlO7pmOOY2iIrKTJKVMebUtLl1CpdZLw7eXUIeLC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863311; c=relaxed/simple;
	bh=mXal+VMIj7NC68//vH4yjzgdjni8omilFbJEyIOz2f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+kwAOFGU0phVJbKV94iCUuusX6fuHo6kLTRvq5PMY61ZzgIhNoxxIl+BT9ykbCCWmZ+QEzJWzLNgdfCFPzgpeZMJcSo/2r2+n/CTaE0QFAa7AaeV4ks6L0RXr8PDmBnM39HWHDW8kmxm8OIownsvFhZd6tcKwVi5kVwvn41m9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jfU8BMIR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ty8aS8XY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jfU8BMIR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ty8aS8XY"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 66500138FCB6;
	Mon,  5 Aug 2024 09:08:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Aug 2024 09:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863308; x=1722949708; bh=8L2p298u5x
	b8mM5jVHzXOG7F0hZZdn91TanCL6cF29w=; b=jfU8BMIR4qaxVR5vLnP/q296qc
	mnsk4y75I4PmSgXvkTyc+DC4Sq0DOnXgnDfWv/r72BU8bYwcmDaBq6099MSNO7iA
	LX78o7bISgpnIfOwN8Zy/KAV4h6WCEepxm7G178SSqLC9GfM5HMgyzoz1eRCVyGC
	02ZLN/234vYOK1m1+ZuCOyslx+TJTFgauyUd5Iji2hHqw2Ch9GA1WRzbs8047r8I
	+5uac8SfHnzWSC+gnn8dqS2LcAPCZ+EhioeUOXWljqvP3lsG5duhbAxW5mtKrhUW
	5riONZL+Iwaxb1WIe1kta/JkAUvzkdY6iFVQdXyMBXqwV2tANCcaRxDNNCBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863308; x=1722949708; bh=8L2p298u5xb8mM5jVHzXOG7F0hZZ
	dn91TanCL6cF29w=; b=Ty8aS8XYWJeQxk0N/OdNy1fET4LHuCa3lgtZyObH9B3U
	ZnDTydWJs9z9wLxQzK//cy5pVHvWSaNiG/lJ/RvXLe33gES98dwgD5JThhP08GIV
	aq7eZysvrcdZKtsoqO4eUhwpfRBz5PvCw11vs8evHnpepktTf22CeWboadQ//Ry4
	3JK4cRbi7Ujp0wE2zMQs9c8h1P3mSOMAXhxhCA746Ww+rlxhqvXBzdHyMUpxR120
	rBSVLDonos7lUjtwMM5U8s5oZxrK88c1ppF+IviqUu0awr0iVxavXS0L8AQ0BZBR
	XlubKpx21pNitDQzstsnKd6B+WwMJyJfcpPKynNgog==
X-ME-Sender: <xms:zM6wZlXIwsiF7Ab6r9BKDIDLAgtKviv6Wy015QK24t6DOYNTtEQQqw>
    <xme:zM6wZlnGPSewJuJIFzsROfgobFhrpYH_0Huee--pvF81jJqjLm9_AvOXwDJZnUcu9
    vjVBvTgS3ERNdDOqw>
X-ME-Received: <xmr:zM6wZhbC7TReB88LVNf31U1xv6J6HyOW23u9RJcCHL04avzLjW3Dj-B1uLEl2tZzyc70hHYfhTG2y4EueDj59UZ0rhemzEZf98KsWuPIqHwjIKow3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:zM6wZoXTxmqvqhhVrzKZO4wCURLY_OZpTXapv8vhwXl199_t_sFOPA>
    <xmx:zM6wZvlRkalZYN_TCBmBQMwy5s1cr7gB4QPKoWHzfzD6dcJWeO1pVQ>
    <xmx:zM6wZlc5-MKqwb05oPdB0bEB4suY6qUF06XloGplpVo4-SzVntDtfg>
    <xmx:zM6wZpElBshxsxOsahUUqoh6yE1OzWVyftM3HnU8gHBEFl9xXlAIlQ>
    <xmx:zM6wZtjS14U53edFJjV6xPUtmAvLHdviFcAwymDnOsmMVK5JLRzjgRXo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:08:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03cc79f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:08:26 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:08:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 9/9] reftable/stack: handle locked tables during
 auto-compaction
Message-ID: <1ef560feb1906c160ad7c81a30e9bd4fc92d2eca.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1722862822.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvXvXjUIoOaZNmKG"
Content-Disposition: inline
In-Reply-To: <cover.1722862822.git.ps@pks.im>


--nvXvXjUIoOaZNmKG
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
 reftable/stack.c           | 59 +++++++++++++++++++++++++++++++-------
 reftable/stack_test.c      | 12 ++++----
 t/t0610-reftable-basics.sh | 21 +++++++++-----
 3 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 51eb4470c7..b0721640e4 100644
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
index 2b1eb83934..733cf6113e 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -913,13 +913,15 @@ static void test_reftable_stack_auto_compaction_with_=
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


--nvXvXjUIoOaZNmKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzsgACgkQVbJhu7ck
PpSV6Q/+MNChAdKmCHb3FMq6AwWyVUOCZa9NFYFopLvk0pz1u5000ad8ROGIS6Fa
Q/+Ytl/5x8cGGFhxypRZgPvQa1CbndMVgbUuZu65GNYYI1HiB90feMigljYr9G3m
COD4bF+Lf0RiRHN8fEZ5IgE8iT+T80w4uYJolSes3ly8zcHlECdutaS/LNwJSdnE
47G+gqiYAtn5k3Hrl+Xf6jfHh/1lnqsj/d1+FZuL8sHqGhylbQb1JSUtVYOfKVvr
+r++FK86TBGLKvWJIbaCyGplDy5agrz/6UWEkP4I6RHyjuD3HEA5DEz0vWxbeMK5
F3PatCi89lPWT1w/gy943xsux8FjhGQ9Ejh5wyzrm9Wa1Y4LzTWML16h47K1G8ty
MqTPVOFW47mCobauEog1V2jYp5lO+fRe4Wbewg2/tn2AoXmoQzNxzGL77T1bpADo
zi7RzH0rRCvuuvRq5YZUeMAYaZhlYWdEK2xmQyF/YMVzivJm+fmdv6ehTKZXjxGR
TQy5eBfO5nonYOM+MRrYSwopIyhRM9s/9SPwAoZUWuf+i/Z/RrNzWTbKtpeKxNmK
L5O1wT3TuRVGDS0MwwywGLzM2IdvBjMabJtIz85MvoBONmurtp/KLbar/ixH27vA
ff+d6tojYwAJMshhluD65ldmVWIy58BkVB6IFNlbjnupfpbc7ws=
=chZc
-----END PGP SIGNATURE-----

--nvXvXjUIoOaZNmKG--
