Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4302EA16D
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673025; cv=none; b=LICHW7FuDToT0Scg2BiP9d0bWeitfF9SDyFmUJ2UvcRXrLxhyLwoOQ4EeouaCBzkvZaaw0d9FOuoDtqkKFrOkQCuLXirZbVJacbFGKcGjHNGnf6V9sQ9oOC/YH+dGw4TVz1E261VFBDdeIS3ZS/5yZl0uzo4yD4x3Vb/E2YZH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673025; c=relaxed/simple;
	bh=vUWLChWCdTH1mP7QAjTzfkJZGTGOkEdeiacNYLzwUMY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ThKlsC/axbGnkV6xsekuYPdw8BqEZQIam6XPvx2jzUUkNpauwb0uIHu+WPRD3/hCoQHfwM6P1mw9IsP6Z0PgCDQ22IheIG+RiOWXslVRrKsmqwj3Fa+gELbqKxu+DT+aHw+TTc4TNojcb2Sjl683VyZN0KjdYmKv5iVVM4iEtB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQHUBkM3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQHUBkM3"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772627dd50aso3235356b3a.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757673023; x=1758277823; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s22SsuCfcC2UD+kh2yP1u7Dx7E2LGn0EeLhO3tmA8g4=;
        b=TQHUBkM3TOy18t6QaY5IP5bVXhPqISJDMrxwc4R1FMDdI/E+1TPM0jnGht/AyI7EbB
         LCsAKslDU7M7DBA8ySCREXoUJH+JrFuNGWnyx6Ihf38TK6gr107Zvkub7uYNxV9wn6k5
         SuRBH1O/XcWgHAweBNJMFc0K3WibEmGxf69c+yubvc3jjlxIqqUOgTBtYm92jFHUZ48F
         T3igPgSXhJoL9Gwy25Pf8yfmS8CI9vzRdS1G1nnW/w8Zmby5514jJ7OFSBNilW9WI6R/
         Dxrq0jOxK/2NlvGdnAsrAONTqQlWm1M3agvaZb2pXUrzK74t/xlnYp8BUB2EkVaQlor0
         yBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673023; x=1758277823;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s22SsuCfcC2UD+kh2yP1u7Dx7E2LGn0EeLhO3tmA8g4=;
        b=XDBfk6+7J+zqAkpLUvGXEvL11gvc4spd4OAKqgALyFraHHx+VYI9KY1LNoNtHKFyux
         XVTOKPWD3AyzpzlRztgn0szzVBGAwPUk5hHzPK/wLNJLpOQfihtrOj0tcUoFGd2yzf+j
         BUUHd66K07XtBRYBIFPkDnPMbuvRt/qRt4mI6RZ6K2ExRU4iMiZ8WRsDkXKfbOjgI+a8
         Q74CK2Bhx7SPFpFLt8UkHEt+AhfbCVJDarwCzMWUST+hvCRnFTBgbqQkPgjT3DdY3JQz
         y1uJ9z4vax8FthR2VtolWP0/IywUI4buD56Vf0AKgJNHqpnwBc7c4Gew7EDyPQmTwo/G
         y99Q==
X-Gm-Message-State: AOJu0YwnQ9+demqxxSiMdaXamWeoFgohnN7hVIgh2T8gK0OjI1N1yWl8
	pWhRLqr0x9pnh5JC1wfJpMaZyp8xuSNwzQ4yb6Gxv9sMgIIQ4cY3igHUZ89PkQ==
X-Gm-Gg: ASbGncvyVpbOnngHLD9hkuo/VEkh7kvZae0r84UlzTODz/tUEt7SuGPQOabu1HC+xUw
	OwUZ3m4KjgoDx8cXWHX4uxqnwkfasGQ/k8fDBdDxyGqzVK9DXP/ijsE9siAHVZYLjJucfDRKQTi
	kfL6J12VCL2a+4VRJsEsgwk2FzA2RwFGjXB1cBE7WhPBu31eCP5jPhfuVlvaAiMNhuePnuiSV/1
	vw0yzPOdWHYHirX2TWjB3WGk43P0PmdihvUONglTMQc5jMAKE7m8PVIfvjkIOxH7lOZ3EwbLf1G
	gz2P4JhUXc1Vh6TXLz6cIQ77KMxSwOvfaPE8skSc3YD8Kb9rcGibTyZ6gbNw2zsYpJ4GHHEHYRW
	HGdht35W884O7sGKemHwn6eLjns4=
X-Google-Smtp-Source: AGHT+IF8QLtgm8uM2YvMjI4MF09cndYMLtuudSocnyx49Ac+JbeQgSw6Sn7ioZaiytuzJ5h0iFEKsw==
X-Received: by 2002:a05:6a21:6d98:b0:246:458:8544 with SMTP id adf61e73a8af0-25cf5d082a1mr9570658637.3.1757673022646;
        Fri, 12 Sep 2025 03:30:22 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.175.152])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c78b5sm4458384a12.21.2025.09.12.03.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:30:21 -0700 (PDT)
