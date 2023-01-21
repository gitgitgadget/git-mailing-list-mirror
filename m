Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65515C27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 01:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAUBzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 20:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjAUBzd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 20:55:33 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CE871BF3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b7so6285753wrt.3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zd5G4Z+OrZbl/P0DHHaGnlAkAG4bR8xHytJ1leEchTo=;
        b=J7U9JxRqb6CQS9zPbOE9ao7JEfG7BmHmDVJNuwIKV36CZ1IIEGrCJcsSrUfJLysNRv
         rBSO3MdvmxqqRtwTLm8ubQBHFnVNdzlqYEcl8V7tbXM+Rs5lfV5Q4Wp0UJwLfC9ypwQ7
         y2MBW2BR6YrtHNreea29lnkhX5bdg4bj+3gEm53vOxxvamWKUXYrxqvWFFdFvTF4VrfG
         lZCVOXtGsyggNFwyWRQ5hzoCe0UtbntdiMy5QJzQPv8b+c8QxdIpA7HCoitG7X4c0/cQ
         CPl/7Humb8D/4Vn55o0S5e63jKfKVIXGDZJ9DrmxQDmY5f77VB7BLm0Xrm5j/DoZdGpc
         /efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zd5G4Z+OrZbl/P0DHHaGnlAkAG4bR8xHytJ1leEchTo=;
        b=cjHZ/TVw+h2F7kJGVwcJQDm7Q7X19M5svkz9xTN0z+U5gYsf21oK1tpmFY9du9PWPS
         TpxY6Ll9Pr3wivnz3ldsd2lVyPHqjPK9rqztHb+fMKBWmVoa8vOevqTA/Hxsk6Pa84VH
         +/YoRnwtxcPRwCN6S3LHuIiS5n1AoPwG0K2gj0r3b3OrLNuNzgVFmi65kgMbwAHn+RbQ
         2HXgtgEDAtaooHbRYuMhH9cju4NeiH1M9uuUAMiOMRkhWU26PNapL+7WbNjCVdWm5Fop
         Qef2StjSXpEmZAjWjgqxiIXy/GN+js6++xARLitix3NJ3ADjjSb+yirlzt9HO5wlMZSu
         AL/A==
X-Gm-Message-State: AFqh2kp2H1MNr4tlkPNOvP+H4XCT4F35ssmDcINlBt0Tpe5ceilNzne3
        ujOAU5+Jinmc+zP248mErL7bJi2/mLo=
X-Google-Smtp-Source: AMrXdXt2Zb3PHnoFib1B2Gtg1MUIZRvag8ju0tZ104jFiRcCnFNHOR5rY+0GPY2lfHi8D5A47v8uwg==
X-Received: by 2002:adf:aa8f:0:b0:2bf:5dc0:56c8 with SMTP id h15-20020adfaa8f000000b002bf5dc056c8mr3156726wrc.51.1674266129886;
        Fri, 20 Jan 2023 17:55:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d6747000000b002b57bae7174sm37541628wrw.5.2023.01.20.17.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 17:55:29 -0800 (PST)
Message-Id: <a8b5a0e4fb01bb3f4332b94f7e82e10d946b7828.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
        <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Jan 2023 01:55:21 +0000
Subject: [PATCH v3 2/7] rebase: flag --apply and --merge as incompatible
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

Previously, we flagged options which implied --apply as being
incompatible with options which implied --merge.  But if both options
were given explicitly, then we didn't flag the incompatibility.  The
same is true with --apply and --interactive.  Add the check, and add
some testcases to verify these are also caught.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c                       | 12 ++++++++++--
 t/t3422-rebase-incompatible-options.sh |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index accd62fce48..2a5e0e8a7a0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -920,6 +920,9 @@ static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
+	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_APPLY)
+	    die(_("apply options and merge options cannot be used together"));
+
 	opts->type = REBASE_APPLY;
 
 	return 0;
@@ -933,8 +936,10 @@ static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
-	if (!is_merge(opts))
-		opts->type = REBASE_MERGE;
+	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_MERGE)
+	    die(_("apply options and merge options cannot be used together"));
+
+	opts->type = REBASE_MERGE;
 
 	return 0;
 }
@@ -948,6 +953,9 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
+	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_MERGE)
+	    die(_("apply options and merge options cannot be used together"));
+
 	opts->type = REBASE_MERGE;
 	opts->flags |= REBASE_INTERACTIVE_EXPLICIT;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 9da39cd91c2..9b9e78479f6 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -67,7 +67,10 @@ test_rebase_am_only () {
 
 }
 
+# Check options which imply --apply
 test_rebase_am_only --whitespace=fix
 test_rebase_am_only -C4
+# Also check an explicit --apply
+test_rebase_am_only --apply
 
 test_done
-- 
gitgitgadget

