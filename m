Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBBC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDC420737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAq+MEjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgDCUsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55813 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCUs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so8503934wmg.5
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o5TkmhML0lYZGbBnxO8ZmmXA0156cOuOWYYPenpIn+Y=;
        b=hAq+MEjQX1zc6MxXuaCoTQWS4LTi8Q1qiXDqwQBZFBXqh0g7m0bcbUZk/Ayqh493zI
         BrpY4a0zJS5ln/WvSR4ataxhPrdMyL2tTlJoO6Su7JM8R4Xx24/3ERH0MiGxKdNsv6j0
         MV5bxk5sYYHGwciDzbj2tkeqoW0xgO+fK1qoi8xeSamEXUNNKc8Kh8yfNaLYxArBtme1
         /MA+BW6ic7abIIVcE4kXHc5IpV4P47xOZai5jhdJNoP2XR8yDyKvk0Zt6kRhUEOGWed+
         /HkLfkUpUC+r4Xw7BY6EnQwVSgUUB5M77c0wFKeAyIkW17jisSDvpZuFMDWo1Y1Qmipk
         Ihog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o5TkmhML0lYZGbBnxO8ZmmXA0156cOuOWYYPenpIn+Y=;
        b=jpY5naeVbshICzULjHnDArXCTbXsHRrjazFFrlzS92Mq9/Oh9q6icsmBt2XjGcbxLY
         fxlx8/Br3VQV99Oj1xbJkmS01DO7sSyOG12tDsaaMRJ2Nvbi+89RASLh4innzBnhZMO5
         Eyy8bYWLUiRmwF10lanhiGogUrh+hmBsbWRfgA3ImwQDmdPiHddluPPZI9FdjZeTVUAo
         Ry9er0Ls1eupM8RhuHnITUl+KHxAnD0hdZErtQYTHMpqYBy5OQiN+OWaD21D44/LZlNl
         it/saxHTyWYPA41PUmyVhkq+D93yi4z+apEXoBaV8ofIFVIBP4gLLfKzkC8AkvHUNKpq
         hM1g==
X-Gm-Message-State: AGi0PuZdJ++ssTZ5gvZm/tVoaXdVvDeiysPki7OpqfauiUo/9bEIiXAR
        9XBJ5KV3jAyICOiN60NTkI2Gxbo9
X-Google-Smtp-Source: APiQypLp8j89KJ4VP2S5guIqBAPuwFbaumZq2L/iTv/SVYjMuyUQr+8OWviSntPojd30zNkVhBdeUQ==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr10218278wmi.31.1585946905884;
        Fri, 03 Apr 2020 13:48:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3sm13148779wrj.91.2020.04.03.13.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:25 -0700 (PDT)
Message-Id: <78b0008d3f15fa16280ea1141d84edc3b4470c9e.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:12 +0000
Subject: [PATCH 13/15] job-runner: skip a job if job.<job-name>.enabled is
 false
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

Allow a user to specify that a job should not be run on a given
repo by setting "job.<job-name>.enabled = false". The job-runner
will check this config before any other options and stop running
the job on that repo. If the config is disabled in the config
read by the job-runner itself (i.e. in global config) then the
job-runner will not attempt to run the job on any of the repos.

Since this config is checked dynamically, the job-runner does will
see config changes without needing to restart the process.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/job.txt |  4 ++++
 builtin/job-runner.c         | 26 ++++++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
index 772001e6744..6c22a40dd36 100644
--- a/Documentation/config/job.txt
+++ b/Documentation/config/job.txt
@@ -2,6 +2,10 @@ job.loopInterval::
 	The number of seconds to sleep between rounds of running
 	background jobs in `git job-runner`.
 
+job.<job-name>.enabled::
+	If set to `false`, this option will disable the `<job-name>`
+	when run by `git job-runner`.
+
 job.<job-name>.interval::
 	The minimum number of seconds between runs of
 	`git run-job <job-name>` when running `git job-runner`.
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
index d1fca2c97b8..45f82a50d49 100644
--- a/builtin/job-runner.c
+++ b/builtin/job-runner.c
@@ -216,13 +216,31 @@ static int load_active_repos(struct string_list *repos)
 	return 0;
 }
 
+static int job_disabled(const char *job, const char *repo)
+{
+	char *enabled;
+
+	if (!try_get_config(job, repo, "enabled", &enabled)) {
+		int enabled_int = git_parse_maybe_bool(enabled);
+		free(enabled);
+		return !enabled_int;
+	}
+
+	return 0;
+}
+
 static int run_job(const char *job, const char *repo)
 {
 	int result;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
 	timestamp_t now = time(NULL);
-	timestamp_t last_run = get_last_run(job, repo);
-	timestamp_t interval = get_interval(job, repo);
+	timestamp_t last_run, interval;
+
+	if (job_disabled(job, repo))
+		return 0;
+
+	last_run = get_last_run(job, repo);
+	interval = get_interval(job, repo);
 
 	if (last_run + interval > now)
 		return 0;
@@ -247,6 +265,10 @@ static int run_job_loop_step(struct string_list *list)
 	     !result && job && job < list->items + list->nr;
 	     job++) {
 		struct string_list_item *repo;
+
+		if (job_disabled(job->string, "."))
+			continue;
+
 		for (repo = repos.items;
 		     !result && repo && repo < repos.items + repos.nr;
 		     repo++)
-- 
gitgitgadget

