Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC5FC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6917C21D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6hj7o9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgIYRDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIYRDS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E066C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:18 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l71so3114674pge.4
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5w0xbVu+QDOUf8+PXLyGTgd8PzAwCFtfEinbJhY9xu4=;
        b=W6hj7o9fUsIAKyiop+H1Is8FCSQ9yh2smj+3jEVH/UllOeDh4+JmbCELPwrDNKRg8G
         BsEJP3BRj8dRaDoz7Tm0tlW/QdDDFAvAr7RWQLVJhcF+flnqbWHgq6aL52q+y8UDKGOS
         ua/zQS8AGc13YiPcL3P8sMw9mK999F5WPHPK8SbRqNrjHR28qdgZgfXZuzFqWsB2em9k
         O9VuGIticDi90ScJhMrq7OG5o9dNY4E07Pkwu6vyRLucjBLPsUl14ByvEw0hF2aia9ji
         WOUIY/uobJabZpj5ckaQYhf1q19E7u5FvPIqwQhLBD6CVlCBfiVrVEvWv0UyYpwDiBjp
         2y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5w0xbVu+QDOUf8+PXLyGTgd8PzAwCFtfEinbJhY9xu4=;
        b=Ajr1hiYainjrqMZjNLq+aulE02nvsa6uaTGJ1q6MczHD5pGs721L6rLNWWMYKkL1uo
         mCu4EsSLHe9TE0BqFjodXj2A1tZerLXz4Sm/w+Zk1cRI7N8Y8G/Mj9dZ2DZK+r35248e
         G3Cxm34LP8eeR/6nLIvJjVvCysmx/SkkCYZvrWreyVhka8FiKsELVidgwtKhyQl6uEOD
         wUwpA9BdxL6nf12tEVzhjKl+b3dJIUEE3jTXwpNy9HuqA4wZJyrYUad/IFMldgbDZYDR
         TGvKoSPhFbAOh9526N8/ZPHfkWMwxZFt1Jz6gYuY8G2fygoNwEbIdlbfY7OFlcrsk4F7
         Pkjg==
X-Gm-Message-State: AOAM532odHaWc7x/fLwMLLj4OoqStU4vFpV4/dBGb6ydt1CWfLvJ2lCF
        b33X/7A8gZIwWXp1oGQgxyy/fTnfXShuJQ==
X-Google-Smtp-Source: ABdhPJwc/jXcnMcTJBRDX7B6dBAv43pcV1djwlRozTvhPuN+b7yiwlVne3EHRq3rsvP4eI3vucDAEw==
X-Received: by 2002:a17:902:9041:b029:d0:cc02:8540 with SMTP id w1-20020a1709029041b02900d0cc028540mr292780plz.41.1601053397582;
        Fri, 25 Sep 2020 10:03:17 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:17 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Cc:     Shubham Verma <shubhunic@gmail.com>
Subject: [PATCH 02/11] t7001: use TAB instead of spaces
Date:   Fri, 25 Sep 2020 22:32:47 +0530
Message-Id: <20200925170256.11490-3-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
References: <20200925170256.11490-1-shubhunic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Shubham Verma <shubhunic@gmail.com>

Change indentation style from spaces to TAB.

Signed-off-by: shubham verma <shubhunic@gmail.com>
---
 t/t7001-mv.sh | 120 +++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 4bbb51e578..7503233814 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -4,72 +4,72 @@ test_description='git mv in subdirs'
 . ./test-lib.sh
 
 test_expect_success 'prepare reference tree' '
-     mkdir path0 path1 &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
-     git add path0/COPYING &&
-     git commit -m add -a
+	mkdir path0 path1 &&
+	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+	git add path0/COPYING &&
+	git commit -m add -a
 '
 
 test_expect_success 'moving the file out of subdirectory' '
-     cd path0 && git mv COPYING ../path1/COPYING
+	cd path0 && git mv COPYING ../path1/COPYING
 '
 
 # in path0 currently
 test_expect_success 'commiting the change' '
-     cd .. && git commit -m move-out -a
+	cd .. && git commit -m move-out -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path0/COPYING..*path1/COPYING" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path0/COPYING..*path1/COPYING" actual
 '
 
 test_expect_success 'moving the file back into subdirectory' '
-     cd path0 && git mv ../path1/COPYING COPYING
+	cd path0 && git mv ../path1/COPYING COPYING
 '
 
 # in path0 currently
 test_expect_success 'commiting the change' '
-     cd .. && git commit -m move-in -a
+	cd .. && git commit -m move-in -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path1/COPYING..*path0/COPYING" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path1/COPYING..*path0/COPYING" actual
 '
 
 test_expect_success 'mv --dry-run does not move file' '
-     git mv -n path0/COPYING MOVED &&
-     test -f path0/COPYING &&
-     test ! -f MOVED
+	git mv -n path0/COPYING MOVED &&
+	test -f path0/COPYING &&
+	test ! -f MOVED
 '
 
 test_expect_success 'checking -k on non-existing file' '
