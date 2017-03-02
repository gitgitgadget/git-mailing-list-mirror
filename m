Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D22232023D
	for <e@80x24.org>; Thu,  2 Mar 2017 03:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbdCBD6o (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 22:58:44 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36812 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbdCBD6m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 22:58:42 -0500
Received: by mail-pf0-f169.google.com with SMTP id x66so17685627pfb.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 19:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AXGFFSScq5JoVYWhK5OpMxYN+J30Qsfdsv2+PPns/4=;
        b=RHySUHPK/nxqkawNdlJ96PuPJmejVAZ3eINOGlOC9QVzGXG2Itix+Z46Z4Go8u1OaR
         Gkc/rZcp9eHfhsU70aF+RVeDFSfcpJ0MKuy/z0XQkW2nmeCIWRcrIgQjejpQrIsReJbT
         TZyjSWb9VPwB1zwWJYqI0MbdyHmaVlmiSFL0BijWbzC1ZpJDxuE6WNiwLDwu87ckvyXb
         ixg96rNrmXT9Ac34ZBRKD9AefdrfGcaA3PBy2/Hlqh/9usVeIy8ISPsZcWrrqkbIAjVH
         ijKURizJFCnJ/yhSKaJJgjqo9S76pgpk3y6AYOuXJiDh3burtdA2zP9Ur+5fNDd1wDgm
         O1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AXGFFSScq5JoVYWhK5OpMxYN+J30Qsfdsv2+PPns/4=;
        b=bbt6fdSOZaLUfb2xzrtZ1EwlpzuQwdVpL4S4ysCQI3+s3645dnQtV8yOKQgOECi0ZT
         tmI3B8Lr6p5rFa8J50bIV52ZkQnaB5AeNzlEjsPDCXFZCnnAlVmx/qDabjuySjdQ732X
         B3p4nNo+NBXNDlix7/vA5YSN+M9uKzuV3NFEH7YmuCLYZ6gcKxT+fPOE03ENMNuG94Hm
         VnIIGjWgXcx2f9MaX93e5/R3epYC/2Mv4BeOYfbhOHwzwB9BuKy/Gp+8DuGdRm9+joQA
         +b+RkPT+K3GTS+M1yb8cwtA+OB518Pl7qeAacVQTimiINVpDiA+Cu6QTdA3UKoycmIj+
         LqPA==
X-Gm-Message-State: AMke39lxgM8EpSpB1weWtAseUODLGOuWM/LRAosJWWfNgx25RTPbP4vS9HanqxBZ0SzBgP+Y
X-Received: by 10.99.116.9 with SMTP id p9mr12097524pgc.74.1488415685461;
        Wed, 01 Mar 2017 16:48:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:695f:c2a1:ec60:5665])
        by smtp.gmail.com with ESMTPSA id o24sm12780143pfj.78.2017.03.01.16.48.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Mar 2017 16:48:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net, gitster@pobox.com,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 01/18] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Wed,  1 Mar 2017 16:47:42 -0800
Message-Id: <20170302004759.27852-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.52.ge239d7e709.dirty
In-Reply-To: <20170302004759.27852-1-sbeller@google.com>
References: <20170223225735.10994-1-sbeller@google.com/>
 <20170302004759.27852-1-sbeller@google.com>
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

