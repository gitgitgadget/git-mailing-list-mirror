Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24465539A
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 12:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753015439; cv=none; b=AHEeEFLGyGZ5mJYCQlkDdh6Wl7hIleVSkvhbs3vTZgzdU07hU7EXuEUf7aY4WeofUnXlAYfhm2CpKZZbsofv5UG8K0H4HFJmSKLKaAlNe5pv7pT6z7yfYRGkmCILjLKrjEIUAufpC56cBCWthHhGZtF8y3IrJoI2yEda6967JCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753015439; c=relaxed/simple;
	bh=i3OVsxWyXNGR3ogLB6NayN62UgE8rGDLYKMc785Y3xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6iRarZw850zwXiLKNvD/KWjNKNjKV3X+P35VPsUKJTP+PBO+4NtTYpUrscH9cnyi27KYCS8k31TZ20WE8qf0x6w6724WtYvJK3rp6JMMnjIzn6VJRG+qQn3cigaojJNQcXlwQ+pCCRA23Zsou/GBkjQHeF09bOtxIuPPKCeDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq5/NfDM; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq5/NfDM"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1851709b3a.0
        for <git@vger.kernel.org>; Sun, 20 Jul 2025 05:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753015437; x=1753620237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2TkfjleP2pe0/e3EArEggIdS17MtLcj0VEtMZN0Xkg=;
        b=mq5/NfDMS7g+hmcX+BuZHn2LUH8RghghPOtLGzMMnGURQEOtTKtotrTMd0I9Oz9EQF
         Whu3MH6WyY+63y32Gt7Pk+e32fzn3sGu0miGBBbjanbml/yO07eDNC5qp9MqeINzbKhG
         ZB0saySgU66HOx9ORWSbCeJVpXmkzwkBt5Un9k3+j5GEDRi44Gdw8TI0tipliYs1p7HV
         bQZxkFIUDXFeMIYzRm8W9tbPU8BfJlqceUCZuXyrTTxKCGViqFU+PyeHTutQ12JNpLT8
         i2u29CCIsrVJrX9sTZ+pbWuuB3q5vWJTm5QwVFWjLIyWUAFH6ma9S/hkE3vDcfvqzumK
         kUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753015437; x=1753620237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2TkfjleP2pe0/e3EArEggIdS17MtLcj0VEtMZN0Xkg=;
        b=CEAWCn6r334NnfJ5TdivUGlKbPVqIRNmrw6yC5WH4Yk/8Sqahfeb6E5e14bqPZy+20
         HFZorsMUoxaTGM9Sk52opGDA9daRiLGJUOHZ9QKtLLIPZIm4q9bNFgttKYXkETF0jmas
         uBQSxjXhQE4LndsAtusaWmOURulMQwlBjdaJ2hSutwGKVRWLujKgzUy7IVf+zfP7Wwtf
         6C2uzBU8HfsrMvo0h/hRbfqC60axef4gJ7mJmUqsLzrjiCZ/J7AojAlC0BIuW0HtwLdG
         jI/NCd5V+Y/uCKHuxz+nVZYctAS6VoBOqnmsIiN8C8RUDUpBoA5VrapYqCYOxauP/pM9
         0bnQ==
X-Gm-Message-State: AOJu0Yy24qKHS65DOQ74f5N1Fr/ytXF4aVCTN2ACPg9oHL9CCnAdF8ge
	JWmzhqpJw7LcUSzGm3Qez2/Xu1is32cF2E2VXed+ynFJcdvJ5Lv6I3Zs
