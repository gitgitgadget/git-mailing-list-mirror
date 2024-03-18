Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE7381A4
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759213; cv=none; b=HlyDazWkPo7QYyPtm1KsuiN94r3SRwVjZJ+UbSXjV0haD/o7nHkaBXkxsMbxMpEiKjRzLw8HPuQFzJMAKA/7y2Z2nkkB/EqlIhM8RqivNy52Ix96Gy33s2SItWENrf1RXc++8o5ExsoOHX9h9Vnb0ekIaiw0QWTG3A+GjLeAAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759213; c=relaxed/simple;
	bh=RfD3CuZo9m8GZ5sv3Qs6bLWRNBROJTzgBan3ptNnD4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqSkkDEOgQdWk0+dFExCd9MQmiIBgO3csGpyrO73eV7KHoNO2A8K/QRmnM73GKuwC/YM5qdnRv+aa87fgzfMdEQVvDd7MR1/jPBOTSR7+WVHcM+4LUB8ByLC6loGCcjek+pFiAJg7FoIzzES+k5Fpf426erGJaEi4geOCMxYBhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jTGWoykM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DjZvvDAp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jTGWoykM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DjZvvDAp"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E63D9114010D;
	Mon, 18 Mar 2024 06:53:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Mar 2024 06:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759210; x=1710845610; bh=mzmFEhmqr3
	JhSpOLKxNt+AwzNPFvcb/vI88tQOD4Hgs=; b=jTGWoykM8uPZaQ3KOUmP0xVIK2
	QgQOJ/0RptTtAc3L2QgCObMMj3CzH8fKv/dZ5RVkie8on1zokXTI/FYCDzd3LUGX
	2GxlQAo1gfNbd9Ct0Odf6cm3qk9ITrONxIonq5sHXVQz1WQg5NNr5nWD6UMNly5I
	Uy4tPio7xpzN2eurQnDV2mxYd8MbhKPSmtIU0zgHaxo8+bB0FTo5c0cHN+9LD3zh
	HQZ7p0vz4EjM2QiNjOHbfm69CfMgC7i3RLavU4in9iB05ql25D3VhZMubvxnyS55
	71AWQlrifglxiXJGkpS5/rQKDTQaXqMF2ZO9nVZaoQ8FqeuM5zRNehXt/qjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759210; x=1710845610; bh=mzmFEhmqr3JhSpOLKxNt+AwzNPFv
	cb/vI88tQOD4Hgs=; b=DjZvvDApL2kDwUXQPUMez/QaokqWbPjhxwZK/FRQ2nZA
	hU3M0jHrxXM5zERkiBKbnkjb8jpUYrmSJ/5VSsCzL78T/+psWvN/6nhGecWBdz29
	BfhZf5HdLxHkLzv8sDJMGzgj2wMKVHg8Jnp9dltlrlJRxb0wQYfZKnbT4bjS4gZk
	AFrZ7OaeR3OqkI/AMP7G0yU651D/tLcdXWaH0V3j4iUgmtoth8BBtl5LNii5TNh8
	jDlybTdXxhNdzRIUb+4rmxiKx2FEPT1CzI0a6qFYvCDHG7Ja3J4gVjMxhMI9RN2d
	GTe/rT1k3m8OE/9txOWWh/wBVEt4sEM7rQktQCiErg==
X-ME-Sender: <xms:Kh34ZZjklgxB8uDaU2JLsmyLBUJeFP2X0F8Z_tvOpR7CIdrKd03IoQ>
    <xme:Kh34ZeAAtsFTpRSQnSIWT_SQRvbOBzMvSrFKyaHDD7t2zt83affScWrxFyxqTIgN2
    eGbvpv2ufZ1Vd1VbA>
