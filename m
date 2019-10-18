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
	by dcvr.yhbt.net (Postfix) with ESMTP id 02A471F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390907AbfJRWLQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:11:16 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:36063 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390635AbfJRWKq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:46 -0400
Received: by mail-pl1-f169.google.com with SMTP id j11so3502951plk.3
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1kH/H9/UmTiuH43xd3spo4dKsgimlvugG7wwdcA5ZSk=;
        b=OfAqurwDJcrY/wJwMwuuFadx0Uq+nZBTIK8g2dDIjzPMBcpuMvbbP4m29mVYEaahV7
         Km7MqfV4DkWG+DJ5wfEtz3K/Ul46qWAbOGf1cW3e4U3cbsj80crnWWyGWFBR0IYJI+41
         AVHvABrKacwhnF2e8m4l34KXY/088WcqnRvdizKrt7mugoMSfkoO3upKWcNe/3SMM23w
         dJj3wQzFLeF+DjeXJ7Jq0fZbm4SF0Yzat5/uQA8klVDxzGEpmf3kwKToJW8QsRtpBtH+
         dN8mxqnOKGatyvDwMhcPK80n/9yGXIxuUKGWJ3S/GM4q3TxxgxjufxUzI7dZtQKagAGK
         y6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1kH/H9/UmTiuH43xd3spo4dKsgimlvugG7wwdcA5ZSk=;
        b=RTjrZ0IMV086cWqtn5d3bL4Fs/S87Q9OJXYXobOjMoT9AFz1PvMLY7UfghcKIxeN5F
         v2+pU3oT82abN9JS3RRvFGxqcDk1iYVUQWfgzjPCriMzsOomcDx8UsIh3AolQAvTnsJG
         T3xMUZ2fnWKvFDqklmQOruICBNQ1BQdHr93k4bPgYKeyWTwfg7JXBBS8MQAolLwSH6H8
         IZOoTGgp/7m7Wl+/pGs1UV9Bibgi9ARSkuqMxl/lFMBgXM9nDNbndf3j0WX5lY/2ViCo
         xPcXt+ciA7nKVu5WlbgooSn1QfyAdYW64FGFj+frQTLsp72rXJ7P2MgqXXgwUq8IzDkf
         A++w==
X-Gm-Message-State: APjAAAVAwZJLhCRGrQulek4vrs6m3W06wFJdzjwmgO8x5Zz41lE+1vsj
        GhqOb4KsV0BhPRb2V64n0UZtQ/uJ
X-Google-Smtp-Source: APXvYqyzCYUK09v/RTfLDLmjk/ZRjrakuNU+jrEm+TeckcIyLlZJINyxx394Zx0uwlSp2HiaG/R2hQ==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr11325957pls.120.1571436645270;
        Fri, 18 Oct 2019 15:10:45 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id i187sm9449067pfc.177.2019.10.18.15.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:44 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:42 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 10/15] t5520: use test_cmp_rev where possible
Message-ID: <1a54db1d5ce6dde8f3526d19b617b7587acba851.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
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
	s/test "$(git rev-parse.* \([^)]*\))" != "$(git rev-parse.* \([^)]*\))"/test_cmp_rev ! \1 \2/
	s/test \([^ ]*\) != "$(git rev-parse.* \([^)]*\))"/test_cmp_rev ! \1 \2/

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 50 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 18225d8430..1af6ea06ee 100755
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
+	test_cmp_rev ! HEAD^ copy &&
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
+	test_cmp_rev ! "$COPY" me/copy
 '
 
 test_expect_success 'pull --rebase works on branch yet to be born' '
-- 
2.23.0.897.g0a19638b1e

