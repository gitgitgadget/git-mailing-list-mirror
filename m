From: Roger Garvin <yoyodyn@gmail.com>
Subject: Re: Suggested Workflow Question
Date: Fri, 17 Apr 2009 21:11:24 +0000 (UTC)
Message-ID: <loom.20090417T205632-412@post.gmane.org>
References: <loom.20090317T175010-470@post.gmane.org> <46a038f90903172141o7b272c17v2c485bb66b529fe8@mail.gmail.com> <loom.20090318T125717-946@post.gmane.org> <200903181452.53497.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 23:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuvN4-0004KC-GA
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 23:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbZDQVLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZDQVLj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 17:11:39 -0400
Received: from main.gmane.org ([80.91.229.2]:55371 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbZDQVLi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 17:11:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LuvLU-0002qJ-Oi
	for git@vger.kernel.org; Fri, 17 Apr 2009 21:11:36 +0000
Received: from 65.14.229.26 ([65.14.229.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 21:11:36 +0000
Received: from yoyodyn by 65.14.229.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 21:11:36 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.14.229.26 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.8) Gecko/2009032609 Firefox/3.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116789>

Robin Rosenberg <robin.rosenberg.lists <at> dewire.com> writes:

> Don't forget the option of mailing bundles (man git-bundle). Those will give
the effect of push/fetch via
> e-mail. I.e. the exact same commit SHA's get replicated, That may be relevant
for the branches that
> contain your released/official test code.

After trying this out for a little while I and projecting some into the future I
think I am going to have a problem that I am not sure if it really is a problem,
or if Git will "take care of it".  Let me give you a simplistic commit history
to illustrate my point.  In its most basic form you have three branches; dev,
test, prod.  In a perfect world all the development happens on dev, then updates
are pushed to test, and finally after tests pass are pushed out to prod.  So at
a point in time you have something like this:

(P)<--(T)<--(D)

Since I would think (and maybe this is my problem) that ideally Prod is a direct
descendant of Test and Test is a direct descendant of Dev.  However we don't
live in a perfect world, so changes get made on Test that aren't in production
yet, and also in an emergency directly on the Prod branch.  Eventually those
changes get migrated back either through a merge or a rebase (rebase would be
bad since there would be multiple developers using these repos.)  Obviously
making a change to Prod and then merging back to Test, and then merging back to
Dev creates a lot of extra commits.

 (P)<---(T)<----(D)
  ^      ^       ^
   \      \      \
  (P')<--(T')<--(D')

Things get even more complicated when the customer decides to only push certain
features into Prod from test, it looks like cherry pick would be ideal for this
and make it much easier for us.

Is trying to maintain a direct ancestral relationship between Prod, Test, and
Dev worth it?  Am I crazy for even trying to?  I am still a pretty green git
user so it might not be worth it.  But it does seem to me that merges might be
easier and faster if the common ancestor between two commits is closer rather
than farther away in the commit history.

Thanks again for your help.
