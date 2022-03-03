Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7407C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 17:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiCCR3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 12:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbiCCR3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 12:29:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3353C6225
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 09:28:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so8900095wrg.11
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7DYw4ABumb0Q5uvLGYTp9oG3nx32XWIPCrXh2FJ4m2s=;
        b=qzXXvhnGZyvsIW6PnTsZHSwYJe8WnTyHQNeY6Ls1bHjrQziHsv7aszX6oySMnUp+UA
         FT7QJ6Two1ZFCTltuIDXpAnEECPupAiqYBs2hUYGX+0sXKqSQtHNGC6tFF+tK3ixysU9
         DWr4AhLe6b2dPjwDbUfFOGL8YEI2C3hR/sBc1VkZWVB2FjfYkqs7SUzMuAusonHKLX/s
         ucShfRMoONs9YLTu3EvM8FBjCUM3/fKSTUftC8KdU7YQZCN6WVXjPJiGqQ4rNAm2Gf9X
         oLgbmWwdTVmHTwCELwVUV88roSXSWL9wIK77tXBQ0GOJvspTt0FB++a+enu+vDN8rhJc
         bX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7DYw4ABumb0Q5uvLGYTp9oG3nx32XWIPCrXh2FJ4m2s=;
        b=MligwH+U7sv6rluO5rn/3lEbtpWXMketklD106ffmWLCo65rHj1tCiwdsjZc15N0kS
         pOff+rigjxeSJLBIUAjkBqI/OyZqq2oQCHhBh3EQBnIaNNLU17579oRVqh4FYxDY64N+
         AfU5k731q6na0PwuL9SvZ8rDNFkz5YknVmZ9m73ZLTJePg2SG9u5NCPBBitiGoJjXRBZ
         4J2W2eiCOU+0SUX/V9zkKpwqd9Ejbv4sqrlysGuFD6jAbFneM/qDUZt/epCYxwRR3Lm1
         VU65sjfuyOHa06A/pjDcm136rjQfWx5RCIFpdNOZEWcMOfZhwos7yJuPv6FvLQOWM8oI
         AenA==
X-Gm-Message-State: AOAM530a4BUy8ThG4heFukNGqSOBHq9TzAbkdNXc4NymsihKhC1EfwId
        cJ8zTiekARnPchUvhDTIdXQ=
X-Google-Smtp-Source: ABdhPJzbfolhGG/3Lz3zigYIlJhCqJ2pnCnGFsaPubxoRuBz7B15j0eQhYsfuR0wYOsUGfrLw6uZ0A==
X-Received: by 2002:a05:6000:2a5:b0:1f0:2e57:82ab with SMTP id l5-20020a05600002a500b001f02e5782abmr6675345wry.515.1646328508139;
        Thu, 03 Mar 2022 09:28:28 -0800 (PST)
Received: from [192.168.1.201] (230.2.7.51.dyn.plus.net. [51.7.2.230])
        by smtp.googlemail.com with ESMTPSA id o18-20020a05600c511200b00352ec3b4c5asm3606051wms.7.2022.03.03.09.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 09:28:27 -0800 (PST)
Message-ID: <d73db784-c09b-a889-3d19-d41be7748e66@gmail.com>
Date:   Thu, 3 Mar 2022 17:28:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite
 --updatref behavior
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        John Cai <johncai86@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g> <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
 <220303.86a6e72d1g.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220303.86a6e72d1g.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/2022 16:52, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Mar 03 2022, Phillip Wood wrote:
> 
>> On 02/03/2022 23:32, Junio C Hamano wrote:
>>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>> [...]
>>>> +test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
>>>> +	git init repo &&
>>>> +	(
>>>> +		cd repo &&
>>>> +		setup_stash
>>>> +	) &&
>>> Hmph, so this is done inside the subdirectory.  The implementation
>>> of the helper in this iteration does look cleaner than in the
>>> previous iteration.
>>> But these many references to "repo/" and "-C repo" we see below
>>> makes me wonder why we do not put the whole thing inside the
>>> subshell we started earlier.
>>> i.e.
>>> 	git init repo &&
>>> 	(
>>> 		cd repo &&
>>> 		setup_stash_test &&
>>> 		echo 9 >file &&
>>> 		old=$(git rev-parse stash@{0}) &&
>>> 		git stash &&
>>> 		new=$(git rev-parse stash@{0}) &&
>>> 		...
>>> 		test_cmp expect actual
>>> 	)
>>>
>>
>> I wonder if we could avoid the subshell entirely and avoid relying on
>> REFFILES (assuming we're not trying to test the implementation details
>> of that refs backend) by doing something like
>>
>> test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
>> 	old=$(git rev-parse stash@{0}) &&
>> 	setup_stash_test &&
>> 	git rev-list -g stash >tmp &&
>> 	sed /$old/d tmp >expect &&
>> 	git rev-list -g stash >actual &&
>> 	test_cmp expect actual
>> '
> 
> Unless I'm missing something that "rev-list -g" will emit only the RHS
> of the stash logs, i.e. no "0000..." etc.
> 
> And if we only look at that the difference with specifying the flag
> isn't visible, no?

Maybe I'm missing what this test is actually needs to do. I thought it 
just needed to check that the deleted stash is removed from the reflog 
and the others are unchanged. You're right that it wont show the LHS and 
if that is important then you need to read the log file directly.

Best Wishes

Phillip


>>>> +	echo 9 >repo/file &&
>>>> +
>>>> +	old_oid="$(git -C repo rev-parse stash@{0})" &&
>>>> +	git -C repo stash &&
>>>> +	new_oid="$(git -C repo rev-parse stash@{0})" &&
>>>> +
>>>> +	cat >expect <<-EOF &&
>>>> +	$(test_oid zero) $old_oid
>>>> +	$old_oid $new_oid
>>>> +	EOF
>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>> +	test_cmp expect actual &&
>>>> +
>>>> +	git -C repo stash drop stash@{1} &&
>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>> +	cat >expect <<-EOF &&
>>>> +	$(test_oid zero) $new_oid
>>>> +	EOF
>>>> +	test_cmp expect actual
>>>> +'
>>>> +
>>>>    test_expect_success 'stash pop' '
>>>>    	git reset --hard &&
>>>>    	git stash pop &&
> 

