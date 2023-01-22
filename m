Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D302AC54E94
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjAVGMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAVGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:12:50 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032DBE05C
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:45 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso6381262wms.3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JT7FIyhlcVRjmE3c8hSVm89gOiZ7LPsQqMxPR3H0tzY=;
        b=mEY6h8zZvi05BL7RRSRt0SHiT1BAlIcsUD85cRCeLi4QsMWkgAMURiSDPHJmfzx1qc
         SJJ/hlB1dgC52wdDlEC7A9HVZu6bU4zD0CoxiSkBAqwG3YjScNooyxzjNDYVfv3f1Ppt
         D+yu4KDEUoP8aIdCrPMPpnpUEakI4DwFrAexq/BOOHPwUd09L4YexnkfPs+i8f0EnUJl
         AhP/9HvWuXpLOTeYZBfJ4K4j/gIB5PBz/kC/MWGP9D7vhmTP54CLEzuJfzT5JBFj5yi/
         XwR80a7sM/A8v50FVO/uU2pHVL8RvT9vZiUVeXJpMBNABAjfsge/SWtAhbxlYrGTxQ1i
         gBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JT7FIyhlcVRjmE3c8hSVm89gOiZ7LPsQqMxPR3H0tzY=;
        b=KmhGOEq/4XersmCo6Mun3hTetBNg41u00fHtSVhcTdAYg/5Aj0joQcW2GuG+zd2yry
         rbI5eLy/DsB9HY/xzyoanp0izzFH6wUIvsj0d5vXobtvVQk3chQ2oHX9TCc1gceoVcQv
         TF6G/YC+bpqimCo82cHkyt2kdHIy4BGe/axxU7JtJ2tnAXKsvBQrYxmZW3ytJQgnH+zb
         UwIcqIeSwhjNYrlW72zhUCKtsi9eMlgZPz7dIZDpGdofrNEx4wRKF0fbuVSTTuFD7hf2
         WvuZZNdDxt2+rorETKqexQ0fBAJ5/SQ2p6dn3A4OqWKgffa7XCC/RGwZf1TR8dsq8l2P
         vUFw==
X-Gm-Message-State: AFqh2krbZLL9gtxwbTLkB0c4Ob9QkkQp4oyYStD4VIz1Ygoz3K0ko6v9
        RK0LDNrphdYRj6cpeXiYhQzGfoseUyY=
X-Google-Smtp-Source: AMrXdXsIB1QsjTZj32axtoLhDVsbIKxI4kinTGzh0U5GtFzLU4UE4ImoKZ+ijbM4Y5uYkCpBZ6cTzQ==
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr18837484wmc.7.1674367964374;
        Sat, 21 Jan 2023 22:12:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg8-20020a05600c538800b003d974076f13sm6971985wmb.3.2023.01.21.22.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 22:12:44 -0800 (PST)
Message-Id: <cc129b8718594a98557d21b5c79369af8935d404.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
        <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 22 Jan 2023 06:12:33 +0000
Subject: [PATCH v4 2/9] rebase: flag --apply and --merge as incompatible
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

