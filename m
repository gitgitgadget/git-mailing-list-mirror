Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D0EC7619A
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCZUPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 16:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjCZUPD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 16:15:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56AA1B1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 13:15:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b20so27853615edd.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679861700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDKbrYnmBsva76lL6saN+eAyrQgWmswX31WVDZ2dWq8=;
        b=P8bZMmpMwBJJNu+yaDeJE8zFf9hj3gvxrQb5goUhWu+Ecw/forwNM5MzHtO4OxU8i0
         4KOkwGlvZL5MSTCDI/lOMj/gaUKX1WsDjIFFLGsIyyKe1QJ7Z6Mb+73fzX1ej65caCxl
         v0u2pXNzhIWtab8B7EhOl9ZXCyKrT3FfDHFx3ZvxRtaZuADijLc3BfZdCEP1S6NINkTo
         xWKjBtSIQZY4YBBxfJbVIVo0wTgTJ7VT2lagDVx+FTp7Udh98WTH5lm4OBX1ciWCMMS2
         cB9GC/0G6CMzyFB1RpjLHGoBEEg415fJwkuQumZb4M1tH6VUuaGCSp2fCusvbnh2PJW0
         6VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679861700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDKbrYnmBsva76lL6saN+eAyrQgWmswX31WVDZ2dWq8=;
        b=afhENEKVIjCwK5uOKmJQP4Xtj+ZeSPKeoD/VZA2iyj3wHG/qA+xdwPWWO0PKawKZZ7
         57un1kBevg9xZ94lD0/FkyrUfemzjEVELcBjrvtp/lupgUDgfShCMKVXLlx/N1anm/AZ
         8VSw3zRFJSKTtOReX0iglrhO7Gl2YC6L5mMFUnocm3CLaPO2c7NvwqG1n5aOxaFL2opo
         t8aAc4bmD8cL9MbC4xeKiW2EgUcOZK4K+GrnKHGKMtm3bXLyGpOlvcqC/6Ij/h97u1bN
         FCkOMBIQaunZyEj29ybrY3ks3ZaGR9ZaS7yxDhRyCLq0ad4ie5Vctc0980yF/wAIVx8H
         20WQ==
X-Gm-Message-State: AO0yUKVlHwFIxZJe6Cvrctv/jXehatrsuGI63yKV0GtBTnB4pNnxUg12
        7AM0cqLf2j/sbQqL/WfISb8AlGIFR/Q=
X-Google-Smtp-Source: AK7set8qapjVFobPZ+a4WrlJFDEAanhUODm/o0kL0FVpbZADx96YY6IYl/RSDS4yTwkJPUPFtKEbNQ==
X-Received: by 2002:a17:906:57cb:b0:929:e5a8:63f7 with SMTP id u11-20020a17090657cb00b00929e5a863f7mr15873768ejr.28.1679861700232;
        Sun, 26 Mar 2023 13:15:00 -0700 (PDT)
Received: from [10.10.18.214] ([212.102.57.11])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906289700b00922547486f9sm13536149ejd.146.2023.03.26.13.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 13:14:59 -0700 (PDT)
Message-ID: <be2f23ec-4b3c-eb9f-fc2d-fecdf76604e1@gmail.com>
Date:   Sun, 26 Mar 2023 22:14:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GSOC][PATCH 1/1] t3701: Avoid suppression of exit status of git
To:     Edwin Fernando <edwinfernando734@gmail.com>
Cc:     vdye@github.org, git@vger.kernel.org
References: <20230326173147.39626-1-edwinfernando734@gmail.com>
 <20230326173147.39626-2-edwinfernando734@gmail.com>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <20230326173147.39626-2-edwinfernando734@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, Edwin.

In subject line "t3701: Avoid suppression of exit status of git" -- the first
word after a colon shouldn't be capitalized.  By the way, similar existing
commits call it:

   don't lose "git" exit codes

and

   preserve "git" exit codes

On 26/03/2023 19:31, Edwin Fernando wrote:
> Pipes and command substitution in bash suppress the exit codes of the

Bash is not the only Shell used for running Git's test suite, so referring
to it like this in the commit message might not be a good idea.

See also similar commit 9fdc79ecba ("tests: don't lose misc "git" exit codes",
2023-02-06) for inspiration in writing the commit message.

> first executed command. In the test scripts errors when running git
> should be exposed. Remove all such suppressions of git by writing
> output to files, chaining commands with &&, or other means.
> 
> Signed-off-by: Edwin Fernando <edwinfernando734@gmail.com>
> ---
>   t/t3701-add-interactive.sh | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 3a99837d9b..80446b311d 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -292,8 +292,10 @@ test_expect_success FILEMODE 'patch does not affect mode' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "n\\ny\\n" | git add -p &&
> -	git show :file | grep content &&
> -	git diff file | grep "new mode"
> +	git show :file > show_file &&

Code style here and in all output redirections below: lose the space between
redirection and the path, like so:

   git show :file >show_file

Also, the suffix "_file" is unnecessary.  Just

   git show :file >show

or

   git show :file >out

or

   git show :file >actual

might be better.

> +	grep content show_file &&
> +	git diff file > diff_file &&
> +	grep "new mode" diff_file
>   '
>   
>   test_expect_success FILEMODE 'stage mode but not hunk' '
> @@ -301,8 +303,10 @@ test_expect_success FILEMODE 'stage mode but not hunk' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "y\\nn\\n" | git add -p &&
> -	git diff --cached file | grep "new mode" &&
> -	git diff          file | grep "+content"
> +	git diff --cached file > diff_file &&
> +	grep "new mode" diff_file &&
> +	git diff file > diff_file &&
> +	grep "+content" diff_file
>   '
>   
>   
> @@ -311,9 +315,12 @@ test_expect_success FILEMODE 'stage mode and hunk' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "y\\ny\\n" | git add -p &&
> -	git diff --cached file | grep "new mode" &&
> -	git diff --cached file | grep "+content" &&
> -	test -z "$(git diff file)"
> +	git diff --cached file > diff_file &&
> +	grep "new mode" diff_file &&
> +	git diff --cached file diff_file &&
> +	grep "+content" diff_file &&
> +	git diff file > diff_file &&
> +	test -z $(cat diff_file)

Function test_stdout_line_count can be used here instead of "test -z".
test_stdout_line_count would produce a more helpful error message in
case of test failure.

>   '
>   
>   # end of tests disabled when filemode is not usable
> @@ -970,8 +977,8 @@ test_expect_success 'handle submodules' '
>   
>   	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
>   	git -C for-submodules ls-files --stage dirty-head >actual &&
> -	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
> -	grep "$rev" actual
> +	git -C for-submodules/dirty-head rev-parse HEAD > rev &&
> +	grep -f rev actual
>   '
>   
>   test_expect_success 'set up pathological context' '

