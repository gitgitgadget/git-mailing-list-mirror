Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E118EAD
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886775; cv=none; b=rLBnR3ZfUfEwl1M+zWiDUpeF+s8W40wWGCUtCUxeWl7X8nj+CPrMv+pXIjKrt9UhCEq+es8Jk0tGXSH/AKNNavWcZKjYEGH9n51zH1Bjeb0tDP+rZwLZAEo0CZb2lJfArseuKcILBIdrg10zh7eAsID6RKJIOg7C1Bz/oHi9gWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886775; c=relaxed/simple;
	bh=PNSzVKEuRZc6xkl4r+TZSrEPYBeP+MCEuF1kPAAp7uI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjxcD3fBhbiSSIF0Ux0QeBDflSKCYD/pJT80BXk1p93j/pOiwASFo3rHLMfiuLK3X6dxgtFa6sBMyFqXuWqeuOOV50R1eoZywLKUmE0JkU+dg9j47XIctJXoWGjcpZUH1SOAHlFyYRfIXybUVe8hYXyOCRWLumFavgBTvUO383c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sf.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQOM3PDZ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sf.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQOM3PDZ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-45812fdcd0aso33035371cf.0
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726886772; x=1727491572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD2dyHht33a0wPVPwu5q3Yp1FvqYwpDuwLCfjxYEGwc=;
        b=BQOM3PDZ/jvcLgRNUBKuThlq1h4orV4sjLdG7+bcxDoytYxf5g8orvKwlHnCiUC90F
         pHwDz2HlyoN9LyjhGDlnZeDT7EhELSDNFoM5OgDcHLZJ8c0fv8mLliDLRQcA+EN46OUF
         w4kHXwo1N/cFWN5WdJo0Gd3lrF4db99fb+yA8PA4O6F887kgwiP1NLDW4BNnrvLrD738
         DaOtC44pfnwEiRQmwZiXRWL7yHUhtv/Pb8lzHSIJ/ocVUTwKmgTNmU2fq2p2zgL+0x1C
         KicesuyLzvZP2tgHJ8TU8rPJs0oaSRndogDfgnbclBGKuzX1MdKD/51U9F0lALxbpjRQ
         0Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726886772; x=1727491572;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD2dyHht33a0wPVPwu5q3Yp1FvqYwpDuwLCfjxYEGwc=;
        b=Mrr5B6KWhoUvEB94w2obW+wH/9v/tZwxPpsK4nSXYZo9AzN0LUVFKedDqoIj9TcvuP
         lHyfimApLlRiE9lhkPfJZ4sKB7g4Bti4fXlSh1XjiQFc1jGqJXhLR+fVQbs0torWYFob
         7nAJpIO7Mu1mKkr7iYRS/y/OqZzn9FUZ9mJWPwnRPnyHNOetH29djM1xp/7wmJrtsEIw
         BIhQcfr08Pdz99Z+MFAD05xpTx6jQzzeQOqNVDURCgRSivRQAdMyQ/eSi2NJzoZqfR0s
         SJZ/lw+02PSoY7aQHq9Mw47OWmMT8BAoiOpuOPz52k0lXgGYTpUQvJ5P3cW8VYxhiLP2
         6zhg==
X-Gm-Message-State: AOJu0Yw0zNZxXzvYvHkAUM+dNAfv7SnLtrA5dpvTPKlIrAQtVqJG8SRf
	nmJlSrp92qBgwSFTnv8dKLoTpDTQRq0aQKAW+/9xgF4wWd0WoeL7/1a1AQ==
X-Google-Smtp-Source: AGHT+IEj5QT8N2RmrK1KVRtywleb34QgkTDxc+H6GQs+VvMbKumw39OXytHY47azC5AXj9MDr7tyrQ==
X-Received: by 2002:a05:622a:1347:b0:459:a824:a1c2 with SMTP id d75a77b69052e-45b2026c99fmr99631161cf.22.1726886771855;
        Fri, 20 Sep 2024 19:46:11 -0700 (PDT)
