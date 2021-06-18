Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE7C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADAC161261
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhFRVB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhFRVB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:01:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AD2C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:59:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so8870767pjs.2
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ph+d5eyb78rp+mlqJgfOu8jExIuSeKAQavI/Q3YGmFk=;
        b=GqdfffXQwGg21niwdIJcWbBtctOZdI4xPF1erYGHVkDG8Z801vdtYWoK8D8TvLSH3k
         MqAw87nC0eEgNUAb2B08FctqM8CgMXzNfU8hHzFWBG8RuTUcO4eH9V9949IHHepPBfE7
         oNc30cLT1bQXN7xA+OAruZ11YE9iZaIqP40ARv60EYg/v6zra1VtD651njoy56aQL+8G
         dfRMcgobTtJik4E91VQ63QlHL3+eFpgeukx+ckugBVBpCdDxpzXj4l3WsusY/ZVFpL7v
         dSqwM+oCmSXBC4DKs84y3wQA9ZdXvfrIrGiTYwF5nkxYhSr5B60BuZbHLEWTm6Y+fjhV
         vHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ph+d5eyb78rp+mlqJgfOu8jExIuSeKAQavI/Q3YGmFk=;
        b=ftYGXBiVLz09XLMw0CMbg+a8aa8Ywa4SJlNlVZeoZUfE8jJ1kM0NaERZc9BJNylgfw
         5vcv2c9PeqAC2Z22kwB7rYS9I42RBUTmQRK6VZcYTMbZt12qC9dRfWXB2fTAEkMQyypL
         Lyu2XlsQuqjuOEO0g8/ezZsB8i4b8uPgMkyNy50thRwfUOBfCEn4T0NyMVN7OEk2ygNO
         pZif3y5URiReQ/l/itqHFP7Oz00J0/GmUAWifwHwVlbnKIe5ACrWOxAlG4YFseHj/lL/
         EZjxNsg2G1hmC7/zN26p1pl5LR4xaZRHTpq+dwx/mao2xk8tDHXcqyHusX3jpOeXUdsS
         hRAA==
X-Gm-Message-State: AOAM532y/2lGOPxgj4q48h3qKwqumYxynk4SAygnQ/MhvlyPetlvVzY0
        c9HVyJZ6h8zKQOogUlqzWhZxfKTrgPy4XQ==
X-Google-Smtp-Source: ABdhPJzCLr23DH2KgKl8D0dDR/5O9N27BF0BtChQZ9gHaRyhyQ/o3e8Ybq1QEx3O0cgJhuLLT+noRw==
X-Received: by 2002:a17:902:bd09:b029:ec:7e58:a54a with SMTP id p9-20020a170902bd09b02900ec7e58a54amr6543485pls.62.1624049986463;
        Fri, 18 Jun 2021 13:59:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:551d:e7ea:4a2f:6667])
        by smtp.gmail.com with ESMTPSA id p45sm2199263pfw.19.2021.06.18.13.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:59:45 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:59:39 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] hook: move list of hooks
Message-ID: <YM0JOyxPGYmzynoc@google.com>
References: <cover.1623881977.git.jonathantanmy@google.com>
 <74ed668e9bbf56bb7898bcdfaaf77db4f3205fe5.1623881977.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ed668e9bbf56bb7898bcdfaaf77db4f3205fe5.1623881977.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 16, 2021 at 04:31:48PM -0700, Jonathan Tan wrote:
> 
> The list of hooks will need to be used outside bugreport, so move it to
> a central location.

Hm, does this fight with
https://lore.kernel.org/git/cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com
?

This patch itself looks pretty straightforward, but I think it is a good
idea to take a look at avarab's change first.

 - Emily

> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/bugreport.c | 38 +++-----------------------------------
>  hook.c              | 34 ++++++++++++++++++++++++++++++++++
>  hook.h              |  3 +++
>  3 files changed, 40 insertions(+), 35 deletions(-)
> 
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 190272ba70..4e0806dff3 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -41,38 +41,6 @@ static void get_system_info(struct strbuf *sys_info)
>  
>  static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  {
> -	/*
> -	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> -	 * so below is a transcription of `git help hooks`. Later, this should
> -	 * be replaced with some programmatically generated list (generated from
> -	 * doc or else taken from some library which tells us about all the
> -	 * hooks)
> -	 */
> -	static const char *hook[] = {
> -		"applypatch-msg",
> -		"pre-applypatch",
> -		"post-applypatch",
> -		"pre-commit",
> -		"pre-merge-commit",
> -		"prepare-commit-msg",
> -		"commit-msg",
> -		"post-commit",
> -		"pre-rebase",
> -		"post-checkout",
> -		"post-merge",
> -		"pre-push",
> -		"pre-receive",
> -		"update",
> -		"post-receive",
> -		"post-update",
> -		"push-to-checkout",
> -		"pre-auto-gc",
> -		"post-rewrite",
> -		"sendemail-validate",
> -		"fsmonitor-watchman",
> -		"p4-pre-submit",
> -		"post-index-change",
> -	};
>  	int i;
>  
>  	if (nongit) {
> @@ -81,9 +49,9 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  		return;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(hook); i++)
> -		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
> -			strbuf_addf(hook_info, "%s\n", hook[i]);
> +	for (i = 0; i < hook_name_count; i++)
> +		if (hook_exists(hook_name[i], HOOKDIR_USE_CONFIG))
> +			strbuf_addf(hook_info, "%s\n", hook_name[i]);
>  }
>  
>  static const char * const bugreport_usage[] = {
> diff --git a/hook.c b/hook.c
> index ff80e52edd..3ccacb72fa 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -5,6 +5,40 @@
>  #include "run-command.h"
>  #include "prompt.h"
>  
> +/*
> + * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> + * so below is a transcription of `git help hooks`. Later, this should
> + * be replaced with some programmatically generated list (generated from
> + * doc or else taken from some library which tells us about all the
> + * hooks)
> + */
> +const char *hook_name[] = {
> +	"applypatch-msg",
> +	"pre-applypatch",
> +	"post-applypatch",
> +	"pre-commit",
> +	"pre-merge-commit",
> +	"prepare-commit-msg",
> +	"commit-msg",
> +	"post-commit",
> +	"pre-rebase",
> +	"post-checkout",
> +	"post-merge",
> +	"pre-push",
> +	"pre-receive",
> +	"update",
> +	"post-receive",
> +	"post-update",
> +	"push-to-checkout",
> +	"pre-auto-gc",
> +	"post-rewrite",
> +	"sendemail-validate",
> +	"fsmonitor-watchman",
> +	"p4-pre-submit",
> +	"post-index-change",
> +};
> +int hook_name_count = ARRAY_SIZE(hook_name);
> +
>  void free_hook(struct hook *ptr)
>  {
>  	if (ptr) {
> diff --git a/hook.h b/hook.h
> index f32189380a..d902166408 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -4,6 +4,9 @@
>  #include "strvec.h"
>  #include "run-command.h"
>  
> +extern const char *hook_name[];
> +extern int hook_name_count;
> +
>  struct hook {
>  	struct list_head list;
>  	/*
> -- 
> 2.32.0.272.g935e593368-goog
> 
