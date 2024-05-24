Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4285926
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545058; cv=none; b=OZPk9Krdw7tIgUe+Mc+PElk41frKIsDsW4Yuf7w69oGeEZMQvjefnHyHgecvgktpcOWE2UajYEFKG2D2U8ng3pZA/PuJH+hwV8JdSQkn3umfub5tO5+XnBkFZFJCSPWNSgVkbVyln5a2ll5AElYgAOaw+qiwBV8EhOJTcg4Ugas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545058; c=relaxed/simple;
	bh=YhU+9l17yMkWNw/jsX8HaghgWaFC0OWqqWwWre3SZtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnxEEvlVM+VNBEXDrHP/Y4n7jJNJQjMifWlMmzU+dM+kZurVG+/cDCnmmD5EpplGu/dIyg+4GvmjltvLf3GgEC3yf6CG5zeW/G58pYIbkbND23NeGakUdwloq5oZvo5aZCso9A3ghFDNf+hIm4zXGkjfbLckE/3bG4WMLx17ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EjExrTzQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDnVxmsE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EjExrTzQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDnVxmsE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 20DC713800EE;
	Fri, 24 May 2024 06:04:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 24 May 2024 06:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545056; x=1716631456; bh=pbeNyU6eIL
	yVPL3iPwRKPk4/RzVjhELqVFZpQzok9fM=; b=EjExrTzQHghxBtXpZ0hRLikh3l
	J/TufnvVgD3I+FQNgrkyPn5eKsY1vFXnfrLo149O24qM31aKbc5J6jxkiLdyvAHf
	91TCPns4Kx9KW0PVTrunKT0GN87CLf9XwxwJ5cUyp/mzgz9SzKjdrxTjSS2UZ1Jf
	G0a6FZpn7O06T+RYP7C2Xtm6Iit7vxiUaVBQIzIi/ZOnpYT9y9bFx+w5RLIVjCRK
	sAMCBKizFcFpwricbl7YA0IliN2Ejw2qCIJkpo4kbD6Aekif3FnPNcobuZrhNeuQ
	0pztGnpbLALEWT2xSOPfUix0iu5AZnebKG0Uke92MZ2Qd11JPuJFFTe/BWKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545056; x=1716631456; bh=pbeNyU6eILyVPL3iPwRKPk4/RzVj
	hELqVFZpQzok9fM=; b=lDnVxmsEZQhBX3vH7uKPhfe3Xfchxp+Jhnnx9tCMIcKk
	ISvprZ9WL4K7gR9BfvycYvGhy1kjhEB36DIgCGV4YDq0U4ekB5JGBImktvoHwfbs
	MoKr7M6jpy1p5SrXkIFvrv0vOOQzgGngo32fzpW3sZXOjh5+5PJbogUdsLpmC+DH
	U0hYntS2zfUbVt+sDdmnKVbja6QGHiwuH8oyS3VD7+UvI5VPHScgBVA8hwDWzart
	/9zhB6FHs8hw/dTtanUYdI4z0XekxLBeTrO3xNO/mE3nuZ5vzhOKtxVIBBCZjqOa
	L3/fwCCD1wHe3BCoVNy1fDgdzyec3SXOFITH7zU0kw==
X-ME-Sender: <xms:H2ZQZixekJ4lKuO5-32jssVrWPqPPhKz3WoSdyDSzws7zENVDP-KNg>
    <xme:H2ZQZuS8mXhGgQ1x-cRm9VPanr7NvpGd5MGfra5Xyh2oZ-C0_NXPEseThPF9OVpsE
    gsOcNiRyjBjAaxGjg>
X-ME-Received: <xmr:H2ZQZkWdukoVe1jnDETGCv92Orr2epkrNqbKaDO426jAQYvzCkdImpH4q1k5b6-dsVlp_by56QA6vuKFBm7JIqLXTREGtVqudoz1ebrpVQJibxY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:H2ZQZohgQJH80LBTjsFCrQpjcRZgXQPF1iNt5jAWXrvtifCNidEAlA>
    <xmx:H2ZQZkAOx9ifMzkj162j8j7lyxoSXqdChtrbBmLM_6qyVUoHtz79nA>
    <xmx:H2ZQZpItdUffMoIX9EnwsDyjQI6SXxG5mycPQkIrvP5vCrsB-kUBiw>
    <xmx:H2ZQZrAkC8VTah6T6weqZGsgH5ySm63W3TNMtejVK9Ga8wMUlS6Uiw>
    <xmx:IGZQZnPzKidJhYvV-UhNERTJr65UWhIrOFZ1qada2qiR0_BCivGSOKGA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:04:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c2bf8d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:04:11 +0000 (UTC)
