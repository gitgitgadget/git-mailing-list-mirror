Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8535AC38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjARQU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjARQU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:20:27 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D472730B30
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:17:03 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so26969684ejb.9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RGi4KqX7fmXFY8BWOuMrccmzpwaFGx/OhDuSg6QQYw=;
        b=TEoFgvn28H5aG3h7JdjgBrmjieDEuOFFGE5OkTS95h1Ng7GNEdP6NHUrsd4TmSQPRX
         dlKV7PYoiFJ2dI90QUpv38969bWDEo8io6oIQO1m3S68rmz1UKIW46nmmgyTGhF1lOvb
         XafF+GirWQgJo6HZ+f5Y1w68fDUSp/uZ9iY56z+YtYwDyy3laRDKD1QB85tOVvmcmxnM
         9cArpUXaCsaCPXdi5ye/oz4L8QH42T7rYfsl8sLXmCxwDkOqgZUmmKOwU0YkRb0TOWTB
         BJqXrySdQSjxfN0Lr0uMUFI8+L5rfqVe0STU9dnf9ECRFQe76TnwCUMMie5dvIIEpnPL
         8D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RGi4KqX7fmXFY8BWOuMrccmzpwaFGx/OhDuSg6QQYw=;
        b=DvT9ryiK97uE0m/Chd5UwKftoQbUgRg0XfNvVTwsVepINfLTH+o3/rUAX3N4jWlJsY
         +mD/3d9BdpDczFUoboXGPvamY/TCnM4k6YaxehR1UYqowgFPhVdQZ5/JkK/73RFENY40
         yZ8UEF48utG6CCV2zYvTPDQ9vqXX2JqGp/MFzDr6bUx6X2t/Y8RIhZI2z1TR46+f9ACu
         Ght2qu4qzHJucxWy+v/h33c9RovlICmd8KMqoXbHSvDi/q67O5YkA2euXHx/lZPJhDAa
         QKwEFQXtO0iewRtm8qPK1AJZHwLB18TC9Dqi5xnH3gEJNMNnwGeIdWvSa+lLWH/yLw/G
         JHOQ==
X-Gm-Message-State: AFqh2koWyhws0iuUSOWTgdSKUC0S+EzgKk/vAgAMnrHzkg73sl+pU3PT
        49OOUQqDZ+mTH0/mjqL6Dto=
X-Google-Smtp-Source: AMrXdXv5845eZT/DTl8oE/RMr0K4KLUNxWnJxQkFcSudOC4TNd8LIpgNuVxdAQQ2XnD1xyuC5amtug==
X-Received: by 2002:a17:906:358f:b0:829:6064:bc52 with SMTP id o15-20020a170906358f00b008296064bc52mr7231616ejb.74.1674058622159;
        Wed, 18 Jan 2023 08:17:02 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b0084d4cb00f0csm12076292ejb.99.2023.01.18.08.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 08:17:01 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8a86074e-3f76-472c-15e2-9aa53762ef8f@dunelm.org.uk>
Date:   Wed, 18 Jan 2023 16:16:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [BUG?] 'git rebase --update-refs --whitespace=fix' incompatible,
 but not enforced
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <b322c536-5a75-bb0c-8eac-1a99d3ba3230@gmail.com>
 <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
In-Reply-To: <9445830b-d172-c3b6-ef60-ae4931cab84b@github.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 18/01/2023 15:51, Derrick Stolee wrote:
> On 1/17/2023 5:02 PM, Philippe Blain wrote:
> Subject: [PATCH] rebase: die for both --apply and --update-refs
> 
> The --apply backend is not compatible with the --update-refs option,
> which requires the interactive backend. Without any warning, users
> running 'git rebase --whitespace=fix' with --update-refs (or
> rebase.updateRefs=true in their config) will realize that their non-HEAD
> branches did not come along for the ride.

I think that for other options such as "--exec" that require the "merge" 
backend we call imply_merge() and then have some code that will error 
out if there are also options that require the "apply" backend. Is it 
possible to do that here?

> Fix this with a die() message in the presence of both options. Since we
> cannot distinguish between the --update-refs option and the config
> option at this point, do an extra check to see if --update-refs was
> implied by the config and present a helpful warning to use
> --no-update-refs.
> 
> It is possible that users might want to be able to use options such as
> --whitespace=fix with rebase.updateRefs=true in their config without
> explicitly adding --no-update-refs. However, it is probably safest to
> require them to explicitly opt-in to that behavior. Users with the
> config option likely expect that their refs will be automatically
> updated and this will help warn them that the action they are doing is
> likely destructive to their branch organization.

I agree that requiring an explicit --no-update-refs in that case is best.

Best Wishes

Phillip

> Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>   builtin/rebase.c              | 21 +++++++++++++++++++++
>   t/t3404-rebase-interactive.sh | 12 ++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 1481c5b6a5b..5330258c865 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1247,6 +1247,27 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		die(_("The --edit-todo action can only be used during "
>   		      "interactive rebase."));
>   
> +	/* Check for arguments that imply --apply before checking --apply itself. */
> +	if (options.update_refs) {
> +		const char *incompatible = NULL;
> +		if (options.git_am_opts.nr)
> +			incompatible = options.git_am_opts.v[0];
> +		else if (options.type == REBASE_APPLY)
> +			incompatible = "--apply";
> +
> +		if (incompatible) {
> +			int from_config = 0;
> +			if (!git_config_get_bool("rebase.updaterefs", &from_config) &&
> +			    from_config) {
> +				warning(_("you have 'rebase.updateRefs' enabled in your config, "
> +					  "but it is incompatible with one or more options;"));
> +				warning(_("run again with '--no-update-refs' to resolve the issue"));
> +			}
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--upate-refs", incompatible);
> +		}
> +	}
> +
>   	if (trace2_is_enabled()) {
>   		if (is_merge(&options))
>   			trace2_cmd_mode("interactive");
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 462cefd25df..8681c8a07f8 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2123,6 +2123,18 @@ test_expect_success '--update-refs: check failed ref update' '
>   	test_cmp expect err.trimmed
>   '
>   
> +test_expect_success '--apply options are incompatible with --update-refs' '
> +	for opt in "--whitespace=fix" "-C1" "--apply"
> +	do
> +		test_must_fail git rebase "$opt" --update-refs HEAD~1 2>err &&
> +		grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
> +
> +		test_must_fail git -c rebase.updateRefs=true rebase "$opt" HEAD~1 2>err &&
> +		grep "options '\''--upate-refs'\'' and '\''$opt'\'' cannot be used together" err &&
> +		grep "you have '\''rebase.updateRefs'\'' enabled" err || return 1
> +	done
> +'
> +
>   # This must be the last test in this file
>   test_expect_success '$EDITOR and friends are unchanged' '
>   	test_editor_unchanged
