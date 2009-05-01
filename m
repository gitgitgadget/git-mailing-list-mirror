From: david@lang.hm
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
 dscms and a "whole product" approach)
Date: Fri, 1 May 2009 12:13:50 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0905011211080.15782@asgard>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <20090430142244.GA23550@coredump.intra.peff.net> <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
 <20090501190854.GA13770@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 01 21:15:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzyCd-00063b-SJ
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 21:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbZEATPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 15:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755693AbZEATPJ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 15:15:09 -0400
Received: from mail.lang.hm ([64.81.33.126]:37221 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754940AbZEATPH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 15:15:07 -0400
Received: from asgard.local (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n41JDoeQ006545;
	Fri, 1 May 2009 12:13:50 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <20090501190854.GA13770@coredump.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118090>

On Fri, 1 May 2009, Jeff King wrote:

> On Fri, May 01, 2009 at 02:43:49PM -0400, Linus Torvalds wrote:
>
>>> Like all generalizations, this is only mostly true. Fast network servers
>>> with big caches can outperform disks for some loads.
>> [...]
>> In contrast, a workstation with local filesystems and enough memory to
>> cache it well will just be a lot nicer.
>> [...]
>>> I have never used perforce, but I get the impression that it is more
>>> optimized for such a situation.
>>
>> I doubt it. I suspect git will outperform pretty much anything else in
>> that kind of situation too.
>
> Thanks for the analysis; what you said makes sense to me. However, there
> is at least one case of somebody complaining that git doesn't scale as
> well as perforce for their load:
>
>  http://gandolf.homelinux.org/blog/index.php?id=50
>
> Part of his issue is with git-p4 sucking, which it probably does. But
> part of it sounds like he has a gigantic workload (the description of
> which sounds silly to me, but I respect the fact that he is probably
> describing standard practice among some companies), and that workload is
> just a little too gigantic for the workstations to handle. I.e., by
> throwing resources at the central server they can avoid throwing as many
> at each workstation.
>
> But there are so few details it's hard to say whether he's doing
> something else wrong or suboptimally. He does mention Windows, which
> IIRC has horrific stat performance.

the key thing for his problem is the support for large binary objects. 
there was discussion here a few weeks ago about ways to handle such things 
without trying to pull them into packs. I suspect that solving those sorts 
of issues would go a long way towards closing the gap on this workload.

there may be issues in doing a clone for repositories that large, I don't 
remember exactly what happens when you have something larger than 4G to 
send in a clone.

David Lang