-     git mv -k idontexist path0
+	git mv -k idontexist path0
 '
 
 test_expect_success 'checking -k on untracked file' '
-     touch untracked1 &&
-     git mv -k untracked1 path0 &&
-     test -f untracked1 &&
-     test ! -f path0/untracked1
+	touch untracked1 &&
+	git mv -k untracked1 path0 &&
+	test -f untracked1 &&
+	test ! -f path0/untracked1
 '
 
 test_expect_success 'checking -k on multiple untracked files' '
-     touch untracked2 &&
-     git mv -k untracked1 untracked2 path0 &&
-     test -f untracked1 &&
-     test -f untracked2 &&
-     test ! -f path0/untracked1 &&
-     test ! -f path0/untracked2
+	touch untracked2 &&
+	git mv -k untracked1 untracked2 path0 &&
+	test -f untracked1 &&
+	test -f untracked2 &&
+	test ! -f path0/untracked1 &&
+	test ! -f path0/untracked2
 '
 
 test_expect_success 'checking -f on untracked file with existing target' '
-     touch path0/untracked1 &&
-     test_must_fail git mv -f untracked1 path0 &&
-     test ! -f .git/index.lock &&
-     test -f untracked1 &&
-     test -f path0/untracked1
+	touch path0/untracked1 &&
+	test_must_fail git mv -f untracked1 path0 &&
+	test ! -f .git/index.lock &&
+	test -f untracked1 &&
+	test -f path0/untracked1
 '
 
 # clean up the mess in case bad things happen
@@ -79,77 +79,77 @@ rm -f idontexist untracked1 untracked2 \
 rmdir path1
 
 test_expect_success 'moving to absent target with trailing slash' '
-     test_must_fail git mv path0/COPYING no-such-dir/ &&
-     test_must_fail git mv path0/COPYING no-such-dir// &&
-     git mv path0/ no-such-dir/ &&
-     test_path_is_dir no-such-dir
+	test_must_fail git mv path0/COPYING no-such-dir/ &&
+	test_must_fail git mv path0/COPYING no-such-dir// &&
+	git mv path0/ no-such-dir/ &&
+	test_path_is_dir no-such-dir
 '
 
 test_expect_success 'clean up' '
-     git reset --hard
+	git reset --hard
 '
 
 test_expect_success 'moving to existing untracked target with trailing slash' '
-     mkdir path1 &&
-     git mv path0/ path1/ &&
-     test_path_is_dir path1/path0/
+	mkdir path1 &&
+	git mv path0/ path1/ &&
+	test_path_is_dir path1/path0/
 '
 
 test_expect_success 'moving to existing tracked target with trailing slash' '
-     mkdir path2 &&
-     >path2/file && git add path2/file &&
-     git mv path1/path0/ path2/ &&
-     test_path_is_dir path2/path0/
+	mkdir path2 &&
+	>path2/file && git add path2/file &&
+	git mv path1/path0/ path2/ &&
+	test_path_is_dir path2/path0/
 '
 
 test_expect_success 'clean up' '
-     git reset --hard
+	git reset --hard
 '
 
 test_expect_success 'adding another file' '
-     cp "$TEST_DIRECTORY"/../README.md path0/README &&
-     git add path0/README &&
-     git commit -m add2 -a
+	cp "$TEST_DIRECTORY"/../README.md path0/README &&
+	git add path0/README &&
+	git commit -m add2 -a
 '
 
 test_expect_success 'moving whole subdirectory' '
-     git mv path0 path2
+	git mv path0 path2
 '
 
 test_expect_success 'commiting the change' '
-     git commit -m dir-move -a
+	git commit -m dir-move -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
-     grep "^R100..*path0/README..*path2/README" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
+	grep "^R100..*path0/README..*path2/README" actual
 '
 
 test_expect_success 'succeed when source is a prefix of destination' '
-     git mv path2/COPYING path2/COPYING-renamed
+	git mv path2/COPYING path2/COPYING-renamed
 '
 
 test_expect_success 'moving whole subdirectory into subdirectory' '
-     git mv path2 path1
+	git mv path2 path1
 '
 
 test_expect_success 'commiting the change' '
-     git commit -m dir-move -a
+	git commit -m dir-move -a
 '
 
 test_expect_success 'checking the commit' '
-     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
-     grep "^R100..*path2/README..*path1/path2/README" actual
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
+	grep "^R100..*path2/README..*path1/path2/README" actual
 '
 
 test_expect_success 'do not move directory over existing directory' '
-     mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
 '
 
 test_expect_success 'move into "."' '
-     git mv path1/path2/ .
+	git mv path1/path2/ .
 '
 
 test_expect_success "Michael Cassar's test case" '
-- 
2.25.1

