Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDE9C77B7F
	for <git@archiver.kernel.org>; Sat, 20 May 2023 16:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjETQO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 May 2023 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjETQOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2023 12:14:25 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D3134
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306dbad5182so2828004f8f.1
        for <git@vger.kernel.org>; Sat, 20 May 2023 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684599247; x=1687191247;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3ApEPrKyxK3yGm9+ENIqBlijwSY/g5JuPIFy5wRFBc=;
        b=ABh/4zPyxx9zEQpiwZbJ7quTPzkQJrqMicELQCPwIbM+NVVURNaRFAtEUlvpH27x3b
         4bodEY18T8CgtAMe11SPHbsxdd3pg5WjQCeFeBvz4m9rTH6Mo4WTR1k7gLgIXin8m5pZ
         clmYYdVHf1ThRp8YizxV9eHShqFe9MsjTIAAOtTz66WX6YU8CVvVueQj6dLx5l9FsnKT
         Ii/5C+aee9w2A/jkWxvCQzz6zXOQlwBGLO5Ecs42RC8GJYPGtNv1Yl0KJNnXZIsY9+nK
         atQVW/z1Vl5C34gKOY6moz38c9IDVPNRaMEUzgYzewiN90iY/hQ8FqWQwUeEue1J+oBC
         J4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684599247; x=1687191247;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3ApEPrKyxK3yGm9+ENIqBlijwSY/g5JuPIFy5wRFBc=;
        b=cW/Qtp83TLkLd/lIvY1X82E6FzV6ZcxBlYagAqfLoKBOhrsl7aG92YOiIekPKXqSZ5
         GafST6gwLM+3riJzfF7HbIyxIxO2WrTws5VZDUm6pYLCkFpmIojVlKwMMkQnmORo19x5
         +zwSrdflLtgSkPBxp09YXLeO41WS5oocNbJp5QwaDP4cAVPtrTnPkN/wkbORMRD+80kC
         LyWnWGpZjRaXXJOmgR185epB34STKK9n0G32F0mcc7XcIs10ZWPHqAUJZUWbuwf3ZQ7V
         bOwNiSJ4mFZ1I1mv5GHXgREuKmAx4+sDxuC1VspUVlRo0Gqj6gz3PgPkzZPMh0/fjkq6
         0hhw==
X-Gm-Message-State: AC+VfDwLqTXr1c90n9iVCF8c64pMHLKi0un2zABF889xO2Ngt6Uciie1
        Ntavq2zcSwWggMm8K97sNTH1Qr8eoZ0=
X-Google-Smtp-Source: ACHHUZ7Jfdpp6L+Z8cONfbPijpQpknJ9x3xagotsvph9fdx71LNpVWkrbf/fBRz92qCGPlr6vAfhGA==
X-Received: by 2002:adf:e60b:0:b0:309:a4e:52d3 with SMTP id p11-20020adfe60b000000b003090a4e52d3mr4814348wrm.5.1684599246901;
        Sat, 20 May 2023 09:14:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00307c8d6b4a0sm2344428wru.26.2023.05.20.09.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 09:14:06 -0700 (PDT)
Message-Id: <c324ec087fb6d31b19b57c1dce5aa72c5ae6c9e4.1684599239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
References: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 20 May 2023 16:13:58 +0000
Subject: [PATCH 10/10] t9400-git-cvsserver-server: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t9400-git-cvsserver-server.sh | 530 +++++++++++++++++---------------
 1 file changed, 278 insertions(+), 252 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 379b19f2f85..003c0b61d0f 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -66,10 +66,11 @@ test_expect_success 'setup' '
 
 # note that cvs doesn't accept absolute pathnames
 # as argument to co -d
-test_expect_success 'basic checkout' \
-  'GIT_CONFIG="$git_config" cvs -Q co -d cvswork main &&
-   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/" &&
-   test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | sed -ne \$p))" = "secondrootfile/1.1/"'
+test_expect_success 'basic checkout' '
+	GIT_CONFIG="$git_config" cvs -Q co -d cvswork main &&
+	test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | head -n 1))" = "empty/1.1/" &&
+	test "$(echo $(grep -v ^D cvswork/CVS/Entries|cut -d/ -f2,3,5 | sed -ne \$p))" = "secondrootfile/1.1/"
+'
 
 #------------------------
 # PSERVER AUTHENTICATION
