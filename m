Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDB1C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113886115B
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhJ2NyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 09:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhJ2Nx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 09:53:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD7C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k7so16197207wrd.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=Kf7qRSzrhBhTVOLR+opMDn+DgdahYWCMdBdgIx4Xz+tiwXOjwhUIBry4bNm6sLu6Bw
         9Sr5JB1DpQ4y2552Zrus4T9FrhUYqcpwWC+raaPyBEAEMNe8yTKN8M8uIreS9KXLToBq
         hm2zzJfIRfDiAM51+CxAP9mlqU43CAVP2DfHC5nXUARKI2zZMVpl1RGeIz8jtZjo3fVd
         /MDBmXCcHiWFWkwLsvXTUSjdyE0VpV0Hnj/V9yEjz44APMtN3k095x7CbXN2C3U98WT4
         O7oOVbHG9Rjv+8OLtCA0sofqLU+uNfrLtH1wLq3VuyIyx75F/cvv/oig4+G403BPDsV9
         9Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=OuwJiZ2Tggw3PxS7ywaN0Zre3eovvKpKEKw+2pPnKuDX6pFWeMssyedD41UfLNmkIt
         JxJYrlpPnGyYauL4z6uwO7BRN32HatyyccIovgnUBbTKg3UbA1PGJBNWal6CTDMAVYcJ
         71ee8qLCpz8roWXa/ISFmUUbpeMoTHEGYYinpUG7xuhxpqOkjpmFMrh18fjbJAaj1tnz
         g0CtEdC/anfLg/R+Trr+KHnw9TNqu8w4rymsZFF+kEpcIN/vmOBWJ5PkErI/R7+/wYGR
         FLvAhQjtgYBk/3R6Owx7W6gNN9jv5EJr9PoFIPtrqkyJmsMNEaq0WpHOMHB5bSFYHg7t
         fIrw==
X-Gm-Message-State: AOAM533M0+2fGyguqogZjHnn2iaYI6eFblUMLqmK0Y8sLCSEADzv3Wvz
        XAEGzz1pzyy9NpF+adTPvujpXlEmkrM=
X-Google-Smtp-Source: ABdhPJwZR20usDSmwfcd8beGDtlQcmo0VEtlzzhLspIeM34o7s6tUPbwi40x9HxvFsYsjWyg3LSOZQ==
X-Received: by 2002:adf:a402:: with SMTP id d2mr15184493wra.266.1635515488864;
        Fri, 29 Oct 2021 06:51:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm1774471wre.52.2021.10.29.06.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:51:28 -0700 (PDT)
Message-Id: <6974ce7e7f568444518f9ff405747653516b2613.1635515487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:51:23 +0000
Subject: [PATCH v4 1/4] test-read-cache.c: prepare_repo_settings after config
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

