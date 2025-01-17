Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B91DED4C
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149522; cv=none; b=jrJwihfsBf5jb5EbbJtmezP8NJ3T+BhZCrTotPjDGGzx1WkC3NARrkOpoa5BDP1U7lGiy5svjrwtjuCUc3sfwQYqvpWLSMunJ/k7rnqnUPAVODIo29K/nlTNJmhIwZ6uMT3thhCms+L6OszxvYB5/eZRRaCrA6KoaagNxxZfXKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149522; c=relaxed/simple;
	bh=qdWBTvEsyhnISynpVtWPFBlLczrfQ2zXNVJuEe5MHwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N85CAO4Lqi0nZ1Zq1P+O2TQ7f+K3yTrfNiEZ1gU3t1H0ZxdvigxjTfaBZaOdkaMMl9spEMaC/yc57wycSFuXeHxI1Fmk/M67fls5j7HgjFBbZjJMjfBsOZ/WwTpPLwOUioX557qIJWrSwCrJp5OvCtL+o0McffkMxWhgOoshI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Elb2+/7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KECdoSdx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Elb2+/7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KECdoSdx"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 16F101380128;
	Fri, 17 Jan 2025 16:31:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 17 Jan 2025 16:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149519; x=
	1737235919; bh=U54O6BJq0xfeYopK+8UYDX75HmRsuOKw91nQZGy6fzg=; b=E
	lb2+/7kq2W00LmfAKRSVDBBh9T2JY6A70PDjfJZL3LLDGKwwTNhzEB7MBopVsiy0
	++b6dv1Gztq5gEz0uO39SugYwvuqevWIRFzZLqrddyQftQugKlmrGjus2YyQp/7M
	Tqq8LC/qzZP4R4kEmTaV5QXYletKFYi9Q2Jz04oNLJn5iBwzzDejeA3lscxBHd9f
	kWvrLacRN7af1KwK2G3Ia9erYyV06zaf87Wc0Tdh5fsxjedMOH4YPI+vyF3AFvfi
	i3eQ2Ez2+TiOiXojhTpx26abZE+Tib74Adyk7PbmzRhcuJldwLc0/BoQC1nJoxZ7
	yzJh7AFQx3j3hb+ihXIww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737149519; x=1737235919; bh=U
	54O6BJq0xfeYopK+8UYDX75HmRsuOKw91nQZGy6fzg=; b=KECdoSdxk5AOS+SvV
	6MHvbMLiCGo2CQdiWKSL6rnaPOKRHvgNVC5MLoOScOerQSPnSi7714mXmI/ZB+Ss
	qbBBiRNWBi1QKwLf+IW2Zee5ulmVoXYMXyLp6usbjW/NNQZxZDePvXQzDVFCFt2/
	p7aTrDzg/rv4ZlFKu+0xPoQtY78XxGILHNUOYxxA4Fw0S6T7JiBx6ohvcrNk0n3A
	ILq73wilIxQPau4A/U0IXXnBhTWpJOBWhqpaVOMiS3/6onf1dA07cKBu5wDmaII9
	aEfDAh0d6V1Zl5OXg5KAx+dJfe87visQdbtiTkCds+bQqgOhehW7aQVpWoN7m89n
	papkg==
X-ME-Sender: <xms:TsyKZ6BMTyJE80kE9SCTdu2i0dXKWsW-NLijs9vATLkc_5ZzIzzR6w>
    <xme:TsyKZ0h8EYau6fXlbwDp_Ck8EvumpCpHNtS6miKbGknPsJpcoJNQiRhZSDqKjElMJ
    uGemvd-v5xOUbWIjg>
X-ME-Received: <xmr:TsyKZ9ny2sT27GnWB4KceWeKuq7jUQosXeqjs279iPof9O8WCYG9vXlWquEIY9XCxkjwt14L5S4WsuQUjfyzMNn_6_eBgzVAYErg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvd
    fflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddvudeknecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:TsyKZ4zIV9oV4PEitzcZ_3yRYtFO4xu7z3_EZVi-4xmJzcH4v2LF-Q>
    <xmx:TsyKZ_Tv4Vpsn_imNoHYLt4EEJHG3N4BXr5inmPg_qckENSQJBmPiQ>
    <xmx:TsyKZzb_nv02f87PLdNS39-zkSS57QEwp60OEyS4UPH1tt9CoGI89g>
    <xmx:TsyKZ4S_YmJyIo1_JrSHEKhip9DHSl_hQF80rQ4mfgui_QqZ1WwYqQ>
    <xmx:T8yKZ5fVd8QYbDKJxD7voxB53JYM4Qj6sD2pl28B9ndYw6gt_hHeJFzi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v5 6/6] builtin: send usage() help text to standard output
