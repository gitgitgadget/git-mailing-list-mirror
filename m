Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398518C33C
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669690; cv=none; b=bd1a30vxyLbg+KHHo1v7OGoo1g5lD3lPkrsiJRuWrUbxeWuAbp9E2Qw2UR9Jtq/J3yGVYHxsLCjE6P7eUOvyDM1o4AwjltJ+dzL+6rwtuwVBXpFV6x3GguO4gvsQkg+SPwvrrC+JoBC2yt5qCPYD8lTqjdGM6a+zHxGPsigGT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669690; c=relaxed/simple;
	bh=bUrFKJ9X9YK3Lg82NHgjjfi5ESeDF8P3vZyX1IZzhWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMRJSpIHG55LWAdjBeAEkw/c0K0NT3Zk0Q0mMEiKtII20Bw+Iv1RXBzU9WA7G6SP1iedolhqzH9ITJB8G5JWBba06FQzo4vZLQ10YxEKV9KqJKPynRlb0oQda/zk1fO6qKAr1IpJi1hjbs2ev4AMx1SPLmRW0toawvJRxZNrvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KaUyuunT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BfCQ1qoM; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KaUyuunT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BfCQ1qoM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9BC9E1140138;
	Thu,  6 Jun 2024 06:28:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669687; x=1717756087; bh=oU3kIUbLFp
	SITxmoMQWAefQ4Cn9aqjsmma23AwXSfR0=; b=KaUyuunTZYf+r525PNo9llnScy
	pd8TgVp+WX/ETmxZY8ze8TetZq0KIk7i6IbG6HIOJUeC/4Tg50TOQom11tvTdZOk
	8yqKchGEUr1oxMbFDJI31/indaF5En/Y4e0hxNeEvB1+AdA3bO378m6F/UO0m6dI
	a4Qg8QIDslAsCXELvBPEEPPgNdqUggLMiGrmDkPW2Qm8MJR/jN700LGWn2GqoCB5
	Rs+wzOlVLlhcJMEmE5CinzffAudLVe500UMXdED3QzsB0/+8WTjADdna855GK0Px
	HgzRf1jDBZxbai7JiNpR5vwv9gmmeOoz+ELXJGI6eDtAKgNK8bj9f7aDjrRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669687; x=1717756087; bh=oU3kIUbLFpSITxmoMQWAefQ4Cn9a
	qjsmma23AwXSfR0=; b=BfCQ1qoMWzQvuxY7ZE5BmhG5wQJDLpvg/2XN1eSLXVMh
	2bhNDi+aNrbVhAiX9wv9LCZIHfTnxOZT5UOcDTQVkCRUMMOUY70ZXS0oVx/r4ngz
	YAJVho5hAkFrMV92oDodioUFnbDB08fxyFy0hUpa89wJvI9wY9Vx04SsfxgBhxXk
	O8z1XcvQ6up4Eob5hXsP0SGsjf6lyLReMqLl0x8C+icUky3Yr7GA+qh9W/2tOjh9
	6QXOxGijVC369vvFSHBr65aTb4ZoEp6/gAA1ydrKL4X3VfRbBo8mLilgLwLTbrzb
	sOpy8K/xgfODI4oXx99oIUKW/N0EcQBkIMRDRbBUgg==
X-ME-Sender: <xms:N49hZk5wZmCE4wthIAKe0ZFg6f7aQRD_SBe3Tga6kiig8BvrkwUmig>
    <xme:N49hZl4BYohUaJCqnk9mSKzO7KhiJfcDMdQIjzq3cLJKS30YVwFcX6P3tfOPoTraG
    cuAv6Ka8_ScOLJPZA>
X-ME-Received: <xmr:N49hZjdh_dzIABSZjhXtLhR_oZ4i8F1AFNMnxbrcGLpFAPjft5-Uwv9hzfQPRMhfs6q_GPiRBAR0CgLIBNu_3xvYlASsxh-oZmyY5oQ4k-4n485M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgeevtdffhedvheehgeeuuefffeetiedtfeehjeehteevieehkeekieefhfdvveeh
    necuffhomhgrihhnpehuphgurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:N49hZpI60VK-QqjSfqo465dl1n953HpHWCgnBLSq0WIA-OdS7qcopQ>
    <xmx:N49hZoLgkBQZyUnSBkR5T-Btd0u6Asjot9iTa7_IHRuz8aYkxNGdow>
    <xmx:N49hZqz_IiBvzhaywr4O7v6qEzx9xk9MTh2rbNLufuNUIO-09_rqEw>
    <xmx:N49hZsL1yG1q-6tTYeRPlUNJtEB6rKsPEB1WYLGox5Ln8MSciaWtOg>
    <xmx:N49hZtG6hk9Zl6yOu92GNr0B6rjf1pXJFIAQwRy5hCbE73z02fq4iR1h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8e5c76ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:36 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 04/27] reftable: cast away constness when assigning
 constants to records
