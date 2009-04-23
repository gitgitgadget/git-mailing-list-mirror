From: Jesper Dangaard Brouer <hawk@diku.dk>
Subject: Re: htb parallelism on multi-core platforms
Date: Thu, 23 Apr 2009 21:47:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0904232136040.13796@ask.diku.dk>
References: <20090423184319.GB2756@ami.dom.local> <Pine.LNX.4.64.0904232103390.13488@ask.diku.dk>
 <20090423191455.GC2756@ami.dom.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Radu Rendec <radu.rendec@ines.ro>,
	Denys Fedoryschenko <denys@visp.net.lb>,
	netdev <netdev@vger.kernel.org>, git@vger.kernel.org
To: Jarek Poplawski <jarkao2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4ub-0002sX-Km
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768AbZDWTrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 15:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754835AbZDWTrM
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:47:12 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:48257 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbZDWTrK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 15:47:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 6A2E119BCA2;
	Thu, 23 Apr 2009 21:47:09 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 29328-18; Thu, 23 Apr 2009 21:47:05 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id A6EB419BC93;
	Thu, 23 Apr 2009 21:47:05 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7CCD56DFD13; Thu, 23 Apr 2009 21:46:21 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3075)
	id 8C0EE2CE5A1; Thu, 23 Apr 2009 21:47:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by ask.diku.dk (Postfix) with ESMTP id 89C722CE2DD;
	Thu, 23 Apr 2009 21:47:05 +0200 (CEST)
In-Reply-To: <20090423191455.GC2756@ami.dom.local>
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117375>

On Thu, 23 Apr 2009, Jarek Poplawski wrote:

> On Thu, Apr 23, 2009 at 09:06:59PM +0200, Jesper Dangaard Brouer wrote:
>> On Thu, 23 Apr 2009, Jarek Poplawski wrote:
>>
>>> Radu Rendec wrote, On 04/23/2009 02:31 PM:
>>>
>>>> On Wed, 2009-04-22 at 23:29 +0200, Jesper Dangaard Brouer wrote:
>>> ...
>>>>> The HTB classify hash has a scalability issue in kernels below 2.6.26.
>>>>> Patrick McHardy fixes that up in 2.6.26.  What kernel version are you
>>>>> using?
>>>>
>>>> I'm using 2.6.26, so I guess the fix is already there :(
>>>
>>> If Jesper meant the change of hash I can see it in 2.6.27 yet.
>>
>> I'm referring to:
>>
>>  commit f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2
>>  Author: Patrick McHardy <kaber@trash.net>
>>  Date:   Sat Jul 5 23:22:35 2008 -0700
>>
>>     net-sched: sch_htb: use dynamic class hash helpers
>>
>> Is there any easy git way to figure out which release this commit got
>> into?
>
> I guess git-describe, but I prefer clicking at the "raw" (X-Git-Tag):
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2

I think I prefer the command line edition "git-describe".  But it seems 
that the two approaches gives a different results.
(Cc'ing the git mailing list as they might know the reason)

  git-describe f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2
  returns "v2.6.26-rc8-1107-gf4c1f3e"

  While you URL returns: "X-Git-Tag: v2.6.27-rc1~964^2~219"

I also did a:
"git log v2.6.26..v2.6.27 | grep f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2"
commit f4c1f3e0c59be0e6566d9c00b1d8b204ffb861a2

To Radu: The change I talked about is in 2.6.27, so you should try that 
kernel on you system.

Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
MSc. Master of Computer Science
Dept. of Computer Science, University of Copenhagen
Author of http://www.adsl-optimizer.dk
-------------------------------------------------------------------
