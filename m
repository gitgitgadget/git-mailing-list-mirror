Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C606BC433FE
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 14:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBAC60ED5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 14:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhJROUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhJROUB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 10:20:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6704BC061367
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 07:14:59 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id h20so11000299qko.13
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gPkOTSTP0eP89EdrBZX3bW+rEcXTCfZrFXgLXcCVP14=;
        b=Wlh2Ay9JF344G4ESoB9gCcA0MEfy3vxw+YP9y7oKd/tHnPTqvEsapQNW9NCvfTX1Ht
         XnrAItEgcc1TNUhH05zsku3kiLrmsYvWLlOtrN3DIwfmJr4rCqcycFCl7KIO0wD6jnk7
         9sfYGveuep3iRJ21CJV2BmIeRcO50/totjbp5Nr3ihyeS4AyXRd4kCDEA/jkZRstHt0U
         apJA9QHOxPknQNzrARt3vMRWPbWdtUTKYZisEwb8/9TbzbXIonk7BdgUCHO+rj3dY47i
         P41waiPT9+oFWasayeHgyUH2UStPRLTa31KVqhDi07Y52k797QvaJPwm053TLeLVzdzS
         7C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gPkOTSTP0eP89EdrBZX3bW+rEcXTCfZrFXgLXcCVP14=;
        b=qTuPPFWqyTmrpTegw0tAbcZ4DOysJ1On98QhwseZibaP1sUNCDDj0ji8ENDdhLicf4
         7xYpeY5bZ+0181/xkG7RvU3u9pw20OpGVNN+jWZG8PG4iFLOR3JgNBD8jdLMMILDlkxg
         m+YYAoqCxsctltGNi2w/9Vb7fkqBLVyIO031rLYfBAUkuCARHKavusk77ODFO3ZTWLJz
         5b29esGUeOiZpqwhsqdqM6mCdHIiK37wlegP3VduN6MW8FlPc420uxSfdTW2m5MNzAdf
         eB69p0GC8QN8MqFX22FU1qaRZfdeShOFhpJRuS2Rd98Cov9GIPyhjp/QaSKP3bus34Fb
         11Hg==
X-Gm-Message-State: AOAM531KObtK8jy88xxSCExelf7xYbUmOSv6Fok0+d944BowfnaPoa0D
        j+ITU1Zy5BUDIrWkmPampIA9dY/lHUqt
X-Google-Smtp-Source: ABdhPJz7U8LNgy8ozh3i2mVaJhkAqx6CE0EoKjMXFBBL3yIKyeir4KS2sCFIkfUtVgXdNKV1dmY5hg==
X-Received: by 2002:ae9:ed58:: with SMTP id c85mr23155886qkg.73.1634566498545;
        Mon, 18 Oct 2021 07:14:58 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id t24sm6605036qkj.52.2021.10.18.07.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 07:14:58 -0700 (PDT)
Message-ID: <4656a934-5305-fbdf-76ca-17562fca62ef@github.com>
Date:   Mon, 18 Oct 2021 10:14:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
Content-Language: en-US
To:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
 <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
 <xmqqh7di3qfu.fsf@gitster.g> <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
 <xmqq5ytw19ck.fsf@gitster.g> <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com>
 <xmqqczo3yvz3.fsf@gitster.g> <b51500f2-854a-3006-810a-fb7fb8d8dcfb@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <b51500f2-854a-3006-810a-fb7fb8d8dcfb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 10/17/2021 9:15 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>>>     * In addition, with these patches, if index.sparse=false, a
