Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28A19DF48
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240692; cv=none; b=b9CzIB1ZVP0exQK4SEXBHwZkIDbeQiCFKZfaCVw4flxgPeCdoGMENIDtIfdw+PC2hCFjFNNPcFTNq9n81oebui0ZPlksSjGcErj/ewUtud31gS2JxYxtUzqotC+z8mJY+cozEUuooRUNdyIh6F/mPyiYHHFf6INLYQBSmA97Uu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240692; c=relaxed/simple;
	bh=YM7WsbVIPu7ngWJ2B+wyDQdNVNLClawysFOaWjJ9qmk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ORN82Xqlx5C4wA3wVnryblkpWUB8EC2/JVlhman3FqjwQUipemyywX5CgloVd6bfMGgiewFh5a28TW1X6NEtKMmVHojL3weBWi6GA4OHXnewU2cbga6OGk98igBqXePH83VQaeaBeFT5xUEETL66hJYUacnbb0jOnIzFqA8ornM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNEw+aDd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNEw+aDd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso1845545e9.1
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 21:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741240688; x=1741845488; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGLFbHdt7nz837PD8zXk9AOIm9zdWa+zEKPQ0/YuFIo=;
        b=bNEw+aDdbgv4CGBttSrISinq0Wk67AvxrTvJ/mcZuIjlkdekTvWV2AILoUXAbGpDi5
         frJmMJvTx33emxYt6PSrWoiExAHF7OAyH3VfAAFfNO4E0W1GQy30YXCnwQNCpvzOvUlj
         4VtSxI4frA6/dF9gsBaWmd6JZ6rfJaBcvzF+wjRFMqoKSjpR1GH2geiwyszScbwd90jR
         hSMLjUeoEWmCE6qMgwrGfqyMtEpnTucPM7xN8uTQynTuxmYxmGb2h4e/MVIV58/TkW2J
         T2m1ptMuBp960gZR6Ilrj9qZ2cXq/i15jR4y+Gi1hBKvpY+CVc17dZ1eAw4tprUAvGCt
         Kczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741240688; x=1741845488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGLFbHdt7nz837PD8zXk9AOIm9zdWa+zEKPQ0/YuFIo=;
        b=PmDPZj1csL6cUUSPjZzfGxdMCXH0ez0L1ml3I5gcDMBopFEJyYG/HhZjhnAs3hEaBh
         j9m9V8uEXwGAzfyM7Rpj/0TqjoM5osOkauOkioILCoClXM8j3Ud9AJqO5QiGZxZ1agOn
         8JzdTwYxaw+Ahmr6DfM0b7p4x5t+BBVyzx2AyDneaCZXOhWJ5cqYh4a/kvrUDw/FugD8
         4ghfYlVlmIcOLPtqKFNJW0KvX/fMkVPkjMoecTbU8xVM5EXnrPkK9HQYhwc0OF6EwOcZ
         VMKeFs3NjYVfJcmW14TD7U9pyIQXwdAd9b+yV+KcCG6DB4stTwDxUBzRzHViVUDUovl+
         KynA==
X-Gm-Message-State: AOJu0YymaqaQdbEcvrS8JlpjmjccFTQdA6hzbDZoG9ESGq3DdckxS5rc
	sJkz70TYgnyuzsMUwbKAyua7gAcX/Lht4QwdP99++FIb0hzh5Ehjz54uzA==
X-Gm-Gg: ASbGncuZ23eFQCafa1NGDJaKcz6cjFto5sowj9Sv9250H5TLO7biv9DlLC29uoAYm7W
	NOyFUE7EYHuhF8P5FoNHQ+ll8jjZ3T3r7QLZN4gz8k6KqXIw68R15ui6adcrpQnf0yihAZ/oax4
	x18owbLL52/D3F4/otz1zURgLMhxwDdoszX51+qo5DIFb56pTWEciTr5Gso6NlCTSa4OzasELyf
	md2q1B8fiBSJ/BWDxL8QKTO2vFrFDbmEznZiwm0Bgl78Muzu/sC4S6q42/A6IuB6Ign83iSbZKI
	GOB10wSGSlF8wnnv2283ADAS/edAs6NwOIkNVDdXRCMLPw==
X-Google-Smtp-Source: AGHT+IEepMZN6GxUk+FwOfStnR8zGXNlVamd7wJRm0bdnxvNIw7/8x9K+I4a6tZ+T/1DxMPUFwBfRg==
X-Received: by 2002:a05:6000:440a:b0:390:e2a3:cb7b with SMTP id ffacd0b85a97d-3911f7adcdfmr4091153f8f.34.1741240688102;
        Wed, 05 Mar 2025 21:58:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfb16sm850067f8f.29.2025.03.05.21.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:58:07 -0800 (PST)
