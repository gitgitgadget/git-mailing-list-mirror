Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C2142E68
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986672; cv=none; b=YVEccvnNma4h+f7dZib1MbKUjFfg+AAk1hxWoQCSkyjYT0NLvCnGc8tf6EE6A6/IHjMoVjFONCZ+XDFkhRJU4I/EPkb2C529pz7ixPMq4j42i3CgaG6dRNIIpBj1NvyYwF53TMQOf3pLc7YPVM42J3aYznCdpPvvMoicVtWQ7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986672; c=relaxed/simple;
	bh=D1Bvd2LSoY6v4CKxJubiT6ZoOo4sC04b7JcwBUuJzX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tm3k3Qblg99xXFW/G4VkkEEdc19Mq5et4AnFq9Fa1KLgHCKMwS53f8BeoaH9n9rRZfGyeuBepT6vu7FeeC/4XTq/zbkq4vxWrFGklK+L9r0v9MGWdOZjNUEFLTz4m4pkk7/baip0AW81xH5SSf09UkAmKzjjlA9F5tUqTRszr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k5A0H15N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLSj7o+p; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k5A0H15N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLSj7o+p"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 6140D1C0012D;
	Wed, 29 May 2024 08:44:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 08:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986668; x=1717073068; bh=6AP1D/Ph8M
	ajefStJ5HPWtalGrWSVK1tqq2ggd2IMCM=; b=k5A0H15Naf5L85HMCT8PdkvJP3
	dSjcFkh+S2W2ghW7XHCwppznidlCdbZ+Ziq3Ny/baVaHphTV6yq/mvReyPoSpBAw
	DRysq8O/fclNomHKOHx+M+qecprTWt53D1H9HYR262xf/FXxKivWv7Wcn994r2gX
	uj7qkaUzxbfdmWw6gsincyL8N3ZU/ypL+5VwsO/2PvFvY2WhCyZCBWVnggsBIQzh
	6jeI4Qbsm/eOWRigaOjNvOJCjiG+2Ha3AKuk8RbiCe07aL5gohRYWasbeTBk2q/i
	HcOmxfF/OL9ZQsIJ+9wMEeWRozTgyIW1jfjXZoWYOF+Qpi9F8+p0KU+gje7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986668; x=1717073068; bh=6AP1D/Ph8MajefStJ5HPWtalGrWS
	VK1tqq2ggd2IMCM=; b=MLSj7o+pHsic/7YEdrx7Wrk+whb0y4ZLgarokhswPFOU
	T3rzy4I7N03L2ora1GJhN3eGLxbxY65CmjKtfVFOJ9txelBEMLZbPGu8IRI83ftT
	Eb2/9N6cZqJfW+BOGNpy6LgLnYSW4C7q2L1ebtgRtpEoLpLnwu8dc1NinhamErEm
	ayLgYglozpTSWbcmraqkuC84CFjmFGQAG8dCKna2RHJV/luRzNFG4KEkpnTbBgkp
	j4sVNF5I8gqIW/ePvyn+zpgrW1wqP98fiEoJmB6mXWzEOfT9Mji2aqDU4xZzaX6b
	tnl5RSvNYYkcjtUTyQ9Pl/OvQyCOfa0s2YuZgNegWQ==
X-ME-Sender: <xms:LCNXZmzQr1LgVzF2fEDja5koW5VKJNrNSnbkvufHsNjRbutsKrIMow>
    <xme:LCNXZiTioj2xzymWP9OvqA8bEi7Y792xXgROJxN8c-biDiSBKxTvK9Vpa3nP_HFut
    iZAULJipbQFrltLiA>
X-ME-Received: <xmr:LCNXZoX5Fj4-L7Kbrwft1OlFlHtoN_ogDr42O-GEzOYmYWPW539Av0FDOR_ilUbUqgNlvtD-DTDF8OnLDnrhR_1D43bB4K4o9DimRt48lR8L7BnW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeegtddvkeegveejjeefgfdvffetfedvie
    dvleeuieelleffteegvdevvdejveekffenucffohhmrghinhepuhhpuggrthgvrdhnvgif
    pdhuphgurghtvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LCNXZsgndbWcA-IaxzaIstF_n-aFkFBTCOgyEIOhLBWXfJqHlX9ovg>
    <xmx:LCNXZoBkQ92rx7HkIlp_JHTv6aT-_X1Ac1INyPt_LTuTb5-3GFaIsQ>
    <xmx:LCNXZtJm4-gu8ASUQW23_4wNgPTeeYiOJmfV8Mkn1jSQhyROsAznvg>
    <xmx:LCNXZvAEac9qiEZj0vBZgzSpCADRS9JvfqaKqr5kYs8b1rvrWJ5lQg>
    <xmx:LCNXZrOBZiQeyJZRiA5BXjfIXWCoKbodx7_yJ2Tt3ewwu_ALDMicoLRC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1f096dbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:13 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 05/19] reftable: improve const correctness when assigning
 string constants
