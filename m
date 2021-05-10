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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0340BC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F50614A5
	for <git@archiver.kernel.org>; Mon, 10 May 2021 18:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhEJSFI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 14:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhEJSFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 14:05:07 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DEFC061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 11:04:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id a10-20020a05600c068ab029014dcda1971aso9551321wmn.3
        for <git@vger.kernel.org>; Mon, 10 May 2021 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1lJ8U+fdIl+wkKsnHHBygJr/mwlDvmRxEAx1U+N+HuQ=;
        b=V0U6Kg8tNjJJkEXOXrJZ6Ia6TqCavQTqn7MNfKa1cofSYd5ZG/Hfpscgwb8CNOV5US
         AHsBi9gNmUwEyGhHsyWkJwE55nhUZOh1xxANVRPiD9969/4AAJfwOv6lIwniMRG5qNKm
         jdyjOsqXP6GsTfBw/FyaUBAiE1ca7zB5P9dDEE6oC7N3AdU8HnnXp1m/cgzloR3NTJTr
         Bl1hVraeVymCwsEy/z7FtYnJ1aexKge8U9qqBUDMi9mDoq1eVJLxoxRMM3o/6EkkGxXl
         0HyQeHtXJHs0PolDSJA8/J4yYs9GtLVKIVdvcG2yMJWa7hNqR2CuPRSt+pGBdPGomeqw
         HjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:cc:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1lJ8U+fdIl+wkKsnHHBygJr/mwlDvmRxEAx1U+N+HuQ=;
        b=KKTOt44KN8RraHmMcvcLY6aSmNu5caruVIH4tU1NU/NfpaX+cTtw1gKcgjdQanxAY2
         J6E5b0XrLjQdh82+7pb8GWAe6lRd9j5QYj/Q4WjLcz5MizalL8laQ6pwofAqFsgEx4R4
         MIBZts3DbETtgG9MER3hj+9Yf0ZhLXE/K67Bk+lxFcLvUgwGCz9VpyAEj2aAN2+z6Jv3
         mPDqg2EUPpWc1gVGnD/xsgGufNM4DIqjDlSJ4PXeMyOAWIhPIVji7gw2M1RERCjCwYyl
         NEmxUUFlzPRpzJblotulxav/3KROAp/ak7Sr+em1oOQe0cKViTmVLZQjIYJcvJCWtVLl
         eCIA==
X-Gm-Message-State: AOAM530y5u8qjdoeiJe/bu4bfv29yeHEUfFIlbHJvjJqrkqUhGoco30z
        Zg1VIegdBt6Pu8E8Oy8sxto=
X-Google-Smtp-Source: ABdhPJxTUVkN0H/NBc/2oNEnsWvNq39b38TlNvek3N2mSPCKSelQI8GC8dQ48vn3jOgPT6PYUZav0Q==
X-Received: by 2002:a05:600c:2296:: with SMTP id 22mr388712wmf.165.1620669840464;
        Mon, 10 May 2021 11:04:00 -0700 (PDT)
Received: from [192.168.1.201] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.googlemail.com with ESMTPSA id q16sm20445842wmj.24.2021.05.10.11.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 11:03:59 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
Reply-To: phillip.wood@dunelm.org.uk
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <20210509213217.449489-1-lenaic@lhuard.fr>
 <20210509213217.449489-2-lenaic@lhuard.fr>
Message-ID: <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
Date:   Mon, 10 May 2021 19:03:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210509213217.449489-2-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

Thanks for updating the patch, I've left some comments below. Aside from 
one possible bug, they mostly revolve around not passing the name of 
scheduler command around when that name is fixed and functions which do 
not check for errors but return a success/failure value (either they 
should check the return values of the system calls they make or be 
declared as void if it is safe to ignore the failures)

