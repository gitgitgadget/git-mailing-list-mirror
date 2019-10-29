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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5991F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 08:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfJ2IeY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 04:34:24 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45444 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfJ2IeX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 04:34:23 -0400
Received: by mail-pg1-f169.google.com with SMTP id r1so8996929pgj.12
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 01:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xf3Jk4bUrzdPhTX/jELk1GZfJMeURAjh4tUjwbfX+4o=;
        b=vHGvGmzfNgoio1ma2C/WCbbe3SDfDmzyJdnL8Am2+9hwOLZJDA4ReQUMApj4UWDUot
         xKLBWqIMzttWrioTLx5D/i7LngTtAeP4vOL+NSagQqeuvcTKkzPtPnz7WgsipcqeVXz7
         eckjrWVJD4PwuivQvznEVDuMSfzs6KWm96A61o0ELRce4Y/f/97i+BwCkQMAdN7DPZnA
         3cijzF7eSOMbu+3fIdXYPj9yjDP+3AtbYRUoX/5hvPL3XNi4IVKobJjaqFqVCc8/Uf95
         vHQK1ciE0RJmf1Me5ZvJRvxMYiTR9/6BoATWWpHkfiwXHE+rAVsMIGpZV5AjFTyFSmnG
         ODAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xf3Jk4bUrzdPhTX/jELk1GZfJMeURAjh4tUjwbfX+4o=;
        b=tX4deBasJShGdiXWtOQIowJ9ldrMwtyyqNHFhH0zJ60HrQdWAtB9KNr3KvqeOW7Dcs
         dIuigF8cESvyYlVZQtXPRoTDhU2BskymSIu4IuJNauzaR01yS2iOXAgmDL4Iss98UpRl
         V/l2DfKD5rn84VtbwgQq7LJNcDtWvhSG/emWZ6OxLreJWYbFOP8A8XqfLlGwPW+UzliS
         ceNfcreHCX8hgjHhbsnCqDCm0XzEaR7xwVYxWQY4p/5WtO0Kyvol4rLShBr1bEUrT0lL
         Ao8SRqqJP0tfl0ORZ4rwAFuz1NnpmJQe+3M+IrAaRQKyn75jShIYc/NAFz0yceFMzNy3
         8Y9g==
X-Gm-Message-State: APjAAAXzYXRnpFvjC2z1J/B0RIlMHWRgzOdC7Qrz+UETAYfbYGmO+AZM
        /9T+ffJzi+Uo9undnQc+VYmSg5Du
X-Google-Smtp-Source: APXvYqx1eWh/2xkbpOkcC+/HzlIZAjJTKHhvpPcOVUEPYvU7/RRx4BcnndpOlIsvQxBvNBNEPC0c+Q==
X-Received: by 2002:a63:e454:: with SMTP id i20mr25858681pgk.319.1572338062096;
        Tue, 29 Oct 2019 01:34:22 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id i22sm13288549pfa.82.2019.10.29.01.34.21
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:34:21 -0700 (PDT)
Date:   Tue, 29 Oct 2019 01:34:19 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2] submodule: teach set-url subcommand
Message-ID: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
References: <3c7a496209d2d8d2162ef3ea7565eef0b0ca0576.1568750590.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7a496209d2d8d2162ef3ea7565eef0b0ca0576.1568750590.git.liu.denton@gmail.com>
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
Range-diff against v1:
1:  3c7a496209 ! 1:  d8841c6009 submodule: teach set-url subcommand
    @@ Documentation/git-submodule.txt: SYNOPSIS
      'git submodule' [--quiet] summary [<options>] [--] [<path>...]
      'git submodule' [--quiet] foreach [--recursive] <command>
      'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
    -@@ Documentation/git-submodule.txt: set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
    +@@ Documentation/git-submodule.txt: set-branch (-d|--default) [--] <path>::
      	`--default` option removes the submodule.<name>.branch configuration
      	key, which causes the tracking branch to default to 'master'.
      
    @@ t/t7420-submodule-set-url.sh (new)
     +
     +test_expect_success 'submodule config cache setup' '
     +	mkdir submodule &&
    -+	(cd submodule &&
    ++	(
    ++		cd submodule &&
     +		git init &&
     +		echo a >file &&
     +		git add file &&
     +		git commit -ma
     +	) &&
     +	mkdir super &&
    -+	(cd super &&
    ++	(
    ++		cd super &&
     +		git init &&
     +		git submodule add ../submodule &&
     +		git commit -m "add submodule"
    @@ t/t7420-submodule-set-url.sh (new)
     +
     +test_expect_success 'test submodule set-url' '
     +	# add a commit and move the submodule (change the url)
    -+	(cd submodule &&
    ++	(
    ++		cd submodule &&
     +		echo b >>file &&
     +		git add file &&
     +		git commit -mb
    @@ t/t7420-submodule-set-url.sh (new)
     +	mv submodule newsubmodule &&
     +
     +	git -C newsubmodule show >expect &&
    -+	(cd super &&
    ++	(
    ++		cd super &&
     +		test_must_fail git submodule update --remote &&
     +		git submodule set-url submodule ../newsubmodule &&
     +		grep "url = \.\./newsubmodule" .gitmodules &&
    -+		git submodule update --remote &&
    -+		git -C submodule show >../actual
    ++		git submodule update --remote
     +	) &&
    ++	git -C super/submodule show >actual &&
     +	test_cmp expect actual
     +'
     +

 Documentation/git-submodule.txt        |  6 +++
 contrib/completion/git-completion.bash |  2 +-
 git-submodule.sh                       | 52 +++++++++++++++++++++++-
 t/t7420-submodule-set-url.sh           | 55 ++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 2 deletions(-)
 create mode 100755 t/t7420-submodule-set-url.sh

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 1f46380af2..f1c4689f24 100644
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
index 0000000000..9bc941ced3
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
+		grep "url = \.\./newsubmodule" .gitmodules &&
+		git submodule update --remote
+	) &&
+	git -C super/submodule show >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.24.0.rc0.197.g0926ab8072