Date: Fri, 17 Jan 2025 13:31:48 -0800
Message-ID: <20250117213148.3974552-7-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-218-gc7e8be6a8f
In-Reply-To: <20250117213148.3974552-1-gitster@pobox.com>
References: <20250116213553.2563751-1-gitster@pobox.com>
 <20250117213148.3974552-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the show_usage_and_exit_if_asked() helper we introduced
earlier, fix callers of usage() that want to show the help text when
explicitly asked by the end-user.  The help text now goes to the
standard output stream for them.

These are the bog standard "if we got only '-h', then that is a
request for help" callers.  Their

	if (argc == 2 && !strcmp(argv[1], "-h"))
		usage(message);

are simply replaced with

	show_usage_and_exit_if_asked(argc, argv, message);

With this, the built-ins tested by t0012 all send their help text to
their standard output stream, so the check in t0012 that was half
tightened earlier is now fully tightened to insist on standard error
stream being empty.

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ref-format.c  |  4 ++--
 builtin/diff-files.c        |  3 +--
 builtin/diff-index.c        |  3 +--
 builtin/diff-tree.c         |  3 +--
 builtin/fast-import.c       |  3 +--
 builtin/get-tar-commit-id.c |  4 +++-
 builtin/index-pack.c        |  3 +--
 builtin/mailsplit.c         |  4 ++--
 builtin/merge-index.c       |  7 ++++++-
 builtin/merge-ours.c        |  3 +--
 builtin/merge-recursive.c   |  6 ++++++
 builtin/pack-redundant.c    |  3 +--
 builtin/remote-ext.c        |  2 ++
 builtin/remote-fd.c         |  1 +
 builtin/rev-list.c          |  3 +--
 builtin/rev-parse.c         |  2 ++
 builtin/unpack-objects.c    |  2 ++
 builtin/upload-archive.c    |  3 +--
 t/t0012-help.sh             | 10 ++--------
 19 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index cef1ffe3ce..5d80afeec0 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -64,8 +64,8 @@ int cmd_check_ref_format(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_check_ref_format_usage);
+	show_usage_if_asked(argc, argv,
+			    builtin_check_ref_format_usage);
 
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 604b04bb2c..99b1749723 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -29,8 +29,7 @@ int cmd_diff_files(int argc,
 	int result;
 	unsigned options = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_files_usage);
