Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4484047
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408062; cv=none; b=RpmF29VSTYckLW367rOOVP6pmHE5oE4DnBk35aE9CXkKDu11XnmczoYqdWKO/rZzU090r6QZkP+cdCu3/awWkQoHYct+cxej6/uxREuBeVtaMe0i1oB+dRFcE2eNIWJMcl8beGXMa8uJU83jaxmA4Vz3PcnhEcpzXG3ANSV59zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408062; c=relaxed/simple;
	bh=idlPxYngxxp4PPv6wa5KeCbaDB0FanjlqLHjX3MgXjM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPH3q9eFRAJtXrVDtAsPDLTkjcKfqMfTNnBF4jzwpnAoq3RurJdXsjczCQ8AfqNmr2gydB7qcpZShtsL2KNslwWmlC1yjDFO0MRUtRkXd+Hr0B3qaMVXmgsA4vOdAwUOw9a5pPOMHCwOmeiCnvbDR5WK6Mu648VAhfu593tztSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XpwktjpU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pbIR0049; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XpwktjpU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbIR0049"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id EC41A1C000F5
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408059; x=1717494459; bh=3sw7865YZF
	US+0nZHnIGkFNC8bksI174TFtWiULzFOU=; b=XpwktjpUQQEtprs1oxl0hmEzyE
	bcKQu4GW2WzUHj+bHuUn3cvEmPrp+ZUhc4v/kHS8JzJiFVYk30ao9LPkuUPnE0Po
	KueGYosFQuftXMQTgBdepbStwDJuZcwhih+Ft4GEvCpWhRHO6ql2knX7AFNBwsZ0
	0rqK2Q1zHX6sMnb34Td91kwu5lxwTl1NN33G5+j7+3sYWQ7Dsg/ZT9q3bYKZcpbW
	srwn0SbD6J5xzREiBDCWX1dUD/lUpqP77gpRv9041kv99JPuXW4k0fSyNuvnA58f
	f0qt1RzfXcsY+kAuVeMhplPIsxJ1p7ThQB4OQqhuPigST7/pJz2VnSoFOTqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408059; x=1717494459; bh=3sw7865YZFUS+0nZHnIGkFNC8bks
	I174TFtWiULzFOU=; b=pbIR0049FvfRYF2zawWGULQ3WQj5SmW3upI65mHOd/O0
	iP+sDqunrH0s4/+GDrzOC8Wx4c0UVYkpHzfAqsakDfjMUsjl0rxu/P7zMNHGIVif
	qBX6Lv/1Cphm70ofF7ScZ4Ho2hYnxTJFItgHaGoEuJBICCaKE+x5Q+vRnDMZ0HDL
	Za4Kzm/01nrtqq3if+xU+0dfLKRJbCJuHv63sEWK/OBigo9PpFXvcrixdX344qz0
	VnxLzcei63iGo2PM+z1G9edxPXDW3Ng0QH3RRCsGHeOLIBYAbAzMshN14gIboZ/Y
	cMK3eSUs/SDweywVczwtaeNBqf7+Det/wXPHIPr6rw==
X-ME-Sender: <xms:O5FdZn66LI3URJUz-E3nRzVVAoNXrL5ZGsmY0orxUG_YPqCAGVBVXg>
    <xme:O5FdZs63tsPPW7bYt7xieukckEFl38FsrTPA6lJIaBboguuCkqtaXIMDpIoILwgmS
    fUbcduvZKcu7kI2RA>
X-ME-Received: <xmr:O5FdZueuN4ttpPzXSwrtEW13ZB4dOmviojU3tMLBEC3fz3fgF1C1E0KAXIW6Q5OY5nbqyRr1xA2X8xWk3XwQRxiYwNZQo5pidZWeZ8fgrhRBBDok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepieeihfetudekhfeiueekjeeuiedvkeduhf
    efleehvdefteegtdefvefguedtteefnecuffhomhgrihhnpeguihhffhhophhtrdhnohen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:O5FdZoJusCFZNYEvcaIIK3Zn7qn3iNvabfDJUoBT4bdSduSBjBV63g>
    <xmx:O5FdZrKdg7N8D7a1cwMF7xEc-Qg8o2lB1YJCNy-NcYpHycX5iCiaHA>
    <xmx:O5FdZhyttusFz_d-5kn3sOFXRptw5kkFCcbuN4ZJfTVyysw-8vK8_g>
    <xmx:O5FdZnJuvMwGsJLAaWjA5Yo-KwWMdX07Q53c7dVuZ5H4wOL7-YSwxQ>
    <xmx:O5FdZhgIgr4xnMqlxggRlh_-7nM5jEC6rrLf4zd82U_owSheAcdoxLUx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2bac1e70 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:14 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/29] revision: free diff options
