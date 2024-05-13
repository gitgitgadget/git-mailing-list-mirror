Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA12146D6B
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588300; cv=none; b=LRXJDV2hM6wLHhxDPHmz/LumoxjQ1RdHACE760Sxr9z6iJuvrEHYeJm3E6u3maLI+QWX+8nz4xzu1SXlJQK10EUs3wDNIFVIbBnlr02a+BH+h7yUF8yXd0zGsOFRlt0RzGLijb1LF11iTC1gTwSSNQdbtzNph7LsZBlx3gginBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588300; c=relaxed/simple;
	bh=SwdWlZ4cniXrgpFHFsqQB0nAjq4V8DiuXKf+7IywUwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oACEAc2G3OPaW8GYGIv5/nA3qpMCJI8+ZHfWCvQYfRZJv3aLWau9NVU5ZUh8NRCgjx6yyLX43qDjz8y6RW9DvFtlXzuXgHJQCQpN2G98Om3MOX44ocN+9whT1gtrPkQTnv/XYyUcUHN6wnkWtlliDBp8nklc6vCQztkYHI11Dno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oxvkJcLh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J490yu15; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oxvkJcLh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J490yu15"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 69D131800101;
	Mon, 13 May 2024 04:18:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 May 2024 04:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588297; x=1715674697; bh=CEa3txDYsJ
	gLgngLd9sP/X9Zc5ykZIyUhZxMDL3tKkw=; b=oxvkJcLhbl0lLFshPwtjnwysRb
	8jQkPRthuZQkIjbtxhPfmPJb2p98Nb35zJCc7NXTEbWzjXWrX3VehlCh5M+NueTv
	04vsJCXj+YCZeEfoVad2Yn9xhSiRoB8f18lhdvL3wZdEk38iDTMdshXxlAGwrRIq
	uYUhbDT9sTwuxTglN0lmbi59mnLx0Y84Q0S/fsgZA3VJFv9ILB77MwzSK/fYecO4
	pHFTAH2MntS/H4rrF7sYsPMgWs7A1zLX5DJWh+uNFNwUB3q9eqo6bbp6dW5gvo7d
	fPw+2Le95PAbgTW3fmXIGxnJ6CCyfQwNrrEJMIqrud1JEpifbRU1iYzAIYSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588297; x=1715674697; bh=CEa3txDYsJgLgngLd9sP/X9Zc5yk
	ZIyUhZxMDL3tKkw=; b=J490yu15ljuCFxzf+afoMVQtGLHCbg4jIM5zNeZuTKkI
	RcD7ozx9hRP5ZdqtWyWAn97RoKtbqYfZQO2GcgaiaejFACCYyezxW4Hp/73ALVr/
	4nsrHg6j9hsS7tGPtLkfPePc6ZcsPQvVtVVcQeMtraXzVSSTJm9o3QP2DJSE/k9L
	RD3sSI9EW2hJUuK4dRwUlQlO1Ir2jXHbIuV+vf0kEAN/TBcyp+cVj62jJ1qNONZm
	qBIH8rJ+Kaa22EXVjj5ZcDeRJAe0GjhIoYyyLmBktJoqd6lv0+5xAWn+39vu5tmu
	ErhtnthNdYaKf0d/c08wsNxMIUzw2To21+gImvjC9w==
X-ME-Sender: <xms:yMxBZpePO9UwgswRTsYvdYCwv5D6UgzfNvFzD5zzbzQEy8jaMA9TUA>
    <xme:yMxBZnPph-Zg9mwhrIHs4pMOyse_4xxKsAFXOgKoiY3Le0OAxsohQWGAEFy2g6SGp
    3Rn-lXk9RXVNR8M8w>
X-ME-Received: <xmr:yMxBZigQACugakJLDaltf-EsYcKa7OFP2KZyiEWXVIQdbHihm9d2xOLshr2d2iDm0Gq14Zz0w0oeZ7tf3Rr4AHsv3K99aiZ8Wppgre4gHTyerzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yMxBZi89Tjf38g2dPALocpx5FprIAUk_z2aSm4CfSfFYixwfnsNuJA>
    <xmx:yMxBZlsL4Dzz7WmXCY5eeK6OQ_grftpKi4LNOCEqQrMMZaQs2Jjycg>
    <xmx:yMxBZhE0Yxh39SJ945-fAV3makwhxFdf3UKEkI3pO-ECIWqqxPYXtg>
    <xmx:yMxBZsMCTrMXfieonZhBkfKuVUXC1wwBUC46Fpitkm7cU9qPRp12vg>
    <xmx:ycxBZvIG5mjrCthnR92f8RqKC-GJiGpHB1EFMqrRV_Ajo_WT8VzBzsVq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 34a544e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:17:57 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 05/11] reftable/dump: support dumping a table's block
 structure
Message-ID: <c4377180ef9c92a28fa71b1cde90d80d901c8710.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UrS5TcTf7c+bkvlO"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--UrS5TcTf7c+bkvlO
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
index 586f3eb288..41abbb8ecf 100644
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
2.45.GIT


--UrS5TcTf7c+bkvlO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzMQACgkQVbJhu7ck
PpS9jw/9FCruAX5XAdE64N+k7ZSX6qDlwN6FlXWaAAbCoExJx5Pc4LljsSXcqbJp
CGSRKcYrXD7q62cifsVOBE09T1IwhhmNI/CnyJp+f2kiGCoLQF8fp+f30B1auEx0
+HyloCawObumiBPg5CqbUMO5PeiYaOTDtaf1/4RmCF4IcakkMD3iGk3qah7KKI78
SrxCyrfxj/rEczaeGUU7owKV0Q8jtcCzQjdwWBxapC9u+LKz2kaV2KJJP5iQ2NCc
OkPadO7bq61uELv7zmXgzClOHVncMFZ02whCYuqWF0JAdR3eiEtZQ2yNIw2K/AOL
e8lPN5Sck7pCyU2i02FlCihQsgfnYdmzLDwImEPYL3cuuq1BOubAHD9CLdh7VlTs
WEtudewYcjRjvOCDFRE00Juhd+HUPUiG466Nfy7MrDY4PSdLdNqCKtRcB64OIG7x
DUK1zL7VI1hS7O6c98nCfoFG+i1x7jd8UnKC1jgEgmiLEpZ3bye/ankrnFEiiXo2
IAyJvdos6SXwa24ArhMIda2WoTD/OEqVsdi7GvSXtBvb2iiT5vJOl/hIjS72jrZM
VDYQ1H60p8HVnqZiDZKq0++KOXeBfqXC6VntDDAO0wje/zmwXEo7om9/7UpATkZr
q6PEt6A20+5qME45+9AOjF9QxNhcfGOmPGEb6hsmMwxeK+p69Zg=
=9a3T
-----END PGP SIGNATURE-----

--UrS5TcTf7c+bkvlO--