@@ -115,35 +116,40 @@ Ah<Z:yZZ30 e
 END VERIFICATION REQUEST
 EOF
 
-test_expect_success 'pserver authentication' \
-  'cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'pserver authentication' '
+	cat request-anonymous | git-cvsserver pserver >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
-test_expect_success 'pserver authentication failure (non-anonymous user)' \
-  'if cat request-git | git-cvsserver pserver >log 2>&1
-   then
-       false
-   else
-       true
-   fi &&
-   sed -ne \$p log | grep "^I HATE YOU\$"'
+test_expect_success 'pserver authentication failure (non-anonymous user)' '
+	if cat request-git | git-cvsserver pserver >log 2>&1
+	then
+	    false
+	else
+	    true
+	fi &&
+	sed -ne \$p log | grep "^I HATE YOU\$"
+'
 
-test_expect_success 'pserver authentication success (non-anonymous user with password)' \
-  'cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'pserver authentication success (non-anonymous user with password)' '
+	cat login-git-ok | git-cvsserver pserver >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
-test_expect_success 'pserver authentication (login)' \
-  'cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'pserver authentication (login)' '
+	cat login-anonymous | git-cvsserver pserver >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
-test_expect_success 'pserver authentication failure (login/non-anonymous user)' \
-  'if cat login-git | git-cvsserver pserver >log 2>&1
-   then
-       false
-   else
-       true
-   fi &&
-   sed -ne \$p log | grep "^I HATE YOU\$"'
+test_expect_success 'pserver authentication failure (login/non-anonymous user)' '
+	if cat login-git | git-cvsserver pserver >log 2>&1
+	then
+	    false
+	else
+	    true
+	fi &&
+	sed -ne \$p log | grep "^I HATE YOU\$"
+'
 
 
 # misuse pserver authentication for testing of req_Root
@@ -165,36 +171,40 @@ END AUTH REQUEST
 Root $WORKDIR
 EOF
 
-test_expect_success 'req_Root failure (relative pathname)' \
-  'if cat request-relative | git-cvsserver pserver >log 2>&1
-   then
-       echo unexpected success
-       false
-   else
-       true
-   fi &&
-   tail log | grep "^error 1 Root must be an absolute pathname$"'
+test_expect_success 'req_Root failure (relative pathname)' '
+	if cat request-relative | git-cvsserver pserver >log 2>&1
+	then
+		echo unexpected success
+		false
+	else
+		true
+	fi &&
+	tail log | grep "^error 1 Root must be an absolute pathname$"
+'
 
-test_expect_success 'req_Root failure (conflicting roots)' \
-  'cat request-conflict | git-cvsserver pserver >log 2>&1 &&
-   tail log | grep "^error 1 Conflicting roots specified$"'
+test_expect_success 'req_Root failure (conflicting roots)' '
+	cat request-conflict | git-cvsserver pserver >log 2>&1 &&
+	tail log | grep "^error 1 Conflicting roots specified$"
+'
 
-test_expect_success 'req_Root (strict paths)' \
-  'cat request-anonymous | git-cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'req_Root (strict paths)' '
+	cat request-anonymous | git-cvsserver --strict-paths pserver "$SERVERDIR" >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
 test_expect_success 'req_Root failure (strict-paths)' '
-    ! cat request-anonymous |
-    git-cvsserver --strict-paths pserver "$WORKDIR" >log 2>&1
+	! cat request-anonymous |
+	git-cvsserver --strict-paths pserver "$WORKDIR" >log 2>&1
 '
 
-test_expect_success 'req_Root (w/o strict-paths)' \
-  'cat request-anonymous | git-cvsserver pserver "$WORKDIR/" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'req_Root (w/o strict-paths)' '
+	cat request-anonymous | git-cvsserver pserver "$WORKDIR/" >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
 test_expect_success 'req_Root failure (w/o strict-paths)' '
