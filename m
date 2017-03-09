Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 442C3202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbdCIWQH (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:07 -0500
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36770 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbdCIWQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:04 -0500
Received: by mail-pg0-f42.google.com with SMTP id g2so13776627pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zRT/yA5frCrCnAUP8EGGRX9q0wuQeG8tKy/e8Yo+L4Q=;
        b=MBiPJMVrWrIKsNUitiZys5Gi4bbUAXoOR0rOsqfPfY0hbs2l9G3kQ5+gFJ8sAYQZZX
         wykl2J/lYYFrtCLbgAOgpYrbm+bVaAkOle1nBXT2sbqK9P9M+qKbV7RhPI7EkvnFUqzt
         u1hJWZjC6zpZC/5GQ3rh30yLn2QIOPV9D1fIA24o2l9cf/0qUAbB2UbBSZXesOBTGs0L
         p6vwgnjDWoaA9mxkEUVjy2EEbmbQZwWT2IqzpdT0wbSsS880pSgetqzaYAHtjIk4Mkfa
         JToumTZX3XGQ6C2oActnfhCwuCAtTl1AUc4X6oC/drkUVICc/iCtvtwAwOvXBtJ1XGXu
         +VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zRT/yA5frCrCnAUP8EGGRX9q0wuQeG8tKy/e8Yo+L4Q=;
        b=CRxgyg1Z8040u0QtNXSUKyEmoGfTiS/b83d7XxDpQWBxPlBNJiWpgf0CC2vWF+tghC
         gsmfBMd/bBxh6Xragxs5frpMWlNyNn4GYw/+ijk6veqI7nOHetuzVREnSbjoLZ9fs8D3
         r7aHyOAZhuIFBl8ZjirVdIUxheRb3Z7t4+bCi9xkG3nic/ZoeC4G6R7l+FFQBQxdGhNL
         Kk6K47pujvF8jwMaBMegHtgW4O4hyB6q7v08C/ZEpKMsd4znN08Iyz2eXGBSdg8tWR6f
         gUuJQ5/In+/NStYXkaiRKi2wSHTC+Wj7MIHepLQsXaDAcyxGBxcs7/wRIGFa2qyAWHF7
         iUXw==
X-Gm-Message-State: AMke39lSPv5X/R1UKl3XhoY3+lsuBBEhCUIAtft9vuaIuDwB87VASeOozZucnLOSnllECtce
X-Received: by 10.99.36.71 with SMTP id k68mr16610225pgk.68.1489097757808;
        Thu, 09 Mar 2017 14:15:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id 78sm14290035pfm.122.2017.03.09.14.15.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:15:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 01/17] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Thu,  9 Mar 2017 14:15:27 -0800
Message-Id: <20170309221543.15897-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

