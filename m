Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5768EC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3525C61028
	for <git@archiver.kernel.org>; Mon, 24 May 2021 10:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhEXKNo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 06:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXKNm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 06:13:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA4DC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:12:13 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o127so14606965wmo.4
        for <git@vger.kernel.org>; Mon, 24 May 2021 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yLKzDXCa86paAl+XZu2Ux4HEYv0o5IrYkjWwZQJ4Uts=;
        b=UHiefXapizZbnWOJ5m4tnQ694GEh1GaxS8NaFXZDqiNJguQL9tkzyIPmCSQsZAbixN
         XXQqJhwdiNERBmi3NrwQLpbadnGE3fqxiQvVGnNiAs5r3/1v8RPRrEv/XwqE9gy7OrIW
         X0rS+3iSP4rNCx4ca2JIfpz1v1N+/MLfteZc3u0DN3J1rwi2zs4EN2466o8vjLP/QfKR
         83uys8DaUKYmDHm949ssTdpbPOYgZx640zJ+0LtHdK9oiecq1kMCI7qlY6vGZDr/uBQl
         CaxuG+d7lAeHE1KNrGXSVu78ozV0HJ9+UvNRB/RH1ggNY66UzF74krr1Mxq+gXAdePzQ
         RA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yLKzDXCa86paAl+XZu2Ux4HEYv0o5IrYkjWwZQJ4Uts=;
        b=XoBPmE0X5w2PIlxq2IJdjd+MMzkmcLXmAQLccWE18VDX9W6/9Okk/oG0tPLNcZ4AnE
         lDeKCVzCd35jc17i0kz9RWX12nXwAu4sXmGVl6MhZQro2yCsIWnaqDgm0VqXluqTL3zs
         mflnfPdSFgrsQm9ypRa0YqAjwoxW9caaIdVPIwTP3MVF/hP18DS3QzGfjCkwSGEdJ8la
         GTKLdGctfME/ntaePDbQ1tjopvhKfCTmFVgw6/vBxcvh9eEc/6Zf7kh+nEKQminQZB+D
         Z2ka13SQWcfMPHdM8IN23Lv1+uA0u8DD+9Eso0uBKeSRvGfWhmMBJjcCDuFrw9zyCj3N
         zURg==
X-Gm-Message-State: AOAM533b1UidIkiHSvLlVhyJV6hQp+iQa1VgOhCF5icnPF2aohyNoTvq
        QwZxv2KZyirOI/Pya09Yz5xLXbRFa2U=
X-Google-Smtp-Source: ABdhPJy0h8yBjnFFxZItH71HapUe8D0MMPPrhI5fLKUtcI1Uf6C5/RJFLkermlyabqBfBd+R1RbSlA==
X-Received: by 2002:a1c:2053:: with SMTP id g80mr4861753wmg.82.1621851131897;
        Mon, 24 May 2021 03:12:11 -0700 (PDT)
Received: from [192.168.1.201] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.googlemail.com with ESMTPSA id h14sm7073232wmb.1.2021.05.24.03.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 03:12:11 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20210520221359.75615-1-lenaic@lhuard.fr>
 <20210524071538.46862-1-lenaic@lhuard.fr>
 <20210524071538.46862-4-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <ce0e096d-cd82-800a-9ef5-5bcc4b25046d@gmail.com>
Date:   Mon, 24 May 2021 11:12:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210524071538.46862-4-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

On 24/05/2021 08:15, Lénaïc Huard wrote:
> Depending on the system, different schedulers can be used to schedule
> the hourly, daily and weekly executions of `git maintenance run`:
> * `launchctl` for MacOS,
> * `schtasks` for Windows and
> * `crontab` for everything else.
> 
> `git maintenance run` now has an option to let the end-user explicitly
> choose which scheduler he wants to use:
> `--scheduler=auto|crontab|launchctl|schtasks`.
> 
> When `git maintenance start --scheduler=XXX` is run, it not only
> registers `git maintenance run` tasks in the scheduler XXX, it also
> removes the `git maintenance run` tasks from all the other schedulers to
> ensure we cannot have two schedulers launching concurrent identical
> tasks.
> 
> The default value is `auto` which chooses a suitable scheduler for the
> system.
> 
> `git maintenance stop` doesn't have any `--scheduler` parameter because
> this command will try to remove the `git maintenance run` tasks from all
> the available schedulers.

I like this change, it makes the test infrastructure less intrusive.

> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> ---
>   Documentation/git-maintenance.txt |  11 +
>   builtin/gc.c                      | 333 ++++++++++++++++++++++++------
>   t/t7900-maintenance.sh            |  56 ++++-
>   3 files changed, 333 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 80ddd33ceb..7c4bb38a2f 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -181,6 +181,17 @@ OPTIONS
>   	`maintenance.<task>.enabled` configured as `true` are considered.
>   	See the 'TASKS' section for the list of accepted `<task>` values.
>   
> +--scheduler=auto|crontab|launchctl|schtasks::
> +	When combined with the `start` subcommand, specify the scheduler
> +	to use to run the hourly, daily and weekly executions of
> +	`git maintenance run`.
> +	The possible values for `<scheduler>` depend on the system: `crontab`
> +	is available on POSIX systems, `launchctl` is available on
> +	MacOS and `schtasks` is available on Windows.
> +	By default or when `auto` is specified, a suitable scheduler for
> +	the system is used. On MacOS, `launchctl` is used. On Windows,
> +	`schtasks` is used. On all other systems, `crontab` is used.
> +
>   
>   TROUBLESHOOTING
>   ---------------
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 0caf8d45c4..bf21cec059 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1544,6 +1544,60 @@ static const char *get_frequency(enum schedule_priority schedule)
>   	}
>   }
>   
> +static int get_schedule_cmd(const char **cmd, int *is_available)
> +{
> +	char *item;
> +	static char test_cmd[32];
> +	char *testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
> +
> +	if (!testing)
> +		return 0;
> +
> +	if (is_available)
> +		*is_available = 0;
> +
> +	for(item = testing;;) {
> +		char *sep;
> +		char *end_item = strchr(item, ',');
> +		if (end_item)
> +			*end_item = '\0';
> +
> +		sep = strchr(item, ':');
> +		if (!sep)
> +			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
> +		*sep = '\0';
> +
> +		if (!strcmp(*cmd, item)) {
> +			strlcpy(test_cmd, sep+1, ARRAY_SIZE(test_cmd));

This falls into the trap of assuming strlcpy() is safe and does not 
check the return value. It will silently truncate the command if it is 
too long. As this is for testing I'd be happy just to return 'sep + 1' 
in *cmd and leak it. We could mark 'testing' with UNLEAK() to keep asan 
happy.

> +			*cmd = test_cmd;
> +			if (is_available)
> +				*is_available = 1;
> +			break;
> +		}
> +
> +		if (!end_item)
> +			break;
> +		item = end_item + 1;
> +	}
> +
> +	free(testing);
> +	return 1;
> +}
> +
> +static int is_launchctl_available(void)
> +{
> +	const char *cmd = "launchctl";
> +	int is_available;
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef __APPLE__
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
>   static char *launchctl_service_name(const char *frequency)
>   {
>   	struct strbuf label = STRBUF_INIT;
> @@ -1576,12 +1630,14 @@ enum enable_or_disable {
>   };
>   
>   static int launchctl_boot_plist(enum enable_or_disable enable,
> -				const char *filename, const char *cmd)
> +				const char *filename)

I'm so pleased to see all these 'cmd' arguments disappearing!

>   {
> +	const char *cmd = "launchctl";
>   	int result;
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	char *uid = launchctl_get_uid();
>   
> +	get_schedule_cmd(&cmd, NULL);
>   	strvec_split(&child.args, cmd);

It's a shame we still have to have this strvec_split() call just to 
handle testing but your changes are an improvement.

>   	strvec_pushl(&child.args, enable == ENABLE ? "bootstrap" : "bootout",
>   		     uid, filename, NULL);
> @@ -1598,26 +1654,26 @@ static int launchctl_boot_plist(enum enable_or_disable enable,
>   	return result;
>   }
>   
> -static int launchctl_remove_plist(enum schedule_priority schedule, const char *cmd)
> +static int launchctl_remove_plist(enum schedule_priority schedule)
>   {
>   	const char *frequency = get_frequency(schedule);
>   	char *name = launchctl_service_name(frequency);
>   	char *filename = launchctl_service_filename(name);
> -	int result = launchctl_boot_plist(DISABLE, filename, cmd);
> +	int result = launchctl_boot_plist(DISABLE, filename);
>   	unlink(filename);
>   	free(filename);
>   	free(name);
>   	return result;
>   }
>   
> -static int launchctl_remove_plists(const char *cmd)
> +static int launchctl_remove_plists(void)
>   {
> -	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
> -		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
> -		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
> +	return launchctl_remove_plist(SCHEDULE_HOURLY) ||
> +		launchctl_remove_plist(SCHEDULE_DAILY) ||
> +		launchctl_remove_plist(SCHEDULE_WEEKLY);
>   }
>   
> -static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
> +static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule)
>   {
>   	FILE *plist;
>   	int i;
> @@ -1686,8 +1742,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
>   	fclose(plist);
>   
>   	/* bootout might fail if not already running, so ignore */
> -	launchctl_boot_plist(DISABLE, filename, cmd);
> -	if (launchctl_boot_plist(ENABLE, filename, cmd))
> +	launchctl_boot_plist(DISABLE, filename);
> +	if (launchctl_boot_plist(ENABLE, filename))
>   		die(_("failed to bootstrap service %s"), filename);
>   
>   	free(filename);
> @@ -1695,28 +1751,42 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
>   	return 0;
>   }
>   
> -static int launchctl_add_plists(const char *cmd)
> +static int launchctl_add_plists(void)
>   {
>   	const char *exec_path = git_exec_path();
>   
> -	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY, cmd) ||
> -		launchctl_schedule_plist(exec_path, SCHEDULE_DAILY, cmd) ||
> -		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
> +	return launchctl_schedule_plist(exec_path, SCHEDULE_HOURLY) ||
> +		launchctl_schedule_plist(exec_path, SCHEDULE_DAILY) ||
> +		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY);
>   }
>   
>   static int launchctl_update_schedule(enum enable_or_disable run_maintenance,
> -				     int fd, const char *cmd)
> +				     int fd)
>   {
>   	switch (run_maintenance) {
>   	case ENABLE:
> -		return launchctl_add_plists(cmd);
> +		return launchctl_add_plists();
>   	case DISABLE:
> -		return launchctl_remove_plists(cmd);
> +		return launchctl_remove_plists();
>   	default:
>   		BUG("invalid enable_or_disable value");
>   	}
>   }
>   
> +static int is_schtasks_available(void)
> +{
> +	const char *cmd = "schtasks";
> +	int is_available;
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef GIT_WINDOWS_NATIVE
> +	return 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
>   static char *schtasks_task_name(const char *frequency)
>   {
>   	struct strbuf label = STRBUF_INIT;
> @@ -1724,13 +1794,15 @@ static char *schtasks_task_name(const char *frequency)
>   	return strbuf_detach(&label, NULL);
>   }
>   
> -static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd)
> +static int schtasks_remove_task(enum schedule_priority schedule)
>   {
> +	const char *cmd = "schtasks";
>   	int result;
>   	struct strvec args = STRVEC_INIT;
>   	const char *frequency = get_frequency(schedule);
>   	char *name = schtasks_task_name(frequency);
>   
> +	get_schedule_cmd(&cmd, NULL);
>   	strvec_split(&args, cmd);
>   	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
>   
> @@ -1741,15 +1813,16 @@ static int schtasks_remove_task(enum schedule_priority schedule, const char *cmd
>   	return result;
>   }
>   
> -static int schtasks_remove_tasks(const char *cmd)
> +static int schtasks_remove_tasks(void)
>   {
> -	return schtasks_remove_task(SCHEDULE_HOURLY, cmd) ||
> -		schtasks_remove_task(SCHEDULE_DAILY, cmd) ||
> -		schtasks_remove_task(SCHEDULE_WEEKLY, cmd);
> +	return schtasks_remove_task(SCHEDULE_HOURLY) ||
> +		schtasks_remove_task(SCHEDULE_DAILY) ||
> +		schtasks_remove_task(SCHEDULE_WEEKLY);
>   }
>   
> -static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule, const char *cmd)
> +static int schtasks_schedule_task(const char *exec_path, enum schedule_priority schedule)
>   {
> +	const char *cmd = "schtasks";
>   	int result;
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	const char *xml;
> @@ -1758,6 +1831,8 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
>   	char *name = schtasks_task_name(frequency);
>   	struct strbuf tfilename = STRBUF_INIT;
>   
> +	get_schedule_cmd(&cmd, NULL);
> +
>   	strbuf_addf(&tfilename, "%s/schedule_%s_XXXXXX",
>   		    get_git_common_dir(), frequency);
>   	tfile = xmks_tempfile(tfilename.buf);
> @@ -1862,34 +1937,65 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
>   	return result;
>   }
>   
> -static int schtasks_schedule_tasks(const char *cmd)
> +static int schtasks_schedule_tasks(void)
>   {
>   	const char *exec_path = git_exec_path();
>   
> -	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY, cmd) ||
> -		schtasks_schedule_task(exec_path, SCHEDULE_DAILY, cmd) ||
> -		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
> +	return schtasks_schedule_task(exec_path, SCHEDULE_HOURLY) ||
> +		schtasks_schedule_task(exec_path, SCHEDULE_DAILY) ||
> +		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY);
>   }
>   
>   static int schtasks_update_schedule(enum enable_or_disable run_maintenance,
> -				    int fd, const char *cmd)
> +				    int fd)
>   {
>   	switch (run_maintenance) {
>   	case ENABLE:
> -		return schtasks_schedule_tasks(cmd);
> +		return schtasks_schedule_tasks();
>   	case DISABLE:
> -		return schtasks_remove_tasks(cmd);
> +		return schtasks_remove_tasks();
>   	default:
>   		BUG("invalid enable_or_disable value");
>   	}
>   }
>   
> +static int is_crontab_available(void)
> +{
> +	const char *cmd = "crontab";
> +	int is_available;
> +	static int cached_result = -1;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	if (cached_result != -1)
> +		return cached_result;
> +
> +	if (get_schedule_cmd(&cmd, &is_available) && !is_available)
> +		return 0;
> +
> +	strvec_split(&child.args, cmd);
> +	strvec_push(&child.args, "-l");
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child)) {
> +		cached_result = 0;
> +		return cached_result;
> +	}
> +	/* Ignore exit code, as an empty crontab will return error. */
> +	finish_command(&child);
> +	cached_result = 1;
> +	return cached_result;
> +}
> +
>   #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
>   #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
>   
>   static int crontab_update_schedule(enum enable_or_disable run_maintenance,
> -				   int fd, const char *cmd)
> +				   int fd)
>   {
> +	const char *cmd = "crontab";
>   	int result = 0;
>   	int in_old_region = 0;
>   	struct child_process crontab_list = CHILD_PROCESS_INIT;
> @@ -1897,6 +2003,7 @@ static int crontab_update_schedule(enum enable_or_disable run_maintenance,
>   	FILE *cron_list, *cron_in;
>   	struct strbuf line = STRBUF_INIT;
>   
> +	get_schedule_cmd(&cmd, NULL);
>   	strvec_split(&crontab_list.args, cmd);
>   	strvec_push(&crontab_list.args, "-l");
>   	crontab_list.in = -1;
> @@ -1972,61 +2079,161 @@ static int crontab_update_schedule(enum enable_or_disable run_maintenance,
>   	return result;
>   }
>   
> +enum scheduler {
> +	SCHEDULER_INVALID = -1,
> +	SCHEDULER_AUTO,
> +	SCHEDULER_CRON,
> +	SCHEDULER_LAUNCHCTL,
> +	SCHEDULER_SCHTASKS,
> +};
> +
> +static const struct {
> +	const char *name;
> +	int (*is_available)(void);
> +	int (*update_schedule)(enum enable_or_disable run_maintenance, int fd);
> +} scheduler_fn[] = {
> +	[SCHEDULER_CRON] = {
> +		.name = "crontab",
> +		.is_available = is_crontab_available,
> +		.update_schedule = crontab_update_schedule,
> +	},
> +	[SCHEDULER_LAUNCHCTL] = {
> +		.name = "launchctl",
> +		.is_available = is_launchctl_available,
> +		.update_schedule = launchctl_update_schedule,
> +	},
> +	[SCHEDULER_SCHTASKS] = {
> +		.name = "schtasks",
> +		.is_available = is_schtasks_available,
> +		.update_schedule = schtasks_update_schedule,
> +	},
> +};
> +
> +static enum scheduler parse_scheduler(const char *value)
> +{
> +	if (!value)
> +		return SCHEDULER_INVALID;
> +	else if (!strcasecmp(value, "auto"))
> +		return SCHEDULER_AUTO;
> +	else if (!strcasecmp(value, "cron") || !strcasecmp(value, "crontab"))
> +		return SCHEDULER_CRON;
> +	else if (!strcasecmp(value, "launchctl"))
> +		return SCHEDULER_LAUNCHCTL;
> +	else if (!strcasecmp(value, "schtasks"))
> +		return SCHEDULER_SCHTASKS;
> +	else
> +		return SCHEDULER_INVALID;
> +}
> +
> +static int maintenance_opt_scheduler(const struct option *opt, const char *arg,
> +				     int unset)
> +{
> +	enum scheduler *scheduler = opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	*scheduler = parse_scheduler(arg);
> +	if (*scheduler == SCHEDULER_INVALID)
> +		return error(_("unrecognized --scheduler argument '%s'"), arg);
> +	return 0;
> +}
> +
> +struct maintenance_start_opts {
> +	enum scheduler scheduler;
> +};
> +
> +static void resolve_auto_scheduler(enum scheduler *scheduler)
> +{
> +	if (*scheduler != SCHEDULER_AUTO)
> +		return;
> +
>   #if defined(__APPLE__)
> -static const char platform_scheduler[] = "launchctl";
> +	*scheduler = SCHEDULER_LAUNCHCTL;
> +	return;
> +
>   #elif defined(GIT_WINDOWS_NATIVE)
> -static const char platform_scheduler[] = "schtasks";
> +	*scheduler = SCHEDULER_SCHTASKS;
> +	return;
> +
>   #else
> -static const char platform_scheduler[] = "crontab";
> +	*scheduler = SCHEDULER_CRON;
> +	return;
>   #endif
> +}
>   
> -static int update_background_schedule(int enable)
> +static void validate_scheduler(enum scheduler scheduler)
>   {
> -	int result;
> -	const char *scheduler = platform_scheduler;
> -	const char *cmd = scheduler;
> -	char *testing;
> +	if (scheduler == SCHEDULER_INVALID)
> +		BUG("invalid scheduler");
> +	if (scheduler == SCHEDULER_AUTO)
> +		BUG("resolve_auto_scheduler should have been called before");
> +
> +	if (!scheduler_fn[scheduler].is_available())
> +		die(_("%s scheduler is not available"),
> +		    scheduler_fn[scheduler].name);
> +}
> +
> +static int update_background_schedule(const struct maintenance_start_opts *opts,
> +				      enum enable_or_disable enable)
> +{
> +	unsigned int i;
> +	int res, result = 0;
>   	struct lock_file lk;
>   	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
>   
> -	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
> -	if (testing) {
> -		char *sep = strchr(testing, ':');
> -		if (!sep)
> -			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
> -		*sep = '\0';
> -		scheduler = testing;
> -		cmd = sep + 1;
> -	}
> -
>   	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
>   		return error(_("another process is scheduling background maintenance"));
>   
> -	if (!strcmp(scheduler, "launchctl"))
> -		result = launchctl_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else if (!strcmp(scheduler, "schtasks"))
> -		result = schtasks_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else if (!strcmp(scheduler, "crontab"))
> -		result = crontab_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else
> -		die("unknown background scheduler: %s", scheduler);
> +	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
> +		enum enable_or_disable enable_scheduler =
> +			(enable == ENABLE && (opts->scheduler == i)) ?

Strictly speaking none of the parenthesis are required, I'd certainly 
drop the inner ones.

> +			ENABLE : DISABLE;
> +		if (!scheduler_fn[i].is_available())
> +			continue;
> +		res = scheduler_fn[i].update_schedule(
> +			enable_scheduler, get_lock_file_fd(&lk));

It does not matter for this patch as we're not really disabling anything 
with the existing range of schedulers but in the next patch we can end 
up enabling the new scheduler before disabling the old one leading to a 
race where they can both start 'git maintenance' on the same repo. As I 
said in my previous review it would be clearer to disable all the 
schedulers first before enabling the new one.

> +		if (enable_scheduler)
> +			result = res;
> +	}
>   
>   	rollback_lock_file(&lk);
> -	free(testing);
>   	return result;
>   }
>   
> -static int maintenance_start(void)
> +static const char *const builtin_maintenance_start_usage[] = {
> +	N_("git maintenance start [--scheduler=<scheduler>]"), NULL
> +};

I'm not sure what the { } and NULL are doing here, it should just be 
assigning a string. You could put it inside maintenance_start() and just 
call the variable "usage"

> +static int maintenance_start(int argc, const char **argv, const char *prefix)
>   {
> +	struct maintenance_start_opts opts;
> +	struct option builtin_maintenance_start_options[] = {

As this variable is local to the function you could call it something 
shorter like options.

> +		OPT_CALLBACK_F(
> +			0, "scheduler", &opts.scheduler, N_("scheduler"),
> +			N_("scheduler to use to trigger git maintenance run"),
> +			PARSE_OPT_NONEG, maintenance_opt_scheduler),
> +		OPT_END()
> +	};
> +	memset(&opts, 0, sizeof(opts));
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_maintenance_start_options,
> +			     builtin_maintenance_start_usage, 0);
> +	if (argc)
> +		usage_with_options(builtin_maintenance_start_usage,
> +				   builtin_maintenance_start_options);
> +
> +	resolve_auto_scheduler(&opts.scheduler);
> +	validate_scheduler(opts.scheduler);
> +
>   	if (maintenance_register())
>   		warning(_("failed to add repo to global config"));
> -
> -	return update_background_schedule(1);
> +	return update_background_schedule(&opts, 1);

This conversion got missed in the last patch (that is if we end up 
wanting to use an enum).

>   }
>   
>   static int maintenance_stop(void)
>   {
> -	return update_background_schedule(0);
> +	return update_background_schedule(NULL, 0);
>   }
>   
>   static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
> @@ -2040,7 +2247,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
>   	if (!strcmp(argv[1], "run"))
>   		return maintenance_run(argc - 1, argv + 1, prefix);
>   	if (!strcmp(argv[1], "start"))
> -		return maintenance_start();
> +		return maintenance_start(argc - 1, argv + 1, prefix);
>   	if (!strcmp(argv[1], "stop"))
>   		return maintenance_stop();
>   	if (!strcmp(argv[1], "register"))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2412d8c5c0..9eac260307 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -488,8 +488,21 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
>   		maintenance.repo "$(pwd)/$META"
>   '
>   
> +test_expect_success 'start --scheduler=<scheduler>' '
> +	test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
> +	test_i18ngrep "unrecognized --scheduler argument" err &&
 >
