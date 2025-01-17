Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF11DE3B3
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149518; cv=none; b=o1KGzUCqIqnEND7/pyIOd7RtnZyfYFqKMZ7dSsqgj6kswiMzJTmb57xrCmdwsn9OVrnc6yHjhd7ySUPXuNVNA2plCtQUhS6lT+XxBVgm54UDzQGen1DGt4YENEKWurpcX/LmfnaAWgHxxb5uhvclks77iCGwl31dx6J8zFoFfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149518; c=relaxed/simple;
	bh=WayQ5amF0hGtkeqItxLsQawB5S9haoXrnwPFFh43qRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POEBnCyEmFSOQhLuvswaKJXQwwp3NjhzbTWKp14puPM3xnAJMY6PeC6mGIYv9yhE8VeVijMx+8YrEdTZGQNISGu7Sv7+ihB5eAcjTyM/F4GtZS4zYzRgXh+fjxYDhgdgpI5Kfxa+45PpW4x/ei7WaOfz/+sNEM5MSnnuZUv7XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=y0fHKIrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sjZsW7oy; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="y0fHKIrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sjZsW7oy"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1C6FA1380167;
	Fri, 17 Jan 2025 16:31:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jan 2025 16:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737149516; x=
	1737235916; bh=pGBQ91OtwTz0DI52ftKwhVC0SaQznSAd2g+C0jmaFQ4=; b=y
	0fHKIrbuiI+l6oyr/yEdiRKXGsFwsneOyRmYaZ/FOnorv8t0FbG5qsVxd4mlZoez
	ILkHMRnotHQuc2Wd3JgrKBQVS+hvAepNRsqDmNqkdhIWrAi6uc9QSYJJuQuvPHZe
	vPpawEK+xMG/R1+vGYNp208ylmo36mKaBDnvZHddUSYhZYBGDC+YnfDOWiSsrr/1
	7y8/WVEFEyfWRUu6a3RGcK0bF1biDjBuZuCPPgaH0CYWMjhTwxSOni0EHyglap6g
	24jdMUOr/2rUmr4tBSsE9aTTLuoQi9Vxqs5PGcY5FQcuQOkv8K0hzRJHh2t6en7d
	za3vK0iBEZVQ31bPi2eVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1737149516; x=1737235916; bh=p
	GBQ91OtwTz0DI52ftKwhVC0SaQznSAd2g+C0jmaFQ4=; b=sjZsW7oyPNAcudZGn
	uC+o3PlBHVKCLKbpeWC7a1HsIIsVGeGjRPcVFqk5q+zvBKvXkApZASR7+bW6lPpy
	YGJmYKc4yy8CHsGt9l3Z3CLKvSXd1uDvumr8/xDx3phhAeZtgBupGZDAgIbGQwxx
	gAcbOgq3KSZOaCeW5XDQkW+0uk4OcpSIWEB0tgbs1FxoZzp5LuH6lsNG0fYZuqYN
	f+u9s2k9UCeoA4XnovHle4PCnpC/FWFisPiX5w2Sff6emmlXjea1C/r3ZGVV4rRm
	iqmf9ZIfcSUUNEQL5UBuw+dr2oux16wktDZqSUCU2blioioBU2g4YqFA5lWcHc/3
	Ee86A==
X-ME-Sender: <xms:S8yKZxH_bQWdBWUs7NmH8bJBqlozJ9T3Dtp9las4yJ3-X7KGLEtILw>
    <xme:S8yKZ2X8oEwDUBCGRJE2q2SZA2QczpzMBVx7G_fr4gd_61RP9FhcbHxg6yAcX3rph
    rp4Qh3NUxsb7hfPzQ>
X-ME-Received: <xmr:S8yKZzKNyn0lDqB2vAqjH61usM1DOZ0Hm51dfCtrueRM-5Cwd0UPBdQU5bEAO5DYZYQKvloizwQ-CkjMIwgAYWm5ZVHVUNy4UI35>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeifedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepvd
    fflefhueetgfektedthfduleffudetleefieeulefhvdduieeukefhtddvudeknecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:S8yKZ3F2FFVY_sXWXfSnDbWU3q0C-w1a5XmiJDS3BNWPDvIbN1-MhA>
    <xmx:S8yKZ3W4jwYRAuvhuKqwI7AEcMUl_Yn5Zpef0dWQYvxDs2P1BLAMrQ>
    <xmx:S8yKZyNEre11kxbH6SvkwKiHlLwtLFVTPcrWoRx3PlD-h2gDHy9-OQ>
    <xmx:S8yKZ20G33qTh1uTWfuBwYDcut5nphEPgxLcBXc3-Qpr5sH5OngVuA>
    <xmx:TMyKZyTrXrzPeXNPRdbN-XWz_q9_hJ9xmRSPPTLPf7sBYb_BedTbVDp3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 16:31:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH v5 4/6] builtins: send usage_with_options() help text to standard output
Date: Fri, 17 Jan 2025 13:31:46 -0800
Message-ID: <20250117213148.3974552-5-gitster@pobox.com>
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

