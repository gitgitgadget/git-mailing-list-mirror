Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA31C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2132861037
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhJGLBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbhJGLBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CC5C061760
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r10so17792871wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SJgwnf3rJRV5fMleXZ2nSdcJHBhDnyI3ULuJxOiFMCg=;
        b=CszVpZPLQc4YvCkfcY9fTReH1XIdegWpnHjsspTsQSYcWTlzEn3DqMjER/tVxWp9k/
         teY3DThA21iDkYte9WVTcGKIkDqQ3NuhmObZSA+PKNH90NySIJmyyLxyjUMM9t2QM+xG
         Imc1lL2mEws/vae5ziC0WOXJX4G2wKWpelUR3sGOt+AsZMxzL6rvhTcgbL6ZoZ839+nF
         rs2WMuhtVrYiA71UFyEgL/Tp1sNYr9QyMx7hGlDLu6zTHqdUZAl4naf9MffgMZ6Bp/Hv
         U+31QEWZwrWvQ/IjZkP543ldWQdg8tvx7rPygYWxVBW6MbpfzNcwX6REK5VTqO4cKOLm
         Rrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SJgwnf3rJRV5fMleXZ2nSdcJHBhDnyI3ULuJxOiFMCg=;
        b=Psp/fWdI8LSS89dzvRtJFx5P4/3p4YgpQRy9GS3/fkxcWl7sb+G/VTArIu98tK1bVK
         ZvizkmjynTqcYkv+WOhW+T+Uk6nxC8rnEYmX+mUIvyTQK91L5Qp/qt1RvjOkOmorLxFZ
         wskJbnhDdJZCDMhBde98ee0GXXq9T53RJLJVV/Ed8P3aIh/Qv6z7mZcxybFccNAKCtYB
         WxRLNlwEJnjTbHYffwowjncDfdY4aQLhKNgzv3tTXEJwvEJ6wpNhytMxVbTQdBd5Tyyi
         EMh1I5+us/bA0B6YQDEYYVeb3/t+WeZDdtR4vOb2DwQW5BEoUt2oxgZEhBfphXiqUazr
         V6iw==
X-Gm-Message-State: AOAM530eJ1j6NewW88t+DLil9J9sCOGv6CBplMG7XaPhxz8q1FKYm/em
        dG099rl7FMgG2pP4uL696v2bO7nsMO4=
X-Google-Smtp-Source: ABdhPJz+r1Wpe0hiNXZZjRrM6Yl8y7V9uiZEZq420Ap676HbMTDf/zTKJrVExaCF2s/ZMcp192kHVg==
X-Received: by 2002:a1c:d7:: with SMTP id 206mr15597615wma.116.1633604354226;
        Thu, 07 Oct 2021 03:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j27sm9778901wms.6.2021.10.07.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:13 -0700 (PDT)
Message-Id: <51b5fc577c9ea7d8f5f7f7c676e9b2c25b65f71c.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:58:59 +0000
Subject: [PATCH v5 05/15] scalar: 'unregister' stops background maintenance
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
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Just like `scalar register` starts the scheduled background maintenance,
`scalar unregister` stops it. Note that we use `git maintenance start`
in `scalar register`, but we do not use `git maintenance stop` in
`scalar unregister`: this would stop maintenance for _all_ repositories,
not just for the one we want to unregister.

The `unregister` command also removes the corresponding entry from the
`[scalar]` section in the global Git config.

Co-authored-by: Victoria Dye <vdye@github.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 50 ++++++++++++++++++++++++++++++++-------
 contrib/scalar/scalar.txt |  8 +++++++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 38721d671ba..fc55404230d 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -197,12 +197,12 @@ static int set_recommended_config(void)
 	return 0;
 }
 
-static int start_maintenance(void)
+static int toggle_maintenance(int enable)
 {
-	return run_git("maintenance", "start", NULL);
+	return run_git("maintenance", enable ? "start" : "unregister", NULL);
 }
 
-static int add_enlistment(void)
+static int add_or_remove_enlistment(int add)
 {
 	int res;
 
@@ -213,24 +213,39 @@ static int add_enlistment(void)
 		      "scalar.repo", the_repository->worktree, NULL);
 
 	/*
-	 * If the setting is already there, then do nothing.
+	 * If we want to add and the setting is already there, then do nothing.
+	 * If we want to remove and the setting is not there, then do nothing.
 	 */
-	if (!res)
+	if ((add && !res) || (!add && res))
 		return 0;
 
-	return run_git("config", "--global", "--add",
+	return run_git("config", "--global", add ? "--add" : "--unset",
+		       add ? "--no-fixed-value" : "--fixed-value",
 		       "scalar.repo", the_repository->worktree, NULL);
 }
 
 static int register_dir(void)
 {
-	int res = add_enlistment();
+	int res = add_or_remove_enlistment(1);
 
 	if (!res)
 		res = set_recommended_config();
 
 	if (!res)
-		res = start_maintenance();
+		res = toggle_maintenance(1);
+
+	return res;
+}
+
+static int unregister_dir(void)
+{
+	int res = 0;
+
+	if (toggle_maintenance(0) < 0)
+		res = -1;
+
+	if (add_or_remove_enlistment(0) < 0)
+		res = -1;
 
 	return res;
 }
@@ -253,11 +268,30 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_unregister(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	const char * const usage[] = {
+		N_("scalar unregister [<enlistment>]"),
+		NULL
+	};
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usage, 0);
+
+	setup_enlistment_directory(argc, argv, usage, options, NULL);
+
+	return unregister_dir();
+}
+
 static struct {
 	const char *name;
 	int (*fn)(int, const char **);
 } builtins[] = {
 	{ "register", cmd_register },
+	{ "unregister", cmd_unregister },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 568987064b2..d9a79984492 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 scalar register [<enlistment>]
+scalar unregister [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -45,6 +46,13 @@ Note: when this subcommand is called in a worktree that is called `src/`, its
 parent directory is considered to be the Scalar enlistment. If the worktree is
 _not_ called `src/`, it itself will be considered to be the Scalar enlistment.
 
+Unregister
+~~~~~~~~~~
+
+unregister [<enlistment>]::
+	Remove the specified repository from the list of repositories
+	registered with Scalar and stop the scheduled background maintenance.
+
 SEE ALSO
 --------
 linkgit:git-maintenance[1].
-- 
gitgitgadget

