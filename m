Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357613A3EF
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810373; cv=none; b=sElE4bZU6ZyvHYraHs93MwnQ/pTYPlY34zU+fdhkb9bLmgV2WE46pDEzhKpWSWR01oblsPL6nFGdvw88cckVPFJfT3x68b/uH+lt2NWAomusxmHEykY9+zZhbxf4sZETf4o5zFN6SzpXKM2ckY+lW3Zc7wD9xOiGNJy1zB7Pn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810373; c=relaxed/simple;
	bh=RiQTuGf9xVzgk0s4QjTeB4LHU1rdVNECkB+/+SkDC9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRzWM7SwFjtzb5XWwrEsqbWUAX0OqW9cbs102+7V41+50xkYtiu1DyOSukiMER0qqh7liPTgZdMpbzfUa+fC0qYhqfKFgqzHlAETgf7rjf0X3w5rInBQ1V1Z95Vwif4OAy4WA6rhKfCz6dBEwm97d/AT5b56gaNaZinshs1HhmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CTRaJ9xM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+xbdFXF; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CTRaJ9xM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+xbdFXF"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3190F18000D3;
	Mon, 27 May 2024 07:46:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 May 2024 07:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810369; x=1716896769; bh=C5QpoMcPLD
	JzUz+I3bRVsQt8z0kl/5bZsext74e9Pp4=; b=CTRaJ9xMY+nuMo4L2j5usoLmez
	Q+NTp7F94NNLPBxIFPiPMsH/6UdFsj+7bukpOxcMQ0tIlT1qpIBYh9gEp4st0HVu
	q7pivNgLjtDpTJwKXH/HXayb9XRZ1awPUW7kWHhHPFRNwShWjXwOyXWVsOZHDcQ3
	TilnitBDXY/OrkS6QFkJFd/jlCCNztgp7LbYXPfhhm0cHqVbCxlCF2ZOTWtJP7ue
	hq+aH7VN89xDnQMW4bY8f9hj4cha/15jxHxSHBbnfyx4KrOiS/uoe++iVxbu2lb7
	qbat9by8Nn6jwQT1MU5vpYGyfgVtfIkF2uJ5hu9VQyGlgK3Grur8S/TD1J5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810369; x=1716896769; bh=C5QpoMcPLDJzUz+I3bRVsQt8z0kl
	/5bZsext74e9Pp4=; b=N+xbdFXFw1eJ/2B6r5LfqkWBFU/ICZrxERBFIKRhsFZC
	ZIyVSJqSw7AFBt6TPPeWv1nRbDyt5pti5q5e+aEgKMxxo9fwAZkRpWD1lWrAH+wd
	nTOkENeOagM1bS5a5I+F1gwUxS7+UQ9+VRqO4pa38uCd5/f4qMgcgw8rc3eHRMhq
	hdpckZRdOMq8nPkGHRBhHuuoQHyBIZrM30WIB6A0KOyqPi9gvl3KWheHn9r/HuoB
	sxyQo4DPO9yee8ZvKu6DI83kh+H7/GZwu9oCgiHH+kCkPQqnrXk6frmuiNwjK3xM
	WIamMqUQ8lSMG7PkEIk65juqn7kFzLV2dKHmWzJp6w==
X-ME-Sender: <xms:gXJUZiowZOs81xXb-bMxe_8iGjOt6M-y7bGt-zotM6z3i9Urx9xdZA>
    <xme:gXJUZgpanFcxFABFdYpKkdCgsipSsFOFLCJs74UCw9OJ_FoLQs1BwEfqUeewwStoJ
    4Wrl7rBHelm3KKbyw>
X-ME-Received: <xmr:gXJUZnOqD2um9IGGxLr78Q13zXxW-rmR3IVMv0fun3cDKc3es8442GIVNbLm7yFxeSkrrm0ZzAgZ7u2PR-SGIUULQoOvipY-ep7jr4FMdiL8s9wjRXo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:gXJUZh5RtsnMqLU9im6HJGebiCLBGl2vJs8CGyADleVjtbsT8jj8Qg>
    <xmx:gXJUZh5CbbfmJPsO8iPjJU1gY87OBRrIoKvueUJkMAmHm_9N2xG3bQ>
    <xmx:gXJUZhi3ertaCkfHaQOH-tjfU3zYu97wUVxWxWKtBPsjB94IlzecQA>
    <xmx:gXJUZr4WfSA0tcDD42yaMOmGm00TgHU4mwxtzPaRIf3g967aI1Ao5A>
    <xmx:gXJUZvRX9QUYkWASxZXxKTtO8yBA-q-bfR7PFrtZ3Q-GzUtGX1-dhBSW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad109430 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:45:58 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 05/21] checkout: clarify memory ownership in
 `unique_tracking_name()`
Message-ID: <4a6dd9b6a85d99fb0e3ba2ef3af4c0f2846560cb.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+WYXhJ868+QT9dbz"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--+WYXhJ868+QT9dbz
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
2.45.1.246.gb9cfe4845c.dirty


--+WYXhJ868+QT9dbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcn0ACgkQVbJhu7ck
PpSTZQ//an2EVLHAg6rHs5lAAO72AgYbFZLb2nKHaSK4JHhmSNxq9N6PTduw7vdD
qdPJmo7wWY3K8XPQ1FEEN37HVlz8iVkBQ9o59JVe6stM2v40pb+dU95FSGseJNsr
CCT9xwhyzKUyyfXiVn8y+jRvOPYk0aoLV+fWKAnllehM08Awkhe7qS+AKK9IiGWA
thlekzdXKlB3ZhB41Fsn00ztC1OUkXEgU1KhWk2gXzSIYi2SH4TgtkA0ETRhz9VF
vmchrQqXqHQ+8VWD8X/qOa26CIMQLH3hy1f45u8UJJ4XZUFWjrB5+iHYEpdD9yKv
ZvUWfSSW4936fc+GrljlFKJe6GN9hlslARlMW9/LxmBAeHRmF95N1V4MWoRwVWQi
o4fibqzmbLWUzlODkpLi0o0ZWzBUQyEGc5u4rYBQ+dDw5fmw0HMZJN9U+65ysYYw
WRvjWFrSUKvUmxY+RuTbhoU3bREHylNWwg4VlzcWsmNTgiXlXE6ND7T+6dpKVg/4
5SzrDTMD0JCv0H6N4jMFCt23rqvWjSaGCodClNSh+jVsBsUhZZgHQEcfKE6a7iYG
B92MaPGRj40P5TRhgnxTRpXLLF/UdcvDqP+ecjjrnc1s9t+g6Y9lPUjv6LGGUead
mf6NjWpyZr7bR5Ev1L0XW061hWsKD7yHl3HjX4IlRi7HdBAWR/0=
=vHH1
-----END PGP SIGNATURE-----

--+WYXhJ868+QT9dbz--
