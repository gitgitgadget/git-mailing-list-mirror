Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CDB145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504636; cv=none; b=TJzf5zytAL6zYb5NyrUhlIBpGlegN3EijTyNaunIXKFVxG+FiU1jKlDmkadyLUlWvDfuEGBlCd4HYufusuw+6rRAB4tGZbxZZXoqK2qBiTfizq9YDZFqMrkhWMgK5V5PX9giwqAE0unT3BS+OjMYR0ibvhhOPxyRBCw5dzXE/dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504636; c=relaxed/simple;
	bh=irzp2Se09X1AhWukE8h5bNt75e6KsV7OxP/xPv+De00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZq2rxPJLfQXFLA+Sz/1aX7aSlpGk1UUPBb945TwRK3USD3cpi/dye8IPcW+BBapfL0G3Ot8qIIz5dgC5q9sof8lvqhWL6kQrUhKkoU8B1XbUpVKgBt89ao1OiFnrsDMpBOUuvU4yC4KXf8FQ4DlLUKqhp4kkm57ncXXN5LxOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CueVoGyZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dNN3t0X8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CueVoGyZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNN3t0X8"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 49D3F11400FB;
	Tue,  4 Jun 2024 08:37:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Jun 2024 08:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504633; x=1717591033; bh=7N6o2PEc/R
	6/rezipXeuj/SuDczsHXwPQUyTt4aUK00=; b=CueVoGyZBvDa/7E+Gdgk3VC9DZ
	8tmrFbYyc4Cxvx8BERHalObSaB/MPQWqOhOzyhoC2CF+pgTV9cQVKwAmom//G7CK
	tcbZwIXYfxT6DvsZXth80Q2bYV4504zMkf2cKCwSVqGenttDww1GkT1JvbXIvw3u
	KTA6ChAa13B+7Fcm0zgnyt/jvDn74VS872xNpuji34g7h6rAzP2b+W8OD6b2oBvn
	85WQztTMvNVXVSKoIPcYBb0UqIfFVGRBjl/izF3YvYqLZNY8DodnXhx0P8bJgpwx
	QtSZyjITXgom/gWwRXC3pbfxx1+7XmQ8IpjtzSGcTf21vLTHAUrIe65zU9kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504633; x=1717591033; bh=7N6o2PEc/R6/rezipXeuj/SuDczs
	HXwPQUyTt4aUK00=; b=dNN3t0X8dlfAdVH8KvTzveQwP6LpEbYQcM6sugrsa9FJ
	f+iYff/+X/dw6mAzG1QrnIDDRy2Je8XxNqIBIdbKbwynVM88vJ+40nRoNHQjvPSt
	OUUdTFol+aQ1I3580m2ztVk3CuLw9kYB53srEUL/eb0q2giJ6/14Hb4VUJBWdI2+
	C+uC/YqjJjqyIw1GMlUw4TjsNrZdTqPR7xbcrPx8eu/57HS+MmF2qYbHCiN48wHH
	4vxjBqoFsC+588O9sZDuYHuPbwseWUCfV2OAzmMLz6acx5+Gljn/fpFHVVHa5IO1
	dGDznUUkvxUhC3kMwZEt0up9lhiJ2G73CsRMKCLsfg==
X-ME-Sender: <xms:eQpfZnrL-JJUHwBtbPu59asbdMChbRYj9LKK9AM8K5W2yt_ne5eBNg>
    <xme:eQpfZhpbLMO_A98O6G6ln00NZ3VYiq_oPAAFfRN3Q9FRvfaHWrVXYYfU_dLsRov02
    J6oHhatua3kcTQM5g>
X-ME-Received: <xmr:eQpfZkN-FHPjVrLIAMksMOEnizwFwTzMM9NzOtK6Ta09XglZORT633GjGa4nmfTx-AaF0JDVTZtliQ58arxfoZCEsGreOhn9FFIjf-ypHUMsjClq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgeevtdffhedvheehgeeuuefffeetiedtfeehjeehteevieehkeekieefhfdvveeh
    necuffhomhgrihhnpehuphgurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:eQpfZq5g0S1T5hdAbVl4S3QzB0XN4YmCQ0lGrqeYVVwar4JEFjn6yA>
    <xmx:eQpfZm5Crt90ukjKZNblO2buJIUW9YLMok2hh9pR6m53WMXp1RQv0w>
    <xmx:eQpfZii5L-_wHFBQuxSDAaE35-KHGzMOCfT0wj5FjT3jgcTp1XYMXw>
    <xmx:eQpfZo5XKYs3haGvGIFSl_kaCQ4Uobeh0Az13RUwnYbcqaEnvT_RCQ>
    <xmx:eQpfZh0KLcxGGUrTNtLuGCFgL4rkqqNsxkWLIJ8Uf7Acpijt0BTYumtW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e6eb1d89 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:45 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 04/27] reftable: cast away constness when assigning
 constants to records
Message-ID: <d0a2a2f6c55af6da9703a1d64f45f77f4c00cd80.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u67BTvcuDeG3mLPX"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--u67BTvcuDeG3mLPX
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
2.45.1.410.g58bac47f8e.dirty


--u67BTvcuDeG3mLPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCnUACgkQVbJhu7ck
PpT0fA//Q1kKkjqxBcrr9laixxrGSY4IZcWJzrc5fC9h5dqzlDHYq2W11L5zlPjD
Qe66QU/KN4LsIjkA9YsEnqy1I20gIc/oiMK79AoFO9VxRhQu8ckdMd5bNZzBOfZ/
E5tw/4C2YOOgFaK4e7JAfwywCad5iAnI2pjrLFhu29vpWMoNE6XVlqI7aKBEZxAn
aLptyhgkdUTpRlLfUeIrRcdz9CmY70jfzLqfGZW0vRrKjXHDY6HpFTX1zBrbC76H
lKpyY+wjL+Sb9v8adu8C8SmqZaFK5DdH105Uqtm0tQjOSShCNbiALu3DjZj1A7cb
udhO5+TqZwkO11Hfm71PEX9dmF02JHIB5+90l4vOz5ZaFlwZZCBCuGkPE3GHMFa7
Z6tqkZS3IuA2G2y2j7ojuPIe95PGKX/lzZmWcpaolCMAtSBl6z+L96EAbuyw3FzX
+uQMxL91Y/ipN6AQm3q/xZJ+pWE3K1hLgqmHfQSppagTTrEV64gOSaY61N67CWwj
O7QBBwzF3lvaGSkaJOGLnDntE2yQFQFbiSxoy4omaO1K2V3ab6a4oIx0rmZ4Ndh+
WkXXzQkk3b0sXaWwNph9oMEGcWQr8lESngLhChWc/Vy9r2aVRvs/A9fRRYyRGnVT
3V4rYYKwTMGzL9b1mv3UexQAQeQbRTu//gsjt388FJSX8+gfmu0=
=8LP4
-----END PGP SIGNATURE-----

--u67BTvcuDeG3mLPX--
