Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37027C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 13:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjH1Nw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 09:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjH1Nwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 09:52:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE5C0
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401ceda85cdso3949615e9.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 06:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693230749; x=1693835549;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ma/LVAu3UJU2P7GZt6zvEcUB9KDjuxMMaQnRr0cfGME=;
        b=JszjdEPrfarUTAsCXlT+c/tUCK+n4YVMYOvHyVdomrpmfD23kebbUVcsg+oSHMRibP
         ene7Zz/5nyx5ONUqeCsIMe+6sDf2hiFwhhnACD6a1gklaVzBOedLJa2zyy3TFbpDQ+rh
         onrM137F2jhIs0Mifsk9JzboUPtyymEGIYcFo2f12lVqP9dU+rgMjRWWgVQWsVc0CiyM
         VbdwTE3LUTt1bUdu8vWZgKAQysWa12vjH5B5s+GRX5s/CS8hWqklfHbvDlSBwVkVUIEK
         M5Nuy/eA8ZbsdGSFxZDvNPNrHMjxCsfElNKNsPzgU63JHiihp4PKzU1/p6/U2vSkilDn
         aFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693230749; x=1693835549;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ma/LVAu3UJU2P7GZt6zvEcUB9KDjuxMMaQnRr0cfGME=;
        b=V4BBetio69f1PtwNgMARjDXPa+mwK/f2c5/DO0ZsteFJKBdab6A8BhTvnl3NiFDEcV
         LiRTihGf/QpSeX2OmaH+5LQteOf14ts1inZzrCBztdtbVs00Ir3qeeVJOr+IJiABGFWn
         oyD51FRYgTSeZJnqCpnJ8rJgJS8o1qOHk0D1Rd4b3iz1mIA8x1tH/M0deHh+5QWn60gr
         rLc5INRVxDuWg0qSdUryya0SHbmuhnmxvzG+g3yca0zBq76tGoLT+gD6wV2X9c7WyLlV
         3AxzsBCWgK+l3CgDLCy4haQlyqA5jF5ppsRpzPlHZC6QJPHuSmBRTa1Zr92dSMqM2CvZ
         GwPQ==
X-Gm-Message-State: AOJu0YyUedKf5/sMMSRJPiYrKHda/18ObszvBJA3zcxmzQ/jGLgXrOxE
        PUsWF5UNoCEsveQqicRtgSCxQLmyuek=
X-Google-Smtp-Source: AGHT+IHTmuc5hfJ9KO8HJ3YLUMK261HKNLG+CFqU3ctV7C5LPxkf8jhQfIz3HN5G9tZnghQ5P4jnhg==
X-Received: by 2002:a1c:ed14:0:b0:401:b1c6:97dc with SMTP id l20-20020a1ced14000000b00401b1c697dcmr7233654wmh.23.1693230748678;
        Mon, 28 Aug 2023 06:52:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003fedcd02e2asm10840372wmj.35.2023.08.28.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:52:28 -0700 (PDT)
Message-ID: <e9858b31db66101b04d93695390f48316bae8199.1693230746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
References: <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
        <pull.1569.v3.git.1693230746.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Aug 2023 13:52:24 +0000
Subject: [PATCH v3 1/3] scalar: add --[no-]src option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Some users have strong aversions to Scalar's opinion that the repository
should be in a 'src' directory, even though this creates a clean slate
for placing build artifacts in adjacent directories.

The new --no-src option allows users to opt out of the default behavior.

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

