Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA2F1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390604AbfJ2RB6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 13:01:58 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:45763 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfJ2RB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 13:01:57 -0400
Received: by mail-pf1-f181.google.com with SMTP id c7so8824610pfo.12
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jXQXKYNwbXDB/gIZCbOxQb/Xw7XhPZksb5EgV7yrCQE=;
        b=Lx6lAvakTSzhjb5FEUCSOlZcWzriqWwWLsiUWbjdqr7Nz6YvPbxjajLLWAeJeQr7IT
         18+VQrXu56uTOs8qTXPk+Fm+0u/sjDuzoxEOYXUsIIaTfcfPYSVWGiizzXKNyWmyVtFZ
         dNw8ccHKi2X3e9pyR6PS76VQ06R5hXjkezWL8YTU2tRCXVUITpcKxEIm1Xy8Z3okMbo0
         zVE1mYuYVi9Kj4RYZXbmtN9o+0lS9TqxRg5EG8B8MTjnYVnbD9NN7Da3Fum5mK+YnXq1
         HS7csXDW1/cqtFjjldZdCL5sliKKcRXqlNpB0auQuizdia1sV9nSSnhhImmwHzfR1nmY
         oVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jXQXKYNwbXDB/gIZCbOxQb/Xw7XhPZksb5EgV7yrCQE=;
        b=eY+DDOGBnx3mg7nMFuMvZ/D20XxKYvwOpzs87A31cZvfKmMDRJCMM+nIHKVzrzIxhi
         GsAV9+ApgbRAKka/v81VmEf1u9w7w9F/bZzLVD2chbd31710rj4AhLjoCcgmNvYLRX2i
         YUuBOT6kTx2rZii3IvJvQ+jATNxWrAuhoW5UFM9fL0NFGPaCOy9w59DHXTxu+QEEWbjg
         vCkwA0kNsRhnuXBaoYS05d6dC4/a4JkeB6qhxEI8wwuOhe292gik/jpwaYUADdzPeBv3
         2BUDmfoCMI3VvO1u6g7UtT23zXkje4HTthkpQCoNocUzG4b86gdsp+L/Q2jV3uWAi2J1
         UKcg==
X-Gm-Message-State: APjAAAXSi2wqLoq1YGL/GdO/5fNhCiEPWGqrtVOsSQDQ6vgtRoDgay/E
        BNrMvq/KHY4qj71kODHzrtRGnS2T
X-Google-Smtp-Source: APXvYqxW/LAmtw1KWQSmRouNT43ALu/Nc+wDj2jeC2FiJA2W8lQYmiAYt6KzndAbJZb67PoulG9qBA==
X-Received: by 2002:a63:31d0:: with SMTP id x199mr28377027pgx.228.1572368516179;
        Tue, 29 Oct 2019 10:01:56 -0700 (PDT)
Received: from generichostname ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id y80sm15118555pfc.30.2019.10.29.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:01:54 -0700 (PDT)
Date:   Tue, 29 Oct 2019 10:01:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Danh Doan <congdanhqx@gmail.com>
Subject: [PATCH v3] submodule: teach set-url subcommand
Message-ID: <f5f44812af2b43fe3f7ea837f8b07c4747eedcc0.1572368447.git.liu.denton@gmail.com>
References: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, in the event that a submodule's upstream URL changes, users
have to manually alter the URL in the .gitmodules file then run
`git submodule sync`. Let's make that process easier.

Teach submodule the set-url subcommand which will automatically change
the `submodule.$name.url` property in the .gitmodules file and then run
`git submodule sync` to complete the process.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks for the review, Danh. I've taken all of your suggestions.

Range-diff against v2:
1:  d8841c6009 ! 1:  f5f44812af submodule: teach set-url subcommand
    @@ Documentation/git-submodule.txt: SYNOPSIS
      'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
      'git submodule' [--quiet] update [<options>] [--] [<path>...]
      'git submodule' [--quiet] set-branch [<options>] [--] <path>
    -+'git submodule' [--quiet] set-url [<options>] [--] <path> <newurl>
    ++'git submodule' [--quiet] set-url [--] <path> <newurl>
      'git submodule' [--quiet] summary [<options>] [--] [<path>...]
      'git submodule' [--quiet] foreach [--recursive] <command>
      'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
    @@ t/t7420-submodule-set-url.sh (new)
     +		cd super &&
     +		test_must_fail git submodule update --remote &&
     +		git submodule set-url submodule ../newsubmodule &&
    -+		grep "url = \.\./newsubmodule" .gitmodules &&
    ++		grep -F "url = ../newsubmodule" .gitmodules &&
     +		git submodule update --remote
     +	) &&
     +	git -C super/submodule show >actual &&

 Documentation/git-submodule.txt        |  6 +++
 contrib/completion/git-completion.bash |  2 +-
 git-submodule.sh                       | 52 +++++++++++++++++++++++-
 t/t7420-submodule-set-url.sh           | 55 ++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100755 t/t7420-submodule-set-url.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1f46380af2..285486d0a8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [<options>] [--] [<path>...]
 'git submodule' [--quiet] set-branch [<options>] [--] <path>