X-ME-Received: <xmr:Kh34ZZH3JwUtFSZm5gO8UB7RkA3xNw7Bq7VjvtvL-SvWiNHRtT4F16WzXeakQxkrTjZlX8Ghil8unZKUKIXuw0l_5kGvnj8R9gWWDeTaj1Yobg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Kh34ZeQaAFdWH177UhtO0H4PabjlExgq2m42-Bwy7GeqPkTcnsx7gQ>
    <xmx:Kh34ZWwPqOFu0-fgP36SVzYqMLp5w_tbv6NmUN1Azu_ODTOA7KV3WQ>
    <xmx:Kh34ZU414HKlr4JEstCtpxpLnYs3PFgXFbv2euPCa-tgU8cbkiIYWA>
    <xmx:Kh34ZbxX4JMHoNzvIkHOfSgVwaZBREjdLwJPEUtIRniL2YzhyHSO9A>
    <xmx:Kh34Za-28BvSsH2Tzr8ff2VA3gu_iFCtFyzwxYYb-HeyISwOGKlDMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b9956f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:38 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 14/15] builtin/gc: forward git-gc(1)'s `--auto` flag when
 packing refs
Message-ID: <474cf66b26f5e459dccd60a2dcd1a09eff86178c.1710706119.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hw3ckFuCkg76ThYG"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--hw3ckFuCkg76ThYG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Forward the `--auto` flag to git-pack-refs(1) when it has been invoked
with this flag itself. This does not change anything for the "files"
backend, which will continue to eagerly pack refs. But it does ensure
that the "reftable" backend only compacts refs as required.

This change does not impact git-maintenance(1) as it won't ever end up
executing the pack-refs task when run with `--auto`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c               | 21 ++++++++++++---------
 t/t0610-reftable-basics.sh | 19 ++++++++++++++++---
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e0029c88f9..bf1f2a621a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -212,6 +212,9 @@ static int maintenance_task_pack_refs(MAYBE_UNUSED stru=
ct maintenance_run_opts *
=20
 	cmd.git_cmd =3D 1;
 	strvec_pushl(&cmd.args, "pack-refs", "--all", "--prune", NULL);
+	if (opts->auto_flag)
+		strvec_push(&cmd.args, "--auto");
+
 	return run_command(&cmd);
 }
=20
@@ -572,7 +575,7 @@ static int report_last_gc_error(void)
 	return ret;
 }
=20
-static void gc_before_repack(void)
+static void gc_before_repack(struct maintenance_run_opts *opts)
 {
 	/*
 	 * We may be called twice, as both the pre- and
@@ -583,7 +586,7 @@ static void gc_before_repack(void)
 	if (done++)
 		return;
=20
-	if (pack_refs && maintenance_task_pack_refs(NULL))
+	if (pack_refs && maintenance_task_pack_refs(opts))
 		die(FAILED_RUN, "pack-refs");
=20
 	if (prune_reflogs) {
@@ -599,7 +602,6 @@ static void gc_before_repack(void)
 int cmd_gc(int argc, const char **argv, const char *prefix)
 {
 	int aggressive =3D 0;
-	int auto_gc =3D 0;
 	int quiet =3D 0;
 	int force =3D 0;
 	const char *name;
@@ -608,6 +610,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 	int keep_largest_pack =3D -1;
 	timestamp_t dummy;
 	struct child_process rerere_cmd =3D CHILD_PROCESS_INIT;
+	struct maintenance_run_opts opts =3D {0};
=20
 	struct option builtin_gc_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -618,7 +621,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 		OPT_MAGNITUDE(0, "max-cruft-size", &max_cruft_size,
 			      N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased r=
untime)")),
-		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
+		OPT_BOOL_F(0, "auto", &opts.auto_flag, N_("enable auto-gc mode"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
@@ -663,7 +666,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 	if (quiet)
 		strvec_push(&repack, "-q");
=20
-	if (auto_gc) {
+	if (opts.auto_flag) {
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
@@ -688,7 +691,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
=20
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
-			gc_before_repack(); /* dies on failure */
+			gc_before_repack(&opts); /* dies on failure */
 			delete_tempfile(&pidfile);
=20
 			/*
@@ -713,7 +716,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
=20
 	name =3D lock_repo_for_gc(force, &pid);
 	if (name) {
-		if (auto_gc)
+		if (opts.auto_flag)
 			return 0; /* be quiet on --auto */
 		die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use --force=
 if not)"),
 		    name, (uintmax_t)pid);
@@ -728,7 +731,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 		atexit(process_log_file_at_exit);
 	}