Using the show_usage_with_options_if_asked() helper we introduced
earlier, fix callers of usage_with_options() that want to show the
help text when explicitly asked by the end-user.  The help text now
goes to the standard output stream for them.

The test in t7600 for "git merge -h" may want to be retired, as the
same is covered by t0012 already, but it is specifically testing that
the "-h" option gets a response even with a corrupt index file, so
for now let's leave it there.

Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/am.c                | 3 +--
 builtin/branch.c            | 4 ++--
 builtin/checkout--worker.c  | 6 +++---
 builtin/checkout-index.c    | 6 +++---
 builtin/commit-tree.c       | 4 ++--
 builtin/commit.c            | 8 ++++----
 builtin/fsmonitor--daemon.c | 4 ++--
 builtin/gc.c                | 4 ++--
 builtin/ls-files.c          | 4 ++--
 builtin/merge.c             | 4 ++--
 builtin/rebase.c            | 6 +++---
 builtin/update-index.c      | 4 ++--
 t/helper/test-simple-ipc.c  | 4 ++--
 t/t7600-merge.sh            | 2 +-
 14 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1338b606fe..8d8f38fa1d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2427,8 +2427,7 @@ int cmd_am(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(usage, options);
+	show_usage_with_options_if_asked(argc, argv, usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..7c8b4b65b6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -784,8 +784,8 @@ int cmd_branch(int argc,
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_branch_usage, options);
 
 	/*
 	 * Try to set sort keys from config. If config does not set any,
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index b81002a1df..da9345a44b 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -128,9 +128,9 @@ int cmd_checkout__worker(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(checkout_worker_usage,
-				   checkout_worker_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 checkout_worker_usage,
+					 checkout_worker_options);
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, checkout_worker_options,
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a81501098d..e30086c7d4 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -250,9 +250,9 @@ int cmd_checkout_index(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_checkout_index_usage,
-				   builtin_checkout_index_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_checkout_index_usage,
+					 builtin_checkout_index_options);
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2ca1a57ebb..38457600a4 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -119,8 +119,8 @@ int cmd_commit_tree(int argc,
 
 	git_config(git_default_config, NULL);
 
-	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage_with_options(commit_tree_usage, options);
+	show_usage_with_options_if_asked(argc, argv,
+					 commit_tree_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, commit_tree_usage, 0);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index ef5e622c07..c84062bfc1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1559,8 +1559,8 @@ struct repository *repo UNUSED)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_status_usage, builtin_status_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_status_usage, builtin_status_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
@@ -1736,8 +1736,8 @@ int cmd_commit(int argc,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_usage, builtin_commit_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_commit_usage, builtin_commit_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 029dc64d6c..0820e524f1 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1598,8 +1598,8 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_fsmonitor__daemon_usage, options);
 
 	die(_("fsmonitor--daemon not supported on this platform"));
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de2..ea007c8e7e 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,8 +710,8 @@ struct repository *repo UNUSED)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_gc_usage, builtin_gc_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_gc_usage, builtin_gc_options);
 
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 15499cd12b..a4431429b7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -644,8 +644,8 @@ int cmd_ls_files(int argc,
 	};
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(ls_files_usage, builtin_ls_files_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 ls_files_usage, builtin_ls_files_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/merge.c b/builtin/merge.c
index 5f67007bba..ba9faf126a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1300,8 +1300,8 @@ int cmd_merge(int argc,
 	void *branch_to_free;
 	int orig_argc = argc;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_merge_usage, builtin_merge_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_merge_usage, builtin_merge_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0498fff3c9..6c9eaf3788 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1223,9 +1223,9 @@ int cmd_rebase(int argc,
 	};
 	int i;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_rebase_usage,
-				   builtin_rebase_options);
+	show_usage_with_options_if_asked(argc, argv,
+					 builtin_rebase_usage,
+					 builtin_rebase_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74bbad9f87..b2f6b1a3fb 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1045,8 +1045,8 @@ int cmd_update_index(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(update_index_usage, options);
+	show_usage_with_options_if_asked(argc, argv,
+					 update_index_usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git a/t/helper/test-simple-ipc.c b/t/helper/test-simple-ipc.c
index fb5927775d..03cc5eea2c 100644
--- a/t/helper/test-simple-ipc.c
+++ b/t/helper/test-simple-ipc.c
@@ -612,8 +612,8 @@ int cmd__simple_ipc(int argc, const char **argv)
 	if (argc < 2)
 		usage_with_options(simple_ipc_usage, options);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(simple_ipc_usage, options);
+	show_usage_with_options_if_asked(argc, argv,
+					 simple_ipc_usage, options);
 
 	if (argc == 2 && !strcmp(argv[1], "SUPPORTS_SIMPLE_IPC"))
 		return 0;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index ef54cff4fa..2a8df29219 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -173,7 +173,7 @@ test_expect_success 'merge -h with invalid index' '
 		cd broken &&
 		git init &&
 		>.git/index &&
-		test_expect_code 129 git merge -h 2>usage
+		test_expect_code 129 git merge -h >usage
 	) &&
 	test_grep "[Uu]sage: git merge" broken/usage
 '
-- 
2.48.1-218-gc7e8be6a8f

