Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDF7083C
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990737; cv=none; b=kuMuHvXH6C0KMPCYvycIenJonC8G6iZx13zEWra3ILmp0bLzuJQyutUtKaIRrF6bxgfjiym+BQejPT9RUSnuChXTdPQIzsNBFMvy/jDgQv6dKJhOcICqLGtZ1z3myfphgwtHNTrUHR6hfl3G3NvpHSgF51AamD4JILsa14b2WuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990737; c=relaxed/simple;
	bh=Tw17AmR3GvW1X2dVO6hB82i1ebZOI03vo99LJ3cTi2A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKGCv16V3cLy3WEQnFpCPlbWUqJ15NHej8001mxwTbkg21dFtVXgk2jk3KZU5kC2k62pNoZ5nuDJTn5lwG0goNqSVGe0mCBYPgA0JiJmDr7DnMlipIfWOO++YJRjbHmm+mXlJfTC7oLKHmr86bnwKspr7UejcJ9dLubH8KNGtCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RI0I6IFD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vc6a4DfM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RI0I6IFD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vc6a4DfM"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id CA8871380281;
	Wed, 15 Jan 2025 20:25:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 20:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736990734; x=
	1737077134; bh=fZAfMo+XaoMZxh88ZKe/QxA8R7bCuZbMT3j/MMWXDu0=; b=R
	I0I6IFDay5mKvBvv+SO3rWk9kRNu9/0ys8h5o/F6TARmujG/qCU72ng4ltQyIojE
	ngajHMGE7vlvKTcatloFjL6CY/dlxTcPUJs2NCQXYoijHFQ5AMTIoObZmEAR9I2n
	CqWRwrBmslgV6AF4uTuiG48Ta3p4K2t59R4hT4mC6TuNVBev65ZbO1EOPImZIkAw
	jSD3Hgqqm0yurDw050ev6IRb+E0CX4v+ddsV4GydgiCnPuLE1z4ylexH1aoz7WTZ
	8etnYW+a8BJ7t1g9E3tVSAfY4/qK0Og6OqrpxZdcB+HXQQmacBPhUcgTayujibDO
	CM6/gW9f+TJryLDDNciKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736990734; x=1737077134; bh=fZAfMo+XaoMZxh88ZKe/QxA8R7bC
	uZbMT3j/MMWXDu0=; b=Vc6a4DfMeeXRBRe/Hn1tbYKARiqj8d6TJcbj071HRHLi
	bIFWGLD/JJ7ScvDOcsNXMjB5MmIfsR3kUjIAKGpwR8mrj3iJbkNOSjL+mZN4APNG
	QvOjrdeROULtof6TG8zV/4rXZkmQ8OBCzItPUcBA/2h7m2O21PVImXR/1KoAKRnf
	hEBUXGWMUXj1aDC7a66tBz1Ywci0acbRnicXF0pyNt8TsAzZ0GBA8MMKSHCQiWwY
	5vo3dJml3RGlr+65MB7Rtt2syXd8lR5TZUzW4t9fM5rlpNB9K4pZK9toKAPXJcBm
	9GFYoMzFjOBCNVZZXnH3CiLa0hrFFugV5UuU/Yhnwg==
X-ME-Sender: <xms:DmCIZ_FF_r2qfV5NvVshs8_R_uHZ91RvWX6zLeKkS89NhhzkLuJyXw>
    <xme:DmCIZ8VpPBhlCVM3FhM2RswKVmIuGFY9N4JVcLTxusQCVLxPNj5TmMnmy9UC5BNTy
    oCVVJctzPhr0aeS5g>
