Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D886C30657
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 18:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjGCSq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGCSqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 14:46:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DDE10D0
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 11:46:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso51341225e9.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688409970; x=1691001970;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk45O6gr7lEHcBSneL+couPdDI5VLKZ2CBJ8y3SfeJY=;
        b=p81piHOfl9I0cRCWCJjfWynZfPkCkVzJC+eIDQFSr58R9NzIKrnTduvNE3sOuTq8lJ
         HXqB3IzPg35AZcjzaYAKzSOPFEIboMNg7WE3WowTFwxgXs4Qo4A59IDeoZMU1sC9znIm
         FjA/tc4GU4b0veMynamyqyZTysu74buO7hWzD4418uSjFGJHoON+A+dc62Y2gOT9cOGJ
         6h+cfwsVB96ICoOb6YxgXxvPWXGHxQbaFsizCU20tRJLMnKxIpm+h8Vf7rCRMDdadHur
         POe0/PRigmyFN+gZLDLLz4/RcPfpxSFgiyi8V3M+5u7QNi+Zmb5GasTxYLRg7MPPSaF2
         8tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688409970; x=1691001970;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kk45O6gr7lEHcBSneL+couPdDI5VLKZ2CBJ8y3SfeJY=;
        b=K8tvFbFMnuB2u5PqiCRFSZ7PyqCU+6RDw+xn2c+6aq6tsPvplS1bxufXNTkANxl5sD
         0VzAeYqvi3FxaIthT4SuYE+ADddXveZ9jPVS9NYgcUXwbWBtcGAvDmfuSETWSGJGN6XA
         g85uiTVaxmXGzX3RFHbLWvHWbUTOJIgOBf7EAFq99hA2V1ZVx23wF8+NE+pPOi+KQ4Af
         dhva4RPyw6zDuoA9l/4l4VtIqHPKgs13qZbY0LDxyRCqbV4+Er99Ca/7uWMyoJ96uzzz
         RtxESAvBUwQikJe3YK4jdPL7kPtdW0+mnQvhgeawZHEabvewHz7nwhj2I8O9jm560ZsF
         c+JA==
X-Gm-Message-State: AC+VfDyHCsW84ofrJtHAcd9XH1qsNqu+4Y7Ju4L1J3jaEhUJaxk6FYvI
        FuWx344g0sz/2RKPNc67db3twCVWRSs=
X-Google-Smtp-Source: ACHHUZ6ZFn1Ha2HqWOrNObDpNvz7ezzOMtyJk+q8WLY/QiGmLLkwQcDD7wQ+Mxf93v3XKzOSZ00cUg==
X-Received: by 2002:a7b:c5d0:0:b0:3f6:a65:6ff3 with SMTP id n16-20020a7bc5d0000000b003f60a656ff3mr10336504wmk.32.1688409970139;
        Mon, 03 Jul 2023 11:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c21c900b003fb41491670sm20268086wmj.24.2023.07.03.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:46:09 -0700 (PDT)
Message-Id: <54afa8fe9e831f5381d045bc24464ff2d6246118.1688409958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
References: <pull.1551.git.1687876884.gitgitgadget@gmail.com>
        <pull.1551.v2.git.1688409958.gitgitgadget@gmail.com>
From:   "Jens Lidestrom via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jul 2023 18:45:55 +0000
Subject: [PATCH v2 07/10] gitk: add keyboard bind for cherry-pick command
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
 gitk-git/gitk | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 65ca11becca..351b88f10c0 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2690,6 +2690,7 @@ proc makewindow {} {
     bind $ctext $ctxbut {pop_diff_menu %W %X %Y %x %y}
     bind $ctext <Button-1> {focus %W}
     bind $ctext <<Selection>> rehighlight_search_results
+    bind . <$M1B-p> {cherrypick [selected_line_id]}
     bind . <$M1B-t> {resethead [selected_line_id]}
     bind . <$M1B-o> {checkout [selected_line_heads] [selected_line_id]}
     bind . <$M1B-m> {rmbranch [selected_line_heads] [selected_line_id] 1}
@@ -2710,8 +2711,8 @@ proc makewindow {} {
         {mc "Create tag" command mktag}
         {mc "Copy commit reference" command copyreference}
         {mc "Write commit to file" command writecommit}
-        {mc "Create new branch" command mkbranch}
-        {mc "Cherry-pick this commit" command cherrypick}
+        {mc "Create new branch" command {mkbranch $rowmenuid}}
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
 [mc "<%s-B>		Create branch on selected commit" $M1T]
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

