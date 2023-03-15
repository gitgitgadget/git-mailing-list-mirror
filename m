Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B8CC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjCOQNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjCOQN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:13:27 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FB180921
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:12:50 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id y3so16976407qvn.4
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678896767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jbmul8COopvbnsnDujXQ0zu3vajC9hb1mF6ijeAyfw8=;
        b=b5D9mKIsppD9j6dEKhy2IijoQjBYvM8Zgp1kh6+gOfnWJD2m+uqM50J78AABmLj3C/
         zrIRXrQUmuUich3AuWA9fYprrS4C9oY/+p4aPWvCOX18n/AqUkB5jMvzJ3WO8hIaSA80
         vvoks57a+vvFmC62WElplhEitlggrqIumHvx01pNN/rBBdvnlui0jDI94v+VhV+xJjC2
         qEHzdt6Nu8jwrV+XRFj0FrkrBiMrc1omKRTdfmDDRYoCQ6zXyT1dsuq39oIQ642kNFED
         mi7exUaRvKNxin+tdz2wt5j4snj8p0C7CYfKsTmXeHqaR8fKcR+STQSVf6PHePFPluYf
         ZnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbmul8COopvbnsnDujXQ0zu3vajC9hb1mF6ijeAyfw8=;
        b=f6HAAyRGpV6VI/eKkIjqLCuqSP6PSn/d4GvZ6fhHH08gzMJOyqaiYwvnh0ykrXMOED
         LG2WZqLQuiHnU1waf1R8FDS9L42fG3PneteuYRt3F3asBusPYC6F2PyBsHySqFJRxEyP
         l+7g1wyqBBLkSIsozHIP9QGz2A8U1D2iv9o020O6QE9Y6C3e7SdyNxokjr8rn4bpc0Xi
         mA+HTgWzO5ml2CP4nSFID6fjFazz/aTdUCegW9PGJeyUEIG/cFOJW6ZN5vYytqu5RrC3
         CZxFhASlgL6u5tvXClKuQIRHBnNsSnr5HDkhaFXhxQnBlSV7iAyjG7ra4ZHE+LjSvXit
         i6Xw==
X-Gm-Message-State: AO0yUKXMDuifet/iVBLUOe64Ve2XocC0/w06OsR8iC++2rYf5OyDs7Xh
        THVnKFmQyPY6CuyT/IOFCnaF
X-Google-Smtp-Source: AK7set/lTEhJOZvs6P9B4j/G0jewsw+ae/gYP7BaD3R1WIBGFIrsVWlru2KxSt5WEdhFbSCMy/ZrWQ==
X-Received: by 2002:ad4:5c8b:0:b0:5a4:690b:abd5 with SMTP id o11-20020ad45c8b000000b005a4690babd5mr24256194qvh.19.1678896766789;
        Wed, 15 Mar 2023 09:12:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id dt7-20020a05620a478700b00706b09b16fasm4101759qkb.11.2023.03.15.09.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:12:46 -0700 (PDT)
Message-ID: <3f7fe6c4-197e-bde9-50b8-ecce705a9f22@github.com>
Date:   Wed, 15 Mar 2023 12:12:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 7/8] for-each-ref: add ahead-behind format atom
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <82dd6f44a33279551bb638357df4bc82253283e5.1678468864.git.gitgitgadget@gmail.com>
 <230315.868rfyxfus.gmgdl@evledraar.gmail.com> <xmqqh6umovf9.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqh6umovf9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 12:01 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
>> On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Derrick Stolee <derrickstolee@github.com>
>>> [...]
>>> +ahead-behind:<ref>::
>>> +	Two integers, separated by a space, demonstrating the number of
>>> +	commits ahead and behind, respectively, when comparing the output
>>> +	ref to the `<ref>` specified in the format.
>>> +
>>
>> As a potential (expert) user who hasn't read the code yet I'd think the
>> the "<ref>" here would be the same as "update-ref", but glancing ahead
>> at your tests it seems that it does ref matching, so "refs/heads/master"
>> and "master" are both accepted?
>>
>> Since nothing else uses "<ref>" here I think we should clearly define
>> the matching rules somehow, or maybe we do, and I missed it.
> 
> I vaguely recall noticing this in the previous round, but doesn't
> this only require a commit-ish, not even a ref?  It is parsed with
> lookup_commit_reference_by_name().

You noticed it in this round, but I haven't sent v3 yet. I have
this in my local copy:

ahead-behind:<committish>::
	Two integers, separated by a space, demonstrating the number of
	commits ahead and behind, respectively, when comparing the output
	ref to the `<committish>` specified in the format.

Thanks,
-Stolee
