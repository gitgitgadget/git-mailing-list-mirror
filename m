Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB512B15A
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360976; cv=none; b=qx/zP1hYOA/kSV+oO9EB316IdCojS328+KmA9uhT7ORPb5+kPgm8B5Eu0Qxh7FmbM1GuHbBMJL0Hj9SY2v/2W/3+FQr4F3PujdpiYxuEA8lb2bLKOITqknIfvEJk9D+m747lKavUn0SzLWLQmyNIGRPlFghkqq0qeFH6WGUn5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360976; c=relaxed/simple;
	bh=X9eQR7WCzUWSMvEVkZRfr4N1EBXBCevP6CPJlG8+z8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkzJ1PRWUnFLX5xn9pqtITK60cssQziBBxIVVZYkYRYIokStXjkL9kX5LJAGiAxJTLTqya1w6v8LPpFogtb9G4Mv0q5gIapyVGMVK/UOwoHZYOMtDsu+fQ0IwYQe9S0DlkAqZ/jay4HeiFNutAAJnsDFQCUvVmaVWT4CPsH3f+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgbru2yO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a2i4Mz+l; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgbru2yO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a2i4Mz+l"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5D3AA13800AE;
	Mon, 25 Mar 2024 06:02:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 06:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360973; x=1711447373; bh=ekHJpNU+cX
	YjrbGprUqXiOVVzkgWAI1ADnfoltC118A=; b=fgbru2yOQKYVEhk7pPadekup/D
	KbfvToYdK27sX9boQ3vEQo5ESv8vuP3fjvKmE3/0YT2eKWg9xrDK28vwqwrBpcmi
	TDjoWpxa3o1eUb0psdgjIQLtCL52U6Ndy7PD9W+7qT4RNSxypYT8JIA6pewz7Il0
	OAVqP5U4yPxhmY+U5FvEk1NVkZGyz4I40lXNHiA00xukCO09kAEBCucfpm2iCEYw
	k1r83bLDbGF+T3zoX+DL/dio4/M0gUct8beFim4ZmLDYjtiTJUBs2onsLS/d0s1o
	E6XKEitnLQZulGaCgso4D13pBpgnU8dNJxqYJm0pho0pPqVVKePIrL4VipSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360973; x=1711447373; bh=ekHJpNU+cXYjrbGprUqXiOVVzkgW
	AI1ADnfoltC118A=; b=a2i4Mz+lo6a68PnGRdd2w+KBmo79H+86N5JlSb4+O0qC
	Z3JAZe6cAWLGfCGwXDAbYcYqWjCjX/IOLo9Mr87pMtHgaL3UpxFqAa1B3mlFe9b0
	6AFA4d2kIa+vNP+SxF+NXOo6WojuhYyXXDexg8AsqDOs+B7PMKt+RYWLm9rYhtwl
	LnEH5aQ0JJPOCDT20Vkoj15HAMOXDicHE1UQwXrouilkeKhDuW+q98eC97O0ZY/e
	kTQSYuJQVKqJFlAeYHF8A87Yfu6PZRF2Hue/uepua+IY4+O/6x5ZOlG/Z79PKmUg
	Xw60m9xgFv6Lw/3U7W8FWEpScXufkgHHWsVoarQfGw==
X-ME-Sender: <xms:zUsBZuygGc0nG_y2jU6DOvZLqJx53VmcQUfyLXyojAquhpWAm96zJA>
    <xme:zUsBZqSoA6Q0b7Zz1jP815atFj1BKeU5Gi2T__f2gJIcC2Gl4Gs2bwFoT_pIreNAo
    Kn-32k1steDzniYAQ>
X-ME-Received: <xmr:zUsBZgV-osXWI92dxxlihd_JGQ5e1C0uGlK8GQlrfqUOPaRemoOkNVyw72hVoDq7LkEY2kiz7L0A4CKPFwvQ8FStio3sPlHZ8XwTJibYDj7kGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:zUsBZkiS5-rk7Svc16_AmXnBjOeI627oqvcRHUgfRUIU3o18zqHoMw>
    <xmx:zUsBZgC9qZgpZqSn4LIBYDnw0rTdRDKocPQ7E6GYpsfeIgNLKzNe_Q>
    <xmx:zUsBZlIV-jym4cEhRLWqlytmWQwQ3UtAeJF8dOzoHit_wExNlCGZwg>
    <xmx:zUsBZnBR2NtTpaxGdb5vO6YAyLiDbpmC-JVdwlC_aA4s4lL4GMS6Nw>
    <xmx:zUsBZj-emFsEtfJoI2jdozGTtf-2RjqY32-IsilQ_2mFNYKWJBuZQA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:02:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a16e4749 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:42 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/15] reftable/stack: gracefully handle failed
 auto-compaction due to locks
Message-ID: <50a3c37f92a28876c0db24e515826485c863ecc3.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0UKJqxGnfPMpRYqX"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--0UKJqxGnfPMpRYqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Whenever we commit a new table to the reftable stack we will end up
invoking auto-compaction of the stack to keep the total number of tables
at bay. This auto-compaction may fail though in case at least one of the
tables which we are about to compact is locked. This is indicated by the
compaction function returning `REFTABLE_LOCK_ERROR`. We do not handle
this case though, and thus bubble that return value up the calling
chain, which will ultimately cause a failure.

