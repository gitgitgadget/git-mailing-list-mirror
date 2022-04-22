Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6819BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443400AbiDVCfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443375AbiDVCfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:35:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8E24B425
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso4557138wml.5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=q6Ij5s6GRHeJKZ845PeuupKqm1meRfzSIPmF3t8zdRE=;
        b=KGRDhlyIyAW+B11qv+pIxDQgaJRlF3h2Ug08W2FFqeVpf1Tbo6sFAzvf7neg8tyZAE
         FSrzB7CLxEKPI87Ogdku9aYaO+HIBsUfJMj/9EfSGauzRlDn0bSuEHZfDjEj/KTfkL3z
         3lqSIbR10wqaASUAvh3UvwJsmPT0PCKaufuyu3MhWgwSDv/y1uS0ydnIFI59xpTkMR4R
         G5Z2cvirjBr1jozCoH3TFu0ux6LpjPOIddyeoDq57SMd/S0+z1l9NIci4LYK7c+AcWC0
         K4kc+JQ30c5dGpnGK1sUcEhi4ZtfdFzMxXOtIQLnfkmmRU1cvWygyoVE1Ie/yDBw/eXN
         TNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=q6Ij5s6GRHeJKZ845PeuupKqm1meRfzSIPmF3t8zdRE=;
        b=7ukzF3DA4QdhDEUVxI1lPVUrBrKe9/xZhQckQRUAQQsTKz3Z0iOgGqx/pB8nb8e3IN
         4mvh83Mtq5/LXw6s0j/2mMBIf5MTc4cE9Pk5CFhJDmMQxmLKvr+0vv/7BOtamVt6ZzTo
         WvkGl3EZtVOAFwkc18f5HY3SUgGgsv2xY7VS4nXSgcOjgGB2a2N9Uui29+znJOsgxrsV
         fbRbilyDBptka1xv6kJGU8VPittPGmlJ1kgNM2xd8Y9aRei1WHv3f3t0HB5wMmnggKYM
         IiTOKLlcTrxdOg30UdnL43eV1i4B6f9+QWz3sI/CBaSy1x55kdvEaQvlS36EcLD8fYcc
         6wDQ==
X-Gm-Message-State: AOAM531IBCqgiFMsiuq93NsKW/dYcPrTj1Y9GOC++OigBfXcZ77Sc4OJ
        e/2EJxDOR9HXbI2RtIJqM2sxgqkXJf4=
X-Google-Smtp-Source: ABdhPJx0EL0ztorVPPbEDbfUpXKD9c4wT3K2lTzT87Z6QGl96jj/9QFAPXE18JSIY3/pov3Q1qUKsQ==
X-Received: by 2002:a1c:43c6:0:b0:38e:bb4c:6e1a with SMTP id q189-20020a1c43c6000000b0038ebb4c6e1amr11142002wma.111.1650594751508;
        Thu, 21 Apr 2022 19:32:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n38-20020a05600c502600b00393d946aef4sm78543wmr.10.2022.04.21.19.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 19:32:30 -0700 (PDT)
Message-Id: <b1e2c95a2780ee7afb81cdc8d9262da3ca12a59a.1650594746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
References: <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com>
        <pull.1148.v3.git.1650594746.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 02:32:20 +0000
Subject: [PATCH v3 3/9] git-sparse-checkout.txt: wording updates for the cone
 mode default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Now that cone mode is the default, we'd like to focus on the arguments
to set/add being directories rather than patterns, and it probably makes
sense to provide an earlier heads up that files from leading directories
get included as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-sparse-checkout.txt | 31 +++++++++++++--------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 7308e744c57..b5db812f09e 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -44,9 +44,9 @@ COMMANDS
 	Enable the necessary sparse-checkout config settings
 	(`core.sparseCheckout`, `core.sparseCheckoutCone`, and
 	`index.sparse`) if they are not already set to the desired values,
-	and write a set of patterns to the sparse-checkout file from the
-	list of arguments following the 'set' subcommand. Update the
-	working directory to match the new patterns.
+	populate the sparse-checkout file from the list of arguments
+	following the 'set' subcommand, and update the working directory to
+	match.
 +
 To ensure that adjusting the sparse-checkout settings within a worktree
 does not alter the sparse-checkout settings in other worktrees, the 'set'
@@ -60,15 +60,15 @@ When the `--stdin` option is provided, the directories or patterns are
 read from standard in as a newline-delimited list instead of from the
 arguments.
 +
-When `--cone` is passed or `core.sparseCheckoutCone` is not false, the
-input list is considered a list of directories.  This allows for
-better performance with a limited set of patterns (see 'CONE PATTERN
-SET' below).  The input format matches the output of `git ls-tree
---name-only`.  This includes interpreting pathnames that begin with a
-double quote (") as C-style quoted strings.  Note that the set command
-will write patterns to the sparse-checkout file to include all files
-contained in those directories (recursively) as well as files that are
-siblings of ancestor directories.
+By default, the input list is considered a list of directories, matching
+the output of `git ls-tree -d --name-only`.  This includes interpreting
+pathnames that begin with a double quote (") as C-style quoted strings.
+Note that all files under the specified directories (at any depth) will
+be included in the sparse checkout, as well as files that are siblings
+of either the given directory or any of its ancestors (see 'CONE PATTERN
+SET' below for more details).  In the past, this was not the default,
+and `--cone` needed to be specified or `core.sparseCheckoutCone` needed
+to be enabled.
 +
 When `--no-cone` is passed or `core.sparseCheckoutCone` is set to false,
 the input list is considered a list of patterns.  This mode is harder
@@ -208,10 +208,9 @@ the following patterns:
 This says "include everything in root, but nothing two levels below root."
 
 When in cone mode, the `git sparse-checkout set` subcommand takes a list of
-directories instead of a list of sparse-checkout patterns. In this mode,
-the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
-a recursive pattern, the directories `A` and `A/B` are added as parent
-patterns. The resulting sparse-checkout file is now
+directories. In this mode, the command `git sparse-checkout set A/B/C` sets
+the directory `A/B/C` as a recursive pattern, the directories `A` and `A/B`
+are added as parent patterns. The resulting sparse-checkout file is now
 
 ----------------
 /*
-- 
gitgitgadget