Message-ID: <dc5d85257eef747f2331638ed718b0f7a5bb1da2.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6GHQVbLKrqkR9zC3"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--6GHQVbLKrqkR9zC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are many cases in the reftable tests where we assign string
constants to non-const fields. This is harmless because we know that
those fields are only used for reading access, but will break once we
enable `-Wwrite-strings`. Add explicit casts to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics_test.c    |  4 +--
 reftable/block_test.c     |  2 +-
 reftable/merged_test.c    | 45 +++++++++++++--------------
 reftable/readwrite_test.c | 47 ++++++++++++++--------------
 reftable/stack_test.c     | 65 ++++++++++++++++++++-------------------
 5 files changed, 82 insertions(+), 81 deletions(-)

diff --git a/reftable/basics_test.c b/reftable/basics_test.c
index 997c4d9e01..af9209d535 100644
--- a/reftable/basics_test.c
+++ b/reftable/basics_test.c
@@ -58,8 +58,8 @@ static void test_binsearch(void)
=20
 static void test_names_length(void)
 {
-	char *a[] =3D { "a", "b", NULL };
-	EXPECT(names_length(a) =3D=3D 2);
+	char *names[] =3D { (char *)"a", (char *)"b", NULL };
+	EXPECT(names_length(names) =3D=3D 2);
 }
=20
 static void test_parse_names_normal(void)
diff --git a/reftable/block_test.c b/reftable/block_test.c
index 26a9cfbc83..34c48c8091 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -42,7 +42,7 @@ static void test_block_read_write(void)
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
=20
-	rec.u.ref.refname =3D "";
+	rec.u.ref.refname =3D (char *)"";
 	rec.u.ref.value_type =3D REFTABLE_REF_DELETION;
 	n =3D block_writer_add(&bw, &rec);
 	EXPECT(n =3D=3D REFTABLE_API_ERROR);
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 530fc82d1c..6ab8ea2858 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -124,13 +124,13 @@ static void readers_destroy(struct reftable_reader **=
readers, size_t n)
 static void test_merged_between(void)
 {
 	struct reftable_ref_record r1[] =3D { {
-		.refname =3D "b",
+		.refname =3D (char *)"b",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D { 1, 2, 3, 0 },
 	} };
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D "a",
+		.refname =3D (char *)"a",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
@@ -165,38 +165,38 @@ static void test_merged(void)
 {
 	struct reftable_ref_record r1[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *)"a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D "b",
+			.refname =3D (char *)"b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D "c",
+			.refname =3D (char *)"c",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		}
 	};
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D "a",
+		.refname =3D (char *)"a",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
 	struct reftable_ref_record r3[] =3D {
 		{
-			.refname =3D "c",
+			.refname =3D (char *)"c",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 2 },
 		},
 		{
-			.refname =3D "d",
+			.refname =3D (char *)"d",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
@@ -291,46 +291,46 @@ static void test_merged_logs(void)
 {
 	struct reftable_log_record r1[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *)"a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 2 },
 				/* deletion */
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message2",
+				.name =3D (char *)"jane doe",
+				.email =3D (char *)"jane@invalid",
+				.message =3D (char *)"message2",
 			}
 		},
 		{
-			.refname =3D "a",
+			.refname =3D (char *)"a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message1",
+				.name =3D (char *)"jane doe",
+				.email =3D (char *)"jane@invalid",
+				.message =3D (char *)"message1",
 			}
 		},
 	};
 	struct reftable_log_record r2[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *)"a",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.new_hash =3D { 3 },
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message3",
+				.name =3D (char *)"jane doe",
+				.email =3D (char *)"jane@invalid",
+				.message =3D (char *)"message3",
 			}
 		},
 	};
 	struct reftable_log_record r3[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *)"a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_DELETION,
 		},
@@ -404,9 +404,8 @@ static void test_default_write_opts(void)
 	struct strbuf buf =3D STRBUF_INIT;
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
-
 	struct reftable_ref_record rec =3D {
-		.refname =3D "master",
+		.refname =3D (char *)"master",
 		.update_index =3D 1,
 	};
 	int err;
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a6dbd214c5..72f66507ba 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -86,7 +86,7 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 		log.update_index =3D update_index;
 		log.value_type =3D REFTABLE_LOG_UPDATE;
 		set_test_hash(log.value.update.new_hash, i);
-		log.value.update.message =3D "message";
+		log.value.update.message =3D (char *)"message";
=20
 		n =3D reftable_writer_add_log(w, &log);
 		EXPECT(n =3D=3D 0);
@@ -117,17 +117,18 @@ static void test_log_buffer_size(void)
 	};
 	int err;
 	int i;
