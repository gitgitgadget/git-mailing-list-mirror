Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38D61F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbeGaVsY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:48:24 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33783 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732373AbeGaVsY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:48:24 -0400
Received: from [192.168.129.4] (x004.home.local [192.168.129.4])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6VK6COO10223738;
        Tue, 31 Jul 2018 20:06:12 GMT
Subject: Re: Is detecting endianness at compile-time unworkable?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
 <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com>
 <287cdba8-19c1-2fe8-4aff-d0385b38e92c@felt.demon.nl>
 <87sh3ztrcb.fsf@evledraar.gmail.com>
From:   Michael <aixtools@felt.demon.nl>
Message-ID: <325d1a6c-276a-9ffa-f9c5-72cbdecb6175@felt.demon.nl>
Date:   Tue, 31 Jul 2018 22:06:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87sh3ztrcb.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/07/2018 16:25, Ævar Arnfjörð Bjarmason wrote:
> ...the real trick is using these macros outside of GCC / glibc and on
> older GCC versions. See the github link above, you basically end up with
> a whitelist of how it looks on different systems / compilers. Sometimes
> both are defined, sometimes only both etc.
>
> It can be done, but as that code shows it's somewhat complex macro soup
> to get right.

FYI - the gcc I was using is 4.7.4.

And, the reason I suggest the test for both not being defined is so that 
'make' stops and whoever is running make just sets one or the other. Let 
them 'file a bug' When they come with a compiler that does not work - 
and find out what could be used.

For example, _AIX is the same as _BIG_ENDIAN. In the meantime, the code 
to test is simple.

Either one of _BIG_ENDIAN or _LITTLE_ENDIAN is provided by the compiler 
or the builder supplies one of the two using CFLAGS. I assume there is 
also a "undefine" flag, maybe -U - so hopefully a -U and a -D 
combination could be used for cross-compiling.

re: my mailer blocking things - it would only be for this list, as other 
lists come through with no extra work from me. At least I am not aware 
of anything special I could do.

