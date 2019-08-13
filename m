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
	by dcvr.yhbt.net (Postfix) with ESMTP id D156C1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 16:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfHMQEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 12:04:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36890 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfHMQEv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 12:04:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id d1so18670664pgp.4
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORadnCQhLIxz4oQK9EsQ9JzKf1asVGT59Shz+uTNJ+M=;
        b=C1RLY3qJdVKlo48saphmtI2JuBV4bVqbX3AGP9ekdt1SLz0F4iZI5zkg2OMSanYNQR
         KiQBVvXUokaducicrUuM5gAhHRNI7cGqAb+wnkX2zGggDi1MA7Ie+jJUN5NUOmg4WG58
         da337ip2Utn3E5rqSrxq1dIEqXiPlLRk/NgTSqnQSKli2xTAZu3vXrdsqZjY3nzQiOec
         iiNXbP2+LaIdQMydISaC0xzg4NLeJfyEu5WKQFPqQeTQ+/MGXRyv/KnYHdEP+ygslGaK
         wswlcFkaekflTnLO+aaOw0Zx9aSLrFPaJmBP9dOg8XOGwTkY4eWgg77D9Of2cIJLzAdv
         rJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ORadnCQhLIxz4oQK9EsQ9JzKf1asVGT59Shz+uTNJ+M=;
        b=i+Ld9sxtRvkAgsKseIguUqE3GMagAMdx+N4eCnrga6nG6qy3edFEr2f2e1XeRrXpP+
         RAjrrpT29LOIq3FdFZ2fD5ZZsH2hct7Nr75B9SrTRnVm7/sGUJaTnhmJtQKLpWX7fk4u
         LyaU7IwfrN0u607u9VJ9TpO1+FeQ7sPXtm903CM4kyac/1SWHbnYUk2aSyqfulVpFLaz
         AQTBGmwpwfxqkXNdoG7czIB9oqf1YlBkzCrBAo/t0pgrfHUb0zUCb94cgOArrG0avNuH
         eMK9xzFx/Yu4zMJx7tcO/BZvVGjnrBIydYOtskQ7+kDIkzwJ6LbSz/EoODVGj0NTT/QF
         u7aA==
X-Gm-Message-State: APjAAAW3kBucBFBPDf1heXWEi90P7FJobb3eZqpjmUu5GV66xM4HhxV8
        GsgJfmjUM60arDDEoJov6pKh1HLVvbE=
X-Google-Smtp-Source: APXvYqwDTZ1jbP2RGMa5g7Fu8dXy9iC1iJPxz5zaZCCnw8c0MzGso+dlCFJzc2SrVNFcsisVBzlYew==
X-Received: by 2002:a17:90a:fa82:: with SMTP id cu2mr1634055pjb.85.1565712290201;
        Tue, 13 Aug 2019 09:04:50 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id d2sm1827439pjs.21.2019.08.13.09.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 09:04:49 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org
Subject: [RFC PATCH] unpack-trees.c: handle empty deleted ita files
Date:   Tue, 13 Aug 2019 09:03:53 -0700
Message-Id: <20190813160353.50018-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. Several variations of "reset" and "checkout" should
resurrect the file in the index from HEAD. "merge", "cherry-pick", and
"revert" should all fail with an error message. This patch provides the
desired behavior even when the file is empty in HEAD.

The affected commands all compare two cache entries by calling
unpack-trees.c:same(). A cache entry for an ita file and a cache entry
for an empty file have the same oid. So, the cache entry for an empty
deleted ita file was previously considered the "same" as the cache entry
for an empty file. This fix adds a comparison of the intent-to-add bits
so that the two cache entries are no longer considered the "same".

Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
I am marking this patch as RFC because it is changing code deep in
unpack-trees.c, and I'm sure it will generate some controversy :)

The affected "reset" and "checkout" commands call
unpack-trees.c:oneway_merge(), which calls same(). The affected "merge",
"cherry-pick", and "revert" commands call
unpack-trees.c:threeway_merge(), which calls same(). "stash" also calls
oneway_merge(), and "rebase" also calls threeway_merge(), but they are
not included in the test cases because their behaviors have not changed.

The new tests are not comprehensive. In particular, they don't call
plumbing commands, such as "read-tree". But hopefully they provide
enough coverage to prevent most regressions.

The new test cases for "cherry-pick" and "revert" grep for the single
word "overwritten" rather than a more precise error message because the
error message for an empty deleted ita file changes slightly if the
patch in [0] is also applied. In retrospect, the commands affected by
[0], [1], and this patch were all intertwined, and it would have been
better to create a single large patch instead of three smaller patches.

[0]: https://public-inbox.org/git/20190801161558.12838-1-vcnaik94@gmail.com/
[1]: https://public-inbox.org/git/20190802162852.14498-1-vcnaik94@gmail.com/

 t/t3030-merge-recursive.sh    | 25 +++++++++++++++---
 t/t3501-revert-cherry-pick.sh | 49 ++++++++++++++++++++++++++++++++++-
 t/t7104-reset-hard.sh         | 11 ++++++++
 t/t7110-reset-merge.sh        | 31 ++++++++++++++++++++++
 t/t7201-co.sh                 | 12 +++++++++
 unpack-trees.c                |  1 +
 6 files changed, 125 insertions(+), 4 deletions(-)

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
diff --git a/unpack-trees.c b/unpack-trees.c
index 50189909b8..9b7e6b01c4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1661,6 +1661,7 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
 	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
 		return 0;
 	return a->ce_mode == b->ce_mode &&
+	       !ce_intent_to_add(a) == !ce_intent_to_add(b) &&
 	       oideq(&a->oid, &b->oid);
 }
 
-- 
2.22.0