On 09/05/2021 22:32, Lénaïc Huard wrote:
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
>    have access to the log of its own tasks scheduled by cron whereas he
>    will have access to the log of its own tasks scheduled by systemd
>    timer.
>    Although `cron` attempts to send email, that email may go unseen by
>    the user because these days, local mailboxes are not heavily used
>    anymore.
> 
> In order to choose which scheduler to use between `cron` and user
> systemd timers, a new option
> `--scheduler=auto|cron|systemd|launchctl|schtasks` has been added to
> `git maintenance start`.
> When `git maintenance start --scheduler=XXX` is run, it not only
> registers `git maintenance run` tasks in the scheduler XXX, it also
> removes the `git maintenance run` tasks from all the other schedulers

I'm not sure it is actually doing that at the moment - see my comment in 
update_background_schedule()

> to
> ensure we cannot have two schedulers launching concurrent identical
> tasks.
> 
> The default value is `auto` which chooses a suitable scheduler for the
> system.
> On Linux, if user systemd timers are available, they will be used as git
> maintenance scheduler. If not, `cron` will be used if it is available.
> If none is available, it will fail.

I think defaulting to systemd timers when both systemd and cron are 
installed is sensible given the problems associated with testing whether 
crond is actually running in that scenario.

> `git maintenance stop` doesn't have any `--scheduler` parameter because
> this command will try to remove the `git maintenance run` tasks from all
> the available schedulers.
> 
> In order to schedule git maintenance, we need two unit template files:
> * ~/.config/systemd/user/git-maintenance@.service
>    to define the command to be started by systemd and
> * ~/.config/systemd/user/git-maintenance@.timer
>    to define the schedule at which the command should be run.
> 
> Those units are templates that are parametrized by the frequency.
> 
> Based on those templates, 3 timers are started:
> * git-maintenance@hourly.timer
> * git-maintenance@daily.timer
> * git-maintenance@weekly.timer
> 
> The command launched by those three timers are the same than with the
> other scheduling methods:
> 
> git for-each-repo --config=maintenance.repo maintenance run
> --schedule=%i
> 
> with the full path for git to ensure that the version of git launched
> for the scheduled maintenance is the same as the one used to run
> `maintenance start`.
> 
> The timer unit contains `Persistent=true` so that, if the computer is
> powered down when a maintenance task should run, the task will be run
> when the computer is back powered on.
> 
> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> ---
>   Documentation/git-maintenance.txt |  60 +++++
>   builtin/gc.c                      | 375 ++++++++++++++++++++++++++++--
>   t/t7900-maintenance.sh            |  51 ++++
>   3 files changed, 462 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
> index 80ddd33ceb..f012923333 100644
> --- a/Documentation/git-maintenance.txt
> +++ b/Documentation/git-maintenance.txt
> @@ -181,6 +181,20 @@ OPTIONS
>   	`maintenance.<task>.enabled` configured as `true` are considered.
>   	See the 'TASKS' section for the list of accepted `<task>` values.
>   
> +--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
> +	When combined with the `start` subcommand, specify the scheduler
> +	to use to run the hourly, daily and weekly executions of
> +	`git maintenance run`.
> +	The possible values for `<scheduler>` depend on the system: `crontab`
> +	is available on POSIX systems, `systemd-timer` is available on Linux
> +	systems, `launchctl` is available on MacOS and `schtasks` is available
> +	on Windows.
> +	By default or when `auto` is specified, the most appropriate scheduler
> +	for the system is used. On MacOS, `launchctl` is used. On Windows,
> +	`schtasks` is used. On Linux, `systemd-timers` is used if user systemd
> +	timers are available, otherwise, `crontab` is used. On all other systems,
> +	`crontab` is used.
> +
>   
>   TROUBLESHOOTING
>   ---------------
> @@ -279,6 +293,52 @@ schedule to ensure you are executing the correct binaries in your
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
> +For more details, see systemd.timer(5)
> +
> +
>   BACKGROUND MAINTENANCE ON MACOS SYSTEMS
>   ---------------------------------------
>   
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ef7226d7bc..7c72aa3b99 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1544,6 +1544,15 @@ static const char *get_frequency(enum schedule_priority schedule)
>   	}
>   }
>   
> +static int is_launchctl_available(const char *cmd)

