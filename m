Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5EAC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhK2XlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhK2XlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:41:24 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70703C061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:38:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id v23so23725938iom.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 15:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NeNwS4/oMFxghKHLm89gi4J8//k/B4L8YDoUC6Gjjz0=;
        b=OTSqQGIaIEhYzHI4ML3JHBiuVQSHjDSDobNqYSwyJcfrIuZU3t0my7/xcF3KPp8O+d
         tR1j0+4N8qgHqqcrv+H5iUgX8rNliHLbd+76mGjDWPcRC6H1V/RLBDq0eCPjDwxl2SZV
         n2isj2RVZRPHN7NeKLS3LAZsCQbVer/MAlf4M06uj4Q3I9DW8X/fz+dxJeMMVWEmmq7w
         tdBc0D8/D2kmdTzbzhSEPWJ4gQNzbgGgrtQNc8jQRe5eLsx+/Ke3trpYQDXvUidBhBMF
         GZ63TEbe9JIXgp0PSfb8SFLoFsnNUQdeb5lctHjAQcGMokvBo0VB8uWx4vV1GZM4YVc0
         JqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NeNwS4/oMFxghKHLm89gi4J8//k/B4L8YDoUC6Gjjz0=;
        b=pIE3NadMFbMLUD7HHataUOFzx6cIfIBfPlAJk+03fa5m63YPRvubqf67vFDJkhOZF0
         hMu9OFFFPFbvUOwgOlTZTUiM5k6lCXtwNJDEgE5IkO5QPrljCGBZawBxcywx838c0+zA
         2UDtMK6l+awvbZNbmSLCNeWYW9wzSRov0UpZtnkXMNWyzQ5WfSNue9+3kJAtiDxOh+ll
         C/jkn39WTtt4aFmdoXv1Dh1gdDNX42elQ5ZnFKw9t2Y4wYENNsbVI9yDGfu+8TXCx73I
         Iga9oB0u3YiAvyFiaG47WWmtZ/C+OOljPtgd0DOVZKhAyjIaoF4gynqsUH1fstouOo0R
         CgSg==
X-Gm-Message-State: AOAM531BYiPjCYwoHgDQdrmULJePESmewGlB7XaU+vpPsv5QuIqWnqlD
        6FIhHxgxbK9o8wueiJGBQJs=
X-Google-Smtp-Source: ABdhPJy9TIWuJVlVbtWMlsxmgU/P1ulFfOzHZuqqbaH/nhcL6A6lidj3QZ1X28TA9DRKjARrX2qzMw==
X-Received: by 2002:a6b:ba05:: with SMTP id k5mr55141510iof.194.1638229085811;
        Mon, 29 Nov 2021 15:38:05 -0800 (PST)
Received: from [192.168.86.121] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id x13sm9179085ilp.43.2021.11.29.15.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 15:38:05 -0800 (PST)
Message-ID: <6db27c92-6ea6-fa5f-8aa7-e1fef7d5ff5a@gmail.com>
Date:   Mon, 29 Nov 2021 15:38:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
 <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
 <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
 <xmqq8rxe787g.fsf@gitster.g> <724abbd4-b9ee-3b3d-226c-b7999f138152@gmail.com>
 <xmqqzgpt2z0h.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqzgpt2z0h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/24/21 10:23 AM, Junio C Hamano wrote:
> Lessley Dennington <lessleydennington@gmail.com> writes:
> 
>>>> @@ -1588,8 +1588,10 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>>>>      	git_config(git_checkout_config, opts);
>>>>    -	prepare_repo_settings(the_repository);
>>>> -	the_repository->settings.command_requires_full_index = 0;
>>>> +	if (startup_info->have_repository) {
>>>> +		prepare_repo_settings(the_repository);
>>>> +		the_repository->settings.command_requires_full_index = 0;
>>>> +	}
>>> I am kind-a surprised if the control reaches this deep if you are
>>> not in a repository.  In git.c::commands[] list, all three primary
>>> entry points that call checkout_main(), namely, cmd_checkout(),
>>> cmd_restore(), and cmd_switch(), are marked with RUN_SETUP bit,
>>> which makes us call setup_git_directory() even before we call the
>>> cmd_X() function.  And setup_git_directory() dies with "not a git
>>> repository (or any of the parent directories)" outside a repository.
>>> So, how can startup_info->have_repository bit be false if the
>>> control flow reaches here?  Or am I grossly misunderstanding what
>>> you are trying to do?
>>>
>> This was in reaction to the t0012-help.sh tests failing with the
>> new BUG in prepare_repo_settings. However, Elijah pointed out that
>> it's a better idea to move prepare_repo_settings farther down
>> (after parse_options) instead. So I will be issuing that change as
>> part of v5.
> 
> I forgot that "git foo -h" for a builtin command 'foo' calls
> run_builtin() but bypasses the RUN_SETUP and NEED_WORK_TREE handling
> before it in turn calls cmd_foo().  We expect a call in cmd_foo() to
> parse_options() emit a short-help and exit.
> 
> So, yes, there is a way to reach this point in the codeflow without
> being in a repository (or even when in a repository, we may have
> chosen not to realize it).  Feels ugly.
> 
> Now a bit of tangent.
> 
> I wonder if it is a problem to completely bypass RUN_SETUP in such a
> case.  In general, we read the configuration to tweak the hardcoded
> default behaviour, and then further override it by parsing command
> line options.  In order to read configuration fully, we'd need to
> know where the repository is.  So the start-up sequence must be in
> this order:
> 
>   - discover where the repository is (either gently or with a hard failure)
>   - read the configuration files
>   - call parse_options()
> 
> And by completly bypassing RUN_SETUP, we are not reading per-repo
> settings from the configuration files.
> 
> Something along this line (note: there is an always-taken if block
> to reduce the patch noise for this illustration), perhaps.
> 
> 
> 
> 
>   git.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git i/git.c w/git.c
> index 5ff21be21f..50e258508e 100644
> --- i/git.c
> +++ w/git.c
> @@ -421,25 +421,30 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>   	int status, help;
>   	struct stat st;
>   	const char *prefix;
> +	int run_setup = (p->option & (RUN_SETUP | RUN_SETUP_GENTLY));
>   
>   	prefix = NULL;
>   	help = argc == 2 && !strcmp(argv[1], "-h");
> -	if (!help) {
> -		if (p->option & RUN_SETUP)
> +	if (help && (run_setup & RUN_SETUP))
> +		/* demote to GENTLY to allow 'git cmd -h' outside repo */
> +		run_setup = RUN_SETUP_GENTLY;
> +
> +	if (1) {
> +		if (run_setup & RUN_SETUP)
>   			prefix = setup_git_directory();
> -		else if (p->option & RUN_SETUP_GENTLY) {
> +		else if (run_setup & RUN_SETUP_GENTLY) {
>   			int nongit_ok;
>   			prefix = setup_git_directory_gently(&nongit_ok);
>   		}
>   		precompose_argv_prefix(argc, argv, NULL);
> -		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
> +		if (use_pager == -1 && run_setup &&
>   		    !(p->option & DELAY_PAGER_CONFIG))
>   			use_pager = check_pager_config(p->cmd);
>   		if (use_pager == -1 && p->option & USE_PAGER)
>   			use_pager = 1;
>   
> -		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
> -		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
> +		if (run_setup && startup_info->have_repository)
> +			/* get_git_dir() may set up repo, avoid that */
>   			trace_repo_setup(prefix);
>   	}
>   	commit_pager_choice();
> 
This is cool! I applied it locally, and it seems to be working well. I
will plan to replace my changes to checkout and pack-objects with this
for v5.

Lessley
