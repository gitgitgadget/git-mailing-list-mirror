Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C71188A74
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361018; cv=none; b=HAXZtqNIJzauxSnY3ugYg3IRE5EICuy2odAbcDBn3YiiJFaWAlDkEu0B/1rsFVJhKDb6oDmWRTqSNDQbzzoMeNL82lY3n+cUOd5KF7TR/r4CtiMNMgheZC0KJii+wXDyg+/vhTAv1LyvWWmh4jXiIWmoAB9+3bmh2mAkmuWon0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361018; c=relaxed/simple;
	bh=87gPnVVFnXN1kD1yeiWaJAJ03Yo1/vMjiRXN8phy1w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N33WQMBDuGSL3f/uDsBV6gdCXIk7INvfc8YDeTrwsA0TkUbGsJz45lnT8mLJ7NsI/+yCpGa+OboAUQJGnsppPfeuEiX5PuCrj/fm6IAHzz7a4eZR608cQlO7tBKreQULRCvviFtQfkDMhWZUnoFKOBBAWgpD+gjvUpN4oIfSPVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mDn7XkP9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kNndxH3Q; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mDn7XkP9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kNndxH3Q"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CA60711400DF;
	Mon, 25 Mar 2024 06:03:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 06:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361015; x=1711447415; bh=RfZSjyCfYm
	h61+5ftsHOhbT46ZZJtn+8Pp4RVBK441o=; b=mDn7XkP9N+yCKBXNRf7UYqyoU1
	xfN73yzKvd2FVKDEZQ6hhYpact+hTOga22dab+d+uyo//lG71yXfi9yqrZ1pMN3L
	vgA/lgDFQ7OOwGj5GAX9+AhSe8LDlWZsSwrmTpnrcYcFiNH8hoR3DvInOczcXIwg
	F9WHwflmbKImqydmVSqu9NTv8dZkH2iHMo6q+4zbUkg6FFRJNceYcDR6dd2YC00X
	+WMLVDeDWpM7toaTAe89zwVQIzXn6qKLohX6cxrqalpm6HImwV7IFM5qacYlt8Pb
	y0j2aLxcyl1QtkyQNMQxpgIEzMbjjKeETNERCUzO1jjRPW7SZJHc1z1oisig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361015; x=1711447415; bh=RfZSjyCfYmh61+5ftsHOhbT46ZZJ
	tn+8Pp4RVBK441o=; b=kNndxH3QYCrd5ZA5ooxMWw4SjVgSNMfleMd6BqseHz3C
	c7O4IfRJb17MUF93VAKUQM4b0zhM0KnpfNAafNNK7W4OyEDYN9VpsU6QImEQE8Uy
	Fnd2tQML/wdKROQJ5NY3dL3+HdWn4sm42+kxNfsGuWo6heYJIyiczJF0KgwBa+gR
	+FFGr0+lStGZbddvbcgOuYym2138E/ZlSEflz1POkRI/a1WKwSPr++e4Zdd7sesP
	qNkuRqK5vpRZO3fMTPgEKEEHy2qsmjjfUpDh33ytJ+jfLuSpR+2FWpfSyLtk2het
	pSwqBs6Uk+xkNTgzwtEA1c0AUy0HTmyFtC+c1r1U8A==
X-ME-Sender: <xms:90sBZubLQ4dhQXxHT6REn2d45DdTqKpLZdBn88XcYx1Ncu655rZ6Kg>
    <xme:90sBZhaRDDU_6jDyuDuzsv5SaaBMGGukX64wDQvYHnz977Dx32MO3faKGgIK1i3f1
    NvmImYzqKFk5NJcZg>
X-ME-Received: <xmr:90sBZo_iW6ztl76iI8V_40J3efLOy_x_EKDKpG6LN2BRSA2wcD3UgcrFv2fdZx8SIl_oO0FeMpz-eK0Q0hnMa3Di78o192GjH7EC7ZNQLt297Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:90sBZgpdYxPodUocy81zdZQFTNqmDAaqsd-O2JYNVUeJm9c-iQc7Ow>
    <xmx:90sBZppdYTT3mNXi3Wlj1C9WA8y58SboQ9QJUSaiGMBeF3lyIsyQSw>
    <xmx:90sBZuTSax6Yq77SK7fUZe_feLkk0xWXOOLMswtjQICwHLjQPxmOKA>
    <xmx:90sBZpo0L2gFD6U_JlLxUP_JIeWxyCLud7f3rBrnTDaFXDB6LJERXg>
    <xmx:90sBZqn89FTn5upnBVGAN5sbUrQNWpkM0j83ShV7llJdfTWuF2S2bw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9d4e16a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:24 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 14/15] builtin/gc: forward git-gc(1)'s `--auto` flag when
 packing refs
Message-ID: <3eaff8289be5032cfd425272f63a6a02ae432eb1.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4CrMgmLFITLZS2ga"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--4CrMgmLFITLZS2ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Forward the `--auto` flag to git-pack-refs(1) when it has been invoked
with this flag itself. This does not change anything for the "files"
backend, which will continue to eagerly pack refs. But it does ensure
that the "reftable" backend only compacts refs as required.

This change does not impact git-maintenance(1) because this command will
in fact never run the pack-refs task when run with `--auto`. This issue
will be addressed in a subsequent commit.

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
2.44.GIT


--4CrMgmLFITLZS2ga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS/MACgkQVbJhu7ck
PpTz7w/5AT/FSuFbS54e+Xk3nwRm5t8Lpcp4Pq570txOw7nHi22lXuzbkmWhraBo
Le4AYeQHNiYLQJ1FDCSMNsWv4Ek7iyxS11u7hs4zkIsxyMIU1/Jfq0U9+9vhhV1a
SEqbr2qkqlTR6K9IqBDAbtFNsC1g9r+ipFSPYET7jC8CQLgR1YpppD7o0UON3+dS
ny7C3eFQTqHxfkp1uLWGg9wVtEvn4JUB3Fx58fgMwmBD7eSG2svupo+kTFXZYJID
nIFcoL2yVnoYaxL/UAEfIudc67etyZcaMlV3pJ4i1qDqF0Ej8iXwxGKF/+08xw1J
/aMgRhpMqMt/FDV/oSU7W+Rkndn3B1eh5lU/7NmE7b9UQlWdr7si+M9DlnUvGED/
adv5ighlpJ/zdjvJpdwlhUFPjYu6LZlzIkKNpITht7LvJ403fI30D8wrJimOFcuX
gJTn/yOj7YMUNmWnmtM1i+wfrwKGwgQuABssmyR8+ijetCfX0mQNgiw2y64U4kew
aCkqV731xbIFlfFam5+BB6ycFjkJzuEXGTo6n1hyTSN4Uj0pTEIgsMT+IrbpCt7V
cd2JEiOti5+430Vt749yds268IfFifNPeqr7abd8g/tWCOiqJKJve0vsuRTKoS9A
Vo6Hgwk6Qn+SrNvKr6CNJTN7rGTUPh3DiIS3q/9Lpu0qiocL6pY=
=ZKjc
-----END PGP SIGNATURE-----

--4CrMgmLFITLZS2ga--
