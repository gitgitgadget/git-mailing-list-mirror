Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD2C27C76
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAYEEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233737AbjAYEEF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2C49560
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so384921wmc.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyvq/IlO7sEBjMMcYmCwR5LXsNbar/KZ79T8kJVWycY=;
        b=eu7/bYu/gjkq76j36AtMsHcAK2RXPMeX0kt2dZsHyn43qkGfvEl3BIjCg36t0oVXP2
         c8Z5VSbph5qCG8d243TOfxAGa6cvqREJLPjMxKDBaFHDhdWGiVkfwy6ARYnG003q/dAT
         p2t6Wwliuk+9pW6cHvWLawVKC4YoRkWlsX4BTkdyWFn9PytiCMOz6kAnsskqFVHZYFIj
         cHre30sEf45MrREYwCmKz4S2ZZ/05+1EFYLPxZN8yM8dfwgkXi+n0oIIvuqMaflNqFvu
         Xl9Exp9TVoxBspzFIMpjI6IvdCNMcqVAgDIFHrQeCey/dYVWw4ybTOxFuxULQqVUA/Us
         13iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyvq/IlO7sEBjMMcYmCwR5LXsNbar/KZ79T8kJVWycY=;
        b=liIPE4hWdgolVQboYDBuvcZoKKYFQViKZIpMIOozo2LiP5t3iRYoR0I27yDYTUj/+a
         8IbcN3PAMJ1qUxpSUrhU3/3MMX04mx+w/H2BNBECM0NTYEynG1u2sUMqCQU6UBQWJUNw
         Tul7K8W+WdmH1ju4MXpUBqefAYBsBt5ISDtAT9CtDnfXQfTiYqsH3dVl5ysh76IcLFT4
         RePaiFco6ozvbbvePUo+B7eiA/PnWRLn1M0OoBSr1zZzj3tw5JIbq4Bzr9l/OHFGa6kM
         UsGnI944RxzP7B7eAjCOvx5iUoX5Mg1N3VYGkFUPuXWUhKg8xjStdl1QJDTwZHYPPKbE
         PUgw==
X-Gm-Message-State: AFqh2krtE1vm2clC2/3k0mrL+o7kJjWPOHRmXE78hgOoHMpAKRUABSRg
        frn63uDikfjJ9mUMs73oSv+Dio6245Q=
X-Google-Smtp-Source: AMrXdXu/o+n+FX9FUqggCWGe43LCCWPjgtkqUDZzl1pJwn3n4ydJo66VMxMdI/m2odI72hIALoCLOA==
X-Received: by 2002:a05:600c:281:b0:3da:1132:4b63 with SMTP id 1-20020a05600c028100b003da11324b63mr30313584wmk.5.1674619442613;
        Tue, 24 Jan 2023 20:04:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b003db1d9553e7sm535899wmq.32.2023.01.24.20.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:04:02 -0800 (PST)
Message-Id: <2777dd2788a9bbb4687cb236642c37a2f538858f.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:50 +0000
Subject: [PATCH v5 06/10] rebase: add coverage of other incompatible options
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
code checks for one of these, which could result in command line
options being silently ignored.

Also, note that adding a check for autosquash means that using
--whitespace=fix together with the config setting rebase.autosquash=true
will trigger an error.  A subsequent commit will improve the error
message.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c                       |  3 +++
 t/t3422-rebase-incompatible-options.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 05b130bfae5..d6b20a6a536 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1511,6 +1511,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.update_refs)
 		imply_merge(&options, "--update-refs");
 
+	if (options.autosquash)
+		imply_merge(&options, "--autosquash");
+
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
 			imply_merge(&options, "--merge");
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 826f3b94ae6..6a17b571ec7 100755
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
@@ -60,6 +65,16 @@ test_rebase_am_only () {
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
 	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
 		git checkout B^0 &&
 		test_must_fail git rebase $opt --no-reapply-cherry-picks A
-- 
gitgitgadget

