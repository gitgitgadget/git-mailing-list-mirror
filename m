From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t0060: loosen overly strict expectations
Date: Fri, 15 Jan 2016 07:54:47 +0100
Message-ID: <569897B7.4040302@kdbg.org>
References: <eccf149d9557fd9afb591d9411ecb0b3460c9eb0.1452754049.git.johannes.schindelin@gmx.de>
 <xmqqziw8jcbr.fsf@gitster.mtv.corp.google.com>
 <5697E550.9020102@ramsayjones.plus.com> <56981DC2.6070706@kdbg.org>
 <5698415E.7070907@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:54:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyHf-0000RC-6v
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 07:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbcAOGyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 01:54:51 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:51602 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbcAOGyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 01:54:50 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3phYCq6ZMSz5tlN;
	Fri, 15 Jan 2016 07:54:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 50E9B5398;
	Fri, 15 Jan 2016 07:54:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <5698415E.7070907@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284139>

Am 15.01.2016 um 01:46 schrieb Ramsay Jones:
>
>
> On 14/01/16 22:14, Johannes Sixt wrote:
>> Am 14.01.2016 um 19:13 schrieb Ramsay Jones:
>>> Correct me if I'm wrong (quite possible), but
>>> _each_ drive has a current working directory associated with
>>> it in win32, so it's a bit difficult to use drive designators
>>> with a relative path (eg. C:usr/lib).
>>
>> As far as it matters for Git, such a path is still an absolute path,
>> because it is not anchored at $(pwd).
>
> I have been using cygwin on windows since beta-18 (about 1995), in order
> to avoid most of the horrors of the windows command line, so I'm a little
> rusty. ;-)
>
> You know windows _much_ better than me, so could you please educate me
> on this point. I tried this (on windows 8.1):

>      C:\cygwin64\home\ramsay\junk>dir C:sub-1
>      dir C:sub-1
>       Volume in drive C is TI31255200A
>       Volume Serial Number is 0024-4AC0
>
>       Directory of C:\cygwin64\home\ramsay\junk\sub-1
>[...]
>
> ... which seems to contradict what you say above.

This example is not super-illuminating. You must cd to a directory on a 
different drive, say D:\foo, then call dir C:sub-1. The result will be 
the directory listing from somewhere deep inside the C: hierarchy, not 
from inside D:\foo.

>
> What am I missing?

Git assumes, given a path in $path that is declared to be relative, that 
"$path" and "$(pwd)/$path" denote the same thing.

But that does not work when path="C:sub-1". Yeah, "C:sub-1" is relative 
to something, but *in general* that something is not $(pwd).

-- Hannes
