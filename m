Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCA5822E
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640665; cv=none; b=e9gCHcu4L6RyKawZNNsN+CTIn4kz/90f5u68s+H3srMJIg4XpBJZqGdBO6ssBp+kB30sAXpbTW6VP1mYH6Fqxr8GabUhNpl7lj+KgIEsamTBdrmx6/5z+TeakSDHXI0oWRASxkaR9GTb17rBuSjY1HAyuF/cWSQgElhjKLLurrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640665; c=relaxed/simple;
	bh=uPFF9umDoRwM2jCQVU/hej+d0dbpiQKllifaPQR8/TU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQDck+ucu421yWDe5uj31aP7bi2sj09eDAB3wqRCKdd1G3CkM1Bmf3wp7/N8ubjDK3EctoxRfq5bS8wxaUxDHFC9l7OnsknGd5r3o0brFbvlIZtLrxrKEbFQuy9U09CU0F5xJNF+OJyoxKLHFd6i3QFPfY/eTXWvyBycjDMq8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AkNE27Tb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQCS2Q/N; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AkNE27Tb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQCS2Q/N"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 64A645C008B
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 07:11:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 05 Mar 2024 07:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709640662; x=1709727062; bh=LcECpIxaNN
	V6OelSBXGKetsEHeLmvajnVL+qu//ifvI=; b=AkNE27Tbm8kXlgzWOgkBbmpoY4
	rHzV1uw9HRXxmeqrBuHKMlG3K2Vt40PdGVqgBRCg0oMKWqJDQy2qeroYJjjtdw7T
	M49LH0SpJJnSmTjGeUb9xOC5g7LaIu9Md07y138cby+c8A/ZY50MJXb7RjT72elF
	Sfe5XeS80PL461yzW31BaSq75cSnlS0IuPn1JsVLeJABvU1T12xmokxVZYXEzxqH
	JkHQz16AimWQbgTccnP9l6pAIdV7Kjw8tQ+ojETRJQ1gGi0e2KCesm9F1SzYI9lM
	97I1mn1wGzE4/ExDGcbZOQEdwos8neoAYsMALUlgxsXqHqjdkThPtjQRfBWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709640662; x=1709727062; bh=LcECpIxaNNV6OelSBXGKetsEHeLm
	vajnVL+qu//ifvI=; b=FQCS2Q/N3TcZmlubZyjGEj16R09lxLznZbtuTedKQq+L
	y+SmeBesTeAvGoxQNoNp+oeecQAWYU66WwNlb+XG9Bm3LAPbntvyH9JHA+tOW9Sl
	E9IhPHdGZvzWrAwcbSCUUPfDtk6fkWEPaiEWBNyZLDv/vUNy1eJwabXAX4OlGNGo
	dokGMJmXYwetIWmIBFyPIA+lgVGVU+M3J2qUT1cHmgx5LbVl206o60vYMIJBEuNC
	zCkZPSK/alkqEDLAhWdiuktbkJvRBJxQActXeE5PCxYzKiYo8AKtqUJXRJRhoTs4
	QuTVugF5duOBU5aUatD7QRTjAn7GuDCfWEFh5id8aQ==
X-ME-Sender: <xms:1gvnZZ5ANlJ3yxSl1qSU5x1fWmt6MQl8LzW9XDBsESDdJU32e681Rg>
    <xme:1gvnZW6TxZwjLqTiUYB3OLoIHVXtOGX9scksP3A0rSVfFBK4Q9v__xFiGtQ4DiHMA
    hmJU5RFmpuBcgpF5w>
X-ME-Received: <xmr:1gvnZQfyXIfV_LjYRjJrQ9fC1bWC83ehV_XpbqTmqdal_3e_iZ74rKtFMeOp_0JA0KvNeu8DdfAwVlYkSu2LXQUFjbzeBzvTjmpQD-k37lRxKro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeutdelieduteethfdtgeelvdfgfffffeduff
    dujeefueegveeljeelleegudekgfenucffohhmrghinhepuhhpuggrthgvrdhnvgifpdhu
    phgurghtvgdrnhgrmhgvpdhuphgurghtvgdrvghmrghilhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1gvnZSLDXJn5UytTDA3OxZth3Mhf1ziKFjBm8DVSaB7DPcRThyfN6g>
    <xmx:1gvnZdJlaz8JuBh_peibVWzqqzLV7CiWOTpXvdltZIdBe5x41YbFGg>
    <xmx:1gvnZbyis_jyS2gH6agAUXtauyLuV_9FrLKiBtuxQTP3plxhoFDuag>
    <xmx:1gvnZfyonalXfCtzMYu1sxvOUudd9izl4X7PA_HaMpdgIv8MfB8ysg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 5 Mar 2024 07:11:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 93271b9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 5 Mar 2024 12:06:34 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:10:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] reftable/record: convert old and new object IDs to arrays
