Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995CC4502B
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 01:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736990733; cv=none; b=PBs4Pb0aTZi5AdQTgn+ZYnRjMtBmwCT3875Ndl0ywY17Omtoqg9olA8e1pL1FF/QH+Vq/sj7acsCXRPESNxaNYpKZi2JytR4wQjdwGzAniZz3opfRVLs7ys5+US6T77vnEK+RX/CjvxoCEsvwteD/hetuqnxiG52/O1IAM8WUXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736990733; c=relaxed/simple;
	bh=qgn+J1XRarmqJZ7c/2at5jH59NwXi6yaeJZchJNbVdg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1W9KbuW/eTaQCt0/Pa2DrIoOkm8SyLB3t3rFAqt1VSDGKO/W8HyUY9EjQkVixpOcFrdTWziw5iueJOMntu2viHhHNOWhhmGip2DtTeLwR0C+NDXkMHn08hccttaTgY07qFM6QEoMghmxPRLtGs3A13KL+6clEqmCOyVuxV/vrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SMgrt4mL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYqQSLUf; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SMgrt4mL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYqQSLUf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 969E3138022C;
	Wed, 15 Jan 2025 20:25:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jan 2025 20:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736990730; x=
	1737077130; bh=6fcmytmPptUP93DPgRIh8SW6ky8F8bvGxFtOKvoCH2A=; b=S
	Mgrt4mLOwVl3ytegwcc/YVuHTHORb7ojVRpcMPeXkqyJRoqRaKW75KUXqWGgNN44
	Kcsb/cr8gZz9fHAPb2sqgFO74zn8P3JX+2YoNR8uAS9RyY9kNNfB7SrBGbN9m35W
	Rhrl3gHHHsUxBW+FP0KG0WZRkx8AhB72/epoLN7PfbXaNKBaN8TIAubSiGrPNLHz
	Snc0MsaEGxwdaIyLaz9i/ipgaiB8oR36RmxGp/RqdP67S/wbcQRqzNISIlVTiERz
	u+CQa+BGARSj5de+g1opoyOBzwNihhn6YiEuQF22zzXeupZwfM6kha/QqbZZQKdo
	X6OAdCL/dlJp5USGqm3qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1736990730; x=1737077130; bh=6fcmytmPptUP93DPgRIh8SW6ky8F
	8bvGxFtOKvoCH2A=; b=GYqQSLUfMeF5CMvJ6k321dwhA9XlgNWYSRtZlWsOVMo+
	E7hRuKkYtTmFaQfc6MWdDDDjfZRXd59sNbOZhwmPtk+DL1oudg/m3M3peDCafYpK
	rg5D8ljD3RtCtddA9ClQP8BM05dY8iznA8d171S/9/Lr2RRWG601KINoI6aZOMci
	iIlHuJZLoyv7jKnDgXLb56lCUFeHm6wci0P/4I/ZrxSBAYXjt9BKdIYISIZlP7U9
	jYyI7KB7nd77phBsVhfwrPuWFmaFW3sS7HWCEnT4RJplmnmTZAdxvfqsfN4zYFL3
	ksSRlM6lyvgVdZX6MDYsKy/oqgze9aHLvD6c3fggyw==
X-ME-Sender: <xms:CmCIZ6AoTghy5MffZrT4oM9kr9yjyVilEisRv1fe7D9_8efCk5BQCA>
    <xme:CmCIZ0goPT3GlZgVgoww_g3YtTukjegXrH48wc_fkSpvvFrc4W01ZbpbMozkh5VC_
    D_BSvg5vXrDZjuH-g>
X-ME-Received: <xmr:CmCIZ9ku-473s2KNHT1Xtv3tWUjo6PfRRLOtcqYt0hoveS6ihf69ZPq-9tWGCkgeHRfilVyCbxSiYh6NbtajGWzdrT-tsVNEwecx>
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
X-ME-Proxy: <xmx:CmCIZ4xU-S8pNplnDQL5FUvbTCch8to7Dh2sVuWenaGExUPe7-hO8g>
    <xmx:CmCIZ_SLcgQ8-Crr3k43P0EI8d_GXR_oG_fDR2s7N6Nhdcvh-d7X1A>
    <xmx:CmCIZzZrWezPKyEUKHV5DTDgWqHq76J8aA63qw3ZHs8-a3HwlFtT1A>
    <xmx:CmCIZ4S7yhTYmWN0-4zfu0fBThV4EQ1mQajMZyu2dDwYUr9YW0sHYg>
    <xmx:CmCIZ6ejvzovcnFWQjKuYecBepGxR882lBvwW6XxZwHwwn-1swsS4o4m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 20:25:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 3/6] builtins: send usage_with_options() help text to standard output