Date: Fri, 24 May 2024 12:04:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/21] config: plug various memory leaks
Message-ID: <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tgKdxDPC8O0PyJ/2"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--tgKdxDPC8O0PyJ/2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now that memory ownership rules around `git_config_string()` and
`git_config_pathname()` are clearer, it also got easier to spot that
the returned memory needs to be free'd. Plug a subset of those cases and
mark now-passing tests as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 alias.c                                      |  4 ++-
 config.c                                     | 38 ++++++++++++++------
 t/t1306-xdg-files.sh                         |  1 +
 t/t1350-config-hooks-path.sh                 |  1 +
 t/t3415-rebase-autosquash.sh                 |  1 +
 t/t4041-diff-submodule-option.sh             |  1 +
 t/t4060-diff-submodule-option-diff-format.sh |  1 +
 t/t4210-log-i18n.sh                          |  2 ++
 t/t6006-rev-list-format.sh                   |  1 +
 t/t7005-editor.sh                            |  1 +
 t/t7102-reset.sh                             |  1 +
 t/t9129-git-svn-i18n-commitencoding.sh       |  1 -
 t/t9139-git-svn-non-utf8-commitencoding.sh   |  1 -
 13 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/alias.c b/alias.c
index 269892c356..4daafd9bda 100644
--- a/alias.c
+++ b/alias.c
@@ -21,9 +21,11 @@ static int config_alias_cb(const char *key, const char *=
value,
 		return 0;
=20
 	if (data->alias) {
-		if (!strcasecmp(p, data->alias))
+		if (!strcasecmp(p, data->alias)) {
+			FREE_AND_NULL(data->v);
 			return git_config_string(&data->v,
 						 key, value);
+		}
 	} else if (data->list) {
 		string_list_append(data->list, p);
 	}
diff --git a/config.c b/config.c
index a025cfafe0..496cd1a61e 100644
--- a/config.c
+++ b/config.c
@@ -1414,8 +1414,10 @@ static int git_default_core_config(const char *var, =
const char *value,
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.attributesfile"))
+	if (!strcmp(var, "core.attributesfile")) {
+		FREE_AND_NULL(git_attributes_file);
 		return git_config_pathname(&git_attributes_file, var, value);
+	}
=20
 	if (!strcmp(var, "core.hookspath")) {
 		if (ctx->kvi && ctx->kvi->scope =3D=3D CONFIG_SCOPE_LOCAL &&
@@ -1428,6 +1430,7 @@ static int git_default_core_config(const char *var, c=
onst char *value,
 			      "again with "
 			      "`GIT_CLONE_PROTECTION_ACTIVE=3Dfalse`"),
 			    value);
+		FREE_AND_NULL(git_hooks_path);
 		return git_config_pathname(&git_hooks_path, var, value);
 	}
=20
@@ -1566,7 +1569,7 @@ static int git_default_core_config(const char *var, c=
onst char *value,
=20
 	if (!strcmp(var, "core.checkroundtripencoding")) {
 		FREE_AND_NULL(check_roundtrip_encoding);
-		return git_config_string((const char **) &check_roundtrip_encoding, var,=
 value);
+		return git_config_string(&check_roundtrip_encoding, var, value);
 	}
=20
 	if (!strcmp(var, "core.notesref")) {
@@ -1576,8 +1579,10 @@ static int git_default_core_config(const char *var, =
const char *value,
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.editor"))
+	if (!strcmp(var, "core.editor")) {
+		FREE_AND_NULL(editor_program);
 		return git_config_string(&editor_program, var, value);
+	}
=20
 	if (!strcmp(var, "core.commentchar") ||
 	    !strcmp(var, "core.commentstring")) {
@@ -1595,11 +1600,13 @@ static int git_default_core_config(const char *var,=
 const char *value,
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.askpass"))
+	if (!strcmp(var, "core.askpass")) {
+		FREE_AND_NULL(askpass_program);
 		return git_config_string(&askpass_program, var, value);
+	}
=20
 	if (!strcmp(var, "core.excludesfile")) {
-		free(excludes_file);
+		FREE_AND_NULL(excludes_file);
 		return git_config_pathname(&excludes_file, var, value);
 	}
=20
@@ -1702,11 +1709,15 @@ static int git_default_sparse_config(const char *va=
r, const char *value)
=20
 static int git_default_i18n_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "i18n.commitencoding"))
+	if (!strcmp(var, "i18n.commitencoding")) {
+		FREE_AND_NULL(git_commit_encoding);
 		return git_config_string(&git_commit_encoding, var, value);
+	}
=20
-	if (!strcmp(var, "i18n.logoutputencoding"))
+	if (!strcmp(var, "i18n.logoutputencoding")) {
+		FREE_AND_NULL(git_log_output_encoding);
 		return git_config_string(&git_log_output_encoding, var, value);
+	}
=20
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
@@ -1779,10 +1790,15 @@ static int git_default_push_config(const char *var,=
 const char *value)
=20
 static int git_default_mailmap_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "mailmap.file"))
+	if (!strcmp(var, "mailmap.file")) {
+		FREE_AND_NULL(git_mailmap_file);
 		return git_config_pathname(&git_mailmap_file, var, value);
-	if (!strcmp(var, "mailmap.blob"))
+	}
+
+	if (!strcmp(var, "mailmap.blob")) {
+		FREE_AND_NULL(git_mailmap_blob);
 		return git_config_string(&git_mailmap_blob, var, value);
+	}
=20
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
@@ -1790,8 +1806,10 @@ static int git_default_mailmap_config(const char *va=
r, const char *value)
=20
 static int git_default_attr_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "attr.tree"))
+	if (!strcmp(var, "attr.tree")) {
+		FREE_AND_NULL(git_attr_tree);
 		return git_config_string(&git_attr_tree, var, value);
+	}
=20
 	/*
 	 * Add other attribute related config variables here and to
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 40d3c42618..53e5b290b9 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -7,6 +7,7 @@
=20
 test_description=3D'Compatibility with $XDG_CONFIG_HOME/git/ files'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'read config: xdg file exists and ~/.gitconfig doesn'\=
''t' '
diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
index f6dc83e2aa..5c47f9ecc3 100755
--- a/t/t1350-config-hooks-path.sh
+++ b/t/t1350-config-hooks-path.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test the core.hooksPath configuration variable'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'set up a pre-commit hook in core.hooksPath' '
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index fcc40d6fe1..22452ff84c 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -5,6 +5,7 @@ test_description=3D'auto squash'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-opti=
on.sh
index 0c1502d4b0..8fc40e75eb 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -12,6 +12,7 @@ This test tries to verify the sanity of the --submodule o=
ption of git diff.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Tested non-UTF-8 encoding
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-su=
bmodule-option-diff-format.sh
index 97c6424cd5..8ce67442d9 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -10,6 +10,7 @@ test_description=3D'Support for diff format verbose submo=
dule difference in git di
 This test tries to verify the sanity of --submodule=3Ddiff option of git d=
iff.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Tested non-UTF-8 encoding
diff --git a/t/t4210-log-i18n.sh b/t/t4210-log-i18n.sh
index 75216f19ce..7120030b5c 100755
--- a/t/t4210-log-i18n.sh
+++ b/t/t4210-log-i18n.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'test log with i18n features'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./lib-gettext.sh
=20
 # two forms of =C3=A9
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 573eb97a0f..f1623b1c06 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -8,6 +8,7 @@ test_description=3D'git rev-list --pretty=3Dformat test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
=20
diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 5fcf281dfb..b9822294fe 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'GIT_EDITOR, core.editor, and stuff'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 unset EDITOR VISUAL GIT_EDITOR
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 62d9f846ce..2add26d768 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -10,6 +10,7 @@ Documented tests for git reset'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 commit_msg () {
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-=
commitencoding.sh
index 185248a4cd..01e1e8a8f7 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -4,7 +4,6 @@
=20
 test_description=3D'git svn honors i18n.commitEncoding in config'
=20
-TEST_FAILS_SANITIZE_LEAK=3Dtrue
 . ./lib-git-svn.sh
=20
 compare_git_head_with () {
diff --git a/t/t9139-git-svn-non-utf8-commitencoding.sh b/t/t9139-git-svn-n=
on-utf8-commitencoding.sh
index b7f756b2b7..22d80b0be2 100755
--- a/t/t9139-git-svn-non-utf8-commitencoding.sh
+++ b/t/t9139-git-svn-non-utf8-commitencoding.sh
@@ -4,7 +4,6 @@
=20
 test_description=3D'git svn refuses to dcommit non-UTF8 messages'
=20
-TEST_FAILS_SANITIZE_LEAK=3Dtrue
 . ./lib-git-svn.sh
=20
 # ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
--=20
2.45.1.216.g4365c6fcf9.dirty


--tgKdxDPC8O0PyJ/2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZhsACgkQVbJhu7ck
PpTOihAAixYxr+UJku5SfslIeqDwfNuhpXDAXk8RT3g12sW8WHA0isit7kAPwaWK
vA3+TRByg3L+twqa7i1uzPOrEEgbbRCKV/DarlZ962tyrNGILdT4ML2Kscax8qGK
JmtfDyKqS9gqzu1/z4NzO9RDQeNAcV/skpujyICr5F3aeX+iKxDREhreR98z9m7V
baSYPuUbCIqqU3BwtjMjf8Xw69wlus9olj5xECFySr3cjDGvHL6qAqkwm8aShamp
FEjQcqh//GzliRAPLr7l1B+2fnLonRpE/+g0Hja3XnWX0pjcLmkcq/CjbfdO/9UR
fwVsZj1wN4e5+R5gKqBXxjS+a9dJBCzhStpMHAo4hS1vPQctPXSE8OJKVJUmOVkE
lN6ZhpK7DSzCfX0YeNfz6H1ssw2ChYO2YGDe9/RfYTxUzmo5Nbax6zBiA10wY79e
5iH0sqtb74KN0mAm4uI8ITcdNP1PGyW/Ma4ygJLhApNmkeMBQet1ngDupipYMsA+
298+PzmfLYSx1md8vqIi1HwVxEfAS1BP+VDewPokGj/KvLv9wkLNZwe5msZo/UQN
cyBa3fJ/blGFCvs5NzuXM2P63wFh332w7lfm2qAiwbxI3WAN3jGpLd9U2xtZT/0a
e6wJfMe8hgBWlcI3uLXV23SKw+Unzkwfc/9eMLJZ7CfzQNlZ+Po=
=+i7B
-----END PGP SIGNATURE-----

--tgKdxDPC8O0PyJ/2--
