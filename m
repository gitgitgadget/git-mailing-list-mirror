Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB26AC2BA2B
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A395D20737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRQVc3sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDCUs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:28 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41148 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbgDCUs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:26 -0400
Received: by mail-ed1-f51.google.com with SMTP id v1so10891668edq.8
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3FyPP/kCWbFAk1FnlwSyBdfh3VeWDnsAloBBrdfXSFE=;
        b=PRQVc3sDHmrl8zhW5469ZZgarK9UcvVJhzZZ5/47CGy4zlVxO2x4wCxGz6TuvtxO4S
         jYdHEs6+6g+JYb9xo2hlfuBuOCPadrrtTcGSHxx6EFCCqZ5orIrubRPmCC1CdIemPB8o
         8XH2UAot9Pc2Nrz478J7hykV/t475pVK4uafJSZBQNVxGVZAloyLujE+0N9cY93sGVU+
         rzBnzwPW4amuSxNzDuhU1xChF1LK9nRiQhvIIbtGVr5VUr2R5iX2iNNf6yPxDEQbEOz4
         YjjgF4JXymM7uvFo6fkjnLwXXuu6r/UZ+BpG08mDQa0CAKg36QDdiZXCKeNByUiOK5Yh
         CyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3FyPP/kCWbFAk1FnlwSyBdfh3VeWDnsAloBBrdfXSFE=;
        b=XGw3q2oOpTXAbjn/AsVEqojHFw44RgJIKBOQrGqfqsUJBQESqFa4FFRf9Gw7tQ2XHY
         UriQn9q47+dmDOkSTxUUkXT+VSQtBOHzOtKUF7mHcPt8kB14tc3FRSG5yLhr0tIQhi1g
         J6sSZGwypth5VlKXnylHr77df7YbgKRr5as8zPeEwq0T6V+9hVIlrzn6UHqA5YAbBYa1
         h61bNZ1gWeFiacsyyK0CEyXydAtygph9umoUP5uYckjTI9tcdJAjWPW/ZF9GQuoldtzW
         hdXTCWLYyeRNEh3YwSjeb5o0YGXGeHagUc7cUjeOuIY2gOWgxRIq9Io+TheD51v7nRdt
         uxpQ==
X-Gm-Message-State: AGi0PuZzSLobfaAF76SDyeIdN47ClKMaQTigI7qk31JiPprQ5fuxCQQB
        DEbxrGqXNTLQFqyop5O7IvWTOvRa
X-Google-Smtp-Source: APiQypKuJ7+QoGB3Vxe1ehlnXeCLKmHHNqWQdVcm0cVh5FDuiGWP1Ibu78QWrEiJ7ulMs4QYbF0nUw==
X-Received: by 2002:a17:906:1613:: with SMTP id m19mr10083532ejd.265.1585946903510;
        Fri, 03 Apr 2020 13:48:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3sm14507ejf.21.2020.04.03.13.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:23 -0700 (PDT)
Message-Id: <18429182ffcf4cb56fcf3d8c76e41652a6c45adc.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:09 +0000
Subject: [PATCH 10/15] job-runner: use config to limit job frequency
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

We want to run different maintenance tasks at different rates. That
means we cannot rely only on the time between job-runner loop pauses
to reduce the frequency of specific jobs. This means we need to
persist a timestamp for the previous run somewhere. A natural place
is the Git config file for that repo.

Create the job.<job-namme>.lastRun config option to store the
timestamp of the previous run of that job. Set this config option
after a successful run of 'git -C <repo> run-job <job-name>'.

To maximize code reuse, we dynamically construct the config key
and parse the config value into a timestamp in a generic way. This
makes the introduction of another config option extremely trivial:

The job.<job-name>.interval option allows a user to specify a
minimum number of seconds between two calls to 'git run-job
<job-name>' on a given repo. This could be stored in the global
or system config to provide an update on the default for all repos,
or could be updated on a per-repo basis. This is checked on every
iteration of the job loop, so a user could update this and see the
effect without restarting the job-runner process.