Message-Id: <3ba3113738e913d51156703b7cf86daf43c7d1b4.1741240685.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
From: "Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 05:58:05 +0000
Subject: [PATCH 2/2] diff: implement --no-optional-locks
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
Cc: Benjamin Woodruff <github@benjam.info>,
    Benjamin Woodruff <benjamin.woodruff@vercel.com>

From: Benjamin Woodruff <benjamin.woodruff@vercel.com>

When used with `autoRefreshIndex`, `git diff` may update the index in
the background for similar performance reasons to `git-status`.

This commit implements the `--no-optional-locks` option for `git diff`,
which allows scripts to bypass this behavior.

Signed-off-by: Benjamin Woodruff <benjamin.woodruff@vercel.com>
---
 Documentation/config/diff.adoc     |  4 ++-
 Documentation/git.adoc             |  3 +-
 builtin/diff.c                     |  4 +++
 t/meson.build                      |  1 +
 t/t4070-diff-auto-refresh-index.sh | 46 ++++++++++++++++++++++++++++++
 5 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100755 t/t4070-diff-auto-refresh-index.sh

diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff.adoc
index 1135a62a0ad..2dadcf7a1da 100644
--- a/Documentation/config/diff.adoc
+++ b/Documentation/config/diff.adoc
@@ -6,7 +6,9 @@
 	contents in the work tree match the contents in the
 	index.  This option defaults to `true`.  Note that this
 	affects only `git diff` Porcelain, and not lower level
-	`diff` commands such as `git diff-files`.
+	`diff` commands such as `git diff-files`. If
+	`--no-optional-locks` is set (see linkgit:git[1] for
+	details), the index file is not updated.
 
 `diff.dirstat`::
 ifdef::git-diff[]
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index f084b2f0f1e..754880b8672 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -190,7 +190,8 @@ If you just want to run git as if it was started in `<path>` then use
 --no-optional-locks::
 	Do not perform optional operations that require locks. This is
 	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`. This
-	functionality is implemented for `git status` and `git describe`.
+	functionality is implemented for `git status`, `git describe`,
+	and `git diff`.
 
 --no-advice::
 	Disable all advice hints from being printed.
diff --git a/builtin/diff.c b/builtin/diff.c
index a4fffee42c6..5469e58bf5d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -9,6 +9,7 @@
 
 #include "builtin.h"
 #include "config.h"
+#include "environment.h"
 #include "ewah/ewok.h"
 #include "lockfile.h"
 #include "color.h"
@@ -239,6 +240,9 @@ static void refresh_index_quietly(void)
 	struct lock_file lock_file = LOCK_INIT;
 	int fd;
 
+	if (!use_optional_locks())
+		return;
+
 	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
 	if (fd < 0)
 		return;
diff --git a/t/meson.build b/t/meson.build
index a59da26be3f..10d7cace3c6 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -500,6 +500,7 @@ integration_tests = [
   't4067-diff-partial-clone.sh',
   't4068-diff-symmetric-merge-base.sh',
   't4069-remerge-diff.sh',
+  't4070-diff-auto-refresh-index.sh',
   't4100-apply-stat.sh',
   't4101-apply-nonl.sh',
   't4102-apply-rename.sh',
diff --git a/t/t4070-diff-auto-refresh-index.sh b/t/t4070-diff-auto-refresh-index.sh
new file mode 100755
index 00000000000..9e38f1d3206
--- /dev/null
+++ b/t/t4070-diff-auto-refresh-index.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2025 Benjamin Woodruff
+#
+
+test_description='diff.autoRefreshIndex config option'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-diff.sh
+
+test_expect_success 'index is updated when autoRefreshIndex is true' '
+	>tracked &&
+	git add tracked &&
+
+	# stat() must change (but not file contents) to trigger an index update
+	test_set_magic_mtime tracked &&
+
+	# check the mtime of .git/index does not change without autoRefreshIndex
+	test_set_magic_mtime .git/index &&
+	git config diff.autoRefreshIndex false &&
+	git diff &&
+	test_is_magic_mtime .git/index &&
+
+	# but it does change when autoRefreshIndex is true (the default)
+	git config diff.autoRefreshIndex true &&
+	git diff &&
+	! test_is_magic_mtime .git/index
+'
+
+test_expect_success '--no-optional-locks overrides autoRefreshIndex' '
+	>tracked &&
+	git add tracked &&
+	test_set_magic_mtime tracked &&
+
+	# `--no-optional-locks` overrides `autoRefreshIndex`
+	test_set_magic_mtime .git/index &&
+	git config diff.autoRefreshIndex true &&
+	git --no-optional-locks diff &&
+
+	# sanity check that without `--no-optional-locks` it still updates
+	test_is_magic_mtime .git/index &&
+	git diff &&
+	! test_is_magic_mtime .git/index
+'
+
+test_done
-- 
gitgitgadget
