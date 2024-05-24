Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6683CCC
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545019; cv=none; b=DaEUuK5SYXh5BaYpnmDBHlShwSgh8nGV9SGCLs9d2hvEUFaYeUtJgSSLChRGMmSnH02EEJHKC5V9EUbv5VmL9D72aU8ZQps8sJdA2tmVpSvH/Uho7dk7P5oeNu7f0vDireU51uas0RLIkPBKHWwRBiAqGfeRL+RcNiL4laPhpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545019; c=relaxed/simple;
	bh=lRYfQVgwLqc/erTYfT577v0TIe4VVRw9GvZxaD8NLsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePdfuMIyurQDcfGf5x2Vhr6q6WY367MOkT3poSBajEf4zQ0jMNJg1N8p1AACRf0mM6Lb8FdH9kwwzYF2v0A7XYwW8n9jh51/p0xxbm1Of+gbLK7/H1crKjsbeuoJyweJI6gVCQd68TUhkQg7nTiXeqKVYnB4BHojwIvhqXqWGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H7a9m4B/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m5hugxCg; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H7a9m4B/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m5hugxCg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0F8391140195;
	Fri, 24 May 2024 06:03:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 24 May 2024 06:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545017; x=1716631417; bh=3MjvKwk5NA
	pOeCvgYgbu900wyFY+cko9dlv8RNJHz18=; b=H7a9m4B/neTk1ADewWXRXev9ni
	VWUu919MR51bJBdfkiCWLcVrk0jrG3htVf/Ai77nJvtoNPvOUw+tK4rmNcUnHTuX
	0wwiepahS9mJWN8DCAxeRK32mKj/5A/D2yVR76HGTfDAP3aMs/XMiivhJ3veQf32
	toewM7RzdtdNsoF/JpucnxHsOFzX/oByFehTeL744sBS+y9KRhzNKb2Yej4YShOF
	S7rxZFrQVMYKTSrOZnD9aFDz5ofOFgqePYIQfPciAIRM4eTd3IQHyqEYOT8GyVUt
	c4Jc9rZnk4OqTo4cnu/gunZk6dznOug0Xh6iMhayUr+BBY4xQ1pfGQ4CtMpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545017; x=1716631417; bh=3MjvKwk5NApOeCvgYgbu900wyFY+
	cko9dlv8RNJHz18=; b=m5hugxCgkvR+IeRxTHe2lbu6PfcucqwesZNzIIGLgQkA
	Yn+KicYXcg4PybDkbcbwvfq1G9xIjgWb1MjqEi31viE6wYWRXAGZXBdXIUjviEGp
	VIjf+8D2Qi92hmP4B/yGaZuViCtA4datX/jEiadZSllu984M/rdDRIsIq5mDnIax
	UIU29Qlw2cwfM7O3caxWF6qDNmQdmKrRLc8wFecYWfzaY8EdmUcmxc7hktE2Mfqx
	ZR2EbXvUWiIpDNkh4uaCQo7sXfyLaLFwUfGOxR0BtsKCyRKIpB912liPVYty5Oj+
	KfXUJvp44G/LydNc2F5A005HBzkAyLXeX0YA1nz++Q==
X-ME-Sender: <xms:-GVQZqOzVc_0cCrDgFh17iw3oRQc7QPBUfV3S2B16cv7DxwRXJqdDg>
    <xme:-GVQZo8KHIN4DcUV9a10tVw8bRSfEml3v0592CQKp0XGwDN8mrNaayGa3fFYxU_RE
    5dZhUAAJsZykMSOsA>
