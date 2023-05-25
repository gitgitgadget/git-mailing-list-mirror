Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A1AC77B7E
	for <git@archiver.kernel.org>; Thu, 25 May 2023 20:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjEYUNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 May 2023 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjEYUNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2023 16:13:47 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDC09B
        for <git@vger.kernel.org>; Thu, 25 May 2023 13:13:45 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so151893276.0
        for <git@vger.kernel.org>; Thu, 25 May 2023 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685045625; x=1687637625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FoP7Pa1Z7I8XT6nBMJdOUNpTUZjbcIWRzzbDwIhs7k=;
        b=chaxfl9pLewnleAt627SoHLlZmohVnrfqP7rAxKCFPDctUd516XyA2YvDwS8mCjmKP
         ffVji7tklllq7Ot45BX1UFcHgLB7U2n/n8erjeN2KfheYsVZZGFPFg6XZHUGgZ45Q3mG
         iVgBcHklx8Xn5eHG47ujD/aVG0KhfuE71FxCsf3cgsJcr5k9vJfy7Qj3+o3K4Za5/wBZ
         pdWCmCu+URX8t66Kow4mW/Yw3lZineaK8REGeeS7N7MkWPC4W0ywPYRL9LL3VXysLW/p
         oiuVvUFVF17810OjWleo6oB+ppV+EHBYruuJQWilPMg3x9LJJVHWene2XU+VHzmMtxy3
         ZShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045625; x=1687637625;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FoP7Pa1Z7I8XT6nBMJdOUNpTUZjbcIWRzzbDwIhs7k=;
        b=d5OiQydwuBuRNUd1GU2roPDL3An2yZPuDF4JvSByAwRKUTt8TnPWW6Plgpvm3AKWhv
         s8H0Oy/uAwB4hJiFUpUMgfsH2TrT5Nq98zXaFK5FO7CyHCqPupfkpOXbzyCPZru4NnUY
         abgkJl+0kZRSgSuDeBV9CWpfg7IzA6cF5prPncA1IvbB0p/rp1xFBAyYX9l0pDDgcoLJ
         KfBwgs/RL30KkiJI91JpnafFM3dOJidOALANmxDLDyzgFhK+q16WwCYGyzJ+pD+lk9UK
         OTX9Vgbezbu2e7qRd1LUzEfghdsi49zZojtECIDCOKUsu9YOTKS9npE5IzkTgJf1V00f
         XByA==
X-Gm-Message-State: AC+VfDx2jgW1p0fzxYRNP+oBoY8gqs7tsyKYtn/uB/rdvM7oAP8QoK/F
        R/dKqunHjsiYG4BC8R3QxrZ+
X-Google-Smtp-Source: ACHHUZ7u+poA3QKeFEjmnT+CaqGh5L7ogKtm4lHYnc8h0iy06j7Bdnyn5GgrN/5fDvG0278i2fob9Q==
X-Received: by 2002:a0d:d456:0:b0:561:da0d:6488 with SMTP id w83-20020a0dd456000000b00561da0d6488mr534444ywd.50.1685045624998;
        Thu, 25 May 2023 13:13:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2c68:6384:8f43:adfe? ([2600:1700:e72:80a0:2c68:6384:8f43:adfe])
        by smtp.gmail.com with ESMTPSA id t20-20020a81c254000000b00561949f713fsm580401ywg.39.2023.05.25.13.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:13:44 -0700 (PDT)
