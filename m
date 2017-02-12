Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9C861FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbdBLVyc (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:32 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36561 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbdBLVy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:29 -0500
Received: by mail-wr0-f194.google.com with SMTP id k90so21579755wrc.3
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCTNIOna+AsSQwKtMCCHs8PNzMSbtRDRimxCV6badoA=;
        b=pjjMJA7oRruC+6K0brvHXNBBupgQe0YAgkN4N8nzgHjkbJIbyJgqlFJZaBh/laYUId
         OS4iqjRBEfLYfoxIK4pitHIJMUnz3GggR++vTo5Y0/2CBId6qREopsBk2UN7HxjccdZT
         xdyu3iQhSRcJNKevNgAJ7rf1JYSaIMTmSsHHdzdEuR2Y6rX2rJjBGeSZbjfMrHlBjfIS
         jrMc64+z0obXhc3k1ygzkRYUPuJWt/DYy2ypCZVWH32H0vRCLk9np8xrPt731/wLtbk6
         8DFFGLSf8nw7sqPV4VNlFOh9xW4cTVoW5tpL3LPieFSVv0+IsJoeEOnOfXdOBzpwbSfN
         AZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VCTNIOna+AsSQwKtMCCHs8PNzMSbtRDRimxCV6badoA=;
        b=Ck2D1FBvE9usztRopmxq7H6yFnOPP+Xe9dG1gFlmihf/mUOxgVIUHfHPe603RJ0qk7
         lUxW5rH7XTm+RlowLhUN9bRSujxyQa9gA2EidQKXc0iWaJmkUSpV25R9FeSNFc0ltLOb
         xs6oQ4ZWQO4Ods0rNQhMypeVBpi9mYiGb2iqGj94stED1wABL2o8pjaqzqIiXN+qY8kj
         +rVIk72HbJiXxxd6bRXFKiTFH0nIpSKi4djxs9iK1UOFq5BoE7zQcvjHRqVJT1DVrCvR
         18uDciNASjiYGw/A6C5ezjetatp1QYDn8GJcrHg+vIyA7mkPMO6vWJuucfJzrIcuWZQH
         2qOA==
X-Gm-Message-State: AMke39keisMBOc5Fs1r2BBSA1yu8XehtgYh8NsmwG06MfHYINuhsBPFJ1QzgHbd+hMSGvw==
X-Received: by 10.223.154.109 with SMTP id z100mr16400792wrb.145.1486936468064;
        Sun, 12 Feb 2017 13:54:28 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 10sm11350934wrw.13.2017.02.12.13.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:27 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 6/7] stash: use stash_push for no verb form
Date:   Sun, 12 Feb 2017 21:54:19 +0000
Message-Id: <20170212215420.16701-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have stash_push, which accepts pathspec arguments, use
it instead of stash_save in git stash without any additional verbs.

This does introduce a small regression.  Previously we allowed
git stash -- -message, with a hyphen in front of the message.  However
git stash -- message without the hyphen was not allowed.  After this
change adding a message to the stash, with or without hyphen is no
longer allowed.

While this now allows specifying a message with the -m flag, it also
disallows messages without a hyphen.  This is to prevent user errors,
where a user tries to stash something with a message, but changes their
mind, and now would like to apply a stash, but forgets to remove the -m
flag.  E.g. git stash -m mes^H^H^Happly would result in a stash with the
message apply, while the user might have intended to apply a previous
stash.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

If this kind of regression introduced here is not acceptable, I think
we could hide this change between some kind of config option, and
transition users over later after a warning period.

 Documentation/git-stash.txt |  8 ++++----
 git-stash.sh                | 16 ++++++++--------
 t/t3903-stash.sh            |  4 +---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index f462f393b0..b0825f4aca 100644
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
 'git stash' create [-m <message>] [-u|--include-untracked <untracked|all>]
diff --git a/git-stash.sh b/git-stash.sh
index db56cf2c66..769cee9fd8 100755
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
@@ -699,7 +699,7 @@ apply_to_branch () {
 }
 
 PARSE_CACHE='--not-parsed'
-# The default command is "save" if nothing but options are given
+# The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
@@ -709,7 +709,7 @@ do
 	esac
 done
 
-test -n "$seen_non_option" || set "save" "$@"
+test -n "$seen_non_option" || set "push" "$@"
 
 # Main command set
 case "$1" in
@@ -760,7 +760,7 @@ branch)
 *)
 	case $# in
 	0)
-		save_stash &&
+		push_stash &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 8b372c35fb..d568799da9 100755
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
2.11.0.301.g86e6ecc671.dirty

