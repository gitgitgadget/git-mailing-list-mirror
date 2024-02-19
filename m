Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F330381C4
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353345; cv=none; b=IS+9s/Ue1RZY+UCE46b22qdLSxmq9pWArkpfHB5YvNKw5mE932VW8g6ZqMYH5GFKzjxiVSVFbkh1K5SFh5g6Y7Rm1MA5Yaee1vMvxUUFyfvoTmvkc6YRorezfeef2CCmkZlJE7Bw4nNmQ6ePmNRxUVxExHuBYBXZCtMwPaVfeYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353345; c=relaxed/simple;
	bh=p9eLD1HclpFDsFKQxNXatqzXu5haaqKrA2YMk1ChIus=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLHyZNfJ+jb9Oha5VtxllZDAY9Xr642jnpMxZ9wLHxRqrcE7AvY5ft3+8G+cT5Ica6D902sD8AbhFgI7imsBA8EQYH+ZoBgQrtGwWSvGvr+SoRVhcGxaUU5AqSMBmfGRXA8EJM+KerZZtr6/Jzhl0a5KFduk6ctkwLTLo7HfddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Eb/mfYb/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keB9Ldmi; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Eb/mfYb/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keB9Ldmi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2BC9F11400D7
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 19 Feb 2024 09:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708353343; x=1708439743; bh=segsBc6Mw5
	ZHwo2eIOfTAdXkpeQ/xRY4CPHDshzH2hw=; b=Eb/mfYb/Ry//7hwc39JL8I6QWC
	UTW7ep6Da6wI+r30k03WFgRqDxnAelZqBhZuhBKDEolq4js4XJMXbPOixyw9DMQ7
	3n5Fr6Q3VO0V+kysH53l9lfftWwNw8QJKfnMrJ6UG1Fe6S9udVfyvvmojRsnoKOT
	JvhFcBbRHWdwrm1586kufaADtmnDMS3rYY7/LNJsNkrJ+psdRg10NdFzvnvTTiuz
	239N7WUObjpo5Vn6GSKF5P3mMoUxM64qg9cSJtSmlrDAzr9rJmDBAelxiKUqocE4
	B0mrbbzjmonbIKyrOnstgs/lBxV8urUvX+Bumuzx40h5I+vQRkmgmTIS4/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708353343; x=1708439743; bh=segsBc6Mw5ZHwo2eIOfTAdXkpeQ/
	xRY4CPHDshzH2hw=; b=keB9Ldmip4+IMoJhqjza+pQ+fafFnDbIRHvIxWIbHW8R
	V09AE8WonPVmZSux3d6MpGXqNmn3C3TvHKwf2VxUysDl7kuxY7sVbekI2iE3p5Fa
	TDjb+aQ+pqB8CLhp9ce2FbF/oOGNVu6bYtT/he75tGhMrMoY5a4WE2fZ7X+T9mln
	8c7IN1zGhDfbv6Ai4FMZ5YoJWg41TWhKmaYiGPWYJwmEAQa6R63xorB5MSBxtg1E
	vtj1C8g6NqIioqzUw3SzcGrAxjKVetpNR8l2jcdhm6WeTOugMRee4LszOi/qqTzo
	O3Lg5JLU4LCNCOUqadBix4OJIX38mUz1C0Gk5ibPuw==
X-ME-Sender: <xms:PmfTZdKRUJiblLgr9MN6A0Nx5aUYb3MAZQK4mfT_a1uk2PvMpIEc7g>
    <xme:PmfTZZLe3g7YtmfEiIwHybfFsS4sOu0fJkJ1yW9NpvhacX1rxJDgKhxFvQTdXWx6n
    Wx7W5yD_JBFJ3EWfA>
X-ME-Received: <xmr:PmfTZVtI1FLXhBvzWN9d97pmJf8DNBacAhVDg6Hfvg6CXkBIY9fCKEVIxmngy3GqSCvvbBx82zhA4uKPTiwXoCCS3ICXDK0ORdXbjfnU0AMMG6uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:P2fTZeb8K-BjdOIULn7w8HNWgy5PI4vZfw0Y2HY2pFnwEZAwtagdYg>
    <xmx:P2fTZUYWPcwqFmklwoqTiCEEjy0DGpHMJ79xTpABJd6_6SBu6merHg>
    <xmx:P2fTZSD8c5UMR2Kjdja3O-BaZS2AhwN8iBi90nRdQMGgXJsRHEjLlw>
    <xmx:P2fTZfx-U7oQSDrgGsl_Z-kG3hLEoKpzPd2t3xUegwpc8y99LdOchQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:42 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 78eae9a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:42 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/6] builtin/reflog: introduce subcommand to list reflogs
Message-ID: <cddb2de9394a07e405682e9ccdfdf5de92bb9092.1708353264.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SR1iqY/gf7/39r02"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--SR1iqY/gf7/39r02
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


--SR1iqY/gf7/39r02
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZzsACgkQVbJhu7ck
PpQKChAAroVrz3kB5MDw3YK2h4TFzbTkyRnMBS3URWUYSECsM7Bc18id9FxbXbWA
IBxyZXrc04ut9vkOmljRzaqdMccF/xJtUyKBuEQuSTE1ftR0OLsvhuyhPxid1rcb
vNt8KXaZDInkCuCtN/6pJ9GcdFwgXcgOqbEIW1WatITFJE0DmIXqnxRy3gjp3P2y
NxZhdGyKc55HjWCBldRWb/Ixl/xNbgQRRvPJHU0G3qeuFgJwJdX9bSYucbz4bB6C
zD44Z5yGM2dQ/9huqL2mwYV4zceCJw4FISJWWvXxvqL57Lfp6zPKdOfPVJZe6HYn
erLo+nZwXkm2IoJwzN6RcxA2GQt2lZRSIbhz9HTCA78y2QKTslyFK2jLrH53wyLn
V2tOWxW8IXMV0PDVI1/O7dSV2Nh7E0haMDrZpIUbefpDmm7Zn+rzAGGjLFJWYh+Q
HX62qy/k9dJWs4RNNwvjtOMNqeYwDbydn/zKdJDiS9m7xSnD7etl0pcMFyewfhFH
8oGM5MXNztFGVOkDxxQHPVAogZNoaT6Uqipy3C4BJ2W+EPKVGYh1vF9YrptrO9Qf
WDOdJpjbLzvuB9EVddcnOsiJalq4VDSe2XlDYfZaAWKUt5zpEf9AOE7Ib7KMuXQP
1tFth9CoAOVbP20ItYGYfMWdxNXB6W/Jv/pkAB1sRm0gy0bQr7M=
=Yh21
-----END PGP SIGNATURE-----

--SR1iqY/gf7/39r02--
