Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A398C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF72A6101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 10:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhJLKSP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhJLKSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 06:18:14 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18572C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:16:13 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so65384109wra.12
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cxouQsNdIGg0tkP3vN/RJZWoPq2JvEEf8+1GMx7ie0o=;
        b=Owh/CP2pCEUi5tSKKUVObTmAmEAoop7O86RQZS6vPidPGOYeDQrOLA/DWvtjtga6cw
         BMzJHOALjPS6HkE7LM62yXrILQWoQBpBwnFCtNvSTmkCUkkDqjdxxFovZOuqgDNRjX4y
         3nxR3U6gTDOhZOTeqDkhY1NWZXsaybkVAUE8P7fzBZIXbLUOk4QIFsOIY/rODDwtAno/
         L24EapAIwuU0OANxosdDOlBwrttt6OzaPRMhks3DS8wz8rsJ/2mCYoubL5uiNPSSEJU1
         8ceVVR4upgBA/NOhD6BZGcZwZ1O5ocMhQI3zk46P7Oq1y6JUBNKg0VzeNLr+QgsXaRbt
         +YJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cxouQsNdIGg0tkP3vN/RJZWoPq2JvEEf8+1GMx7ie0o=;
        b=VuYzn1ywsqmr+y9XdDbvczxqVqTO1eC0AEXtSUh1ggM7yB+hv5Uy8eAsdSSTXYP20J
         RlKIcBDevwl+LxLBBFREG8qHHUI+T0FnmzmI7zHiJzUf64VBfswmJmRFOI+sm1ATUJor
         pwH6tMAH1JNiuAPn33GG3gzozO1xBl7QvxrzaIIZUZ2pLBp2SNOM8sZyiJuC9dUwXzd7
         xCwkzxzjyPGKKoe5h1p1XUufYkesl01oFIYDK+ySY8jY+PqLxCaBkkkmrQok2tVKOfqb
         FfPLH+IpfUif41oXpVkNUp1f8nLXkApCrh2cjt/lKQkHOChSBsmHKq1u15pC8xCxgAIs
         hibA==
X-Gm-Message-State: AOAM533M4u7JRUj9XRPJ+YlKwyG9tBE42pNEKYKvRS621L+v/P64p1uK
        P7aUgc0V4Kn1JSmMb9tpd8I=
X-Google-Smtp-Source: ABdhPJxyi7M+Bzd820WDPyr9RGGzusyAzWgRh3bep49SuuEwBdMBgV8/djz54nsOT/OrcfCmoufSuA==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr4619615wmc.27.1634033771463;
        Tue, 12 Oct 2021 03:16:11 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id k17sm2624423wmj.0.2021.10.12.03.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 03:16:11 -0700 (PDT)
Message-ID: <cd62bf13-fdf1-af00-cc25-ef20abcfe152@gmail.com>
Date:   Tue, 12 Oct 2021 11:16:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 6/8] reset: make sparse-aware (except --mixed)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye <vdye@github.com>, phillip.wood@dunelm.org.uk,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <330e0c0977480d0506801854fcaa6c9f2b014569.1633641339.git.gitgitgadget@gmail.com>
 <c1dd1fef-2d48-cc18-5786-10e174b487a7@gmail.com>
 <52768318-ef8a-b26f-d4bc-d5c91779ccdb@github.com>
 <xmqq1r4vl65w.fsf@gitster.g> <47d4c810-0b56-45b0-944c-72c4d047f9b6@gmail.com>
 <xmqqlf30edvf.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqlf30edvf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/2021 23:03, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 08/10/2021 19:31, Junio C Hamano wrote:
>>> Victoria Dye <vdye@github.com> writes:
>>>
>>>> Phillip Wood wrote:
>>>
>>>>> I was looking at the callers to prime_cache_tree() this morning
>>>>> and would like to suggest an alternative approach - just delete
>>>>> prime_cache_tree() and all of its callers!
>>> Do you mean the calls added by new patches without understanding
>>> what they are doing, or all calls to it?
>>
>> I mean all calls to prime_cache_tree() after having understood (or at
>> least thinking that I understand) what they are doing.
> 
> Sorry, my statement was confusingly written.  I meant "calls added
> by new patches, written by those who do not understand what
> prime_cache_tree() calls are doing", but after re-reading it, I
> think it could be taken to be referring to "you may be commenting
> without understanding what prime_cache_tree() calls are doing",
> which wasn't my intention.

Thanks for clarifying that, I had misunderstood what you had written.

>> (a) a successful call to unpack_trees() updates the cache tree
>>
>> (b) all the existing calls to prime_cache_tree() follow a successful
>> call to unpack_trees() and nothing touches in index in between the
>> call to unpack_trees() and prime_cache_tree().
> 
> Ahh, OK.
> 
> I think we originally avoided calling cache_tree_update() lightly
> (because it is essentially a "write-tree", a fairly heavy-weight
> operation, without I/O) and instead relied on prime_cache_tree() to
> get degraded cache-tree back into freshness.
> 
> What I forgot was that 52fca218 (unpack-trees: populate cache-tree
> on successful merge, 2015-07-28) added cache_tree_update() there at
> the end of unpack_trees().  The commit covers quite a wide range of
> operations---the log message says "merge", but in fact anything that
> uses unpack_trees() including branch switching and the resetting of
> the index are affected, and they cause a full reconstruction of the
> cache tree by calling cache_tree_update().
> 
> For most callers of prime_cache_tree(), like the ones in "git
> read-tree" and "git reset", it is immediately obvious that we just
> read from the same tree, and we should have everything from the tree
> and nothing else in the resulting index, so it is clear that the
> prime_cache_tree() call is recreating the same cache-tree
> information that we already should have computed ourselves, and
> these calls can go (or if "prime" is still cheaper than "update",
> these callers can pass an option to tell unpack_trees() to skip the
> cache_tree_update() call, because they will call "prime" immediately
> after).

I haven't really thought this through but could we teach unpack_trees() 
to call prime_cache_tree() rather than cache_tree_update() when that 
would be safe? For callers that use oneway_merge() merge it should 
always be safe I think and it might be possible to modify twoway_merge() 
to signal if the final tree in the index matches the second one passed 
to it. We could have a more general mechanism for the callback to signal 
if it is safe to prime the tree but I suspect the callers that are using 
custom callbacks are not updating the whole tree.

Best Wishes

Phillip

> For other callers it is not immediately obvious, but I trust you are
> correctly reading the code ;-)
> 
> Thanks.
> 
> 
> 

