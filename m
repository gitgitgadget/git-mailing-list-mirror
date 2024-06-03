Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D685127B67
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407999; cv=none; b=GwmulAap6MIKXotdUY3C/Ip69tdljnHJm0Hm8uU62LX3+tSKgaRU7z1apecY3ek5NGhb3tBAMaXgfJLOPxAHme9wJSlOL1Ji8K9+AXkqD7nEkIrpvMU3y340KoXiytmWsHzxBcwK32YGt3R3ZDhIYfdK7pEqmfodevoOC5Zj7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407999; c=relaxed/simple;
	bh=qiKf6NXN0ms0ZoDVFvKQhBsFb7MPI5qPSDTF6N3LElk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aj8zazQ9DKMBFoDRqEGjIDTthE4uQlw+MiEuvDZ2PWanFrwOgM1LYh338zD0m9BM2m+H2G2ZFppLd5qL/RPvRQbyZbWIomhj7QsUMkfFzvD1ip9zZQAckxNZeRqfsdBtuf6UboTQFqPP0U+MixJCq9GdpRGhhmKFadIxt01Qe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=phXUnRXn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDreiGxW; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="phXUnRXn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDreiGxW"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id E14A918000BA
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407996; x=1717494396; bh=hcdWsA1ODD
	YucLbZ0OJuvsHIUv7hQGKOcoW0DXvx0f4=; b=phXUnRXnUzyCyEK4CBwORR3BxE
	zpAN46xB/yWDJrAmTK/G/pL1Odh4LzY97iqft6O3ATpvnNAxxVELk3Xb2eFyuK/x
	WJ2Hu+by63EWbLDRIiagfHlg/ZHrR9uAvXboKall+AewgnYpvUdMsyWInQFrELNL
	jGb6egsD0ixQpQyFjuh2nNrWMsH27Rgs2LMaZ5haKHF3c3HQNkWDMrlzjbROMST7
	4mhF/3Kr+cdU/T5cAg5gZYf7KPLMTZkiesI7VSWqHCbb8u/BjRqoGnCVd+Y8V3/k
	9RSMgQDjny7Yf4rOqB4NvB9u+QA6uNvRNPUeWaxaunsRYlgdDJokVs2PxNpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407996; x=1717494396; bh=hcdWsA1ODDYucLbZ0OJuvsHIUv7h
	QGKOcoW0DXvx0f4=; b=oDreiGxWbXSYzrxXs5ULFi8p8sPxJVYWQlhfyiWz/QX1
	LURHIcspgLOxtrPp9AdUmJLbpLPa3MnIce3Ip/VTPiYLRkpgXvy+MxcUTYP4nB43
	l8ZhAEULfe0y3LcmwdvBt64VtRwpwvxA/cG0+sbBHS3ItT41kCnT0AoA+gtrdJwC
	rpvt0ue/B+J4YoNFXNtQDXj8v44sVi/YhSBeYgTgaTqsA5l7tb70rAOqkUHkrPJ8
	xfTVJEI7qjp+8iQRwr/ErdwrGQkTTo0hfYRz1DouZLNEBQ9P86k5vwTRJFe68Y++
	l5svgLEbtnKqOzoEIY4rBmF3aUOmFpdZHke7lSUHKg==
X-ME-Sender: <xms:_JBdZje4xZ45WpjsYq_uVqAzufyE7w9xAIx3qjf-_ZqS6pDx593jMA>
    <xme:_JBdZpP1Wgru_F0Zu0nSUviSBmEA23ILgS-r_w2D1wsg714mzWnJUaF6g9aoeUmnw
    mREVmj4n90GqCDWLw>
X-ME-Received: <xmr:_JBdZsj5QPbrzlRDrOBW32paLJbfi_1khlTt16GX9gDZ8Mwa0bwHxbWReAh522AuVKikx7g9IvWdK5qvplTWmUJpQuL5SLUlzLh32iGom5ojdy9q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_JBdZk92VzOCZtkCdCxD7dnHJKSC6DG1d7c4LQ3MOg_A9hvQW0EgXw>
    <xmx:_JBdZvsdoD-nrQkkvuPMZJjTB1Ne3A4W465YfqovKRqj7Otw4wI2dQ>
    <xmx:_JBdZjHiZsDbiQyW-q9OyI4UJTdAdQmjv-XMP0iMeW698Ac-E2lqKQ>
    <xmx:_JBdZmPmz9Dq-EeIs6BBGyrlbwKSo7tPPQWeRAvhBCe3Rz_pEsd8gQ>
    <xmx:_JBdZoVcgzYUb59jvlTP_ZiLcJtUBbFXdZnvborSeuxmGdbeQY_iypeR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b958c83e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:11 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/29] parse-options: fix leaks for users of OPT_FILENAME
