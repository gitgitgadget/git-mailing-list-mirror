From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 17:49:10 +0000
Message-ID: <56437F96.2070209@ramsayjones.plus.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
 <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
 <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:49:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwZWJ-0007m2-Ia
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 18:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbbKKRtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 12:49:15 -0500
Received: from avasout01.plus.net ([84.93.230.227]:55445 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKKRtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 12:49:14 -0500
Received: from [10.0.2.15] ([146.199.93.105])
	by avasout01 with smtp
	id gHpC1r0062GQ2gJ01HpDfx; Wed, 11 Nov 2015 17:49:13 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MbeRwMLf c=1 sm=1 tr=0
 a=SWxm+s7FAPvPP0IAAWI2og==:117 a=SWxm+s7FAPvPP0IAAWI2og==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8 a=J2d4_G6QDc1fK1R13N8A:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281174>



On 11/11/15 02:00, Stefan Beller wrote:
> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>> 02-11-2015) changed the type of some variables from long to off_t.
>>> The 32-bit build, which enables the large filesystem interface
>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>> integer, whereas long is a 32-bit integer. This results in a couple
>>> of printf format warnings.
>>>
>>> In order to suppress the warnings, change the format specifier to use
>>> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
>>> the http_opt_request_remainder() function, which uses the same
>>> solution).
>>
>> I just ran across the problem when building 'next' on my Mac and was
>> about to investigate, so am happy to find that the work has already
>> been done. Thanks.
>>
>> My machine is 64-bit, though, so perhaps it's misleading to
>> characterize this as a fix for 32-bit builds. In particular, off_t is
>> 'long long' on this machine, so it complains about the "long" format
>> specifier.
> 
> +Lars
> 
> I wonder if 32 bit compilation can be part of travis.
> 

Did this warning show up on the OS X build?

ATB,
Ramsay Jones