X-ME-Received: <xmr:-GVQZhRRobnPpLd29JklUzituuXc9pPHPu7kiCa8Fem9_oDI100HAbqKouz2SG4jQEpl20jJepTG6_L4Ey_p_4-7eWL4DvwlybzXKoLAtVQFfw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-GVQZqvp2lP0aO6e4DHKSffYiGp_QMp2u0d_HvzHRE6tznPz7TuixQ>
    <xmx:-GVQZifkDFIbqIXZGS4nyQu2MI4JLsljL3VvnBgk_bZprSBB44InQQ>
    <xmx:-GVQZu3KUiu4hCkANfKiL2nI_gFYWzBuPWyRGxCRgom4eWPu56JyVw>
    <xmx:-GVQZm_mqt-xyf5TugNtKv5yTPMST-aEiIQeQwAGSuifSM7KE1FRCA>
    <xmx:-WVQZi7Bnm568blvqhJWC5P6aJ2p6I_X557B6V6jZ5LcVTxHfq8i3GD0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0e76f430 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:33 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 05/21] checkout: clarify memory ownership in
 `unique_tracking_name()`
Message-ID: <6d4e9ce706b84ff23aa30b60ba7d849dc8c9cee3.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="StbA68t0SuwDHh7E"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--StbA68t0SuwDHh7E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `unique_tracking_name()` returns an allocated string, but
does not clearly indicate this because its return type is `const char *`
instead of `char *`. This has led to various callsites where we never
free its returned memory at all, which causes memory leaks.

Plug those leaks and mark now-passing tests as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c                            | 14 +++++++------
 builtin/worktree.c                            | 20 ++++++++++---------
 checkout.c                                    |  4 ++--
 checkout.h                                    |  6 +++---
 t/t2024-checkout-dwim.sh                      |  1 +
 t/t2060-switch.sh                             |  1 +
 t/t3426-rebase-submodule.sh                   |  1 +
 t/t3512-cherry-pick-submodule.sh              |  1 +
 t/t3513-revert-submodule.sh                   |  1 +
 t/t3600-rm.sh                                 |  1 +
 t/t3906-stash-submodule.sh                    |  1 +
 t/t4137-apply-submodule.sh                    |  1 +
 t/t6041-bisect-submodule.sh                   |  1 +
 t/t6438-submodule-directory-file-conflicts.sh |  1 +
 14 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index f90a4ca4b7..3cf44b4683 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1275,12 +1275,12 @@ static void setup_new_branch_info_and_source_tree(
 	}
 }
