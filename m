Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02DB21F404
	for <e@80x24.org>; Thu, 16 Aug 2018 08:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389776AbeHPLDA (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 07:03:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeHPLDA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 07:03:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id a108-v6so636953wrc.13
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mDCbWjENsLvCGtmNmZ1NLZTiAea+NACV3MnBUhtHo8k=;
        b=ogQWKvHiWlDQHDHNJ+44ZCBX5VE45MTid4V3YAym1aaaayVq+DKuwsOwKvzZGviNL2
         C2jGMVGQzdglzHn2yasSfPRS6HFHEDTCLZAo3v1T+aoBOHrP1t72ka0Ac7o5KlnoTtat
         4dfOKNhSYqJTECyXN65U4MOXNpMuwpjjU550HG9mvcTNIt78ZOZ8G0GxTd21YmnyCmqv
         7zKMeo4Ab7EhHAoToV+I+Fy6Uc727rLZXK93cKQEuFjvSzqC6VWhOGZVJ4TrFb4AH8CM
         kK5hp78jMr7ve++XOdbR0EttmQnZlGTizXM2O7bITfYjiad3qHP8KIJUSVKFSFrQaWLR
         KRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mDCbWjENsLvCGtmNmZ1NLZTiAea+NACV3MnBUhtHo8k=;
        b=UkUi67FMwKiJjav6vTW5dc6gyoZoOOgsIAc7W9+I8ird1PAAuOYMGwkhfx1+6KvD1M
         QUaozH2hEk1DPeRbRXjQcS0LWyok3pC4+IiaWWWIpfzAQbRMrOzMJxrlJshiJUHCiQJi
         hhKpxTVQQW4F6QpAgX0qRNla2KCrPUOjYmgXxK2FMigbuv+GK9SMkVGfM0B81ZHL8KcV
         okrpOQwuC+lV0cthcZcbNVW/bMRmT6JCAaaBJ//Nkliu2JQA1FF5dD/LRZKihZ+BIZ4y
         ctnA2yZeWBNlGAis/MbUefoqVPxyYFVnaG0GkqOjRQdTkLdl+kaoEe+KK1GKZ9Qvdc7y
         HKiw==
X-Gm-Message-State: AOUpUlGXJFU2DQggSby1Io7i26OrKSp8+NhcZfZWJeukMuD6Z48WN4cu
        xmxzbJTOLA8kW0zNGHGhxbEZ0Dwy
X-Google-Smtp-Source: AA+uWPxiQzvY0OhBRxx0QxHEgQgxuulTR/kdvAVPUDNz50uFgQqi5amfQPyEC9CaoNDjvK9C12M/kQ==
X-Received: by 2002:adf:9443:: with SMTP id 61-v6mr19207728wrq.193.1534406774098;
        Thu, 16 Aug 2018 01:06:14 -0700 (PDT)
Received: from localhost.localdomain (mey38-3-88-164-118-40.fbx.proxad.net. [88.164.118.40])
        by smtp.gmail.com with ESMTPSA id u65-v6sm882737wmd.31.2018.08.16.01.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 01:06:13 -0700 (PDT)
From:   samuel.maftoul@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        Samuel Maftoul <samuel.maftoul@gmail.com>
Subject: [PATCH] branch: support configuring --sort via .gitconfig
Date:   Thu, 16 Aug 2018 10:05:49 +0200
Message-Id: <20180816080549.33544-1-samuel.maftoul@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAPig+cSUy7rFwhmJ1SFHsAjPkoWparfY6wAjV=6kJyUL3SLQUw@mail.gmail.com>
References: <CAPig+cSUy7rFwhmJ1SFHsAjPkoWparfY6wAjV=6kJyUL3SLQUw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Samuel Maftoul <samuel.maftoul@gmail.com>

Add support for configuring default sort ordering for git branches. Command
line option will override this configured value, using the exact same
syntax.

Signed-off-by: Samuel Maftoul <samuel.maftoul@gmail.com>
---
 Documentation/config.txt     |  6 +++++
 Documentation/git-branch.txt |  3 +++
 builtin/branch.c             | 10 +++++++-
 t/t3200-branch.sh            | 47 ++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 63365dcf3..1236d1ec9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1034,6 +1034,12 @@ branch.autoSetupRebase::
 	branch to track another branch.
 	This option defaults to never.
 
+branch.sort::
+	This variable controls the sort ordering of branches when displayed by
+	linkgit:git-branch[1]. Without the "--sort=<value>" option provided, the
+	value of this variable will be used as the default.
+	See linkgit:git-for-each-ref[1] field names for valid values.
+
 branch.<name>.remote::
 	When on branch <name>, it tells 'git fetch' and 'git push'
 	which remote to fetch from/push to.  The remote to push to
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1072ca0eb..1be009a35 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -272,6 +272,9 @@ start-point is either a local or remote-tracking branch.
 	full refname (including `refs/...` prefix). This lists
 	detached HEAD (if present) first, then local branches and
 	finally remote-tracking branches.
+	Sort order defaults to the value configured for the `branch.sort`
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
index dbca665da..448c93527 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1305,4 +1305,51 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
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
+		git config branch.sort committerdate &&
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
+	(
+		cd sort &&
+		git config branch.sort "v:notvalid" &&
+		test_must_fail git branch
+
+	)
+'
+
 test_done
-- 
2.18.0

