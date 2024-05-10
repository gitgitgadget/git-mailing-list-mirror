Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A64168B01
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336971; cv=none; b=AfFCEGEVGU2jZ6v/214KucpSiXcsukF7jwS3oIvsiOX35WLI2pN6dqbJGP0Jrmp/1ihzdKV7gKH16rD8SRFGLDr0zf7wdm1FYmrLbtpYEElCKyTxz3MGEaRwsG0e6MqQaSfzBLJjQjOIkGcX3THUbccjzBTj6zR1Bw40IUYkHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336971; c=relaxed/simple;
	bh=gu/fthYt8H/q7rhSnojtHqzpVupq2uxZt+5jzmWFh7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCBBL/VehboUbMHGtTnusLZtkmAjs2jCG7eJ5aBAEkvyDh3jMOCmyVZnIGxknJ5de46waPI58OXVRucVV+YhnvWGiS9n6WxLEnN94B5ofSmrJUJb7rIZ92pTgJEyzyDGfow6RVwHU9/fO+f56qUa9guhymdNhsT128KZSC5y77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CQEKNUsl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0VKwEuh; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CQEKNUsl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0VKwEuh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1AA31180009A;
	Fri, 10 May 2024 06:29:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 06:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336968; x=1715423368; bh=3d0FFhFQHf
	INkXefT8jArDIFCWHcBC6W3EEMM8bSXlA=; b=CQEKNUslGxhrNNxUmU7/SR6bQb
	Y8brxzBFCmedZpQioPBzECxYV/nqusrn79AX4GpSPzC1FVhKvO6pjLirc4GNfNxf
	IEkUWPe0dS2LWv/IlgQo5lzXn+9eO3tfRV6hoEJqfNtiKydQi6DA68Tr46lIMfK/
	1CGhM+Dp7fNho+edmUyNi7JRhWgypJvESpO+OGSbdGPqaq94uxywH/X44DZBxhwG
	keW3DU/SIqnxQL+18Bz8rtBejaqBJcr0zEtmkMferd8cIQEsTvg6hHceKHj4cvku
	O8YfX2ZylgjwZP7WTVkPs11kIeklzGlvYiyU7Ttufbl2wvHVQfPYGVUhtalQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336968; x=1715423368; bh=3d0FFhFQHfINkXefT8jArDIFCWHc
	BC6W3EEMM8bSXlA=; b=e0VKwEuhfV7HD+DbegAaTO4z3Pz9yzprQXK0JNtwQYaW
	zmsfDjzJsc/5sb8LQNKSVB1jBSmCkV/bckLreXeVI9ZkVQj3usWPHm8DrklAQGZR
	w9xopBw/7Y5D6mzNMeVb6CK4y8wdQx/RJSQpKD+uXzVvWR7lu643aBaid5RT+Lci
	LRGVaMmUOo/Fz4tbBOIfIfsUkwOktFTgCmLa2YRPcAnLSZICiOXJJzBbZ/UlByhB
	FRFzYJsjPmWJMXs7Xchpe2yl2oofowidP4IRX1yn8f8ugChPCpgTGTWoymRrt7nu
	FNOOaRtgwioW8WzqQNt2NKgaIMTF2xRnKOWQsEnsmQ==
X-ME-Sender: <xms:CPc9ZkwL6OqVJ5l9zNtQ6msQXy1TdUITgMrhHgE_ZjxWtSS-qckDrw>
    <xme:CPc9ZoQz-Rjqa64OpYKYV7Q6rkxWgbNTVYUQgcQG9aWf_M4EFuWz8im-m4hIL6Od_
    LXKuiqV_7J_IofTwQ>
X-ME-Received: <xmr:CPc9ZmXfc3OxCgGFsuFbzsRlvspLnkE21ccKaxlepNUdo0HjJUusLBY-jztIwPaMJMx2M2ACqSd5ZP6eBeEeeKqSIcGxO-qWgJ7cg2oaB0ptC0KJ3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CPc9ZihICg-Ut_WKSyrxilsBbM9YAKVJOo70rTpxKhgwv5fDBYCbyg>
    <xmx:CPc9ZmBtWBWaSUsiK0DL_5E0-i2zpUlgX8Gj2bJ85svCqEP778Naqw>
    <xmx:CPc9ZjJuUR7GSnr3tEhxjz0fYXTTF_PRTgh-ru6zkxnsHo-JYuN7AA>
    <xmx:CPc9ZtBoYnaDSNcznRRUd33_KoYobHBrq4saqmPo0ILwFvA3CU884A>
    <xmx:CPc9ZhOo0lwDgrY6aBv_jFUqvCesy9qj9mJNtL2PEYCKU5oHgjPwd4B5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 859208f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:15 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/11] reftable: consistently pass write opts as value
