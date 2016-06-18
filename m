Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B081FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 01:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbcFRBVN (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 21:21:13 -0400
Received: from avasout04.plus.net ([212.159.14.19]:44156 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcFRBVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 21:21:12 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout04 with smtp
	id 81M91t0045VX2mk011MBsm; Sat, 18 Jun 2016 02:21:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=K//fZHiI c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=sMS1rzW9B_-N5Ai6EAIA:9 a=QEXdDO2ut3YA:10
X-AUTH:	ramsayjones@:2500
Subject: Re: [PATCH] archive-tar: add UL type suffix to unsigned long constant
To:	Jeff King <peff@peff.net>
References: <57646646.9060407@ramsayjones.plus.com>
 <20160617234041.GC26564@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
From:	Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <5764A204.3010503@ramsayjones.plus.com>
Date:	Sat, 18 Jun 2016 02:21:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <20160617234041.GC26564@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 18/06/16 00:40, Jeff King wrote:
> On Fri, Jun 17, 2016 at 10:06:14PM +0100, Ramsay Jones wrote:
> 
>> If you need to re-roll your 'jk/big-and-old-archive-tar' branch, could
>> you please squash this into the relevant patch (commit 8035a1e3,
>> "archive-tar: write extended headers for far-future mtime", 16-06-2016).
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
>>
>>  archive-tar.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/archive-tar.c b/archive-tar.c
>> index 749722f..c7b85fd 100644
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -187,7 +187,7 @@ static inline unsigned long ustar_size(uintmax_t size)
>>  
>>  static inline unsigned long ustar_mtime(time_t mtime)
>>  {
>> -	if (mtime < 077777777777)
>> +	if (mtime < 077777777777UL)
> 
> Whoops. I even got it right in the similar line above. :-/
> 
> This did make me wonder how the whole thing fares on a system where
> "unsigned long" is 32-bit (AIUI, Git for Windows is such a system).
> 
> The sizes passed around (here and all through git) are "unsigned long",
> so I don't think we're making anything _worse_.

Heh, I had exactly the same thought! ;-)

I have a TODO item that reads: check odb code for object size limitations
imposed by using 'unsigned long'. This is a known problem on Git for Windows.

[Not for cygwin, however, since long is 64bit (just like linux). The win32api
headers on cygwin have been written in terms of a __LONG32 #define to allow
them to be used on LLP64 and LP64 systems.]

However, since I don't have GFW installed, I couldn't actually test it, so ...

ATB,
Ramsay Jones