X-ME-Received: <xmr:DmCIZxJfvOeCDbNTv6mEMT1RDMeLBa_uaB8GnhGCH9mQhX6tp2rNAWI4eRUgjgCAer6gFG6RrrpsAbyUWypb524w6Wgib5fCjfS_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepleevie
    efieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DmCIZ9ESGm6fJXFmsHCGr84C7ue9LvIJVUjvhy9ypuwWISNJqc0jWA>
    <xmx:DmCIZ1WN8SBRNQoSomVCvSjXjETaVF8SKTx4quDHHJ_2pXpjyu_i9w>
    <xmx:DmCIZ4MnFo3IjyhkZivbJaT2gG0n8lkQDQH0Y1hTFbmhA0PsEHkbnA>
    <xmx:DmCIZ00WUHMC5b534niy3ckgn88DrAnArXV3pkzPvOJF0xwMvR599A>
    <xmx:DmCIZygQ_zp3dC-dxXsUDgpAglk295MghWOThB40TnhIiW0lGZLsaZrq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 6/6] builtin: send usage() help text to standard output
Date: Wed, 15 Jan 2025 17:25:23 -0800
Message-ID: <20250116012524.1557441-7-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-191-gafe818080f
In-Reply-To: <20250116012524.1557441-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ref-format.c  |  4 ++--
 builtin/diff-files.c        |  3 +--
 builtin/diff-index.c        |  3 +--
 builtin/diff-tree.c         |  3 +--
 builtin/fast-import.c       |  3 +--
 builtin/fetch-pack.c        |  3 +++
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
 t/helper/test-simple-ipc.c  |  4 ++--
 t/t0012-help.sh             | 10 ++--------
 21 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index cef1ffe3ce..acc4366d85 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -64,8 +64,8 @@ int cmd_check_ref_format(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_check_ref_format_usage);
+	show_usage_and_exit_if_asked(argc, argv,
+				     builtin_check_ref_format_usage);
 
 	if (argc == 3 && !strcmp(argv[1], "--branch"))
 		return check_ref_format_branch(argv[2]);
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 604b04bb2c..f8816e0d9e 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -29,8 +29,7 @@ int cmd_diff_files(int argc,
 	int result;
 	unsigned options = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_files_usage);
