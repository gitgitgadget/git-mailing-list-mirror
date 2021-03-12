Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E16C433E6
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921E164F6D
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbhCLWsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 17:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhCLWsN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 17:48:13 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9E5C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:12 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id by2so5071879qvb.11
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 14:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=63mqPkXaHrZKU54+wVjh6hAzeUelJYtnj0G0KhGNe10=;
        b=Z2gKKjzfRrM8CZhoImRH7Cv0efzqn/Qo+1Zd9mwsgn6HpBxWL+haRAujXut7EGgfoV
         kaBc8uUNkLLJ1E77vb4AicK4NkKmgDqzgMvl75QO2zFxzkU8CFhZmz7pRj6mCwctrbnf
         kxMz5xQ1KahUERTdncW1FV4oVwNChD02YC404SF/lYBGPrf96KPZzR/2rc399uGypytE
         9Pxd4fcc7WY6u043gO0v5XYIFbiwkkhBl00NzROh4ESiZCECpKX2zoZ5SA7Og6Tipz8f
         eJ0gjVw0MrcBXBiZP4FONE1C6DA7o+PCsBVT80voSFta/0RG4y3Oz2c4L4anYlwCrsAi
         uLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=63mqPkXaHrZKU54+wVjh6hAzeUelJYtnj0G0KhGNe10=;
        b=nmZuqTDmUnd62ozhnb4d5/JR/TvHjSOl6ruDM4idkBWoBQs0NmL8al8e4zpzEAq2wA
         ltlVQ6V/7e/ZTWGJFqP9EdZN5t/8gacB5cFZOOHC3JUN4ShX87hb3GU5UERsfEHZp/fZ
         dSc+adP9UZUeKIv8FnMLYV8wCpe4QCUCx+BS3sWZMb6wxfg6pJzj4L7wcxCM6UXQZqkZ
         IboLTWTa3ba26yiVPe5PUv88AM+xb+k/UJT+01/QJ0wAradS4w9yMlAjK6tQA33Sqwfw
         tyiYLs42bRBJLEV6asI1FXWI98XiZm73PF3/2UB0rtJvjSaPTMm3yixSFsS0zfXP5DB2
         06qw==
X-Gm-Message-State: AOAM533lt8uhlmiIAJ/tv41g93viezDc4UN/VAPvGFsfMUaJNTrRSGi2
        7z75StD+CisvMUuAfMM2jj3IiKvbGVVouw==
X-Google-Smtp-Source: ABdhPJyMEn9glB2WGIpeeqDGhh/XiMwnPOpymuv6MLdVe7XCE3uy3wAuxoqW5JZjnu8XC7n3vLbUjw==
X-Received: by 2002:a0c:f54d:: with SMTP id p13mr576993qvm.32.1615589291576;
        Fri, 12 Mar 2021 14:48:11 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j1sm4870400qti.55.2021.03.12.14.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 14:48:11 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Subject: [PATCH v3 1/7] add: include magic part of pathspec on --refresh error
Date:   Fri, 12 Mar 2021 19:47:56 -0300
Message-Id: <05b66a8c2b0a11c2b4695f8bd49ecf4ad6bfc438.1615588108.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615588108.git.matheus.bernardino@usp.br>
References: <cover.1615588108.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git add --refresh <pathspec>` doesn't find any matches for the
given pathspec, it prints an error message using the `match` field of
the `struct pathspec_item`. However, this field doesn't contain the
magic part of the pathspec. Instead, let's use the `original` field.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c  | 2 +-
 t/t3700-add.sh | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index ea762a41e3..24ed7e25f3 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -187,7 +187,7 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"),
-			    pathspec->items[i].match);
+			    pathspec->items[i].original);
 	}
 	free(seen);
 }
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index b3b122ff97..cd78dd65e5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -196,6 +196,12 @@ test_expect_success 'git add --refresh with pathspec' '
 	grep baz actual
 '
 
+test_expect_success 'git add --refresh correctly reports no match error' "
+	echo \"fatal: pathspec ':(icase)nonexistent' did not match any files\" >expect &&
+	test_must_fail git add --refresh ':(icase)nonexistent' 2>actual &&
+	test_i18ncmp expect actual
+"
+
 test_expect_success POSIXPERM,SANITY 'git add should fail atomically upon an unreadable file' '
 	git reset --hard &&
 	date >foo1 &&
-- 
2.30.1