Fix this bug by ignoring `REFTABLE_LOCK_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c           | 13 +++++++++++-
 reftable/stack_test.c      | 43 ++++++++++++++++++++++++++++++++++++++
 t/t0610-reftable-basics.sh | 20 ++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 79856b6565..dde50b61d6 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -680,8 +680,19 @@ int reftable_addition_commit(struct reftable_addition =
*add)
 	if (err)
 		goto done;
=20
-	if (!add->stack->disable_auto_compact)
+	if (!add->stack->disable_auto_compact) {
+		/*
+		 * Auto-compact the stack to keep the number of tables in
+		 * control. It is possible that a concurrent writer is already
+		 * trying to compact parts of the stack, which would lead to a
+		 * `REFTABLE_LOCK_ERROR` because parts of the stack are locked
+		 * already. This is a benign error though, so we ignore it.
+		 */
 		err =3D reftable_stack_auto_compact(add->stack);
+		if (err < 0 && err !=3D REFTABLE_LOCK_ERROR)
+			goto done;
+		err =3D 0;
+	}
=20
 done:
 	reftable_addition_close(add);
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 2c3540d9e6..822e681028 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -343,6 +343,48 @@ static void test_reftable_stack_transaction_api_perfor=
ms_auto_compaction(void)
 	clear_dir(dir);
 }
=20
+static void test_reftable_stack_auto_compaction_fails_gracefully(void)
+{
+	struct reftable_ref_record ref =3D {
+		.refname =3D "refs/heads/master",
+		.update_index =3D 1,
+		.value_type =3D REFTABLE_REF_VAL1,
+		.value.val1 =3D {0x01},
+	};
+	struct reftable_write_options cfg =3D {0};
+	struct reftable_stack *st;
+	struct strbuf table_path =3D STRBUF_INIT;
+	char *dir =3D get_tmp_dir(__LINE__);
+	int err;
+
+	err =3D reftable_new_stack(&st, dir, cfg);
+	EXPECT_ERR(err);
+
+	err =3D reftable_stack_add(st, write_test_ref, &ref);
+	EXPECT_ERR(err);
+	EXPECT(st->merged->stack_len =3D=3D 1);
+	EXPECT(st->stats.attempts =3D=3D 0);
+	EXPECT(st->stats.failures =3D=3D 0);
+
+	/*
+	 * Lock the newly written table such that it cannot be compacted.
+	 * Adding a new table to the stack should not be impacted by this, even
+	 * though auto-compaction will now fail.
+	 */
+	strbuf_addf(&table_path, "%s/%s.lock", dir, st->readers[0]->name);
+	write_file_buf(table_path.buf, "", 0);
+
+	ref.update_index =3D 2;
+	err =3D reftable_stack_add(st, write_test_ref, &ref);
+	EXPECT_ERR(err);
+	EXPECT(st->merged->stack_len =3D=3D 2);
+	EXPECT(st->stats.attempts =3D=3D 1);
+	EXPECT(st->stats.failures =3D=3D 1);
+
+	reftable_stack_destroy(st);
+	clear_dir(dir);
+}
+
 static void test_reftable_stack_validate_refname(void)
 {
 	struct reftable_write_options cfg =3D { 0 };
@@ -1085,6 +1127,7 @@ int stack_test_main(int argc, const char *argv[])
 	RUN_TEST(test_reftable_stack_tombstone);
 	RUN_TEST(test_reftable_stack_transaction_api);
 	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compaction);
+	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
 	RUN_TEST(test_reftable_stack_update_index_check);
 	RUN_TEST(test_reftable_stack_uptodate);
 	RUN_TEST(test_reftable_stack_validate_refname);
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..5f2f9baa9b 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -340,6 +340,26 @@ test_expect_success 'ref transaction: empty transactio=
n in empty repo' '
 	EOF
 '
=20
+test_expect_success 'ref transaction: fails gracefully when auto compactio=
n fails' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		for i in $(test_seq 10)
+		do
+			git branch branch-$i &&
+			for table in .git/reftable/*.ref
+			do
+				touch "$table.lock" || exit 1
+			done ||
+			exit 1
+		done &&
+		test_line_count =3D 13 .git/reftable/tables.list
+	)
+'
+
 test_expect_success 'pack-refs: compacts tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.GIT


--0UKJqxGnfPMpRYqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS8kACgkQVbJhu7ck
PpSSLRAAo1LhTLdckB0TvnXaqPmGc4MI17qMpjxifDdy7Eui6e1aehJa7by11utg
Tv0hPT0jv4ES6bZVQAhptidonoN3lp0WXqAeU7iQBq/HJzU+bxTZkMR+Ahi6KhDM
odSevFZJWN52aNAvYHnNJJbHbUuyHenJQ9tui9pSKVfl9JKNKvZbErxHhYVhqC1v
dm49HCnMPN7P0wuf0PU6xqqcOv9gM6gkWdWIuc3hH+FD2p2iJnTIikrM8avU+GN7
WSUT0zjzDCiXL90sKURCBLCCcK/mWIWBKYnWl+xWsLyMqetrMC3RZe/DGEFCopgh
2NhmjVDTfAmm6zMstGj6bUR/biD/1pjUzhpkl4EUAF4awX9/dQ+EU459MbneW5Us
3EtXERrfQbasjbBDKaDt3QWJj2nF4yuCGRMEUA33KrKQA9O9mVnG43ssQxhOwG9l
d0Z6VFKlOLIEnCC4A+d8rnosNma9h4AmZ3AmM4VJJIQOT9QovL5M9Ix18Bd4hGNG
behqe1xvSfmZTxXJcmzP64/Jm1cryiIUOAf3bzl9MhwMzO1Q3LPtzCkpLl2GDdBi
/62U9CjfK2+y1dWiDXjVCWFf2JQoNxHd8fjl+slxwQa5VvcH0EdTM2aHNiZQAHvX
cFp7W5TqwY59InCSdhm/yIt6cavbcTt1a7JPbsokPR6Q/VRPEqY=
=WCBu
-----END PGP SIGNATURE-----

--0UKJqxGnfPMpRYqX--
