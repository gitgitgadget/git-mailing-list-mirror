Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378CCC001DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGCSqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjGCSqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:08 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BAB137
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:07 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fa93d61d48so57127175e9.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409965; x=1691001965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOj4vagHBIuVG3b0wKMvkS2HmXugzXRR9p09CH5zzBg=;
        b=hKjcqaMpE03bSfSOrPnZF8g7E5zTCytgnxsPsTi6UTN5OgK/nw2J+mGfDvNZFX7xPD
         3pnmSoa0oAn4zvC/0d8Bit2ay1sel8Y277EXy9hDsWJ34B5/akzKmiLzSNxIVg+MiBRQ
         BxRbKY8s+QFyUhgJO1HbZD5+RLBazQO8sY0VPYDKYbIFc9ZwfchrcJh8e9kKWZwkJLsx
         1rCUGvHnT6DVnLI1bRxGtZfdtZ8Oyayi2l02i6LVu6bXkvkcQ9QxDRQBx2VVdflW0q4s
         Am+ackkG62r1sULGM7noaX2ue8sfzePsNZmhUjjsIvfxxrAchspfhha6gYIOCEGcZdjL
         WDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409965; x=1691001965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOj4vagHBIuVG3b0wKMvkS2HmXugzXRR9p09CH5zzBg=;
        b=LJr2Fu3+qkt0bHkGlTEm8BNaBN2f4oGDOF68mqXEKNVbkrdFhDrl6FvQeV3ZZwH8bO
         dZSLEiuNdv//U3VTB6yaIrRLtRUXbcglDgUgds6BMGyMgQJSn7oyoMaPHZM+qWsSSQmP
         XQCIriBjOPg95k76nLafzOsZzSf/lLzqIBp6HREWVVdIElNF+4hy0k6KT1jlQwBzi1Pm
         yF+T3kPysLMu+3nLBKg9OsGHbs3nzL+xZ3gtRogrcyY5L6621nvcntHbqY+tAwxFoNKf
         VZ9Xcvpul+Iy4ZjMP0MwjzeH29zW3wQxR6Oxi+9LZJoJvHye8mHpgeaUpbWWgaIpD7NU
         r4Qg==
X-Gm-Message-State: AC+VfDwkfdAHixXke8EKHBJUQQesAIacpEnpxlQvYiThXks00rp2Fjoy
        D6aGWrCViq9KCI7tWzgH60CRPiAmL6k=
X-Google-Smtp-Source: ACHHUZ64G3v/qfwqoS3Bfe4jE7d3hdUw2jLsdVYnhocNMrtgMlgoF0bGcKTPFgAIdc4XsEDa7IMC4g==
X-Received: by 2002:a05:600c:cb:b0:3f8:f663:921d with SMTP id u11-20020a05600c00cb00b003f8f663921dmr9444180wmm.41.1688409964904;
        Mon, 03 Jul 2023 11:46:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm27824334wmb.8.2023.07.03.11.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:04 -0700 (PDT)
Message-Id: <ca042ded0bb2b0de005008533db64c3c5bcf414f.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:51 +0000
Subject: [PATCH v2 03/10] gitk: add keyboard bind for reset command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jens Lidestrom <jens@lidestrom.se>,
        Jens Lidestrom <jens@lidestrom.se>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jens Lidestrom <jens@lidestrom.se>

Signed-off-by: Jens Lidestrom <jens@lidestrom.se>
---
 gitk-git/gitk | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index fab21d8cfbc..3d4bfa5f1d8 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2675,6 +2675,7 @@ proc makewindow {} {
     bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
+    bind . <$M1B-t> {resethead [selected_line_id]}
     for {set i 1} {$i < 10} {incr i} {
         bind . <$M1B-Key-$i> [list go_to_parent $i]
     }
@@ -2693,7 +2694,7 @@ proc makewindow {} {
         {mc "Write commit to file" command writecommit}
         {mc "Create new branch" command mkbranch}
         {mc "Cherry-pick this commit" command cherrypick}
-        {mc "Reset current branch to here" command resethead}
+        {mc "Reset current branch to here" command {resethead $rowmenuid}}
         {mc "Mark this commit" command markhere}
         {mc "Return to mark" command gotomark}
         {mc "Find descendant of this and mark" command find_common_desc}
@@ -3166,6 +3167,7 @@ proc keys {} {
 [mc "<%s-KP->	Decrease font size" $M1T]
 [mc "<%s-minus>	Decrease font size" $M1T]
 [mc "<F5>		Update"]
+[mc "<%s-T>		Reset current branch to selected commit" $M1T]
 " \
             -justify left -bg $bgcolor -border 2 -relief groove
     pack $w.m -side top -fill both -padx 2 -pady 2
@@ -9859,8 +9861,13 @@ proc revert {} {
     notbusy revert
 }
 
-proc resethead {} {
-    global mainhead rowmenuid confirm_ok resettype NS
+proc resethead {reset_target_id} {
+    global headids mainhead confirm_ok resettype NS
+
+    if {! [info exists headids($mainhead)]} {
+        error_popup [mc "Cannot reset a detached head"]
+        return
+    }
 
     set confirm_ok 0
     set w ".confirmreset"
@@ -9868,7 +9875,7 @@ proc resethead {} {
     make_transient $w .
     wm title $w [mc "Confirm reset"]
     ${NS}::label $w.m -text \
-        [mc "Reset branch %s to %s?" $mainhead [string range $rowmenuid 0 7]]
+        [mc "Reset branch %s to %s?" $mainhead [string range $reset_target_id 0 7]]
     pack $w.m -side top -fill x -padx 20 -pady 20
     ${NS}::labelframe $w.f -text [mc "Reset type:"]
     set resettype mixed
@@ -9891,13 +9898,13 @@ proc resethead {} {
     tkwait window $w
     if {!$confirm_ok} return
     if {[catch {set fd [open \
-            [list | git reset --$resettype $rowmenuid 2>@1] r]} err]} {
+            [list | git reset --$resettype $reset_target_id 2>@1] r]} err]} {
         error_popup $err
     } else {
         dohidelocalchanges
         filerun $fd [list readresetstat $fd]
         nowbusy reset [mc "Resetting"]
-        selbyid $rowmenuid
+        selbyid $reset_target_id
     }
 }
 
-- 
gitgitgadget

