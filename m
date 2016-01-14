From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Thu, 14 Jan 2016 18:13:36 +0000
Message-ID: <5697E550.9020102@ramsayjones.plus.com>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
 <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:13:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJmP9-0000rV-3l
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 19:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726AbcANSNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 13:13:47 -0500
Received: from avasout07.plus.net ([84.93.230.235]:35862 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628AbcANSNq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 13:13:46 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 5uDj1s0084mu3xa01uDkvw; Thu, 14 Jan 2016 18:13:44 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=EBOSESyhAAAA:8
 a=N659UExz7-8A:10 a=uZvujYp8AAAA:8 a=uT-ainIaydT-rWoZ4UAA:9 a=pILNOxqGKmIA:10
 a=Nlrvvu092-0A:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284073>



On 14/01/16 17:33, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> Also...
> 
>> -#if defined(__MINGW32__)
>> -	/* the following is clearly wrong ... */
>> -	{ "C:",              "."      },
>> -#endif
>> -
>> -#if defined(_MSC_VER)
>> -	{ "C:",              "C:."    },
>> -#endif
>> -
>> -#endif
>> +	{ "C:",              "C:.", "." },
>>  #endif
> 
> "C:" is still allowed to go to "."; is it still "clearly wrong",
> or do we have a reason why we think it is not wrong at all?
> 
> I think the comment was written by Ramsay and also suspect that you
> did not specifically agree or disagree with that particular
> decision, so I'd understand if you do not have a strong opinion
> either way, but I'd like to hear from Ramsay.  Perhaps earlier we
> thought it was clearly wrong but we no longer do?
> 

Yes, that comment was mine. The result is "clearly wrong" if you
follow the POSIX rules [1], but that may not translate exactly to
a dos like path. ;-)

I think the question is: does it make a difference if you call
chdir() on the result? Which brings up something which I have
been ignoring. Correct me if I'm wrong (quite possible), but
_each_ drive has a current working directory associated with
it in win32, so it's a bit difficult to use drive designators
with a relative path (eg. C:usr/lib).

Note: The test data in the test-libgen.c file was using Linux
as the 'benchmark' for the POSIX paths and IIRC MinGW-32 for
the dos paths. (Note that I said 'benchmark' _not_ 'correct'). :-P

ATB,
Ramsay Jones

[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/dirname.html
