Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE61C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 15:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKIPFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiKIPFj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 10:05:39 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353BF18366
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 07:05:38 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so10490825qts.1
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/vbDJS15IChLC/yMBivMSb6NaXowFAmlNayD4STn5gE=;
        b=FfaiqoqmJvhG6q6+f3o/3fkCqTQouJRpIzja7bTpNrGyUx2p9+qloakUUKP6kveJoU
         cQjPY39IUWD/IPKs8drimigVvZr8hG0h9WH9dzTRuXMuuRVC5JXPpzgMwzG4sxP6sOrZ
         fkzCiGi/PJUnF9VeDiuRXxm/B305dOmyBb24P7ftQMQOtj/PnKOVq/5Rcqhrh0zSCdxC
         GbyxMyEJfYS10WURTo+7DyUdV/CZkZWW+T7EiCt7hsLd0gQ/+8SzayGTKwBXnJHdoTQn
         TbuwfIl5q8pgubWJXabQNwdmghOswncdONspKvzC+KIuqkhhlMFbnRrhogSD9ZdXX2Ab
         nZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vbDJS15IChLC/yMBivMSb6NaXowFAmlNayD4STn5gE=;
        b=dQJR7U3nWi/xLuj/yTS2CGL+XZOYUj0dd7VwOF6LDX5OFMLZTJJTNeTE/6c6aKhD6G
         hUn9VtQ/fa95ml63l07buFjO2nZXFsW3SRUP1sY6cM824omWDogH5ohN/UfD7Mle9Nqx
         9YPk325/8e3sjhlP9my4MYkMHr3nR+bOJC87MYQsuk7hpPNL8gy9q8vsl1zeoEu0Lldo
         LVzJl8EY2fBMs2JwpRdec4GgDWyiubStYR4eSu0KkzVi4WtWOhKqg3gD0hULwrOH4tb3
         lISUn5HzN8cUWVYUKi+YSX/Hz20AqCObf0uLVLDP+t0nZf1uIL1dUKp1o5Ui3AFI4TXb
         QkXw==
X-Gm-Message-State: ACrzQf37hWNCIrEFBIhOw0s80nQtnyhMsft/MGBPnqnn2NMUnkc8mwFu
        q3MM4PcE1golxso+ldlF1sx4dw+z1ceK
X-Google-Smtp-Source: AMsMyM6Xh8PEoCACnPdloSkibrc4Ua3qXA3RjTzqZPjPAkMT9OGOf98NdZ0WhvnG0s43aJ3ihvN1lQ==
X-Received: by 2002:ac8:4f01:0:b0:3a5:54e2:4e1c with SMTP id b1-20020ac84f01000000b003a554e24e1cmr25919907qte.63.1668006337269;
        Wed, 09 Nov 2022 07:05:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9489:2f30:3101:b539? ([2600:1700:e72:80a0:9489:2f30:3101:b539])
        by smtp.gmail.com with ESMTPSA id bn5-20020a05620a2ac500b006eee3a09ff3sm10975440qkb.69.2022.11.09.07.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 07:05:35 -0800 (PST)
Message-ID: <df1d3485-3913-c132-83b5-09ca2408000b@github.com>
Date:   Wed, 9 Nov 2022 10:05:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] maintenance: add option to register in a specific
 config
To:     Ronan Pigott <ronan@rjp.ie>, git@vger.kernel.org
Cc:     me@ttaylor.com
References: <20221108194930.25805-1-ronan@rjp.ie>
 <20221108194930.25805-3-ronan@rjp.ie>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20221108194930.25805-3-ronan@rjp.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/8/2022 2:49 PM, Ronan Pigott wrote:
> maintenance register currently records the maintenance repo exclusively
> within the user's global configuration, but other configuration files
> may be relevant when running maintenance if they are included from the
> global config. This option allows the user to choose where maintenance
> repos are recorded.

> +	Initialize Git config values so any scheduled maintenance will start
> +	running on this repository. This adds the repository to the
> +	`maintenance.repo` config variable in the current user's global config,
> +	or the config specified by --config option, and enables some

This still says --config...

> +	recommended configuration values for `maintenance.<task>.schedule`. The
> +	tasks that are enabled are safe for running in the background without
> +	disrupting foreground processes.

> +	"git maintenance register [--config-file <path>]",

> +	char *config_file = NULL;
>  	struct option options[] = {
> +		OPT_STRING(0, "config-file", &config_file, N_("file"), N_("use given config file")),

>  static char const * const builtin_maintenance_unregister_usage[] = {
> -	"git maintenance unregister [--force]",
> +	"git maintenance unregister [--config-file <path>] [--force]",

> +	char *config_file = NULL;
>  	struct option options[] = {
> +		OPT_STRING(0, "config-file", &config_file, N_("file"), N_("use given config file")),

...but these have been updated. Easy to miss that doc update.

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
>  			}
>  		}
>  	}
>  
> -	if (found) {
> +	if (found || config_file) {

This seems like it will attempt to update the given config file
regardless of its contents. This might result in failures when the
file does not have that value, which is different than the typical
case.

I think the right thing to do would be to update the first
"if (!config_file)" block to have an else.


	if (!config_file)
		list = git_config_get_value_multi(key);
	else
		list = <get multi-value from the file>

	if (list) {
		for_each_string_list_item(item, list) {
			...

Then the "if (found)" case can be the same.

>  		int rc;
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
>  		rc = git_config_set_multivar_in_file_gently(
> -			user_config, key, NULL, maintpath,
> +			config_file, key, NULL, maintpath,
>  			CONFIG_FLAGS_MULTI_REPLACE | CONFIG_FLAGS_FIXED_VALUE);

at least until this part that handles the config write.

>  		free(user_config);
>  		free(xdg_config);
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 96bdd42045..091da683a8 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -500,6 +500,21 @@ test_expect_success 'register and unregister' '
>  	git config --global --get-all maintenance.repo >actual &&
>  	test_cmp before actual &&
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

Please add a case of `git maintenance unregister --config-file` where
the given file does not already have that repo listed to make sure we
cover that case.

Thanks,
-Stolee
