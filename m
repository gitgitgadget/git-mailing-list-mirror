Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A63C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43A460FD9
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 20:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhJUUuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 16:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhJUUur (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 16:50:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4124BC0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r10so1385528wra.12
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=mqYvcO7C3mD9eiVS/lBwj4bQmfGQIqzHpmHR5K756VmVLJD4dR0Kd0kkygaFmSH1rt
         JWOIrd/V8A27OQLn1kvgPJB/H1TGUNO2QFxH35qE1JK1y9iJLACZrTMPDFn/Sjwiyc4S
         2WDmM1gl8qBLOHX2T/p/Xb/MiLsD5xv8qq29iAkh7rU+CqV2/3U2gpMctFiyqD6jwlkV
         3BiH3JGmJPJqW6l+gb6WMGYwPsh23WTH2t0echsPDqoT8WrLzK6sW0JKcVY5+54LR/l+
         xOoPKn4toZPw5/AQSL5rUTgUmxl/4ZFxGx4Dhad5L0Yt0JmfNGJhyg/YEgwGEywF5tC3
         ZrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=SA8d9CdkYLeguY3BflqLiX+DreQjnhEhrGP+BmPYDkxCSA/IQW3mSWyIq47Xfk5756
         7FyI5mYW9HoFVZFkOK0xT5V66dAHt6/Sbj85OQV7tytUSMHsa57yv9l6wAmRKK0oQ0wK
         lNN9WpDyCO95ZR2ijDWSTvnOQj5mxnriUSKRR8YiefwZlgOkDy7tdQPfxdjHvVcSZg4A
         AJHmKpkZhHlqe+z6fOamlCOMzBF2stzIZOQdDTipTzTzdZKrEGSS4T8vuGbIIoRJSxbE
         hm/cP9AO6HzBx5HxJ/W1gehUUij19htrx6ZraYPmYNb3jkYYRFzUeWiIQWqMShBkFAyL
         /Uiw==
X-Gm-Message-State: AOAM530Rs0J5CNyvGrS2pCRQZStnHCQQmVKWiXMqWPssClfJKeWs/s6P
        scQYyNUTuz9oSfIbl0cgtHS9UfbCbbI=
X-Google-Smtp-Source: ABdhPJyenlRGJCXGqA9RtIHk/d3GMiGmycQ4a+M8RwgYjJhSOLQvHMmUj839qIg8sSKz6x7n9pz4wA==
X-Received: by 2002:a5d:59aa:: with SMTP id p10mr10107090wrr.45.1634849308902;
        Thu, 21 Oct 2021 13:48:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17sm6101878wrq.4.2021.10.21.13.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 13:48:28 -0700 (PDT)
Message-Id: <6974ce7e7f568444518f9ff405747653516b2613.1634849307.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 20:48:24 +0000
Subject: [PATCH v2 1/3] test-read-cache.c: prepare_repo_settings after config
 init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move `prepare_repo_settings` after the git directory has been set up in
`test-read-cache.c`. The git directory settings must be initialized to
properly assign repo settings using the worktree-level git config.

Signed-off-by: Victoria Dye <vdye@github.com>
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

