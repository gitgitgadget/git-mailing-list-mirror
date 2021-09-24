Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC80C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970BE61211
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 10:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbhIXKK7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245535AbhIXKK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 06:10:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06F6C061574
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:09:25 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so25789044wrb.3
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N9iGIkROelZjuSbnG3twhMt8a0RM4PRfIGYiy1jsCDY=;
        b=kq6uDee2BzNiXi2rnuyMA23D/YCvnzvBYBej3nLACWT1vPTZzuL5C947NJj3p6mwYR
         ZjbsmILQu+QfvwEMaJF9IdQkgzun13W4CTCMQzTk41ISyI2sjceHPIp+bc19hhfYCqZ4
         DpgRC15QG58V+hGU8fhUiWUbWu6uqszzUMKX2rdKCzkb2SFdNL+mqL45/X/mWCdOTlEp
         5HC/ubc/hMzaFPqHXD0f1481y/uR4YbfzPHRThRql4BOmMx9BfVTp1ihk8rhwE95pe3R
         vr4kPk0uN8rx8t8bS9Az6Wk6CjrBmkIxUcySK8omW8YbKwjkA0vl9K2ZBwrOOLCiUCne
         p1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N9iGIkROelZjuSbnG3twhMt8a0RM4PRfIGYiy1jsCDY=;
        b=5u7a9pAu9SwXUgmsS3XQTN0qt5TkYyD68M7/xJI4em0Ld4W1jsvnXbO98vbT6Bz29b
         MxpKhYAMqlWNUpbd8AxUFUp9wTlMBX0D6z0UMpvtJ9UAJK6I5eJU3qynufneo/HtkIfC
         Lpn17buveNsqBYyFprhPsW6hJb/1izPG9y4hb8Qhx4teCOjr3oTx0af4DBXyFQzCpstY
         ig7QZm1nkMrfHdYrwRMfFMg8sSkEvBHdJuyrfXn6VKlUbDqUfd3d2kGKcn5P3EeRRYFs
         DUyn4i81s7WGC03jAZ6CVTFnDMnR98/4BM57l9mRNntOAWVIBOgdF+6pqv3u4R84rvdw
         ZFdg==
X-Gm-Message-State: AOAM530Ch8lCOJ/H9oaA6W7EdY0d3lfQpoqREULi6FZuecow/RDKLFi8
        UKy3S2ZUZT43MrFLGn3TTy0=
X-Google-Smtp-Source: ABdhPJyCDzUAe4pTUkACyfvC53SkYLUThKmYkvlAnuTuwh9LP5ggxmMPl5MTg9Rx5cOCg8GjnLU/IA==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr1240325wmj.144.1632478164372;
        Fri, 24 Sep 2021 03:09:24 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id o3sm8167575wra.52.2021.09.24.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 03:09:23 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] xdiff: implement a zealous diff3, or "zdiff3"
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com>
 <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
 <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com>
 <2290b657-3c67-0ab8-5c25-cc57feac301c@gmail.com>
 <CABPp-BHXUNTuYPdCzfKhkvr23W3PODzti84bed6uEP5q+sj0TQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <69635d07-7b4e-e94e-db98-0b8f4ea566d7@gmail.com>
Date:   Fri, 24 Sep 2021 11:09:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHXUNTuYPdCzfKhkvr23W3PODzti84bed6uEP5q+sj0TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/09/2021 23:06, Elijah Newren wrote:
> On Wed, Sep 15, 2021 at 4:22 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 15/09/2021 11:25, Phillip Wood wrote:
>>> I do wonder (though a brief try failed to trigger it) if there are cases
>>> where the diff algorithm does something "clever" which means it does not
>>> treat a common prefix or suffix as unchanged (see d2f82950a9
>>> ("Re(-re)*fix trim_common_tail()", 2007-12-20) for a related issue). We
>>> could just trim the common prefix and suffix from the two sides
>>> ourselves using xdl_recmatch().
>>
>> Here is an evil test case that shows this problem (diff on top of your patch)
>>
>>
>> diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
>> index de9c6190b9..836843c6b0 100755
>> --- a/t/t6427-diff3-conflict-markers.sh
>> +++ b/t/t6427-diff3-conflict-markers.sh
>> @@ -219,8 +219,9 @@ test_setup_zdiff3 () {
>>                   test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
>>                   test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
>>                   test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
>> +               test_write_lines 1 2 3 4 5 6 7 8 9 >evil &&
>>
>> -               git add basic middle-common &&
>> +               git add basic middle-common interesting evil &&
>>                   git commit -m base &&
>>
>>                   git branch left &&
>> @@ -230,19 +231,21 @@ test_setup_zdiff3 () {
>>                   test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
>>                   test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
>>                   test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
>> +               test_write_lines 1 2 3 4 X A B C 7 8 9 >evil &&
>>                   git add -u &&
>>                   git commit -m letters &&
>>
>>                   git checkout right &&
>>                   test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
>>                   test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
>>                   test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
>> +               test_write_lines 1 2 3 4 Y A B C B C 7 8 9 >evil &&
>>                   git add -u &&
>>                   git commit -m permuted
>>           )
>>    }
>>
>> -test_expect_failure 'check zdiff3 markers' '
>> +test_expect_success 'check zdiff3 markers' '
> 
> ...except your new testcase makes it fail.

Sorry I meant to remove that, I'd changed it to test_expect_success so I 
could poke about in the test repo when it failed.

Best Wishes

Phillip

> 
>>           test_setup_zdiff3 &&
>>           (
>>                   cd zdiff3 &&
>> @@ -251,6 +254,14 @@ test_expect_failure 'check zdiff3 markers' '
>>
>>                   test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
>>
>> +               test_write_lines \
>> +                       1 2 3 4 \
>> +                       "<<<<<<< HEAD" X A \
>> +                       "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= \
>> +                       Y A B C ">>>>>>> right^0" \
>> +                       B C 7 8 9 >expect &&
>> +               test_cmp expect evil &&
>> +
> 
> Yeah, this is an interesting testcase, and I agree with the 'expect'
> choice you wrote, but the current code doesn't produce it.  I'll
> update the patches and send out another round, and then do you want to
> try your xdl_recmatch() magic to fix this testcase?
> 

