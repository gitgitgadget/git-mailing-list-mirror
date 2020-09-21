Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E59C43465
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2801220874
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 08:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqShdFv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgIUIAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIUH7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 03:59:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BE1C061755
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 00:59:24 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so3759960pfo.12
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 00:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MUYJR8zIFCey76Csm6VBKC///B29w1JN7lWojxQQWQA=;
        b=aqShdFv599zGCfZu8b/fs9yMAhyC2nVVqu5zzhQBxAoq/rF75HUnW7VxbTuHUUquJ8
         MDYMA0t8dY1sow1i2uiKj+3b7cOeh9H2HJ85xTq0p+YgTCfIcars0srPxpnFSFiRYe2n
         hlNx2Oh10ub5LzYbVcs9k9cN7mwbQjcGUlUKxzCzfxg9Hd97wdZWFTsnJIVhjR8jk17C
         F+ADqbSToKx++1Efhz86xBmnjuBQlYDQ0GZjTtZ6mfXBJdcbkdxPDozlTpBRg83igamL
         qEjSCr4pjo6pXlYbDfE+Svet1SE2r4p4of1sv5Web7BQ0sGHcg0gJxCMmX8e5RmvSHjr
         5w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUYJR8zIFCey76Csm6VBKC///B29w1JN7lWojxQQWQA=;
        b=qLo23jkHJRExqsPYUhDSZe8XkIWjySRCs62jdpec0cL/+nwY5B3/dsWG6/x4/472uj
         bEp3OtJ5AHUPHEsGuVFDL73RWZIjGm+CIXdksHMloVBJmCWtAzBY+epVxE6WuzkxXkka
         jiUP3Yam8FBX6n74q4ZXKCqO+gYasmgRp7T336aG7BKHt3OWhcIn2HZEt8rhSSCciAXb
         Of6BTlR1Y9D9VrrNr7Q+n9OynsGSvxXKkxt6WqMfUpUNBejNA6nrCQqS7ibJsEeAmQDc
         BWUyDtE5cAB5lIyjWr7HJ7qzJvifwvN4IVscXInvfoYiRIaSHgV8SEfipAb5T+oZZ+am
         USyA==
X-Gm-Message-State: AOAM532PsiumkcZ54NU5MIyZzrAKVyElmRB+dLqd8EoGD2oni9Wgn/Wy
        xslx2tzmL7KG7UjEgO06ETc=
X-Google-Smtp-Source: ABdhPJznzggyRk/79IA+xT5bWbdpP4JSaRBdabaQuK+eXTFB9V5Lhw/7RgSKibJiuzBVV34+8FBX4w==
X-Received: by 2002:a17:902:eb54:b029:d1:f365:a668 with SMTP id i20-20020a170902eb54b02900d1f365a668mr21448397pli.69.1600675163838;
        Mon, 21 Sep 2020 00:59:23 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.86.189])
        by smtp.gmail.com with ESMTPSA id y202sm11337177pfc.179.2020.09.21.00.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 00:59:23 -0700 (PDT)
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <441bd08b-ca7d-5977-a455-c4c2a4bd4bc9@gmail.com>
 <a9b7cac1-1993-dbf9-a048-a81c2c39a906@gmail.com>
 <CAP8UFD05qPn6kGRTQGhwABvZbfoH3xcK3VpFo7d5koj9d7mUsg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <8b189b7d-e43f-a6fd-ff43-a02bca9e4132@gmail.com>
Date:   Mon, 21 Sep 2020 13:29:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CAP8UFD05qPn6kGRTQGhwABvZbfoH3xcK3VpFo7d5koj9d7mUsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21-09-2020 09:52, Christian Couder wrote:
> On Sun, Sep 20, 2020 at 6:31 PM Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>>
>> On 07-09-2020 00:26, Kaartic Sivaraam wrote:>
>>>
>>> I'm guessing only the status of submodule has changed as it's being
>>> worked on now.
>>
>> After giving it a second thought, I believe I should take back my word
>> about the git-submodule status changing. There still seems to be some
>> work left for it.
> 
> Yeah, there is some work left, but Shourya said he was interested in
> continuing to work on it.
> 

Yeah, he's most welcome to resume his work :)

>> To be clear,
>>
>> - there's 'add', whose conversion is currently stalled [1]
> 
> Yeah, but it hasn't been stalled for a long time, and sometimes it
> takes time after the GSoC or Outreachy period for former GSoC students
> or Outreachy interns to resume their work.
>

Ok. Got it.

>> - there's 'update', which still has a decent amount of code [2]
>>   in the shell script.
>> - we still have to complete the conversion completely converting
>>   moving the rest of the bits from `git-submodule.sh` to C which is
>>   mostly just the option parsing. This might be more trickier than
>>   it sounds as we would've to ensure the we don't accidentally
>>   change behaviour of the options when moving the option parsing to C.
>>
>>   There's also an e-mail from Junio which is relevant [3]
>>
>> I'm not sure if this would be enough for a complete project on it's own.
>> I'm also not sure whether 'add' would get converted in the meantime. In
>> any case, I believe we could add a few other small refactoring projects
>> to make up for the rest of the period. For instance,
>>
>> - Replace more instances of `the_index` and `the_repository`
>>   (https://github.com/gitgitgadget/git/issues/379)
>>
>> - Turn the `fetch_if_missing` global into a field of `struct repository`
>>   (https://github.com/gitgitgadget/git/issues/251)
>>
>> - Possibly others from #leftoverbits
>>
>> Thoughts?
> 
> Yeah, without 'add' we would have enough related issues for another
> project. I would prefer though that we wait for at least 3 months
> without any progress before suggesting them as a project. That's what
> we usually do and I think it's the right thing to do.
> 

Ok. That makes sense. I also missed the fact that Shourya had also
expressed interested in converting the 'update' part of submodule in his
final GSoC report [A]. So, I agree that it's too early to propose the
rest of the submodule work for Outreachy.

Thanks.


References
===
[A]: https://shouryashukla.blogspot.com/2020/08/the-final-report.html

--
Sivaraam
