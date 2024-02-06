Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5D12838D
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201353; cv=none; b=X+bjIARH917nXeb77tL/Z3En25mHHcHwNIYmlcDF5JjLeHM7BoF/TN+whK8QjIHbbpZY3uKnHzSuf6NKBKSqu2tntpwoK5qnTRnpP1wS+oks4w7Gwnzclgg1a19UrazeUyIS+p1Nw8vplTgqOOT/6S4JbI9YAxEeMX1ns6iZLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201353; c=relaxed/simple;
	bh=YPzJhJtULZHwV9Vs5RFCVx9RgW/l68dWX6epunW68GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF1m4IWb0iex77ABMwJs10cYxUZlcJPm1uLj3c4mo1fnXcj4bB+OL3X7mFlwq7g74SoBhEocS5dyWN5V3uJ9zwrW0drgmZp79PcNP325qTQrXiHbziaRx6GMj4VAqpZaFYdsckK9+8ZVqXTBx8P94UkhaGcOhRUbhcmvJShMTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HDqKbIdg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rbF2R0q4; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HDqKbIdg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rbF2R0q4"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 0DBC03200A9A;
	Tue,  6 Feb 2024 01:35:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Feb 2024 01:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707201349; x=1707287749; bh=wiNieeR7pv
	tFJDeaIzflZ6izn0o9SW01PPPnds2OYXY=; b=HDqKbIdgm4tdrQAEiWpSEb8A3a
	59fHazn5H70+60KP+6JLvwqxXfinBltoqW/yjEDDhf27I5VuNAOguCcpjQO7Td2w
	CO7VoQ9+Aqu0GYFH1mD0ax2KDjZgeslavnlwNpG3WyQ5RZg3hyrIjuMlXVSi2719
	AEOEzlqs8zXMbO1lPFKeTHOojbJ7u1JtB0EWO8EDuVEvw1ttZZQpS/bvSe2wKdby
	oFkKp797IOAW/z+k3GCnxH7R5hZ0tbJl5QH+9qSOKOJ/n7kcjcXMEHxKGMcFHd1b
	xBTEFDtciFNspIOharOiMIjkI9N9uSRR/rMSq0yIw80UOkJIh0qXzqCvuf0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707201349; x=1707287749; bh=wiNieeR7pvtFJDeaIzflZ6izn0o9
	SW01PPPnds2OYXY=; b=rbF2R0q4UDknnYdTD1sZsKeBhxGhciqd4kdaZ33UCKVm
	jbVzbe5N6ac6nucfQh2Zq3RqFKaHceXWAjpk5R8UG5A833AHbTlhy6xLaw6htXrJ
	qiD+9iz71prv9xh/yC52YFuj85aPHHRnJwhrpI5Fn4E2REl2SvUZS+1nTfa9qs87
	M+yzh4eyC4Jgt8FRKNH6Ix+6D0+frSDQ0Z8IC0B19VJJjQQ2UoNdmYUAERy9aPaf
	/uTvc34PJcR168hLQm1ETykgofRBVT8ro67en87j19ZT2gYzoGZFzhz9Yb6/2veK
	EftSbmWtYY2hqkwtEM1U3pseqkHLv+npJ/sIA4oAUg==
X-ME-Sender: <xms:RdPBZYPuf_Qs_kMkqmFRwdhLxVinZihVMqLotzlberh9Ubx7A_rLww>
    <xme:RdPBZe9bfM2hPqo13Sh62ydrvy3V3tNpJ3TMyPxK61V3BMvbH2M5Fh3Z-iNXw8EMb
    LNkE0tCVXUXQIaN-Q>
X-ME-Received: <xmr:RdPBZfQ2QDIG-1yC_DluRoiZ-G3exwYc5SUk3-K_rUhi__-kDisNHT0VnP9octRBVRg8tP05Jn3CwSfI10CO-Cvm8AOFlFKiIz9pcNzpXqBWTjdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:RdPBZQsKipyy9Fwt3K2c7uLxpiFoBlr_Mn_VYhqu7Wmc3UPBrf5tEg>
    <xmx:RdPBZQftM7QGTK0iOcK7mqrKvX70dqB_ZqvWDiwqWTVq7DiGhDKCXA>
    <xmx:RdPBZU3SanZpPZuLkBuKkpFyMCjsCu7EUaHsIxW3_10wmgpPEXkkCA>
    <xmx:RdPBZf4zUwjj8CsCRWTfznqKyr-o3GX0TYFCVL52NkLnmZfIeTH6Ug>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 01:35:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c2ba02b9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Feb 2024 06:32:18 +0000 (UTC)
