Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACF3597A
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716062; cv=none; b=ptLBlysoxqVxbTxVfSPL0i8JaMlWHMaxg2/zAW8taQSaLIGq1cfbJNtpKLO57YW8u3Asrt/DSJuc2QzLDyUyhwmxx/TinwwEEgDuibcTvB1TPM0n01gZuaGwBm8eMwNh2EBSMgmtblwwsZ8i46sbxSy2VpNtf0xaESXmYSiwFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716062; c=relaxed/simple;
	bh=m3FAGLF5IfzXii5K5wjH5lpxj5mUGR/Aoy3Wf7snpHo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kPWScSHfvnOD09lJjs44+wnysqbSvzZikJf8TOtKnLSx4GU+tpngwiK+KK+p9YtlsuNmg9CJAd+Umh5E7/947fPRmxxfyr+xpcD5b6u04UFieVPZihq7tVKP6ISXX1ej7vO2OI+2WUc9YVeNy7RaTWyoPb4+7+oRZ/GQcJFlJ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QayJmTF/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QayJmTF/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so3965945e9.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716058; x=1753320858; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xERS5LtG/DRgjARpU13WM6IwkfMb0R0UDtJrmDoRJs0=;
        b=QayJmTF/7fMW0zRplkb/Cdem+I+eKlYHMFPrRxn9LdqUP8DT6y3/nytefoOW/18fiB
         ZAxMtoj5/yOJMaaZ9AEJ2sIYZdjGDswMdwCmnnOEp+cnovrWTH5/0/Fjr/Lqtzmn48Ol
         v2h4JNciTt3Wydm7Xz7au0ELDsMgkGoeAl0szRknMTjovTyhKv3bA2nsJdGXOCTpMoVO
         SdLzTA9ePllWSUeb5bjKcjmZVOTdgqYknkLsa9dTVMWsxHLJP/xtc3/118sz6jIIPqao
         e/IyhpsLNVLN/BrMaMDKPKSDnwh9Dm9XKAj8d79/7+BYXcYqAMPn5iDhUzCw3SBS4gqE
         7XdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716058; x=1753320858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xERS5LtG/DRgjARpU13WM6IwkfMb0R0UDtJrmDoRJs0=;
        b=IbdQ90NX0RLuZ4AT7GGN40RqrnnvVoNMEJCC/1KN4lb55oemUaN0Dh9rBeZqNTokLY
         FSpWc4rQ2KFLrCbpXXAbkOTe4jXM/EKDZm8/9ErIdqNAPK45rsbbnkcVcHtan6dCctDU
         Urz6IPJ+A8tvKoOfLSD2Gvr6NO1w88JNf2NHuTga5EuM32PxpF1/is1FTKm4sJ1TPfV/
         Lp8h697Zsaf0CDWlJyQ3lY2PPhP82hyG9S/WJWaI2f/dytlOKGzwWMtC/a+JmWMkLNnZ
         e2iKBI0qvMGzhyPyyg/nOSxjqyaQktSp2GV/7qypM0XsCwdXggIyaMumQEJGeruO+x9o
         IOIA==
X-Gm-Message-State: AOJu0YxKrKNpZA/R7J9gJj7/eKfUED9D5QsoZa7PWbaSmYqZH1zBnOF3
	hr37vC5V4b75HZwuX1gNZ9gmjcuWVZ6ep/j4+hFf/YzsY+bu3DteAIFwsQo9lA==
X-Gm-Gg: ASbGnct8wAaStzddtgp0LLLwTPVUJNN64kVY9x0FiX6Da4sTIAgpXzBe1noH1VTknCa
	T7ioidjQkYpo/QUKkGqVb6rNq2kD4bgBcWpQ12zWutJfnalL0U4E0DX+cB1kUvas0fVNbdo0T+j
	lzGIqXTesYtxXIzXdMBMUk4VsMbWUESp36WBtBAA/z5Da9JIqElFUlJOYkfzv34s8s8FHdtRJwI
	BsDOXGF/kYyq8zP2E8AgKSbXNkO8lIv2DMd6glucHQXnrlgTWxzMEZ0xhjRoNQPXpYL/BY2uxJq
	xYFWXNX557/jx7QHzRVnapCU8TPc1O6z6OtXIZsHBgOhCQ7x4esdpNQ8pl90CIY1L68put5jnhS
	Z20oO0X+Q66dPvs7wquCpSvZH8JsW4xM7MQ==
