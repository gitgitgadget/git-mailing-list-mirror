Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96336201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbdBSLJ6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:09:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34317 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbdBSLJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:09:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so9620050wmi.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dch4ZPg96dBg35y0p9AKbqHgJsP6dDJvcgTG70YoGS0=;
        b=Fvv1oveWtGVNvH4c+UDu0BFQ5V8x86AsMxbf7oOB4t91BGq4y0NITTgkpLOYeIJfws
         GYB7dAwnPzE9tIHiMagzTQGidepF6r31jjTnmNKyr4i6kQZkRXLW8rmQXC1T155qRdGV
         EVYBGpZuPrkd2zb7XaIlVt/F2MYkianTPyCtkOVxc/J9SgEVdP1EEkV8/dF3lysbtQpa
         IIdzsMiK36MlD6u+r7AvxVyPUV4I+X7e/zJmOVSy8GHrXbP+Z5sV3Y4jkD99Zso9nApo
         Q3kjXZUMILvnVCDSXdiZF4womUC1sttfqC4Bcx0y/y4E5jG+Yt/Axt3B+hHOSuugSTfU
         uStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dch4ZPg96dBg35y0p9AKbqHgJsP6dDJvcgTG70YoGS0=;
        b=PBd1OYWa4vra2CVFir0x5gpx6SyKl0wdJ0V/O7XLVhJuTlI1TgaDqE+nLt/xIp7jeb
         Gj2QBkrsoVWIvOAAMBvTPNN5Jo1vtrNZpXtNV20W+UHKvieX5N9jV6+6JmsJLkvQ4KU6
         cgc6uju1My6IHcUSruaH5guW8t8zfb7R71GDkn1WYD+QOqHkdao5Y2Q4P19/K1NpwpBX
         DK+z5+1p06R67e2tfOfVA1ryWU/z6Khi2UcpFO+gnEdVjwrt5yNSI3ELBKK1PSK7EMBT
         8rNAG+fY6GEDcG6NtSoouBF4xmnsAxl75tNPvGa8u3s4I+5fOd4pVWebgmQlUPSjU7hl
         ekUw==
X-Gm-Message-State: AMke39nhoiAHJBKFhlzV8GKbIUZ2om5Omb1lKqF1sTPPI2awvpbv7dqQ2L1eiYGnXCmrEg==
X-Received: by 10.28.11.131 with SMTP id 125mr12761031wml.29.1487502193494;
        Sun, 19 Feb 2017 03:03:13 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id s26sm20294841wra.26.2017.02.19.03.03.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:12 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 5/6] stash: use stash_push for no verb form
Date:   Sun, 19 Feb 2017 11:03:12 +0000
Message-Id: <20170219110313.24070-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
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
index b7db939a06..3f7fa88ddc 100644
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
index b55983d1fd..1e55cd5fdd 100755
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
@@ -667,7 +667,7 @@ apply_to_branch () {
 }
 
 PARSE_CACHE='--not-parsed'
-# The default command is "save" if nothing but options are given
+# The default command is "push" if nothing but options are given
 seen_non_option=
 for opt
 do
@@ -677,7 +677,7 @@ do
 	esac
 done
 
-test -n "$seen_non_option" || set "save" "$@"
+test -n "$seen_non_option" || set "push" "$@"
 
 # Main command set
 case "$1" in
@@ -728,7 +728,7 @@ branch)
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
2.12.0.rc2.399.g0ca89a282

