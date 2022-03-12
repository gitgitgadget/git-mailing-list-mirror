Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC4BC433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 08:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiCLIiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 03:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiCLIiG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 03:38:06 -0500
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC7010BBC3
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 00:36:59 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4KFx485kKxz5tlD;
        Sat, 12 Mar 2022 09:36:56 +0100 (CET)
Message-ID: <90d0b9b5-65d8-4d16-10b0-f10ae5e72942@kdbg.org>
Date:   Sat, 12 Mar 2022 09:36:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     jaydeepjd.8914@gmail.com
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220311072716.674808-1-jaydeepjd.8914@gmail.com>
 <16543315-8515-a4d7-d75b-e7fe9731a7cf@kdbg.org>
 <62e13889-315a-1a42-f37b-390702c0aa9d@gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <62e13889-315a-1a42-f37b-390702c0aa9d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.03.22 um 05:36 schrieb jaydeepjd.8914@gmail.com:
> On 3/12/22 1:37 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 11.03.22 um 08:27 schrieb Jaydeep P Das:
>> > diff --git a/userdiff.c b/userdiff.c
>> > index 8578cb0d12..c416c9b426 100644
>> > --- a/userdiff.c
>> > +++ b/userdiff.c
>> > @@ -168,6 +168,18 @@ PATTERNS("java",
>> >        "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>> >        "|[-+*/<>%&^|=!]="
>> >        "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
>> > +PATTERNS("kotlin",
>> > +     "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
>> > +     /* -- */
>> > +     "[a-zA-Z_][a-zA-Z0-9_]*"
>> > +     /* hexadecimal and binary numbers */
>> > +     "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
>> > +     /* integers and floats */
>> > +     "|[0-9][0-9_]*([.][0-9_]*)([Ee][-+]?[0-9]+)?[fFlLuU]*"
>>
>> This line matches a non-empty digit sequence of any length, and I
>> thought the longest match would win. Why is that not the case here?
>> Frankly, I'm scratching my head over it. Any ideas?
> 
> Yes. The capture group ([.][0-9_]*) should occur once or zero times. So
> this `([.][0-9_]*)?` will fix it.

Oh, good catch! That's the missing piece.

-- Hannes
