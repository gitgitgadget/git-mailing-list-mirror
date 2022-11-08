Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F94C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKHUi7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 15:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiKHUi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 15:38:57 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624567114
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 12:38:56 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v1so22807501wrt.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 12:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXSti5Lg3jJtFQ4ZuxzCTN38ut/hDX4aIUcd8YqSKKk=;
        b=mfES10/cpBaEDlIWYjBtiAPK0XTympN+46GphlzS/Ry3u98DBsdvNxwzqnygt9m0d9
         yTxGNbQOY0FejbNLiCHcoBPLGD67frX4nvruVRrlpAelHmhs8Sg0vWlAPDitcJnMKbam
         SYSsLWF9MlCk2SkQqmSnytrp2FeWi1KJKIBwPdXfNqjUxT1EIpla1KMnLTIysMQHoUC4
         dGivTnk5uhuONTR1gUPidoww2HHv0ANJ54RjRvkAg7IRrrG5LTnmzzGTgVBMiGcyV7Yw
         qGYkhASPsGn+R0k3+tOXp7bB8Mr/OWf7A7LOas7/qEXUuObQd9TFMBXlyNkBdPienFvI
         fQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXSti5Lg3jJtFQ4ZuxzCTN38ut/hDX4aIUcd8YqSKKk=;
        b=A0DWyb0e0pXTHEbunUrB0E/d+/tp1aDaDv/oZuCfV2W+BGU5gxSx3Yu75CYh5O3dxM
         Zdn4z3J6FpotpBeUzwPXqFo/AquKWYjauY7Y14goN7GI35UCwqTI7xRdkaDxesxQC9A/
         wnJvvoCtqNgwsDyVeJl7sNjP5FSNmSt8/7gatYmjxinL4JtWFJbUNLFDLLM6Dj1k6BD5
         iW7GfEqwX1SeXrg3u4JKKYkCA2xwGSlGRP3dzZt6t9EMuQKhxV7V6OzjhZBxtO6CT6OK
         elCGD71rcplXX5cKAJMCaZuhidsnVHfXr6cXwIvwCaI7HHQcgJ0HGde4B5K/+KLqEf4y
         kJzQ==
X-Gm-Message-State: ACrzQf2KtZsbjCE8zQdGV+9ArnAZNhPdlwcNy71CTCTrlFQnTcd5/B6E
        AI262eb4CLkV4LMGrdjzPOo69MEDacM=
X-Google-Smtp-Source: AMsMyM6inlqZfLMxynou9u3okUhPU3EKt3ZHYr9V7qLsD1Py0Py36pYHNpMTTer2EWKoqwKAcDeJBg==
X-Received: by 2002:adf:a351:0:b0:236:bd81:4cf6 with SMTP id d17-20020adfa351000000b00236bd814cf6mr21111854wrb.299.1667939934711;
        Tue, 08 Nov 2022 12:38:54 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d6e84000000b00236722ebe66sm11385607wrz.75.2022.11.08.12.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:38:54 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <448cc6ed-c441-85a3-2780-0c07e56f53f8@dunelm.org.uk>
Date:   Tue, 8 Nov 2022 20:38:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] maintenance: add option to register in a specific
 config
Content-Language: en-US
To:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org
Cc:     me@ttaylor.com, derrickstolee@github.com
References: <20221108194930.25805-1-ronan@rjp.ie>
 <20221108194930.25805-3-ronan@rjp.ie>
In-Reply-To: <20221108194930.25805-3-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ronan

I think both these patches are useful improvements, thanks for working 
on them. I've left one comment below