-    ! cat request-anonymous |
-    git-cvsserver pserver "$WORKDIR/gitcvs" >log 2>&1
+	! cat request-anonymous |
+	git-cvsserver pserver "$WORKDIR/gitcvs" >log 2>&1
 '
 
 cat >request-base  <<EOF
@@ -206,27 +216,30 @@ END AUTH REQUEST
 Root /gitcvs.git
 EOF
 
-test_expect_success 'req_Root (base-path)' \
-  'cat request-base | git-cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'req_Root (base-path)' '
+	cat request-base | git-cvsserver --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
 test_expect_success 'req_Root failure (base-path)' '
-    ! cat request-anonymous |
-    git-cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" >log 2>&1
+	! cat request-anonymous |
+	git-cvsserver --strict-paths --base-path "$WORKDIR" pserver "$SERVERDIR" >log 2>&1
 '
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false || exit 1
 
-test_expect_success 'req_Root (export-all)' \
-  'cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'req_Root (export-all)' '
+	cat request-anonymous | git-cvsserver --export-all pserver "$WORKDIR" >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
-test_expect_success 'req_Root failure (export-all w/o directory list)' \
-  '! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
+test_expect_success 'req_Root failure (export-all w/o directory list)' '
+	! (cat request-anonymous | git-cvsserver --export-all pserver >log 2>&1 || false)'
 
-test_expect_success 'req_Root (everything together)' \
-  'cat request-base | git-cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
-   sed -ne \$p log | grep "^I LOVE YOU\$"'
+test_expect_success 'req_Root (everything together)' '
+	cat request-base | git-cvsserver --export-all --strict-paths --base-path "$WORKDIR/" pserver "$SERVERDIR" >log 2>&1 &&
+	sed -ne \$p log | grep "^I LOVE YOU\$"
+'
 
 GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true || exit 1
 
@@ -247,45 +260,49 @@ test_expect_success 'gitcvs.enabled = false' \
    test ! -d cvswork2'
 
 rm -fr cvswork2
-test_expect_success 'gitcvs.ext.enabled = true' \
-  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
-   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
-   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
-   test_cmp cvswork cvswork2'
+test_expect_success 'gitcvs.ext.enabled = true' '
+	GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+	GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled false &&
+	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
+	test_cmp cvswork cvswork2
+'
 
 rm -fr cvswork2
-test_expect_success 'gitcvs.ext.enabled = false' \
-  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled false &&
-   GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
-   if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1
-   then
-     echo unexpected cvs success
-     false
-   else
-     true
-   fi &&
-   grep "GITCVS emulation disabled" cvs.log &&
-   test ! -d cvswork2'
+test_expect_success 'gitcvs.ext.enabled = false' '
+	GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled false &&
+	GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
+	if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1
+	then
+		echo unexpected cvs success
+		false
+	else
+		true
+	fi &&
+	grep "GITCVS emulation disabled" cvs.log &&
+	test ! -d cvswork2
+'
 
 rm -fr cvswork2
-test_expect_success 'gitcvs.dbname' \
-  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
-   GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
-   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
-   test_cmp cvswork cvswork2 &&
-   test -f "$SERVERDIR/gitcvs.ext.main.sqlite" &&
-   cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"'
+test_expect_success 'gitcvs.dbname' '
+	GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
+	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
+	test_cmp cvswork cvswork2 &&
+	test -f "$SERVERDIR/gitcvs.ext.main.sqlite" &&
+	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"
+'
 
 rm -fr cvswork2
-test_expect_success 'gitcvs.ext.dbname' \
-  'GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
-   GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
-   GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
-   GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
-   test_cmp cvswork cvswork2 &&
-   test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
-   test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
-   cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs1.ext.main.sqlite"'
+test_expect_success 'gitcvs.ext.dbname' '
+	GIT_DIR="$SERVERDIR" git config --bool gitcvs.ext.enabled true &&
+	GIT_DIR="$SERVERDIR" git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
+	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
+	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
+	test_cmp cvswork cvswork2 &&
+	test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
+	test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
+	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs1.ext.main.sqlite"
+'
 
 
 #------------
