Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03118C33B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125990; cv=none; b=VtzpKqnohJXPBo7V3lEEZYT9Ye7mkpH9eEFzedzlr41BY+dmTLAA572QGom4GBofWHhyLUdQkyEcr4cBbxR6D4hYSEZbOColFeQNIW1o6/Oef7hdDdb2jf/cnmE6BoBGCBJz/mPhGLn03VNaUwyViB10G6ViJeHg7IgZM69dX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125990; c=relaxed/simple;
	bh=Vd7rfmXPLBH0DsiVDfHkK1o8aPw4euFlYZ7rIrKnSiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bpq0kopelgxKl/SETQnE5J/WlXu05rMdph9ogdfBpRO/a8xbiQGJEMQmnMVXICyZWTfyC8u+usrVgpy/kGHP3jjSI9tOrvKr4o3nPcVOmi1cCSA3+SdMWv7bTkWwDEeUOE+zEjhFULAfOiN+4SSgJMXUZ5vxtODv/DV/kR4ZuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FvrXRG0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iBP21AAL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FvrXRG0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iBP21AAL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0600F11517A4;
	Thu,  8 Aug 2024 10:06:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 08 Aug 2024 10:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723125988; x=1723212388; bh=mYMhjsUsxE
	3oB6YPAnVKvVYgNUtOqGe4p2GGjMebQ5w=; b=FvrXRG0MHGXUreCKLUM9whcazk
	kiiGjbg/yyFMK3+pPgwWfbyDLzTol90NTi/KQMt9O/62kUgNoEh5aESgdaSnJFGq
	cE81WYyBp6CZFCO/ER8CmMegDG0N02qmbvR+V4A5rbZx1glNge/jeDx8ifNhywne
	jY/X+JhNxxUGeRLNHdvuqxHvF8lQG5Oad+fnuO/7FOsWJWZSjHAvB7/Cdzg15Hdl
	jshHXjE96HW+XMXpk5ITzf++z6WA6ucl68qcOl5l3k7BoyvfrFuP1LgIW8wVnKfO
	nWVvLaqn/wqgQLGlgs1ADxV2OVTm6QcOsWctnt1/Jr4YtGmeVITpAvFur+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723125988; x=1723212388; bh=mYMhjsUsxE3oB6YPAnVKvVYgNUtO
	qGe4p2GGjMebQ5w=; b=iBP21AALFgKkWI5/9i9DyhR8rYbHpra0uKNmUNEyFG55
	nT95Rt50NMNCUYehfM6bje2cy1mRUnha3hzUgk+5+v1dOYrDYbHu5L0JcH/yzcls
	i+mD1I7dMP7d7RKRLyoabzdWWicsm0Qx/HGEXSuf386QX1mRG9ma6dUS3+CKO0uZ
	EutEs+lEgSo8x6NBbP14Cz+ctcfW/oMqDsgbnknk+iYAqB66ROQhNwyLtW8OBObO
	2cN1iRLuF7/d86NnKMv8MgoPI5lnbqkH7dRs19rkgCLlmYL4A6V6sO9ebK/qc6Dh
	r7L6SyX0hDjN1j6ZlqNnJ5jRXWnKkRFap7TvfDcOzg==
X-ME-Sender: <xms:49C0Zh02tRnBZPyAp3On5dxrAIR6QWY4FbtPbvuJWWDcNFDFqB_L1Q>
    <xme:49C0ZoE0eBGs1Y8YHQqQgbdIAMtI25M1h53N9ocoZy7T4v-oRTFrtnVwTQtdgQlpy
    VuNOcpV-g4HfxuGGQ>
X-ME-Received: <xmr:49C0Zh6Zpqv2mfJYcRG610liipOUQVnv9rTASojkD4EmYkfnPTrxA0DhcU5cJli5l6hVDfWORtv---UOMsN84nBZXFdA7LblYgta-JIlaBg656fa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:49C0Zu2RCzR82S9-KhL16QypO0W61LI5uwu7tl0v8r9GlJ-Qwl3DfA>
    <xmx:49C0ZkHUx9YuNCOPg_1BfPYG0QikhSqk8oj5ZsXGhCTLznQxJuAQaw>
    <xmx:49C0Zv9hmoZkRnblWoLOalFQ6jTnGOeM4U1TUWk_66gJUKdgNpC7WA>
    <xmx:49C0ZhlleO_nvTj6QvwC5JUP224vu3KEppQcWh8bURXaGjMzPnypQg>
    <xmx:49C0Zgge3h2KXfu_cMM1nlnjH2DlyHv3Jm7j00DwyG1qP5liLOZWNtBX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f713fedf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:19 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 2/9] reftable/stack: extract function to setup stack with
 N tables
Message-ID: <798a661824cfaa93160636e91b745b57e2d52776.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
 <cover.1723123606.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GFyVqzrZXJ/PyjSU"
Content-Disposition: inline
In-Reply-To: <cover.1723123606.git.ps@pks.im>


--GFyVqzrZXJ/PyjSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to add two tests, and both of them will want to initialize
the reftable stack with a set of N tables. Introduce a new function that
handles this and refactor existing tests that use such a setup to use
it.

