Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E48C3A5A7
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 16:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLHQaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLHQaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 11:30:08 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674ABE23
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 08:30:07 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u10so1285427qvp.4
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 08:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/zT2XE9TZvNBJObzf6bUtJAEJuzIra27Cv34SAADGC8=;
        b=V6RPTsf/NKaN8rqIhKKNKOQ2FqqjBZK6ZMsKgY1lm/48SL8osctq1P1m0bK75jNrq4
         on6BiwL4Vk1VpL8+1OQctg6NvSl9yg4tyCROzvEZVzvDywpOCy2sixAALpOYtB34H1q2
         mr4/zb7LgCW1Dmc0dv5dsvV523JN8Xttii+n2y95faDqEnvs7crNfGYpnLPusxfCd3sY
         +TT1bMYWUfoJ0FFC3vNmIyg7dmN2M6nIk58jcaOiqwZmb7L+WFNylVGQP9sqf5wX4TAB
         VhSyxpnP7/0BKuxpNZiNzp3zVbWs+RS0WffmiqpIq8EFuR32bom8uwPDVwYLxElxmVsX
         3yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/zT2XE9TZvNBJObzf6bUtJAEJuzIra27Cv34SAADGC8=;
        b=SXuy+rYXS2TQg+4sBV8+YMX3p2lVqrDcOFlj/2u3oKbmsOvDwmRBHRPO1gKTEhtFe8
         gbRYn6gQAqXwo2HtqkgNvnPXL4T8QQKXSDEHKZAu2IYnLCdkU3/tuRSabQMqo8/oSAR+
         HRsvRlH+GTQCmVilF32PIlXdf4fFMl9y+7RUS0Qjvjom45pgEx9RtBQ0q8xcJSp7350D
         hHdDx67b7tDQ9x4mnFlbuRofus3kb1aXCmMas3F9WzFHDkcQUmjXvqf/woqQE6OnKxfr
         ibA+fijKZBzVvt7hcAWFI8HrdG2zdBn/5a+Wu5++gv0L29M2NaZUyDu2RHwmYAIZrax+
         Cd7g==
X-Gm-Message-State: ANoB5pkoT834KBpX0nW3174T76EUR1+K0U+tCM/whbfdOA9HTxB4Yyzx
        IoOTEeXi/u2FrXq5t/A25CaK
X-Google-Smtp-Source: AA0mqf4Pak6QUJKK5/yr9xfOTxPx5sSFt0wDyFSVQnYmJvh7XGIMQwI1x+reQmwQ4QEA28/xbbyNbQ==
X-Received: by 2002:a05:6214:451d:b0:4c7:121:d684 with SMTP id oo29-20020a056214451d00b004c70121d684mr4475846qvb.7.1670517006143;
        Thu, 08 Dec 2022 08:30:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c5e5:e5dd:715:ac2e? ([2600:1700:e72:80a0:c5e5:e5dd:715:ac2e])
        by smtp.gmail.com with ESMTPSA id az33-20020a05620a172100b006feea093006sm3251107qkb.124.2022.12.08.08.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:30:05 -0800 (PST)
Message-ID: <95e92f84-5f83-6439-0d02-f8060669a4d3@github.com>
Date:   Thu, 8 Dec 2022 11:30:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] scalar: use verbose mode in clone
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 1:10 PM, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Sometimes when users use scalar to download a monorepo
> with a long commit history, they want to check the
> progress bar to know how long they still need to wait
> during the fetch process, but scalar suppresses this
> output by default.

I think this is an accurate description of the status quo.
 
> So add `[--verbose| -v]` to scalar clone, to enable
> fetch's output.

However, this isn't the only thing we could consider doing.

For instance, we typically use isatty(2) to detect if
stderr is a terminal to determine if we should carry
through progress indicators. It seems that maybe run_git()
is not passing through stderr and thus diminishing the
progress indicators to the fetch subprocess. It's worth
looking into to see if there's a different approach that
would get the same goal without needing a new option. It
could also make your proposed '--verbose' to be implied
by isatty(2).

If being verbose becomes the implied default with isatty(2),
then it might be better to add a --quiet option instead, to
opt-out of the progress.

Also, I'm not sure your implementation is doing the right
thing.

> -	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
> +	if ((res = run_git("fetch", "origin",
> +			   verbosity ? NULL : "--quiet",
> +			   NULL))) {
>  		warning(_("partial clone failed; attempting full clone"));
>  
>  		if (set_config("remote.origin.promisor") ||
> @@ -508,7 +511,9 @@ static int cmd_clone(int argc, const char **argv)
>  			goto cleanup;
>  		}
>  
> -		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
> +		if ((res = run_git("fetch", "origin",
> +				   verbosity ? NULL : "--quiet",
> +				   NULL)))

Specifically, here the "verbosity" being on does not change
the way we are calling 'git fetch', so I do not expect the
behavior to change with this calling pattern.

You might want to add the "--progress" option in the verbose
case.

As Taylor mentioned, a test might be helpful. Here's an
example from t7700-repack.sh that sets up the isatty(2)
configuration correctly, as well as sets the progress
delay to 0 to be sure some progress indicators are written:

test_expect_success TTY '--quiet disables progress' '
	test_terminal env GIT_PROGRESS_DELAY=0 \
		git -C midx repack -ad --quiet --write-midx 2>stderr &&
	test_must_be_empty stderr
'

Thanks,
-Stolee
