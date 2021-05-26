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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B1DC2B9F7
	for <git@archiver.kernel.org>; Wed, 26 May 2021 10:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787AE61445
	for <git@archiver.kernel.org>; Wed, 26 May 2021 10:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhEZK1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 06:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhEZK1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 06:27:37 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC5C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 03:26:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so157455wmf.5
        for <git@vger.kernel.org>; Wed, 26 May 2021 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aN9B9yqPQ7jaH2o27uEvLCexKESmobeMvSZck5J4lN0=;
        b=aQxhkYyRE1IT9PhnLa+ns4DsckGXYB4Wu/zktdblzltLuj1IqNW/6tuCQ3CZMwsVKS
         wZEa4MaQOJesx2FHN9wgpMKXq+3fmfb69/Ijh+Jq0O9Kv68Wxzx+b0LAmX51VXRwIbEJ
         0pY4RUCokimIonxcLLnbs+HNiCNkMkDTTCVkQo2UeYCEmEA6YZRG8E2ELLSBO1RYrqzx
         NRzeB6vmEMicXyxbuEKm8ldYgAoh801d3ufhxDnMotry/O/1nFvBTpQZFy+7sDfOt/s2
         hwTy+mIWt6xbzSJvKzflzXR+T4vNB6zcFgxa2b4+4fficpnYijI5LGyYCegfSsTTBc4r
         3M5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aN9B9yqPQ7jaH2o27uEvLCexKESmobeMvSZck5J4lN0=;
        b=QRx3sSL+lLkH3vcQKldx9qUXTYOWp1UK7fIxCWCNTecv6oujeDtz1jbIAh9wVmF4nU
         Ekhi36DUXaNB4dHTzju3+YEqNI72BK1QatPjJzDlKyVDJ6F17UUp4dmXGJx5/ByLhSkz
         kZcAU2rXF42ljeFCh5YCz5R3+L2IK9b4vQRs1j1w2GvXa2/ryaiCWdqtgZYOsRwm/IqS
         9uy5FhrIE4n9gBjEvP246VCZt3tVcW0zXf4hsWjhV7h+h6pPsy6teibUWzySsLrefKQe
         QG/jFK/KH/urxG2neTpv8dHqPjVuXL4DNx+LjSoVTcC6ZgBWqXFp5r/JGfplcjbYAhh8
         Ssaw==
X-Gm-Message-State: AOAM530XoJJgiaZk8YXyOcWln7eo9vmKTI5WqHO5H6NxV/t+//BBR+t5
        qdUdxUxp/i3d2DzjIPyBf5w=
X-Google-Smtp-Source: ABdhPJyzTLAD527uU0rrR1VQTgPUyS1+Tn1mFwigWpTi4+hcWx0tG1Kq8OYU7uOSFfLLUzEa1H4Egg==
X-Received: by 2002:a1c:146:: with SMTP id 67mr1466622wmb.61.1622024764058;
        Wed, 26 May 2021 03:26:04 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id o8sm19924884wrx.4.2021.05.26.03.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 03:26:03 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] maintenance: add support for systemd timers on
 Linux
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
 <20210524071538.46862-5-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <78148258-8b9c-7b88-54ee-ae899ce6af69@gmail.com>
Date:   Wed, 26 May 2021 11:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210524071538.46862-5-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lénaïc

