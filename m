X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Tue, 19 Dec 2006 10:24:29 +0000
Message-ID: <4587BDDD.5030508@shadowen.org>
References: <86y7p57y05.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>	<86r6uw9azn.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>	<86hcvs984c.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>	<8664c896xv.fsf@blue.stonehenge.com>	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>	<20061219051108.GA29405@thunk.org>	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 10:57:58 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Theodore Tso <tytso@mit.edu>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1988 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 05:57:43 EST
User-Agent: Icedove 1.5.0.8 (X11/20061116)
In-Reply-To: <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34821>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcfK-0006qj-Pi for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932782AbWLSK5o (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWLSK5o
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:57:44 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:4246 "EHLO
 hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932782AbWLSK5n (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:57:43 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gwc8F-0002T9-9d; Tue, 19 Dec 2006 10:23:35 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Hi,
>>
>> in a very unscientific test, without your patch local cloning of the 
>> LilyPond repo takes 1m33s (user), and with your patch (pread() instead of 
>> mmap()) it takes 1m13s (user). The real times are somewhat bogus, but 
>> still in favour of pread(), but only by 8 seconds instead of 20.
>>
>> This is on Linux 2.4.32.
> 
> Interesting.  Anybody have numbers from 2.6?

On my debian etch system:

Linux version 2.6.17-2-686 (Debian 2.6.17-9) (waldi@debian.org) (gcc 
version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 SMP Wed Sep 13 
16:34:10 UTC 2006

I did one run first (not included) to get things nice and warm, then 
three runs of each.  Overall the same as reported elsewhere marginally 
better with pread().  I guess you could say a 20-30% improvement in 
system time which isn't to be sniffed at.

-apw

mmap():

real    1m5.187s
user    1m0.844s
sys     0m2.900s

real    1m6.748s
user    1m0.868s
sys     0m3.064s

real    1m5.604s
user    1m0.760s
sys     0m3.124s


pread():

real    1m4.676s
user    1m0.168s
sys     0m2.340s

real    1m3.563s
user    0m59.796s
sys     0m2.248s

real    1m4.066s
user    1m0.156s
sys     0m2.304s
