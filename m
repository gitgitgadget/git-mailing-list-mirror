Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A96C433F5
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 20:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiAKUVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:21:16 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:40426 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbiAKUVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 15:21:15 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4JYMXS1XF8z5tlD;
        Tue, 11 Jan 2022 21:21:12 +0100 (CET)
Message-ID: <e8e2c37d-39f1-0ae4-7894-07e85628a757@kdbg.org>
Date:   Tue, 11 Jan 2022 21:21:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/3] reftable tests: avoid "int" overflow, use "uint64_t"
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-3.3-93112305523-20220111T163908Z-avarab@gmail.com>
 <Yd3aZ5Q9Ph0H+Ijn@nand.local>
 <CAFQ2z_M0Fjjx8tAd_cXqk9K9q43hwienEy=UsLJi2aW8G3sEwA@mail.gmail.com>
 <Yd3dao5Qh5yl/cBs@nand.local> <45baffd7-c9f3-cc52-47b4-ea0fee0182a8@kdbg.org>
 <Yd3mCVLyxkVTNcS9@nand.local>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Yd3mCVLyxkVTNcS9@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.01.22 um 21:18 schrieb Taylor Blau:
> On Tue, Jan 11, 2022 at 09:08:46PM +0100, Johannes Sixt wrote:
>> Am 11.01.22 um 20:41 schrieb Taylor Blau:
>>> On Tue, Jan 11, 2022 at 08:31:47PM +0100, Han-Wen Nienhuys wrote:
>>>> On Tue, Jan 11, 2022 at 8:28 PM Taylor Blau <me@ttaylorr.com> wrote:
>>>>> In any case, you're only setting the lower half of `min` high. Maybe:
>>>>>
>>>>>     uint64_t min = ~0ul;
>>>>
>>>> yeah, that works.
>>>
>>> I'm pretty sure this is OK on 32-bit systems, too, but confirmation from
>>> somebody more confident than I in this area would be welcome :).
>>
>> It does not work on Windows: unsigned long is 32 bits wide. You have to
>> make it
>>
>>    uint64_t min = ~(uint64_t)0;
> 
> Perfect; this is exactly what I was looking for. Thanks!

Actually, on second thought, UINT64_MAX would be even better.

-- Hannes
