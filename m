Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA19C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 20:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiKJUyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiKJUyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 15:54:07 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44200252B0
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 12:54:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k7so2550833pll.6
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+TbxgGqsGYcjm5vWXorqdYrkIfYocQCFr9MXaVS4Is=;
        b=Ba4cVbWJSbzNUhUuxyzYZkfQnCKDmG2AKVU+BFIfuBcZDSx8mwJX9IM2Q+CBqvigH7
         p6n+4RLKuamWyNDw41YNxIUXGKU0kf9aldoDsz/RgwK5w9O3MjHKbBnh2gK6LDDuJjJV
         DDCMM3+j+cdyHQXGepD8kWcq4iQ60zw34KGPaztcu0nmukBws98sRJSM4jvGQqve+/UX
         UtZQ57lNvIhcSs6JnMz0chkBOXXiUGcr6lEZkZ0rs1+5TMUpQE5MlvTIHeiVMGxWW98C
         kRydYivoTpjHSoEK8JGK5sq6dnjhZX9pen5WS0m2RarV8kCLQUkHYlciG9Ao8cVe08Zw
         JTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+TbxgGqsGYcjm5vWXorqdYrkIfYocQCFr9MXaVS4Is=;
        b=ol7Lq+2m+wiSsxC0/WPK5VWtLbyEzvB73YZ1nyexiPVjhV4yM8u2fuFhjVW+3qxvc+
         86PUXD7fUi09+wS90N/WWgsMnwGONMa2HCFwI2oeynE+NlknZCmTZm9M+h3VbFg4oA+0
         QBLdYh12u70Z3LFE/oRj7o4uUvuCqzG2DP0xvyOjh/i201SGYzpq3ipjJ/aOL3oDg5dW
         KnRDowK9+Xm//WlJ2zgPKO7XoB/cnEjZjqi9dA64G1l6v9vZWZupoC5pXq1EjbGRJuZL
         tuSPFxmPIYYOzrPp71k7OnPd4JsGAD0o5e3vBTlIcAcV3Ftozf78opGRBMBHTkf5YJFO
         59PA==
X-Gm-Message-State: ACrzQf1gfx/Oq89MdbA9ybgyAd5psBxWDhkc8NUr+mzBrTKzgdYIgXZf
        p+y+8nb3rdYY3Qql2fBSMhTX
X-Google-Smtp-Source: AMsMyM7cZx56HKilT3W+VqxfJiT1qNvNd/5wZ+6r6sYMTF7zk4UEtNAywdUmblmRQdtqsdKIIzIIUA==
X-Received: by 2002:a17:902:da92:b0:186:827f:88f3 with SMTP id j18-20020a170902da9200b00186827f88f3mr2034682plx.75.1668113645614;
        Thu, 10 Nov 2022 12:54:05 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090a818600b00212daa6f41dsm236616pjn.28.2022.11.10.12.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 12:54:05 -0800 (PST)
Message-ID: <9c3b71d2-6481-e702-329c-33ee988dd7ce@github.com>
Date:   Thu, 10 Nov 2022 12:54:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/5] Skip 'cache_tree_update()' when
 'prime_cache_tree()' is called immediate after
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
 <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
 <20221110195029.GD1159673@szeder.dev>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20221110195029.GD1159673@szeder.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Thu, Nov 10, 2022 at 07:06:00PM +0000, Victoria Dye via GitGitGadget wrote:
>> Changes since V2
>> ================
>>
>>  * Cleaned up option handling & provided more informative error messages in
>>    'test-tool cache-tree'. The changes don't affect any behavior in the
>>    added tests & 'test-tool cache-tree' won't be used outside of
>>    development, but the improvements here will help future readers avoid
>>    propagating error-prone implementations.
>>    * Note that the suggestion to change the "unknown subcommand" error to a
>>      'usage()' error was not taken, as it would be somewhat cumbersome to
>>      use a formatted string with it.
> 
> I'm not sure I understand what's cumbersome.  It's as simple as:
> 
>    if (...) {
>        error(_("unknown subcommand: `%s'"), argv[0]);
>        usage_with_options(test_cache_tree_usage, options);
>    }

To be honest, the cumbersome approach I was thinking of was 'sprintf()'-ing
the subcommand into the string and calling 'usage()' with that - your
suggestion is certainly much simpler. However, as a matter of personal
preference, I still think the 'die()' is sufficient in the context of this
test helper (especially given that other test helpers do the same).

> 
>>      This is in line with other custom
>>      subcommand parsing in Git, such as in 'fsmonitor--daemon.c'.
> 
> The option parsing in 'fsmonitor--daemon.c' is broken, please don't
> consider it as an example to follow.

While I understand your desire to helpfully guide users, I don't see
anything to suggest that particular example is "broken." The error conveys
the cause of the problem to a user, who could then run without arguments (or
with -h) to see what the valid subcommands are. And, in the case of this
test helper, I'm not particularly concerned with perfecting the (already
subjective) user experience, given that it's an internal-only tool.

If there are examples of proper usage patterns that future commands should
follow, I'd recommend updating 'CodingGuidelines' and/or
'MyFirstContribution' to mention them. Codifying recommendations like that
can help avoid churn in reviews and, long-term, push Git to align on a
uniform style.

