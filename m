Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E109C76196
	for <git@archiver.kernel.org>; Sun,  2 Apr 2023 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjDBKlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Apr 2023 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBKlO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2023 06:41:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A0A11EB4
        for <git@vger.kernel.org>; Sun,  2 Apr 2023 03:41:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v6-20020a05600c470600b003f034269c96so6183221wmo.4
        for <git@vger.kernel.org>; Sun, 02 Apr 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680432071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/vaz5mJ+8oIKXIkGFDeLVzD3Sa+ejishQh6kzfP0Xs=;
        b=IHTVZsy70EwWTTAQgOwpi+bxzti1y9BDJYODIhAQXuaFkSGpSI67OZov1U2ugBZ4l8
         8eWGbGrTHf8oReioIiDcy/gNy0aqZXgMRdTJNvv6+HLSsZHqXGxRDpiGZfjNX8+5gcS7
         LuQgnhJZL+P9rz0cy9DRpT42HaZtr0+ez7xaFesV9CuR5hr4bL+YheQZ8GtIqlaAK21M
         Y5q8WVwWij3OMCfcD8dnl0DZbP1nhNW6qIRSwoLsqiCcXsezjNDg7H9KeLOaenZNq1s2
         qfRypwV8GjAMBWPr78DYjpPJUo9tol+gt59AqmjC+slDG7XFmLe68xvcJ1GK+gsPFox5
         8kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680432071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/vaz5mJ+8oIKXIkGFDeLVzD3Sa+ejishQh6kzfP0Xs=;
        b=r1nvmhg4ow89pBwszXB4LfM6GISz5QV57xXzCf6nj1IYvS3ixOosRZMQHOyk8HxJr2
         ZKpcu5DquR6ZJezxWLcMzUmmPT4R4Qxyu3vyr/ENq3wF7KnkZxZBpCr7UhbQ+eY5crR8
         wuSvnn6anjlM+csMqeu2S9rlOMWrAsc3Js6vrH4OzM9w5Z4dsxoXm3UioN5aQFuWvonP
         uPLXvU/INsp2zetLooYbo91OrJb6yqC+H1RiTHVYaiJjSDAeq0Iq4CxP33a5QZkl0pBF
         Smjuflh3IMHLEpAgMDZZdsTfZaa64MEetlYddU+q2hshdRgrVtxNCzKn4Rp4Yu3Hlo9T
         fG0A==
X-Gm-Message-State: AO0yUKW7zWn4peBlfzdJ+A7GukEJfRr0eouZdJeAFBIAqWVsURCUB3ld
        vs1a4wugSa5FCFW4CZL9oAY=
X-Google-Smtp-Source: AK7set86EnR5iwLmmTYLx9oyAKNsaA/wLlwPwUuYNWcRZTbpYKxFrbYjrz+ny3jpgMs8bEzntXztmA==
X-Received: by 2002:a7b:ca59:0:b0:3eb:2da5:e19 with SMTP id m25-20020a7bca59000000b003eb2da50e19mr24872572wml.27.1680432071560;
        Sun, 02 Apr 2023 03:41:11 -0700 (PDT)
Received: from [10.23.18.56] ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b003eb2e33f327sm25463102wmo.2.2023.04.02.03.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 03:41:11 -0700 (PDT)
Message-ID: <96430edd-a4f8-1f3c-a1f2-860e0af5e4e7@gmail.com>
Date:   Sun, 2 Apr 2023 12:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [GSOC][PATCH v2] t3701: don't lose "git" exit codes in test
 scripts
Content-Language: en-US
To:     Edwin Fernando <edwinfernando734@gmail.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <20230326173147.39626-1-edwinfernando734@gmail.com>
 <20230401194756.5954-1-edwinfernando734@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <20230401194756.5954-1-edwinfernando734@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/04/2023 21:47, Edwin Fernando wrote:
> Exit codes were lost due to piping and command substitution:

s/were/are/

See section "[[present-tense]]" in Documentation/SubmittingPatches:

    The problem statement that describes the status quo is written in the
    present tense.  Write "The code does X when it is given input Y",
    instead of "The code used to do Y when given input X".  You do not
    have to say "Currently"---the status quo in the problem statement is
    about the code _without_ your change, by project convention.

> 
> - "git ... | <command>"
> - "<command> $(git ... )"
> 
> Fix these issues using the intermediate step of writing output to file.
> ---
> Changes in response to review:
> - addressed code style issues: ">diff" not  "> diff_file"
> - a more direct alternative to "test -z $(cat ...)"
> - commit message similar to previous commits accomplishing same goals
> - revert unnecessary change. keep "<var> = $(git ...)"
> 
>   t/t3701-add-interactive.sh | 31 +++++++++++++++----------------
>   1 file changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 80446b311d..77aad9032a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -292,10 +292,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "n\\ny\\n" | git add -p &&
> -	git show :file > show_file &&
> -	grep content show_file &&
> -	git diff file > diff_file &&
> -	grep "new mode" diff_file
> +	git show :file >show &&
> +	grep content show &&
> +	git diff file >diff &&
> +	grep "new mode" diff
>   '
>   
>   test_expect_success FILEMODE 'stage mode but not hunk' '
> @@ -303,10 +303,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "y\\nn\\n" | git add -p &&
> -	git diff --cached file > diff_file &&
> -	grep "new mode" diff_file &&
> -	git diff file > diff_file &&
> -	grep "+content" diff_file
> +	git diff --cached file >diff &&
> +	grep "new mode" diff &&
> +	git diff file >diff &&
> +	grep "+content" diff
>   '
>   
>   
> @@ -315,12 +315,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "y\\ny\\n" | git add -p &&
> -	git diff --cached file > diff_file &&
> -	grep "new mode" diff_file &&
> -	git diff --cached file diff_file &&
> -	grep "+content" diff_file &&
> -	git diff file > diff_file &&
> -	test -z $(cat diff_file)
> +	git diff --cached file >diff &&
> +	grep "new mode" diff &&
> +	grep "+content" diff &&
> +	git diff file >diff &&
> +	test_must_be_empty diff
>   '
>   
>   # end of tests disabled when filemode is not usable
> @@ -977,8 +976,8 @@ test_expect_success 'handle submodules' '
>   
>   	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
>   	git -C for-submodules ls-files --stage dirty-head >actual &&
> -	git -C for-submodules/dirty-head rev-parse HEAD > rev &&
> -	grep -f rev actual
> +	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
> +	grep "$rev" actual
>   '
>   
>   test_expect_success 'set up pathological context' '

It seems that you've created a second commit on top of the patch
you've originally sent and have only sent the second commit as "v2".
That is not what you want to show your reviewers, and more importantly,
that is not what we want to record in our history.

Instead, you should squash these two commits together and send it as
a single patch, as though the commit from v1 doesn't exist.
