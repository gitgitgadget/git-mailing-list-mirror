Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D200C433FE
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357533AbiCPUNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356184AbiCPUNV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:13:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865846E37D
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u10so4514212wra.9
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y3kmhBiIfQZuWnSQxBg2UxN/8HabZZOuizQ279yE4JQ=;
        b=ZpMq/UL5IoLNSLEbJPSPSa074BJcdzh70WglYJUUr8wM38GhqBaoqCjioMCVt9rO6u
         vAZTt40SnXfesNBIvbAocOJfW5yVNak09sHkJZQ3JgBarYqrzGwHSe93FUozfLbIW1w6
         dbniFAuOuHli/3Gn+eDd6XoYrNFhSVDwcm3w2cELvW8UW1YXJqPGldovPRPOGSUqJXSS
         zlu4GjHooZh4mNi8mLjUtW3XQ4FA3pHlxSH9iqu5BR5ubsTeCNJRBiDRECS3h/RRu5Kx
         HR+TOsG9l3Ww+1QZ4BdKgyW6wT2wA9lnxw/izXWD2l/gljyTIamDTsjUBR1UcMSRycYg
         lVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y3kmhBiIfQZuWnSQxBg2UxN/8HabZZOuizQ279yE4JQ=;
        b=wOongBG3RZP/aGbD7ocxn5WsUlQAoHfuBUmFsBBPkO7GWwsFmreMTjZLUsKoaIKStu
         pJjbWRTgpaRO7dkPLRbonODh2lnrhJ2JdwBh5iZsfqjdeMtzk2PZ3AR2rCVqtQh1dnpK
         biD/Z3BnSJJngUsTde72urXyKjQ+5FQHrvkNQ7I5OWodC0ds+QlQDvPjLPt8dSE6tFey
         xMo250cmcMdqSFvpoxcLFTwzNgP94gbnlr8H8koNaU+wxnv9MIF++hsokcEvw2zhBnCQ
         GhIQ3vaigN1/JFDM4ji75iX3PLFAbKMrscpZxAH5/S8Yc8upFvriY6uQnypT0kCnJxPB
         8xgA==
X-Gm-Message-State: AOAM533nBQnh/mwM0boADU3hMxKnhHyNCv7aQ0kUP9NYYKwAE4uknLDn
        WeYC2rkgmwZmcPjaOW8xcqvULiaRdaw=
X-Google-Smtp-Source: ABdhPJzJxrwUk638F5AYO0Tx4XjlOo+LtgI6iz4OkeOKBoLNgqi0/AvRimtpE62+pNLBxak2nm0jOg==
X-Received: by 2002:adf:90e2:0:b0:1e3:f5a:553c with SMTP id i89-20020adf90e2000000b001e30f5a553cmr1220415wri.476.1647461524899;
        Wed, 16 Mar 2022 13:12:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r1-20020a5d4941000000b001ed89dcacbbsm2419085wrs.23.2022.03.16.13.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 13:12:04 -0700 (PDT)
Message-Id: <726b947bcbfa8ff10dba0241460cbf1a0cbcd7e4.1647461522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 20:12:00 +0000
Subject: [PATCH 1/3] t1092: add sparse directory before cone in test repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a sparse directory 'before/' containing files 'a' and 'b' to the test
repo used in 't/t1092-sparse-checkout-compatibility.sh'. This is meant to
ensure that no sparse index integrations rely on the in-cone path(s) being
lexicographically first in the repo.

Unfortunately, some existing tests do not handle this repo architecture
properly:

* 'add outside sparse cone'
* 'status/add: outside sparse cone'
* 'reset with pathspecs inside sparse definition'

All three of these are due to the incorrect handling of the
'unpack_trees_options.cache_bottom' when performing a cache diff via
'unpack_trees'. This will be corrected in a future patch; in the meantime,
mark the tests with 'test_expect_failure'.

Finally, update the 'ls-files' test to include the 'before/' directory in
its expected results.

Co-authored-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 2a04b532f91..11141221b4d 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -16,7 +16,9 @@ test_expect_success 'setup' '
 		echo "after deep" >e &&
 		echo "after folder1" >g &&
 		echo "after x" >z &&
-		mkdir folder1 folder2 deep x &&
+		mkdir folder1 folder2 deep before x &&
+		echo "before deep" >before/a &&
+		echo "before deep again" >before/b &&
 		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
 		mkdir deep/deeper1/deepest2 &&
@@ -312,7 +314,7 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
-test_expect_success 'add outside sparse cone' '
+test_expect_failure 'add outside sparse cone' '
 	init_repos &&
 
 	run_on_sparse mkdir folder1 &&
@@ -354,7 +356,7 @@ test_expect_success 'commit including unstaged changes' '
 	test_all_match git status --porcelain=v2
 '
 
-test_expect_success 'status/add: outside sparse cone' '
+test_expect_failure 'status/add: outside sparse cone' '
 	init_repos &&
 
 	# folder1 is at HEAD, but outside the sparse cone
@@ -565,7 +567,7 @@ test_expect_success 'checkout and reset (keep)' '
 	test_all_match test_must_fail git reset --keep deepest
 '
 
-test_expect_success 'reset with pathspecs inside sparse definition' '
+test_expect_failure 'reset with pathspecs inside sparse definition' '
 	init_repos &&
 
 	write_script edit-contents <<-\EOF &&
@@ -1311,6 +1313,7 @@ test_expect_success 'ls-files' '
 
 	cat >expect <<-\EOF &&
 	a
+	before/
 	deep/
 	e
 	folder1-
@@ -1358,6 +1361,7 @@ test_expect_success 'ls-files' '
 
 	cat >expect <<-\EOF &&
 	a
+	before/
 	deep/
 	e
 	folder1-
-- 
gitgitgadget

