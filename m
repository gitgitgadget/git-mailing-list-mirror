Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23492C38141
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjAUBze (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjAUBzc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6CF73170
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q5so1620382wrv.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZwxIcNCBhyuM9xa73Egxa/KXEsbmEo51Nawts7/CH8=;
        b=qXgA52zZNmm0a7XBSXpHESC5kdD3JHKjYT19ORYb8Lg0pG7lsd48IMLxr0J+Hsw52v
         qnL9zFCIPf+Ycg1xazBg0T5+XR04r+BTOVMjEnj2Dk+Y12OKOl9MOP1VoMfC0ViONmch
         cMaKc8AOORbvAoNmekcp4Xl32/0OypZ7XhSRE3p2dT9Uzr7TTfQzCOoehQbnEmQDr/Ts
         /sYfXmcldBgiz1u21QYGCpYH/6WoZU1r1CUA8hwGeRF4uzpQ4vD8JFGvhIRHLkxCiEOL
         qMIyeeaxM51WQdAuFGBrSF2w2ntGz5UPJqF7YI+Q9v4BNyDlR8nmIaQ6qgyBRKWktxMZ
         7I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZwxIcNCBhyuM9xa73Egxa/KXEsbmEo51Nawts7/CH8=;
        b=6GhM9476/gNBXem6jMFUrGJJkfZGO68aQkJQUDXX8IbNIuawMLasQd2RWpUTNl4xVF
         UaL0n3dVgbzYX/WuaiLL88cx4TMAn3hJ78P8ECHaO1ASl3AEpL9GwmpbMYX5PtCZlONY
         WfnKS7ZmX5Gvv1/6E1HMGfFVd/hfabKigF9nCFYfPgsRdp3DhG+NH+bM1RZz7D/xCSb+
         FPpqGivy5PzCfZIpRL8QHfsrmKgboyjt2DigF9WpQLrngoqX0ttNYELMFrhTPXxLhjab
         dKC84dfWNWILXUvAbJk4JtqyTDXMnHwRJiBHwnpu3BVZt1IeRxkuDaAv+JExusK8jRJM
         pPhA==
X-Gm-Message-State: AFqh2kr2iU4/pyUNnKjrS/2Cv+zPB7ecv05wSZ2DQHGvYz5H2WPqBnGB
        XAgmEG4VWhkfcZvJovHaSefLItEpHf0=
X-Google-Smtp-Source: AMrXdXvDhYf5azy8eIALLoyEnsUPSHR0ckRu+kpNr+p1P1ZBKkXgBuBStsli7bgbFdMZVcCaKJN2zA==
X-Received: by 2002:a5d:6f15:0:b0:2b9:28ef:24c9 with SMTP id ay21-20020a5d6f15000000b002b928ef24c9mr16656115wrb.39.1674266129025;
        Fri, 20 Jan 2023 17:55:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14-20020a5d526e000000b0028e55b44a99sm19297724wrc.17.2023.01.20.17.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:28 -0800 (PST)
Message-Id: <9089834adeacb2233cb924f36a04b027dac76594.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:20 +0000
Subject: [PATCH v3 1/7] rebase: mark --update-refs as requiring the merge
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
index f9675bd24e6..00d21d7287d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -623,6 +623,8 @@ start would be overridden by the presence of
 +
 If the configuration variable `rebase.updateRefs` is set, then this option
 can be used to override and disable this setting.
++
+See also INCOMPATIBLE OPTIONS below.
 
 INCOMPATIBLE OPTIONS
 --------------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 1481c5b6a5b..accd62fce48 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1514,6 +1514,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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

