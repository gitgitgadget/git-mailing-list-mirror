From: "Denis Bueno" <denbuen@sandia.gov>
Subject: Re: Git clone error
Date: Wed, 01 Aug 2007 14:22:56 -0600
Message-ID: <C2D647C0.2B60%denbuen@sandia.gov>
References: <Pine.LNX.4.64.0708011802020.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 22:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGKj0-0002If-L3
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 22:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXHAUXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 16:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbXHAUXO
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 16:23:14 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:3116 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbXHAUXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 16:23:13 -0400
Received: from [134.253.164.148] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 01 Aug 2007 14:22:56 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from ES21SNLNT.srn.sandia.gov ([134.253.164.104]) by
 ES24SNLNT.srn.sandia.gov with Microsoft SMTPSVC(6.0.3790.3959); Wed, 1
 Aug 2007 14:22:56 -0600
Received: from 134.253.202.158 ([134.253.202.158]) by
 ES21SNLNT.srn.sandia.gov ([134.253.164.116]) with Microsoft Exchange
 Server HTTP-DAV ; Wed, 1 Aug 2007 20:22:56 +0000
User-Agent: Microsoft-Entourage/11.3.3.061214
Thread-Topic: Git clone error
Thread-Index: AcfUeb7E/Wxt/EBsEdy7fwAX8tQlcQ==
In-Reply-To: <Pine.LNX.4.64.0708011802020.14781@racer.site>
X-OriginalArrivalTime: 01 Aug 2007 20:22:56.0695 (UTC)
 FILETIME=[BF2E1C70:01C7D479]
X-TMWD-Spam-Summary: TS=20070801202257; SEV=2.2.2; DFV=B2007080114;
 IFV=2.0.4,4.0-9; AIF=B2007080114; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230332E34364230454241302E303038302C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007080114_5.02.0125_4.0-9
X-WSS-ID: 6AAE342A1V82532297-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54474>

On 08/01/2007 11:17, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
wrote:
> But this is what I would do if I had the problem: I would try to create
> a state which is as close to the corrupt revision as possible,
> use a graft to replace the initial commit with that revision, and
> rewrite the branch. I'd probably start by doing something like this:
> 
> $ git symbolic-ref HEAD refs/heads/recreate-first && rm .git/index
> $ git ls-tree -r --name-only <initial-commit> |
> grep -v "^condor/condor-uninstall.sh$" |
> xargs git checkout <initial-commit>
> $ git checkout <second-commit> condor/condor-uninstall.sh
> [possibly some minor hacking on the latter file to make it work]
> $ git commit -c <initial-commit>

Wow.  `commit' and `checkout' are the only two commands that I have ever
heard of in that sequence.

How difficult would it be to create a new git repo which is exactly the same
minus the initial condor-uninstall.sh commit?  That is, just to pretend the
initial import of condor-uninstall.sh never existed, and use the second
commit of the old repo the first commit of the new, and preserve the rest of
the history of the entire repo?  Or, to remove both condor-uninstall.sh
commits from the history -- deleting that history altogether -- and add it
back as a completely new file?

If I get enough courage, I'll attempt to understand exactly what it is
you're doing in the commands above and try it out on (a copy of) the repo.
My willingness to part with the current history and just reinitialise the
repo with its current contents increases with time, though.

The real problem is that I'm sure I have no idea exactly what the first
version of the file looked like, and how it differed from the next one.

                      Denis
--
"If we wish to count lines of code, we should not regard them as lines
produced but as lines spent." -- Edsger Dijkstra
