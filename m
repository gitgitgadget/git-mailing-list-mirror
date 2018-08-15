Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F07E1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeHOOHx (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 10:07:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55345 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbeHOOHx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 10:07:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so1053575wmc.5
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 04:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+AAcphFtBM39M6qR2zqtyoB5sozCLIM1R2mxaLXGFKM=;
        b=cujRMB6RdPpNWWFX5MC/FOPpHE/GVtkx0Cn7nO4xNLQFgGgYGx9D0xdrdyG+r9HGR5
         F6t6l5TV9kHtXHAbvtj5znja0fArE0UD/aZbNtRk2n1Sju/6DtjfBRNVGhwWrDY4+G/M
         hzR5VV8XUFgxBO9fag1zand247BI8D1e27tUMaJmf0WtY4yZoneqRLmtVYCBM/x7EEjb
         VX/K46uDzMM8jNLPoAyssd0/92ZYqW1ErDXDyKC5CwtzC9uiMzWN++P4nqe2D/R/b0Cg
         2m3kqh9biwjLGDTs0bHjmVIUBrcYnpriLq8M4iVhGTknlA1rJHh/aEjp10sqeKQ4o7ja
         YSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+AAcphFtBM39M6qR2zqtyoB5sozCLIM1R2mxaLXGFKM=;
        b=t1zHaOwEVE/SnrHDqvUWR0Oq85o6G0d6hGA1NId70QYGrkTpvN5JtfGDNCugDLm1x/
         Rit9XFMcYpuvO1SEPCr+MP1xjnTz1dULQQJMCSjz4LXr4fBSrMMKH7Nlr7mIHEnIgcYo
         ANz8ISX4qXyDM4E0V1uP4G7rOydss7SnMxpibIBp2zAvZBCaudKnocmDy96JRE0fqpJr
         UWxvucCdfE9ixsc2SDqSp0aaCKc4tbl66BnHGnt2p/wg/OiTn0Hd2IbhuRZiIAbPtR4j
         Vxk9GF7WlkJFsepENtTEgzShwCvD0fBXBta7EOgqmvxHlZwo0sSc0UwZEVHRbBqPCgT6
         LoKQ==
X-Gm-Message-State: AOUpUlF9cybUJUt9s7uKlOCHiGmDUctuAc/C6EJCmQZaTuD0pF0HJkzu
        BtXyUDixG00luCKhJm5+y0tUOfWY
X-Google-Smtp-Source: AA+uWPxMfCI0lwZQklJhBgM7f0/nNXlNXi8tgCjpwx9ntiAukr3keXLNnOOm5S5WzFWc4ApCSrxRYA==
X-Received: by 2002:a1c:8a04:: with SMTP id m4-v6mr12839676wmd.137.1534331765969;
        Wed, 15 Aug 2018 04:16:05 -0700 (PDT)
Received: from localhost.localdomain (mey38-3-88-164-118-40.fbx.proxad.net. [88.164.118.40])
        by smtp.gmail.com with ESMTPSA id i125-v6sm2630468wmd.23.2018.08.15.04.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 04:16:04 -0700 (PDT)
From:   samuel.maftoul@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com,
        Samuel Maftoul <samuel.maftoul@gmail.com>
Subject: [PATCH] branch: support configuring --sort via .gitconfig
Date:   Wed, 15 Aug 2018 13:15:44 +0200
Message-Id: <20180815111544.30711-1-samuel.maftoul@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Samuel Maftoul <samuel.maftoul@gmail.com>

Add support for configuring default sort ordering for git branches. Command
line option will override this configured value, using the exact same
syntax.
---
 Documentation/config.txt     |  5 +++++
 Documentation/git-branch.txt |  4 ++++
 builtin/branch.c             | 10 +++++++++-
 t/t3200-branch.sh            | 46 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 63365dcf3..82e306d20 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1034,6 +1034,11 @@ branch.autoSetupRebase::
 	branch to track another branch.
 	This option defaults to never.
 
+branch.sort::
+	This variable controls the sort ordering of branches when displayed by
+	linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
+	value of this variable will be used as the default.
+
 branch.<name>.remote::
 	When on branch <name>, it tells 'git fetch' and 'git push'
 	which remote to fetch from/push to.  The remote to push to
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1072ca0eb..9212a8d5d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -272,6 +272,10 @@ start-point is either a local or remote-tracking branch.
 	full refname (including `refs/...` prefix). This lists
 	detached HEAD (if present) first, then local branches and
 	finally remote-tracking branches.
+	The keys supported are the same as those in `git for-each-ref`.
+	Sort order defaults to the value configured for the `tag.sort`
+	variable if it exists, or lexicographic order otherwise. See
+	linkgit:git-config[1].
 
 
 --points-at <object>::
diff --git a/builtin/branch.c b/builtin/branch.c
index 4fc55c350..bbd006aab 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -74,6 +74,14 @@ define_list_config_array(color_branch_slots);
 static int git_branch_config(const char *var, const char *value, void *cb)
 {
 	const char *slot_name;
+	struct ref_sorting **sorting_tail = (struct ref_sorting **)cb;
+
+	if (!strcmp(var, "branch.sort")) {
+		if (!value)
+			return config_error_nonbool(var);
+		parse_ref_sorting(sorting_tail, value);
+		return 0;
+	}
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "branch", &colopts);
@@ -653,7 +661,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_branch_usage, options);
 
-	git_config(git_branch_config, NULL);
+	git_config(git_branch_config, sorting_tail);
 
 	track = git_branch_track;
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dbca665da..8bd42e9c6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1305,4 +1305,50 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
 	)
 '
 
+test_expect_success 'configured committerdate sort' '
+	git init sort &&
+	(
+		cd sort &&
+		git config branch.sort committerdate &&
+		test_commit initial &&
+		git checkout -b a &&
+		test_commit a &&
+		git checkout -b c &&
+		test_commit c &&
+		git checkout -b b &&
+		test_commit b &&
+		git branch >actual &&
+		cat >expect <<-\EOF &&
+		  master
+		  a
+		  c
+		* b
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'option override configured sort' '
+	(
+		cd sort &&
+		git branch --sort=refname >actual &&
+		cat >expect <<-\EOF &&
+		  a
+		* b
+		  c
+		  master
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'invalid sort parameter in configuration' '
+       (
+		cd sort &&
+		git config branch.sort "v:notvalid" &&
+		test_must_fail git branch
+
+	)
+'
+
 test_done
-- 
2.14.3 (Apple Git-98)

