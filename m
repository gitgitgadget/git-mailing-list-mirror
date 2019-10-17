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
	by dcvr.yhbt.net (Postfix) with ESMTP id DCBA81F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441774AbfJQXRS (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:18 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:44882 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441765AbfJQXRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:16 -0400
Received: by mail-pf1-f171.google.com with SMTP id q21so2587093pfn.11
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h1FQkA6wcxi7jDa6pSaVR/LK5GDZFewlwUK5sOA5UrU=;
        b=lF4ovz1WkmKLjEPo/y7BI7PTzW8/SK+yzPOGO1lGDPcfNnAn7EaeVA93L/GqsplIaZ
         m38N1owJ1EFCCmkijsio3YMcjOEluhuyk/13hQtQpyrGb8ouFD8OvGzeXrmWxFakEFKJ
         0ZpnDz4FbhwQb4dA2CFQmUBnABpjiKWoRbAz2waDh+opY9hskYqnmzKowdV6BRuNPori
         1nmtSgQeRRgwvyJgvpoD8jyh4uZvlYAtPOCLa6UHmYdWNLFkJ2Qr3uK3qOz85KZiufFi
         1yfr+vw+PukJ5f4OcX39ucS+Gwf4jhdyibxK36S3UFssdeM5YsZJ8AObnU7dO3qs9Wde
         adZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h1FQkA6wcxi7jDa6pSaVR/LK5GDZFewlwUK5sOA5UrU=;
        b=gNXdgHNCiTglGY2Sp5LMzD/mxVYP/h1fyGnqiQ20IeCMUA0wko/ux9QYMgZ+i5Noi9
         Bn2CzhjmYsAjp5agVDk5dDbpLZxI5vOkU9N2y+OYW6OPjevhvW07T9mhKUhIHTRQGN1B
         Aq2hTtVUOTVyQ2OYQFg67HD0ALr9+FUOUONwCGGtWun0VMrDi2tVoBnFlLBnb+pqkQuB
         OdPuiNumxcZ+uxbju5wAzjg4caPb0gAh3ztQ+eZppOqnlAbNH4wOJ3b60quZfiztPI9g
         on5bhYIcfGpe1q/PL2sJMiXwcEL6JNpwMtDh2csj0TGfLj6yZYx++hMhqsJDxb6VVE5k
         u3Zg==
X-Gm-Message-State: APjAAAUbEJrqoPEDOO4qFi2HsjzcX0jD7gYMeJFyydkqw6MJOImoNvWG
        DOeIKEdLUitaoLR4dOd7tLbXRyvQ
X-Google-Smtp-Source: APXvYqz+4JlrI0T8sxdgcw0eH8PGEyroiOntyu09slbUmFgc4nNMhKvvGYGA/bAq7IHzdnN5njB8Gg==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr6647867pgb.185.1571354233783;
        Thu, 17 Oct 2019 16:17:13 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id w189sm4057241pfw.101.2019.10.17.16.17.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:13 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:11 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 08/12] t5520: use test_cmp_rev where possible
Message-ID: <ff05a0a8f7dc91d988e290b7d606e8a64f5daf54.1571354136.git.liu.denton@gmail.com>
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

In case an invocation of `git rev-list` fails within the subshell, the
failure will be masked. Remove the subshell and use test_cmp_rev() so
that failures can be discovered.

This change was done with the following sed expressions:

	s/test "$(git rev-parse.* \([^)]*\))" = "$(git rev-parse \([^)]*\))"/test_cmp_rev \1 \2/
	s/test \([^ ]*\) = "$(git rev-parse.* \([^)]*\))"/test_cmp_rev \1 \2/
	s/test "$(git rev-parse.* \([^)]*\))" != "$(git rev-parse.* \([^)]*\))"/test_must_fail test_cmp_rev \1 \2/
	s/test \([^ ]*\) != "$(git rev-parse.* \([^)]*\))"/test_must_fail test_cmp_rev \1 \2/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c7797b13e6..f11fadc075 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -230,7 +230,7 @@ test_expect_success 'fast-forwards working tree if branch head is updated' '
 	git pull . second:third 2>err &&
 	test_i18ngrep "fetch updated the current branch head" err &&
 	test "$(cat file)" = modified &&
-	test "$(git rev-parse third)" = "$(git rev-parse second)"
+	test_cmp_rev third second
 '
 
 test_expect_success 'fast-forward fails with conflicting work tree' '
@@ -241,7 +241,7 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 	test_must_fail git pull . second:third 2>err &&
 	test_i18ngrep "Cannot fast-forward your working tree" err &&
 	test "$(cat file)" = conflict &&
