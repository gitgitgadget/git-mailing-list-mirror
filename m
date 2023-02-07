Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD3EC636CD
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 10:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjBGKwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjBGKwm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 05:52:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB99527B
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 02:52:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so13135925wru.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 02:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZANo29lMh4zoWEWeVxZ/VhTX8QsTGkk7Ht0zKjs3F38=;
        b=aY1iMCXmG3ILVmXfu3XA44gMxd5rYhB+wHoEPwDmgC9sgqXQ9Da7bv5eYgU9vZHYjr
         v49EFAzL7wqriPdm5stsmodcJCUWCs/VfY7/eyiVAbgil7XqZV9YmcRoPuiY5EJUfCFz
         JpwL2fl1ItzcX2s4SR3Kk1+ptDefwJr/10Nm8etobAQlzLI8HpGtcrWhn6nCRVAxCsZS
         Qw5i6m1Hr7aHS29rYJmtKn0v+IYleTjL21zJxUvGiPjIIIPjQVJ5GPiwIrvS3UqdkC+w
         y3BhZYoZ0cBge9CKvC6Iz4w2JQO3/R3cfRb5+1h0SHNBzI9BNH5FGSTZRdFQOUyZoReK
         05TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZANo29lMh4zoWEWeVxZ/VhTX8QsTGkk7Ht0zKjs3F38=;
        b=xwzuXuBU24B33CH0n/5bp2b/qv/cAgSKhoN9DPovm6r6cC6RBFX2YVr87TP5h1nJwU
         DyeZrq9325JB943BzJnK8SfJnWBCoygebPxZVuzpa0ALM8AjUOCH7iGgzQWaHlQIAw8m
         XwKDGwqvnLxTLVLAJWPrqOjKWw5i32WQAkrsKGoJoimdrodFZrTNrn9q6GolHSCfCNXm
         bHewqXCKHvXbK2xgaHnREl23alfDOWSbX524BoB+UwuBe0VDbHjSL76SUMFXj2F9xlM1
         40COTbCC/p9giO3Fm3CS8O6OXeKA3INkhHBrv5SgUXhjEyLCgoeGm7EYulcRytXt7hRt
         6K6g==
X-Gm-Message-State: AO0yUKXM2S3rYn9M1WVqa5XzoSV0D9KIMIop4MGooenbTdQiW+zFFFfU
        DMtTROchtVHVgej2phS9oC8=
X-Google-Smtp-Source: AK7set/giSmQbLbpkw0613qCQS+pD0te0qBkPeZrMD1l03CYitzE381B2BFzqlN0qcaT7ec9zuwzIQ==
X-Received: by 2002:adf:db45:0:b0:2bf:9459:255 with SMTP id f5-20020adfdb45000000b002bf94590255mr1905716wrj.70.1675767159777;
        Tue, 07 Feb 2023 02:52:39 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d6d8a000000b002bfb5bda59asm11635604wrs.25.2023.02.07.02.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:52:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f4be3c97-eb15-790e-9746-96d0c9bbc5a7@dunelm.org.uk>
Date:   Tue, 7 Feb 2023 10:52:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 3/4] rebase: refuse to switch to a branch already
 checked out elsewhere (test)
Content-Language: en-US
To:     =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <5b0d5b6e-5055-6323-1b6c-fe98137e81f6@gmail.com>
 <230206.86wn4u6859.gmgdl@evledraar.gmail.com>
 <4580b825-b117-4581-4ea2-ab30e350b6ad@gmail.com>
In-Reply-To: <4580b825-b117-4581-4ea2-ab30e350b6ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rubén

On 06/02/2023 23:16, Rubén Justo wrote:
> On 06-feb-2023 17:59:11, Ævar Arnfjörð Bjarmason wrote:
> 
>>> Let's add a test to notice if this changes in the future.
>>
>> I for one would find this series much easier to follow if you started
>> with this test, possibly with a test_expect_failure, and as we fix the
>> relevant code flip them (both this and the subsequent one) to run
>> successfully, and include them as part of the commit that fixes the
>> bug).
>>
>> Maybe there's reasons for why that's tricky to do in this case, so
>> please ignore this if so.
> 
> I'll give it try, I like the idea.  Thanks.

Squashing the last three commits together so that the tests are 
introduced in the same commit as the fix as Junio suggested in his 
comments on the previous round would be very welcome.

Best Wishes

Phillip
