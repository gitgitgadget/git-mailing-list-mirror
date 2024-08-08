Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5DB18C33B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125994; cv=none; b=q+6LzpLAdmSXbbHRcBs2Qog6uJBUh9Y6vdxuT0mnXaS9qMG2CTobPhPoACeoUbJem6NDs/3jwHAC6BJ5cqjudM77/mCXyEU9BdDgqc0nZ0oxitff8gOgShi58XQNk6E7Kawvw2ea96C2MBOzqqPDsKk6XWPEE5JPWzkhVDbKQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125994; c=relaxed/simple;
	bh=TOFwokuvQxqczzilN1271PZRXKPZ7Ct9VhhWnkF6oYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWUIFy7kuTs8Jt3eIgAPo+sQSElqNrsVCWO77CTwPCwYcjO9wAVROjDjEGtSf+kOKTTgxwJ1g8Lrm+yReCyBu9nVAzZb7A2MC8mZEuQmvHm5LDyeaZLzHEJcRK0gxj+n7FcIKzLzAg74p6zEv6b/r3oIbYQ406wDlvBjxWiM2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=guWtGSki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XvjK9BeL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="guWtGSki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XvjK9BeL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 36568138FC67;
	Thu,  8 Aug 2024 10:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Aug 2024 10:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723125992; x=1723212392; bh=GTZ6SofbRg
	MJZBU/6GhcZ2k1/PLoKrTdGw2+WGtCsfE=; b=guWtGSki5Z8TRxkjm7hrdS2vrt
	C+a8h5xkNTuRLrfgUliTv744KP/LEF7Vcvg7ixagVp1xB+/Xg0fGCW1fTjxzBUAL
	biqkp9DoA9b4F+CJIxfEAcJ6YZR29lvcC9c4OonjQVCY8LcksH+7MqSmwO5aPtdX
	b+Wkl+z7pg4qJ8WVMKv3DLRzFu8xZT4x62UGNkJAm4JnuK08FVMTnFMO20FgLxMv
	agbIm8j3Jr+rrLNKJZP793YXz9W467i2COFI6c35Ay65jVYev3Bz7jMs4JTtp+kF
	VZzJfDorBOdBuFYGSaVuVgj2fC7YOHWHfTczIoizozw7AlPWZ7Guh+hDlY4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723125992; x=1723212392; bh=GTZ6SofbRgMJZBU/6GhcZ2k1/PLo
	KrTdGw2+WGtCsfE=; b=XvjK9BeLYhnGU/Ggma0KBKeOCRz/BFa0SqXTxJny+K3s
	MxVOJ8K/6ze2ltMMEO4O8YETmFdRKtJW8CY11EiUB4UvSdPzCEBvpc2BLa8MSZF0
	ezUCp1s5dAaVEqdybrC+gxfPpuR1+kixwiKyevMOo4Y6ZdrfsDa9Q+2RsA8LL9lA
	9Diwa71+auk8CsN3hC/2gPEKusJU2um2uk0PcT6XsjNRtdY9RQAOfktBguYlUXp1
	Gax1V3Xud7k262tZpEAL/7lcPnuQIG8JyOTtC7vmQJ26L/tbTkZCeOPM2qOH3cJJ
	qLTHv3/jbujm9HWDTJ5503S0AdgqEYphqJaPt//FkA==
X-ME-Sender: <xms:6NC0Zj6ObFlofMOyNwNRB2Om_yPGzVV-zNMD9JgOKFJ9kaj9-oxWQw>
    <xme:6NC0Zo5gIshIzM5Meu5S3alz8JuCduQOPMf1IExDAyop_5rHl0vGu5VYQ4DfFqR8Z
    fT5VkHqpvsYFNtk0w>
X-ME-Received: <xmr:6NC0ZqcIqzduGl2c-8wKOIlM0ClMIaFkzCbxhVZ86ZwAu3R4d2ezyNp8pbMGi8NR3_-0iqr-EzFMDUb3k8juPmm6KXS1oGgJ_vxtza7BNheBZZLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjlhht
    ohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:6NC0ZkIlcG5Of-2nb2bmjV60nlbaz2oVAh7m3-Ap4KjliTAFQMPYJA>
    <xmx:6NC0ZnLtVJjArOFzQSn4Ht6Sm5K_7Q1FEog5nJkAyM_UcgKY-6OrNQ>
    <xmx:6NC0ZtwhfGuVCmYCMdU8gIf61dCUK0QAKf8k4q7QH0-mLuX3B2mjPw>
    <xmx:6NC0ZjKks7tncxVF1JWay1BgB3spU71kEYfuNqNn29BEQMsVStBYsA>
    <xmx:6NC0ZkHHTuNtJYTEYTKbxcqzRloHbNV7ryWj9LlL-kPGDrLVnDfHA3Iu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9061d20b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:24 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 3/9] reftable/stack: test compaction with already-locked
 tables
Message-ID: <949f748823d8d79cd2ecede7e3b4772e3c121098.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LPt9iVFqPW3Fx2J6"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--LPt9iVFqPW3Fx2J6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're lacking test coverage for compacting tables when some of the
tables that we are about to compact are locked. Add two tests that
exercise this, one for auto-compaction and one for full compaction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 77 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 0b110f6f02..1d109933d3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -891,6 +891,45 @@ static void test_reftable_stack_auto_compaction(void)
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
+	write_n_ref_tables(st, 5);
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
@@ -939,6 +978,42 @@ static void test_reftable_stack_add_performs_auto_comp=
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
+	write_n_ref_tables(st, 3);
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
@@ -1016,9 +1091,11 @@ int stack_test_main(int argc, const char *argv[])
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
2.46.0.46.g406f326d27.dirty


--LPt9iVFqPW3Fx2J6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00OQACgkQVbJhu7ck
PpSXohAAkt1srPPFoAt77vI6HDFv7jeQOORchta3NDBq6dAryjg49ulWp33GC/Ub
DCfukkH+WTcBvYBld+Qq7kwsSbf4M7+KXTkejfVxd7YfkPGYD0+cvRVpc/2dXzmk
adjPfmP/Dkr3MSanMcmmtluUJbUjt925Jj44JQ3nQudtmXolZxUTCjqVuYEFXmFw
yWbWV56xpsO35t4oVYUavX5E5fCjAML96r9RheCSaphTY6FFewIZX1/tdnYScLvl
gcariIdrkxdd+J3Xu+p4hfnOlBIgPCb9BkXw0jnk4+EdivpFkVtfnjgk7NXALH/V
ZP/k/EbaYXm6+OaOrrJkUPhaCMKXoaPuLMNv6xe5nCEk6qp9Sr6xBns+Oi0V9PHv
VqbOs3ZsqQbaq9lh32T4UzQOaC4V8hZNPjZy4t5HVLT7UqIwZMh6JHXvQD2oZ6xD
X3OK/nMLE9B8MAv9qH0eCIKQ69Q0e52sEqPwnOpHU77XHPmvcer2zIoSU1kIBSlM
6hYwMJZ8k+PpwpFw/ARnrZh0PgE17cqIRcsD/+oHG8ufo1Iqdpt6yjBjR+008wla
PmBy0f0VsL/nXOkb5m8+dYBlXG9pxqMiqRDeXbruF/mk7KC1XWNa95OsZfI87ZF9
InYhds6BuL7xf9mjtTFeGNQ2YHtqCkG4OYGbXLfQJr7VJHtHPys=
=F1y/
-----END PGP SIGNATURE-----

--LPt9iVFqPW3Fx2J6--
