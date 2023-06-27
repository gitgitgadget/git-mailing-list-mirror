Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A78EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 14:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjF0Omh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 10:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjF0OmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 10:42:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DF930D5
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so21382855e9.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687876891; x=1690468891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRoYwVHzSDwkYldlcFwgc+8SqgwvY7sM5nMQ6BpUX1A=;
        b=hJ9L5PKUV6gr76elZnBd4eHusDmrCY+390M9b8ErwN61VSvZyRxe6X8gay0bLwiz47
         aFEsrjmXqt/xVCu4RzIApiFlNv5SsJjzcWvLwXd4KJfw+HGnhrbMNgd9f0yEMfgw9z/6
         o4pBG/iKmdlgv925Xgz/WUmlB/wMxVmea31WMO1iiaV8cF5tyLhafFthVqM5yK095K5J
         7SsQ0AzUwSm1jSfxEnse1P1tEoufIzBvNYPaM8soO+0aR4/+/+bX/2+/FtAszR6AsucB
         XFEBhPh7iKsgbN5QaTJX3vImnCSy4HvhduO7GE7yFg/EqATAQjShFIDLxxCjOSjPvH9u
         BHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687876891; x=1690468891;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRoYwVHzSDwkYldlcFwgc+8SqgwvY7sM5nMQ6BpUX1A=;
        b=S/5Ni2yMSk/RWIRBxTH6F2yiBix+WdalH07qs0abm0/5+KplYdL7SZV80jWjudHk5b
         AwjSMPjkVzpo6SPLPCAPObpjQUmfGq+tk4Ff0whkkaH6IqM3ecROnVWWgSbVmDEPnPn9
         4N/IXkzvMoJEvGNTn6x8Rb5vru2Ob3zhGJSFCaVeBHvv3c0vjuuUOezxL/+1MnMePff/
         BAL/oUFN9WZ9+kBzJjpRynz7bVZWuPGt4S6+Jhmx/ACH464Il0LY7Dks8MASo/5MVq/W
         8c24/ezsjbwRzq8Yq6KHjyRV8JwSfbnjl01aiyLd8ZEnd+oDr1i4REeQBdWaLXXDGU2f
         hYhA==
X-Gm-Message-State: AC+VfDxjjxuywmevu+g4fkoqvuZQ5P9pxDJIBr+AvvGAZP++cwgx13dY
        2HmIDCE6TUFc7t0RjM2apOhsOSmossM=
X-Google-Smtp-Source: ACHHUZ7B/5gAt83NWsZxxlk7D+NwwqfihCuFArC7nAKHDYSHmS3eGsv4T4oduJpeQwK176rbszkY5A==
X-Received: by 2002:a7b:ce12:0:b0:3fa:97ad:2ba5 with SMTP id m18-20020a7bce12000000b003fa97ad2ba5mr4194007wmc.31.1687876891632;
        Tue, 27 Jun 2023 07:41:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bcb8d000000b003fba97b1252sm1044431wmi.1.2023.06.27.07.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:41:31 -0700 (PDT)
Message-Id: <46cbbaa6fe2a215e8b7f1e4f9b5c420d5850503c.1687876885.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Jun 2023 14:41:22 +0000
Subject: [PATCH 7/9] gitk: add keyboard bind to cherry-pick
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
 gitk-git/gitk | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 0d83a72a424..5b01d1902a5 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2690,6 +2690,7 @@ proc makewindow {} {
     bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
+    bind . <$M1B-p> {cherrypick [selected_line_id]}
     bind . <$M1B-t> {resethead [selected_line_id]}
     bind . <$M1B-o> {checkout [selected_line_head] [selected_line_id]}
     bind . <$M1B-m> {rmbranch [selected_line_head] [selected_line_id] 1}
@@ -2711,7 +2712,7 @@ proc makewindow {} {
         {mc "Copy commit reference" command copyreference}
         {mc "Write commit to file" command writecommit}
         {mc "Create new branch" command {mkbranch $rowmenuid}}
-        {mc "Cherry-pick this commit" command cherrypick}
+        {mc "Cherry-pick this commit" command {cherrypick $rowmenuid}}
         {mc "Reset current branch to here" command {resethead $rowmenuid}}
         {mc "Mark this commit" command markhere}
         {mc "Return to mark" command gotomark}
@@ -3186,6 +3187,7 @@ proc keys {} {
 [mc "<%s-minus>	Decrease font size" $M1T]
 [mc "<F5>		Update"]
 [mc "<%s-T>		Reset current branch to selected commit" $M1T]
+[mc "<%s-P>		Cherry-pick selected commit to current branch" $M1T]
 [mc "<%s-O>		Check out selected commit" $M1T]
 [mc "<%s-C>		Create branch on selected commit" $M1T]
 [mc "<%s-M>		Remove selected branch" $M1T]
@@ -9758,24 +9760,29 @@ proc exec_citool {tool_args {baseid {}}} {
     array set env $save_env
 }
 
-proc cherrypick {} {
-    global rowmenuid curview
+proc cherrypick {id} {
+    global curview headids
     global mainhead mainheadid
     global gitdir
 
+    if {! [info exists headids($mainhead)]} {
+        error_popup [mc "Cannot cherry-pick to a detached head"]
+        return
+    }
+
     set oldhead [exec git rev-parse HEAD]
-    set dheads [descheads $rowmenuid]
+    set dheads [descheads $id]
     if {$dheads ne {} && [lsearch -exact $dheads $oldhead] >= 0} {
         set ok [confirm_popup [mc "Commit %s is already\
                 included in branch %s -- really re-apply it?" \
-                                   [string range $rowmenuid 0 7] $mainhead]]
+                                   [string range $id 0 7] $mainhead]]
         if {!$ok} return
     }
     nowbusy cherrypick [mc "Cherry-picking"]
     update
     # Unfortunately git-cherry-pick writes stuff to stderr even when
     # no error occurs, and exec takes that as an indication of error...
-    if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
+    if {[catch {exec sh -c "git cherry-pick -r $id 2>&1"} err]} {
         notbusy cherrypick
         if {[regexp -line \
                  {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
@@ -9791,7 +9798,7 @@ proc cherrypick {} {
                         resolve it?"]]} {
                 # Force citool to read MERGE_MSG
                 file delete [file join $gitdir "GITGUI_MSG"]
-                exec_citool {} $rowmenuid
+                exec_citool {} $id
             }
         } else {
             error_popup $err
-- 
gitgitgadget

