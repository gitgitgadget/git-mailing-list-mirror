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
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B181F463
	for <e@80x24.org>; Tue, 17 Sep 2019 20:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfIQUDn (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 16:03:43 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46335 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfIQUDn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 16:03:43 -0400
Received: by mail-pl1-f180.google.com with SMTP id q24so1962183plr.13
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GVbKz8OyZTzJEP9tX8o0JlZ5aWcFlAkMmj4oPciWyJE=;
        b=BP7y3+sI7INbXSkJZl0LFHccAvfYIIS/Asn5Y/QUdyS6tOirRupz2fQZwFLg9bE9Pt
         mw47SXjLoN4yYIdeI+ywiLpe+yQKouur+L3r8Z2tOVMBM75be54lQuy7p4mt0CcxKFJM
         4iHAsTGjk3PkZ2SORXQy9vaOitRsC+bc6hBNiS8GBjO+VJC5eo1Yap8yCjReQM/VxXC7
         kmJmwHk8uPNDqUUGaQKPChbQINA3s32YGJLibc4G28ROVUrFplEb2wWfgJzjtemxXkY9
         DwtRYyGeV+JqFeljeYsn3YBfnK4AinkGpNPKuKobmszXHmDCRF+DGkE77t/NFerrg3VR
         FmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GVbKz8OyZTzJEP9tX8o0JlZ5aWcFlAkMmj4oPciWyJE=;
        b=q2ULj97uYOkqRz9RqjCNqLaTIesjTvIcqMiLcyt+vIVC+lJozj+oAmrU4GHptMDJa0
         fjMXvYEpDFbyD7sigxUIe2BfeqRrPl4XoUR8h028srX8qDyAy3Af7M1b+92apz0WaWn/
         Oj3A9KZdjyuWArcTemO4AeCnFUrhw0jvWesnnX36Mh+MmDtdDKKhF7et0ptXAhNQk5aI
         0g9NgvBA+aEAS/UTYRR+RglOWNJYrw8PUfy9loa57lAru1teBqYVyVtdB5mYP9xDnZNm
         3161j40mFLOKNV8aYB42mHCnsi8k2q3cFUjyecGiHLe0Ov0NNHbP4ApVEmb2kKm9g2RY
         R3Jg==
X-Gm-Message-State: APjAAAVg0sjFzyvEoNsxxEUKoPvrJwcNq6b7NUHhnwUlvqY/s2Rg+zD3
        leIzDuwxLXcj/Sm8Zs5jAkzMAMLDWjw=
X-Google-Smtp-Source: APXvYqwlf3QCdl2xVeZU0MSeX1w6F0yTfuP1N8qLdMxpBKkPG8gBjJG7LsPDoRXp7e8LfoK/DB/9xg==
X-Received: by 2002:a17:902:a581:: with SMTP id az1mr389878plb.311.1568750621914;
        Tue, 17 Sep 2019 13:03:41 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id v18sm2860039pgl.87.2019.09.17.13.03.39
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 13:03:40 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:03:38 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH] submodule: teach set-url subcommand
Message-ID: <3c7a496209d2d8d2162ef3ea7565eef0b0ca0576.1568750590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
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
 Documentation/git-submodule.txt        |  6 +++
 contrib/completion/git-completion.bash |  2 +-
 git-submodule.sh                       | 52 +++++++++++++++++++++++++-
 t/t7420-submodule-set-url.sh           | 51 +++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100755 t/t7420-submodule-set-url.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..8eac3c350c 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
 'git submodule' [--quiet] update [<options>] [--] [<path>...]
 'git submodule' [--quiet] set-branch [<options>] [--] <path>
+'git submodule' [--quiet] set-url [<options>] [--] <path> <newurl>
 'git submodule' [--quiet] summary [<options>] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
@@ -179,6 +180,11 @@ set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
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
index e087c4bf00..bec31a7fc3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2666,7 +2666,7 @@ _git_submodule ()
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
index 0000000000..60adc5db28
--- /dev/null
+++ b/t/t7420-submodule-set-url.sh
@@ -0,0 +1,51 @@
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
+	(cd submodule &&
+		git init &&
+		echo a >file &&
+		git add file &&
+		git commit -ma
+	) &&
+	mkdir super &&
+	(cd super &&
+		git init &&
+		git submodule add ../submodule &&
+		git commit -m "add submodule"
+	)
+'
+
+test_expect_success 'test submodule set-url' '
+	# add a commit and move the submodule (change the url)
+	(cd submodule &&
+		echo b >>file &&
+		git add file &&
+		git commit -mb
+	) &&
+	mv submodule newsubmodule &&
+
+	git -C newsubmodule show >expect &&
+	(cd super &&
+		test_must_fail git submodule update --remote &&
+		git submodule set-url submodule ../newsubmodule &&
+		grep "url = \.\./newsubmodule" .gitmodules &&
+		git submodule update --remote &&
+		git -C submodule show >../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.23.0

