Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A77C07E9E
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA88461A19
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 13:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhGFNVa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhGFNV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 09:21:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5DC061762
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 06:18:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a13so26015314wrf.10
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DC5HzV3uMYVhInxzMQn8tvRBiQBqmaLDTcHCNp61uqI=;
        b=HzFTVHoNxsbdl5Rm/zt749UERuN9nhWapzsxF83X2nb14Mt9CZtHSvY9sTl6ACjoUX
         13JUTQiTOpwtDUn8xPRcWcL6uLs1sdjorHRXBZT9OS2rquk7Ev4TwUEtHHuVaVPed5XK
         j7DdgmeG4lZ8H673fpGATWMlJYOIC/fTrDwXIZkQPR1vsidnuHQecmncIDvL4NIU/4kD
         mPKW2EFkEJevRl4JPFqnsGZevn28cCozWhWIEeqxhZHJFQqODE+Fp5nCd6JktNJuwOw8
         tYY3mbMO55UNDIuYlmET3WhRfHDECrc04JScEQomCVWYz+oeEzVFqbx13hkFCeaaNrMO
         N+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DC5HzV3uMYVhInxzMQn8tvRBiQBqmaLDTcHCNp61uqI=;
        b=UrXI9SqiN9J9zQc5xq7H4ytt1hh4TYf0PvV8SH0o3kTdW73uCvJpTAWJxyxL6gEPuA
         /SnG457kwKLRSoh9U5gW7VqsVMgOAUu3M9G7EE4+dS8dqsIa4PoqnUEHseBMlGw2M1yi
         sEK5/xPYajsEIZLELy178HhAUMa+g7rGlPhAzj8HYoG0w1Whup7q5zIIP/hcr75V4jxT
         5kXpSKuQmdzIeFYWOuH/tQG2+kPQaLB186fMZzQOcGP5CuVpHy0IUlFNo7Mow9b4fEcb
         zqxE536BwRxLNwGpRqzbpE/Rd5qgNIXDkBm5pmDXJ9csA12mbO28hRh3mg9PGNKyvPiV
         UzBg==
X-Gm-Message-State: AOAM533iLCq7mKb9xgnM59Jgnu73Mgx2RAhHB2d1H+kzVQ3BFMqWrX8T
        yPsW9u8TCWT82fPHzOsN3r8=
X-Google-Smtp-Source: ABdhPJz9gBG+0gwoDEfXEuDwUySH0XS5p9SjK8q5r32KwsOXTiZEhM+mQ5A5RUJJJNVaIWnifQCqBw==
X-Received: by 2002:adf:e605:: with SMTP id p5mr22321339wrm.396.1625577527042;
        Tue, 06 Jul 2021 06:18:47 -0700 (PDT)
Received: from [192.168.1.201] (118.22.198.146.dyn.plus.net. [146.198.22.118])
        by smtp.googlemail.com with ESMTPSA id b12sm12630796wrx.60.2021.07.06.06.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:18:46 -0700 (PDT)
Subject: Re: [PATCH v7 0/3] maintenance: add support for systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210702142556.99864-1-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <387ad277-a75c-92ca-b7af-163d10d3b4a4@gmail.com>
Date:   Tue, 6 Jul 2021 14:18:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702142556.99864-1-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi  Lénaïc

