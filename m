Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B5F41F404
	for <e@80x24.org>; Thu, 16 Aug 2018 09:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbeHPMc7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 08:32:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36707 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387553AbeHPMc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 08:32:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id w24-v6so3702953wmc.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 02:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6A10SoqjDws/xFlprSk6LdweAja3V1POLbBn0KOIM8=;
        b=IdPh2QU6z9jyOc6kvgC99tOm+6VBYofQjH0nR741AZ8/meiMK3t6bN3vMNQeq/rEci
         jlCR/r/WS8gB09kZhvc0FXdmotHVS00ORZc+uE11mmiR0sLn6Bo9gMgJDWOCcGjztE3g
         +Jii8n6FJkWAMCrvpq/m9dGVAzUTwbjqyTuPtC+H0N4zX2FVX298bXeeSZ6I4NqX4PpW
         yNsJ7TtvaZkYGGhAAYbaZ1sRxSiNySVQuQ0AeWZq2nobQ8LDkN1Mh4a7f7SCkJgLDXFI
         FtOS8NHUC1dPZrSGtXg5C0hkK4sUbvyREzPDdjrH7sncHrnu+V+EWOBfNcX1nps8ehNS
         pLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6A10SoqjDws/xFlprSk6LdweAja3V1POLbBn0KOIM8=;
        b=k9HqPRwV4Up5Wqs7x0qJ3xBvRJsiaHm6xISrTDhmVa9SM+4Bfj9C96hNazh8orzBRd
         liw5CrFev+TGS8NGVd6OGigCY77VWIVoXXx7UyXvWEX482IFn0eXWKNyL5YBBssoKaQV
         QQaXbnIxlHIiwNTyAlMKIcMQVQUQIGmssklanUqk3Ut7MEGK6rN1Ez1gdtFWGSP6JJ+z
         FlaEpofSx+IJb27cjzYG2knw3R2iAdmpD3oh8dCuL9cybLmq19yhCTwKvdb6o0O71fk3
         eJsWpv6OXp7JrP9nyIP8TvVbNgKQLv+411CnR+Ym0mxEgQUbcTkpc/JOiLT2FaysKCIc
         T9oA==
X-Gm-Message-State: AOUpUlGgj0fVFsvLicN5E/GI7cvVdMSgcinn/5G5UOd57R+ouY9QhLKJ
        c5s0zYER9Zp2xh7iWPcDIebVPm2h
X-Google-Smtp-Source: AA+uWPxcJa7CDc11+AOwC0sJ9FXvdYmLLUz5bwjI/LbCN1WXCU6u0hAkQB4kBcT8qbQ5dRp7Pp0hqA==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr14784496wme.109.1534412139265;
        Thu, 16 Aug 2018 02:35:39 -0700 (PDT)
Received: from localhost.localdomain (mey38-3-88-164-118-40.fbx.proxad.net. [88.164.118.40])
        by smtp.gmail.com with ESMTPSA id w204-v6sm740413wmw.5.2018.08.16.02.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 02:35:38 -0700 (PDT)
From:   samuel.maftoul@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sunshine@sunshineco.com,
        Samuel Maftoul <samuel.maftoul@gmail.com>
Subject: [PATCH] branch: support configuring --sort via .gitconfig
Date:   Thu, 16 Aug 2018 11:35:08 +0200
Message-Id: <20180816093508.37193-1-samuel.maftoul@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAPig+cR5cu3cxtpdHsbSSK7xWRpMQh_sv5nvunZrojAOkFeedg@mail.gmail.com>
References: <CAPig+cR5cu3cxtpdHsbSSK7xWRpMQh_sv5nvunZrojAOkFeedg@mail.gmail.com>
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
 Documentation/git-branch.txt |  5 ++--
 builtin/branch.c             | 10 +++++++-
 t/t3200-branch.sh            | 46 ++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fd8d27e76..7f7a50123 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1039,6 +1039,12 @@ branch.autoSetupRebase::
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
index 1072ca0eb..9767b2b48 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -268,10 +268,11 @@ start-point is either a local or remote-tracking branch.
 	order of the value. You may use the --sort=<key> option
 	multiple times, in which case the last key becomes the primary
 	key. The keys supported are the same as those in `git
-	for-each-ref`. Sort order defaults to sorting based on the
+	for-each-ref`. Sort order defaults to the value configured for the
+	`branch.sort` variable if exists, or to sorting based on the
 	full refname (including `refs/...` prefix). This lists
 	detached HEAD (if present) first, then local branches and
-	finally remote-tracking branches.
+	finally remote-tracking branches. See linkgit:git-config[1].
 
 
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
index dbca665da..93f21ab07 100755
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
+	)
+'
+
 test_done
-- 
2.18.0