On 08/11/2022 19:49, Ronan Pigott wrote:
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 24ea85c7af..1709355bce 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -1497,12 +1499,16 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>   
>   	if (!found) {
>   		int rc;
> -		char *user_config, *xdg_config;
> -		git_global_config(&user_config, &xdg_config);
> -		if (!user_config)
> -			die(_("$HOME not set"));
> +		char *user_config = NULL, *xdg_config = NULL;
> +
> +		if (!config_file) {
> +			git_global_config(&user_config, &xdg_config);
> +			config_file = user_config;

Here we need to decide whether to use user_config or xdg_config as the 
config file. In builtin/config.c we do this with

		if (access_or_warn(user_config, R_OK, 0) &&
		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
			given_config_source.file = xdg_config;
			free(user_config);
		} else {
			given_config_source.file = user_config;
			free(xdg_config);
		}

We need something similar here (maybe we should create a helper function 
to find the appropriate file)

> +			if (!user_config)
> +				die(_("$HOME not set"));

This check needs to come before deciding which config file to use

Best Wishes

Phillip

> +		}
>   		rc = git_config_set_multivar_in_file_gently(
> -			user_config, "maintenance.repo", maintpath,
> +			config_file, "maintenance.repo", maintpath,
>   			CONFIG_REGEX_NONE, 0);
>   		free(user_config);
>   		free(xdg_config);
> @@ -1517,14 +1523,16 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
>   }
>   
>   static char const * const builtin_maintenance_unregister_usage[] = {
> -	"git maintenance unregister [--force]",
> +	"git maintenance unregister [--config-file <path>] [--force]",
>   	NULL
>   };
>   
>   static int maintenance_unregister(int argc, const char **argv, const char *prefix)
>   {
>   	int force = 0;
> +	char *config_file = NULL;
>   	struct option options[] = {
> +		OPT_STRING(0, "config-file", &config_file, N_("file"), N_("use given config file")),
>   		OPT__FORCE(&force,
>   			   N_("return success even if repository was not registered"),
>   			   PARSE_OPT_NOCOMPLETE),
> @@ -1542,24 +1550,29 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>   		usage_with_options(builtin_maintenance_unregister_usage,
>   				   options);
>   
> -	list = git_config_get_value_multi(key);
> -	if (list) {
> -		for_each_string_list_item(item, list) {
> -			if (!strcmp(maintpath, item->string)) {
> -				found = 1;
> -				break;
> +	if (!config_file) {
> +		list = git_config_get_value_multi(key);
> +		if (list) {
> +			for_each_string_list_item(item, list) {
> +				if (!strcmp(maintpath, item->string)) {
> +					found = 1;
> +					break;
> +				}
>   			}
>   		}
>   	}
>   
> -	if (found) {
> +	if (found || config_file) {
>   		int rc;
> -		char *user_config, *xdg_config;
> -		git_global_config(&user_config, &xdg_config);
> -		if (!user_config)
> -			die(_("$HOME not set"));
> +		char *user_config = NULL, *xdg_config = NULL;
> +		if (!config_file) {
> +			git_global_config(&user_config, &xdg_config);
> +			config_file = user_config;
> +			if (!user_config)
> +				die(_("$HOME not set"));
> +		}
>   		rc = git_config_set_multivar_in_file_gently(
> -			user_config, key, NULL, maintpath,
> +			config_file, key, NULL, maintpath,
>   			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);
>   		free(user_config);
>   		free(xdg_config);
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 96bdd42045..091da683a8 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -500,6 +500,21 @@ test_expect_success 'register and unregister' '
>   	git config --global --get-all maintenance.repo >actual &&
>   	test_cmp before actual &&
>   
> +	git config --file ./other --add maintenance.repo /existing1 &&
> +	git config --file ./other --add maintenance.repo /existing2 &&
> +	git config --file ./other --get-all maintenance.repo >before &&
> +
> +	git maintenance register --config-file ./other &&
> +	test_cmp_config false maintenance.auto &&
> +	git config --file ./other --get-all maintenance.repo >between &&
> +	cp before expect &&
> +	pwd >>expect &&
> +	test_cmp expect between &&
> +
> +	git maintenance unregister --config-file ./other &&
> +	git config --file ./other --get-all maintenance.repo >actual &&
> +	test_cmp before actual &&
> +
>   	test_must_fail git maintenance unregister 2>err &&
>   	grep "is not registered" err &&
>   	git maintenance unregister --force
