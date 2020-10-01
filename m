Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF13C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B3A20848
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORq2SozX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgJAUiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAUiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 16:38:51 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74017C0613D0
        for <git@vger.kernel.org>; Thu,  1 Oct 2020 13:38:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n2so7081779oij.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2020 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/KCx68NsrPfxhMTrDTSx5Cx9g5G4nA3Mm8RGgSz0PA=;
        b=ORq2SozX/+mdJWwIumDF73DGNYtF/+TVq/ggyesKRAF0qK6g7w704TQPrn5mpEIo5b
         F+gRQHUyd89QRbehg8k0ZneUbrKmnlKHEOKcM73QVbTgSgb147xis+MDK+PTwbjmNa7D
         qDexCmueNZGZeuBF2c/mCTK4W0N2OITyhEBydepxyFUxzuegMpivkng1qO+w8Knqhjtr
         rr8yqU3IiLnp0fs/1yBmlCN7VxusYLtdn+YOumodQnHPlT8Q42AvoJAN0jhoCosyi7TL
         PVyZ27nYgJc0ywYZ9t5SXKMOq/ghnGXGBSbXa8Ks89/NCAUExOJBKoKfsscDZcO58I6P
         quZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/KCx68NsrPfxhMTrDTSx5Cx9g5G4nA3Mm8RGgSz0PA=;
        b=OzMYvtWYm6yO+mSdLO0IFxKlPiQXvTeL0b5DFJdhPK4QCl77KOobARzAYAxBThdEWx
         BWvhwDHsCFLFmgMI6EXCQmpevUtPa0hz2Wu1mAsh8OzuHhGCSdOLIjznDCPZXhbVSh7G
         rmtg1Ssyksrgl3VxAOf4JKaY7oQwWXm4VCiR4V9EuYrtJV9XhggNJktXKPH3oZfg/om3
         WxBWMGeKZIu+7gtMIP+5zcUKxBxw0JDpDbo6eUTFa5sBvQJszGfEgP+mFQ5z5EMROskz
         uDJGh8de68eb3BQ6nmCnSjRHqx+2hXTFFPjvH1/SuJw3XqIPzFWlFd77a+pziN38afpS
         K+JA==
X-Gm-Message-State: AOAM533Ni4PUBfIAufAiX0QSpNv0hZVnM7txvbM3tz+12OgZkIjKk16m
        8dEmhu68V8pNQ2yhwOol3To=
X-Google-Smtp-Source: ABdhPJyzYj+nI3NmGVcGUe6Tv/F9Pq9dbf9Bt5aevftM97olilWewXUQRCXP1g0J4vk7RVasByaGMg==
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr1167636oif.21.1601584730719;
        Thu, 01 Oct 2020 13:38:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:8070:e593:34fe:7a8a? ([2600:1700:e72:80a0:8070:e593:34fe:7a8a])
        by smtp.gmail.com with UTF8SMTPSA id a4sm1292180oif.3.2020.10.01.13.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 13:38:49 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in
 register/start
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
 <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
 <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
Message-ID: <3e18199a-1dcb-057d-4753-03d5acfcc036@gmail.com>
Date:   Thu, 1 Oct 2020 16:38:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/30/2020 4:11 PM, Derrick Stolee wrote:
> On 9/29/2020 3:48 PM, Martin Ågren wrote:
>> If there aren't any "schedule" configurations, we'll go ahead and
>> sprinkle in quite a few of them. I suppose that another approach would
>> be that later, much later, when we go look for these configuration
>> items, we could go "there is not a single one set, let's act as if
>> *these* were configured".
> 
> I do like this alternative.
> 
>> The advantage there would be that we can tweak those defaults over time.
>> Whereas with the approach of this patch, v2.29.0 will give the user a
>> snapshot of 2020's best practices. If they want to catch up, they will
>> need to drop all their "schedule" config and re-"register", or use a
>> future `git maintenance reregister`. ;-)
> 
> This is a significant advantage! Great idea.

Thank you for giving me the idea to pursue this direction. The
replacement patch isn't too bad, and I think this is a much better
approach to satisfy the situation.

What do you think?

Thanks,
-Stolee

-- >8 --

From 7c7698da17327d17485ba1b23a16a0a8d54efaad Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Tue, 18 Aug 2020 15:15:02 -0400
Subject: [PATCH] maintenance: recommended schedule in register/start
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'git maintenance (register|start)' subcommands add the current
repository to the global Git config so maintenance will operate on that
repository. It does not specify what maintenance should occur or how
often.

