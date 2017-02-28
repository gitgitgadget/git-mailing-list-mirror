Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B6B201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbdB1Ug0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:36:26 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33832 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751531AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: by mail-wm0-f65.google.com with SMTP id m70so4173767wma.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+IxSWSRFXA7MFpSAZX4iFEb1AlxcP/aLPlfO8uKjA7Q=;
        b=qL6ghmXBKH4kW7iNMGmZP1KvOpmu+p41LSsDVf0c/KXnhd1UTQUV7BYBeENrz94Q7Q
         d32Zg2u6WfiIOseh+MDPVdl5CutSRfkII3NbLMbG9YWkpyvZFkL4vaePOLMxLYBQ/GJH
         jiGC7KhhsfJ81g7VH2xQflie+ae0zZsU/iE0+Nli2jppRMQ9df418tAq31eCBcKyPE/8
         Il/uKlHgymFSJHE1k5U2OaZuCPDI/tE54h4pdmfoAwUJk5wCSqVVYlfW5anPRmZDydB0
         zwqSnT7iNtt8u9cNPnd+NPzuI6APC96JlxE5t55D5aGcAxI2Ew2gjwzG3UgvFw08xCD3
         XSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+IxSWSRFXA7MFpSAZX4iFEb1AlxcP/aLPlfO8uKjA7Q=;
        b=Q0yBho8txI3hV/NZBfchb69yPp0ZkD9/nJAlD3pe+5dFaNGStSjB7cd+WSnceFWgHm
         fHXzngC6reOucKLXAhMy23bmx0gx6WLsrbqlxeKREuPkq08WI/4TZ0vQtVBJasml3G3v
         InN7nWnTeUfVPeeHLOo4Sg44BghyAOywl9+ALXpZfSBwCp+kZ6PzkUcJ2OXgvaLZJEp3
         GZJ4wMXVTHXFsBMtQ/Xkm4HkROKF2OefqCWlnYMLjzGDJ8fYpAHNowK8BIhIion/8h7J
         RJumREwNKqu6XbjYi+JAVS6sYPtCnzTLSs3lFKcuymzXFlKrfEq5UVZbkcuA/r1bD9b0
         etgQ==
X-Gm-Message-State: AMke39nUJB8ztPpM3/4abeY65JjCuxFmoVpWJ15UXZzaqZ/j/4EjKp7kpwT86z8CKOT+Tg==
X-Received: by 10.28.209.202 with SMTP id i193mr380292wmg.17.1488314031229;
        Tue, 28 Feb 2017 12:33:51 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id q4sm3737790wrc.35.2017.02.28.12.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Feb 2017 12:33:50 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 5/6] stash: use stash_push for no verb form
Date:   Tue, 28 Feb 2017 20:33:39 +0000
Message-Id: <20170228203340.18723-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.428.g67fe103aa
In-Reply-To: <20170228203340.18723-1-t.gummerer@gmail.com>
References: <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170228203340.18723-1-t.gummerer@gmail.com>
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
index 5892abafa3..f3c2f86804 100755
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
@@ -658,7 +658,7 @@ apply_to_branch () {
 }
 
 PARSE_CACHE='--not-parsed'
-# The default command is "save" if nothing but options are given
+# The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
@@ -668,7 +668,7 @@ do
 	esac
 done
 
-test -n "$seen_non_option" || set "save" "$@"
+test -n "$seen_non_option" || set "push" "$@"
 
 # Main command set
 case "$1" in
@@ -719,7 +719,7 @@ branch)
 *)
 	case $# in
 	0)
-		save_stash &&
+		push_stash &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index f934993263..e875fe8259 100755
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
2.12.0.428.g67fe103aa