-	struct reftable_log_record
-		log =3D { .refname =3D "refs/heads/master",
-			.update_index =3D 0xa,
-			.value_type =3D REFTABLE_LOG_UPDATE,
-			.value =3D { .update =3D {
-					   .name =3D "Han-Wen Nienhuys",
-					   .email =3D "hanwen@google.com",
-					   .tz_offset =3D 100,
-					   .time =3D 0x5e430672,
-					   .message =3D "commit: 9\n",
-				   } } };
+	struct reftable_log_record log =3D {
+		.refname =3D (char *)"refs/heads/master",
+		.update_index =3D 0xa,
+		.value_type =3D REFTABLE_LOG_UPDATE,
+		.value.update =3D {
+			.name =3D (char *)"Han-Wen Nienhuys",
+			.email =3D (char *)"hanwen@google.com",
+			.tz_offset =3D 100,
+			.time =3D 0x5e430672,
+			.message =3D (char *)"commit: 9\n",
+		},
+	};
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
=20
@@ -156,15 +157,15 @@ static void test_log_overflow(void)
 	};
 	int err;
 	struct reftable_log_record log =3D {
-		.refname =3D "refs/heads/master",
+		.refname =3D (char *)"refs/heads/master",
 		.update_index =3D 0xa,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D "Han-Wen Nienhuys",
-				.email =3D "hanwen@google.com",
+				.name =3D (char *)"Han-Wen Nienhuys",
+				.email =3D (char *)"hanwen@google.com",
 				.tz_offset =3D 100,
 				.time =3D 0x5e430672,
 				.message =3D msg,
@@ -293,14 +294,14 @@ static void test_log_zlib_corruption(void)
 	char message[100] =3D { 0 };
 	int err, i, n;
 	struct reftable_log_record log =3D {
-		.refname =3D "refname",
+		.refname =3D (char *)"refname",
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.new_hash =3D { 1 },
 				.old_hash =3D { 2 },
-				.name =3D "My Name",
-				.email =3D "myname@invalid",
+				.name =3D (char *)"My Name",
+				.email =3D (char *)"myname@invalid",
 				.message =3D message,
 			},
 		},
@@ -728,7 +729,7 @@ static void test_write_empty_key(void)
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record ref =3D {
-		.refname =3D "",
+		.refname =3D (char *)"",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_DELETION,
 	};
@@ -752,18 +753,18 @@ static void test_write_key_order(void)
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record refs[2] =3D {
 		{
-			.refname =3D "b",
+			.refname =3D (char *)"b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D "target",
+				.symref =3D (char *)"target",
 			},
 		}, {
-			.refname =3D "a",
+			.refname =3D (char *)"a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D "target",
+				.symref =3D (char *)"target",
 			},
 		}
 	};
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7889f818d1..0994f6bcda 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -83,7 +83,7 @@ static void test_read_file(void)
 	char out[1024] =3D "line1\n\nline2\nline3";
 	int n, err;
 	char **names =3D NULL;
-	char *want[] =3D { "line1", "line2", "line3" };
+	const char *want[] =3D { "line1", "line2", "line3" };
 	int i =3D 0;
=20
 	EXPECT(fd > 0);
@@ -116,13 +116,14 @@ static void test_parse_names(void)
=20
 static void test_names_equal(void)
 {
-	char *a[] =3D { "a", "b", "c", NULL };
-	char *b[] =3D { "a", "b", "d", NULL };
-	char *c[] =3D { "a", "b", NULL };
-
-	EXPECT(names_equal(a, a));
-	EXPECT(!names_equal(a, b));
-	EXPECT(!names_equal(a, c));
+	char a[] =3D "a", b[] =3D "b", c[] =3D "c", d[] =3D "d";
+	char *abc[] =3D { a, b, c, NULL };
+	char *abd[] =3D { a, b, d, NULL };
+	char *ab[] =3D { a, b, NULL };
+
+	EXPECT(names_equal(abc, abc));
+	EXPECT(!names_equal(abc, abd));
+	EXPECT(!names_equal(abc, ab));
 }
=20
 static int write_test_ref(struct reftable_writer *wr, void *arg)
@@ -156,10 +157,10 @@ static void test_reftable_stack_add_one(void)
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record ref =3D {
-		.refname =3D "HEAD",
+		.refname =3D (char *)"HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *)"master",
 	};
 	struct reftable_ref_record dest =3D { NULL };
 	struct stat stat_result =3D { 0 };
@@ -216,16 +217,16 @@ static void test_reftable_stack_uptodate(void)
=20
 	int err;
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D "HEAD",
+		.refname =3D (char *)"HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *)"master",
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D "branch2",
+		.refname =3D (char *)"branch2",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *)"master",
 	};
