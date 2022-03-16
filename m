Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EBAC433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 20:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352786AbiCPUI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 16:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343924AbiCPUI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 16:08:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB22BB2D
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:07:11 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso3500556pjo.5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 13:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=90aqLC9G7+LwOf/2xIOfJJiC4DdwbPKbPbpIT78HpxU=;
        b=LwOENd9rdpV5Q2vIsw5ivPRv3f4oyyjMKKC2LdKw3U5aiTym3UNbc0ZKISr4aqIz8T
         cJxuiB2x6qyABWKFUHSG3OqPZL87PXOY3Tlpq4TUocm10fG1cVngj8h2IMFp28Ctn/Y8
         P0nPp85sAUA2g/hdG7W17TpFdXB5Rv4/qJ9lV0k0SM0+ZdvwtrdBRXDod8x1uyTs+uRI
         f8Av3m0W878llqOc/gYIfncPvABlf5LOGg3pAqfHzpcyi8/YU2n4fliSmjyXjznzsuPg
         CgrapxWqNSuCCl1yLMynP/rZ2SLxhuPS9TogPvLc3iWMxPXzTJ00JtUieUe251IVfjtp
         hduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=90aqLC9G7+LwOf/2xIOfJJiC4DdwbPKbPbpIT78HpxU=;
        b=bWMPECRwulwa+3zvW+RgX/UqKYUXcr9kGCRXNu2bu4FqIp9936HjUUAW+RPeMOgPBQ
         cCtMQsxgzPjP764pb1HAiXPZuyzLfxreR3rv8frCg2djs9gZ0H92dDNhHpShlF822v3y
         qZCZy0fvXNa9gT+wOn4bTCz7A7lG8eUCPrPNchuF7neeJzpmo2yaUWqJUuGUaNchHwxJ
         UNFCzjx/dja3jz5QsbfKkxMH4DJRczdJsCN/BU7SbBEDtVimt8EyZVqvu7zuI0b5BkNU
         bUOhYcT9ageO5HJQAlfsjrLWTYdLaVRfFLlKvMZh73F4NBcY64XzoA2pyQBv9EFeJdrK
         IfIA==
X-Gm-Message-State: AOAM530/GtyYMFMHDhGDKUtxrpp4ZKOTbH3rhyQYuuSzg5oIIRpuRx+d
        4f2sPtZXKaiZW0haRs5mF8vHLfiQr3jE
X-Google-Smtp-Source: ABdhPJzOnvRcfTZNntUsy57Z0MCBOjwS2oUuCICZeYCqUkpwNSSZAWCuWakiyp+j/xMXsGySsR43bQ==
X-Received: by 2002:a17:902:c407:b0:151:f794:ac5e with SMTP id k7-20020a170902c40700b00151f794ac5emr1588287plk.67.1647461231051;
        Wed, 16 Mar 2022 13:07:11 -0700 (PDT)
Received: from [192.168.0.102] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id ca9-20020a17090af30900b001c658fd7b47sm3394598pjb.36.2022.03.16.13.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 13:07:10 -0700 (PDT)
Message-ID: <a4a7c3ea-3a40-1110-1c1e-a089daf01281@github.com>
Date:   Wed, 16 Mar 2022 13:07:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] stash: make internal resets quiet and refresh
 index
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
 <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
 <4c45351a0c4b8b955a9101ed9445a763750ca3c3.1647308982.git.gitgitgadget@gmail.com>
 <xmqqee33h5ty.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqee33h5ty.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +test_expect_success 'apply --index -q is quiet' '
> 
> Hmph.  So being quiet and refreshing index are tested separately in
> different tests, and this one is only about being quiet?
> 

Yes, because the changes in this series only correct the "quietness" of 'git
apply --index -q'. Similarly, there are two instances where '--refresh' was
added to 'reset's in 'stash', and two corresponding tests added here.

