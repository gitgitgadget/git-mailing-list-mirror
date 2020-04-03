Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C623AC2BA12
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922612076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx15jiVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgDCUs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:27 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:32827 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgDCUsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:25 -0400
Received: by mail-ed1-f41.google.com with SMTP id z65so10969999ede.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wPw4Ujqre3RuuVQ/1ja2QwtJ69E/3Zwg1uBQQWQh5QU=;
        b=Gx15jiVUTysyHeFZiOAr062g0JuinI0NNgNDD5Vv5S2X73Fr1htj+Y7v16PLF7Eq5w
         KdiF/3uAsRRbUNINaUXIeKwTk2CqrhRNRm1Dp7h6Xo/q7fjQp2t0TiDWHZSjZJpEJXzp
         CcjbepPp84gYc7aRCZfYkzB2xcWFBgnyQ62632qMmeso+WN/lqiFTmoNQcJ/GBMLE2gx
         RC6QpJq8o0lJeLstvMYUF4MpgAnO5omhggQKBy9zZ2y6yM2wL/avEK2cCWGowaaDUlFc
         TuxiTnmOCLUdMTC9pCUGng6DYfMXG7pp/hRoLQcepkEQhiL5swzXqGv8ripWbjBmnBMp
         LyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wPw4Ujqre3RuuVQ/1ja2QwtJ69E/3Zwg1uBQQWQh5QU=;
        b=B9S+YPeHBEF0E7XfX0ERAyMDrJO3+YpewhpgxAbAPsznDgyuusf9EnUNI0a3tARWsM
         soAd82XJw3OeV4/P8emwHUH1Otuw5ZkxWnLyJE1s5Tm1Ct7uimnKmZKCEU5Us4QHn+v9
         eHFGNbCtYKsC/ymun6gLHOcnvNAXJIX1Ii4nN8v8rP2ToJrxvqftg3/J2kuhz/hLIymY
         RfCmH+nmcrcp4vaemmDJ5lONneSzWc03QEqm+Uud2IuFyYvY4nBbnd2xrgx6NAL11gMv
         R9utEN2BbXGsMGuet+/rvJ+r+Kq1nQPGTCUtl20T/oHXP8gvzap2L1iEOXgV5SduxXd8
         dygw==
X-Gm-Message-State: AGi0PuYVGfhNdNx2qd2cxO518eo1n4KoVCY/w8AUFQoFSQ0nTyLGtspt
        DQ/eqJ7T/7utf+kK9ZWOS1QEpu1N
X-Google-Smtp-Source: APiQypLpwPD06R+rAOkW0saghtNUY+JTdrK8MQdMVwvSbX4gUM6SA3x8ZmeIxYlqBywyRUzy1twNFA==
X-Received: by 2002:aa7:dd90:: with SMTP id g16mr9804913edv.274.1585946901615;
        Fri, 03 Apr 2020 13:48:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k9sm1595992edl.35.2020.04.03.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:20 -0700 (PDT)
Message-Id: <90379bad303e77cc82ef79fc2ba505805a571483.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:07 +0000
Subject: [PATCH 08/15] job-runner: create builtin for job loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Given the existing 'git run-job <job-name>' builtin, users _could_
construct their own scheduling mechanism for running jobs in the
background. However, it is much easier to have a dedicated process
that manages all jobs across multiple repos.

The 'git job-runner' builtin is specifically built to handle this
scenario. It will be customized further in later changes, but for
now it does the following:

* Given a list of '--repo=<path>' arguments, construct a list of
  repositories to manage with jobs.

* Every 30 minutes, iterate over all jobs and all repos to run

	git -C <repo> run-job <job-name>

This builtin needs to be careful about how much of the Git internals
it consumes. The intention is that this is a long-lived process that
could be launched upon login and only closed on logout. For that
reason, we will avoid instantiating any object store or index data.

Run the maintenance jobs by running subcommands. We will update how
we enable or disable these jobs and separate their runs in a later
change.

RFC QUESTIONS:

1. The hardest part of this builtin is "how do we test it?" In
   Scalar, we can unit test the scheduler with mocks. What is the
   equivalent here for "make sure 'git job-runner' runs 'git run-job
   pack-files' on repo X? I expect to add a "--no-loop" option that
   ensures the logic only runs one iteration of the loop.

2. The difference between 'git run-job' and 'git job-runner' is
   subtle and probably confusing. Are there better names?

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 .gitignore                       |   1 +
 Documentation/git-job-runner.txt |  52 +++++++++++++++
 Makefile                         |   1 +
 builtin.h                        |   1 +
 builtin/job-runner.c             | 111 +++++++++++++++++++++++++++++++
 command-list.txt                 |   1 +
 git.c                            |   1 +
 7 files changed, 168 insertions(+)
 create mode 100644 Documentation/git-job-runner.txt
 create mode 100644 builtin/job-runner.c

diff --git a/.gitignore b/.gitignore
index 5dea9d3b96b..24c377b2883 100644
--- a/.gitignore
+++ b/.gitignore
@@ -83,6 +83,7 @@
 /git-init-db
 /git-interpret-trailers
 /git-instaweb
+/git-job-runner
 /git-log
 /git-ls-files
 /git-ls-remote