Note that this changes the exact records contained in the preexisting
tests. This is fine though as we only care about the shape of the stack
here, not the shape of each table.

Furthermore, with this change we now start to disable auto compaction
when writing the tables, as otherwise we might not end up with the
expected amount of new tables added. This also slightly changes the
behaviour of these tests, but the properties we care for remain intact.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 64 +++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index e3c11e6a6e..0b110f6f02 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -109,6 +109,34 @@ static int write_test_ref(struct reftable_writer *wr, =
void *arg)
 	return reftable_writer_add_ref(wr, ref);
 }
=20
+static void write_n_ref_tables(struct reftable_stack *st,
+			       size_t n)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	int disable_auto_compact;
+	int err;
+
+	disable_auto_compact =3D st->opts.disable_auto_compact;
+	st->opts.disable_auto_compact =3D 1;
+
+	for (size_t i =3D 0; i < n; i++) {
+		struct reftable_ref_record ref =3D {
+			.update_index =3D reftable_stack_next_update_index(st),
+			.value_type =3D REFTABLE_REF_VAL1,
+		};
+
+		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
+		ref.refname =3D buf.buf;
+		set_test_hash(ref.value.val1, i);
+
+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
+		EXPECT_ERR(err);
+	}
+
+	st->opts.disable_auto_compact =3D disable_auto_compact;
+	strbuf_release(&buf);
+}
+
 struct write_log_arg {
 	struct reftable_log_record *log;
 	uint64_t update_index;
@@ -916,25 +944,11 @@ static void test_reftable_stack_compaction_concurrent=
(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-	int err, i;
-	int N =3D 3;
+	int err;
=20
 	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
-
-	for (i =3D 0; i < N; i++) {
-		char name[100];
-		struct reftable_ref_record ref =3D {
-			.refname =3D name,
-			.update_index =3D reftable_stack_next_update_index(st1),
-			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D (char *) "master",
-		};
-		snprintf(name, sizeof(name), "branch%04d", i);
-
-		err =3D reftable_stack_add(st1, &write_test_ref, &ref);
-		EXPECT_ERR(err);
-	}
+	write_n_ref_tables(st1, 3);
=20
 	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
@@ -965,25 +979,11 @@ static void test_reftable_stack_compaction_concurrent=
_clean(void)
 	struct reftable_write_options opts =3D { 0 };
 	struct reftable_stack *st1 =3D NULL, *st2 =3D NULL, *st3 =3D NULL;
 	char *dir =3D get_tmp_dir(__LINE__);
-	int err, i;
-	int N =3D 3;
+	int err;
=20
 	err =3D reftable_new_stack(&st1, dir, &opts);
 	EXPECT_ERR(err);
-
-	for (i =3D 0; i < N; i++) {
-		char name[100];
-		struct reftable_ref_record ref =3D {
-			.refname =3D name,
-			.update_index =3D reftable_stack_next_update_index(st1),
-			.value_type =3D REFTABLE_REF_SYMREF,
-			.value.symref =3D (char *) "master",
-		};
-		snprintf(name, sizeof(name), "branch%04d", i);
-
-		err =3D reftable_stack_add(st1, &write_test_ref, &ref);
-		EXPECT_ERR(err);
-	}
+	write_n_ref_tables(st1, 3);
=20
 	err =3D reftable_new_stack(&st2, dir, &opts);
 	EXPECT_ERR(err);
--=20
2.46.0.46.g406f326d27.dirty


--GFyVqzrZXJ/PyjSU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00N8ACgkQVbJhu7ck
PpQcyg/+PbQVeY8XiilJAOlUE8epeowL+nKZEtlW7W9t5xiJNAGSPzzD9V/DMt4b
DorbURCiLjKIg2MRbSk39Amym7XoLI78WrpP9B79OJBm8z+EbRegRatd0vbRMjCA
J327Akkpmb50czXz6MmuiBkRE56FAmEvpWbBOf7//IZEXzqtwzm/MBZzFqTStepi
nxZeUBACmvYtzvoTfjPXgOPP8XxLRJNZTDd4oeHrPvkcyNkpvCAL+bI7Qq/FY/og
ZqHHVJaGqZXAosPDSvnQzySZF/380lIBUgacW9TnfG/ddUalvzyfwMx4/5BU5yT2
a/AWLO8bPA009RUy9u1uKtitOrFx2v4UfjuSPAfToaIQxDOOx/bVcqVolwRif3UE
9so+QMaOuUl6AADZmnD8+xEtvt2bprIvwxYPqir8cmWfqlpfyaPKmYl6Gp31rzki
b0wGDQ3HC9xe+fBZNh5+sg8OHP6bDhMevretLKL2zBEiUkTdxvxmzfhryal7LkWr
OGyNa596LeIg++TJtPGJG3uLE3u0GCWkMdnbOS0Wfnnqj4emKexA8tJg04OpTq2W
IJIS0R3gMHByjIaBUXshJ9D1I2iY+45+gflH6S21ZXdbNxvUm5ICvGtPMTFLvUmE
mmAF458HwLZNF9QyimX/y/FyQzTCh3qXzbSk6c6aB1YMcHjl4sg=
=CDoo
-----END PGP SIGNATURE-----

--GFyVqzrZXJ/PyjSU--
