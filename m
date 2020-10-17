Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5189FC433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A0C2073A
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+yUf/Hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437525AbgJQH4B (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437522AbgJQH4A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:56:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C917C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:55:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e10so2866838pfj.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8vVoXiXZzh0fLZS99sdzB1AzmUqV0PIa/JAkir7jYo=;
        b=N+yUf/HwUA1d6SnMIS/wVyKryQF8JmrrhnjirRypLDpWzVHVUHLiC6WH/LwxsccU1R
         u0UYBxU2m3lwyhV2fez8jQWGEzjNWwSiUwbZscXI+XqNWPlu1PlEwnNBRTRCtJt7f7sn
         11CbZJUofj7WQxFedMow8YDb3C/tHSPMrrwQSk8f0+jo6ojvTn3HFivitVM8ISCFAcFr
         HNjBJPKvVnZOY1R2/iD8xgT+KktF5ToRcVJ/7Zrq3ZLJEvHl2hpYV6oFJI6l+soRG1Po
         Rc8gM30Il4t+g8fFWf1sbrVdfrKtH+6x09kmR7wA3+20qqJaKa/Ud51b6vpyej1200Kb
         pSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8vVoXiXZzh0fLZS99sdzB1AzmUqV0PIa/JAkir7jYo=;
        b=uUNq4M1++9Dn6C+r0oHIWC8Dse/OuVa6m6VTYT4SW2ZeTIkfqFO2WDPv3zR5VE4/IJ
         kcezcT/kDtOXw0A0ghy2cXvb80AxQnfwo/+sEEx+DFfdHu3Z+vDaPjJiUviSqjDLz2FH
         l0/VA+39fX9XEv/sCJIHhkUjA7wX6DnatqF60UFbAnxBD/RRzx/m7r7vhuVzrcg+mLcs
         MJUSE7lmilTh8rGjA3cPQFE5RqS8oDhAJ80L9rMyS0XHDfiYuRznO1stSBxcmZKUAO5Q
         gdgAKgBF7LM2yMAtD2MUhz/If+iz7nUZapxwHO0y9+FJS8bNWse4Scbl1/9lQ+53ZMkX
         mLsA==
X-Gm-Message-State: AOAM531PP4onimUywaMMROfg5nukAxoHUQhFQq6LTU/Wc6aPx6L8/fSV
        2fU/gYc6iS1ndFM+GL1fcV8Vksc7DpRWjGhv
X-Google-Smtp-Source: ABdhPJzx7ufIV3lDU66RLIcFrxSne6khGApV8oSChbaD153n7YaB5vlOjWbCk8wc0cxJ9RswGIqMiA==
X-Received: by 2002:a65:6719:: with SMTP id u25mr6261637pgf.346.1602921357183;
        Sat, 17 Oct 2020 00:55:57 -0700 (PDT)
Received: from localhost.localdomain ([106.201.2.128])
        by smtp.gmail.com with ESMTPSA id t2sm4994162pji.12.2020.10.17.00.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:55:56 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 1/5][Outreachy] t7101,t7102,t7201: modernize test formatting
Date:   Sat, 17 Oct 2020 13:24:51 +0530
Message-Id: <20201017075455.9660-2-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201017075455.9660-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in these scripts are formatted using a very old style:
        test_expect_success \
            'title' \
            'body line 1 &&
            body line 2'

Updating the formatting to the modern style:
        test_expect_success 'title' '
            body line 1 &&
            body line 2
        '

Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 t/t7101-reset-empty-subdirs.sh | 66 +++++++++++++++++-----------------
 t/t7102-reset.sh               | 24 +++++--------
 t/t7201-co.sh                  | 31 ++++++++--------
 3 files changed, 56 insertions(+), 65 deletions(-)

diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index 96e163f084..bfce05ac5d 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -6,16 +6,15 @@
 test_description='git reset should cull empty subdirs'
 . ./test-lib.sh
 
-test_expect_success \
-    'creating initial files' \
-    'mkdir path0 &&
+test_expect_success 'creating initial files' '
+     mkdir path0 &&
      cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
      git add path0/COPYING &&
-     git commit -m add -a'
+     git commit -m add -a
+'
 
-test_expect_success \
-    'creating second files' \
-    'mkdir path1 &&
+test_expect_success 'creating second files' '
+     mkdir path1 &&
      mkdir path1/path2 &&
      cp "$TEST_DIRECTORY"/../COPYING path1/path2/COPYING &&
      cp "$TEST_DIRECTORY"/../COPYING path1/COPYING &&
