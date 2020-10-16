Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB1EC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E8720866
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO0ahCEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408432AbgJPNxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408423AbgJPNxB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 09:53:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE433C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:53:00 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l4so2449436ota.7
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9aoFep+fkfu3Qf/YtYWcSvTAb6BPjk+DHStle+pePIs=;
        b=hO0ahCEZD7z36ynHMRjW0Zknf6yUlCxBgg825ede0XI4eaXOGYt2QGMy1NdB2jEjO/
         Yw3+qwttEyEsCmsfFs+wRNDUBqyiJssrBkm31QRMJFt0ZU9fOH+nphI4V0tdCNLDy8Mm
         2Z8rlCSnzBu5t5iSV6DUkcTogBxuqJM7dqffjD0nSwEcXGNJuwGgDDUwLo/wJq10phxH
         7eFZ3YzOtc9l3E5JbDjiniwE6KTpopNDFIv3q0VRG4SY/6xGl+3JDIo89v9tdWExE0ba
         SfT5VBp3kxbrvZ3EGA9RiD0eFAt++Uw5F+5mxJWVxt8W6XarhW95JGACl2w4zW+TX2cP
         OPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9aoFep+fkfu3Qf/YtYWcSvTAb6BPjk+DHStle+pePIs=;
        b=aQzSA7j6w+5hCh7kU9/ubsbGv2DTup/uC4jOIOD4ZPSt2C5yB2NvVfDVDRvXdvGoBU
         wPfpvEpdjMRA46E0QGLe1p3V0TBCLhAk6AeVibxY40QfjPPzSHuXc+8U/sQXI6IXP5Lg
         /QcJODcb6SuK25Yuqt4LWh2TE55IyZLRIsB8r7sscHvEiEC3l08h4/9m96Nqr08v7bEY
         Yz5xZjfD8zv06rgVeOTEm7SFf5hapisYX0sB21m5uvuH3Vk0qO/3cdLtaoJsN6aEvHaj
         qBiqx1m1MHS+elo/gY0eVOCxNG12vkjFsa9TzbQcKBSXxB5CphiOsYjbxJiBFIvAoPcd
         Ejhw==
X-Gm-Message-State: AOAM5305mUJ5Wq9rNeKQQHeFZpCXxmaIzD9hAO5nX2zL9sZEGW7kZeGS
        vF1gvMD16mibwrOPwg4txoMydS7fgW4WDQ==
X-Google-Smtp-Source: ABdhPJyKE58DhFM9unZUgLlBvLmaa8tkv1medQhJIUxvn2LeGUZQvUOrggAlHx/2TlSkR2TViw+ypg==
X-Received: by 2002:a05:6830:30a8:: with SMTP id g8mr2716527ots.370.1602856379792;
        Fri, 16 Oct 2020 06:52:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:45e2:f3c8:7158:823d? ([2600:1700:e72:80a0:45e2:f3c8:7158:823d])
        by smtp.gmail.com with UTF8SMTPSA id y13sm1036142ote.45.2020.10.16.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 06:52:58 -0700 (PDT)
Subject: Re: [PATCH v4 04/10] commit-graph: persist existence of changed-paths
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, l.s.r@web.de,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.659.v3.git.1593174636.gitgitgadget@gmail.com>
 <pull.659.v4.git.1593610050.gitgitgadget@gmail.com>
 <f1e3a8516ebd58b283166a5374843f5cb3332d08.1593610050.git.gitgitgadget@gmail.com>
 <20201015132147.GB24954@szeder.dev> <20201015214111.GA2176154@nand.local>
 <103404f0-a164-2550-4730-6b8773d3ca1f@gmail.com>
 <20201016031844.GA2181783@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6fe5de28-01f3-fc48-6bc3-aec0777ad889@gmail.com>
Date:   Fri, 16 Oct 2020 09:52:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201016031844.GA2181783@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/15/2020 11:18 PM, Taylor Blau wrote:
> On Thu, Oct 15, 2020 at 10:18:47PM -0400, Derrick Stolee wrote:
>> On 10/15/2020 5:41 PM, Taylor Blau wrote:
>>> So, we need to be more aggressively checking the Bloom filter settings
>>> in any layer we want to reuse a Bloom filter out of before reusing it
>>> verbatim in the current layer. The patch below the scissors line is
>>> sufficient to do that, and it causes the third test to start passing.
>>
>> I think there are three things we should keep in mind:
>>
>> 1. Incompatible Bloom filter settings between layers should be seen
>>    as _inconsistent data_ as Git should not be writing incremental
>>    commit-graph files with inconsistent Bloom filter settings. Thus,
>>    when reading the commit-graph chain we should prevent incompatible
>>    filters from being used. One way to do this is to notice different
>>    settings and completely disable Bloom filters. The other way would
>>    be to take the settings from the first layer with filters and then
>>    clear the chunk_bloom_indexes and chunk_bloom_data fields for the
>>    layers that don't agree. This fits with an expectation that lower
>>    layers are larger, so more filters can be used in that situation.
> 
> Sure; I'd be fine with only allowing filters computed with the settings
> present in the lowest or largest layer in the event that multiple layers
> exist with incompatible settings.
> 
> I'm trying to point us towards a direction of not optimizing too far
> along a direction that we're unlikely to take, while also trying to do
> something relatively non-invasive to make it possible for a version of
> Git to change the default Bloom settings. That is, if a user is writing
> split commit-graphs, and we change the default Bloom settings, they
> shouldn't have to recompute or merge down all of their Bloom filters.

They would need to recompute when they merge layers, which introduces
a big question about how we should handle such a case.

> If that's something that we never think is going to happen, I'm fine
> with not thinking too hard about it. But, I also don't want to paint
> ourselves into a corner, so I think something like the patch I wrote in
> the email that you're replying to actually may be worth pursuing
> further. I dunno. Definitely after 2.29, though.

I think the proposed "react properly to this unlikely situation"
is a good way to prevent getting locked into our choices now. It
makes it possible for "old" Git versions (2.30 until we decide to
allow this mix) to interact with the inconsistent settings without
failure.

We don't need to do the 100% "optimal" case of using all filters
in order to enable this choice in the future.
 
[...]

> For what it's worth, I was mainly talking about it to say that it would
> be more effort than it's probably worth to do. There's also nothing that
> we're currently discussing that would prevent us from taking that same
> direction up in six months from now.

Yes, I just want to make sure that everyone agrees there is a
middle ground without saying that inconsistent filter settings
across layers is a "fully supported" feature. If someone wants
to tackle the work to make it a desirable state, then they can
try that (with great care).

Thanks,
-Stolee