RFC QUESTION: I'm using a 'git -C <repo> config <option>' process
to test if enough time has elapsed before running the 'run-job'
process. These 'config' processes are pretty light-weight, so
hopefully they are not too noisy. An alternative would be to
always run 'git -C <repo> run-job <job-name>' and rely on that
process to no-op based on the configured values and how recently
they were run. However, that will likely interrupt users who want
to test the jobs in the foreground. Finally, that user disruption
would be mitigated by adding a "--check-latest" option. A user
running a job manually would not include that argument by default
and would succeed. However, any logging that we might do for the
job-runner would make it look like we are running the run-job
commands all the time even if they are no-ops. Advice welcome!

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/job.txt  |  10 ++
 Documentation/git-run-job.txt |   3 +
 builtin/job-runner.c          | 177 +++++++++++++++++++++++++++++++++-
 3 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
index 2dfed3935fa..7c799d66221 100644
--- a/Documentation/config/job.txt
+++ b/Documentation/config/job.txt
@@ -1,3 +1,13 @@
+job.<job-name>.interval::
+	The minimum number of seconds between runs of
+	`git run-job <job-name>` when running `git job-runner`.
+
+job.<job-name>.lastRun::
+	The Unix epoch for the timestamp of the previous run of
+	`git run-job <job-name>` when running `git job-runner`. You
+	can manually update this to a later time to delay a specific
+	job on this repository.
+
 job.pack-files.batchSize::
 	This string value `<size>` will be passed to the
 	`git multi-pack-index repack --batch-size=<size>` command as
diff --git a/Documentation/git-run-job.txt b/Documentation/git-run-job.txt
index cdd6417f7c9..c6d5674d699 100644
--- a/Documentation/git-run-job.txt
+++ b/Documentation/git-run-job.txt
@@ -90,6 +90,9 @@ pack-files, the job does not attempt to repack. Otherwise, the batch
 size is the sum of all pack-file sizes minus the largest pack-file size.
 The batch size is capped at two gigabytes. This intends to pack all
 small pack-files into a single pack-file.
++
+The `--batch-size=<size>` option will override the dynamic or configured
+batch size.
 
 
 GIT
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
index bed401f94bf..aee55c106e8 100644
--- a/builtin/job-runner.c
+++ b/builtin/job-runner.c
@@ -4,11 +4,175 @@
 #include "run-command.h"
 #include "string-list.h"
 
+#define MAX_TIMESTAMP ((timestamp_t)-1)
+
 static char const * const builtin_job_runner_usage[] = {
 	N_("git job-runner [<options>]"),
 	NULL
 };
 