Message-ID: <d0a2a2f6c55af6da9703a1d64f45f77f4c00cd80.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OisMp4ls4rB3zqsk"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--OisMp4ls4rB3zqsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable records are used in multiple ways throughout the reftable
library. In many of those cases they merely act as input to a function
without getting modified by it at all. Most importantly, this happens
when writing records and when querying for records.

We rely on this in our tests and thus assign string constants to those
fields, which is about to generate warnings as those fields are of type
`char *`. While we could go through the process and instead allocate
those strings in all of our tests, this feels quite unnecessary.

Instead, add casts to `char *` for all of those strings. As this is part
of our tests, this also nicely serves as a demonstration that nothing
writes or frees those string constants, which would otherwise lead to
segfaults.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block_test.c     |  2 +-
 reftable/merged_test.c    | 44 +++++++++++++++++------------------
 reftable/readwrite_test.c | 32 +++++++++++++-------------
 reftable/stack_test.c     | 48 +++++++++++++++++++--------------------
 4 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/reftable/block_test.c b/reftable/block_test.c
index 26a9cfbc83..90aecd5a7c 100644
--- a/reftable/block_test.c
+++ b/reftable/block_test.c
@@ -42,7 +42,7 @@ static void test_block_read_write(void)
 	block_writer_init(&bw, BLOCK_TYPE_REF, block.data, block_size,
 			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
=20
-	rec.u.ref.refname =3D "";
+	rec.u.ref.refname =3D (char *) "";
 	rec.u.ref.value_type =3D REFTABLE_REF_DELETION;
 	n =3D block_writer_add(&bw, &rec);
 	EXPECT(n =3D=3D REFTABLE_API_ERROR);
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index 530fc82d1c..6d1159d12d 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -124,13 +124,13 @@ static void readers_destroy(struct reftable_reader **=
readers, size_t n)
 static void test_merged_between(void)
 {
 	struct reftable_ref_record r1[] =3D { {
-		.refname =3D "b",
+		.refname =3D (char *) "b",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D { 1, 2, 3, 0 },
 	} };
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D "a",
+		.refname =3D (char *) "a",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
@@ -165,38 +165,38 @@ static void test_merged(void)
 {
 	struct reftable_ref_record r1[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *) "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D "b",
+			.refname =3D (char *) "b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		},
 		{
-			.refname =3D "c",
+			.refname =3D (char *) "c",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
 		}
 	};
 	struct reftable_ref_record r2[] =3D { {
-		.refname =3D "a",
+		.refname =3D (char *) "a",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_DELETION,
 	} };
 	struct reftable_ref_record r3[] =3D {
 		{
-			.refname =3D "c",
+			.refname =3D (char *) "c",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 2 },
 		},
 		{
-			.refname =3D "d",
+			.refname =3D (char *) "d",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_REF_VAL1,
 			.value.val1 =3D { 1 },
@@ -291,46 +291,46 @@ static void test_merged_logs(void)
 {
 	struct reftable_log_record r1[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *) "a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 2 },
 				/* deletion */
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message2",
+				.name =3D (char *) "jane doe",
+				.email =3D (char *) "jane@invalid",
+				.message =3D (char *) "message2",
 			}
 		},
 		{
-			.refname =3D "a",
+			.refname =3D (char *) "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message1",
+				.name =3D (char *) "jane doe",
+				.email =3D (char *) "jane@invalid",
+				.message =3D (char *) "message1",
 			}
 		},
 	};
 	struct reftable_log_record r2[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *) "a",
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
 				.new_hash =3D { 3 },
