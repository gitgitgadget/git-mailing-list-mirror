Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EEC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7705D610E7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 17:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFGRpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:45:13 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:35570 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhFGRpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:45:12 -0400
Received: by mail-wm1-f45.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so245491wms.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 10:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+nJPDkE3O4qZ3PLxuuGkHKTGv37TNEC6uUfKAXdFSZg=;
        b=gvfMLrgud8aveQA80Rtf0Oem51Z1B2j6Q/RO13tFW7z1GrHDxo7pPF+H7bJGgDiNWw
         m0b0OX6JIFa7BDqzDnesb3WJEBt8rZxK7d4CBCrr+fCHHnDozQNogRM2y+EZQ3YEh9HT
         wiJCdCVP7Fu26HWy1KayK1lah2r51xvE1tKlGJN3rzc4u8oqbTM+tJmXBae4BHGRf4+f
         0vgo9wLlyZwd0eqC0flwRNke3EYywBnQUz7dzUJEziJxWFVNQrOOdJ+xxlFovqAr3WGr
         usBxMe4ELVRCtq4YjVaWbO+S2mFuajwwTkl5G/VAl361+xQ2hLY2LGYAObIbvmR2y+ZB
         oPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+nJPDkE3O4qZ3PLxuuGkHKTGv37TNEC6uUfKAXdFSZg=;
        b=MhCukZCrKWiHRB9kRMpnJEIX6yQI6+7kqMUnp5PvxTMZjXZBiN75fcgQzUXQUtVqmH
         mVX0fUSf/m4OEtCCPDXYmVYm2hRdVDf23hYsilUHiXMs/JpoTIVbqPTJU61cvlFPI4EU
         J8fFtkm5/JhcG7ofkz8A+L5R9qsMSjeZR3LMJUqSI8GBGxtirZEF81qik245sylox+pf
         FMOQit4cxI0+50QfvCL5u6GVtZ1wuQibcBY7I3aBhXq1+JZWeZ/JA5Kx16Tr5X5PabSY
         eCok1asYwPfhNT/rqFHbbWCyC1hOCqjHQkSxnu6QmhfCfke70WZy2CKVZ5wXYbGIOorQ
         YsQQ==
X-Gm-Message-State: AOAM533tiDlu8gzpGy0Nf86YYZFoL9EeVYEvmz6p4ZN4kY6KL8l8T2y6
        zZCwWpzui2ke7SIhIEbGkAs=
X-Google-Smtp-Source: ABdhPJwlVGNGWejAf4XfjEMiSoXdB8HdJEUv8uAf0SSrL+rf2i9xoYESJKEHcdR8YOfXd46tztu7Pw==
X-Received: by 2002:a7b:cb9a:: with SMTP id m26mr270032wmi.66.1623087730472;
        Mon, 07 Jun 2021 10:42:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c8:7e01:d47f:7755:b018:7aae? ([2001:a61:34c8:7e01:d47f:7755:b018:7aae])
        by smtp.gmail.com with ESMTPSA id j18sm16767682wrw.30.2021.06.07.10.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 10:42:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
To:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <87eedd4n20.fsf@evledraar.gmail.com>
 <9ae26bcd-c6b7-682d-f895-3196c6c04ce2@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <d556cba2-9508-ae21-6650-403cd6d951b3@gmail.com>
Date:   Mon, 7 Jun 2021 19:42:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9ae26bcd-c6b7-682d-f895-3196c6c04ce2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/06/2021 19:32, Derrick Stolee wrote:
> On 6/7/2021 1:09 PM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> There are several instances in our documentation where we refer to an
>>> anonymous user as "a contributor" or "an integrator" or similar. To
>>> avoid repeating this role, pronouns are used. Previous examples
>>> chose a gender for this user, using "he/him" or "she/her" arbitrarily.
>>>
>>> Replace these uses with "they/them" to ensure that these documentation
>>> examples apply to all potential users without exception.
>>>
>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>
>> I think this is mostly an improvement, however:
>>
>>>   .../using-signed-tag-in-pull-request.txt      | 38 +++++++++----------
>>
>> This is a quote from a mail of Junio's[1] (date and all). I don't think
>> it makes sense to copyedit that after the fact without at least editing
>> the header that indicates that it's a verbatim reproduction.
>>
>> 1. https://lore.kernel.org/git/7vehuyosaa.fsf@alter.siamese.dyndns.org/
> 
> That's a good point. It does look a little strange that there is
> an email in our Documentation/ directory. I wondered if this was
> included in the docs that get posted to git-scm.com, but I see that
> the link I manually constructed [1] redirects to the GitHub mirror.
> 
> [1] https://git-scm.com/docs/howto/using-signed-tag-in-pull-request.txt
> 
> As long as this file remains formatted as an archived email message,
> the edits here are inappropriate.

To be fair, this file has already been copyedited once in commit
2de9b71138 (Documentation: the name of the system is 'Git', not 'git', 
2013-01-21)

> It's another question of whether the
> files within Documentation/howto should be updated to be docs that can
> be more easily posted in places like git-scm.com.
> 
> For now, I'll remove these edits from the patch.


