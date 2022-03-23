Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6CC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 16:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245344AbiCWQBb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCWQBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 12:01:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5227B118
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:00:00 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p189so1230942wmp.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cZgSaREMHB1QrWLkqeM31I1IOHeiqTkPrNejx9diiEg=;
        b=To/wRVxJ+IwS/2OFCvIAoG8BOdN28ibjrpfkKAM9DpBAc0ybWU0MfZ3cMnS7PwpH4K
         8qfwFkvEGwCJnWnFxUzDi8l9s3FhLv+auH4DFInsfQuAGQRdSJx3MXUjp5y5Cmrz0MYn
         UylaYn+jR8t6NSOLw8L4bUrzq7+DhZDr0usO08iJItZ6ZdxLandQZKe52s24yvr6Y2ET
         4N3MdMtpscEmsJ86IMmUeMdfWB6eZTHoijOeCjtjY4kTcPX1Y6DorIatRAsQzr0X26lC
         u9pYiQGpzbSprEJW1QNboMPzLnHB2Xe77l4WIRNgNTXrSc8IsCu4RckSAcuiFNxBix8c
         GJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cZgSaREMHB1QrWLkqeM31I1IOHeiqTkPrNejx9diiEg=;
        b=DeAVlQCJyLtHZ1UNy63Cv3DDklqLz+LGqoTKJ6wsbIiKL5i9/+NPzA+GypHxkoaV8f
         80tzMq1fdojmx/B0tKzB5EiOKqcVCfF5D7QFtARk9t5eutF6rxv/vjgJbF74av4L33uj
         Rrk9p9EAdicrZ5rtx4cVnDekwwfoUuRrxq7J3HzUhIOLwut0RrZhnejXZfzJeRqsoIUH
         4LPuei0HtiK4ipF4me1omFYPvzBrU8grQr51d10c2t32IUdgHzUSa/cbt65qoIvPbiWl
         ylH8/PjqFwJG3FaJp1E/v3OrmApfVbWrf7gT8Kz/hD7WwyjL0Z2B8IWp9zb26xjTH54q
         bgvw==
X-Gm-Message-State: AOAM532AbDviGd7OHyJySCUee8jA/vrPlilQn2qACR6dto2Wo1ifqHq7
        wJmQ8lkfnJOZH+kbQY+b3Tw=
X-Google-Smtp-Source: ABdhPJzFRU282PXYj0EFvLmKYTWfsQNO7s6E8Jtb0Na2eyWWNCE4wB4hAaJrJzX7hIquDHWj8XNt7Q==
X-Received: by 2002:a05:600c:3d07:b0:38b:94f2:5d17 with SMTP id bh7-20020a05600c3d0700b0038b94f25d17mr571205wmb.67.1648051199096;
        Wed, 23 Mar 2022 08:59:59 -0700 (PDT)
Received: from [192.168.1.201] (203.2.7.51.dyn.plus.net. [51.7.2.203])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b0038c9249ffdesm357895wmq.9.2022.03.23.08.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 08:59:58 -0700 (PDT)
Message-ID: <355f36d5-7153-42a4-6db8-b9ba5fcac422@gmail.com>
Date:   Wed, 23 Mar 2022 15:59:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] reset: do not make '--quiet' disable index refresh
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1184.git.1647894889.gitgitgadget@gmail.com>
 <f89e9b4ae24718116d0275333f4ece1d4024ab6b.1647894889.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <f89e9b4ae24718116d0275333f4ece1d4024ab6b.1647894889.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria

On 21/03/2022 20:34, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Update '--quiet' to no longer implicitly skip refreshing the index in a
> mixed reset. Users now have the ability to explicitly disable refreshing the
> index with the '--no-refresh' option, so they no longer need to use
> '--quiet' to do so. Moreover, we explicitly remove the refresh-skipping
> behavior from '--quiet' because it is completely unrelated to the stated
> purpose of the option: "Be quiet, only report errors."
> 
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>   Documentation/git-reset.txt |  5 +----
>   builtin/reset.c             |  7 -------
>   t/t7102-reset.sh            | 32 +++++---------------------------
>   3 files changed, 6 insertions(+), 38 deletions(-)
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 89ddc85c2e4..bc1646c3016 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -114,10 +114,7 @@ OPTIONS
>   --no-refresh::
>   	Proactively refresh the index after a mixed reset. If unspecified, the
>   	behavior falls back on the `reset.refresh` config option. If neither
> -	`--[no-]refresh` nor `reset.refresh` are set, the default behavior is
> -	decided by the `--[no-]quiet` option and/or `reset.quiet` config.
> -	If `--quiet` is specified or `reset.quiet` is set with no command-line
> -	"quiet" setting, refresh is disabled. Otherwise, refresh is enabled.
> +	`--[no-]refresh` nor `reset.refresh` are set, refresh is enabled.
>   
>   --pathspec-from-file=<file>::
>   	Pathspec is passed in `<file>` instead of commandline args. If
> diff --git a/builtin/reset.c b/builtin/reset.c
> index c8a356ec5b0..7c3828f6fc5 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -430,13 +430,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>   						PARSE_OPT_KEEP_DASHDASH);
>   	parse_args(&pathspec, argv, prefix, patch_mode, &rev);
>   
> -	/*
> -	 * If refresh is completely unspecified (either by config or by command
> -	 * line option), decide based on 'quiet'.
> -	 */
> -	if (refresh < 0)
> -		refresh = !quiet;

Does this mean we can stop initializing refresh to -1?

Best Wishes

Phillip
