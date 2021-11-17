Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BD8C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537BC61350
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 18:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhKQScN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 13:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKQScM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 13:32:12 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B4AC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 10:29:14 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z26so4466288iod.10
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mODlgLUFPu90LW9MI5iBS9EuUMXLA8l/luRyJvb/Vew=;
        b=hh8BmU1pcd7X+2019T9zQECi6VP2dsAuLYw2+gvUctLNoVaiyQfEHzd87mLSYGV4Ww
         K5eXfjr61Ypi/HrUVxOzYH5nJM1sF99RSIkUPRGLHTKQC2VgDsS/7VYVVmW4wyxzwida
         wTXEKVQZh2/MUgi08yd9sIt7lo7qZH3Uup4CPeceZ6ZzKnQeGRTJD2mXyTz1DsbeBGnP
         2JNtAIjt2rBfc5Jf3mutSckoRI9AP8WTK3LWfQnzckkxc2P4LNOy1CG8Cvr0WAvrDc89
         F3/+Cgfqw/eEZu8Y5wSPs1qDTIcQZM4sH5uITKCx+usRPt+hqDkmi7kYu89ufRF7dOHJ
         MixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mODlgLUFPu90LW9MI5iBS9EuUMXLA8l/luRyJvb/Vew=;
        b=TSIolfva7zP515Ccir6kiZGbDjxFmPSbSlFidyZeQk/qTiGdd1ZBWopXUXkzXZ14Cf
         GvNDpMm99wdUWQN+UwVH1Xf0qDcuz5ITBrsvcZ+U0V2UWsUUZmHnGaSLPVxZ3GbtLOvR
         rN0Si9awFH6W+R2FwhOqcMKbiv2HYVRrCgQ2fo0b/LKI0FEGmrIBsS1VIJGp9pNTPrjs
         iadnc9Ka9SY0D7Pl+EZYYaWe7dKC9CEGr+DwR32NKqAtA7SVP/wzOHLhIL7BRe9wEYiV
         m+oE8qa3YXQoSv+dSOjqC0IklTdqpmjTHSGRBrR/aX9CSPtrBr+/rqSRZCpqh8dgenaL
         nbpA==
X-Gm-Message-State: AOAM533XOFfN9qpXnkSOKiwx+HLFK9BfUcJCqSFba552z0JnkiJSKtua
        mxdYMPdyv60F+PSbOUv6n1nwkhXyRHU=
X-Google-Smtp-Source: ABdhPJyy5Y/yg8BBqJIVKkK7ysvwq5Nd/0gvK6oAPuOe+5PDz2Et7JAZXGQbypJNJhSvjtrNofzDtw==
X-Received: by 2002:a05:6602:134d:: with SMTP id i13mr12881426iov.164.1637173753279;
        Wed, 17 Nov 2021 10:29:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d1ee:6c8f:319:f5? ([2600:1700:e72:80a0:d1ee:6c8f:319:f5])
        by smtp.gmail.com with ESMTPSA id i1sm477571iov.10.2021.11.17.10.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 10:29:12 -0800 (PST)
Message-ID: <8a3d0d0e-cc82-b696-00f4-b71e6452e1bd@gmail.com>
Date:   Wed, 17 Nov 2021 13:29:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [Question] Unicode weirdness breaking tests on ZFS?
Content-Language: en-US
To:     Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <9393e572-0666-6485-df29-abad5e0d32a1@gmail.com>
 <20211117161226.xcat77ewhf5inaif@tb-raspi4>
 <20211117170613.kyoe6ov2m5wi2i56@tb-raspi4>
 <20211117173924.maporsti5cz2ixsu@tb-raspi4>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211117173924.maporsti5cz2ixsu@tb-raspi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2021 12:39 PM, Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= wrote:
