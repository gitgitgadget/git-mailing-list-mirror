Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801FC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbiFJA0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiFJA0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:26:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7D53C75
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:26:32 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o8so6625289wro.3
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 17:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/HX17gRh89EuEt+H3U9vsOlmQzLzCLDGUX84w3u5jU=;
        b=FKNsqy8CHIbx5qqIApIdLWMz6TEMRw+lM8u8Rw57pzowMSbTyvLAFJRJcSxBA1QLKQ
         pDqSRxhQx/s3To9C5MgbyRZy0xF71unGWcAXuulVOHAakxsva27VyG9ZvFVX1cJLR8H6
         BitNfjU8Hoqpw+uyyYar+2FA/D6FRxFEP39WOrXbQUFEXccW8eYVHq9QqU1J43j/jbVn
         hKHtecmucZlyUOXoaAPCoqpAxYO1vC+pXuuoen0wpjMR7VdUgBjc5RCqM1/zRoAQxYCH
         V045G9qSAv1ABLF3jcLMtiwcBPIl/ffBZSULPkpM3GrJtlU1ZrnoYj9KzFJvjjEWaalD
         ierA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/HX17gRh89EuEt+H3U9vsOlmQzLzCLDGUX84w3u5jU=;
        b=RY7y1qIetHtA5bc5X6G45GdioWZQ50AKHvzZtCcgG66TnuyxImlaEgNra8Wgbj8rp1
         RZjp5dlb47bM7BiLiiRdjsce26qyiYfq71zp/kucv59iQY9g2Ca/oh+ap/4PANDyzXkM
         FZf6sw6w8/7nMCY27xHfhFndMoj0oFG7h3+fGBSViafIPqj8kdYhDI9nGSfmnoRSWj2o
         jPz/ii1V6lkifmlxiB7vwwjteJDlgae2plJXesLq5c/sZ6T5/BsG4jFVPvaxiOx/qwMO
         NTd1FcnwEj1KHHHWy1pgJZrg5vPRpLQjP5nIGyhlD4BgXi6p9Lc86D1dFLKxJu5hTVqT
         ViKA==
X-Gm-Message-State: AOAM530eSwsJHJbuZ7wdvl7Os3KwToWVS6eFOSqE/LKURIfcu8nKCXVL
        BIgUthkUYIziibF40Tm5mVu3OlLg3Zmf8pG3
X-Google-Smtp-Source: ABdhPJxYzoXDDVBYROsNtQSDa/xMMpRFkvXn594+gjz9NZNnYyMgQ1OQbKzigZOhyn3WDUBzqrFSQQ==
X-Received: by 2002:adf:fb03:0:b0:20a:e253:b8c7 with SMTP id c3-20020adffb03000000b0020ae253b8c7mr39841238wrr.119.1654820790884;
        Thu, 09 Jun 2022 17:26:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l21-20020a1ced15000000b003942a244ed1sm841394wmh.22.2022.06.09.17.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:26:30 -0700 (PDT)
Message-Id: <fbdfab55f563c2a6dff8485d6870baf472b2e12f.1654820781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 00:26:19 +0000
Subject: [PATCH 6/8] submodule update: remove -v, pass --quiet
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Atharva Raykar <raykar.ath@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In cmd_update(), "-v" unsets GIT_QUIET, but this does nothing because
GIT_QUIET is only set when "-q|--quiet" is passed.

Remove "-v", and since "git submodule--helper update" already
understands 'quiet' options, append them to `opts`. This makes GIT_QUIET
obsolete, so remove it.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 git-submodule.sh            | 6 +-----
 t/t7406-submodule-update.sh | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index d93b6dfbbd7..6b3f161dc53 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -242,10 +242,7 @@ cmd_update()
 	do
 		case "$1" in
 		-q|--quiet)
-			GIT_QUIET=1
-			;;
-		-v)
-			unset GIT_QUIET
+			opts="$opts $1"
 			;;
 		--progress)
 			opts="$opts $1"
@@ -339,7 +336,6 @@ cmd_update()
 	done
 
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update \
-		${GIT_QUIET:+--quiet} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		$opts \
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 43f779d751c..06d804e2131 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1074,7 +1074,7 @@ test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
 	 git submodule update --rebase --quiet >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err &&
-	 git submodule update --rebase -v >out 2>err &&
+	 git submodule update --rebase >out 2>err &&
 	 test_file_not_empty out &&
 	 test_must_be_empty err
 	)
-- 
gitgitgadget

