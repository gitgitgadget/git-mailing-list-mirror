Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631A3CE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 13:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjIXN6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjIXN6G (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 09:58:06 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA07AF
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 06:58:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32325534cfaso423413f8f.3
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 06:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695563879; x=1696168679; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jkivSLF8LWkHwpJE/R7ZqliFx5WPPYpt6faXncr4zWM=;
        b=ZHnXWh3cYxxwXN6UionB4U1nk+wPB0pKWMVv7M7agFVwz0DNQ5ooY/cJV27kwgZjrr
         liDjwOi2QeIrpUlJdGOKPGhT7AV+0yUC0k7JJzMeCX4Hpg/otAZkb7nSB/0keERb6fPF
         LFwPyNWiNXCX13st/Hziah2gDLgDw3bmHlCt3xeOzAigWYJIOtwnxvo3lw26K1BK5hj6
         eq8rVzp+br9BRv64mkAaBoUWGAcL0GddNWFCbpOyuxqFkhwpha43XVyviG+yzLINFRcA
         pOWfxLXnCdPuGK9mpjI1c76vxPQ8s6L8oHsywGJQMKNLGKOJLZs7nmi6HuPLrfds3CB/
         jZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695563879; x=1696168679;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkivSLF8LWkHwpJE/R7ZqliFx5WPPYpt6faXncr4zWM=;
        b=ZzF1uUtquE7+W5uhBA+dFWYSPOTluqbjYYiA0KGGaCe5/vEcqjfrx51jjMriqYkEdR
         PXbAMB/FJXIEm6Q9Tg8JuV6M347Jh1wOwhckoRChXVDXQF/HvITQTqGMbh3MnQUmQQXE
         LB8uFHkxeQdO9uzdK+loRHcIh1yjjFFkDcuzWa0adDrWQeSTdRt0sCkrdJcv5odm6Ciw
         si4sBua6wW00d8O2uH5MDDTucgv7J5gTDpUTu6Ud5ITKI5ppDiTHAUYIzggrRTQo2ngw
         eaXfcjqRxwTYsxpsuYU7oFeF1UCLMc87QGNywN8Gp8knWrlQjyqPjDzxeOT6x91gGUEM
         QMcA==
X-Gm-Message-State: AOJu0YwZQrhX+tuoR3oXd7F2Fh4SgYGYxmynp2D+W/D/R3L+LvIyeY2C
        7fFf/34ffYoOe9bcROvy+cQ=
X-Google-Smtp-Source: AGHT+IGY2zoR12j/2XlHgVO35YhChnuOZ34g3bEbkstko1g8r9ySifCnvpqHggiWep3XtVqGFVWIpw==
X-Received: by 2002:adf:fd01:0:b0:322:5d58:99b4 with SMTP id e1-20020adffd01000000b003225d5899b4mr3559855wrr.0.1695563878824;
        Sun, 24 Sep 2023 06:57:58 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c229700b00403b63e87f2sm9743168wmf.32.2023.09.24.06.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 06:57:58 -0700 (PDT)
Message-ID: <0b6de919-8dbf-454f-807b-5abb64388cb7@gmail.com>
Date:   Sun, 24 Sep 2023 14:57:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 2/3] unit tests: add TAP unit test framework
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        linusa@google.com, calvinwan@google.com, rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692297001.git.steadmon@google.com>
 <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
 <xmqq350hw6n7.fsf@gitster.g> <xmqqa5te0y9r.fsf@gitster.g>
In-Reply-To: <xmqqa5te0y9r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 22/09/2023 21:05, Junio C Hamano wrote:
> It seems this got stuck during Josh's absense and I didn't ping it
> further, but I should have noticed that you are the author of this
> patch, and pinged you in the meantime.

Sorry I meant to reply when I saw your first message but then didn't get 
round to it.

> Any thought on the "polarity" of the return values from the
> assertion?  I still find it confusing and hard to follow.

When I was writing this I was torn between whether to follow our usual 
convention of returning zero for success and minus one for failure or to 
return one for success and zero for failure. In the end I decided to go 
with the former but I tend to agree with you that the latter would be 
easier to understand.

>>> +test_expect_success 'TAP output from unit tests' '
>>> [...]
>>> +	ok 19 - test with no checks returns -1
>>> +	1..19
>>> +	EOF
>>
>> Presumably t-basic will serve as a catalog of check_* functions and
>> the test binary, together with this test piece, will keep growing as
>> we gain features in the unit tests infrastructure.  I wonder how
>> maintainable the above is, though.  When we acquire new test, we
>> would need to renumber.  What if multiple developers add new
>> features to the catalog at the same time?

I think we could just add new tests to the end so we'd only need to 
change the "1..19" line. That will become a source of merge conflicts if 
multiple developers add new features at the same time though. Having 
several unit test programs called from separate tests in t0080 might 
help with that.

>>> diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
>>> new file mode 100644
>>> index 0000000000..e292d58348
>>> --- /dev/null
>>> +++ b/t/unit-tests/.gitignore
>>> @@ -0,0 +1,2 @@
>>> +/t-basic
>>> +/t-strbuf
>>
>> Also, can we come up with some naming convention so that we do not
>> have to keep adding to this file every time we add a new test
>> script?

Perhaps we should put the unit test binaries in a separate directory so 
we can just add that directory to .gitignore.

Best Wishes

Phillip
