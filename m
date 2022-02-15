Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F5C433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 07:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiBOHGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiBOHGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 02:06:00 -0500
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE29471C94
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:05:50 -0800 (PST)
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4JyXDY2CK3z5tyn
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 08:05:49 +0100 (CET)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4JyXDT6pTPz5tlB;
        Tue, 15 Feb 2022 08:05:44 +0100 (CET)
Message-ID: <9ab7761a-ff63-f809-47af-033825e5779e@kdbg.org>
Date:   Tue, 15 Feb 2022 08:05:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Improvements to tests and docs for .gitattributes
 eol
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
 <xmqqilth2u28.fsf@gitster.g> <20220214204631.mquj645jt5qajwku@tb-raspi4>
 <xmqq8rud0ytj.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq8rud0ytj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.02.22 um 01:15 schrieb Junio C Hamano:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
>>> ---- >8 -----
>>> From: brian m. carlson <sandals@crustytoothpaste.net>
>>> Subject: doc: clarify interaction between 'eol' and text=auto
>>>
>>> The `eol` takes effect on text files only when the index has the
>>> contents in LF line endings.  Paths with contents in CRLF line
>>> endings in the index may become dirty unless text=auto.
>>
>> That is a nice, precise and short summary here in the commit message
>> as well as the patch further down.
> 
> Thanks.  Then let's queue it for 'next' and merge it down.
> 
>>>
>>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>> ---
>>>  Documentation/gitattributes.txt | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git c/Documentation/gitattributes.txt w/Documentation/gitattributes.txt
>>> index 60984a4682..a71dad2674 100644
>>> --- c/Documentation/gitattributes.txt
>>> +++ w/Documentation/gitattributes.txt
>>> @@ -161,11 +161,12 @@ unspecified.
>>>
>>>  This attribute sets a specific line-ending style to be used in the
>>>  working directory.  This attribute has effect only if the `text`
>>> -attribute is set or unspecified, or if it is set to `auto` and the file
>>> -is detected as text.  Note that setting this attribute on paths which
>>> -are in the index with CRLF line endings may make the paths to be
>>> -considered dirty. Adding the path to the index again will normalize the
>>> -line endings in the index.
>>> +attribute is set or unspecified, or if it is set to `auto`, the file is
>>> +detected as text, and it is stored with LF endings in the index.  Note
>>> +that setting this attribute on paths which are in the index with CRLF
>>> +line endings may make the paths to be considered dirty unless
>>> +`text=auto` is set. Adding the path to the index again will normalize
>>> +the line endings in the index.

Sorry, I don't find this description clear at all due to the many 'or's
and 'and's and no indication which parts belong together. The original
text was clear (but, of course, not helpful if it was wrong).

I suggest to rewrite the paragraph into format with bullet points:

   ... only if one of the following is true:

  - is set and foo or bar
  - is unspecified and either
      - this
      - or that
  - is set to auto but not...

or something along the lines. I can't propose actual text because I have
no clue what the truth is.

-- Hannes
