Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B82520248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCDMIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:08:50 -0500
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38017 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDMIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:08:49 -0500
Received: by mail-pf1-f181.google.com with SMTP id n125so2895777pfn.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lt6I5TqadZGLU+QD98VIhH8DYy0G3TdLytOrt+/uC+U=;
        b=eSl06sBbvNc0NoDm4J09kc4rebF96kGw4w7D9/SzzGhTgbWU/Heowuv4aTeTlmzlRL
         Nm8BHMgF69ncCot2atEpmTqjg7m7KEHYItAQV41cd6A5tkRrEUgg4oUo6PZrxVvP3tOU
         XBzLFzXs1ztjgRXIYzWUV3O39ETBdsNxbLDWJaolPAP137T4p0uJw87Dy1u4Yw3gwpZi
         4Dlv7a8FYBTmOANbwSHprpHviVP9jQ2CL1k4mK0L0WOphlhrLSgiyhiCJJxQzkVpCIH7
         tG+krX79wDk05029IQn8M2QvQgStxAZFHBRsFa1wZFGI/qllToKOe40OEbWjhvPdCWbq
         pSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lt6I5TqadZGLU+QD98VIhH8DYy0G3TdLytOrt+/uC+U=;
        b=CznW3C2u4W9G5D/uTCvNo93NI+XZaQjcmwhsqWvd3QbynxwTaLqpZk2cfGcd3hbFkD
         Ebh/wnSjV8i89oGa8mR+Csw3vfZPgJY202hpBiW57JYSTDHm7Jc77Qn8PpsOcq9/LZO+
         ofq0Luw26dD1f+6F2kNutZb5HpEBnbG079UYJTsNR4ak2hBK5U/gI+3AFTn0vU5RNSbj
         CRT1tcymqpZ3g3XanDk5jzGMatFmp+oBpsZ/XHKe80EU98cQRLglVMa279WIGlNwiGle
         rYJKsR8LxLXGs69eu1b0JebXOpHVjSZxKe2oRcof7zqynyX8yt70mUjWAQN0T+vXdyKu
         ntmQ==
X-Gm-Message-State: AHQUAubCrAFU6jZlX284hDLZrKA5th++P0twv05RJ+Tz8Z0aKIv084hs
        s5ksccb/jAq4XV+gBS7sOPw=
X-Google-Smtp-Source: AHgI3IbonykvEjLQjumT+CTtpo9xZtc4rtN6xyBZMR/BqX40CjPwYBv8or96ognrYwyVUsqMOI0aSQ==
X-Received: by 2002:a62:ae04:: with SMTP id q4mr19501489pff.213.1551701328459;
        Mon, 04 Mar 2019 04:08:48 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id b138sm18791686pfb.48.2019.03.04.04.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:08:47 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v3 3/3] t3600: use helpers to replace test -d/f/e/s <path>
Date:   Mon,  4 Mar 2019 17:38:01 +0530
Message-Id: <20190304120801.28763-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously  we  were  using  `test -(d|f|e|s)`  to  verify  the  presence of a
directory/file, but we already have helper functions, viz, `test_path_is_dir`,
`test_path_is_file`,    `test_path_is_missing`    and    `test_file_not_empty`
with better functionality.

These helper functions make code more readable and informative to someone new,
also these functions have better error messages.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 150 +++++++++++++++++++++++++-------------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 8b03897a65..85ae7dc1e4 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -26,7 +26,7 @@ test_expect_success FUNNYNAMES 'add files with funny names' '
 '
 
 test_expect_success 'Pre-check that foo exists and is in index before git rm foo' '
-	test -f foo &&
+	test_path_is_file foo &&
 	git ls-files --error-unmatch foo
 '
 
@@ -69,12 +69,12 @@ test_expect_success 'Test that git rm --cached -f foo works in case where --cach
 '
 
 test_expect_success 'Post-check that foo exists but is not in index after git rm foo' '
-	test -f foo &&
+	test_path_is_file foo &&
 	test_must_fail git ls-files --error-unmatch foo
 '
 
 test_expect_success 'Pre-check that bar exists and is in index before "git rm bar"' '
-	test -f bar &&
+	test_path_is_file bar &&
 	git ls-files --error-unmatch bar
 '
 