Message-ID: <a754800fd1b7bd753b0d6fdfdd5f7a5cf17ceb98.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a1pRqLOruZNPVvpY"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--a1pRqLOruZNPVvpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is a todo comment in `release_revisions()` that mentions that we
need to free the diff options, which was added via 54c8a7c379 (revisions
API: add a TODO for diff_free(&revs->diffopt), 2022-04-14). Releasing
the diff options wasn't quite feasible at that time because some call
sites rely on its contents to remain even after the revisions have been
released.

In fact, there really only are a couple of callsites that misbehave
here:

  - `cmd_shortlog()` releases the revisions, but continues to access its
    file pointer.

  - `do_diff_cache()` creates a shallow copy of `struct diff_options`,
    but does not set the `no_free` member. Consequently, we end up
    releasing resources of the caller-provided diff options.

  - `diff_free()` and friends do not play nice when being called
    multiple times as they don't unset data structures that they have
    just released.

Fix all of those cases and enable the call to `diff_free()`, which plugs
a bunch of memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c                        | 5 +----
 diff-lib.c                                | 2 ++
 diff.c                                    | 8 ++++++--
 revision.c                                | 2 +-
 t/t4208-log-magic-pathspec.sh             | 1 +
 t/t6000-rev-list-misc.sh                  | 1 +
 t/t6001-rev-list-graft.sh                 | 1 +
 t/t6013-rev-list-reverse-parents.sh       | 1 +
 t/t6017-rev-list-stdin.sh                 | 1 +
 t/t9500-gitweb-standalone-no-errors.sh    | 1 +
 t/t9502-gitweb-standalone-parse-output.sh | 1 +
 11 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index d4daf31e22..5bde7c68c2 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -460,11 +460,8 @@ int cmd_shortlog(int argc, const char **argv, const ch=
ar *prefix)
 	else
 		get_from_rev(&rev, &log);
=20
-	release_revisions(&rev);
-
 	shortlog_output(&log);
-	if (log.file !=3D stdout)
-		fclose(log.file);
+	release_revisions(&rev);
 	return 0;
 }
=20
diff --git a/diff-lib.c b/diff-lib.c
index 5a5a50c5a1..1cbf03bf39 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -662,9 +662,11 @@ int do_diff_cache(const struct object_id *tree_oid, st=
ruct diff_options *opt)
 	repo_init_revisions(opt->repo, &revs, NULL);
 	copy_pathspec(&revs.prune_data, &opt->pathspec);
 	revs.diffopt =3D *opt;
+	revs.diffopt.no_free =3D 1;
=20
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
+
 	release_revisions(&revs);
 	return 0;
 }
diff --git a/diff.c b/diff.c
index e70301df76..53e2f5a42e 100644
--- a/diff.c
+++ b/diff.c
@@ -6649,8 +6649,10 @@ static void diff_flush_patch_all_file_pairs(struct d=
iff_options *o)
=20
 static void diff_free_file(struct diff_options *options)
 {
-	if (options->close_file)
+	if (options->close_file && options->file) {
 		fclose(options->file);
+		options->file =3D NULL;
+	}
 }
=20
 static void diff_free_ignore_regex(struct diff_options *options)
@@ -6661,7 +6663,9 @@ static void diff_free_ignore_regex(struct diff_option=
s *options)
 		regfree(options->ignore_regex[i]);
 		free(options->ignore_regex[i]);
 	}
-	free(options->ignore_regex);
+
+	FREE_AND_NULL(options->ignore_regex);
+	options->ignore_regex_nr =3D 0;
 }
