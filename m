Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B9FC38141
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjAUBzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjAUBzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:41 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B639A71BF3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m15so5317003wms.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClNPjRAf26eSVe0VCv+WyY36E4T/Isg99sFUT82jjsc=;
        b=deZ+H8ZoO1z98bcnjuhCqcuv0lpI7aUnVRlDPcK5ApIG+QwR6cfNoGbqVElsgrhW2S
         Wq5M8yZJ3cta8dMguonzIdlzoXRab3X1Jw8wSHox1IWLRz6qm7ZNpZjKWmUkMo/Ty0u2
         Rc20IKOWEqRPdjV5sxKjCv7u2w+XEVBL++cQmwdcroNXY1SUACIoEhg/OdW988U7RdLz
         xCnx2BCgFuIsPD0v07M8B97IvDYqvmNNLdkJaPaPYqbaxprDsPVgHbkSDLtfrKZAZnn4
         2EgxOq/ljB8v2Qt6/8u53vZO7lCVvcu/I2xHDPanIftoE27UzYG+FxdfaoMGYbwUOIgu
         qvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClNPjRAf26eSVe0VCv+WyY36E4T/Isg99sFUT82jjsc=;
        b=zyzshy8gWGZphyjniwkKVa2QQ9aNg0YoLJAA1T4vW1ffrI1IpnywRL8COLfXQyJK4D
         WvyCPBVYGPCXCYmvoav4ncST5Rpxvp9i/kBOyh/JJ7dQdYmJt0/sV6fDmsEk8HX4C//M
         AQAZSBrq+fqvxVMIh7RS1fbvqSqsUZ1+8jHogiAa58BFdQtVK2vF42u6RS3R1Mq9nR9N
         /6tKl94UTnsfN/3ELVf+os8NfKUL605kbB14M1TDrzeEtJGdsg3nZJZ4IA2Tp3HvblC7
         SqCCsR7Ezn4l/w7PTmO+3Fx/RGMuzm3Sj7yxeq/y+76eb5a7zecTBYb+cVOb9LhDxQmA
         TSVQ==
X-Gm-Message-State: AFqh2kr0NQ7/GQ1i6c9lr2PxUqn9jG3L2Vz5p97a/3wwuR5sa2EmfEMT
        msD6P65u2ZRMAgd0Oxpoy6fg71jcwps=
X-Google-Smtp-Source: AMrXdXsdDZ/Q6DPW3hqvcbpuRW7KG/bo7rPgDw6hm91L9G2XyDy7WTH/7TY2LfkwR7oFd6wSnWhFzA==
X-Received: by 2002:a05:600c:3b91:b0:3d3:5c9e:6b27 with SMTP id n17-20020a05600c3b9100b003d35c9e6b27mr12633648wms.12.1674266132054;
        Fri, 20 Jan 2023 17:55:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm16231936wrb.13.2023.01.20.17.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:31 -0800 (PST)
Message-Id: <48c40c0dda00eeb8b9bdc5ba9372b46964eea14a.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:24 +0000
Subject: [PATCH v3 5/7] rebase: add coverage of other incompatible options
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

The git-rebase manual noted several sets of incompatible options, but
we were missing tests for a few of these.  Further, we were missing
code checks for some of these, which could result in command line
options being silently ignored.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c                       | 21 ++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2a5e0e8a7a0..6dcdb59bb02 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1238,6 +1238,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.fork_point < 0)
 			options.fork_point = 0;
 	}
+	/*
+	 * reapply_cherry_picks is slightly weird.  It starts out with a
+	 * value of -1.  It will be assigned a value of keep_base below and
+	 * then handled specially.  The apply backend is hardcoded to
+	 * behave like reapply_cherry_picks==1, so if it has that value, we
+	 * can just ignore the flag with the apply backend.  Thus, we only
+	 * really need to throw an error and require the merge backend if
+	 * reapply_cherry_picks==0.
+	 */
+	if (options.reapply_cherry_picks == 0)
+		imply_merge(&options, "--no-reapply-cherry-picks");
 	/*
 	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
 	 * commits when using this option.
@@ -1420,13 +1431,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.empty != EMPTY_UNSPECIFIED)
 		imply_merge(&options, "--empty");
 
-	/*
-	 * --keep-base implements --reapply-cherry-picks by altering upstream so
-	 * it works with both backends.
-	 */
-	if (options.reapply_cherry_picks && !keep_base)
-		imply_merge(&options, "--reapply-cherry-picks");
-
 	if (gpg_sign)
 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
 
@@ -1525,6 +1529,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.update_refs)
 		imply_merge(&options, "--update-refs");
 
+	if (options.autosquash)
+		imply_merge(&options, "--autosquash");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index f86274990b0..c830025470f 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -50,6 +50,11 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --strategy-option=ours A
 	"
 
+	test_expect_success "$opt incompatible with --autosquash" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --autosquash A
+	"
+
 	test_expect_success "$opt incompatible with --interactive" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --interactive A
@@ -60,6 +65,21 @@ test_rebase_am_only () {
 		test_must_fail git rebase $opt --exec 'true' A
 	"
 
+	test_expect_success "$opt incompatible with --keep-empty" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --keep-empty A
+	"
+
+	test_expect_success "$opt incompatible with --empty=..." "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --empty=ask A
+	"
+
+	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
+		git checkout B^0 &&
+		test_must_fail git rebase $opt --no-reapply-cherry-picks A
+	"
+
 	test_expect_success "$opt incompatible with --update-refs" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --update-refs A
-- 
gitgitgadget

