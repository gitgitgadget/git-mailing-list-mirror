Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1582C25B0E
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 07:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbiHRHGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243225AbiHRHGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 03:06:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11CB876AE
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:06:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2392866wmk.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 00:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=DArugEmCjYz039HJputmnA5s3tQbmRrT5AgwtC10kXQ=;
        b=DqtjZbgC4QyJSrWse4sBNfd2Wneim0A2W7mOHgojiJ8cNPtmWzmw5mxld05YnAbx3W
         lNncvAqftSGVG0lUPwlosZhwb0VPAgmiIfvWQ/fyVgBrkVbGSK1rr8Kl8RKq5WVMtzXj
         OOfnGH55S25V7Np74BpI2SmWHssUvb96lBc3VUqph8D1/95ItpZG077OpWXwRQVXRezn
         /jS+DLrbiOwP8D9L3ThyYmT8YOoZpMpkMtkkNwa4/o+bwDlnism99RN6UHGOYtbgMgYe
         9jMEFIAhEyVv+XwHMiuSjiFG+EHwy0ZjF8TDXW7fGqqniENvMkXhDcnZdUMBMdFRWIfV
         4GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=DArugEmCjYz039HJputmnA5s3tQbmRrT5AgwtC10kXQ=;
        b=1hqOSRwcTiDjOUQJshvUiiGnS40DlQ6SmNBj/1cDSO5Lxae/x+Cud6IePAZz+NEb2R
         AlPro5TVS+Qu9icEXGGNnFD3MPOJrzFpsM0ASimY5Px9q4juJLv2KNKmbqbCcMaEBUQS
         ZqsMc/8lNY1xDx0lIrS8DtACsNjVhlg+ejhvyqQyrOr6/bN6nASmCNKZ77CQCznHf8hN
         0LUYUbZM29pRRRy0OBzgDcRbxOYUQXtHmPou++9HH0IvbPP8LlV5wA7oqUm14hnnGDHr
         l4BINeyszsS8KELmSt0p45JedfxgqZbetw58jBn27SYcXpvjMumtJyuKWM4x4APu0EqL
         C7bg==
X-Gm-Message-State: ACgBeo1maKVsPYlYCJ/o1yWasfqn8tABvCOgYZe3Bcel6jVKMWbJAl64
        c1FgQiPqHRcRkxXXKaYi3p3CUZYAuY0=
X-Google-Smtp-Source: AA6agR6E/yuoOP3vpOtGNpLKhNsqx+bllHKLFXnkWjrRZSlXN80CAHaViJbUlF49NczAjCMXQm4IAw==
X-Received: by 2002:a05:600c:582:b0:3a5:4f7b:3146 with SMTP id o2-20020a05600c058200b003a54f7b3146mr930719wmd.152.1660806377209;
        Thu, 18 Aug 2022 00:06:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c425100b003a5bd9448e5sm1024888wmm.28.2022.08.18.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:06:16 -0700 (PDT)
Message-Id: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
From:   "Max Bernstein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 07:06:15 +0000
Subject: [PATCH] trailer: allow spaces in tokens
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Max Bernstein <max@bernsteinbear.com>

The docs (for example, https://git-scm.com/docs/git-interpret-trailers)
say that whitespace should be allowed inside tokens:

> There can also be whitespaces inside the token and the value.

The code since e4319562bc2834096fade432fd90c985b96476db does not allow
that, so re-enable and add a test.

Signed-off-by: Max Bernstein <max@bernsteinbear.com>
---
    trailer: allow spaces in tokens

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1309%2Ftekknolagi%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1309/tekknolagi/maint-v1
Pull-Request: https://github.com/git/git/pull/1309

 t/t7513-interpret-trailers.sh | 40 +++++++++++++++++++++++++++++++++++
 trailer.c                     |  7 +-----
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 97f10905d23..47bf83003ef 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1481,6 +1481,46 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
 	test_cmp expected actual
 '
 
+test_expect_success 'supports spaces inside token' '
+	git config --unset trailer.sign.command &&
+	cat >expected <<-\EOF &&
+		Signed-off-by: nobody <nobody@nowhere>
+		some other trailer: a value
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	echo "wrote to expected" 1>&2 &&
+	git interpret-trailers --only-trailers >actual <<-\EOF &&
+		subject
+
+		it is important that the trailers below are signed-off-by
+		so that they meet the "25% trailers Git knows about" heuristic
+
+		Signed-off-by: nobody <nobody@nowhere>
+		some other trailer: a value
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'does not support space at beginning of token' '
+	cat >expected <<-\EOF &&
+		Signed-off-by: nobody <nobody@nowhere> not a trailer: thing
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	echo "wrote to expected" 1>&2 &&
+	git interpret-trailers --only-trailers --unfold >actual <<-\EOF &&
+		subject
+
+		it is important that the trailers below are signed-off-by
+		so that they meet the "25% trailers Git knows about" heuristic
+
+		Signed-off-by: nobody <nobody@nowhere>
+		 not a trailer: thing
+		Signed-off-by: somebody <somebody@somewhere>
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'only input' '
 	git config trailer.sign.command "echo config-value" &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index d419c20735e..d02a9154512 100644
--- a/trailer.c
+++ b/trailer.c
@@ -618,17 +618,12 @@ static int token_matches_item(const char *tok, struct arg_item *item, size_t tok
  */
 static ssize_t find_separator(const char *line, const char *separators)
 {
-	int whitespace_found = 0;
 	const char *c;
 	for (c = line; *c; c++) {
 		if (strchr(separators, *c))
 			return c - line;
-		if (!whitespace_found && (isalnum(*c) || *c == '-'))
+		if (isalnum(*c) || *c == '-' || (c != line && (*c == ' ' || *c == '\t')))
 			continue;
-		if (c != line && (*c == ' ' || *c == '\t')) {
-			whitespace_found = 1;
-			continue;
-		}
 		break;
 	}
 	return -1;

base-commit: ad60dddad72dfb8367bd695028b5b8dc6c33661b
-- 
gitgitgadget
