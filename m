Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51FDE20248
	for <e@80x24.org>; Sun,  3 Mar 2019 23:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbfCCXig (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 18:38:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46997 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCCXif (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 18:38:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so1670475pgf.13
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 15:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/KGhHLYyQXfZrvfwhUG5mHd6KrxQx3uemXFG0Y+ks2s=;
        b=YtgoUDUye9QKc1AE8y6FthsKY6Rv7c9Ou/qi/vHsglBNOVQrZ466z7Xme4srqP4k8C
         AvmaH/qAaLtTaA1xO1IFySbEYPnSJh22Vbwgzwx/YU6yGETYtv1LpviRiEVGYmos1shC
         tJgH6GDhTLdSk+abqyyieI4H4vf2xPu4J4SCbegHJktVB+W3UgI63cpucD++BlqssJVa
         AgIjnraPzPTiL8lCmhf40nhNHw8C23D7Z9DhJZnV72VkriHo9DID6wh+QSbCeTJ0Wo1X
         6qhEvXdNXslzmJxP/EIu2McR8hUuw+P7WclP1ozrHHnsNP8GZXRr3EThtYtCniqS+cI5
         4ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/KGhHLYyQXfZrvfwhUG5mHd6KrxQx3uemXFG0Y+ks2s=;
        b=Eot5ne5un3AuCVvVyg95stTyjI71a5XU4pNUnXn5ctGk7me/Rkb+dezXYSLZNzcD85
         1tLIxSSeLFYXLLWSnUDKI3hEU0HSFSAteWffQGDm53/BdQfW4bpauO/bYuaVyJhB6Y/m
         Hwuq/s0eIYrOaAWNsHjWlVZXuYhK6uTzrd6hgcxHgwpO9inP6WASKpfr8YWuxljJufZR
         4OK5I+U/eklNu79rbjXve0EsMfxN17DD/zUrbBLqqnC5okYPVym9V16ThGG2ikrwWzl3
         ZM1sKeHL7fqHB/6D9Adcpn6d6kB1p7+gxggbLamY1W3wbcz+8dqFvEFYoj/kHNiTxk0T
         uSYQ==
X-Gm-Message-State: APjAAAXOgpBBMdVmPh4YsO3BUZr3quTyGAErMkvyEKrNScKfsg/Xems4
        5vD2CZ4D4OtmtGAEwWHUNYo=
X-Google-Smtp-Source: APXvYqyiOBSMFSYQXgNhG6NjLKRlC8acHcNPK5j3YOhXeHyY0g7vJ9kZzbysRXjj0nxBToRYomtJjg==
X-Received: by 2002:a65:64c4:: with SMTP id t4mr15839509pgv.152.1551656314271;
        Sun, 03 Mar 2019 15:38:34 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id y6sm7284579pfy.87.2019.03.03.15.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 15:38:33 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v2 3/3] t3600: use helpers to replace test -d/f/e/s <path>
Date:   Mon,  4 Mar 2019 05:07:50 +0530
Message-Id: <20190303233750.6500-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace `test -(d|f|e|s)` calls in `t3600-rm.sh`.

Previously we were using `test -(d|f|e|s)` to verify the presence of a
directory/file, but we already have helper functions, viz, `test_path_is_dir`,
`test_path_is_file`, `test_path_is_missing` and `test_file_not_empty`
with better functionality.

These helper functions make code more readable and informative to someone
new, also these functions have better error messages.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 142 +++++++++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f1afda21e9..9e1ada463c 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -141,15 +141,15 @@ test_expect_success 'Re-add foo and baz' '
 test_expect_success 'Modify foo -- rm should refuse' '
 	echo >>foo &&
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
 test_expect_success 'Modified foo -- rm -f should work' '
 	git rm -f foo baz &&
-	test ! -f foo &&
-	test ! -f baz &&
+	test_path_is_missing foo &&
+	test_path_is_missing baz &&
 	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch bar
 '
@@ -163,15 +163,15 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
 
 test_expect_success 'foo is different in index from HEAD -- rm should refuse' '
 	test_must_fail git rm foo baz &&
-	test -f foo &&
-	test -f baz &&
+	test_path_is_file foo &&
+	test_path_is_file baz &&
 	git ls-files --error-unmatch foo baz
 '
 
 test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
-	test ! -f foo &&
-	test ! -f baz &&
+	test_path_is_missing foo &&
+	test_path_is_missing baz &&
 	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
@@ -198,21 +198,21 @@ test_expect_success 'Recursive test setup' '
 
 test_expect_success 'Recursive without -r fails' '
 	test_must_fail git rm frotz &&
-	test -d frotz &&
-	test -f frotz/nitfol
+	test_path_is_dir frotz &&
+	test_path_is_file frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r but dirty' '
 	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
-	test -d frotz &&
-	test -f frotz/nitfol
+	test_path_is_dir frotz &&
+	test_path_is_file frotz/nitfol
 '
 
 test_expect_success 'Recursive with -r -f' '
 	git rm -f -r frotz &&
-	! test -f frotz/nitfol &&
-	! test -d frotz
+	test_path_is_missing frotz/nitfol &&
+	test_path_is_missing frotz
 '
 
 test_expect_success 'Remove nonexistent file returns nonzero exit status' '
@@ -237,7 +237,7 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 	git reset --hard &&
 	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
-	test ! -f frotz/nitfol
+	test_path_is_missing frotz/nitfol
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
@@ -258,7 +258,7 @@ test_expect_success 'rm removes subdirectories recursively' '
 	echo content >dir/subdir/subsubdir/file &&
 	git add dir/subdir/subsubdir/file &&
 	git rm -f dir/subdir/subsubdir/file &&
-	! test -d dir
+	test_path_is_missing dir
 '
 
 cat >expect <<EOF
@@ -296,7 +296,7 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git add .gitmodules &&
 	git commit -m "add submodule" &&
 	git rm submod &&
-	test ! -e submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -318,7 +318,7 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -329,7 +329,7 @@ test_expect_success 'rm removes a submodule with a trailing /' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod/ &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -347,12 +347,12 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
 	git submodule update &&
 	git -C submod checkout HEAD^ &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -363,8 +363,8 @@ test_expect_success 'rm --cached leaves work tree of populated submodules and .g
 	git reset --hard &&
 	git submodule update &&
 	git rm --cached submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect.cached actual &&
 	git config -f .gitmodules submodule.sub.url &&
@@ -375,7 +375,7 @@ test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm -n submod &&
-	test -f submod/.git &&
+	test_path_is_file submod/.git &&
 	git diff-index --exit-code HEAD
 '
 
@@ -385,8 +385,8 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
 	git rm .gitmodules &&
 	git rm submod >actual 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect.both_deleted actual
 '
@@ -396,15 +396,15 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
 	git submodule update &&
 	git config -f .gitmodules foo.bar true &&
 	test_must_fail git rm submod >actual 2>actual.err &&
-	test -s actual.err &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_file_not_empty actual.err &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git diff-files --quiet -- submod &&
 	git add .gitmodules &&
 	git rm submod >actual 2>actual.err &&
 	test_must_be_empty actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -417,8 +417,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
 	echo "warning: Could not find section in .gitmodules where path=submod" >expect.err &&
 	git rm submod >actual 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
-	! test -d submod &&
-	! test -f submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno >actual &&
 	test_cmp expect actual
 '
@@ -428,12 +428,12 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
 	git submodule update &&
 	echo X >submod/empty &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -443,12 +443,12 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
 	git submodule update &&
 	echo X >submod/untracked &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -485,7 +485,7 @@ test_expect_success 'rm removes work tree of unmodified conflicted submodule' '
 	git submodule update &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -497,12 +497,12 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
 	git -C submod checkout HEAD^ &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -516,12 +516,12 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
 	echo X >submod/empty &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -535,12 +535,12 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
 	echo X >submod/untracked &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -556,13 +556,13 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	) &&
 	test_must_fail git merge conflict2 &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	test_must_fail git rm -f submod &&