Date: Tue, 6 Feb 2024 07:35:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 6/9] reftable/stack: use `size_t` to track stack length
Message-ID: <29c5a54ae8754e106769d9ba50f0e4547a32d993.1707200355.git.ps@pks.im>
References: <cover.1706687982.git.ps@pks.im>
 <cover.1707200355.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ubrr3GSE+smWrZZ"
Content-Disposition: inline
In-Reply-To: <cover.1707200355.git.ps@pks.im>


--6ubrr3GSE+smWrZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the stack length is already stored as `size_t`, we frequently use
`int`s to refer to those stacks throughout the reftable library. Convert
those cases to use `size_t` instead to make things consistent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c          |  7 +++----
 reftable/basics.h          |  2 +-
 reftable/merged.c          | 11 +++++------
 reftable/merged_test.c     | 14 ++++++--------
 reftable/reftable-merged.h |  2 +-
 reftable/stack.c           | 21 ++++++++++-----------
 6 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index af9004cec2..0785aff941 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -64,12 +64,11 @@ void free_names(char **a)
 	reftable_free(a);
 }
=20
-int names_length(char **names)
+size_t names_length(char **names)
 {
 	char **p =3D names;
-	for (; *p; p++) {
-		/* empty */
-	}
+	while (*p)
+		p++;
 	return p - names;
 }
=20
diff --git a/reftable/basics.h b/reftable/basics.h
index 4c3ac963a3..91f3533efe 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -44,7 +44,7 @@ void parse_names(char *buf, int size, char ***namesp);
 int names_equal(char **a, char **b);
=20
 /* returns the array size of a NULL-terminated array of strings. */
-int names_length(char **names);
+size_t names_length(char **names);
=20
 /* Allocation routines; they invoke the functions set through
  * reftable_set_alloc() */
