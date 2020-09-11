Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994D8C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5F72244C
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llw747rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIKO5j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgIKO4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 10:56:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0423CC061757
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:31:02 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so4440323wme.5
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=06buklgB7jApEGJ8iBHzVyNBbafi8K6dZTQTaa1XW7I=;
        b=llw747rdLum+pFbcNU+7/H5F4pFZrzCioZqUBav7F4Qzo9c5fa+xCo3dBXily/E4rm
         NCvTbofTdpQLIdzzJyrlkHXLKu9+sYOYeJbZtEz8zdh2KvHLR4kbl+MTSAuiPe5ewlgG
         Ubr0z62mrfH6r//jL9L49gw1Dd9t4WN3ulk81M+BuY1gfle+lrWlIwe4FeVg6I37likx
         CpxP6vTlvR0y7I/qSDFKPTxZH7EWU/9+a88GTuKrmVtYi4v4N37ClU1sjKHZ8ncqptzC
         UQyOPWE4U+Ew1HiWlTzIE6EyabkwwKCK8kbBJKdoi0xK0YSYTYXMioMrcSXqtbJWjOeL
         DQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=06buklgB7jApEGJ8iBHzVyNBbafi8K6dZTQTaa1XW7I=;
        b=AaqtNrNCw6LwozP52kcsP9fnVn8ZxDk8XJ7VC9TxDfKJdv84dJfHuXNerieT9xO5FE
         UU3IcIIROGLMVulmsSW12apkZYfGW3Zn8MqeCI7Y10AoAYR+oL/WlhKhDx1p5wFKOVEn
         K6pAJ6A/H5bLVExo9cL4tdF7G/JChm6rYgxWKybqSKG5HRZS7dyuXqB7fbqDLsO+QhGb
         TR7Z/ERQJDmMx3tCxSxZe9+jQ88yNgeVbH3Pe0qNRgqMtgJ8X1yv9WX705ycsWapIGeK
         Q40V8Vb83DDO+45KqH91L/KBMtHaqoSkc9oTh62NHxw0EAqbLwzNyaa7BG+9CuLjqohj
         oCEg==
X-Gm-Message-State: AOAM533+UXHjWoAC63FMzM+1o9BK0MY+S2pRH2NJHm+rpDzzWxUxgdY5
        t9PZo8JUYuG9lFIyS3Uqc4bGb3TjrLA=
X-Google-Smtp-Source: ABdhPJzYibpvwOWsp2Ujq9AONYYQjcA+9DpCwZfvljoK+R4TTPbvmSNp63yFKriLyVH1Ji00q1KgNQ==
X-Received: by 2002:a1c:4381:: with SMTP id q123mr2196871wma.108.1599831060379;
        Fri, 11 Sep 2020 06:31:00 -0700 (PDT)
Received: from [192.168.1.201] (151.252.189.80.dyn.plus.net. [80.189.252.151])
        by smtp.googlemail.com with ESMTPSA id h8sm4541630wrw.68.2020.09.11.06.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:30:59 -0700 (PDT)
Subject: Re: [PATCH v4 6/9] hook: add 'run' subcommand
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-7-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <45208197-9e2d-6127-026f-b8ee5591677d@gmail.com>
Date:   Fri, 11 Sep 2020 14:30:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909004939.1942347-7-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 09/09/2020 01:49, Emily Shaffer wrote:
> In order to enable hooks to be run as an external process, by a
> standalone Git command, or by tools which wrap Git, provide an external
> means to run all configured hook commands for a given hook event.
> 
> For now, the hook commands will in config order, in series. As alternate
> ordering or parallelism is supported in the future, we should add knobs
> to use those to the command line as well.
> 
> As with the legacy hook implementation, all stdout generated by hook
> commands is redirected to stderr. Piping from stdin is not yet
> supported.
> 
> Legacy hooks (those present in $GITDIR/hooks) are run at the end of the
> execution list. For now, there is no way to disable them.
> 
> Users may wish to provide hook commands like 'git config
> hook.pre-commit.command "~/linter.sh --pre-commit"'. To enable this, the
> contents of the 'hook.*.command' and 'hookcmd.*.command' strings are
> first split by space or quotes into an argv_array, then expanded with
> 'expand_user_path()'.
> 
 > [...]
> diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
> index ebf8f38d68..ee8114250d 100755
> --- a/t/t1360-config-based-hooks.sh
> +++ b/t/t1360-config-based-hooks.sh
> @@ -84,4 +84,32 @@ test_expect_success 'git hook list --porcelain prints just the command' '
>   	test_cmp expected actual
>   '
>   
> +test_expect_success 'inline hook definitions execute oneliners' '
> +	test_config hook.pre-commit.command "echo \"Hello World\"" &&
> +
> +	echo "Hello World" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'inline hook definitions resolve paths' '
> +	cat >~/sample-hook.sh <<-EOF &&
> +	echo \"Sample Hook\"
> +	EOF

I think this could use `write_script`. I'm rather scared of the '~' in 
the script path, can we write it to the test directory please.

Best Wishes

Phillip

> +	test_when_finished "rm ~/sample-hook.sh" &&
> +
> +	chmod +x ~/sample-hook.sh &&
> +
> +	test_config hook.pre-commit.command "~/sample-hook.sh" &&
> +
> +	echo \"Sample Hook\" >expected &&
> +
> +	# hooks are run with stdout_to_stderr = 1
> +	git hook run pre-commit 2>actual &&
> +	test_cmp expected actual
> +'
> +
>   test_done
> 

