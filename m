Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC430201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964834AbdBQWlQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:41:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36361 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964806AbdBQWlM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:41:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so4804354wmd.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o616vGnyQ4zNXWzqrjaR7JtLvFOIl8Lp/j4EAd8DtYY=;
        b=i61uDfcGgJKAP1hc+TL14e/kcbdlesrgeGceCfY/3hxwy/I5jR5i+z2DH4VQTMuks3
         YojfTjQZDEDW90K3mHCiyXafn8vmXd3FPll4bwBNFqLHwUamgN/yb/9mRARfCGNRstho
         ax45moNPgtMfzF6onjmDsJw6I7GS+7gsJ30mKht8bA8NPxwd8cgGzOKs9A+Uh8ParPf2
         O0Kz0smMr5zgx52BvkYQsNIy0NIMvga2KGVtUuS19/Qd3F0SoLmQM9QjtTlrJ2BCgZVC
         5tgtOcjSlKPAptB9CJpJPkb1Sbmy2CxWs7FKUZu6Wp6pVG0PScI3KZP7/eyfFhM1NzHk
         o13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o616vGnyQ4zNXWzqrjaR7JtLvFOIl8Lp/j4EAd8DtYY=;
        b=WJBWjCGF5r64IPo0o3Jg1ZchUN0HHNjXicOPkDggP8CBnnsl/EAwJFdFIEibM6fyyp
         mXUOllpILH+Or7Srf6RvGHMEX4zRC/FWOKrViQIIDXRgvYEH1QXCV8uhwhYz8pLQe07w
         ys2RuK/8WmqYUZbxfbTWOY+tozEsrbKbVxTunqe9oGQWNDnkzshdBeaDP7IFNDHzq51t
         DIkYKGvOZx69pgZtnUdYHI9CFQL14nNjaeFVtQueI7CFgOzzmundbx3pHh7nhnFcjMh/
         8hSDT8A976jFcKeoY/ZZ2jHYyEnY+sgaQMPRbOI2MSAP6q3VeHIJFUHXwSfI8X6k1YkN
         dtpg==
X-Gm-Message-State: AMke39mJlo2N9VTfuSG6MOvGUWYDkhJLmGC2D78E63aIySrF/0FJlg7sD7WZ0ZGNUGgc0Q==
X-Received: by 10.28.126.12 with SMTP id z12mr3800733wmc.84.1487371270588;
        Fri, 17 Feb 2017 14:41:10 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id w16sm3297992wmd.4.2017.02.17.14.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 14:41:10 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 5/6] stash: use stash_push for no verb form
Date:   Fri, 17 Feb 2017 22:41:40 +0000
Message-Id: <20170217224141.19183-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g27b9849079.dirty
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
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
index 086c229db0..97194576ef 100644
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
index 6b56f84d81..2a33614cb7 100755
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
@@ -668,7 +668,7 @@ apply_to_branch () {
 }
 
 PARSE_CACHE='--not-parsed'
-# The default command is "save" if nothing but options are given
+# The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
@@ -678,7 +678,7 @@ do
 	esac
 done
 
-test -n "$seen_non_option" || set "save" "$@"
+test -n "$seen_non_option" || set "push" "$@"
 
 # Main command set
 case "$1" in
@@ -729,7 +729,7 @@ branch)
 *)
 	case $# in
 	0)
-		save_stash &&
+		push_stash &&
 		say "$(gettext "(To restore them type \"git stash apply\")")"
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 4fb800eec8..7f90a247b4 100755
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
2.11.0.301.g27b9849079.dirty

