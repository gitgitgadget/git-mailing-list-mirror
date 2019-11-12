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
	by dcvr.yhbt.net (Postfix) with ESMTP id B3D311F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 23:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKLXIL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 18:08:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40266 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfKLXIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 18:08:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id r4so167629pfl.7
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 15:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/vecAnN5VtAlJJ/1jgmDMCYE43BgNyJCxBqq8yrlct0=;
        b=oQ+8fVw/b9e+smzEhcFgpJFuJ8nP0uUx4hvI8U4b6qasDO9oPjEz+ffn9b1nQ7GC/c
         0NSeC6O/GAcWA/6N/drgjXWJMPxTnNneCHiuMKdaNsD6SK2AfTOgP/5Tzw15J56G4WeX
         zrkd+SWJPYYi/TiLBJDvwLFZE3g399mSk2MU1UNbaNTkDNcLi97/JmSyOKVq+Khe5pKc
         kh6TqNwp9Dm2Czfa9EYUe/NX8gGmGTg1bi/BzoF2nRVLOSgKJD4ytXpxK0mV2xoVLsI7
         0qHe5eqbswWSydFUyecOrernjPba2/zub9zyr1tYfOFvRbCjng9ejBo06cNTHaKDXwms
         ZLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/vecAnN5VtAlJJ/1jgmDMCYE43BgNyJCxBqq8yrlct0=;
        b=P7f/39fAw6p6sxCGHNYoI7DFpsjyu0f/Qqw+CYu+8k+BRNXJEcoE9/jpe2XDhkg9P5
         NCUvs76CTu1be7SMEFFh7uaJwGvcnQuzp0b5L8LCykvEyjVmNIw8CiHVmgtvahdwq5Dj
         8lvH1oAJmnfiUKZR9Jgx+J9tua6jkDZT85icg2Zebb08nEhIgDTCWvRBV2U4tNCv+L0R
         udOUMzk1upB+M+95s5GLJpqxnbYQxxOcM6xCHJBXwOSsaBNRpmkFjBfYZf+Cz+Yr26Xd
         p7MCGeYzmkcFIVK7UXD4KJO/dzkckAWn8F8rze43fTDps+zOYJaxPDhrV77/4eG5VEGG
         YGLA==
X-Gm-Message-State: APjAAAXRd5RK2vGXPpxkfl8iix13kFM4nQYnqJW80iDos3uI+qpONNbs
        ZsBHwcLcSmqow2YGIvUBsrda/YgZ
X-Google-Smtp-Source: APXvYqy+zN4keq1TMjjOOC8j1ha2a5QqaUOeZeYNgoRvhh5cCvD1fn1EY4HWeYBk/ilEqLjjL9qe3g==
X-Received: by 2002:a17:90a:2a41:: with SMTP id d1mr388499pjg.87.1573600089908;
        Tue, 12 Nov 2019 15:08:09 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id c21sm64804pgh.25.2019.11.12.15.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:08:08 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:08:07 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 10/14] t5520: test single-line files by git with test_cmp
Message-ID: <73004d6cc354493cab1116e5f4a2021ec05ad05d.1573595985.git.liu.denton@gmail.com>
References: <cover.1573517561.git.liu.denton@gmail.com>
 <cover.1573595985.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573595985.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case an invocation of a git command fails within the command
substitution, the failure will be masked. Replace the command
substitution with a file-redirection and a call to test_cmp.

This change was done with the following GNU sed expressions:

	s/\(\s*\)test \([^ ]*\) = "$(\(git [^)]*\))"/\1echo \2 >expect \&\&\n\1\3 >actual \&\&\n\1test_cmp expect actual/
	s/\(\s*\)test "$(\(git [^)]*\))" = \([^ ]*\)/\1echo \3 >expect \&\&\n\1\2 >actual \&\&\n\1test_cmp expect actual/

A future patch will clean up situations where we have multiple duplicate
statements within a test case. This is done to keep this patch purely
mechanical.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 64 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 1af6ea06ee..8b7e7ae55d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -255,7 +255,9 @@ test_expect_success '--rebase' '
 	git tag before-rebase &&
 	git pull --rebase . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--rebase fast forward' '
@@ -330,7 +332,9 @@ test_expect_success '--rebase fails with multiple branches' '
 	test_must_fail git pull --rebase . copy master 2>err &&
 	test_cmp_rev HEAD before-rebase &&
 	test_i18ngrep "Cannot rebase onto multiple branches" err &&
-	test modified = "$(git show HEAD:file)"
+	echo modified >expect &&
+	git show HEAD:file >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
@@ -381,7 +385,9 @@ test_expect_success 'pull.rebase' '
 	test_config pull.rebase true &&
 	git pull . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull --autostash & pull.rebase=true' '
@@ -399,7 +405,9 @@ test_expect_success 'branch.to-rebase.rebase' '
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
@@ -408,14 +416,18 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
 	test_cmp_rev ! HEAD^ copy &&
-	test new = "$(git show HEAD:file2)"
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)" &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
 
@@ -423,7 +435,9 @@ test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
 	test_cmp_rev HEAD^ copy &&
-	test new = "$(git show HEAD:file2)" &&
+	echo new >expect &&
+	git show HEAD:file2 >actual &&
+	test_cmp expect actual &&
 	test_i18ngrep ! "verify-signatures" err
 '
 
@@ -445,7 +459,9 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	git pull . copy &&
 	test_cmp_rev HEAD^1 before-preserve-rebase &&
 	test_cmp_rev HEAD^2 copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull.rebase=true flattens keep-merge' '
@@ -453,7 +469,9 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
 	test_config pull.rebase true &&
 	git pull . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
@@ -461,7 +479,9 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	test_config pull.rebase 1 &&
 	git pull . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success REBASE_P \
@@ -507,7 +527,9 @@ test_expect_success '--rebase=false create a new merge commit' '
 	git pull --rebase=false . copy &&
 	test_cmp_rev HEAD^1 before-preserve-rebase &&
 	test_cmp_rev HEAD^2 copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--rebase=true rebases and flattens keep-merge' '
@@ -515,7 +537,9 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success REBASE_P \
@@ -537,7 +561,9 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
 	test_cmp_rev HEAD^^ copy &&
-	test file3 = "$(git show HEAD:file3.t)"
+	echo file3 >expect &&
+	git show HEAD:file3.t >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--rebase with rebased upstream' '
@@ -622,10 +648,16 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 		cd empty_repo2 &&
 		echo staged-file >staged-file &&
 		git add staged-file &&
-		test "$(git ls-files)" = staged-file &&
+		echo staged-file >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual &&
 		test_must_fail git pull --rebase .. master 2>err &&
-		test "$(git ls-files)" = staged-file &&
-		test "$(git show :staged-file)" = staged-file &&
+		echo staged-file >expect &&
+		git ls-files >actual &&
+		test_cmp expect actual &&
+		echo staged-file >expect &&
+		git show :staged-file >actual &&
+		test_cmp expect actual &&
 		test_i18ngrep "unborn branch with changes added to the index" err
 	)
 '
-- 
2.24.0.346.gee0de6d492

