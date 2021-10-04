Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B998C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F4613A1
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 10:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhJDKFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 06:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhJDKFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 06:05:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EABC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 03:03:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o20so11778879wro.3
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SJ2LnR/cnkiue4ecR12SBBnarlp1mP5/uOsnhVDfE/I=;
        b=OeqIz06t9/6AY4RMgucpaEGfZbos+Y1UkRuIpnHcW7XXCFXoEIVkv7+zppsJsACjuA
         XhFoIdxoOTiS9luqbRpkm/EuY6DkeQ8To1bqrrEljCwZ6HuXlOuCGqUmg0p1AuTDw92h
         c0fsycZct+/11062Kngj+nOzgCGLhcVdRm3jPhmFzTaenfW98XosW8J5wV9QHogQ9bWt
         V5kHCu554/37TmvIeJEWeFQhiR5PJ+Rq34kb4ZL6tnZ9vBFQhCeyk9bsn09n4uPNQoNe
         t06t2PGoFOTvqWNSehO+B1hVWbKrkE7X31iggx7Mqui0Ldi4wGft3iBjs7TsNNuG1+nA
         D7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SJ2LnR/cnkiue4ecR12SBBnarlp1mP5/uOsnhVDfE/I=;
        b=6OA3BwoChZsYC7pvshArd/jdiuyAn3WhiX4aP6qCrM4Ag5XHzbYxssmALEmlX5/jni
         Brxmram1lT+UcnIPXh4GYNkdhF5/dG2aYHPzFhut84C5etQ/Adxf4oKVsS0sdG/PumNF
         7qs7W4WW5SdLg8LVqwi+d0WYElqgMNIVD7arjiuN9wpRoWbregQXRtmy5IvFOys4Vmc9
         jTmeqssLec1GuCddYOpLhB1C/3lDwWs10F++QKOSfmLIS1lx2GSll4MJ+jfEf+9H+Djc
         lKOdxx+aMAVxJabJdANA41zSw1X/BlRjDtVxuIlrYiziYmv3jcVLaSYq4D3TdNBOnQGj
         MuBQ==
X-Gm-Message-State: AOAM5316s7WHaDDNC+KDy02dpYDhQ985JBfXMgkc0T8bxX0tt0FiB1Kr
        MrAaogFF2LhTLa8UuDErRWc=
X-Google-Smtp-Source: ABdhPJwvNG3T66Y4xn06NVeYsmPcOzICWZk+ymUA7YkvgKSYSxJuyGahLgHki0OKoS2dQxule7BPKg==
X-Received: by 2002:a05:6000:1786:: with SMTP id e6mr13732625wrg.344.1633341808977;
        Mon, 04 Oct 2021 03:03:28 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id e11sm2045677wro.4.2021.10.04.03.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 03:03:28 -0700 (PDT)
Message-ID: <0a580f49-4366-526b-d601-f8ce5f99711c@gmail.com>
Date:   Mon, 4 Oct 2021 11:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 06/11] reset_head(): make default_reflog_action optional
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <4503defe5912aecc4e6a50ac82a31aa7b230456b.1633082702.git.gitgitgadget@gmail.com>
 <xmqqczoo5u7m.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqczoo5u7m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/10/2021 22:08, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> This parameter is only needed when a ref is going to be updated and
>> the caller does not pass an explicit reflog message. Callers that are
>> just discarding changes in the working tree like create_autostash() do
>> not update any refs so should not have to worry about passing this
>> parameter.
> 
> This only talks about internal implementation details of passing a
> parameter that may not be used, but ...
> 
>> -	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
>> -			  default_reflog_action, flags);
>> +	if (oid != &head_oid || update_orig_head || switch_to_branch)
>> +		ret = update_refs(oid, switch_to_branch, reflog_head,
>> +				  reflog_orig_head, default_reflog_action,
>> +				  flags);
> 
> ... doesn't this have a more significant behaviour change?
> 
> I am not sure if comparison between oid and head_oid can safely
> cheat like the patch does, or if it is necessary to do a proper oid > comparison, but either way, this would stop calling update_refs(),
> which in turn means it would have an externally visible effect, like
> a hook no longer getting called, doesn't it?
> 
> It would be a change for the good---calling post-checkout hook when
> you did "git checkout (no other arguments)" feels wasteful, but it
> deserves to be told to end users, I would think.

That would be a change for the good, but it is not what this patch does.
If oid == &head_oid then it means that the caller did not give us a tree 
to checkout so HEAD will not change unless we are switching branches. 
Using a pointer comparison rather than calling oidcmp() was a deliberate 
choice to avoid any user visible changes as there are no callers that 
try to run the checkout-hook without passing an oid or branch. The aim 
here is to avoid having to pass default_reflog when it is not needed 
without making any user visible changes.

> Again, a new test to protect the change would go well in the same
> patch.

I'm not sure what we could test

Best Wishes

Phillip

> Thanks.
> 
> 
