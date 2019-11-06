Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EBF21F454
	for <e@80x24.org>; Wed,  6 Nov 2019 13:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbfKFNVw (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 08:21:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38257 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfKFNVw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 08:21:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id p20so15377929qtq.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 05:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TCwGbXVATU89qt3vwbRpHK/bKyQ4GySHcjRHUAaumAw=;
        b=g7tiDA7VfqH3LUP11c+bhccvpFHrezVhHYNLuAkGCXyb8+PsqBYwxkdwTBYREd7iK5
         8egPAHMWUA2vZBTqqWMXTs1GPwlczN/DKze3p+mPjBmhKZfni3Y3ew9fsz2UcCGhLbCd
         mMw/sCQau4xiYgpnH6f0DOu3cAuYweZsu9adLRU41LQ3sYQeFBugFNKwUWqlbH3rWB0W
         3dyF8T4yBLJdPF4yifWsPDDZgBJPyYvwOC4tzjX3h3ST+EFWt3Rvsf7ZMmgxwUGUICcz
         BiDRAvpEh8Hu/to0O8WZnhXh5N8bOlcxYgnP5XqR98MQkzVEhBJJFjPxhIe7dxhn+pxA
         dmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TCwGbXVATU89qt3vwbRpHK/bKyQ4GySHcjRHUAaumAw=;
        b=NZ25LroW34U6U6i9TqyoSOGu5Ey807AlGeNO7eS67cWK9JaEnRuGtLy+76Uz+SdJJb
         Nr6AK2IektvVf07F2Tk1d3rdsQphhsPn9wm8UEQCbWWOVNQvINIET6cyArPC5d5aoD/K
         0WiGdZmpIxfjhlvnfSf8RV0BWuAU2PGsfPSPYI+lb2UPYtpIDniU0421evxvmYEgReyt
         T5L/wV6qOv20FR/gnt4yhIkWFLpgKWFsz2+N0W9g9fPLSxQtV6QpQYRSwcb/Yis0k10G
         CA7VEQlVCcQEc8qapr/GlQi0W/H+mA5jNyngYoOZ9n5/o+R3vq+2iVbMEu4ZWaKADeli
         uTig==
X-Gm-Message-State: APjAAAU+7H5s0hv5VGsknHfVsIOdb8fcXHOzM089ezMM5nj7wTvkIa5R
        V/ATBPzksOkuSeMsiwGIRhw=
X-Google-Smtp-Source: APXvYqzaZGYeakc8GfP+pyvRkuA8b3P8a9iOBXiD3s7ZgdNysv1quuBPx7LRuZTrr3l47RH8cqvg3A==
X-Received: by 2002:ac8:2f55:: with SMTP id k21mr2379798qta.237.1573046509973;
        Wed, 06 Nov 2019 05:21:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d78:3a28:e2ab:8193? ([2001:4898:a800:1010:4eae:3a28:e2ab:8193])
        by smtp.gmail.com with ESMTPSA id z72sm11615171qka.115.2019.11.06.05.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 05:21:49 -0800 (PST)
Subject: Re: [PATCH v2 1/1] commit-graph: use start_delayed_progress()
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, rynus@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
 <pull.450.v2.git.1572984842.gitgitgadget@gmail.com>
 <78bd6bc2c02f1daf13938a738d8eae56b5f6b74c.1572984842.git.gitgitgadget@gmail.com>
 <20191106040955.GD4307@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <832b3b8b-63e6-1d32-0013-158b3c6725c8@gmail.com>
Date:   Wed, 6 Nov 2019 08:21:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191106040955.GD4307@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/2019 11:09 PM, Jeff King wrote:
> On Tue, Nov 05, 2019 at 08:14:02PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When writing a commit-graph, we show progress along several commit
>> walks. When we use start_delayed_progress(), the progress line will
>> only appear if that step takes a decent amount of time.
>>
>> However, one place was missed: computing generation numbers. This is
>> normally a very fast operation as all commits have been parsed in a
>> previous step. But, this is showing up for all users no matter how few
>> commits are being added.
> 
> Yep, makes sense (especially that it should all the other progress as
> part of the same process).
> 
>> Now that we changed this method, very fast commands show no progess at
>> all. This means we need to stop testing for seeing these progress lines
>> in the test suite.
> 
> I think this is OK for now, though it does make me wonder if
> "--progress" ought to perhaps override "delayed" in some instances,
> since it's a positive signal from the caller that they're interested in
> seeing progress.

I was thinking that we could start with a GIT_TEST_PROGRESS environment
variable to force all delayed progress to act like non-delayed progress.
That would at least give us confirmation on these kinds of tests.

The impact of doing that inside the progress code could be large, so
perhaps that is best left for a follow-up.

Thanks,
-Stolee
