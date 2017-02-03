Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031DD1FAF4
	for <e@80x24.org>; Fri,  3 Feb 2017 02:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdBCCtU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:49:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33268 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbdBCCtS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:49:18 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so1189198wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqtpLQS9N2BsfTyyAf2Tw1tFjdEMRj4IvuAohpLEXIg=;
        b=gQLuVRYt++5MixknAAXTdCR9I/Z5qm/zbLIjwP1BXVQ8psuUQr86B4ZWfCYzY0iE9Y
         kp0fwNeakf5ygLfGQ7ZDT/dmfQSJ7UhOKs1ULbcQ9DDGNQH0IqyxMmWTG0HVGKsLBOzG
         flG7WqDG5k1NNzKPhh+gbB7c6Ymi7ou0Wb5AlyikGJKFDlwYAzVdEVt2zPayhk8a52DD
         KgAkPygke340dnCj+t5pDUIoUuPmbL6bLSwppttDbGDlNnsu3goqQaTt8XHXzA59xKjI
         I94d2LorRqkUf2T/5cG6bqlKSk6ChJPFG7gaCG5rApYnR8X9Iv1XcbuXRKvdkIhwinpX
         5ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqtpLQS9N2BsfTyyAf2Tw1tFjdEMRj4IvuAohpLEXIg=;
        b=ILXhk6Hopnqj4/6uAhfNpnvAWiIdhvtIe0vPqdGgKDHxKQwlyVBadqEXo2dF3XDnun
         gSH84pR2Fl+wH8kGNu4nWWZM6p/w0dGnIaHfaIj49JI1qgMLNBV2054xV/KaZKpOvXFi
         dbXct1WxqWKsaVBSoaTLmvT14vUqQCJKNB5erEh9jy/VcoUz+oXw5N6j3UajL9llPUfF
         iFiFGOIEVCB1+eBDcG//aTbw2hpAulr/BSfcQ6c/xa5bWlcXjoSFSiV6GglwOuszEZ+l
         mu5olCDe5M3+BrXHFJOctB1krq2bN0VdXUrIvoCMw44133hKNz9wnHTgSujqmYdvnRpu
         X6hw==
X-Gm-Message-State: AIkVDXKHvWl+07ssAMpeJKgxQd+6qcnuWy7GbOeRCXkRn7h/EwKC3UPh+Pic7O1xXLKQIA==
X-Received: by 10.223.150.34 with SMTP id b31mr10368364wra.196.1486090157328;
        Thu, 02 Feb 2017 18:49:17 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id k43sm42867464wrc.46.2017.02.02.18.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:49:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 04/21] completion tests: consolidate getting path of current working directory
Date:   Fri,  3 Feb 2017 03:48:12 +0100
Message-Id: <20170203024829.8071-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203024829.8071-1-szeder.dev@gmail.com>
References: <20170203024829.8071-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests of the __gitdir() helper function use the $TRASH_DIRECTORY
variable in direct path comparisons.  In general this should be
avoided, because it might contain symbolic links.  There happens to be
no issues with this here, however, because those tests use
$TRASH_DIRECTORY both for specifying the expected result and for
specifying input which in turn is just 'echo'ed verbatim.

Other __gitdir() tests ask for the path of the trash directory by
running $(pwd -P) in each test, sometimes even twice in a single test.

Run $(pwd) only once at the beginning of the test script to store the
path of the trash directory in a variable, and use that variable in
all __gitdir() tests.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t9902-completion.sh | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 294a08cfe..030a16e77 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -124,15 +124,22 @@ invalid_variable_name='${foo.bar}'
 
 actual="$TRASH_DIRECTORY/actual"
 
