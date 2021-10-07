Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B66C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7E961058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 10:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhJGLBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbhJGLBX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 07:01:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4911C06176D
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 03:59:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s15so17816278wrv.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r16GA9XdAq44eQzQb75Q58Xi22aaWnk4iW8ItzuXDOo=;
        b=ne+1WmptBbC79sLzrcFp+MaoEcR1miDJliJTRPiSRp+BEZV3j+4axO82SdeSISx0lN
         2JeSp0pmpYMMcJ8D35YqKw1bjQ9A5rf9+359aYTrpuUlSntLonOX2/TkSteS1Zs6fmOE
         qZMxmQkjcLyslqck2zalKFmGjaOJYWzn4a4EUST8cTuHNbDKvH3mBdoUewFABsRmHndf
         ke2l4SKvdaYIeieqYarG6sTVsG1qaZ7vStlJ36LY4+3xzyanPOM3TWICGFy74b6lXWPR
         UzusLhVulA4RePRFHQXTvkfbyY0hlRXH2o+m4tLCYQFRQWAm0jqBRoX9IbcVKWlIo3Gj
         roRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r16GA9XdAq44eQzQb75Q58Xi22aaWnk4iW8ItzuXDOo=;
        b=cWvf+sgo5+vOqyg5j/DcF6W82pUI35994S+MjPYz2oGb/BPqn3LiPYsIaPvp3DbWby
         3lFlw2OygKVVdrORImzVEqVG2F60BSr6kEeqILTLpIJYAEq1vjaPAdwKp2GGTf2vLu/Y
         SIJOpd+2aDY6nF44aqnNylCZXLJkG3Yatsg3Bl340ZZUe8fwpv0DvEz3Gr8jKAriDJZa
         /s5uZGz6iC7yCnCLEogNd2We4LEc67L/9/9NQ3XVNcLJghv+pBxqgChsZCLm5Zt1ug80
         fu9JSR0bHeRVAI1sIZ1oqsJlQTH+J8F6PgmJPP6j2QiGs3gTYUBYzkxMRv4SaiYbIvIc
         CAUA==
X-Gm-Message-State: AOAM533JmbBna2pxYaR2v+qXc+DWOiAp3ErNMKnwmEai97D8jzzlPByR
        Qwcjzz8K6A094vzrzZVacY1Vx76FeuY=
X-Google-Smtp-Source: ABdhPJwQ2XHU3qjz1yfcWPcsNxbXvieR/Cl45+kVDi9J02kG1uBZ+YK5cn6HkcjHN/kEno3IkYvQbw==
X-Received: by 2002:adf:8b15:: with SMTP id n21mr4585626wra.373.1633604357481;
        Thu, 07 Oct 2021 03:59:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p14sm8041998wmc.18.2021.10.07.03.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:59:17 -0700 (PDT)
Message-Id: <5a0b3843f986246d33f5ea3c63e5d67619348816.1633604349.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
References: <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <pull.1005.v5.git.1633604349.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 10:59:04 +0000
Subject: [PATCH v5 10/15] scalar: implement the `run` command
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
index 46999cf7c84..f139a14445d 100644
--- a/contrib/scalar/scalar.txt
+++ b/contrib/scalar/scalar.txt
@@ -12,6 +12,7 @@ scalar clone [--single-branch] [--branch <main-branch>] [--full-clone] <url> [<e
 scalar list
 scalar register [<enlistment>]
 scalar unregister [<enlistment>]
+scalar run ( all | config | commit-graph | fetch | loose-objects | pack-files ) [<enlistment>]
 
 DESCRIPTION
 -----------
@@ -97,6 +98,24 @@ unregister [<enlistment>]::
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

