Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E0C6FA82
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 09:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIYJLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Sep 2022 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIYJLA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 05:11:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EEB2CE2C
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 02:10:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so2140562wmq.1
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=r+2pDYpioLqKN0y350kb3u+AcrFZUqZw6UQ0L172L/I=;
        b=eYQOp7/SIfIyWM7DXSSjVgXf/2W2rWZEPBXbyccO04GhRQpoHpp6+uoo5fWVNCTg8z
         im6yx85LFpIHMy4Vq4UhuV2APimigBRdUn+wOXEMJoEdcrawCsektjCqoulSTJ/vBGrF
         r8lwhyrKrclgjFvyLs+SdK5Cwj9xYHWxUf1bpDLtPVIbVliiQRJb8mAyNad+ORgGYnK2
         ++LxC+CNdcmw1nj105Z466jf8BzB3uQ5/KF5Im0tWs3z9tR9nc/g8H2ZpR5kRHZGgWcv
         cDnoA+zw+r4+IEzIEZ+z4RXH5u64bcFx+wk0p9WMFZSdK9BvfTzirbmFAiZc944MDUvd
         KkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=r+2pDYpioLqKN0y350kb3u+AcrFZUqZw6UQ0L172L/I=;
        b=iThPV/6GB1Kkn1iPnw5ZhHwEBpbMFIANglKHNpf8iwjgr7nQRkmakLuhBsf1xFWhNe
         Tn3tGnVjOurQg29BSY1zcRVKWgxfF449iOxwnxJLbMgCk5soDXNzJvRwSlvn5Wj/luED
         X/SZ4Hj5FLvh381PyaK6sDCSGEB5swGjjcRHL8rfKXY7eJkTY0QAqfJCckU9qFmx1Qq+
         MeUB9ePR+LrjBZMKeGDzj2OXITVyLrho9rz1NsNGDygqsEYLh4CQ52o7ATaapaTok8G+
         xVsUtyvPycsdexT1hkZoATkeylpLVViSOwVfxlXotClTgyBwFriYWT4vHs5IhKflToKc
         182Q==
X-Gm-Message-State: ACrzQf1/V5aDgMzjJGS5kf3RAIRfJO4ibF1GxFJXrsAWsZzd2Icw3m64
        t1GQkA0ukFE94j5OTk7L/QyIV6XCR0R0Ug==
X-Google-Smtp-Source: AMsMyM5gKJB09bBafCvSrWyYRfWN4xyBgrI8VINlIK0KerTyu0p+m4sqWiOs9Uu5paWNv1uaIn1Qfg==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr11511176wmb.146.1664097057614;
        Sun, 25 Sep 2022 02:10:57 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b00228dbf15072sm11629997wrn.62.2022.09.25.02.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 02:10:57 -0700 (PDT)
Message-ID: <61a01fdf-9805-ff8d-6306-ff49f31e93c2@gmail.com>
Date:   Sun, 25 Sep 2022 10:10:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/10] evolve: implement the git change command
Content-Language: en-GB-large
To:     Stefan Xenos via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Christophe Poucet <christophe.poucet@gmail.com>,
        Stefan Xenos <sxenos@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <914028341842a4d57e02ec42a7426d3aa83640f9.1663959325.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 23/09/2022 19:55, Stefan Xenos via GitGitGadget wrote:
> From: Stefan Xenos <sxenos@google.com>
> 
> Implement the git change update command, which
> are sufficient for constructing change graphs.
> 
> For example, to create a new change (a stable name) that refers to HEAD:
> 
> git change update -c HEAD
> 
> To record a rebase or amend in the change graph:
> 
> git change update -c <new_commit> -r <old_commit>
> 
> To record a cherry-pick in the change graph:
> 
> git change update -c <new_commit> -o <original_commit>

While it is good to have this example it would be better to have some 
documentation about how to use this command. It would be very helpful to 
have the documentation added before the code so that reviewers have an 
overview of the command when they come to review the code.

The commit message should also discuss why it is called "change" rather 
than "evolve". For more details on commit messages for this project see 
"Describe your changes well" in Documentation/SubmittingPatches. Having 
some tests would make it clear how this command is intended to be used 
as well as demonstrating that the implementation works.

> Signed-off-by: Stefan Xenos <sxenos@google.com>
> Signed-off-by: Chris Poucet <poucet@google.com>
> ---

> +struct update_state {
> +	int options;
> +	const char* change;
> +	const char* content;
> +	struct string_list replace;
> +	struct string_list origin;
> +};
> +
> +static void init_update_state(struct update_state *state)
> +{
> +	memset(state, 0, sizeof(*state));
> +	state->content = "HEAD";
> +	string_list_init_nodup(&state->replace);
> +	string_list_init_nodup(&state->origin);
> +}

In general we prefer to use initializer macros over functions. So this 
would become

#define UPDATE_STATE_INIT {			\
	.content = "HEAD",			\
	.replace = STRING_LIST_INIT_NODUP,	\
	.origin = STRING_LIST_INIT_NODUP	\
}

and lower down we'd have

struct update_state state = UPDATE_STATE_INIT;

Likewise we prefer

	struct foo = { 0 };

over

	struct foo foo;
	memset(&foo, 0, sizeof(foo));

> +int cmd_change(int argc, const char **argv, const char *prefix)
> +{
> +	/* No options permitted before subcommand currently */
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +	int result = 1;
> +
> +	argc = parse_options(argc, argv, prefix, options, builtin_change_usage,
> +		PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	if (argc < 1)
> +		usage_with_options(builtin_change_usage, options);
> +	else if (!strcmp(argv[0], "update"))
> +		result = change_update(argc, argv, prefix);

Since Stefan wrote this code the parse options api has been improved to 
support sub commands so this should be updated to use that support.


Thanks again for picking up these patches, I'm excited to see an evolve 
command for git.

Best Wishes

Phillip
