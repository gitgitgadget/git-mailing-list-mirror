Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE49C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434986120A
	for <git@archiver.kernel.org>; Mon, 24 May 2021 09:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhEXJmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 05:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhEXJmv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 05:42:51 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A1C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 02:41:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so11051698wmf.5
        for <git@vger.kernel.org>; Mon, 24 May 2021 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xH/mQ0mAbdE/ZZpOh84IiMiYIyaEUBS0ZIL2cKu2S/Q=;
        b=n1GT2jUcUTjhejlXal/vHApYqzJuFOHbTFYlr7a2uk5k8k2c5PGRSbHUd/Z/HuGrW2
         mP4Qb0M5pg0P0TM2F5mM0bXi3vheDGJoAnoatfpIhHH3qWBxOdHSpIwNOgixE7YD5C6k
         k6c6muPbucpJmc8rP9tD0eoMe8eFJRYY5MOJrzXGqGf4RnjDb59Fv/nFt5tyBjs9eu8f
         OchEnLSCqQJ3+mfe5V2tUsXg5bKG4o6E7biVlRf0v916sgjx1lszGBOaHTTBDPLiNwoW
         KKKLqWXvKFWUeYlreXCfp4xvsqZXTlkTBlesI0j+HJT5s3/T5tXkz+BIeFJSSO+h3tUE
         Y6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xH/mQ0mAbdE/ZZpOh84IiMiYIyaEUBS0ZIL2cKu2S/Q=;
        b=c8quYq3L7GcTpP93QOsRFFr4tlJ8t30zokXFY2keMGk4zUtR3UbjRQK1KqE9zrrTte
         0VlqyPpobh5zRqGJl9t9+VGBE+kOVmoYI0gHl/iEmmBeSgxxU9CtjngQyfc+fyBhW9yZ
         MtEA5bncrMSR9f4aoRytErWj+ubRIAvvAoIWulXcefwwfp5LU7tnzwBwh940Ny6m4WFh
         OvvGbwO/Rwhjn8Powhl18s0SZVBVY7ezU9YpixDTetLFPIuKKSpPLaGGNH3By6xUNG8C
         VryuLUHCodriBqCAjBYtrR6NNTlC3xTdemAcxoWDvprsMGnQ2wLydV/cO80jsbAXrXTm
         8CSg==
X-Gm-Message-State: AOAM533IHUPBjmeVD4etKngyqE8rszEFOEhR8UewTLuDFjwviMy8WN5U
        FFGec/scNsSin4fu8eHQDdw=
X-Google-Smtp-Source: ABdhPJwc7XuVxO95ECQZMShNxWAdyxm+Jz6SjrL6Wo7sseZhX4l2CDv7rPadKFq7vWSdpvuW2+oljA==
X-Received: by 2002:a1c:4482:: with SMTP id r124mr19367637wma.42.1621849280118;
        Mon, 24 May 2021 02:41:20 -0700 (PDT)
Received: from [192.168.1.201] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.googlemail.com with ESMTPSA id s11sm7323854wmf.14.2021.05.24.02.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 02:41:19 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] maintenance: introduce ENABLE/DISABLE for code
 clarity
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
 <20210524071538.46862-3-lenaic@lhuard.fr>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8e013441-08dc-fbb5-f9b9-649b2ffd78db@gmail.com>
Date:   Mon, 24 May 2021 10:41:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210524071538.46862-3-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lénaïc

On 24/05/2021 08:15, Lénaïc Huard wrote:
> The first parameter of `XXX_update_schedule` and alike functions is a
> boolean specifying if the tasks should be scheduled or unscheduled.
> 
> Using an `enum` with `ENABLE` and `DISABLE` values can make the code
> clearer.

I'm sorry to say that I'm not sure this does make the code clearer 
overall - I wish I'd spoken up when Danh suggested it.
While
	launchctl_boot_plist(DISABLE, filename, cmd)
is arguably clearer than
	launchctl_boot_plist(0, filename, cmd)
we end up with bizarre tests like
  	if (enabled == ENABLED)
rather than
	if (enabled)
and in the next patch we have
	(enable == ENABLE && (opts->scheduler == i)) ?
			ENABLE : DISABLE;
rather than
	enable && opts->scheduler == i

Also looking at the next patch it seems as this one is missing some 
conversions in maintenance_start() as it is still calling 
update_background_schedule() with an integer rather than the new enum.

I'd be happy to see this being dropped I'm afraid

Best Wishes

Phillip

> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> ---
>   builtin/gc.c | 49 +++++++++++++++++++++++++++++++------------------
>   1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/gc.c b/builtin/gc.c
> index ef7226d7bc..0caf8d45c4 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1570,19 +1570,21 @@ static char *launchctl_get_uid(void)
>   	return xstrfmt("gui/%d", getuid());
>   }
>   
> -static int launchctl_boot_plist(int enable, const char *filename, const char *cmd)
> +enum enable_or_disable {
> +	DISABLE,
> +	ENABLE
> +};
> +
> +static int launchctl_boot_plist(enum enable_or_disable enable,
> +				const char *filename, const char *cmd)
>   {
>   	int result;
>   	struct child_process child = CHILD_PROCESS_INIT;
>   	char *uid = launchctl_get_uid();
>   
>   	strvec_split(&child.args, cmd);
> -	if (enable)
> -		strvec_push(&child.args, "bootstrap");
> -	else
> -		strvec_push(&child.args, "bootout");
> -	strvec_push(&child.args, uid);
> -	strvec_push(&child.args, filename);
> +	strvec_pushl(&child.args, enable == ENABLE ? "bootstrap" : "bootout",
> +		     uid, filename, NULL);
>   
>   	child.no_stderr = 1;
>   	child.no_stdout = 1;
> @@ -1601,7 +1603,7 @@ static int launchctl_remove_plist(enum schedule_priority schedule, const char *c
>   	const char *frequency = get_frequency(schedule);
>   	char *name = launchctl_service_name(frequency);
>   	char *filename = launchctl_service_filename(name);
> -	int result = launchctl_boot_plist(0, filename, cmd);
> +	int result = launchctl_boot_plist(DISABLE, filename, cmd);
>   	unlink(filename);
>   	free(filename);
>   	free(name);
> @@ -1684,8 +1686,8 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
>   	fclose(plist);
>   
>   	/* bootout might fail if not already running, so ignore */
> -	launchctl_boot_plist(0, filename, cmd);
> -	if (launchctl_boot_plist(1, filename, cmd))
> +	launchctl_boot_plist(DISABLE, filename, cmd);
> +	if (launchctl_boot_plist(ENABLE, filename, cmd))
>   		die(_("failed to bootstrap service %s"), filename);
>   
>   	free(filename);
> @@ -1702,12 +1704,17 @@ static int launchctl_add_plists(const char *cmd)
>   		launchctl_schedule_plist(exec_path, SCHEDULE_WEEKLY, cmd);
>   }
>   
> -static int launchctl_update_schedule(int run_maintenance, int fd, const char *cmd)
> +static int launchctl_update_schedule(enum enable_or_disable run_maintenance,
> +				     int fd, const char *cmd)
>   {
> -	if (run_maintenance)
> +	switch (run_maintenance) {
> +	case ENABLE:
>   		return launchctl_add_plists(cmd);
> -	else
> +	case DISABLE:
>   		return launchctl_remove_plists(cmd);
> +	default:
> +		BUG("invalid enable_or_disable value");
> +	}
>   }
>   
>   static char *schtasks_task_name(const char *frequency)
> @@ -1864,18 +1871,24 @@ static int schtasks_schedule_tasks(const char *cmd)
>   		schtasks_schedule_task(exec_path, SCHEDULE_WEEKLY, cmd);
>   }
>   
> -static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd)
> +static int schtasks_update_schedule(enum enable_or_disable run_maintenance,
> +				    int fd, const char *cmd)
>   {
> -	if (run_maintenance)
> +	switch (run_maintenance) {
> +	case ENABLE:
>   		return schtasks_schedule_tasks(cmd);
> -	else
> +	case DISABLE:
>   		return schtasks_remove_tasks(cmd);
> +	default:
> +		BUG("invalid enable_or_disable value");
> +	}
>   }
>   
>   #define BEGIN_LINE "# BEGIN GIT MAINTENANCE SCHEDULE"
>   #define END_LINE "# END GIT MAINTENANCE SCHEDULE"
>   
> -static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
> +static int crontab_update_schedule(enum enable_or_disable run_maintenance,
> +				   int fd, const char *cmd)
>   {
>   	int result = 0;
>   	int in_old_region = 0;
> @@ -1925,7 +1938,7 @@ static int crontab_update_schedule(int run_maintenance, int fd, const char *cmd)
>   			fprintf(cron_in, "%s\n", line.buf);
>   	}
>   
> -	if (run_maintenance) {
> +	if (run_maintenance == ENABLE) {
>   		struct strbuf line_format = STRBUF_INIT;
>   		const char *exec_path = git_exec_path();
>   
> 