On 02/07/2021 15:25, Lénaïc Huard wrote:
> Hello,
> 
> Please find hereafter a new reroll of my patchset to add support for
> systemd timers on Linux for the `git maintenance start` command.
> 
> The changes compared to the previous version address the remarks
> raised during the previous review.
> ... 
> Diff-intervalle contre v6 :
> -:  ---------- > 1:  899b11ed5b cache.h: Introduce a generic "xdg_config_home_for(…)" function
> 1:  604627f347 ! 2:  f3e2f0256b maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
>      @@ Documentation/git-maintenance.txt: OPTIONS
>        
>       +--scheduler=auto|crontab|launchctl|schtasks::
>       +	When combined with the `start` subcommand, specify the scheduler
>      -+	to use to run the hourly, daily and weekly executions of
>      ++	for running the hourly, daily and weekly executions of
>       +	`git maintenance run`.
>      -+	The possible values for `<scheduler>` depend on the system: `crontab`
>      -+	is available on POSIX systems, `launchctl` is available on
>      -+	MacOS and `schtasks` is available on Windows.
>      -+	By default or when `auto` is specified, a suitable scheduler for
>      -+	the system is used. On MacOS, `launchctl` is used. On Windows,
>      -+	`schtasks` is used. On all other systems, `crontab` is used.
>      ++	Possible values for `<scheduler>` are `auto`, `crontab` (POSIX),
>      ++	`launchctl` (macOS), and `schtasks` (Windows).
>      ++	When `auto` is specified, the appropriate platform-specific
>      ++	scheduler is used. Default is `auto`.
>       +
>        
>        TROUBLESHOOTING
>      @@ builtin/gc.c: static const char *get_frequency(enum schedule_priority schedule)
>        	}
>        }
>        
>      ++/*
>      ++ * get_schedule_cmd` reads the GIT_TEST_MAINT_SCHEDULER environment variable
>      ++ * to mock the schedulers that `git maintenance start` rely on.
>      ++ *
>      ++ * For test purpose, GIT_TEST_MAINT_SCHEDULER can be set to a comma-separated
>      ++ * list of colon-separated key/value pairs where each pair contains a scheduler
>      ++ * and its corresponding mock.
>      ++ *
>      ++ * * If $GET_TEST_MAINT_SCHEDULER is not set, return false and leave the
>      ++ *   arguments unmodified.
>      ++ *
>      ++ * * If $GET_TEST_MAINT_SCHEDULER is set, return true.
>      ++ *   In this case, the *cmd value is read as input.
>      ++ *
>      ++ *   * if the input value *cmd is the key of one of the comma-separated list
>      ++ *     item, then *is_available is set to true and *cmd is modified and becomes
>      ++ *     the mock command.
>      ++ *
>      ++ *   * if the input value *cmd isn’t the key of any of the comma-separated list
>      ++ *     item, then *is_available is set to false.
>      ++ *
>      ++ * Ex.:
>      ++ *   GIT_TEST_MAINT_SCHEDULER not set
>      ++ *     ┏━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
>      ++ *     ┃ Input ┃                     Output                      ┃
>      ++ *     ┃ *cmd  ┃ return code │       *cmd        │ *is_available ┃
>      ++ *     ┣━━━━━━━╋━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━┫
>      ++ *     ┃ "foo" ┃    false    │ "foo" (unchanged) │  (unchanged)  ┃
>      ++ *     ┗━━━━━━━┻━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━┛
>      ++ *
>      ++ *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
>      ++ *     ┏━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
>      ++ *     ┃ Input ┃                     Output                      ┃
>      ++ *     ┃ *cmd  ┃ return code │       *cmd        │ *is_available ┃
>      ++ *     ┣━━━━━━━╋━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━┫
>      ++ *     ┃ "foo" ┃    true     │  "./mock.foo.sh"  │     true      ┃
>      ++ *     ┃ "qux" ┃    true     │ "qux" (unchanged) │     false     ┃
>      ++ *     ┗━━━━━━━┻━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━┛
>      ++ */
>       +static int get_schedule_cmd(const char **cmd, int *is_available)
>       +{
>       +	char *item;
>      @@ builtin/gc.c: static int schtasks_schedule_task(const char *exec_path, enum sche
>       +	int is_available;
>       +	struct child_process child = CHILD_PROCESS_INIT;
>       +
>      -+	if (get_schedule_cmd(&cmd, &is_available) && !is_available)
>      -+		return 0;
>      ++	if (get_schedule_cmd(&cmd, &is_available))
>      ++		return is_available;

This fixes the bug that Eric found with the last version - excellent.

>       +
>       +	strvec_split(&child.args, cmd);
>       +	strvec_push(&child.args, "-l");
>      @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
>       +	enum scheduler scheduler;
>       +};
>       +
>      -+static void resolve_auto_scheduler(enum scheduler *scheduler)
>      ++static enum scheduler resolve_scheduler(enum scheduler scheduler)
>       +{
>      -+	if (*scheduler != SCHEDULER_AUTO)
>      -+		return;
>      ++	if (scheduler != SCHEDULER_AUTO)
>      ++		return scheduler;
>       +
>        #if defined(__APPLE__)
>       -static const char platform_scheduler[] = "launchctl";
>      -+	*scheduler = SCHEDULER_LAUNCHCTL;
>      -+	return;
>      ++	return SCHEDULER_LAUNCHCTL;
>       +
>        #elif defined(GIT_WINDOWS_NATIVE)
>       -static const char platform_scheduler[] = "schtasks";
>      -+	*scheduler = SCHEDULER_SCHTASKS;
>      -+	return;
>      ++	return SCHEDULER_SCHTASKS;
>       +
>        #else
>       -static const char platform_scheduler[] = "crontab";
>      -+	*scheduler = SCHEDULER_CRON;
>      -+	return;
>      ++	return SCHEDULER_CRON;
>        #endif
>       +}

This is one of the changes that Eric suggested, I agree it improves the 
code.

Thanks for your work on these patches, I've scanned the rest of the 
range-diff and I'd be happy to see this version merged

Best Wishes

Phillip

>      @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
>       +	if (scheduler == SCHEDULER_INVALID)
>       +		BUG("invalid scheduler");
>       +	if (scheduler == SCHEDULER_AUTO)
>      -+		BUG("resolve_auto_scheduler should have been called before");
>      ++		BUG("resolve_scheduler should have been called before");
>       +
>       +	if (!scheduler_fn[scheduler].is_available())
>       +		die(_("%s scheduler is not available"),
>      @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
>       +	struct option options[] = {
>       +		OPT_CALLBACK_F(
>       +			0, "scheduler", &opts.scheduler, N_("scheduler"),
>      -+			N_("scheduler to use to trigger git maintenance run"),
>      ++			N_("scheduler to trigger git maintenance run"),
>       +			PARSE_OPT_NONEG, maintenance_opt_scheduler),
>       +		OPT_END()
>       +	};
>      @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
>       +	if (argc)
>       +		usage_with_options(builtin_maintenance_start_usage, options);
>       +
>      -+	resolve_auto_scheduler(&opts.scheduler);
>      ++	opts.scheduler = resolve_scheduler(opts.scheduler);
>       +	validate_scheduler(opts.scheduler);
>       +
>        	if (maintenance_register())
> 2:  29628b5a92 ! 3:  0ea5b2fc45 maintenance: add support for systemd timers on Linux
>      @@ Documentation/git-maintenance.txt: OPTIONS
>       ---scheduler=auto|crontab|launchctl|schtasks::
>       +--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
>        	When combined with the `start` subcommand, specify the scheduler
>      - 	to use to run the hourly, daily and weekly executions of
>      + 	for running the hourly, daily and weekly executions of
>        	`git maintenance run`.
>      - 	The possible values for `<scheduler>` depend on the system: `crontab`
>      --	is available on POSIX systems, `launchctl` is available on
>      --	MacOS and `schtasks` is available on Windows.
>      -+	is available on POSIX systems, `systemd-timer` is available on Linux
>      -+	systems, `launchctl` is available on MacOS and `schtasks` is available
>      -+	on Windows.
>      - 	By default or when `auto` is specified, a suitable scheduler for
>      - 	the system is used. On MacOS, `launchctl` is used. On Windows,
>      --	`schtasks` is used. On all other systems, `crontab` is used.
>      -+	`schtasks` is used. On Linux, `systemd-timer` is used if user systemd
>      -+	timers are available, otherwise, `crontab` is used. On all other systems,
>      -+	`crontab` is used.
>      +-	Possible values for `<scheduler>` are `auto`, `crontab` (POSIX),
>      +-	`launchctl` (macOS), and `schtasks` (Windows).
>      +-	When `auto` is specified, the appropriate platform-specific
>      +-	scheduler is used. Default is `auto`.
>      ++	Possible values for `<scheduler>` are `auto`, `crontab`
>      ++	(POSIX), `systemd-timer` (Linux), `launchctl` (macOS), and
>      ++	`schtasks` (Windows). When `auto` is specified, the
>      ++	appropriate platform-specific scheduler is used; on Linux,
>      ++	`systemd-timer` is used if available, otherwise
>      ++	`crontab`. Default is `auto`.
>        
>        
>        TROUBLESHOOTING
>      @@ builtin/gc.c: static enum scheduler parse_scheduler(const char *value)
>        	else if (!strcasecmp(value, "launchctl"))
>        		return SCHEDULER_LAUNCHCTL;
>        	else if (!strcasecmp(value, "schtasks"))
>      -@@ builtin/gc.c: static void resolve_auto_scheduler(enum scheduler *scheduler)
>      - 	*scheduler = SCHEDULER_SCHTASKS;
>      - 	return;
>      +@@ builtin/gc.c: static enum scheduler resolve_scheduler(enum scheduler scheduler)
>      + #elif defined(GIT_WINDOWS_NATIVE)
>      + 	return SCHEDULER_SCHTASKS;
>        
>       +#elif defined(__linux__)
>       +	if (is_systemd_timer_available())
>      -+		*scheduler = SCHEDULER_SYSTEMD;
>      ++		return SCHEDULER_SYSTEMD;
>       +	else if (is_crontab_available())
>      -+		*scheduler = SCHEDULER_CRON;
>      ++		return SCHEDULER_CRON;
>       +	else
>       +		die(_("neither systemd timers nor crontab are available"));
>      -+	return;
>       +
>        #else
>      - 	*scheduler = SCHEDULER_CRON;
>      - 	return;
>      + 	return SCHEDULER_CRON;
>      + #endif
>       
>        ## t/t7900-maintenance.sh ##
>       @@ t/t7900-maintenance.sh: test_xmllint () {
> 

