Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53692C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300E864E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbhBQVDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbhBQVD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:03:26 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DDC061788
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:46 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id g24so8128704qts.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eO79hD/COpmgZFAlN7t0LKYqs92Cya1RLIEpXJaXkQY=;
        b=x4PYUvFIKZuFWKlVNNN4e1A8AlEbvuMi4v9RBV+lTZke1kvALWhMkjQIpYj7pO+m8s
         Mtl6FUS9T88FmJdROesQkf6Z2hGf9xk38V7qUKmWZY2A+fAUR0gFE4ZNDZO/vvki3Ss9
         a7QlJm2Ueuc5sLIH5813P97cE659XCbQvEjtCU0HMbJ1ipUEa5xG4m1F7q1VUNUi3xVq
         jgw0c8FSUffSIixQmZ7lM8h3p1yHcTDExgfgSAv3MBotpzil4UpCrYNd0Zz4E0KHjkuD
         7JCmg4x6x4Deo0XRH/Z5RGOGMfSX+VicJf4PdI++iKt/49FwllE6ayuRgAJaFd9NsD9g
         te7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eO79hD/COpmgZFAlN7t0LKYqs92Cya1RLIEpXJaXkQY=;
        b=kgJaQtRxVYk0YfK+4ExbskAVQIwcfyjTBwhXle2L0RN+04goCAEqhSiujyDmzLNNNO
         +y5udOKF+YAudx1+8wefOVpz8RiZOk4XM3TAtyTmzmKtYezkjgq5Fx7lU1zu6NiPUuRR
         cuziZehsmC+Rzwky20qd69LQlgMIiVNeG1guLJT7JtIfEU/bzEtykmW13Y3NnuSBi3DW
         4YLLWpmEaEVi5k5+1eVdCkFueOJ2YJOPzKIkRRefNwYdWPeClbLMx8gMsf5IIXwXNdL8
         u3+UKpHRu3UrLC3xQzAcTQ9SEJHmcThn+gFbePpmOk61CH1fkDvWC1XF19qV5ggokDY7
         FNbQ==
X-Gm-Message-State: AOAM533zWDB+CFUyVvyicEhky71pRmSp76qVFjCm+h+BeFFpeCVF0AW6
        sWeA2Hbp/fUQA+W40nZIcub966KB6S0uQA==
X-Google-Smtp-Source: ABdhPJxHXJNDcJZ75o9blggdfMkNVTOwXcdmFZMHwYE1o/kKga8eIKLu9fFNgiSwwr4Al0tiMafxAg==
X-Received: by 2002:ac8:710d:: with SMTP id z13mr1146042qto.165.1613595765183;
        Wed, 17 Feb 2021 13:02:45 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:44 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 4/7] add: make --chmod and --renormalize honor sparse checkouts
Date:   Wed, 17 Feb 2021 18:02:27 -0300
Message-Id: <f8893577c7a0269670abbd67f94f42462ba0791a.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613593946.git.matheus.bernardino@usp.br>
References: <cover.1613593946.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/add.c                  | 5 +++++
 t/t3705-add-sparse-checkout.sh | 4 ++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 8c96c23778..e10a039070 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -45,6 +45,9 @@ static void chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
+		if (ce_skip_worktree(ce))
+			continue;
+
 		if (pathspec && !ce_path_match(&the_index, ce, pathspec, NULL))
 			continue;
 
@@ -137,6 +140,8 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
 	for (i = 0; i < active_nr; i++) {
 		struct cache_entry *ce = active_cache[i];
 
+		if (ce_skip_worktree(ce))
+			continue;
 		if (ce_stage(ce))
 			continue; /* do not touch unmerged paths */
 		if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index 5530e796b5..f7b0ea782e 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -75,13 +75,13 @@ test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
 	test_cmp actual expected
 '
 
-test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
+test_expect_success 'git add --chmod does not update SKIP_WORKTREE entries' '
 	setup_sparse_entry &&
 	git add --chmod=+x sparse_entry &&
 	test_sparse_entry_unchanged
 '
 
-test_expect_failure 'git add --renormalize does not update SKIP_WORKTREE entries' '
+test_expect_success 'git add --renormalize does not update SKIP_WORKTREE entries' '
 	test_config core.autocrlf false &&
 	setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
 	echo "sparse_entry text=auto" >.gitattributes &&
-- 
2.29.2