=20
-static const char *parse_remote_branch(const char *arg,
-				       struct object_id *rev,
-				       int could_be_checkout_paths)
+static char *parse_remote_branch(const char *arg,
+				 struct object_id *rev,
+				 int could_be_checkout_paths)
 {
 	int num_matches =3D 0;
-	const char *remote =3D unique_tracking_name(arg, rev, &num_matches);
+	char *remote =3D unique_tracking_name(arg, rev, &num_matches);
=20
 	if (remote && could_be_checkout_paths) {
 		die(_("'%s' could be both a local file and a tracking branch.\n"
@@ -1316,6 +1316,7 @@ static int parse_branchname_arg(int argc, const char =
**argv,
 	const char **new_branch =3D &opts->new_branch;
 	int argcount =3D 0;
 	const char *arg;
+	char *remote =3D NULL;
 	int dash_dash_pos;
 	int has_dash_dash =3D 0;
 	int i;
@@ -1416,8 +1417,8 @@ static int parse_branchname_arg(int argc, const char =
**argv,
 			recover_with_dwim =3D 0;
=20
 		if (recover_with_dwim) {
-			const char *remote =3D parse_remote_branch(arg, rev,
-								 could_be_checkout_paths);
+			remote =3D parse_remote_branch(arg, rev,
+						     could_be_checkout_paths);
 			if (remote) {
 				*new_branch =3D arg;
 				arg =3D remote;
@@ -1459,6 +1460,7 @@ static int parse_branchname_arg(int argc, const char =
**argv,
 		argc--;
 	}
=20
+	free(remote);
 	return argcount;
 }
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7e0868df72..937da6c0ee 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -736,16 +736,14 @@ static int dwim_orphan(const struct add_opts *opts, i=
nt opt_track, int remote)
 	return 1;
 }
=20
-static const char *dwim_branch(const char *path, const char **new_branch)
+static char *dwim_branch(const char *path, char **new_branch)
 {
 	int n;
 	int branch_exists;
 	const char *s =3D worktree_basename(path, &n);
-	const char *branchname =3D xstrndup(s, n);
+	char *branchname =3D xstrndup(s, n);
 	struct strbuf ref =3D STRBUF_INIT;
=20
-	UNLEAK(branchname);
-
 	branch_exists =3D !strbuf_check_branch_ref(&ref, branchname) &&
 			refs_ref_exists(get_main_ref_store(the_repository),
 					ref.buf);
@@ -756,8 +754,7 @@ static const char *dwim_branch(const char *path, const =
char **new_branch)
 	*new_branch =3D branchname;
 	if (guess_remote) {
 		struct object_id oid;
-		const char *remote =3D
-			unique_tracking_name(*new_branch, &oid, NULL);
+		char *remote =3D unique_tracking_name(*new_branch, &oid, NULL);
 		return remote;
 	}
 	return NULL;
@@ -769,6 +766,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
 	const char *new_branch_force =3D NULL;
 	char *path;
 	const char *branch;
+	char *branch_to_free =3D NULL;
+	char *new_branch_to_free =3D NULL;
 	const char *new_branch =3D NULL;
 	const char *opt_track =3D NULL;
 	const char *lock_reason =3D NULL;
@@ -859,16 +858,17 @@ static int add(int ac, const char **av, const char *p=
refix)
 		opts.orphan =3D dwim_orphan(&opts, !!opt_track, 0);
 	} else if (ac < 2) {
 		/* DWIM: Guess branch name from path. */
-		const char *s =3D dwim_branch(path, &new_branch);
+		char *s =3D dwim_branch(path, &new_branch_to_free);
 		if (s)
-			branch =3D s;
+			branch =3D branch_to_free =3D s;
+		new_branch =3D new_branch_to_free;
=20
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan =3D (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac =3D=3D 2) {
 		struct object_id oid;
 		struct commit *commit;
-		const char *remote;
+		char *remote;
=20
 		commit =3D lookup_commit_reference_by_name(branch);
 		if (!commit) {
@@ -923,6 +923,8 @@ static int add(int ac, const char **av, const char *pre=
fix)
=20
 	ret =3D add_worktree(path, branch, &opts);
 	free(path);
+	free(branch_to_free);
+	free(new_branch_to_free);
 	return ret;
 }
=20
diff --git a/checkout.c b/checkout.c
index 4256e71a7c..cfaea4bd10 100644
--- a/checkout.c
+++ b/checkout.c
@@ -45,8 +45,8 @@ static int check_tracking_name(struct remote *remote, voi=
d *cb_data)
 	return 0;
 }
=20
-const char *unique_tracking_name(const char *name, struct object_id *oid,
-				 int *dwim_remotes_matched)
+char *unique_tracking_name(const char *name, struct object_id *oid,
+			   int *dwim_remotes_matched)
 {
 	struct tracking_name_data cb_data =3D TRACKING_NAME_DATA_INIT;
 	const char *default_remote =3D NULL;
diff --git a/checkout.h b/checkout.h
index 3c514a5ab4..ba15a13fb3 100644
--- a/checkout.h
+++ b/checkout.h
@@ -8,8 +8,8 @@
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-const char *unique_tracking_name(const char *name,
-				 struct object_id *oid,
-				 int *dwim_remotes_matched);
+char *unique_tracking_name(const char *name,
+			   struct object_id *oid,
+			   int *dwim_remotes_matched);
=20
 #endif /* CHECKOUT_H */
diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index a3b1449ef1..2caada3d83 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -4,6 +4,7 @@ test_description=3D'checkout <branch>
=20
 Ensures that checkout on an unborn branch does what the user expects'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Is the current branch "refs/heads/$1"?
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db936..77b2346291 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -5,6 +5,7 @@ test_description=3D'switch basic functionality'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t3426-rebase-submodule.sh b/t/t3426-rebase-submodule.sh
index ba069dccbd..94ea88e384 100755
--- a/t/t3426-rebase-submodule.sh
+++ b/t/t3426-rebase-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'rebase can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3512-cherry-pick-submodule.sh b/t/t3512-cherry-pick-submodu=
le.sh
index f22d1ddead..9387a22a9e 100755
--- a/t/t3512-cherry-pick-submodule.sh
+++ b/t/t3512-cherry-pick-submodule.sh
@@ -5,6 +5,7 @@ test_description=3D'cherry-pick can handle submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t3513-revert-submodule.sh b/t/t3513-revert-submodule.sh
index 8bfe3ed246..e178968b40 100755
--- a/t/t3513-revert-submodule.sh
+++ b/t/t3513-revert-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'revert can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 98259e2ada..31ac31d4bc 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,6 +8,7 @@ test_description=3D'Test of the various options to git rm.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Setup some files to be removed, some with funny characters
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index 0f7348ec21..0f61f01ef4 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'stash can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t4137-apply-submodule.sh b/t/t4137-apply-submodule.sh
index 07d5262537..ebd0d4ad17 100755
--- a/t/t4137-apply-submodule.sh
+++ b/t/t4137-apply-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git apply handling submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t6041-bisect-submodule.sh b/t/t6041-bisect-submodule.sh
index 82013fc903..3946e18089 100755
--- a/t/t6041-bisect-submodule.sh
+++ b/t/t6041-bisect-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'bisect can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t6438-submodule-directory-file-conflicts.sh b/t/t6438-submod=
ule-directory-file-conflicts.sh
index 8df67a0ef9..3594190af8 100755
--- a/t/t6438-submodule-directory-file-conflicts.sh
+++ b/t/t6438-submodule-directory-file-conflicts.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'merge can handle submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
--=20
2.45.1.216.g4365c6fcf9.dirty


--StbA68t0SuwDHh7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZfUACgkQVbJhu7ck
PpRF2Q/9Fo7yLusoPlfR6lUzEeQJXGnpHnqBaE5xsh5aeGYLrgAzP+viD6Epjj1x
Vdu0XUlqdzqi7Zr//xS+EU0L2flfQwa5lqM6yhJsyfyzW98ESVfN9lFE48TV9a7N
3OxX7VeDkjkNhN9FePSt+TMfNULbQlS3hOzf0nyL77gytNRgy0p1rWMtYJgXSzSM
RB17q/GhoFaIAg7zUXQSaxUQ6QimbmVWGy7Q79bJ9+spqI0Gq+pCB7xvkuStRnsL
PXIW9ZLM+jR0gQxCX3khDFN1i+7zR/Amx0kemKCwoRMghcSCWa3PxcrfGueaXrtk
KuCS9WiuUfLyi40ku7y78RGCz02Ff4htYhVSkJoaHryAai0ZPFk+C+WfhBGdNdSx
FDbfSv9eCv/B/45FsOv+h88noOYKTwQwGct2PGS10otfCt9yqcp/YqWDbA8ckbhh
/31Wj5GoTZ28xrPKEfoa6PE6MmDnyoLqvJpxhd2sXxBVzAI0q34/EzWRZukn7nRf
7zgI+27RMQogRLAU8F6SsxGtATR3WIOQxPx5xHhM22zp9n7N4/4NBoh/Fklzpl/a
zbeBMzJt4NbTSQDeOr1kW26QSc1XHHbpaIe5tnzofoSLVYlfMbO7MFrh920Bt1db
c/xlqRBR7ylRNu5kbkO4CMaM1Zgk7LOxPyuKbK1fI+O/71/BHHs=
=FuCi
-----END PGP SIGNATURE-----

--StbA68t0SuwDHh7E--
