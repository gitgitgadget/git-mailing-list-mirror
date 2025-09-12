Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087E2E8DE8
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673021; cv=none; b=iUW5Q9Boy/NwwaThSQcrRyD0omAXroaY862d1Za0XsgdMWjbS2O7MydUxr5cdnpAeDTG6LmXkQVqvC1WR7PTkkn14mAkJJKWWF25iKYPIGQ9IjHgUTHuQ5NAVrIBEf+SXf1AAzYwk5tSAoo/2HMspMHL2NsaQUpBMYANBHrkD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673021; c=relaxed/simple;
	bh=RrVYrqnz3SMpV6DCnVDa6PNwDSennwRdCAy1lqtHad0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lPRMJiMdS0HcNUmzciROUA+Zaj80+kEZzKn8zOYZGFTjciy+sS0cPLqhfgk8eUSfYS09TRm6hk68EXjNn3izzUNmVr4BG/sjOR2y3iTq41TLoyL55cQ9YS/ZMroeYV1VsQyzWnjUB3QS3MLh8nknnLGAbDbKS94a0187JydDYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXtS3YqC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXtS3YqC"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b52047b3f19so1249827a12.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673019; x=1758277819; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRf3SKOJHbilBk+OlF/EPuH/4cLQ68Zdz0M4z/ee0AE=;
        b=bXtS3YqCetJWeF706D8NK3PjaPqirM9hjYjkmzTydmPHu+MvQVZk1JoGxaHvRtRzRE
         bSEf9yJ8XlAoJXQaDXVVqcR+f38EkJlWZmoohPAhkggUj0do2xHvkd3bzENn0zjFTKbE
         3dhxX08WEpHyvikN+lnoTKgVPKw6VfcJA3OZILUI0OmiXu1rvhBPEk5d5/VuiZyr3qCs
         eB2DoQ5bKmRSrjvE1NoxdhCfwqH+PlRQZ0NNDCizG/6jnPXkIRkBmA0ql4BfXrBw62/X
         cjNPlybOLb6PUS1raF3gw4LUR0uzS6ecD85d6QQv3olImoQhJaah9Xsl/cMdkyzObhu1
         TbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673019; x=1758277819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRf3SKOJHbilBk+OlF/EPuH/4cLQ68Zdz0M4z/ee0AE=;
        b=nmSuxPEnlXjNckPZvt8YXNJ4BpHDg2afAdeITwkFP5FtKT1AO2zxTFpTYq1efVRstF
         mJXc3+wrK4rwb7uvf6wEK7+WvMBpmRjmcPuDeU5FGrOalaVxQCU0UzdGBcjWw6PxcWoh
         cayslpA5iDSFzPrurVfaihYGFrzsLIoraNEszqI3nD6YgEJOJxG5OxWkzMMGJ0RQljff
         wre3Ej3xduLMvUbvh2fee/S4Nx0P7KvDX0wbxng2YusJisdqBPqEGwHgnZj/iGEMxbz4
         PixofJHTPBdkfmwSqBfBJ0pNKnqL4Byz534n1bwMT1GxS0zXHjrTtJ+aCKqx2g+frHPA
         z6Tw==
X-Gm-Message-State: AOJu0YwpDVq8pIXjUq1muojpRLE52Sy4L16gZn3JSbUDUELTUb/BbqLW
	O0eZCD+qk99vHC5pO6pz4tMyWXeLa8wzIuLpz1tE0CXhNwF5F9ejSjjWc72pFQ==
X-Gm-Gg: ASbGnct1g2iKelZTcTfK9SMuYmpwi8AB7vcK1x9B4NKs11GmfOrXHuxkP2p40AJMvGt
	zfLzd17APbWXoCNi+gXuMdniTFLPxG72nTJhCWeQmPa5/GC3qee7lP4626AoY8YCG5JiJvjhhuk
	DxZ6a37mOCWVOoC5lkvInSqx7oVnG3LL0IiRCIGMpr7Xqy10mYIAgfWVt+nrDUYOA1flCK4w+8G
	klHCRVB2LmWHE09P2eyF+t+imZ1iL7GEo1SXuxYzjK7VhLb1GMKwijKs05LhkVMHOWz6cPXX+no
	za7EQ2LlP3rXroQkQPQEofVMQQ5GZSXBLyFBOVMEovb1Gtn3rTprwEeIW9SNQAKk3Nzif+vENuu
	FtENeQBApki/Tqp4koSznkveTuwsNB0mdfA2A07W8L2hJIzf/
X-Google-Smtp-Source: AGHT+IGAwPx9TQVLezSlpbTBEcXA8IzEf5sEI7brRqIM+1Chqvz4xCAdcGf+DFbd0HInbqIQVcYLBQ==
X-Received: by 2002:a17:902:b58a:b0:248:df64:ec6c with SMTP id d9443c01a7336-25d2528bed4mr22316065ad.13.1757673018650;
        Fri, 12 Sep 2025 03:30:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3ae29ae2sm44789275ad.120.2025.09.12.03.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:17 -0700 (PDT)
Message-Id: <71a498db65440ad40c6cbde92b74ea1105075737.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:07 +0000
Subject: [PATCH v3 3/7] sparse-checkout: match some 'clean' behavior
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'git sparse-checkout clean' subcommand is somewhat similar to 'git
clean' in that it will delete files that should not be in the worktree.
The big difference is that it focuses on the directories that should not
be in the worktree due to cone-mode sparse-checkout. It also does not
discriminate in the kinds of files and focuses on deleting entire
directories.

