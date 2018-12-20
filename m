Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C0FD1F405
	for <e@80x24.org>; Thu, 20 Dec 2018 21:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbeLTVsg (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 16:48:36 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46188 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLTVsf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 16:48:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so3238385wrt.13
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 13:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfLzGBXzVFWCX+D00aTNf+mPu3wJyzdKZS5tiU/zKXY=;
        b=RiHEe4SJFpVccGw/zyaj4TAqtexbjB8gK7Fb8uLtNn4NyuCMcTf18w6zDS+Co94p4A
         IjYI7ied150ikEjqnZFH2RjG3BXCiEBoFm2zSEz8mHLQ5St8/mq4l6p42d2vXPJBMZRN
         NNb+L5L5A0NqmS8OEDy7l+SRduk8Cc+SHiBE8hl9TppjhvgXWUl9FuevxOMmpW0jUIyF
         3Kpw58KHYP/t7Lx1aEe+uWJsgaxcUqlv368TjlxMtmbJjb50vDXu3iPFV/8ANcHfkO8H
         TyQy5/QWBVgFaNfTi0Jwu1+yhKNuuMWKDqU1L6PY4G2BTd87Wj6ScrFQ8q3GifLOXnU8
         jSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WfLzGBXzVFWCX+D00aTNf+mPu3wJyzdKZS5tiU/zKXY=;
        b=NaLAn6SobaVcpHpIR/O1JaEVg7ZnCC6Pv10hojHSZyYlEiVoLn9l/t70qgeri/I6pG
         78aRV19i4g+s+8pAwv3uYwkJjuObYXKCkwnVOWW7QwlkOzvYLgVw4DPFuNCvYY0sNvs5
         crcCsB2oKEXpQB2LX/RrnNEuBSkdjJBe6xdePuv4JgKavfzKn4r7NYnLr8PTzqwAbh/f
         WRkf7xXiLUtbI6UtyqoGAcmQEBZtVVRdm4nG6Zixh7DpEkD35T2keYp7jTjQBQQf0P7i
         gvlhXgLdrXIjBWHP+R990d4WZwaBUEe2Gnojz5LFxTjwkG/lWz0yR+g2XkCHuJM/zAaE
         7chQ==
X-Gm-Message-State: AA+aEWbLPvvn6hoGvZkSXILWMWCT+qha6NsHiP7WpyA8d1ymD399/8/2
        1cUAQ8n1LX+zZOfle4m/C9VwsGhg
X-Google-Smtp-Source: AFSGD/Ueh32Q7FHX97d2HS+I8LGI+ZbnRK+EyoPchIIlxwcLQl/qjT9+V85PHvTcb6C7Ad4C5oGyag==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr24900262wrv.123.1545342512124;
        Thu, 20 Dec 2018 13:48:32 -0800 (PST)
Received: from localhost.localdomain ([95.86.125.58])
        by smtp.gmail.com with ESMTPSA id t5sm8620006wmg.43.2018.12.20.13.48.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:48:31 -0800 (PST)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH 1/2] t5403: Refactor
Date:   Thu, 20 Dec 2018 23:48:22 +0200
Message-Id: <20181220214823.21378-1-orgads@gmail.com>
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
index fc898c9eac..7e941537f9 100755
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
+    test_commit two &&
+    test_commit three three &&
+    mv .git/hooks-disabled .git/hooks
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
+    read old new flag < .git/post-checkout.args &&
 	test $old = $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
-	GIT_DIR=clone2/.git git checkout new2 &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	git checkout two &&
+    read old new flag < .git/post-checkout.args &&
 	test $old != $new && test $flag = 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
-	GIT_DIR=clone2/.git git checkout master b &&
-	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
-	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
-	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
+	git checkout master -- three &&
+    read old new flag < .git/post-checkout.args &&
 	test $old = $new && test $flag = 0
 '
 
-- 
2.20.1