diff --git a/reftable/merged.c b/reftable/merged.c
index 2031fd51b4..e2c6253324 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -45,11 +45,10 @@ static int merged_iter_init(struct merged_iter *mi)
 static void merged_iter_close(void *p)
 {
 	struct merged_iter *mi =3D p;
-	int i =3D 0;
+
 	merged_iter_pqueue_release(&mi->pq);
-	for (i =3D 0; i < mi->stack_len; i++) {
+	for (size_t i =3D 0; i < mi->stack_len; i++)
 		reftable_iterator_destroy(&mi->stack[i]);
-	}
 	reftable_free(mi->stack);
 	strbuf_release(&mi->key);
 	strbuf_release(&mi->entry_key);
@@ -168,14 +167,14 @@ static void iterator_from_merged_iter(struct reftable=
_iterator *it,
 }
=20
 int reftable_new_merged_table(struct reftable_merged_table **dest,
-			      struct reftable_table *stack, int n,
+			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id)
 {
 	struct reftable_merged_table *m =3D NULL;
 	uint64_t last_max =3D 0;
 	uint64_t first_min =3D 0;
-	int i =3D 0;
-	for (i =3D 0; i < n; i++) {
+
+	for (size_t i =3D 0; i < n; i++) {
 		uint64_t min =3D reftable_table_min_update_index(&stack[i]);
 		uint64_t max =3D reftable_table_max_update_index(&stack[i]);
=20
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index e233a9d581..442917cc83 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -88,18 +88,17 @@ static struct reftable_merged_table *
 merged_table_from_records(struct reftable_ref_record **refs,
 			  struct reftable_block_source **source,
 			  struct reftable_reader ***readers, int *sizes,
-			  struct strbuf *buf, int n)
+			  struct strbuf *buf, size_t n)
 {
-	int i =3D 0;
 	struct reftable_merged_table *mt =3D NULL;
-	int err;
 	struct reftable_table *tabs;
+	int err;
=20
 	REFTABLE_CALLOC_ARRAY(tabs, n);
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
=20
-	for (i =3D 0; i < n; i++) {
+	for (size_t i =3D 0; i < n; i++) {
 		write_test_table(&buf[i], refs[i], sizes[i]);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
=20
@@ -263,18 +262,17 @@ static struct reftable_merged_table *
 merged_table_from_log_records(struct reftable_log_record **logs,
 			      struct reftable_block_source **source,
 			      struct reftable_reader ***readers, int *sizes,
-			      struct strbuf *buf, int n)
+			      struct strbuf *buf, size_t n)
 {
-	int i =3D 0;
 	struct reftable_merged_table *mt =3D NULL;
-	int err;
 	struct reftable_table *tabs;
+	int err;
=20
 	REFTABLE_CALLOC_ARRAY(tabs, n);
 	REFTABLE_CALLOC_ARRAY(*readers, n);
 	REFTABLE_CALLOC_ARRAY(*source, n);
=20
-	for (i =3D 0; i < n; i++) {
+	for (size_t i =3D 0; i < n; i++) {
 		write_test_log_table(&buf[i], logs[i], sizes[i], i + 1);
 		block_source_from_strbuf(&(*source)[i], &buf[i]);
=20
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 1a6d16915a..c91a2d83a2 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -33,7 +33,7 @@ struct reftable_table;
    the stack array.
 */
 int reftable_new_merged_table(struct reftable_merged_table **dest,
-			      struct reftable_table *stack, int n,
+			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
=20
 /* returns an iterator positioned just before 'name' */
diff --git a/reftable/stack.c b/reftable/stack.c
index a86481a9a6..bb684a3dc1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -202,18 +202,18 @@ static struct reftable_reader **stack_copy_readers(st=
ruct reftable_stack *st,
 static int reftable_stack_reload_once(struct reftable_stack *st, char **na=
mes,
 				      int reuse_open)
 {
-	int cur_len =3D !st->merged ? 0 : st->merged->stack_len;
+	size_t cur_len =3D !st->merged ? 0 : st->merged->stack_len;
 	struct reftable_reader **cur =3D stack_copy_readers(st, cur_len);
-	int err =3D 0;
-	int names_len =3D names_length(names);
+	size_t names_len =3D names_length(names);
 	struct reftable_reader **new_readers =3D
 		reftable_calloc(names_len, sizeof(*new_readers));
 	struct reftable_table *new_tables =3D
 		reftable_calloc(names_len, sizeof(*new_tables));
-	int new_readers_len =3D 0;
+	size_t new_readers_len =3D 0;
 	struct reftable_merged_table *new_merged =3D NULL;
 	struct strbuf table_path =3D STRBUF_INIT;
-	int i;
+	int err =3D 0;
+	size_t i;
=20
 	while (*names) {
 		struct reftable_reader *rd =3D NULL;
@@ -221,11 +221,10 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
=20
 		/* this is linear; we assume compaction keeps the number of
 		   tables under control so this is not quadratic. */
-		int j =3D 0;
-		for (j =3D 0; reuse_open && j < cur_len; j++) {
-			if (cur[j] && 0 =3D=3D strcmp(cur[j]->name, name)) {
-				rd =3D cur[j];
-				cur[j] =3D NULL;
+		for (i =3D 0; reuse_open && i < cur_len; i++) {
+			if (cur[i] && 0 =3D=3D strcmp(cur[i]->name, name)) {
+				rd =3D cur[i];
+				cur[i] =3D NULL;
 				break;
 			}
 		}
@@ -870,7 +869,7 @@ static int stack_write_compact(struct reftable_stack *s=
t,
 			       size_t first, size_t last,
 			       struct reftable_log_expiry_config *config)
 {
-	int subtabs_len =3D last - first + 1;
+	size_t subtabs_len =3D last - first + 1;
 	struct reftable_table *subtabs =3D reftable_calloc(
 		last - first + 1, sizeof(*subtabs));
 	struct reftable_merged_table *mt =3D NULL;
--=20
2.43.GIT


--6ubrr3GSE+smWrZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXB00EACgkQVbJhu7ck
PpRLTw/+JTua5TGs+/76WbPCG2lEFtTlUy/H4WQT1z378Mq4X2kXmSFMVOHA0L8s
789PyQk92O59wfSGR4D0tNvPCmh2w5TRLiT3mrcqnT1XjPfocB01oHF2vUVD81Uw
dhWILrV2YBON54CJcbMVeCGdVhe2ZmEb3ewyc9CqejcgnhUyO+YeNJ2CPO7BJ0ne
zN+wfbFKgdfsAVs2g+XjtYiQ1B0v0PzaD2q8ZcJox0v2tW3RobmQVzKlYmGWD7En
b2D5rzADRmGtvACG3GXVWQG2kftc3o7oE5+tPyB9xcHjXCENbE7p8THx82gCkGjS
ntH6tQ9sGbUmA4FFe9f+S29FFbrThRZWT3K+r6TiKWnRU7vWfkkw8cfm4FMPyJUx
NGaaLmEmzxUUjwUSFBYSJmTKPWGSP77DHOYNure8RA3ysNFiZswI8iVrMi8lvFQ+
I94QlUb0VVCUKUe2iOP08zPGKtABxc4CiHmwUQIUSPCb5c1gZ3IUC4r1s+Ko65z+
zv4vzlnBFNDRa06UdZe7w767FBz/YasHgh3D/JQB8wkJQguznutOeQ5iulYwHzLn
qqACx3eiyhnJRyAOQz0kTxLo8v0aZHmbm/atwMInoW/N2QhuhnawkohZlq3OX1Y8
X3tG8jX65yN1xF7qXajvpbpMPsEejcJxWOKFjIcBptXfcmLrORk=
=84NW
-----END PGP SIGNATURE-----

--6ubrr3GSE+smWrZZ--
