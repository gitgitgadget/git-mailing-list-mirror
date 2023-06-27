Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C62EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjF0OmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjF0OmE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839AC30E5
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso14234105e9.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876889; x=1690468889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdkA237Rzq1Trv8pIbF8G3SN9IrNUiZENoyBh4/95tA=;
        b=m9V0Ytcd+fvgWldH6bwsJgKCvKRVgzT7UeAvZRrOItHT918uADsnSgeamtxXCjD5fs
         Oq1owBNZ4lQQcPMwfHpS4IpkW3lxXw+VEg80u8Oc/sMqlQUNzCb96haIABCRxXTlUCr8
         +zTKNyxCLjTVKLEswjrf0YM7w9WgmyW73vCVk7N8RBylKZx2f9y4UpcF6lKGtvEoZ9iD
         YtUNK+UyqQ34+Jg3WWYJx3+vmGBDQqeaaWqBC2iwci6yjfszSiF0XuEzhftJZlTAHW4h
         bGiBvMVcY+AvCK55TjV2MsXKLGgNAd2d+WY6UHGyNQ1bt37gWBMjhT0WtTmQpiQtnG4c
         NnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876889; x=1690468889;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdkA237Rzq1Trv8pIbF8G3SN9IrNUiZENoyBh4/95tA=;
        b=ISetCo1QV5Cq4WTCNR6tZnl4YUhUzPJe/oncEBwB9uk8Pwf7H7wz0pK4jal/SacVOQ
         rbz/NnmcDihBExg84nWyX9H2f+W7kMS/rGeH3+jqqpZSP7x5MEwAO2OQL5CKUCh4oCg8
         LhjLrt4CFRexrErWhvE8szkClv1lrY6Uo6FMbCXO5XWUS2jDJ8N2KoDTkjLPEZ7qUBIn
         5QMOLum22IJHzZl8nx2/BP4/dNZiGjEIhvHqyhwyWy9NiRuIh9kCQUkrPe1+gKS8M+w6
         4l8kobo8iI9Ppw55YedWWtyWmwsc9xD2y4jc1kS8t3Nm9anNl5gabAvGKPz3Eqob5IrM
         8yvA==
X-Gm-Message-State: AC+VfDz1rJWuSNSF9oEuFnWw8A8aYqh46VoR4o3qZEMFhwm1bBbXhG4w
        YbsYvp0s0wgdV4DGy9dRPwixIT0Xvws=
X-Google-Smtp-Source: ACHHUZ5cCGXuCFpTwGnS+qv8Ll1iIuVeq3b2IR43XmNfVb+S/xtAylXoD6g3kKDj3HUFm3vHL98PmQ==
X-Received: by 2002:a05:600c:4209:b0:3fa:955a:9291 with SMTP id x9-20020a05600c420900b003fa955a9291mr5710371wmh.9.1687876889196;
        Tue, 27 Jun 2023 07:41:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm6025981wmj.41.2023.06.27.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:28 -0700 (PDT)
Message-Id: <2ba695bf94fcd8739e434d4c52f80468919d23c3.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:18 +0000
Subject: [PATCH 3/9] gitk: add keyboard bind for reset
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Paul Mackerras [ ]" <paulus@ozlabs.org>,
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
index 574a80fbcc2..99c6fb6a848 100755
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

