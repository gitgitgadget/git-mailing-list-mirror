Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3286B20A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbdKZTmj (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:42:39 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42091 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbdKZTmh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:42:37 -0500
Received: by mail-wr0-f194.google.com with SMTP id o14so24491828wrf.9
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 11:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6bfMv+8iq+jd5gNs803TNAZRfUg+jDEKP+Ch2SD12k=;
        b=kJPT59ahXhPmtamx6n/HpDUBxA+QOrt8xlrJE+UREKGoXaGqRCnMeGkA8m0XyxGJo2
         S4LL5y95kcg+ZaIMrvQJuQuKN7tw839zsgIHxf6Jy6tyKAIGGNIuSx3ZqiYgDdkDpbll
         aUcQxIYP/REbJ/eLAd1g+XIQgBNSgXfcMmjZTgwzvo1hoEhganAU8PPbsQSBO5rZVE2t
         SnsCXJKQ75ydAmhqlWJsuhg6ISpBoKWgrHFs2h3x4yWxyOKg96aLG9k5Gr9TbRNpkREk
         jIMFvOJGT+7mZ2lJdYJJkMDb/H1FBI5jJDorUIobzIwqDZXuvox4MbslUOxmkClDdT4G
         sIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6bfMv+8iq+jd5gNs803TNAZRfUg+jDEKP+Ch2SD12k=;
        b=TXsyvxrglbUUL8I1hy0dkNzfSQm9puqMzqjxijY2yD7ffzyVK4JlnkBTNCjPOANTnn
         fVsi7LvDWruYMXlFPw3CObxnu/CbsXTRbOnjfsCgwk786qAbNkGImuKnk4i2mPNrFcEY
         zyLpqQhbD1L7fuCkrsBvfQUB0H+2gBqATzbrD/pztDW4ZKo0uRMZvTrDCiq0hYbXG+KC
         F+uet2fqve/PG3tBu9B/tyLi7Up8XYsAVUQSbJVY/Rowf4S+DUCGjmcxkIth9FVicIzL
         ls/FluQ6x0HDZJHS2CssdnqSy3I+UqNB4ocnBFNbwayWzmK6HdgcGhr0lS4c7G4OWe7R
         n2ZQ==
X-Gm-Message-State: AJaThX7fxH7StrCI467oeIVDXvk4isScYKhrs/LbE4wd+vrrybsqDN2O
        KGjR96ZaMyA8tuGtdrJw5RDBjXFq
X-Google-Smtp-Source: AGs4zMa9AM2u6UGCgNSQZ1r+r93rTec/pIBS1a9kCCg5QFtym6LLusgmX3wQVTZUqK6HxUkQO21VTg==
X-Received: by 10.223.132.129 with SMTP id 1mr28357531wrg.136.1511725356036;
        Sun, 26 Nov 2017 11:42:36 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o48sm10326864wrf.85.2017.11.26.11.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 11:42:35 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 4/6] worktree: make add <path> <branch> dwim
Date:   Sun, 26 Nov 2017 19:43:54 +0000
Message-Id: <20171126194356.16187-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171126194356.16187-1-t.gummerer@gmail.com>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171126194356.16187-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path> <branch>', errors out when 'branch'
is not a local branch.  It has no additional dwim'ing features that one
might expect.

Make it behave more like 'git checkout <branch>' when the branch doesn't
exist locally, but a remote tracking branch uniquely matches the desired
branch name, i.e. create a new branch from the remote tracking branch
and set the upstream to the remote tracking branch.

As 'git worktree add' currently just dies in this situation, there are
no backwards compatibility worries when introducing this feature.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt |  8 ++++++++
 builtin/worktree.c             | 16 ++++++++++++++++
 t/t2025-worktree-add.sh        | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 15e58b18f7..3044d305a6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -52,6 +52,14 @@ is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
 specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
+If <commit-ish> is a branch name (call it `<branch>` and is not found,
+and neither `-b` nor `-B` nor `--detach` are used, but there does
+exist a tracking branch in exactly one remote (call it `<remote>`)
+with a matching name, treat as equivalent to
+------------
+$ git worktree add --track -b <branch> <path> <remote>/<branch>
+------------
++
 If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, a new branch based at HEAD is created automatically,
 as if `-b $(basename <path>)` was specified.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index ea9678cac8..7021d02585 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "checkout.h"
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
@@ -390,6 +391,21 @@ static int add(int ac, const char **av, const char *prefix)
 		opts.new_branch = xstrndup(s, n);
 	}
 
+	if (ac == 2 && !opts.new_branch && !opts.detach) {
+		struct object_id oid;
+		struct commit *commit;
+		const char *remote;
+
+		commit = lookup_commit_reference_by_name(branch);
+		if (!commit) {
+			remote = unique_tracking_name(branch, &oid);
+			if (remote) {
+				opts.new_branch = branch;
+				branch = remote;
+			}
+		}
+	}
+
 	if (opts.new_branch) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 72e8b62927..96ebc63d04 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -365,4 +365,23 @@ test_expect_success '--no-track avoids setting up tracking' '
 	)
 '
 
+test_expect_success '"add" <path> <non-existent-branch> fails' '
+	test_must_fail git worktree add foo non-existent
+'
+
+test_expect_success '"add" <path> <branch> dwims' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
+	git init repo_dwim &&
+	(
+		cd repo_dwim &&
+		git worktree add ../foo foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_upstream foo &&
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
+	)
+'
+
 test_done
-- 
2.15.0.426.gb06021eeb

