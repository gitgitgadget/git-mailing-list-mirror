Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE37C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 01:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74AB26023B
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 01:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhBIBeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 20:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBIBeL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 20:34:11 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AAAC061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 17:33:31 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id m7so17749456oiw.12
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 17:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AOx6l944pZ9U4DlSTzjVnchK5Akg/XlGbNwpnJ7CNog=;
        b=YtZkEODWf26vTzSGHDmyYUg/fq+56/y+ChmXQuUEXcrv5vauvZ6Vl/Rt2KU7P5G0l8
         6tpsg2YVJTn6G5jisyIh/RJrRWXYWh7eJcNO8UyycoT/AB0j98TTq9SRZJZuqnFBB+pW
         CTDcQwbaIdWWwXQH7RSTngNrmcOYZIYZI49akFl7sdudnVOvzTR/bBNXaZBQNATtKfLy
         d5JjzUOsNIO1FsAce1aj65e+qta/1SgAsuHpERFiCg+WRv0wvDp3TIXekbX97CFIWQvL
         fvggp+kdmXXjhmTdq2jPnNYYsqwJD/TWtUBY7Vf25fFHNDjCdI/DBU6B/nPAmsjCyI/i
         jHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AOx6l944pZ9U4DlSTzjVnchK5Akg/XlGbNwpnJ7CNog=;
        b=ugkk57t+IZmjHUXcVtxy2OUFRvkzXVIwunH9WG4+69W0diitjGRLpPGGKPJh7Awfiw
         C1g5CjtZxgLWEqttqfNlVX7TtInC6vfdkmiN4fnzJqNWbdImGsYohtpL2A02rawrCEjU
         XXW7xpPjZab4kIFxgwuVwHyiAk5ulBoB9fy46jnonpR/J62BrwjIgT2FQgwngNofgsUj
         l1SV2Si/A2csLIToYEVPkK7dHfShwCEEBOmANlLFoIcowWdQx6oIiCM4Xy+/0HmOSCFY
         0eslN1slwuBGxeJsyoguJdYlWaLZmnA8ZcyjxK/5jRiAHxy2VUh+jGBaXnm4ptgVC+HC
         Ew6A==
X-Gm-Message-State: AOAM530Ne01OHEKi+qElqFDosdU/AQeYIe/2NsVNChr+fJC6Z1yITr2K
        88VO0O37JpgClRZte2Bb57Y=
X-Google-Smtp-Source: ABdhPJwnQwnW9492k1UkRClbUShZxB2U5SkonaWxrIQ635f26BfkQwMZQUdZqS3LH3lk9tS1XElSqQ==
X-Received: by 2002:a05:6808:147:: with SMTP id h7mr1015172oie.142.1612834410931;
        Mon, 08 Feb 2021 17:33:30 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id 203sm2494226oie.14.2021.02.08.17.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 17:33:30 -0800 (PST)
Message-ID: <abd61648-c351-e849-9cf1-ddabff514743@gmail.com>
Date:   Mon, 8 Feb 2021 20:33:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 12/17] chunk-format: create read chunk API
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
 <xmqqczxf4d2k.fsf@gitster.c.googlers.com>
 <1278de82-417c-a6ee-a5fe-055fa0ef1903@gmail.com>
 <xmqqeehu1f1q.fsf@gitster.c.googlers.com>
 <xmqqh7mm42ml.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh7mm42ml.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/8/2021 5:26 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> The users of pair_chunk() presumably are not ready to (or simply do
>> not want to) process the data immediately by using read_chunk() with
>> callback, but when they get ready to process the data, unlike
>> read_chunk callbacks, they do not get to learn how much they ought
>> to process---all they learn is the address of the beginning of the
>> chunk.  I do not see a way to write pair_chunk() users safely to
>> guarantee that they do not overrun at the tail end of the chunk they
>> are processing.
> 
> I've read through v3 and found it mostly done, but the above
> question still stands.  I find it questionable why callers of
> pair_chunk() only can learn where a chunk data begins, without
> being able to learn how big the region of memory is.  IOW, why
> can we get away without doing something like this?  The users
> of pair_chunk() won't even know when they overrun the end of
> the data the are given without something like this, no?

I guess that the point is that if a caller wants to perform
logic on the size, then they should use read_chunk() instead.
We have some chunks that check the size is correct upon read,
but most chunks do not do this (currently).

In future series, additional protections could be added, and
I would expect that to be done by converting callers of
pair_chunk() into callers of read_chunk() with appropriate
callback functions.

Thanks,
-Stolee