-	test "$(git rev-parse third)" = "$(git rev-parse second)"
+	test_cmp_rev third second
 '
 
 test_expect_success '--rebase' '
@@ -254,7 +254,7 @@ test_expect_success '--rebase' '
 	git commit -m "new file" &&
 	git tag before-rebase &&
 	git pull --rebase . copy &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
@@ -266,7 +266,7 @@ test_expect_success '--rebase fast forward' '
 
 	git checkout to-rebase &&
 	git pull --rebase . ff &&
-	test "$(git rev-parse HEAD)" = "$(git rev-parse ff)" &&
+	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
 	git reflog -1 >reflog.actual &&
@@ -290,7 +290,7 @@ test_expect_success '--rebase --autostash fast forward' '
 	git checkout behind &&
 	echo dirty >file &&
 	git pull --rebase --autostash . to-rebase-ff &&
-	test "$(git rev-parse HEAD)" = "$(git rev-parse to-rebase-ff)"
+	test_cmp_rev HEAD to-rebase-ff
 '
 
 test_expect_success '--rebase with conflicts shows advice' '
@@ -328,7 +328,7 @@ test_expect_success 'failed --rebase shows advice' '
 test_expect_success '--rebase fails with multiple branches' '
 	git reset --hard before-rebase &&
 	test_must_fail git pull --rebase . copy master 2>err &&
-	test "$(git rev-parse HEAD)" = "$(git rev-parse before-rebase)" &&
+	test_cmp_rev HEAD before-rebase &&
 	test_i18ngrep "Cannot rebase onto multiple branches" err &&
 	test modified = "$(git show HEAD:file)"
 '
@@ -380,7 +380,7 @@ test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
@@ -398,7 +398,7 @@ test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
@@ -407,14 +407,14 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
 	test_config pull.rebase true &&
 	test_config branch.to-rebase.rebase false &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^)" != "$(git rev-parse copy)" &&
+	test_must_fail test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)"
 '
 
 test_expect_success 'pull --rebase warns on --verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --verify-signatures . copy 2>err &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)" &&
 	test_i18ngrep "ignoring --verify-signatures for rebase" err
 '
@@ -422,7 +422,7 @@ test_expect_success 'pull --rebase warns on --verify-signatures' '
 test_expect_success 'pull --rebase does not warn on --no-verify-signatures' '
 	git reset --hard before-rebase &&
 	git pull --rebase --no-verify-signatures . copy 2>err &&
-	test "$(git rev-parse HEAD^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^ copy &&
 	test new = "$(git show HEAD:file2)" &&
 	test_i18ngrep ! "verify-signatures" err
 '
@@ -443,8 +443,8 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase false &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -452,7 +452,7 @@ test_expect_success 'pull.rebase=true flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -460,7 +460,7 @@ test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase 1 &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -469,8 +469,8 @@ test_expect_success REBASE_P \
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
 '
 
 test_expect_success 'pull.rebase=interactive' '
@@ -505,8 +505,8 @@ test_expect_success '--rebase=false create a new merge commit' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=false . copy &&
-	test "$(git rev-parse HEAD^1)" = "$(git rev-parse before-preserve-rebase)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^1 before-preserve-rebase &&
+	test_cmp_rev HEAD^2 copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -514,7 +514,7 @@ test_expect_success '--rebase=true rebases and flattens keep-merge' '
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase=true . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -523,8 +523,8 @@ test_expect_success REBASE_P \
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase true &&
 	git pull --rebase=preserve . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
-	test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
+	test_cmp_rev HEAD^^ copy &&
+	test_cmp_rev HEAD^2 keep-merge
 '
 
 test_expect_success '--rebase=invalid fails' '
@@ -536,7 +536,7 @@ test_expect_success '--rebase overrides pull.rebase=preserve and flattens keep-m
 	git reset --hard before-preserve-rebase &&
 	test_config pull.rebase preserve &&
 	git pull --rebase . copy &&
-	test "$(git rev-parse HEAD^^)" = "$(git rev-parse copy)" &&
+	test_cmp_rev HEAD^^ copy &&
 	test file3 = "$(git show HEAD:file3.t)"
 '
 
@@ -597,10 +597,10 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
-	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
+	test_cmp_rev "$COPY" me/copy &&
 	git checkout HEAD -- file &&
 	git pull &&
-	test "$COPY" != "$(git rev-parse --verify me/copy)"
+	test_must_fail test_cmp_rev "$COPY" me/copy
 '
 
 test_expect_success 'pull --rebase works on branch yet to be born' '
-- 
2.23.0.897.g0a19638b1e

