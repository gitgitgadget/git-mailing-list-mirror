Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B855EE8B
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420013; cv=none; b=VnrCEfP7hLdAg05vrNaBKcLz6f6+cz1arlsUw3WaAevLaT2eBAPa88FpFfudyazmTSAb1NavtHU1c2Ibzuio1WhisXBedH7SFn7hCDbsyBnjLEuFJe6jc3pp4L0DyTIMy2r0/3D3OEkBzB0LSjxA1mRWBuumlIUdCIgQ8/CUSIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420013; c=relaxed/simple;
	bh=f5qhfs8EYx8TvcQVPQI4SWHJkQ90FkKF9J8gCdpe8YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nea31zv7gaiqXF9Ns4oLnqvrOrVTJv1ny38lIvMkOejQSQ1HGNXeKJmYj57MPwOLKQGPmsZ7bY8ogBLQ817/58LOvKSokDKl6Hvugn/shLnpnSlftaFILNXErFLDcsJf9oUOX0XXQAxwIvvedEpee1tngjD3svMhfM1x0tOEVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k4gJxb78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9D0eYVW; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k4gJxb78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9D0eYVW"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9BE671C00096;
	Tue, 20 Feb 2024 04:06:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 20 Feb 2024 04:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708420010; x=1708506410; bh=J+pKgn089x
	Osq03zjCOKqO/bD+74mPT7v03KgMpJ6yM=; b=k4gJxb78zeSflzKIXS8A+aRQup
	Zh8ZtwYKbWF7pGeTBpb0fI9wWOyWSFkBJciwkvDfEf/UWPSx4K0tMx5LNIIafrBZ
	FMVAFegQ2eLw1COdy3haBWepCR+pgisCIewRjwtWevTrVz9kYB3Jkzvvi0rKL1Fs
	tputTYeKy0VsvoGfFdAWDeKqcHMShOXErT2jNtfZQcjIeLjnQ3eb9o7cuag6A0p4
	QO0rCaY8i3DwxKuu/twWzXkx6JyMOOluDPCingucWsUA/HFkOKglmx9UaIu+jpS9
	vHfADfqcB5TcMcczfYHDsY0QzKG5s3sfw+sQ37FT+pglbXfn7OZQ4OWzphwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708420010; x=1708506410; bh=J+pKgn089xOsq03zjCOKqO/bD+74
	mPT7v03KgMpJ6yM=; b=l9D0eYVWzwWFum/ZNZNIXlBMmAgqpnjmCrQ4HMVptDGq
	X51aqGcL43XZit9VDWbSthL5BWfqoEeSQB1SjkI6gLVtcoRIcOb62udMrushO9hP
	y+9l1AXscl1NGKpJgz1wGgeS4cdRoPylp0BMGd6RO3wRWSfGQZlrFri20pLnrBLY
	c0TujQNcRtsdFoQMxugU+6Clv6rJErkizLQr7Zz3prXP3/jmhAjUlBaqhiTMNwQO
	1rYAC7jx7Ma42FOaB9E/9umSaVGrPQfIM7Z67TvTd/Cg5DAPjRB7dXKtYoXWuWzO
	4W5hhkU9o2gNVBW4nDG5St6+k93Zjz55KJoaHPBg6A==
X-ME-Sender: <xms:qWvUZZBHh5V2CwY9TFxO0ZFlf8DRdEXyY-Zwf83tmp1HBZIZSVjyrQ>
    <xme:qWvUZXj0mlXRiAK4G1_pUB5CC8LHFu3IUAl4W5gsah_dZJYdsEmGgmEeUAnq42vt1
    u3SfAwZNqT46KbRoA>
X-ME-Received: <xmr:qWvUZUk_nhBgPzaCezguRuZPZT6bAc7wvOhm6LKmsV1rJCiBKd6aCJ5wZgckVcIaLqXFTmafxQP0z9UqxgXUeFtQDW3o0qbAOfPCnnmDOEkY0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:qmvUZTz0ayqgiY47QH2QJoPkpU0JfDNbPwSvGRtDs0VQCZVv-6xQzA>
    <xmx:qmvUZeSp-Hh2sqjO0Yg2iGM4e8TGXzgZGtW1DycGFGldt7JHxLxhnw>
    <xmx:qmvUZWbKmcHDZOkPR2KWx7dxl00IE9TfVK7dYVi0Z1d4dZIjvoHMEA>
    <xmx:qmvUZZePUfAvqnsnN99-lvjFpZokXoS_GxzftBOKGHkKOyz8ZjihlKomEdw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d0f04304 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:47 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/7] builtin/reflog: introduce subcommand to list reflogs
