Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61835202D2
	for <e@80x24.org>; Sun,  5 Mar 2017 22:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752410AbdCEWQd (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 17:16:33 -0500
Received: from avasout01.plus.net ([84.93.230.227]:46071 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbdCEWQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2017 17:16:32 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id sNGU1u00622aPyA01NGVss; Sun, 05 Mar 2017 22:16:30 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=NEAV23lmAAAA:8 a=4p0Hgal-Ckn9Mbp9WKEA:9
 a=pILNOxqGKmIA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=Bn2pgwyD2vrAyMmN8A2t:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
To:     Lars Schneider <larsxschneider@gmail.com>
References: <c76a133a57514a332828099d342c9763fd946bfa.1488309430.git.johannes.schindelin@gmx.de>
 <20170302105157.59791-1-larsxschneider@gmail.com>
 <alpine.DEB.2.20.1703021210170.3767@virtualbox>
 <4a27f62d-5576-df9d-257f-60ff327547e6@ramsayjones.plus.com>
 <125BAC7C-0FCF-4E0E-9757-2BFACD1910C5@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, gitster@pobox.com
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <1caa38bc-8423-dded-f01d-95ff3e75b92a@ramsayjones.plus.com>
Date:   Sun, 5 Mar 2017 22:16:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <125BAC7C-0FCF-4E0E-9757-2BFACD1910C5@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/03/17 17:38, Lars Schneider wrote:
>> On 02 Mar 2017, at 16:17, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
>> On 02/03/17 11:24, Johannes Schindelin wrote:
>>> On Thu, 2 Mar 2017, Lars Schneider wrote:
>>>
>> [snip]
>>>> One thing that still bugs me: In the Linux32 environment prove adds the
>>>> CPU times to every test run: ( 0.02 usr  0.00 sys +  0.00 cusr  0.00
>>>> csys ...  Has anyone an idea why that happens and how we can disable it?
>>>
>>> I have no idea.
>>
>> I have no idea either, but it is not unique to this 32bit Linux, but
>> rather the version of prove. For example, I am seeing this on Linux
>> Mint 18.1 (64bit _and_ 32bit), whereas Linux Mint 17.x did not do
>> this. (They used different Ubuntu LTS releases).
>>
>> [Mint 18.1 'prove --version' says: TAP::Harness v3.35 and Perl v5.22.1]
> 
> I think I found it. It was introduced in TAP::Harness v3.34:
> https://github.com/Perl-Toolchain-Gang/Test-Harness/commit/66cbf6355928b4828db517a99f1099b7fed35e90
> 
> ... and it is enabled with the "--timer" switch.

Yep, that looks like it.

When I updated to Mint 18, this broke a perl script of mine, so I had
a quick look to see what I could do to suppress it. The man page seemed
to imply that you could replace the output formatter, but that didn't
take me too far (search CPAN for TAP::Parser::Formatter: ;-) ). I suppose
you could replace Tap::Formatter::Base, or some such, but I didn't need
to go that far - I simply changed a couple of regex-es to ignore the
excess output! :-P

Do you really need to suppress that timing information or, like me, can
you simply ignore it?

ATB,
Ramsay Jones


