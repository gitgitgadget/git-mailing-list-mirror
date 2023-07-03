Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE031EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 15:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjGCPr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCPr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 11:47:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E319C2
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 08:47:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51d89664272so5389959a12.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2023 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688399275; x=1690991275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ycLalNEZy+7gTQznnQqiqh3NViAb9Y8HPrIG5ntpB0E=;
        b=dTnpyRPH+QrBsflTAyMnKq1+G0tSE8annD82XUF4gQGd12vUlXfsw9XVVyn3DM6+Jx
         u1g5JKVZLba0PccRG3yJNvqcOq/D55Ol9ZHWyayvh9VqVphJNzke2AqGfFKlJlM3XQGg
         1OK861Il9uM5M9w+aYtjiP2Koe9SIk7E7FmzZpgpOFNjB4/MiD4sOjlBrZy8mQ2dhgvU
         MhJS8xOPVmiEIdzPhaCknGH4Mn4Q2t0c/8DAMiiRuFcywHZOaszAlPi91N+TrqqG+Gb3
         OYRgMJjfBRclq9XP+Zxx6rnWxeGlyTFDZLodMAx8kKmXlOPiBrfTmQBwL91+CQAXWxGQ
         fLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688399275; x=1690991275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ycLalNEZy+7gTQznnQqiqh3NViAb9Y8HPrIG5ntpB0E=;
        b=bfDCdS7Qtdkk1hrmzWGs2EDUcWZheFEb5Ut7cmPUoY23fGFYA9naLvFKbEEVCDgF4u
         hWnvnLhB9Qda4NuZxulLcRP6BJ2gUzfWgby5j81BnCpA4wI9oEyntwX5TIihyqlfotoZ
         9sI88Xhh0yOw3OMPf4HH0rRfc6dkvbuG4P7yGU1VphyYuEgTD418owF9kU+hyxUH2i4j
         4gkP+GPlOEqqYoXmV9nbCVZQAwKX6nnEawXtnnnPc7tWBP32yMiUUvhc3OsZGYaRYtsZ
         cqF8cOF3e+tWgNd2nzfRdgYxbl6jc4aIxjS79vtaFDsBrDmaXfcETEFm6wEKL3IRuB/C
         v9mQ==
X-Gm-Message-State: ABy/qLafyPNO0nOE2CcDf2r1VWhv/V3+g7H7pWMpf8xeTqiIIXPXdh6v
        48DWiuJoQ77zFFXl7hAE5oI=
X-Google-Smtp-Source: APBJJlHaO7LObMNVI37bgptB1ikxIbojMsPGMlQR7POM3EmciC48NmcZaNqCc5yOeuSZCz/bIq7eMQ==
X-Received: by 2002:a05:6402:1607:b0:51e:1690:1b97 with SMTP id f7-20020a056402160700b0051e16901b97mr1362710edv.19.1688399274572;
        Mon, 03 Jul 2023 08:47:54 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id j18-20020a50ed12000000b0051dada80305sm7077937eds.63.2023.07.03.08.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 08:47:54 -0700 (PDT)
Message-ID: <2f516828-deee-5c78-a08d-7a64e457f91a@gmail.com>
Date:   Mon, 3 Jul 2023 16:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] t0091-bugreport.sh: actually verify some content of
 report
Content-Language: en-US
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <YHYZTLl90rkWWVOr@google.com>
 <20230701192642.647167-1-martin.agren@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230701192642.647167-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin

On 01/07/2023 20:26, Martin Ågren wrote:
> In the first test in this script, 'creates a report with content in the
> right places', we generate a report and pipe it into our helper
> `check_all_headers_populated()`. The idea of the helper is to find all
> lines that look like headers ("[Some Header Here]") and to check that
> the next line is non-empty. This is supposed to catch erroneous outputs
> such as the following:
> 
>    [A Header]
>    something
>    more here
> 
>    [Another Header]
> 
>    [Too Early Header]
>    contents
> 
> However, we provide the lines of the bug report as filenames to grep,
> meaning we mostly end up spewing errors:
> 
>    grep: : No such file or directory
>    grep: [System Info]: No such file or directory
>    grep: git version:: No such file or directory
>    grep: git version 2.41.0.2.gfb7d80edca: No such file or directory
> 
> This doesn't disturb the test, which tugs along and reports success, not
> really having verified the contents of the report at all.

Thanks for the clear description of the problem and for fixing it

> Note that after 788a776069 ("bugreport: collect list of populated
> hooks", 2020-05-07), the bug report, which is created in our hook-less
> test repo, contains an empty section with the enabled hooks. Thus, even
> the intention of our helper is a bit misguided: there is nothing
> inherently wrong with having an empty section in the bug report.
> 
> Let's instead split this test into three: first verify that we generate
> a report at all, then check that the introductory blurb looks the way it
> should, then verify that the "[System Info]" seems to contain the right
> things. (The "[Enabled Hooks]" section is tested later in the script.)

That sounds like a good plan

> +test_expect_success 'report contains wanted template (before first section)' '
> +	awk "/^\[/ { exit } { print }" git-bugreport-format.txt >actual &&

Personally I'd find

	sed -n -e '/^\[/q;p' git-bugreport-format.txt >actual

easier to understand but that's probably because I don't use awk very 
much. I'm not sure it is worth a re-roll though as I see we do use awk 
in a few of the other test scripts.

Best Wishes

Phillip