@@ -299,109 +316,115 @@ GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
 GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
 exit 1
 
-test_expect_success 'cvs update (create new file)' \
-  'echo testfile1 >testfile1 &&
-   git add testfile1 &&
-   git commit -q -m "Add testfile1" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
-   test_cmp testfile1 ../testfile1'
+test_expect_success 'cvs update (create new file)' '
+	echo testfile1 >testfile1 &&
+	git add testfile1 &&
+	git commit -q -m "Add testfile1" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.1/" &&
+	test_cmp testfile1 ../testfile1
+'
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (update existing file)' \
-  'echo line 2 >>testfile1 &&
-   git add testfile1 &&
-   git commit -q -m "Append to testfile1" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
-   test_cmp testfile1 ../testfile1'
+test_expect_success 'cvs update (update existing file)' '
+	echo line 2 >>testfile1 &&
+	git add testfile1 &&
+	git commit -q -m "Append to testfile1" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.2/" &&
+	test_cmp testfile1 ../testfile1
+'
 
 cd "$WORKDIR"
 #TODO: cvsserver doesn't support update w/o -d
 test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" '
-   mkdir test &&
-   echo >test/empty &&
-   git add test &&
-   git commit -q -m "Single Subdirectory" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test ! -d test
+	mkdir test &&
+	echo >test/empty &&
+	git add test &&
+	git commit -q -m "Single Subdirectory" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test ! -d test
 '
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (subdirectories)' \
-  '(for dir in A A/B A/B/C A/D E; do
-      mkdir $dir &&
-      echo "test file in $dir" >"$dir/file_in_$(echo $dir|sed -e "s#/# #g")"  &&
-      git add $dir || exit 1
-   done) &&
-   git commit -q -m "deep sub directory structure" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update -d &&
-   (for dir in A A/B A/B/C A/D E; do
-      filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
-      if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
-	test_cmp "$dir/$filename" "../$dir/$filename"; then
-        :
-      else
-	exit 1
-      fi
-    done)'
+test_expect_success 'cvs update (subdirectories)' '
+	(for dir in A A/B A/B/C A/D E; do
+		mkdir $dir &&
+		echo "test file in $dir" >"$dir/file_in_$(echo $dir|sed -e "s#/# #g")"  &&
+		git add $dir || exit 1
+	done) &&
+	git commit -q -m "deep sub directory structure" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update -d &&
+	(for dir in A A/B A/B/C A/D E; do
+		filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
+		if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
+			test_cmp "$dir/$filename" "../$dir/$filename"; then
+		:
+		else
+			exit 1
+		fi
+	done)
+'
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (delete file)' \
-  'git rm testfile1 &&
-   git commit -q -m "Remove testfile1" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test -z "$(grep testfile1 CVS/Entries)" &&
-   test ! -f testfile1'
+test_expect_success 'cvs update (delete file)' '
+	git rm testfile1 &&
+	git commit -q -m "Remove testfile1" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test -z "$(grep testfile1 CVS/Entries)" &&
+	test ! -f testfile1
+'
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (re-add deleted file)' \
-  'echo readded testfile >testfile1 &&
-   git add testfile1 &&
-   git commit -q -m "Re-Add testfile1" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
-   test_cmp testfile1 ../testfile1'
+test_expect_success 'cvs update (re-add deleted file)' '
+	echo readded testfile >testfile1 &&
+	git add testfile1 &&
+	git commit -q -m "Re-Add testfile1" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test "$(echo $(grep testfile1 CVS/Entries|cut -d/ -f2,3,5))" = "testfile1/1.4/" &&
+	test_cmp testfile1 ../testfile1
+'
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (merge)' \
-  'echo Line 0 >expected &&
-   for i in 1 2 3 4 5 6 7
-   do
-     echo Line $i >>merge &&
-     echo Line $i >>expected || return 1
-   done &&
-   echo Line 8 >>expected &&
-   git add merge &&
-   git commit -q -m "Merge test (pre-merge)" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
-   test_cmp merge ../merge &&
-   ( echo Line 0 && cat merge ) >merge.tmp &&
-   mv merge.tmp merge &&
-   cd "$WORKDIR" &&
-   echo Line 8 >>merge &&
-   git add merge &&
-   git commit -q -m "Merge test (merge)" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   sleep 1 && touch merge &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test_cmp merge ../expected'
+test_expect_success 'cvs update (merge)' '
+	echo Line 0 >expected &&
+	for i in 1 2 3 4 5 6 7
+	do
+		echo Line $i >>merge &&
+		echo Line $i >>expected || return 1
+	done &&
+	echo Line 8 >>expected &&
+	git add merge &&
+	git commit -q -m "Merge test (pre-merge)" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test "$(echo $(grep merge CVS/Entries|cut -d/ -f2,3,5))" = "merge/1.1/" &&
+	test_cmp merge ../merge &&
+	( echo Line 0 && cat merge ) >merge.tmp &&
+	mv merge.tmp merge &&
+	cd "$WORKDIR" &&
+	echo Line 8 >>merge &&
+	git add merge &&
+	git commit -q -m "Merge test (merge)" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	sleep 1 && touch merge &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test_cmp merge ../expected
+'
 
 cd "$WORKDIR"
 
