Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0315DBB3
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810412; cv=none; b=J294Q0Xlsj+Osu3InB9MeS5C1djMDyZvnwwmI1QYUzzkGnzL4AJUUOkLggE/2GTBwyC5FLmcGTmNo31M0rOC0bBggTnz/XX8yvkr2aAMlqv+0PJgoPixdv70h+s9f+yTOP1sEZpbEvP2XpDGy8723lAswvFpI+CYdJV3ICrcQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810412; c=relaxed/simple;
	bh=NbBnEoJwp1AdhHjPmWewlCp8QvkAIrXNONRrjtSLuXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMZLWH4LP3aVb2uDfvJsDnYPT99qC8EdaE5b2mgF0N5L2JIW02IQq4mv/OsHiBRXRajX8onq7lsiWSTdyfaXpDgFw764LpX0OYn3cQMyWUBOOqK3EvHYJjzA1eyU8uleWpjTawNFEh/p1vD9WNs/s17f2r6KkHQTQAOAk88ktsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bMCOKVvs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bz7iySdX; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bMCOKVvs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bz7iySdX"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 9917C1C000EC;
	Mon, 27 May 2024 07:46:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 May 2024 07:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810408; x=1716896808; bh=QXNwf+lpAY
	PjDpBqFj2WoAik6P6bvQs1IB3BAl9YcT8=; b=bMCOKVvse6qD1m+8Oq6yvUsLZO
	WvyY46xOlT8IDjzTCKnxAmroG+wFg0OrzHDbXxqTPN3hnBS3hi1d0Q2d+xSgPSdp
	9ZOS/YuY9lr/MnsFj+r+dr1Sk+c5FbVx1DXwTymoNOnadz0h3ew5KtzMxrliweAE
	yA0XFZl3EhFsVrbaE88e7evdHfoOvTn+KHCjW+3TwfXsZcANiicR0XlzDbMUt1Mn
	rU5qVCLZJargMRCcI1JP3i3JZ9JbzVHMoQSLIXfUV3zdYtYuW9EhUdhhZ2OxPGSm
	uDdk+WFSYm18loHXMo8yfpE+u+6dhVXnJy+VwODgMKXlAdrPdnKMsUVurDiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810408; x=1716896808; bh=QXNwf+lpAYPjDpBqFj2WoAik6P6b
	vQs1IB3BAl9YcT8=; b=bz7iySdX1m/gzvcLtHTj98UqP5SugLOfIaS8TnHYZTzz
	0cGVcrOtbk85AZv8HHy1khuBf+d7L/txwzq9pVR8GE3v+y5r/qgjVW0bEO20I7IR
	D5rKU9OlNjYB7NDYoIYVUy/9zpcHUpu1fVXDgtFq7l71tlUQl5UcrO/4q+5Eky0t
	Em14XfZ9KZo8MsOvuCUkV+gq5SLJk9BRbAPINfnh7jl0D7/xA0PM2XL1Ivezfx6E
	pe8lXlCZnBmQcdmAIT953iu1zU+GEnjlrDzHCvyw07xVUhm4+IGUVeHfEG6+LT6h
	HAwIeTv14Cbw9P07erRQAh32bZoUhD+CXp4GUwPlDw==
X-ME-Sender: <xms:qHJUZutgEFdYnTWfws43Kqahb9VYCGHZ9MWjSC1OoVijy7fx3Ef1lw>
    <xme:qHJUZjeCpjOGi7CxYy8P3AtwcMw9caeA-d2rKTENE39g2vuIUDug8KMeVqtFh_2qE
    ggb3yna30TtdUDknQ>
X-ME-Received: <xmr:qHJUZpwz90p04UiCj1oDNJfdBIt7wupjECAllpD5KkH0dY-KYTLT7-xaVEbJ2E5RqmGdtKYFag5DQDhtNOtalE5d4IIDck3xkAsjNN1-Mf1QInSbW60>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qHJUZpONUiRQsbo5_v1c2lVYKygdrVn8ZDdmq1rqXWwRFinPpiHcNw>
    <xmx:qHJUZu8dINxSzqXTp3cCi4cmfcg_L_nHv8HGUGFjYJYaJn6M5_TUpw>
    <xmx:qHJUZhUVzO8Jv74Wloj1lYL-tnevLPb4waahEFzWqhaRFUDoZ4-4Ng>
    <xmx:qHJUZndpz4z_dtzXn3wDMQTlvTlt7hGByRHDPz1SV0ULkzD-axTmPA>
    <xmx:qHJUZln6kyDl1o_Tk0cQbRXWRX9qRR5FokgZ4NIt1hRb6TKx89pyqqs2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9b5c3b0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:36 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 13/21] config: plug various memory leaks
Message-ID: <8b74dff67874a6c1c8d1cd9c8207db046bca985a.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7emuS7sym1/qcHsx"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--7emuS7sym1/qcHsx
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
 config.c                                     | 36 +++++++++++++++-----
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
 13 files changed, 40 insertions(+), 12 deletions(-)

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
index da52a7f8a1..496cd1a61e 100644
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
2.45.1.246.gb9cfe4845c.dirty


--7emuS7sym1/qcHsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcqMACgkQVbJhu7ck
PpRYjBAAoTjWpjDKiiRRHkAGkP/uGc0/8mFL0Q/uYaDdq45J7581bw+8HGPitof/
WHD9ufKUi18R/G3KDfPneRIkkdsRLcz6NTNQ9S/Jer8tXGcQtkTQPT0qOShVvHWj
JAlUZDSDdNu340hoK6pjls2u5+hd7Gt9fBnyOGxKu8ZyIm+NYhZVwEt16W0phNk1
OPziGYy0FW6fF424HKpciAb/YR2MlEJCL01RvTnXoy7fB///YqwLvuRPleumqfQ+
LByl3Y3ueNke3sAzJ81cKP4fR9a3ejcLVgi1u5dRfmHhAi1LYKCYPOABPT26huCN
SAS8KJytvcyZnEAmMFltM24SyT3CqbF356Zd3JgWUqPcDC+OPC6OLsVcasm93i7C
jWZJzhieGX+UqsrF5U2EJK8roxOWThBMQYVeR3jPXJ6Lrf+5ro+d7ZQawCJT0kdy
//KhuhaVRCmXYgtk5idc/RsOXEidK0eJch6GRwxMPdx/7WaW/rmYW9vE+bgXUVGK
nKhfOpqqaaHDZv0P6TKEwghOFiHaABZl2GmNE7ycm+auohEggoD4E8/gWRe2udxv
TmyAZ83M3gNpkM9AG1WdRyPajliqzovcJYpt4qMttCMxul/1Oa49t6Z9DpSHH/eX
SWAzeOimmlqhDscr5blf0uF7tgxlXVcyHXOSxWXKykygthLQtPg=
=8jzH
-----END PGP SIGNATURE-----

--7emuS7sym1/qcHsx--
