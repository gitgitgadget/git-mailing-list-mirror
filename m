Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0B1B375C
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435302; cv=none; b=LVV4tcy2VOkTtWf/K84sXx4g0DkUnPpt44Iu060FbJzNNd+GSu1qlPofykgdxz+JYNOyZSELkjxfAaPSAWS1UH321WWMkGvy7EJk3XAeI7CBW4nrwnlYr0LACHYq47rTiOkjlILJVG3RBRVzk7ril177+Lght4SkeOaq8l2Rkv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435302; c=relaxed/simple;
	bh=ygkhdS004+btHxYp9hjaisI/UZJm7p/hK9WjtY/NvZk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqE1aOza1H/2v18IjZKFcymMN8YQNyKRITY2UTe4DwcKU9IAb9FxSppjTcso8gjzpNhxq5pIB0Ym933k4FcgNgHYDrIhjZJahUZeQm3/f1xKLA1rVK0oVAJayHUxgnQZ5yHXt2Bw5nPYkr9p3FVFqxW96gfo0K9qXA7Uzg9WWjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IJjHuX/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BifOLTg6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IJjHuX/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BifOLTg6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 07D041381E13
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 31 Jul 2024 10:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435300; x=1722521700; bh=Si9etyY1Cm
	I533199jI1jEP50fsbX2gipMnoIxbjPR0=; b=IJjHuX/2iUB4y4hqtgP8OuhFFl
	B4YXHL7QC/15eqERi1SZNGu/qfmdQsONlnsvRYVvy/57FUkQ8utlovrHTOdIbKli
	fc2pXPMh/7aLZoPvkURWj+EsT7u8yFgNpDrccGTePyOsA4L6SEj91L+eQiqRdZ3s
	hQq1L7nIq2XLPSD45ZwROWlNn+VmHb1CRaL1AwJyT66zXJpU9xwIgySEDgCrFzn6
	bXRepbRa1njx1e2wSmuthMXrw0HpupSGyAe1+TzIczaDsNw6aDcghbKKxfpw3EKS
	fRHYQ5d9+MZDo5rfSBuDhqbWYYTZqvqj+LiQ56ZmiINax0n0fQ7Avy55f4/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435300; x=1722521700; bh=Si9etyY1CmI533199jI1jEP50fsb
	X2gipMnoIxbjPR0=; b=BifOLTg6kdc1tTXPOeKImM9eWlntrUKFJmvQBF/YCqFf
	iEWVBYG9ZL/yZ6ROrxmUxO7HSs8XVmoJN3SjBa8BZC9bGxuGeu/4eMyT7sibc0cZ
	ca0zxVXz9hbbjgvIEhMBNHc+unmRSv+4LOgsRGJWugToomy4/I7f8yDfBpUuKUCC
	8k1vD+jZz9oVj6MlhfB49Rh5ydb+k+BZLbdLYk9KpuHYYANQrEEu3Xlf4iNo95Qn
	z5fuicrwNIC2Mm65azT/QJTigvWmicqrCClULfrLe4n+4icOiM7AlrQiiszYBv5+
	nUH0Cxozs5Tnexg+sqQA3ItyMIoV4DTcyKtMLzrWfA==
X-ME-Sender: <xms:40aqZlPtmsmCdG5Zl-xaKLELMvqzSE_3au4neF9exeUIWeO2p3YSLw>
    <xme:40aqZn-6qRLgUeLUfYLEbjCgAukiVasRbTw32O73-BoxrylCqWzE05YgT11aq1t9u
    q4UWx7wymUNeW2i6w>
X-ME-Received: <xmr:40aqZkTaRnYol1_e-XKkCLW218GuJGNlYwGeRnCO0fbZ5-_GR0NiKqIc3NYviHrwU9u4erFtthIvPN8QnL1cUkaYSjuuE3iAYnU7s3VS2S1FgbU5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:40aqZhtz13eaF2yuf5dGYqXi2xOCDbK31pV8NcHD3Pw2AIA-QJrusQ>
    <xmx:40aqZtcITlvv2pbnWeCQYcDx_SMIIrzFU_0moESKg-7P4l40v3t_Zg>
    <xmx:40aqZt2JRRXX85k5XFwtD1KAtKyfIKPtz_kKEiD0l-jyonMBZuHkHg>
    <xmx:40aqZp_S0bgzOHjJ06VC0qovly_AGCil-IL5koIyi_2rpP78_4FrcQ>
    <xmx:5EaqZtGmgcaNnNA6nAjH5JWKxfKzfwBbYIG7iBjX4Nz6E4wrJN0RWE1C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:14:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 971f2713 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:29 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:14:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/8] reftable/stack: test compaction with already-locked
 tables
