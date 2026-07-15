Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC338238D
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125969; cv=none; b=g4rat8lO/Z5bUemHaX5SxmRSex+iRuV4IXpxD7hI0D1+pZh2BQDtrcDYzxtpwv5qWvomK9DMvNkp3kPG+1rAcdNW4QBy+AfT0+0DAXlLOHUe+vKhZjGuzDV7QcaQMCQBD9I6adwP2pdFHzTp5zki82/+A2F4nHVJk5qteSc2wD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125969; c=relaxed/simple;
	bh=PTmgyO7oIj++S5W/C3zmDmplNo43hznp0nSWSDO+CYw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=aFd+d9YFZUFe0XNT8idA8qFQJ9sWNzt3hy54LcugIW63Cpd31H7B7Sc0wja1mz40p8rxZEmhbIsSO7X4/2hcdPXEc3xYog9CWt+eSVdbd+zM85hIKFyfEoAeyhClYTT6xXRNc5WAkP3cmC9x0MfUSFxqCm7LxBoVc+A3Toj3C24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZED/xcdj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZED/xcdj"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so4206155e87.0
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784125966; x=1784730766; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fh6q65p5kaVq8tf+y0UeUJLBf0RFPA581dV2X3NtyLQ=;
        b=ZED/xcdjS9cXPEerrOy+OAmA+ARbHYzB3GDczu25ixIs5DLe4GMe078nIK4ny6xT5J
         Z6gJXRPee/PHrdfituR8POmF1WBpeMKXfYDXp6zB9a4JfP2ZBVIHdA8BPVHHYhP3//+2
         EH155cFNzSQCM2eAZULc/0jOdTYoKs0PWx6FnmPbkHSxlQp3HbwPScWt49PXwjx4DOKR
         V8FVo7+s1BbmIqmiWyg4zW4UDlc529tS4Ld9Q32ixkRkjMEClbDbqk0Vrk6VlPBtyo5f
         Y9YXoRVqwP2dgWBADjMSfW9Ok5ZVI/tQXWu1xSfZQ32iDbNTIVXOIBX5/VYZtQ0EA5UM
         DYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125966; x=1784730766;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fh6q65p5kaVq8tf+y0UeUJLBf0RFPA581dV2X3NtyLQ=;
        b=AV4TR9a4chudGtuRs0NOvTjW+K9vrswLCQK6wjE26Ih2Ztdcy+lFaNa2OVRy86X1Pq
         V9rRnsNqCUzeZDsJR/zyuhbzUQ1aYOwLSS8nOs/08vUe/2lYsLrJKG4JB3f8tPAp/kpF
         HpASTsoX3WueP6fd6ZYMbS7zE+bHTlXpEvy+GlQUEqfjAp6GLaG1qeCouMEcHIICXS+p
         9xMOLpA7LEq7kEajSbMgmcvWR7SAtcQ4GmZ6J1sp3QqFm49Ug+qkIT144Tah1kFoMm1u
         rE2Oye5dUxxqfBUpzlA+YkoNJsekQlSI42C8vnANl6OMSTJF10jIH1FhOvLKFKFKgtoH
         qqSQ==
X-Gm-Message-State: AOJu0YxS3V2H4acXaaTIuWtOzMQgwGK40unO4frK5jl087RK8WYnxuSO
	GQla9/8HzxLFQN5MCvXfvx+yTPdd/M1h2uH6tMIrVvXsDeuFFgQIn18SiAMsyg==
X-Gm-Gg: AfdE7cnlevNGfK6Lkj//xcp0k7kvnGgr13iMHYlBbpbqNF780FTN+zJtqdiI6BaMDum
	Jo50Z32zVArrU5meDyXj3tiqGub56F+h6kAOpPYrxaFuVepqkLHbQbxgKBkluKDePXgkKRAs0FH
	lKAwVLPSLVL3dwClGjb7DcAW19J2fCNM8/Vv6hMlqp1r2+XlijG/kKte1+c+xne26G32szloxu6
	eddaaEwm5hSnStV8Uno7A3lBzQPZ+3RG4joy+V9JwE6GkbLzq0HymuYZjdb1zIpFf2ziCXbrFU/
	mJq0cybuDwivbsOqwne2awF154D54qm5RRVJJEfzb4vTTXTZbXF4PEvl2FlEkEE5n8nTW9ZTuS6
	ahiJXmm89Qk5gGGk8UF6TE5sxiSCkB5azH1P86X4rpQ1dTL/jdwZNJAMUTHUIrbi4PkvIobFI0j
	OXddvMsQGG+5gtJsPw