Message-ID: <ecabbb74e19ea773fd23719bd7fd4937b29679e5.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x27k3CrNUJVX01YA"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--x27k3CrNUJVX01YA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `OPT_FILENAME()` option will, if set, put an allocated string into
the user-provided variable. Consequently, that variable thus needs to be
free'd by the caller of `parse_options()`. Some callsites don't though
and thus leak memory. Fix those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                             |  1 +
 apply.h                             |  2 +-
 builtin/archive.c                   |  7 +++++--
 builtin/commit.c                    |  7 +++++--
 builtin/fmt-merge-msg.c             |  4 +++-
 builtin/log.c                       |  4 +++-
 builtin/multi-pack-index.c          | 13 +++++++++----
 builtin/sparse-checkout.c           |  1 +
 t/helper/test-parse-options.c       |  1 +
 t/t1512-rev-parse-disambiguation.sh |  1 +
 t/t2500-untracked-overwriting.sh    |  1 +
 t/t3406-rebase-message.sh           |  1 +
 t/t3407-rebase-abort.sh             |  1 +
 t/t3428-rebase-signoff.sh           |  1 +
 t/t4131-apply-fake-ancestor.sh      |  1 +
 t/t4151-am-abort.sh                 |  1 +
 t/t4253-am-keep-cr-dos.sh           |  1 +
 t/t4255-am-submodule.sh             |  1 +
 t/t5407-post-rewrite-hook.sh        |  1 +
 t/t6427-diff3-conflict-markers.sh   |  1 +
 t/t7512-status-help.sh              |  1 +
 21 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/apply.c b/apply.c
index 901b67e625..d8d26a48f1 100644
--- a/apply.c
+++ b/apply.c
@@ -135,6 +135,7 @@ void clear_apply_state(struct apply_state *state)
 	strset_clear(&state->removed_symlinks);
 	strset_clear(&state->kept_symlinks);
 	strbuf_release(&state->root);
+	FREE_AND_NULL(state->fake_ancestor);
=20
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
diff --git a/apply.h b/apply.h
index 7cd38b1443..36d7c3f70b 100644
--- a/apply.h
+++ b/apply.h
@@ -59,7 +59,7 @@ struct apply_state {
 	struct repository *repo;
 	const char *index_file;
 	enum apply_verbosity apply_verbosity;
-	const char *fake_ancestor;
+	char *fake_ancestor;
 	const char *patch_input_file;
 	int line_termination;
 	struct strbuf root;
diff --git a/builtin/archive.c b/builtin/archive.c
index 15ee1ec7bb..f29c0ef6ad 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -92,6 +92,7 @@ int cmd_archive(int argc, const char **argv, const char *=
prefix)
 			N_("path to the remote git-upload-archive command")),
 		OPT_END()
 	};
+	int ret;
=20
 	argc =3D parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
@@ -106,6 +107,8 @@ int cmd_archive(int argc, const char **argv, const char=
 *prefix)
=20
 	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
=20
-	UNLEAK(output);
-	return write_archive(argc, argv, prefix, the_repository, output, 0);
+	ret =3D write_archive(argc, argv, prefix, the_repository, output, 0);
+
+	free(output);
+	return ret;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index f53e7e86ff..dcaf4efa03 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -106,7 +106,8 @@ static enum {
 	COMMIT_PARTIAL
 } commit_style;
