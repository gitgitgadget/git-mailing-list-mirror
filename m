Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0E7C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbiFCNiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbiFCNiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:38:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164912D38
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:37:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r129so4106552wmr.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ttWhpEGetrPXdh5WVpHkNj8LET5/tVmBOlacKztqzp4=;
        b=inpka5pGBaMND7BxSY3FScTvoc2y5tEZg4HGStBvxcgu7zze6HthJ1+gPF65GtARom
         ZBLFAJV9ByJ0zAYLaKgJTbUQPwtlu3rRjAVaEKuBC4pg8Fj7nERT5AglKg+Y6hpXVFgt
         8cSOKWXkK51ZDSuutq5dXfm5BAH4yvMDPbY+7vu4LV1hE5pnUS4UvdoVkFVFLMs4K4+H
         H/PV6Y0usChKr3H95NNSromNuY/bxUMUszeTPqFOXDMcV+m70aUtJbaU39KO4bJzc1WR
         GT5yvyQp45dzrz/vxE7trDl00PBJ1/y+Hsj6h1VvHM14hDb7RuAhRoNYrntgm0HX4lnR
         1Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ttWhpEGetrPXdh5WVpHkNj8LET5/tVmBOlacKztqzp4=;
        b=wPM/T3sFqqJlW+9ot7Bb6IUUNQjhpxX+G/NBeid/O7leDf0v8oeNh5Dr5Uj/RFHZGg
         CXRF6+U8wTmDR/7xaoeMtlwfFw6li5aeIsEk2hDwQeOjMCuc+LSwJjaHN3mIJGv+QKd7
         SX758O/Q120zn9XG4RrCL56/tI92ExmUXZLk6xAcufTnFZr/uzCZ4HOQqE+RXjp609S7
         hGIFOn1uMyF8XNw2eXMCxTcSyycIvOzXpBku17pCTx1UVzO0fbbItyvkkw+jjvtkvOc5
         UURVtUzUMK+hZ5ub9idUwmWKmKS01nis7dwca0yJeG47bvik4e7a/qMFaDDwubDy3nbt
         HswQ==
X-Gm-Message-State: AOAM530c/FDRnODAkmiQEDPaZGbdbvo/ouVS7p/y7bRuUv8PtFik0Yy6
        F8KzQ+09vWPW/hAdogaHXAXkUO0EwGfhs6i+
X-Google-Smtp-Source: ABdhPJxB0jtIl8+3+y8VX+ufQjUETaqJwvn5qUIiSl6juPhMgLFBp0QSrD4D+zcDw/kAjxUGKrZRlw==
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id y6-20020a05600c364600b00397326deac7mr8919981wmq.43.1654263478868;
        Fri, 03 Jun 2022 06:37:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003942a244eebsm8010635wmc.48.2022.06.03.06.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:37:58 -0700 (PDT)
Message-Id: <b99c5bf34ef45f8ac9e57ef28af01dfff7a72198.1654263472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 13:37:52 +0000
Subject: [PATCH 4/4] rebase: add rebase.updateRefs config option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
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
 Documentation/config/rebase.txt | 3 +++
 Documentation/git-rebase.txt    | 4 ++++
 builtin/rebase.c                | 5 +++++
 t/t3404-rebase-interactive.sh   | 5 +++++
 4 files changed, 17 insertions(+)

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
index 866554fc978..cb1b498bd99 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -615,6 +615,10 @@ start would be overridden by the presence of
 	are being rebased. Any branches that are checked out in a worktree
 	or point to a `squash! ...` or `fixup! ...` commit are not updated
 	in this way.
++
+If the `--update-refs` option is enabled by default using the
+configuration variable `rebase.updateRefs`, this option can be
+used to override and disable this setting.
 
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
index 38c7ef95e0e..1fa9f78d40d 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1768,6 +1768,11 @@ test_expect_success '--update-refs adds git branch commands' '
 		exec git update-ref refs/heads/no-conflict-branch HEAD $(git rev-parse M)
 		EOF
 
+		test_cmp expect todo &&
+
+		test_must_fail git -c rebase.autosquash=true \
+				   -c rebase.updaterefs=true \
+				   rebase -i primary >todo &&
 		test_cmp expect todo
 	)
 '
-- 
gitgitgadget
