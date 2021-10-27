Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2584CC433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E06C61090
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhJ0Iab (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240943AbhJ0IaF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:30:05 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA920C06122F
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so1620636wmj.3
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LsnYG1NdA6AzQDz9+MnzYCvyx4uf9jKqkP91nSQVJYA=;
        b=mkDw/W3FWPlG9YbPz89e1pLmWY8T9xFYmnZASLhB+0cEm3y5eSQCqJRDAoln8a418Y
         Ov9F8iTuPh4pFSDZPMOkszVQ+BhQDjlwZM7+BAgmeVwzhSOhnOsMVzcGKoloaOmSQTXU
         5kLdu5zZe934p32PqOJSby4+J/jsk3ngELOlptCyPvn3PutGQ2VUMUxvGheF7S9gVQLc
         FTbXKxdlxpl5Lg/xre8vMCZOJstel4BR2j+VH7guwtdiiNUqz3BbEfd7KaIk0gCT/Nyo
         MipTiPNP2MN6c8dQwlxVs8RLe1Qmm7e9/jzG0EmXYk4tM4bXkdU2XLZJ466RyYp5NgAt
         KSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LsnYG1NdA6AzQDz9+MnzYCvyx4uf9jKqkP91nSQVJYA=;
        b=HHDOaABNlGQUGvNqRP2tVCAsyRQhqFQaRzicr65LIn+mmt4vKwy55CpiM3io7PuoF1
         npDb8925vmnDnmT5hfhQV1slGaSv9AASB/2I4l1GyIviEjpywXRe6Gt5bDqX4CJ0dS1z
         Ed8vUKfaagCMyKXHb2KszdmZs4JrrbWn16AvPEzHq76ofMHuvGWvDah4/9Mu1cMz7aH0
         V7yAPDRMdpEIn3tYnqlNKWogJJLw0+Cf3Z6WM8E17jdEjCQW9ribhDanGTeubISjOo/Z
         C8BGbVpxNyv8Q2lwLCT9EZzJqg3q1R9PnO1P2DhmRkIGDXua9a+1uQfqQr487bHOtm8j
         Z0Fg==
X-Gm-Message-State: AOAM530Wk1Kz7wfhUEoWKjS5wlB82yB7dlXgJ7u0ScxEe+WEFDYVp+Kv
        ByL7iITV+Rn2fG1A/WCgxG212ievweQ=
X-Google-Smtp-Source: ABdhPJw2SrSlnK4JTxlAQogD7uzi7O97baWzrI6pWYEt76fyYPBoamSNuos1nWX/3kIfsT1p8GxrdQ==
X-Received: by 2002:a05:600c:2049:: with SMTP id p9mr2806774wmg.36.1635323248342;
        Wed, 27 Oct 2021 01:27:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm12139020wrd.75.2021.10.27.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:27 -0700 (PDT)
Message-Id: <843026d54812dd5408270b4ddc2ba9873819e631.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:17 +0000
Subject: [PATCH v6 13/15] scalar: implement the `delete` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Delete an enlistment by first unregistering the repository and then
deleting the enlistment directory (usually the directory containing the
worktree `src/` directory).

On Windows, if the current directory is inside the enlistment's
directory, change to the parent of the enlistment directory, to allow us
to delete the enlistment (directories used by processes e.g. as current
working directories cannot be deleted on Windows).

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c          | 63 ++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt        |  8 ++++
 contrib/scalar/t/t9099-scalar.sh |  9 +++++
 3 files changed, 80 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 234a7dce479..8aaeca7cc64 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -8,6 +8,8 @@
 #include "config.h"
 #include "run-command.h"
 #include "refs.h"
+#include "dir.h"
+#include "packfile.h"
 
 /*
  * Remove the deepest subdirectory in the provided path string. Path must not
@@ -327,6 +329,33 @@ static char *remote_default_branch(const char *url)
 	return NULL;
 }
 
+static int delete_enlistment(struct strbuf *enlistment)
+{
+#ifdef WIN32
+	struct strbuf parent = STRBUF_INIT;
+#endif
+
+	if (unregister_dir())
+		die(_("failed to unregister repository"));
+
+#ifdef WIN32
+	/*
+	 * Change the current directory to one outside of the enlistment so
+	 * that we may delete everything underneath it.
+	 */
+	strbuf_addbuf(&parent, enlistment);
+	strbuf_parent_directory(&parent);
+	if (chdir(parent.buf) < 0)
+		die_errno(_("could not switch to '%s'"), parent.buf);
+	strbuf_release(&parent);
+#endif
+
+	if (remove_dir_recursively(enlistment, 0))
+		die(_("failed to delete enlistment directory"));
+
+	return 0;
+}
+
 static int cmd_clone(int argc, const char **argv)
 {
 	const char *branch = NULL;
@@ -687,6 +716,39 @@ static int cmd_unregister(int argc, const char **argv)
 	return unregister_dir();
 }
 
+static int cmd_delete(int argc, const char **argv)
+{
+	char *cwd = xgetcwd();
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar delete <enlistment>"),
+		NULL
+	};
+	struct strbuf enlistment = STRBUF_INIT;
+	int res = 0;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	if (argc != 1)
+		usage_with_options(usage, options);
+
+	setup_enlistment_directory(argc, argv, usage, options, &enlistment);
+
+	if (dir_inside_of(cwd, enlistment.buf) >= 0)
+		res = error(_("refusing to delete current working directory"));
+	else {
+		close_object_store(the_repository->objects);
+		res = delete_enlistment(&enlistment);
+	}
+	strbuf_release(&enlistment);
+	free(cwd);
+
+	return res;
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
@@ -697,6 +759,7 @@ static struct {
 	{ "unregister", cmd_unregister },
 	{ "run", cmd_run },
 	{ "reconfigure", cmd_reconfigure },
+	{ "delete", cmd_delete },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 737cf563c1a..f416d637289 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -14,6 +14,7 @@ scalar register [<enlistment>]
 scalar unregister [<enlistment>]
 scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 scalar reconfigure [ --all | <enlistment> ]
+scalar delete <enlistment>
 
 DESCRIPTION
 -----------
@@ -128,6 +129,13 @@ reconfigure the enlistment.
 With the `--all` option, all enlistments currently registered with Scalar
 will be reconfigured. Use this option after each Scalar upgrade.
 
+Delete
+~~~~~~
+
+delete <enlistment>::
+	This subcommand lets you delete an existing Scalar enlistment from your
+	local file system, unregistering the repository.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 5fe7fabd0e5..7e8771d0eff 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -76,4 +76,13 @@ test_expect_success 'scalar reconfigure' '
 	test true = "$(git -C one/src config core.preloadIndex)"
 '
 
+test_expect_success 'scalar delete without enlistment shows a usage' '
+	test_expect_code 129 scalar delete
+'
+
+test_expect_success 'scalar delete with enlistment' '
+	scalar delete cloned &&
+	test_path_is_missing cloned
+'
+
 test_done
-- 
gitgitgadget