Message-ID: <b63722b35dbf44c408517b6b657b8ff7c81df325.1709640322.git.ps@pks.im>
References: <cover.1709640322.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BBKmD/ys5iuR0R4Q"
Content-Disposition: inline
In-Reply-To: <cover.1709640322.git.ps@pks.im>


--BBKmD/ys5iuR0R4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 7af607c58d (reftable/record: store "val1" hashes as static arrays,
2024-01-03) and b31e3cc620 (reftable/record: store "val2" hashes as
static arrays, 2024-01-03) we have converted ref records to store their
object IDs in a static array. Convert log records to do the same so that
their old and new object IDs are arrays, too.

This change results in two allocations less per log record that we're
iterating over. Before:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 8,068,495 allocs, 8,068,373 frees, 401,011,862 byte=
s allocated

After:

    HEAP SUMMARY:
        in use at exit: 13,473 bytes in 122 blocks
      total heap usage: 6,068,489 allocs, 6,068,367 frees, 361,011,822 byte=
s allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    | 39 ++++++------------------
 reftable/merged_test.c     | 11 +++----
 reftable/readwrite_test.c  | 62 +++++++++++++++-----------------------
 reftable/record.c          | 59 ++++++------------------------------
 reftable/record_test.c     | 11 -------
 reftable/reftable-record.h |  4 +--
 reftable/stack_test.c      | 26 +++++++---------
 7 files changed, 61 insertions(+), 151 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index f04be942ac..2de57c047a 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -171,23 +171,6 @@ static int should_write_log(struct ref_store *refs, co=
nst char *refname)
 	}
 }
=20
-static void clear_reftable_log_record(struct reftable_log_record *log)
-{
-	switch (log->value_type) {
-	case REFTABLE_LOG_UPDATE:
-		/*
-		 * When we write log records, the hashes are owned by the
-		 * caller and thus shouldn't be free'd.
-		 */
-		log->value.update.old_hash =3D NULL;
-		log->value.update.new_hash =3D NULL;
-		break;
-	case REFTABLE_LOG_DELETION:
-		break;
-	}
-	reftable_log_record_release(log);
-}
-
 static void fill_reftable_log_record(struct reftable_log_record *log)
 {
 	const char *info =3D git_committer_info(0);
@@ -1102,8 +1085,8 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 			fill_reftable_log_record(log);
 			log->update_index =3D ts;
 			log->refname =3D xstrdup(u->refname);
-			log->value.update.new_hash =3D u->new_oid.hash;
-			log->value.update.old_hash =3D tx_update->current_oid.hash;
+			memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
+			memcpy(log->value.update.old_hash, tx_update->current_oid.hash, GIT_MAX=
_RAWSZ);
 			log->value.update.message =3D
 				xstrndup(u->msg, arg->refs->write_options.block_size / 2);
 		}
@@ -1158,7 +1141,7 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 done:
 	assert(ret !=3D REFTABLE_API_ERROR);
 	for (i =3D 0; i < logs_nr; i++)
-		clear_reftable_log_record(&logs[i]);
+		reftable_log_record_release(&logs[i]);
 	free(logs);
 	return ret;
 }
@@ -1275,13 +1258,13 @@ static int write_create_symref_table(struct reftabl=
e_writer *writer, void *cb_da
 	log.update_index =3D ts;
 	log.value.update.message =3D xstrndup(create->logmsg,
 					    create->refs->write_options.block_size / 2);
-	log.value.update.new_hash =3D new_oid.hash;
+	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
 	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
 				    RESOLVE_REF_READING, &old_oid, NULL))
