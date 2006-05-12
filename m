From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Tracking branch history
Date: Fri, 12 May 2006 19:18:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605121838490.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 13 01:17:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FegtJ-0002eN-3k
	for gcvg-git@gmane.org; Sat, 13 May 2006 01:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWELXRk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 19:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWELXRk
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 19:17:40 -0400
Received: from iabervon.org ([66.92.72.58]:19728 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751126AbWELXRk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 May 2006 19:17:40 -0400
Received: (qmail 543 invoked by uid 1000); 12 May 2006 19:18:37 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2006 19:18:37 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19920>

One feature that might make git more intuitive to people is if we were to 
additionally track the history of what commit was the head of each branch 
over time. This is only vaguely related to the history of the content, but 
it's well-defined and sometimes significant.

E.g., if you know that two weeks ago, what you had worked, but it doesn't 
work now, you can use git-bisect to figure out what happened, but first 
you have to figure out what commit it was that you were using two weeks 
ago. Two weeks ago, we had that information, but we didn't keep it.

It would probably also be useful for showing changelogs in a 
locally-useful order. If you merge in a tree that's been in separate 
development for a long time, the commits in that tree will be interleaved 
in commit date with the commits you did locally. You tend to want to 
attribute all of the changes that happened in the merge to the time of the 
merge, but that commit object isn't going to tell you anything useful, 
because it may have been done by the other tree (and you fast-forwarded to 
the merge). In fact, you may want to attribute the changes to the 
fast-forward, which can't recorded in the content history, because nothing 
happened to the content. On the other hand, if we were to also record the 
branch history, we could give output which shows changes in the order they 
reached the local tree (then ordered by the commit tree), just by having 
it do:

<time now>

git log <head-as-of-before>..<head-of-of-now>

<time before>

git log <head-as-of-before-that>..<head-as-of-before>

<time before-that>

and so forth.

	-Daniel
*This .sig left intentionally blank*
