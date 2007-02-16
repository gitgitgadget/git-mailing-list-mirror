From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 03:00:04 +0100
Organization: At home
Message-ID: <er333i$787$1@sea.gmane.org>
References: <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com> <17876.53654.426022.454712@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 03:00:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHsP7-00061L-IR
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 03:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423028AbXBPCAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 21:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423026AbXBPCAU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 21:00:20 -0500
Received: from main.gmane.org ([80.91.229.2]:36251 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423025AbXBPCAS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 21:00:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HHsOJ-0005VT-Le
	for git@vger.kernel.org; Fri, 16 Feb 2007 03:00:04 +0100
Received: from host-81-190-26-5.torun.mm.pl ([81.190.26.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 03:00:03 +0100
Received: from jnareb by host-81-190-26-5.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 03:00:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-5.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39876>

Bill Lear wrote:

> On Thursday, February 15, 2007 at 15:21:38 (-0600) Bill Lear writes:
>>On Thursday, February 15, 2007 at 16:00:23 (-0500) Nicolas Pitre writes:
>>>On Thu, 15 Feb 2007, Bill Lear wrote:
>>>
>>>> We are about to switch to git 1.5 from git 1.4.4.1.  I cannot remember
>>>> if someone posted about this, but what is the danger of working on a
>>>> tracking branch --- there are abundant cautions about doing this, but
>>>> I can't recall and can't find the reason this is bad.
>>>
>>>A tracking branch is supposed to be a local mirror of what is available 
>>>remotely.  If you commit local changes to it then you break that model.
>>
>>Ok, so I break the model, what is the harm in that?  Can I no longer
>>pull from or push to the remote branch?  Do I corrupt something
>>locally?  Does something else break?  I'm trying to formulate an
>>explanation to our users why the 1.5 way is superior and I can't just
>>say "if you do that you break the model".

You cannot fetch or push to the remote branch if you made some commits
on the tracking branch ("broke the model") and remote branch has other
commits. You can force the issue, but then either remote (for push)
or local (for fetch) commits would be lost.

Sidenote: for some branches you have to skip fast-forward check, because
they have rewritten history (e.g. pu branch in git.git).
 
> BTW, my ignorant assumption is that for merging to take place, git
> requires two branches, so 'git pull' will fetch into the tracking
> branch and then merge onto your ... uh ... whatever the name of the
> working version of your tracking branch is.

But one of those branches can be temporary "branch" FETCH_HEAD (if you
use "git pull <URL>" syntax, and do not use tracking (remote) branches).

> BTW, again, why does git clone not have an option to just create all
> of the "working versions" (better name needed) of tracking branches?

Because usually you work with one branch with tracking (remote) + local
branch workflow; I think with multiple branches you usually use temporary
feature branches...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
