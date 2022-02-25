Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A0C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 10:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiBYKbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiBYKbX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 05:31:23 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05B71DFDF4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 02:30:50 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x5so6720977edd.11
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 02:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=W6hAugLYSvCg6lmI8KpSRS1RHysWHxTPx2dy/wXEyGU=;
        b=SbMyXGCMuK4qi5cGfWkGzTOJKpQN+yP2NW+rBrlz2zDU+RASgoHvYXa/bzC0uPkL+n
         ZaqTzS5PSWPoO0r81abyySBOFBVGd6g9eEmBWVhSuTCXKPmNWviVw9VDQSRhR2eamgHF
         dN7hjvCQgaknSAIyzyix40YA2bS/CgaIwjv4AzEeCzXa9QkAYDng9vQrxXrzAvblHSfB
         i2rmNc1/saLwRT2X+0FuznlNE+uUgIWvChXOQha+fiAYSMAaHY1Sbos8E1rICgoh2tdP
         1Fh0y6qdP/S8vap9cFHL7KDtJvZAzmlwcGigRvxcSYdySc+pQnjSBXGS9xhcSFF/E616
         zCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=W6hAugLYSvCg6lmI8KpSRS1RHysWHxTPx2dy/wXEyGU=;
        b=iTS72qjt4Q2wQHqxwm59xso/B6iCJv0g65jddL1sUIvxm+zWNBAYSjzRJCrMtBfRWn
         /WJGbnu10g0AFzs1MHMavkPxec43zq+b+ARQDy4o/8ffNUGnEf/hJmfMNkEIWmwUQTEs
         Fcla0f1FOMSEsRUGrtsHyg0BiV0dNaTZ/rNU9GZz4jx8qW6CNmHTyPKELOdq+pW48bSH
         HJ9GuEoBnLPcLUviOQbu+YWNLLJU9zz+1cXWYxuqWnJ+wx1HcnmgHOOk2a2e10rbbCVq
         gYyqEvswKX+Jr+sW73qxhBeWKdvg9T33SxRW510fEs4md1qsoUgGZax8GB4kW66NXKc3
         jg+g==
X-Gm-Message-State: AOAM532Ywi2NU+/W971tf1Pmp1VC/VSauJUaR6yWBmtDYMwapZha+Sad
        HPQ6D3ka0XG3VsuGfjnSgS8wekJShvOblg==
X-Google-Smtp-Source: ABdhPJw+ffL7gIogvM0rbuj+wXbU3aIvG21kS9kBDntpB9YdqK2GGSNlXuXiNxAIbRt7SxbjAQZnfw==
X-Received: by 2002:a05:6402:17c8:b0:406:80a3:5cad with SMTP id s8-20020a05640217c800b0040680a35cadmr6354989edy.388.1645785048915;
        Fri, 25 Feb 2022 02:30:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id rs4-20020a170907036400b006d5dc743977sm831015ejb.158.2022.02.25.02.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 02:30:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNXs7-000Rix-KR;
        Fri, 25 Feb 2022 11:30:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 6/8] maintenance: add ability to pass config options
Date:   Fri, 25 Feb 2022 11:29:51 +0100
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
 <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
Message-ID: <220225.86tucn8ch4.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 24 2022, Robert Coup via GitGitGadget wrote:

> From: Robert Coup <robert@coup.net.nz>
>
> Make run_auto_maintenance() accept optional config options for a
> specific invocation of the auto-maintenance process.
> [...]
> -int run_auto_maintenance(int quiet)
> +int run_auto_maintenance(int quiet, const struct strvec *config_opts)
>  {
>  	int enabled;
> +	int i;
>  	struct child_process maint = CHILD_PROCESS_INIT;
>  
>  	if (!git_config_get_bool("maintenance.auto", &enabled) &&
> @@ -1809,6 +1810,11 @@ int run_auto_maintenance(int quiet)
>  
>  	maint.git_cmd = 1;
>  	maint.close_object_store = 1;
> +
> +	if (config_opts)
> +		for (i = 0; i<config_opts->nr; i++)
> +			strvec_pushl(&maint.args, "-c", config_opts->v[i], NULL);
> +
>  	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
>  	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
>  
> diff --git a/run-command.h b/run-command.h
> index 07bed6c31b4..24021abd41f 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -222,8 +222,11 @@ int run_command(struct child_process *);
>  
>  /*
>   * Trigger an auto-gc
> + *
> + * config_opts is an optional list of additional config options to
> + * pass to the maintenance process in the form "some.option=value".
>   */
> -int run_auto_maintenance(int quiet);
> +int run_auto_maintenance(int quiet, const struct strvec *config_opts);
>  
>  #define RUN_COMMAND_NO_STDIN		(1<<0)
>  #define RUN_GIT_CMD			(1<<1)


Shouldn't this bei using git grep the git_config_push.*parameter()
functions instead of adding a new custom method to do this.

Perhaps there's some subtle distinction between the two that's important
here, or perhaps you just didn't know about that API...
