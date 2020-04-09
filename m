Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D09DC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 18:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A7120771
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 18:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlsFjqoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDISD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:03:28 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44102 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgDISD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 14:03:28 -0400
Received: by mail-ed1-f42.google.com with SMTP id cb27so921652edb.11
        for <git@vger.kernel.org>; Thu, 09 Apr 2020 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=VigRXSyTQn8y+l99YQMEUZglL5NIb5JvnHGNe3g6+Iw=;
        b=MlsFjqoDArOpGgCh0qvxw+EeAukP892BQpw9w+Ja/1/IyZnOgow9Uu7KrDWbfaczGd
         KE8rwwBcuBUHdZwxqdYXZAbbNVVL6TJGrYYc9qVguSe4SRw30welD3mKI28krG8SSK3b
         WvQB1SiM+K0dVhHIV+wEJ7u5gmRMkgrQXjku1N/Qeg6h/yzp/nQ0HAFCIOZCxlPBI4gs
         VteWZw6KIsXO2pCh1lXRiv9tfjkQPWiDV3b1gzuNZjC+gNbtiXAA00jjHwf7CCzf2AbN
         yCpxmDYoFEbLSltl2KB3m1S/724MS+bgylatT9+TbII1CkwFP/6sJy7vX5xN6EqI/mLd
         kNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=VigRXSyTQn8y+l99YQMEUZglL5NIb5JvnHGNe3g6+Iw=;
        b=nav4LrKTlb0S7/2MaEMJAwEo67OEdQFIe7Ms9gUihMtnOIgmtHbLRj+zgacnd/R9Tf
         VozQt0qdXeFomrM3PxqYmR3jc15yUIBB4AGaxW69MB2z1TbZ5nDxxim2VpHoQQJ14R5E
         GvtpXFxdOLIjiCVKKrWjM9w36IBOlrtyCpvIecSzmwSC+hucYsdq6dDtD3RNVjLkSQK0
         HAQlgF8aJhQvkd7Nzi9tx0rCsFBSQO1eCdI377UJEjSsXWrZLuERBvl+el60P3Ui3QQn
         saM9eLPdc1w3mWYs/rkLaJyEo4PPzBj8hGKrfHtMlA/IkWwnmPaHpkuuYRmiEUV0l/r0
         wCTA==
X-Gm-Message-State: AGi0PubK7UndReRVkTGTd7WjQl8gSGA/LGPNc/WAVxAdC6qU7hcfV3NZ
        6WnBtZUqlrZNjug5727P2J41FBii
X-Google-Smtp-Source: APiQypJlVt+rbgCSgfh4PUdu4M+pTuYOw8a/T8uqFtj93XCjC3dpRqFLY3I6DVOaJv3Bj9CkyrzOrQ==
X-Received: by 2002:a05:6402:1b03:: with SMTP id by3mr1197220edb.93.1586455406682;
        Thu, 09 Apr 2020 11:03:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ce18sm632423ejb.61.2020.04.09.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 11:03:26 -0700 (PDT)
Message-Id: <pull.607.git.1586455405590.gitgitgadget@gmail.com>
From:   "Ansgar =?UTF-8?Q?R=C3=B6ber?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 09 Apr 2020 18:03:25 +0000
Subject: [PATCH] git-gui: fix concatenation of ui_ready by adding ";"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Ansgar =?UTF-8?Q?R=C3=B6ber?= <ansgar.roeber@rwth-aachen.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        =?UTF-8?q?Ansgar=20R=C3=B6ber?= <ansgar.roeber@rwth-aachen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Ansgar=20R=C3=B6ber?= <ansgar.roeber@rwth-aachen.de>

This fixes https://github.com/git-for-windows/git/issues/2469
Signed-off-by: Ansgar Röber <ansgar.roeber@rwth-aachen.de>
---
    git-gui: fix concatenation of ui_ready by adding ";"
    
    This fixes https://github.com/git-for-windows/git/issues/2469

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-607%2FIsengart%2Ffix-stage-to-commit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-607/Isengart/fix-stage-to-commit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/607

 git-gui.sh        | 4 ++--
 lib/index.tcl     | 4 ++--
 lib/mergetool.tcl | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4610e4ca72a..faaf93b431a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2600,12 +2600,12 @@ proc toggle_or_diff {mode w args} {
 			update_indexinfo \
 				"Unstaging [short_path $path] from commit" \
 				[list $path] \
-				[concat $after [list ui_ready]]
+				[concat $after {ui_ready;}]
 		} elseif {$w eq $ui_workdir} {
 			update_index \
 				"Adding [short_path $path]" \
 				[list $path] \
-				[concat $after [list ui_ready]]
+				[concat $after {ui_ready;}]
 		}
 	} else {
 		set selected_paths($path) 1
diff --git a/lib/index.tcl b/lib/index.tcl
index 1fc5b42300d..59d1f7542a8 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -60,7 +60,7 @@ proc rescan_on_error {err {after {}}} {
 
 	$::main_status stop_all
 	unlock_index
-	rescan [concat $after [list ui_ready]] 0
+	rescan [concat $after {ui_ready;}] 0
 }
 
 proc update_indexinfo {msg path_list after} {
@@ -314,7 +314,7 @@ proc unstage_helper {txt paths} {
 		update_indexinfo \
 			$txt \
 			$path_list \
-			[concat $after [list ui_ready]]
+			[concat $after {ui_ready;}]
 	}
 }
 
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 120bc4064b6..e688b016ef6 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -59,7 +59,7 @@ proc merge_add_resolution {path} {
 	update_index \
 		[mc "Adding resolution for %s" [short_path $path]] \
 		[list $path] \
-		[concat $after [list ui_ready]]
+		[concat $after {ui_ready;}]
 }
 
 proc merge_force_stage {stage} {

base-commit: a5728022e07c53e5ac91db0960870518e243b7c1
-- 
gitgitgadget