X-Gm-Gg: ASbGncv7IApaYLm7SHFZMPhhH8w3vn1hdRaO4NRYodw68JBPaEFJVMPvPcRU3HvOjW4
	z1WKmwTwNR9d3mUVVIfk7Vb90Iil50N9Q53bcuRcQgvcqu9YghcUsszkuzOQJfuTBlnDGhZpxxP
	bif2UwQU/3z400/qAo1o/D+gHlH3jUJ8EFuDA1jBndeTtnkwxKth81bLYYyADCWGjuU4uMw/q2e
	4hyFrABoS7WcY4ukDhwPPSWiNPGGTO2UQFroMXnHtuyKJTSmE1/5OuLEZV5r0EvegYQhNHjLogb
	8z4g3SbZhoyC1yMge27As2WACCGNoS4euydXZ94V+9lOuuVxpZDKFg7rSTtHCfTAoZXw+Ivvq5Z
	hrZn9q9UUw6SWu+nN3IrzyBUyD+Y+W+7GhIp6Cs0S64nyOaPlgq2GweJOc3Rm4kj+LDJlTCpkAP
	LIbe5wNE6r/Ai1hgmirRN4xDcEIBM5Jw==
X-Google-Smtp-Source: AGHT+IFGhZf/UhwpI9xVWTWBlyyWkbj4PpthAnOzN8X2SkQOrfFsT8C5oLqGJpg7xQcKKA8K3GNZeg==
X-Received: by 2002:a05:6a20:3948:b0:233:c703:d4bf with SMTP id adf61e73a8af0-23812c45eadmr24052173637.19.1753015436989;
        Sun, 20 Jul 2025 05:43:56 -0700 (PDT)
Received: from localhost.localdomain (awork062145.netvigator.com. [203.198.28.145])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ff99ef4sm3781930a12.61.2025.07.20.05.43.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Jul 2025 05:43:56 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hi@looping.me,
	j6t@kdbg.org,
	sunshine@sunshineco.com
Subject: [PATCH v2] pull: add pull.autoStash config option
Date: Sun, 20 Jul 2025 20:43:34 +0800
Message-Id: <20250720124334.12045-1-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250718035221.2293-1-yldhome2d2@gmail.com>
References: <20250718035221.2293-1-yldhome2d2@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git uses `rebase.autostash` or `merge.autostash` to determine whether a
dirty worktree is allowed during pull. However, this behavior is not
clearly documented, making it difficult for users to discover how to
enable autostash, or causing them to unknowingly enable it. Add new
config option `pull.autostash` along with its documentation and test
cases.

