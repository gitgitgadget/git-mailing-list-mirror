Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7741CAA5
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632703; cv=none; b=p8CjjckDRXsv7Exbvm+dvalVh1m0/QF9zBTtBzFAGdJVVVwIX2T15NSpbBuNUN0JmC9XUNlgFslPXH16iKMZNZz3ArCEraqx14CvdU69SknuaFm3eZ3duhKGS7EjweB6CoRj6//eiGxgY7ZXkGpVO+3/IeOTawlgQ8g2x5EMx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632703; c=relaxed/simple;
	bh=ynRGB7lJG8sNhHFo5sRXSb6Apy316AbP2dmhNzAiKXY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzDEe6maDU29qHzsNug3Ul4sGvnsB1Cp3h9V2YiCP7ftO283dzuNBnjY+O89ZaXIBZQqMC6L4Lve4oeYAEvxCuEH6ytNNmKvogsSJjp000x3Tk0vT4VzTaZFz9k6GVBDRB8tKdaCtg5qTXBSOc+gsd10h9LtDakeo/AatHv2mW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ocq5LfwY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VkiaQNhE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ocq5LfwY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VkiaQNhE"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D141311400CA
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:51:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 02:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632700; x=1714719100; bh=OIC2Jw9GSe
	kd3bCME2UpPW8YcZmAwwuASVSTATkHWvQ=; b=ocq5LfwYQwfE/JK6xjdYNjX7xK
	01mx/EMpp3giQoofjd5vflgLcX+uVYMMbkgkMIpVXN2e29bNQzWZl/wnoSyHdDk9
	bbUWfGIlMOTX1+bx+rLT7bBzmG/O6BLYyR+XSu7kv76A584JIbTb7Apg8asLy46w
	F67Bk1Po+opcUXrt/1GEhQ28QElNnX5P9Sqgt0R14Dx47C/hi5ulXU83Ipv8vQla
	UsPNZrza2jRCmlEdej1/eAETEDdXbxrTmaAuDYnSiHPEunMbCdTAi8D8JuP7UaTJ
	Su0+CRJ+qJON4w7xsaZpXVemd8Esr3qrxPajBJUyDaVaPgEhCwBu3Xd2fFaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632700; x=1714719100; bh=OIC2Jw9GSekd3bCME2UpPW8YcZmA
	wwuASVSTATkHWvQ=; b=VkiaQNhE6AAdppSpXq3vnG5TMilGM0lRkHQbAO0FJTyZ
	pSIMgUw/wIFxL0QlynmcGazoSM9Vd1ZWpvXr21mJH5z1X1gKnbPWA22w2I7o6AGv
	4GU8LsNs+BZS8OUPVeIsEppun11xFdMf6+zXZ0R0bfOAdeuBgCQlsBRVVKE+6XBK
	h8UDFxxWfkIcuwP+PQUuwrbLMGqk/F+KnDwEijTzfK3trQBmd0uG+6mpWniysbLb
	IIjl5a0EPnpCk/8j100P1r145QFBnRWPMBK0S32kLwRjKcgiFZPmoQC8MbjjhSfr
	v/P6EoS4NuaygXtDu1mtINzl6jQmDZ3IWzq941iWrQ==
X-ME-Sender: <xms:_DczZv0p367PPVinX1CUDgeojKrFSemQgbar5dQj2ddZu2PVzBH3Wg>
    <xme:_DczZuFK8Fe3T3zY25fXlNYlQ8XB0HBk5jRatckl5-k-Wqf_whV1YroOKMghWnFx7
    iaS_srDUmJb_BTkiQ>
X-ME-Received: <xmr:_DczZv5fYnGk9U3b0JSb6-_RYbgdvn1_ymhrxhgHH8H5bTR8zxh35TITT2HA2TWGjoQJR8R9PHhACaC16Gbky1o-yk5VIxx36PQ9AY45obpdk7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_DczZk1_LLDTFaRPB8u0rPusbidXPO0tUYCIJgmO_nIv7MKl1JQKng>
    <xmx:_DczZiEmkVrgoSJtY8OHeutqP8pLAhq1ZiTSqFsWHCsQHUmd3JylVQ>
    <xmx:_DczZl9-YT27jPjmq4VmYxL7XaqE-4EIjTNKslULgKT2Ivn3X1wUKw>
    <xmx:_DczZvm5PQ4rwTLfYhv8jB5xd1ptWxD5I1lwu1oQbqrftDnGPgcihw>
    <xmx:_DczZkNHRa3Awd68zsrMdmGUd5QfPu6CwV8psjCLcRgVZPM9mamxt1eg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:51:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e628a170 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:14 +0000 (UTC)
Date: Thu, 2 May 2024 08:51:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/11] reftable: consistently pass write opts as value
Message-ID: <d8a0764e8783c26cba247cdb8b497636433d199b.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uytVWq6g3yRnpaR0"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--uytVWq6g3yRnpaR0
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


--uytVWq6g3yRnpaR0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzN/gACgkQVbJhu7ck
PpRrIA//b4RI/sel0iKP5szeFqTdPy6KClCyBdmxKhRJt7xf8dj1MfDQv4j4adpz
1UGjJkw+t9hb5XnpzU9BPgB7ny7AFktU/WdfYzYvGkkLpCSvxNrJ/riMsrxsH52G
I41xE4+Nh4esLQ3knvSWgQpKqOv5nqdAdYwQ4hp5z4vEOKGQT66ZDLsRDHY8qeT3
UiPXy7xr8MIcljTgyP+cjUDNEdjLglbS7pxJcvQh5euHeEDtTu3xlENUeyUsCLlA
u2avmljkJdtaDR2BXcpvjeA6fh64ROKTSod/A2Uy0VOrq4EZIYMqePLWdOvdy21P
LT9tXunCS65EdYbxio1Sz5LOaQQWgnMdMOmaF28MFu3LwEK0qa5kTmSOmzgJPXOr
oYceZUVjIxE9XTHWj2zzXg2I4graZOjiCiF/09TpQwVyx8f1j2PEi29RiyqN6Ki7
mmd4n2NZVyFboHsIPL6ohaP71QylhKKW0endizojBjUafZ8T9x+phCkBbdLtS1Yb
klB9JA/3ZFNGI7mevnLg1QosAHa69ZrBwtdhec1+sNoNx8Md/YISs2SU3ASYHsDr
LNweHgt4hnaCDdVDsQVJaUGeGon0lvilv6sdgXjjFXMJuIhJaEtfRaUfQ42uwkjf
ELSICtWrDFGnniZBDrkms1wbLOqhfvnVQmbGFBK1JKYo4ZV37Ho=
=g+fZ
-----END PGP SIGNATURE-----

--uytVWq6g3yRnpaR0--