@@ -25,39 +24,40 @@ test_expect_success \
      git add path1/COPYING &&
      git add COPYING &&
      git add path0/COPYING-TOO &&
-     git commit -m change -a'
+     git commit -m change -a
+'
 
-test_expect_success \
-    'resetting tree HEAD^' \
-    'git reset --hard HEAD^'
+test_expect_success 'resetting tree HEAD^' '
+     git reset --hard HEAD^
+'
 
-test_expect_success \
-    'checking initial files exist after rewind' \
-    'test -d path0 &&
-     test -f path0/COPYING'
+test_expect_success 'checking initial files exist after rewind' '
+     test -d path0 &&
+     test -f path0/COPYING
+'
 
-test_expect_success \
-    'checking lack of path1/path2/COPYING' \
-    '! test -f path1/path2/COPYING'
+test_expect_success 'checking lack of path1/path2/COPYING' '
+    ! test -f path1/path2/COPYING
+'
 
-test_expect_success \
-    'checking lack of path1/COPYING' \
-    '! test -f path1/COPYING'
+test_expect_success 'checking lack of path1/COPYING' '
+    ! test -f path1/COPYING
+'
 
-test_expect_success \
-    'checking lack of COPYING' \
-    '! test -f COPYING'
+test_expect_success 'checking lack of COPYING' '
+     ! test -f COPYING
+'
 
-test_expect_success \
-    'checking checking lack of path1/COPYING-TOO' \
-    '! test -f path0/COPYING-TOO'
+test_expect_success 'checking checking lack of path1/COPYING-TOO' '
+     ! test -f path0/COPYING-TOO
+'
 
-test_expect_success \
-    'checking lack of path1/path2' \
-    '! test -d path1/path2'
+test_expect_success 'checking lack of path1/path2' '
+     ! test -d path1/path2
+'
 
-test_expect_success \
-    'checking lack of path1' \
-    '! test -d path1'
+test_expect_success 'checking lack of path1' '
+     ! test -d path1
+'
 
 test_done
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 22161b3b2d..fe43f77513 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -107,8 +107,7 @@ test_expect_success 'reset --soft with unmerged index should fail' '
 	git rm --cached -- un
 '
 
-test_expect_success \
-	'giving paths with options different than --mixed should fail' '
+test_expect_success 'giving paths with options different than --mixed should fail' '
 	test_must_fail git reset --soft -- first &&
 	test_must_fail git reset --hard -- first &&
 	test_must_fail git reset --soft HEAD^ -- first &&
@@ -128,8 +127,7 @@ test_expect_success 'giving unrecognized options should fail' '
 	check_changes $head5
 '
 
-test_expect_success \
-	'trying to do reset --soft with pending merge should fail' '
+test_expect_success 'trying to do reset --soft with pending merge should fail' '
 	git branch branch1 &&
 	git branch branch2 &&
 
@@ -152,8 +150,7 @@ test_expect_success \
 	check_changes $head5
 '
 
-test_expect_success \
-	'trying to do reset --soft with pending checkout merge should fail' '
+test_expect_success 'trying to do reset --soft with pending checkout merge should fail' '
 	git branch branch3 &&
 	git branch branch4 &&
 
@@ -175,8 +172,7 @@ test_expect_success \
 	check_changes $head5
 '
 
-test_expect_success \
-	'resetting to HEAD with no changes should succeed and do nothing' '
+test_expect_success 'resetting to HEAD with no changes should succeed and do nothing' '
 	git reset --hard &&
 		check_changes $head5 &&
 	git reset --hard HEAD &&
@@ -226,8 +222,7 @@ secondfile:
 2nd line 2nd file
 3rd line 2nd file
 EOF
-test_expect_success \
-	'changing files and redo the last commit should succeed' '
+test_expect_success 'changing files and redo the last commit should succeed' '
 	echo "3rd line 2nd file" >>secondfile &&
 	git commit -a -C ORIG_HEAD &&
 	head4=$(git rev-parse --verify HEAD) &&
@@ -245,8 +240,7 @@ first:
 second:
 2nd file
 EOF
-test_expect_success \
-	'--hard reset should change the files and undo commits permanently' '
+test_expect_success '--hard reset should change the files and undo commits permanently' '
 	git reset --hard HEAD~2 &&
 	check_changes $head5p2 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
@@ -284,8 +278,7 @@ secondfile:
 1st line 2nd file
 2nd line 2nd file
 EOF
