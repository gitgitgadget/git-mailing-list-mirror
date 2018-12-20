Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79D981F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbeLTV4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:56:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38079 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLTV4J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:56:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so3275304wrw.5
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9ez7rg+Ye+gpvhejUVhBtLyVrqnOnUQSo1WvomeTuc=;
        b=YMg2Hq1IN34kpdHwKSRthLR+FgcJlox9mxRUyViEnBdy8vD1VjrigScw1B1S31f69H
         LYqcvAhW7SIL6158yDlorKU2nvfbjIOEo6LxJVljWXKH1np/Ftcoq1kKQ0GfT88wkHCE
         J2/uW+T7utwZ7iQfKyMpYXTcGAzqzq8ThsY/2SQj7o/5OPX4JkdRxtZ3rAiSyaETa4iJ
         fntoVoyp+u+7J6JvTOEv/tb9D4rNE4TqBFTJ9VQOqq5ZfjjeZNhR4k76vOS1G4dIH9QP
         EFF6Y9VSdrO0DLl0fCxyvCBDrRXubQs+duETCWRedJ7QhLaSvwq19hCAixK8IL5MccnI
         VIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E9ez7rg+Ye+gpvhejUVhBtLyVrqnOnUQSo1WvomeTuc=;
        b=l014Ue8pKR0OZZdDntO5Lako92os//c3H3jTkbEuArdqLdskIGbislnyszxIhgHg9n
         3P6l2HZMphBusIB95hscmazMrTUMmkvnoRXftAJr9dBWPL//4cuOR0Wlnjp/LtZsrxZ8
         nHqZme6WuiJs/gLBEMfSCk5rqB62fDlFWXFpanDli9d1P9TEp6EB47sIJoDPeSO6Ej5Z
         gO6977SO+FGc8nEBziogDZMLSfQ6wIgBTz0KuxGgGxEw2iBC4oX6gAxDItV4c+APIE4J
         FLxnkMdo1YOhwqlsScXX45QJ3QS9G7BlKrFQhnWu4w83G6KeifGlqCiA8s/uFsh73XYm
         QrYQ==
X-Gm-Message-State: AA+aEWYN8lelhtwPbrA4xs8jYq762k8zG4N9D+igRd5GuTQ4nUnP9Vy1
        ree337l3A+mKFp/L58K1ybT2vDpy
X-Google-Smtp-Source: AFSGD/UmkVnPXtmv6GykiNLIPpWebNpli2jGY9N73D+4sDoyGguGk9frTCaGANAXbw5HT8OdNWqv9w==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr24400829wrx.85.1545342967410;
        Thu, 20 Dec 2018 13:56:07 -0800 (PST)
Received: from localhost.localdomain ([95.86.125.58])
        by smtp.gmail.com with ESMTPSA id b18sm8453017wrr.43.2018.12.20.13.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:56:06 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 1/2] t5403: Refactor
Date:   Thu, 20 Dec 2018 23:55:58 +0200
Message-Id: <20181220215559.22454-1-orgads@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

* Replace multiple clones and commits by test_commits.
* Replace 3 invocations of awk by read.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 55 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 37 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index fc898c9eac..868d6f7272 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -7,67 +7,48 @@ test_description='Test the post-checkout hook.'
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo Data for commit0. >a &&
-	echo Data for commit0. >b &&
-	git update-index --add a &&
-	git update-index --add b &&
-	tree0=$(git write-tree) &&
-	commit0=$(echo setup | git commit-tree $tree0) &&
-	git update-ref refs/heads/master $commit0 &&
-	git clone ./. clone1 &&
-	git clone ./. clone2 &&
-	GIT_DIR=clone2/.git git branch new2 &&
-	echo Data for commit1. >clone2/b &&
-	GIT_DIR=clone2/.git git add clone2/b &&
-	GIT_DIR=clone2/.git git commit -m new2
+	test_commit one &&
+	test_commit two &&
+	test_commit three three &&
+	mv .git/hooks-disabled .git/hooks
 '
 
-for clone in 1 2; do
-    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
+cat >.git/hooks/post-checkout <<'EOF'
 #!/bin/sh
-echo $@ > $GIT_DIR/post-checkout.args
+echo $@ > .git/post-checkout.args
 EOF
-    chmod u+x clone${clone}/.git/hooks/post-checkout
-done
+chmod u+x .git/hooks/post-checkout
 
 test_expect_success 'post-checkout runs as expected ' '
-	GIT_DIR=clone1/.git git checkout master &&
-	test -e clone1/.git/post-checkout.args
+	git checkout master &&
+	test -e .git/post-checkout.args
 '
 
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
-	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	read old new flag < .git/post-checkout.args &&
 	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout runs as expected ' '
-	GIT_DIR=clone1/.git git checkout master &&
-	test -e clone1/.git/post-checkout.args
+	git checkout master &&
+	test -e .git/post-checkout.args
 '
 
 test_expect_success 'post-checkout args are correct with git checkout -b ' '
-	GIT_DIR=clone1/.git git checkout -b new1 &&
-	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
+	git checkout -b new1 &&
+	read old new flag < .git/post-checkout.args &&
 	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
-	GIT_DIR=clone2/.git git checkout new2 &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	git checkout two &&
+	read old new flag < .git/post-checkout.args &&
 	test $old != $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
-	GIT_DIR=clone2/.git git checkout master b &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	git checkout master -- three &&
+	read old new flag < .git/post-checkout.args &&
 	test $old = $new && test $flag = 0
 '
 
-- 
2.20.1