>>>>       sparse index will be expaned to full upon reading, and if it
>>>>       is true, a non-sparse index will be shrunk to sparse upon
>>>>       reading
>>>
>>> This is only half true. If "index.sparse=false", then a sparse
>>> index will be expanded to full upon reading. If "index.sparse=true"
>>> then nothing special will happen to an index on reading.
>>
>> OK.  I somehow got the impression that we convert in both ways from
>> the patch text under discussion, specifically this part in
>> do_read_index():
>>
>>> -	if (istate->repo->settings.command_requires_full_index)
>>> +	if (!istate->repo->settings.sparse_index ||
>>> +	    istate->repo->settings.command_requires_full_index)
>>>  		ensure_full_index(istate);
>>> +	else if (!istate->sparse_index)
>>> +		convert_to_sparse(istate, 0);
>>>  
>>>  	return istate->cache_nr;
>>
>> We used to say "when we know we are running a command that is not
>> sparse ready, expand it here" and nothing else.
>>
>> We now added a bit more condition for expansion, i.e. "when we are
>> told that the repository does not want sparse index, or when the
>> command is not sparse ready".
>>
>> But the patch goes one more step.  "If we didn't find a reason to
>> expand to full, and if the in-core index we read is not sparse, then
>> call convert_to_sparse() on it".  So if the repo settings tells us
>> that the repository wants a sparse index, and the index we read was
>> not sparse, what does convert_to_sparse() without MEM_ONLY flag bit
>> do?  Nothing special?
> 
> You are absolutely right. I've been talking about what I _thought_
> the code does (and should do) but I missed this 'else if' which is
> in fact doing what you have been claiming the entire time. I should
> have done a better job double-checking the code before doubling
> down on my claims.
> 
> I think the 'else if' should be removed, which would match my
> expectations.
> 

By leaving that part out, wouldn't you only solve half of the "mismatch"
between in-core index and repo setting? Earlier, you described your
expectation as:

> * If index.sparse=false, then a sparse index will be converted to
>   full upon read.
> 
> * If index.sparse=true, then a full index will be converted to sparse
>   on write.

Why should the direction of change to the setting value (false->true vs
true->false) cause the index to convert at different times? Consider the
scenario:

# In a cone-mode, sparse index-enabled sparse checkout repo
$ git -c index.sparse=false status    # 1
$ git status                          # 2
$ git status                          # 3

Before this patch, the index has the following states per command:

(1) the index is sparse in-core, writes full on-disk
(2) the index is full in-core, writes sparse on-disk
(3) the index is sparse in-core, writes sparse on-disk

Here, I see two mismatches in my expectations: (1) operates on an in-core
sparse index, despite `index.sparse=false`, and (2) operates on an in-core
full index, despite `index.sparse=true`. 

What you're suggesting solves only the first mismatch. However, the second
mismatch incurs the performance hit of a supposedly-sparse command actually
operating on an in-core full index. It also creates an inconsistency between
(2) and (3) in their use of the sparse index. What I'd like this patch to do
is:

(1) the index is full in-core, writes full on-disk
(2) the index is sparse in-core, writes sparse on-disk
(3) the index is sparse in-core, writes sparse on-disk

Here, there are no more mismatches between in-core index usage and what is
written to disk, and (2) and (3) use the same index sparsity.

>> I see many unconditional calls to convert_to_sparse(istate, 0) on
>> the write code paths, where I instead would expect "if the repo
>> wants sparse, call convert_to_sparse(), and if the repo does not
>> want sparse, call ensure_full_index()", before actualy writing the
>> entries out.  These also are setting traps to confuse readers.
>>
>> Perhaps we want a helper function "ensure_right_sparsity(istate)"
>> that would be called where we have
>>
>> 	if (condition)
>> 		convert_to_sparse();
>> 	else
>> 		ensure_full_index();
>>
>> or an unconditonal call to convert_to_sparse() to unconfuse readers?
> 
> convert_to_sparse() has several checks that prevent the conversion
> from happening, such as having a split index. In particular, it will
> skip the conversion if the_repository->settings.sparse_index is false.
> Thus, calling it unconditionally in the write code is correct.
> 

I may have introduced some confusion by redundantly checking
`!istate->sparse_index` before converting to sparse (my goal was readability
- showing the index does not need to be converted to sparse if it is already
sparse - but I think it ended up doing the opposite). The condition could be
removed entirely, thanks to an equivalent check inside `convert_to_sparse`:

-       if (istate->repo->settings.command_requires_full_index)
+       if (!istate->repo->settings.sparse_index ||
+           istate->repo->settings.command_requires_full_index)
                ensure_full_index(istate);
+       else
+               convert_to_sparse(istate, 0);
