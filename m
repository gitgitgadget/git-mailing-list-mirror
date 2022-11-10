Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301ACC4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 18:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiKJSVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKJSUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 13:20:45 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B7D56542
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 10:20:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so2415010pji.0
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 10:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYLQpkytitq1O3vsCjqgkswKmY/buRg6G/EcUaCc2h8=;
        b=ifUzB4iBLVo6Z6WXiG05fYVTmesj9bWfbR4b/qCE6tyRbCdY4uFqgY0nBiKvn8vone
         kRuZCfON6CI3KSuxWXUqxZp0ZCUSaN7Yw2IiQArY9wHIXYqn1X25EmvfiNkGkRPx9Cei
         k4myJcWJgcNZWNyczONwFWDsICz4bVG14j8rUpI8VpUBIXpv/3yxwXpFDycooPeyGat+
         ZmBKjRtK6dVigvkX21j7e6xio9miPS5VOQgMcpr/6jknQu2aO5a6wNrxiissepzTJB+4
         KX4t2qtmVTEjocilxJVnwWNEInpiohQAUWw9vvsbuk90PuYnmpuOEkgiEJq2fH61Nc/8
         mdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYLQpkytitq1O3vsCjqgkswKmY/buRg6G/EcUaCc2h8=;
        b=H+DcSLd6CYMjG8Wp1b4C/dwi1YAl2qw3I/0b3lsOH+CK6/eRsmD8iIBkSiI8LDjWXE
         XhJVXj0Rb6QyOGkFCgjEZzLt/7uuofyAonqWpq29nBf8gozfi3QvCMNIwCHVCP0t/ZfI
         GXmmiNvOJ/ktTE/QLZU+PYR7dIZU1l9oKMYzO2AaHCsxuwcd0E00yT88PSraM+Z8ukRQ
         XLFEISCQpxE8OwyqgrRuMkDzOM+8z7rFT2fTl7k3zM26AEdyFp6kiBmUJet4Ssm4Jz8g
         IUAev58mXz/vx26TsV09Mo8O7qpOD4U97WNH7dAUfssYzDLXDiIdHAFy8mLNux4pAyyF
         m3CA==
X-Gm-Message-State: ACrzQf0NiAJqx2yMOWt2i0KDqTn/ABXuOaBCyZrnzhLZySAN4HGOPINj
        kDE3+E0RKfqNfKw4yYPAEJWWY2W95aDB
X-Google-Smtp-Source: AMsMyM7kMq4KXGYvPfAe/KDYSnsDLFT84d4JvbMF1YfQ/c4tLJmcEBj+cisNAVunTQn24iy7KroszA==
X-Received: by 2002:a17:902:bb98:b0:186:988d:a0f0 with SMTP id m24-20020a170902bb9800b00186988da0f0mr65084944pls.10.1668104399912;
        Thu, 10 Nov 2022 10:19:59 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902714a00b00178aaf6247bsm9984plm.21.2022.11.10.10.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 10:19:59 -0800 (PST)
Message-ID: <85230269-2473-2c6a-45a3-59b2b2ed4e3b@github.com>
Date:   Thu, 10 Nov 2022 10:19:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 5/5] rebase: use 'skip_cache_tree_update' option
To:     phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
 <fffe2fc17ed3beb05376f1377ea193199c13c657.1668045438.git.gitgitgadget@gmail.com>
 <44b0331a-17e5-1528-2249-e89f0bdd6ffb@dunelm.org.uk>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <44b0331a-17e5-1528-2249-e89f0bdd6ffb@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> Hi Victoria
> 
> On 10/11/2022 01:57, Victoria Dye via GitGitGadget wrote:
>> Signed-off-by: Victoria Dye <vdye@github.com>
>> ---
>>   reset.c     | 1 +
>>   sequencer.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/reset.c b/reset.c
>> index e3383a93343..5ded23611f3 100644
>> --- a/reset.c
>> +++ b/reset.c
>> @@ -128,6 +128,7 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
>>       unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
>>       unpack_tree_opts.update = 1;
>>       unpack_tree_opts.merge = 1;
>>       unpack_tree_opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
>> +     unpack_tree_opts.skip_cache_tree_update = 1;
> 
> I've added an extra context line above to show that we do either a one-way
> or two-way merge - is it safe to skip the cache_tree_update for the
> two-way merge? (I'm afraid I seem to have forgotten everything I learnt
> about prime_cache_tree() and cache_tree_update() when we discussed this
> optimization before).

Yes - 'prime_cache_tree()' is called immediately after 'unpack_trees()' in
both the one-way and two-way merge cases. Because 'prime_cache_tree()'
unconditionally clears the cache tree and rebuilds it from scratch,
repairing the cache tree with 'cache_tree_update()' at the end of
'unpack_trees()' is unnecessary.