@@ -418,55 +441,58 @@ do
   echo Line $i >>expected.C
 done
 
-test_expect_success 'cvs update (conflict merge)' \
-  '( echo LINE 0 && cat merge ) >merge.tmp &&
-   mv merge.tmp merge &&
-   git add merge &&
-   git commit -q -m "Merge test (conflict)" &&
-   git push gitcvs.git >/dev/null &&
-   cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update &&
-   test_cmp merge ../expected.C'
+test_expect_success 'cvs update (conflict merge)' '
+	( echo LINE 0 && cat merge ) >merge.tmp &&
+	mv merge.tmp merge &&
+	git add merge &&
+	git commit -q -m "Merge test (conflict)" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test_cmp merge ../expected.C
+'
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (-C)' \
-  'cd cvswork &&
-   GIT_CONFIG="$git_config" cvs -Q update -C &&
-   test_cmp merge ../merge'
+test_expect_success 'cvs update (-C)' '
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs -Q update -C &&
+	test_cmp merge ../merge
+'
 
 cd "$WORKDIR"
-test_expect_success 'cvs update (merge no-op)' \
-   'echo Line 9 >>merge &&
-    cp merge cvswork/merge &&
-    git add merge &&
-    git commit -q -m "Merge test (no-op)" &&
-    git push gitcvs.git >/dev/null &&
-    cd cvswork &&
-    sleep 1 && touch merge &&
-    GIT_CONFIG="$git_config" cvs -Q update &&
-    test_cmp merge ../merge'
+test_expect_success 'cvs update (merge no-op)' '
+	echo Line 9 >>merge &&
+	cp merge cvswork/merge &&
+	git add merge &&
+	git commit -q -m "Merge test (no-op)" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	sleep 1 && touch merge &&
+	GIT_CONFIG="$git_config" cvs -Q update &&
+	test_cmp merge ../merge
+'
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (-p)' '
-    touch really-empty &&
-    echo Line 1 > no-lf &&
-    printf "Line 2" >> no-lf &&
-    git add really-empty no-lf &&
-    git commit -q -m "Update -p test" &&
-    git push gitcvs.git >/dev/null &&
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs update &&
-    for i in merge no-lf empty really-empty; do
-	GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out &&
-	test_cmp $i.out ../$i || return 1
-    done
+	touch really-empty &&
+	echo Line 1 > no-lf &&
+	printf "Line 2" >> no-lf &&
+	git add really-empty no-lf &&
+	git commit -q -m "Update -p test" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs update &&
+	for i in merge no-lf empty really-empty; do
+		GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out &&
+		test_cmp $i.out ../$i || return 1
+	done
 '
 
 cd "$WORKDIR"
 test_expect_success 'cvs update (module list supports packed refs)' '
