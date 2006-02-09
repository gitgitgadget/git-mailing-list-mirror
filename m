From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 11:29:24 +0100
Message-ID: <43EB1984.3040602@op5.se>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>	<BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>	<43EB05B5.20307@op5.se> <7vk6c4etzy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 11:29:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F793J-0001JL-8y
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 11:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbWBIK30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 05:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWBIK30
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 05:29:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:9893 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1030513AbWBIK3Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 05:29:25 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 378C76BCBE
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 11:29:24 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vk6c4etzy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15802>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>sean wrote:
>>
>>>I've always followed it okay by just using "git branch -d pu" each
>>>time before pulling from you.   Your "next" branch does sound like
>>>an improvement though.
>>
>>I thought
>>
>>	Pull: +pu:pu
>>
>>was supposed to handle such things automatically. It has always pulled
>>properly for me anyways.
> 
> 
> Yes, fetching to look at is no problem, but what I wanted to
> solve is that you cannot easily _touch_ it.  The point of this
> is to make improving on top of what is still _not_ in master
> easier for the contributors.
> 
> If you want to improve upon what is in the current "pu", the
> natural thing for you to do would be:
> 
> 	$ git fetch git://git.kernel.org/pub/scm/git/git +pu:pu
> 	$ git checkout -b my-pu pu ;# initial
>         $ hack on it and git commit many times
>         $ git format-patch --stdout pu..my-pu |
>           git send-email --to junkio@cox.net --cc git@vger.kernel.org
> 

This is exactly what I do when I improve upon things in master, and 
according to numerous emails this is the recommended workflow.

> (Side note: I do not know git-send-email would work like the
> above, but if it did that might be handy.  Ryan?)
> 

With my (still un-published) git-send-patch you could do

	$ work, work, work
	$ git send-patch -s "Some subject for a prelude message" pu

and it would do the right thing.

I guess I'll have to get around to sending that thing in sooner or later.

> But sometimes you may take more time than how my "pu"
> progresses, and you would want to sync your work to my updated
> "pu".  A natural thing you would want to do is this:
> 
>         $ git pull git://git.kernel.org/pub/scm/git/git +pu:pu
> 

Do you mean
	$ git pull git://git.kernel.org/pub/scm/git/git +pu:my-pu

? Otherwise, I don't see how I can end up with merge-conflicts.

> Unfortunately, this would _not_ work very well, because by the
> time you pull from my "pu" again, it would have rewound and
> rebased.  You would end up seeing unnecessary merge conflicts.
> 
> Another possibility would be:
> 
>         $ git fetch git://git.kernel.org/pub/scm/git/git +pu:pu
>         $ git rebase pu
> 

Using my own topic-branch, this is what I always do. Conflicts that 
occur that way are always in my patches, so they would have to be 
reworked anyway. The new rerere tool should help if I dally too long.

Perhaps I'm just weird, but I never touch published branches.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
