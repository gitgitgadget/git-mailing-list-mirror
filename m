Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795A117967F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097568; cv=none; b=O6X4LznW3cl8e4m6umZV8tre+qep6m7hw3eruJqyS0Zi0+6gOS8Q6FKDDHwYrbox6Xu2kyB9BsTpgbK/K7ilTyRTHi8DjEOObZeEzwVQtyRNduLLEQUqiMtzIHnkcdgP3QCto+hH+TEQWNRyXFFinwSkBRsc3QDK58MCLewtfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097568; c=relaxed/simple;
	bh=RhWfed/W8E9taIGycJimXHcsKo1Bdn2LqbXiXI6RIII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkkLvlBTNBtTBnhuc1BBETBtaTZkyGTiuD0BX1NFvdw+PZEzyRJOyM7cNIdbpA829+srYfSVJkplNdwHu+Jf3tmYPTTMF+4a+Jo/Mlr3belbREh7prLt3IZuCogW08y/y5eO0Et8efVnEh08jJ4dL4sn+zbt4yoVF+U4C1TFH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aW8qX2hL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bj3glJ98; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aW8qX2hL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bj3glJ98"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id A3F6618000B8;
	Tue, 11 Jun 2024 05:19:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097565; x=1718183965; bh=EFU3Jv45ZK
	Tyeoc78ug/EOiffVNwMwuc0q86MeG5f3Y=; b=aW8qX2hLsKWBDdKU6GE26hcWVR
	BRFUTsj4LsQ6jhAOm7T8Y2X0f+L4ZHGIxCdzl8p/o5VDvaMNcps0aR496CqdsgLy
	8gMa3/CI/rYiLUB4IegBUB/m6t/rW94YS7SbDEvNbhBVDBsZBmScTIXvkGAdvBHB
	RjPLKtbO0K0XlMh4jkdke6+oRoybTkqVloKYKyX1YMhQ8emofppmw6aLdysLCN+z
	/enGvF1W5NI22TK4hTHZvp+L3t0bKNDfEJQGI0PtX0SNp+6jnVpRka106ADxpIUf
	W+pp+kz7og5juAAXUVxddjDEUrdzbUg5geysZ0DpJnsjGuSA6q2dXQF0h7pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097565; x=1718183965; bh=EFU3Jv45ZKTyeoc78ug/EOiffVNw
	Mwuc0q86MeG5f3Y=; b=Bj3glJ98/cNe0u34rEy6WX1I/mORO1NEik1OzyxrJv2L
	hvGDAtlqOwERYpshPlHMVu68n6UWa9jMUMWXTz1SqNqdUrMXW6rdZ1kaozlTho8U
	FFkmFkQlW7fXzhGtb2JF4sRsWIK8iz1cqyjfh8aHIV6QLOYTTdElkcuYSYpYmHSc
	KeoPAJ9urSVL8tzDXhzJXEohEZ4H43yDqJFqrIKAaoNp6QaZWODKI7tWV+cwp8S6
	SJGYme026YQag/t5fobPQ+MBbxjqgocnG34l8AdlaWqZCY3MrC4DGvtDIkwMlKtj
	4MTOyfZtxHrvE5Fa9ZQXjxVLEp4rOrslWe38wcwNDw==
X-ME-Sender: <xms:nRZoZjy_GK-xImon-P3f0Fl4jkSbSH_34sDMtO4zGB1vL1Cv4trJZA>
    <xme:nRZoZrRwn2TwSzO7lnj58La5n8515P6cqBy9lc5NMVDr9j3oEV3Gr9O1zrYacykyi
    0mHfKCJe_s-wSUzDg>
X-ME-Received: <xmr:nRZoZtUMdQy3tJ9BJ3m-ZUd8u9b_01m4GrorgI5CQmI4QmV0Ap3I2ziGANJoaXS-KKF3kSgqCHuxBlYQ_Z3_TdIiHy0KDdWH7r6hMFWgYbuhB5YLxD7i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nRZoZthAnUZuetPoAXdsCYpqfREAHPhNkrYQ_YHCKeT-pdhVCGJ11Q>
    <xmx:nRZoZlBwmqzp2hlL5aqjD12qWTbBsaLfozWXOOgk6EleehJkL57DsQ>
    <xmx:nRZoZmJOUKn_RpS41bDnJ7rCjB8dElPi7PomZTy8jXBuptdH_miWgQ>
    <xmx:nRZoZkD9ku5q3RlnhIxdf3sv20Oiozp0C0EbaDbvnfqmkTlDMVGbrw>
    <xmx:nRZoZkNe28ukWmwu3aSMSff7CKYQLnEWgTQvPH5evzhD0FI_MtexutOm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aac3fbf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:15 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/29] parse-options: fix leaks for users of OPT_FILENAME
Message-ID: <84f2f56b717b2d081ca76532d821e474412dbc05.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ui81zAbuMulamupF"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--Ui81zAbuMulamupF
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
2.45.2.436.gcd77e87115.dirty


--Ui81zAbuMulamupF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFpkACgkQVbJhu7ck
PpRxYxAAm++IO2xKyiagFy8c6uMtGbAykBey4Lap8eMEWv8t5pPBPm+bbTw9rNtN
7X/+VyJdy5xGWW9PSl+eqtfcDbgOWQnkHd6+EEpnAmymq7ZJnnWIkgEMUDgPfti1
ijnfySHp6yfRyiI1e1e5zg25WUAT26HkgGxUFe6Lub2LJkJiAvupYhv3yH8rmR7R
6mnz3aH8yDHVCLLGRQUt3Y45qvHpDuAHhKqBrsnPtcKuo5RSB4k931eUYzB1xY4n
IYUGK5NYH6J23x6S5cqlnrMB/LgClL9AhdLOKKRD724qhQwLsnbO8omYa0vyUT9c
D4Ckvb4T1aiuNeCAik+PnWYHZibqTXyFdzWC6/XA4of4FtNjOxxc5myqsP9ur5JA
CSzZGQ+fY4XPOYV+8xbwJpmaHznqITAVsHN8JFPwrdLDbJ2Po+2EqPizKCsVCCFS
psjdg2u362Y7GiAtx68MsG5TcXSWk4FImkyhx1GDLC5jIdMnlVzRHnlBdVr6qK/1
OL4b/GXU47BqfpseIie712h4t1+rIG7MbU3x7QJGjdoO+8Aow5cdggwOfjQCA9Wm
TYufhvBJvTTbzdYvcBPHopo2BI0U+efr/hsdrAfURA2G4FIYiADiVw25LvFfMPWK
y3bQqoANpBy5ayus9igMbnndO/fYz9u2NE/8raPQOD6rL2XCMkU=
=0yDN
-----END PGP SIGNATURE-----

--Ui81zAbuMulamupF--