Message-ID: <e6f8fc09c282e620a331a737c30a190107c76996.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AQYfH9+PW73CyrId"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--AQYfH9+PW73CyrId
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We sometimes pass the refatble write options as value and sometimes as a
pointer. This is quite confusing and makes the reader wonder whether the
options get modified sometimes.

In fact, `reftable_new_writer()` does cause the caller-provided options
to get updated when some values aren't set up. This is quite unexpected,
but didn't cause any harm until now.

Refactor the code to consistently pass the options as a value so that
they are local to the subsystem they are being passed into so that we
can avoid weirdness like this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged_test.c     |  6 +++---
 reftable/readwrite_test.c  | 26 +++++++++++++-------------
 reftable/refname_test.c    |  2 +-
 reftable/reftable-writer.h |  2 +-
 reftable/stack.c           |  4 ++--
 reftable/writer.c          | 12 +++++++-----
 6 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 530fc82d1c..4ac81de8d4 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -42,7 +42,7 @@ static void write_test_table(struct strbuf *buf,
 		}
 	}
=20
-	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
+	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, opts);
 	reftable_writer_set_limits(w, min, max);
=20
 	for (i =3D 0; i < n; i++) {
@@ -70,7 +70,7 @@ static void write_test_log_table(struct strbuf *buf,
 		.exact_log_message =3D 1,
 	};
 	struct reftable_writer *w =3D NULL;
-	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
+	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, opts);
 	reftable_writer_set_limits(w, update_index, update_index);
=20
 	for (i =3D 0; i < n; i++) {
@@ -403,7 +403,7 @@ static void test_default_write_opts(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
=20
 	struct reftable_ref_record rec =3D {
 		.refname =3D "master",
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a6dbd214c5..27631a041b 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -51,7 +51,7 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 		.hash_id =3D hash_id,
 	};
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, opts);
 	struct reftable_ref_record ref =3D { NULL };
 	int i =3D 0, n;
 	struct reftable_log_record log =3D { NULL };
@@ -129,7 +129,7 @@ static void test_log_buffer_size(void)
 					   .message =3D "commit: 9\n",
 				   } } };
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
=20
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
@@ -172,7 +172,7 @@ static void test_log_overflow(void)
 		},
 	};
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
=20
 	memset(msg, 'x', sizeof(msg) - 1);
 	reftable_writer_set_limits(w, update_index, update_index);
