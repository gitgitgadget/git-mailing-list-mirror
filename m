Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144416C844
	for <git@vger.kernel.org>; Fri, 10 May 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336986; cv=none; b=I12nVc86iicUoI8jmJrdLUbo3K9MFQj9jrDjWP+InOFFNdLrG/xY8dGT4GZ0XwsvnzOd83TpdmzTPqc1XvVNULjLOefdWF9SkGNO86X1SBk97CjrkT1EQT5j4pY62z7+7JcyPvWMp/t+67Xd0dRu+ugJnPdSanI0PkQr7E59UUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336986; c=relaxed/simple;
	bh=VYjmdAe83h4bfBirPVgRa1l18TlkShUjbRj4pmPXFgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9ueD0KDBqEiVXLqHmWETVi4BaaRmPDyL4JpYgQnCmWjDKmYjKokHVgIHVnOx3oKB3gyOj6/6upaix/RiYds+FLzbwzqFxCmI8q5SrGoLpG+JIVBREuOmNt+HUzFIvzhYJ5HHUgRDuCe07vJT6fAbl6rqvFItU2KdS/f+3EfsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bFqo5dBk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ea5T7Q5p; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bFqo5dBk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ea5T7Q5p"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id CAA211C000E5;
	Fri, 10 May 2024 06:29:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 06:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715336983; x=1715423383; bh=lJ2VUvM+5L
	XM1o8XtVAXTRGCkiPShI81i4116Y6L+rI=; b=bFqo5dBkYPm9Fxy3a7pYoiTeIj
	WEhFGKEKJ0TKVtfltPDCMJ8yOBBHxvryD/x7OGfkUd2aa4KwFHuGAQ7sPVALvxLG
	kYEfg3mfjSuIXxqwL+vLPdMc9++oJxQNvba2me+2WXKpGM2xdLYjvBJwxg/jRY6D
	a7jt7/rb3e6AV4efCzt/5B6lJjfXESoRcPe987YMps9UIYw6gNqElOd/i5v1BG5U
	FdGT7VOi988+bS6hACEP19CXd1yWktC/CCywoTED6VnLpI2L4EK4ptVKlJeFo0SO
	DSu/k4+enPD20pnwm/wb/QSe/93gBr/kL2Y4/3RykBIUXKLwlolDToLUdkHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715336983; x=1715423383; bh=lJ2VUvM+5LXM1o8XtVAXTRGCkiPS
	hI81i4116Y6L+rI=; b=Ea5T7Q5pGo0YWNSQsAyj89yK/fEcgKWGyaMOGUIDvzoo
	pmzAHIQAnklh9EETdT9h1SM2a7eEK68sYxkgM7YPdGT4KCnrWXIyUSPyYtlSNRHl
	dVJsTmuZ7cTcC0bfuNIcWObrQovM+KneEPHUwaPQPQDeYz+qTjvZUNNTBdAlKvAO
	lcx6+yh6zYuW7BIfxcqMrTOARCfOZ2wz4M1jWCN16WjnUjNqYxrTA/281tgAhjwJ
	D4eVXsc1EY2swHJjZzU1xXpAhhVyulrtd/i8XUka7BbJtLThICV7HkNFdu7k1dGg
	2Oz+tI1V+3nGcZz6gzTImy3kna6eriv4euzUNyFanA==
X-ME-Sender: <xms:F_c9Zt-rbHplqOW-FwO8egkGI0UlptiFeVu6XFlyylqgs_tLiRTj4A>
    <xme:F_c9ZhukOd56erb9rZeqnekn9euUKxJc46ALw6BF-xtx46ErCPzLST6ErgafLoGyX
    QsWOtqaDQwrhM_HXQ>
X-ME-Received: <xmr:F_c9ZrB5PxKxGWsn879ch-vmZ5zc4tGP4xODCGiuls2g2DPVQPN-b9wYmD89Ld-6QdwCjGvCAY4AF_smsjRnizvUiCNHXPYpeHVIFBGSFyjFZuh47w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:F_c9Zhdcft9OcKQkKZR24qmQZMlNiS4Egw9nUOrIAgvGQ2uaX1edJA>
    <xmx:F_c9ZiOkAcMp3AtF19EmjOTDE-H1wW1b5EUQiIwVt8a-p_CI-cGIUg>
    <xmx:F_c9ZjnxVKx1j8a9ltHyu8T7QcsOW6edW6863QRDaO03WMu7mLRDqQ>
    <xmx:F_c9Zst8DfIEhO9xD1f6LFQuCR9UzA5FUhyY0Hom0km82V3URCPOqQ>
    <xmx:F_c9ZvrkqiIdDPWEdqSSLfo7uAjyqexcaqAvQ_4XOu-0fENFhWCInveC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 06:29:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8324d31b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 10:29:30 +0000 (UTC)
