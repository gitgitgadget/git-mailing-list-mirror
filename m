Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D113D3D05
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876701; cv=none; b=NlJEVOicmB9AFGa0wYtepFmmCyv+ivsnF4LFfx52krAdj0Nif9oqRNUCQzSQY0tXXggC5Igr1R3Itlgjk+1bcIj4n5QX9zoxCGoNndSTWrR3GI6DaMitkBPV4S/Osd/HpduOUKn0t7UDrUDvFr4QtJRQNy5aoAKDo472MV78lPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876701; c=relaxed/simple;
	bh=LxaqVitBViikqGDCB1G8eG6bQfM8CN0mY/79KP0LTk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZmJzTOsKpfWtAJjIX+hkDf+Tg9MxjKHc3QcJI4UJljiSSv8/n/LlN6Ga0Fqp1adnPonmL+7u7zGfiMS2Np+BRJJY4Gh1bjwIL+PcEPOsamvh2Zb9j6pjDSqsHxkD2wuHVxQ0Zb/Ou3+ifB2HapK/LP99jIa3FLqc9z/38Ch+vNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iVSvCpE4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cTz5V5O4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iVSvCpE4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cTz5V5O4"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9EDE87A009C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 30 Mar 2026 09:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876698;
	 x=1774963098; bh=6jCp6KI4rY0DWp9TpCthMS4+h49RZ/bNz0mTOcv6+ag=; b=
	iVSvCpE45+MTr/l1u3+/8q9ttcYnE86hhypWm21nZqcgE8FYJLz0ETZTquh5TgX5
	vQmxSn9+10K1vf+6rfQWtDR4nPAGqGsWLcBqEQvOQyF+Cjctu/DPd4l2oM7FZbpz
	IRSdHlawN3HdInFQHI8AhVGkt8krJ/z+LfpSjGeGbzkE+F2dmRTuMW64HoTyjzuy
	Ljv0BY8VtfYKJFHI0cH8iWBdMTLYO4AbLDkdCjqMIiePHsWaK+w8WZRj+zQThQQ0
	NVtKDiN4ltLpnN/gGIHfN8NmHLliVwqisvkfv2Gz+gUIDg/6o7dOnWFG3j6J4r72
	RTgs9jGf80GR36JQlVu5jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876698; x=
	1774963098; bh=6jCp6KI4rY0DWp9TpCthMS4+h49RZ/bNz0mTOcv6+ag=; b=c
	Tz5V5O4pyXspusLkLllEmI0UybrVTl15v7zE0yfgU1hXPA4rEDtZwptJMrZr+utB
	44mVho/sIr6pJXOYNeER5h6d/Ngpc1VJ+zRI+UWLCg4JC5wb6qMkbls9DTReH9+o
	N0dnKsn7J4+rxLYziMSop/+CR+u5Kr/AGaIjeKy+WwipWFRkndF9FGSJGfooWyUN
	zqwtUMmllcUEZwFzhvx0c7jij8rDvUEqQ/z1PQ+WWTamjcKsJVz51fKbtrKVKMFD
	R5lkl0UEPrmp7VytQHDf+uQMbZZONEx0qeEhsQHKswiWdQgd9fXHO1YIe7c+vSC8
	D85tomLq1l3B0vG5jl4Ng==
X-ME-Sender: <xms:GnjKaX6ysKHARPI4TYN8IFebuQpRy3HSKA5s42JCY6N4n8Mbf94oIg>
    <xme:GnjKaT1IYQ8iYTxBJZYEO10NR-T0hzlrHldultIjZ0bEFKkB8-xYAt1J33ZvwVa59
    ulyboEtJW6hwGeyih2DUEet7A0EGY1VZzQl56gCuDYh3xV-pr0S>
