Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954A72EAD09
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673021; cv=none; b=gf1cmqOsV3dAlhfb67Ozeh5THospxLzsZ7L5Y7hR5V+uZZ2JGVrs6FZaOtXz1AXpvp+4BbzbZCFi2j6pz4MuRZ7lcjqxcsnB6Ac797ZLw9uRO/dWOjF0AGQyRLzE6ppY9xdQtUvnqNAkRcbx3BICHUv8NygPuzlh0J8/Pa9Zxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673021; c=relaxed/simple;
	bh=KJSSCnJR+sGiWuz56WV5d1y8up+9Uf8O2VcmM0KvckI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CeEWVoIUvuRF1P7wnnqaEXdqIw3Ya+L0oBXdP1HVvgwkVab5RdQSd6OC7EaMuLc07YS7/QbwyX8Hxi0OuWRCnlvT7ZJ8C4cwc2D7XYaT/A8Pj4XQ6LQDsWikmNqy3kIUA1NIjGPWj8Affe7zBaUeygTC+D7zOPI8HP23BqRmajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp+e2eLZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp+e2eLZ"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32dd1238843so1710985a91.3
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673017; x=1758277817; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPuIdBBBPCQdsKAylkOUv2DIf9arYomT8DfUfF/T9GM=;
        b=Hp+e2eLZJAhmz0+sN/+r3HGCKySU+FB8Nlc4YOEC/2HfZsano1lPvc7wijcppB0H7y
         ZMfvGZ8TDD5pUYHpjHd5UWhQbd+arqx+bSIdp++azSpzW5gM4XBiitU0GFus6PbdeZmZ
         WFoaTZEtY4n2pdsF5x5iis9uB8AjVjY2u/dk1ZOtbtdH40ZXUbIqpZBjN3h5BT9yMoiB
         m38F1DeoU9h1/KNnMRNwzzqo2GMeP4klx7jvzLdpsvxA03wIXTxDYPI6rn1RxtODcZbJ
         Uwl8fjylYLKRIsbVyJLyPL3LJ19dZzf3xELi5BZGtIolLPC/WTY97+PigDMij3QG0e/A
         2onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673017; x=1758277817;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPuIdBBBPCQdsKAylkOUv2DIf9arYomT8DfUfF/T9GM=;
        b=t2K1tpjARvMcwZATvORnRCoS8sv/BxsGg7oqRPzPTAv6wKvRdlbx1785OUkpaK2Rfo
         nbVQqtCxD/7qILgTdY33NZoBkH2q3KZ6tQDBQpSnkZu7xzX56l/RGPpL/tSGZ5SoS9X0
         TH6+ltBZRSvQeaHMPr0iIKJsb4KmQuniSDeoBMTl/wcz42YMRmy9dlLTRe4dSYMvlwLP
         1VBaSVUrgJ2P6Ck82f3soK1CHDUOrt8H9FGLbT2gsDnYddDXoFZ+CLzdls26XjpLK5vO
         /sgx9dzXwsXYPL7mDrjqMOeZ68F4ms97QiJASYpsKdk723jcn+DompJ7cH1pmYuVk5wF
         mByg==
X-Gm-Message-State: AOJu0YyxS+wVyKfWnyaCGHpkABm2SX8Vrlw313N5CLF3xJ8XAMm7SeBu
	ZgK5njs/cbHCl4ADXw3vVJHQbzGLRajj/72Ygfz9wydqpXByoBNPtrty2Y0FaA==
X-Gm-Gg: ASbGncv+0a09CSRLyjkuiw+x7u0WF50XfKujPogv3CL2JWGKXgtvmkmHaBs8PLroQEm
	hz8QBycRl2PAL8E7pPKLAZwXWqe0v/XdTKOKxsPlghRMHCiYYY3Q8StMMLvMdMfWH2li5DD50gW
	qNNSrqz4Lkfy2ynIWJMQ1XuL3FSJ2QKNjMDuc0bQDHhCtgw1mSuu2oA2uaNrFGkRGJhsQ1rh8oj
	HZ+hgKHv1zUbCxi+4b1ehmzxzGiqsdv8dcH9O6O+/6OY71QWJcCU3Uz8w6XtNXvg6DGvL1ntNrJ
	yZCuCqQwVWUXkUtH4FJIhqZpj4DvajbZaj8BHqWW5ekXNFgqX98v5avUStIIbNeHidYOLnwa44o
	NN7Jp6ZUh2qm4Ks1A6ALkzxk12zE=
