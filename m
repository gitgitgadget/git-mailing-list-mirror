From: Andreas Ericsson <ae@op5.se>
Subject: Re: several quick questions
Date: Wed, 15 Feb 2006 00:00:57 +0100
Message-ID: <43F26129.4040804@op5.se>
References: <43F20532.5000609@iaglans.de>	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>	<87fymlvgzv.wl%cworth@cworth.org>	<200602142230.11442.Josef.Weidendorfer@gmx.de> <7v7j7xr54u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 00:01:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F99Au-0008Gx-Cr
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 00:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWBNXBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWBNXA7
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 18:00:59 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:8067 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1422863AbWBNXA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 18:00:59 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D10016BCFF; Wed, 15 Feb 2006 00:00:57 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j7xr54u.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16190>

Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> 
>>Why not allow something like
>>
>>	git-checkout master~5
>>
>>which implicitly does create a read-only branch "seek-point"?
> 
> 
> Now what does "git-checkout branch" mean?  Does it switch to the
> branch, or does it force tip of seek-point to be the tip of
> branch and switch to seek-point branch?  More interestingly,
> what does "git-checkout seek-point" mean? 
> 
> If we _were_ to do something like cg-seek where an implicit
> throw-away branch is used, you at least need a way to
> disambiguate these cases, and "git seek" originally suggested is
> far clearer than what you said above.
> 

Nah. What's the point of having another protected name. Just allow

	$ git checkout -b discard HEAD~15

and we're good to go.

> Having said that, I am not convinced in either way, though.
> 
> 
>>A branch could be marked readonly by above command with
>>
>>	chmod a-w .git/refs/heads/seek
> 
> 
> I do not think that would work.  Have you tried it?
> 

It wouldn't on cygwin, for one. I'm against having things work 
differently on different platforms. If nothing else it usually worsens 
the bitrot that always happens to documentation.

> 
>>And git-commit should refuse to commit on a readonly ref, telling
>>the user to create a writable branch before with "git-branch new".
> 
> 
> Now, read-only ref does not interest me, but "do not commit on
> top of this yourself, only fast-forward from somewhere else is
> allowed" may be useful, for the reason why you mentioned
> "origin".
> 

Do my suggestion and you wouldn't have to worry about read-only 
branches, and although merging any changes from it might be more trouble 
than its worth, it might be possible to cherry-pick the commit rather 
than reverting and re-applying it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