diff --git a/Documentation/git-job-runner.txt b/Documentation/git-job-runner.txt
new file mode 100644
index 00000000000..010b2d05f9b
--- /dev/null
+++ b/Documentation/git-job-runner.txt
@@ -0,0 +1,52 @@
+git-job-runner(1)
+=================
+
+NAME
+----
+git-job-runner - run jobs on multiple repos according to a schedlue.
+Intended for background operation.
+
+
+SYNOPSIS
+--------
+[verse]
+'git job-runner [--repo=<path>]'
+
+
+DESCRIPTION
+-----------
+
+Run jobs in a loop with some frequency. Intended for running in the
+background.
+
+The `git run-job <job-name>` command runs a specific maintenance task.
+The `job-runner` command is a long-running process that calls the
+`run-job` command on a set of repositories at some frequency. The
+`job.*` config values customize the frequencies of these jobs.
+
+
+OPTIONS
+-------
+
+--repo=<dir>::
+	If at least one `--repo` option is provided, the runner only
+	attempts running jobs on repositories located at the provided
+	`<dir>` values. This option can be specified multiple times.
+
+
+CONFIGURATION
+-------------
+
+The `git job-runner` command is intended to run as a long-running
+process. The following config options are checked periodically during
+the process and will modify its behavior:
+
+The below documentation is the same as what's found in
+linkgit:git-config[1]:
+
+include::config/job.txt[]
+
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f5f9c4d9e94..ee98a91af0f 100644
--- a/Makefile
+++ b/Makefile
@@ -1082,6 +1082,7 @@ BUILTIN_OBJS += builtin/help.o
 BUILTIN_OBJS += builtin/index-pack.o
 BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
+BUILTIN_OBJS += builtin/job-runner.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
 BUILTIN_OBJS += builtin/ls-remote.o
diff --git a/builtin.h b/builtin.h
index 3e0ddaaf67f..5008c7096b3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -176,6 +176,7 @@ int cmd_help(int argc, const char **argv, const char *prefix);
 int cmd_index_pack(int argc, const char **argv, const char *prefix);
 int cmd_init_db(int argc, const char **argv, const char *prefix);
 int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
+int cmd_job_runner(int argc, const char **argv, const char *prefix);
 int cmd_log(int argc, const char **argv, const char *prefix);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 int cmd_ls_files(int argc, const char **argv, const char *prefix);
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
new file mode 100644
index 00000000000..135288bcaae
--- /dev/null
+++ b/builtin/job-runner.c
@@ -0,0 +1,111 @@
+#include "builtin.h"
+#include "config.h"
+#include "parse-options.h"
+#include "run-command.h"
+#include "string-list.h"
+
+static char const * const builtin_job_runner_usage[] = {
+	N_("git job-runner [<options>]"),
+	NULL
+};
+
+static struct string_list arg_repos = STRING_LIST_INIT_DUP;
+
+static int arg_repos_append(const struct option *opt,
+			    const char *arg, int unset)
+{
+	string_list_append(&arg_repos, arg);
+	return 0;
+}
+
+static int load_active_repos(struct string_list *repos)
+{
+	if (arg_repos.nr) {
+		struct string_list_item *item;
+		for (item = arg_repos.items;
+		     item && item < arg_repos.items + arg_repos.nr;
+		     item++)
+			string_list_append(repos, item->string);
+		return 0;
+	}
+
+	return 0;
+}
+
+static int run_job(const char *job, const char *repo)
+{
+	struct argv_array cmd = ARGV_ARRAY_INIT;
+	argv_array_pushl(&cmd, "-C", repo, "run-job", job, NULL);
+	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+}
+
+static int run_job_loop_step(struct string_list *list)
+{
+	int result = 0;
+	struct string_list_item *job;
+	struct string_list repos = STRING_LIST_INIT_DUP;
+
+	if ((result = load_active_repos(&repos)))
+		return result;
+
+	for (job = list->items;
+	     !result && job && job < list->items + list->nr;
+	     job++) {
+		struct string_list_item *repo;
+		for (repo = repos.items;
+		     !result && repo && repo < repos.items + repos.nr;
+		     repo++)
+			result = run_job(job->string,
+					 repo->string);
+	}
+
+	string_list_clear(&repos, 0);
+	return result;
+}
+
+static unsigned int get_loop_interval(void)
+{
+	/* Default: 30 minutes */
+	return 30 * 60;
+}
+
+static int initialize_jobs(struct string_list *list)
+{
+	string_list_append(list, "commit-graph");
+	string_list_append(list, "fetch");
+	string_list_append(list, "loose-objects");
+	string_list_append(list, "pack-files");
+	return 0;
+}
+
+int cmd_job_runner(int argc, const char **argv, const char *prefix)
+{
+	int result;
+	struct string_list job_list = STRING_LIST_INIT_DUP;
+	static struct option builtin_job_runner_options[] = {
+		OPT_CALLBACK_F(0, "repo",
+			       NULL,
+			       N_("<path>"),
+			       N_("run jobs on the repository at <path>"),
+			       PARSE_OPT_NONEG, arg_repos_append),
+		OPT_END(),
+	};
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_job_runner_usage,
+				   builtin_job_runner_options);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_job_runner_options,
+			     builtin_job_runner_usage,
+			     0);
+
+	result = initialize_jobs(&job_list);
+
+	while (!(result = run_job_loop_step(&job_list))) {
+		unsigned int interval = get_loop_interval();
+		sleep(interval);
+	}
+
+	return result;
+}
diff --git a/command-list.txt b/command-list.txt
index 1cd2b415e46..cb835c74693 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -110,6 +110,7 @@ git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators          complete
 git-interpret-trailers                  purehelpers
 gitk                                    mainporcelain
+git-job-runner                          plumbingmanipulators
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
diff --git a/git.c b/git.c
index db5a43c8687..3a2da2c232f 100644
--- a/git.c
+++ b/git.c
@@ -517,6 +517,7 @@ static struct cmd_struct commands[] = {
 	{ "init", cmd_init_db },
 	{ "init-db", cmd_init_db },
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
+	{ "job-runner", cmd_job_runner, RUN_SETUP_GENTLY },
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
-- 
gitgitgadget