Message-Id: <2cde464fd4c225144489c222537e5d7549f81849.1757673011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
	<pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Sep 2025 10:30:09 +0000
Subject: [PATCH v3 5/7] sparse-checkout: add --verbose option to 'clean'
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

The 'git sparse-checkout clean' subcommand is focused on directories,
deleting any tracked sparse directories to clean up the worktree and
make the sparse index feature work optimally.

However, this directory-focused approach can leave users wondering why
those directories exist at all. In my experience, these files are left
over due to ignore or exclude patterns, Windows file handles, or
possibly merge conflict resolutions.

Add a new '--verbose' option for users to see all the files that are
being deleted (with '--force') or would be deleted (with '--dry-run').

Based on usage, users may request further context on this list of files for
states such as tracked/untracked, unstaged/staged/conflicted, etc.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-sparse-checkout.adoc |  5 +++++
 builtin/sparse-checkout.c              | 28 ++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh     | 14 ++++++++++---
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-sparse-checkout.adoc
index 42050ff5b5..113728a0e7 100644
--- a/Documentation/git-sparse-checkout.adoc
+++ b/Documentation/git-sparse-checkout.adoc
@@ -136,6 +136,11 @@ The `--dry-run` option will list the directories that would be removed
 without deleting them. Running in this mode can be helpful to predict the
 behavior of the clean comand or to determine which kinds of files are left
 in the sparse directories.
++
+The `--verbose` option will list every file within the directories that
+are considered for removal. This option is helpful to determine if those
+files are actually important or perhaps to explain why the directory is
+still present despite the current sparse-checkout.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index d777b64960..8d3c3485f5 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -930,6 +930,26 @@ static char const * const builtin_sparse_checkout_clean_usage[] = {
 	NULL
 };
 
+static int list_file_iterator(const char *path, const void *data)
+{
+	const char *msg = data;
+
+	printf(msg, path);
+	return 0;
+}
+
+static void list_every_file_in_dir(const char *msg,
+				   const char *directory)
+{
+	struct strbuf path = STRBUF_INIT;
+
+	strbuf_addstr(&path, directory);
+	fprintf(stderr, "list every file in %s\n", directory);
+
+	for_each_file_in_dir(&path, list_file_iterator, msg);
+	strbuf_release(&path);
+}
+
 static const char *msg_remove = N_("Removing %s\n");
 static const char *msg_would_remove = N_("Would remove %s\n");
 
@@ -940,12 +960,13 @@ static int sparse_checkout_clean(int argc, const char **argv,
 	struct strbuf full_path = STRBUF_INIT;
 	const char *msg = msg_remove;
 	size_t worktree_len;
-	int force = 0, dry_run = 0;
+	int force = 0, dry_run = 0, verbose = 0;
 	int require_force = 1;
 
 	struct option builtin_sparse_checkout_clean_options[] = {
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
+		OPT__VERBOSE(&verbose, N_("report each affected file, not just directories")),
 		OPT_END(),
 	};
 
@@ -987,7 +1008,10 @@ static int sparse_checkout_clean(int argc, const char **argv,
 		if (!is_directory(full_path.buf))
 			continue;
 
-		printf(msg, ce->name);
+		if (verbose)
+			list_every_file_in_dir(msg, ce->name);
+		else
+			printf(msg, ce->name);
 
 		if (dry_run <= 0 &&
 		    remove_dir_recursively(&full_path, 0))
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e6b768a8da..7b15fa669c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -1053,11 +1053,11 @@ test_expect_success 'check-rules null termination' '
 test_expect_success 'clean' '
 	git -C repo sparse-checkout set --cone deep/deeper1 &&
 	git -C repo sparse-checkout reapply &&
-	mkdir repo/deep/deeper2 repo/folder1 &&
+	mkdir -p repo/deep/deeper2 repo/folder1/extra/inside &&
 
 	# Add untracked files
 	touch repo/deep/deeper2/file &&
-	touch repo/folder1/file &&
+	touch repo/folder1/extra/inside/file &&
 
 	test_must_fail git -C repo sparse-checkout clean 2>err &&
 	grep "refusing to clean" err &&
@@ -1074,7 +1074,15 @@ test_expect_success 'clean' '
 	git -C repo sparse-checkout clean --dry-run >out &&
 	test_cmp expect out &&
 	test_path_exists repo/deep/deeper2 &&
-	test_path_exists repo/folder1 &&
+	test_path_exists repo/folder1/extra/inside/file &&
+
+	cat >expect <<-\EOF &&
+	Would remove deep/deeper2/file
+	Would remove folder1/extra/inside/file
+	EOF
+
+	git -C repo sparse-checkout clean --dry-run --verbose >out &&
+	test_cmp expect out &&
 
 	cat >expect <<-\EOF &&
 	Removing deep/deeper2/
-- 
gitgitgadget