X-Received: by 2002:a05:6512:3b86:b0:5b1:5fe4:6f64 with SMTP id 2adb3069b0e04-5b15fe47041mr128392e87.45.1784125965450;
        Wed, 15 Jul 2026 07:32:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.178.119.17])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b13542sm37566371fa.11.2026.07.15.07.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:32:44 -0700 (PDT)
Message-Id: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
From: "Lucas Zamboni Orioli via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 14:32:43 +0000
Subject: [PATCH] mv: report missing destination leading directory
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
Cc: Lucas Zamboni Orioli <lucaszam0@gmail.com>,
    Lucas Zamboni Orioli <lucaszam0@gmail.com>

From: Lucas Zamboni Orioli <lucaszam0@gmail.com>

When moving a file to a destination whose leading directory does not
exist, "git mv" fails at the rename(2) syscall with ENOENT. Because
the error is reported via die_errno() using only the source path:

    fatal: renaming 'src' failed: No such file or directory

the message misleadingly blames the source, even though it is the
destination's parent directory that is missing. A user who runs

    git mv a/file b/does-not-exist/file

is told the problem is with 'a/file', which exists, giving no hint
that 'b/does-not-exist/' needs to be created first.

The checking phase already rejects a missing destination directory
when the destination ends in a slash, but a destination that names a
file inside a non-existent directory is not caught and only fails
later at rename(2). As a result "git mv -n" also fails to detect the
problem, since the dry run never reaches the syscall and reports a
move that would not actually succeed.

Detect this during the checking phase instead: for entries that will
be renamed on disk, stat the destination's leading directory and, if
it is missing, fail with the existing "destination directory does not
exist" message. Guard the check with the same condition under which
rename(2) is invoked so that directory moves, whose child entries are
expanded to paths under a not-yet-created directory, and sparse or
out-of-cone destinations, which are not written to the worktree, are
not flagged incorrectly.

This gives a clear message and lets "git mv -n" report the failure.

Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
---
    mv: report missing destination leading directory

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2356%2FZamboniL%2Fmv-detect-non-existing-target-folder-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2356/ZamboniL/mv-detect-non-existing-target-folder-v1
Pull-Request: https://github.com/git/git/pull/2356

 builtin/mv.c  | 21 +++++++++++++++++++++
 t/t7001-mv.sh | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index e03823370c..a95531f0b2 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -444,6 +444,27 @@ dir_check:
 			goto act_on_entry;
 		}
 
+		/*
+		* If we are going to move SRC to DST on disk, DST's leading
+		* directories must already exist.
+		*/
+		if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
+				!(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
+				char *dst_dir = xstrdup(dst);
+				char *slash = strrchr(dst_dir, '/');
+
+				if (slash) {
+						struct stat dir_st;
+						*slash = '\0';
+						if (lstat(dst_dir, &dir_st) < 0 && errno == ENOENT) {
+								free(dst_dir);
+								bad = _("destination directory does not exist");
+								goto act_on_entry;
+						}
+				}
+				free(dst_dir);
+		}
+
 		if (ignore_sparse &&
 		    (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
 		    index_entry_exists(the_repository->index, dst, strlen(dst))) {
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 920479e925..8a45997b33 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -114,6 +114,20 @@ test_expect_success 'clean up' '
 	git reset --hard
 '
 
+test_expect_success 'moving to non-existent destination parent directory' '
+	git reset --hard &&
+	mkdir -p from &&
+	echo content >from/file &&
+	git add from/file &&
+	test_must_fail git mv from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
+test_expect_success 'mv --dry-run detects non-existent destination parent directory' '
+	test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
+	test_grep "destination directory does not exist" actual
+'
+
 test_expect_success 'moving to existing untracked target with trailing slash' '
 	mkdir path1 &&
 	git mv path0/ path1/ &&

base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
-- 
gitgitgadget