@@ -83,7 +83,7 @@ test_expect_success 'Test that "git rm bar" succeeds' '
 '
 
 test_expect_success 'Post-check that bar does not exist and is not in index after "git rm -f bar"' '
-	! test -f bar &&
+	test_path_is_missing bar &&
 	test_must_fail git ls-files --error-unmatch bar
 '
 
@@ -138,15 +138,15 @@ test_expect_success 'Re-add foo and baz' '
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
@@ -160,15 +160,15 @@ test_expect_success 'Re-add foo and baz for HEAD tests' '
 
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
@@ -195,21 +195,21 @@ test_expect_success 'Recursive test setup' '
 
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
@@ -236,7 +236,7 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 	git reset --hard &&
 	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
-	test ! -f frotz/nitfol
+	test_path_is_missing frotz/nitfol
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
@@ -257,7 +257,7 @@ test_expect_success 'rm removes subdirectories recursively' '
 	echo content >dir/subdir/subsubdir/file &&
 	git add dir/subdir/subsubdir/file &&
 	git rm -f dir/subdir/subsubdir/file &&
-	! test -d dir
+	test_path_is_missing dir
 '
 
 cat >expect <<EOF
@@ -295,7 +295,7 @@ test_expect_success 'rm removes empty submodules from work tree' '
 	git add .gitmodules &&
 	git commit -m "add submodule" &&
 	git rm submod &&
-	test ! -e submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -317,7 +317,7 @@ test_expect_success 'rm removes work tree of unmodified submodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual &&
 	test_must_fail git config -f .gitmodules submodule.sub.url &&
@@ -328,7 +328,7 @@ test_expect_success 'rm removes a submodule with a trailing /' '
 	git reset --hard &&
 	git submodule update &&
 	git rm submod/ &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -346,12 +346,12 @@ test_expect_success 'rm of a populated submodule with different HEAD fails unles
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
@@ -362,8 +362,8 @@ test_expect_success 'rm --cached leaves work tree of populated submodules and .g
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
@@ -374,7 +374,7 @@ test_expect_success 'rm --dry-run does not touch the submodule or .gitmodules' '
 	git reset --hard &&
 	git submodule update &&
 	git rm -n submod &&
-	test -f submod/.git &&
+	test_path_is_file submod/.git &&
 	git diff-index --exit-code HEAD
 '
 
@@ -384,8 +384,8 @@ test_expect_success 'rm does not complain when no .gitmodules file is found' '
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
@@ -395,15 +395,15 @@ test_expect_success 'rm will error out on a modified .gitmodules file unless sta
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
@@ -416,8 +416,8 @@ test_expect_success 'rm issues a warning when section is not found in .gitmodule
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
@@ -427,12 +427,12 @@ test_expect_success 'rm of a populated submodule with modifications fails unless
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
@@ -442,12 +442,12 @@ test_expect_success 'rm of a populated submodule with untracked files fails unle
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
@@ -484,7 +484,7 @@ test_expect_success 'rm removes work tree of unmodified conflicted submodule' '
 	git submodule update &&
 	test_must_fail git merge conflict2 &&
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -496,12 +496,12 @@ test_expect_success 'rm of a conflicted populated submodule with different HEAD
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
@@ -515,12 +515,12 @@ test_expect_success 'rm of a conflicted populated submodule with modifications f
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
@@ -534,12 +534,12 @@ test_expect_success 'rm of a conflicted populated submodule with untracked files
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
@@ -591,10 +591,10 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
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
 
@@ -620,7 +620,7 @@ test_expect_success 'setup subsubmodule' '
 
 test_expect_success 'rm recursively removes work tree of unmodified submodules' '
 	git rm submod &&
-	test ! -d submod &&
+	test_path_is_missing submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
 	test_cmp expect actual
 '
@@ -630,12 +630,12 @@ test_expect_success 'rm of a populated nested submodule with different nested HE
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
@@ -645,12 +645,12 @@ test_expect_success 'rm of a populated nested submodule with nested modification
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
@@ -660,12 +660,12 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
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
@@ -680,10 +680,10 @@ test_expect_success "rm absorbs submodule's nested .git directory" '
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
Rohit