X-Google-Smtp-Source: AGHT+IELX6g8eZztw7NcNuhVu/hOcHGnrvMzLnL2HdezSPutOKjy9aRx5y0YFhxgPeYG438YyA3F3Q==
X-Received: by 2002:a17:90b:1c03:b0:32d:e07f:3236 with SMTP id 98e67ed59e1d1-32de4f9613cmr2244758a91.22.1757673016954;
        Fri, 12 Sep 2025 03:30:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b3e8fsm5284052a91.17.2025.09.12.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:16 -0700 (PDT)
Message-Id: <a1564f74cfa19eee528a1a0c54b87ac52d1e8975.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:06 +0000
Subject: [PATCH v3 2/7] sparse-checkout: add basics of 'clean' command
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
tracked-but-sparse directories.

The implementation details provide a clear definition of what is happening,
but it is difficult to describe this without including the internal
implementation details. The core operation converts the index to a sparse
index (in memory if not already on disk) and then deletes any directories in
the worktree that correspond with a sparse directory entry in that sparse
index.

In the most common case, this means that a file will be removed if it is
contained within a directory that is both tracked and outside of the
sparse-checkout definition. However, there can be exceptions depending on
the current state of the index:

 * If the worktree has a modification to a tracked, sparse file, then that
   file's parent directories will be expanded instead of represented as
   sparse directories. Siblings of those parent directories may be
   considered sparse.

 * If the user staged a sparse file with "git add --sparse", then that file
   loses the SKIP_WORKTREE bit until the sparse-checkout is reapplied. Until
   then, that file's parent directories are not represented as sparse
   directory entries and thus will not be removed. Siblings of those parent
   directories may be considered sparse. (There may be other reasons why
   the SKIP_WORKTREE bit was removed for a file and this impact on the
   sparse directories will apply to those as well.)

 * If the user has a merge conflict outside of the sparse-checkout
   definition, then those conflict entries prevent the parent directories
   from being represented as sparse directory entries and thus are not
   removed.

 * The cases above present reasons why certain _file conditions_ will impact
   which _directories_ are considered sparse. The list of tracked
   directories that are outside of the sparse-checkout definition but not
   represented as a sparse directory further reduces the list of files that
   will be removed.

For these complicated reasons, the documentation details a potential list of
files that will be "considered for removal" instead of defining the list
concretely. The special cases can be handled by resolving conflicts,
committing staged changes, and running 'git sparse-checkout reapply' to
update the SKIP_WORKTREE bits as expected by the sparse-checkout definition.

It is important to make clear that this operation will remove ignored and
excluded files which would normally be ignored even by 'git clean -f' unless
the '-x' or '-X' option is provided. This is the most extreme method for
doing this, but it works when the sparse-checkout is in cone mode and is
expected to rescope based on directories, not files.

The current implementation always deletes these sparse directories
without warning. This is unacceptable for a released version, but those
features will be added in changes coming immediately after this one.

Note that this will not remove an untracked directory (or any of its
contents) if its parent is a tracked directory within the sparse-checkout
definition. This is required to prevent removing data created by tools that
perform caching operations for editors or build tools.

Thus, 'git sparse-checkout clean' is both more aggressive and more careful
than 'git clean -fx':

 * It is more aggressive because it will remove _tracked_ files within the
   sparse directories.

 * It is less aggressive because it will leave _untracked_ files that are
   not contained in sparse directories.

These special cases will be handled more explicitly in a future change that
expands tests for the 'git sparse-checkout clean' command. We handle some of
the modified, staged, and committed states including some impact on 'git
status' after cleaning.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc |  19 ++++-
 builtin/sparse-checkout.c              |  64 ++++++++++++++-
 t/t1091-sparse-checkout-builtin.sh     | 103 +++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 529a8edd9c..baaebce746 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -9,7 +9,7 @@ git-sparse-checkout - Reduce your working tree to a subset of tracked files
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules) [<options>]
+'git sparse-checkout' (init | list | set | add | reapply | disable | check-rules | clean) [<options>]
 
 
 DESCRIPTION
@@ -111,6 +111,23 @@ flags, with the same meaning as the flags from the `set` command, in order
 to change which sparsity mode you are using without needing to also respecify
 all sparsity paths.
 