-		log.value.update.old_hash =3D old_oid.hash;
+		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
=20
 	ret =3D reftable_writer_add_log(writer, &log);
-	clear_reftable_log_record(&log);
+	reftable_log_record_release(&log);
 	return ret;
 }
=20
@@ -1420,7 +1403,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
 			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
-		logs[logs_nr].value.update.old_hash =3D old_ref.value.val1;
+		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_=
RAWSZ);
 		logs_nr++;
=20
 		ret =3D read_ref_without_reload(arg->stack, "HEAD", &head_oid, &head_ref=
erent, &head_type);
@@ -1452,7 +1435,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	logs[logs_nr].update_index =3D creation_ts;
 	logs[logs_nr].value.update.message =3D
 		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
-	logs[logs_nr].value.update.new_hash =3D old_ref.value.val1;
+	memcpy(logs[logs_nr].value.update.new_hash, old_ref.value.val1, GIT_MAX_R=
AWSZ);
 	logs_nr++;
=20
 	/*
@@ -1515,10 +1498,6 @@ static int write_copy_table(struct reftable_writer *=
writer, void *cb_data)
 	for (i =3D 0; i < logs_nr; i++) {
 		if (!strcmp(logs[i].refname, "HEAD"))
 			continue;
-		if (logs[i].value.update.old_hash =3D=3D old_ref.value.val1)
-			logs[i].value.update.old_hash =3D NULL;
-		if (logs[i].value.update.new_hash =3D=3D old_ref.value.val1)
-			logs[i].value.update.new_hash =3D NULL;
 		logs[i].refname =3D NULL;
 		reftable_log_record_release(&logs[i]);
 	}
@@ -2180,7 +2159,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 			dest->value_type =3D REFTABLE_LOG_DELETION;
 		} else {
 			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
-				dest->value.update.old_hash =3D last_hash;
+				memcpy(dest->value.update.old_hash, last_hash, GIT_MAX_RAWSZ);
 			last_hash =3D logs[i].value.update.new_hash;
 		}
 	}
diff --git a/reftable/merged_test.c b/reftable/merged_test.c
index d0f77a3b8f..530fc82d1c 100644
--- a/reftable/merged_test.c
+++ b/reftable/merged_test.c
@@ -289,16 +289,13 @@ merged_table_from_log_records(struct reftable_log_rec=
ord **logs,
=20
 static void test_merged_logs(void)
 {
-	uint8_t hash1[GIT_SHA1_RAWSZ] =3D { 1 };
-	uint8_t hash2[GIT_SHA1_RAWSZ] =3D { 2 };
-	uint8_t hash3[GIT_SHA1_RAWSZ] =3D { 3 };
 	struct reftable_log_record r1[] =3D {
 		{
 			.refname =3D "a",
 			.update_index =3D 2,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
-				.old_hash =3D hash2,
+				.old_hash =3D { 2 },
 				/* deletion */
 				.name =3D "jane doe",
 				.email =3D "jane@invalid",
@@ -310,8 +307,8 @@ static void test_merged_logs(void)
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
-				.old_hash =3D hash1,
-				.new_hash =3D hash2,
+				.old_hash =3D { 1 },
+				.new_hash =3D { 2 },
 				.name =3D "jane doe",
 				.email =3D "jane@invalid",
 				.message =3D "message1",
@@ -324,7 +321,7 @@ static void test_merged_logs(void)
 			.update_index =3D 3,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
-				.new_hash =3D hash3,
+				.new_hash =3D { 3 },
 				.name =3D "jane doe",
 				.email =3D "jane@invalid",
 				.message =3D "message3",
diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 363fe0f998..a6dbd214c5 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -77,18 +77,15 @@ static void write_table(char ***names, struct strbuf *b=
uf, int N,
 	}
