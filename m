Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF6A6931A
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519073; cv=none; b=Ipt+iBDyYKbcmzxz1NmpY86lrcLetF0Ek7oWcgYGz5Oo0YmBwB3buHk1tmtR9VGBkNoB3hiN9BBMiWxLx2emjbzFLTR/Kz4reoOWddNMK2mGdnZ10ugAQ6Z0WQEGHPGrTksr9OjXE/vY7PxCjEhW0BasDbESC9vsbzOFXB8URNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519073; c=relaxed/simple;
	bh=HEu3JnakTwIoYlGxU7AtF8IHBfPHFpWYEgX/Q75ulT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8LrZnC2+b3OqgipnK8+mu/CvAXDakFKIUuXELyzvWsQnuquNtxAzA/NcC5Xccl/SkcI0yJaZSLtyr4a39XtkO7XhoucWUUQic3Kn8mkkWRsVBL2iIsb7zgrnXz6L28Y2K80LQfn7anmISHYPNAK1cf93owPAOegeSzG18ue31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UScGeULG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PjAsYayu; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UScGeULG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PjAsYayu"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C6B5D18000C9;
	Wed, 21 Feb 2024 07:37:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 07:37:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519070; x=1708605470; bh=GD1apZ8BXy
	HhF1+gX5drklkCu1x1jt/hczpWnZYYcjI=; b=UScGeULG4i+Sz6CuT9L5roM/yn
	LZuMtSUSg69+SGDgcS6hh5XD4lYyUha0iYzClfI92/MQb+ZVAWOucGcRsXrBxy3W
	umAAzXR6AEEqpTIuW6R3r2zPWTMUURszFK3liLW4mA2/hJbRtFIrBXqz2hXzFPfJ
	JMaRQY68481em/xa45rLe7zlIudu1lv0Ch1V5PbEDdQay9fyYhEhTL3G1rRG8KOr
	NJ9HalUJAGLvgzMSkHzDR4PstSgrDLTZ7DtMrdoiHUujCkvyH0MtCuefiCz9BAGu
	havinTylFWRgbZveKuQxROtKqpRcvHPUwFta+fOXvkpCRJP54b19kwC1hSYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519070; x=1708605470; bh=GD1apZ8BXyHhF1+gX5drklkCu1x1
	jt/hczpWnZYYcjI=; b=PjAsYayuWLFrOA64FWa8uJ8GfrpghpxgTv+0MBTLW9b7
	i5KmfiA84Ozpz0EMwviozRgO8al5Id+4F+EU38KPrJgqfRJS94+gkibkowEkIu8o
	obsd/7ARWy6e8lGK4aygfgQQ913xNYHl4irzGBCfJmI8Lkeb1dwoePQ2hDM16TL6
	G3y5X1vqmXdS2iUO9Qvb4FWQeE5jNvbV7R9YdcJhuAWP6i0PVwhoAoRiBoFW4S2k
	7FwR8HHb6FAZJQP3hNoCJbSWO/jwkS00v2j3XOkuAfG/L+XYsUsuw4dv3o5Qzlof
	RlDzPQ7sz1W3JnQ1l/0Mmy5dFnZB3NVdy/I9sD2jWA==
X-ME-Sender: <xms:nu7VZRV7ccAFRX-b1PU2FzxqpNTSJkDIigU4JNo3wPV6t3rAw1Bbaw>
    <xme:nu7VZRliONrLP9ZD5TU9EjWeznYvvY2VdpqMEUMK6vuV8OB5qCzVhkxT-nTG3ZhBl
    WchOKAKDTYj2pjb3g>
