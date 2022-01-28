Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D8C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 19:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiA1Tkn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 14:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiA1Tkn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 14:40:43 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF7BC061714
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:40:42 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q5so6549536qkc.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 11:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HDv3kx+1kGlpI0brWVsMgt4od/sF4UTtRL/bo6spJWk=;
        b=k7RQAPAeMSthLIS+5C0cF9QEtnwse8j9+6kbwRbONzgtv+EzcgkgR8caJ5FCDOjcv1
         fIDjqwPvNkh0k0iZhqY1vHVOhmYIjPz96jD1aGUKIkdQXhvDam/CKGIuNw9iOt7AGoaF
         xSFypdxYNiQjvvv+iev2P/WW2mKNvwHnnAyD99TjZBfqX2LHAsgf0Gq4WnXHcjaQW4kU
         zDm5fEadd2cWGHIRaulmR06lmopg3qaj4ky1C5ng9iBERIQKTFLzXF5XDWqFQRK8NH+t
         eAUrNtoV/DkN5h4p6fQo0P/dps2hFHWo/zf68iOV8A9dE8Rn3PlGRvEiUpBSrMO41Nfi
         ypuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HDv3kx+1kGlpI0brWVsMgt4od/sF4UTtRL/bo6spJWk=;
        b=Uht3LqxP5RgAvSoY9XNWJuHT9KIonZumhViF2IkmeMedpzMPTDf88IlBmxHnmlBmCF
         1t9dbNoYwaET+EENGTEhWgOvyYisFVY/k3dO48wV7dGU96ibIETyyIu8CpDMDEG/fz4c
         MhT1FjmMSQDT4jq2cW4k+hYj037R/WHrPSS1AZnLzSzQlh1vfk3ODKDMCBbAvMejzxch
         JghiNzfic7qGQEV5/vO+uCgSrg+z9uIES9VV+mhoeEnC1IQcVhuVAFhwbQE3qBC7KW/V
         GHgOqh9pT2Cn9eB2q2zcVkKwhV1t9IJPu4ucQ0xL1CIW+vTbrDqREkeVEqqxbw6o0ms1
         S9wg==
X-Gm-Message-State: AOAM5334s+KSvpfPcUdItECmtf/JeZJf5hQ8kcxEwmUbARU65zD+30rC
        bjGEK6qzHJ/KvsNdfzLXd3zED5bwO2w=
X-Google-Smtp-Source: ABdhPJylU1LTHiOU7GGifR6CpxsX3L7/FfFCi+mSUMhK3ay9R2jNBJEpo99Au0WMPW47C4Ac4In3eA==
X-Received: by 2002:a37:61d8:: with SMTP id v207mr6982804qkb.776.1643398841914;
        Fri, 28 Jan 2022 11:40:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67? ([2600:1700:e72:80a0:5cd8:5d5f:ba81:6c67])
        by smtp.gmail.com with ESMTPSA id a128sm3517896qkf.1.2022.01.28.11.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 11:40:41 -0800 (PST)
Message-ID: <aad60461-be96-5122-ec50-abe0955e61d8@gmail.com>
Date:   Fri, 28 Jan 2022 14:40:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] scalar: accept -C and -c options before the subcommand
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1130.git.1643195729608.gitgitgadget@gmail.com>
 <pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1130.v2.git.1643380317358.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2022 9:31 AM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The `git` executable has these two very useful options:
> 
> -C <directory>:
> 	switch to the specified directory before performing any actions
> 
> -c <key>=<value>:
> 	temporarily configure this setting for the duration of the
> 	specified scalar subcommand
> 
> With this commit, we teach the `scalar` executable the same trick.
> 
> Note: It might look like a good idea to try to reuse the
> `handle_options()` function in `git.c` instead of replicating only the
> `-c`/`-C` part. However, that function is not only not in `libgit.a`, it
> is also intricately entangled with the rest of the code in `git.c` that
> is necessary e.g. to handle `--paginate`. Besides, no other option
> handled by that `handle_options()` function is relevant to Scalar,
> therefore the cost of refactoring vastly would outweigh the benefit.

Based on discussions elsewhere in this thread, I have changed my mind
and agree that this approach is the best one to take at the moment.

With this additional context and the new tests, I think this patch is
ready to go.

Thanks,
-Stolee
