Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981FC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 13:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E377722268
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 13:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSYaxmu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgJSNqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgJSNqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 09:46:04 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547FC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 06:46:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z22so56328wmi.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/t1IfaXICSkjzwhA1c2tPINvVyA4JbGzJB4nl4A9Tdw=;
        b=RSYaxmu0V6OmImfg88HZpfuvFM5ikLfBMUR2G2lxXPoDRqvqNWz/gWYVmTX0aI25zf
         TZXl0walmatxJ2zTVbtTvaD1dV5CNgrNkSfczsrWmpckSDKylK2gFR57TQU+GS1deEHE
         5R3dyqGe2Fe3kAQW03mPtpFS0gQk6tgim4BQawyyvvGYKS5Q02W0nX8wMGlZSD64NlOu
         BGPLpu6q0xCmR0XmT9Y8j4MCR+tSTUKjmuuJ6Mbg7XQeOpdcwi0ZmPIonCAWZYaHArGJ
         DOVPwohl4fLIUcLYyqT4QjSnGEpbw0QkrXRyA+/buq5/S7hqD+hgMT5kUkdPTwqU1zLH
         bk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/t1IfaXICSkjzwhA1c2tPINvVyA4JbGzJB4nl4A9Tdw=;
        b=Y1FQibGP0jH7PFc45wzx6qSAwSOjHymnz6mSnpYSgHvR9Me/s9IedqHTMcoJytJkII
         10VWeJuimbZ6z7UfdHT6gPYGQWiUgzogkBoxXNXKDHKWVBdvexAoDt42CS+QP58jbx4g
         7ndiMYelhME/IvwJdTyNpeK8ZHYtmB0mK4ny3apkCxDvAAuQQSGMrP+zaw7ITjTuOpfL
         OXJt3e5u5Rtav1cPIwRdH5JW4aY8/+z9wecyzkQ0gy0BbJgUhIbzia1elDSS2vZ3JEzf
         5zEmLPvVSmnIwePLZlvPQAFvu0XGNNr7HOvO7cfeZZTNew/jnJAscPxhK55D7+VCkV5h
         k0bQ==
X-Gm-Message-State: AOAM531MItUkLbR7ohXyJvKgOKV7b/6EeI4QMb4G4IoIcP94/fhX2bWd
        n3E5rAUyjlHa8gc/f0gTKfeYuQZhrcc=
X-Google-Smtp-Source: ABdhPJyFjLYwyAG9KnFBBCfM6oorbE9zitbrStwvp96CtRtwTZRXybCLId+bTJY9OwjccAyev/+ORA==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr17133519wmh.72.1603115162629;
        Mon, 19 Oct 2020 06:46:02 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id v189sm118175wmg.14.2020.10.19.06.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 06:46:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of
 subshells
To:     Charvi Mendiratta <charvi077@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
 <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com>
 <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com>
Date:   Mon, 19 Oct 2020 14:46:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Charvi

On 19/10/2020 13:55, Charvi Mendiratta wrote:
> On Sun, 18 Oct 2020 at 21:09, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Charvi
>>
>> Congratulations on posting your first patch series.
>>
>> On 17/10/2020 08:54, Charvi Mendiratta wrote:
>>> Avoid using `cd` outside of subshells since, if the test fails, there is no guarantee that the current working directory is the expected one, which may cause subsequent tests to run in the wrong directory.
>>
>> That is an accurate description of why we want to avoid using `cd`
>> outside of subshells. However this conversion is converting `cd` inside
>> a subshell to use `git -C`. I think that is worthwhile as it avoids
>> having to use a subshell but the description should say explain that the
>> conversion is desirable to avoid the cost of starting a subshell as the
>> original test does not suffer from the problem described in your commit
>> message.
>>
> 
> Thank you Philip, for corrections . I somewhat able to understand that
> commit message
> should be " avoid using cd inside the subshells " because running a
> shell script itselfs starts
> a new subshell, please correct me if I am wrong . But still I am
> unable to get that why you
> mentioned the description as "cost of starting a new subshell " . Will
> this not be the same subshell ?

The original test looks something like
(
	cd sub &&
	git something
) &&

The commands between the ( and ) are executed in a subshell, any changes 
made to the current directory or shell variables in the subshell do not 
affect the rest of the test script. This is because the subshell starts 
a separate shell process, but creating this separate process has a cost 
associated with it.

The modified test looks like
	git -C sub something

Here we tell git to change directory before it runs the 'something' 
command, this is more efficient as we don't need to start any extra 
processes - there are no subshells.

So the purpose of this change is not to "avoid using cd inside a 
subshell" but to avoid having to use a subshell at all.

I hope that helps explain what a subshell is and why we want to avoid 
using it if we can, do let me know if you want me to clarify anything.

Best Wishes

Phillip


>> Best Wishes
>>
>> Phillip
>>
>>>
>>> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
>>> ---
>>>    t/t7201-co.sh | 10 ++--------
>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
>>> index 74553f991b..5898182fd2 100755
>>> --- a/t/t7201-co.sh
>>> +++ b/t/t7201-co.sh
>>> @@ -339,10 +339,7 @@ test_expect_success 'switch branches while in subdirectory' '
>>>        git checkout master &&
>>>
>>>        mkdir subs &&
>>> -     (
>>> -             cd subs &&
>>> -             git checkout side
>>> -     ) &&
> 
> Is there any specific meaning of writing these above two commands in
> parentheses . Will this not work the same without it ?
> 
>>> +     git -C subs checkout side &&
>>>        ! test -f subs/one &&
>>>        rm -fr subs
>>>    '
>>> @@ -357,10 +354,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
>>>
>>>        git checkout master &&
>>>        mkdir -p subs &&
>>> -     (
>>> -             cd subs &&
>>> -             git checkout side -- bero
>>> -     ) &&
>>> +     git -C subs checkout side -- bero &&
>>>        test -f subs/bero
>>>    '
>>>
>>>
> Thanks and Regards ,
> Charvi
> 
