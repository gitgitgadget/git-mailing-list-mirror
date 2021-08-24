Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48331C432BE
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235E0610E6
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 18:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbhHXSCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 14:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbhHXSBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 14:01:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7705C03327C
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:45:40 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso43175999otp.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EnqhtLw8HQsgNJ04GNm4GlcdIiaQc52ABYLqRbhhC+E=;
        b=RJhozFAWlGRDtxtKwxTtrhTYluvuKYh7gmr7e5Rp8ZAzlo4dZt//HxJue3U91M3JHa
         Vb4t9BOe7eBp5PCQVvR007DtTadRYpoNeoCZN4EVdFcC7aDlLux9drR5pBvsJpkCVR8h
         CpC5bQbxsDffFTgq6MvkwqqRN2tcvfT8C7gAjhVJPWRToz3kseU/aZPAmu+nJghtgipx
         MPUEe5wuEp177ubvEEqVg5934dGvLKRXJ2J7f/yKYn3aCUj2pLzkHxszaegMwRD+o52g
         gVMc3aEH5pl1BGHs7CiY9vrFbn6/Nb90jiZ1/UE5RGZHcOZYO2WhqUvxGx9Ydg9Xd1o9
         7UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EnqhtLw8HQsgNJ04GNm4GlcdIiaQc52ABYLqRbhhC+E=;
        b=VEz8sf/f7erFbpffm10njEEAwUUS1MH3wnoSU3KNWwK4sX/x3IjroT+OYdL2CGE27Y
         iuXH0VtyWl2YS/aDVrKlM9KQC952699iJpbKoXsB1ZmXYs2NuJDsWnAfi1A+rve7zKNZ
         VfTsp/ldRqaGGYeHQDXst2zeiEnOu7XBs3GrkU6CjsJV0Ln2E1+R9W7o3QdwDqkP1K6w
         Awt33L6ZxatFB0txgkvUVH+fJ2eTvlC1HlZiwTKaxx0QzWZU7RgunT4tIXFrkD4tCFOl
         vqr9FVzIu/WFzH8UHncvVKyb3Nt9pyZdXtOL81FzVsWxx8XI14KvAJTurEMwMRfaAO1B
         jS7g==
X-Gm-Message-State: AOAM530A5rHADPlqLWv6Zn0JLIiaUTAVHKYQMfxlZPO3c4pOBRCRPKZK
        psHUyx4jY0MVZLoQsE9aUAo=
X-Google-Smtp-Source: ABdhPJx/ICCczYi22x/hLX+zEvB4cUBTY1vhwWQUsr5hAdr3NxbHx2Fsx3RNwzxLauNPP8ShpglEcQ==
X-Received: by 2002:a9d:541:: with SMTP id 59mr31842785otw.278.1629827140235;
        Tue, 24 Aug 2021 10:45:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id s24sm4658455otp.37.2021.08.24.10.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:45:39 -0700 (PDT)
Subject: Re: [PATCH v8 3/3] maintenance: add support for systemd timers on
 Linux
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20210702142556.99864-1-lenaic@lhuard.fr>
 <20210823204011.87023-1-lenaic@lhuard.fr>
 <20210823204011.87023-4-lenaic@lhuard.fr>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <66b2961f-19c8-d308-c9d2-eb8d05599a84@gmail.com>
Date:   Tue, 24 Aug 2021 13:45:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823204011.87023-4-lenaic@lhuard.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 4:40 PM, Lénaïc Huard wrote:
> +#ifdef __linux__
> +
> +static int real_is_systemd_timer_available(void)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	strvec_pushl(&child.args, "systemctl", "--user", "list-timers", NULL);
> +	child.no_stdin = 1;
> +	child.no_stdout = 1;
> +	child.no_stderr = 1;
> +	child.silent_exec_failure = 1;
> +
> +	if (start_command(&child))
> +		return 0;
> +	if (finish_command(&child))
> +		return 0;
> +	return 1;
> +}
> +
> +#else
> +
> +static int real_is_systemd_timer_available(void)
> +{
> +	return 0;
> +}
> +
> +#endif

This #ifdef option is one that could be changed. There is a lot
of code inside the #ifdef that would be nice to compile on all
platforms.

Technically, we could drop all conditionals here and rely on
the start_command() and finish_command() to tell us that systemd
is or is not installed. This would allow a potential future where
maybe macOS supports systemd (or users install a version
themselves).

Another option would be to compile in a conditional early return
inside real_is_systemd_timer_available() such as

static int real_is_systemd_timer_available(void)
{
	struct child_process child = CHILD_PROCESS_INIT;

#ifndef __linux__
	if (1)
		return 0;
#endif

	strvec_pushl(&child.args, "systemctl", "--user", "list-timers", NULL);
	child.no_stdin = 1;
	child.no_stdout = 1;
	child.no_stderr = 1;
	child.silent_exec_failure = 1;

	if (start_command(&child))
		return 0;
	if (finish_command(&child))
		return 0;
	return 1;
}

...but this also looks a bit awkward in order to avoid compilers
complaining about unreachable code (and some might still rightly
warn about unreachable code).

> +static int systemd_timer_setup_units(void)
> +{
> +	const char *exec_path = git_exec_path();
> +
> +	int ret = systemd_timer_write_unit_templates(exec_path) ||
> +	          systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
> +	          systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
> +	          systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);

These lines are incorrectly tabbed with spaces. Here is a corrected
version:

+	int ret = systemd_timer_write_unit_templates(exec_path) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_DAILY) ||
+		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY);

'git rebase --whitespace=fix <base>' will also fix these issues. You
can discover if they exist using 'git log --check'.

Thanks,
-Stolee
