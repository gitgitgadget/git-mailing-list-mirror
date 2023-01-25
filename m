Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1453FC54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjAYEED (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYEEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC74902C
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:03:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so402592wmq.0
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TELS1RC3bPR/JOiEBxfSoYL+GhZIw/AaeR38ux0uFNg=;
        b=PoUkiuTp2LiKTJ/w+D5REIFsHyFOd/CtEQbeHl12QDZUoEDzIFAACvCp0knzuM0U3m
         lgkWk+zvtdlgYqDax9zOVknfi1drwm7YThOA5cwPXqAmOXmu2F0Xkl1wKl+IqQJFvAhh
         lp4L34VTnU7OWpsw2WVzIVsYt7nMtTHlfMCRj20HN9IMpKgGRzOHyugw05/OS2kmyVz4
         c2T4r2jFelaJNN/lf/LrsN1Rv2AFrGGnnpvQpRHGlQvacmhFBpO0ViSOpGj+YSOD8vkN
         lnuYUKwvod661gSy+9pN/bT+aPuTw60OqmsWXKf39KH0cYYvTPzNLFG8Y/P9AIS4ffs5
         byAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TELS1RC3bPR/JOiEBxfSoYL+GhZIw/AaeR38ux0uFNg=;
        b=E7P1EmhheSMNBAbaxBp2dZbXf5SXfY+/67ZviGlPgpibtlidIljKCbWNGI6obt8Udg
         kmi6OiC3hbKSv0lLy8RamPCJeg3POYtX7e7osfR5dtSxZxDf0UjXUUGNUo2dgfT5vT/I
         SLKc+WXUUmBTGZFueej4ZxyPsR5GgNVRDcxeOOfjo23ZNuelNEpv2r7bpN+En/btSVoV
         f4oEFKlL8uyIblU5M0LqAyipHuWtaR0y97fTz+Otjz8kMFUQ8tYQANiyE/2sqFD57gQN
         EH/ZDVIaPKvP5+RXPFfT+iynqhytJh5zZrgj5C+gmaIJtnnO1Etja20RpYsVyOsxE7ub
         6U/A==
X-Gm-Message-State: AFqh2kqNeXHDNKu9ojJwiCUiKQ+rD+uGOptMFE038bsAVafzqzoDgtYb
        43oByI7pn06Kf52+wGpfWo+KJFaTyEc=
X-Google-Smtp-Source: AMrXdXvIHyUH2GonzU27l8bxWdNeKvHwQGA2iBaPvjy6RmAOt9/5ZPYZ6NFMyarA0VFK+UKKTamtJw==
X-Received: by 2002:a05:600c:5116:b0:3da:212d:9dc0 with SMTP id o22-20020a05600c511600b003da212d9dc0mr30412898wms.14.1674619437587;
        Tue, 24 Jan 2023 20:03:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020adff008000000b00297dcfdc90fsm3276877wro.24.2023.01.24.20.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:03:56 -0800 (PST)
Message-Id: <8a676e6ec1a30a0220ca0d222211a4cdbf0646a2.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:45 +0000
Subject: [PATCH v5 01/10] rebase: mark --update-refs as requiring the merge
 backend
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

--update-refs is built in terms of the sequencer, which requires the
merge backend.  It was already marked as incompatible with the apply
backend in the git-rebase manual, but the code didn't check for this
incompatibility and warn the user.  Check and error now.

While at it, fix a typo in t3422...and fix some misleading wording
(most options which used to be am-specific have since been implemented
in the merge backend as well).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rebase.txt           |  2 ++
 builtin/rebase.c                       |  3 +++
 t/t3422-rebase-incompatible-options.sh | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d811c1cf443..6490bc96a15 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -630,6 +630,8 @@ start would be overridden by the presence of
 +
 If the configuration variable `rebase.updateRefs` is set, then this option
 can be used to override and disable this setting.
++
+See also INCOMPATIBLE OPTIONS below.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index a26cc0cfdb5..c111b89e137 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1492,6 +1492,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	if (options.update_refs)
+		imply_merge(&options, "--update-refs");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 6dabb05a2ad..9da39cd91c2 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -25,11 +25,11 @@ test_expect_success 'setup' '
 '
 
 #
-# Rebase has lots of useful options like --whitepsace=fix, which are
-# actually all built in terms of flags to git-am.  Since neither
-# --merge nor --interactive (nor any options that imply those two) use
-# git-am, using them together will result in flags like --whitespace=fix
-# being ignored.  Make sure rebase warns the user and aborts instead.
+# Rebase has a couple options which are specific to the apply backend,
+# and several options which are specific to the merge backend.  Flags
+# from the different sets cannot work together, and we do not want to
+# just ignore one of the sets of flags.  Make sure rebase warns the
+# user and aborts instead.
 #
 
 test_rebase_am_only () {
@@ -60,6 +60,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --update-refs" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --update-refs A
+	"
+
 }
 
 test_rebase_am_only --whitespace=fix
-- 
gitgitgadget

