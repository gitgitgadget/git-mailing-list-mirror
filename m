Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3388C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADD361BE3
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhKQOXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhKQOXB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:23:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1CC0611FE
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:41 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a9so5018787wrr.8
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5J6efhqLKwPw37BZdtrl+rmUFh3AZSA48OGeWE6mV7E=;
        b=kXlipG4VI2VLGJdSMTo1s5d2DiVyJaBjZCwSWPctVuLZ72lN6w8sGOi+4FLcrJplG1
         ZTMcczRRdVsqNDP+xSUB+fTddcWg2wcZz5A8WsKlFpK0q37UgviWAaZwwL/jZhuYknK7
         00BzZPPp+e+AYWFp/KK5Pb+rDyzLOcqAcnG8gazFm2+lFiBiraOIjr465lJzDO6KzCX1
         HzuTJFcyh2FCwbwLPZ3hGHXqWfDv2ntoeThjgIt+lMe/rvnm3u2CqaiLRfa1vd6O6R+o
         n5OVazQpM0Ykaqrv0Qf73DP/jAjjUxxfCgnR2KeCdyuLH/aBDpopoS42MgNgBhMhQoho
         zrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5J6efhqLKwPw37BZdtrl+rmUFh3AZSA48OGeWE6mV7E=;
        b=gorcWeV9N5h0yWLCHGyaknmiJomNpP0QMUU6vTyTaVdcgs3p4B8M8INQwVFn1njGC/
         RGfpMl5RK/l3BU/2M1erAYRD9tz4fcDIvHqEfgv9cqvu4SynoOLgkOTuMmHELmF8LXN8
         ERTP83w40dZ4a5hkVTFzfuz7M5x9xOhYh2M+6rf9S1qJ9HufZLmPoH275WSr6JJFSMxx
         q08tDCQKAoxc9/mXQA6395rC2CgheLXeGqS8AhOlU4Q/6TKeYE7u95V4Q0rDPoqkOcgK
         eYxBR7TMmJew5DS7eae2jS1Jteul5R/k+1goHPRcJhd5ODwmKsk72I+YOnu35p5wM3sj
         JbhQ==
X-Gm-Message-State: AOAM532ECn2uRXpvJ3xDZl3zdaB4OohuVnbpLLvBP/dJw1+a8Wr4GiSy
        OqGQ6yBgT2OoF4Mny+yBaB3JZv6cgZE=
X-Google-Smtp-Source: ABdhPJzaNrUXtG401eZOXY5UJqe0cDDgFIEe4uyOCh1gSi5K+Ld/XyojMiQVVFmEjBi5SXz/5mIpfQ==
X-Received: by 2002:adf:d84c:: with SMTP id k12mr20702103wrl.24.1637158779559;
        Wed, 17 Nov 2021 06:19:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l26sm6616939wms.15.2021.11.17.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:39 -0800 (PST)
Message-Id: <99affb84284e3c8f868104bde98de8446f57b309.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:18 +0000
Subject: [PATCH v7 13/17] scalar: implement the `run` command
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

Note: this subcommand is provided primarily for backwards-compatibility,
for existing Scalar uses. It is mostly just a shim for `git
maintenance`, mapping task names from the way Scalar called them to the
way Git calls them.

The reason why those names differ? The background maintenance was first
implemented in Scalar, and when it was contributed as a patch series
implementing the `git maintenance` command, reviewers suggested better
names, those suggestions were accepted before the patches were
integrated into core Git.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/scalar/scalar.c   | 64 +++++++++++++++++++++++++++++++++++++++
 contrib/scalar/scalar.txt | 19 ++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 516a75be3c4..ca524576011 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -484,6 +484,69 @@ static int cmd_register(int argc, const char **argv)
 	return register_dir();
 }
 
+static int cmd_run(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END(),
+	};
+	struct {
+		const char *arg, *task;
+	} tasks[] = {
+		{ "config", NULL },
+		{ "commit-graph", "commit-graph" },
+		{ "fetch", "prefetch" },
+		{ "loose-objects", "loose-objects" },
+		{ "pack-files", "incremental-repack" },
+		{ NULL, NULL }
+	};
+	struct strbuf buf = STRBUF_INIT;
+	const char *usagestr[] = { NULL, NULL };
+	int i;
+
+	strbuf_addstr(&buf, N_("scalar run <task> [<enlistment>]\nTasks:\n"));
+	for (i = 0; tasks[i].arg; i++)
+		strbuf_addf(&buf, "\t%s\n", tasks[i].arg);
+	usagestr[0] = buf.buf;
+
+	argc = parse_options(argc, argv, NULL, options,
+			     usagestr, 0);
+
+	if (!argc)
+		usage_with_options(usagestr, options);
+
+	if (!strcmp("all", argv[0])) {
+		i = -1;
+	} else {
+		for (i = 0; tasks[i].arg && strcmp(tasks[i].arg, argv[0]); i++)
+			; /* keep looking for the task */
+
+		if (i > 0 && !tasks[i].arg) {
+			error(_("no such task: '%s'"), argv[0]);
+			usage_with_options(usagestr, options);
+		}
+	}
+
+	argc--;
+	argv++;
+	setup_enlistment_directory(argc, argv, usagestr, options, NULL);
+	strbuf_release(&buf);
+
+	if (i == 0)
+		return register_dir();
+
+	if (i > 0)
+		return run_git("maintenance", "run",
+			       "--task", tasks[i].task, NULL);
+
+	if (register_dir())
+		return -1;
+	for (i = 1; tasks[i].arg; i++)
+		if (run_git("maintenance", "run",
+			    "--task", tasks[i].task, NULL))
+			return -1;
+	return 0;
+}
+
 static int remove_deleted_enlistment(struct strbuf *path)
 {
 	int res = 0;
@@ -556,6 +619,7 @@ static struct {
 	{ "list", cmd_list },
 	{ "register", cmd_register },
 	{ "unregister", cmd_unregister },
+	{ "run", cmd_run },
 	{ NULL, NULL},
 };
 
diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
index 56f744a4aa9..39143b08324 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -12,6 +12,7 @@ scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<e
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
+scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -98,6 +99,24 @@ unregister [<enlistment>]::
 	Remove the specified repository from the list of repositories
 	registered with Scalar and stop the scheduled background maintenance.
 
+Run
+~~~
+
+scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]::
+	Run the given maintenance task (or all tasks, if `all` was specified).
+	Except for `all` and `config`, this subcommand simply hands off to
+	linkgit:git-maintenance[1] (mapping `fetch` to `prefetch` and
+	`pack-files` to `incremental-repack`).
++
+These tasks are run automatically as part of the scheduled maintenance,
+as soon as the repository is registered with Scalar. It should therefore
+not be necessary to run this subcommand manually.
++
+The `config` task is specific to Scalar and configures all those
+opinionated default settings that make Git work more efficiently with
+large repositories. As this task is run as part of `scalar clone`
+automatically, explicit invocations of this task are rarely needed.
+
 SEE ALSO
 --------
 linkgit:git-clone[1], linkgit:git-maintenance[1].
-- 
gitgitgadget

