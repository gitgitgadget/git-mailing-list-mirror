Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F5C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 08:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbjEJISq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbjEJISk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 04:18:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F294
        for <git@vger.kernel.org>; Wed, 10 May 2023 01:18:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3078cc99232so3880990f8f.3
        for <git@vger.kernel.org>; Wed, 10 May 2023 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683706716; x=1686298716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hs+xakeovaojRFaj2c5Qv+bcTQJw5DGS6qKFFS5ND4U=;
        b=gPbmOgs03sRlb9MriOe1G708FNpRVaxSUTH+GuyISDmIP5dTum/q+T0kpK9F2x8jQC
         NZNNp4mNnNbmeeex3r87+ul2sIf49fJWYHuKebdyiRxoW+H6kmSvy666xoNDX1MaLWpv
         +hCVO7kDGq8mvk0oKP5Vl3mtVQZg6PE1Q/csLV+0EgFxmYYkoKxpifgnMwn2aPTCg/lR
         0wK4si11rle48VvpLoyd0l+LpRMr4RalkFQCXlFVCTQabrOsg4AvHCKQlqMWWA6F/AQa
         Ne6HPI7RV1h2ER8Xt0kV5uP4Rfvmdbb20CMuatb7JVWmlnJQKrrVSVsP8XtteCv82Bf7
         Nnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683706716; x=1686298716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hs+xakeovaojRFaj2c5Qv+bcTQJw5DGS6qKFFS5ND4U=;
        b=Ggyu4w8E71vxCJThC8qp+rHh03CSvmi+ran0IDJgB+pO7ioKKGdyrePT8a8KXSYsOq
         uF8d0Se2iE5y5HafHqCJUV3PKdDyS+WUetkvnXjygUbNYzhbbv89eXgjnNi+CcnFk3RV
         jzpQpl3MUT6/vSePKyT2SzztJwXv+QCoTrwJQlN/GqNoGLXBJMEmmzT6z9ohk4+fd/FR
         IoFhPV0rpE8+IsYfIqa7yWE5kQog6J/yI+VD9wm5XCVIHjP7bYKdkHfkKOsf2O+WCacS
         mduPjT8Q6p3bZsGnMexKGCFisi8MkBDs428Dle1beSJhpLkhIG+TnaPRgErthqOnqcUe
         HK1Q==
X-Gm-Message-State: AC+VfDyS5dD7cBcJoQi1TS0Kmpp3zAqIEScLDlrO0Btp/U9Rtua+91zf
        V9i/3fx8KcKEJhyvy4ENFv4=
X-Google-Smtp-Source: ACHHUZ6gh73Vl+q2dyASAQ+LgnI6QA6YygRFQXYWzquOL3mjaGJZlt/pFRrZvPpyQXVdmzAuUSn0oA==
X-Received: by 2002:adf:e849:0:b0:2fa:27ef:93d7 with SMTP id d9-20020adfe849000000b002fa27ef93d7mr12146957wrn.42.1683706716299;
        Wed, 10 May 2023 01:18:36 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f188f608b9sm21976580wmf.8.2023.05.10.01.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 01:18:36 -0700 (PDT)
Message-ID: <3808fc35-6d3d-5a91-3eac-9428ff0e8045@gmail.com>
Date:   Wed, 10 May 2023 09:18:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        phillip.wood@dunelm.org.uk
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <230502.86wn1qhemd.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <230502.86wn1qhemd.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 02/05/2023 17:34, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Apr 27 2023, Phillip Wood wrote:
> 
>> Hi Calvin
>>
>> On 27/04/2023 18:50, Calvin Wan wrote:
>>> Introduces the C TAP harness from https://github.com/rra/c-tap-harness/
>>> There is also more complete documentation at
>>> https://www.eyrie.org/~eagle/software/c-tap-harness/
>>
>> I'm afraid this reply is rather briefer than I'd like but I'm short of
>> time and about to go off-list for a couple of weeks. My ideal unit
>> test library would
>>
>>   - print the file and line number of failed assertions
>>   - allow the test plan to be omitted by calling test_done() at the end
>>     of the test file as we do in our main test suite.
>>   - support the TODO directive
>>   - allow named tests (this maybe more trouble that it is worth as I
>>     think it inevitably leads to more boilerplate code calling the named
>>     tests)
>>
>> Unfortunately this library doesn't seem to offer any of those
>> features. It does support a lazy test plan but uses atexit() so will
>> not detect if the test program exits before all the tests have run. I
>> think it would be useful to add some unit tests to our test suite and
>> maybe this library could form the basis of that but I think printing
>> the file and line number of failed assertions is pretty essential.
> 
> Other things aside, I prefer our explicit "test_done", but I don't see
> why you think an atexit() isn't enough to catch incomplete tests.
>
> For a C program you'd just do something like this (somewhat pseudocode,
> I didn't check if it compiled etc):
> 	
>          static int done; /* read by atexit() handler */
> 
>          void on_atexit(void)
> 	{
> 		if (!done)
> 			BUG();
>          	print_plan_line();
> 	}
> 
> 	int main(void)
> 	{
>                  int ret;
> 
> 	        setup_atexit(a_handler);
> 		ret = do_tests();
> 	        done = 1;
> 
>                  return ret;
> 	}
> 
> If I'm understanding you correctly you're concerned that if some user
> code within do_test() calls exit() we won't return from "do_test()", but
> we *would* call print_plan_line().

Exactly

> That's a valid concern, we want to distinguish such "early return" from
> cases where we run to completion, that's why we use "test_done" in the
> shell code.
> 
> But in the C case I think just using something like the "done" variable
> pattern above should cover that, without the need for an explicit
> "test_done".

We could do that. My complaint is that the code being proposed does not 
and so prints a valid plan if any code being tested calls exit()

Best Wishes

Phillip
