Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505021A04
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632718; cv=none; b=rk1NJMvIY57iynpsMHj2X31+896YWmCccBYt2C1RvX811xY0/5K69SP40OqSNbqAyi8JJxkFQNNM9vH6nxS9SZouH1LTgyRk0tNH0SZeAX4kSD5ndEz/ye0rqhDxiYDLGBD8EzN/d9X9XwrriylG/YARJSbwusGkv1J25RtI2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632718; c=relaxed/simple;
	bh=8ZZLRJkV0OWEktJ8YDMyMo3vhx7JEDyQHXzIGHE27kw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7xasEGgtlnIpkFmnMbxfN5gUejFQeeBAKQZX9UCd3hNfi6gcqADRnGlNkYAFTr8OWvsKHZVUYp8m2RO57UpUE+dYDhis75MRIesUrb/pdOoCH+ToYUo2vJUZY9jDy1lHELyHEv+IkurfhQEeagMT+DcAabvjmDY3VC2NYylOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NNJ8cqwr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P26dXn/3; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NNJ8cqwr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P26dXn/3"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9D9E411400F9
	for <git@vger.kernel.org>; Thu,  2 May 2024 02:51:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2024 02:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632715; x=1714719115; bh=BGAazfA8S/
	I1+2DAsPXiosk/lreELDQhmG+U5dUBPTk=; b=NNJ8cqwr/sIPWXsKNgXS2SHjbL
	3OgkHJq/ZRpQX8IIFB5vVu96pO79L7py2nljsRBo2TCotHE/X7x8GfIu6myAp3QP
	F/l5htgrgAuzzeFrrGiKh6dQJx/fOF1+24YK2kBqcurFPSnvWuWdoDPihhWKCJbF
	OccOFxUV3yuW51ZHMx6EMk/CYu1UPgMEAoHxEfn9bH/HA8J9CsH6dgiUdtmq4OK3
	/mh9dQbYodjcyBoR44bHeVwPepPfbBmdZQy8xIhCjXyLwVhX48bcBO2VqhSYcU5Y
	+taBjR6p16EDduxoqz0oES/wA3IiktfsZ4Tgjv2SEH/YpnNF+2fi6FjzDOww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632715; x=1714719115; bh=BGAazfA8S/I1+2DAsPXiosk/lreE
	LDQhmG+U5dUBPTk=; b=P26dXn/3nfvlegbgMdGyXtr+joEkxoD1ra0YILSePSEw
	XKAnM8buqxiFhWCSwyHVTheNvkz9DqSzHoXHeAgSSWJyBpuBO6w9OU3tw1oRw+Tv
	wz8Y1V4bUKwFIsup0ql++s5sS2q8AluSrV+eZF+V4brIixh08ekkn0BRJZ7UAKhZ
	Iu9VsTxh8hvPuOveBNGoeiWfl9hCpk52/izKnI1fAJnrWUTcawUIPmWmsh70Dt24
	e2khe6etbTurFCD5murvWTDuwmAdZtIWXiRvr+ftH8n5f8IHlizk/o3AJ39S1Q3Z
	eBYJTiibghR5TqJIoobvhguEGsa3j2upfGgjfuxZoQ==
X-ME-Sender: <xms:CzgzZnvsVxbyrByu1dDSExRcZxNXxgF1fbpebR19jd0wRniQS2WcZw>
    <xme:CzgzZodOQHWLe8QzL6CJWHUKKSE9luem5ukvLhGvLbJ8PqDn0NmaBnPei8S1c6nOS
    gP3yUMzVUTCnvSDyA>
X-ME-Received: <xmr:CzgzZqwRwyBjo0G7MU9Vw3AL2LGNg4y1x2-s0sbh19yZ9SJ6C2EjdG0NtCflE-S4n7TiMe9rFpDKF6PYmnA5Lw3PZXvR-to63f2EODoOC_RfPGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:CzgzZmN6YuyH9fP5SEXJl8H11WRx43ZChz7vSHN0dnJi3IUOHsHvLg>
    <xmx:CzgzZn_Sagnvclq8eYtFU7rzeiqyRUHuSvCij8aEdFcrbQQB5qYMFQ>
    <xmx:CzgzZmVWlKuyinkDheldLnYQX2a_z3bjrHGKdqAVs9BZbVb1b_bf2A>
    <xmx:CzgzZocYgQEeb9-A30f2ajfeBg01dWXXlukAWDYX4xAW5Qd-EwDLog>
    <xmx:CzgzZhlPW-sn9zTtbtMzMWo4qUvBSyqbQ_byz4eNCIKUeO0paMQxFkRm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 2 May 2024 02:51:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a3513db5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 2 May 2024 06:51:28 +0000 (UTC)
Date: Thu, 2 May 2024 08:51:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/11] reftable/dump: support dumping a table's block
 structure
Message-ID: <4d4407d4a468a81f7775595c1ea4c611c1ca2482.1714630191.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1jD0foOURo14JYi/"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--1jD0foOURo14JYi/
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


--1jD0foOURo14JYi/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzOAcACgkQVbJhu7ck
PpRAZg//Rr0bT5/lJcVmd4NH4crOOKPfzwaHYmd5FEbW2dHzc0IM2nLdBGEf2k5P
2xpAGejZYRBz9a7bb4+2kDoOPYCaavSFJKX9ohJxvNcmLIvSv8Z3ND3491KLE55x
VaDPuMTBde5wG4S4n5D9LqWW86g6iYuVvffv1jLpcsYaqPfKBrDTfGeFJsTLDnjO
uv5oBdcpM9A5SUJbgRTGibj4+sAte4Sldd7NOvWxFpiYFsX0Jehy8WG7NGPj0xXF
Ca3cGmEAjrZNAuYFQxPMqo5AmoO1QTFgx3deD3mPeawmZIPVoLrBrUACePahXJq9
FYGqGrgu4ZtK7IjFW3JELVM5HcSHwZ1ABIUS5M4mSMfAwpLp5kKqtrC1pSyROKPy
/XcW2DNYg0cw27mAfh5DEn95fdAhQ0P1kY+2XyCgAKSb83EW4sqGUXfx/uaL80Ca
4w7mS7c9c1B0v334S9pTCFLdiW4WR9/SS4EI7U0Mo0MUitllQgrqHRaEwlKAnT1i
qdUKc9fJvwTmbsm2pumEQJn8LWJYqW4VTZrJi72EOdKub2v5BXf9PEAeyY3wc2O6
wRsY8ZWTk/tgnPCBGd6sAyNJxxB2Lsd9iPFaYsD6BQi21H5QjoJoUiPsFVAw6JKl
C7eT9yqcLlr/5hShOqYDhj4TI/Y32n5Yxj8rPHmW8o7Vt1r/yg0=
=bRN1
-----END PGP SIGNATURE-----

--1jD0foOURo14JYi/--
