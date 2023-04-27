Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92400C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbjD0Wcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344287AbjD0Wcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:32:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807923A89
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:32:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8bf9f09340so15435201276.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682634762; x=1685226762;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YB3oGuOlPsaeWIA2HRR4TxsjpUxIoq/HbR3GtmzpQkI=;
        b=1ME2sS7iux3ABcjZreRrE4RgOQT6fpwm+7b652oIK3gGR4S4YlCQgxDl8MAgyu9Td0
         iERqV4OkxkPdkgtCCTUyuASqFws8TQCdmZRrcp34idWFC4hpdNLRomh2kMFiRlsPSRmo
         J0WAdSiHaDB2+vrhC02ixXDMHu0LSblbzi0gu/GC9Gxiwl3HcA9mJzn2IkfAo3YYqJEV
         ipleCpivv5I0RAhEFjqPvVHIp1q1P+9zQhJPgGeUp/KLRNSFGPmr21YCGEZLuU0MJgQk
         lCQh+1B+HWEDN/v+4WBRjz8+y3KYmt782h01K00gIBvfh7uG/0lvouncu1el+mWqL7yQ
         lWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634762; x=1685226762;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YB3oGuOlPsaeWIA2HRR4TxsjpUxIoq/HbR3GtmzpQkI=;
        b=Gdd6fG7mCY1nd8O6do5WeQ2nlR+EGm2n3MBvlRiUmD+3qRTlTx9RiiengPZplUlKw+
         pdo4/TTNhuEyODgY09OyLWny5hkh4TvWy+nf0JFfTisf1ai+mXZ49xyDLv5KUbuOB+G6
         QpMw9AYpDoHyQzi/uabxR99+4Be4FgrRuJsjwotRqiMkyBUJKt2vq1tag0/iDgR+uU3i
         VSME5uE/si9AFYUMVGrY29qMNjGB5VB/kHGp4FpqN6wXXkw+CmVYkV10gsgDx4zS+3L8
         5afXLJkWZIxwwF11hrta2wWCIrC2NmAoEnkRvnFwp/6llmX0sQ6b6CK44jF2vUl9ANCe
         KW3w==
X-Gm-Message-State: AC+VfDzQZzBnvpZRcmJIz86EIE95SvzHTsOX5KhZU8Z9UbIUTf4OV36p
        8e5Mc3OwZ7CbDRKWYlY3rq2RWgSDs52aM0TssBu7n1YZji5GxHMskysiu31oBELTui2eCee/3CK
        yA7rt2VS8opuwtdjC0dNdeXpXfl8wVUCWwIXqvwSz8TgXDrzz0G00QEpsiwHhaPE=
X-Google-Smtp-Source: ACHHUZ7RJSbHmGG7IgT0uj/BY0MiTEjqBqe0uQ2PhN3tgARH/Dw/cl3IxTy9RvL10uWVGsSjUjq+ia/qaIp8SA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:9f29:bd1c:a657:5a1d])
 (user=steadmon job=sendgmr) by 2002:a25:1182:0:b0:b98:f947:1c1f with SMTP id
 124-20020a251182000000b00b98f9471c1fmr1186384ybr.2.1682634762752; Thu, 27 Apr
 2023 15:32:42 -0700 (PDT)
Date:   Thu, 27 Apr 2023 15:32:40 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
Subject: [PATCH] setup: trace bare repository setups
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

safe.bareRepository=explicit is a safer default mode of operation, since
it guards against the embedded bare repository attack [1]. Most end
users don't use bare repositories directly, so they should be able to
set safe.bareRepository=explicit, with the expectation that they can
reenable bare repositories by specifying GIT_DIR or --git-dir.

However, the user might use a tool that invokes Git on bare repositories
without setting GIT_DIR (e.g. "go mod" will clone bare repositories
[2]), so even if a user wanted to use safe.bareRepository=explicit, it
wouldn't be feasible until their tools learned to set GIT_DIR.

To make this transition easier, add a trace message to note when we
attempt to set up a bare repository without setting GIT_DIR. This allows
users and tool developers to audit which of their tools are problematic
and report/fix the issue.  When they are sufficiently confident, they
would switch over to "safe.bareRepository=explicit".

Note that this uses trace2_data_string(), which isn't supported by the
"normal" GIT_TRACE2 target, only _EVENT or _PERF.

[1] https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com/
[2] https://go.dev/ref/mod

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Josh Steadmon <steadmon@google.com>
Change-Id: I8e8b5e70ce8c6c81ec4716187c27c44da38b35db
---
 setup.c                         |  1 +
 t/t0035-safe-bare-repository.sh | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/setup.c b/setup.c
index 59abc16ba6..458582207e 100644
--- a/setup.c
+++ b/setup.c
@@ -1352,6 +1352,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		}
 
 		if (is_git_directory(dir->buf)) {
+			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
 			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
 				return GIT_DIR_DISALLOWED_BARE;
 			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))
diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
index 11c15a48aa..a1f3b5a4d6 100755
--- a/t/t0035-safe-bare-repository.sh
+++ b/t/t0035-safe-bare-repository.sh
@@ -7,13 +7,24 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 pwd="$(pwd)"
 
-expect_accepted () {
-	git "$@" rev-parse --git-dir
+expect_accepted_implicit () {
+	test_when_finished "rm \"$pwd/trace.perf\"" &&
+	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
+	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
+}
+
+expect_accepted_explicit () {
+	test_when_finished "rm \"$pwd/trace.perf\"" &&
+	GIT_DIR="$@" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
+	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
 }
 
 expect_rejected () {
-	test_must_fail git "$@" rev-parse --git-dir 2>err &&
-	grep -F "cannot use bare repository" err
+	test_when_finished "rm \"$pwd/trace.perf\"" &&
+	test_env GIT_TRACE2_PERF="$pwd/trace.perf" \
+		test_must_fail git "$@" rev-parse --git-dir 2>err &&
+	grep -F "cannot use bare repository" err &&
+	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
 }
 
 test_expect_success 'setup bare repo in worktree' '
@@ -22,12 +33,12 @@ test_expect_success 'setup bare repo in worktree' '
 '
 
 test_expect_success 'safe.bareRepository unset' '
-	expect_accepted -C outer-repo/bare-repo
+	expect_accepted_implicit -C outer-repo/bare-repo
 '
 
 test_expect_success 'safe.bareRepository=all' '
 	test_config_global safe.bareRepository all &&
-	expect_accepted -C outer-repo/bare-repo
+	expect_accepted_implicit -C outer-repo/bare-repo
 '
 
 test_expect_success 'safe.bareRepository=explicit' '
@@ -47,7 +58,7 @@ test_expect_success 'safe.bareRepository in the repository' '
 
 test_expect_success 'safe.bareRepository on the command line' '
 	test_config_global safe.bareRepository explicit &&
-	expect_accepted -C outer-repo/bare-repo \
+	expect_accepted_implicit -C outer-repo/bare-repo \
 		-c safe.bareRepository=all
 '
 
@@ -60,4 +71,8 @@ test_expect_success 'safe.bareRepository in included file' '
 	expect_rejected -C outer-repo/bare-repo
 '
 
+test_expect_success 'no trace when GIT_DIR is explicitly provided' '
+	expect_accepted_explicit "$pwd/outer-repo/bare-repo"
+'
+
 test_done

base-commit: 2807bd2c10606e590886543afe4e4f208dddd489
-- 
2.40.1.495.gc816e09b53d-goog