-				.name =3D "jane doe",
-				.email =3D "jane@invalid",
-				.message =3D "message3",
+				.name =3D (char *) "jane doe",
+				.email =3D (char *) "jane@invalid",
+				.message =3D (char *) "message3",
 			}
 		},
 	};
 	struct reftable_log_record r3[] =3D {
 		{
-			.refname =3D "a",
+			.refname =3D (char *) "a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_DELETION,
 		},
@@ -406,7 +406,7 @@ static void test_default_write_opts(void)
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
=20
 	struct reftable_ref_record rec =3D {
-		.refname =3D "master",
+		.refname =3D (char *) "master",
 		.update_index =3D 1,
 	};
 	int err;
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index a6dbd214c5..c55019232b 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -86,7 +86,7 @@ static void write_table(char ***names, struct strbuf *buf=
, int N,
 		log.update_index =3D update_index;
 		log.value_type =3D REFTABLE_LOG_UPDATE;
 		set_test_hash(log.value.update.new_hash, i);
-		log.value.update.message =3D "message";
+		log.value.update.message =3D (char *) "message";
=20
 		n =3D reftable_writer_add_log(w, &log);
 		EXPECT(n =3D=3D 0);
@@ -118,15 +118,15 @@ static void test_log_buffer_size(void)
 	int err;
 	int i;
 	struct reftable_log_record
-		log =3D { .refname =3D "refs/heads/master",
+		log =3D { .refname =3D (char *) "refs/heads/master",
 			.update_index =3D 0xa,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value =3D { .update =3D {
-					   .name =3D "Han-Wen Nienhuys",
-					   .email =3D "hanwen@google.com",
+					   .name =3D (char *) "Han-Wen Nienhuys",
+					   .email =3D (char *) "hanwen@google.com",
 					   .tz_offset =3D 100,
 					   .time =3D 0x5e430672,
-					   .message =3D "commit: 9\n",
+					   .message =3D (char *) "commit: 9\n",
 				   } } };
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
@@ -156,15 +156,15 @@ static void test_log_overflow(void)
 	};
 	int err;
 	struct reftable_log_record log =3D {
-		.refname =3D "refs/heads/master",
+		.refname =3D (char *) "refs/heads/master",
 		.update_index =3D 0xa,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.old_hash =3D { 1 },
 				.new_hash =3D { 2 },
-				.name =3D "Han-Wen Nienhuys",
-				.email =3D "hanwen@google.com",
+				.name =3D (char *) "Han-Wen Nienhuys",
+				.email =3D (char *) "hanwen@google.com",
 				.tz_offset =3D 100,
 				.time =3D 0x5e430672,
 				.message =3D msg,
@@ -293,14 +293,14 @@ static void test_log_zlib_corruption(void)
 	char message[100] =3D { 0 };
 	int err, i, n;
 	struct reftable_log_record log =3D {
-		.refname =3D "refname",
+		.refname =3D (char *) "refname",
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
 				.new_hash =3D { 1 },
 				.old_hash =3D { 2 },
-				.name =3D "My Name",
-				.email =3D "myname@invalid",
+				.name =3D (char *) "My Name",
+				.email =3D (char *) "myname@invalid",
 				.message =3D message,
 			},
 		},
@@ -728,7 +728,7 @@ static void test_write_empty_key(void)
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record ref =3D {
-		.refname =3D "",
+		.refname =3D (char *) "",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_DELETION,
 	};
@@ -752,18 +752,18 @@ static void test_write_key_order(void)
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	struct reftable_ref_record refs[2] =3D {
 		{
-			.refname =3D "b",
+			.refname =3D (char *) "b",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D "target",
+				.symref =3D (char *) "target",
 			},
 		}, {
-			.refname =3D "a",
+			.refname =3D (char *) "a",
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_REF_SYMREF,
 			.value =3D {
-				.symref =3D "target",
+				.symref =3D (char *) "target",
 			},
 		}
 	};
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 07d89b45da..4abf92636d 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -156,10 +156,10 @@ static void test_reftable_stack_add_one(void)
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record ref =3D {
-		.refname =3D "HEAD",
+		.refname =3D (char *) "HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record dest =3D { NULL };
 	struct stat stat_result =3D { 0 };
@@ -216,16 +216,16 @@ static void test_reftable_stack_uptodate(void)
=20
 	int err;
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D "HEAD",
+		.refname =3D (char *) "HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D "branch2",
+		.refname =3D (char *) "branch2",
 		.update_index =3D 2,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *) "master",
 	};
=20
=20
@@ -264,10 +264,10 @@ static void test_reftable_stack_transaction_api(void)
 	struct reftable_addition *add =3D NULL;
=20
 	struct reftable_ref_record ref =3D {
-		.refname =3D "HEAD",
+		.refname =3D (char *) "HEAD",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record dest =3D { NULL };
=20
@@ -313,7 +313,7 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *) "master",
 		};
 		char name[100];
