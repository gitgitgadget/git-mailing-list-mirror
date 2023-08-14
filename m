Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB5BC04A94
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 15:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjHNPMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjHNPM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 11:12:27 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B51701
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:21 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3196afc7d4bso1749525f8f.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 08:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692025939; x=1692630739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2FQoPMLFnkA9AHBm5fQVhne5jALeyP9JS8KJLLnMmk=;
        b=HM/V4/NvLVJTySjJW8m3lJy3aki2iZyS4JYsirjb1aEMIpz75IuWagwweRYGrYETMo
         hn9mxPsD8ByFV3qnjkAzegoThT1gyzNY1N0yVIezDAVEtjzu/j8Ws7px7JSAYD9FZZIL
         H4j67QA39CkpsPgSdtp1ab15skA//SlkdszFp/K/H6SRZpyShETpSFbcKwYFO+8Jf4zW
         9Kx4m9mLAzAPe4I3X7GF2bG6J5W7BWYbG8tCb6YEwKJgJNqlkycVd4BZML0eBpxqvwOy
         yeu1W+ZAdcRhKsoQNq+3bhRXjAvganxNkC3vnTMSakOEz8u4n1zv+Eabj3KJPVLgW3Db
         ufLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692025939; x=1692630739;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2FQoPMLFnkA9AHBm5fQVhne5jALeyP9JS8KJLLnMmk=;
        b=h3HH2yVglUGJRhJhBqaP8i8w1LcXQi6OFmUw2ac78Iqt1OCYl6tXAEIG/1eUPzQz3O
         runjBrLTKI8rGngry4UmCqSKPU0hz3TUIrUD0MBT5PoP6EzV2lbS0Gm8CqEwR4RsfRJE
         cxI/3CzCIUoOK5uH22r5R+9d6Giwfxmy0BbGj02j+dUVjo4ueX0tU/0UdUJwJH3Nbxj3
         8NXfvoSALWfl0BGWX+zjsosbaC+EmkYnYpx5d304Z5X7LjSfWQKqDhyPyURYsflKwmIc
         kFd8qHllw1gzC2R8BBzKnLLLEz8LToB1pGbMcJDjODd9ksNGswYQyZ/uyvbCaBti56dX
         ggJA==
X-Gm-Message-State: AOJu0YzAixHH9jkRzwA2MtM+MCfh7zEuXP2jM+W99A6jpG0Xtez+hpTR
        5LD7rCPB5gCnTkGOoIQhSL0SluIh2TA=
X-Google-Smtp-Source: AGHT+IH+g9fQvMPSFTE4Q+Ni7jNL9JMvXWkfXNduBDXZkeu7I9dwkKk/t1ZMjaRCQ1XquyILmeHPEw==
X-Received: by 2002:adf:f2d2:0:b0:319:63f3:c0cb with SMTP id d18-20020adff2d2000000b0031963f3c0cbmr6365981wrp.40.1692025939437;
        Mon, 14 Aug 2023 08:12:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d53c4000000b00319756d5b80sm4493866wrw.29.2023.08.14.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:12:19 -0700 (PDT)
Message-ID: <c1c7e2f049e762b9b60614a5732e4d41db1d0da5.1692025937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Aug 2023 15:12:15 +0000
Subject: [PATCH 1/3] scalar: add --[no-]src option
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
 t/t9211-scalar-clone.sh  |  8 ++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/scalar.txt b/Documentation/scalar.txt
index f33436c7f65..cd65b3e230d 100644
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
+	Specify if the repository should be created within a `src` directory
+	within `<enlistment>`. This is the default behavior, so use
+	`--no-src` to opt-out of the creation of the `src` directory.
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
index 872ad1c9c2b..7ee73aba092 100755
--- a/t/t9211-scalar-clone.sh
+++ b/t/t9211-scalar-clone.sh
@@ -180,4 +180,12 @@ test_expect_success 'scalar clone warns when background maintenance fails' '
 	grep "could not turn on maintenance" err
 '
 
+test_expect_success '`scalar clone --no-src`' '
+	scalar clone --src "file://$(pwd)/to-clone" with-src &&
+	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
+
+	test_path_is_dir with-src/src &&
+	test_path_is_missing without-src/src
+'
+
 test_done
-- 
gitgitgadget

