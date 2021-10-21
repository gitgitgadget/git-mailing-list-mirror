Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC994C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B221E611CE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJUN2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJUN2i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 09:28:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EE2C0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:26:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h10so598793ilq.3
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 06:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yeQnfSTl7pAT/Z/rQvKYHSWE+SRp1yfWdAg/OJ1LvL4=;
        b=IWtU4u3Zj1a8zXqcG5LnyJ43/NTN5HTGUo2PFMCjUPmhdQR2Ili4NbQN6yKJMnvTOO
         fOCJvU/FIRuF5FNaDVSrKbdD8eZiMKh19NMFldRvMLy/r0xDkwzzCTe5a6HTuPL27I27
         4tDTb/DwGt8LloQWIqi5h6EBk9uWYYsTE6b7yHCgDu1GXmkx5zYiT12KSh6MnZJzX656
         9H8+FEL0uuD3xWzWacU3Btqh6KSQPuXf0lS+V6QAnxGE1FCT8bv3A+GSsQnOIYF4BSyZ
         Ptc87y6PE8vszdZVnUKgj4ZODfkFNx3iEKqWTQH2+jFCzQucndcITPo/rvjc6ZEu3S6/
         tM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yeQnfSTl7pAT/Z/rQvKYHSWE+SRp1yfWdAg/OJ1LvL4=;
        b=T0XshwjTP+g9C9+ubhUxLwvL7B3xycXl9dyzHD5OWfkW73KsUysiaZzJcR6cT64NXp
         Ga4mLwKKWPuYPxqsdpAMs+hDnLPlKZtS9e1HDmRn7G3u+IlYl1kA5hiWsQiVMFIctuUu
         Qe1j0zlDAhnx25qp3X8SC13dCHH0UF5gAwgjQE0CyIcy0/2lyTNBUWrmOE8jw3Ni7917
         Ij6VfGzMkhnoSa2JvNWEquHU8sQmDYnq3Zse0RrpJoSNnzKigr7AoXO6Iy78Xvltn1se
         d2BHF5CJoclBTuTAeoXKB/sphByT2Fc9H6/tDDUaY+OLbZQwlNnWw4fnVXZ6oIgDBMxu
         1NtA==
X-Gm-Message-State: AOAM530SPy/RxGHTjIsLQ5oa9/uWyz2rvmTmMukWGYXdP0oWbrtmShWN
        5mXAUbFtSvVZZVPoBOMAQmY=
X-Google-Smtp-Source: ABdhPJwvreEhfrd8FgYfCkLvJAaaOFdDxzYMArmLqgi/IAcUEcQiKkU0nT/DUO0J/f9kluSMzXjyRw==
X-Received: by 2002:a05:6e02:1c08:: with SMTP id l8mr3702672ilh.137.1634822781472;
        Thu, 21 Oct 2021 06:26:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:144c:9bcd:5030:5cda? ([2600:1700:e72:80a0:144c:9bcd:5030:5cda])
        by smtp.gmail.com with ESMTPSA id n17sm2737720ile.76.2021.10.21.06.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:26:21 -0700 (PDT)
Message-ID: <002d7dd3-c41a-87a4-6fc0-ddf8497f4805@gmail.com>
Date:   Thu, 21 Oct 2021 09:26:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
 <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
 <xmqqh7di3qfu.fsf@gitster.g> <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
 <xmqq5ytw19ck.fsf@gitster.g> <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com>
 <xmqqczo3yvz3.fsf@gitster.g> <b51500f2-854a-3006-810a-fb7fb8d8dcfb@gmail.com>
 <4656a934-5305-fbdf-76ca-17562fca62ef@github.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <4656a934-5305-fbdf-76ca-17562fca62ef@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/18/2021 10:14 AM, Victoria Dye wrote:
