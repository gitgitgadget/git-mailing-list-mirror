Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FFD2013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbdBPAjc (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:39:32 -0500
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33630 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756216AbdBPAiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:22 -0500
Received: by mail-pg0-f54.google.com with SMTP id 204so909253pge.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZHJFaNPRhLylKLZvG+5VYnQ1zMzYJlM5TvicAJHtJo=;
        b=fk2YMrkgT3/Rctjk2zqmpMUt1X8JKJUmFyFOEYvaD2ve7psVKC4E9vYa8LS3A5Zm26
         RdBFwr3ZEQRqQSKQghlgqoPipCmD0WrE8jTKO2RJuZrfwx85rZT32VP+tKhAG5d4TibZ
         hf3Zxyj6j2ZVRJGoR/omDj8Z17PQ0eaF3CBa2mvnz7/ojGfOowwPcHXQoq1r/uusi10q
         e9Y10ZyS8UX7oB/xN3SL5cmZAuLh1xw8kTpWaKjj8uYGulDqmQlcW0g0CPb2xfV6RvsH
         PpNKAXCerr4ANYFmURFxbGw4nG8qSg7w9Z7ee+/io+DbUTevRi/wOFAL0BR6OVmO2brc
         Ap7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZHJFaNPRhLylKLZvG+5VYnQ1zMzYJlM5TvicAJHtJo=;
        b=HRQTn6xM/HlwSqp/JUrRBXRubf+WGCkZUP/jW904c/aLenMEfoxlyKsG0gOTNBjVbp
         3O40Xb9mqI16avSHcHFLzfcrvfBLBbdjpElS/tNZytOUKMo8rLdSdrX18Pl06qwLueZv
         WOWHmW7lWjENnmUIQCj2UcLNsVPhSpkteAuAfRiztO8lonwMnvpSrAgfP5syQSMJRNRN
         pea0pUYWVpQbe+x8frca5xdbcwIiLpAA6tN7zytP/rnO4xK4cplaToTR/8Gh5o9ummWg
         WFMqK3l6irnkR6+rLLWeWhjyISFsUWiOwx1lBoPxpye54ARghP+GMWe0Fvv+UUdatjBg
         aeng==
X-Gm-Message-State: AMke39kVvlq/yQ5HyYv/YaWOdBha/182Xstsm41SJb0MvxJ8/MEHd0+l3IFllqeqjZri2Cl6
X-Received: by 10.84.241.10 with SMTP id a10mr47432773pll.47.1487205501146;
        Wed, 15 Feb 2017 16:38:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id a24sm9570174pfh.33.2017.02.15.16.38.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/15] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Wed, 15 Feb 2017 16:37:57 -0800
Message-Id: <20170216003811.18273-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Redraw the ASCII art describing the setup using more space, such that
it is easier to understand.  The leaf commits are now ordered the same
way the actual code is ordered.

Add empty lines to the setup code separating each of the leaf commits,
each starting with a "checkout -b".

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 49 ++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 915eb4a7c6..5df528ea81 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -15,22 +15,27 @@
 # - Tracked file replaced by submodule (replace_sub1_with_file =>
 #   replace_file_with_sub1)
 #
-#                   --O-----O
-#                  /  ^     replace_directory_with_sub1
-#                 /   replace_sub1_with_directory
-#                /----O
-#               /     ^
-#              /      modify_sub1
-#      O------O-------O
-#      ^      ^\      ^
-#      |      | \     remove_sub1
-#      |      |  -----O-----O
-#      |      |   \   ^     replace_file_with_sub1
-#      |      |    \  replace_sub1_with_file
-#      |   add_sub1 --O-----O
-# no_submodule        ^     valid_sub1
-#                     invalid_sub1
+#                     ----O
+#                    /    ^
+#                   /     remove_sub1
+#                  /
+#       add_sub1  /-------O
+#             |  /        ^
+#             | /         modify_sub1
+#             v/
+#      O------O-----------O---------O
+#      ^       \          ^         replace_directory_with_sub1
+#      |        \         replace_sub1_with_directory
+# no_submodule   \
+#                 --------O---------O
+#                  \      ^         replace_file_with_sub1
+#                   \     replace_sub1_with_file
+#                    \
+#                     ----O---------O
+#                         ^         valid_sub1
+#                         invalid_sub1
 #
+
 create_lib_submodule_repo () {
 	git init submodule_update_repo &&
 	(
@@ -49,10 +54,11 @@ create_lib_submodule_repo () {
 		git config submodule.sub1.ignore all &&
 		git add .gitmodules &&
 		git commit -m "Add sub1" &&
-		git checkout -b remove_sub1 &&
+
+		git checkout -b remove_sub1 add_sub1 &&
 		git revert HEAD &&
 
-		git checkout -b "modify_sub1" "add_sub1" &&
+		git checkout -b modify_sub1 add_sub1 &&
 		git submodule update &&
 		(
 			cd sub1 &&
@@ -67,7 +73,7 @@ create_lib_submodule_repo () {
 		git add sub1 &&
 		git commit -m "Modify sub1" &&
 
-		git checkout -b "replace_sub1_with_directory" "add_sub1" &&
+		git checkout -b replace_sub1_with_directory add_sub1 &&
 		git submodule update &&
 		git -C sub1 checkout modifications &&
 		git rm --cached sub1 &&
@@ -75,22 +81,25 @@ create_lib_submodule_repo () {
 		git config -f .gitmodules --remove-section "submodule.sub1" &&
 		git add .gitmodules sub1/* &&
 		git commit -m "Replace sub1 with directory" &&
+
 		git checkout -b replace_directory_with_sub1 &&
 		git revert HEAD &&
 
-		git checkout -b "replace_sub1_with_file" "add_sub1" &&
+		git checkout -b replace_sub1_with_file add_sub1 &&
 		git rm sub1 &&
 		echo "content" >sub1 &&
 		git add sub1 &&
 		git commit -m "Replace sub1 with file" &&
+
 		git checkout -b replace_file_with_sub1 &&
 		git revert HEAD &&
 
-		git checkout -b "invalid_sub1" "add_sub1" &&
+		git checkout -b invalid_sub1 add_sub1 &&
 		git update-index --cacheinfo 160000 0123456789012345678901234567890123456789 sub1 &&
 		git commit -m "Invalid sub1 commit" &&
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
+
 		git checkout master
 	)
 }
-- 
2.12.0.rc1.16.ge4278d41a0.dirty