X-ME-Received: <xmr:nu7VZdaSkKbMzvrYKvqEWCe6S-ObR1bNpfzXbzAeyPo81FwEDp4Pwh8YeOgqJUnwTgxokHR4drG4mrLKo9nLLdZK94E3ptXcedPOmcSIqCN_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nu7VZUU1pgWg1P-jhgOhVKb7t6h_-1_BNVsnAyw2ZBC43RyW3ZwhbQ>
    <xmx:nu7VZblwgOlNFo08TzF6W8MFbmYXaytmcxAZJkDpiZ7eN0yYBV_gwA>
    <xmx:nu7VZRfRaKr4_jlwtceTblLPPO9dZLZYQuZvNw_itcUFKTC67iRkTA>
    <xmx:nu7VZQx8Gc7JE8emUyHXdB4QtQnMi8mzrKx0tns5EYfwWw4OVCJTQxDUmFU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 69681630 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:44 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/8] builtin/reflog: introduce subcommand to list reflogs
Message-ID: <f3f50f37429e39e07bcbbeeaf90d2aa18e279f5d.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kt/qvouYlH6vvdrD"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--Kt/qvouYlH6vvdrD
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
 Documentation/git-reflog.txt |   3 +
 builtin/reflog.c             |  34 +++++++++++
 t/t1410-reflog.sh            | 108 +++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

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
index d2f5f42e67..5bf883f1e3 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -436,4 +436,112 @@ test_expect_success 'empty reflog' '
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
+test_expect_success 'list reflogs with worktree' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		git worktree add wt &&
+		git -c core.logAllRefUpdates=3Dalways \
+			update-ref refs/worktree/main HEAD &&
+		git -c core.logAllRefUpdates=3Dalways \
+			update-ref refs/worktree/per-worktree HEAD &&
+		git -c core.logAllRefUpdates=3Dalways -C wt \
+			update-ref refs/worktree/per-worktree HEAD &&
+		git -c core.logAllRefUpdates=3Dalways -C wt \
+			update-ref refs/worktree/worktree HEAD &&
+
+		cat >expect <<-EOF &&
+		HEAD
+		refs/heads/main
+		refs/heads/wt
+		refs/worktree/main
+		refs/worktree/per-worktree
+		EOF
+		git reflog list >actual &&
+		test_cmp expect actual &&
+
+		cat >expect <<-EOF &&
+		HEAD
+		refs/heads/main
+		refs/heads/wt
+		refs/worktree/per-worktree
+		refs/worktree/worktree
+		EOF
+		git -C wt reflog list >actual &&
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


--Kt/qvouYlH6vvdrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7poACgkQVbJhu7ck
PpTxew//ZDYuQk5Igdx4nOXz+G8+Jth0GvY+lI5T93z1goABkharAeXh55sXMJzJ
zbmCQalL3wkbXZ4U4egzom6wkso+bRzVdJEJgrg9D68vJqPqnQAtEN6piVcTa31D
MRGvkFFgNkqSWr69YsEaMYE6QJ8sEpiyEf8qH6Zn+3MlND+qOJ5RACwkod5qyT7G
XH04LfUM5ucICJGVnafuJwGQ0F9sdmhYjjaXIpRVjt5eFKf6qAEHu6yKzMKNsHvN
zf5yGsUD7PzMF4vV/rwkVJfmY1Xd2cRv/1gByCTjghF8PIu3ALx/Tu7Hi+pln9B+
jJEnoCp3TTM/KdKPOnHxP3l5bclU4CrnroqiAzHegndtiYChY1MT3n5c8PVA30/J
44yAwGi0HPHVdatLeD+70omnPsH00250im4F09P7qJfIB21fiLf4+AuUxlHPYG0W
vHhhzoREWsAwoCwWxxbB9xFgAY6emca13oD9/BVGDN8p22XNj/IioXilK/ecxiBi
o+CGVI6WTSVc9zs3Y5kTMrY0J2/699mDyxyuXbThFruVx+gisY4/G/e6J5dyfmuA
KjGYXKSdMjg9CTVcfo84OvAEnPuSGCL1vmAXoD2BHO/6vnqrF+AeEKNrB4am0zXh
FbYHv0apyYcFZplJl5j+ZICbUz42J1a1UJZDJ3AdkKgtOSSQtiE=
=Ge05
-----END PGP SIGNATURE-----

--Kt/qvouYlH6vvdrD--