=20
-	gc_before_repack();
+	gc_before_repack(&opts);
=20
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd =3D CHILD_PROCESS_INIT;
@@ -783,7 +786,7 @@ int cmd_gc(int argc, const char **argv, const char *pre=
fix)
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
=20
-	if (auto_gc && too_many_loose_objects())
+	if (opts.auto_flag && too_many_loose_objects())
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
=20
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 6de7529575..b37d8bf3b1 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -387,7 +387,9 @@ test_expect_success 'pack-refs: compaction raises locki=
ng errors' '
 	test_cmp expect err
 '
=20
-test_expect_success 'pack-refs: auto compaction' '
+for command in pack-refs gc
+do
+test_expect_success "$command: auto compaction" '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -395,14 +397,24 @@ test_expect_success 'pack-refs: auto compaction' '
=20
 		test_commit A &&
=20
+		# We need a bit of setup to ensure that git-gc(1) actually
+		# triggers, and that it does not write anything to the refdb.
+		git config gc.auto 1 &&
+		git config gc.autoDetach 0 &&
+		git config gc.reflogExpire never &&
+		git config gc.reflogExpireUnreachable never &&
+		test_oid blob17_1 | git hash-object -w --stdin &&
+
 		# The tables should have been auto-compacted, and thus auto
 		# compaction should not have to do anything.
 		ls -1 .git/reftable >tables-expect &&
 		test_line_count =3D 4 tables-expect &&
-		git pack-refs --auto &&
+		git $command --auto &&
 		ls -1 .git/reftable >tables-actual &&
 		test_cmp tables-expect tables-actual &&
=20
+		test_oid blob17_2 | git hash-object -w --stdin &&
+
 		# Lock all tables write some refs. Auto-compaction will be
 		# unable to compact tables and thus fails gracefully, leaving
 		# the stack in a sub-optimal state.
@@ -416,10 +428,11 @@ test_expect_success 'pack-refs: auto compaction' '
 		rm .git/reftable/*.lock &&
 		test_line_count =3D 5 .git/reftable/tables.list &&
=20
-		git pack-refs --auto &&
+		git $command --auto &&
 		test_line_count =3D 1 .git/reftable/tables.list
 	)
 '
+done
=20
 test_expect_success 'pack-refs: prunes stale tables' '
 	test_when_finished "rm -rf repo" &&
--=20
2.44.0


--hw3ckFuCkg76ThYG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HScACgkQVbJhu7ck
PpTM/w//RerdOfmbactuFkyLEHkggExVY8I/V14pAfbbbiulSZzBZmK2a4O5hr2+
LvWWpKu/DDUm+u4R77jKSkGIRP4UN1RhuqQwa6Mf7ShAjFqB7P1jGGzTpF+XJ907
cQ7SZ5MqHPD+YMoaRRa3VT6UafrwDUPsTcmJrwJboeqn93jpra3fgp4F0EMCP6hR
iVdNQfQ0Weeb3T8lDJs+fapRcL1/gxfhhO67UH+8MDnWY1Vh6BmCg+jm3NLDgFj0
PtBiaWmPh770QhXke70L/Ay7UXbn4Lw7f/adbdS3f91mwURAlE8Sjm3o3HRhhOiU
bB6Wmz/WiHH7+gCZ1IjG/Zp2rUHv4YKI5A9qAxTBR3VWTfuPRO5Ihk/RZpsi9tLa
nl6+DyE9jVTdNC5uDSzv+UXKOy8uhQShE4f7qI+yGHHgPzJmtZKKCHxdxU89UHVv
IPBQy5NYy/MH3kxqDVk2z3dNqzAsO2UxTcgeKe/e/llA6p2OdlqwlgDKi8/1dtrj
E1g0oFxkkaq12onJA9guKYYBeWqc77zKutVG0iAlWe2h9xPy9+2bVcTkIZFAC488
DhhOSF4oALzmUaHumMPdSJOyAY7YKLvkc6E/MnP457eD24P5JdGRsYAK2EMJsTmz
m4hEMIqlDyFnJYxSH+ze35eKvQ/Uzr770RXMEbOI3E8d24y7DmQ=
=aCKZ
-----END PGP SIGNATURE-----

--hw3ckFuCkg76ThYG--