Date: Wed, 15 Jan 2025 17:25:20 -0800
Message-ID: <20250116012524.1557441-4-gitster@pobox.com>
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

Using the show_usage_help_and_exit_if_asked() helper we introduced
earlier, fix callers of usage_with_options() that want to show the
help text when explicitly asked by the end-user.  The help text now
goes to the standard output stream for them.

The test in t7600 for "git merge -h" may want to be retired, as the
same is covered by t0012 already.  It would be even more true if we
later consider changing the exit status from 129 to 0.

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
 t/t7600-merge.sh            | 2 +-
 13 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 1338b606fe..0801b556c2 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2427,8 +2427,7 @@ int cmd_am(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv, usage, options);
 
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 6e7b0cfddb..366729a78b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -784,8 +784,8 @@ int cmd_branch(int argc,
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_branch_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_branch_usage, options);
 
 	/*
 	 * Try to set sort keys from config. If config does not set any,
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index b81002a1df..7093d1efd5 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -128,9 +128,9 @@ int cmd_checkout__worker(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(checkout_worker_usage,
-				   checkout_worker_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  checkout_worker_usage,
+					  checkout_worker_options);
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, checkout_worker_options,
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index a81501098d..d928d6b5e3 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -250,9 +250,9 @@ int cmd_checkout_index(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_checkout_index_usage,
-				   builtin_checkout_index_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_checkout_index_usage,
+					  builtin_checkout_index_options);
 	git_config(git_default_config, NULL);
 	prefix_length = prefix ? strlen(prefix) : 0;
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 2ca1a57ebb..2efc224d32 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -119,8 +119,8 @@ int cmd_commit_tree(int argc,
 
 	git_config(git_default_config, NULL);
 
-	if (argc < 2 || !strcmp(argv[1], "-h"))
-		usage_with_options(commit_tree_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  commit_tree_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, commit_tree_usage, 0);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index ef5e622c07..4268915120 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1559,8 +1559,8 @@ struct repository *repo UNUSED)
 		OPT_END(),
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_status_usage, builtin_status_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_status_usage, builtin_status_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
@@ -1736,8 +1736,8 @@ int cmd_commit(int argc,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_commit_usage, builtin_commit_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_commit_usage, builtin_commit_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 029dc64d6c..dabf190bbe 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1598,8 +1598,8 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix UNUSED
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_fsmonitor__daemon_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_fsmonitor__daemon_usage, options);
 
 	die(_("fsmonitor--daemon not supported on this platform"));
 }
diff --git a/builtin/gc.c b/builtin/gc.c
index a9b1c36de2..5f831e1f94 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -710,8 +710,8 @@ struct repository *repo UNUSED)
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_gc_usage, builtin_gc_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_gc_usage, builtin_gc_options);
 
 	strvec_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 15499cd12b..9efe92b7c0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -644,8 +644,8 @@ int cmd_ls_files(int argc,
 	};
 	int ret = 0;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(ls_files_usage, builtin_ls_files_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  ls_files_usage, builtin_ls_files_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/merge.c b/builtin/merge.c
index 5f67007bba..95d798fc89 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1300,8 +1300,8 @@ int cmd_merge(int argc,
 	void *branch_to_free;
 	int orig_argc = argc;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_merge_usage, builtin_merge_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_merge_usage, builtin_merge_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0498fff3c9..cb49323c44 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1223,9 +1223,9 @@ int cmd_rebase(int argc,
 	};
 	int i;
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(builtin_rebase_usage,
-				   builtin_rebase_options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  builtin_rebase_usage,
+					  builtin_rebase_options);
 
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 74bbad9f87..b0e2ad4970 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1045,8 +1045,8 @@ int cmd_update_index(int argc,
 		OPT_END()
 	};
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage_with_options(update_index_usage, options);
+	show_usage_help_and_exit_if_asked(argc, argv,
+					  update_index_usage, options);
 
 	git_config(git_default_config, NULL);
 
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
2.48.1-191-gafe818080f

