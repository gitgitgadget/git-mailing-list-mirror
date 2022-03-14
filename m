Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D641C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 15:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbiCNPLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242377AbiCNPLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 11:11:16 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AEF434B9
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:10:06 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so20567569oof.12
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VeZhzmfspJbPNWwRF4h7ydUb5Jz/qj0lS5Tnz6zD5bo=;
        b=Ng6x8+t0TmdZ9NR8FCG7Oa9anj4lc4ZU4vppWiFPe1HbrbdbjH4KWhXbxhcQcNPE/v
         GLLnxcNRMAu6zlf4OncGHyaCoUO9m1VafIoLJ8iiN0xlSHl/QcI04C2j5F877jFeTOBW
         HDD5tpyoRCldaJc8hbw9S44aXoOyq2xr30ueh51rMQPuxp8SUdecsOrSCbpJdacOo90U
         rAgFxRnKDI5gWbIqM+1BD1wpBRp4/YGPgbJS4yVeRj+Nwn99c8MhY9PERrDxsoL8cWF3
         lxoOyTrk4EfWmBkMpDwivGkGPqjFTJmQtjUlL/cNnaz98QkvT2jJvXql7Htd6Zl7D9fH
         2H5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VeZhzmfspJbPNWwRF4h7ydUb5Jz/qj0lS5Tnz6zD5bo=;
        b=mdSW8/acH4Z5Wdl+8soTqImbRdArPEbeELcj3tte/HtVQB8+9m6aw8pqEZbVJ44zEj
         s7uS4FR95hP23rzKE04+ECIjdugCbwGQis/iGgMrWw/0wCY/BKA9iZ7G4uBUaTfHu0uA
         SobkePonds4nJJSLCuHCsqYOqR6dquLOsGu7GUBf6a+OSqHM9ugKgTTquo/af+xIx680
         HLgB0diIYQkgJYG7b50gHlftNHkXVC/MgwbNg01tjJCI+T5jV/8HVTlku/ZXQIqSy3iz
         5WLDT+2oKhNbIJVG3BJniiZvPxXtCzJGvT216/jbowXL/nO6e/2NwubYC8KNDo+c8eHM
         p9NA==
X-Gm-Message-State: AOAM530XosFkNO4bpdLWTUqXMrWCBE+skzTOMF+LuU2hybzaa/KrfiKb
        c/l8LvfqHwI29lkh7/dBxIon
X-Google-Smtp-Source: ABdhPJxrXG+o60oZ6VlSa+BgCA5yl906oYgZmNCdH2I65pbb466ZU0rN/CraUU82FIl3+WzJPYUHwA==
X-Received: by 2002:a05:6871:69f:b0:da:294e:2de4 with SMTP id l31-20020a056871069f00b000da294e2de4mr17219503oao.123.1647270605393;
        Mon, 14 Mar 2022 08:10:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c30-20020a056830349e00b005b272587f47sm7320223otu.38.2022.03.14.08.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:10:02 -0700 (PDT)
Message-ID: <41db12c3-029f-2e44-703c-90cb45ed9875@github.com>
Date:   Mon, 14 Mar 2022 11:10:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/5] stash: make internal resets quiet and refresh index
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
 <052499bbc93cb6a60a3b7f7861de78dd4075fd7f.1647043729.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <052499bbc93cb6a60a3b7f7861de78dd4075fd7f.1647043729.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2022 7:08 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Add the options '-q' and '--refresh' to the 'git reset' executed in
> 'reset_head()', and '--refresh' to the 'git reset -q' executed in
> 'do_push_stash(...)'.

> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 5e68180f3b2..f2076545133 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -482,7 +482,7 @@ test_index_refreshed () {
>  	git rm --cached file2 &&
>  
>  	# Step 2
> -	git reset $1 --mixed HEAD &&
> +	git reset $@ --mixed HEAD &&

I see you change this from "$1" to "$@", which won't help with
the "-c key=value" issues from earlier.

>  
>  	# Step 3
>  	git read-tree -m HEAD~1
> @@ -491,48 +491,66 @@ test_index_refreshed () {
>  test_expect_success '--mixed refreshes the index' '
>  	# Verify default behavior (with no config settings or command line
>  	# options)
> -	test_index_refreshed &&
> +	test_index_refreshed

Ah, I see you fixed this here, probably just a rebase issue, then.

>  test_expect_success '--mixed --[no-]quiet sets default refresh behavior' '
>  	# Verify that --[no-]quiet and `reset.quiet` (without --[no-]refresh)
>  	# determine refresh behavior
>  
> -	# Config setting
> -	test_must_fail test_index_refreshed -c reset.quiet=true &&
> -	test_index_refreshed -c reset.quiet=true &&
> -

Ah, and the -c changes are removed here. You could still test them
using the trick I mention in reply to patch 2.

>  	# Command line option
> -	test_must_fail test_index_refreshed --quiet &&
> +	! test_index_refreshed --quiet &&
>  	test_index_refreshed --no-quiet &&
>  
> -	# Command line option overrides config setting
> -	test_must_fail test_index_refreshed -c reset.quiet=false --quiet &&
> -	test_index_refreshed -c reset.refresh=true --no-quiet
> +	# Config: reset.quiet=false
> +	test_config reset.quiet false &&
> +	(
> +		test_index_refreshed &&
> +		! test_index_refreshed --quiet
> +	) &&
> +
> +	# Config: reset.quiet=true
> +	test_config reset.quiet true &&
> +	(
> +		! test_index_refreshed &&
> +		test_index_refreshed --no-quiet
> +	)

I'm not sure why you need sub-shells here. The test_config is
not scoped to the shell. These lines could be avoided with the
-c trick, which should make it a bit simpler to show what you
intend to be testing here.

Thanks,
-Stolee
