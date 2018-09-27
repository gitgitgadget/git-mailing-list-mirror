Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682531F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeI1AcC (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 20:32:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36685 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1AcC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 20:32:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id b7-v6so2477036pfo.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 11:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnEzTj3QvcPDjNdkfw5OZmq0mhCHXnayvh9HGf5dREk=;
        b=eIoqIGcMhdvPhlsddDyJSe8q0WRcSYhOWBGVfjzRytC5Gz94m0v/+zLoeYo/4SbteV
         XEAEc1UVvemJkULK4HdC0ztXYK5Dat3jlywzHATMJ/hH/G8hN3Y4QG31tVx8YXOnL0+E
         zid3rYquKyUOrFBrBLBPlaLtHz+OVo1ONdu0N1jUHx+tHGwIuLAWM7mHGK7zNssVT5rf
         NFHe9JZuB2OJ15dio5Gw5sosHBDYv6zR0MGey6J8ss5UXMb3Iro7D7VBy6H04cPF0Jia
         zbGSByktNhI7oTQzduUrQT5oZVrSn/3PpCVxhicadY5FWZrl/RfJk4tYcs4OdKaykEme
         L3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qnEzTj3QvcPDjNdkfw5OZmq0mhCHXnayvh9HGf5dREk=;
        b=LV62SW9SYsoDth2bolHATdHJh7G5G6K/maNTI7C86geUi/aVDku0GgsNac95nli/8D
         RxhkLCSLxmoRMEJgV21iiOf9FMGVvdsUyke2S/3xhfvuTOsXsx/EWK3umzpAkPseQi9j
         nGthSCXQ0ESH0xuL2FwqAXgPR/UVDcepywyuD/xyunmcZjcArlxtMOmz/9k0dxJ7G7cQ
         Vhe4ZdTCfxcHVg1xNaQfyAeK4tpeFDF+zcxVkuAPWpzGF/OwG+QvgDPvAYBBztolw5YO
         ef6/M5dot1he47od8/reHOjDDvrhRc9eMN8VOk/J0DB7iVAVdWCtM1aupsTU9rQAAPAO
         FLKQ==
X-Gm-Message-State: ABuFfoj1ZJBnl+4PxtTuyHeBNabudwTWwPIEkUz/FcIMl4RQwkyyYbob
        mJux6PFuBVXBkTJQtK22WA8q0EaR
X-Google-Smtp-Source: ACcGV60WLeRhL7uNA3kUElBpPnI2Xm43v6negElEg+AKGjvPosDJnoJz6R9T/LhDgeI5QKRb4s+uUQ==
X-Received: by 2002:a17:902:a413:: with SMTP id p19-v6mr12264922plq.220.1538071952524;
        Thu, 27 Sep 2018 11:12:32 -0700 (PDT)
Received: from localhost.localdomain (hq.xevo.com. [4.14.243.50])
        by smtp.googlemail.com with ESMTPSA id r25-v6sm3537725pgm.59.2018.09.27.11.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:12:31 -0700 (PDT)
From:   Sam McKelvie <sammck@gmail.com>
To:     sammck@gmail.com, git@vger.kernel.org
Subject: [PATCH] submodule: Alllow staged changes for get_superproject_working_tree
Date:   Thu, 27 Sep 2018 11:10:54 -0700
Message-Id: <20180927181054.25802-1-sammck@gmail.com>
X-Mailer: git-send-email 2.19.0.606.g67c3761e7
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Invoking 'git rev-parse --show-superproject-working-tree' exits with

    "fatal: BUG: returned path string doesn't match cwd?"

when the superproject has an unmerged entry for the current submodule,
instead of displaying the superproject's working tree.

The problem is due to the fact that when a merge of the submodule reference
is in progress, "git ls-files --stage —full-name <submodule-relative-path>”
returns three seperate entries for the submodule (one for each stage) rather
than a single entry; e.g.,

$ git ls-files --stage --full-name submodule-child-test
160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       submodule-child-test
160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       submodule-child-test
160000 e6178f3a58b958543952e12824aa2106d560f21d 3       submodule-child-test

The code in get_superproject_working_tree() expected exactly one entry to
be returned; this patch makes it use the first entry if multiple entries
are returned.

Test t1500-rev-parse is extended to cover this case.

Signed-off-by: Sam McKelvie <sammck@gmail.com>
---
 submodule.c          |  2 +-
 t/t1500-rev-parse.sh | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index 33de6ee5f..5b9d5ad7e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1885,7 +1885,7 @@ const char *get_superproject_working_tree(void)
 		 * We're only interested in the name after the tab.
 		 */
 		super_sub = strchr(sb.buf, '\t') + 1;
-		super_sub_len = sb.buf + sb.len - super_sub - 1;
+		super_sub_len = strlen(super_sub);
 
 		if (super_sub_len > cwd_len ||
 		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 5c715fe2c..b774cafc5 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -134,7 +134,6 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
 test_expect_success 'showing the superproject correctly' '
 	git rev-parse --show-superproject-working-tree >out &&
 	test_must_be_empty out &&
-
 	test_create_repo super &&
 	test_commit -C super test_commit &&
 	test_create_repo sub &&
@@ -142,6 +141,22 @@ test_expect_success 'showing the superproject correctly' '
 	git -C super submodule add ../sub dir/sub &&
 	echo $(pwd)/super >expect  &&
 	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
+	test_cmp expect out &&
+	test_commit -C super submodule_add &&
+	git -C super checkout -b branch1 &&
+	git -C super/dir/sub checkout -b branch1 &&
+	test_commit -C super/dir/sub branch1_commit &&
+	git -C super add dir/sub &&
+	test_commit -C super branch1_commit &&
+	git -C super checkout master &&
+	git -C super checkout -b branch2 &&
+	git -C super/dir/sub checkout master &&
+	git -C super/dir/sub checkout -b branch2 &&
+	test_commit -C super/dir/sub branch2_commit &&
+	git -C super add dir/sub &&
+	test_commit -C super branch2_commit &&
+	test_must_fail git -C super merge branch1 &&
+	git -C super/dir/sub rev-parse --show-superproject-working-tree >out &&
 	test_cmp expect out
 '
 
-- 
2.17.1

