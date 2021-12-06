Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0CEC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 16:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377100AbhLFQOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388642AbhLFQNj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 11:13:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65873C00FDF6
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 07:56:05 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so23439390wrn.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xAocT7yf/kpTiA/n7n7/FZSdVz7wIVtS4qeC06FPkFk=;
        b=hGGnzyUwWi3ZRfGMulAy86bbARfuzwmgddFR/DEzZ4fX7q8/pk0ni6ctpeKDelguKp
         +VhV9CHThE7zs+Dnuxg0iYgz+UPbZ9ZeKOkheTPh25GMzMJfShiJvVbEZlpiBRM35BOu
         ldVU8KkVfvF2dfGWOuXzOEuee6eVlsGYbkDt3L38kiR4LrWucSpWMw+brnfEPpIJsQ3w
         ZuOjoeAVJAgzZ7kNb0IbQTo4xxrzqpJUxKKxPqV56Vixo+v6O44L3CbyByKXKBTCjYzY
         58AEsp/TLJd+d4yBdRkRaVkqN1oGa+BAigLhOXMnpTzOWVUDh9HQ0Er8nl/93hORyJMF
         LbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xAocT7yf/kpTiA/n7n7/FZSdVz7wIVtS4qeC06FPkFk=;
        b=wJ0bHBjWA7DkSw36Oq8/OxsOMm4zu2NzUACQti7O1teGCrrUcwFS8fR/seMdHAMgsO
         SqQexNM3ETQvn4OtSxefHxOPKuElUM6MbsU1HXQHrMePOrWa0dZBwPvjGbHCZW7n14et
         vPvyd2i/gIZePjWN1VRGS3n0/lKvGaS9M74ob+CEBn9mpqeOBdBBDvnNvJ5z3syytjyc
         Z2SP2QXpGr/qlGY4ZljAh5vEoR6xSuGL0toOxBD+qtwkdPo8Hj8wfBmjXCqQTuhJICbZ
         BKypTdcemSBPdFCaQU2knjjy5+GOtUBEkaSbQIFyJw+oEsfHXzq9u9ZeoQ6OoGOwvrBl
         SF9Q==
X-Gm-Message-State: AOAM531dOTIZGyWNqVxIrAcRbceKdb2Q317iaDAL4CwHVobtweE63PkO
        71o8PAgC13igKXR6jplSU0u/msNwLAI=
X-Google-Smtp-Source: ABdhPJzPncM8u2fd/LY9kBpu0LD4gkoSw/skzFYNkmTF1zDtQDYecudzl3nexHEQhDr5/pEWdKXvqA==
X-Received: by 2002:adf:f749:: with SMTP id z9mr45102424wrp.379.1638806163341;
        Mon, 06 Dec 2021 07:56:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm12477908wmq.12.2021.12.06.07.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:56:03 -0800 (PST)
Message-Id: <efdd55c126d9704e750f00d9fc3f8e99a7c7343a.1638806161.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
References: <pull.1050.v5.git.1638566165.gitgitgadget@gmail.com>
        <pull.1050.v6.git.1638806161.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 15:55:55 +0000
Subject: [PATCH v6 1/7] git: ensure correct git directory setup with -h
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

Ensure correct git directory setup when -h is passed with commands. This
specifically applies to repos with special help text configuration
variables and to commands run with -h outside a repository. This
will also protect against test failures in the upcoming change to BUG in
prepare_repo_settings if no git directory exists.

Note: this diff is better seen when ignoring whitespace changes.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 git.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/git.c b/git.c
index 60c2784be45..eb6890087c3 100644
--- a/git.c
+++ b/git.c
@@ -421,27 +421,30 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	int status, help;
 	struct stat st;
 	const char *prefix;
+	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
 
-	prefix = NULL;
 	help = argc == 2 && !strcmp(argv[1], "-h");
-	if (!help) {
-		if (p->option & RUN_SETUP)
-			prefix = setup_git_directory();
-		else if (p->option & RUN_SETUP_GENTLY) {
-			int nongit_ok;
-			prefix = setup_git_directory_gently(&nongit_ok);
-		}
-		precompose_argv_prefix(argc, argv, NULL);
-		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
-		    !(p->option & DELAY_PAGER_CONFIG))
-			use_pager = check_pager_config(p->cmd);
-		if (use_pager == -1 && p->option & USE_PAGER)
-			use_pager = 1;
-
-		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
-		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
-			trace_repo_setup(prefix);
+	if (help && (run_setup & RUN_SETUP))
+		/* demote to GENTLY to allow 'git cmd -h' outside repo */
+		run_setup = RUN_SETUP_GENTLY;
+
+	if (run_setup & RUN_SETUP) {
+		prefix = setup_git_directory();
+	} else if (run_setup & RUN_SETUP_GENTLY) {
+		int nongit_ok;
+		prefix = setup_git_directory_gently(&nongit_ok);
+	} else {
+		prefix = NULL;
 	}
+	precompose_argv_prefix(argc, argv, NULL);
+	if (use_pager == -1 && run_setup &&
+		!(p->option & DELAY_PAGER_CONFIG))
+		use_pager = check_pager_config(p->cmd);
+	if (use_pager == -1 && p->option & USE_PAGER)
+		use_pager = 1;
+	if (run_setup && startup_info->have_repository)
+		/* get_git_dir() may set up repo, avoid that */
+		trace_repo_setup(prefix);
 	commit_pager_choice();
 
 	if (!help && get_super_prefix()) {
-- 
gitgitgadget