None of these is_..._available() function needs the cmd parameter. It 
matches the existing pattern of the existing ..._update_schedule() 
functions but they don't really need the cmd argument either so I would 
drop the argument for the new functions.

> +{
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
> @@ -1710,6 +1719,15 @@ static int launchctl_update_schedule(int run_maintenance, int fd, const char *cm
>   		return launchctl_remove_plists(cmd);
>   }
>   
> +static int is_schtasks_available(const char *cmd)
> +{
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
> @@ -1872,6 +1890,28 @@ static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd
>   		return schtasks_remove_tasks(cmd);
>   }
>   
> +static int is_crontab_available(const char *cmd)
> +{
> +	static int cached_result = -1;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	if (cached_result != -1)
> +		return cached_result;
> +
> +	strvec_split(&child.args, cmd);
> +	strvec_push(&child.args, "-l");
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child))
> +		return cached_result = 0;
> +	/* Ignore exit code, as an empty crontab will return error. */
> +	finish_command(&child);
> +	return cached_result = 1;
> +}
> +
>   #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
>   #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
>   
> @@ -1959,61 +1999,348 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
>   	return result;
>   }
>   
> +static int is_systemd_timer_available(const char *cmd)
> +{
> +#ifdef __linux__
> +	static int cached_result = -1;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	if (cached_result != -1)
> +		return cached_result;
> +
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", "list-timers", NULL);
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child))
> +		return cached_result = 0;

This is maybe a bit too clever. It would be clearer to separate the 
assignment of the cached result and the return statement.

> +	if (finish_command(&child))
> +		return cached_result = 0;
> +	return cached_result = 1;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static char *xdg_config_home_systemd(const char *filename)
> +{
> +	const char *home, *config_home;
> +
> +	assert(filename);
> +	config_home = getenv("XDG_CONFIG_HOME");
> +	if (config_home && *config_home)
> +		return mkpathdup("%s/systemd/user/%s", config_home, filename);
> +
> +	home = getenv("HOME");
> +	if (home)
> +		return mkpathdup("%s/.config/systemd/user/%s", home, filename);
> +
> +	die(_("failed to get $XDG_CONFIG_HOME and $HOME"));
> +}

This is largely a copy of xdg_config_home(), I would prefer to see this 
function calling that rather than duplicating it.

static char *xdg_config_home_systemd(const char *filename)
{
     struct strbuf buf = STRBUF_INIT;
     char *path;

     strbuf_addf(&buf, "systemd/user/%s", filename);
     path = xdg_config_home(buf.buf);
     strbuf_release(&buf);
     return path;
}

Even better would be to modify xdg_config_home() to take a format string.

> +static int systemd_timer_enable_unit(int enable,
> +				     enum schedule_priority schedule,
> +				     const char *cmd)

The cmd argument is pointless, it will always be "systemctl" and you 
have even hard coded that value into the error message below.

> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	const char *frequency = get_frequency(schedule);
> +
> +	strvec_split(&child.args, cmd);
> +	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
> +		     "--now", NULL);
> +	strvec_pushf(&child.args, "git-maintenance@%s.timer", frequency);
> +
> +	if (start_command(&child))
> +		die(_("failed to run systemctl"));
> +	return finish_command(&child);

There is a strange mix of dying and returning an error here. Also should 
this be printing a message if finish_command() returns a non-zero value? 
If systemctl fails then there is not much we can do to recover so dying 
on any error might be ok unless we need to perform some cleanup if it 
fails like removing the timer unit files.

What is the exit code of systemctl if a unit is already enabled and we 
try to enbale it again (and the same for disabling a disabled unit)?