> Derrick Stolee wrote:
>> On 10/17/2021 9:15 PM, Junio C Hamano wrote:
>>> OK.  I somehow got the impression that we convert in both ways from
>>> the patch text under discussion, specifically this part in
>>> do_read_index():
>>>
>>>> -	if (istate->repo->settings.command_requires_full_index)
>>>> +	if (!istate->repo->settings.sparse_index ||
>>>> +	    istate->repo->settings.command_requires_full_index)
>>>>  		ensure_full_index(istate);
>>>> +	else if (!istate->sparse_index)
>>>> +		convert_to_sparse(istate, 0);
>>>>  
>>>>  	return istate->cache_nr;
>>>
>>> We used to say "when we know we are running a command that is not
>>> sparse ready, expand it here" and nothing else.
>>>
>>> We now added a bit more condition for expansion, i.e. "when we are
>>> told that the repository does not want sparse index, or when the
>>> command is not sparse ready".
>>>
>>> But the patch goes one more step.  "If we didn't find a reason to
>>> expand to full, and if the in-core index we read is not sparse, then
>>> call convert_to_sparse() on it".  So if the repo settings tells us
>>> that the repository wants a sparse index, and the index we read was
>>> not sparse, what does convert_to_sparse() without MEM_ONLY flag bit
>>> do?  Nothing special?
>>
>> You are absolutely right. I've been talking about what I _thought_
>> the code does (and should do) but I missed this 'else if' which is
>> in fact doing what you have been claiming the entire time. I should
>> have done a better job double-checking the code before doubling
>> down on my claims.
>>
>> I think the 'else if' should be removed, which would match my
>> expectations.
>>
> 
> By leaving that part out, wouldn't you only solve half of the "mismatch"
> between in-core index and repo setting? Earlier, you described your
> expectation as:
> 
>> * If index.sparse=false, then a sparse index will be converted to
>>   full upon read.
>>
>> * If index.sparse=true, then a full index will be converted to sparse
>>   on write.
> 
> Why should the direction of change to the setting value (false->true vs
> true->false) cause the index to convert at different times? Consider the
> scenario:
> 
> # In a cone-mode, sparse index-enabled sparse checkout repo
> $ git -c index.sparse=false status    # 1
> $ git status                          # 2
> $ git status                          # 3
> 
> Before this patch, the index has the following states per command:
> 
> (1) the index is sparse in-core, writes full on-disk
> (2) the index is full in-core, writes sparse on-disk
> (3) the index is sparse in-core, writes sparse on-disk
> 
> Here, I see two mismatches in my expectations: (1) operates on an in-core
> sparse index, despite `index.sparse=false`, and (2) operates on an in-core
> full index, despite `index.sparse=true`. 
> 
> What you're suggesting solves only the first mismatch. However, the second
> mismatch incurs the performance hit of a supposedly-sparse command actually
> operating on an in-core full index. It also creates an inconsistency between
> (2) and (3) in their use of the sparse index. What I'd like this patch to do
> is:
> 
> (1) the index is full in-core, writes full on-disk
> (2) the index is sparse in-core, writes sparse on-disk
> (3) the index is sparse in-core, writes sparse on-disk
> 
> Here, there are no more mismatches between in-core index usage and what is
> written to disk, and (2) and (3) use the same index sparsity.

I suppose that my perspective is that we always need to handle a full
index in-core, because it is a subset of the capabilities of a sparse
index. There is not much value in requiring the in-core index be sparse.

But also, I'm now less concerned about commands that convert from
full-to-sparse on read and expand back to full because of
command_requires_full_index. This should be a short-lived issue because
the index.sparse config is unlikely to be changing frequently, so once
the index is converted to sparse on write, we no longer need to do any
work to convert the in-core index to sparse on read.

The thing to keep in mind is that not every command that reads the index
also writes it. For example, the two 'git status' commands you list might
not write the index if there is no new information in the filesystem that
would trigger an index write.

In short: I've shifted my view and no longer oppose this conversion
immediately upon reading.

>>> I see many unconditional calls to convert_to_sparse(istate, 0) on
>>> the write code paths, where I instead would expect "if the repo
>>> wants sparse, call convert_to_sparse(), and if the repo does not
>>> want sparse, call ensure_full_index()", before actualy writing the
>>> entries out.  These also are setting traps to confuse readers.
>>>
>>> Perhaps we want a helper function "ensure_right_sparsity(istate)"
>>> that would be called where we have
>>>
>>> 	if (condition)
>>> 		convert_to_sparse();
>>> 	else
>>> 		ensure_full_index();
>>>
>>> or an unconditonal call to convert_to_sparse() to unconfuse readers?
>>
>> convert_to_sparse() has several checks that prevent the conversion
>> from happening, such as having a split index. In particular, it will
>> skip the conversion if the_repository->settings.sparse_index is false.
>> Thus, calling it unconditionally in the write code is correct.
>>
> 
> I may have introduced some confusion by redundantly checking
> `!istate->sparse_index` before converting to sparse (my goal was readability
> - showing the index does not need to be converted to sparse if it is already
> sparse - but I think it ended up doing the opposite). The condition could be
> removed entirely, thanks to an equivalent check inside `convert_to_sparse`:
> 
> -       if (istate->repo->settings.command_requires_full_index)
> +       if (!istate->repo->settings.sparse_index ||
> +           istate->repo->settings.command_requires_full_index)
>                 ensure_full_index(istate);
> +       else
> +               convert_to_sparse(istate, 0);
 
This is simpler.

Thanks,
-Stolee
