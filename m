Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F011F42D
	for <e@80x24.org>; Mon, 28 May 2018 12:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424992AbeE1Mfx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 08:35:53 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43471 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424972AbeE1Mfg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 08:35:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so4584262wrm.10
        for <git@vger.kernel.org>; Mon, 28 May 2018 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x2lL4xThnbkL/T8RgO8y+GLWpaKTrfbQ6Ynrc+qYpeg=;
        b=q0y1LN5CHl13s31oxvgWFr3xj9fthv36C9O3PzvT0sMRlEVcMh9Zqw3HcjJxJ6JZGI
         +gx1t/3J21fZ3V9q1KC4YuvNp6Z8BmLLd9dTi2tA1Py5thhCw8RLNQ656DExinef6l6+
         20AGB9cCrWl4HrIg/siv7pu+pS25IIaNzxFNhEfWmBTz3D6VJZ2YcNQqYF5NmA5g498k
         7SEqDMqHyBkOqoTb7eE/itHx2UihGiXioGNsPyeat6Py/ZmfNI0R5HDpaWpML80fM8Mg
         pU/gKjC2XrAqSFfewXFziTwpfc3FXKb/+GLSkfgLcrwEwuVDMAzvrkzf5thiAc6m1btG
         5QTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x2lL4xThnbkL/T8RgO8y+GLWpaKTrfbQ6Ynrc+qYpeg=;
        b=obwjGE5eTIjEDlnuffFW+nptJzjyTubxSdEfpaV9giYEHKVs5WOWQwnaRH425CDlAn
         WsVHOsxJIQ1AMGYnydOviR5+gMwR8jed65Juw4N0DFROcyWzxjms0ubcvNucnTSPHPUn
         XaI3nsFSWWatKIhuTMN3vGetSFNAfC4UdZrGB1v5+LP8YSaXX+zzMe3RsjNs4JpgHWiA
         pwQTSXPY1jIiWb3Z/YO41XlOGtCsi0WVLLbtwiYgMwhxJr+356VB/InxIPslF2rlRvCs
         1fLyJ7O7zJW1wxG5TWHcsxP/Az8GwPgqJIXY+xDd1s/lTnz7LQFDFCH428oSNRaG8Vb4
         8E7A==
X-Gm-Message-State: ALKqPwew/W5NOYYBRFvCKDjEu5pqmqT0+bA7iELJVgVv3gO+QbfwlbdT
        QtEjWAfmOv6Bdx8tWW9vnk3MCELF
X-Google-Smtp-Source: AB8JxZpxQvqOebNumjjqagLrWi2E8R9OleqbJopMf8igF/rqzSQZNkLhzcE5whWbbM8REgaDgnlKIA==
X-Received: by 2002:adf:b310:: with SMTP id j16-v6mr9716573wrd.207.1527510934806;
        Mon, 28 May 2018 05:35:34 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-64.w86-221.abo.wanadoo.fr. [86.221.117.64])
        by smtp.googlemail.com with ESMTPSA id p5-v6sm13808895wre.83.2018.05.28.05.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 May 2018 05:35:33 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 3/4] rebase: use the new git-rebase--preserve-merges.sh
Date:   Mon, 28 May 2018 14:34:21 +0200
Message-Id: <20180528123422.6718-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180528123422.6718-1-alban.gruin@gmail.com>
References: <20180524114958.26521-1-alban.gruin@gmail.com>
 <20180528123422.6718-1-alban.gruin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new type of rebase, "preserve-merges", used when rebase is
called with -p.

Before that, the type for preserve-merges was "interactive", and some
places of this script compared $type to "interactive". Instead, the code
now checks if $interactive_rebase is empty or not, as it is set to
"explicit" when calling an interactive rebase (and, possibly, one of its
submodes), and "implied" when calling one of its
submodes (eg. preserve-merges) *without* interactive rebase.

It also detects the presence of the directory "$merge_dir"/rewritten
left by the preserve-merges script when calling rebase --continue,
--skip, etc., and, if it exists, sets the rebase mode to
preserve-merges. In this case, interactive_rebase is set to "explicit",
as "implied" would break some tests.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 git-rebase.sh | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 40be59ecc..19bdebb48 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -207,7 +207,14 @@ run_specific_rebase () {
 		autosquash=
 	fi
 	. git-rebase--$type
-	git_rebase__$type${preserve_merges:+__preserve_merges}
+
+	if test -z "$preserve_merges"
+	then
+		git_rebase__$type
+	else
+		git_rebase__preserve_merges
+	fi
+
 	ret=$?
 	if test $ret -eq 0
 	then
@@ -239,7 +246,12 @@ then
 	state_dir="$apply_dir"
 elif test -d "$merge_dir"
 then
-	if test -f "$merge_dir"/interactive
+	if test -d "$merge_dir"/rewritten
+	then
+		type=preserve-merges
+		interactive_rebase=explicit
+		preserve_merges=t
+	elif test -f "$merge_dir"/interactive
 	then
 		type=interactive
 		interactive_rebase=explicit
@@ -402,14 +414,14 @@ if test -n "$action"
 then
 	test -z "$in_progress" && die "$(gettext "No rebase in progress?")"
 	# Only interactive rebase uses detailed reflog messages
-	if test "$type" = interactive && test "$GIT_REFLOG_ACTION" = rebase
+	if test -n "$interactive_rebase" && test "$GIT_REFLOG_ACTION" = rebase
 	then
 		GIT_REFLOG_ACTION="rebase -i ($action)"
 		export GIT_REFLOG_ACTION
 	fi
 fi
 
-if test "$action" = "edit-todo" && test "$type" != "interactive"
+if test "$action" = "edit-todo" && test -z "$interactive_rebase"
 then
 	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
 fi
@@ -487,7 +499,13 @@ fi
 
 if test -n "$interactive_rebase"
 then
-	type=interactive
+	if test -z "$preserve_merges"
+	then
+		type=interactive
+	else
+		type=preserve-merges
+	fi
+
 	state_dir="$merge_dir"
 elif test -n "$do_merge"
 then
@@ -647,7 +665,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
 # but this should be done only when upstream and onto are the same
 # and if this is not an interactive rebase.
 mb=$(git merge-base "$onto" "$orig_head")
-if test "$type" != interactive && test "$upstream" = "$onto" &&
+if test -z "$interactive_rebase" && test "$upstream" = "$onto" &&
 	test "$mb" = "$onto" && test -z "$restrict_revision" &&
 	# linear history?
 	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
@@ -691,7 +709,7 @@ then
 	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
 fi
 
-test "$type" = interactive && run_specific_rebase
+test -n "$interactive_rebase" && run_specific_rebase
 
 # Detach HEAD and reset the tree
 say "$(gettext "First, rewinding head to replay your work on top of it...")"
-- 
2.16.1