> +}
> +
> +static int systemd_timer_delete_unit_templates(void)
> +{
> +	char *filename = xdg_config_home_systemd("git-maintenance@.timer");
> +	unlink(filename);

This is missing error handling (and below). If there is a good reason to 
ignore the errors then there is no point in returning a value from this 
function

> +	free(filename);
> +
> +	filename = xdg_config_home_systemd("git-maintenance@.service");
> +	unlink(filename);
> +	free(filename);
> +
> +	return 0;
> +}
> +
> +static int systemd_timer_delete_units(const char *cmd)
> +{
> +	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, cmd) ||
> +	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, cmd) ||
> +	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, cmd) ||
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
> +	free(filename);
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
> +	if (safe_create_leading_directories(filename))

Haven't we already created this path if it was missing above for the 
first file?

> +		die(_("failed to create directories for '%s'"), filename);
> +	file = xfopen(filename, "w");

Do we want to try and remove the first file if we cannot write the 
second file to leave the file system in a consitent state? If so you'll 
need to use something like fopen_or_warn() and check the return value.

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
> +	       "ExecStart=\"%1$s/git\" --exec-path=\"%1$s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%i\n"
> +	       "LockPersonality=yes\n"
> +	       "MemoryDenyWriteExecute=yes\n"
> +	       "NoNewPrivileges=yes\n"
> +	       "RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6\n"
> +	       "RestrictNamespaces=yes\n"
> +	       "RestrictRealtime=yes\n"
> +	       "RestrictSUIDSGID=yes\n"

After a quick read of the systemd.exec man page it is unclear to me if 
these Restrict... lines are needed as we already have 
NoNewPrivileges=yes - maybe they have some effect if `git maintence` is 
run as root?

> +	       "SystemCallArchitectures=native\n"
> +	       "SystemCallFilter=@system-service\n";
> +	fprintf(file, unit, exec_path);
> +	fclose(file);
> +
> +	return 0;

As we don't return any errors but die instead there is no need to return 
a value. On the other hand maybe we should be checking the return values 
of fclose() and possibly fputs() / fprint().

> +}
> +
> +static int systemd_timer_setup_units(const char *cmd)
> +{
> +	const char *exec_path = git_exec_path();
> +
> +	return systemd_timer_write_unit_templates(exec_path) ||
> +	       systemd_timer_enable_unit(1, SCHEDULE_HOURLY, cmd) ||
> +	       systemd_timer_enable_unit(1, SCHEDULE_DAILY, cmd) ||
> +	       systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, cmd);

If any step fails do we need to try and reverse the preceding steps to 
avoid leaving so units enabled but not others. In practice this is 
probably pretty unlikely so maybe we don't need to worry.

> +}
> +
> +static int systemd_timer_update_schedule(int run_maintenance, int fd,
> +					 const char *cmd)

No need for the cmd argument