However, there are some restrictions that would be good to bring over
from 'git clean', specifically how it refuses to do anything without the
'-f'/'--force' or '-n'/'--dry-run' arguments. The 'clean.requireForce'
config can be set to 'false' to imply '--force'.

Add this behavior to avoid accidental deletion of files that cannot be
recovered from Git.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc |  9 +++++
 builtin/sparse-checkout.c              | 15 ++++++-
 t/t1091-sparse-checkout-builtin.sh     | 54 +++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index baaebce746..42050ff5b5 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -127,6 +127,15 @@ clean` to resolve these cases.
 This command can be used to be sure the sparse index works efficiently,
 though it does not require enabling the sparse index feature via the
 `index.sparse=true` configuration.
++
+To prevent accidental deletion of worktree files, the `clean` subcommand
+will not delete any files without the `-f` or `--force` option, unless
+the `clean.requireForce` config option is set to `false`.
++
+The `--dry-run` option will list the directories that would be removed
+without deleting them. Running in this mode can be helpful to predict the
+behavior of the clean comand or to determine which kinds of files are left
+in the sparse directories.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f7caa28f3f..d777b64960 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -931,6 +931,7 @@ static char const * const builtin_sparse_checkout_clean_usage[] = {
 };
 
 static const char *msg_remove = N_("Removing %s\n");
+static const char *msg_would_remove = N_("Would remove %s\n");
 
 static int sparse_checkout_clean(int argc, const char **argv,
 				   const char *prefix,
@@ -939,8 +940,12 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	struct strbuf full_path = STRBUF_INIT;
 	const char *msg = msg_remove;
 	size_t worktree_len;
+	int force = 0, dry_run = 0;
+	int require_force = 1;
 
 	struct option builtin_sparse_checkout_clean_options[] = {
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
+		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
 		OPT_END(),
 	};
 
@@ -954,6 +959,13 @@ static int sparse_checkout_clean(int argc, const char **argv,
 			     builtin_sparse_checkout_clean_options,
 			     builtin_sparse_checkout_clean_usage, 0);
 
+	repo_config_get_bool(repo, "clean.requireforce", &require_force);
+	if (require_force && !force && !dry_run)
+		die(_("for safety, refusing to clean without one of --force or --dry-run"));
+
+	if (dry_run)
+		msg = msg_would_remove;
+
 	if (repo_read_index(repo) < 0)
 		die(_("failed to read index"));
 
@@ -977,7 +989,8 @@ static int sparse_checkout_clean(int argc, const char **argv,
 
 		printf(msg, ce->name);
 
-		if (remove_dir_recursively(&full_path, 0))
+		if (dry_run <= 0 &&
+		    remove_dir_recursively(&full_path, 0))
 			warning_errno(_("failed to remove '%s'"), ce->name);
 	}
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index bdb7b21e32..e6b768a8da 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1059,12 +1059,29 @@ test_expect_success 'clean' '
 	touch repo/deep/deeper2/file &&
 	touch repo/folder1/file &&
 
+	test_must_fail git -C repo sparse-checkout clean 2>err &&
+	grep "refusing to clean" err &&
+
+	git -C repo config clean.requireForce true &&
+	test_must_fail git -C repo sparse-checkout clean 2>err &&
+	grep "refusing to clean" err &&
+
+	cat >expect <<-\EOF &&
+	Would remove deep/deeper2/
+	Would remove folder1/
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run >out &&
+	test_cmp expect out &&
+	test_path_exists repo/deep/deeper2 &&
+	test_path_exists repo/folder1 &&
+
 	cat >expect <<-\EOF &&
 	Removing deep/deeper2/
 	Removing folder1/
 	EOF
 
-	git -C repo sparse-checkout clean >out &&
+	git -C repo sparse-checkout clean -f >out &&
 	test_cmp expect out &&
 
 	test_path_is_missing repo/deep/deeper2 &&
@@ -1076,6 +1093,10 @@ test_expect_success 'clean with sparse file states' '
 	git -C repo sparse-checkout set --cone deep/deeper1 &&
 	mkdir repo/folder2 &&
 
+	# The previous test case checked the -f option, so
+	# test the config option in this one.
+	git -C repo config clean.requireForce false &&
+
 	# create an untracked file and a modified file
 	touch repo/folder2/file &&
 	echo dirty >repo/folder2/a &&
@@ -1154,4 +1175,35 @@ test_expect_success 'clean with sparse file states' '
 	test_must_be_empty out
 '
 
+test_expect_success 'clean with merge conflict status' '
+	git clone repo clean-merge &&
+
+	echo dirty >clean-merge/deep/deeper2/a &&
+	touch clean-merge/folder2/extra &&
+
+	cat >input <<-EOF &&
+	0 $ZERO_OID	folder1/a
+	100644 $(git -C clean-merge rev-parse HEAD:folder1/a) 1	folder1/a
+	EOF
+	git -C clean-merge update-index --index-info <input &&
+
+	git -C clean-merge sparse-checkout set deep/deeper1 &&
+
+	test_must_fail git -C clean-merge sparse-checkout clean -f 2>err &&
+	grep "failed to convert index to a sparse index" err &&
+
+	mkdir -p clean-merge/folder1/ &&
+	echo merged >clean-merge/folder1/a &&
+	git -C clean-merge add --sparse folder1/a &&
+
+	# deletes folder2/ but leaves staged change in folder1
+	# and dirty change in deep/deeper2/
+	cat >expect <<-\EOF &&
+	Removing folder2/
+	EOF
+
+	git -C clean-merge sparse-checkout clean -f >out &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget

