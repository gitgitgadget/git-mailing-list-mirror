Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80C520951
	for <e@80x24.org>; Tue, 14 Mar 2017 21:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbdCNVr7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:47:59 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36397 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdCNVqz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:46:55 -0400
Received: by mail-pf0-f179.google.com with SMTP id o126so75979370pfb.3
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M23fks36wROuvFH43IDG7t5HaYj0v+KlgtD2AcJ3VOU=;
        b=upHenU5rPlD4DVUYredioBf3RGofji88LMusxjP6dWu6scwzCPBA6XMsamMv6GdZce
         Her83k3ndvUXb1GQBV+Y6PaHvhE5WaDvRcmtXpeYt2JA8SizMF6q4ZqxWXt5b3Wq4q8S
         RqOZaIulgEN9c1kqMVPfmqUIUJtkvtM0REDPcDFBGFDtQQfa7RLA3ELYIwGV5x1nKeIl
         rLC2b28OOp3Yo5rmXN/wG1onYMt9CsWuSQORPDqkvF4VnJE3H63mmMWHzI43M6WVuWvf
         /nuTrfyTlLEyZQqETHohmv5Gvd9dBAnIQBOJ836S5ixD6PuqvVO5jhlJB9AjbIZqFMWI
         RaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M23fks36wROuvFH43IDG7t5HaYj0v+KlgtD2AcJ3VOU=;
        b=NVVxsZ4DB1+XRlHUhWTZOPJlNpXSl2ADQFygecFCoPdaEC83cVwZO4GtiVPPglp2HO
         QplYAIBsoKPk2xcqzUhFRSv8cPdHBAoVhpci6JaQPGlcZ5WzHXiAnGh4C6r9HX8tQWVI
         KTvSPpN9GIoJGEjZbqqzj8hxhpZ3enP+Z8rh/KcERtU0ol27xHF3c/40sLNyQRB1hV8p
         jfNqSV8UMyeljGTHDh8NeyA55Rm2tFkOeYLI7iL+2iYVDZ651hXzSVrt27Q8u53/KREB
         pMbPSMol9ZZTlC8ES40KtrWQK+n2YcnkTEZjp/TBrtcFnosRJfQsynZDgjnrPnbaXNTo
         /4Pw==
X-Gm-Message-State: AMke39kvMrcvrRF1VMsOtpp2xPCeGTp4PvKMSH1DkA272liBNk/5ZgVJwA4q/m9NnByzTTGs
X-Received: by 10.84.236.67 with SMTP id h3mr58652232pln.12.1489528013540;
        Tue, 14 Mar 2017 14:46:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id q90sm40273682pfk.73.2017.03.14.14.46.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:52 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 03/19] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Tue, 14 Mar 2017 14:46:26 -0700
Message-Id: <20170314214642.7701-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
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
2.12.0.rc1.49.g0cfd38c5f6.dirty