On 24/05/2021 08:15, Lénaïc Huard wrote:
> The existing mechanism for scheduling background maintenance is done
> through cron. On Linux systems managed by systemd, systemd provides an
> alternative to schedule recurring tasks: systemd timers.
> 
> The main motivations to implement systemd timers in addition to cron
> are:
> * cron is optional and Linux systems running systemd might not have it
>    installed.
> * The execution of `crontab -l` can tell us if cron is installed but not
>    if the daemon is actually running.
> * With systemd, each service is run in its own cgroup and its logs are
>    tagged by the service inside journald. With cron, all scheduled tasks
>    are running in the cron daemon cgroup and all the logs of the
>    user-scheduled tasks are pretended to belong to the system cron
>    service.
>    Concretely, a user that doesn’t have access to the system logs won’t
>    have access to the log of their own tasks scheduled by cron whereas
>    they will have access to the log of their own tasks scheduled by
>    systemd timer.
>    Although `cron` attempts to send email, that email may go unseen by
>    the user because these days, local mailboxes are not heavily used
>    anymore.
> 
> In order to schedule git maintenance, we need two unit template files:
> * ~/.config/systemd/user/git-maintenance@.service
>    to define the command to be started by systemd and
> * ~/.config/systemd/user/git-maintenance@.timer
>    to define the schedule at which the command should be run.
> 
> Those units are templates that are parameterized by the frequency.
> 
> Based on those templates, 3 timers are started:
> * git-maintenance@hourly.timer
> * git-maintenance@daily.timer
> * git-maintenance@weekly.timer
> 
> The command launched by those three timers are the same as with the
> other scheduling methods:
> 
> /path/to/git for-each-repo --exec-path=/path/to
> --config=maintenance.repo maintenance run --schedule=%i
> 
> with the full path for git to ensure that the version of git launched
> for the scheduled maintenance is the same as the one used to run
> `maintenance start`.
> 
> The timer unit contains `Persistent=true` so that, if the computer is
> powered down when a maintenance task should run, the task will be run
> when the computer is back powered on.

The commit message is comprehensive and does a good job of explaining 
the patch I do not think there is any need to reword it - I find using 
'they' rather than 'it' to refer to a user is more readable.

> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> ---
>   Documentation/git-maintenance.txt |  57 +++++++++-
>   builtin/gc.c                      | 180 ++++++++++++++++++++++++++++++
>   t/t7900-maintenance.sh            |  66 ++++++++++-
>   3 files changed, 293 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 7c4bb38a2f..50179e010f 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -181,16 +181,19 @@ OPTIONS
>   	`maintenance.<task>.enabled` configured as `true` are considered.
>   	See the 'TASKS' section for the list of accepted `<task>` values.
>   
> ---scheduler=auto|crontab|launchctl|schtasks::
> +--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
>   	When combined with the `start` subcommand, specify the scheduler
>   	to use to run the hourly, daily and weekly executions of
>   	`git maintenance run`.
>   	The possible values for `<scheduler>` depend on the system: `crontab`
> -	is available on POSIX systems, `launchctl` is available on
> -	MacOS and `schtasks` is available on Windows.
> +	is available on POSIX systems, `systemd-timer` is available on Linux
> +	systems, `launchctl` is available on MacOS and `schtasks` is available
> +	on Windows.
>   	By default or when `auto` is specified, a suitable scheduler for
>   	the system is used. On MacOS, `launchctl` is used. On Windows,
> -	`schtasks` is used. On all other systems, `crontab` is used.
> +	`schtasks` is used. On Linux, `systemd-timer` is used if user systemd
> +	timers are available, otherwise, `crontab` is used. On all other systems,
> +	`crontab` is used.
>   
>   
>   TROUBLESHOOTING
> @@ -290,6 +293,52 @@ schedule to ensure you are executing the correct binaries in your
>   schedule.
>   
>   
> +BACKGROUND MAINTENANCE ON LINUX SYSTEMD SYSTEMS
> +-----------------------------------------------
> +
> +While Linux supports `cron`, depending on the distribution, `cron` may
> +be an optional package not necessarily installed. On modern Linux
> +distributions, systemd timers are superseding it.
> +
> +If user systemd timers are available, they will be used as a replacement
> +of `cron`.
> +
> +In this case, `git maintenance start` will create user systemd timer units
> +and start the timers. The current list of user-scheduled tasks can be found
> +by running `systemctl --user list-timers`. The timers written by `git
> +maintenance start` are similar to this:
> +
> +-----------------------------------------------------------------------
> +$ systemctl --user list-timers
> +NEXT                         LEFT          LAST                         PASSED     UNIT                         ACTIVATES
> +Thu 2021-04-29 19:00:00 CEST 42min left    Thu 2021-04-29 18:00:11 CEST 17min ago  git-maintenance@hourly.timer git-maintenance@hourly.service
> +Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021-04-29 00:00:11 CEST 18h ago    git-maintenance@daily.timer  git-maintenance@daily.service
> +Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST 3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
> +-----------------------------------------------------------------------
> +
> +One timer is registered for each `--schedule=<frequency>` option.
> +
> +The definition of the systemd units can be inspected in the following files:
> +
> +-----------------------------------------------------------------------
> +~/.config/systemd/user/git-maintenance@.timer
> +~/.config/systemd/user/git-maintenance@.service
> +~/.config/systemd/user/timers.target.wants/git-maintenance@hourly.timer
> +~/.config/systemd/user/timers.target.wants/git-maintenance@daily.timer
> +~/.config/systemd/user/timers.target.wants/git-maintenance@weekly.timer
> +-----------------------------------------------------------------------
> +
> +`git maintenance start` will overwrite these files and start the timer
> +again with `systemctl --user`, so any customization should be done by
> +creating a drop-in file, i.e. a `.conf` suffixed file in the
> +`~/.config/systemd/user/git-maintenance@.service.d` directory.
> +
> +`git maintenance stop` will stop the user systemd timers and delete
> +the above mentioned files.
> +
> +For more details, see `systemd.timer(5)`.
> +
> +
>   BACKGROUND MAINTENANCE ON MACOS SYSTEMS
>   ---------------------------------------
>   
> diff --git a/builtin/gc.c b/builtin/gc.c
> index bf21cec059..3eca1e5e6a 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2079,10 +2079,173 @@ static int crontab_update_schedule(enum enable_or_disable run_maintenance,
>   	return result;
>   }
>   
> +static int is_systemd_timer_available(void)
> +{
> +	const char *cmd = "systemctl";
> +	int is_available;
> +	static int cached_result = -1;
> +#ifdef __linux__
> +	struct child_process child = CHILD_PROCESS_INIT;
> +#endif
> +
> +	if (cached_result != -1)
> +		return cached_result;
> +
> +	if (get_schedule_cmd(&cmd, &is_available))
> +		return is_available;
> +
> +#ifdef __linux__
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", "list-timers", NULL);
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child)) {
> +		cached_result = 0;
> +		return cached_result;
> +	}
> +	if (finish_command(&child)) {
> +		cached_result = 0;
> +		return cached_result;
> +	}
> +	cached_result = 1;
> +	return cached_result;
> +#else
> +	return 0;
> +#endif
> +}

