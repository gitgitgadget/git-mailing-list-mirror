From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] cvstrack: work on imported cvs and other git branches
Date: Sun, 1 Jul 2007 18:43:05 +0200
Message-ID: <4ED65855-7B87-43C6-B5F1-162FC9A1CBF0@zib.de>
References: <11832957963860-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0707011533370.4438@racer.site> <4880FDC4-BAD5-49B4-871B-98259D691449@zib.de> <Pine.LNX.4.64.0707011710480.4438@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 18:42:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I52Uz-0008Pi-4Y
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 18:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbXGAQmH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 12:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbXGAQmG
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 12:42:06 -0400
Received: from mailer.zib.de ([130.73.108.11]:58123 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753169AbXGAQmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 12:42:05 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l61Gg2TB023157;
	Sun, 1 Jul 2007 18:42:02 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1bbde.pool.einsundeins.de [77.177.187.222])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l61Gg1MM020418
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 1 Jul 2007 18:42:01 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0707011710480.4438@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51309>


On Jul 1, 2007, at 6:11 PM, Johannes Schindelin wrote:

> On Sun, 1 Jul 2007, Steffen Prohaska wrote:
>
>> On Jul 1, 2007, at 4:35 PM, Johannes Schindelin wrote:
>>
>>> On Sun, 1 Jul 2007, Steffen Prohaska wrote:
>>>
>>>> The idea is to import a cvs repository using git cvsimport; build a
>>>> perfect history in git by cherry picking commits that are only in
>>>> cvs but not in git; and export only summaries back to cvs. Cvs
>>>> imports are organized on a separate git branch. git is used for
>>>> merging. The differences can be sent back to cvs as a squashed
>>>> commit together with a shortlog. Sent git commits are noted in the
>>>> cvs commit message and will be ignored in subsequent cvs imports.
>>>
>>> Wouldn't it be more intuitive to add a --squash option to
>>> git-cvsexportcommit?
>>
>> Maybe.
>>
>> But how to handle commits that are sent to cvs and come back
>> through git-cvsimport?
>
> Probably I do not really understand what you are doing... If the  
> commits
> come from cvs, then they are already there, no? So where do you  
> want to
> commit the squashed commits?

I do some work in git and want to send this work to cvs. I squash all
_git_ commits into a single _cvs_ commit. In the next incremental
import from cvs the squashed commit comes back to git (at least after
cvsps time fuzz passed). If I just merged from the cvsimport branch
I'd build a history in git that contains the changes twice; once in
a sane way from the original git history and a second time because it
was sent to cvs and came back through git-cvsimport.

What I try to achieve is to build a history in git that has
- every commit that was initially committed to cvs only once.
- every commit that was initially committed to git only once.
- provides a stable git branch that can be cloned by others.
In addition I need a way to send changes from git to cvs such that cvs
has all changes that are available in git.

Some examples of what I may want to do in git:
- just work as if cvs wasn't there and create topic branches. Only
   after work is finished the change should be sent to cvs. But changes
   from cvs should be continuously integrated.
- track cvs topic branches for a longer period of time and merge
   them several times using git and after a final merge, send the  
changes
   back to cvs.

The background is, I plan to convince approximately 60 developers
to migrate from CVS to git and I'm searching for a way to start the
transition with some beta testers, while maintaining full cvs
infrastructure in place for the remaining users.

Currently, I think that I can handle this with the scripts I sent in
the patch.

	Steffen
