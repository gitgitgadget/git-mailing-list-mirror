Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F8C43217
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbiK2BBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 20:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK2BA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 20:00:59 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC103E0A6
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:00:58 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k5so11174622pjo.5
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 17:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcqGPRzgeL/hpEi1YstIEBbhx0xh0wKwloepzxXYQoA=;
        b=DK9UaJlxHcelWxe9FjysAlUcW4+jyY0tjvm3Uao4c5ViiVcPcGRyMyEGUgqVoY4/5g
         pQYMD4eeHayELu3CQHB9d1uKPO1UTn8K0QxuXVSsuMYR7I+je4GTSQRtSRHReZwq/DQd
         kMU0ynKC9Xo4js7LVZiIYT86mRtZ0oAkIk0p+sbfUZ+pC7i7gBlfJtMAGjpEM6sYYtPG
         XsarT2BNVsyRBXDUrAKV7e2FRX+YN8p5LGvrm8AFiZ5OrrVkX7E9eD6XCtnlr5QxiTcf
         bZlP+CnOpRnfjSqqw14hy9MGhwl8um87cnE5nl8wLGZ7rTM8nPU625YrhylK6WkOMMOW
         oRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcqGPRzgeL/hpEi1YstIEBbhx0xh0wKwloepzxXYQoA=;
        b=YPfKYJHP892kWRbWpg9RIFZfXnfCNVgXPb8tHbyRWTvFBK7lmcY0/oZ3KZepHA8FR5
         TYGxGpf0+FzdV56Xpr8yIPLAewnYbhG0JalPFwllha9JLHclmdPnyq5SCXt/kune2sGT
         kjlanK6a+NRRjBtPLQWRpIKsCHw3c+DC3BZp2wNCudNrIKl8NfpdjZxxBxiXaov8Wcsw
         tfIlUvnYOGB7Ek+ICnr4BeB07uYD7BUI3PV07yrpm/kae3j6v88Bl1z8v9chrVtz/qxt
         BdJJ1DCRjraUM9LQTrUQTRigdQFVzdP79jd4VntkV1zmY0/BqddbOTm7Zo3tcYM41pLM
         caBQ==
X-Gm-Message-State: ANoB5plBARLGkqx8Av9fvWjPNkP4XUh0dPXwqUngnfLvToaco77yFrBF
        Al9qCHJAM7hQZ3yozrKLxc+QHLSNf2On
X-Google-Smtp-Source: AA0mqf4bS2aR+nq/9h0qG2UFIgfDVD9+4ZhZHSH0+q1Z7jpjB3JKfSkN+/rBouEOf1aE2UA0pFzOYw==
X-Received: by 2002:a17:90a:ca09:b0:213:53c:3b2a with SMTP id x9-20020a17090aca0900b00213053c3b2amr57184938pjt.113.1669683658490;
        Mon, 28 Nov 2022 17:00:58 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001869f2120a6sm9497452plg.108.2022.11.28.17.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 17:00:58 -0800 (PST)
Message-ID: <de6dc8f5-4750-db83-e58d-507aaa868ca4@github.com>
Date:   Mon, 28 Nov 2022 17:00:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/9] bundle-uri: serve bundle.* keys from config
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <cd906f6d9818a36cbdee896c1ede44d6de3f8990.1668628303.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cd906f6d9818a36cbdee896c1ede44d6de3f8990.1668628303.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> Implement the "bundle-uri" protocol v2 capability by populating the
> key=value packet lines from the local Git config. The list of bundles is
> provided from the keys beginning with "bundle.".
> 
> In the future, we may want to filter this list to be more specific to
> the exact known keys that the server intends to share, but for
> flexibility at the moment we will assume that the config values are
> well-formed.

This patch looks good - the implementation is pretty straightforward ("send
a config value if its key matches 'bundle.*'), and the tests cover both
single and multiple bundle URIs returned by the server.

> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c                          | 16 +++++++++++-
>  t/lib-t5730-protocol-v2-bundle-uri.sh | 35 +++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
> index c327544641b..000fcc5e20b 100644
> --- a/t/lib-t5730-protocol-v2-bundle-uri.sh
> +++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
> @@ -158,6 +158,8 @@ test_expect_success "ls-remote with $T5730_PROTOCOL:// using protocol v2" '
>  	[bundle]
>  		version = 1
>  		mode = all
> +	[bundle "only"]
> +		uri = $T5730_BUNDLE_URI_ESCAPED


Ah, okay, this explains why the 'bundle.only.uri' config was added to the
test in the last patch [1]. But, if the config is only being served in this
patch, shouldn't that test change be moved to this patch? 

[1] https://lore.kernel.org/git/c3269a24b5780023cbb4d173cb9cfb10c5a4b0d8.1668628303.git.gitgitgadget@gmail.com/

>  	EOF
>  	GIT_TRACE_PACKET="$PWD/log" \
>  	test-tool bundle-uri \