Message-ID: <123fb9d80eecbd3690280991e0415cbb718b7202.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yd1FxTSQWriqvsil"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--Yd1FxTSQWriqvsil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're lacking test coverage for compacting tables when some of the
tables that we are about to compact are locked. Add two tests that
exercise this, one for auto-compaction and one for full compaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e3c11e6a6e..04526c6604 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -863,6 +863,58 @@ static void test_reftable_stack_auto_compaction(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_auto_compaction_with_locked_tables(void)
+{
+	struct reftable_write_options opts =3D {
+		.disable_auto_compact =3D 1,
+	};
+	struct reftable_stack *st =3D NULL;
+	struct strbuf buf =3D STRBUF_INIT;
+	char *dir =3D get_tmp_dir(__LINE__);
+	int err;
+
+	err =3D reftable_new_stack(&st, dir, &opts);
+	EXPECT_ERR(err);
+
+	for (size_t i =3D 0; i < 5; i++) {
+		struct reftable_ref_record ref =3D {
+			.update_index =3D reftable_stack_next_update_index(st),
+			.value_type =3D REFTABLE_REF_VAL1,
+			.value.val1 =3D { i },
+		};
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/branch-%04" PRIuMAX, (uintmax_t) i);
+		ref.refname =3D buf.buf;
+
+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+	}
+	EXPECT(st->merged->stack_len =3D=3D 5);
+
+	/*
+	 * Given that all tables we have written should be roughly the same
+	 * size, we expect that auto-compaction will want to compact all of the
+	 * tables. Locking any of the tables will keep it from doing so.
+	 */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[2]->name);
+	write_file_buf(buf.buf, "", 0);
+
+	/*
+	 * Ideally, we'd handle the situation where any of the tables is locked
+	 * gracefully. We don't (yet) do this though and thus fail.
+	 */
+	err =3D reftable_stack_auto_compact(st);
+	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
+	EXPECT(st->stats.failures =3D=3D 1);
+	EXPECT(st->merged->stack_len =3D=3D 5);
+
+	reftable_stack_destroy(st);
+	strbuf_release(&buf);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_add_performs_auto_compaction(void)
 {
 	struct reftable_write_options opts =3D { 0 };
@@ -911,6 +963,55 @@ static void test_reftable_stack_add_performs_auto_comp=
action(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_compaction_with_locked_tables(void)
+{
+	struct reftable_write_options opts =3D {
+		.disable_auto_compact =3D 1,
+	};
+	struct reftable_stack *st =3D NULL;
+	struct strbuf buf =3D STRBUF_INIT;
+	char *dir =3D get_tmp_dir(__LINE__);
+	int err;
+
+	err =3D reftable_new_stack(&st, dir, &opts);
+	EXPECT_ERR(err);
+
+	for (size_t i =3D 0; i < 3; i++) {
+		struct reftable_ref_record ref =3D {
+			.update_index =3D reftable_stack_next_update_index(st),
+			.value_type =3D REFTABLE_REF_VAL1,
+			.value.val1 =3D { i },
+		};
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/heads/branch-%04" PRIuMAX, (uintmax_t) i);
+		ref.refname =3D buf.buf;
+
+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+	}
+	EXPECT(st->merged->stack_len =3D=3D 3);
+
+	/* Lock one of the tables that we're about to compact. */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "%s/%s.lock", dir, st->readers[1]->name);
+	write_file_buf(buf.buf, "", 0);
+
+	/*
+	 * Compaction is expected to fail given that we were not able to
+	 * compact all tables.
+	 */
+	err =3D reftable_stack_compact_all(st, NULL);
+	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
+	/* TODO: this is wrong, we should get notified about the failure. */
+	EXPECT(st->stats.failures =3D=3D 0);
+	EXPECT(st->merged->stack_len =3D=3D 3);
+
+	reftable_stack_destroy(st);
+	strbuf_release(&buf);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_compaction_concurrent(void)
 {
 	struct reftable_write_options opts =3D { 0 };
@@ -1016,9 +1117,11 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_add);
 	RUN_TEST(test_reftable_stack_add_one);
 	RUN_TEST(test_reftable_stack_auto_compaction);
+	RUN_TEST(test_reftable_stack_auto_compaction_with_locked_tables);
 	RUN_TEST(test_reftable_stack_add_performs_auto_compaction);
 	RUN_TEST(test_reftable_stack_compaction_concurrent);
 	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
+	RUN_TEST(test_reftable_stack_compaction_with_locked_tables);
 	RUN_TEST(test_reftable_stack_hash_id);
 	RUN_TEST(test_reftable_stack_lock_failure);
 	RUN_TEST(test_reftable_stack_log_normalize);
--=20
2.46.0.dirty


--Yd1FxTSQWriqvsil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRuAACgkQVbJhu7ck
PpStYxAAqsbIRdGWxO9Nz0xoNeNA8t81i2DWem8V2bNGESxYkJwP7wv341Cin3tf
LiVA79yQgKUaW+mnz1/+iISYuA3Jjmkcq5gZsxM/oFlMZ7XXFE27MWAKSXoc/q1+
W+2121Bg5gQt8cLGgXKET+JLXy48pT7ukzMdp54vTJGXwjR2yaHz3m03FQJoNFq9
L6IXwBsUUDZESb5vRNwv1KKs2lCzvOcJ+fB7PRRNPM17erPBh5a3DGGBleFnqRz5
9qT2BnjhIEGmqZebuYMkEbuNJPTLOQSLNS5B4Fp/Zge7dTvtVxBQvzKQmcSJwGeo
ao/qvMI1oXIXkQP7F/eSHXimtLnvSRNpYJXxC5d+FiTzH14ZtpBs8tYAFf4uMrWf
kvMseyoZdXoNsavvm7wXf1kHkqg75QCuDtPGP+kEN229K0plXQy2seWugpb5d7k3
qHQFvlwBXsDm5rZcyNn7a3kVpk0WA64brK8WG18N2aQgzuzshf5g3HFqJTYvJvNP
jguAvUSNOMoxGDZtkJd5HF4AO9IjBw84ec2tGxzygWopr350XwUDo+uVR8cQgh4A
Y4yo4StBIpwmhBd6Uti0rmSAEqibmmc6eTaEgHzeIywH8a4Fnj4PgaqI8bXogKR+
elKL6sMMopuiV+middiLVYOGhsEPpAPKw30bGh6/ojD75qHgfNk=
=JFXv
-----END PGP SIGNATURE-----

--Yd1FxTSQWriqvsil--
