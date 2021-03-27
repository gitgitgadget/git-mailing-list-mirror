Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4003DC433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 06:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B632619B4
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 06:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhC0GwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 02:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhC0GwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 02:52:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92FAC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 23:52:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x126so6314542pfc.13
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 23:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=83h22qL7Xf6BxRbRwQe+qbb3jnenYSld6QUbN9IsE1I=;
        b=UME0KYmCDDCVin+wW9FvGDdQhh1jsDF7dJGdYUwm1RkPEUu3gTrxHxhgy9vivWCb7n
         JGmawzM6s3ewj3yQ0BXDwD4L40J5xODOTWT8ckYpVr4kz9ciMRbXqr4UDtKe69PJ+QIC
         nB/Kt+/iqf979wZibYjXMGvdxQuI95qoA0Q/kUmiGkmB/VUiCvYEzkkgR9hOfEfAEq6n
         HfWcLh+eHzzA+qqSbh6dA62YnvUkPOXHmyeJWdF6nk+5GGJO1CMeP+JtpBokEYouXCSX
         q3U4pGIbPQBPLYE7LGxed8pXjZvUopjA8yGFCzbmvVeo7eHzJ5JvehgMy9fjxyiAO/1U
         hJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=83h22qL7Xf6BxRbRwQe+qbb3jnenYSld6QUbN9IsE1I=;
        b=Pu8JOukA2bRNLWhJl6Q8UsYeYyCZQptz0Q0FhJtWXZCKWRMd5JrsgG8rWi6XlRE3/j
         7KoAtjK+1asjqJqV+OO2fKreP5gZG0mnAqcNrwOXmRsyWwBHbqHlAI7OqtmJmHCaeDfP
         AiuWRmUQ/a7bNYf77Q8sox1lh1x3EM/Szld/fPNkXVISsC0er9EhcbBWSMLCIY+06cZ4
         pXHQ/SfYf8zI2GFtQAElsZ9rhYL8yoZY+yVjM1/58ef3esWmf+/l/GVpiuKKPFxyfTdd
         4xDLbqgeXXw2thikxFBfiZJlCUA6VUalPGG62JXLZfpJPShNfARJrQt1zrQVVQInfJHP
         nKfQ==
X-Gm-Message-State: AOAM532NnDT8lDPuaBVXTOs4x1YeOAtY/tQ1w4p+eTZu/n2NcV2dO3KV
        5jdGJC87ZkjtsOny2MW0Hnvl60OBXgidpA==
X-Google-Smtp-Source: ABdhPJwaa/f+s4BBgcwdtoXhwhn0ny9j/ZshstIFR3tj/1JBRaLWtyMD4stpxoMz/64yvrg8djTtTg==
X-Received: by 2002:a05:6a00:15c4:b029:204:33ea:ced0 with SMTP id o4-20020a056a0015c4b029020433eaced0mr16880765pfu.20.1616827924219;
        Fri, 26 Mar 2021 23:52:04 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id x125sm11280194pfd.124.2021.03.26.23.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 23:52:03 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ci: facilitate dev to mimic a CI environment
To:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, gitster@pobox.com, git@vger.kernel.org
References: <20210326170505.7771-1-stdedos+git@gmail.com>
 <20210326170505.7771-2-stdedos+git@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <5196a86c-1153-8998-a8cb-c8bd20687150@gmail.com>
Date:   Sat, 27 Mar 2021 13:52:01 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210326170505.7771-2-stdedos+git@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/03/21 00.05, Σταύρος Ντέντος wrote:
> diff --git a/Documentation/howto/setup-local-dev-environment-docker.sh b/Documentation/howto/setup-local-dev-environment-docker.sh
> new file mode 100644
> index 0000000000..265602ea55
> --- /dev/null
> +++ b/Documentation/howto/setup-local-dev-environment-docker.sh
> @@ -0,0 +1,43 @@
> +#!/bin/false
Wait, why did you make this documentation /bin/false script? I think
it is better to be in Asciidoc format (.txt)
> +# shellcheck shell=sh
> +
> +# Partially based on instructions from:
> +# ci/run-docker.sh
> +#
> +# Note: Alpine (and consequently the other variant ["non-32-bit"]) complains of:
> +# git-compat-util.h:  1139:	#error "Git requires REG_STARTEND support. Compile with NO_REGEX=NeedsStartEnd"
> +# and no
> +# ```bash
> +# export NO_REGEX=NeedsStartEnd
> +# /usr/src/git/ci/run-docker-build.sh 0
> +# ```
> +# helps
> +
> +docker run -itv "${PWD}:/usr/src/git" --entrypoint /bin/bash "daald/ubuntu32:xenial"
> +
> +# And then, inside, initialize with:
> +
> +export jobname=Linux32
> +
> +# Helpful initializations:
> +
> +cat >> ~/.gdbinit <<"EOF"
> +# https://stackoverflow.com/a/3176802/2309247
> +set history save on
> +set history size -1
> +set history filename ~/.gdb_history
> +EOF
> +chmod 600 ~/.gdbinit
> +
> +# cd to repo
> +
> +cd /usr/src/git/ || echo "cd error!"
> +
> +# In lieu of `$ make`:
> +ci/run-docker-build.sh 0
> +
> +# # And then run a test with:
> +# prove t/t6130-pathspec-noglob.sh
> +# t/t6130-pathspec-noglob.sh
> +# ci/run-docker-build.sh 0 && prove t/t6130-pathspec-noglob.sh
> diff --git a/ci/setup-local-dev-environment-docker.sh b/ci/setup-local-dev-environment-docker.sh
> new file mode 120000
> index 0000000000..1c4bcc90a9
> --- /dev/null
> +++ b/ci/setup-local-dev-environment-docker.sh
> @@ -0,0 +1 @@
> +../Documentation/howto/setup-local-dev-environment-docker.sh
> \ No newline at end of file
> --
> 2.31.0
> 

-- 
An old man doll... just what I always wanted! - Clara