Message-ID: <4d8907ba-3fe5-5bc1-e7bd-237edec31261@github.com>
Date:   Thu, 25 May 2023 16:13:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] repository: move 'repository_format_worktree_config'
 to repo scope
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     chooglen@google.com, Victoria Dye <vdye@github.com>
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/23/2023 7:17 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Move 'repository_format_worktree_config' out of the global scope and into
> the 'repository' struct. This change is similar to how
> 'repository_format_partial_clone' was moved in ebaf3bcf1ae (repository: move
> global r_f_p_c to repo struct, 2021-06-17), adding to the 'repository'
> struct and updating 'setup.c' & 'repository.c' functions to assign the value
> appropriately. In addition, update usage of the setting to reference the
> relevant context's repo or, as a fallback, 'the_repository'.
> 
> The primary goal of this change is to be able to load worktree config for a
> submodule depending on whether that submodule - not the super project - has
> 'extensions.worktreeConfig' enabled. To ensure 'do_git_config_sequence()'
> has access to the newly repo-scoped configuration:
> 
> - update 'repo_read_config()' to create a 'config_source' to hold the
>   repo instance
> - add a 'repo' argument to 'do_git_config_sequence()'
> - update 'config_with_options' to call 'do_git_config_sequence()' with
>   'config_source.repo', or 'the_repository' as a fallback
> 
> Finally, add/update tests in 't3007-ls-files-recurse-submodules.sh' to
> verify 'extensions.worktreeConfig' is read an used independently by super
> projects and submodules.
 
> @@ -2277,7 +2278,7 @@ int config_with_options(config_fn_t fn, void *data,
>  		data = &inc;
>  	}
>  
> -	if (config_source)
> +	if (config_source && config_source->scope != CONFIG_SCOPE_UNKNOWN)
>  		config_reader_set_scope(&the_reader, config_source->scope);

This extra condition on config_source->scope surprised me. Could you
elaborate on the reason this is necessary?

> @@ -2667,11 +2670,14 @@ static void repo_read_config(struct repository *repo)
>  {
>  	struct config_options opts = { 0 };
>  	struct configset_add_data data = CONFIGSET_ADD_INIT;
> +	struct git_config_source config_source = { 0 };

This could be...

	struct git_config_source config_source = { .repo = repo };

>  
>  	opts.respect_includes = 1;
>  	opts.commondir = repo->commondir;
>  	opts.git_dir = repo->gitdir;
>  
> +	config_source.repo = repo;
> +

...avoiding these lines.

> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
> index e35c203241f..6d0bacef4de 100755
> --- a/t/t3007-ls-files-recurse-submodules.sh
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -309,19 +309,30 @@ test_expect_success '--recurse-submodules parses submodule repo config' '
>  test_expect_success '--recurse-submodules parses submodule worktree config' '
>  	test_when_finished "git -C submodule config --unset extensions.worktreeConfig" &&
>  	test_when_finished "git -C submodule config --worktree --unset feature.experimental" &&
> -	test_when_finished "git config --unset extensions.worktreeConfig" &&
>  
>  	git -C submodule config extensions.worktreeConfig true &&
>  	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
>  
> -	# NEEDSWORK: the extensions.worktreeConfig is set globally based on super
> -	# project, so we need to enable it in the super project.
> -	git config extensions.worktreeConfig true &&
> -
>  	test_must_fail git ls-files --recurse-submodules 2>err &&
>  	grep "bad boolean config value" err
>  '

These are my favorite kind of test updates: deleting extra setup that's no
longer needed.

> +test_expect_success '--recurse-submodules submodules ignore super project worktreeConfig extension' '
> +	test_when_finished "git config --unset extensions.worktreeConfig" &&
> +
> +	# Enable worktree config in both super project & submodule, set an
> +	# invalid config in the submodule worktree config, then disable worktree
> +	# config in the submodule. The invalid worktree config should not be
> +	# picked up.
> +	git config extensions.worktreeConfig true &&
> +	git -C submodule config extensions.worktreeConfig true &&
> +	git -C submodule config --worktree feature.experimental "invalid non-boolean value" &&
> +	git -C submodule config --unset extensions.worktreeConfig &&
> +
> +	git ls-files --recurse-submodules 2>err &&
> +	! grep "bad boolean config value" err
> +'

We have the same ways to improve here using 'test_config' as recommended
in patch 1.

Thanks,
-Stolee