=20
@@ -356,7 +356,7 @@ static void test_reftable_stack_transaction_api_perform=
s_auto_compaction(void)
 static void test_reftable_stack_auto_compaction_fails_gracefully(void)
 {
 	struct reftable_ref_record ref =3D {
-		.refname =3D "refs/heads/master",
+		.refname =3D (char *) "refs/heads/master",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_VAL1,
 		.value.val1 =3D {0x01},
@@ -409,16 +409,16 @@ static void test_reftable_stack_update_index_check(vo=
id)
 	struct reftable_stack *st =3D NULL;
 	int err;
 	struct reftable_ref_record ref1 =3D {
-		.refname =3D "name1",
+		.refname =3D (char *) "name1",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *) "master",
 	};
 	struct reftable_ref_record ref2 =3D {
-		.refname =3D "name2",
+		.refname =3D (char *) "name2",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "master",
+		.value.symref =3D (char *) "master",
 	};
=20
 	err =3D reftable_new_stack(&st, dir, cfg);
@@ -561,7 +561,7 @@ static void test_reftable_stack_log_normalize(void)
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
 	struct reftable_log_record input =3D {
-		.refname =3D "branch",
+		.refname =3D (char *) "branch",
 		.update_index =3D 1,
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
@@ -582,11 +582,11 @@ static void test_reftable_stack_log_normalize(void)
 	err =3D reftable_new_stack(&st, dir, cfg);
 	EXPECT_ERR(err);
=20
-	input.value.update.message =3D "one\ntwo";
+	input.value.update.message =3D (char *) "one\ntwo";
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT(err =3D=3D REFTABLE_API_ERROR);
=20
-	input.value.update.message =3D "one";
+	input.value.update.message =3D (char *) "one";
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
=20
@@ -594,7 +594,7 @@ static void test_reftable_stack_log_normalize(void)
 	EXPECT_ERR(err);
 	EXPECT(0 =3D=3D strcmp(dest.value.update.message, "one\n"));
=20
-	input.value.update.message =3D "two\n";
+	input.value.update.message =3D (char *) "two\n";
 	arg.update_index =3D 2;
 	err =3D reftable_stack_add(st, &write_test_log, &arg);
 	EXPECT_ERR(err);
@@ -697,9 +697,9 @@ static void test_reftable_stack_hash_id(void)
 	int err;
=20
 	struct reftable_ref_record ref =3D {
-		.refname =3D "master",
+		.refname =3D (char *) "master",
 		.value_type =3D REFTABLE_REF_SYMREF,
-		.value.symref =3D "target",
+		.value.symref =3D (char *) "target",
 		.update_index =3D 1,
 	};
 	struct reftable_write_options cfg32 =3D { .hash_id =3D GIT_SHA256_FORMAT_=
ID };
@@ -879,7 +879,7 @@ static void test_reftable_stack_auto_compaction(void)
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *) "master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -913,7 +913,7 @@ static void test_reftable_stack_add_performs_auto_compa=
ction(void)
 		struct reftable_ref_record ref =3D {
 			.update_index =3D reftable_stack_next_update_index(st),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *) "master",
 		};
=20
 		/*
@@ -964,7 +964,7 @@ static void test_reftable_stack_compaction_concurrent(v=
oid)
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *) "master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
@@ -1014,7 +1014,7 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 			.refname =3D name,
 			.update_index =3D reftable_stack_next_update_index(st1),
 			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D "master",
+			.value.symref =3D (char *) "master",
 		};
 		snprintf(name, sizeof(name), "branch%04d", i);
=20
--=20
2.45.2.409.g7b0defb391.dirty


--OisMp4ls4rB3zqsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhjzMACgkQVbJhu7ck
PpTs2g/+LNx7/5qwJJS8pwKaPesHas0Y5HDGlbQDtmCfmrwAEcrQqhHWuS7utSPQ
I6bw1TyJ1BaCB1ClJsb3q4ktykpUClqyIPVLtcjEnB9gjMKFxuVxZrEGTZ0wmhBP
dk+pW1IXU2gX3t3Y4SGf0Y43bv4aK7ube/XL9iBz4sS66io7L4xEP+5arRkh8BqR
ktQRJyboNVlDjivGEeJqjCkr6Lqho8PxKT6k43au3GDpniJqbBaC0Kv8kwkN0WPh
oimhqzUtprSWRsj1nECSLzHvZ4tKmSg1Lnt9KuLQJHm/NSowFWjpLO0Ay1y5SBnq
lC7czHAzKya/M0TynH+b6lDi7ZOzeUoSXGzTox+0ZLt/3/351EDcnxkbsUlHiWUR
3sQGuRSYcVdPmUQAF6exX1h6/SjLbKM4PkideIvVi4y2qTCj/ML0VBjq/0KSQb/i
1G6iedlYzr9CbwTGvmylLDl++GpJ9oOM0+goCaKM7JJx5t5L108adegYtl73th4d
K9DUBK6jLzqVWPlxc4ypQ7Ry+CYFUUYPYES5ITK0QvH9N31R77HwIFXWeJpzJ9n3
Ax1+kSbz0HudGEhiFmsh9Ub3JAzMEbgQI4TEn2+i0cyyMegq2hhf9REP0Ti6GpiH
izm+xyCWA7F/OrxQZeLrQidsZWFSyH2hpTjOfIYWMuJO9HPqLsA=
=AYsb
-----END PGP SIGNATURE-----

--OisMp4ls4rB3zqsk--
