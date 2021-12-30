Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4B2C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 13:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbhL3Nn0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 08:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhL3NnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 08:43:24 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706FAC061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 05:43:24 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id j3-20020a056830014300b0058f4f1ef3c2so28423981otp.13
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 05:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PQYLZA5mkAL5y8ZRU+c5YiSVGgUcw2c1tgHkO5hYQEo=;
        b=OtFADLrgP/rIOswF2/2sFhBywZ39bJx4J31yF/NpVn9JNhQOw7TQ+P/CGWzOdTkvtJ
         hHR3k21XnhVJBAfZtTvYHhQ3PQtIUivK463gXAOvmG7vdq1dbj224t9oMq19o/GVk9R8
         KS0KaKYuP9INOIgYu3Ea43cW+C+4Ppe7sX52pT+5BMHKLl5zcM0kR4/Zm61FN3jzEhJr
         8CRzW4ykSgDIEnlMnsmTkThtB8Ku47ITw8As+wnuqK5zAy/ia/YVCWCdjKNz/s1nkSHq
         L8BGLy9A4ZcEZ4aXHGNnRogaXx+ylquzUC2T9IvLRgzw4qtancrMAPv9Gdh2eURUlHL9
         ltzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PQYLZA5mkAL5y8ZRU+c5YiSVGgUcw2c1tgHkO5hYQEo=;
        b=uVL0jJOb3au1MVfRYoanTkCPCL2tGiZ6q9ZYHv0Dz7EIDA1z+7orBgU/jKAGGlN6Xa
         ffb99v2cnVN2JGLmYzOFI71enY0Jxl73YJ9dEmTlvWZ/ipTZzGJy1I/2SFTofVhDOpI6
         yPskhq2WyD3hoLvCmhX23sJYwjRUQX/j6+j0OZBwOYMzmYDCB87pTQDI2oHA9t1a8EsH
         t5X0LDLz8C4Jb9lP6uquPxT6oHMbOHbWx6yr9dwWusFG5koiWekkDgwuew5GfAlhjeuD
         /jniqdxvCG/lPTZZJ1FiKrGmYLU7QgW8TnzWVCv+uSn7f4Vtb6CBv5zVeK2jFqJffnsI
         r0ww==
X-Gm-Message-State: AOAM533TYT0KTwBLYWrVGpd6v5u/lOlF1uVOGwzZXMkhJLqkpBpy60yP
        X5uVIEYSvNxjCA0d/6n1JsVpWzb0OP4=
X-Google-Smtp-Source: ABdhPJzyPTIfXEU7ydpG2sI7dQqlqNY4w7gAt/8diEUqtk/P2SsPtSEHmcSHoI0WYKOIGzAEQrr5Ag==
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr19984358otp.271.1640871803677;
        Thu, 30 Dec 2021 05:43:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:cd5c:4260:de91:c496? ([2600:1700:e72:80a0:cd5c:4260:de91:c496])
        by smtp.gmail.com with ESMTPSA id p19sm4069277otp.5.2021.12.30.05.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 05:43:23 -0800 (PST)
Message-ID: <cd190111-1930-9538-a844-4d9aa08d98b0@gmail.com>
Date:   Thu, 30 Dec 2021 08:43:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] sparse-checkout: custom tab completion tests
Content-Language: en-US
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
 <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a7f3ae5cddaed61a618a5fa2f9d9c888e0dd7d99.1640824351.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29/2021 7:32 PM, Lessley Dennington via GitGitGadget wrote:
> From: Lessley Dennington <lessleydennington@gmail.com>
> 
> Add tests for missing/incorrect components of custom tab completion for the
> sparse-checkout command. These tests specifically highlight the following:
> 
> 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
> (it is missing reapply and add).
> 2. git sparse-checkout --<TAB> does not complete the help option.
> 3. Options for subcommands are not tab-completable.
> 4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
> both file names and directory names.

Thanks for these. I've never looked at this test script before, but
I can surmise how it works from your tests.
 
> Although these tests currently fail, they will succeed with the
> sparse-checkout modifications in git-completion.bash in the next commit in
> this series.

> +test_expect_failure 'sparse-checkout completes subcommand options' '
> +	test_completion "git sparse-checkout init --" <<-\EOF &&
> +	--cone Z
> +	--sparse-index Z
> +	--no-sparse-index Z
> +	EOF
> +
> +	test_completion "git sparse-checkout set --" <<-\EOF &&
> +	--stdin Z

In en/sparse-checkout-set, the 'set' subcommand learns the options
for init, including --cone, --sparse-index, and --no-sparse-index.
I think technically, --no-cone is in there, too.

Further, the 'reapply' subcommand learns these options in that
series and I see you do not include that subcommand in this test.

You might want to rebase onto en/sparse-checkout-set and adjust
these tests for the new options (plus change the next patch that
implements the completion).

> +	EOF
> +
> +	test_completion "git sparse-checkout add --" <<-\EOF
> +	--stdin Z
> +	EOF
> +'

> +test_expect_failure 'sparse-checkout completes directory names' '
> +	# set up sparse-checkout repo
> +	git init sparse-checkout &&
> +	(
> +		cd sparse-checkout &&
> +		mkdir -p folder1/0/1 folder2/0 folder3 &&
> +		touch folder1/0/1/t.txt &&
> +		touch folder2/0/t.txt &&
> +		touch folder3/t.txt &&
> +		git add . &&
> +		git commit -am "Initial commit"
> +	) &&
> +
> +	# initialize sparse-checkout definitions
> +	git -C sparse-checkout config index.sparse false &&

I'm guessing that the implementation actually requires this, but
I'll take a look in the next patch. It might just be slow to expand
the full list of directories in the sparse index case.

> +	git -C sparse-checkout sparse-checkout init --cone &&
> +	git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
> +
> +	# test tab completion
> +	(
> +		cd sparse-checkout &&
> +		test_completion "git sparse-checkout set f" <<-\EOF
> +		folder1 Z
> +		folder1/0 Z
> +		folder1/0/1 Z
> +		folder2 Z
> +		folder2/0 Z
> +		folder3 Z

This tab-completion doing a full directory walk seems like it could
be expensive for a large repository, but I suppose it is the only way
to allow the following sequence:

	fol<tab> -> folder
	folder1/<tab> -> folder1/0
	folder1/0/<tab> -> folder1/0/1

(Hopefully that makes sense.)

It would be more efficient to only go one level deep at a time, but
that might not be possible with the tab completion mechanisms.

> +		EOF
> +	) &&
> +
> +	(
> +		cd sparse-checkout/folder1 &&
> +		test_completion "git sparse-checkout add " <<-\EOF
> +		./ Z
> +		0 Z
> +		0/1 Z
> +		EOF
I do like seeing this test within a directory. Thanks!

-Stolee