Date: Fri, 10 May 2024 12:29:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 05/11] reftable/dump: support dumping a table's block
 structure
Message-ID: <ed1c150d909da836a760bc0699f585722d5988e9.1715336798.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eLZOD/93sxY9ZbF3"
Content-Disposition: inline
In-Reply-To: <cover.1715336797.git.ps@pks.im>


--eLZOD/93sxY9ZbF3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to introduce new configs that will allow users to have more
control over how exactly reftables are written. To verify that these
configs are effective we will need to take a peak into the actual blocks
written by the reftable backend.

Introduce a new mode to the dumping logic that prints out the block
structure. This logic can be invoked via `test-tool dump-reftables -b`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/dump.c                   |   8 ++-
 reftable/reader.c                 |  63 ++++++++++++++++++
 reftable/reftable-reader.h        |   2 +
 t/t0613-reftable-write-options.sh | 102 ++++++++++++++++++++++++++++++
 4 files changed, 174 insertions(+), 1 deletion(-)
 create mode 100755 t/t0613-reftable-write-options.sh

diff --git a/reftable/dump.c b/reftable/dump.c
index 9c770a10cc..24476cc2a9 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -48,6 +48,7 @@ static void print_help(void)
 	printf("usage: dump [-cst] arg\n\n"
 	       "options: \n"
 	       "  -c compact\n"
+	       "  -b dump blocks\n"
 	       "  -t dump table\n"
 	       "  -s dump stack\n"
 	       "  -6 sha256 hash format\n"
@@ -58,6 +59,7 @@ static void print_help(void)
 int reftable_dump_main(int argc, char *const *argv)
 {
 	int err =3D 0;
+	int opt_dump_blocks =3D 0;
 	int opt_dump_table =3D 0;
 	int opt_dump_stack =3D 0;
 	int opt_compact =3D 0;
@@ -67,6 +69,8 @@ int reftable_dump_main(int argc, char *const *argv)
 	for (; argc > 1; argv++, argc--)
 		if (*argv[1] !=3D '-')
 			break;
+		else if (!strcmp("-b", argv[1]))
+			opt_dump_blocks =3D 1;
 		else if (!strcmp("-t", argv[1]))
 			opt_dump_table =3D 1;
 		else if (!strcmp("-6", argv[1]))
@@ -88,7 +92,9 @@ int reftable_dump_main(int argc, char *const *argv)
=20
 	arg =3D argv[1];
=20
-	if (opt_dump_table) {
+	if (opt_dump_blocks) {
+		err =3D reftable_reader_print_blocks(arg);
+	} else if (opt_dump_table) {
 		err =3D reftable_reader_print_file(arg);
 	} else if (opt_dump_stack) {
 		err =3D reftable_stack_print_directory(arg, opt_hash_id);
diff --git a/reftable/reader.c b/reftable/reader.c
index 481dff10d4..f23c8523db 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -856,3 +856,66 @@ int reftable_reader_print_file(const char *tablename)
 	reftable_reader_free(r);
 	return err;
 }
+
+int reftable_reader_print_blocks(const char *tablename)
+{
+	struct {
+		const char *name;
+		int type;
+	} sections[] =3D {
+		{
+			.name =3D "ref",
+			.type =3D BLOCK_TYPE_REF,
+		},
+		{
+			.name =3D "obj",
+			.type =3D BLOCK_TYPE_OBJ,
+		},
+		{
+			.name =3D "log",
+			.type =3D BLOCK_TYPE_LOG,
+		},
+	};
+	struct reftable_block_source src =3D { 0 };
+	struct table_iter ti =3D TABLE_ITER_INIT;
+	struct reftable_reader *r =3D NULL;
+	size_t i;
+	int err;
+
+	err =3D reftable_block_source_from_file(&src, tablename);
+	if (err < 0)
+		goto done;
+
+	err =3D reftable_new_reader(&r, &src, tablename);
+	if (err < 0)
+		goto done;
+
+	printf("header:\n");
+	printf("  block_size: %d\n", r->block_size);
+
+	for (i =3D 0; i < ARRAY_SIZE(sections); i++) {
+		err =3D reader_start(r, &ti, sections[i].type, 0);
+		if (err < 0)
+			goto done;
+		if (err > 0)
+			continue;
+
+		printf("%s:\n", sections[i].name);
+
+		while (1) {
+			printf("  - length: %u\n", ti.br.block_len);
+			printf("    restarts: %u\n", ti.br.restart_count);
+
+			err =3D table_iter_next_block(&ti);
+			if (err < 0)
+				goto done;
+			if (err > 0)
+				break;
+		}
+	}
+
+done:
+	reftable_reader_free(r);
+	table_iter_close(&ti);
+	return err;
+}
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 4a4bc2fdf8..4a04857773 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -97,5 +97,7 @@ void reftable_table_from_reader(struct reftable_table *ta=
b,
=20
 /* print table onto stdout for debugging. */
 int reftable_reader_print_file(const char *tablename);
+/* print blocks onto stdout for debugging. */
+int reftable_reader_print_blocks(const char *tablename);
=20
 #endif
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-opt=
ions.sh
new file mode 100755
index 0000000000..462980c37c
--- /dev/null
+++ b/t/t0613-reftable-write-options.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+
+test_description=3D'reftable write options'
+
+GIT_TEST_DEFAULT_REF_FORMAT=3Dreftable
+export GIT_TEST_DEFAULT_REF_FORMAT
+# Disable auto-compaction for all tests as we explicitly control repacking=
 of
+# refs.
+GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse
+export GIT_TEST_REFTABLE_AUTOCOMPACTION
+# Block sizes depend on the hash function, so we force SHA1 here.
+GIT_TEST_DEFAULT_HASH=3Dsha1
+export GIT_TEST_DEFAULT_HASH
+# Block sizes also depend on the actual refs we write, so we force "master=
" to
+# be the default initial branch name.
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmaster
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'default write options' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git pack-refs &&
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 4096
+		ref:
+		  - length: 129
+		    restarts: 2
+		log:
+		  - length: 262
+		    restarts: 2
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'disabled reflog writes no log blocks' '
+	test_config_global core.logAllRefUpdates false &&
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git pack-refs &&
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 4096
+		ref:
+		  - length: 129
+		    restarts: 2
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'many refs results in multiple blocks' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		for i in $(test_seq 200)
+		do
+			printf "update refs/heads/branch-%d HEAD\n" "$i" ||
+			return 1
+		done >input &&
+		git update-ref --stdin <input &&
+		git pack-refs &&
+
+		cat >expect <<-EOF &&
+		header:
+		  block_size: 4096
+		ref:
+		  - length: 4049
+		    restarts: 11
+		  - length: 1136
+		    restarts: 3
+		log:
+		  - length: 4041
+		    restarts: 4
+		  - length: 4015
+		    restarts: 3
+		  - length: 4014
+		    restarts: 3
+		  - length: 4012
+		    restarts: 3
+		  - length: 3289
+		    restarts: 3
+		EOF
+		test-tool dump-reftable -b .git/reftable/*.ref >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
--=20
2.45.0


--eLZOD/93sxY9ZbF3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY99xMACgkQVbJhu7ck
PpTf0hAAqm20jNwmxwY57yf/IMHi4VkK4yUjycYoIp9KCs0jp/c68/lRNMd5M06F
phTqbo2AiXWpu4LOQVqps7mdnHc91AVSYROwAtCwqw9n+G1eI+t5CoLmowEeGBbt
CRnAr6k9I4w+BSeTfKdJ2WVRIv7ao4QC/Q8fs74UmhiHGrlfRdU0qRN5xr8XJyCN
ubEHPOiR7OTmMD4U0KtRQRySqJ2BDl9cB93yaj3oXAMFX7rdJ/ATq1eiXgEo5C9q
9pK0orglnrp57NptgKqzg/jnoT0XwvMkRgJ87PRmAQnfMJJe5BIIcJ2K442MygW+
2aZmN24qivmZ6Pdp7hZ/r0/Qh09eBBNEzmuOR/fS8nRFG2xRkpb7dIFJExUM6aKK
Et2XY4v/GJjHtF3ub6Y4q1ldr52SpCPqGRas8WstYLKXOE0o60L2Z6BwC8HSXDmL
HWboweKb3rh7DDd8FrYbLezcCXdMLCVsQbKhrW3B/cWAE5KZU1IrmVMg+nzvZCOp
+Gj+Wl57yHSZW2waSa5ugfybrkYfUE71ygnSTfzV0z3GHOXmgVki7vgBDJkE80YS
Y/x50WPgIlG47AXTwMehp+t3V9Vcd249oGNRTOKJxijKyQ+3aULxLhD2WKFWQIK3
1B8lsu+5EA0yyOusMbRE2eOgryFSpMxuMwS5RCx4VADMYwtCnrk=
=6YCz
-----END PGP SIGNATURE-----

--eLZOD/93sxY9ZbF3--
