Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BB2C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 23:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356091AbiBCX7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 18:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356086AbiBCX7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 18:59:35 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D4C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 15:59:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id e28so3598898pfj.5
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nkviCYo/xwgEoMc8NpXXM8nbCC5MEdVkqeGZ+cmJ5cM=;
        b=UnbJugv2h2fnoBbfhsv3DlsdZcAKwMlkEwLcXC2GGkaA8f7eYWdc1wD1PoA2G6986F
         Ji3kJeZTKY5UboPLWZmb0NA2Fs/9ZpSR+/oPkl6wnRtvYYASNxY9PAJJqkP93cO9qpg3
         9HFq72nQw1k09pq+UkRJz81wc8PH5f+G1AeIyjMej6+eyajJC8UR17bb4Z9YdyQvu8j2
         4dm8thfaTGwOn/uFApaCUz+9GMwbDc1A1+onEuhH/ktSGC3lNVoIXUpO6WPUsp+UnzTS
         Wq2QRGY5PVssJgkLvkuH87ZNUtgyZqdWpltfPLZ/+7mJ6NE1BHupkAiDveBIfZOo1RV+
         2SXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nkviCYo/xwgEoMc8NpXXM8nbCC5MEdVkqeGZ+cmJ5cM=;
        b=iwgepE41odndXhkqcWfigGzfg2S2ntbPgz4jWe9d0jQ2dSB+b7N336Sz8S2GgEE0Q0
         0OijVux8k4LONDcuvTr9jLWgGcoAB4SMWHTTTsp2LvGBnNd8GZxIxIIn5bVrpKKD6gnN
         b2poUxeXudlYX+lRo8mzpizHwJJoaSDwh2TLAf9sozK/lD1n22H/IAydQQPmrS0t461O
         gxPAz8XcMAnqoFv+PzA3DysTnk7byxT8doto/HamWD2TmRe4cvDt6UVsawnhP9hV7Mhk
         bIPBvX46HJCxeNceoKbC1AvI7vTCh3S309FuNQYm7Geif1GsgNc7xeg80jfQaloID/Vk
         JAtw==
X-Gm-Message-State: AOAM532tzCR9iFEozJTxbTGYIKJztpMfzDG+WQV7cNFrIJFMkUS4XOX1
        2wjFfmv9yw5fcjOVklg/h2k=
X-Google-Smtp-Source: ABdhPJzhsZjDrzj7kJD4Yg24S6XLNtpMpAcz9sDm+FuWUFd906QnxTT3gdKVMCzRcTbmyuT3JykzVA==
X-Received: by 2002:a05:6a00:2451:: with SMTP id d17mr547702pfj.70.1643932774651;
        Thu, 03 Feb 2022 15:59:34 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:51c6:c5ef:caca:5a98? ([2601:602:9e81:12c0:51c6:c5ef:caca:5a98])
        by smtp.gmail.com with ESMTPSA id c11sm120631pgl.92.2022.02.03.15.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 15:59:34 -0800 (PST)
Message-ID: <eb442213-d369-fdcd-c3a3-05239bccb5bf@gmail.com>
Date:   Thu, 3 Feb 2022 15:59:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v5 0/3] completion: sparse-checkout updates
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
 <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
 <xmqqo83nr59i.fsf@gitster.g> <7033ab1b-7d90-d83c-fc65-33801c6348cc@gmail.com>
 <xmqqy22rpm10.fsf@gitster.g>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <xmqqy22rpm10.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/3/22 3:28 PM, Junio C Hamano wrote:
> Lessley Dennington <lessleydennington@gmail.com> writes:
> 
>> On 2/3/22 1:48 PM, Junio C Hamano wrote:
>>> "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
>>> writes:
>>>
>>>> This series is based on en/sparse-checkout-set.
>>> This has been a very helpful note, but after the topic was merged to
>>> 'master' on Jan 3rd, it has become a tad stale.  Let me apply the
>>> topic directly on v2.35.0 instead.
>>> Thanks.
>>
>> Thank you for the heads up! I will remove from future versions.
> 
> No problem.
> 
> FWIW, the tip of 'seen' seems to be failing the CI; I haven't looked
> into the cause of the breakage.
> 
>    https://github.com/git/git/actions/runs/1792151138
> 
> There is another CI job running on 'seen', whose only difference from
> the above version is that this topic has been temporarily ejected:
> 
>    https://github.com/git/git/actions/runs/1792296432
> 
> We'll see if that fails the same way (in which this topic may not
> have anything to do with the breakage) or if it passes.
> 
> Thanks.

I just merged seen locally and was able to repro the failure. I will
submit a fix ASAP.
