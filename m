Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F9C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 12:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E091164FBC
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 12:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhBEMdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 07:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhBEMb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 07:31:26 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D583C0613D6
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 04:30:46 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id y199so5219165oia.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EomoK/4bizahJI/iancZQiKbASPJTy5NoZEYHfflJQA=;
        b=CdzU2vaE6B2GBtKjCQJ7+Fvl3PS1KuzFsX6sCQHntnzqtGMM+sYYl1qhk56ryPCAsy
         Wx+hhpkOgMwdr0zCTMaHZceAaEeXPgVEyics+iqikeKBJV+gMVel9CGz5uen/aptuGmK
         tBsnIkAlaMTLyRhJ5EWB8Wdt4caR2v44p5M5LHjk/kHg3ROHrMVDv7xGt5M7mXbbs07K
         vDtGeWn0NPltQemwWx8WjAzxbrZoLx3rEIF9cNLdfXBr6yUHtjZymaDzZIg6YsBQ+0VS
         lYxLcT6h9Z3OTlu+Ir6kvzNB9eOfn0zRb4M804qgNeWiQElcVhQVtDb49Lh/L8p3qquU
         CWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EomoK/4bizahJI/iancZQiKbASPJTy5NoZEYHfflJQA=;
        b=PQqai2mUfjfQTlyhqnPoAtTXcQpbdG/8v6c7X/IoYpmqkDzlkI88Q8cmrlaY0c3Egr
         oJk9m2vXsm9mkIZh51geoEQTsSpIRqizGtFbO96pTbUUv9WUQcxzLyWorW9rI9Nva9D3
         WKmBFB0owhlGrkzQ/CdYcQgzMa4i4N6UxiEzKoBqzd4dZHhQc/C2HL7JBd4juPsd5ZDn
         wkDMOQDw4RDX7IZJeq5YatjBHoUZ2Em9J372jBL8gUl5ksE0baEUvG1Yd0JMwJ4WOSLJ
         GqjxTojzd77TTXdm7RWYhCnTIkETGMM/5/82/21Dh1+5ygIZWZR9S3CSzgtA9nA5O9uC
         evhw==
X-Gm-Message-State: AOAM5316pyYoh269K4JiATEHb2QtuFK/LMx+F16diEVXhI7RzQVCd+fH
        UbXoUTjZ6bXxbF31CE59tfM=
X-Google-Smtp-Source: ABdhPJxBfGP6q41OADDBkyocXenhGSqBa3UWFGkYe+zVTE8LAQGBimH925IdHWJlXLXzEsQptmyqPQ==
X-Received: by 2002:aca:d403:: with SMTP id l3mr469494oig.32.1612528245884;
        Fri, 05 Feb 2021 04:30:45 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id n93sm1757169ota.37.2021.02.05.04.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 04:30:45 -0800 (PST)
Message-ID: <7c209432-82e6-7785-a5c1-1068ec3f0378@gmail.com>
Date:   Fri, 5 Feb 2021 07:30:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
 <xmqq8s834c4s.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8s834c4s.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2021 7:00 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> When calculating the sizes of certain chunks, we should use 64-bit
>> multiplication always. This allows us to properly predict the chunk
>> sizes without risk of overflow.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  midx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> This one I find somewhat questionable for multiple reasons.
> 
>  * the fourth parameter of add_chunk() is of size_t, not uint64_t;
>    shouldn't the multiplication be done in type size_t instead?

This is probably appropriate because we will truncate to size_t if
it is smaller than uint64_t.

>  * these mutiplications were introduced in "midx: use chunk-format
>    API in write_midx_internal()"; that step should use the
>    arithmetic with cast (if necessary) from the start, no?

I wanted to isolate these changes specifically so we could be
careful about the multiplications and not be distracted by them
when converting to the chunk-format API. The multiplications were
"moved" by that patch, not "introduced".

>  * There is "ctx.entries_nr * MIDX_CHUNKID_OFFSET_WIDTH" passed to
>    add_chunk(), in the post-context of the first hunk.  Shouldn't
>    that be covered as well?  I didn't grep for all uses of
>    add_chunk(), but I wouldn't be surprised if this patch missed
>    some of the calls that need the same treatment.

And here is a great example of why it was good to call out these
multiplications in their own patch.

I did a full inspection of all multiplications in midx.c and
found a few more instances of possible overflow. Two are on the
read side, but they require the object lookup chunk to have size
4gb or larger. This is not _that_ far off from possibility! My
multi-pack-index for the Windows repository is currently ~1.6 GB
(in total, including the other chunks).

Thanks,
-Stolee
