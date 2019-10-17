Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6391F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441776AbfJQXRS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46616 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441771AbfJQXRR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so2586088pfg.13
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E0/CWs14yol2zVv7416BOcasXuIjqEFNuel7EyXMdg4=;
        b=Ksd+vjumTR5VWYyoHWaMYBPGv8RaMXFIQx84qK506899D+7rw+K8+CKPJkryzyLMso
         oGQRTWtRIY3W2qjnjBCQNBStb9aFZ3QAj/uVxApW1dH+7EHZJCJuABLq7swAl/94QPNy
         AIcGyCRuGPSCiJFrYMHOWfJAW+VB4zsjsnpOp58jGL6l/3xlA8iQYVwc7gkPNJFoDK5t
         JA0qHBu5c2/sBe8xWiB6UCWMbiaHIA23IalmsylGYCX0UtIJrNkMr8onKAQT5Ue6Nxj5
         rJ1N3FyEKzJ8gxZwcpnMCK0GGJB628J+RKVvNywPVuOqgPoD/U4kr7BJ5NdGx9qqCO5n
         q3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E0/CWs14yol2zVv7416BOcasXuIjqEFNuel7EyXMdg4=;
        b=XFkknpgqrRlmYItpw+iMM+OIi7CT1LmkLXqEM8SreT0HSOnTJfQfLvvUOGACzYXtz7
         TIV0FRDiTfSNorikjaoF04DnmBpYiGCLM7Q6negONgnVtXFU2Wkp1Tiik7+eKVMoy7QS
         rBgkLHYwzKkPMCHW7M551S3Zsy8qGQuotz2YQwlTHEYOoqYcTljP6yzb5phKcj5eQFQV
         5AjMrVrmJ+E4g6nx2hJ2at/0GIuXvHYSKgEhkJW/onO9OaInKkn3TAgcb//QeEwtajvs
         UerRHl/TGM3NjIiuS7WwN90Ad4cQYtwUEdjLgdubZflR+C4R7tmVY8GcuG8C+pxXUwUl
         xddw==
X-Gm-Message-State: APjAAAVeL1IcGvWnF+HGE40Ck49Q8VAOSAEuuWzZRv+TZh5n1q0NC0N6
        cKVefwD2e2Cdv8oO/hVMG6M38k3h
X-Google-Smtp-Source: APXvYqyE7KsXK6ehiwrJKFickHQw0gQeHU4SinynoGJk6K5TTqYVd4iSY7skDfAc1WJnRYnv0Ge1uQ==
X-Received: by 2002:a62:61c4:: with SMTP id v187mr2980271pfb.23.1571354236060;
        Thu, 17 Oct 2019 16:17:16 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 22sm4206018pfo.131.2019.10.17.16.17.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:15 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:14 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 09/12] t5520: test single-line files by git with test_cmp
Message-ID: <f1b515fc0ed431f03244eefbe9f8f34921f4c62d.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case an invocation of a Git command fails within the subshell, the
failure will be masked. Replace the subshell with a file-redirection and
a call to test_cmp.

This change was done with the following GNU sed expressions:

	s/\(\s*\)test \([^ ]*\) = "$(\(git [^)]*\))"/\1echo \2 >expect \&\&\n\1\3 >actual \&\&\n\1test_cmp expect actual/
	s/\(\s*\)test "$(\(git [^)]*\))" = \([^ ]*\)/\1echo \3 >expect \&\&\n\1\2 >actual \&\&\n\1test_cmp expect actual/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 64 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f11fadc075..0eebab7d86 100755
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
 	test_must_fail test_cmp_rev HEAD^ copy &&
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
2.23.0.897.g0a19638b1e

