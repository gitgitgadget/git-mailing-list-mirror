Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6612013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751362AbdBOAfI (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:08 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:37506 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdBOAfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:06 -0500
Received: by mail-it0-f53.google.com with SMTP id x75so54903902itb.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pw2AumVUgTzrRQi8ep1rjSIrCIjf1VyybORx+84kyD0=;
        b=CqGiwwZpLmVU9l9iZZz1ey/BZjpCy3kFn1f6fmEQMgORHhecbSGGvuc1gG2ZFzABi9
         nYcNypwFlcFh+v7mo/0id1hrXJ6GCUg4/9Tjdp6Rv1bUe3ZrY13ralqiUX/44ui58hzG
         +08y8uT19aoFjhwTL9/TfFUKwCJ7tFkNz8Jch+9VEFu/nA5oH1F0yoPZABngjzNDpsOp
         jXrQD0t0mM+x3UJNwabTxzC1nQGde4NI+G+EzMxmbtfPFyW+tWHEghJnLe137tBOjvMf
         icWVw0oNrig1GzBJE88bewbWLyMIdd1+dP4oOcO6KnzOM/ByxcCYJBjktzWyw0QAds8O
         Mgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pw2AumVUgTzrRQi8ep1rjSIrCIjf1VyybORx+84kyD0=;
        b=SEXjooqaERIu0zBmlg1mJYmo0kMioLp9soL517GEAtRhiaSKSTxBsmenZQ2QnRFo8A
         NNIxGyvxu5S0HZBVP8Z3ksw0godNsyH8QhPipKC3NDYN+voBl4oJnHhS7ARrKsv1d91L
         cnQyQk3Ao+7HYjVu6pICVL8URqKjocGOv1zIEMklDtc5fIhk0oFOQsMf+nleacK4fNaG
         aNdrWHg1KfDsTeFuhyzYttaaLERz1Rd6c3z/mekCMkRZ+XOuSoJpse1VKmeF0Ewbo1gI
         8hQVV5u1zZUdt78RRLqnJwo+COm9XSqX4AkDnplBvXOcl5j5mQFATR4UJonisnyc06Gh
         xLOg==
X-Gm-Message-State: AMke39mT4+ADF1squMOj67RL9+KS64vg1TJTvhWWWq4jY+J2g16s1EvQQxTo2KLbJjdbpCwH
X-Received: by 10.84.136.75 with SMTP id 69mr40338690plk.172.1487118905367;
        Tue, 14 Feb 2017 16:35:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id b74sm3254151pfc.129.2017.02.14.16.35.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 01/14] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Tue, 14 Feb 2017 16:34:10 -0800
Message-Id: <20170215003423.20245-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
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
index 915eb4a7c6..61c54f2098 100755
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
+		git checkout -b remove_sub1 add_sub1&&
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
2.12.0.rc0.16.gd1691994b4.dirty

