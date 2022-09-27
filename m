Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB18C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiI0QzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiI0QzA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 12:55:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC35603E
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:54:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id g8so8271627iob.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vppSvWKx3tXsMfiUctD+muRVdg3LltwfppSzygOlDrk=;
        b=V2j0sOVGVWOOY/fQpzxIhhq77xen8S6D7MyChFmP8Vb+WE8Al7juMyFRply7hUjVKb
         HfKMUF5VnUeaNiLKnMeOhvKTBxqgiDKGNEUueJ7095virBkhH1hwwDdcw8yVJ8iG7M4X
         lZ1ZWzTcjizauiEH6wWN1VTEahvEmT4adodO51QDigSQcsu1kGzJHFLqE/HtsMUeqrgo
         Myy+Vqd98o4LnPj+MdVShe7l6Eb8Ss/i8OQvpwvqSEk9aSal0L4/ROfgvrrtwdS6z/G+
         ToP5NI27l4sjxl+yCGwkOjojCw+PLVdBHhT1fRnt04Y+CeZypB5yPEMImJZF11DPpUKT
         sYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vppSvWKx3tXsMfiUctD+muRVdg3LltwfppSzygOlDrk=;
        b=Uc00p85TN7750l9XsxxjmcwGM1N4eEQCzXxuXQe9XyMLDScXHaLzsiOHwgXdjXu161
         L6p9OtYTVuOk88jSC2IaqltAhpluNAaX172lZS9jA7y5AwL75mLSnFrQn+qVKJPwkVWb
         PvQChKnRdRuGkHG8kcGXax29Nq8PffxCf2tZHvbJC0OWRTw5dlJKUVF+3Poviaq4LUY2
         v/riU6x8qwWBNfmPUtKNOzFpZ6GRrDAfJsbRx+k9GrHeMhCMX/wIvruRRgmJ8xy+SG5y
         JLfpwQCZAaB2SULeT8tUQSUK299kmuhJIqW5E69W4shRJMDG97BD2uaIOJ3sGqLb3tFl
         jeKg==
X-Gm-Message-State: ACrzQf1MCgyZzm+wnmAnLReOKUEDHSdm76QosJ72TJwhgBGQU2ZpzToD
        w+VHu1zW8IGwrcrAL188sifc
X-Google-Smtp-Source: AMsMyM6ZUoW++fTcBtAJsfntORMiq/jF2/QXr/R24yXYd/CyMQPuMquTcJrt+WB6sOTbzd08lzUGig==
X-Received: by 2002:a05:6638:3821:b0:35a:1973:ae9 with SMTP id i33-20020a056638382100b0035a19730ae9mr13991514jav.313.1664297650117;
        Tue, 27 Sep 2022 09:54:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id z25-20020a6be019000000b006814fd71117sm935061iog.12.2022.09.27.09.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:54:09 -0700 (PDT)
Message-ID: <9ccd46f1-4577-3075-db1c-a260fcf247ad@github.com>
Date:   Tue, 27 Sep 2022 12:54:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 0/4] scalar: make unregister idempotent
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
 <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
 <xmqqtu4s7p9q.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu4s7p9q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2022 12:31 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> I noticed this while we were updating the microsoft/git fork to include
>> v2.38.0-rc0. I don't think 'git maintenance unregister' was idempotent
>> before, but instead some change in 'scalar unregister' led to it relying on
>> the return code of 'git maintenance unregister'. Our functional tests expect
>> 'scalar unregister' to be idempotent, and I think that's a good pattern for
>> 'git maintenance unregister', so I'm fixing it at that layer.
>>
>> Despite finding this during the 2.38.0-rc0 integration, this isn't critical
>> to the release.
>>
>> Perhaps an argument could be made that "failure means it wasn't registered
>> before", but I think that isn't terribly helpful.
> 
> I happen _not_ to share the idea that "unregister is expected to be
> idempotent" is a good pattern at all, and it is a better pattern to
> make failure mean that the object specified to be acted upon did not
> even exist (cf. "rm no-such-file").  But that aside, does what the
> above paragraphs mention still true for this round, namely, you are
> "fixing" it at that (i.e. "maintenance unregister") layer?

Sorry, I forgot to update the cover letter when updating the title.
"git maintenance unregister" will fail if the repository is not already
registered (unless --force is given). Now, "scalar unregister" _is_
idempotent (it uses "git maintenance unregister --force").
 
> The cover letter does not become part of the permanent history, so
> it is not a huge deal as long as the reviewers know what they are
> looking at ;-).  Just leaving a note in case somebody who missed the
> iterations up to v3 is now interested in the topic.
> 
> Thanks for a quick iteration.

Thank you for your very careful review!

-Stolee
