Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD24C433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 13:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1C61283
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 13:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRN3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbhJRN2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 09:28:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DC5C061770
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 06:25:20 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bj31so12570916qkb.2
        for <git@vger.kernel.org>; Mon, 18 Oct 2021 06:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jdV0Oqa3xzTY8G4jYdOhN0ydDS6fV1+GqGPDJXC8iEY=;
        b=Lfjc6QDYOp8m9C53tqu2tbBKDhMpg8D/DUlAZ0J0bxU3O7b88S2RFW+j1Tkm2my2YK
         P0nRLytL28GDeDBmw3TLxmC5FSiaMSC/ZTwV/JGKAiNSH7COclh6Fjaq70O6cBNbaQL9
         x2rXIigAYOo6wNBE2iBMmygFyB2SjqOgVEqQltWWJ254cOc0sVo7NdwnGcF/o+hzDXMb
         CXHroj/BCEUlHUz3ft0ezHdHOrRht82w/AsT4elSaZ7J7hkZ6CvgJVxKRygQprG/tJTr
         6L8iFnd63o9E7NNxd9PkWi2kJhgpm25LeYOO30UgYJ4IbluGJXjYsIE6Mete+0QX4Erv
         dSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jdV0Oqa3xzTY8G4jYdOhN0ydDS6fV1+GqGPDJXC8iEY=;
        b=3POr3SBGH+ABYwz9OCP/0OSZDMtMDFmWkhMu1+jyOJMnABgODY1/SH53NKCNrkv6vj
         MIF4/qGDbbrNqX1qOF03+OIrUBrug+ZEObKkr4RUEuVXoZbzcObhuIvN7Pz2Zra32V00
         eoXRC2jq13A+Obhn4elRIE779ZqJhgrVEZCI3V/jPXTfuV9mjrsjWMzkhTBC/RxpvHJN
         Etbq+IQmrkyL5m545Q65/L1Te3wC2ikLlHQOyV89StlYwPVmWYS6cUZ3W0i9L8ULZ8C9
         1Rc4LJjclf6q+KD1Z7b6D7bg+QG0dyCPyWIBhR0+s/eNxJKriqzsVuzjApcoVK7u1Qtk
         zgSA==
X-Gm-Message-State: AOAM530aZB+rDaRKSBzeNSaBEetCXoup+xCK09WIsfUVs0pEk8l+Ld5A
        DTq4Q4JSZvYpW5vb0Rd2htw=
X-Google-Smtp-Source: ABdhPJw2/H5aXWgHPhm+ees/nLp3rThJ+jAKI20OsQrbId9s0P5CcpXMkQzOzgsKbZ3JXmzfAkGWxA==
X-Received: by 2002:a05:620a:1709:: with SMTP id az9mr23625429qkb.191.1634563519793;
        Mon, 18 Oct 2021 06:25:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:d8a5:7933:aca3:76a6? ([2600:1700:e72:80a0:d8a5:7933:aca3:76a6])
        by smtp.gmail.com with ESMTPSA id w17sm6221340qts.53.2021.10.18.06.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 06:25:19 -0700 (PDT)
Message-ID: <b51500f2-854a-3006-810a-fb7fb8d8dcfb@gmail.com>
Date:   Mon, 18 Oct 2021 09:25:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
 <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
 <xmqqh7di3qfu.fsf@gitster.g> <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
 <xmqq5ytw19ck.fsf@gitster.g> <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com>
 <xmqqczo3yvz3.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqczo3yvz3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2021 9:15 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>>     * In addition, with these patches, if index.sparse=false, a
>>>       sparse index will be expaned to full upon reading, and if it
>>>       is true, a non-sparse index will be shrunk to sparse upon
>>>       reading
>>
>> This is only half true. If "index.sparse=false", then a sparse
>> index will be expanded to full upon reading. If "index.sparse=true"
>> then nothing special will happen to an index on reading.
> 
> OK.  I somehow got the impression that we convert in both ways from
> the patch text under discussion, specifically this part in
> do_read_index():
> 
>> -	if (istate->repo->settings.command_requires_full_index)
>> +	if (!istate->repo->settings.sparse_index ||
>> +	    istate->repo->settings.command_requires_full_index)
>>  		ensure_full_index(istate);
>> +	else if (!istate->sparse_index)
>> +		convert_to_sparse(istate, 0);
>>  
>>  	return istate->cache_nr;
> 
> We used to say "when we know we are running a command that is not
> sparse ready, expand it here" and nothing else.
> 
> We now added a bit more condition for expansion, i.e. "when we are
> told that the repository does not want sparse index, or when the
> command is not sparse ready".
> 
> But the patch goes one more step.  "If we didn't find a reason to
> expand to full, and if the in-core index we read is not sparse, then
> call convert_to_sparse() on it".  So if the repo settings tells us
> that the repository wants a sparse index, and the index we read was
> not sparse, what does convert_to_sparse() without MEM_ONLY flag bit
> do?  Nothing special?

You are absolutely right. I've been talking about what I _thought_
the code does (and should do) but I missed this 'else if' which is
in fact doing what you have been claiming the entire time. I should
have done a better job double-checking the code before doubling
down on my claims.

I think the 'else if' should be removed, which would match my
expectations.

> I see many unconditional calls to convert_to_sparse(istate, 0) on
> the write code paths, where I instead would expect "if the repo
> wants sparse, call convert_to_sparse(), and if the repo does not
> want sparse, call ensure_full_index()", before actualy writing the
> entries out.  These also are setting traps to confuse readers.
> 
> Perhaps we want a helper function "ensure_right_sparsity(istate)"
> that would be called where we have
> 
> 	if (condition)
> 		convert_to_sparse();
> 	else
> 		ensure_full_index();
> 
> or an unconditonal call to convert_to_sparse() to unconfuse readers?

convert_to_sparse() has several checks that prevent the conversion
from happening, such as having a split index. In particular, it will
skip the conversion if the_repository->settings.sparse_index is false.
Thus, calling it unconditionally in the write code is correct.

Doing these conditional checks within convert_to_sparse() make sense
to avoid repeating the conditionals in all callers. ensure_full_index()
doesn't do the same because we absolutely want a full index at the end
of that method.

Perhaps a rename to something like "convert_to_sparse_if_able()" would
make sense? But it might be best to leave that one lie.

Thanks,
-Stolee
