Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D52831F4B7
	for <e@80x24.org>; Wed, 21 Aug 2019 03:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfHUDV1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 23:21:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfHUDV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 23:21:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so482988pgc.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4T2f/zvdwttyJH4maH7QIL8Vur4CPQh2l/NyoS3FEY=;
        b=ao6pjbicS186AMeORh/TARalbiV+4K+TEW1btKgtKFpHggrYpSo7xQOVboUleMB9m8
         gAwewAqWlT2H5aoM2nvnXmAyqP3ok6e2Zw2uhQh+pPaIQUCyFvDfR4K2xj0ZNRTyLxf7
         ITB3S5de/d6pDgoNzfU5xqnrDS12EwM6JrQSWYfdrW6oNUOk4LKYtrDTvsZnKHoAa9HL
         A7qJOWLNOEKIIP5xNnBmvs8qIZUWv12LE2dlbVz4uksLLzhB7yLaSSer0Jy43f9nhhSr
         awSMOLWhJUNhJVZIBz1bumGI2G1kIzu6t/V9QXKIQbHmQLwiz/J0A6rHmG0x7b9EEHWr
         kEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4T2f/zvdwttyJH4maH7QIL8Vur4CPQh2l/NyoS3FEY=;
        b=oT9ck6VDAf4ON71fxbCZCJbqcaZ5qwMPE0J/6MrBtHuyxRY8rDTnkaDkrxSGmxiH/b
         AzJAlFQJ/LOo4cMvdrQHYpCLd9gAK48VK+3FrV585bfczkfye6UK4iutrd9mqBaXhyKo
         5dLv+DDLaGu6CH/+0aA94Sv6/L7Xd0PZ+201OCIcS0hfwR77VkwMqBYwkaVnRtgAzz1u
         UDtOFu8qUfubRYMLsbCb9A4A6EojmbrjDlMOO/j7QWfTrr/IEJKnuVrtrUvQOoN+UN1J
         FvfJKutQWYZY0R5rEKUZF+YsqSlKLxH/MMGUY5vDAghnhgPH27dh7C1LfIbHAEKDN28X
         NcRA==
X-Gm-Message-State: APjAAAXPnCR96gHGc18l3uPpdKsJpfkozIqN+EVc1eDBV2iqe5wwvCbc
        fYrNBxu9ErclzC93bsThAs4=
X-Google-Smtp-Source: APXvYqw5W5i6HM0UdT/+aA34VIC1SfKev2rkSR0KPuaQBHm9wIJfjTvfhzAPPiUsPncYxA/SKYFrag==
X-Received: by 2002:a63:d23:: with SMTP id c35mr27361553pgl.376.1566357686055;
        Tue, 20 Aug 2019 20:21:26 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id l4sm1448319pjq.9.2019.08.20.20.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 20:21:25 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v3] unpack-trees.c: distinguish ita files from empty files
Date:   Tue, 20 Aug 2019 20:21:00 -0700
Message-Id: <20190821032100.73917-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190813160353.50018-1-vcnaik94@gmail.com>
References: <20190813160353.50018-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. Several variations of "reset" and "checkout" should
resurrect the file in the index from HEAD. "merge" (non-fast-forward),
"cherry-pick", and "revert" should all fail with an error message. This
patch provides the desired behavior even when the file is empty in HEAD.

Furthermore, "merge --ff-only" should prevent a fast-forward merge if a
file is marked as intent-to-add. This patch provides the desired
behavior even when the file exists with empty contents in the final
commit.

The affected commands all compare two cache entries by calling
unpack-trees.c:same(). Since a cache entry for an ita file and a cache
entry for an empty file have the same oid, if the two files had the same
mode, then the cache entries were previously considered the "same". This
fix checks the intent-to-add bits so if one or both of the cache entries
are marked as ita, then the two cache entries are not considered the
"same".

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
I rewrote the code in same(), as René suggested. Somehow the extra line
slipped through into v2.

As Junio suggested, I'm ignoring the validity check of the CE_CONFLICTED
and CE_INTENT_TO_ADD bits in this patch.

 t/t3030-merge-recursive.sh    | 25 +++++++++++++++---
 t/t3501-revert-cherry-pick.sh | 49 ++++++++++++++++++++++++++++++++++-
 t/t7104-reset-hard.sh         | 11 ++++++++
 t/t7110-reset-merge.sh        | 31 ++++++++++++++++++++++
 t/t7201-co.sh                 | 12 +++++++++
 t/t7607-merge-overwrite.sh    | 23 ++++++++++++++++
 unpack-trees.c                |  2 +-
 7 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..8aebb829a6 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -303,13 +303,32 @@ test_expect_success 'fail if the index has unresolved entries' '
 	git checkout -f "$c1" &&
 
 	test_must_fail git merge "$c5" &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail git merge "$c5" 2>out &&
 	test_i18ngrep "not possible because you have unmerged files" out &&
 	git add -u &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail git merge "$c5" 2>out &&
 	test_i18ngrep "You have not concluded your merge" out &&
 	rm -f .git/MERGE_HEAD &&
-	test_must_fail git merge "$c5" 2> out &&
+	test_must_fail git merge "$c5" 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out
+'
+
+test_expect_success 'fail if a deleted intent-to-add file exists in the index' '
+	git checkout -f "$c1" &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached nonempty &&
+	git add -N nonempty &&
+	test_must_fail git merge "$c5" 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out &&
+	git checkout -f "$c1" &&
+	>empty &&
+	git add empty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached empty &&
+	git add -N empty &&
+	test_must_fail git merge "$c5" 2>out &&
 	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out
 '
 
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index d1c68af8c5..45d816fc0c 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -91,16 +91,63 @@ test_expect_success 'cherry-pick on stat-dirty working tree' '
 	)
 '
 
