Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680A62022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbdBWXET (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:04:19 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36076 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbdBWXES (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:04:18 -0500
Received: by mail-pg0-f49.google.com with SMTP id s67so2256401pgb.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yZHJFaNPRhLylKLZvG+5VYnQ1zMzYJlM5TvicAJHtJo=;
        b=PjGAS8MIz5tMXg+2ivxWshvEPND/j3Ui3mCRHqGld4oPTvgUGddpHZrzRtXfnPBdDq
         R8w48Ytjk9EkKV1hZEh4nvLM4CSt5G+JRWbklKTcVeIBBFONPsp9w8HJoJCLKmmkUpVc
         zq1j45EF0CRiVQ5SBg18h1SiWWiHJ3aVRV/iFB9nlPBHDLt0UXag79NlAovLX2Dijuc0
         O04T+1571Ye+tVqxcp+R3OZxMSnz9XcYyY0dm+R+8XLS7CccXLsrKXsDBSwscIwEsYaW
         TUFBoGYn/1y9H8Y9z1LxqVDh8R9U2C4CO9Ji5F2zv23v76MPyoDo+wF7Yoq7hqgkzwag
         ShoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yZHJFaNPRhLylKLZvG+5VYnQ1zMzYJlM5TvicAJHtJo=;
        b=m0WKu1O6DgFvY5SU6njPypjDGnQ/k0A7ED+MfB601sEYdMglklZPdo47xhhiC4xc2v
         h98eqrFbI2wn/A9fhqeg4MJUoRK4ULXPX3ZmqY5o9iBRWkcrem1cZT1mQydhcY1i1Vhg
         6WOmTQYXJF99UQIr+iNVdlYdiWm/0zDKIZz9eo0i2JXKHRfo7mjd+I/qrtYhg98XFU3t
         ddb+kCsaCqB77UIyzG65g8kmaLECtxb03+RIv1c8QAQtt0PK6j4j0p9V4vd3HVmGkTyd
         tthMq/Df9BokYfO5PlMd9HdVU+D4PQ5BAYpOOxmK6QnZcnaLdz+XTB9JL8GtooUtfSKb
         y3kg==
X-Gm-Message-State: AMke39nnxCJRyhA+p5Lgfc7DZiyx73ynalLu7Wp9Ta9/WE3ow3VP/i+SOSl6dmoCta/r0am4
X-Received: by 10.98.215.70 with SMTP id v6mr48926080pfl.141.1487890672851;
        Thu, 23 Feb 2017 14:57:52 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:ad75:dfc7:8a6:1152])
        by smtp.gmail.com with ESMTPSA id x30sm11604873pgc.67.2017.02.23.14.57.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 14:57:52 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        novalis@novalis.org
Subject: [PATCH 01/15] lib-submodule-update.sh: reorder create_lib_submodule_repo
Date:   Thu, 23 Feb 2017 14:57:21 -0800
Message-Id: <20170223225735.10994-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170223225735.10994-1-sbeller@google.com>
References: <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com>
 <20170223225735.10994-1-sbeller@google.com>
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

