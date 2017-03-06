Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBC520133
	for <e@80x24.org>; Mon,  6 Mar 2017 21:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754601AbdCFVHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 16:07:40 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33625 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbdCFVHg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 16:07:36 -0500
Received: by mail-pg0-f51.google.com with SMTP id 25so70461820pgy.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AXGFFSScq5JoVYWhK5OpMxYN+J30Qsfdsv2+PPns/4=;
        b=HcEKqcG57EDl3XIZnZdK+ngfpxGEl02nP1hfWaWhOxZ5OmjaRJAgCaPWzwtY+WH9GK
         cUcZ4OcbJTsrb81+fe5f0MUvU96GFLvKqEhWBETpZyj2PLmWYQQXE2DsVgaQy7CItTt8
         hCErlTaw1Yh0ls5xM7QSMxFxSVp8tKH5BECXW935Op7BX/z17A2VtMNFjf10tANZCb3x
         86ewskN+WZ1Hw7aEpr40HIqS8mLB2MIU9TMfTCyQ2LppMVMGU8qqcAPuVMOC+mHvTj10
         PK+LQ27dFqSasHVOOitzB1VNCoG8++aFvoEbqjE4AZlLxnvZndGG+rESBnGQmg5Yl1lT
         Y8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AXGFFSScq5JoVYWhK5OpMxYN+J30Qsfdsv2+PPns/4=;
        b=OtyYChZCejystjKUk8r5bq3jJQJkNuutvthrOdvOTMSzOxVhmAm2BdFBqbeR6gbpki
         lfmalXjWSG43JQxs00zrRLIvbW+bsfD/MMyPfyLQk8Nmo6B43qUSFwHEDrp6zwyll0Rm
         GshS2D9MEGEmDrWnh8SJjkknfow2BbI3icC4+eVBFsZNuF+QTt6GIWsCy9ENDxNnqrzv
         BY6buj9W9NDKXmtcfohjibxVEEN5vArQT5nbqbgEopBwnGj0ZQybHp58WRyYU1EQFRFG
         ZY2AFzV17eMh98Layv5CITY/Wvh1v1zlZFTiL1BluUqBzVEf6HJyBR8aCelPemRJGY8G
         DXew==
X-Gm-Message-State: AMke39ngGBDXbJhBVddiJnwpJtANWF485V6GOnUjiXq4CaVPQz4gV23a6x/VL/5Iwi4NbcSF
X-Received: by 10.99.9.65 with SMTP id 62mr23203290pgj.22.1488833965179;
        Mon, 06 Mar 2017 12:59:25 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:44ae:633a:9d1d:6402])
        by smtp.gmail.com with ESMTPSA id d72sm34803119pfb.21.2017.03.06.12.59.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 12:59:24 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 01/18] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Mon,  6 Mar 2017 12:59:02 -0800
Message-Id: <20170306205919.9713-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170306205919.9713-1-sbeller@google.com>
References: <20170302004759.27852-1-sbeller@google.com>
 <20170306205919.9713-1-sbeller@google.com>
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
2.12.0.rc1.52.ge239d7e709.dirty