I agree with Ævar that this would be more readable with two separate 
definitions rather chosen by a single #ifdef. I'm dubious that we need 
the caching as well.

> +static char *xdg_config_home_systemd(const char *filename)
> +{
> +	return xdg_config_home_for("systemd/user", filename);
> +}
> +
> +static int systemd_timer_enable_unit(int enable,
> +				     enum schedule_priority schedule)
> +{
> +	const char *cmd = "systemctl";
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	const char *frequency = get_frequency(schedule);
> +
> +	get_schedule_cmd(&cmd, NULL);
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
> +		     "--now", NULL);
> +	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
> +
> +	if (start_command(&child))
> +		die(_("failed to run systemctl"));
> +	return finish_command(&child);

I left some comments about the combination of dying and returning an 
error when reading v2[1]. If you disagree with a reviewers comments 
that's fine but please try to comment on the reviewers suggestions so 
that they know their suggestions weren't just forgotten by accident. 
Looking through the patch this applies to a number of comments I left 
about the error handling (or lack of it) and cleanup. I don't think I 
have anything new to add.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com/

> +}
> +
> +static int systemd_timer_delete_unit_templates(void)
> +{
> +	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	unlink(filename);
> +	free(filename);
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	unlink(filename);
> +	free(filename);
> +
> +	return 0;
> +}
> +
> +static int systemd_timer_delete_units(void)
> +{
> +	return systemd_timer_enable_unit(DISABLE, SCHEDULE_HOURLY) ||
> +	       systemd_timer_enable_unit(DISABLE, SCHEDULE_DAILY) ||
> +	       systemd_timer_enable_unit(DISABLE, SCHEDULE_WEEKLY) ||
> +	       systemd_timer_delete_unit_templates();
> +}
> +
> +static int systemd_timer_write_unit_templates(const char *exec_path)
> +{
> +	char *filename;
> +	FILE *file;
> +	const char *unit;
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	if (safe_create_leading_directories(filename))
> +		die(_("failed to create directories for '%s'"), filename);
> +	file = xfopen(filename, "w");
> +	FREE_AND_NULL(filename);
> +
> +	unit = "# This file was created and is maintained by Git.\n"
> +	       "# Any edits made in this file might be replaced in the future\n"
> +	       "# by a Git command.\n"
> +	       "\n"
> +	       "[Unit]\n"
> +	       "Description=Optimize Git repositories data\n"
> +	       "\n"
> +	       "[Timer]\n"
> +	       "OnCalendar=%i\n"
> +	       "Persistent=true\n"
> +	       "\n"
> +	       "[Install]\n"
> +	       "WantedBy=timers.target\n";
> +	fputs(unit, file);
> +	fclose(file);
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	file = xfopen(filename, "w");
> +	free(filename);
> +
> +	unit = "# This file was created and is maintained by Git.\n"
> +	       "# Any edits made in this file might be replaced in the future\n"
> +	       "# by a Git command.\n"
> +	       "\n"
> +	       "[Unit]\n"
> +	       "Description=Optimize Git repositories data\n"
> +	       "\n"
> +	       "[Service]\n"
> +	       "Type=oneshot\n"
> +	       "ExecStart=\"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
> +	       "LockPersonality=yes\n"
> +	       "MemoryDenyWriteExecute=yes\n"
> +	       "NoNewPrivileges=yes\n"
> +	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
> +	       "RestrictNamespaces=yes\n"
> +	       "RestrictRealtime=yes\n"
> +	       "RestrictSUIDSGID=yes\n"
> +	       "SystemCallArchitectures=native\n"
> +	       "SystemCallFilter=@system-service\n";
> +	fprintf(file, unit, exec_path, exec_path);
> +	fclose(file);
> +
> +	return 0;
> +}
> +
> +static int systemd_timer_setup_units(void)
> +{
> +	const char *exec_path = git_exec_path();
> +
> +	return systemd_timer_write_unit_templates(exec_path) ||
> +	       systemd_timer_enable_unit(ENABLE, SCHEDULE_HOURLY) ||
> +	       systemd_timer_enable_unit(ENABLE, SCHEDULE_DAILY) ||
> +	       systemd_timer_enable_unit(ENABLE, SCHEDULE_WEEKLY);
> +}
> +
> +static int systemd_timer_update_schedule(enum enable_or_disable run_maintenance,
> +					 int fd)
> +{
> +	switch (run_maintenance) {
> +	case ENABLE:
> +		return systemd_timer_setup_units();
> +	case DISABLE:
> +		return systemd_timer_delete_units();
> +	default:
> +		BUG("invalid enable_or_disable value");
> +	}
> +}
> +
>   enum scheduler {
>   	SCHEDULER_INVALID = -1,
>   	SCHEDULER_AUTO,
>   	SCHEDULER_CRON,
> +	SCHEDULER_SYSTEMD,
>   	SCHEDULER_LAUNCHCTL,
>   	SCHEDULER_SCHTASKS,
>   };
> @@ -2097,6 +2260,11 @@ static const struct {
>   		.is_available = is_crontab_available,
>   		.update_schedule = crontab_update_schedule,
>   	},
> +	[SCHEDULER_SYSTEMD] = {
> +		.name = "systemctl",
> +		.is_available = is_systemd_timer_available,
> +		.update_schedule = systemd_timer_update_schedule,
> +	},
>   	[SCHEDULER_LAUNCHCTL] = {
>   		.name = "launchctl",
>   		.is_available = is_launchctl_available,
> @@ -2117,6 +2285,9 @@ static enum scheduler parse_scheduler(const char *value)
>   		return SCHEDULER_AUTO;
>   	else if (!strcasecmp(value, "cron") || !strcasecmp(value, "crontab"))
>   		return SCHEDULER_CRON;
> +	else if (!strcasecmp(value, "systemd") ||
> +		 !strcasecmp(value, "systemd-timer"))
> +		return SCHEDULER_SYSTEMD;
>   	else if (!strcasecmp(value, "launchctl"))
>   		return SCHEDULER_LAUNCHCTL;
>   	else if (!strcasecmp(value, "schtasks"))
> @@ -2155,6 +2326,15 @@ static void resolve_auto_scheduler(enum scheduler *scheduler)
>   	*scheduler = SCHEDULER_SCHTASKS;
>   	return;
>   
> +#elif defined(__linux__)
> +	if (is_systemd_timer_available())
> +		*scheduler = SCHEDULER_SYSTEMD;
> +	else if (is_crontab_available())
> +		*scheduler = SCHEDULER_CRON;
> +	else
> +		die(_("neither systemd timers nor crontab are available"));
> +	return;
> +
>   #else
>   	*scheduler = SCHEDULER_CRON;
>   	return;
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 9eac260307..c8a6f19ebc 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -20,6 +20,18 @@ test_xmllint () {
>   	fi
>   }
>   
> +test_lazy_prereq SYSTEMD_ANALYZE '
> +	systemd-analyze --help >out &&
> +	grep verify out
> +'
> +
> +test_systemd_analyze_verify () {
> +	if test_have_prereq SYSTEMD_ANALYZE
> +	then
> +		systemd-analyze verify "$@"
> +	fi
> +}
> +
>   test_expect_success 'help text' '
>   	test_expect_code 129 git maintenance -h 2>err &&
>   	test_i18ngrep "usage: git maintenance <subcommand>" err &&
> @@ -628,14 +640,54 @@ test_expect_success 'start and stop Windows maintenance' '
>   	test_cmp expect args
>   '
>   
> +test_expect_success 'start and stop Linux/systemd maintenance' '
> +	write_script print-args <<-\EOF &&
> +	printf "%s\n" "$*" >>args
> +	EOF
> +
> +	XDG_CONFIG_HOME="$PWD" &&
> +	export XDG_CONFIG_HOME &&
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance start --scheduler=systemd-timer &&
> +
> +	# start registers the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
> +
> +	printf -- "--user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args" git maintenance stop &&
> +
> +	# stop does not unregister the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_path_is_missing "systemd/user/git-maintenance@.timer" &&
> +	test_path_is_missing "systemd/user/git-maintenance@.service" &&
> +
> +	printf -- "--user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
> +	test_cmp expect args
> +'
> +
>   test_expect_success 'start and stop when several schedulers are available' '
>   	write_script print-args <<-\EOF &&
>   	printf "%s\n" "$*" | sed "s:gui/[0-9][0-9]*:gui/[UID]:; s:\(schtasks /create .* /xml\).*:\1:;" >>args
>   	EOF
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
> -	rm -f expect &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=systemd-timer &&
> +	printf -- "systemctl --user enable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
> +	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> +		hourly daily weekly >>expect &&
> +	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
> +		hourly daily weekly >>expect &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=launchctl &&
> +	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>   	for frequency in hourly daily weekly
>   	do
>   		PLIST="$pfx/Library/LaunchAgents/org.git-scm.git.$frequency.plist" &&
> @@ -647,17 +699,19 @@ test_expect_success 'start and stop when several schedulers are available' '
>   	test_cmp expect args &&
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance start --scheduler=schtasks &&
> +	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>   	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> -		hourly daily weekly >expect &&
> +		hourly daily weekly >>expect &&
>   	printf "schtasks /create /tn Git Maintenance (%s) /f /xml\n" \
>   		hourly daily weekly >>expect &&
>   	test_cmp expect args &&
>   
>   	rm -f args &&
> -	GIT_TEST_MAINT_SCHEDULER="launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
> +	GIT_TEST_MAINT_SCHEDULER="systemctl:./print-args systemctl,launchctl:./print-args launchctl,schtasks:./print-args schtasks" git maintenance stop &&
> +	printf -- "systemctl --user disable --now git-maintenance@%s.timer\n" hourly daily weekly >expect &&
>   	printf "launchctl bootout gui/[UID] $pfx/Library/LaunchAgents/org.git-scm.git.%s.plist\n" \
> -		hourly daily weekly >expect &&
> +		hourly daily weekly >>expect &&
>   	printf "schtasks /delete /tn Git Maintenance (%s) /f\n" \
>   		hourly daily weekly >>expect &&
>   	test_cmp expect args
> 

