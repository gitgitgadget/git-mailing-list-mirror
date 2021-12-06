Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7F9C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385715AbhLFQON (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388685AbhLFQNk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:40 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCABC00FDFA
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:06 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id y196so8528816wmc.3
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GqJ+NP7XuZ5yK3anRqCNkO4r/4BS6AKv/7hp/KRrfXQ=;
        b=npU6dyFJrIsRd2pl0C8Uz2xGdQwW66sWJnuCAWGjSqC8fNHkuNY7z98hFUD1vivmbt
         GMPBKixbTZILcQdfdClclRzCtX75drOmS4Iw+9JmLqXjRxn46ZHLXmmCgTJazq42Abl7
         F4W/2+kDC0q2usBl2g5kAwR8VJx/1nZsXRrj3txFLm2IWL6IcuWiVFTK8j+9aQ9EKQk3
         VkIMg+J+xWTal/cOLS5JH0M1qGlPuFe0mBvKw9euzJ/nHrVYzTnLABXSpC8oKjplbaIR
         hmnpOobFJ/SotOJdoUTp898OZOZlRrk2oeHXJy48qxB2ch37+XYQzCHc5a/BmdCDyLqH
         Z/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GqJ+NP7XuZ5yK3anRqCNkO4r/4BS6AKv/7hp/KRrfXQ=;
        b=7Y2GAC3+GuV2OyTet4vU6FGls6LiKy2rK7hHp9z88MQyJBd7Egenaye0Yo7KbsA4eM
         BHSFFG99N65yY05SjTnh3/4vxYRNMDQW50RRzGn7vpCqpTZbpv0TM7UZ8NhNwE35LUtT
         cgv8MBg43voy5H0NhF9z1fsZiKsh+jzNVF941WfSnPSE3qCCRVhLlPUYTMRKd4h53Eu1
         30N9XpMGCV5zh9zTAlKyoKQysMRDqsjP1TJ/Jir9PsK9t/AMSRnL3BT+znzKU6LKf0Ga
         DrirlABIrEkY3Qz5LyUUSe9wmm6nS9CLsFykW4LWMdopLsO3oRj502D2+kuC0rXMjcfe
         tfSg==
X-Gm-Message-State: AOAM532VslhQ8Yss8efwmpJiNsLjoDqd4OwAYZhtZKyrFakiktQPnS/z
        iMtV5CrQuKaMMa0Xc0yZXMtaLbyO4wA=
X-Google-Smtp-Source: ABdhPJz0sdlEQXWEi3FafDmCrtvLKUtalKsgYYO/NpWv9Fxb9Hs2hsIxAJgicsvm6ngFTGMf1eWtig==
X-Received: by 2002:a1c:90:: with SMTP id 138mr39491688wma.27.1638806165047;
        Mon, 06 Dec 2021 07:56:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm14521351wmg.12.2021.12.06.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:04 -0800 (PST)
Message-Id: <7b1fab86a4a15f33b37ac3364a599c3f5237bf21.1638806161.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:55:57 +0000
Subject: [PATCH v6 3/7] test-read-cache: set up repo after git directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lessley Dennington <lessleydennington@gmail.com>

Move repo setup to occur after git directory is set up. This will protect
against test failures in the upcoming change to BUG in
prepare_repo_settings if no git directory exists.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 t/helper/test-read-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index b52c174acc7..0d9f08931a1 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -39,8 +39,6 @@ int cmd__read_cache(int argc, const char **argv)
 	int table = 0, expand = 0;
 
 	initialize_the_repository();
-	prepare_repo_settings(r);
-	r->settings.command_requires_full_index = 0;
 
 	for (++argv, --argc; *argv && starts_with(*argv, "--"); ++argv, --argc) {
 		if (skip_prefix(*argv, "--print-and-refresh=", &name))
@@ -56,6 +54,9 @@ int cmd__read_cache(int argc, const char **argv)
 	setup_git_directory();
 	git_config(git_default_config, NULL);
 
+	prepare_repo_settings(r);
+	r->settings.command_requires_full_index = 0;
+
 	for (i = 0; i < cnt; i++) {
 		repo_read_index(r);
 
-- 
gitgitgadget

