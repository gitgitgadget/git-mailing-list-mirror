Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252422023D
	for <e@80x24.org>; Mon, 22 May 2017 19:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761723AbdEVTsT (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:48:19 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:32977 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757889AbdEVTsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:48:13 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so91773063pfh.0
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+COQGR1yT4i/DYcOGRwces/KhaGasPEJQ9YZBof1mdQ=;
        b=TLPjnpnHOtPZ8X4QHF2cmXpGWeEog4xamGlEshvhj1RgTkmUTaw1fdMDYfz10+6fty
         jGdumk3h9HlBaW/xmY9F4heZuyQGg2oonXJMFgb/MW/zhTnBqyn1rzReeJU2RIGz41aZ
         v8kBeO3w9hvVqtq+ZQKqOIy8KdWXKauzTl8YVb3GSypqCCehKTbHZiMVyrMTlebHhCx2
         U3ReHWIH7yxdVGG/i07cbnOu46vxdRalePKMGslnWc5q20SwcZZw/SkFIZCH1fKRkUo4
         w1ka5AXx34cAGbKmizBbdxr14gfOq+oNommmMMyh3MZNR99hiLZsFIS9uWgTGw8ipHVn
         8OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+COQGR1yT4i/DYcOGRwces/KhaGasPEJQ9YZBof1mdQ=;
        b=LTOiO5qaugT+6L4cliN57MWED+yK6ZPj7A20r5QNcWrvm7Pn1FY2DfQYbp7Q6omeHF
         WO7iZleXsITC6OsoYd53M4wrIrI3yV0RNkgWQo9zDT7hOGKqAbNx8/LY91+RTJ/WKlr+
         XU3jy7EA/HjdsNTsmak19EHCDjJ9ldS5/sq9OPRFXeb6z/AqI/SnAOYvGxPrw16rEN0F
         bw4gtaXRbQoPczmW9OjIFU3+GwNATH+5WytRSubshP1KtiLtCvgMyl61tBAkLvJi935t
         +g/RC0Oi/JHDozOnhaszCN5qePGMoNzhKFPEHGfFWk9zt0sKvV+gW3f1AVYSWjiKlFk2
         cWKA==
X-Gm-Message-State: AODbwcDAK6ZI+HKQWvF0mA7BI49GE7N05D7GcNKnrzwcrainXlH7mTKs
        dlrtlFk+Sq04O2WictmI0A==
X-Received: by 10.99.158.17 with SMTP id s17mr22612613pgd.219.1495482492186;
        Mon, 22 May 2017 12:48:12 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id s23sm31062730pfg.81.2017.05.22.12.48.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 12:48:11 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 2/6] submodule test invocation: only pass additional arguments
Date:   Mon, 22 May 2017 12:48:02 -0700
Message-Id: <20170522194806.13568-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170522194806.13568-1-sbeller@google.com>
References: <20170522194806.13568-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh      | 6 ++++--
 t/t1013-read-tree-submodule.sh | 4 ++--
 t/t2013-checkout-submodule.sh  | 4 ++--
 t/t7112-reset-submodule.sh     | 4 ++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index f0b1b18206..0f70b5ec7b 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -782,7 +782,8 @@ test_submodule_forced_switch () {
 #   git directory first into the superproject.
 
 test_submodule_switch_recursing () {
-	command="$1"
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
 	RESULTDS=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
@@ -1022,7 +1023,8 @@ test_submodule_switch_recursing () {
 # that change a submodule, but throwing away local changes in
 # the superproject as well as the submodule is allowed.
 test_submodule_forced_switch_recursing () {
-	command="$1"
+	cmd_args="$1"
+	command="git $cmd_args --recurse-submodules"
 	RESULT=success
 	if test "$KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS" = 1
 	then
diff --git a/t/t1013-read-tree-submodule.sh b/t/t1013-read-tree-submodule.sh
index de1ba02dc5..a779e6917c 100755
--- a/t/t1013-read-tree-submodule.sh
+++ b/t/t1013-read-tree-submodule.sh
@@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing "git read-tree --recurse-submodules -u -m"
+test_submodule_switch_recursing "read-tree -u -m"
 
-test_submodule_forced_switch_recursing "git read-tree --recurse-submodules -u --reset"
+test_submodule_forced_switch_recursing "read-tree -u --reset"
 
 test_submodule_switch "git read-tree -u -m"
 
diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index e8f70b806f..2672f104cf 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -65,9 +65,9 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
-test_submodule_switch_recursing "git checkout --recurse-submodules"
+test_submodule_switch_recursing "checkout"
 
-test_submodule_forced_switch_recursing "git checkout -f --recurse-submodules"
+test_submodule_forced_switch_recursing "checkout -f"
 
 test_submodule_switch "git checkout"
 
diff --git a/t/t7112-reset-submodule.sh b/t/t7112-reset-submodule.sh
index f86ccdf215..a000304221 100755
--- a/t/t7112-reset-submodule.sh
+++ b/t/t7112-reset-submodule.sh
@@ -9,9 +9,9 @@ KNOWN_FAILURE_SUBMODULE_RECURSIVE_NESTED=1
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 KNOWN_FAILURE_SUBMODULE_OVERWRITE_IGNORED_UNTRACKED=1
 
-test_submodule_switch_recursing "git reset --recurse-submodules --keep"
+test_submodule_switch_recursing "reset --keep"
 
-test_submodule_forced_switch_recursing "git reset --hard --recurse-submodules"
+test_submodule_forced_switch_recursing "reset --hard"
 
 test_submodule_switch "git reset --keep"
 
-- 
2.13.0.18.g7d86cc8ba0

