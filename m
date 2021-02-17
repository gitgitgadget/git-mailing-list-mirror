Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6314C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE66864E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbhBQVDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhBQVDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:03:22 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9275CC0613D6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:42 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m144so1828qke.10
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRAlg9W+JJ1LhRAgwzyAQsmT2K2M8iAlrnhIQ/u/Ysg=;
        b=DPHUKTypQ1GP1zs+NNzYXupdLBUBwJKDwi5HiDr2mJtGWADYxleXN1+7CNxxrBkIg8
         6nxw+Gfe/BgpNzA8n1i6JOctkn1eSZR2y0zyJ1dzJDQZ9oXjVgPhoxOm4zzEnT/xE/R+
         RBgw9Y9vqJ7qwMkYwObrZwvGp+RHMkqeJEktgrrZ1Mh75HFcZnPsDO9CoJDppvUU+8P/
         N6mDXp8kT6+r6SwAhAXo5Q6vJZRSYC/dYaCmvIYVeXY8h17YXhl7KJfmUy0SK3atsSRN
         D9U2gjH+a8y0ZIr7KsY1hA6Iv0H9eUOjRIll9y6ybAx+/yGyLXr2o37WyoicO57c2fX+
         nKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRAlg9W+JJ1LhRAgwzyAQsmT2K2M8iAlrnhIQ/u/Ysg=;
        b=ECnf75z2yChXb5nTcdArmKj8rSPbNo35XmwFeBCQoJc8h+ns0tiYxUxsktU2e6BReW
         Y0F5xy+yuBIQRbROKr/QaRv02/r3QMBtp0wp/N/ZxCB8DAT+srH73W1qIAy5J3raEGnB
         kFMQ4hAuOkBd//lrNY5VY4RTavBYtP3FV1QTLakFgRHUS0Z8lbADahne5KOb1A9oMWaL
         nqLU7NzBIiAwmjfRuY/CO5sO7k0DXLZ54/b6Zais1mwB8hY51hs45IFiMNdd5BWfUHuP
         NacLTteXLUvTIZtJlrwJImUb6ZYctyo7u5cxI1q0gGEtNsAXHhYRBM3K7/SHXeKY6ia9
         JJmg==
X-Gm-Message-State: AOAM532RM1NqoXz1aBAu4MgOe+l0ryer10P10A43I/eaNqC25nXURoxp
        Cl8xuxE13n/fNTrzMBTNfPvlThiAt0aByQ==
X-Google-Smtp-Source: ABdhPJxSaVu1I8DXdI7dwLxe34NlF2N7eju5VJvWx9/NzSilk9cr44sykW2U77hy1Yj28iX4N4qvXg==
X-Received: by 2002:a37:434c:: with SMTP id q73mr1208687qka.170.1613595761461;
        Wed, 17 Feb 2021 13:02:41 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:41 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 2/7] add: include magic part of pathspec on --refresh error
Date:   Wed, 17 Feb 2021 18:02:25 -0300
Message-Id: <970b7156c2697e65778ec85751733a3adc53c1be.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
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
index f757de45ea..8c96c23778 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -180,7 +180,7 @@ static void refresh(int verbose, const struct pathspec *pathspec)
 	for (i = 0; i < pathspec->nr; i++) {
 		if (!seen[i])
 			die(_("pathspec '%s' did not match any files"),
-			    pathspec->items[i].match);
+			    pathspec->items[i].original);
 	}
 	free(seen);
 }
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index fc81f2ef00..fe72204066 100755
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
2.29.2