=20
 	for (i =3D 0; i < N; i++) {
-		uint8_t hash[GIT_SHA256_RAWSZ] =3D { 0 };
 		char name[100];
 		int n;
=20
-		set_test_hash(hash, i);
-
 		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
=20
 		log.refname =3D name;
 		log.update_index =3D update_index;
 		log.value_type =3D REFTABLE_LOG_UPDATE;
-		log.value.update.new_hash =3D hash;
+		set_test_hash(log.value.update.new_hash, i);
 		log.value.update.message =3D "message";
=20
 		n =3D reftable_writer_add_log(w, &log);
@@ -137,13 +134,10 @@ static void test_log_buffer_size(void)
 	/* This tests buffer extension for log compression. Must use a random
 	   hash, to ensure that the compressed part is larger than the original.
 	*/
-	uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
 	for (i =3D 0; i < GIT_SHA1_RAWSZ; i++) {
-		hash1[i] =3D (uint8_t)(git_rand() % 256);
-		hash2[i] =3D (uint8_t)(git_rand() % 256);
+		log.value.update.old_hash[i] =3D (uint8_t)(git_rand() % 256);
+		log.value.update.new_hash[i] =3D (uint8_t)(git_rand() % 256);
 	}
-	log.value.update.old_hash =3D hash1;
-	log.value.update.new_hash =3D hash2;
 	reftable_writer_set_limits(w, update_index, update_index);
 	err =3D reftable_writer_add_log(w, &log);
 	EXPECT_ERR(err);
@@ -161,25 +155,26 @@ static void test_log_overflow(void)
 		.block_size =3D ARRAY_SIZE(msg),
 	};
 	int err;
-	struct reftable_log_record
-		log =3D { .refname =3D "refs/heads/master",
-			.update_index =3D 0xa,
-			.value_type =3D REFTABLE_LOG_UPDATE,
-			.value =3D { .update =3D {
-					   .name =3D "Han-Wen Nienhuys",
-					   .email =3D "hanwen@google.com",
-					   .tz_offset =3D 100,
-					   .time =3D 0x5e430672,
-					   .message =3D msg,
-				   } } };
+	struct reftable_log_record log =3D {
+		.refname =3D "refs/heads/master",
+		.update_index =3D 0xa,
+		.value_type =3D REFTABLE_LOG_UPDATE,
+		.value =3D {
+			.update =3D {
+				.old_hash =3D { 1 },
+				.new_hash =3D { 2 },
+				.name =3D "Han-Wen Nienhuys",
+				.email =3D "hanwen@google.com",
+				.tz_offset =3D 100,
+				.time =3D 0x5e430672,
+				.message =3D msg,
+			},
+		},
+	};
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
=20
-	uint8_t hash1[GIT_SHA1_RAWSZ]  =3D {1}, hash2[GIT_SHA1_RAWSZ] =3D { 2 };
-
 	memset(msg, 'x', sizeof(msg) - 1);
-	log.value.update.old_hash =3D hash1;
-	log.value.update.new_hash =3D hash2;
 	reftable_writer_set_limits(w, update_index, update_index);
 	err =3D reftable_writer_add_log(w, &log);
 	EXPECT(err =3D=3D REFTABLE_ENTRY_TOO_BIG_ERROR);