-test_expect_success \
-	'redoing changes adding them without commit them should succeed' '
+test_expect_success 'redoing changes adding them without commit them should succeed' '
 	git rm first &&
 	git mv second secondfile &&
 
@@ -380,8 +373,7 @@ secondfile:
 1st line 2nd file
 2nd line 2nd file
 EOF
-test_expect_success \
-	'--hard reset to ORIG_HEAD should clear a fast-forward merge' '
+test_expect_success '--hard reset to ORIG_HEAD should clear a fast-forward merge' '
 	git reset --hard HEAD^ &&
 	check_changes $head5 &&
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 4d62b9b00f..a800bda5e3 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -62,7 +62,7 @@ test_expect_success setup '
 	git checkout master
 '
 
-test_expect_success "checkout from non-existing branch" '
+test_expect_success 'checkout from non-existing branch' '
 
 	git checkout -b delete-me master &&
 	git update-ref -d --no-deref refs/heads/delete-me &&
@@ -71,7 +71,7 @@ test_expect_success "checkout from non-existing branch" '
 	test refs/heads/master = "$(git symbolic-ref HEAD)"
 '
 
-test_expect_success "checkout with dirty tree without -m" '
+test_expect_success 'checkout with dirty tree without -m' '
 
 	fill 0 1 2 3 4 5 6 7 8 >one &&
 	if git checkout side
@@ -84,7 +84,7 @@ test_expect_success "checkout with dirty tree without -m" '
 
 '
 
-test_expect_success "checkout with unrelated dirty tree without -m" '
+test_expect_success 'checkout with unrelated dirty tree without -m' '
 
 	git checkout -f master &&
 	fill 0 1 2 3 4 5 6 7 8 >same &&
@@ -95,7 +95,7 @@ test_expect_success "checkout with unrelated dirty tree without -m" '
 	test_cmp messages.expect messages
 '
 
-test_expect_success "checkout -m with dirty tree" '
+test_expect_success 'checkout -m with dirty tree' '
 
 	git checkout -f master &&
 	git clean -f &&
@@ -120,7 +120,7 @@ test_expect_success "checkout -m with dirty tree" '
 	test_must_be_empty current.index
 '
 
-test_expect_success "checkout -m with dirty tree, renamed" '
+test_expect_success 'checkout -m with dirty tree, renamed' '
 
 	git checkout -f master && git clean -f &&
 
@@ -388,22 +388,22 @@ test_expect_success 'checkout specific path while in subdirectory' '
 
 '
 
-test_expect_success \
-    'checkout w/--track sets up tracking' '
+test_expect_success 'checkout w/--track sets up tracking' '
     git config branch.autosetupmerge false &&
     git checkout master &&
     git checkout --track -b track1 &&
     test "$(git config branch.track1.remote)" &&
-    test "$(git config branch.track1.merge)"'
+    test "$(git config branch.track1.merge)"
+'
 
-test_expect_success \
-    'checkout w/autosetupmerge=always sets up tracking' '
+test_expect_success 'checkout w/autosetupmerge=always sets up tracking' '
     test_when_finished git config branch.autosetupmerge false &&
     git config branch.autosetupmerge always &&
     git checkout master &&
     git checkout -b track2 &&
     test "$(git config branch.track2.remote)" &&
-    test "$(git config branch.track2.merge)"'
+    test "$(git config branch.track2.merge)"
+'
 
 test_expect_success 'checkout w/--track from non-branch HEAD fails' '
     git checkout master^0 &&
@@ -435,8 +435,7 @@ test_expect_success 'detach a symbolic link HEAD' '
     test "z$(git rev-parse --verify refs/heads/master)" = "z$here"
 '
 
-test_expect_success \
-    'checkout with --track fakes a sensible -b <name>' '
+test_expect_success 'checkout with --track fakes a sensible -b <name>' '
     git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*" &&
     git update-ref refs/remotes/origin/koala/bear renamer &&
 
@@ -457,9 +456,9 @@ test_expect_success \
     test "$(git rev-parse HEAD)" = "$(git rev-parse renamer)"
 '
 
-test_expect_success \
-    'checkout with --track, but without -b, fails with too short tracked name' '
-    test_must_fail git checkout --track renamer'
+test_expect_success 'checkout with --track, but without -b, fails with too short tracked name' '
+    test_must_fail git checkout --track renamer
+'
 
 setup_conflicting_index () {
 	rm -f .git/index &&
-- 
2.29.0.rc1

