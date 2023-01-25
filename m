Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A6C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 04:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjAYEEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 23:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAYEED (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 23:04:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E349032
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r2so15765852wrv.7
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 20:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT7FIyhlcVRjmE3c8hSVm89gOiZ7LPsQqMxPR3H0tzY=;
        b=qRTDjp2hgeZ7/U5jt102zN+IEj/XD1g4aIlg5GP3lHfC4Hl7Oi/cwvFliHcNewdhU+
         2X8r1dtr02yx9NbV846kTf8CVNV5wtA0Cyi852p9XTwZnWhN6gZ5IWWZwxQedWjYb6mu
         FsEsWXJZIvXY3bX4l6jO14zG9BPhDS0T8qqsEw6OzalcWj71M4WLAByKl/H4aronWmDZ
         FtADi1/RfPr7W3BFtJ6pxdZtCMCU9UE/bs+KfeNLaaM2pl+YV28s1OfHsXLK6KezOZFl
         k+5fLQ6KBWO2x27prPPwsXQIAcNpty8A8YAEqTEGQUYvNbGpiu39+NRQ9YYlFk8900KV
         z/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT7FIyhlcVRjmE3c8hSVm89gOiZ7LPsQqMxPR3H0tzY=;
        b=xHSeKLTOolHXcFcb16u9SR4ezViH3Xf+8p1iCVjxjEIj3v4B6TJenlhttkXLeYdnyc
         7MeZ/3osXZbWIUsUMpZqObRsTdl/OvDCTy5jqiB68TNA7ef3aTqJEXwjX6DE+nBCzNwt
         sy1s826omoQSnDdbjD0smerAPjRmRp4+SMwnQuFttGnn2ahlkJSZMtHF/sa19NCmZa3k
         IK08lJXr/J0wGDTBHBf2rE7knpiXKXb8Ww8d4i/ClLBCDe14Q/et5IexLqs0gZcH7dVP
         7zohsh2pwyzZsyFhEz1onKa1O4ynNixVmEyVKooXCI7i3nh4NMuSbaVr0VAvRs/oaa4n
         rtnA==
X-Gm-Message-State: AFqh2krECOTW7mNHdXXxgglfTqaHZXs+S/p4Ka/kyjobrTCp/V6wd/cn
        yuvoUPHAMrdKqjch/wryGs2ndYiD/YE=
X-Google-Smtp-Source: AMrXdXs7dL3cof2kC4IMekwxxC9EGW9bny88+R8FOirMgl+sR79nGgnThv0Y+D3Sc7Rm1AtVEe/upA==
X-Received: by 2002:a05:6000:81b:b0:2be:5c3d:99e3 with SMTP id bt27-20020a056000081b00b002be5c3d99e3mr18885148wrb.10.1674619438910;
        Tue, 24 Jan 2023 20:03:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4-20020adfd0c4000000b002bdfe3aca17sm3206713wrh.51.2023.01.24.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 20:03:58 -0800 (PST)
Message-Id: <cc129b8718594a98557d21b5c79369af8935d404.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
        <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Jan 2023 04:03:46 +0000
Subject: [PATCH v5 02/10] rebase: flag --apply and --merge as incompatible
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
index c111b89e137..b742cc8fb5c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -907,6 +907,9 @@ static int parse_opt_am(const struct option *opt, const char *arg, int unset)
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 
+	if (opts->type != REBASE_UNSPECIFIED && opts->type != REBASE_APPLY)
+	    die(_("apply options and merge options cannot be used together"));
+
 	opts->type = REBASE_APPLY;
 
 	return 0;
@@ -920,8 +923,10 @@ static int parse_opt_merge(const struct option *opt, const char *arg, int unset)
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
@@ -935,6 +940,9 @@ static int parse_opt_interactive(const struct option *opt, const char *arg,
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

