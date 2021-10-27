Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B97C433FE
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B00610A0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbhJ0IaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbhJ0I3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:29:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C00C061767
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y205-20020a1c7dd6000000b0032cc8c2800fso4604723wmc.4
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SJgwnf3rJRV5fMleXZ2nSdcJHBhDnyI3ULuJxOiFMCg=;
        b=EjhDZslY2Zo6lKI3ozgmRuxxeCpNgPS97YnmFGSaBFnCKWPbm19Tzo8PEilhnj9DCP
         ztPcBb/cFzCFknSLQXAZnjZQURpDjtSlVvmksq4N4gVCtEGRnQ9zdyKfNTahLj+2DCcW
         RsL+xQjnidX5nfHCWFqQJ5HvlTZRChGmn89ocD7u1+4SqCYM9RkIVWQv8OIoMWZjv96u
         rfMVbAKZfGrkhW3MT67EVjXEcKurN46A6uz8VyL5OzVqy4eCQrX//Doo4sjEz4Yduc8j
         0OwbjZOdkoPGB/sJR2w5/EviFbWK6s2vFCkP7FNqZdspDrOj4YBEc7itNfH+8HWO2ST5
         TiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SJgwnf3rJRV5fMleXZ2nSdcJHBhDnyI3ULuJxOiFMCg=;
        b=OXgVqXYUQHjgjEFlT/TbUODAT+Bpca73XcdJfNhBCOBOPAVlvH78BB5DwkEmD3uRTZ
         lT9AmcPZlzD2/9Vzhs7OwtmbA4VmlDsCaJJKBXJvUEQvbBn0N1NalGISFiUjIKZ09AWf
         EV0SHc6wM0VBPSmlAIKQcZTrxlqIbBBA8f3d0j2dxznmSUflCo683f1NH+ZwzjJHADvw
         EVBENxu3THEvD14UnCGj5vJJwIF+7a1tBp19mNtwKhoFDQBW6EWqI4YEyGR8YYQaxWgq
         BoQgH3KwK6EaBaW+TVGKqDoFAUgSVMEMbehagFwVSkap2C8ialdtoo4X7WeFZVjSeaoh
         lFQg==
X-Gm-Message-State: AOAM530UY56XkkwkOoOvG48McU9ghOAias3lXTWbaI4rELsTwu7DpYs1
        CZ0QHw/uUi5pzLRMch/pUalQ5JyrvN8=
X-Google-Smtp-Source: ABdhPJxLlSrStw7qnjpFxZo0FMF/Qvdzxq4LxWvseNKAXZuAEwlwRbQ+PEhEO/rvoaPSUIgi18WQSg==
X-Received: by 2002:a7b:c441:: with SMTP id l1mr4093622wmi.69.1635323243533;
        Wed, 27 Oct 2021 01:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m31sm2714910wms.25.2021.10.27.01.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:23 -0700 (PDT)
Message-Id: <3591e53700bbf9e193af4ad8c14793fcc377292e.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:09 +0000
Subject: [PATCH v6 05/15] scalar: 'unregister' stops background maintenance
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

