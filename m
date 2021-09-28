Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FBC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C4D60FED
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 06:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238869AbhI1GQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 02:16:56 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:14925 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238835AbhI1GQz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 02:16:55 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4HJTkm3xXwz5tlD;
        Tue, 28 Sep 2021 08:15:12 +0200 (CEST)
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
 <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
 <87czou1dmp.fsf@evledraar.gmail.com>
 <YVJZrOYucywgoi+v@coredump.intra.peff.net>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5bda4e3e-0951-c28e-320d-23cdadba5bc6@kdbg.org>
Date:   Tue, 28 Sep 2021 08:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YVJZrOYucywgoi+v@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.09.21 um 01:54 schrieb Jeff King:
> On Mon, Sep 27, 2021 at 01:02:35PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>>>>  static inline void cb_init(struct cb_tree *t)
>>>>  {
>>>> -	t->root = NULL;
>>>> +	struct cb_tree blank = CBTREE_INIT;
>>>
>>> This could be
>>>
>>> 	static const struct cb_tree blank = CBTREE_INIT;
>>
>> *nod*...
>> [...]
>> ...but to both this & the above my reply in the side-thread at
>> https://lore.kernel.org/git/87h7e61duk.fsf@evledraar.gmail.com/
>> applies. I.e. this is just following a pattern I got from Jeff King &
>> used in bd4232fac33 (Merge branch 'ab/struct-init', 2021-07-16).
> 
> I'm not sure how a compiler would react to the "static const" thing. I
> tested the compiler output for the "auto" struct case you've written
> here, and at least gcc and clang are smart enough to just initialize the
> pointed-to struct directly, with no extra copy.

Good! Then a deviation from established patterns is not warranted.

-- Hannes
