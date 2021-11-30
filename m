Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D4C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 15:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhK3Ph1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhK3Ph0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 10:37:26 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F265C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 07:34:07 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id bj13so41986987oib.4
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 07:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=suevOa5l+2o1trjZO5a8+JNtfhbgFgi7cooF3L8uDS8=;
        b=JxgROlD+JaWRVXPyiL97Lumj4vQWKh+jhTss7wMyupBiU7F5QU+p5jFQ+dJyKqlYrh
         R2Ydb3REzifq+grFGsejJmaGKyMtfHLTr4r7qUCqsD1/RBh/8agn3W0TXDq/FC5DmiCt
         UkpeK7Vvh8ivco+Dv3kg+BCDW1r6abcWCf401wZ9tTv1czkxb1zxQ5GPSo6ChqZ5Wn4K
         8RW+cE+lSGjzZHjlaPhOFNlYuri2e7L3tZFVYE/9/IiUNVpIVRhM/sC6WDBixV4d7EMV
         JUNdJnqbhzzBfg2lBXsrhHyKs0UAZMcpXZaY25G9JNv8CccYjKjFHB8xg6+9EHXYtIbT
         FbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=suevOa5l+2o1trjZO5a8+JNtfhbgFgi7cooF3L8uDS8=;
        b=1SusjSHcey2WVjOHjsC/frnKxFZ26SkVYSP53Qd9SKtqz4YOhJ9/E/D55bIDHTAsCT
         LeeVq19hsSKn/aofKs7sDUCKMcV/i3wtDLv3X8wjg5HsguO9NGgw7xHdtCO/V1Xoichj
         kStJBHUSdw5RxPryeTHdVyDSjtSwjWcqR/cOOImRru8/FIzkzeX7ZGJcS6QALkRX8iHC
         Cyo4Zow47zPNQP0QSGOnEUG/mrScomXTNeKtHlHMzvYodYE2QPQKEZeWG7SVwJ8ZVCKb
         QphrmD9kfTBi6zN1azdCH7yPuWR8iANmu9PvT+1LXVRhUC8lcbuqJqLeKymCSxjyb56x
         2ZwQ==
X-Gm-Message-State: AOAM53078K/XRdXLpGxYafFeJi2cQamTJXIL0ax7ZQ+5vzHuR8Kh+y6O
        6Cr7941c/rtzOqrFiXXC8Fw=
X-Google-Smtp-Source: ABdhPJzPfgihbwDEWw4pHE+a2os653fDvsFsmaAuvRREbfix9WXuTKhkCoYzB1U1FjEeKSOeOHFl6A==
X-Received: by 2002:a05:6808:228c:: with SMTP id bo12mr95156oib.93.1638286446384;
        Tue, 30 Nov 2021 07:34:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:ecc1:c98a:cda5:6f9d? ([2600:1700:e72:80a0:ecc1:c98a:cda5:6f9d])
        by smtp.gmail.com with ESMTPSA id u28sm3161480otj.57.2021.11.30.07.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 07:34:05 -0800 (PST)
Message-ID: <86555f24-e7c4-64cb-a55c-7e2580e895f2@gmail.com>
Date:   Tue, 30 Nov 2021 10:34:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] Set GIT_TRACE2_EVENT_NESTING in test-lib.sh
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <git@jeffhostetler.com>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 1:40 PM, Jeff King wrote:
> On Mon, Nov 29, 2021 at 01:47:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
>> As reported by Ævar [1] and diagnosed by Peff in a reply, the default
>> GIT_TRACE2_EVENT_NESTING is set so low that tests that look for trace2
>> events can start failing due to an added trace2 region. This can even be
>> subtle, including the fact that the progress API adds trace2 regions when in
>> use (which can depend on the verbose output of a test script).
> 
> I think this is a good change for fixing the immediate problem of the
> test suite failing.
> 
> But I have to wonder if this is masking a problem that real users will
> see. Aren't we silently discarding trace2 output that could be useful to
> somebody debugging or trying to get performance metrics?
> 
> I.e., should we be bumping the internal nesting max of 2 to something
> higher? If that would that cause problems with existing metrics, should
> we be designing new metrics to avoid nesting?

One thing this makes me think about is that we might want to
have items such as trace2_data_intmax() and trace2_data_string()
not be subject to the nesting limit. Only have the nesting apply
to the regions (which nest).

CC'ing Jeff Hostetler for his thoughts on that idea. We will have
a discussion offline to see if the progress regions have started
to cause inconsistencies in our existing telemetry stream of
internal users.

Thanks,
-Stolee