X-ME-Received: <xmr:GnjKaUH7sO3vP5jxouvQxirsHNyH8jBdY_ka3dHGycC4USBJEW4sP1VNeeH5W7CauRwJqxfT0DRBE0rZAidJMK3jKzBg12oxIK4EfYTeTjCbSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:GnjKadTheJy7ZS53aK88ybTa2v7Z4WJuTPmHn_G4C937-l60vD4p5A>
    <xmx:GnjKabCU8eK79UX9nXkaDV9oX1CCBF5f_pLU3uQddNZt0_3lMK_3oQ>
    <xmx:GnjKad1bXSCdxk1rQdHeg7ia6W0ZqkrPXMdY7ZUoONgxYvBJwK0wjQ>
    <xmx:GnjKaZW0Aw0qU4dQJ3QWPJiaPZusF54ZEa0zhPL8T_rmDZqxEWmHNw>
    <xmx:GnjKaUZOeeIsTDUOQOgiGSebeODJDwi1m7g_TuysX_S2FOCUr7f1l4sl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f9df8f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:35 +0200
Subject: [PATCH 13/18] setup: stop using `the_repository` in
 `setup_git_directory()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-13-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `setup_git_directory()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive.c                                    |  2 +-
 builtin/grep.c                               |  2 +-
 builtin/hash-object.c                        |  2 +-
 builtin/merge-file.c                         |  2 +-
 builtin/rev-parse.c                          |  4 ++--
 git.c                                        |  2 +-
 http-push.c                                  |  2 +-
 scalar.c                                     |  4 ++--
 setup.c                                      |  4 ++--
 setup.h                                      |  2 +-
 t/helper/test-advise.c                       |  2 +-
 t/helper/test-bitmap.c                       |  2 +-
 t/helper/test-bloom.c                        |  2 +-
 t/helper/test-cache-tree.c                   |  2 +-
 t/helper/test-config.c                       |  2 +-
 t/helper/test-dump-cache-tree.c              |  2 +-
 t/helper/test-dump-fsmonitor.c               |  2 +-
 t/helper/test-dump-split-index.c             |  2 +-
 t/helper/test-dump-untracked-cache.c         |  2 +-
 t/helper/test-find-pack.c                    |  2 +-
 t/helper/test-fsmonitor-client.c             |  2 +-
 t/helper/test-lazy-init-name-hash.c          |  2 +-
 t/helper/test-match-trees.c                  |  2 +-
 t/helper/test-pack-deltas.c                  |  2 +-
 t/helper/test-pack-mtimes.c                  |  2 +-
 t/helper/test-partial-clone.c                |  4 +++-
 t/helper/test-path-walk.c                    |  2 +-
 t/helper/test-reach.c                        |  2 +-
 t/helper/test-read-cache.c                   |  2 +-
 t/helper/test-read-graph.c                   |  2 +-
 t/helper/test-read-midx.c                    |  2 +-
 t/helper/test-ref-store.c                    |  2 +-
 t/helper/test-revision-walking.c             |  2 +-
 t/helper/test-scrap-cache-tree.c             |  2 +-
 t/helper/test-serve-v2.c                     |  2 +-
 t/helper/test-submodule-config.c             |  2 +-
 t/helper/test-submodule-nested-repo-config.c |  2 +-
 t/helper/test-submodule.c                    | 10 +++++-----
 t/helper/test-userdiff.c                     |  2 +-
 t/helper/test-write-cache.c                  |  2 +-
 40 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/archive.c b/archive.c
index fcd474c682..51229107a5 100644
--- a/archive.c
+++ b/archive.c
@@ -786,7 +786,7 @@ int write_archive(int argc, const char **argv, const char *prefix,
 		 * die ourselves; but its error message will be more specific
 		 * than what we could write here.
 		 */
-		setup_git_directory();
+		setup_git_directory(the_repository);
 	}
 
 	parse_treeish_arg(argv, &args, remote);