@@ -219,16 +214,13 @@ static void test_log_write_read(void)
 		EXPECT_ERR(err);
 	}
 	for (i =3D 0; i < N; i++) {
-		uint8_t hash1[GIT_SHA1_RAWSZ], hash2[GIT_SHA1_RAWSZ];
 		struct reftable_log_record log =3D { NULL };
-		set_test_hash(hash1, i);
-		set_test_hash(hash2, i + 1);
=20
 		log.refname =3D names[i];
 		log.update_index =3D i;
 		log.value_type =3D REFTABLE_LOG_UPDATE;
-		log.value.update.old_hash =3D hash1;
-		log.value.update.new_hash =3D hash2;
+		set_test_hash(log.value.update.old_hash, i);
+		set_test_hash(log.value.update.new_hash, i + 1);
=20
 		err =3D reftable_writer_add_log(w, &log);
 		EXPECT_ERR(err);
@@ -298,18 +290,15 @@ static void test_log_zlib_corruption(void)
 	struct reftable_writer *w =3D
 		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
 	const struct reftable_stats *stats =3D NULL;
-	uint8_t hash1[GIT_SHA1_RAWSZ] =3D { 1 };
-	uint8_t hash2[GIT_SHA1_RAWSZ] =3D { 2 };
 	char message[100] =3D { 0 };
 	int err, i, n;
-
 	struct reftable_log_record log =3D {
 		.refname =3D "refname",
 		.value_type =3D REFTABLE_LOG_UPDATE,
 		.value =3D {
 			.update =3D {
-				.new_hash =3D hash1,
-				.old_hash =3D hash2,
+				.new_hash =3D { 1 },
+				.old_hash =3D { 2 },
 				.name =3D "My Name",
 				.email =3D "myname@invalid",
 				.message =3D message,
@@ -821,13 +810,12 @@ static void test_write_multiple_indices(void)
 	}
=20
 	for (i =3D 0; i < 100; i++) {
-		unsigned char hash[GIT_SHA1_RAWSZ] =3D {i};
 		struct reftable_log_record log =3D {
 			.update_index =3D 1,
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value.update =3D {
-				.old_hash =3D hash,
-				.new_hash =3D hash,
+				.old_hash =3D { i },
+				.new_hash =3D { i },
 			},
 		};
=20
diff --git a/reftable/record.c b/reftable/record.c
index 367de04600..8d2cd6b081 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -763,16 +763,10 @@ static void reftable_log_record_copy_from(void *rec, =
const void *src_rec,
 				xstrdup(dst->value.update.message);
 		}
=20
-		if (dst->value.update.new_hash) {
-			REFTABLE_ALLOC_ARRAY(dst->value.update.new_hash, hash_size);
-			memcpy(dst->value.update.new_hash,
-			       src->value.update.new_hash, hash_size);
-		}
-		if (dst->value.update.old_hash) {
-			REFTABLE_ALLOC_ARRAY(dst->value.update.old_hash, hash_size);
-			memcpy(dst->value.update.old_hash,
-			       src->value.update.old_hash, hash_size);
-		}
+		memcpy(dst->value.update.new_hash,
+		       src->value.update.new_hash, hash_size);
+		memcpy(dst->value.update.old_hash,
+		       src->value.update.old_hash, hash_size);
 		break;
 	}
 }
@@ -790,8 +784,6 @@ void reftable_log_record_release(struct reftable_log_re=
cord *r)
 	case REFTABLE_LOG_DELETION:
 		break;
 	case REFTABLE_LOG_UPDATE:
-		reftable_free(r->value.update.new_hash);
-		reftable_free(r->value.update.old_hash);
 		reftable_free(r->value.update.name);
 		reftable_free(r->value.update.email);
 		reftable_free(r->value.update.message);
@@ -808,33 +800,20 @@ static uint8_t reftable_log_record_val_type(const voi=
d *rec)
 	return reftable_log_record_is_deletion(log) ? 0 : 1;
 }
=20
-static uint8_t zero[GIT_SHA256_RAWSZ] =3D { 0 };
-
 static int reftable_log_record_encode(const void *rec, struct string_view =
s,
 				      int hash_size)
 {
 	const struct reftable_log_record *r =3D rec;
 	struct string_view start =3D s;
 	int n =3D 0;
-	uint8_t *oldh =3D NULL;
-	uint8_t *newh =3D NULL;
 	if (reftable_log_record_is_deletion(r))
 		return 0;
=20
-	oldh =3D r->value.update.old_hash;
-	newh =3D r->value.update.new_hash;
-	if (!oldh) {
-		oldh =3D zero;
-	}
-	if (!newh) {
-		newh =3D zero;
-	}
-
 	if (s.len < 2 * hash_size)
 		return -1;
=20
-	memcpy(s.buf, oldh, hash_size);
-	memcpy(s.buf + hash_size, newh, hash_size);
+	memcpy(s.buf, r->value.update.old_hash, hash_size);
+	memcpy(s.buf + hash_size, r->value.update.new_hash, hash_size);
 	string_view_consume(&s, 2 * hash_size);
=20
 	n =3D encode_string(r->value.update.name ? r->value.update.name : "", s);
@@ -891,8 +870,6 @@ static int reftable_log_record_decode(void *rec, struct=
 strbuf key,
 	if (val_type !=3D r->value_type) {
 		switch (r->value_type) {
 		case REFTABLE_LOG_UPDATE:
-			FREE_AND_NULL(r->value.update.old_hash);
-			FREE_AND_NULL(r->value.update.new_hash);
 			FREE_AND_NULL(r->value.update.message);
 			FREE_AND_NULL(r->value.update.email);
 			FREE_AND_NULL(r->value.update.name);
@@ -909,11 +886,6 @@ static int reftable_log_record_decode(void *rec, struc=
t strbuf key,
 	if (in.len < 2 * hash_size)
 		return REFTABLE_FORMAT_ERROR;
=20
-	r->value.update.old_hash =3D
-		reftable_realloc(r->value.update.old_hash, hash_size);
-	r->value.update.new_hash =3D
-		reftable_realloc(r->value.update.new_hash, hash_size);
-
 	memcpy(r->value.update.old_hash, in.buf, hash_size);
 	memcpy(r->value.update.new_hash, in.buf + hash_size, hash_size);
=20
@@ -983,17 +955,6 @@ static int null_streq(char *a, char *b)
 	return 0 =3D=3D strcmp(a, b);
 }
=20
-static int zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
-{
-	if (!a)
-		a =3D zero;
-
-	if (!b)
-		b =3D zero;
-
-	return !memcmp(a, b, sz);
-}
-
 static int reftable_log_record_equal_void(const void *a,
 					  const void *b, int hash_size)
 {
@@ -1037,10 +998,10 @@ int reftable_log_record_equal(const struct reftable_=
log_record *a,
 				  b->value.update.email) &&
 		       null_streq(a->value.update.message,
 				  b->value.update.message) &&
-		       zero_hash_eq(a->value.update.old_hash,
-				    b->value.update.old_hash, hash_size) &&
-		       zero_hash_eq(a->value.update.new_hash,
-				    b->value.update.new_hash, hash_size);
+		       !memcmp(a->value.update.old_hash,
+			       b->value.update.old_hash, hash_size) &&
+		       !memcmp(a->value.update.new_hash,
+			       b->value.update.new_hash, hash_size);
 	}
=20
 	abort();
diff --git a/reftable/record_test.c b/reftable/record_test.c
index 89209894d8..57e56138c0 100644
--- a/reftable/record_test.c
+++ b/reftable/record_test.c
@@ -183,8 +183,6 @@ static void test_reftable_log_record_roundtrip(void)
 			.value_type =3D REFTABLE_LOG_UPDATE,
 			.value =3D {
 				.update =3D {
-					.old_hash =3D reftable_malloc(GIT_SHA1_RAWSZ),
-					.new_hash =3D reftable_malloc(GIT_SHA1_RAWSZ),
 					.name =3D xstrdup("han-wen"),
 					.email =3D xstrdup("hanwen@google.com"),
 					.message =3D xstrdup("test"),
@@ -202,13 +200,6 @@ static void test_reftable_log_record_roundtrip(void)
 			.refname =3D xstrdup("branch"),
 			.update_index =3D 33,
 			.value_type =3D REFTABLE_LOG_UPDATE,
-			.value =3D {
-				.update =3D {
-					.old_hash =3D reftable_malloc(GIT_SHA1_RAWSZ),
-					.new_hash =3D reftable_malloc(GIT_SHA1_RAWSZ),
-					/* rest of fields left empty. */
-				},
-			},
 		}
 	};
 	set_test_hash(in[0].value.update.new_hash, 1);
@@ -231,8 +222,6 @@ static void test_reftable_log_record_roundtrip(void)
 				.value_type =3D REFTABLE_LOG_UPDATE,
 				.value =3D {
 					.update =3D {
-						.new_hash =3D reftable_calloc(GIT_SHA1_RAWSZ, 1),
-						.old_hash =3D reftable_calloc(GIT_SHA1_RAWSZ, 1),
 						.name =3D xstrdup("old name"),
 						.email =3D xstrdup("old@email"),
 						.message =3D xstrdup("old message"),
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index e657001d42..2659ea008c 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -88,8 +88,8 @@ struct reftable_log_record {
=20
 	union {
 		struct {
-			uint8_t *new_hash;
-			uint8_t *old_hash;
+			unsigned char new_hash[GIT_MAX_RAWSZ];
+			unsigned char old_hash[GIT_MAX_RAWSZ];
 			char *name;
 			char *email;
 			uint64_t time;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 509f486623..7336757cf5 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -468,8 +468,6 @@ static void test_reftable_stack_add(void)
 		logs[i].refname =3D xstrdup(buf);
 		logs[i].update_index =3D N + i + 1;
 		logs[i].value_type =3D REFTABLE_LOG_UPDATE;
-
-		logs[i].value.update.new_hash =3D reftable_malloc(GIT_SHA1_RAWSZ);
 		logs[i].value.update.email =3D xstrdup("identity@invalid");
 		set_test_hash(logs[i].value.update.new_hash, i);
 	}
@@ -547,16 +545,17 @@ static void test_reftable_stack_log_normalize(void)
 	};
 	struct reftable_stack *st =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-
-	uint8_t h1[GIT_SHA1_RAWSZ] =3D { 0x01 }, h2[GIT_SHA1_RAWSZ] =3D { 0x02 };
-
-	struct reftable_log_record input =3D { .refname =3D "branch",
-					     .update_index =3D 1,
-					     .value_type =3D REFTABLE_LOG_UPDATE,
-					     .value =3D { .update =3D {
-								.new_hash =3D h1,
-								.old_hash =3D h2,
-							} } };
+	struct reftable_log_record input =3D {
+		.refname =3D "branch",
+		.update_index =3D 1,
+		.value_type =3D REFTABLE_LOG_UPDATE,
+		.value =3D {
+			.update =3D {
+				.new_hash =3D { 1 },
+				.old_hash =3D { 2 },
+			},
+		},
+	};
 	struct reftable_log_record dest =3D {
 		.update_index =3D 0,
 	};
@@ -627,8 +626,6 @@ static void test_reftable_stack_tombstone(void)
 		logs[i].update_index =3D 42;
 		if (i % 2 =3D=3D 0) {
 			logs[i].value_type =3D REFTABLE_LOG_UPDATE;
-			logs[i].value.update.new_hash =3D
-				reftable_malloc(GIT_SHA1_RAWSZ);
 			set_test_hash(logs[i].value.update.new_hash, i);
 			logs[i].value.update.email =3D
 				xstrdup("identity@invalid");
@@ -810,7 +807,6 @@ static void test_reflog_expire(void)
 		logs[i].update_index =3D i;
 		logs[i].value_type =3D REFTABLE_LOG_UPDATE;
 		logs[i].value.update.time =3D i;
-		logs[i].value.update.new_hash =3D reftable_malloc(GIT_SHA1_RAWSZ);
 		logs[i].value.update.email =3D xstrdup("identity@invalid");
 		set_test_hash(logs[i].value.update.new_hash, i);
 	}
--=20
2.44.0


--BBKmD/ys5iuR0R4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXnC9IACgkQVbJhu7ck
PpSY+Q/+JNCcoBe7qLI2+pfDR98C1dMuELY8mkohbpz6N0caIzAtOmc8vKeE7QUM
zGp7WE8e0xCh30pT3b2i6fOZMDQBN2n7mjCCDJE+3m418jxDqrxzxv/hohvF7mdA
fzoIfLlLWiyjYpulXPdaMWkOx1DFenW0lQK+hjehKMwDPpSUWELW0dMctFFf8sq1
QgVXcWsBF/vn73hVRsZLdbPmlGWV0ytsIEdYV5QB8OGpOM+ntXzparXNqtEkm5md
RSjzxX8TKC/dIKVM0t6m+SZMWkIx0tbcRBzQJ06q35IyV0rpNT6qiOTt9ssOWI8h
Ife7QLSrvnJhTwRn657jISIJePRxxcLbttx4wVD7mYQSq5z2SO2WCnS5EzhAvlBl
CyU2jOFkLgnJJA9PPsEVjIUHb/N9qT2PhZfgxXnq3OuMMFQrS2RKlrRGNCauCfzd
eHCvify2pGOhoMi2UXbHcZdRBn98FhtVLI+DNLrQIUSpQU6VJrhsQeCgMsKrBtqs
9qhtQLEX139pOkkzSBOy1nWzs3tA18EIUvpExOWFmuAgCeUgu0ZbUSHst883Hj/L
GTHIZUygAtd8rEO9X4EQzGvTP3h7HzXrv51DfkrFVBbUk1LG4P99ETbIOTB1U7p/
9AnAfHQGjUoOkSSl+nogzyIjKGrfMK4oprUyrrtxfTah112CnLg=
=bMXy
-----END PGP SIGNATURE-----

--BBKmD/ys5iuR0R4Q--