-test_expect_success 'revert forbidden on dirty working tree' '
+test_expect_success 'cherry-pick forbidden on dirty working tree' '
 
+	git checkout -b temp &&
 	echo content >extra_file &&
 	git add extra_file &&
+	test_must_fail git cherry-pick rename2 2>errors &&
+	test_i18ngrep "your local changes would be overwritten by " errors
+
+'
+
+test_expect_success 'revert forbidden on dirty working tree' '
+
 	test_must_fail git revert HEAD 2>errors &&
 	test_i18ngrep "your local changes would be overwritten by " errors
 
 '
 
+test_expect_success 'cherry-pick fails if a deleted intent-to-add file exists in the index' '
+	git reset --hard rename1 &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached nonempty &&
+	git add -N nonempty &&
+	test_must_fail git cherry-pick rename2 2>errors &&
+	test_i18ngrep "overwritten" errors &&
+	git reset --hard rename1 &&
+	>empty &&
+	git add empty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached empty &&
+	git add -N empty &&
+	test_must_fail git cherry-pick rename2 2>errors &&
+	test_i18ngrep "overwritten" errors
+'
+
+test_expect_success 'revert fails if a deleted intent-to-add file exists in the index' '
+	git reset --hard rename1 &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached nonempty &&
+	git add -N nonempty &&
+	test_must_fail git revert rename2 2>errors &&
+	test_i18ngrep "overwritten" errors &&
+	git reset --hard rename1 &&
+	>empty &&
+	git add empty &&
+	git commit -m "create file to be deleted" &&
+	git rm --cached empty &&
+	git add -N empty &&
+	test_must_fail git revert rename2 2>errors &&
+	test_i18ngrep "overwritten" errors
+'
+
 test_expect_success 'cherry-pick on unborn branch' '
+	git checkout -f rename1 &&
 	git checkout --orphan unborn &&
 	git rm --cached -r . &&
 	rm -rf * &&
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index 16faa07813..96a0b779e7 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -43,4 +43,15 @@ test_expect_success 'reset --hard did not corrupt index or cached-tree' '
 
 '
 
+test_expect_success 'reset --hard adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git reset --hard &&
+	git diff --cached --exit-code nonempty empty
+'
+
 test_done
diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index a82a07a04a..3346759375 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -292,4 +292,35 @@ test_expect_success '--keep fails with added/deleted merge' '
     test_i18ngrep "middle of a merge" err.log
 '
 
+test_expect_success 'reset --merge adds deleted intent-to-add file back to index' '
+    git reset --hard initial &&
+    echo "nonempty" >nonempty &&
+    git add nonempty &&
+    git commit -m "create file to be deleted" &&
+    git rm --cached nonempty &&
+    git add -N nonempty &&
+    test_must_fail git reset --merge HEAD 2>err.log &&
+    grep nonempty err.log | grep "not uptodate" &&
+    git reset --hard initial &&
+    >empty &&
+    git add empty &&
+    git commit -m "create file to be deleted" &&
+    git rm --cached empty &&
+    git add -N empty &&
+    test_must_fail git reset --merge HEAD 2>err.log &&
+    grep empty err.log | grep "not uptodate"
+'
+
+test_expect_success 'reset --keep adds deleted intent-to-add file back to index' '
+    git reset --hard initial &&
+    echo "nonempty" >nonempty &&
+    >empty &&
+    git add nonempty empty &&
+    git commit -m "create files to be deleted" &&
+    git rm --cached nonempty empty &&
+    git add -N nonempty empty &&
+    git reset --keep HEAD &&
+    git diff --cached --exit-code nonempty empty
+'
+
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 5990299fc9..4c0c33ce33 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -674,4 +674,16 @@ test_expect_success 'custom merge driver with checkout -m' '
 	test_cmp expect arm
 '
 
+test_expect_success 'checkout -f HEAD adds deleted intent-to-add file back to index' '
+	git reset --hard master &&
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git checkout -f HEAD &&
+	git diff --cached --exit-code nonempty empty
+'
+
 test_done
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index dd8ab7ede1..7e6b7b9a07 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -20,6 +20,16 @@ test_expect_success 'setup' '
 	git add sub/f sub2/f &&
 	git commit -m sub &&
 	git tag sub &&
+	git reset --hard c0 &&
+	echo "nonempty" >nonempty &&
+	git add nonempty &&
+	git commit -m nonempty &&
+	git tag nonempty &&
+	git reset --hard c0 &&
+	>empty &&
+	git add empty &&
+	git commit -m empty &&
+	git tag empty &&
 	echo "VERY IMPORTANT CHANGES" > important
 '
 
@@ -192,4 +202,17 @@ test_expect_success 'will not clobber WT/index when merging into unborn' '
 	grep bar untracked-file
 '
 
+test_expect_success 'will not overwrite ita file on fast-forward merge' '
+	git reset --hard c0 &&
+	>nonempty &&
+	git add -N nonempty &&
+	test_must_fail git merge --ff-only nonempty 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out &&
+	git reset --hard c0 &&
+	>empty &&
+	git add -N empty &&
+	test_must_fail git merge --ff-only empty 2>out &&
+	test_i18ngrep "Your local changes to the following files would be overwritten by merge:" out
+'
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 50189909b8..8d974667f2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1658,7 +1658,7 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
 		return 0;
 	if (!a && !b)
 		return 1;
-	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
+	if ((a->ce_flags | b->ce_flags) & (CE_CONFLICTED | CE_INTENT_TO_ADD))
 		return 0;
 	return a->ce_mode == b->ce_mode &&
 	       oideq(&a->oid, &b->oid);
-- 
2.23.0

