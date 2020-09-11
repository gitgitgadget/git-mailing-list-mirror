Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E227C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C127022208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 19:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8gQV/jF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKTNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 15:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgIKTNG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 15:13:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D930C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:13:06 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so10946826qkj.7
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gcB9rigky/Roqc1J/LMat3XT8BHi8OARedvfq5HJ4v8=;
        b=P8gQV/jFGYDy9Y/YA2CIZtLisVll5pkfR03Pcl5fI8XUVDBujMPv4wFUJ84eDGohZP
         2r5zH720YB3jBhc5AF67HOTsDSMkmWEoudUhbXwArXo32aEc40WPnj4ztEL4Kcp8tT89
         ZUUkbqTGX+LpxoGiToV6NbyRtMDTiX+nn1CbXFTOsFFQRnP03VXQxyVtrWVmRGSssItB
         VGzsLQZI8OhQbUdT4nIl9leYFu3wO5vb4WAJrXaIeGi1BaCDmlRjDwN9lSxzA3M3VQk1
         lsGSQOr6MX1+fmyoEwRderqM4I1G/FE5lE6XSGGn276/7/CVSI9iIM89kXfgq/dlxpgM
         ok8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gcB9rigky/Roqc1J/LMat3XT8BHi8OARedvfq5HJ4v8=;
        b=nceW18EwUpXRhNQgOltPQsP71sjWH4ViLmtccUoiL+q+gE3iL7gzQTTnKpy+OUE50w
         W2/F/QgcgbNMMD7+NgxirTgl+fUYSTDLYOTfe4n15mvQGDO74DugnPyA8IbShvQA288C
         XMKOULOMrkPWXj7IzlnAtIKz2+53emYOHVd2t84ejXSQsDiY5WEFMS3AuPTvpmGECLV7
         VZSLNQLKcvKQ6YNzXurOZ6SH9X+vOEvQjm6J9xUsALRHVK1FxeKhHTQQJn3v8+7+08+q
         BguBvMHJAahBSAfmvDYNzf4vUSxcTAs5MBX5PqhP9Y6Nk/XiXpjSjgheXDrk+Bug0v0j
         KIuA==
X-Gm-Message-State: AOAM5321yf0WXGdmpemoOa/lNgTa/XdoiiA4VEOFU1lrLSJc2cjgwSJl
        xHuMw3cQXK0r8IxKiHudg5cmzNaPktSRXg==
X-Google-Smtp-Source: ABdhPJwqDul16R0SGxuLvRvTNTWTVC6ID8Q1PttOEpLkwZoO1GMmg72s5GidGaNhmeeXtHJfwOqK4w==
X-Received: by 2002:a05:620a:64b:: with SMTP id a11mr2879559qka.313.1599851585385;
        Fri, 11 Sep 2020 12:13:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id m18sm3999377qkg.77.2020.09.11.12.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:13:04 -0700 (PDT)
Subject: Re: [PATCH 4/4] clone: allow configurable default for `-o`/`--origin`
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0739858e-83f1-3b3f-aba0-7549e7e47cfc@gmail.com>
Date:   Fri, 11 Sep 2020 15:13:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <5c519376c29a28bd89a712cf0b8125fc1c2c81be.1599848727.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2020 2:25 PM, Sean Barag via GitGitGadget wrote:

>  static char *option_origin = NULL;
> +static char *remote_name = "origin";

This patch could have used a prep patch that had all consumers
of option_origin use remote_name instead, with this adjustment
to the way to use option_origin:
  
> -	if (!option_origin)
> -		option_origin = "origin";
> +	if (option_origin)
> +		remote_name = option_origin;
> +	else
> +		remote_name = "origin";
  
Then this patch introducing the config option would have a
very limited change in the builtin consisting of these two
hunks:

>  static int git_clone_config(const char *k, const char *v, void *cb)
>  {
> +	if (!strcmp(k, "clone.defaultremotename") && !option_origin)
> +		remote_name = xstrdup(v);
>  	return git_default_config(k, v, cb);
>  }
...
>  	if (option_origin)
>  		remote_name = option_origin;
> -	else
> -		remote_name = "origin"

along with this translators comment note:

>  	if (!valid_fetch_refspec(resolved_refspec.buf))
> -		/* TRANSLATORS: %s will be the user-provided --origin / -o option */
> -		die(_("'%s' is not a valid origin name"), option_origin);
> +		/*
> +		 * TRANSLATORS: %s will be the user-provided --origin / -o option, or the value
> +		 * of clone.defaultremotename from the config.
> +		 */
> +		die(_("'%s' is not a valid origin name"), remote_name);


> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -43,13 +43,6 @@ test_expect_success 'disallows --bare with --separate-git-dir' '
>  
>  '
>  
> -test_expect_success 'uses "origin" for default remote name' '
> -
> -	git clone parent clone-default-origin &&
> -	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)
> -
> -'
> -

Interesting that you moved this test. Probably not necessary, and
just a mistake.

>  test_expect_success 'prefers --template config over normal config' '
>  
>  	template="$TRASH_DIRECTORY/template-with-config" &&
> @@ -71,6 +64,28 @@ test_expect_success 'prefers -c config over --template config' '
>  
>  '
>  
> +test_expect_success 'uses "origin" for default remote name' '
> +
> +	git clone parent clone-default-origin &&
> +	(cd clone-default-origin && git rev-parse --verify refs/remotes/origin/master)

I didn't notice it earlier, but perhaps this subshell should be split
into its own multi-line section as follows:

> +	(
> +		cd clone-default-origin &&
> +		git rev-parse --verify refs/remotes/origin/master
> +	)

But even better, this is only one line so using
"git -C clone-default-origin rev-parse" is simpler:


> +test_expect_success 'uses "origin" for default remote name' '
> +
> +	git clone parent clone-default-origin &&
> +	git -C clone-default-origin rev-parse --verify refs/remotes/origin/master
> +'

> +test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
> +
> +	test_config_global clone.defaultRemoteName from_config &&
> +	git clone parent clone-config-origin &&

This could be done using "git -c clone.defaultRemoteName=from_config" instead
of setting the global config.

> +	(cd clone-config-origin && git rev-parse --verify refs/remotes/from_config/master)
> +
> +'
> +
> +test_expect_success 'prefers --origin over -c config' '
> +
> +	git clone -c clone.defaultRemoteName=inline --origin from_option parent clone-o-and-inline-config &&

And you use the -c option here.

> +	(cd clone-o-and-inline-config && git rev-parse --verify refs/remotes/from_option/master)
> +
> +'
> +

We have the extra newline in these tests, too.

Thanks,
-Stolee

