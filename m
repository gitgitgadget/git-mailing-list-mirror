Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB57E77B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407562; cv=none; b=PZcBH8q3ZJsUlZjGikOkWNxJvfhLw4RS+10ehdknNvjvi+64fh4IWjOH685BBG9Mh2WUwVL5E1PdIeI0Y9mEstp2FlfDjxHbWK6tEbpodUWC+pUnaN2bxHHrxljqIOnYCv0w/re8CzwiRiJ8vvEpdqXj7U4qf7I3BZTZmKxQtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407562; c=relaxed/simple;
	bh=RmqZlgcstdQ/GK+evOU/lmMBA8B6kW9vFHuHCECrs3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBOd9tuxaqyzdsSDjmPf0ih0OUjHAv1jhMD+O/GHVHUQT2+KLvlDsj48kh9W6vJEDVny5yC5HQtHMaoZZRv6Np+butpe8uhcjO1SO0qVAXBGAPlZBNwTIf9LYaiBTKGQqtJknp0wx+wUeccz9m8vmh3XpfQWRfVmCB/8vwXE6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ApNstsOm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HYzojtdp; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ApNstsOm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HYzojtdp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9EBB218000CC;
	Mon,  3 Jun 2024 05:39:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407559; x=1717493959; bh=9arkqyMph2
	9TukJpr+J06ScioeSM3lneXkjjCqnbBDs=; b=ApNstsOmFMUg4YRhoEx222/GNl
	OqftJz+Jwq9jj0Ty6w4LygdOMo4upjBH0rEX2fEyhPHTl67bcDnEqPuk2bO+RywA
	ZRWISGdHwKFnKDTtH9J4v6XBZTGDb6oJl+yH+iycpXeXmLvBnZD4ODC26DZYYKtz
	Q11ca2TU5PKYCo70SsMmNFaKDekEjbgsBHNz9JrYBhNoLq8cU3o5duixb8mZ3ZJh
	1wkBpGEvFa4e9eXYutQKPPLOd5ANXvi0Ifu4o3NkEmp75jlBKLALkFSHAFsj4tC2
	RsNryjzypbeRMrzXUUODKsJstKdsIox97K65LZsMU88hIDXlCLPWjOSOy3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407559; x=1717493959; bh=9arkqyMph29TukJpr+J06ScioeSM
	3lneXkjjCqnbBDs=; b=HYzojtdpWmFGw1/FFbyjFjIe51zO//8Nufja60T/44gA
	ro9YR9zB/XsZ0LLjjwSYuYR4NQeVKB8L2SToyADlF/sJsEOmU2viDmVlVMJXii+h
	hcfVGS9/sMBsloHW0GSe9Hy1wDlm3ORSyzKQKUtnffWScfKvCDGJnsmBs/gEbbAA
	OVElGNhIRlLIuizF/rViC8XK0ufYnd3XIp4gvm6JD4fTdhoAUyS0sR9WQbla0Fjx
	00zf1VODUVNHExprDC5IISoO2G4atoLX3/jxXW0j+S5d2N8xtScgwspvegMGsDL0
	B0Cxm9N88vPA5bJcYYd/LAEUik4im4XGPwCxrdK4kg==
X-ME-Sender: <xms:R49dZm55H_sTjZe2EwjxiQMzLIbt_B7Yn8iVfwMqHAFugNm7jVTUTA>
    <xme:R49dZv6j3dCypdBEUgpNIRBzknT2HqxgNHqjJS3caX8-ZvFooSRmcqr_xRx8aRcGq
    hMxGGkY0hlOHlqrrQ>
X-ME-Received: <xmr:R49dZldfPXm2vF5omIHqIQsJhqknIhhWLPvk5a7-lEPKlpi4_H8hXTD7JJNc_iodsJmMP_DIRyqO2yssNawjAtiCTC4oGZmdOu5b5enCDfq-VcX5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeegvedtffehvdehheegueeuffefteeitd
    efheejheetveeiheekkeeifefhvdevheenucffohhmrghinhepuhhpuggrthgvrdhnvgif
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:R49dZjIu4V0-hdOC4Jn4De-oQvIh-jJqRnI8JPryXncwCmbg48LC5w>
    <xmx:R49dZqJbvXZf0Vl5bJYZlwLLW2loGm9YQma4HqD-sbdiBcj2K99-aQ>
    <xmx:R49dZkwsMiWyHyTyg1vBWHzsZmzGFFk7_FQYX_eJTJa9ZOtcQnnCkg>
    <xmx:R49dZuK11hoEDk_e-ef3Gkccxtd7pyroz1cMSurXUi05yL4ZbM5gfg>
    <xmx:R49dZm1Pn3VGLQ1OG7xHRaLBPfFempl9ix0FB-fZkuCgUI0C_HEHkn4U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 620a44de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:38:53 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/27] reftable: cast away constness when assigning
 constants to records
Message-ID: <8692d9d9afbe69642484fd7548bd6af76c5db1f5.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AepGvRT1OHGgBno6"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--AepGvRT1OHGgBno6
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


--AepGvRT1OHGgBno6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj0IACgkQVbJhu7ck
PpSeYhAAiwWLy5CZvTSFVcUgLzgen6CtIQJqQkNdpZmXVx3ByYiu9ah+qWYXdjh1
AbrDBkUPiSPtvks6+AsH6KwHAfs4jf/KHitxalevQ2WLZCS0SS8YoQXVSdrleMJn
rMjtXUGSNkyFMuCGV9jjIWTPwyD7gjCqEtRuKnBTlgPLKUJaqluMBKdfNeBtUlCr
cV4fRGJxhqUnEY6jgRRrU5/alCboPsVqkCv5u+T+xWanZPwSPwzzszDSXJpC9i2m
yIWVAOUwX/HciQlVchWcDP2HEEgvnYTpHQUCFMaeT57SvXWHYtBN8YEZD7F9a3BK
LzpBge6yKypcdgaoHitM5KWXcoxe51QVNclorpS/LLUwh84DC2B0qOIw73CEGKqM
gy+6LQuFE1WRFMi/OjkEYjmc5EJBbXNNDbmt09TDJ4iXL1hmzdzJvz0vuxv3ns7J
6bIvEMd06LVmHj+7YB87N3kK/WsMANP81KBIqP8p8IBc6slukvEqj+w2EuOeaA4T
9OXhYciDjevIVRvkK9nUfSz9bXqLIx/V0O0zpL3KeCmjWbtTiGjsBq6tdxjm9I1l
XYmr/NANDjYwysRSsDQ+cyFuxJUOvxzerj+hjNRVmfMvaG9gpTs5uZPUGStCCX1S
/aEixF4oyjbtliAN3B6HlIPkem+Fz57iO4BvuLW36T+mousL4kg=
=rkZu
-----END PGP SIGNATURE-----

--AepGvRT1OHGgBno6--
