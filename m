Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B487EC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F47E61073
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 08:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbhJ0IaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 04:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhJ0IaB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 04:30:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F9C061229
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d13so2647371wrf.11
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eLdul3jk7I0UMVOSFxEGqDEf7DigzLk/FEfs6EOhO/A=;
        b=Ppo08mxcSPHrj8nS61xjMtTK+p/VjbEbtSTnUb3JWPuA26d5YFordwbng1Hnp/Rx+5
         5TDCIhhwgcTKhnGBj/VyHKO734PQfcwQ2iqNCOUq7O625jebC2qlZ8IJwMHiisnEqmA6
         /gK2U3Wy8Lf8FO4GaTwHq2SKPMMbil5uaHOzkbPbFr+u0s9+vdX4u+HO+fJ6RKBFpfi6
         JIH1kDLzwmUBbRvGDDWVkFiXBopEZ+e41CkCBjGA/OuXZWD8RNi0C1wvTzIJjH1MfPaZ
         BtywerHD/B8FwgKeg5ODlT9/fsI/7tr7HAeUK6SKHykdvBDio5XZAm4KomxPgfRc6f9T
         q+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eLdul3jk7I0UMVOSFxEGqDEf7DigzLk/FEfs6EOhO/A=;
        b=q67kv2qBaQsCQ80euTn5TuSqQ194pV8pc0Whe68u9w4nkdzoThM/ban2l0p9V9mslf
         bo1yFBnse5Ym5oaPWr34RfTeOA6H7++O7Nd9SksB7KyTVMibaFE2uSfNDW0tUT6GFcL7
         lGOsOyCdJXWAJtW/X76chTZ2//ViFw0YPKaMkskclT3+y2MCoY2oTfevhWdS8ZK2Du3f
         S1IDNKcpHah9vYf6GSEupZ4IxvJzDqRk4lI8TCjPt/UxNam9e1OeCheR5ylc1znLzhKN
         HOI7Yyzog005IdE35ssxjyg9eGB2sJ1YKlyK+rcVjIbOdcndWS+YbZtTdC0UyZlBaRW2
         hMSA==
X-Gm-Message-State: AOAM533b+2ZZhQWAU+lqyxyJmrE1BncXWE8ae6E38dHcFJ9jf41IVh7g
        AG6VVFkABda0ACJYELASZOeHJoBs8To=
X-Google-Smtp-Source: ABdhPJxYdN74YUY8ojmBtnOwHKCRKXnfPfej23xr7K7lXp7zQqj8o6vOuiK1LyeSnAEBx6CiaRcRwg==
X-Received: by 2002:adf:d1cd:: with SMTP id b13mr25969989wrd.178.1635323246478;
        Wed, 27 Oct 2021 01:27:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm1339590wru.12.2021.10.27.01.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:27:26 -0700 (PDT)
Message-Id: <3361eb8f09177f86849cb1c7737780668a313f5a.1635323239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
References: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
        <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 08:27:14 +0000
Subject: [PATCH v6 10/15] scalar: implement the `run` command
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
index 754e19d781d..d9631287e12 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -483,6 +483,69 @@ static int cmd_register(int argc, const char **argv)
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
@@ -555,6 +618,7 @@ static struct {
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

