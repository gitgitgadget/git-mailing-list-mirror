Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13FA1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 11:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbeGWM2b (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 08:28:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44599 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGWM2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 08:28:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so163383pgp.11
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 04:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZJ+69HYdeKj5PGElAk9gcpat2FXWGbpE4y/vwDb75sc=;
        b=KUdezCrcWkVa5S88I8V8OyoXc5OWnFrxjs/hFF+1sf1O68PFscVAWHqKsGOsM/4oij
         CP2Lqbg9GdxYC2UBDM6mVP+2nuUIGMKCC+ISKMRTT1wynFA5RoBG1ldP7Gz/yemR4Q2d
         qJD/vAt4FkmvXtkKbg6+0/BhiL8hiFU6k4J9uJvCxUirykfYAH5bb1nq3gleih+eUGIA
         c1qF23qlYtziSfh4+F8VyJr2pAaflNw9da6Lm8ZU/BVVG0TxGXBNYI0+YxN7djswev2f
         YLhqQqw3clfgHALSHdyxQPKK5shcHueGQYRXyiQ4rlZTEUz6npDt/XC5hrlhdg17y1Bq
         GzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZJ+69HYdeKj5PGElAk9gcpat2FXWGbpE4y/vwDb75sc=;
        b=uRzDXixSPOtBbrjqQUgSlI4rhITjvKYmuUZPi0ri3ADmMQEiXh3w3nkh4gFp8UvfPa
         7XRzmpBmpCENZjQhxLu4PCyhniE5h9Iz1vGBDCQybTWu5klsHVkRtdmZ5mNA5M0yE2yZ
         seGQnmFbTG8TWP/+PiKNn0mpZIFeD9hAIX+WjVp+P5pQChiqyRm9RipDHLS1pNwdHRaW
         zk/Z216vZRVz/oy1F660AmT2LhDIhxvK5EfG2oQfNZGeoZpzTVU205JVK7zUzv1CtSKA
         sB3XI0UBl30wKvBG9MWKHEfVS9DSgnPTFq4yJf1waEJRgd97jjJ0sZB4FRUrx47VhuAi
         A7dw==
X-Gm-Message-State: AOUpUlGfaiknKWvzGn8taxlZi1ji+ROe++FaUq/qpYDTJD1gYsVw8dXk
        ECtUobluOTurZaM/Nqli50f8mXWw
X-Google-Smtp-Source: AAOMgpdpkq8VO+7msFK9pjOMyxl5OY2kAh4GLmqrC86BWU1dH/dVZp5Jgh6N+YtsMd+5pyzxypKUIg==
X-Received: by 2002:a62:4147:: with SMTP id o68-v6mr12711578pfa.111.1532345265283;
        Mon, 23 Jul 2018 04:27:45 -0700 (PDT)
Received: from localhost.localdomain ([110.175.42.185])
        by smtp.gmail.com with ESMTPSA id m21-v6sm10435472pgv.27.2018.07.23.04.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 04:27:43 -0700 (PDT)
From:   Chen Bin <chenbin.sh@gmail.com>
To:     git@vger.kernel.org
Cc:     Chen Bin <chenbin.sh@gmail.com>
Subject: [PATCH 1/1] add hook pre-p4-submit
Date:   Mon, 23 Jul 2018 21:27:36 +1000
Message-Id: <20180723112736.15088-1-chenbin.sh@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hook pre-p4-submit is executed before git-p4 actually submits code.
If the hook exits with non-zero value, submit process will abort.

Signed-off-by: Chen Bin <chenbin.sh@gmail.com>
---
 git-p4.py               |  6 ++++++
 t/t9800-git-p4-basic.sh | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index b449db1cc..69ee9ce41 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2303,6 +2303,12 @@ def run(self, args):
             sys.exit("number of commits (%d) must match number of shelved changelist (%d)" %
                      (len(commits), num_shelves))
 
+        # locate hook at `.git/hooks/pre-p4-submit`
+        hook_file = os.path.join(read_pipe("git rev-parse --git-dir").strip(), "hooks", "pre-p4-submit")
+        # Execute hook. If it exit with non-zero value, do NOT continue.
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file]) != 0:
+            sys.exit(1)
+
         #
         # Apply the commits, one at a time.  On failure, ask if should
         # continue to try the rest of the patches, or quit.
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 4849edc4e..48b768fa7 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -261,6 +261,28 @@ test_expect_success 'unresolvable host in P4PORT should display error' '
 	)
 '
 
+# Test following scenarios:
+#   - Without hook ".git/hooks/pre-p4-submit", submit should continue
+#   - With hook returning 0, submit should continue
+#   - With hook returning 1, submit should abort
+test_expect_success 'run hook pre-p4-submit before submit' '
+	test_when_finished cleanup_git &&
+	git p4 clone --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		echo "hello world" >hello.txt &&
+		git add hello.txt &&
+		git commit -m "add hello.txt" &&
+		git config git-p4.skipSubmitEdit true &&
+		git p4 submit --dry-run | grep "Would apply" &&
+		mkdir -p .git/hooks &&
+		: >.git/hooks/pre-p4-submit && chmod +x .git/hooks/pre-p4-submit &&
+		git p4 submit --dry-run | grep "Would apply" &&
+		echo #!/bin/sh && echo exit 1 >.git/hooks/pre-p4-submit &&
+		git p4 submit --dry-run | grep "Would apply" || echo "Abort submit"
+	)
+'
+
 test_expect_success 'submit from detached head' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
-- 
2.18.0

