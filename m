Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3E7C47088
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 18:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiK3SlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiK3SlL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 13:41:11 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2F898949
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 10:41:04 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id DF95ACA1246;
        Wed, 30 Nov 2022 13:41:03 -0500 (EST)
Received: from [10.0.0.3] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id A51A3CC8415;
        Wed, 30 Nov 2022 13:41:03 -0500 (EST)
Message-ID: <c9ac37d3-99a9-a358-4d49-fea6a5d92efc@jeffhostetler.com>
Date:   Wed, 30 Nov 2022 13:41:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH] trace2 tests: guard pthread test with "PTHREAD"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        "Randall S . Becker" <randall.becker@nexbridge.ca>
References: <patch-1.1-f7f21c94a6c-20221124T214813Z-avarab@gmail.com>
 <xmqqilj3edtr.fsf@gitster.g> <221125.867czjo3ud.gmgdl@evledraar.gmail.com>
 <6c725ed6-4d74-c260-98fb-dc965b4647ee@jeffhostetler.com>
 <221128.86wn7fj72k.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <221128.86wn7fj72k.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/28/22 12:50 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 28 2022, Jeff Hostetler wrote:
> 
>> On 11/25/22 3:05 AM, Ævar Arnfjörð Bjarmason wrote:
>> [...]
>>> That was my thought as well, but these tests are specifically testing
>>> how it interacts with threading. The counter mechanism works in general
>>> without threading.
>>> The test descriptions don't help, and should really say that they're
>>> to
>>> do with threading in particular, but I wanted to keep this as small as
>>> possible for rc[12] and the final, so I didn't fix that while-at-it.
>>
>> There is large comment block above `have_timer_event()` and
>> `have_counter_event()` in t0211 that explained the purpose of the
>> test1 and test2 tests for each.  Would it help if that text were moved
>> down before each of the individual tests rather than where it is now?
> 
> You did ask :)

Yes, I did.  :-) :-)


> I think that better than a comment is to have the test description
> itself reflect the nature & purpose of the test.
> 
> Now the two are:
> 
> 	test_expect_success 'global counter test/test1' '
> 	test_expect_success PTHREAD 'global counter test/test2' '
> 
> So at least the PTHREAD shows that it's something to do with threading,
> but if it fails with that prereq passed you'll need to consult the
> source to see what "test2" is supposed to do. Better would be to just
> skip the comment & work "single threaded" and "multi-threaded" etc. into
> the test name itself.
> 
> Ditto symbol names "ut_200counter" and "ut_201counter", again, a comment
> somewhere in t/helper/test-trace2.c notes that they're single- and
> multi-threaded, respectively, but why not skip that and make the symbol
> names self-descriptive?

Good points. I'll keep this in mind for the future. I don't
think I want to send a fix for them now, but maybe the next
time I'm in the area...


Thanks again,
Jeff