=20
=20
@@ -264,10 +265,10 @@ static void test_reftable_stack_transaction_api(void)
 	struct reftable_addition *add =3D NULL;
=20
 	struct reftable_ref_record ref =3D {
-		.refname =3D "HEAD",
+		.refname =3D (char *)"HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *)"master",
 	};
 	struct reftable_ref_record dest =3D { NULL };
=20
@@ -313,7 +314,7 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *)"master",
 		};
 		char name[100];
=20
@@ -356,7 +357,7 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
 static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 {
 	struct reftable_ref_record ref =3D {
-		.refname =3D "refs/heads/master",
+		.refname =3D (char *)"refs/heads/master",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D {0x01},
@@ -409,16 +410,16 @@ static void test_reftable_stack_update_index_check(vo=
id)
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D "name1",
+		.refname =3D (char *)"name1",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *)"master",
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D "name2",
+		.refname =3D (char *)"name2",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *)"master",
 	};
=20
 	err =3D reftable_new_stack(&st, dir, cfg);
@@ -561,7 +562,7 @@ static void test_reftable_stack_log_normalize(void)
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
 	struct reftable_log_record input =3D {
-		.refname =3D "branch",
+		.refname =3D (char *)"branch",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
@@ -582,11 +583,11 @@ static void test_reftable_stack_log_normalize(void)
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
=20
-	input.value.update.message =3D "one\ntwo";
+	input.value.update.message =3D (char *)"one\ntwo";
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT(err =3D=3D REFTABLE_API_ERROR);
=20
-	input.value.update.message =3D "one";
+	input.value.update.message =3D (char *)"one";
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
=20
@@ -594,7 +595,7 @@ static void test_reftable_stack_log_normalize(void)
 	EXPECT_ERR(err);
 	EXPECT(0 =3D=3D strcmp(dest.value.update.message, "one\n"));
=20
-	input.value.update.message =3D "two\n";
+	input.value.update.message =3D (char *)"two\n";
 	arg.update_index =3D 2;
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
@@ -697,9 +698,9 @@ static void test_reftable_stack_hash_id(void)
 	int err;
=20
 	struct reftable_ref_record ref =3D {
-		.refname =3D "master",
+		.refname =3D (char *)"master",
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "target",
+		.value.symref =3D (char *)"target",
 		.update_index =3D 1,
 	};
 	struct reftable_write_options cfg32 =3D { .hash_id =3D GIT_SHA256_FORMAT_=
ID };
@@ -879,7 +880,7 @@ static void test_reftable_stack_auto_compaction(void)
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *)"master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -913,7 +914,7 @@ static void test_reftable_stack_add_performs_auto_compa=
ction(void)
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *)"master",
 		};
=20
 		/*
@@ -964,7 +965,7 @@ static void test_reftable_stack_compaction_concurrent(v=
oid)
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *)"master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -1014,7 +1015,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *)"master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
--=20
2.45.1.313.g3a57aa566a.dirty


--6GHQVbLKrqkR9zC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIygACgkQVbJhu7ck
PpRkMA/8CGYKOQEe3ZGtPWkOw0oLAtKX3bk0Bsx5JtBJrdPk1wi3XywMYEzSFvjF
9kTa5YtiTeGI2k4zs33Bdz8h+M1VwbNkE55KMuEansvWdSbbzS7kBAdFPuP8yygN
XcpDReQ7cTPxltLaKvv2CLdXb0kR0TdA7F1P19zmz5oWHG8lAUpBFKXGY4mZZC9B
EBSy+wJGPQ84nK2DCKj15ZzWMB6QrGs3Qkx+KSsmfz2dFy1xYgGzB/8HKYnsDEoK
ws5cDj1t9TfAVmcPJauTvG/SfayrkZS6tX24YRGvIr7cK4cQB+kHzk2X/rufmFtH
7/bIYln+wQ+N1ZgVYGQeb44IUKjKtaxS3oPM7S5MgFbdM7UMaRpfr+ZtGWmTNahn
W6guXM5EkLbydlFLyaNfYRtnLmq0i1SFwWtyes2QUfd3weNNfoB9ahL23OaO6dbi
muukvXxbmXqGpv6awyMrDxLvt43TMKKGzAg17eu46+lfZHDTOFtWvg11jN6SQiLP
frI7kqEb7xiLo45Y0kHT6BDUM9hI3Mb/XX5tZP7t3rNl2ZnqSzTz1HjN8YGIunbU
rXRQH1kGIwxvRTCTLYdBVqe0vVZWIaQUgJM3g0O/d4r3clFLh2lvbw/jZMxHKUwq
AT9Nx8gWFgaAgjVKe7Y/7+IlUOAdY5XUzBf8NyO6d12foajtlY4=
=rr4Q
-----END PGP SIGNATURE-----

--6GHQVbLKrqkR9zC3--