+if test_have_prereq MINGW
+then
+	ROOT="$(pwd -W)"
+else
+	ROOT="$(pwd)"
+fi
+
 test_expect_success 'setup for __gitdir tests' '
 	mkdir -p subdir/subsubdir &&
 	git init otherrepo
 '
 
 test_expect_success '__gitdir - from command line (through $__git_dir)' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	(
-		__git_dir="$TRASH_DIRECTORY/otherrepo/.git" &&
+		__git_dir="$ROOT/otherrepo/.git" &&
 		__gitdir >"$actual"
 	) &&
 	test_cmp expected "$actual"
@@ -157,7 +164,7 @@ test_expect_success '__gitdir - .git directory in cwd' '
 '
 
 test_expect_success '__gitdir - .git directory in parent' '
-	echo "$(pwd -P)/.git" >expected &&
+	echo "$ROOT/.git" >expected &&
 	(
 		cd subdir/subsubdir &&
 		__gitdir >"$actual"
@@ -175,7 +182,7 @@ test_expect_success '__gitdir - cwd is a .git directory' '
 '
 
 test_expect_success '__gitdir - parent is a .git directory' '
-	echo "$(pwd -P)/.git" >expected &&
+	echo "$ROOT/.git" >expected &&
 	(
 		cd .git/refs/heads &&
 		__gitdir >"$actual"
@@ -184,9 +191,9 @@ test_expect_success '__gitdir - parent is a .git directory' '
 '
 
 test_expect_success '__gitdir - $GIT_DIR set while .git directory in cwd' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	(
-		GIT_DIR="$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR="$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		__gitdir >"$actual"
 	) &&
@@ -194,9 +201,9 @@ test_expect_success '__gitdir - $GIT_DIR set while .git directory in cwd' '
 '
 
 test_expect_success '__gitdir - $GIT_DIR set while .git directory in parent' '
-	echo "$TRASH_DIRECTORY/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	(
-		GIT_DIR="$TRASH_DIRECTORY/otherrepo/.git" &&
+		GIT_DIR="$ROOT/otherrepo/.git" &&
 		export GIT_DIR &&
 		cd subdir &&
 		__gitdir >"$actual"
@@ -206,24 +213,15 @@ test_expect_success '__gitdir - $GIT_DIR set while .git directory in parent' '
 
 test_expect_success '__gitdir - non-existing $GIT_DIR' '
 	(
-		GIT_DIR="$TRASH_DIRECTORY/non-existing" &&
+		GIT_DIR="$ROOT/non-existing" &&
 		export GIT_DIR &&
 		test_must_fail __gitdir
 	)
 '
 
-function pwd_P_W () {
-	if test_have_prereq MINGW
-	then
-		pwd -W
-	else
-		pwd -P
-	fi
-}
-
 test_expect_success '__gitdir - gitfile in cwd' '
-	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
-	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
+	echo "$ROOT/otherrepo/.git" >expected &&
+	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir &&
@@ -233,8 +231,8 @@ test_expect_success '__gitdir - gitfile in cwd' '
 '
 
 test_expect_success '__gitdir - gitfile in parent' '
-	echo "$(pwd_P_W)/otherrepo/.git" >expected &&
-	echo "gitdir: $(pwd_P_W)/otherrepo/.git" >subdir/.git &&
+	echo "$ROOT/otherrepo/.git" >expected &&
+	echo "gitdir: $ROOT/otherrepo/.git" >subdir/.git &&
 	test_when_finished "rm -f subdir/.git" &&
 	(
 		cd subdir/subsubdir &&
@@ -244,7 +242,7 @@ test_expect_success '__gitdir - gitfile in parent' '
 '
 
 test_expect_success SYMLINKS '__gitdir - resulting path avoids symlinks' '
-	echo "$(pwd -P)/otherrepo/.git" >expected &&
+	echo "$ROOT/otherrepo/.git" >expected &&
 	mkdir otherrepo/dir &&
 	test_when_finished "rm -rf otherrepo/dir" &&
 	ln -s otherrepo/dir link &&
-- 
2.11.0.555.g967c1bcb3