`pull.autostash` provides the same functionality as `rebase.autostash`
and `merge.autostash`, but overrides them when set. If `pull.autostash`
is not set, it falls back to `rebase.autostash` or `merge.autostash`,
depending on the value of `pull.rebase`.

Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
---
Range-diff against v1:
1:  5b7d10d7e9 ! 1:  51a7c66783 pull: add pull.autoStash config option
    @@ Commit message
         Signed-off-by: Lidong Yan <yldhome2d2@gmail.com>
     
      ## Documentation/config/pull.adoc ##
    -@@ Documentation/config/pull.adoc: pull.rebase::
    - 	of merging the default branch from the default remote when "git
    - 	pull" is run. See "branch.<name>.rebase" for setting this on a
    - 	per-branch basis.
    -+
    +@@ Documentation/config/pull.adoc: pull.octopus::
    + 	The default merge strategy to use when pulling multiple branches
    + 	at once.
    + 
     +pull.autoStash::
    -+	When true, Git will automatically perform a `git stash` before the
    -+	operation and then restore the local changes with `git stash pop`
    -+	after the pull is complete. This means that you can run pull on a
    -+	dirty worktree. If `pull.autostash` is set, it takes precedence over
    -+	`rebase.autostash` and `merge.autostash`. If `pull.autostash` is not
    -+	set, it falls back to `rebase.autostash` or `merge.autostash`,
    -+	depending on the value of `pull.rebase`. This option can be
    -+	overridden by the `--no-autostash` and `--autostash` options of
    -+	linkgit:git-pull[1]. Defaults to false.
    - +
    - When `merges` (or just 'm'), pass the `--rebase-merges` option to 'git rebase'
    - so that the local merge commits are included in the rebase (see
    ++	When set to true, automatically create a temporary stash entry
    ++	to record the local changes before the operation begins, and
    ++	restore them after the operation completes.  When your "git
    ++	pull" rebases (instead of merges), this may be convenient, since
    ++	unlike merging pull that tolerates local changes that do not
    ++	interfere with the merge, rebasing pull refuses to work with any
    ++	local changes.
    +++
    ++If `pull.autostash` is set (either to true or false),
    ++`merge.autostash` and `rebase.autostash` are ignored.  If
    ++`pull.autostash` is not set at all, depending on the value of
    ++`pull.rebase`, `merge.autostash` or `rebase.autostash` is used
    ++instead.  Can be overridden by the `--[no-]autostash` command line
    ++option.
    ++
    + pull.twohead::
    + 	The default merge strategy to use when pulling a single branch.
     
      ## builtin/pull.c ##
     @@ builtin/pull.c: static char *opt_ff;
    @@ t/t5520-pull.sh: test_expect_success 'pull --no-autostash & merge.autostash unse
      	test_pull_autostash_fail --no-autostash --no-rebase
      '
      
    -+test_expect_success 'pull succeeds with dirty working directory and pull.autostash set' '
    ++test_expect_success 'pull succeeds with dirty working directory and pull.autostash=true' '
     +	test_config pull.autostash true &&
     +	test_pull_autostash 1 --rebase &&
    -+	test_pull_autostash 2 --no-rebase
    -+'
    -+
    -+test_expect_success 'pull --autostash & pull.autostash=true' '
    -+	test_config pull.autostash true &&
    ++	test_pull_autostash 2 --no-rebase &&
     +	test_pull_autostash 1 --autostash --rebase &&
     +	test_pull_autostash 2 --autostash --no-rebase
     +'
     +
    -+test_expect_success 'pull --autostash & pull.autostash=false' '
    ++test_expect_success 'pull fails with dirty working directory and pull.autostash=false' '
     +	test_config pull.autostash false &&
    -+	test_pull_autostash 1 --autostash --rebase &&
    -+	test_pull_autostash 2 --autostash --no-rebase
    -+'
    -+
    -+test_expect_success 'pull --autostash & pull.autostash unset' '
    -+	test_unconfig pull.autostash &&
    -+	test_pull_autostash 1 --autostash --rebase &&
    -+	test_pull_autostash 2 --autostash --no-rebase
    -+'
    -+
    -+test_expect_success 'pull --no-autostash & pull.autostash=true' '
    -+	test_config pull.autostash true &&
    ++	test_pull_autostash_fail --rebase &&
    ++	test_pull_autostash_fail --no-rebase &&
     +	test_pull_autostash_fail --no-autostash --rebase &&
     +	test_pull_autostash_fail --no-autostash --no-rebase
     +'
     +
    -+test_expect_success 'pull --no-autostash & pull.autostash=false' '
    ++test_expect_success 'pull --autostash overrides pull.autostash=false' '
     +	test_config pull.autostash false &&
    -+	test_pull_autostash_fail --no-autostash --rebase &&
    -+	test_pull_autostash_fail --no-autostash --no-rebase
    ++	test_pull_autostash 1 --autostash --rebase &&
    ++	test_pull_autostash 2 --autostash --no-rebase
     +'
     +
    -+test_expect_success 'pull --no-autostash & pull.autostash unset' '
    -+	test_unconfig pull.autostash &&
    ++test_expect_success 'pull --no-autostash overrides pull.autostash=true' '
    ++	test_config pull.autostash true &&
     +	test_pull_autostash_fail --no-autostash --rebase &&
     +	test_pull_autostash_fail --no-autostash --no-rebase
     +'
     +
    -+test_expect_success 'pull.autostash=true & rebase.autostash=true' '
    ++test_expect_success 'pull.autostash=true overrides rebase.autostash' '
     +	test_config pull.autostash true &&
     +	test_config rebase.autostash true &&
    -+	test_pull_autostash 1 --rebase
    -+'
    -+
    -+test_expect_success 'pull.autostash=true & rebase.autostash=false' '
    -+	test_config pull.autostash true &&
    ++	test_pull_autostash 1 --rebase &&
     +	test_config rebase.autostash false &&
     +	test_pull_autostash 1 --rebase
     +'
     +
    -+test_expect_success 'pull.autostash=false & rebase.autostash=true' '
    ++test_expect_success 'pull.autostash=false overrides rebase.autostash' '
     +	test_config pull.autostash false &&
     +	test_config rebase.autostash true &&
    -+	test_pull_autostash_fail --rebase
    -+'
    -+
    -+test_expect_success 'pull.autostash=false & rebase.autostash=false' '
    -+	test_config pull.autostash false &&
    ++	test_pull_autostash_fail --rebase &&
     +	test_config rebase.autostash false &&
     +	test_pull_autostash_fail --rebase
     +'
     +
    -+test_expect_success 'pull.autostash=true & merge.autostash=true' '
    ++test_expect_success 'pull.autostash=true overrides merge.autostash' '
     +	test_config pull.autostash true &&
     +	test_config merge.autostash true &&
    -+	test_pull_autostash 2 --no-rebase
    -+'
    -+
    -+test_expect_success 'pull.autostash=true & merge.autostash=false' '
    -+	test_config pull.autostash true &&
    ++	test_pull_autostash 2 --no-rebase &&
     +	test_config merge.autostash false &&
     +	test_pull_autostash 2 --no-rebase
     +'
     +
    -+test_expect_success 'pull.autostash=false & merge.autostash=true' '
    ++test_expect_success 'pull.autostash=false overrides merge.autostash' '
     +	test_config pull.autostash false &&
     +	test_config merge.autostash true &&
    -+	test_pull_autostash_fail --no-rebase
    -+'
    -+
    -+test_expect_success 'pull.autostash=false & merge.autostash=false' '
    -+	test_config pull.autostash false &&
    ++	test_pull_autostash_fail --no-rebase &&
     +	test_config merge.autostash false &&
     +	test_pull_autostash_fail --no-rebase
     +'

 Documentation/config/pull.adoc | 16 +++++++++
 builtin/pull.c                 | 20 ++++++++++--
 t/t5520-pull.sh                | 60 ++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/pull.adoc b/Documentation/config/pull.adoc
index 9349e09261..125c930f72 100644
--- a/Documentation/config/pull.adoc
+++ b/Documentation/config/pull.adoc
@@ -29,5 +29,21 @@ pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
 
+pull.autoStash::
+	When set to true, automatically create a temporary stash entry
+	to record the local changes before the operation begins, and
+	restore them after the operation completes.  When your "git
+	pull" rebases (instead of merges), this may be convenient, since
+	unlike merging pull that tolerates local changes that do not
+	interfere with the merge, rebasing pull refuses to work with any
+	local changes.
++
+If `pull.autostash` is set (either to true or false),
+`merge.autostash` and `rebase.autostash` are ignored.  If
+`pull.autostash` is not set at all, depending on the value of
+`pull.rebase`, `merge.autostash` or `rebase.autostash` is used
+instead.  Can be overridden by the `--[no-]autostash` command line
+option.
+
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
diff --git a/builtin/pull.c b/builtin/pull.c
index c593f324fe..2a6c2e4a37 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -90,7 +90,8 @@ static char *opt_ff;
 static const char *opt_verify_signatures;
 static const char *opt_verify;
 static int opt_autostash = -1;
-static int config_autostash;
+static int config_rebase_autostash;
+static int config_pull_autostash = -1;
 static int check_trust_level = 1;
 static struct strvec opt_strategies = STRVEC_INIT;
 static struct strvec opt_strategy_opts = STRVEC_INIT;
@@ -367,7 +368,18 @@ static int git_pull_config(const char *var, const char *value,
 			   const struct config_context *ctx, void *cb)
 {
 	if (!strcmp(var, "rebase.autostash")) {
-		config_autostash = git_config_bool(var, value);
+		/*
+		 * run_rebase() also reads this option. The reason we handle it here is
+		 * that when pull.rebase is true, a fast-forward may occur without
+		 * invoking run_rebase(). We need to ensure that autostash is set even
+		 * in the fast-forward case.
+		 *
+		 * run_merge() handles merge.autostash, so we don't handle it here.
+		 */
+		config_rebase_autostash = git_config_bool(var, value);
+		return 0;
+	} else if (!strcmp(var, "pull.autostash")) {
+		config_pull_autostash = git_config_bool(var, value);
 		return 0;
 	} else if (!strcmp(var, "submodule.recurse")) {
 		recurse_submodules = git_config_bool(var, value) ?
@@ -1006,6 +1018,8 @@ int cmd_pull(int argc,
 	}
 
 	argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
+	if (opt_autostash == -1)
+		opt_autostash = config_pull_autostash;
 
 	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
 		recurse_submodules = recurse_submodules_cli;
@@ -1052,7 +1066,7 @@ int cmd_pull(int argc,
 
 	if (opt_rebase) {
 		if (opt_autostash == -1)
-			opt_autostash = config_autostash;
+			opt_autostash = config_rebase_autostash;
 
 		if (is_null_oid(&orig_head) && !is_index_unborn(the_repository->index))
 			die(_("Updating an unborn branch with changes added to the index."));
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 63c9a8f04b..0e0019347e 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -472,6 +472,66 @@ test_expect_success 'pull --no-autostash & merge.autostash unset' '
 	test_pull_autostash_fail --no-autostash --no-rebase
 '
 
+test_expect_success 'pull succeeds with dirty working directory and pull.autostash=true' '
+	test_config pull.autostash true &&
+	test_pull_autostash 1 --rebase &&
+	test_pull_autostash 2 --no-rebase &&
+	test_pull_autostash 1 --autostash --rebase &&
+	test_pull_autostash 2 --autostash --no-rebase
+'
+
+test_expect_success 'pull fails with dirty working directory and pull.autostash=false' '
+	test_config pull.autostash false &&
+	test_pull_autostash_fail --rebase &&
+	test_pull_autostash_fail --no-rebase &&
+	test_pull_autostash_fail --no-autostash --rebase &&
+	test_pull_autostash_fail --no-autostash --no-rebase
+'
+
+test_expect_success 'pull --autostash overrides pull.autostash=false' '
+	test_config pull.autostash false &&
+	test_pull_autostash 1 --autostash --rebase &&
+	test_pull_autostash 2 --autostash --no-rebase
+'
+
+test_expect_success 'pull --no-autostash overrides pull.autostash=true' '
+	test_config pull.autostash true &&
+	test_pull_autostash_fail --no-autostash --rebase &&
+	test_pull_autostash_fail --no-autostash --no-rebase
+'
+
+test_expect_success 'pull.autostash=true overrides rebase.autostash' '
+	test_config pull.autostash true &&
+	test_config rebase.autostash true &&
+	test_pull_autostash 1 --rebase &&
+	test_config rebase.autostash false &&
+	test_pull_autostash 1 --rebase
+'
+
+test_expect_success 'pull.autostash=false overrides rebase.autostash' '
+	test_config pull.autostash false &&
+	test_config rebase.autostash true &&
+	test_pull_autostash_fail --rebase &&
+	test_config rebase.autostash false &&
+	test_pull_autostash_fail --rebase
+'
+
+test_expect_success 'pull.autostash=true overrides merge.autostash' '
+	test_config pull.autostash true &&
+	test_config merge.autostash true &&
+	test_pull_autostash 2 --no-rebase &&
+	test_config merge.autostash false &&
+	test_pull_autostash 2 --no-rebase
+'
+
+test_expect_success 'pull.autostash=false overrides merge.autostash' '
+	test_config pull.autostash false &&
+	test_config merge.autostash true &&
+	test_pull_autostash_fail --no-rebase &&
+	test_config merge.autostash false &&
+	test_pull_autostash_fail --no-rebase
+'
+
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
-- 
2.39.5 (Apple Git-154)