X-Google-Smtp-Source: AGHT+IE9cHh7s77weeUs2h/qlvtMkcEA2FXioFsd5uVNgCMhApKPvfdi87ZUliXN5EkDKXiVZPUeUw==
X-Received: by 2002:a05:600c:4709:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-4562e379f80mr46357175e9.3.1752716057882;
        Wed, 16 Jul 2025 18:34:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d587sm19035227f8f.46.2025.07.16.18.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:34:17 -0700 (PDT)
Message-Id: <7e8f7c2d6c8c740d42bc6d157fa491b558b9ff6a.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
	<pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Jul 2025 01:34:08 +0000
Subject: [PATCH v2 2/8] sparse-checkout: add basics of 'clean' command
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

When users change their sparse-checkout definitions to add new
directories and remove old ones, there may be a few reasons why
directories no longer in scope remain (ignored or excluded files still
exist, Windows handles are still open, etc.). When these files still
exist, the sparse index feature notices that a tracked, but sparse,
directory still exists on disk and thus the index expands. This causes a
performance hit _and_ the advice printed isn't very helpful. Using 'git
clean' isn't enough (generally '-dfx' may be needed) but also this may
not be sufficient.

Add a new subcommand to 'git sparse-checkout' that removes these
tracked-but-sparse directories. This necessarily removes all files
contained within, including tracked and untracked files. Of particular
importance are ignored and excluded files which would normally be
ignored even by 'git clean -f' unless the '-x' or '-X' option is
provided. This is the most extreme method for doing this, but it works
when the sparse-checkout is in cone mode and is expected to rescope
based on directories, not files.

The current implementation always deletes these sparse directories
without warning. This is unacceptable for a released version, but those
features will be added in changes coming immediately after this one.

Note that untracked directories within the sparse-checkout remain.
Further, directories that contain staged changes or files in merge
conflict states are not deleted. This is a detail that is partly hidden
by the implementation which relies on collapsing the index to a sparse
index in-memory and only deleting directories that are listed as sparse
in the index.

If a staged change exists, then that entry is not stored as a sparse
tree entry and thus remains on-disk until committed or reset.

There are some interesting cases around merge conflict resolution, but
that will be carefully analyzed in the future.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc | 11 ++++-
 builtin/sparse-checkout.c              | 64 +++++++++++++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh     | 38 +++++++++++++++
 3 files changed, 111 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 529a8edd9c1e..6db88f00781d 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules) [<options>]
+'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules | clean) [<options>]
 
 
 DESCRIPTION
@@ -111,6 +111,15 @@ flags, with the same meaning as the flags from the `set` command, in order
 to change which sparsity mode you are using without needing to also respecify
 all sparsity paths.
 
+'clean'::
+	Remove all files in tracked directories that are outside of the
+	sparse-checkout definition. This subcommand requires cone-mode
+	sparse-checkout to be sure that we know which directories are
+	both tracked and all contained paths are not in the sparse-checkout.
+	This command can be used to be sure the sparse index works
+	efficiently, though it does not require enabling the sparse index
+  feature via the `index.sparse=true` configuration.
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files.
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 61714bf80be0..6fe6ec718fe3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -2,6 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
+#include "abspath.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
@@ -23,7 +24,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init | list | set | add | reapply | disable | check-rules) [<options>]"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable | check-rules | clean) [<options>]"),
 	NULL
 };
 
@@ -924,6 +925,66 @@ static int sparse_checkout_reapply(int argc, const char **argv,
 	return update_working_directory(repo, NULL);
 }
 
