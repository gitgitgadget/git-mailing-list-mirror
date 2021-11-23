Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E274EC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhKWAXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhKWAXo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:23:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F9C061714
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id b12so35756581wrh.4
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=oeC0LNRQa7o6p3qEezQI60hQbbmjtROm8PqnxkcDjSEHE1INp1F547OiUtbIM+DcBm
         7ierGRwNb8MCUnxjH8MSyEUBjsqtf1DNHILIIY3oyl6xNN6W2EmqEag/r5baQXKogBaH
         rkxWS2qXrr7VPRt+W88E6Nnws1YQT58VQoUmWbASfiIx121diN6v7O5MpAQ8iFUgVwM8
         O4J10x9wR3wMfLijZCrIHrcyjkiCNtRdmy7zaZwiTptLRnqNbR0g8YeZMtKbTxZCS3Vc
         fJNerLukr4BOcfbieEMkqNrQSr/FRlIwsv6J67sX0nTDQMmLwLMEEgWdnHLqwbe81NWR
         ts1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fBwFOyZpb1FNiGNmlBqIz8szMCFUAyTVo8d9LrANmrg=;
        b=pBpnma/w0Bx8toifgutvobIRk0r5hi83gB45Jj6UdEMh6G1gfVFTGL8gwibncROlIf
         6f+33+agDtBOpdJiV+3PdEIHV573Z6V98LyEABZonLaq6wj88mAwJK+XoqmKuC37X5kk
         nPewJkuX+xHlg1iQ9dJNMan207rUw0Qc4HjJ1Ir13zj6XMPjSsTt78nmEML0jTl6kYsK
         ETF+4T3I89wXYSUdXOYNxZIyfQ/IcYjbiz2oI1SkIb3/cctldYZfEqttPhbmqTpWDpWE
         5VKky9/BtcUmIshzsiI5YR7Z1HnR5ZuV+wetPtCFX+2vnpjPttSoumd/XTSfwZw5DziG
         mvCg==
X-Gm-Message-State: AOAM530mavVM5V4I7hgDfmKT+ggdzaL5ULNHtDQ0kv4FI6/1il1h3Gsp
        80ZDeCxVImnihVHLtFyF7BOR3F4z6zs=
X-Google-Smtp-Source: ABdhPJzXtOx7BSzSoY8feXIDbS1+492udcOp4TpGumMdfDcA2Hikv8Kc4R+gnykrcERuN9v2zQcQ3A==
X-Received: by 2002:a5d:45cc:: with SMTP id b12mr1900321wrs.164.1637626835538;
        Mon, 22 Nov 2021 16:20:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm10055865wrn.91.2021.11.22.16.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:20:35 -0800 (PST)
Message-Id: <6974ce7e7f568444518f9ff405747653516b2613.1637626833.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
References: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
        <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Nov 2021 00:20:30 +0000
Subject: [PATCH v5 1/4] test-read-cache.c: prepare_repo_settings after config
 init
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>,
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