+	show_usage_and_exit_if_asked(argc, argv, diff_files_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index ebc824602e..a1759b8291 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -26,8 +26,7 @@ int cmd_diff_index(int argc,
 	int i;
 	int result;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_cache_usage);
+	show_usage_and_exit_if_asked(argc, argv, diff_cache_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 40804e7b48..fc7c026555 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -122,8 +122,7 @@ int cmd_diff_tree(int argc,
 	int read_stdin = 0;
 	int merge_base = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(diff_tree_usage);
+	show_usage_and_exit_if_asked(argc, argv, diff_tree_usage);
 
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 0f86392761..e1f6bfdc73 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3565,8 +3565,7 @@ int cmd_fast_import(int argc,
 {
 	unsigned int i;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(fast_import_usage);
+	show_usage_and_exit_if_asked(argc, argv, fast_import_usage);
 
 	reset_pack_idx_option(&pack_idx_opts);
 	git_pack_config();
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index bed2816c2d..9bd4b29c5b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -176,6 +176,9 @@ int cmd_fetch_pack(int argc,
 			list_objects_filter_set_no_filter(&args.filter_options);
 			continue;
 		}
+
+		if (!strcmp(arg, "-h"))
+			show_usage_and_exit_if_asked(2, &arg - 1, fetch_pack_usage);
 		usage(fetch_pack_usage);
 	}
 	if (deepen_not.nr)
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 6bec0d1854..033a205ba4 100644
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
 
+	show_usage_and_exit_if_asked(argc, argv, builtin_get_tar_commit_id_usage);
+
 	if (argc != 1)
 		usage(builtin_get_tar_commit_id_usage);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0b62b2589f..92ef59fad5 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1897,8 +1897,7 @@ int cmd_index_pack(int argc,
 	 */
 	fetch_if_missing = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(index_pack_usage);
+	show_usage_and_exit_if_asked(argc, argv, index_pack_usage);
 
 	disable_replace_refs();
 	fsck_options.walk = mark_link;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 41dd304731..9e11bffdfb 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -284,6 +284,8 @@ int cmd_mailsplit(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_and_exit_if_asked(argc, argv, git_mailsplit_usage);
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
index 342699edb7..f243a55d32 100644
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
 
+	show_usage_and_exit_if_asked(argc, argv, usage_string);
+
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
+		usage(usage_string);
 
 	repo_read_index(the_repository);
 
diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 3ecd9172f1..ab78fffb52 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -23,8 +23,7 @@ int cmd_merge_ours(int argc,
 		   const char *prefix UNUSED,
 		   struct repository *repo UNUSED)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_merge_ours_usage);
+	show_usage_and_exit_if_asked(argc, argv, builtin_merge_ours_usage);
 
 	/*
 	 * The contents of the current index becomes the tree we
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 1dd295558b..b71c7e1c2f 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -38,6 +38,12 @@ int cmd_merge_recursive(int argc,
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
+	if (argc == 2 && !strcmp(argv[1], "-h")) {
+		struct strbuf msg = STRBUF_INIT;
+		strbuf_addf(&msg, builtin_merge_recursive_usage, argv[0]);
+		show_usage_and_exit_if_asked(argc, argv, msg.buf);
+	}
+
 	if (argc < 4)
 		usagef(builtin_merge_recursive_usage, argv[0]);
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index e046575871..ce2e1fde8d 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -595,8 +595,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	struct strbuf idx_name = STRBUF_INIT;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(pack_redundant_usage);
+	show_usage_and_exit_if_asked(argc, argv, pack_redundant_usage);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 33c8ae0fc7..f7591e7701 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -202,6 +202,8 @@ int cmd_remote_ext(int argc,
 {
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_and_exit_if_asked(argc, argv, usage_msg);
+
 	if (argc != 3)
 		usage(usage_msg);
 
diff --git a/builtin/remote-fd.c b/builtin/remote-fd.c
index ae896eda57..1a1aa65273 100644
--- a/builtin/remote-fd.c
+++ b/builtin/remote-fd.c
@@ -64,6 +64,7 @@ int cmd_remote_fd(int argc,
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
+	show_usage_and_exit_if_asked(argc, argv, usage_msg);
 	if (argc != 3)
 		usage(usage_msg);
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3196da7b2d..5a21d57c43 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -542,8 +542,7 @@ int cmd_rev_list(int argc,
 	const char *show_progress = NULL;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(rev_list_usage);
+	show_usage_and_exit_if_asked(argc, argv, rev_list_usage);
 
 	git_config(git_default_config, NULL);
 	repo_init_revisions(the_repository, &revs, prefix);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 949747a6b6..f4c2b1b000 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -713,6 +713,8 @@ int cmd_rev_parse(int argc,
 	int seen_end_of_options = 0;
 	enum format_type format = FORMAT_DEFAULT;
 
+	show_usage_and_exit_if_asked(argc, argv, builtin_rev_parse_usage);
+
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
 		return cmd_parseopt(argc - 1, argv + 1, prefix);
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2197d6d933..1f1fb8e682 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -619,6 +619,8 @@ int cmd_unpack_objects(int argc,
 
 	quiet = !isatty(2);
 
+	show_usage_and_exit_if_asked(argc, argv, unpack_usage);
+
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 3b282d41e6..42d8f67174 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -93,8 +93,7 @@ struct repository *repo UNUSED)
 
 	BUG_ON_NON_EMPTY_PREFIX(prefix);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(upload_archive_usage);
+	show_usage_and_exit_if_asked(argc, argv, upload_archive_usage);
 
 	/*
 	 * Set up sideband subprocess.
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index fb5927775d..d7a41cd053 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -612,8 +612,8 @@ int cmd__simple_ipc(int argc, const char **argv)
 	if (argc < 2)
 		usage_with_options(simple_ipc_usage, options);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(simple_ipc_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  simple_ipc_usage, options);
 
 	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
 		return 0;
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
2.48.1-191-gafe818080f