If a user sets any 'maintenance.<task>.schedule' config value, then
they have chosen a specific schedule for themselves and Git should
respect that.

To make this process extremely simple for users, assume a default
schedule when no 'maintenance.<task>.schedule' or '...enabled' config
settings are concretely set. This is only an in-process assumption, so
future versions of Git could adjust this expected schedule.

Helped-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-maintenance.txt | 15 ++++++++
 builtin/gc.c                      | 58 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh            | 11 +++---
 3 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 7628a6d157..52fff86844 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -37,6 +37,21 @@ register::
 	`maintenance.<task>.schedule`. The tasks that are enabled are safe
 	for running in the background without disrupting foreground
 	processes.
++
+If your repository has no `maintenance.<task>.schedule` configuration
+values set, then Git will use a recommended default schedule that performs
+background maintenance that will not interrupt foreground commands. The
+default schedule is as follows:
++
+* `gc`: disabled.
+* `commit-graph`: hourly.
+* `prefetch`: hourly.
+* `loose-objects`: daily.
+* `incremental-repack`: daily.
++
+`git maintenance register` will also disable foreground maintenance by
+setting `maintenance.auto = false` in the current repository. This config
+setting will remain after a `git maintenance unregister` command.
 
 run::
 	Run one or more maintenance tasks. If one or more `--task` options
diff --git a/builtin/gc.c b/builtin/gc.c
index a387f46585..965690704b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1251,6 +1251,59 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 	return b->selected_order - a->selected_order;
 }
 
+static int has_schedule_config(void)
+{
+	int i, found = 0;
+	struct strbuf config_name = STRBUF_INIT;
+	size_t prefix;
+
+	strbuf_addstr(&config_name, "maintenance.");
+	prefix = config_name.len;
+
+	for (i = 0; !found && i < TASK__COUNT; i++) {
+		char *value;
+
+		strbuf_setlen(&config_name, prefix);
+		strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
+
+		if (!git_config_get_string(config_name.buf, &value)) {
+			found = 1;
+			FREE_AND_NULL(value);
+		}
+
+		strbuf_setlen(&config_name, prefix);
+		strbuf_addf(&config_name, "%s.enabled", tasks[i].name);
+
+		if (!git_config_get_string(config_name.buf, &value)) {
+			found = 1;
+			FREE_AND_NULL(value);
+		}
+	}
+
+	strbuf_release(&config_name);
+	return found;
+}
+
+static void set_recommended_schedule(void)
+{
+	if (has_schedule_config())
+		return;
+
+	tasks[TASK_GC].enabled = 0;
+
+	tasks[TASK_PREFETCH].enabled = 1;
+	tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
+
+	tasks[TASK_COMMIT_GRAPH].enabled = 1;
+	tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
+
+	tasks[TASK_LOOSE_OBJECTS].enabled = 1;
+	tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
+
+	tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
+	tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
+}
+
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
 	int i, found_selected = 0;
@@ -1280,6 +1333,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 
 	if (found_selected)
 		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
+	else if (opts->schedule != SCHEDULE_NONE)
+		set_recommended_schedule();
 
 	for (i = 0; i < TASK__COUNT; i++) {
 		if (found_selected && tasks[i].selected_order < 0)
@@ -1417,6 +1472,9 @@ static int maintenance_register(void)
 	if (!the_repository || !the_repository->gitdir)
 		return 0;
 
+	/* Disable foreground maintenance */
+	git_config_set("maintenance.auto", "false");
+
 	config_get.git_cmd = 1;
 	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
 		     the_repository->worktree ? the_repository->worktree
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index c8d7e65d3d..fae2ef81bd 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -305,11 +305,14 @@ test_expect_success 'register and unregister' '
 	git config --global --add maintenance.repo /existing1 &&
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
+
 	git maintenance register &&
-	git config --global --get-all maintenance.repo >actual &&
-	cp before after &&
-	pwd >>after &&
-	test_cmp after actual &&
+	test_cmp_config false maintenance.auto &&
+	git config --global --get-all maintenance.repo >between &&
+	cp before expect &&
+	pwd >>expect &&
+	test_cmp expect between &&
+
 	git maintenance unregister &&
 	git config --global --get-all maintenance.repo >actual &&
 	test_cmp before actual
-- 
2.28.0.284.gc2951c3dd58.dirty