+static char const * const builtin_sparse_checkout_clean_usage[] = {
+	"git sparse-checkout clean [-n|--dry-run]",
+	NULL
+};
+
+static const char *msg_remove = N_("Removing %s\n");
+
+static int sparse_checkout_clean(int argc, const char **argv,
+				   const char *prefix,
+				   struct repository *repo)
+{
+	struct strbuf full_path = STRBUF_INIT;
+	const char *msg = msg_remove;
+	size_t worktree_len;
+
+	struct option builtin_sparse_checkout_clean_options[] = {
+		OPT_END(),
+	};
+
+	setup_work_tree();
+	if (!repo->settings.sparse_checkout)
+		die(_("must be in a sparse-checkout to clean directories"));
+	if (!repo->settings.sparse_checkout_cone)
+		die(_("must be in a cone-mode sparse-checkout to clean directories"));
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_clean_options,
+			     builtin_sparse_checkout_clean_usage, 0);
+
+	if (repo_read_index(repo) < 0)
+		die(_("failed to read index"));
+
+	if (convert_to_sparse(repo->index, SPARSE_INDEX_MEMORY_ONLY) ||
+	    repo->index->sparse_index == INDEX_EXPANDED)
+		die(_("failed to convert index to a sparse index; resolve merge conflicts and try again"));
+
+	strbuf_addstr(&full_path, repo->worktree);
+	strbuf_addch(&full_path, '/');
+	worktree_len = full_path.len;
+
+	for (size_t i = 0; i < repo->index->cache_nr; i++) {
+		struct cache_entry *ce = repo->index->cache[i];
+		if (!S_ISSPARSEDIR(ce->ce_mode))
+			continue;
+		strbuf_setlen(&full_path, worktree_len);
+		strbuf_add(&full_path, ce->name, ce->ce_namelen);
+
+		if (!is_directory(full_path.buf))
+			continue;
+
+		printf(msg, ce->name);
+
+		if (remove_dir_recursively(&full_path, 0))
+			warning_errno(_("failed to remove '%s'"), ce->name);
+	}
+
+	strbuf_release(&full_path);
+	return 0;
+}
+
 static char const * const builtin_sparse_checkout_disable_usage[] = {
 	"git sparse-checkout disable",
 	NULL
@@ -1079,6 +1140,7 @@ int cmd_sparse_checkout(int argc,
 		OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
 		OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
 		OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
+		OPT_SUBCOMMAND("clean", &fn, sparse_checkout_clean),
 		OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
 		OPT_SUBCOMMAND("check-rules", &fn, sparse_checkout_check_rules),
 		OPT_END(),
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ab3a105ffff2..a48eedf766d2 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1050,5 +1050,43 @@ test_expect_success 'check-rules null termination' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clean' '
+	git -C repo sparse-checkout set --cone deep/deeper1 &&
+	mkdir repo/deep/deeper2 repo/folder1 &&
+	touch repo/deep/deeper2/file &&
+	touch repo/folder1/file &&
+
+	cat >expect <<-\EOF &&
+	Removing deep/deeper2/
+	Removing folder1/
+	EOF
+
+	git -C repo sparse-checkout clean >out &&
+	test_cmp expect out &&
+
+	test_path_is_missing repo/deep/deeper2 &&
+	test_path_is_missing repo/folder1
+'
+
+test_expect_success 'clean with staged sparse change' '
+	git -C repo sparse-checkout set --cone deep/deeper1 &&
+	mkdir repo/deep/deeper2 repo/folder1 repo/folder2 &&
+	touch repo/deep/deeper2/file &&
+	touch repo/folder1/file &&
+	echo dirty >repo/folder2/a &&
+
+	git -C repo add --sparse folder1/file &&
+
+	# deletes deep/deeper2/ but leaves folder1/ and folder2/
+	cat >expect <<-\EOF &&
+	Removing deep/deeper2/
+	EOF
+
+	git -C repo sparse-checkout clean >out &&
+	test_cmp expect out &&
+
+	test_path_is_missing repo/deep/deeper2 &&
+	test_path_exists repo/folder1
+'
 
 test_done
-- 
gitgitgadget

