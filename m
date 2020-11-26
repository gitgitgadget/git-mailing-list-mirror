Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEFEC63777
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13757221E9
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 20:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNcHMRkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbgKZUpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgKZUpU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 15:45:20 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34499C0613D4
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 12:45:19 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id hb22so4405682ejb.12
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7+HjKiCPtx5qU+dhMA2ewkSnY5tSWHd+8OfLhEKr75Y=;
        b=bNcHMRkE3yMJ2aO9LtNCgkuwbhxATrx0WPMw9+irsZ50JoIRJkfblB0vY1kIAH2uEk
         G2UAvpLUY5BhRaN5vKikREjIuf1TeTrjHLyzaz12PyAQx+6mAwecKf5JXC7Dt9I+7ZUj
         9ZrzQ4u1xzMWA4/imP+C5McC0IPTyWmCV4LfXGN1NWTMhc2dePyP/L0RWq3KNSXa7RNK
         +gY682dCu13t9r9go4TQi2WlhC3ixXKJcyL3xdgpX+0hkDpdyisz2X6KjbmvVFxkLh6g
         qNuwBw8KsmJHvCadL/7CEzxe6gbiFrxlECjb1A4Ql6K2G9q7Vj2OPahcihDiuJxMdTKp
         uGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7+HjKiCPtx5qU+dhMA2ewkSnY5tSWHd+8OfLhEKr75Y=;
        b=g8Chsm8novFGsRuPcAZUTMYKeKNRUYGf9boyTSCBbvNkIsxQOn+GKw5sppnwqX28Ky
         HnJIztoGJ0A1cyFlepcNqfkRnXIqc8X26TCYMvM0+9DQ6+dnoY0sKa6AtRDNGLYHGMvp
         399h/PeWwR0nFqtDgRFFh3eKwZlNczuIevLYOcQhCfZEmhaOV1/mNwdH+JzeK3lape5n
         QYlp1hm7iTtWwi0nE7jQSjX+JmCJjxJq2S1iOC7UMf88vt5HyZ0Vkb6VafnVUiajDMkx
         ZFCPvAVCyxITJnlyW7uXo2Xj+Iwgn/PAvetJsF9ULxYpo0qrv5RKsXyHoQRYx3OqnGDz
         R8AQ==
X-Gm-Message-State: AOAM532cPBKl9f2sz7wYqsihBJO9Ff9DXSQ7yCKvBqKT5ER1LwtEifOe
        SNJbYDkQ0FbZ/wESfAS6eSAt4XmHjFzASo1/
X-Google-Smtp-Source: ABdhPJy9CYgkNgaXE7j3QIBPp9REm/oTRL0c8mNRW4jCuX9bO1AJt4CmTDqCO4geGkmXSj7wETXxyQ==
X-Received: by 2002:a17:906:28d4:: with SMTP id p20mr4378671ejd.322.1606423517617;
        Thu, 26 Nov 2020 12:45:17 -0800 (PST)
Received: from contrib-buster.auto1.local ([79.140.115.35])
        by smtp.gmail.com with ESMTPSA id d1sm3648689eje.82.2020.11.26.12.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 12:45:16 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
Date:   Thu, 26 Nov 2020 20:41:41 +0000
Message-Id: <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.29.2.367.g37477fb670
In-Reply-To: <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git maintenance run" and "git maintenance start/stop" commands
holds a file-based lock at the .git/maintenance.lock and
.git/schedule.lock respectively. These locks are used to ensure only
one maintenance process is executed at the time as both operations
involves writing data into the git repository.

The path to the lock file is built using
"the_repository->objects->odb->path" that results in SEGFAULT when we
have no repository available as "the_repository->objects->odb" is
set to NULL.

Let's teach maintenance command to use RUN_SETUP option that will
provide the validation and fail when running outside of a repository.
Hence fixing the SEGFAULT for all three operations and making the
behaviour consistent across all subcommands.

Setting the RUN_SETUP also provides the same protection for all
subcommands given that the "register" and "unregister" also requires to
be executed inside a repository.

Furthermore let's remove the local validation implemented by the
"register" and "unregister" as this will not be required anymore with
the new option.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/gc.c           | 7 -------
 git.c                  | 2 +-
 t/t7900-maintenance.sh | 8 ++++++++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bc25ad52c7..ebb0158308 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1446,10 +1446,6 @@ static int maintenance_register(void)
 	struct child_process config_set = CHILD_PROCESS_INIT;
 	struct child_process config_get = CHILD_PROCESS_INIT;
 
-	/* There is no current repository, so skip registering it */
-	if (!the_repository || !the_repository->gitdir)
-		return 0;
-
 	/* Disable foreground maintenance */
 	git_config_set("maintenance.auto", "false");
 
@@ -1486,9 +1482,6 @@ static int maintenance_unregister(void)
 {
 	struct child_process config_unset = CHILD_PROCESS_INIT;
 
-	if (!the_repository || !the_repository->gitdir)
-		return error(_("no current repository to unregister"));
-
 	config_unset.git_cmd = 1;
 	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
 		     "maintenance.repo",
diff --git a/git.c b/git.c
index 4b7bd77b80..a00a0a4d94 100644
--- a/git.c
+++ b/git.c
@@ -535,7 +535,7 @@ static struct cmd_struct commands[] = {
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
-	{ "maintenance", cmd_maintenance, RUN_SETUP_GENTLY | NO_PARSEOPT },
+	{ "maintenance", cmd_maintenance, RUN_SETUP | NO_PARSEOPT },
 	{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d9e68bb2bf..ae5c29b0ff 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -441,4 +441,12 @@ test_expect_success 'register preserves existing strategy' '
 	test_config maintenance.strategy incremental
 '
 
+test_execpt_success 'fails when running outside of a repository' '
+	nongit test_must_fail git maintenance run &&
+	nongit test_must_fail git maintenance stop &&
+	nongit test_must_fail git maintenance start &&
+	nongit test_must_fail git maintenance register &&
+	nongit test_must_fail git maintenance unregister
+'
+
 test_done
-- 
2.29.2.367.g37477fb670

