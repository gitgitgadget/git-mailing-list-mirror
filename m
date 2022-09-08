Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC6C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 17:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiIHRaf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiIHRaI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 13:30:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED2252B3
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 10:29:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b144so13843473pfb.7
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yvykFb5tsuLWkB6mRc2IJPfdS6m2bdCStCYN8TDPvvM=;
        b=PHx8B2mgoeSawOvXKkfSDq0Wyh+Hw5aYQbIKAgsI2f7VeUJARJvyese+rH15VAoylU
         E/Eu1iJfqfJBxkjvdeIDIKknYDrcor8uVXMOgiLFvDeYHiD9f82+WLbfj3qAk6sl2QuI
         trP6ZzIAqNKiZoxI8UCAUXL3fOE93CyliNzGm5AvO/F6yB3pHCXej+EzeVlZwMBFkI4G
         gqdGXqWoHpTkPUBBdEeRkfJmYF4Zo9zIqSYCGkpnc+o3krQVQh9bV6HJbiKXEy/JUjZb
         sB8ocWRFXHL3E/cmHzFovKJ547qIpgCLl76Fh38ekrMvTmkiTGt+U6aVOpihDIgtoti8
         oDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yvykFb5tsuLWkB6mRc2IJPfdS6m2bdCStCYN8TDPvvM=;
        b=xXJQVj7sGaHfMfDehreNQg7N9o1HgIXro0r6AmEtzbdJoExuyAD4zD1v1an1D7Dmsg
         vcCFeUdYMwJhU+QHk1ABjc00GV7Bw0CaTi35bl+E0HP4G2U2aartTbWtZ2xQyB6q9Y7i
         7WuIKuvN3HXxJkKVVWk05wfmMa6qUiGCf0BG6L3oBEH7u+nI1WBPhTp/G2hnnEFTbsSx
         HYGqAkKjnEKlBpg9W/jqZSgZJneVVstRgpKoxiIicOo3Am7t0D4h0Jze/v+cKfpNXDrM
         2pqHZRAZovUsUaBEpzeSoBH9jbn9I8khWhpHjR5RGaVj/ewauEqAAxL+hclssMxaylYU
         4VVg==
X-Gm-Message-State: ACgBeo2bIYVsLuVXCl72ID9IOnJ0bNQ6yD1q3GRJRpgnpTcbkxuwLg0B
        B70skZD1Vs1jGF+UeQvorAEV
X-Google-Smtp-Source: AA6agR4f2Reywl1tWJm1dvPl304gnKPai5UT3PbfsJWsCe1t4NwKW4HmZp6ZUouQLwEPk2soWnUH7w==
X-Received: by 2002:aa7:80d0:0:b0:52d:f9c6:bb14 with SMTP id a16-20020aa780d0000000b0052df9c6bb14mr10073075pfn.57.1662658177818;
        Thu, 08 Sep 2022 10:29:37 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id w4-20020aa79544000000b0053e156e9475sm5073811pfq.182.2022.09.08.10.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 10:29:37 -0700 (PDT)
Message-ID: <6bc8f50b-c869-11a7-b12e-dca8a2ce2a81@github.com>
Date:   Thu, 8 Sep 2022 10:29:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH v2 5/5] cmake: increase time-out for a long-running test
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <6aaa675301cc56081d07974a0eb8662700fe96f8.1661243464.git.gitgitgadget@gmail.com>
 <220908.86edwml3hm.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <220908.86edwml3hm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> As suggested in
>> https://github.com/git-for-windows/git/issues/3966#issuecomment-1221264238,
>> t7112 can run for well over one hour, which seems to be the default
>> maximum run time at least when running CTest-based tests in Visual
>> Studio.
>>
>> Let's increase the time-out as a stop gap to unblock developers wishing
>> to run Git's test suite in Visual Studio.
>>
>> Note: The actual run time is highly dependent on the circumstances. For
>> example, in Git's CI runs, the Windows-based tests typically take a bit
>> over 5 minutes to run. CI runs have the added benefit that Windows
>> Defender (the common anti-malware scanner on Windows) is turned off,
>> something many developers are not at liberty to do on their work
>> stations. When Defender is turned on, even on this developer's high-end
>> Ryzen system, t7112 takes over 15 minutes to run.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  contrib/buildsystems/CMakeLists.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
>> index 29d7e236ae1..b1306f95256 100644
>> --- a/contrib/buildsystems/CMakeLists.txt
>> +++ b/contrib/buildsystems/CMakeLists.txt
>> @@ -1088,4 +1088,8 @@ foreach(tsh ${test_scipts})
>>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>>  endforeach()
>>  
>> +# This test script takes an extremely long time and is known to time out even
>> +# on fast machines because it requires in excess of one hour to run
>> +set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
>> +
>>  endif()#BUILD_TESTING
> 
> I don't see per [1] that it would have any negative effect to just bump
> the timeout a lot more, and for all the tests.

I'm a bit confused as to how that link (which explains that the 'TIMEOUT'
property is used to determine when to kill a test process - more or less
standard behavior for timeouts in applications) shows that excessively long
timeouts on every test "[wouldn't] have any negative effect." 

In terms of the timeout length, the stated reason for adding the timeout in
the first place is:

>> Let's increase the time-out as a stop gap to unblock developers wishing
>> to run Git's test suite in Visual Studio.

I would consider ~1 hour a manageable (albeit frustrating) amount of time to
wait for a test, but not 10 hours (as you suggest later).

As for setting the timeout on all tests: that might be helpful, only because
(AFAICT from CMake's source code & documentation) the default timeout is "no
timeout." If setting a global default, though, I'd prefer a shorter timespan
(e.g. 1800s) so that a timeout properly indicates a failure condition ("this
test runs much longer than it should, so we may have introduced a
performance bug"). 

Practically, though, I don't feel too strongly about whether or not to set a
global default. If we wanted to add timeouts to more tests in the future,
I'd want a more extensible solution with carefully-selected timeouts. But if
it's just this one test running too long, special case-ing a timeout for it
with a comment explaining the reasoning seems appropriate to me. 

> 
> If we're running into 3600 seconds, then setting this to 4000 seconds
> seems to be a smal stopgap at best. That's just over a 10% increase, so
> if one person ran into it it 3600 someone with a slightly slower system
> should be running into the same still, or if we just add a few more
> tests to 7112 (or some other slow test).

I don't think this patch is suggesting that timeout failures are happening
at 3600s, rather that the peak observed execution time of the test is 3600s.
If that's the case, <peak execution time> + an 11% buffer is a reasonable
choice for the value.

> 
> So why not set this ta 3600*10 or whatever for *all* of the test scripts
> instead of playing whack-a-mole?
> 
> 1. https://cmake.org/cmake/help/latest/prop_test/TIMEOUT.html

