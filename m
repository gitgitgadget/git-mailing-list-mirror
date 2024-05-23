Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1713D61E
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467136; cv=none; b=QRaOohNJZP7c4WhKvfHfytG8FoAHQ+RaK4BmrCs3TwR2h9Nfk6ramxNmtT0ozbziHhVxb9pQJy1SWY1f9m0bIyUM4Wp3lN2z1OcDajEGoE64hAG6Xv9QaN6OucJnlweQXXQw6a2ERljDkRtml8SGe1blDcBqEoe1THdzt2u8GVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467136; c=relaxed/simple;
	bh=5D9B9qNf9p+S0hUEjR096JotEJkk3DhwwgiAA5PlqoE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSTjCuCPbyG9CNdaxIugF9GQmPdFMYwDnTgkYxxkdcM8QNyTqX0rOacUvD1lyRx/uGHeMArzNiS0G0B1WTXS6JgDWpMCBVOHxu/3F0gS0/ZENimT9ZRxJYwZexdX52mThF+N+TPrGFKr1PikoVP01crxkuErAlrtdXIMPhQfb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=onRjBPjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iy6S1gNT; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="onRjBPjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iy6S1gNT"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0D56A1800087
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 May 2024 08:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467133; x=1716553533; bh=ZJVevRt7U/
	ErJQEpwz3TG6+Z8btTZOogCRbUCmOuTvY=; b=onRjBPjcdsSbOc/WrT5Rm3WDGF
	KT4bhOJvMYE6heiFw9EEbJcjhk6KTW20TRra69QL+qfR3/kJFJEJcvO5ucQxxWXK
	47LA0E0WdFntBIq7ftP1ncIeHKDqdzN+5nt2nyHpRPCVOrUrFwJvFguQrZ9PulsC
	/3eEo9AiJu2qYGmPhdNdZBgyx6AloicMkwSxS7AziXNrMvsUj4P/I10pKaH9tKRS
	WQSbR4XJpTlln7qa9KYJtHeGwiZ2TpSEz1zv7EcL7i1iuy4XDa4pg48p9i4fofLh
	kvcvyd2j5PvB1KmAo1w1kr0yKbb12UcQb727cYHQ/sbm1aG1nZ5rCjRLbLqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467133; x=1716553533; bh=ZJVevRt7U/ErJQEpwz3TG6+Z8btT
	ZOogCRbUCmOuTvY=; b=Iy6S1gNTh/j9FkMcvDVz8VW7B8qgMRXl5wKNCW7VoiDz
	gWlvcx534aznaxlx6mHf6+EeSBql6l/nQYi10Bs+1yuCNSvTSBC9+sb+dcjpSo8n
	3DrA1mF7imwkvYkTcMRzBlIfrLOc/NjYFJSyR1VOSkiF2yfrI3UxHcPEPogjzmfg
	RuqsuHoQYIHMer+UAmXdjHg7fs/iB60daybFZI0/NDvG3oJq9BavtyP7XBktp/J5
	PxRYy1jDn+tBj4mjy728MH96XPSSZ16aFWKmjOQkgV0Z193zzfJ4Ackv8VhijAAl
	O88c9sVwlPziunNOIzC0UlOjhXQ5mVd8CybUwF3ngA==
X-ME-Sender: <xms:vTVPZljBNIZJscu7XpUtVjjq7lTjMpQ9WpcwkOlwTNkf3OhriJOGJA>
    <xme:vTVPZqB-QV_1OL8PFCaD5mIvIMwdtSeWCXiuQqBwhwuMbJs4BKwrN2VRuFGZHGK90
    ipvqJn47ygtx066hw>
X-ME-Received: <xmr:vTVPZlECh9mUrf9TJxK473tcQQeqRMDRCxD4Escm4y5AvrvikX9h0TxUue18TxXCmq_Q-98nWaq2Bq759POt7M6hLm7qRhA2mxskZ0P2RS8pSWcTrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:vTVPZqQuIJCN-NL37bFXUTCe9ylEGM380sZL1P4NJUHHOwOHw_8gBg>
    <xmx:vTVPZiz4DrvRu20IR6tmeTuKrHvznVyo6LAMLoQocKAD4eDPNBJu4g>
    <xmx:vTVPZg7PzYkW65K4pCpaBq4OVFj6Qa8-0UMKzbZoyfU4Ex8mpgNDhg>
    <xmx:vTVPZnxOLQwh75NE9bVn-2vTs7NWZZwyr6O8prNEUNileRoonHF_-g>
    <xmx:vTVPZnrqKEazuWjwN1gUajaXnI4oiHnAvfJAjgkJdnzsNQ6MGbXhJTK0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d21d266e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:26 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/20] checkout: clarify memory ownership in
 `unique_tracking_name()`
Message-ID: <ffd9eb795f315b2c03da5bcec573938e89148a95.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hWNcd1b3rNjnw6lm"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--hWNcd1b3rNjnw6lm
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


--hWNcd1b3rNjnw6lm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNboACgkQVbJhu7ck
PpSPoA//W7HpEBsWkBO2K2UycTgFSLpcILCm8rfOuCtrm5v2dJLrZ+edHnbdFtKR
q0ekQE0HfRxbLOJwbhusvOjoZuKbKhpb6tWVKTbBkfbQHlUBp1WMwVLALMLgrgGL
aoLa0NUidOrhaKwuPn44FbKVp3YxEKBeb7L9xAEASOarkg0baY4y/4ES+W5clsjv
N39xhNZywiBaoOTvGuxTPwGUeneFD47FgUHkH65XhvFLQZ6ZfnDMCBt3l1HR0Ues
Yc5uxyk5N29jQl74lG9KzE20Su/ysPW6G6ipN2GSlSMTacbGnAMxmrXewkJx7nop
f4TWtCWIzrV3OqNAZpwOBt9e12Q47LSLUdDE7+8OaE+HXb07ueJBjIQ775T09bEB
YomHupjqeEbQ5JWt4ehPB8m2YoeWgSDpdQLC7EVOqnCRM0Dy8bxdg8ktBewy+7iz
SOaf0980QeUeVi0osZStCAHl6C6a5NwKXXeOkcHXlqtbGHOXDUBOW3uVYuX7npve
vf+43XbUkmvA2RgAoknRDfs6T3SGMGjSG1AHo+KpQtYPhimqRRwfCVI23WDLZ9Yq
P9yCeE2eeCQSbCi5Ygo1wSZuHjUXg/RWHdG3E5aPUku9/BWejMmfGy2o4ND6CVTB
miM5Br9fWiRxxi6nPwLiV4o6i8Ou76tAn/Djfz1eHoiKoCzc8+M=
=7/yH
-----END PGP SIGNATURE-----

--hWNcd1b3rNjnw6lm--
