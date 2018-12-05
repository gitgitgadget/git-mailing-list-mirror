Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDB2A211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeLEVbX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 16:31:23 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:15694 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLEVbX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 16:31:23 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 439BkK6NN5z5tlF;
        Wed,  5 Dec 2018 22:31:21 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6CDFD20A8;
        Wed,  5 Dec 2018 22:31:21 +0100 (CET)
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
To:     =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
 <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
 <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
 <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
 <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
 <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
 <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
 <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
 <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
 <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
 <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
 <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com>
 <3572b619-0603-d16d-392c-4cc8e0bc4614@kdbg.org>
 <de3bd8e1-cdd7-5fcf-0912-a216cc8cb3e9@googlemail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <337ed78c-afd5-24ab-709b-ff74ee6b90ac@kdbg.org>
Date:   Wed, 5 Dec 2018 22:31:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <de3bd8e1-cdd7-5fcf-0912-a216cc8cb3e9@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.12.18 um 20:29 schrieb Frank Schäfer:
> 
> Am 02.12.18 um 22:22 schrieb Johannes Sixt:
>> Am 02.12.18 um 20:31 schrieb Frank Schäfer:
>>> With other words:
>>> "If CR comes immediately before a LF, do the following with *all* lines:
>>> <RESET> after the CR if eol=lf but do not <RESET> after the CR if
>>> eol=crlf."
>>
>> Why? It is the pager's duty to highlight CR, IMO. If it doesn't, but
>> the user wants to see them, then they are using the wrong pager or the
>> wrong pager settings.
> AFAIU Junios explanation it's not the pagers fault.

Then Junio and I are in disagreement. IMO, Git does not have to be more 
clever than the pager when it comes to presentation of text.

>> As far as I am concerned, I do not have any of my files marked as
>> eol=crlf, but I do *not* want to see ^M in the pager. I.e., having git
>> insert <RESET> between CR and LF would do the wrong thing for me.
>>
> But doing the same thing in added lines is doing the right thing for you ?

Yes, I think so. As long as I'm not telling Git that my files are CRLF 
when they actual are, then the CR before LF is a whitespace error. 
Nevertheless, I do *NOT* want Git to outwit my pager by inserting 
<RESET> between CR and LF all the time so that it is forced to treat the 
lone CR like a control character that is to be made visible.

> Or are you suggesting to fix the behavior of added lines instead ?
> In any case, inconsistent behavior is not what we want.

I'm suggesting that users who knowingly store CRLF files in the 
database, but do not want to see ^M in added lines have to use 
whitespace=cr-at-eol and that's all. I do not see inconsistency.

-- Hannes
