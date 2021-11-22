Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14722C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbhKVWpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbhKVWpv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:45:51 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA716C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so520399wme.0
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w6vpqglH5lwDg1E4b+OHGlkiNda+85Fj50ySebHz61U=;
        b=WH5296vPKyl8VMARfaFndlc/wY9w+Q+YQbPN+yM6kwbwNxHixlyzvTHV9Ypmrm+WmD
         6yjI7FdixmXh77VM1I47YOv9nfRLZK7vPGGevNENzL8WKGoRsMroRz7B+unuS20SnrRw
         RxsFQ/Pu+sKcHjjuVorFvrEnQAjUGuxDZUc8FQ09N+l517peystX2UsE0NVCC7yXM1vy
         0MpaO+eWzDGCPthBbxlHDdYJoz8dYvkVhBuVM216dszE1wF2UZX6nwo5BTb+/9rGSR5e
         RdW6QB/ibJ83QNktketDBKambtCPVepca6/2i2BRB1OM/z+iLa/U+h6957e+naaABk2n
         m1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w6vpqglH5lwDg1E4b+OHGlkiNda+85Fj50ySebHz61U=;
        b=aA2iEvnFbXPNEbzoDyR4v8Og+hgBGkUIxrrfXg8ao6hI0HL7VD1zHUTLVrFe73y+qa
         O168Z1qSL49/IJd6bMW6V1Rn9tdiwEL0xIwYZZHIG/PFS2LdyXusMRvhEfJP3O7+uOuF
         3dPJ3X8QApEfS0nCOWPPR4Xs3/BDHm5tTIvk1zQFZkkFLcfdYIPeZiPcHxs+twWk2D18
         lZ5JUVkqz52c3h9bI7SBMG3a3Bki/K+KL6hKdNh5vMcq8xH/rT0/SPdqmScetA2x/Bj4
         wSm8DxfguLdH6JtFjtTctCyFeA0+s8H0qca/wKvWTfqKJMi6G72ya5tRMHo6Z1lr7uPI
         EZKg==
X-Gm-Message-State: AOAM532hOqOUuMB6H3UHJRpvJ/lpYzXG9TDGdaHx4efbCIPBow4zLaX2
        DaoWVp7djiQNdGoJINJQGXAHrNXuEoc=
X-Google-Smtp-Source: ABdhPJwcmFzQ/I8h93LGNuiCqbdE21RJKQ7+CX35TCXOFD8wix71xCYxWAB6jNWqggPVdh2eJq/4Yg==
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr33566242wmj.121.1637620962204;
        Mon, 22 Nov 2021 14:42:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n32sm10972236wms.42.2021.11.22.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 14:42:41 -0800 (PST)
Message-Id: <5bc5e8465ab5fe871965e6c6d578efc51e55b505.1637620958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 22:42:36 +0000
Subject: [PATCH v4 2/4] test-read-cache: set up repo after git directory
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

Move repo setup to occur after git directory is set up. This will ensure
enabling the sparse index for `diff` (and guarding against the nongit
scenario) will not cause tests to start failing, since that change will include
adding a check to prepare_repo_settings() with the new BUG.

Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
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