-    GIT_DIR="$SERVERDIR" git pack-refs --all &&
-    GIT_CONFIG="$git_config" cvs -n up -d 2> out &&
-    grep "cvs update: New directory \`main'\''" < out
+	GIT_DIR="$SERVERDIR" git pack-refs --all &&
+	GIT_CONFIG="$git_config" cvs -n up -d 2> out &&
+	grep "cvs update: New directory \`main'\''" < out
 '
 
 #------------
@@ -475,30 +501,30 @@ test_expect_success 'cvs update (module list supports packed refs)' '
 
 cd "$WORKDIR"
 test_expect_success 'cvs status' '
-    mkdir status.dir &&
-    echo Line > status.dir/status.file &&
-    echo Line > status.file &&
-    git add status.dir status.file &&
-    git commit -q -m "Status test" &&
-    git push gitcvs.git >/dev/null &&
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs update &&
-    GIT_CONFIG="$git_config" cvs status | grep "^File: status.file" >../out &&
-    test_line_count = 2 ../out
+	mkdir status.dir &&
+	echo Line > status.dir/status.file &&
+	echo Line > status.file &&
+	git add status.dir status.file &&
+	git commit -q -m "Status test" &&
+	git push gitcvs.git >/dev/null &&
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs update &&
+	GIT_CONFIG="$git_config" cvs status | grep "^File: status.file" >../out &&
+	test_line_count = 2 ../out
 '
 
 cd "$WORKDIR"
 test_expect_success 'cvs status (nonrecursive)' '
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs status -l | grep "^File: status.file" >../out &&
-    test_line_count = 1 ../out
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs status -l | grep "^File: status.file" >../out &&
+	test_line_count = 1 ../out
 '
 
 cd "$WORKDIR"
 test_expect_success 'cvs status (no subdirs in header)' '
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs status | grep ^File: >../out &&
-    ! grep / <../out
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs status | grep ^File: >../out &&
+	! grep / <../out
 '
 
 #------------
@@ -507,9 +533,9 @@ test_expect_success 'cvs status (no subdirs in header)' '
 
 cd "$WORKDIR"
 test_expect_success 'cvs co -c (shows module database)' '
-    GIT_CONFIG="$git_config" cvs co -c > out &&
-    grep "^main[	 ][ 	]*main$" <out &&
-    ! grep -v "^main[	 ][ 	]*main$" <out
+	GIT_CONFIG="$git_config" cvs co -c > out &&
+	grep "^main[	 ][ 	]*main$" <out &&
+	! grep -v "^main[	 ][ 	]*main$" <out
 '
 
 #------------
@@ -575,11 +601,11 @@ expectStat="$?"
 
 cd "$WORKDIR"
 test_expect_success 'cvs log' '
-    cd cvswork &&
-    test x"$expectStat" = x"0" &&
-    GIT_CONFIG="$git_config" cvs log merge >../out &&
-    sed -e "s%2[0-9][0-9][0-9]/[01][0-9]/[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]%__DATE__%" ../out > ../actual &&
-    test_cmp ../expect ../actual
+	cd cvswork &&
+	test x"$expectStat" = x"0" &&
+	GIT_CONFIG="$git_config" cvs log merge >../out &&
+sed -e "s%2[0-9][0-9][0-9]/[01][0-9]/[0-3][0-9] [0-2][0-9]:[0-5][0-9]:[0-5][0-9]%__DATE__%" ../out > ../actual &&
+	test_cmp ../expect ../actual
 '
 
 #------------
@@ -588,11 +614,11 @@ test_expect_success 'cvs log' '
 
 cd "$WORKDIR"
 test_expect_success 'cvs annotate' '
-    cd cvswork &&
-    GIT_CONFIG="$git_config" cvs annotate merge >../out &&
-    sed -e "s/ .*//" ../out >../actual &&
-    printf "1.%d\n" 3 1 1 1 1 1 1 1 2 4 >../expect &&
-    test_cmp ../expect ../actual
+	cd cvswork &&
+	GIT_CONFIG="$git_config" cvs annotate merge >../out &&
+	sed -e "s/ .*//" ../out >../actual &&
+	printf "1.%d\n" 3 1 1 1 1 1 1 1 2 4 >../expect &&
+	test_cmp ../expect ../actual
 '
 
 #------------
-- 
gitgitgadget