+'clean'::
+	Opportunistically remove files outside of the sparse-checkout
+	definition. This command requires cone mode to use recursive
+	directory matches to determine which files should be removed. A
+	file is considered for removal if it is contained within a tracked
+	directory that is outside of the sparse-checkout definition.
++
+Some special cases, such as merge conflicts or modified files outside of
+the sparse-checkout definition could lead to keeping files that would
+otherwise be removed. Resolve conflicts, stage modifications, and use
+`git sparse-checkout reapply` in conjunction with `git sparse-checkout
+clean` to resolve these cases.
++
+This command can be used to be sure the sparse index works efficiently,
+though it does not require enabling the sparse index feature via the
+`index.sparse=true` configuration.
+
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files.
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 06de61bd9d..f7caa28f3f 100644
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
+	if (!core_apply_sparse_checkout)
+		die(_("must be in a sparse-checkout to clean directories"));
+	if (!core_sparse_checkout_cone)
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
@@ -1080,6 +1141,7 @@ int cmd_sparse_checkout(int argc,
 		OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
 		OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
 		OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
+		OPT_SUBCOMMAND("clean", &fn, sparse_checkout_clean),
 		OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
 		OPT_SUBCOMMAND("check-rules", &fn, sparse_checkout_check_rules),
 		OPT_END(),
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ab3a105fff..bdb7b21e32 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1050,5 +1050,108 @@ test_expect_success 'check-rules null termination' '
 	test_cmp expect actual
 '
 
+test_expect_success 'clean' '
+	git -C repo sparse-checkout set --cone deep/deeper1 &&
+	git -C repo sparse-checkout reapply &&
+	mkdir repo/deep/deeper2 repo/folder1 &&
+
+	# Add untracked files
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
+test_expect_success 'clean with sparse file states' '
+	test_when_finished git reset --hard &&
+	git -C repo sparse-checkout set --cone deep/deeper1 &&
+	mkdir repo/folder2 &&
+
+	# create an untracked file and a modified file
+	touch repo/folder2/file &&
+	echo dirty >repo/folder2/a &&
+
+	# First clean/reapply pass will do nothing.
+	git -C repo sparse-checkout clean >out &&
+	test_must_be_empty out &&
+	test_path_exists repo/folder2/a &&
+	test_path_exists repo/folder2/file &&
+
+	git -C repo sparse-checkout reapply 2>err &&
+	test_grep folder2 err &&
+	test_path_exists repo/folder2/a &&
+	test_path_exists repo/folder2/file &&
+
+	# Now, stage the change to the tracked file.
+	git -C repo add --sparse folder2/a &&
+
+	# Clean will continue not doing anything.
+	git -C repo sparse-checkout clean >out &&
+	test_line_count = 0 out &&
+	test_path_exists repo/folder2/a &&
+	test_path_exists repo/folder2/file &&
+
+	# But we can reapply to remove the staged change.
+	git -C repo sparse-checkout reapply 2>err &&
+	test_grep folder2 err &&
+	test_path_is_missing repo/folder2/a &&
+	test_path_exists repo/folder2/file &&
+
+	# We can clean now.
+	cat >expect <<-\EOF &&
+	Removing folder2/
+	EOF
+	git -C repo sparse-checkout clean >out &&
+	test_cmp expect out &&
+	test_path_is_missing repo/folder2 &&
+
+	# At the moment, the file is staged.
+	cat >expect <<-\EOF &&
+	M  folder2/a
+	EOF
+
+	git -C repo status -s >out &&
+	test_cmp expect out &&
+
+	# Reapply persists the modified state.
+	git -C repo sparse-checkout reapply &&
+	cat >expect <<-\EOF &&
+	M  folder2/a
+	EOF
+	git -C repo status -s >out &&
+	test_cmp expect out &&
+
+	# Committing the change leads to resolved status.
+	git -C repo commit -m "modified" &&
+	git -C repo status -s >out &&
+	test_must_be_empty out &&
+
+	# Repeat, but this time commit before reapplying.
+	mkdir repo/folder2/ &&
+	echo dirtier >repo/folder2/a &&
+	git -C repo add --sparse folder2/a &&
+	git -C repo sparse-checkout clean >out &&
+	test_must_be_empty out &&
+	test_path_exists repo/folder2/a &&
+
+	# Committing without reapplying makes it look like a deletion
+	# due to no skip-worktree bit.
+	git -C repo commit -m "dirtier" &&
+	git -C repo status -s >out &&
+	test_must_be_empty out &&
+
+	git -C repo sparse-checkout reapply &&
+	git -C repo status -s >out &&
+	test_must_be_empty out
+'
 
 test_done
-- 
gitgitgadget