diff --git a/builtin/grep.c b/builtin/grep.c
index 679f8b567a..560133feb8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1064,7 +1064,7 @@ int cmd_grep(int argc,
 			use_index = 0;
 		else
 			/* die the same way as if we did it at the beginning */
-			setup_git_directory();
+			setup_git_directory(the_repository);
 	}
 	/* Ignore --recurse-submodules if --no-index is given or implied */
 	if (!use_index)
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index d7905bedc2..f306b0643f 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -100,7 +100,7 @@ int cmd_hash_object(int argc,
 			     hash_object_usage, 0);
 
 	if (flags & INDEX_WRITE_OBJECT)
-		prefix = setup_git_directory();
+		prefix = setup_git_directory(the_repository);
 	else
 		prefix = setup_git_directory_gently(the_repository, &nongit);
 
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 59a9792208..8fa5765239 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -110,7 +110,7 @@ int cmd_merge_file(int argc,
 
 	if (!repo && object_id)
 		/* emit the correct "not a git repo" error in this case */
-		setup_git_directory();
+		setup_git_directory(the_repository);
 
 	for (i = 0; i < 3; i++) {
 		char *fname;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d7c6400ddc..426a3c5676 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -739,7 +739,7 @@ int cmd_rev_parse(int argc,
 
 	/* No options; just report on whether we're in a git repo or not. */
 	if (argc == 1) {
-		setup_git_directory();
+		setup_git_directory(the_repository);
 		repo_config(the_repository, git_default_config, NULL);
 		return 0;
 	}
@@ -774,7 +774,7 @@ int cmd_rev_parse(int argc,
 
 		/* The rest of the options require a git repository. */
 		if (!did_repo_setup) {
-			prefix = setup_git_directory();
+			prefix = setup_git_directory(the_repository);
 			repo_config(the_repository, git_default_config, NULL);
 			did_repo_setup = 1;
 
diff --git a/git.c b/git.c
index 0df36c9b9d..78bd607e2f 100644
--- a/git.c
+++ b/git.c
@@ -477,7 +477,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 		run_setup = RUN_SETUP_GENTLY;
 
 	if (run_setup & RUN_SETUP) {
-		prefix = setup_git_directory();
+		prefix = setup_git_directory(the_repository);
 		no_repo = 0;
 	} else if (run_setup & RUN_SETUP_GENTLY) {
 		prefix = setup_git_directory_gently(the_repository, &no_repo);
diff --git a/http-push.c b/http-push.c
index 9ae6062198..ee66813012 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1788,7 +1788,7 @@ int cmd_main(int argc, const char **argv)
 	if (delete_branch && rs.nr != 1)
 		die("You must specify only one branch name when deleting a remote branch");
 
-	gitdir = setup_git_directory();
+	gitdir = setup_git_directory(the_repository);
 
 	memset(remote_dir_exists, -1, 256);
 
diff --git a/scalar.c b/scalar.c
index 4efb6ac36d..a80d8ee3ff 100644
--- a/scalar.c
+++ b/scalar.c
@@ -58,7 +58,7 @@ static void setup_enlistment_directory(int argc, const char **argv,
 	}
 	strbuf_setlen(&path, len);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (!the_repository->worktree)
 		die(_("Scalar enlistments require a worktree"));
@@ -514,7 +514,7 @@ static int cmd_clone(int argc, const char **argv)
 		goto cleanup;
 	}
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	/* common-main already logs `argv` */
 	trace2_def_repo(the_repository);
diff --git a/setup.c b/setup.c
index 99c0d1640e..da0576d28a 100644
--- a/setup.c
+++ b/setup.c
@@ -2133,9 +2133,9 @@ void check_repository_format(struct repository_format *fmt)
  * directory is not a strict subdirectory of the work tree root. The
  * prefix always ends with a '/' character.
  */
-const char *setup_git_directory(void)
+const char *setup_git_directory(struct repository *repo)
 {
-	return setup_git_directory_gently(the_repository, NULL);
+	return setup_git_directory_gently(repo, NULL);
 }
 
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
diff --git a/setup.h b/setup.h
index 18092fbf16..b779661ce7 100644
--- a/setup.h
+++ b/setup.h
@@ -137,7 +137,7 @@ enum {
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags);
 
 const char *setup_git_directory_gently(struct repository *repo, int *);
-const char *setup_git_directory(void);
+const char *setup_git_directory(struct repository *repo);
 char *prefix_path(struct repository *repo, const char *prefix, int len, const char *path);
 char *prefix_path_gently(struct repository *repo, const char *prefix, int len, int *remaining, const char *path);
 
diff --git a/t/helper/test-advise.c b/t/helper/test-advise.c
index 81ed93a05c..8f9db2693e 100644
--- a/t/helper/test-advise.c
+++ b/t/helper/test-advise.c
@@ -11,7 +11,7 @@ int cmd__advise_if_enabled(int argc, const char **argv)
 	if (argc != 2)
 		die("usage: %s <advice>", argv[0]);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	repo_config(the_repository, git_default_config, NULL);
 
 	/*
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index 16a01669e4..d9b9a83b8f 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -37,7 +37,7 @@ static int bitmap_dump_pseudo_merge_objects(uint32_t n)
 
 int cmd__bitmap(int argc, const char **argv)
 {
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc == 2 && !strcmp(argv[1], "list-commits"))
 		return bitmap_list_commits();
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 3283544bd3..0c65befbf0 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -52,7 +52,7 @@ static const char *const bloom_usage = "\n"
 
 int cmd__bloom(int argc, const char **argv)
 {
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc < 2)
 		usage(bloom_usage);
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index ff61d0ca7e..d42e260092 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -33,7 +33,7 @@ int cmd__cache_tree(int argc, const char **argv)
 		OPT_END()
 	};
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	argc = parse_options(argc, argv, NULL, options, test_cache_tree_usage, 0);
 
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 9f8cca7c48..cfb3f4b111 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -102,7 +102,7 @@ int cmd__config(int argc, const char **argv)
 		return 0;
 	}
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	git_configset_init(&cs);
 
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 3f0c7d0ed0..ccb41a4239 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -66,7 +66,7 @@ int cmd__dump_cache_tree(int ac UNUSED, const char **av UNUSED)
 	struct cache_tree *another = cache_tree();
 	int ret;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
 	istate = *the_repository->index;
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index efd017ca35..c991cbbb8a 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -9,7 +9,7 @@ int cmd__dump_fsmonitor(int ac UNUSED, const char **av UNUSED)
 {
 	struct index_state *istate = the_repository->index;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	if (do_read_index(istate, the_repository->index_file, 0) < 0)
 		die("unable to read index file");
 	if (!istate->fsmonitor_last_update) {
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index f855a3862c..aae0a40a74 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -17,7 +17,7 @@ int cmd__dump_split_index(int ac UNUSED, const char **av)
 {
 	struct split_index *si;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	do_read_index(the_repository->index, av[1], 1);
 	printf("own %s\n", oid_to_hex(&the_repository->index->oid));
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index 01a109496b..24308bd371 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -54,7 +54,7 @@ int cmd__dump_untracked_cache(int ac UNUSED, const char **av UNUSED)
 	xsetenv("GIT_CONFIG_KEY_0", "core.untrackedCache", 1);
 	xsetenv("GIT_CONFIG_VALUE_0", "keep", 1);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
 	uc = the_repository->index->untracked;
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index fc4b8a77b3..28d5b1fe09 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -25,7 +25,7 @@ int cmd__find_pack(int argc, const char **argv)
 	struct object_id oid;
 	struct packed_git *p;
 	int count = -1, actual_count = 0;
-	const char *prefix = setup_git_directory();
+	const char *prefix = setup_git_directory(the_repository);
 
 	struct option options[] = {
 		OPT_INTEGER('c', "check-count", &count, "expected number of packs"),
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 02bfe92e8d..dc1dff23fb 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -210,7 +210,7 @@ int cmd__fsmonitor_client(int argc, const char **argv)
 
 	subcmd = argv[0];
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (!strcmp(subcmd, "query"))
 		return !!do_send_query(token);
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 40f5df4412..e542985c94 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -211,7 +211,7 @@ int cmd__lazy_init_name_hash(int argc, const char **argv)
 	const char *prefix;
 	uint64_t avg_single, avg_multi;
 
-	prefix = setup_git_directory();
+	prefix = setup_git_directory(the_repository);
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 2ed064b971..006ce5278e 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -13,7 +13,7 @@ int cmd__match_trees(int ac UNUSED, const char **av)
 	struct object_id hash1, hash2, shifted;
 	struct tree *one, *two;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (repo_get_oid(the_repository, av[1], &hash1))
 		die("cannot parse %s as an object name", av[1]);
diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 4981401eaa..c493b75e02 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -95,7 +95,7 @@ int cmd__pack_deltas(int argc, const char **argv)
 	if (argc || num_objects < 0)
 		usage_with_options(usage_str, options);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	f = hashfd(the_repository->hash_algo, 1, "<stdout>");
 	write_pack_header(f, num_objects);
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 7a8ee1de24..b774056799 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -32,7 +32,7 @@ int cmd__pack_mtimes(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	struct packed_git *p;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc != 2)
 		usage(pack_mtimes_usage);
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index d848800749..a7aab426d0 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -1,3 +1,5 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "test-tool.h"
 #include "hex.h"
 #include "repository.h"
@@ -32,7 +34,7 @@ static void object_info(const char *gitdir, const char *oid_hex)
 
 int cmd__partial_clone(int argc, const char **argv)
 {
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc < 4)
 		die("too few arguments");
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index fe63002c2b..69676b15a5 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -89,7 +89,7 @@ int cmd__path_walk(int argc, const char **argv)
 		OPT_END(),
 	};
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	revs.repo = the_repository;
 
 	argc = parse_options(argc, argv, NULL,
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 3131b54a87..5d86a96c17 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -39,7 +39,7 @@ int cmd__reach(int ac, const char **av)
 	struct strbuf buf = STRBUF_INIT;
 	struct repository *r = the_repository;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (ac < 2)
 		exit(1);
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 9ae71cefb3..6b08ba8f07 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -19,7 +19,7 @@ int cmd__read_cache(int argc, const char **argv)
 
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	repo_config(the_repository, git_default_config, NULL);
 
 	for (i = 0; i < cnt; i++) {
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 6a5f64e473..9f07b9c25a 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -76,7 +76,7 @@ int cmd__read_graph(int argc, const char **argv)
 	struct odb_source *source;
 	int ret = 0;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	source = the_repository->objects->sources;
 
 	prepare_repo_settings(the_repository);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 388d29e2b5..790000fb26 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -14,7 +14,7 @@
 static struct multi_pack_index *setup_midx(const char *object_dir)
 {
 	struct odb_source *source;
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	source = odb_find_source(the_repository->objects, object_dir);
 	if (!source)
 		source = odb_add_to_alternates_memory(the_repository->objects,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 74edf2029a..3866d0aca4 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -340,7 +340,7 @@ int cmd__ref_store(int argc UNUSED, const char **argv)
 	const char *func;
 	struct command *cmd;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	argv = get_store(argv + 1, &refs);
 
diff --git a/t/helper/test-revision-walking.c b/t/helper/test-revision-walking.c
index 071f5bd1e2..70051eeaf8 100644
--- a/t/helper/test-revision-walking.c
+++ b/t/helper/test-revision-walking.c
@@ -56,7 +56,7 @@ int cmd__revision_walking(int argc, const char **argv)
 	if (argc < 2)
 		return 1;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (!strcmp(argv[1], "run-twice")) {
 		printf("1st\n");
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 64fff6e9e3..7b5ce501d9 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -12,7 +12,7 @@ int cmd__scrap_cache_tree(int ac UNUSED, const char **av UNUSED)
 {
 	struct lock_file index_lock = LOCK_INIT;
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	repo_hold_locked_index(the_repository, &index_lock, LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		die("unable to read index file");
diff --git a/t/helper/test-serve-v2.c b/t/helper/test-serve-v2.c
index 63a200b8d4..27f3ed8947 100644
--- a/t/helper/test-serve-v2.c
+++ b/t/helper/test-serve-v2.c
@@ -23,7 +23,7 @@ int cmd__serve_v2(int argc, const char **argv)
 			 N_("exit immediately after advertising capabilities")),
 		OPT_END()
 	};
-	const char *prefix = setup_git_directory();
+	const char *prefix = setup_git_directory(the_repository);
 
 	/* ignore all unknown cmdline switches for now */
 	argc = parse_options(argc, argv, prefix, options, serve_usage,
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index cbe93f2f9e..3f30292179 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -34,7 +34,7 @@ int cmd__submodule_config(int argc, const char **argv)
 	if (my_argc % 2 != 0)
 		die_usage(argc, argv, "Wrong number of arguments.");
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	while (*arg) {
 		struct object_id commit_oid;
diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index 2710341cd5..7e31d3fe47 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -19,7 +19,7 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv)
 	if (argc < 3)
 		die_usage(argv, "Wrong number of arguments.");
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (repo_submodule_init(&subrepo, the_repository, argv[1], null_oid(the_hash_algo))) {
 		die_usage(argv, "Submodule not found.");
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 0133852e1e..3c5c4c4a09 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -99,7 +99,7 @@ static int cmd__submodule_is_active(int argc, const char **argv)
 	if (argc != 1)
 		usage_with_options(submodule_is_active_usage, options);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	return !is_submodule_active(the_repository, argv[0]);
 }
@@ -142,7 +142,7 @@ static int cmd__submodule_config_list(int argc, const char **argv)
 	argc = parse_options(argc, argv, "test-tools", options, usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc == 2)
 		return print_config_from_gitmodules(the_repository, argv[1]);
@@ -161,7 +161,7 @@ static int cmd__submodule_config_set(int argc, const char **argv)
 	argc = parse_options(argc, argv, "test-tools", options, usage,
 			     PARSE_OPT_KEEP_ARGV0);
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	/* Equivalent to ACTION_SET in builtin/config.c */
 	if (argc == 3) {
@@ -183,7 +183,7 @@ static int cmd__submodule_config_unset(int argc, const char **argv)
 		NULL
 	};
 
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc == 2) {
 		if (!is_writing_gitmodules_ok())
@@ -202,7 +202,7 @@ static int cmd__submodule_config_writeable(int argc, const char **argv UNUSED)
 		"test-tool submodule config-writeable",
 		NULL
 	};
-	setup_git_directory();
+	setup_git_directory(the_repository);
 
 	if (argc == 1)
 		return is_writing_gitmodules_ok() ? 0 : -1;
diff --git a/t/helper/test-userdiff.c b/t/helper/test-userdiff.c
index aa3a9894d2..fc34c589b3 100644
--- a/t/helper/test-userdiff.c
+++ b/t/helper/test-userdiff.c
@@ -40,7 +40,7 @@ int cmd__userdiff(int argc, const char **argv)
 		return error("unknown argument %s", argv[1]);
 
 	if (want & USERDIFF_DRIVER_TYPE_CUSTOM) {
-		setup_git_directory();
+		setup_git_directory(the_repository);
 		repo_config(the_repository, cmd__userdiff_config, NULL);
 	}
 
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index b37dd2c5d6..98e1477c98 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -12,7 +12,7 @@ int cmd__write_cache(int argc, const char **argv)
 	int i, cnt = 1;
 	if (argc == 2)
 		cnt = strtol(argv[1], NULL, 0);
-	setup_git_directory();
+	setup_git_directory(the_repository);
 	repo_read_index(the_repository);
 	for (i = 0; i < cnt; i++) {
 		repo_hold_locked_index(the_repository, &index_lock,

-- 
2.53.0.1185.g05d4b7b318.dirty