> +	test_expect_code 129 git maintenance start --no-scheduler 2>err &&
> +	test_i18ngrep "unknown option" err &&
> +
> +	test_expect_code 128 \
> +		env GIT_TEST_MAINT_SCHEDULER="launchctl:true,schtasks:true" \
> +		git maintenance start --scheduler=crontab 2>err &&
> +	test_i18ngrep "fatal: crontab scheduler is not available" err
> +'
> +
>   test_expect_success 'start from empty cron table' '
> -	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
> +	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
>   
>   	# start registers the repo
>   	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> @@ -512,7 +525,7 @@ test_expect_success 'stop from existing schedule' '
>   
>   test_expect_success 'start preserves existing schedule' '
>   	echo "Important information!" >cron.txt &&
> -	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start &&
> +	GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt" git maintenance start --scheduler=crontab &&
>   	grep "Important information!" cron.txt
>   '
>   
> @@ -541,7 +554,7 @@ test_expect_success 'start and stop macOS maintenance' '
>   	EOF
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start &&
> +	GIT_TEST_MAINT_SCHEDULER=launchctl:./print-args git maintenance start --scheduler=launchctl &&
>   
>   	# start registers the repo
>   	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> @@ -592,7 +605,7 @@ test_expect_success 'start and stop Windows maintenance' '
>   	EOF
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start &&
> +	GIT_TEST_MAINT_SCHEDULER="schtasks:./print-args" git maintenance start --scheduler=schtasks &&
>   
>   	# start registers the repo
>   	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> @@ -615,6 +628,41 @@ test_expect_success 'start and stop Windows maintenance' '
>   	test_cmp expect args
>   '
>   
> +test_expect_success 'start and stop when several schedulers are available' '
> +	write_script print-args <<-\EOF &&
> +	printf "%s\n" "$*" | sed "s:gui/[0-9][0-9]*:gui/[UID]:; s:\(schtasks /create .* /xml\).*:\1:;" >>args
> +	EOF
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
> +	rm -f expect &&
> +	for frequency in hourly daily weekly
> +	do
> +		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> +		echo "launchctl bootout gui/[UID] $PLIST" >>expect &&
> +		echo "launchctl bootstrap gui/[UID] $PLIST" >>expect || return 1
> +	done &&
> +	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
> +		hourly daily weekly >>expect &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
> +	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> +		hourly daily weekly >expect &&
> +	printf "schtasks /create /tn Git Maintenance (%s) /f /xml\n" \
> +		hourly daily weekly >>expect &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
> +	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> +		hourly daily weekly >expect &&
> +	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
> +		hourly daily weekly >>expect &&
> +	test_cmp expect args
> +'
> +

Thanks for adding tests for the new option and converting the old ones 
to use it. I think that with a couple of small changes this patch will 
be ready. I've run out of time for now but I'll try and look at the 
fourth patch in the next couple of days.
Best Wishes

Phillip

>   test_expect_success 'register preserves existing strategy' '
>   	git config maintenance.strategy none &&
>   	git maintenance register &&
> 