+	show_usage_if_asked(argc, argv, diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index ebc824602e..81c0bc8ed7 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -26,8 +26,7 @@ int cmd_diff_index(int argc,
 	int i;
 	int result;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_cache_usage);
+	show_usage_if_asked(argc, argv, diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 40804e7b48..e31cc797fe 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -122,8 +122,7 @@ int cmd_diff_tree(int argc,
 	int read_stdin = 0;
 	int merge_base = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_tree_usage);
+	show_usage_if_asked(argc, argv, diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761..2da46fecdc 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3565,8 +3565,7 @@ int cmd_fast_import(int argc,
 {
 	unsigned int i;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(fast_import_usage);
+	show_usage_if_asked(argc, argv, fast_import_usage);
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 6bec0d1854..e4cd1627b4 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -13,7 +13,7 @@ static const char builtin_get_tar_commit_id_usage[] =
 #define HEADERSIZE (2 * RECORDSIZE)
 
 int cmd_get_tar_commit_id(int argc,
-			  const char **argv UNUSED,
+			  const char **argv,
 			  const char *prefix,
 			  struct repository *repo UNUSED)
 {
@@ -27,6 +27,8 @@ int cmd_get_tar_commit_id(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_if_asked(argc, argv, builtin_get_tar_commit_id_usage);
+
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0b62b2589f..d41b126ec0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1897,8 +1897,7 @@ int cmd_index_pack(int argc,
 	 */
 	fetch_if_missing = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(index_pack_usage);
+	show_usage_if_asked(argc, argv, index_pack_usage);
 
 	disable_replace_refs();
 	fsck_options.walk = mark_link;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 41dd304731..264df6259a 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -284,6 +284,8 @@ int cmd_mailsplit(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_if_asked(argc, argv, git_mailsplit_usage);
+
 	for (argp = argv+1; *argp; argp++) {
 		const char *arg = *argp;
 
@@ -297,8 +299,6 @@ int cmd_mailsplit(int argc,
 			continue;
 		} else if ( arg[1] == 'f' ) {
 			nr = strtol(arg+2, NULL, 10);
-		} else if ( arg[1] == 'h' ) {
-			usage(git_mailsplit_usage);
 		} else if ( arg[1] == 'b' && !arg[2] ) {
 			allow_bare = 1;
 		} else if (!strcmp(arg, "--keep-cr")) {
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 342699edb7..3314fb1336 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -75,6 +75,9 @@ static void merge_all(void)
 	}
 }
 
+static const char usage_string[] =
+"git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])";
+
 int cmd_merge_index(int argc,
 		    const char **argv,
 		    const char *prefix UNUSED,
@@ -87,8 +90,10 @@ int cmd_merge_index(int argc,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
+	show_usage_if_asked(argc, argv, usage_string);
+
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage(usage_string);
 
 	repo_read_index(the_repository);
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 3ecd9172f1..97b8a792c7 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -23,8 +23,7 @@ int cmd_merge_ours(int argc,
 		   const char *prefix UNUSED,
 		   struct repository *repo UNUSED)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_merge_ours_usage);
+	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
 
 	/*
 	 * The contents of the current index becomes the tree we
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 1dd295558b..abfc060e28 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -38,6 +38,12 @@ int cmd_merge_recursive(int argc,
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		struct strbuf msg = STRBUF_INIT;
+		strbuf_addf(&msg, builtin_merge_recursive_usage, argv[0]);
+		show_usage_if_asked(argc, argv, msg.buf);
+	}
+
 	if (argc < 4)
 		usagef(builtin_merge_recursive_usage, argv[0]);
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index e046575871..3febe732f8 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -595,8 +595,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	struct strbuf idx_name = STRBUF_INIT;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(pack_redundant_usage);
+	show_usage_if_asked(argc, argv, pack_redundant_usage);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 33c8ae0fc7..bd2037f27d 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -202,6 +202,8 @@ int cmd_remote_ext(int argc,
 {
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_if_asked(argc, argv, usage_msg);
+
 	if (argc != 3)
 		usage(usage_msg);
 
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index ae896eda57..39908546ba 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -64,6 +64,7 @@ int cmd_remote_fd(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_if_asked(argc, argv, usage_msg);
 	if (argc != 3)
 		usage(usage_msg);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3196da7b2d..28f148049f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -542,8 +542,7 @@ int cmd_rev_list(int argc,
 	const char *show_progress = NULL;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(rev_list_usage);
+	show_usage_if_asked(argc, argv, rev_list_usage);
 
 	git_config(git_default_config, NULL);
 	repo_init_revisions(the_repository, &revs, prefix);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 949747a6b6..428c866c05 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -713,6 +713,8 @@ int cmd_rev_parse(int argc,
 	int seen_end_of_options = 0;
 	enum format_type format = FORMAT_DEFAULT;
 
+	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
+
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2197d6d933..8faa6024b2 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -619,6 +619,8 @@ int cmd_unpack_objects(int argc,
 
 	quiet = !isatty(2);
 
+	show_usage_if_asked(argc, argv, unpack_usage);
+
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 9d76a31c8f..97d7c9522f 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -93,8 +93,7 @@ struct repository *repo UNUSED)
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(upload_archive_usage);
+	show_usage_if_asked(argc, argv, upload_archive_usage);
 
 	/*
 	 * Set up sideband subprocess.
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 9c7ae9fd36..d3a0967e9d 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -257,14 +257,8 @@ do
 			export GIT_CEILING_DIRECTORIES &&
 			test_expect_code 129 git -C sub $builtin -h >output 2>err
 		) &&
-		if test -n "$GIT_TEST_HELP_MUST_BE_STDOUT"
-		then
-			test_must_be_empty err &&
-			test_grep usage output
-		else
-			test_grep usage output ||
-			test_grep usage err
-		fi
+		test_must_be_empty err &&
+		test_grep usage output
 	'
 done <builtins
 
-- 
2.48.1-218-gc7e8be6a8f