@@ -199,7 +199,7 @@ static void test_log_write_read(void)
 	struct reftable_block_source source =3D { NULL };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	const struct reftable_stats *stats =3D NULL;
 	reftable_writer_set_limits(w, 0, N);
 	for (i =3D 0; i < N; i++) {
@@ -288,7 +288,7 @@ static void test_log_zlib_corruption(void)
 	struct reftable_block_source source =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	const struct reftable_stats *stats =3D NULL;
 	char message[100] =3D { 0 };
 	int err, i, n;
@@ -526,7 +526,7 @@ static void test_table_refs_for(int indexed)
=20
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
=20
 	struct reftable_iterator it =3D { NULL };
 	int j;
@@ -619,7 +619,7 @@ static void test_write_empty_table(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	struct reftable_block_source source =3D { NULL };
 	struct reftable_reader *rd =3D NULL;
 	struct reftable_ref_record rec =3D { NULL };
@@ -657,7 +657,7 @@ static void test_write_object_id_min_length(void)
 	};
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	struct reftable_ref_record ref =3D {
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
@@ -692,7 +692,7 @@ static void test_write_object_id_length(void)
 	};
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	struct reftable_ref_record ref =3D {
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
@@ -726,7 +726,7 @@ static void test_write_empty_key(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	struct reftable_ref_record ref =3D {
 		.refname =3D "",
 		.update_index =3D 1,
@@ -749,7 +749,7 @@ static void test_write_key_order(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	struct reftable_ref_record refs[2] =3D {
 		{
 			.refname =3D "b",
@@ -792,7 +792,7 @@ static void test_write_multiple_indices(void)
 	struct reftable_reader *reader;
 	int err, i;
=20
-	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf=
, &opts);
+	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf=
, opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (i =3D 0; i < 100; i++) {
 		struct reftable_ref_record ref =3D {
@@ -869,7 +869,7 @@ static void test_write_multi_level_index(void)
 	struct reftable_reader *reader;
 	int err;
=20
-	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf=
, &opts);
+	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &writer_buf=
, opts);
 	reftable_writer_set_limits(writer, 1, 1);
 	for (size_t i =3D 0; i < 200; i++) {
 		struct reftable_ref_record ref =3D {
diff --git a/reftable/refname_test.c b/reftable/refname_test.c
index b9cc62554e..3468253be7 100644
--- a/reftable/refname_test.c
+++ b/reftable/refname_test.c
@@ -30,7 +30,7 @@ static void test_conflict(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
-		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
 	struct reftable_ref_record rec =3D {
 		.refname =3D "a/b",
 		.value_type =3D REFTABLE_REF_SYMREF,
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 155bf0bbe2..44cb986465 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -92,7 +92,7 @@ struct reftable_stats {
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
-		    void *writer_arg, struct reftable_write_options *opts);
+		    void *writer_arg, struct reftable_write_options opts);
=20
 /* Set the range of update indices for the records we will add. When writi=
ng a
    table into a stack, the min should be at least
diff --git a/reftable/stack.c b/reftable/stack.c
index 3979657793..7b4fff7c9e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -767,7 +767,7 @@ int reftable_addition_add(struct reftable_addition *add,
 	tab_fd =3D get_tempfile_fd(tab_file);
=20
 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &tab_fd,
-				 &add->stack->opts);
+				 add->stack->opts);
 	err =3D write_table(wr, arg);
 	if (err < 0)
 		goto done;
@@ -861,7 +861,7 @@ static int stack_compact_locked(struct reftable_stack *=
st,
 	}
=20
 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush,
-				 &tab_fd, &st->opts);
+				 &tab_fd, st->opts);
 	err =3D stack_write_compact(st, wr, first, last, config);
 	if (err < 0)
 		goto done;
diff --git a/reftable/writer.c b/reftable/writer.c
index 1d9ff0fbfa..ad2f2e6c65 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -122,20 +122,22 @@ static struct strbuf reftable_empty_strbuf =3D STRBUF=
_INIT;
 struct reftable_writer *
 reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size_t),
 		    int (*flush_func)(void *),
-		    void *writer_arg, struct reftable_write_options *opts)
+		    void *writer_arg, struct reftable_write_options opts)
 {
 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
 	strbuf_init(&wp->block_writer_data.last_key, 0);
-	options_set_defaults(opts);
-	if (opts->block_size >=3D (1 << 24)) {
+
+	options_set_defaults(&opts);
+	if (opts.block_size >=3D (1 << 24)) {
 		/* TODO - error return? */
 		abort();
 	}
+
 	wp->last_key =3D reftable_empty_strbuf;
-	REFTABLE_CALLOC_ARRAY(wp->block, opts->block_size);
+	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 	wp->write =3D writer_func;
 	wp->write_arg =3D writer_arg;
-	wp->opts =3D *opts;
+	wp->opts =3D opts;
 	wp->flush =3D flush_func;
 	writer_reinit_block_writer(wp, BLOCK_TYPE_REF);
=20
--=20
2.45.0


--AQYfH9+PW73CyrId
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99wQACgkQVbJhu7ck
PpSLYw//cMUcwbg258YXkSQilzzSGsLLD0uLeBNtAlalh3LOKZYlEevMPqLEuXcN
CY/zaw7s0/pIzWCHvGG5VkfZnaCKJkAMYVY3K4hjdZhAWe6kNLOtlfSee1SWZgN4
iHcMW9SXXCsSXSTOqR86ODJD5ci0DwzZSVH3jNk/pYHzYR3sjS9hE9t0pIDGvPZG
nzGnBUuxsGrMIu42r4zaulUwGSegHrB95/Agoa7nV9PICrLpXZM+/tPom9zVRT8L
q5hxq1c86hii536R0f+BlOAKWfy9vZIGg2M0wBdxTXeAB9TkmSlzoqEox4Gk0OOj
emd5APJwM6vrn8Z110gjr0xfJ6dNEmjHLvgEa94W6CuncxX595JJp9AYgUisiXiA
P2pUsixKJmXBlKE6Yk8vzPRPC4DAX9LLriVNjFJd3OZOcO7iEd4bf4dziTkGUDPO
c9DHsGaPNR/152yREqq83fo88YO6XksCPixMzn5dgQjnRGI4rhNHuq42foKyhhNO
WdOGlAXNCQyB0bjw1oqH3hmPL4L9E5Pj2DyhnEMA9Ia1XTL5GpNr16DRg4Q6Jvu8
HaAkwu8mbeo5TkqndOKdlueB1aFVebGwLFaMRZdcBZU6ICDN2E9HZJIIMBpPkHeC
BplF0pxdksRTR+JzwCnQ+bTFmsAG0aIdxM3rBmkRbUlo5ICPOUY=
=PlvY
-----END PGP SIGNATURE-----

--AQYfH9+PW73CyrId--
