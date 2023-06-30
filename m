Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F87EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 09:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbjF3JtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjF3Js6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 05:48:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626961AE
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 02:48:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98d34f1e54fso182648466b.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688118533; x=1690710533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NkMjsR0k97abyCxVBAfMApz9d8Qj02WQczeCKGnIp3w=;
        b=nnBRZ+jeX5nZ1+RLwSyCc4kwhhXa0v8cj5DcmEs/3Cn8hP57alAziKdNjeviKU+eeo
         BtPZrUONI5MycCasGSGO8ZOkAFMucFtEFh67CSRRyR57uUVHpDq47J2u7dUfMHqq4x0v
         4s0ByZ8HbZCW9ly7iC5wZNXxt7qjVf1LGaRio8Y5LUDmyEyivMqA06pFQrmLQpJxdEic
         puDNKXdghJVSQ6mJS+tBTlhNF3jN9CyX7OZHC1AhpPrdnRq8mkoK3cTSX0r3dNcnFeF9
         HLxcn95u2mM1enRqXNhfkB5sAEYD44HniPFlT6qZ+P8x9j1Wwp8Bdw61U12PAh6kDTca
         6ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688118533; x=1690710533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkMjsR0k97abyCxVBAfMApz9d8Qj02WQczeCKGnIp3w=;
        b=PQUpp57aUVAZbMrPsEqfKKil9MBLZJE0bqi3GfkOWOGc2gw/gV9eWuP30mBU6qyf2g
         WiWv8Nc6oPhP16eySY+GphPeq177yDrCwHqTG8b86ZHyw1TLagMyqBykCHQ0lW/uXV7r
         EqoCSa0Gyi8FyyORfbVa2ehNQU5MFHtvRJZ8mII/E2DsdRI2HmWJTKiwGsNfgMCoyxsA
         4El0vJ3cROJ6isl9xMXQkFAIX14mvZKTZul1uc1JBffWocz/+0bqkiI/OxJxeHjSJZtF
         WHke0NeF9MVJVjKuaREVPb2UJQhv+h5QhRtx8HC2NlaUjfk4HBsKfyO4xlkLiR90yOFp
         FNtg==
X-Gm-Message-State: ABy/qLZ7yNnditHVIg5b71xskAFWcxkZTqaiNfKZ/vxtPT/xBATJnMg5
        Po6r/mG2/jBpgzJ4CfSc71E=
X-Google-Smtp-Source: APBJJlG1hoevwlKMlDAoyPOfNPzZtkv4o//u/ghiehXH0bkVSufGEeubSswWiYuXQ4QwD2JyqXvNwQ==
X-Received: by 2002:a17:906:81d8:b0:98d:ffdf:29cb with SMTP id e24-20020a17090681d800b0098dffdf29cbmr1291120ejx.2.1688118532491;
        Fri, 30 Jun 2023 02:48:52 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id jt24-20020a170906dfd800b009788554ad10sm7799170ejc.138.2023.06.30.02.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 02:48:51 -0700 (PDT)
Message-ID: <7a375796-aadd-a982-430c-a78b27bac59b@gmail.com>
Date:   Fri, 30 Jun 2023 10:48:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Linus Arver <linusa@google.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
References: <20230427175007.902278-1-calvinwan@google.com>
 <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com>
 <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
 <owly8rcc3j1u.fsf@fine.c.googlers.com>
 <a6dff108-6946-71e7-99dc-ac3b70f7d7fa@gmail.com> <ZJ0cIKrSVmwMy6F4@ugly>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ZJ0cIKrSVmwMy6F4@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/06/2023 06:52, Oswald Buddenhagen wrote:
> On Mon, Jun 26, 2023 at 02:15:39PM +0100, Phillip Wood wrote:
>> On 21/06/2023 16:57, Linus Arver wrote:
>>> - Make the 'TEST' macro accept the test description first. Or, keep the
>>>    'TEST' macro but also name a new macro 'IT' that accepts the
>>>    description first, to encourage usage that reads in a
>>>    behavior-driven-development (BDD) style, like 'IT("should accept 
>>> foo",
>>>    t_bar(...))'. I find some test descriptions easier to write this way.
>>
>> The test description is a printf style format string followed by 
>> arguments. This allows parameterized tests to include the parameter 
>> values in the description to aid debugging but it means the test 
>> function must be the first parameter. We could have IT("should accept 
>> %d", t(), i) but that would be a bit weird.
>>
> with some minor preprocessor magic [1], you could make that
> 
>    IT(("should accept %d", i), t(i))
> 
> which would be somewhat more noisy, but arguably even somewhat clearer.
> notably,
> 
>    IT("should accept foo", t())
> 
> would still work with the same macro.
> 
> [1] https://stackoverflow.com/a/62984543/3685191

Thanks, I'd not come across that trick before. As you say it is a it 
noisy though.

> somewhat on a tangent: it's also possible to overload macros on argument 
> count [2], which may also come in handy.
> 
> [2] https://stackoverflow.com/a/24028231/3685191

When I was writing my original reply to Linus I did wonder if we could 
count the arguments. I didn't pursue it as I don't really want to create 
a dozen different macros for different argument counts. I think TEST() 
is understandable by anyone reading the code whereas IT() seems a bit 
odd unless one is used to BDD.

Best Wishes

Phillip