=20
-static const char *logfile, *force_author;
+static const char *force_author;
+static char *logfile;
 static char *template_file;
 /*
  * The _message variables are commit names from which to take
@@ -1309,7 +1310,7 @@ static int parse_and_validate_options(int argc, const=
 char *argv[],
 				  !!use_message, "-C",
 				  !!logfile, "-F");
 	if (use_message || edit_message || logfile ||fixup_message || have_option=
_m)
-		template_file =3D NULL;
+		FREE_AND_NULL(template_file);
 	if (edit_message)
 		use_message =3D edit_message;
 	if (amend && !use_message && !fixup_message)
@@ -1892,5 +1893,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 	strbuf_release(&author_ident);
 	strbuf_release(&err);
 	strbuf_release(&sb);
+	free(logfile);
+	free(template_file);
 	return ret;
 }
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0f9855b680..957786d1b3 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -11,7 +11,7 @@ static const char * const fmt_merge_msg_usage[] =3D {
=20
 int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 {
-	const char *inpath =3D NULL;
+	char *inpath =3D NULL;
 	const char *message =3D NULL;
 	char *into_name =3D NULL;
 	int shortlog_len =3D -1;
@@ -66,5 +66,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const =
char *prefix)
 	if (ret)
 		return ret;
 	write_in_full(STDOUT_FILENO, output.buf, output.len);
+
+	free(inpath);
 	return 0;
 }
diff --git a/builtin/log.c b/builtin/log.c
index 78a247d8a9..4e4b645a21 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2021,7 +2021,7 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	const char *rfc =3D NULL;
 	int creation_factor =3D -1;
 	const char *signature =3D git_version_string;
-	const char *signature_file_arg =3D NULL;
+	char *signature_file_arg =3D NULL;
 	struct keep_callback_data keep_callback_data =3D {
 		.cfg =3D &cfg,
 		.revs =3D &rev,
@@ -2559,6 +2559,8 @@ int cmd_format_patch(int argc, const char **argv, con=
st char *prefix)
 	strbuf_release(&rdiff1);
 	strbuf_release(&rdiff2);
 	strbuf_release(&rdiff_title);
+	free(description_file);
+	free(signature_file_arg);
 	free(to_free);
 	free(rev.message_id);
 	if (rev.ref_message_ids)
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 8360932d2e..9cf1a32d65 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -50,7 +50,7 @@ static char const * const builtin_multi_pack_index_usage[=
] =3D {
 static struct opts_multi_pack_index {
 	char *object_dir;
 	const char *preferred_pack;
-	const char *refs_snapshot;
+	char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
 	int stdin_packs;
@@ -135,6 +135,7 @@ static int cmd_multi_pack_index_write(int argc, const c=
har **argv,
 			     N_("refs snapshot for selecting bitmap commits")),
 		OPT_END(),
 	};
+	int ret;
=20
 	opts.flags |=3D MIDX_WRITE_BITMAP_HASH_CACHE;
=20
@@ -157,7 +158,6 @@ static int cmd_multi_pack_index_write(int argc, const c=
har **argv,
=20
 	if (opts.stdin_packs) {
 		struct string_list packs =3D STRING_LIST_INIT_DUP;
-		int ret;
=20
 		read_packs_from_stdin(&packs);
=20
@@ -166,12 +166,17 @@ static int cmd_multi_pack_index_write(int argc, const=
 char **argv,
 					   opts.refs_snapshot, opts.flags);
=20
 		string_list_clear(&packs, 0);
+		free(opts.refs_snapshot);
=20
 		return ret;
=20
 	}
-	return write_midx_file(opts.object_dir, opts.preferred_pack,
-			       opts.refs_snapshot, opts.flags);
+
+	ret =3D write_midx_file(opts.object_dir, opts.preferred_pack,
+			      opts.refs_snapshot, opts.flags);
+
+	free(opts.refs_snapshot);
+	return ret;
 }
=20
 static int cmd_multi_pack_index_verify(int argc, const char **argv,
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0f52e25249..84a6adf681 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1011,6 +1011,7 @@ static int sparse_checkout_check_rules(int argc, cons=
t char **argv, const char *
=20
 	ret =3D check_rules(&pl, check_rules_opts.null_termination);
 	clear_pattern_list(&pl);
+	free(check_rules_opts.rules_file);
 	return ret;
 }
=20
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index ded8116cc5..5250913d99 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -207,6 +207,7 @@ int cmd__parse_options(int argc, const char **argv)
 	expect.strdup_strings =3D 1;
 	string_list_clear(&expect, 0);
 	string_list_clear(&list, 0);
+	free(file);
=20
 	return ret;
 }
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disamb=
iguation.sh
index 70f1e0a998..f9d68ce74e 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -23,6 +23,7 @@ one tagged as v1.0.0.  They all have one regular file eac=
h.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_cmp_failed_rev_parse () {
diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriti=
ng.sh
index 5c0bf4d21f..714feb83be 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test handling of overwriting untracked files'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_setup_reset () {
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index a1d7fa7f7c..82108b67e6 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -5,6 +5,7 @@ test_description=3D'messages from rebase operation'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 9f49c4228b..2c3f38d45a 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -5,6 +5,7 @@ test_description=3D'git rebase --abort tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t3428-rebase-signoff.sh b/t/t3428-rebase-signoff.sh
index 6f57aed9fa..365436ebfc 100755
--- a/t/t3428-rebase-signoff.sh
+++ b/t/t3428-rebase-signoff.sh
@@ -5,6 +5,7 @@ test_description=3D'git rebase --signoff
 This test runs git rebase --signoff and make sure that it works.
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
=20
diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index b1361ce546..40c92115a6 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -5,6 +5,7 @@
=20
 test_description=3D'git apply --build-fake-ancestor handling.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index edb38da701..1825a89d6a 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'am --abort'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t4253-am-keep-cr-dos.sh b/t/t4253-am-keep-cr-dos.sh
index 0ee69d2a0c..2bcdd9f34f 100755
--- a/t/t4253-am-keep-cr-dos.sh
+++ b/t/t4253-am-keep-cr-dos.sh
@@ -9,6 +9,7 @@ test_description=3D'git-am mbox with dos line ending.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Three patches which will be added as files with dos line ending.
diff --git a/t/t4255-am-submodule.sh b/t/t4255-am-submodule.sh
index a7ba08f728..04f3ccfc41 100755
--- a/t/t4255-am-submodule.sh
+++ b/t/t4255-am-submodule.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git am handling submodules'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index ad7f8c6f00..e99e728236 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -7,6 +7,7 @@ test_description=3D'Test the post-rewrite hook.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-mar=
kers.sh
index dd5fe6a402..a13271b349 100755
--- a/t/t6427-diff3-conflict-markers.sh
+++ b/t/t6427-diff3-conflict-markers.sh
@@ -5,6 +5,7 @@ test_description=3D'recursive merge diff3 style conflict ma=
rkers'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # Setup:
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 802f8f704c..cdd5f2c697 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -10,6 +10,7 @@ test_description=3D'git status advice'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
--=20
2.45.1.410.g58bac47f8e.dirty


--x27k3CrNUJVX01YA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkPgACgkQVbJhu7ck
PpTcDg/9FF2dUObDOovFe72QD+0zDeqmI4ZXShW8cBAdW3Xs06wEHVnkH1PKEK1P
tRzC4dzdmKteHlFQBmHeX2dW1jJZubUZR2sOQmMGVlYXhbxZ1mYCHl880wYhx+mS
ZvMpWk3jb47oI3Num1HA+vxEqa8Ba8KZTGnIvoKTilzcSQC8tdk/09JmGtgc7f8t
u0oMHwIrGGuabiBWV31+AuAXAwStvbJoFhGQlBSDStZoegAkxWApKFT/aQ8vyIx9
db7jldmAat/TydbXX7y6BVpE1Ot3AYCT2w4Ga2WRzk+xHrWwHayMvyPeBl+c9RXP
XNGARAsUlHpHxK9/to6IOAinuqF+r2VSWKHFT7ZqZpv7cGivAvY9S6m0Tfu4QhpF
TTXhl2KrPLwZBmqD12mH01d1b4SnZGLSfSMgwDmLqpAnPsTSZB2nH2g6Xn8Y5Wuo
jcQvCoYT5Cc7OSRuJWXnyl3Tx41/n+JHDLMYJ9WQ2F8MGvJsfd2l/PUz6A6ZOGE1
SF9LDg3eCcP3H3DdDPJHcBITgvGC3B7KF6PMi5Yx0Kl54mxSoJL3qtkyPk5nLOed
n+BwEYFdQMKkWuHcd7Dd4CpfwXNNTQCxNSsZIgvKFMV9GDjDPSHczlJ3xLa3rVjx
feMK4upAjkpP83+UzjQvHBXMmWzHzq9hqz07X6Alug4ki6aO+Vs=
=CIel
-----END PGP SIGNATURE-----

--x27k3CrNUJVX01YA--
