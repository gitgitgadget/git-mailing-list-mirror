Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CF9C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346255AbiF1N2L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346489AbiF1N1f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:27:35 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D43293
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 189so6881967wmz.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5x6fg5yrJbAE2JBm8dIv01LDeHVBfYCo1j46a2PHdLQ=;
        b=pOBe0n3PdHvFBjN3lL8gK7qsRQzlYLcR2OhvmD+SxvDDSv48Cam85PdRdYtxh+OoW5
         3nqbstD5TgqEp+U7uu9N/ngOd5BdCykzDmngqt8GlcVbqoFAKHIGrk+By+iXJGKFUGEu
         +XDxsmwLRVtGfksdYuqDxqgLxWtQgmNpPH+KscaCYuoHt870SPy9HpXcpnt2Z5LqW2iB
         g0tQrizreCvlxRHkrM/g7+F2CWtVyGEbIrMi5dThCEfyKZpWkxlvYrKEVEw4yhFmz/wX
         brfa+3mn2PnFARww6Xq1jRLqRxtjL7bgMD7oFZBaZRAebXoX5YQAsOf+VeYX9iS2sFtG
         Tf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5x6fg5yrJbAE2JBm8dIv01LDeHVBfYCo1j46a2PHdLQ=;
        b=DBqKzdANI/hnSOpNEJC1YAK0BYNRTHe0EhQ0uoW2EUaME5D948PiAzw2Tld4M4PZMe
         VF0v9HwsX/eKycAaHNBqAaBVqlGe6G76apxWcKbybIszOeV5IwBSuOgGDt8jkxPv+bii
         8JMdQP5kd5oviGeW4cwy6RNgqmX9qm3nAmlDLE5H77Z3Fo+Ojv7ZahnceHOISfJU9Dlf
         ILkkMFan6FwF307pC/bhTBGkx3J24KRx2RUjtPBd9r1GOjnB6wxk007eBM1wFDdcQIg6
         XdsRu/4EeYyo7pj62LCGf8qFiXeSD11KJdPtgCthbkVsCsZMundN1hUquyNge+C1qXsz
         jTTA==
X-Gm-Message-State: AJIora83uavJOffmGfhRGYqrYeNWUwQeYsZy53E+IMnccPiJoiGdzfjI
        wUSPEZ49p5xDV1aD+kgfxyaMYT6E7ybZOA==
X-Google-Smtp-Source: AGRyM1t9Q9r6wG+xOKdlKMB8cWQ1Iwf8y5fBA4qfiggFjzTkdcOMTG0DIynEK572vpfpdDc09J6eJg==
X-Received: by 2002:a05:600c:3d92:b0:3a0:4b71:f2c4 with SMTP id bi18-20020a05600c3d9200b003a04b71f2c4mr11179788wmb.160.1656422769959;
        Tue, 28 Jun 2022 06:26:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm13665690wrs.64.2022.06.28.06.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 06:26:09 -0700 (PDT)
Message-Id: <d2cfdbfc4319081d548d13bbd675c4385b1a5ba6.1656422759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
        <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jun 2022 13:25:59 +0000
Subject: [PATCH v3 8/8] rebase: add rebase.updateRefs config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change added the --update-refs command-line option.  For
users who always want this mode, create the rebase.updateRefs config
option which behaves the same way as rebase.autoSquash does with the
--autosquash option.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/rebase.txt |  3 +++
 Documentation/git-rebase.txt    |  3 +++
 builtin/rebase.c                |  5 +++++
 t/t3404-rebase-interactive.sh   | 14 ++++++++++++++
 4 files changed, 25 insertions(+)

diff --git a/Documentation/config/rebase.txt b/Documentation/config/rebase.txt
index 8c979cb20f2..f19bd0e0407 100644
--- a/Documentation/config/rebase.txt
+++ b/Documentation/config/rebase.txt
@@ -21,6 +21,9 @@ rebase.autoStash::
 	`--autostash` options of linkgit:git-rebase[1].
 	Defaults to false.
 
+rebase.updateRefs::
+	If set to true enable `--update-refs` option by default.
+
 rebase.missingCommitsCheck::
 	If set to "warn", git rebase -i will print a warning if some
 	commits are removed (e.g. a line was deleted), however the
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7611b4089c..1249f9ed617 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -615,6 +615,9 @@ start would be overridden by the presence of
 	are being rebased. Any branches that are checked out in a worktree
 	or point to a `squash! ...` or `fixup! ...` commit are not updated
 	in this way.
++
+If the configuration variable `rebase.updateRefs` is set, then this option
+can be used to override and disable this setting.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 56d82a52106..8ebc98ea505 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -802,6 +802,11 @@ static int rebase_config(const char *var, const char *value, void *data)
 		return 0;
 	}
 
+	if (!strcmp(var, "rebase.updaterefs")) {
+		opts->update_refs = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "rebase.reschedulefailedexec")) {
 		opts->reschedule_failed_exec = git_config_bool(var, value);
 		return 0;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 63a69bc073e..77478d94f3b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1768,6 +1768,12 @@ test_expect_success '--update-refs adds label and update-ref commands' '
 		EOF
 
 		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
+		test_cmp expect todo &&
+
+		test_must_fail git -c rebase.autosquash=true \
+				   -c rebase.updaterefs=true \
+				   rebase -i primary >todo &&
+
 		test_cmp expect todo
 	)
 '
@@ -1809,6 +1815,14 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 				   --rebase-merges=rebase-cousins \
 				   --update-refs primary >todo &&
 
+		test_cmp expect todo &&
+
+		test_must_fail git -c rebase.autosquash=true \
+				   -c rebase.updaterefs=true \
+				   rebase -i \
+				   --rebase-merges=rebase-cousins \
+				   primary >todo &&
+
 		test_cmp expect todo
 	)
 '
-- 
gitgitgadget