Received: from opti.lan (pool-71-183-241-13.nycmny.fios.verizon.net. [71.183.241.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17888921sm24700181cf.41.2024.09.20.19.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 19:46:11 -0700 (PDT)
Sender: j j <gonch.dmitry@gmail.com>
From: dgoncharov@users.sf.net
To: git@vger.kernel.org
Cc: newren@gmail.com,
	Dmitry Goncharov <dgoncharov@users.sf.net>
Subject: [PATCH] merge-ort: fix a crash in process_renames
Date: Fri, 20 Sep 2024 22:45:33 -0400
Message-Id: <20240921024533.15249-2-dgoncharov@users.sf.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240921024533.15249-1-dgoncharov@users.sf.net>
References: <20240921024533.15249-1-dgoncharov@users.sf.net>
Reply-To: dgoncharov@users.sf.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Goncharov <dgoncharov@users.sf.net>

cherry-pick --strategy=ort (the default at the moment) crashes in the following
scenario

$ ls -a
.  ..
$ mkdir tools
$ git init -q -b side2
$ echo hello>tools/hello
$ git add  tools/hello
$ git commit -q tools/hello -m'Add tools/hello.'
$ git branch side1
$ echo world>world
$ git add world
$ git commit -q world -m'Add world.'
$ git mv  world tools/world
$ git commit -q -m'mv world tools/world.'
$ git checkout -q side1
$ git mv tools/hello hello
$ git commit -q -m'mv tools/hello hello.'
$ git cherry-pick --strategy=ort side2
git: merge-ort.c:3006: process_renames: Assertion `source_deleted || oldinfo->filemask & old_sidemask' failed.
Aborted (core dumped)

While cherry picking the top commit from side2 to side1 collect_renames is
confused by the preceding move from "tools/hello" to "hello" that took place on
side1. This move from "tools/hello" to "hello" causes the logic in
check_for_directory_rename to incorrectly conclude that "tools/world" should be
renamed to "world".  detect_and_process_renames proceeds with "world" instead
of "tools/world" and ends up tripping on an assertion in process_renames.

In the same scenario cherry-pick --strategy=recursive detects a merge conflict.

$ rm .git/index.lock
$ git reset -q --hard
$ git cherry-pick --strategy=recursive side2
CONFLICT (file location): world renamed to tools/world in fead592 (mv world tools/world.), inside a directory that was renamed in HEAD, suggesting it should perhaps be moved to world.
CONFLICT (content): Merge conflict in world
error: cache entry has null sha1: world
error: cherry-pick: Unable to write new index file
fatal: cherry-pick failed

There really is a merge conflict and the goal of this commit is to have
cherry-pick --strategy=ort detect the conflict.  This commit modifies
collect_renames to ignore an implicit directory rename that suggests moving a
file to itself.

Also, see test t3515-cherry-pick-move.sh.

Signed-off-by: Dmitry Goncharov <dgoncharov@users.sf.net>
---
 merge-ort.c                 |  9 +++++++
 t/t3515-cherry-pick-move.sh | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100755 t/t3515-cherry-pick-move.sh

diff --git a/merge-ort.c b/merge-ort.c
index 691db9050e..e58fb7a7fa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3369,6 +3369,15 @@ static int collect_renames(struct merge_options *opt,
 						      collisions,
 						      &clean);
 
+		if (new_path && !strcmp(new_path, p->one->path)) {
+			/* Ignore an implicit directory rename that suggests replacing a move
+			 * from one->path to two->path with a move
+			 * from one->path to one->path.
+			 */
+			free(new_path);
+			new_path = NULL;
+		}
+
 		possibly_cache_new_pair(renames, p, side_index, new_path);
 		if (p->status != 'R' && !new_path) {
 			pool_diff_free_filepair(&opt->priv->pool, p);
diff --git a/t/t3515-cherry-pick-move.sh b/t/t3515-cherry-pick-move.sh
new file mode 100755
index 0000000000..20af478d4e
--- /dev/null
+++ b/t/t3515-cherry-pick-move.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='Test cherry-picking a move commit.'
+
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=side2
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success setup '
+	mkdir tools &&
+
+	echo hello >tools/hello &&
+
+	git add tools/hello &&
+	git commit -m"Add tools/hello." tools/hello &&
+
+	git branch side1 &&
+
+	# This commit is the base of the fatal cherry-pick merge.
+	echo world >world &&
+	git add world &&
+	git commit -m"Add world." &&
+
+	# Cherry picking this commit crashes git.
+	# This commit is side 2 of the fatal cherry-pick merge.
+	git mv -v world tools/world &&
+	git commit -m"mv world tools/world." &&
+
+	git checkout side1 &&
+	# This commit is side 1 of the fatal cherry-pick merge.
+	git mv -v tools/hello hello &&
+	git commit -m"mv tools/hello hello"
+'
+
+test_expect_success 'recursive cherry-pick of a move commit' '
+	test_must_fail git cherry-pick --strategy=recursive side2
+'
+
+test_expect_success 'ort cherry-pick of a move commit' '
+	rm -f world &&
+	git reset --hard &&
+	test_must_fail git cherry-pick --strategy=ort side2
+'
+
+test_done
-- 
2.34.1