> On Wed, Nov 17, 2021 at 06:06:13PM +0100, Torsten B??gershausen wrote:
>> On Wed, Nov 17, 2021 at 05:12:26PM +0100, Torsten B??gershausen wrote:
>>> On Wed, Nov 17, 2021 at 10:17:53AM -0500, Derrick Stolee wrote:
>>>> I recently had to pave my Linux machine, so I updated it to Ubuntu
>>>> 21.10 and had the choice to start using the ZFS filesystem. I thought,
>>>> "Why not?" but now I maybe see why.
>>>>
>>>> Running the Git test suite at the v2.34.0 tag on my machine results in
>>>> these failures:
>>>>
>>>> t0050-filesystem.sh                   (Wstat: 0 Tests: 11 Failed: 0)
>>>>   TODO passed:   9-10
>>>> t0021-conversion.sh                   (Wstat: 256 Tests: 41 Failed: 1)
>>>>   Failed test:  31
>>>>   Non-zero exit status: 1
>>>> t3910-mac-os-precompose.sh            (Wstat: 256 Tests: 25 Failed: 10)
>>>>   Failed tests:  1, 4, 6, 8, 11-16
>>>>   TODO passed:   23
>>>>   Non-zero exit status: 1
>>>>
>>>> These are all related to the UTF8_NFD_TO_NFC prereq.
>>>>
>>>> Zooming in on t0050, these tests are marked as "test_expect_failure" due
>>>> to an assignment of $test_unicode using the UTF8_NFD_TO_NFC prereq:
>>>>
>>>>
>>>> $test_unicode 'rename (silent unicode normalization)' '
>>>> 	git mv "$aumlcdiar" "$auml" &&
>>>> 	git commit -m rename
>>>> '
>>>>
>>>> $test_unicode 'merge (silent unicode normalization)' '
>>>> 	git reset --hard initial &&
>>>> 	git merge topic
>>>> '
>>>>
>>>>
>>>> The prereq creates two files using unicode characters that could
>>>> collapse to equivalent meanings:
>>>>
>>>>
>>>> test_lazy_prereq UTF8_NFD_TO_NFC '
>>>> 	# check whether FS converts nfd unicode to nfc
>>>> 	auml=$(printf "\303\244")
>>>> 	aumlcdiar=$(printf "\141\314\210")
>>>> 	>"$auml" &&
>>>> 	test -f "$aumlcdiar"
>>>> '
>>>>
>>>>
>>>> What I see in that first test, the 'git mv' does change the
>>>> index, but the filesystem thinks the files are the same. This
>>>> may mean that our 'git add "$aumlcdiar"' from an earlier test
>>>> is providing a non-equivalence in the index, and the 'git mv'
>>>> changes the index without causing any issues in the filesystem.
>>>>
>>>> It reminds me as if we used 'git mv README readme' on a case-
>>>> insensitive filesystem. Is this not a similar situation?
>>>>
>>>> What I'm trying to gather is that maybe this test is flawed?
>>>> Or maybe something broke (or never worked?) in how we use
>>>> 'git add' to not get the canonical unicode from the filesystem?
>>>>
>>>> The other tests all have similar interactions with 'git add'.
>>>> I'm hoping that these are just test bugs, and not actually a
>>>> functionality issue in Git. Yes, it is confusing that we can
>>>> change the unicode of a file in the index without the filesystem
>>>> understanding the difference, but that is very similar to how
>>>> case-insensitive filesystems work and I don't know what else we
>>>> would do here.
>>>>
>>>> These filesystem/unicode things are out of my expertise, so
>>>> hopefully someone else has a clearer idea of what is going on.
>>>> I'm happy to be a test bed, or even attempt producing patches
>>>> to fix the issue once we have that clarity.
>>>>
>>>> Thanks,
>>>> -Stolee
>>>
>>> Interesting.
>>> The tests have always been working on HFS+, then we got
>>> APFS (and needed a small fix) and now ZFS.
>>>
>>> I'll can have a look - just installing in a virtual machine.
>>
>> So, the virtual machine is up-and-running.
>>
>> I got 2 messages:
>>
>> ok 9 - rename (silent unicode normalization) # TODO known breakage vanished
>> ok 10 - merge (silent unicode normalization) # TODO known breakage vanished
>>
>> Do you get the same ?

Halfway, I see this:

ok 9 - rename (silent unicode normalization) # TODO known breakage vanished
not ok 10 - merge (silent unicode normalization) # TODO known breakage

> Now I am even more puzzled.
> running t0050 with -x gives this:
> 
>  Author: A U Thor <author@example.com>
>   1 file changed, 0 insertions(+), 0 deletions(-)
>    rename "a\314\210" => "\303\244" (100%)
>    ok 9 - rename (silent unicode normalization) # TODO known breakage vanished
> 
> 
> ----------------
> When I create a test Git, with one file in ä-decomposed,
> and rename into ä-precomposed, Git gives me:
> 
> tb@Ubuntu2021:~/ttt$ git mv "$aumlcdiar" "$auml"
> fatal: destination exists, source=ä, destination=ä
> 
> and in hex form:
> 
> tb@Ubuntu2021:~/ttt$ git mv "$aumlcdiar" "$auml" 2>&1 | xxd
> 00000000: 6661 7461 6c3a 2064 6573 7469 6e61 7469  fatal: destinati
> 00000010: 6f6e 2065 7869 7374 732c 2073 6f75 7263  on exists, sourc
> 00000020: 653d 61cc 882c 2064 6573 7469 6e61 7469  e=a.., destinati
> 00000030: 6f6e 3dc3 a40a                           on=...
 
Interesting: does this "fatal" error not change the exit code? Oddly,
I don't get that failure under -x:

checking known breakage of 0050.9 'rename (silent unicode normalization)': 
        git mv "$aumlcdiar" "$auml" &&
        git commit -m rename

+ git mv ä ä
+ git commit -m rename
[main 591d19c] rename
 Author: A U Thor <author@example.com>
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename "a\314\210" => "\303\244" (100%)
ok 9 - rename (silent unicode normalization) # TODO known breakage vanished

checking known breakage of 0050.10 'merge (silent unicode normalization)': 
        git reset --hard initial &&
        git merge topic

+ git reset --hard initial
error: unable to unlink old 'ä': No such file or directory
fatal: Could not reset index file to revision 'initial'.
error: last command exited with $?=128
not ok 10 - merge (silent unicode normalization) # TODO known breakage


But notice that -x does make test 10 go back to failing.

Thanks,
-Stolee