> +{
> +	if (run_maintenance)
> +		return systemd_timer_setup_units(cmd);
> +	else
> +		return systemd_timer_delete_units(cmd);
> +}
> +
> +enum scheduler {
> +	SCHEDULER_INVALID = -1,
> +	SCHEDULER_AUTO = 0,
> +	SCHEDULER_CRON = 1,
> +	SCHEDULER_SYSTEMD = 2,
> +	SCHEDULER_LAUNCHCTL = 3,
> +	SCHEDULER_SCHTASKS = 4,
> +};
> +
> +static const struct {
> +	int (*is_available)(const char *cmd);
> +	int (*update_schedule)(int run_maintenance, int fd, const char *cmd);
> +	const char *cmd;
> +} scheduler_fn[] = {
> +	[SCHEDULER_CRON] = { is_crontab_available, crontab_update_schedule,
> +			     "crontab" },
> +	[SCHEDULER_SYSTEMD] = { is_systemd_timer_available,
> +				systemd_timer_update_schedule, "systemctl" },
> +	[SCHEDULER_LAUNCHCTL] = { is_launchctl_available,
> +				  launchctl_update_schedule, "launchctl" },
> +	[SCHEDULER_SCHTASKS] = { is_schtasks_available,
> +				 schtasks_update_schedule, "schtasks" },
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
> +	else if (!strcasecmp(value, "systemd") ||
> +		 !strcasecmp(value, "systemd-timer"))
> +		return SCHEDULER_SYSTEMD;
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
> +	if (unset)
> +		die(_("--no-scheduler is not allowed"));

As others have said it would be better to BUG() here and pass 
PARSE_OPT_NONEG when defining the option below.

> +
> +	*scheduler = parse_scheduler(arg);
> +
> +	if (*scheduler == SCHEDULER_INVALID)
> +		die(_("unrecognized --scheduler argument '%s'"), arg);
> +
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
> +#elif defined(__linux__)
> +	if (is_systemd_timer_available("systemctl"))
> +		*scheduler = SCHEDULER_SYSTEMD;
> +	else if (is_crontab_available("crontab"))
> +		*scheduler = SCHEDULER_CRON;
> +	else
> +		die(_("neither systemd timers nor crontab are available"));
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
> +	const char *cmd;
> +
> +	if (scheduler == SCHEDULER_INVALID)
> +		BUG("invalid scheduler");
> +	if (scheduler == SCHEDULER_AUTO)
> +		BUG("resolve_auto_scheduler should have been called before");
> +
> +	cmd = scheduler_fn[scheduler].cmd;
> +	if (!scheduler_fn[scheduler].is_available(cmd))
> +		die(_("%s scheduler is not available"), cmd);
> +}
> +
> +static int update_background_schedule(const struct maintenance_start_opts *opts,
> +				      int enable)
> +{
> +	unsigned int i;
> +	int res, result = 0;
> +	enum scheduler scheduler;
> +	const char *cmd = NULL;
>   	char *testing;
>   	struct lock_file lk;
>   	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
>   
> +	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
> +		return error(_("another process is scheduling background maintenance"));
> +
>   	testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
>   	if (testing) {
>   		char *sep = strchr(testing, ':');
>   		if (!sep)
>   			die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
>   		*sep = '\0';
> -		scheduler = testing;
> +		scheduler = parse_scheduler(testing);
>   		cmd = sep + 1;
> +		result = scheduler_fn[scheduler].update_schedule(
> +			enable, get_lock_file_fd(&lk), cmd);
> +		goto done;
>   	}
>   
> -	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0)
> -		return error(_("another process is scheduling background maintenance"));
> -
> -	if (!strcmp(scheduler, "launchctl"))
> -		result = launchctl_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else if (!strcmp(scheduler, "schtasks"))
> -		result = schtasks_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else if (!strcmp(scheduler, "crontab"))
> -		result = crontab_update_schedule(enable, get_lock_file_fd(&lk), cmd);
> -	else
> -		die("unknown background scheduler: %s", scheduler);
> +	for (i = 1; i < ARRAY_SIZE(scheduler_fn); i++) {
> +		int enable_scheduler = enable && (opts->scheduler == i);
> +		cmd = scheduler_fn[i].cmd;
> +		if (!scheduler_fn[i].is_available(cmd))
> +			continue;
> +		res = scheduler_fn[i].update_schedule(
> +			enable_scheduler, get_lock_file_fd(&lk), cmd);
> +		if (enable_scheduler)
> +			result = res;

If I have understood the code correctly then if systemd timers are 
currently enabled and the user runs `git maintenance --scheduler=cron` 
then cron will be enabled and the loop will quit before we get the the 
entry to disable systemd timers leaving both running. I think it would 
be cleaner and clearer to loop over the schedulers disabling them first 
and then enable the one the user has selected.

> +	}
>   
> +done:
>   	rollback_lock_file(&lk);
>   	free(testing);
>   	return result;
>   }
>   
> -static int maintenance_start(void)
> +static const char *const builtin_maintenance_start_usage[] = {
> +	N_("git maintenance start [--scheduler=<scheduler>]"), NULL
> +};
> +
> +static int maintenance_start(int argc, const char **argv, const char *prefix)
>   {
> +	struct maintenance_start_opts opts;

struct maintenance_start_opts opts = { 0 };

would avoid the need for the memset() call below

Thanks again for working on this. Best Wishes

Phillip

> +	struct option builtin_maintenance_start_options[] = {
> +		OPT_CALLBACK(
> +			0, "scheduler", &opts.scheduler, N_("scheduler"),
> +			N_("scheduler to use to trigger git maintenance run"),
> +			maintenance_opt_scheduler),
> +		OPT_END()
> +	};
> +	memset(&opts, 0, sizeof(opts));
> +
> +	argc = parse_options(argc, argv, prefix,
> +			     builtin_maintenance_start_options,
> +			     builtin_maintenance_start_usage, 0);
> +
> +	resolve_auto_scheduler(&opts.scheduler);
> +	validate_scheduler(opts.scheduler);
> +
> +	if (argc > 0)
> +		usage_with_options(builtin_maintenance_start_usage,
> +				   builtin_maintenance_start_options);
> +
>   	if (maintenance_register())
>   		warning(_("failed to add repo to global config"));
> -
> -	return update_background_schedule(1);
> +	return update_background_schedule(&opts, 1);
>   }
>   
>   static int maintenance_stop(void)
>   {
> -	return update_background_schedule(0);
> +	return update_background_schedule(NULL, 0);
>   }
>   
>   static const char builtin_maintenance_usage[] =	N_("git maintenance <subcommand> [<options>]");
> @@ -2027,7 +2354,7 @@ int cmd_maintenance(int argc, const char **argv, const char *prefix)
>   	if (!strcmp(argv[1], "run"))
>   		return maintenance_run(argc - 1, argv + 1, prefix);
>   	if (!strcmp(argv[1], "start"))
> -		return maintenance_start();
> +		return maintenance_start(argc - 1, argv + 1, prefix);
>   	if (!strcmp(argv[1], "stop"))
>   		return maintenance_stop();
>   	if (!strcmp(argv[1], "register"))
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 2412d8c5c0..6e6316cd90 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -20,6 +20,20 @@ test_xmllint () {
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
> +	else
> +		true
> +	fi
> +}
> +
>   test_expect_success 'help text' '
>   	test_expect_code 129 git maintenance -h 2>err &&
>   	test_i18ngrep "usage: git maintenance <subcommand>" err &&
> @@ -615,6 +629,43 @@ test_expect_success 'start and stop Windows maintenance' '
>   	test_cmp expect args
>   '
>   
> +test_expect_success 'start and stop Linux/systemd maintenance' '
> +	write_script print-args <<-\EOF &&
> +	echo $* >>args
> +	EOF
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemd:./print-args" git maintenance start &&
> +
> +	# start registers the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_systemd_analyze_verify "$HOME/.config/systemd/user/git-maintenance@.service" &&
> +
> +	rm -f expect &&
> +	for frequency in hourly daily weekly
> +	do
> +		echo "--user enable --now git-maintenance@${frequency}.timer" >>expect || return 1
> +	done &&
> +	test_cmp expect args &&
> +
> +	rm -f args &&
> +	GIT_TEST_MAINT_SCHEDULER="systemd:./print-args" git maintenance stop &&
> +
> +	# stop does not unregister the repo
> +	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
> +
> +	test_path_is_missing "$HOME/.config/systemd/user/git-maintenance@.timer" &&
> +	test_path_is_missing "$HOME/.config/systemd/user/git-maintenance@.service" &&
> +
> +	rm -f expect &&
> +	for frequency in hourly daily weekly
> +	do
> +		echo "--user disable --now git-maintenance@${frequency}.timer" >>expect || return 1
> +	done &&
> +	test_cmp expect args
> +'
> +
>   test_expect_success 'register preserves existing strategy' '
>   	git config maintenance.strategy none &&
>   	git maintenance register &&
> 