-	test -d submod &&
-	test -d submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_dir submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.conflict actual &&
 	git merge --abort &&
@@ -574,7 +574,7 @@ test_expect_success 'rm of a conflicted unpopulated submodule succeeds' '
 	git reset --hard &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -590,10 +590,10 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
 		rm -r ../.git/modules/sub
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test -s actual &&
+	test_file_not_empty actual &&
 	test_i18ngrep Migrating output.err
 '
 
@@ -618,7 +618,7 @@ test_expect_success 'setup subsubmodule' '
 
 test_expect_success 'rm recursively removes work tree of unmodified submodules' '
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -628,12 +628,12 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
 	git submodule update --recursive &&
 	git -C submod/subsubmod checkout HEAD^ &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -643,12 +643,12 @@ test_expect_success 'rm of a populated nested submodule with nested modification
 	git submodule update --recursive &&
 	echo X >submod/subsubmod/empty &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_inside actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -658,12 +658,12 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	git submodule update --recursive &&
 	echo X >submod/subsubmod/untracked &&
 	test_must_fail git rm submod &&
-	test -d submod &&
-	test -f submod/.git &&
+	test_path_is_dir submod &&
+	test_path_is_file submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -677,10 +677,10 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
 		GIT_WORK_TREE=. git config --unset core.worktree
 	) &&
 	git rm submod 2>output.err &&
-	! test -d submod &&
-	! test -d submod/subsubmod/.git &&
+	test_path_is_missing submod &&
+	test_path_is_missing submod/subsubmod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test -s actual &&
+	test_file_not_empty actual &&
 	test_i18ngrep Migrating output.err
 '
 
-- 
2.17.1

