Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B866C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjHHRH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjHHRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:07:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CA359A2
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:02:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so9667493e87.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510548; x=1692115348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qN7qwfaPw461YoJocVU4rQ2MciJthpYMqiBF9NrvXak=;
        b=VbpV0x7mE/dP9XvzVO/2qugmH7h3v+AZzs6MSFzpYyjNax/LKmoSHCNmEU9dO07aR1
         tVQJYP1oTwWLRJzDljMKkeruJxTNcj7WDD2x/KDyOGsud6vxuyTStEnEsUgt3ucxM8Ue
         GLpkVgfKxdwuf7vXYtzoooFoPPGL7L1IbYeiw39UDLJOHuXJOkz1rwOG4/dvVFYzhGLG
         NXjTF+ogp6NrnNTslRlZkFsOgAcqxzCbgEEXf9EaVBkYg/LvTTiE+0tiMzsGP3Ix2/0n
         qwB5jfNUx5WLD8kXlDRkbcJ8c8w7uTPBui5K8kFoZ1ja7rC6k391kaEiWQ/JT+IUVVr+
         pONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510548; x=1692115348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qN7qwfaPw461YoJocVU4rQ2MciJthpYMqiBF9NrvXak=;
        b=iJYK8xGPCt6DGLjnxs5Xsr81QvEGHsIKMbdReIOYfjq1uI+DD1lVgxMRKII/kswD0O
         EjUOpPVAKOb1SwRrUaLAgNjhZ8t1Z5693bmFLmyRXx6ASn3dbeaNnNz2H4L29x2IPs3d
         z5OHwDOeiKYwX6AzEQBEwyJi1Ki2buJCikHT/Wwc9xRDjzVeqgFcd9pJ+K9j9ekPV8N4
         T1Wl/udTilNksdBjzKh4rgi/u3cPVyhzJj2KANi4e4WONZUh6o9n1ZsrzZtBJkG1XAyw
         DlZ3Op/rsEn1o1zyiB6WLeEfFyZD/fDKKh+PwMvm+Pr/6YV1eI/x8vBVVd1pm0flMJW0
         QMlQ==
X-Gm-Message-State: AOJu0Yy9AxzkBHoRETO7sjQ346frENPsPrx2w3w5NklPASlpkR7iJ8F2
        HoWLgNlAelMz82PvyoFYsLcOP/l7/3c=
X-Google-Smtp-Source: AGHT+IGxp7x56eXbHhWyq6qu5/rlGiSuPhqtHa+js657hIKMsd7AqjEWgz6LSTXZjVqzjUOSKRJkOw==
X-Received: by 2002:a7b:c7cc:0:b0:3fb:ffa8:6d78 with SMTP id z12-20020a7bc7cc000000b003fbffa86d78mr7958974wmk.36.1691496509965;
        Tue, 08 Aug 2023 05:08:29 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k19-20020a05600c479300b003fe24df4182sm625704wmo.1.2023.08.08.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 05:08:29 -0700 (PDT)
Message-ID: <3e254d61-b74a-f419-1a03-dbc557a9fe86@gmail.com>
Date:   Tue, 8 Aug 2023 13:08:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/2023 19:51, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The get_random_minute() method was created to allow maintenance
> schedules to be fixed to a random minute of the hour. This randomness is
> only intended to spread out the load from a number of clients, but each
> client should have an hour between each maintenance cycle.
> 
> Add this random minute to the systemd integration.

I think it makes sense to keep the random minute implementation the same 
across all the schedulers, but we could use RandomizedDelaySec (possibly 
combined with FixedRandomDelay) to randomize when the job is actually run.

> This integration is more complicated than similar changes for other
> schedulers because of a neat trick that systemd allows: templating.
> 
> The previous implementation generated two template files with names
> of the form 'git-maintenance@.(timer|service)'. The '.timer' or
> '.service' indicates that this is a template that is picked up when we
> later specify '...@<schedule>.timer' or '...@<schedule>.service'. The
> '<schedule>' string is then used to insert into the template both the
> 'OnCalendar' schedule setting and the '--schedule' parameter of the
> 'git maintenance run' command.
> 
> In order to set these schedules to a given minute, we can no longer use
> the 'hourly', 'daily', or 'weekly' strings for '<schedule>' and instead
> need to abandon the template model.

I've left some comments about this below.


> @@ -2299,13 +2299,20 @@ static char *xdg_config_home_systemd(const char *filename)
>   	return xdg_config_home_for("systemd/user", filename);
>   }
>   
> -static int systemd_timer_write_unit_templates(const char *exec_path)
> +static int systemd_timer_write_unit_template(enum schedule_priority schedule,

As we're not writing template files any more I think we should rename 
this to systemd_timer_write_unit_file()

> +					     const char *exec_path,
> +					     int minute)
>   {
>   	char *filename;
>   	FILE *file;
>   	const char *unit;
> +	char *schedule_pattern = NULL;
> +	const char *frequency = get_frequency(schedule);
> +	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);

The "@" in the name signifies that it is a template unit which it isn't 
anymore so I think we want to change this to "git-maintenance-%s.timer"

> +	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);

Same change to the name here. I wonder if we could still use a template 
service file but that would complicate the implementation as we'd need 
to write three timer files but only one service file.

> [...]
> @@ -2375,13 +2399,16 @@ static int systemd_timer_write_unit_templates(const char *exec_path)
>   	return 0;
>   
>   error:
> +	free(schedule_pattern);
> +	free(local_timer_name);
>   	free(filename);
> -	systemd_timer_delete_unit_templates();

This looks like a change in behavior as previously we'd remove any files 
if there was an error rather than leaving behind a timer file without a 
corresponding unit file.

Looking at maintenance_start() we call maintenance_register() which 
disables "gc --auto" before we get to this point so if we fail to write 
the files we'll end up disabling any form of gc in the repository.

> [...]
> -static int systemd_timer_delete_unit_templates(void)
> +static int systemd_timer_delete_unit_template(enum schedule_priority priority)

Same suggestion as above to rename this to ..._unit_file()

>   {
> +	const char *frequency = get_frequency(priority);
> +	char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
> +	char *local_service_name = xstrfmt("git-maintenance@%s.service", frequency);

I'm not sure it is worth it but we could perhaps

	#define SYSTEMD_UNIT_FORMAT "git-maintenance-%s.%s"

above and then these lines and the ones in 
systemd_timer_write_unit_file() would become

	char *local_timer_name = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "timer");
	char *local_service = xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "service");

> [...]
> +static int systemd_timer_delete_unit_templates(void)

Naming again.

Best Wishes

Phillip
