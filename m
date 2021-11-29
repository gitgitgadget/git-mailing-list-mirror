Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D2C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 15:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348291AbhK2Ppb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 10:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbhK2Pna (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 10:43:30 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A6C0619DB
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:49:48 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id n66so34670208oia.9
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0v4XUUf/67LZZeGAJ1VaDFJZkY92Sj0WCTZt0nU+u78=;
        b=F4USYjCJMNwLpVLWgNRWL7A6/q5BW1/iFVWGIIlrJdoUQCMsCjgVCO5mH2CvZRdMLY
         Vfr4mChmrGzfdt6DoRfNuHW6HbhlfhQmhXN7o/m/4iKpXBA3P++wGcaGCYEAjRUqBQgc
         z0NcxVSyaDtIADSNURcVBqsC4XHSvwLIxDiF1WzihnDXwg8LOpk8/hbKa0efEA2VPtMl
         Yh6DPDR5cnWZXjLLsxbKmX8Z1Iy8TukNB1S6Y7y/kM9v0yigCbldWYv9K6Y5kTVquHlw
         Vpajjsmu7AYq/Y5WefLwWp0hpAuEV4utAcsbMfcAGmCI9MQAH9flyFn+6ZjhkwfJi15M
         o6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0v4XUUf/67LZZeGAJ1VaDFJZkY92Sj0WCTZt0nU+u78=;
        b=nyRizwO3+fGqzELBH6uXdiVJ7SEXpyYsvSpSQsDfmq2wLrFr8kgOynDBXCwSnV1EAd
         L7XPSKA+kC6bSCLVdRrK38J8LIqDuHTl0/AvsCH7+bGHeVgqB19dSpqK72E7b71GyZQC
         JxXvIFYOHAxoQ/oqydCola29pu7ibX9WeRFqqOLb9KULj9tIk8XWe/lBFhTsLCxMfLkv
         Np81WsBVXi3It7eNYh/bk7uGUIMufVG96PM4s2biiLaaMjy7BQTvFULA5tt2tpIzD5O5
         moAMNSyQNZ1IrSBnUYmggvAW8rsZJ/FC9DtN8ot7rqrb9Lo0klZpdjcOKuK+wyM6dfMF
         gGow==
X-Gm-Message-State: AOAM531ZovtqaPgZ0NUWKnY/1mRMuXBrK1BrJ3TqbScfTUPPk5JldIoC
        iwLRB8nuLehwe14qZR3lZOU=
X-Google-Smtp-Source: ABdhPJxEzhCFNNXyxkOtDOeKP/8/VPXiwjEVFcXLFhyvS1p463kKB7R6Af1Q3Yt6eSv4eu2uelm74g==
X-Received: by 2002:a05:6808:1509:: with SMTP id u9mr39762653oiw.4.1638193787282;
        Mon, 29 Nov 2021 05:49:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:3085:654c:eb81:848b? ([2600:1700:e72:80a0:3085:654c:eb81:848b])
        by smtp.gmail.com with ESMTPSA id r37sm2685330otv.54.2021.11.29.05.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 05:49:46 -0800 (PST)
Message-ID: <d41a9117-ee7c-d708-39f8-03e05a863dab@gmail.com>
Date:   Mon, 29 Nov 2021 08:49:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: t4216-log-bloom.sh fails with -v (but not --verbose-log)
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Git ML <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com>
 <211125.86pmqoifp8.gmgdl@evledraar.gmail.com>
 <YaBdxL3QH1/GrWY1@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YaBdxL3QH1/GrWY1@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25/2021 11:08 PM, Jeff King wrote:
> On Thu, Nov 25, 2021 at 01:14:45PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
>> I haven't looked much into $subject, but there's an interesting
>> regression in 2ca245f8be5 (csum-file.h: increase hashfile buffer size,
>> 2021-05-18) where it fails with -v, but not --verbose-log. Discovered
>> while running it manually.
>>
>> This is a regression in v2.33.0 (not v2.34.0!), so nothing urgent, and
>> this is pretty obscure anyway.
>>
>> For the original change see:
>> https://lore.kernel.org/git/64ffddd791160895b8e6730ebcddfac8458653f2.1621362768.git.gitgitgadget@gmail.com/
> 
> Interesting. This patch makes it go away (the "5" is cargo-culted from
> earlier in the script):
...
>  		# Commit has 7 file and 4 directory adds
>  		GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS=10 \
> +			GIT_TRACE2_EVENT_NESTING=5 \
>  			GIT_TRACE2_EVENT="$(pwd)/trace" \
>  			git commit-graph write --reachable --changed-paths &&
>  		test_max_changed_paths 10 trace &&
...
> The commit in question (2ca245f8be) puts the writing into a new trace2
> region ("chunkfile"), so it makes sense that the nesting increases by
> one. But what's interesting is that the nesting is different depending
> on whether stderr is a terminal. I guess because the progress code
> starts its own region.
> 
> The default nesting max for trace2 is 2. That seems kind of low given
> this example, but I don't know enough about the tradeoffs to say what
> bad things might happen if it's raised. But the above patch really seems
> like a hack, and that this quiet omission would absolutely confuse real
> users who are trying to use trace2 for debugging.

Thanks, both, for identifying the problem and the root cause. I have
sent a patch series [1] that sets a deeper GIT_TRACE2_EVENT_NESTING
across the test suite to avoid this kind of issue in the future (along
with removing the existing uses scattered across the tests).

Thanks,
-Stolee

[1] https://lore.kernel.org/git/pull.1085.git.1638193666.gitgitgadget@gmail.com/
