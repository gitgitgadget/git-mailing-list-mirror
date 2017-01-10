Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0220520756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbdAJUnV (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:21 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33367 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdAJUmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:43 -0500
Received: by mail-qk0-f172.google.com with SMTP id s140so165030898qke.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdEzJNbpgJArW6rlTAjYKiAI6ggFPHNW987A6mk0BgM=;
        b=nKdYDzTen7cPaWpfPQpgQT09gy+6vk+vcz09f7jj7FLxfKhVMCk5A86v5pM1YliHoF
         uYsjZu05insXx9moq8Mqalkgpym5+VkLoxuPqfoZs4YWJVgTHh+TDsLp2oSII5R8UnS6
         r3gpgcmGhNOS88laE8Yk/xzeNSjZHVvx1xSb3BM7v/WSE0G1C6T9UIog6dcPoGFkY+CD
         ZR0bVX9yqbYhIh2mP/MUQVeD4OeB5mH9dIVPI5g1SoDAl2zvEzlazP4oMXnN87BTgNMk
         1LOEQOuXHu98SIJOB1jleJktR8fP1oJEoflGbDsa2an14dhglHhxzP2co4M+SXo0xTMa
         MBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdEzJNbpgJArW6rlTAjYKiAI6ggFPHNW987A6mk0BgM=;
        b=ucv2z4NhucnqCdjDByRn+oVzjkIzq3i1ZotZUUt/+pSJ+jsB9FtLl2srXxzMfLjEyj
         1xouL4Myydg4ORp3yMIdDfPTLKKckrV79CfJ5DT0JKUKVKZg4pnocQJlGmaxtblJ1+0N
         e+Hq8k2iq7xWk4WT5JZAGszoCIF1I+D2noP2k0QD4YP2xSILoeCLWgz6frnr5iKd8fEM
         F0mMKRhr9x3sZU9i2zJfFPulnZs5IvjwHuOAnIGc1ncgW9JVrkPT0A8IQiJ71puu6v5u
         GdQA9QRlwqlWMJBm/YieT4VVdCtaE8DmVgr5vGk+oEU1kZmOEx8rbttiAlSpva7T60YT
         o0gQ==
X-Gm-Message-State: AIkVDXIpWurBdjefxKN2O6KwP5OfkaFI6vb6F1K0Sd6cPpvV8Z0l1TTE8JrcjfQYhCLS1184
X-Received: by 10.55.137.197 with SMTP id l188mr4764811qkd.94.1484080961852;
        Tue, 10 Jan 2017 12:42:41 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:41 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 04/14] t7610: Move setup code to the 'setup' test case.
Date:   Tue, 10 Jan 2017 15:41:52 -0500
Message-Id: <20170110204202.21779-5-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple test cases depend on these hunks, so move them to the 'setup'
test case.  This is a step toward making the tests more independent so
that if one test fails it doesn't cause subsequent tests to fail.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 65 ++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 14090739f..550838a1c 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -55,6 +55,22 @@ test_expect_success 'setup' '
 	git rm file12 &&
 	git commit -m "branch1 changes" &&
 
+	git checkout -b delete-base branch1 &&
+	mkdir -p a/a &&
+	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
+	git add a/a/file.txt &&
+	git commit -m"base file" &&
+	git checkout -b move-to-b delete-base &&
+	mkdir -p b/b &&
+	git mv a/a/file.txt b/b/file.txt &&
+	(echo one; echo two; echo 4) >b/b/file.txt &&
+	git commit -a -m"move to b" &&
+	git checkout -b move-to-c delete-base &&
+	mkdir -p c/c &&
+	git mv a/a/file.txt c/c/file.txt &&
+	(echo one; echo two; echo 3) >c/c/file.txt &&
+	git commit -a -m"move to c" &&
+
 	git checkout -b stash1 master &&
 	echo stash1 change file11 >file11 &&
 	git add file11 &&
@@ -86,6 +102,23 @@ test_expect_success 'setup' '
 	git rm file11 &&
 	git commit -m "master updates" &&
 
+	git clean -fdx &&
+	git checkout -b order-file-start master &&
+	echo start >a &&
+	echo start >b &&
+	git add a b &&
+	git commit -m start &&
+	git checkout -b order-file-side1 order-file-start &&
+	echo side1 >a &&
+	echo side1 >b &&
+	git add a b &&
+	git commit -m side1 &&
+	git checkout -b order-file-side2 order-file-start &&
+	echo side2 >a &&
+	echo side2 >b &&
+	git add a b &&
+	git commit -m side2 &&
+
 	git config merge.tool mytool &&
 	git config mergetool.mytool.cmd "cat \"\$REMOTE\" >\"\$MERGED\"" &&
 	git config mergetool.mytool.trustExitCode true &&
@@ -244,21 +277,7 @@ test_expect_success 'mergetool takes partial path' '
 '
 
 test_expect_success 'mergetool delete/delete conflict' '
-	git checkout -b delete-base branch1 &&
-	mkdir -p a/a &&
-	(echo one; echo two; echo 3; echo 4) >a/a/file.txt &&
-	git add a/a/file.txt &&
-	git commit -m"base file" &&
-	git checkout -b move-to-b delete-base &&
-	mkdir -p b/b &&
-	git mv a/a/file.txt b/b/file.txt &&
-	(echo one; echo two; echo 4) >b/b/file.txt &&
-	git commit -a -m"move to b" &&
-	git checkout -b move-to-c delete-base &&
-	mkdir -p c/c &&
-	git mv a/a/file.txt c/c/file.txt &&
-	(echo one; echo two; echo 3) >c/c/file.txt &&
-	git commit -a -m"move to c" &&
+	git checkout move-to-c &&
 	test_must_fail git merge move-to-b &&
 	echo d | git mergetool a/a/file.txt &&
 	! test -f a/a/file.txt &&
@@ -607,26 +626,12 @@ test_expect_success MKTEMP 'temporary filenames are used with mergetool.writeToT
 '
 
 test_expect_success 'diff.orderFile configuration is honored' '
+	git checkout order-file-side2 &&
 	test_config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
 	echo b >order-file &&
 	echo a >>order-file &&
-	git checkout -b order-file-start master &&
-	echo start >a &&
-	echo start >b &&
-	git add a b &&
-	git commit -m start &&
-	git checkout -b order-file-side1 order-file-start &&
-	echo side1 >a &&
-	echo side1 >b &&
-	git add a b &&
-	git commit -m side1 &&
-	git checkout -b order-file-side2 order-file-start &&
-	echo side2 >a &&
-	echo side2 >b &&
-	git add a b &&
-	git commit -m side2 &&
 	test_must_fail git merge order-file-side1 &&
 	cat >expect <<-\EOF &&
 		Merging:
-- 
2.11.0.390.gc69c2f50cf-goog