=20
 void diff_free(struct diff_options *options)
diff --git a/revision.c b/revision.c
index 82c0aadb42..99c75c939d 100644
--- a/revision.c
+++ b/revision.c
@@ -3191,7 +3191,7 @@ void release_revisions(struct rev_info *revs)
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 	graph_clear(revs->graph);
-	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
+	diff_free(&revs->diffopt);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
 	release_revisions_topo_walk_info(revs->topo_walk_info);
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 806b2809d4..2a46eb6bed 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -5,6 +5,7 @@ test_description=3D'magic pathspec tests using git-log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 6289a2e8b0..f6d17ee902 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -5,6 +5,7 @@ test_description=3D'miscellaneous rev-list tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t6001-rev-list-graft.sh b/t/t6001-rev-list-graft.sh
index 73a2465aa0..3553bbbfe7 100755
--- a/t/t6001-rev-list-graft.sh
+++ b/t/t6001-rev-list-graft.sh
@@ -5,6 +5,7 @@ test_description=3D'Revision traversal vs grafts and path l=
imiter'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse=
-parents.sh
index 39793cbbd6..4128269c1d 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -5,6 +5,7 @@ test_description=3D'--reverse combines with --parents'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
=20
diff --git a/t/t6017-rev-list-stdin.sh b/t/t6017-rev-list-stdin.sh
index 4821b90e74..a0a40fe55c 100755
--- a/t/t6017-rev-list-stdin.sh
+++ b/t/t6017-rev-list-stdin.sh
@@ -8,6 +8,7 @@ test_description=3D'log family learns --stdin'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 check () {
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standa=
lone-no-errors.sh
index 7679780fb8..ccfa415384 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -13,6 +13,7 @@ or warnings to log.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-gitweb.sh
=20
 # ----------------------------------------------------------------------
diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-sta=
ndalone-parse-output.sh
index 81d5625557..b41ea19331 100755
--- a/t/t9502-gitweb-standalone-parse-output.sh
+++ b/t/t9502-gitweb-standalone-parse-output.sh
@@ -13,6 +13,7 @@ in the HTTP header or the actual script output.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-gitweb.sh
=20
 # ----------------------------------------------------------------------
--=20
2.45.1.410.g58bac47f8e.dirty


--a1pRqLOruZNPVvpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkTcACgkQVbJhu7ck
PpQGlA//bGfysTOD/nkC5CMD0IN58gG6/QQsRfuDp7wkjaeQhrdW8VoR9hAzBhoe
ZWtqNvpMtXIRPRe8/LCzmqcuV2/qjHFq+FalkO1j9qWEHPSYzAEP4Na1Fty6dk2y
xBFk4Tahbrz1Z1sVk7hZOv51noScjDVMC8GXLyX+ETodZZo7muu2I30eeCg7do+9
PlLsQPq9yBN0NKZUzocY6s75+ARaRb8cyr1aBGlW74cR6UUSN90WqLEbdGCNeZz0
D7vo0GOwADayHRMrUPsJAf3oO7JSxNLKrNDJPvlDS9NLbqm/bJz5RFxeFLmKiCTu
A4nzsojFUoNm/0OrGa76qOuF7rFMMnV46XuYh9lYy6q507KZZ9sqnrYcAVRYlOGK
KIZ26NvNYF83sK6JxRCszc3V/EjPOZkYeNMjYrKfydccuq6LEKNVvvX5GXC4hZ14
PiRjs/QOY969EhuKCmoK+K6DZmcqSOr1fXnFr8nVjViU8Dg39xwTT5nuisIuLCVT
eboBS/IAyhqT4+UKZD2bfTbXrbg1LW+midCyhtFG5Z99hrbxbOgN5kIy9JT4Wi3D
IweZ3MQbj/T4ad3H9/EWuGr9IzGlPW7U8oLwCrC+l8//9sDAw+MI3font2UqMb5b
xwDOpu+zLh3QT/ElPYZ+ncYMSfd/sdRRV3pu4FsODKJp5VG6SyI=
=gyod
-----END PGP SIGNATURE-----

--a1pRqLOruZNPVvpY--