+static char *config_name(const char *prefix,
+			 const char *job,
+			 const char *postfix)
+{
+	int postfix_dot = 0;
+	struct strbuf name = STRBUF_INIT;
+
+	if (prefix) {
+		strbuf_addstr(&name, prefix);
+		strbuf_addch(&name, '.');
+	}
+
+	if (job) {
+		strbuf_addstr(&name, job);
+		postfix_dot = 1;
+	}
+
+	if (postfix) {
+		if (postfix_dot)
+			strbuf_addch(&name, '.');
+		strbuf_addstr(&name, postfix);
+	}
+
+	return strbuf_detach(&name, NULL);
+}
+
+static int try_get_config(const char *job,
+			  const char *repo,
+			  const char *postfix,
+			  char **value)
+{
+	int result = 0;
+	FILE *proc_out;
+	struct strbuf line = STRBUF_INIT;
+	char *cname = config_name("job", job, postfix);
+	struct child_process *config_proc = xmalloc(sizeof(*config_proc));
+
+	child_process_init(config_proc);
+
+	argv_array_push(&config_proc->args, "git");
+	argv_array_push(&config_proc->args, "-C");
+	argv_array_push(&config_proc->args, repo);
+	argv_array_push(&config_proc->args, "config");
+	argv_array_push(&config_proc->args, cname);
+	free(cname);
+
+	config_proc->out = -1;
+
+	if (start_command(config_proc)) {
+		warning(_("failed to start process for repo '%s'"),
+			repo);
+		result = 1;
+		goto cleanup;
+	}
+
+	proc_out = xfdopen(config_proc->out, "r");
+
+	/* if there is no line, leave the value as given */
+	if (!strbuf_getline(&line, proc_out))
+		*value = strbuf_detach(&line, NULL);
+	else
+		*value = NULL;
+
+	strbuf_release(&line);
+
+	fclose(proc_out);
+
+	result = finish_command(config_proc);
+
+cleanup:
+	free(config_proc);
+	return result;
+}
+
+static int try_get_timestamp(const char *job,
+			     const char *repo,
+			     const char *postfix,
+			     timestamp_t *t)
+{
+	char *value;
+	int result = try_get_config(job, repo, postfix, &value);
+
+	if (!result) {
+		*t = atol(value);
+		free(value);
+	}
+
+	return result;
+}
+
+static timestamp_t get_last_run(const char *job,
+				const char *repo)
+{
+	timestamp_t last_run = 0;
+
+	/* In an error state, do not run the job */
+	if (try_get_timestamp(job, repo, "lastrun", &last_run))
+		return MAX_TIMESTAMP;
+
+	return last_run;
+}
+
+static timestamp_t get_interval(const char *job,
+				const char *repo)
+{
+	timestamp_t interval = MAX_TIMESTAMP;
+
+	/* In an error state, do not run the job */
+	if (try_get_timestamp(job, repo, "interval", &interval))
+		return MAX_TIMESTAMP;
+
+	if (interval == MAX_TIMESTAMP) {
+		/* load defaults for each job */
+		if (!strcmp(job, "commit-graph") || !strcmp(job, "fetch"))
+			interval = 60 * 60; /* 1 hour */
+		else
+			interval = 24 * 60 * 60; /* 1 day */
+	}
+
+	return interval;
+}
+
+static int set_last_run(const char *job,
+			const char *repo,
+			timestamp_t last_run)
+{
+	int result = 0;
+	struct strbuf last_run_string = STRBUF_INIT;
+	struct child_process *config_proc = xmalloc(sizeof(*config_proc));
+	char *cname = config_name("job", job, "lastrun");
+
+	strbuf_addf(&last_run_string, "%"PRItime, last_run);
+
+	child_process_init(config_proc);
+
+	argv_array_push(&config_proc->args, "git");
+	argv_array_push(&config_proc->args, "-C");
+	argv_array_push(&config_proc->args, repo);
+	argv_array_push(&config_proc->args, "config");
+	argv_array_push(&config_proc->args, cname);
+	argv_array_push(&config_proc->args, last_run_string.buf);
+	free(cname);
+	strbuf_release(&last_run_string);
+
+	if (start_command(config_proc)) {
+		warning(_("failed to start process for repo '%s'"),
+			repo);
+		result = 1;
+		goto cleanup;
+	}
+
+	if (finish_command(config_proc)) {
+		warning(_("failed to finish process for repo '%s'"),
+			repo);
+		result = 1;
+	}
+
+cleanup:
+	free(config_proc);
+	return result;
+}
+
 static struct string_list arg_repos = STRING_LIST_INIT_DUP;
 
 static int arg_repos_append(const struct option *opt,
@@ -54,9 +218,20 @@ static int load_active_repos(struct string_list *repos)
 
 static int run_job(const char *job, const char *repo)
 {
+	int result;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
+	timestamp_t now = time(NULL);
+	timestamp_t last_run = get_last_run(job, repo);
+	timestamp_t interval = get_interval(job, repo);
+
+	if (last_run + interval > now)
+		return 0;
+
 	argv_array_pushl(&cmd, "-C", repo, "run-job", job, NULL);
-	return run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+	result = run_command_v_opt(cmd.argv, RUN_GIT_CMD);
+
+	set_last_run(job, repo, now);
+	return result;
 }
 
 static int run_job_loop_step(struct string_list *list)
-- 
gitgitgadget

