Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED4AD1FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 13:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbdDLN6Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 09:58:24 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34792 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752923AbdDLN6W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 09:58:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id o123so5495255pga.1
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYruuXpYtNXiRIZPkS2mTGmz8I71MBgtr8QlJkV7qC0=;
        b=WBZEj604gIBH+2++dA8xH+pZbQDBvnc0AMGG7lneWZW+Rgr8/uBavlwnnsHTf3kXJV
         SyI0FCzlmFYqKe2xdAmQJ3A9IGTkaRJGmA6HzH2NTe3kXePcNE1YaJ5+nTQiuaZ32+da
         02FMStjavcaf5CrXnGebAMmKvHrsEdjusUsjOJZQGtV42wNSVUHrePmVotPrOOVAQknt
         HqMFh3BFabMtfPm5hqdjBE1pONV4zwmZwou6PX6xBNET0Q2Kn/DVXPVkG1K6BdR3z5F+
         9+a5oPpgA6ZaNd5Zk38ePSzH/WxPArXyBsLn3G5E5xbd5s3LChWTc77PoQeCs9YTpmz4
         x3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYruuXpYtNXiRIZPkS2mTGmz8I71MBgtr8QlJkV7qC0=;
        b=FWxyQZi8xtgxr8g3hjZViN1hdR9CYOg4iv+gtz2I5ktjV9AJWXTqVDXctlNWLl8FoU
         73OiB4fIBr+Ny5KEG6aBLykr7DqwpAzYHMs4HHo7YYmVwh93pzkQQkx27DjY4asRtTR4
         S+MnLe7ly3/YXaFBvcRYuSvchjGNfVb1Rj9VJWrJuR8g2YFbrRihen+Rj1LboJ06orGc
         0RC9F5WCI1EKMrg6fKNBgo3Ux2a7ENy0I3lqR4LREhLHwXtq0Ok2B4NQtv62Ya+y3wzV
         NRqNqSFlASwH+3BebQeqVH7aRGusdmMGFOU7wQgczL1GwZIjFmiukvWjPphm/x6LWblW
         LzyA==
X-Gm-Message-State: AN3rC/6lzcbMpbhoTX43Xkc3PbHLx42ykinF0Ztz7nSl24R3fpkX29Vfwk7rqS9PG1/e4w==
X-Received: by 10.98.149.196 with SMTP id c65mr29094152pfk.37.1492005501710;
        Wed, 12 Apr 2017 06:58:21 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z188sm36944010pgb.3.2017.04.12.06.58.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Apr 2017 06:58:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 12 Apr 2017 20:58:15 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     David.Taylor@dell.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] worktree add: add --lock option
Date:   Wed, 12 Apr 2017 20:58:05 +0700
Message-Id: <20170412135805.29837-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As explained in the document. This option has an advantage over the
command sequence "git worktree add && git worktree lock": there will be
no gap that somebody can accidentally "prune" the new worktree (or soon,
explicitly "worktree remove" it).

"worktree add" does keep a lock on while it's preparing the worktree.
If --lock is specified, this lock remains after the worktree is created.

Suggested-by: David Taylor <David.Taylor@dell.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 A patch that adds --lock may look like this.

 Documentation/git-worktree.txt |  7 ++++++-
 builtin/worktree.c             | 12 +++++++++++-
 t/t2025-worktree-add.sh        |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 553cf8413f..b472acc356 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -107,6 +107,11 @@ OPTIONS
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--lock::
+	Keep the working tree locked after creation. This is the
+	equivalent of `git worktree lock` after `git worktree add`,
+	but without race condition.
+
 -n::
 --dry-run::
 	With `prune`, do not remove anything; just report what it would
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9993ded41a..3dab07c829 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -24,6 +24,7 @@ struct add_opts {
 	int force;
 	int detach;
 	int checkout;
+	int keep_locked;
 	const char *new_branch;
 	int force_new_branch;
 };
@@ -305,7 +306,15 @@ static int add_worktree(const char *path, const char *refname,
 done:
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/locked", sb_repo.buf);
-	unlink_or_warn(sb.buf);
+	if (!ret && opts->keep_locked) {
+		/*
+		 * Don't keep the confusing "initializing" message
+		 * after it's already over.
+		 */
+		truncate(sb.buf, 0);
+	} else {
+		unlink_or_warn(sb.buf);
+	}
 	argv_array_clear(&child_env);
 	strbuf_release(&sb);
 	strbuf_release(&symref);
@@ -328,6 +337,7 @@ static int add(int ac, const char **av, const char *prefix)
 			   N_("create or reset a branch")),
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
+		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
 		OPT_END()
 	};
 
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b618d6be21..6dce920c03 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -63,6 +63,12 @@ test_expect_success '"add" worktree' '
 	)
 '
 
+test_expect_success '"add" worktree with lock' '
+	git rev-parse HEAD >expect &&
+	git worktree add --detach --lock here-with-lock master &&
+	test_must_be_empty .git/worktrees/here-with-lock/locked
+'
+
 test_expect_success '"add" worktree from a subdir' '
 	(
 		mkdir sub &&
-- 
2.11.0.157.gd943d85