+'git submodule' [--quiet] set-url [--] <path> <newurl>
 'git submodule' [--quiet] summary [<options>] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
@@ -180,6 +181,11 @@ set-branch (-d|--default) [--] <path>::
 	`--default` option removes the submodule.<name>.branch configuration
 	key, which causes the tracking branch to default to 'master'.
 
+set-url [--] <path> <newurl>::
+	Sets the URL of the specified submodule to <newurl>. Then, it will
+	automatically synchronize the submodule's new remote URL
+	configuration.
+
 summary [--cached|--files] [(-n|--summary-limit) <n>] [commit] [--] [<path>...]::
 	Show commit summary between the given commit (defaults to HEAD) and
 	working tree/index. For a submodule in question, a series of commits
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 00fbe6c03d..88c7446414 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2779,7 +2779,7 @@ _git_submodule ()
 {
 	__git_has_doubledash && return
 
-	local subcommands="add status init deinit update set-branch summary foreach sync absorbgitdirs"
+	local subcommands="add status init deinit update set-branch set-url summary foreach sync absorbgitdirs"
 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
 	if [ -z "$subcommand" ]; then
 		case "$cur" in
diff --git a/git-submodule.sh b/git-submodule.sh
index c7f58c5756..f7374ddbd6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -12,6 +12,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
    or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
+   or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]
@@ -760,6 +761,55 @@ cmd_set_branch() {
 	fi
 }
 
+#
+# Configures a submodule's remote url
+#
+# $@ = requested path, requested url
+#
+cmd_set_url() {
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	if test $# -ne 2
+	then
+		usage
+	fi
+
+	# we can't use `git submodule--helper name` here because internally, it
+	# hashes the path so a trailing slash could lead to an unintentional no match
+	name="$(git submodule--helper list "$1" | cut -f2)"
+	if test -z "$name"
+	then
+		exit 1
+	fi
+
+	url="$2"
+	if test -z "$url"
+	then
+		exit 1
+	fi
+
+	git submodule--helper config submodule."$name".url "$url"
+	git submodule--helper sync ${GIT_QUIET:+--quiet} "$name"
+}
+
 #
 # Show commit summary for submodules in index or working tree
 #
@@ -1059,7 +1109,7 @@ cmd_absorbgitdirs()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | set-branch | status | summary | sync | absorbgitdirs)
+	add | foreach | init | deinit | update | set-branch | set-url | status | summary | sync | absorbgitdirs)
 		command=$1
 		;;
 	-q|--quiet)
diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
new file mode 100755
index 0000000000..ef0cb6e8e1
--- /dev/null
+++ b/t/t7420-submodule-set-url.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Denton Liu
+#
+
+test_description='Test submodules set-url subcommand
+
+This test verifies that the set-url subcommand of git-submodule is working
+as expected.
+'
+
+TEST_NO_CREATE_REPO=1
+. ./test-lib.sh
+
+test_expect_success 'submodule config cache setup' '
+	mkdir submodule &&
+	(
+		cd submodule &&
+		git init &&
+		echo a >file &&
+		git add file &&
+		git commit -ma
+	) &&
+	mkdir super &&
+	(
+		cd super &&
+		git init &&
+		git submodule add ../submodule &&
+		git commit -m "add submodule"
+	)
+'
+
+test_expect_success 'test submodule set-url' '
+	# add a commit and move the submodule (change the url)
+	(
+		cd submodule &&
+		echo b >>file &&
+		git add file &&
+		git commit -mb
+	) &&
+	mv submodule newsubmodule &&
+
+	git -C newsubmodule show >expect &&
+	(
+		cd super &&
+		test_must_fail git submodule update --remote &&
+		git submodule set-url submodule ../newsubmodule &&
+		grep -F "url = ../newsubmodule" .gitmodules &&
+		git submodule update --remote
+	) &&
+	git -C super/submodule show >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.24.0.rc0.197.g0926ab8072