Message-ID: <d7b9cff4c360147e65df17316533fba0b4f2ab7d.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DGn8F9OaD0vZGign"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--DGn8F9OaD0vZGign
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While the git-reflog(1) command has subcommands to show reflog entries
or check for reflog existence, it does not have any subcommands that
would allow the user to enumerate all existing reflogs. This makes it
quite hard to discover which reflogs a repository has. While this can
be worked around with the "files" backend by enumerating files in the
".git/logs" directory, users of the "reftable" backend don't enjoy such
a luxury.

Introduce a new subcommand `git reflog list` that lists all reflogs the
repository knows of to fill this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-reflog.txt |  3 ++
 builtin/reflog.c             | 34 ++++++++++++++++++
 t/t1410-reflog.sh            | 69 ++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index ec64cbff4c..a929c52982 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git reflog' [show] [<log-options>] [<ref>]
+'git reflog list'
 'git reflog expire' [--expire=3D<time>] [--expire-unreachable=3D<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
@@ -39,6 +40,8 @@ actions, and in addition the `HEAD` reflog records branch=
 switching.
 `git reflog show` is an alias for `git log -g --abbrev-commit
 --pretty=3Doneline`; see linkgit:git-log[1] for more information.
=20
+The "list" subcommand lists all refs which have a corresponding reflog.
+
 The "expire" subcommand prunes older reflog entries. Entries older
 than `expire` time, or entries older than `expire-unreachable` time
 and not reachable from the current tip, are removed from the reflog.
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3a0c4d4322..63cd4d8b29 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -7,11 +7,15 @@
 #include "wildmatch.h"
 #include "worktree.h"
 #include "reflog.h"
+#include "refs.h"
 #include "parse-options.h"
=20
 #define BUILTIN_REFLOG_SHOW_USAGE \
 	N_("git reflog [show] [<log-options>] [<ref>]")
=20
+#define BUILTIN_REFLOG_LIST_USAGE \
+	N_("git reflog list")
+
 #define BUILTIN_REFLOG_EXPIRE_USAGE \
 	N_("git reflog expire [--expire=3D<time>] [--expire-unreachable=3D<time>]=
\n" \
 	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
@@ -29,6 +33,11 @@ static const char *const reflog_show_usage[] =3D {
 	NULL,
 };
=20
+static const char *const reflog_list_usage[] =3D {
+	BUILTIN_REFLOG_LIST_USAGE,
+	NULL,
+};
+
 static const char *const reflog_expire_usage[] =3D {
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	NULL
@@ -46,6 +55,7 @@ static const char *const reflog_exists_usage[] =3D {
=20
 static const char *const reflog_usage[] =3D {
 	BUILTIN_REFLOG_SHOW_USAGE,
+	BUILTIN_REFLOG_LIST_USAGE,
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
 	BUILTIN_REFLOG_EXISTS_USAGE,
@@ -238,6 +248,29 @@ static int cmd_reflog_show(int argc, const char **argv=
, const char *prefix)
 	return cmd_log_reflog(argc, argv, prefix);
 }
=20
+static int show_reflog(const char *refname, void *cb_data UNUSED)
+{
+	printf("%s\n", refname);
+	return 0;
+}
+
+static int cmd_reflog_list(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] =3D {
+		OPT_END()
+	};
+	struct ref_store *ref_store;
+
+	argc =3D parse_options(argc, argv, prefix, options, reflog_list_usage, 0);
+	if (argc)
+		return error(_("%s does not accept arguments: '%s'"),
+			     "list", argv[0]);
+
+	ref_store =3D get_main_ref_store(the_repository);
+
+	return refs_for_each_reflog(ref_store, show_reflog, NULL);
+}
+
 static int cmd_reflog_expire(int argc, const char **argv, const char *pref=
ix)
 {
 	struct cmd_reflog_expire_cb cmd =3D { 0 };
@@ -417,6 +450,7 @@ int cmd_reflog(int argc, const char **argv, const char =
*prefix)
 	parse_opt_subcommand_fn *fn =3D NULL;
 	struct option options[] =3D {
 		OPT_SUBCOMMAND("show", &fn, cmd_reflog_show),
+		OPT_SUBCOMMAND("list", &fn, cmd_reflog_list),
 		OPT_SUBCOMMAND("expire", &fn, cmd_reflog_expire),
 		OPT_SUBCOMMAND("delete", &fn, cmd_reflog_delete),
 		OPT_SUBCOMMAND("exists", &fn, cmd_reflog_exists),
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index d2f5f42e67..6d8d5a253d 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -436,4 +436,73 @@ test_expect_success 'empty reflog' '
 	test_must_be_empty err
 '
=20
+test_expect_success 'list reflogs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git reflog list >actual &&
+		test_must_be_empty actual &&
+
+		test_commit A &&
+		cat >expect <<-EOF &&
+		HEAD
+		refs/heads/main
+		EOF
+		git reflog list >actual &&
+		test_cmp expect actual &&
+
+		git branch b &&
+		cat >expect <<-EOF &&
+		HEAD
+		refs/heads/b
+		refs/heads/main
+		EOF
+		git reflog list >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'reflog list returns error with additional args' '
+	cat >expect <<-EOF &&
+	error: list does not accept arguments: ${SQ}bogus${SQ}
+	EOF
+	test_must_fail git reflog list bogus 2>err &&
+	test_cmp expect err
+'
+
+test_expect_success 'reflog for symref with unborn target can be listed' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		git symbolic-ref HEAD refs/heads/unborn &&
+		cat >expect <<-EOF &&
+		HEAD
+		refs/heads/main
+		EOF
+		git reflog list >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'reflog with invalid object ID can be listed' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit A &&
+		test-tool ref-store main update-ref msg refs/heads/missing \
+			$(test_oid deadbeef) "$ZERO_OID" REF_SKIP_OID_VERIFICATION &&
+		cat >expect <<-EOF &&
+		HEAD
+		refs/heads/main
+		refs/heads/missing
+		EOF
+		git reflog list >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
--=20
2.44.0-rc1


--DGn8F9OaD0vZGign
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa6YACgkQVbJhu7ck
PpSXIxAAo1EHVh7VlCGMZhRc5FOFNRCOjg2VrSIOwUUJGI+2HGNmlvzoAGCX7iCG
yVXeK5DfV1c4NXRcrK9IgN7qDcYri4c5HDN8SJ/XlHTB1/OKx7FfEnncgoHSFGqb
pJIFGnkyHcPAMPeH8fcqM8pD2PJnbR2tc/10vZLWbODe0MFJcn9VV3AvsfkU2JhA
ZKDuFL4vgnb9apI/JdTb+Dso+CZTuWT2mYW0iUcu4sRjloIhfz378KglhrErd2Kr
d+A+YHZWd6NyQAStLyRS0EsNQIJdHFaB9fIf9uMznDbflDkzk0lQbp2OnWicLNRX
Jgh/WwUyvd3Nh/gJ0zVCmxPlMcKlSNs/PRbl22qkIXFKc0QsD5jvOialtqNlvjES
luxkxOCGz2t+mt7SZBIgkWv9GIaHuqcvegMwphz1X2XQsK/9kjxsod08e3T25qib
ZKfI37AHW6r31UDx901rNgqE9+4b7qop3CsGMWFKWM798VIHqeO7stAyZzu8WikW
wr+8pMkekTYaao7Df1U+wfWkhtsAwAAGvcsZDV3WjJ2H24eBUF9oBorRRG0KqyDQ
U4ZYFQfCQRobhqfdXGOFKK/+ihF0uFrhWkJnlvb7CmqCpDCpd71LwQlw9L5kF+2g
fHWc35LMPHZSSy2RAPtQGKLIFB+LisfzxCQaC859zg39SJ3gWyg=
=auEj
-----END PGP SIGNATURE-----

--DGn8F9OaD0vZGign--
