Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D54FEE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjHVRYX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjHVRYW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 13:24:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8840CCA
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fee8b78097so28048015e9.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725058; x=1693329858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUy7xL7G56fsl+yLjM6dx9SX9QttlZv1Nm3ht1K6PnU=;
        b=Whge/9p1A+IxauucazBlWW1g6D/ue1x1qAco5dlqlnyQscv3SvR5xx4UJMZcAj7iSU
         f5ELQn5DlDN/mHwvC9wN1JCtjYWmljoSozSJ5aKnHLzQb0VTAiC3NA8QXwMfqTJmvtfH
         osVgIV56JtblPalXUW3Er6pjPgZpj7UaduMBzsiwhgyRBKKAN9eDtunKEqhGVXrrtt/5
         2Wy74ahCHeLI89Eym5ensPqflVxKwyrZm5xU65wMTzP9U9mLCfQMiSolhJddYy9Bg8db
         Fmbc3n4HfZdfvzVtY1XV55w0WWSIfVYFw0k6uAxTWYyV8o/AfpxU2BjkraQE6NOldE4n
         nWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725058; x=1693329858;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUy7xL7G56fsl+yLjM6dx9SX9QttlZv1Nm3ht1K6PnU=;
        b=QHwwY6n3JT91s0c+Vo6HojJsfL20nI66HLF99rbhDy3k3IToSY/QIsmfEmbRPP/1Ob
         3ndTWi9lHt5kf38ZhhZed8yT61iikIl8lv38mTavNcFBR0lPKSb5VItT6OHothsJ4cG9
         rxR5cL1har9rMQhCjfVxr67C3/AutgCcG7ZxW4s0HTzTJf4EsAqhcSg8MEFuTyWZkhBM
         itNKtWFZu2oyNmM0TNVCHEnvc7HQwTqgFhAaAnoN8IAk7AvUxFcWAj+wUG2Ch5FPTgNz
         7XgTHeRdT+y+EJ+FgxGtkNXYVeZ7pXLmJGpV+UoYT9P4NeeBSVwDAZg6B6HycKnYlzUG
         86AA==
X-Gm-Message-State: AOJu0YyjNPCulGZvlveYWdjCVVou6u8psuyTHnPX4P7d83puza+goL7C
        hnIqx2UU049KdZak/URfv5abE7m/Bh8=
X-Google-Smtp-Source: AGHT+IEkcqVX5echccsBDjxWtkLSxwXMUhD+u9Dr1Ap/l3zO0kH4oF9yY82fxi+zMx0Mi3Oliq8bog==
X-Received: by 2002:a1c:4c15:0:b0:3fb:dd5d:76b with SMTP id z21-20020a1c4c15000000b003fbdd5d076bmr7864010wmf.7.1692725057863;
        Tue, 22 Aug 2023 10:24:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c204400b003fe407ca05bsm20036806wmg.37.2023.08.22.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 10:24:17 -0700 (PDT)
Message-ID: <0b6957beccbd1815c49c15c3525bfd6cbe077d34.1692725056.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
        <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Aug 2023 17:24:13 +0000
Subject: [PATCH v2 1/3] scalar: add --[no-]src option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Some users have strong aversions to Scalar's opinion that the repository
should be in a 'src' directory, even though it creates a clean slate for
placing build outputs in adjacent directories.

The --no-src option allows users to opt-out of the default behavior.

While adding options, make sure the usage output by 'scalar clone -h'
reports the same as the SYNOPSIS line in Documentation/scalar.txt.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/scalar.txt |  8 +++++++-
 scalar.c                 | 11 +++++++++--
 t/t9211-scalar-clone.sh  | 12 ++++++++++++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
index f33436c7f65..361f51a6473 100644
--- a/Documentation/scalar.txt
+++ b/Documentation/scalar.txt
@@ -8,7 +8,8 @@ scalar - A tool for managing large Git repositories
 SYNOPSIS
 --------
 [verse]
-scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<enlistment>]
+scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]
+	[--[no-]src] <url> [<enlistment>]
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
@@ -80,6 +81,11 @@ remote-tracking branch for the branch this option was used for the initial
 cloning. If the HEAD at the remote did not point at any branch when
 `--single-branch` clone was made, no remote-tracking branch is created.
 
+--[no-]src::
+	By default, `scalar clone` places the cloned repository within a
+	`<entlistment>/src` directory. Use `--no-src` to place the cloned
+	repository directly in the `<enlistment>` directory.
+
 --[no-]full-clone::
 	A sparse-checkout is initialized by default. This behavior can be
 	turned off via `--full-clone`.
diff --git a/scalar.c b/scalar.c
index df7358f481c..938bb73f3ce 100644
--- a/scalar.c
+++ b/scalar.c
@@ -409,6 +409,7 @@ static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
 	int full_clone = 0, single_branch = 0, show_progress = isatty(2);
+	int src = 1;
 	struct option clone_options[] = {
 		OPT_STRING('b', "branch", &branch, N_("<branch>"),
 			   N_("branch to checkout after clone")),
@@ -417,10 +418,13 @@ static int cmd_clone(int argc, const char **argv)
 		OPT_BOOL(0, "single-branch", &single_branch,
 			 N_("only download metadata for the branch that will "
 			    "be checked out")),
+		OPT_BOOL(0, "src", &src,
+			 N_("create repository within 'src' directory")),
 		OPT_END(),
 	};
 	const char * const clone_usage[] = {
-		N_("scalar clone [<options>] [--] <repo> [<dir>]"),
+		N_("scalar clone [--single-branch] [--branch <main-branch>] [--full-clone]\n"
+		   "\t[--[no-]src] <url> [<enlistment>]"),
 		NULL
 	};
 	const char *url;
@@ -456,7 +460,10 @@ static int cmd_clone(int argc, const char **argv)
 	if (is_directory(enlistment))
 		die(_("directory '%s' exists already"), enlistment);
 
-	dir = xstrfmt("%s/src", enlistment);
+	if (src)
+		dir = xstrfmt("%s/src", enlistment);
+	else
+		dir = xstrdup(enlistment);
 
 	strbuf_reset(&buf);
 	if (branch)
diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
index 872ad1c9c2b..7869f45ee64 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -180,4 +180,16 @@ test_expect_success 'scalar clone warns when background maintenance fails' '
 	grep "could not turn on maintenance" err
 '
 
+test_expect_success '`scalar clone --no-src`' '
+	scalar clone --src "file://$(pwd)/to-clone" with-src &&
+	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
+
+	test_path_is_dir with-src/src &&
+	test_path_is_missing without-src/src &&
+
+	(cd with-src/src && ls ?*) >with &&
+	(cd without-src && ls ?*) >without &&
+	test_cmp with without
+'
+
 test_done
-- 
gitgitgadget