> I wonder if a single test that checks chattiness and refreshing of
> "git stash -q" and "git apply --index -q" (that's 2x2 which is 4)
> would be sufficient?
> 
>> +	# Added file, deleted file, modified file all staged for commit
>> +	echo foo >new-file &&
>> +	echo test >file &&
>> +	git add new-file file &&
>> +	git rm other-file &&
>> +
>> +	git stash &&
> 
> As this is only about chattiness about "apply --index -q", this
> command goes unchecked (4 - 2 = 2).
> 
>> +	git stash apply --index -q >output.out 2>&1 &&
> 
> And this is only about chattiness so we do not test if the index
> gets refreshed after this operation (2 - 1 = 1).
> 
>> +	test_must_be_empty output.out
> 
> This ensures that "git stash apply --index -q" is silent, as that is
> the main objective of this step: make sure reset won't chatter,
> especially when stash is told to be --quiet, which is good.
> 
> But with a few more lines, this set-up can also test the other three
> with minimum additional effort, no?
> 

I like having the "quietness" and "refresh" checks separate because they're
not inextricably linked. One could fail while the other doesn't (or both
could independently fail), where two separate results would be slightly more
helpful information for a developer debugging the tests. The same reasoning
applies to 'stash push' with 'stash apply' (they can fail independently, so
they're tested separately). 

I'm not normally super adherent to a "test each mode of failure separately"
paradigm (evidenced by some of the more complicated tests in
't1092-sparse-checkout-compatibility'), but 't3903-stash.sh' already has
dedicated'-q' tests separate from other functionality tests, so I followed
the precedent.

>> +'
>> +
>>  test_expect_success 'save -q is quiet' '
>>  	git stash save --quiet >output.out 2>&1 &&
>>  	test_must_be_empty output.out
>> @@ -291,6 +303,27 @@ test_expect_success 'drop -q is quiet' '
>>  	test_must_be_empty output.out
>>  '
>>  
>> +test_expect_success 'stash push -q --staged refreshes the index' '
>> +	git reset --hard &&
>> +	echo test >file &&
>> +	git add file &&
>> +	git stash push -q --staged &&
> 
> "git stash" and "git stash push -q --staged" may do different
> things, so leaving the plain "git stash" untested for refreshing in
> an earlier test, and "git stash" with different options being tested
> for refreshing here, makes me wonder about a gap in test coverage.
> 

Yes and no, I think. There is a gap in that stash is not otherwise tested for index refresh, but in the context of this series, that's primarily a concern where 'git reset [--mixed] -q' is used internally - if the refresh didn't happen, the command could (incorrectly) fail altogether. The new tests cover usage of 'stash' wherever a unique 'git reset [--mixed]' exists, and those are theoretically the main sources of a failure-inducing non-refreshed index.

> The overall theme of the whole topic was that chatty output from
> "git reset" run as an implementation detail seeps through from "git
> stash", IIUC.  So, making sure that our index is refreshed after the
> operation is good, but at the same time, wouldn't we want to see
> what the output of this command says (or be silent)?

The goal of this series was to fix 'git stash apply --index -q' specifically
- it's a somewhat narrow scope, to the point where I would have included it
in another series I'm working on if it weren't for the other changes needed
in 'reset'. In line with that, I tried to keep the tests here tied
one-to-one with the changes made in 'stash':

* add '-q' to 'reset_head()' -> 'apply --index -q is quiet'
* add '--refresh' to 'reset_head()' -> 'stash apply -q --index refreshes the
  index'
* add '--refresh' to 'do_push_stash()' -> 'stash push -q --staged refreshes
  the index'

So while I do think 'stash' testing could be expanded, my intention with
this particular series was to unblock changes relying on 'git stash apply
--index -q' to work properly. If I'm making this too narrowly-scoped,
though, I can submit a patch on top of this one that more broadly expands
testing in 'stash' for '-q'. Let me know what you think!
