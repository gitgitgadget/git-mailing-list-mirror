Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5EAF201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbdBYU3a (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:29:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35975 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdBYU2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:28:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so7833389wmd.3
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 12:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NxKW+j122xzP3ogVkYWrc/HTe2PFZnBReqwtMrjATww=;
        b=k+T2W4U0rIPIQmCnlQauPjFkiNDka+vRbPvednRLmlLljzRquQPm+JnbmUHgqjU/cO
         i/X0ePZhesYLWxN7Iirh0q6y5ovksIM7ST+WZCHd0HnTGnOsH3k2qXsaBDFdoJsxZAPX
         cc+lDRUETlEhYHryFEJsb/2vc+vefcgcqw6SVyScUL4czDbqjKdrgeQN/IUPcy7nF5Cv
         1KOtq8Ip9LsNLZht7hewRiE3mLrB5/abbKSDctRZUIzvSHRTMpKlCbwHxh9eq7FamFbG
         392ptlrjvr4v08AnDr+K/Jo8FHAdA2vFZP5+RYy18BBqJxaslGHUiba1NIVruJ+eWwpW
         BkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NxKW+j122xzP3ogVkYWrc/HTe2PFZnBReqwtMrjATww=;
        b=fuqwI7y/epB8Gumd2h41ZICXkvoKl3tvzrXwNcJgYK42cyEPrmbk9UFcHSqEnffixC
         V75y7qypc7zvOvtu8VVaaVEw1UgOhYQaH8wgp51iYuEGJtnY1dxKCte4SC+fPS1OAZme
         44UvBphNBEKqZtr1yMutYGXDSH7Zsam6j6NDch7wzhW3hL4wLDDM66pA92yyuToS9X0M
         uCNkfgViM/DH4lfxcm52cdlcsU7HOYDxi5XnD4mne/2sHmwOmn/KczvN9GlB3rY02sTl
         aVr85zwOt1RqfclW9mkhxLduMWPbFXVlz85joyzjoty8ZxIchlzK3kFHD3oSN+I+lvJR
         UQ3w==
X-Gm-Message-State: AMke39khQf3tuUcO7J1OKT1f5xknpAxFXK0Z5dUzLBXAtiPXWEyKNDfuK46pYWJQVRf1kA==
X-Received: by 10.28.21.81 with SMTP id 78mr7451719wmv.138.1488054455025;
        Sat, 25 Feb 2017 12:27:35 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id j39sm15502484wrj.45.2017.02.25.12.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 12:27:34 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v7 5/6] stash: use stash_push for no verb form
Date:   Sat, 25 Feb 2017 21:33:05 +0000
Message-Id: <20170225213306.2410-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g275aeb250c.dirty
In-Reply-To: <20170225213306.2410-1-t.gummerer@gmail.com>
References: <20170219110313.24070-1-t.gummerer@gmail.com>
 <20170225213306.2410-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have stash_push, which accepts pathspec arguments, use
it instead of stash_save in git stash without any additional verbs.

Previously we allowed git stash -- -message, which is no longer allowed
after this patch.  Messages starting with a hyphen was allowed since
3c2eb80f, ("stash: simplify defaulting to "save" and reject unknown
options").  However it was never the intent to allow that, but rather it
was allowed accidentally.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt |  8 ++++----
 git-stash.sh                | 16 ++++++++--------
 t/t3903-stash.sh            |  4 +---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 88369ed8b6..4d8d30f179 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,11 +13,11 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
-'git stash' push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+'git stash' save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+	     [-u|--include-untracked] [-a|--all] [<message>]
+'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
-	     [--] [<pathspec>...]
+	     [--] [<pathspec>...]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
diff --git a/git-stash.sh b/git-stash.sh
index 57828f926d..2d7b30ec5e 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -7,11 +7,11 @@ USAGE="list [<options>]
    or: $dashless drop [-q|--quiet] [<stash>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
-   or: $dashless [save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		       [-u|--include-untracked] [-a|--all] [<message>]]
-   or: $dashless push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
-		      [-u|--include-untracked] [-a|--all] [-m <message>]
-		      [-- <pathspec>...]
+   or: $dashless save [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+		      [-u|--include-untracked] [-a|--all] [<message>]
+   or: $dashless [push [--patch] [-k|--[no-]keep-index] [-q|--quiet]
+		       [-u|--include-untracked] [-a|--all] [-m <message>]
+		       [-- <pathspec>...]]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -656,7 +656,7 @@ apply_to_branch () {
 }
 
 PARSE_CACHE='--not-parsed'
-# The default command is "save" if nothing but options are given
+# The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
@@ -666,7 +666,7 @@ do
 	esac
 done
 
-test -n "$seen_non_option" || set "save" "$@"
+test -n "$seen_non_option" || set "push" "$@"
 
 # Main command set
 case "$1" in
@@ -717,7 +717,7 @@ branch)
 *)
 	case $# in
 	0)
-		save_stash &&
+		push_stash &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4d8a096773..2f5888df0d 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -274,9 +274,7 @@ test_expect_success 'stash --invalid-option' '
 	git add file2 &&
 	test_must_fail git stash --invalid-option &&
 	test_must_fail git stash save --invalid-option &&
-	test bar5,bar6 = $(cat file),$(cat file2) &&
-	git stash -- -message-starting-with-dash &&
-	test bar,bar2 = $(cat file),$(cat file2)
+	test bar5,bar6 = $(cat file),$(cat file2)
 '
 
 test_expect_success 'stash an added file' '
-- 
2.11.0.301.g275aeb250c.dirty

