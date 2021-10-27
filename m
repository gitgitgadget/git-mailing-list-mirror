Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C47BC43219
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DF4610C8
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 18:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbhJ0SWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhJ0SWk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 14:22:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E3C061745
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v17so5622974wrv.9
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=hCWIZ1tTSV7RdHiMlNiSPB4poAyJY18+db6JRI0ofs9pPdMRRtgmDF1sxtAk3n3K/o
         tc8yUsTAPwEWe624Rm6rcAQLWuHAwkkTqusDSn8SjiSZlA3tj+E9ctQKyENmFfDFPhoc
         nGtoUTAkjLcJdqS7R+dT8aLAhMo0QAWumF4vM6sCYV6C5fhM6KuPn1snymTxyry/5ZJJ
         hcbgeAm2JIownuFO6mUpk9G8T/zJ8vaTnteUx14/5UGtwEghIAbZEewAYYdhf97hjbiT
         j5IhnOguvyKW0E1k/nytfWU79zzyXaHq7yGmQ7L+RZpySvt+hDUlpJMlxLIZQtRPr6ot
         e5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=MBtNz+Tuc98iK8Z9eWnaGAfGnaVKxhYpQMAGqgSe90iJxIV8zY/zfr7jjocUxDozpv
         ETJepX5GzgsFtaEYvMcWrjNq4TXdDALoZkDgnBfX6bezx/hEnMmpLMYQJJ2peGnC6+91
         JKwYzVFKnHBtd4bSTguXuNmZmcvxbVDrMDK68UFjyonUO7nnqmGSW9J3WbyYPCGJQXqu
         dpRYep1Q/MorCET/UlWaO8C2iMeyeF9HAawGTHexkiLhV2fSjY5ZhD47rvRF5qqK2kK6
         JqUbUrlwPDHh+vMiwqT0fhYqfEVtee3O2n/z9B0LEPx0f7i0lmpDkm3CdWGn7z/ZEol1
         Fkdg==
X-Gm-Message-State: AOAM533A/8U5W04H0Ujy5NqZTFDp8zLxBbIYSzLugbP8VOu1Dm1rN8Pe
        SfJ9m5CD86WhEUwX36rfKH1MsA4kiKU=
X-Google-Smtp-Source: ABdhPJwjRCxLtfkGxqqQsmwzMVX5tSN802CeLS5xtxg9RpB+GqYfgKtO3bsfR/cFy7bcPQGQZYtZZA==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr42294404wrz.295.1635358813521;
        Wed, 27 Oct 2021 11:20:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t19sm611026wry.89.2021.10.27.11.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 11:20:13 -0700 (PDT)
Message-Id: <6974ce7e7f568444518f9ff405747653516b2613.1635358812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
        <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 18:20:09 +0000
Subject: [PATCH v3 1/3] test-read-cache.c: prepare_repo_settings after config
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

