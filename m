Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A671523F293
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737063364; cv=none; b=W3w8jFKoRdq/O3IKB+G48X41ZMm1/H493WwIDQ3HX/UaDocJLxNw3hN2RsQ7fkUl26d6VUzgBTYgR7xdSuD0gqYYZZm8wQypvDjqfzL+LPSTJV8d2IEJ9KOksCNgnfdEuG8+soVvyRpUMoSWun9eQfCNKI3hw01EswWeu9v35c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737063364; c=relaxed/simple;
	bh=3466YrW6VxD6+qpJn+bq9cTxNqYo87fidDJmvAHvpEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9TQogDkkxFWNodPxvdZ/WDehM/m+rwmlRSArlIyU0S3ZItjGiESpXos02KrRuinLUIfY14r6QqkGycjLfUxZWkgosqieTks3MjGkaHGT/lzEJQU0+CSLqaMYbZo4dqUDeu2z6pUg7dkqLsIzpMH09E/FXIYZLCUDnVr5/tgcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=1BXprMwa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PNEdsDC6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="1BXprMwa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PNEdsDC6"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A2FA1138021E;
	Thu, 16 Jan 2025 16:36:01 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 16:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1737063361; x=
	1737149761; bh=lc2f+DSz3JTSwNZDWv3nu29brbO90bOCyYy5ZJYe5n8=; b=1
	BXprMwarYZLTVoSgo5O4KZgpQ8NIyKTUbqR5BNFxdkEW0y0N7kaF70AKIfLle204
	Da3JXS5dEbHUqMt6GRhYP2uPzNRMox7hiiLbcw/JdKdrEtfznbjFDP3O6ba/kp5Q
	onKmDaYWf3+2PCNdVofKixM15PjpAzDWOyMj7HgCDn1SYKBKDxw6cxQpNEDlbRRy
	9oq0UTjaI4LAUpiIKFji2wNwihOgUDmFXGdioF9pi+P81nnDC+/Li6jg2cFqlg+1
	MyBnIT1g/qCeDa9DViIoACn9SwRPd3y+lMJRlK6O0EvNYy1oNghTsGZD6qHxvIlz
	K7oZqR8fRo6BLP2fDH+LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1737063361; x=1737149761; bh=lc2f+DSz3JTSwNZDWv3nu29brbO9
	0bOCyYy5ZJYe5n8=; b=PNEdsDC6QOqSSuRMGs8pTG2AwG27Im24ZV6b+8KyYJ0F
	Ai8RIObVMqCgO5I/pEoy+ufz9H2fycu9o0CAjxegnzQwLVegGF3O8wAoJKmPtGFr
	MSQ6YpcKagS0NgDwQpLX6Gkw/jMuwMeL+zQzcGKb75tfPlzYh7R13FESQL6u/xFL
	9av3BDctE02ZarWv1uE/B+R1hOZPBbMHXiG4+nnVryxafgNcP9Th9Bc8wJHXbLhl
	Rz3e3EuaWm29se6DkU6Vv+0vyPH3JWSnvw/7xlhHMx1qUab77e0JvuJctIrynS+n
	VdwVdtwk42MYxP9zFgjqT8iw+ocucZoFgtgyopQLbQ==
X-ME-Sender: <xms:wXuJZ30d20URjPkiz6NryDxzylX2q-PcqzMlqU4-wekA2PloxpxTsw>
    <xme:wXuJZ2H4-3ceW6wnH9whbz35FivGuGqG-_7L3TyiqQqurMNAMN-3AhPEHnupGWjKI
    8nqZzbIJ3Pna48jZA>
X-ME-Received: <xmr:wXuJZ34_PIbTcwnBepRxx0jT-Oi5cd9teNNTPiymsggoVv_aCV0PxcLsCKzESZL_pGnddNChZiaJ1cOs0mdw0g3SYv0RVS_ilAjl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wXuJZ82ovVkJ5nCpzz2l4gDP1sd8RaHuDwaIf5TgRlDF1LDTk7v-jA>
    <xmx:wXuJZ6HRqDpAakaoQH3Mbq7UPxBn2pqhNC3GjNjztF8m2EmK3g0SqQ>
    <xmx:wXuJZ9-DigVELO6iE0rzIgTfrDKfK9t-kT3Sm1Z95h-gDrlqKkPgoQ>
    <xmx:wXuJZ3kRpjTwD2FSst7U2-sgqLQ4Xn9qhORMPPyST2G_GniltZ5rFA>
    <xmx:wXuJZ_QRBnJpbiDEJn7dvRZBJ0S1UhixlhuKnTzd_jT6GXO3nAJIo4xK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 16:36:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 4/6] builtins: send usage_with_options() help text to standard output
Date: Thu, 16 Jan 2025 13:35:51 -0800
Message-ID: <20250116213553.2563751-5-gitster@pobox.com>
X-Mailer: git-send-email 2.48.1-210-gaa1682cadd
In-Reply-To: <20250116213553.2563751-1-gitster@pobox.com>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116213553.2563751-1-gitster@pobox.com>
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

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Helper function renamed.

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
2.48.1-191-gafe818080f

